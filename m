Return-Path: <linux-kernel+bounces-674523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F5AACF0A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB20189119E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD2242927;
	Thu,  5 Jun 2025 13:28:15 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EC233156;
	Thu,  5 Jun 2025 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130094; cv=none; b=OgIMqZH2Al60fhWlLDqNV0wZ6MroEXkXuh1zofZ3o6f7vHztFtU7vExaVq5k6+3/KvYOfN+6/XIgzZsYrL2Bb/ERMr/aTiCBPN7fQtsRasdbC7Hye/lZ+ACq/pe04rLcHCbqfMBNnDUimpQhx75gkdYYR2o6C4VOVzF1p4hXuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130094; c=relaxed/simple;
	bh=/ieZ0vxH4omc1mUqVzRc72rlNUiEFsdEdZ7K/9g2NXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cz40QCMo0uSkbT5C6OToNWtkbjayW90oLcIqXDgYEKpGGUTNdfljFGS86y4JlwcqaklG8w8majmLW75NKVPHqrj8eWhs/glQ28MPWu3xwlaOVSDwzPncgehZ5wzX3Ue4cnfrx3Z8yoIWwcMbxRtdnQJzaGS0TSSzl2NbK+FHdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 15:28:02 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Thu, 5 Jun 2025 15:28:02 +0200
From: John Ernberg <john.ernberg@actia.se>
To: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: Frank Li <Frank.li@nxp.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, John Ernberg <john.ernberg@actia.se>,
	"stable@kernel.org" <stable@kernel.org>
Subject: [PATCH v4 1/4] crypto: caam - Prevent crash on suspend with iMX8QM /
 iMX8ULP
Thread-Topic: [PATCH v4 1/4] crypto: caam - Prevent crash on suspend with
 iMX8QM / iMX8ULP
Thread-Index: AQHb1h2plHQMa1AvZEqS7N0zrhQB1A==
Date: Thu, 5 Jun 2025 13:28:01 +0000
Message-ID: <20250605132754.1771368-2-john.ernberg@actia.se>
References: <20250605132754.1771368-1-john.ernberg@actia.se>
In-Reply-To: <20250605132754.1771368-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B1445363726A
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Since the CAAM on these SoCs is managed by another ARM core, called the
SECO (Security Controller) on iMX8QM and Secure Enclave on iMX8ULP, which
also reserves access to register page 0 suspend operations cannot touch
this page.

This is similar to when running OPTEE, where OPTEE will reserve page 0.

Track this situation using a new state variable no_page0, reflecting if
page 0 is reserved elsewhere, either by other management cores in SoC or
by OPTEE.

Replace the optee_en check in suspend/resume with the new check.

optee_en cannot go away as it's needed elsewhere to gate OPTEE specific
situations.

Fixes the following splat at suspend:

    Internal error: synchronous external abort: 0000000096000010 [#1] SMP
    Hardware name: Freescale i.MX8QXP ACU6C (DT)
    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
    pc : readl+0x0/0x18
    lr : rd_reg32+0x18/0x3c
    sp : ffffffc08192ba20
    x29: ffffffc08192ba20 x28: ffffff8025190000 x27: 0000000000000000
    x26: ffffffc0808ae808 x25: ffffffc080922338 x24: ffffff8020e89090
    x23: 0000000000000000 x22: ffffffc080922000 x21: ffffff8020e89010
    x20: ffffffc080387ef8 x19: ffffff8020e89010 x18: 000000005d8000d5
    x17: 0000000030f35963 x16: 000000008f785f3f x15: 000000003b8ef57c
    x14: 00000000c418aef8 x13: 00000000f5fea526 x12: 0000000000000001
    x11: 0000000000000002 x10: 0000000000000001 x9 : 0000000000000000
    x8 : ffffff8025190870 x7 : ffffff8021726880 x6 : 0000000000000002
    x5 : ffffff80217268f0 x4 : ffffff8021726880 x3 : ffffffc081200000
    x2 : 0000000000000001 x1 : ffffff8020e89010 x0 : ffffffc081200004
    Call trace:
     readl+0x0/0x18
     caam_ctrl_suspend+0x30/0xdc
     dpm_run_callback.constprop.0+0x24/0x5c
     device_suspend+0x170/0x2e8
     dpm_suspend+0xa0/0x104
     dpm_suspend_start+0x48/0x50
     suspend_devices_and_enter+0x7c/0x45c
     pm_suspend+0x148/0x160
     state_store+0xb4/0xf8
     kobj_attr_store+0x14/0x24
     sysfs_kf_write+0x38/0x48
     kernfs_fop_write_iter+0xb4/0x178
     vfs_write+0x118/0x178
     ksys_write+0x6c/0xd0
     __arm64_sys_write+0x14/0x1c
     invoke_syscall.constprop.0+0x64/0xb0
     do_el0_svc+0x90/0xb0
     el0_svc+0x18/0x44
     el0t_64_sync_handler+0x88/0x124
     el0t_64_sync+0x150/0x154
    Code: 88dffc21 88dffc21 5ac00800 d65f03c0 (b9400000)

Fixes: d2835701d93c ("crypto: caam - i.MX8ULP donot have CAAM page0 access"=
)
Cc: stable@kernel.org # v6.10+
Signed-off-by: John Ernberg <john.ernberg@actia.se>

---

I noticed this when enabling the iMX8QXP support (next patch), hence the
iMX8QXP backtrace, but the iMX8QM CAAM integration works exactly the same
and according to the NXP tree [1] the iMX8ULP suffers the same issue.

[1]: https://github.com/nxp-imx/linux-imx/commit/653712ffe52dd59f407af1b781=
ce318f3d9e17bb

---

v4:
 - Drop 2nd Fixes tag (Frank Li)

v3:
 - no changes

v2:
 - Adjust commit message to make it clearer what is happening around no_pag=
e0 (Frank Li)
---
 drivers/crypto/caam/ctrl.c   | 5 +++--
 drivers/crypto/caam/intern.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 38ff931059b4..766c447c9cfb 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -831,7 +831,7 @@ static int caam_ctrl_suspend(struct device *dev)
 {
 	const struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
=20
-	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en)
+	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->no_page0)
 		caam_state_save(dev);
=20
 	return 0;
@@ -842,7 +842,7 @@ static int caam_ctrl_resume(struct device *dev)
 	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
 	int ret =3D 0;
=20
-	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en) {
+	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->no_page0) {
 		caam_state_restore(dev);
=20
 		/* HW and rng will be reset so deinstantiation can be removed */
@@ -908,6 +908,7 @@ static int caam_probe(struct platform_device *pdev)
=20
 		imx_soc_data =3D imx_soc_match->data;
 		reg_access =3D reg_access && imx_soc_data->page0_access;
+		ctrlpriv->no_page0 =3D !reg_access;
 		/*
 		 * CAAM clocks cannot be controlled from kernel.
 		 */
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index e51320150872..51c90d17a40d 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -115,6 +115,7 @@ struct caam_drv_private {
 	u8 blob_present;	/* Nonzero if BLOB support present in device */
 	u8 mc_en;		/* Nonzero if MC f/w is active */
 	u8 optee_en;		/* Nonzero if OP-TEE f/w is active */
+	u8 no_page0;		/* Nonzero if register page 0 is not controlled by Linux */
 	bool pr_support;        /* RNG prediction resistance available */
 	int secvio_irq;		/* Security violation interrupt number */
 	int virt_en;		/* Virtualization enabled in CAAM */
--=20
2.49.0

