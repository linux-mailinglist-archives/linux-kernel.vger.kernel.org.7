Return-Path: <linux-kernel+bounces-830203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494DCB990BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49587A5997
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22832D663B;
	Wed, 24 Sep 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T1Zr4meC"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09352D592A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705049; cv=none; b=dvNAnQtAj6XPiQrV6vq2pN+BciHxmK7ynkEUxrp0sAzYzmONsYcKkXE78c0iOhblReoIJaLaoCO8EjUiqDig/ZMpIAsTRzr2hkKPJOVxYATe9JjKiJJgdxS62MfE8q+JtsIF/ki4rZ+h7v3KZu9NsACRN2jyzfsbddoBIwpPqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705049; c=relaxed/simple;
	bh=IDbvaU3Lm/9yddinO83XZDCblAQ+mOFRlIV4M9xf/o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEWaw0RkcBh5O+0E9QpO5OozbCU+DV2vWKhjNi9xzoIPxiqqzORvavA79NXizpessPuQjmUiRQhYaB97PSscrIrsdKFpAFOT3AttlxoIU2+ooaQv85PoRsi7L+cz+q7C+/EeH9xmmr2tF04+pwWW408xoYnH5QdIX7DV9iwbfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T1Zr4meC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f44000626bso2785836f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758705044; x=1759309844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa5ZKREGG6CwQzuOzEGbODKbeGIenSkztlFKN5OSwHQ=;
        b=T1Zr4meCmUIWtXCKwUnoEMSdksvvG7+gIkAB+z7eiRcRj1FtqKCRKsPiutimrC5f9O
         XI4TOWt2W35+uzpKDNbi4PSIIX2UTLnqvlkeYgNAajUBVbSgpk4+Yr8fGNpCyE9GfRCw
         UAhFq6idmeWAPzkt1XxGHFLclyp5vRg8s74RwNVScrba7Nh3RlJV1SUG0YcysL+fryMX
         L6IxaMZHW9/m0vH2sdoEHbkoAdOq8LsP9xL9gdu5si82kwrKbDtAkm5HsEKE28+m73Ox
         E4mkBANAHVCwHlmkRMy866Tp3Rvs97hrwaIbXMQ3yK9GBCNgje2+UV4liZxwV8BnAWVi
         /pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705044; x=1759309844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aa5ZKREGG6CwQzuOzEGbODKbeGIenSkztlFKN5OSwHQ=;
        b=hJNzkR1EIBQWFRQRAbEISRMZcyxNUTQVdxHW/UO+5isnRtzdONINYS4qKZvujpprKQ
         XWwrHm4/YyNwb8P8pYJ7No2YqcS6reu1L86MTWCLjJLpfFhL6SdyceeIJAo+yR48mDY/
         601y6wRYiAtnWAeknSskzdcYmSh3Bkea3eQXQ4z/5KggkiItFwb4i3e8vi5kQiCl07Ea
         MctakIfIyfen2zKcLOZZHxL4TYoY4r+Ce0FPVkcpiOKSQVmiIFraMaWRGkywZo5PSg3o
         BzC0dD8d6d8lOEEXhgGxv4BeUc2KOlEWHStderxzPJGy4PWJqHmarNRe7OV97wtg+6eO
         YBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV57AAbhoNMiJNL9u6hsNQAGfsI9StOOWD44fRguZSDuSa0bhzUT98v1j4rdbgqCdRaMTKUSFcKe6DXsB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSn+mzdKWBR3mSue/XE5Dn/YrP+ABTkoGgxOxiDBdIO4WD/Pho
	PgJwZB1JmBDDEQLVsKhEsE3g3UQt3tsnIwcCW5xJco+dbYtWg9CE5ChKVW/3n4GHlGk=
X-Gm-Gg: ASbGncuvwQC4+HbrZHDp2YhXOxV/6/2gK311NkIA0ZWSpEAU0kYvIcKbvN4PR5Vvk5z
	tRT08V6mNmVSYxIZ9EGI5+yhT1AOWeeYTFw83sOfFReYq4e/rc1Gwda2DGXTbgCH72rAJ66duga
	l7H/GB4ZN3KoROY94bF7snMPxSZP2nSJW3kQJzWuqHhbM/2WBuy53esFt6dO5eDU6U4Qd5sUxAU
	4Hy4kDQcf7L005O6nfUSH7fXJJ98z1mlkUxmB9mbnOd0Mi9rs4oaosSKdTMc4AzDFpYFKlCcA+E
	PvGoLPJOEIhMob0FkocudEmDE5hFsYMpagkdS7dj25rSk2y/mXHdqIyLrysZ7qNPLlK0g/01pqX
	Fi1c+hGQDSHxgCGltEqVN3a9Wcc7pqVp22TT5oRlTLiYi6ZolFCDA
X-Google-Smtp-Source: AGHT+IHT5ieSdEF6kMAGMnbj819PLp8ZpjWuyT4jcx1ODntvKEwJ0BGe/A+E1aTr+SU1aX987uvojw==
X-Received: by 2002:a05:6000:3101:b0:3e7:4893:f9be with SMTP id ffacd0b85a97d-405c3c3e191mr4075455f8f.12.1758705043344;
        Wed, 24 Sep 2025 02:10:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07408258sm27435671f8f.19.2025.09.24.02.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:10:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] usb: core: Drop spaces after function names
Date: Wed, 24 Sep 2025 12:10:36 +0300
Message-ID: <20250924091036.1319161-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Drop spaces after function name to comply with the coding style.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/usb/core/hcd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 9dd79769cad1..24feb0de1c00 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2696,18 +2696,18 @@ static void hcd_release(struct kref *kref)
 	kfree(hcd);
 }
 
-struct usb_hcd *usb_get_hcd (struct usb_hcd *hcd)
+struct usb_hcd *usb_get_hcd(struct usb_hcd *hcd)
 {
 	if (hcd)
-		kref_get (&hcd->kref);
+		kref_get(&hcd->kref);
 	return hcd;
 }
 EXPORT_SYMBOL_GPL(usb_get_hcd);
 
-void usb_put_hcd (struct usb_hcd *hcd)
+void usb_put_hcd(struct usb_hcd *hcd)
 {
 	if (hcd)
-		kref_put (&hcd->kref, hcd_release);
+		kref_put(&hcd->kref, hcd_release);
 }
 EXPORT_SYMBOL_GPL(usb_put_hcd);
 
-- 
2.43.0


