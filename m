Return-Path: <linux-kernel+bounces-873438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A0C13EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98F344FFF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68F73016F8;
	Tue, 28 Oct 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L1DVlw5E"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACC2D836A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645151; cv=none; b=XQrGYkC/QDklsqnp7hGMJP8Ia6tcFs+sHJV+Zt2t6beN3gijHPzNJHvhU5WlHax+YvImUmPDuy15YpXPhAK4Z2m5WoTiSjBWEsR59r9b4D6QDcbZq7e2x2i+vQrsmxgMeCNZSPfRm7PdCp7gDZZFW8PGBuhk2x6ZASX8bEpgDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645151; c=relaxed/simple;
	bh=CTCRbXjK1xSjiiNC3T8U4qCRVUyZeqG1PI/yXheWtMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=aU1bnox9iAAa2vqrO74xiL+8/yxOajd0+0rqUyh8ZlQZevLGLhr+D3ftVkKQ3XSOo7Q/xrCUI195M0WT1Pq7vUW/Ed3ES4IRrv2qenC5XfBc97X9pV8lU9tnAwVnCtmQoiSR/24KYBr7+x+MrndUFL0ByJlRFy2BPBEbjs4KuSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L1DVlw5E; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251028095220euoutp01d23e49e9e6368ae467aba76181dee092~ynuwPvlZu2742727427euoutp016
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:52:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251028095220euoutp01d23e49e9e6368ae467aba76181dee092~ynuwPvlZu2742727427euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761645141;
	bh=5DRRsPiWfCTULqTag5q8vJYQP8UI8UuEIkFTOc7lJ8A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=L1DVlw5EPZn0MwvD7thqUUvjfJHTkiCm+rLl+4Xd7IyCofp9wJOf85YkvNjYs495A
	 dm3wuuCTuBdmu9NzwUqTPUP+ixumNsjvN8X8+rmuiwzVI6tRmCsJ50pM/OYYcKYR7M
	 ycRq5862aio7vH71UsRfar/cnTlj+PuQ7cUOf9Sw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251028095220eucas1p2f8973d1aa76637cf907eff2dce7fa9a4~ynuwCr6O00826208262eucas1p2c;
	Tue, 28 Oct 2025 09:52:20 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251028095220eusmtip275cfb7e2c20ddad1f8de11636653766d~ynuv0BYCh1470214702eusmtip2j;
	Tue, 28 Oct 2025 09:52:20 +0000 (GMT)
Message-ID: <5748e9f5-b560-467b-a50d-5590b9acbaf1@samsung.com>
Date: Tue, 28 Oct 2025 10:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the pwm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
	Mailing List <linux-next@vger.kernel.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20251028133924.30a058af@canb.auug.org.au>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251028095220eucas1p2f8973d1aa76637cf907eff2dce7fa9a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028023933eucas1p1ea7f8b51a5da190b593635cea7e72982
X-EPHeader: CA
X-CMS-RootMailID: 20251028023933eucas1p1ea7f8b51a5da190b593635cea7e72982
References: <CGME20251028023933eucas1p1ea7f8b51a5da190b593635cea7e72982@eucas1p1.samsung.com>
	<20251028133924.30a058af@canb.auug.org.au>



On 10/28/25 03:39, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pwm tree, today's linux-next build (x86_64 allmodconfig)
> produced these warnings:
> 
> WARNING: modpost: module pwm_th1520 uses symbol pwmchip_release from namespace PWM, but does not import it.
> WARNING: modpost: module pwm_th1520 uses symbol __pwmchip_add from namespace PWM, but does not import it.
> WARNING: modpost: module pwm_th1520 uses symbol pwmchip_alloc from namespace PWM, but does not import it.
> WARNING: modpost: module pwm_th1520 uses symbol pwmchip_remove from namespace PWM, but does not import it.

Hi, Thank you for the report. Interestingly this seems to be the first
Rust driver that needs to write 'import_ns' in the .modpost section. For
C drivers the macro MODULE_IMPORT_NS("PWM") was simply included with
pwm.h. I think the module! macro needs to be extended to support
import_ns in rust/macros/module.rs. I think I know how to do it code
wise, will post a patch.

> 
> Presumably introduced by commit
> 
>   fb3957af9ec6 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

