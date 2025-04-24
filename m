Return-Path: <linux-kernel+bounces-618037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA53AA9A964
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 12:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAE217A0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4B221FAF;
	Thu, 24 Apr 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="bibwfnel"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF90221FA0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489118; cv=none; b=Mgjwmp3n3/3KycNS+sCBgCwYENXeCj9YWVVUx7ACNICy7v86FmVKe4e2xld8ZYyS2pNprtuCCDTweicgT/vsu1MoZQuEbzRL/jdZtu86mKqz+zAB4sSSoULmnuzZNVcOy0i2Lmji/Z7stBrSAqlQ3TpjqZ2PmEJN5Py5sMaP+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489118; c=relaxed/simple;
	bh=aTwCG5zIVsBJxb8IZJPcVqIrui6+49eu8TMKM+dV630=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=BvUkNfF8GVSmFSrRjH33QtzcVLZDrEWbq08WTeg+ccR4c6BMo2d1hTYp0hkhjc0smbyh5iTLk+vDD5gc3UCNj/oB/ZyXToRIWGwWpgVtav8iNoMDm78MifcUEOEdOGQEMfkL9idHINn0UlK01r8S2h0QkhcYhp+geXRsU/ZvCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=bibwfnel; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6A3Eb004531;
	Thu, 24 Apr 2025 11:04:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=h
	t+5MJoy98mefo5C6EhU8q+TpMHAYhDjxH3joLjpVHE=; b=bibwfnelT/m25Frf4
	LnxZIB8sCCOy2javZuwKXMBL0tSsu9ggTmWRxwN9fiWuxFvyHMIOz2s9DB4YjZ/y
	5Oz8N1IuN92qUYjcBfNLFFi6nvOvxgz2tR1n5p7hNWAVgrWGFXY69synP8wcy7dL
	6NQDHRQb48mibRJSySvAM+Iathi/qa5q09sXpVJCOFuhH8TVY5uOlEJkMSPO8w1J
	umOmfmkH0W4WR92oTapiU6MZimWXwfZptft/wh9Vf5oLIM2KGZGpeDwV6P/virGG
	x4cvSZwclUKxGZ8fOvzNEOtDbuQ96Mz1b8ankLiRSpzGUPTVGZFbeH23v2NeNkQC
	Gi5sQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 46423t30bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Apr 2025 11:04:37 +0100 (BST)
Received: from Matts-MacBook-Pro.local (172.25.2.134) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Apr 2025 11:04:35 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Arnd Bergmann <arnd@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Andrzej
 Hajda" <andrzej.hajda@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        "Alex
 Deucher" <alexander.deucher@amd.com>,
        Alessio Belle
	<alessio.belle@imgtec.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20250409122314.2848028-1-arnd@kernel.org>
References: <20250409122131.2766719-1-arnd@kernel.org>
 <20250409122314.2848028-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH 01/10] drm/imagination: avoid
 unused-const-variable warning
Message-ID: <174548907548.56131.3060253413773321018.b4-ty@imgtec.com>
Date: Thu, 24 Apr 2025 11:04:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=L60dQ/T8 c=1 sm=1 tr=0 ts=680a0cb5 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=OXfeAiaCWNgA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=r_1tXGB3AAAA:8 a=0awzr-uiiHjTTRS7KEMA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: SPdZCKhLNrewa3ueFb4AyDGUNRLczfRX
X-Proofpoint-GUID: SPdZCKhLNrewa3ueFb4AyDGUNRLczfRX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2NyBTYWx0ZWRfX8Zno8UDFwBlU duo4p/Fdz0av0UAgxGRNiVRJk1XJoAiV3cx5zZXo6AcXCz222ufGHQ6WHfbQW9XWpRnDkit1K3m SrdhNtByYCGxNlVGWLPt/U1h1TRc9J6Go5Da2RgZgW6LgwweP0Zt3f3AQFYCX1hXLUDdOU4ti/L
 zU4nKKfMLBba9Te4xBIW4WYEWyPWiWUJfm4BFy2JvoFy26oBDK+rU7ZjYWGtobUQluv2tB6MSMd DKYk+kfeqDhicF9kF5mk9CGlseuzNtsEiOySkcJDZJWUawCmu626IowkW+CEnZuSlpjB1A2/sxO 2hPqohFeIcc0tWOVj4BzHHy71HHMp0yOOxhDzNlyGJ8wRkkg+nglO5xooGbW+eKPVhNOlcGVJil
 Kl+gB1KT5TQ8k5HcTyO6PMC7OycZBf8xS92LrJ7FK0TC8eypbntBwOp+62KotipGvP1r+IrC


On Wed, 09 Apr 2025 14:22:53 +0200, Arnd Bergmann wrote:
> When CONFIG_DEBUG_FS is disabled, the stid_fmts[] array is not referenced
> anywhere, causing a W=1 warning with gcc:
> 
> In file included from drivers/gpu/drm/imagination/pvr_fw_trace.c:7:
> drivers/gpu/drm/imagination/pvr_rogue_fwif_sf.h:75:39: error: 'stid_fmts' defined but not used [-Werror=unused-const-variable=]
>    75 | static const struct rogue_km_stid_fmt stid_fmts[] = {
>       |                                       ^~~~~~~~~
> 
> [...]

Applied, thanks!

[01/10] drm/imagination: avoid unused-const-variable warning
        commit: 3206a96675342badb0254558ba4b4c8764aa3ae7

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


