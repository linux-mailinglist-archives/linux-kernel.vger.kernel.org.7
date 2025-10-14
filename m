Return-Path: <linux-kernel+bounces-853457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F2BDBB71
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF633E31AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4D3231827;
	Tue, 14 Oct 2025 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yy/hQuzJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A849134BD;
	Tue, 14 Oct 2025 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482640; cv=none; b=oMf66KOPUOZFZDWWp3dRhpS4lZkJkRWKWHMTXnUQMSMswcxCp+aBPmsV7vKs3TZuq18OGlpvHATKd6Iq/aKXs6jSSt1g+++6cEmjLWuhWMM4thkG6G7U1ROEEhZVjgy4ZJB1ZnEwTXpFQFAbmyI4PoTJVYaGZfTXc4p2G5cTb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482640; c=relaxed/simple;
	bh=dI5SogE0uAAFm67QBt0/OqgiWz3UwWUKI0k+HCcv4pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7cWv5gfUAskaHjEqMBeJnhrmvmlIy1Bx/xVCp48/9+xPPQ/iW0eZ5m2TW9N9fHZ5HtgjtqaTXDkzKiNg0QuI6mTrcTgQ3dJVwA3k4J5KQzSeGko3/X5A2ic7wTWeKB4S535ggZfZcmQv2OB1z41nLGaC8Vp5eygK05uV6GGXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yy/hQuzJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2wDbJlxvYX7Q+igEzrmpKJX7HyVeyPvtDFgca/eF0N4=; b=yy/hQuzJzL36WNehKDOFWc1hAQ
	Ebx6zwFMSUWAeh6kHLswwaMPFLCT5RpgxsBuIKe4UI/XVaFcQ8u8RKYBsBWL3nTGNYIPBPQ1sREXN
	x8Md404Q/CFtnY9usTpG+TM/YSfP8LC18y9Ce+2dVyV1vveiPODN7+IYHv6+H0b5f50GaPvv3/Vp/
	aHcOEXTLQKS0t9qhskSr6gzih15LTH+4yYr1v0/Uak5inLz42yGrSkyPk7qdVmJ6daNCXP6TiXXAW
	p2hf+vHcO3kc5xm4Jolx6VPo6LtvIuEYGoxnK9I4oL141jltTCt4O3cpl65mQ8jP9MHIRm4L57g9+
	CBh80Ihg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8nxE-0000000Hale-1X38;
	Tue, 14 Oct 2025 22:57:16 +0000
Message-ID: <3b7f31b9-443a-465c-90ac-5b539852d799@infradead.org>
Date: Tue, 14 Oct 2025 15:57:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: admin-guide: update tiny script for number of taint
 flags
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <20251014031538.764059-1-rdunlap@infradead.org>
 <20251014121403.GX3901471@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251014121403.GX3901471@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 5:14 AM, Jason Gunthorpe wrote:
> On Mon, Oct 13, 2025 at 08:15:38PM -0700, Randy Dunlap wrote:
>> Account for 2 new taint flags being added by increasing the number of
>> bits handled by the tiny show-tainted-flags example script.
> 
> Maybe add a comment near the array about this :\

Something like this?


--- linux-next-20251014.orig/kernel/panic.c
+++ linux-next-20251014/kernel/panic.c
@@ -638,6 +638,12 @@ EXPORT_SYMBOL(panic);
 /*
  * TAINT_FORCED_RMMOD could be a per-module flag but the module
  * is being removed anyway.
+ *
+ * NOTE: if you modify the taint_flags or TAINT_FLAGS_COUNT,
+ * please also modify tools/debugging/kernel-chktaint and
+ * Documentation/admin-guide/tainted-kernels.rst, including its
+ * small shell script that prints the TAINT_FLAGS_COUNT bits of
+ * /proc/sys/kernel/tainted.
  */
 const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G', true),



-- 
~Randy


