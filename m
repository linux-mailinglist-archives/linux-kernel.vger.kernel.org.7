Return-Path: <linux-kernel+bounces-819100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFFDB59B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37AE1BC7DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C3350D4F;
	Tue, 16 Sep 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixts7/yQ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F434A32A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034986; cv=none; b=BlmJ7ajX/QJcytzMcWlIwBSgQItAl/bH6faDLuCurZCU5/3n2sl09baRVw6gvxDz/oFW6A/JtaswjBO+mQVM/gXRZ5ata1PgvXV47mUn3U7T2VDWxQxM3WY5PaqXf9oVZ5qQJ3JlKXQL+x/pZ731Gnp54Ki4KwGxk15tCDAEz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034986; c=relaxed/simple;
	bh=A/pVmo2VMMUD2z+HUZj4DpziB5TxDDr6gmH3385sgqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfh3H/iBDIsyTA1e6JuuicWTtGjTKExN2v2ArIZynf5TqCetu6bLN31C9jSvmRCg7Qn5OytPpEiozXsNd0oJgsyr47vMkIYqZ42Mv4JPIUFzkEiPSiaf5xt1fWvqUDexTaA0ozFRtK8z3B6+IZDCQECyXRyH3wV79IzkY2Z7uTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixts7/yQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ea115556b2so1702941f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034982; x=1758639782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/k7vhUf1voL8kqIJSX9PkvL+7B3TmZ2+++u1y1uP1Q=;
        b=Ixts7/yQY5gf8B9y9C6Zf6BHoYLLlWuB48hHKmNVehxpj7geI3FWHqvNJyz0A26UWY
         FbvXxvYsISIGLgIPexfICQ4NvzMJbo1Xa/j7ij76W4wDFKWWzhIowhNxiarVvfTT5Ml9
         GKh5pJgDIwFN8B7UFAI4u48lLApSKl76YQBkI+DuChCLTMkVWm1yOOR4AaCHYWnjBbXW
         WuPjyJ8DJyfrkBZDo/Si8yt8A570eQK1hjlBnXblDLEuyggkhCR7ajeltN6p9Pb6r1Xo
         zAN5NTaJX7VV/L2TQaIOE6SbsNy5Vth2MWzYhp69SfifXzv6W3cZ4cHxp3Za5fhHWGhw
         SeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034982; x=1758639782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/k7vhUf1voL8kqIJSX9PkvL+7B3TmZ2+++u1y1uP1Q=;
        b=bZqkCMzNpBJTC19J+H2VjdIibS0z7N5vLk+0ad0ri7mBCinXjGylr3GaQmDm9kQWMV
         XmKSKa3BmnEfKTHQP6DnJ7QyxjO3wkU0pdWBL9rwFAECDbwMp7cJoHTIfEapN3fZzdx5
         9KbfqqRxvOih+sjlnhHjk48iX6XAONGmwK44OHQvWF7Zr7uoG0qammqZ9y7LZk1q17CP
         jqNwy7Ue05YU3Xoid3lzWEXlQUVN70dKaFy1SCAXM+nue3sF53+50Kn4XH1hWdAr2sNS
         5s9IBbAYJNSM2Li8+vYa7yHGRxVNN1VkuBUP1z9AqJ6TcO+GsV++FZ4w/7xzHdZghYdU
         id9g==
X-Forwarded-Encrypted: i=1; AJvYcCWhh9kftW9BrSYbbL5XGS+KSJBppeK3EJ91kBs1cUmfTnbFHtMqvKO3Uf7ZZNk8nqlauq2U3jR+GoBjyXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdnkUPD0Yt164gtuQGmh/Nz/9VBPvbDSbXSZQnIgaal1GPQIFy
	KpaCuOyLw2VJ2YcXjN0tCNOKR6+RUeSGootXnNs7Lc35HATnBbgbR6EN
X-Gm-Gg: ASbGncsJbGYZq3tRnrppBwQLzqEjriJtFODaHjHnLXUZzwGMLEUdt4UZUqRh6uOy7pJ
	b4BC/9PlnTmZV8wTGb/n6I9jqP7avadGXRUpNevlTp8R83OU4pSZGJh5vyPd+00g6KWEcu6i0gD
	RzAi065JUu1Vr9OadSu88fK2rraZdpRhSQs7zcK/4loudhH3PfFQaB6TGgIZUeJoRJocJ76rB4i
	dL+tnqM2taKVUm9aU5bSoV9+g/y7kkZ1tRa+Ofn7wagI7ABV6mZI67fHxGNyK8vXHVCuXt1Sdhl
	NdlshCmvr4vUIdNHW6SUCo69NlrEk0JFqhQBzb/cRGEHPnjBL+AcLt9diuwSWI7hOWDi3tWJ6M+
	UlEwMviLpBrHnWakg1vA9k/Y0JLo/gbZDMFljIHmAkfjGWKje9QVsqcq6y09HZYLN+ENskqLVxj
	p6hQ==
X-Google-Smtp-Source: AGHT+IGrfbQPvbjSEiLxQt7eaONhgRJwkDjXjoj1pqSn2g2OiHYXCnZlBuCibXYoLvrggR6sX6Hh/g==
X-Received: by 2002:a05:6000:2903:b0:3e0:152a:87b4 with SMTP id ffacd0b85a97d-3e7659db0ecmr14198255f8f.35.1758034982264;
        Tue, 16 Sep 2025 08:03:02 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc2deb20sm932154f8f.47.2025.09.16.08.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:03:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 5/9] usb: host: xhci-plat: Add .post_resume_quirk for struct xhci_plat_priv
Date: Tue, 16 Sep 2025 16:02:41 +0100
Message-ID: <20250916150255.4231-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916150255.4231-1-biju.das.jz@bp.renesas.com>
References: <20250916150255.4231-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Some SoCs (eg Renesas RZ/G3E SoC) have special sequence after
xhci_resume, add .post_resume_quick for it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/usb/host/xhci-plat.c | 14 ++++++++++++++
 drivers/usb/host/xhci-plat.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3a56d8f94519..9e58431f486b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -75,6 +75,16 @@ static int xhci_priv_resume_quirk(struct usb_hcd *hcd)
 	return priv->resume_quirk(hcd);
 }
 
+static int xhci_priv_post_resume_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->post_resume_quirk)
+		return 0;
+
+	return priv->post_resume_quirk(hcd);
+}
+
 static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
 	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
@@ -529,6 +539,10 @@ static int xhci_plat_resume_common(struct device *dev, bool power_lost)
 	if (ret)
 		goto disable_clks;
 
+	ret = xhci_priv_post_resume_quirk(hcd);
+	if (ret)
+		goto disable_clks;
+
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 2b32a93d2b76..00751d851831 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -21,6 +21,7 @@ struct xhci_plat_priv {
 	int (*init_quirk)(struct usb_hcd *);
 	int (*suspend_quirk)(struct usb_hcd *);
 	int (*resume_quirk)(struct usb_hcd *);
+	int (*post_resume_quirk)(struct usb_hcd *);
 };
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
-- 
2.43.0


