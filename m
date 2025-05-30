Return-Path: <linux-kernel+bounces-668797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC141AC972B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 23:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DBF18813F3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 21:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C033283C9E;
	Fri, 30 May 2025 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pcjmdGSU"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D92210184;
	Fri, 30 May 2025 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640772; cv=none; b=lBr9qiSXx8Qe88neNvI1lrPrR4fF2sNWWhqQ1Oe/LUmseROJBijZhnE9dil5Tb9tReak0f+bjhPfJu9nN38/pZLdB7CIY14xtKw8qye2wMIUEjzYjYXxI+wlESb8OGkfLvN/uIQKMCiUj+UrQat5p9ihE+o6nC1f1Y9uZVK2qTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640772; c=relaxed/simple;
	bh=2+EOkSUSicdbY+PP355CJ7CJZaTni13bOZ4Wbxgrtxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6SFYSRYZEWYOyMVuN//25razjJhaKBgQpEUroRQe04X48oFPGFQETe4IIZ96ZEFcYFcndL+6P/yAo7R6+QeKEe23GbIK5UP5AsxtA73/oNMmL5E2tqJaSq3yDuHWp0qiXQNBjZW2jZoEEhtLSHt3xXdwUZt5pbD80ab3NF5gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pcjmdGSU; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 30 May 2025 14:32:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748640757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=si3SF9j/QxcYzVc63Fo3LxDqAOFGuYFt7AY4pyNbzVM=;
	b=pcjmdGSUBNikrhQQdswudi4WL4piT3kKmievAcCgqON0yv4eo8GFaDENd/gmgCoKtpaVpN
	WzAyvh8W84zwzl4tTvYflOLaJ556bWoEr3Bm41omgPYplmLHdXdQHW7W0sknPJtejTnbEx
	WukuBvJXUV2MXAcV/mvlVuSo8sy0Gpo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, seanjc@google.com,
	darren@os.amperecomputing.com
Subject: Re: [RFC PATCH v2 0/9] KVM: Enable Nested Virt selftests
Message-ID: <aDoj6DjbISGQFwbd@linux.dev>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

Hi Ganapat,

On Mon, May 12, 2025 at 03:52:42AM -0700, Ganapatrao Kulkarni wrote:
> This patch series makes the selftest work with NV enabled. The guest code
> is run in vEL2 instead of EL1. We add a command line option to enable
> testing of NV. The NV tests are disabled by default.
> 
> Modified around 12 selftests in this series.

Thanks for sharing this, we sorely need testing for NV.

I haven't looked at these patches thoroughly but I have some overall
feedback. What I'd like to see is that we force *all* KVM selftests
to run in VHE EL2 without an opt-in/opt-out. The user had to boot their
kernel with kvm-arm.mode=nested, so imposing NV testing on them feels
reasonable.

Thanks,
Oliver

