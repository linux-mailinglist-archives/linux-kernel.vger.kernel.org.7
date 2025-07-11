Return-Path: <linux-kernel+bounces-726839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB93AB011D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F10154581D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC53B29E;
	Fri, 11 Jul 2025 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AerXqv/x"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC92AD04;
	Fri, 11 Jul 2025 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206322; cv=none; b=p2x9B19WxICkRM5S4XkA60rXcrso94pil6fLpr1Zk2FtHVcD04QmID7uoa22fUQzbac6QfdTW3j7O1dNg7zCUYKLjxdmqelRZmyBRpwhDYRe1SU1Si3j64Utxk41hbCIKnbAkOUvy5dNQZ3jhg5acBSnfN7NnvLG62g8MFwrorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206322; c=relaxed/simple;
	bh=A+QzmpPP3U4NIbtnvFrbCu23PANHOG16S/Q/jyjnRWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrH4JILvY6Vn6IE70mhYD9wu3upSuinSP6+O1V8Iq2S+ZR3tkRt9B0brl3YK5jViwfSfOvviBB8ycKEBY4cP2aBrO6Uip36LWakO+tzU8L3TDqMOPcb0MwBFSVmAA9QFU2IhQ+PnLB08tO/ICNrCOdJI6AFv2Dov9rpONlo9gm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AerXqv/x; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-558facbc19cso1386019e87.3;
        Thu, 10 Jul 2025 20:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752206318; x=1752811118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAyGyV/ROok4pI9Bzo4icqARtJ1bPtyu3l7jtXPJYx0=;
        b=AerXqv/xcHBOtbIcAi64yzQE3h0ST6sm1e6NCSSVQCox5x/kpZQ2CMp1H1Tki37tGe
         KswY8xsrhtphPnUIDYkSBUIZxnlGvvetLNBFGTh2B9bCtkZZp+TYbXKC1t4iZQc2Haoq
         PxBVv2RrBRbHl3kWtf8Z/mfY2xGDxncRB2n/hnH1T+/p0VqiQWeQswTVurko67ODoSLR
         dkkkDunduPZBYJV/gDc+GnjP1grfbvwavR5CXf5xOTYO0yhWoxw8xTxZbXO1orD9FSEn
         vxnMxUTnqZmxiLnElR1m+IU10VseWeSexKbG1Jv8mQ935eI/p+uahuR01UPzWzBakeW0
         c+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206318; x=1752811118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAyGyV/ROok4pI9Bzo4icqARtJ1bPtyu3l7jtXPJYx0=;
        b=Odc5t/PvXyKJe8Ra6rPzZ1Do289XnYs/HtjaytNAkQST270JxUrzr9Lg5BkLI7D/z9
         f1ygf+up+p+arber+Lv60WBHTlxDtPGbWvxOPi8a+LE+dXZMNH9+GCn5Pgib0B7Jx4G2
         nKAJ0KuFcIapvalhir40LzKTE7h8GA6qGm8ZYcaFIiOjDbpNF1ingS1CJZ//i0hA02t9
         LuU2r2tSBCunkKKnOFbheGTeReDIDimneb5BJHAnRkFS79RjdmJZOBLViotMJ5wMekUU
         giuIIZymtzogbU0eTsDlWMfOFhG0lsB0LXNPYTTx0DwRpmX+HB012viClHP4N0qXZRSX
         eicA==
X-Forwarded-Encrypted: i=1; AJvYcCVV2AeUCdXBw+QfcZmD1HRMw3ua6hjhpNfX2491ctjn82oJkTa0QR7EmV4Itv+U9T/v5xKWzGfOGno7RbxB@vger.kernel.org, AJvYcCXVhrJYXjKwdkAtamiaiPxy7rVpl15LDG1aNP+c8Xx/xxnhVyAk8Y0K2pnyNGH8+IUw7cxngh/TDzVD@vger.kernel.org
X-Gm-Message-State: AOJu0YzkrgKA1BtNI895Gs2NEC91XOamXK9Aakk3RTp+tl6vaiVBByVY
	VfN+rZb06FtnaEeGki5j7cUzux5mrO0XVuYCjLZ3x0BLXOkP4f2u6Iac
X-Gm-Gg: ASbGncu+n1SPoGADXwCkZID4gfL3Wz5M6XSLFmtZM10ieqxzt7BPiv0Bm3Lc41gkk2p
	YrnZfvMoPTW4x47HuXIw5hnJf11S9osmME3gxiHtf2KwHdzWSkHLmf63J59sMPDRsQ0Ix1ifqng
	xOHgPq409pDx1zf+oM2eeY3aO9n3isj2ww+mErspNJHVP1eumr/KjV+3/ztTerSzb7Hlz9yocc+
	PfTyJqD19IAf3GDAepyV4QRl+Oupq6xs/hNTxobri4Kd/Eml0dRZiTG1lFQZGWdJfW33FtqN6eb
	TC0Vs5TOtWKjw81CwIY9alQXddfFyjmhYXsLBZyu6Y3Oge7RHAMFmg5MnzTwjobmUKZV/tStpxl
	Aubuxcbx1+WI=
X-Google-Smtp-Source: AGHT+IFtt4gy09VuR+9hOE1KziZmPtb3mGCWJrKa92kTcM9xUQYQNVoHoopk6977gNAOL2psPZEM7g==
X-Received: by 2002:a2e:a594:0:b0:32b:7284:7b with SMTP id 38308e7fff4ca-3305329b33emr5078191fa.6.1752206318153;
        Thu, 10 Jul 2025 20:58:38 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa2943d46sm4971191fa.40.2025.07.10.20.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:58:37 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.or>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/3] dt-bindings: gpu: mali-bifrost: Add Allwinner A523 compatible
Date: Fri, 11 Jul 2025 11:57:27 +0800
Message-ID: <20250711035730.17507-2-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711035730.17507-1-iuncuim@gmail.com>
References: <20250711035730.17507-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Add a compatible for the Allwinner A523 SoC, with an integrated
ARM Mali G57 MC1 (Valhall-JM) GPU.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index b8d659d27..aa19f8819 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -40,6 +40,7 @@ properties:
           - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
       - items:
           - enum:
+              - allwinner,sun55i-a523-mali
               - mediatek,mt8188-mali
               - mediatek,mt8192-mali
           - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
-- 
2.50.0


