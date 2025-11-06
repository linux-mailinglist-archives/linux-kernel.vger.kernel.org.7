Return-Path: <linux-kernel+bounces-888744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9CC3BCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A166E189542A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E6345749;
	Thu,  6 Nov 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gUOZaJfz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16860334C0C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439623; cv=none; b=pz2GnejErjJ6vOfyo9l4uV4K14frFau9Ia9b8kAGJ6MNzHpZZiatw/Vc7D+i5siHC/HstUX86Kh6beRr/rx5hNkyvM3CQuGa8+pegIHUsGuBYz0QnSahU8CPM0V5jAtYABqvzEn9rERWVPYnRUV3HZz7rVCcSu7IDasWprpk8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439623; c=relaxed/simple;
	bh=FRH8KxX+aaghZgdbZDYvQy3T8pQdGJSOIegb7HwAmPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hnm9yCO7N5IKFdJZ0uuIsmOucOdul5OsFsUUpKnKjpPanqBLjIeE/GfcHsC3uu718h7+x1Hy1d6wueXvvxaB4fEsziQS8PcNwum2ZWZdM4yeuoETU/aId8UeQsGm1nU0CaPXoxoikUZzKchyZjEE/xd1klqe2blWRdiFzQls0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gUOZaJfz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so6200105e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762439619; x=1763044419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuidE0a2dKfVWIKlkxeWcF5Yy+eJEP448+dchNRz5GU=;
        b=gUOZaJfzMW1G1rsA4Br8q4VxKpcf4U5qAepotp81ne8F3gzTK/1VKsiYI9eFwCEysy
         4I6SrCC3ouGKuxQjnmjCVEqhKPWtSQvGBMh2No/xNruYGo1nkOg7VVcXteciMRBMgfwU
         6XmoO86cXOEyQEPXIEs2yjg2ImCxwX4DKY61uDigfOkS2upYIXBtdnSgn+Rz/ika5wNs
         39dMWxUPloizTDGQc1rxv+/4BjURe48GCl/eNRgoYxYFWOdN3iEOBpKbev+ldOK1Ml4v
         2Or8zUOMSmNoLY+8J2x3XQxmKScURFzR7GojwvGka8Q6bVjlkH0v08BG+rmzQqDPWpxc
         fHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439619; x=1763044419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuidE0a2dKfVWIKlkxeWcF5Yy+eJEP448+dchNRz5GU=;
        b=FHiNrYXIwREdTMObbw5mdMTr/oLBaIuHoabgImP+ZcANZZKdr23mvp26qC3XNSho1X
         EYGExGJ+p5tzgcF53NN6qcpbwNTqyrD7nGgf1etKGMPecNE+Y4oba+GIc9ZKX7lsDeJb
         2GidB2djm06RclJJl+B/uCXAJ0WLS48wyaLJttq8cG1vfxV3//+9FetIOCzeetIOZbVg
         sHBoaiIJdJMuy16lndg0PzAnh3l/Hnb6vYGVI2uz2RZgq/A8SeKMHLpeiy8/pvmXkqGC
         vU2T1RlmHaIW8wKrVsx+h02nL8QduNjqNOS7jbPAveBR064Zrj4wuPeySgBzQHZa+zq8
         BWDA==
X-Forwarded-Encrypted: i=1; AJvYcCU5OZXe1zPg4/CQFeNJKn3rKuU5XYhB3DfTfTXLoWL6/i7KSelJry96WjeKMJsJINVxji43TGaGzgsRKoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUcT+56FPrpfa5NM0fKaBp25WoYuhkRvf2M7FsPDEOdozE0cd
	ZwU50ocXW1dldyiFkzsRc9t9Qj5kVbVGP7g/7cC/GRH7fMwPo41uGZyHLshNC2TD22U=
X-Gm-Gg: ASbGncuTZuO2saUx9OY3pR3+MKFkibHcGYfY+xmBuXwzrMhBy5ayo8sDAqRWxP0T3Me
	O0eOFe+t/mP+F0RDy8fOiZnzU4K/MC+/kvY0SH/a2MgH3gfHagVkidbrPzgooFfpUNf5w/1Ww3Y
	lPiGVZ4cJgyTdOyrOlnLT3pEZhHi/iHPGlyiqiXd1AcyVpaNyMIsp1K5WaJapbZz2+ZIgoPOKej
	2BWS5Lsj6QAAz6+1gEeZcDjN72HPKjkGZ4X2kNfx4jhi8JQxegbMIvhEt59nm7INcVxdJ8VPswk
	TfO+Ep+d69hrKs2tZkYfkQMvXfLnsFspYSqLCNLunUsRIeCJJ8gJNahmrFusQjpuAXLltuqzOSZ
	ohOw0Zvh+34CZGy+EJ7x80O2e3xeazZIWKyIAtjIrIMtcid8L8abFHCnx1x9yDONJLCllK6mrUZ
	et1EeuMcVQDf3kKtgaDtx+cb6KFVU4xoTsei8GgSMB
X-Google-Smtp-Source: AGHT+IEGCXOaTbxgHVwN2bpZ3oM5GcbXhrmW5LLT6uPbqG7RyvXMo96EsCuQUlDfDivHug04wVefxg==
X-Received: by 2002:a05:600c:528d:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-4775ce15009mr86631365e9.32.1762439619485;
        Thu, 06 Nov 2025 06:33:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477622661c4sm50001595e9.0.2025.11.06.06.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:33:38 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/2] reset: rzg2l-usbphy-ctrl: Add suspend to RAM support
Date: Thu,  6 Nov 2025 16:33:25 +0200
Message-ID: <20251106143327.3049052-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds suspend to RAM support to the rzg2l-usbphy-ctrl driver.
Patch 1/2 is a preparatory change to avoid suppressing any
configuration errors.

Thank you,
Claudiu

Claudiu Beznea (2):
  reset: rzg2l-usbphy-ctrl: Propagate the return value of
    regmap_field_update_bits()
  reset: rzg2l-usbphy-ctrl: Add suspend/resume support

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 105 +++++++++++++++++++-----
 1 file changed, 86 insertions(+), 19 deletions(-)

-- 
2.43.0


