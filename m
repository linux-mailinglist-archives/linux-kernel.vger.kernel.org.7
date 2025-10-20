Return-Path: <linux-kernel+bounces-860948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D9BF1663
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C599234CE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C38239E60;
	Mon, 20 Oct 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MYoodAvC"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E79339A8;
	Mon, 20 Oct 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965221; cv=none; b=q3Cd9+wH1Scc1mHcfTFyELKbJ8LLkTSg0tiOQSUzwClXRsUV/+CEEvtav8NimPF9oTHD0DkHijcgqiknV+C9xoGuaTGVoTvYDlUAgrV2Tsxrh7FLhuOOtE+eOlWPto+Ten84FkPRCtf4k2nrKTKRgQr8eIvMH/n7LUCcBSivP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965221; c=relaxed/simple;
	bh=L5AONxnW45RKiVE2kaWUGbR1Yv5Cm8NyMUmn3AReMMA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=N6vkKs2OuynbvcbdUIPcd9INKo0r18wwPCFyMKSE/WWJXsyd7TDW+Y/UdWt0f8Ay4hvAuzKB7TWCjfiMyNjCrNwWQtAIjogmOVS7KJ0fZyhbNwAOtbD4B92yChj1tuAOEcFAva5tz/RoIAag8CVzwb74QKzkdReGfPEq5cYCyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MYoodAvC; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760965215; x=1761570015; i=markus.elfring@web.de;
	bh=k2BV2Zs6KyNvvkXjdx3X0JvRTK39aZwsnopynBsWICQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MYoodAvC3qOjoqXTFkNR9eHH05CLFe4NP8DIPYUyIffEj3LN3t5TMAB2LknQDhbM
	 X9kfmYh36jzMq5lB3Zc+Y+XwLfJzi1hn4R55VR23H0xp2ceUxtRx17hG11dTBCCOj
	 +K8BbfTQhYPDhokn98myeAS13u2IOu+Me42TXcVRlK/JBh59fVnGbT6iTYLGTOQHb
	 XLb87FF0t7eWZyemHAMIO/hVoJnz2WDEPNWH5WT8C4A5T+NhJRwbWfmbNhFA76wHQ
	 n1MCHXeloX2rFyaopq4DEGVehxQ4HEHvCUFvKT23LYq6g3dDjHUMI9DvPs15fg81G
	 vbRnHc5Q0IOsplQbMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRYf-1ut1Ui1FCd-00SPQl; Mon, 20
 Oct 2025 15:00:15 +0200
Message-ID: <28b3e6b0-0090-4256-8dd6-5a01fc4bd576@web.de>
Date: Mon, 20 Oct 2025 15:00:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: Andrea della Porta <andrea.porta@suse.com>, Arnd Bergmann
 <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Anand Moon <linux.amoon@gmail.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] misc: rp1: Omit two variable reassignments in rp1_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UridH3VEjBpeNGDZtqQz5HV8TpGFUEGVFuI45Y3fkzhxltdOW8C
 YNssXcSf/UGt7DM/1MJJ+lszzkLRy9qGpnDm0jXyeCAihEaSLOKNpVpIK5q83qZJ4ridQFo
 4h40c+Kw4Q3m3DnUgV11kSTe+CK5azJsMmlX+Tqfku9D6J9Wjcw6sVBwfbzEJ/Zb9/iqFrn
 /MVKa3hPNmVvLKc8AtvUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pHMFG0xsXuM=;TSobXuOpXI9KokQChdqm1qRMnsG
 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
 TanJGEZXqZ1WVACYyNFYBxH4rw=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 20 Oct 2025 14:51:43 +0200
Subject: [PATCH] misc: rp1: Omit two variable reassignments in rp1_probe()

An error code was assigned to a variable and checked accordingly.
This value was passed to a dev_err_probe() call in an if branch.
This function is documented in the way that the same value is returned.
Thus delete two redundant variable reassignments.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/misc/rp1/rp1_pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
index 803832006ec8..3baea1a24549 100644
=2D-- a/drivers/misc/rp1/rp1_pci.c
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -226,8 +226,7 @@ static int rp1_probe(struct pci_dev *pdev, const struc=
t pci_device_id *id)
=20
 	err =3D pcim_enable_device(pdev);
 	if (err < 0) {
-		err =3D dev_err_probe(&pdev->dev, err,
-				    "Enabling PCI device has failed");
+		dev_err_probe(&pdev->dev, err, "Enabling PCI device has failed");
 		goto err_put_node;
 	}
=20
@@ -243,8 +242,7 @@ static int rp1_probe(struct pci_dev *pdev, const struc=
t pci_device_id *id)
 	err =3D pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
 				    PCI_IRQ_MSIX);
 	if (err < 0) {
-		err =3D dev_err_probe(&pdev->dev, err,
-				    "Failed to allocate MSI-X vectors\n");
+		dev_err_probe(&pdev->dev, err, "Failed to allocate MSI-X vectors\n");
 		goto err_put_node;
 	} else if (err !=3D RP1_INT_END) {
 		dev_err(&pdev->dev, "Cannot allocate enough interrupts\n");
=2D-=20
2.51.1


