Return-Path: <linux-kernel+bounces-805476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65112B488FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C7F16653C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B8315D41;
	Mon,  8 Sep 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IHh4bkEw"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38812F744C;
	Mon,  8 Sep 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324812; cv=none; b=oeZsGsxxzD7A5Shc3qDnBgpQuzTuR1Pit822RxOTkaEuf9alXqPQ3LsNjh3+c3Oaq/QEEnNP5dJwkcsxqrT0LmYuww5Psdh49ncG/Q+i6n2k4iCacxPUob3TMorU0wiRC4F59fgXyFWme/UVuF1jT5HBi/nZ1vduBTLs/jlvuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324812; c=relaxed/simple;
	bh=ziT/aLu8avuUvS3XHAWGbBPl0kaCQ3HaG/wfIZ5/D0Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chZipDB5y1sUCSJGG6Bfmn7v1QMl0iG4Y6Up8wbp1p+ehRTN81cR5VqmKrTY0FMzMoYxEvGnKGGwowI0oToLPnZMaiNldaKGmTwZmxGsHUmSAZsxzjhuVwKDBqGo0pu32LNNeFLLevy8W+7o05dJAoan3rrK66Zl7PTiXxxL+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IHh4bkEw; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5889khcP3767020;
	Mon, 8 Sep 2025 04:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757324803;
	bh=DVpNAYv9QMh4KP4W1odbt5pAyANXJCF48xip5X7vrWU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IHh4bkEwiYCZ1vM7QBQessgtpy7zw0R5q5EVPwKYV5/fTfFFr+K56idvFZc1NOxDP
	 CXTBumPnkiUgioz3b6Duol/JWkoJlHKq8leZxT+Q7kmUdyV/D3OeuanF0U4Ii58/yo
	 yFHKJPQu0JPvcJaosX79vGLkAXAd4RkcDohGt6s8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5889khxE2321912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 04:46:43 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 04:46:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 04:46:43 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5889kfo4396067;
	Mon, 8 Sep 2025 04:46:42 -0500
Date: Mon, 8 Sep 2025 15:16:41 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH v3 32/33] arm64: dts: ti: k3-am64-ti-ipc-firmware:
 Refactor IPC cfg into new dtsi
Message-ID: <20250908094641.5fxhrlv27zr2jtus@lcpd911>
References: <20250905051846.1189612-1-b-padhi@ti.com>
 <20250905051846.1189612-33-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051846.1189612-33-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 10:48:45 +0530, Beleswar Padhi wrote:
> The TI K3 AM64 SoCs have multiple programmable remote processors like
> R5F, M4F etc. The TI SDKs for AM64 SoCs offer sample firmwares which
> could be run on these cores to demonstrate an "echo" IPC test. Those
> firmware require certain memory carveouts to be reserved from system
> memory, timers to be reserved, and certain mailbox configurations for
> interrupt based messaging. These configurations could be different for a
> different firmware.
> 
> While DT is not meant for system configurations, at least refactor these
> configurations from board level DTS into a dtsi for now. This dtsi for
> TI IPC firmware is board-independent and can be applied to all boards
> from the same SoC Family. This gets rid of code duplication and allows
> more freedom for users developing custom firmware (or no firmware) to
> utilize system resources better; easily by swapping out this dtsi. To
> maintain backward compatibility, the dtsi is included in all boards.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am64x
> Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am64x
> Tested-by: Hari Nagalla <hnagalla@ti.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

