Return-Path: <linux-kernel+bounces-744111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05C9B10821
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BAF5A2528
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36226A0AD;
	Thu, 24 Jul 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bsw1aepv"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B89267B9B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354252; cv=none; b=dmNHwymzAdXvP0mEi+hvKSgR7+i1yeoV8nd9C+7wo+HA/PsUrfYb/r3xorwMgxVZKSvvdvGNbiifnAXah0py2LSCS79mbOAe6cI9PFDMnWn5/A7oqHVHLL1YE3DhF+1hBqc7IXuiabMoiaPckhMCWQsSqzHuHFc4aeVq+YPHyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354252; c=relaxed/simple;
	bh=/1X+P/6gP4BHYVmBCUEOv2IrTzDWhxfhewmPaKuUbzs=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=VaFRrtkRWAzdFLC26BkdBzVb1pe2DXqfnxqKIwUMA/+Vz9SrPgJKISzY/24dxVgyCltb0dmTH1xk9kQNHohnSOJht8cc/YTl0vhUe8L1VIQ9ziYbsqiGx4omdM1X7wFexakxMIhREdJ+B1H533VciTq1LyK6CQpelvJMjl2nHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bsw1aepv; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753354244; bh=RcdXqW0Mg+KqFkD0C57qkWF/2nYk05qS92jUMLwn2ig=;
	h=From:Date:Subject:To:Cc;
	b=bsw1aepvLtuc4lOQrjbRHQlmmk2Klw0y+KhrTxgP+fckAc9DvKvEkpAUDWO/ZSAOD
	 SARI9PKjWLVSFb8jsnT3CxOgDMrr+an3J8+DgCRu0JlGomRZFQPb5Egv7J/l0IsCvf
	 tUP/ulOzgaD+bBlBlu9AMsNn6kOlWKGqrvYKuApY=
Received: from [127.0.1.1] ([112.48.13.20])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 959B64BC; Thu, 24 Jul 2025 18:37:25 +0800
X-QQ-mid: xmsmtpt1753353445tw253cgsg
Message-ID: <tencent_5782606120514CBCC9339FD79EBC411FB607@qq.com>
X-QQ-XMAILINFO: Mi9y8J8807RSTdiXgXV1GdBTD+M2t4+BkvWPIwWhVn0b/V+weqlvdG7F+Mx73G
	 I3MyPJwQ1A5yat0LLfqXyPD2zTr+7meZq0XYPKPZSqbjx1MNh6tagIDh8sWC8GAf93SodORhysKP
	 UOEjI22sf3FClWu2Pu2VC8ps4nhnCha7D2dMzxlXKGO8etqVSIv5OcTzcwB3MKHmwW5AfiDlvCBs
	 gjaEPb/W29AEIR+5sDgIpQTSiy3dNfgIxojKkrui1yyOh9jB8hQfJtLpMweEauXO1g2M/ODtOhOK
	 ezEFyIHexLNsqA6Tpwbn61aSFcKjvxqlROStu2XwvFJrM7jzCC9iCwazhPbUsG+r7PZrjXl0VGo/
	 yAtgkghovJ28uCPGQ7E7Bquj7/vdlOK7ZFA2knJKjQEPR/PJXhcDoTd+QKUWm6KbY3X5m4a19T/n
	 Fhg/6vTwSpmLuARyttcX/BZTDNBxDzNKiApqZX1UzWbFdMo5okVDZn69RF6pRP6jR4hmWiCK3Egz
	 PxcBDbXg7hZi35Ecwct05ZWV3V9Dnv+j9c5Oa026FaL+6dx9USUCPfIayInlR8bNSw2AE1gkqUKX
	 JVN3k4Oa2Z7LsiFOvfDBAo9sxmr2tS9xyQ0wsaMGqTpeLWIoWsbuF2w/9XZc2j3youQXV8DPCojN
	 B8ZLiqr4KpEKkg4fkUTfY3bw4hFR4UNaUrZbuHj2B+vKafm/4w64CJzhhB/VlnEk3SNsAP0xyneb
	 mIpQp1wyARnroP/ri4X7tXpa2gAM74fnT3hNV15Dc8I0BAbe0odcsLwLnrOUrnFE5eYP/dldzm1j
	 eBDjb1Kr5nM8xwxyla28VjasnQ3+Cc3RqkVLH0jvV5MFa23vZ1m3hQFomjVzPM62QgElKct0KpDf
	 XpbsrK+VylGH9h+lcNGVSH6PYXaLSvKFkWxmi4onGXm1oepvpJLcETEuD/JRnVR2j6h4/FiPc2dm
	 A9gGG7ul1nfJebksnMZ0GzXdbawPJQ5A1q64RMvKrA1JwH8kV1ou24D/HE5gXGvXnGaFxyuzDZo9
	 aohHrtnw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Liya Huang <1425075683@qq.com>
Date: Thu, 24 Jul 2025 18:37:23 +0800
Subject: [PATCH] drivers/base/faux: Remove unnecessary match callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20250724-faux_match-v1-1-513b64b263c0@qq.com>
X-B4-Tracking: v=1; b=H4sIAOIMgmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNj3bTE0or43MSS5AzdNHOzRDMTUzNLc7NUJaCGgqLUtMwKsGHRsbW
 1AINjBRRcAAAA
X-Change-ID: 20250723-faux_match-f76a6456976e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liya Huang <1425075683@qq.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753353446; l=2010;
 i=1425075683@qq.com; s=20250415; h=from:subject:message-id;
 bh=/1X+P/6gP4BHYVmBCUEOv2IrTzDWhxfhewmPaKuUbzs=;
 b=skeoEOULk0O/wT8veuH1pxQx0HG9J/wRgnp7gr89PAHSjJnrcWoOwnLY8ZwDS7D8Nun4I3vI4
 n+d7zc5Bg4iBokFAHNIScFFs8oSnQjoKsK5d9kXK2uCPO7dyfGRumbX
X-Developer-Key: i=1425075683@qq.com; a=ed25519;
 pk=nSnzeGGcMXBimuyIWYIZpZRN8DboZqwr67IqWALwrGs=

The faux_match() function always returns 1, indicating a successful match.
The driver core function driver_match_device() already handles this case
by defaulting to 1 if the bus->match callback is NULL.

The implementation in driver_match_device() is:
  return drv->bus->match ? drv->bus->match(dev, drv) : 1;

Therefore, the faux_match() callback is redundant and can be removed to
simplify the code, with no change in functionality.

---
drivers/base/faux: Remove unnecessary match callback

The faux_match() function always returns 1, indicating a successful match.
The driver core function driver_match_device() already handles this case
by defaulting to 1 if the bus->match callback is NULL.

The implementation in driver_match_device() is:
  return drv->bus->match ? drv->bus->match(dev, drv) : 1;

Therefore, the faux_match() callback is redundant and can be removed to
simplify the code, with no change in functionality.

Signed-off-by: Liya Huang <1425075683@qq.com>
---
 drivers/base/faux.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index f5fbda0a9a44bd8e4831ee0ef9fc87841146d2da..005e4ecac05aebccb6fcf770f7e62848d9963c88 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -33,12 +33,6 @@ static struct device faux_bus_root = {
 	.init_name	= "faux",
 };
 
-static int faux_match(struct device *dev, const struct device_driver *drv)
-{
-	/* Match always succeeds, we only have one driver */
-	return 1;
-}
-
 static int faux_probe(struct device *dev)
 {
 	struct faux_object *faux_obj = to_faux_object(dev);
@@ -77,7 +71,6 @@ static void faux_remove(struct device *dev)
 
 static const struct bus_type faux_bus_type = {
 	.name		= "faux",
-	.match		= faux_match,
 	.probe		= faux_probe,
 	.remove		= faux_remove,
 };

---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250723-faux_match-f76a6456976e

Best regards,
-- 
Liya Huang <1425075683@qq.com>


