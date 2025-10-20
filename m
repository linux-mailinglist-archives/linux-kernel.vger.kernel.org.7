Return-Path: <linux-kernel+bounces-861097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE3DBF1CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA4A188FE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C22184;
	Mon, 20 Oct 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj4ACLXO"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF25323417
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969842; cv=none; b=r4/FzoTnC/o1574Wx0rnKhQoiQz1MxGWPZYG4FBldIbZLKWgQDmfIA7ot3YAtBcHTI6pEzHtFEQVCG7r26h2ZmNfz/QRlfDeYAiCMFEd2XJt2OHzdCf2SrXEErUH/N2Bdiil3plW3sWJqOqKPHIkb7dqoeai93IlwmlFidpO6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969842; c=relaxed/simple;
	bh=GgaR0JF2DiNFcr+JLR+skAJBZe8ZfkbJM0uSeMUmHNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lquH2Czwfv5QQqo91tPFyaUaG7La953zlCoKq2H703vlkQgPZaUNl7qsxtzpNTq1T52aeV09neUFUuHoYYksoCZ/V6CweQyWxpwiIcLnIljG73eSPY2ZR/gjGnXsICvBujLDrePBj3soGVg2MYNDu3AvWr7TKtb2JmmH0Dr+DuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj4ACLXO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3968863b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760969839; x=1761574639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFGSwFSrgqDr9/3WMg/kXR+n60QLpJskpnlVbbXnq7E=;
        b=Fj4ACLXOuyHGurIdjfUL8FcVmFbnm+HjYPtIBnXUycyVRNj1V8AkaYh3YOHngc76us
         ESaYAVC7RaXb5oMDPzIsdnoNV/WaDqzYzaKMzH98oIApPkbrJ9ypblNfbMJ3PDBWgSGZ
         Kozgz5RZGZZw2Kpa5dS/2LvWPEs1MeezAT3AbgOc5Bvu0AxzxhH9lwAwhgT5N/UAsJ4F
         D4Gy4+AuY6C+0gwqBrXZPox++CIok5sqegXlG4zal1H4OS08gXXMLDmvqRxg25eyoZGe
         PoN8sN0Zw+hKJt0Wp4hvCP7UPQTDNhOvatU+YatE6woAguT5Cm5eF1Fw7bPWmitjzzNG
         1iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969839; x=1761574639;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFGSwFSrgqDr9/3WMg/kXR+n60QLpJskpnlVbbXnq7E=;
        b=Xwtbk6zxTeFYgRrLdKYGUJ3n7pdLvRsOL7XIz7j/4pTWlmEPz+J/PpUJsxm4Y6jbAZ
         cIRBemTTjiSpqQ1kLaYxKmHSAt+IbVaps8+ml7EwM7RC/N65W7z5/VuXIW1mxRHFzkNc
         bdEl8hFf7QM6IhQDy7Nrj9nj/33KeonkqD4NP6QJQJQ57hojoLEBERtGfirFyftOiTnv
         SxPNq8IiAehbg7nTm0YimKTx6E12n7c587v5UOIKh8qdGgZcMqy+byrWRMQyBhRn3aIP
         iaxHsFQsjMmLnbesrMGLXtRzg97euPoK7kY3F8nq50GtaPupDhTgBLP+3VxAY0aeGggK
         jF9w==
X-Forwarded-Encrypted: i=1; AJvYcCVK1qKV3xehRoBwwitVh2YRiYUVCiw6Teph/2KiEs/psPJyuvl7WFPL4IMHvX0NAiHP+UY4RXgXLv3e/j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtlFr5VgNXqM33+O+QJLpXQXpIPBaz8tkAID3EIbJzkFHXeSS
	FwIGxhxxmKXy/aAOrf6tXsb1soL36xg2WTR9lLIPO8OKHwb5oAGwsoW5
X-Gm-Gg: ASbGncuIVJZHbe7B3UtxxlGZdDuNzjUHhxk1JK9U6tgTBsZsrPQDzSQ5X9oseebMxeM
	LaqCzfCVB9Aczq5gTiXrQIwRPQIpr6CfSxpj0fWDvX9ChYdkTzTDmxwQc63Zl1lVBrap/b/uFy9
	BfwUFYwWf2SheohY6/9S92T313C6IJSrZb40m2AiR1jIVnctUHseGz8yp89pIoClehE7p72pfsw
	ZCdIZwLdmBg7+L/o7AKwXvssLyhZFDN9TTp0M7iDpkPx7F+KPl+21jQ/Z+h+8s9D5gZ4icFKMTq
	2ngZrRN8fNVyhFyMjSFjblwWKLS8aksREJR2hqm5N1+L212zAorqgYs49JaEc98IGLik0kWHzW8
	G6M5UHg5kHs1xDXolS8G6xnmBUnceUIjc3Y0Zdiv6v6iBhmolDNIqG3v6GmoH+vBa7MwAaiQYgJ
	WjgKq91s4F0dyH+CZn4Zd2vC2krvnc9go=
X-Google-Smtp-Source: AGHT+IEGpqCj48hSlGvE39SucbX6Ouca5PqF+VzauRnJXVW7BvicaDLem8wj36fR99ehw835dYNneQ==
X-Received: by 2002:a17:90b:3c02:b0:33b:6bff:35fe with SMTP id 98e67ed59e1d1-33bc9d1c743mr18185739a91.16.1760969839288;
        Mon, 20 Oct 2025 07:17:19 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c0:fdb0:efbb:1413:f1d2:48d9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de11601sm8126966a91.9.2025.10.20.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:17:18 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:17:04 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com, u-kumar1@ti.com, 
	hnagalla@ti.com, jm@ti.com, d-gole@ti.com, b-padhi@ti.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Logan Bristol <logan.bristol@utexas.edu>, Josua Mayer <josua@solid-run.com>, John Ma <jma@phytec.com>, 
	Nathan Morrisson <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, 
	Matt McKee <mmckee@phytec.com>, Wadim Egorov <w.egorov@phytec.de>, 
	Max Krummenacher <max.krummenacher@toradex.com>, Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
	Hiago De Franco <hiago.franco@toradex.com>, Diogo Ivo <diogo.ivo@siemens.com>, 
	Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Baocheng Su <baocheng.su@siemens.com>, Benedikt Niedermayr <benedikt.niedermayr@siemens.com>, 
	regressions@lists.linux.dev
Subject: [REGRESSION] Suspend to RAM does not work anymore with
 k3-am62-ti-ipc-firmware.dtsi
Message-ID: <sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello all,

After commit 1d6161617c10 (“arm64: dts: ti: k3-am62-ti-ipc-firmware:
Refactor IPC cfg into new dtsi”), suspend-to-RAM stopped working on
AM62x.

When I originally tested that change, I did not test suspend-to-RAM
functionality, but our testing infrastructure caught this regression.

See the log below:

root@verdin-am62-15479173:~# cat /sys/class/remoteproc/remoteproc*/state
offline
offline
offline
root@verdin-am62-15479173:~# echo mem > /sys/power/state
[   37.798686] PM: suspend entry (deep)
[   37.805942] Filesystems sync: 0.003 seconds
[   37.811965] Freezing user space processes
[   37.819214] Freezing user space processes completed (elapsed 0.002 seconds)
[   37.826469] OOM killer disabled.
[   37.829721] Freezing remaining freezable tasks
[   37.835557] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   37.843057] printk: Suspending console(s) (use no_console_suspend to debug)
[   37.953874] omap-mailbox 29000000.mailbox: fifo 5 has unexpected unread messages
[   37.953909] omap-mailbox 29000000.mailbox: PM: dpm_run_callback(): platform_pm_suspend returns -16
[   37.953941] omap-mailbox 29000000.mailbox: PM: failed to suspend: error -16
[   37.953967] PM: Some devices failed to suspend, or early wake event detected
[   37.973876] am65-cpsw-nuss 8000000.ethernet: set new flow-id-base 19
[   37.984655] am65-cpsw-nuss 8000000.ethernet end0: PHY [8000f00.mdio:00] driver [TI DP83867] (irq=353)
[   37.985655] am65-cpsw-nuss 8000000.ethernet end0: configuring for phy/rgmii-rxid link mode
[   38.009002] usb-conn-gpio connector: repeated role: device
[   38.013377] lt8912 1-0048: PM: dpm_run_callback(): lt8912_bridge_resume [lontium_lt8912b] returns -121
[   38.013420] lt8912 1-0048: PM: failed to resume async: error -121
[   38.153252] OOM killer enabled.
[   38.156422] Restarting tasks: Starting
[   38.163532] Restarting tasks: Done
[   38.167252] random: crng reseeded on system resumption
[   38.173031] PM: suspend exit

The omap-mailbox driver returns -EBUSY because it detects an unexpected
unread message on FIFO 5.  As I understand it, this FIFO corresponds to
the communication channel between the DM R5 and the Cortex-M4 cores.

DM R5 sends a message that is never consumed, since no firmware is
running on the M4 (the core is offline). This unhandled message prevents
the system from entering suspend.

This issue also appears on the downstream TI kernel, which I reported
earlier [1] (for reference).

The following patch resolves the problem:

diff --git a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
index ea69fab9b52b..e07cf3290cc3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
@@ -26,11 +26,6 @@ mbox_m4_0: mbox-m4-0 {
                ti,mbox-rx = <0 0 0>;
                ti,mbox-tx = <1 0 0>;
        };
-
-       mbox_r5_0: mbox-r5-0 {
-               ti,mbox-rx = <2 0 0>;
-               ti,mbox-tx = <3 0 0>;
-       };
 };

 &mcu_m4fss {
@@ -45,7 +40,6 @@ &wkup_r5fss0 {
 };

 &wkup_r5fss0_core0 {
-       mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
        memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
                        <&wkup_r5fss0_core0_memory_region>;
        status = "okay";

Ultimately  this issue is related to the omap driver itself:

1. We should have a functionatlly to save and restore the messages into
the mailbox, instead of preveting it to go into suspend.

2. Or we could not check all 16 FIFOs if the kernel does not own them:

	for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
		if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
			dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
				fifo);
			return -EBUSY;
		}
	}

Setting the number of FIFOs to 4 in the device tree also resolves this
issue.

Do you have suggestions on how best to fix this in the driver, or should
we consider reverting the DTS change until suspend-to-RAM works again?

#regzbot introduced: 1d6161617c

[1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1557295/am62p-mailbox-channel-is-not-freed-during-r5-remoteproc-stop-call/6069413

Best regards,
Hiago.

