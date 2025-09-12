Return-Path: <linux-kernel+bounces-813619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEFCB54853
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D714669E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2828643C;
	Fri, 12 Sep 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RY6jxN3n"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACC287272;
	Fri, 12 Sep 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670651; cv=none; b=Nqxea7N+QG3xETu0Q1vE+PvEyL6rSCCAFpswp+kdqksd/6jWEPDwkdS1u0ZHpi0hYUffsXPC/bLBJLN6p3iPj240u29DwN0bp4Mecrf9xpsQ8ekec2sojTfcBnxe0zEwBtRp/UXbm/PWRH937b0XycA6K8mWQXyzdCedMlsSxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670651; c=relaxed/simple;
	bh=BB//RMbV9IqrMKmROkV7sTf+bdwtLIP1AgyJMO9TppQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ec+WoMUi5ne7QhoZfajYHJEpXmySq5cVkcxpatIzf7lipRiYkGzDElIYx0Gv5/j0ARpP26ATZsGl9Xxh6kOjRqDnG4oKR1n2UTTq7aKdPIrO790IuCufd6uSKn2JxOMF9vvBZXbgHjmrdV4JdaHtnJcghn4lVvuiJE/LbcwfRuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RY6jxN3n; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9oAOh495791;
	Fri, 12 Sep 2025 04:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670610;
	bh=FwmRxOveNll9yM/Pf1bROm7oigcTkb+UVTYDC58BlQ8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RY6jxN3nnkSaH6skOA8scRxrqMQefuuIMsdrvkHpejF3pNBN4FQoqY42hN0KzkzTV
	 qtbTa9ORLDZ6218RF/OyzG49UrUQ+69jfqFw8dc7Q5VZWP1qunL7RGqQ9B/jBIxIji
	 8+6C4Gmq2NfMP9rGpr/som5DJcACw0dyoToFLWfc=
Received: from DFLE208.ent.ti.com (dfle208.ent.ti.com [10.64.6.66])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9oAvh1775818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Sep 2025 04:50:10 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Sep
 2025 04:50:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:50:02 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9o2Q63717224;
	Fri, 12 Sep 2025 04:50:02 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Beleswar Padhi <b-padhi@ti.com>
CC: Nishanth Menon <nm@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>,
        <hnagalla@ti.com>, <jm@ti.com>, <d-gole@ti.com>,
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
        Max
 Krummenacher <max.krummenacher@toradex.com>,
        Stefan Eichenberger
	<stefan.eichenberger@toradex.com>,
        Hiago De Franco
	<hiago.franco@toradex.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Li Hua Qian
	<huaqian.li@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Baocheng Su
	<baocheng.su@siemens.com>,
        Benedikt Niedermayr
	<benedikt.niedermayr@siemens.com>
Subject: Re: [PATCH v4 00/34] Refactor TI IPC DT configs into dtsi
Date: Fri, 12 Sep 2025 04:49:58 -0500
Message-ID: <175766786790.25701.17214923767658263422.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250908142826.1828676-1-b-padhi@ti.com>
References: <20250908142826.1828676-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Beleswar Padhi,

On Mon, 08 Sep 2025 19:57:52 +0530, Beleswar Padhi wrote:
> The TI K3 SoCs have multiple programmable remote processors like
> R5F, M4F, C6x/C7x etc. The TI SDKs for these SoCs offer sample firmware
> which could be run on these cores to demonstrate an "echo" IPC test.
> Those firmware require certain memory carveouts to be reserved from
> system memory, timers to be reserved, and certain mailbox
> configurations for interrupt based messaging. These configurations
> could be different for a different firmware.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
NOTE: I have'nt had feedback from Siemens team, but looking at the series,
things look fine overall. holler if a problem..
Thank you!

[01/34] arm64: dts: ti: k3-j7200: Enable R5F remote processors at board level
        commit: 7b09167cb7cb09282200903b6371996df4d76bc4
[02/34] arm64: dts: ti: k3-j721e: Enable remote processors at board level
        commit: 73d0df7437364feb1a39772eccbb4f1a604cf623
[03/34] arm64: dts: ti: k3-j721s2: Enable remote processors at board level
        commit: 368ae64a7188ac06d3cb2ee96975d40e6504e40d
[04/34] arm64: dts: ti: k3-j784s4-j742s2: Enable remote processors at board level
        commit: fa1b98ddfa1d44a98f70d7480c87f33f8d29c8d7
[05/34] arm64: dts: ti: k3-am62p-j722s: Enable remote processors at board level
        commit: ec158a0883c90528bbc1ec960a9b990d49a34099
[06/34] arm64: dts: ti: k3-am62: Enable remote processors at board level
        commit: bdc921171dbe13fdc41589d44217d560299bbd5c
[07/34] arm64: dts: ti: k3-am62a: Enable remote processors at board level
        commit: f927049553dfaa27acc099b21095ee488b199687
[08/34] arm64: dts: ti: k3-am64: Enable remote processors at board level
        commit: 93b4ff5b86e5bc53aeba3a0193597ba31a4e5839
[09/34] arm64: dts: ti: k3-am65: Enable remote processors at board level
        commit: c3fc9c1c1ac8f64ef333858ea42676889448a248
[10/34] arm64: dts: ti: k3-am62: Enable Mailbox nodes at the board level
        commit: bc590db1b5fe999d056ba66dc1990288c14f1ec3
[11/34] arm64: dts: ti: k3-am62a: Enable Mailbox nodes at the board level
        commit: 9ca8079eb36b71a86bb5851d9d3b7a49da8e595f
[12/34] arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node
        commit: 4f1aee4723a796a92f17b23699dc861b582ddfd2
[13/34] arm64: dts: ti: k3: Rename rproc reserved-mem nodes to 'memory@addr'
        commit: aee0678597c63e5427e91b2e49a6c5ed4951f277
[14/34] arm64: dts: ti: k3-j721e-beagleboneai64: Add missing cfg for TI IPC FW
        commit: a564730142d5d23c197ca4b4741fb6a89e6f0c2c
[15/34] arm64: dts: ti: k3-am62p-verdin: Add missing cfg for TI IPC Firmware
        commit: fc4f6f0146d4c778859042a76b1e932b6334bf96
[16/34] arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware
        commit: a49f991e740f5f3917b4023705568aeb817ee773
[17/34] arm64: dts: ti: k3-am62-pocketbeagle2: Add missing cfg for TI IPC Firmware
        commit: 6104984a7d1d8c17c724e799501a1be2a2a35a52
[18/34] arm64: dts: ti: k3-am642-sr-som: Add missing cfg for TI IPC Firmware
        commit: e85524649959c2fa2477b66a450471df6e1fb725
[19/34] arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC Firmware
        commit: 67b98792407f41b369ecd799a4928db24dbb2058
[20/34] arm64: dts: ti: k3-am642-tqma64xxl: Add missing cfg for TI IPC Firmware
        commit: b13fb32f6bde4c0c533fab6e4bc240b75296e810
[21/34] Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations"
        commit: 79a1778c7819c8491cdbdc1f7e46d478cb84d5cf
[22/34] Revert "arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations"
        commit: 932424a925ce79cbed0a93d36c5f1b69a0128de1
[23/34] arm64: dts: ti: k3-j721e-beagleboneai64: Switch MAIN R5F clusters to Split-mode
        commit: 897117c6bb4b151bd9326773cd6a5acdad4c47b4
[24/34] arm64: dts: ti: k3-j7200-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: c5b645dbecd6d0b2689fa44eeefe2a2648172dc7
[25/34] arm64: dts: ti: k3-j721e-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: 20ca55168b139c78d4e604a59dbc89403781ee0a
[26/34] arm64: dts: ti: k3-j721s2-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: e2581d3e0787a42f6ede8a15a66a93ae4a3ecd6f
[27/34] arm64: dts: ti: k3-j784s4-j742s2-ti-ipc-firmware-common: Refactor IPC cfg into new dtsi
        commit: 3dabfaa168d8b3835e210f90da3bf0f10b050fdb
[28/34] arm64: dts: ti: k3-j784s4-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: 2742d963e1dd7f4a3d0505044323b091daffcddc
[29/34] arm64: dts: ti: k3-j722s-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: 3cc04e49cd5d9c5af24eb4357775f35156b19fec
[30/34] arm64: dts: ti: k3-am62p-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: 6bd0449be319a29096f3ee7cd415f8b6b28104c7
[31/34] arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: 1d6161617c10435e970d3bb3ef5de124b94fe719
[32/34] arm64: dts: ti: k3-am62a-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: d4ab4a33c8e0a8cd33c8cb70ba3c74dba770c2a4
[33/34] arm64: dts: ti: k3-am64-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: 3ad3ab0bfa577d1f93e7048224c267b32ed4d6a1
[34/34] arm64: dts: ti: k3-am65-ti-ipc-firmware: Refactor IPC cfg into new dtsi
        commit: a26bc9175f679da37ee3a52669aeb26db7f57738

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


