Return-Path: <linux-kernel+bounces-800815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B62B43C67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8065B5818D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AB2FF671;
	Thu,  4 Sep 2025 13:02:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E42FF669
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990972; cv=none; b=dz+XFV5bUUyctZpld8PhpNMBK5+piZuqM/gWuA+hlJdnF7wCTNKiL/s9hduvlOIIt3CoABas5nhqhZlRjUbFpXCeG6PyE/SzxHxVH7MG4n5jWtCRumRpYG8NAMPzwjrW17zn/lm6KvyJ1AKcEIBgqApX9a2uclCkH3oG84OfoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990972; c=relaxed/simple;
	bh=WQPKUXhmti6atme4IK/JBqY0adO7qnSvih5EdwBuHGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4cdH5yfQrOz7ou8KWTJS6JHhlboRnnoyfwRig2R5ISuqsKyXjs1MLkXyBcp8gkCTh0LXNaeI7TMeZgH3TyZ+aLTnqrCp3Ck47HpPcD3YSLu7VcjujKqYtK5quloCC1OHCo5gdkG8yu3BP4vlieX6mci5ddbukZZ/qY4XrfpTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6F602F2E;
	Thu,  4 Sep 2025 06:02:42 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9954A3F6A8;
	Thu,  4 Sep 2025 06:02:50 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:02:48 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] coresight: perf: Fix pointer check with IS_ERR_OR_NULL()
Message-ID: <20250904130248.GO745921@e132581.arm.com>
References: <20250904-cs_etm_auxsetup_fix_error_handling-v1-1-ecc5edf282a5@arm.com>
 <5f24d286-629c-404f-8e0f-aa01e27bcb80@linaro.org>
 <20cec516-1589-4fc5-ac07-06029f2dc143@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20cec516-1589-4fc5-ac07-06029f2dc143@linaro.org>

On Thu, Sep 04, 2025 at 01:11:37PM +0100, James Clark wrote:

[...]

> > I think the bug is in TRBE. It's the only one that returns an error
> > pointer, but only for -ENOMEM which would normally be NULL for alloc
> > type functions anyway.

Thought again, you are right — it is better to fix this in TRBE, since
we don't really get any benefit from an artificial "-ENOMEM".

Will respin a new one.

Thanks,
Leo

