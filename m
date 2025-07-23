Return-Path: <linux-kernel+bounces-742212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A57CB0EEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2727C1C28025
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4245C288524;
	Wed, 23 Jul 2025 09:50:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7523D2BC;
	Wed, 23 Jul 2025 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264239; cv=none; b=rUY6WFt5FnwF8WrChI+sQ+C8zlipsqRJQmTNWiNUoBdni+AcHRS3gXY/IsnbneHJ5B/ENViTKYtK83Q5yVA74vL4xcLwjscz/7alypyf/kA5Aa4TrCmI9EDFUS1REefs+8gM3KdynYEkopB825ctOzofVii+m0yZpPUn5I6KXXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264239; c=relaxed/simple;
	bh=Dlm1RZ4Nf3Oywxsd2CAe4cTLNI1sNPwEtub5FQW3F1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXBGBBxZmRddib8vPh6hF7sNHsu4R0A6fQiDgk5+CXXdqfE82ie4/AwpnwU2qGlA6e1ZExDDHcCMi7dQ+THJQfZV7yPTz5Qv52EayVlRVaLNFSwQKsBfadU89Y/z4vyyEaCEjTQDe/Gie51o3BgO7fmh80ebiZojB+02FbJEpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13554C4CEE7;
	Wed, 23 Jul 2025 09:50:35 +0000 (UTC)
Date: Wed, 23 Jul 2025 10:50:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] arm64: uaccess: Add additional userspace GCS
 accessors
Message-ID: <aICwaQZxK5Spjj8G@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-5-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719043740.4548-5-jeremy.linton@arm.com>

On Fri, Jul 18, 2025 at 11:37:36PM -0500, Jeremy Linton wrote:
> +/*
> + * Unlike put_user_gcs() above, the use of copy_from_user() may provide
> + * an opening for non GCS pages to be used to source data. Therefore this
> + * should only be used in contexts where that is acceptable.
> + */

Even in user space, the GCS pages can be read with normal loads, so
already usable as a data source if one wants to (not that it's of much
use). So not sure the comment here is needed.

> +static inline u64 load_user_gcs(unsigned long __user *addr, int *err)

Nitpick: name this get_user_gcs() for symmetry with put_user_gcs().

> +{
> +	unsigned long ret;
> +	u64 load = 0;
> +
> +	gcsb_dsync();

Might be worth a comment here, see the one in gcs_restore_signal().

> +	ret = copy_from_user(&load, addr, sizeof(load));
> +	if (ret != 0)
> +		*err = ret;
> +	return load;
> +}

Otherwise the patch looks fine:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

