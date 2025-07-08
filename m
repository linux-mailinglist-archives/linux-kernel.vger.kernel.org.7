Return-Path: <linux-kernel+bounces-721352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9368AAFC808
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D124240DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27F026773C;
	Tue,  8 Jul 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b="c8aOyglP"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D14265CAB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969560; cv=none; b=P/HoG0/5fUx/85xOu8Pke4tdoNlFjuRfm16DNTpdTx0H9ZUP6+xD5NAAq0e68SBqIZFUwahTLFzok+17mY5/zlguvkDhi+fvRKd5aVqujTi4z27qrHBmk5NqlFxU9S263T06GVIzw6KpGF+4MIyD/HPKNKD6I7Mat1/xKaODoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969560; c=relaxed/simple;
	bh=lIdIuh0O/t3n7LtVB2cUksJC30jNSXA/jpebYB6unRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHTgzBd1bOpX0/8KFvEXWJNkowXPSriav/33kj5gPbwAIMu3KvM34GMO33UyIWELRvZLkXrqBPejMz2oZTgoT5Lo2oshmmNInSN1x0NbFENKtStTxUoi32RzhH7tPKeBe7fNpkYnMD1HP2kkowrfpl/np7Gy6nq9a5h/Y3uRvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b=c8aOyglP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a524caf77eso582059f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix.de; s=google; t=1751969557; x=1752574357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmX1zBN33lB4gzLUkNPqUBTAn0Dd9jMDbw1KtlNeu0A=;
        b=c8aOyglPhAN3DKMubS+9WQx54KbgiTKrwdmw8nHaXx52FM8pgsiVQ1UmP9WPPXInl4
         jcFdNP3pV6Sy8/MWJSBQznMMUk2WpiA6buMg5+kTgRiFyqLH4czVn1eRdS2bkCY2mTr6
         ZaGou8XAC6o/xiAWnOYIuu834v6yWbLdSyHLnT9HkgSOHRkyKnh5Dgw0qIoiOy+l1KcL
         4q/xI2oSc4D8+2WeJw80J9LN+UNTWmAV+AuQ4ZZqKBuliHIn4uheXP5N+aKaMPNHsgug
         qeoQMoQUG3Yrgkbui+H3sbcBw3KirpVZZJ4zccbXeh+PJhEI1n/1yz9qyxmxThGChJN+
         d2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969557; x=1752574357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmX1zBN33lB4gzLUkNPqUBTAn0Dd9jMDbw1KtlNeu0A=;
        b=U3wafoyMlEmGwyaSsvVDJaaqHJXXi8bYu0xEnP6Zo2UugUWzJnzav3PFdAQcAEhzXa
         VZ6BObhsVIz4LKuFVQlKGxsV+Bhr35p8820Rt0uppLs8Nfdp9P4UrV2K2yOVm7R2sn/h
         8ukbTCK74K9g+N1HU9PFnOJF2QR6KHLbiYQEd7OSaspaVfLtPYvpJOZ9jGuTnZsLdPbG
         lFbnpz1QfZhfWc5BizwDR22KLgSMQJBwa4re9QKDQCn8MjQrkM217in7huAC5V+IF9F/
         0tVABFwTv9PGc31a+WC95ZGYs0NuJyIROU4kKCosONR1gDAQe0kxjYjJ2cem6fYM+N1j
         U//w==
X-Forwarded-Encrypted: i=1; AJvYcCWwtdcAq1Av+gEj8cTtqN4XmYlJSLGlAT1/vPwWlc+GwbIJhT7U6o+b/fckhSxXp3qsLvOHvWdbaqNVN5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWI1nTxFxbh+U8pF58U5lAUihv5CmPOc+4zxJut7UisoTmRCV
	/jWa/Avh5RC+MI2WgHjusLF9Jnn+DZ8ZYCOxMpSfeFy8bpcF8M9F5MeUmCgHnby9dlKve69psyG
	tscf5rFESD906L/3QZ97b2D8cI9Dw/4YiYEpBhpHYKBEmKhYi7/oColhpxy8=
X-Gm-Gg: ASbGncuOFIuT5m5RIDJepyRr/i8rrUg/Re36HJnoLYptgdPOJzkVXPGgxzZg728vPxV
	GEqsHj61bP4RVkRdBB3IRceIib/HhRo/ThpSdRhKBUDvZ4pBsbvfKVf6v1BQ9w5I7SwEyH8RqTN
	z0/fhXlx4WQY8VxgZtLOz68TpvaptnACJycd7OpMT4bMYJw0BloJ28WXXoYE6MSLqaqqk9drm1S
	8NHhYaxvVK5D0mpg+ORJ3Z8wP+rDk2qS2qsopvNnofZaPnU4bjf3ylyVWMjD2xkaGkVBy6urub/
	4IuE4hS4fod89pbG6+f3CWqGRFAylOc8xFs7rdeVx/7/Nx7VLtScT629GSrG+uNVsAkACLThhQo
	U/x6V+w+TrczwaeqpYAvtTg==
X-Google-Smtp-Source: AGHT+IED26y+n9j+5pBqdocpELjkLG6eOq39ZrvJ+qRhatVN4TQ5wRzgtBzDH16tDXGPwRZX5wMJRA==
X-Received: by 2002:a05:6000:310a:b0:3a6:d30e:6fd3 with SMTP id ffacd0b85a97d-3b4965ffca6mr4118923f8f.10.1751969556510;
        Tue, 08 Jul 2025 03:12:36 -0700 (PDT)
Received: from steffen-linux.. (p57b79c3d.dip0.t-ipconnect.de. [87.183.156.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a2e8sm12558121f8f.75.2025.07.08.03.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:12:35 -0700 (PDT)
From: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>
To: 
Cc: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	stable@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvmem: imx-ocotp: fix MAC address byte length
Date: Tue,  8 Jul 2025 12:12:00 +0200
Message-ID: <20250708101206.70793-1-steffen@innosonix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The commit "13bcd440f2ff nvmem: core: verify cell's raw_len" caused an
extension of the "mac-address" cell from 6 to 8 bytes due to word_size
of 4 bytes. This led to a required byte swap of the full buffer length,
which caused truncation of the mac-address when read.

Previously, the mac-address was incorrectly truncated from=20
70:B3:D5:14:E9:0E to 00:00:70:B3:D5:14.

Fix the issue by swapping only the first 6 bytes to correctly pass the
mac-address to the upper layers.

Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
v4:
- Adopted the commit message wording recommended by=20
Frank.li@nxp.com to improve clarity.
- Simplified byte count determination by using min() instead of an=20
explicit conditional statement.
- Kept the Tested-by tag from the previous patch as the change=20
remains trivial but tested.
v3:
- replace magic number 6 with ETH_ALEN
- Fix misleading indentation and properly group 'mac-address' statements
v2:
- Add Cc: stable@vger.kernel.org as requested by Greg KH's patch bot
 drivers/nvmem/imx-ocotp-ele.c | 5 ++++-
 drivers/nvmem/imx-ocotp.c     | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index ca6dd71d8a2e..7807ec0e2d18 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
=20
 enum fuse_type {
 	FUSE_FSB =3D BIT(0),
@@ -118,9 +119,11 @@ static int imx_ocotp_cell_pp(void *context, const char=
 *id, int index,
 	int i;
=20
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		bytes =3D min(bytes, ETH_ALEN);
 		for (i =3D 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
=20
 	return 0;
 }
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 79dd4fda0329..7bf7656d4f96 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
=20
 #define IMX_OCOTP_OFFSET_B0W0		0x400 /* Offset from base address of the
 					       * OTP Bank0 Word0
@@ -227,9 +228,11 @@ static int imx_ocotp_cell_pp(void *context, const char=
 *id, int index,
 	int i;
=20
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		bytes =3D min(bytes, ETH_ALEN);
 		for (i =3D 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
=20
 	return 0;
 }
--=20
2.43.0


--=20


*innosonix GmbH*
Hauptstr. 35
96482 Ahorn
central: +49 9561 7459980
www.innosonix.de <http://www.innosonix.de>

innosonix GmbH
Gesch=C3=A4ftsf=C3=BChrer:=20
Markus B=C3=A4tz, Steffen B=C3=A4tz
USt.-IdNr / VAT-Nr.: DE266020313
EORI-Nr.:=20
DE240121536680271
HRB 5192 Coburg
WEEE-Reg.-Nr. DE88021242

