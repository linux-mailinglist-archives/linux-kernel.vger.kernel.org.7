Return-Path: <linux-kernel+bounces-801610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E89B44790
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D9A43138
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77B28469C;
	Thu,  4 Sep 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ptTOBHWt"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C2280312;
	Thu,  4 Sep 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018487; cv=none; b=jtdsAlxr4BkPcYrtC5iTVjSW2wpv7yBVVJcnMzkSFXx4btOHaJoeWND1BQj4b0CmBPqrUkJZc8etye5mpNaIoUOC6UcMw8cpRg5awJloZ17EB0pEy4gm70/Tosd15doh3WqVI8tBGb02DesAGboRR9MBnqqXctZ4et29tEeLFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018487; c=relaxed/simple;
	bh=ZHDNR2SrJAcBSZYdkKgM50YcJVcRyKPewh/tYvvv40k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PTmaKOfG/OvyO03sEH0OV+raYf/9rfLXaiDYWdPqX5mNKcdQIV+FS4D2I89yZE0xVPUP1fnXsGyvqQkK74/PONB5GLdgqJwkUmcdX+aSM/F2nP/JuqCMlK9vKTC2J2FLYX9GnJLsUaGAC3uaJ2Bbzx6B8uidg9uHImsKyzVNYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ptTOBHWt; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584KepBk3595659;
	Thu, 4 Sep 2025 15:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757018451;
	bh=XViZ7K4qUIDoQ+R0DNxwBPH2Ie9zst4zMX81EjLVreE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ptTOBHWt/JWN/jXCAdnAvShJZj5EA/1fBWY56d+Ab7GX7zbZotqkTEKu7Vd0GjZEb
	 OngvCoFOuqN3Izm3HTkrxPZ/UN5Ul/rXTJV+1ETYarkWNlyCGHQVxkPSHm1lTOGkY7
	 NLTgWpiAxKWpQ5BZpfST2qg+sVGGCpyv2A1LKlwI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584KeoJN379192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 15:40:51 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 15:40:50 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Thu, 4 Sep
 2025 15:40:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 15:40:50 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584Keo8e3561056;
	Thu, 4 Sep 2025 15:40:50 -0500
Message-ID: <8fea9d7d-faa0-4e51-b7a5-e17a945bf1ed@ti.com>
Date: Thu, 4 Sep 2025 15:40:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/33] Refactor TI IPC DT configs into dtsi
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson
	<robertcnelson@gmail.com>,
        Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>,
        Parth Pancholi <parth.pancholi@toradex.com>,
        Emanuele Ghidoli
	<emanuele.ghidoli@toradex.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>,
        Logan Bristol
	<logan.bristol@utexas.edu>,
        Josua Mayer <josua@solid-run.com>, John Ma
	<jma@phytec.com>,
        Nathan Morrisson <nmorrisson@phytec.com>,
        Garrett Giordano
	<ggiordano@phytec.com>,
        Matt McKee <mmckee@phytec.com>, Wadim Egorov
	<w.egorov@phytec.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "Max
 Krummenacher" <max.krummenacher@toradex.com>,
        Stefan Eichenberger
	<stefan.eichenberger@toradex.com>,
        Hiago De Franco <hiago.franco@toradex.com>
References: <20250823160901.2177841-1-b-padhi@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250823160901.2177841-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Beleswar,

On 8/23/25 11:08 AM, Beleswar Padhi wrote:
> The TI K3 SoCs have multiple programmable remote processors like
> R5F, M4F, C6x/C7x etc. The TI SDKs for these SoCs offer sample firmware
> which could be run on these cores to demonstrate an "echo" IPC test.
> Those firmware require certain memory carveouts to be reserved from
> system memory, timers to be reserved, and certain mailbox
> configurations for interrupt based messaging. These configurations
> could be different for a different firmware.
> 
> Refactor these firmware dependent configurations from board level DTS
> into a dtsi for now. This dtsi for TI IPC firmware is board-independent
> and can be applied to all boards from the same SoC Family. This gets
> rid of code duplication (>50%) and allows more freedom for users
> developing custom firmware (or no firmware) to utilize system resources
> better; easily by swapping out this dtsi. To maintain backward
> compatibility, the dtsi is included in all existing boards.
> 
> DTSI vs Overlay:
> 1. I chose DTSI over overlay as both the ways required including the
> refactored file in existing board-level files to maintain backward
> compatibility, so didn't see the advantage of using overlays here.
> 2. If we do down the overlay path, existing board-level file names have
> to be changed to indicate they are without the IPC support; so that
> they can be combined with the overlay to generate the same-named DTBs.
> For example:
> k3-am69-sk.dtb := k3-am69-sk-sans-ipc.dtb k3-j784s4-ti-ipc-firmware.dtbo
> 			     ~~~~~~~~
> 
> I am not sure if this renaming of files is ideal?
> 

Thanks for you patches, I was able to boot test on am62px SK and
am62ax SK boards. I was also able do a simple rpmsg echo test with some
additional patches on top of your changes:
https://gist.github.com/jmenti/4ae7a6a65c2cb95fd54f48d32430c1e9

so for am62ax and am62px SK boards:

Tested-by: Judith Mendez <jm@ti.com>





