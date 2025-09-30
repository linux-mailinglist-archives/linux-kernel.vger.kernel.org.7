Return-Path: <linux-kernel+bounces-837978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA74BAE29F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FC17AEB66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438218A93F;
	Tue, 30 Sep 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="ihRNpUpc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="B2EcvA9P"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADD26B0AE;
	Tue, 30 Sep 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252960; cv=pass; b=fhChHTN30SyTJlk9HFJxKusS0BoAus9KzSv+v0cR5UizDbAeMUEYW2EOeqYjzgSxT8RO2JSYUz4jCEPLo1Iz5eyMVPkbrUa/3L6GqMRndK3qlEH3H/vrJnCAjJaSdFxnJ8FSQYVLRetlDthVX+e084ZwLr/GWg6nAY/HtnZSq6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252960; c=relaxed/simple;
	bh=JZtxUhAQUCH5tT2nzBPh/tiK8TwzH93xTaxCq93C8jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jIrTnA+a15OQDtCNVy+WEqvRgJYJZOgR2wP+a1QI23nUieArNcVlsM+kMNjFo3yh4kZap1VLIqUuzRKBvopwBS+gqQjxtI1QnH290/zHAT31FzOmW8stFZBtOyXDXk6WP2CL1FpNrsPNguYolVPPt5jwHrGzbo9IZUrJCLnLO/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=ihRNpUpc; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=B2EcvA9P; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com; s=arckey; t=1759252958;
	 b=Tdb55HlygttdWNIlW3rfVLwP5d4QYaFuUEH+IFWjn0upGbmfI41HRBShOSf4ItEOBIR9Q99DuS
	  hI7gRgo/sOgCX6tJhvFOFciMGbV10XpyKkDXpzzQYBbmdVohUZG7AZA6eOTy2sX9dpeXUd+gD+
	  nHh7ql2EbDQrlsVV92cZYdQ9nFes1+ZMhd/kC8AtEoV//ArDzoL8Qw2W+C62wE2Svo7VuIxq6/
	  xNzH+hMmM6y0H308Bx3By5OVAMcAiacmX3BymFBoBFQGM6+DILlcpSVto4wdeuMfSxAUUQoaFa
	  D/Zfj3Vnik7pkBn4BumP0eIK2VrlzXDr74UreRQw9gMerQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com; s=arckey; t=1759252958;
	bh=JZtxUhAQUCH5tT2nzBPh/tiK8TwzH93xTaxCq93C8jc=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=T02/uULH4c7eCiWiy/qcx2ENygzAcrxRtirOKlOGL5bUYevSUZLDv5pegdUchzTBKP7Z61LeSl
	  2zkgibN62Gh3YIGWkNPyU1PxG7Y5Mk0/gOoGB5Swgxp7oWi1ClsO+Z8s8OD5/DXHIcOn8d+tIb
	  tsB8ZVPg+CgoJwNFNxLUWW2dzbHtTbkvDBc5B3d3rkhv/tXSz8bbPTpf9rrEzdYL456KNIbvpI
	  xnGJZ+6QXXnayp8b1nF50tHQw48eyuhpwKQlryuVroizTXwp/1g/c3NGJn8gBharDZlTIWiYM4
	  mVvJVBtPa0QjiD/TAhF/qfnIb4NnQNNKZ6DPt7eV1oo5Xg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=tANQVUbOx22qxWTY4yrEi3DRCxNNuIzZh38xy2R6dUM=; b=ihRNpUpcz9HLWIm1NQokudK9rg
	XKXMr0KjYpTmfpUYDtC2J/297PYjCYUwkqGuItnVdoyX+g6lPCxEnfWzLCC+Hn2GSgY3+XP9jwdam
	lnKB7P6L6tD6azrqntEHbFupJz7kikpFfQaU0BQ4z1z5tI5Y217BEh2PnHBZGGxBEQBo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-p705.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v3ckO-0000000AsTu-2K94;
	Tue, 30 Sep 2025 15:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=tANQVUbOx22qxWTY4yrEi3DRCxNNuIzZh38xy2R6dUM=; b=B2EcvA9P0Mw5Q6QaXuOIGAvAkt
	Hp/rIPaLUEsq+GppnGHXj7TwWy/XdJURulYrGIWi+XzP1mpuiuJcErBJ8GFU+DyhPgL2Te3gnTlil
	H7ZXIVcsqo+bGqEr5rZ/0h50t5RQsFJxYicnmUm790pY3Vb8vJhYDHI9PZAuohHTa9fk=;
Received: from [87.16.13.60] (port=62166 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v3ckG-000000000VX-1Di3;
	Tue, 30 Sep 2025 15:58:28 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 30 Sep 2025 17:58:17 +0200
Subject: [PATCH v2] of: property: fw_devlink: Add support for "mmc-pwrseq"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@valla.it>
X-B4-Tracking: v=1; b=H4sIABj+22gC/23MSw7CIBSF4a00dywGaCulI/dhGkPoxd6kL6FBT
 cPexY4d/ic53w4BPWGAttjBY6RAy5xDngqwg5kfyKjPDZLLmuuSs2my9/XlAz6ZrBRvtLG6bkr
 Ih9Wjo/eB3brcA4Vt8Z/DjuK3/mWiYIIp10t1qVxtrLhGM47mTBt0KaUvJu1pSqMAAAA=
X-Change-ID: 20250930-mmc_pwrseq-247089ac9583
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: f0f180143d3c8da286562b5a3ac18f3a
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v3ckO-0000000AsTu-2K94-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add support for parsing MMC power sequencing (pwrseq) binding so that
fw_devlink can enforce the dependency.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250930-mmc_pwrseq-v1-1-7fd2764f5ac1@valla.it
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index c1feb631e3831d7d5ec23c606af31731bfc2f8b8..fcf10c4f02dcf879e1f25e4fa97b25152d58bacb 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1377,6 +1377,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller-cells")
 DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
+DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1524,6 +1525,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_msi_parent, },
 	{ .parse_prop = parse_pses, },
 	{ .parse_prop = parse_power_supplies, },
+	{ .parse_prop = parse_mmc_pwrseq, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_interrupt_map, },

---
base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
change-id: 20250930-mmc_pwrseq-247089ac9583

Best regards,
-- 
Francesco Valla <francesco@valla.it>


