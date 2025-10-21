Return-Path: <linux-kernel+bounces-862578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C07BF5A90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F254042F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D10303A0F;
	Tue, 21 Oct 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="thhEMRO8"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484E2D77F7;
	Tue, 21 Oct 2025 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040651; cv=none; b=gNh4rwHk+I8Dk6vrl5gogdQJOXVqy3enEELyQrqQJMI69CB9LqhSd3hpZh2f/Fx/TFBtKI9SH/iZVUCJgk/zdADaet3keAfipZt/VB6SDDiaZsiHQgTofyLhPnOkqWTfCpM76zDUlltppJUpacm6CfmeWPuCy2IiTQZKOCrWd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040651; c=relaxed/simple;
	bh=uJDMfMk0FDiNF+LAIATAEVdDyXBlepdQ6p2f0t9tJjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bRujFfwIFjlXfT2DCrsE0MVZEAiEUZ9xOBtx8iVp11oS+XHJftTk4gmtU6gDjmeHMUOUKCDHY9PmO1RrvrDTF9EtbPbd7MdfFUIi3t53vdxK/KbHdD8Ws6eDKKiEkO7pg7sa8qr/YdRYLsspVR/US5p0PKOAXMnNziQ1dXDSNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=thhEMRO8; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59L9uRAY1121769;
	Tue, 21 Oct 2025 04:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761040588;
	bh=jYCe3lkSPCb2Hc0E21Vy3Hl4e6Ov3za1LHe8G0I1rNs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=thhEMRO8A5XfHuIPnumSTPetjUUmaaozss8J6GroMAfEPPXPd5z7TBD/JSkX5k0CL
	 OXXuwZNIGkchcrz9KIyGXxvYuMEjr7nvF/Ujx/zlV+uzZ//1pU+P5ozmrrVvAllSDx
	 lGk8jTydu3wFjVaQL0fPF0vtZsgfGRwRKoAzG65c=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59L9uRv11065000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 21 Oct 2025 04:56:27 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 21
 Oct 2025 04:56:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Oct 2025 04:56:27 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59L9uHo43566169;
	Tue, 21 Oct 2025 04:56:18 -0500
Message-ID: <cf10f312-3ba1-4226-96da-d2c9a149c1c7@ti.com>
Date: Tue, 21 Oct 2025 15:26:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Suspend to RAM does not work anymore with
 k3-am62-ti-ipc-firmware.dtsi
To: Francesco Dolcini <francesco@dolcini.it>
CC: Hiago De Franco <hiagofranco@gmail.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <afd@ti.com>, <u-kumar1@ti.com>,
        <hnagalla@ti.com>, <jm@ti.com>, <d-gole@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
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
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan
 Eichenberger <stefan.eichenberger@toradex.com>,
        Hiago De Franco
	<hiago.franco@toradex.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Li Hua Qian
	<huaqian.li@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Baocheng Su
	<baocheng.su@siemens.com>,
        Benedikt Niedermayr
	<benedikt.niedermayr@siemens.com>,
        <regressions@lists.linux.dev>
References: <sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l>
 <e60dd8d6-2bd5-41f0-bf8a-b0a5822a7f88@ti.com>
 <20251021093420.GA28462@francesco-nb>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20251021093420.GA28462@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 21/10/25 15:04, Francesco Dolcini wrote:
> On Tue, Oct 21, 2025 at 02:33:10PM +0530, Beleswar Prasad Padhi wrote:
>> On 20/10/25 19:47, Hiago De Franco wrote:
>>> DM R5 sends a message that is never consumed, since no firmware is
>>> running on the M4 (the core is offline).
>>
>> May I know why you are not running any firmware on the M4
>> rproc? If the intention is just to run the DM R5 core on the SoC,
>> you can disable the IPC by NOT including the
>> "k3-am62-ti-ipc-firmware.dtsi". That was the motivation for the
>> refactoring.
> Verdin AM62 and AM62P are generic SoMs, that can be used for a multitude
> of different use cases. And not having anything running on the M4 is the
> default use case.


If not having anything on M4 is the default use case, it should
be marked as "status=disabled" in the DT.

>
> I think having the node in the DT is the correct way forward, if you
> want to start the M4 firmware you need such a node, so this is enabling
> a valid and useful use case.


Having the node is fine, you can still choose to keep it
disabled by default.

>
>> List of suggestions/solutions in order of preference:
>> 1. If no intention to enable IPC on rprocs:
>>       Do _not_ include k3-am62-ti-ipc-firmware.dtsi
>> 2. If intention is to enable IPC on rprocs:
>>       Make sure rproc firmware is available in rootfs.
>>       rproc would boot up and consume the mbox
>>       msg, suspend would be successful. Tested this
>>       on TI AM62x-sk with commit 1d6161617c, works
>> 3. Add support in mbox driver to flush the pending
>>     queues.
> 2 is not applicable here, and 1 to me is not a good solution.


Why not? Why would you power on the rproc, enable
the mailboxes, carveout some memory if you never
intend to use it?

>  So this
> means that we need #3.
>
>>> #regzbot introduced: 1d6161617c
>> Would not see this as a regression, but rather a new
>> bug for the omap-mailbox driver...
> As a user this is just a regression. It worked fine before, it's not
> working anymore now.


Isn't this partly dependent on the filesystem as well?
You would not see this behavior if you package the
firmware in rootfs, which I assume you did while
testing a49f991e740f

https://lore.kernel.org/all/20250908142826.1828676-17-b-padhi@ti.com/

>
> The fact that the solution might not be in the same file that introduced
> the issue is not a reason for this not being considered a regression.
>
> Francesco
>

