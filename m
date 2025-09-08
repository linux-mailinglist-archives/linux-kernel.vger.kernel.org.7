Return-Path: <linux-kernel+bounces-805467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1572B488E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6431316401E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025282EC54E;
	Mon,  8 Sep 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dhbD+lWn"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5B1CDFAC;
	Mon,  8 Sep 2025 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324720; cv=none; b=SGZZXeBmJL+5EWDxJR7akX3sNfJGJMkUPqllrRJSOhD1VnKkTYrfZoI8BWQG5YwR6p7aFGpmAWjH4QhlnfFP4/EM0/VYQRAfoNecI9MJ0+7rxDLZA+Po9HC1d+K2anzBinpM0/laiREyFFXbqDUPASLmJdltMlKcCkAZKzSiGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324720; c=relaxed/simple;
	bh=nDalhWDdRaKI0K8oFZEyuIzW1+9ZHDPR6MDrSzflp68=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/ZFH52TdqgqbUDlc2fOJD9mO+Yuy09EuUfz4waxjCbtuLHqkjfGbXhJnWosQ9d/Uaf4PQiqVRoPr717KSvh9Z2Cm1g+dKus6Oz0X9qv6OtLEnT2gYB/GVEYWitY1UnUvXCmcgrEb4Yif1z2RDLBt/QFY/ue/V4mGZHok4Z1jsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dhbD+lWn; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5889j7Bg077755;
	Mon, 8 Sep 2025 04:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757324707;
	bh=vSJqX1AAqYYY3cwD7+kPGOUDcEyMxKTWaZHJI25fkLc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dhbD+lWnE6JwR2i9iy7Fi4ZjtgbhGvxq0IVdPw0x5ftpfLZo/PKlb5qjbBCca5l5M
	 RRM7NLkEaGHmtoYrvZVsHiYTQ5FZFka+JbVwpiOpQdHs4qc+yEwa/qgYHbyCHwq+KQ
	 uxCtbMJmzhioBnofioa4FbvxyzN5mpZ985Ouu5zA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5889j7NU3685564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 04:45:07 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 04:45:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 04:45:07 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5889j5gl394282;
	Mon, 8 Sep 2025 04:45:06 -0500
Date: Mon, 8 Sep 2025 15:15:05 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 29/33] arm64: dts: ti: k3-am62p-ti-ipc-firmware:
 Refactor IPC cfg into new dtsi
Message-ID: <20250908094505.4dasmw6sv5bazd5z@lcpd911>
References: <20250905051846.1189612-1-b-padhi@ti.com>
 <20250905051846.1189612-30-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051846.1189612-30-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 10:48:42 +0530, Beleswar Padhi wrote:
> The TI K3 AM62P SoCs have multiple programmable remote processors like
> R5Fs. The TI SDKs for AM62P SoCs offer sample firmwares which could be
> run on these cores to demonstrate an "echo" IPC test. Those firmware
> require certain memory carveouts to be reserved from system memory,
> timers to be reserved, and certain mailbox configurations for interrupt
> based messaging. These configurations could be different for a different
> firmware.
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
> Tested-by: Judith Mendez <jm@ti.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

