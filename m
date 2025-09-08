Return-Path: <linux-kernel+bounces-805450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3DCB488A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37EA18927C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57B2ED14D;
	Mon,  8 Sep 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MYXV/gWp"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891032E7F30;
	Mon,  8 Sep 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324285; cv=none; b=qL1n8mEtBIO0wsvACvbsc5d1qYnLaS7ZsBiyzuItnbJRqZrAxmPtrwaRQ8IsJQL79EfEViNJsMhrOzsx5b8tc1751/Yzbuma5r4IjPn/0oOq+bQ1LiMoBegb4uPWex6Wwy4z+N6Egx07URs7rHmt0QA66kKCgprygTNxMbySh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324285; c=relaxed/simple;
	bh=qlRN1u/CSDLjqfmklYbEq+IcrLK8UAdREzAgxsn6p7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A67ZZRCaVSjTq4N7HOO4X5B+/swU5XL9hjtxeRE9iCtjqZn54F5Ou0jwjKeexazEvaYQTUYOuPo+jBCUCuSU7QIqzuEt1k5vR2EJBse3FOneki60Gs0c1Q3Vz0L2DHK5K7yhkhhXM67nqFLFtPMlyH+DaLXPDOSqUVifpGyuP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MYXV/gWp; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5889bruo3765935;
	Mon, 8 Sep 2025 04:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757324274;
	bh=HViEJAJtIasUDMxy95AazLJM2TcmtxxJAuZu2hzNvWY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=MYXV/gWpLq85Jc6hXNCxwhhqMuUjRqO1z2laLlj51kRCP5mmiRIIWU0pmYfm0imz6
	 nhjZBMrJUptMKKFpi+V2cbfpokqEPsS6KWePEYRhLzEsR5hZaWxg4Ik1NmdyA1LpB2
	 5itliTHgQanayE3l5hdnesW/tWFyJRz8Aq5JyKxI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5889brL22871363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 04:37:53 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 04:37:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 04:37:53 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5889bqgJ386168;
	Mon, 8 Sep 2025 04:37:52 -0500
Date: Mon, 8 Sep 2025 15:07:51 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH v3 30/33] arm64: dts: ti: k3-am62-ti-ipc-firmware:
 Refactor IPC cfg into new dtsi
Message-ID: <20250908093751.2chmawizotlo3gm6@lcpd911>
References: <20250905051846.1189612-1-b-padhi@ti.com>
 <20250905051846.1189612-31-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051846.1189612-31-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 10:48:43 +0530, Beleswar Padhi wrote:
> The TI K3 AM62 SoCs have multiple programmable remote processors like
> R5F, M4F etc. The TI SDKs for AM62 SoCs offer sample firmwares which
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
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am62x
> ---
[...]

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

