Return-Path: <linux-kernel+bounces-832076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C4B9E480
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B561BC578E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE72EA171;
	Thu, 25 Sep 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGLogjGH"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD072E7BAE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792093; cv=none; b=fyRUn7HJUvO8ZGpTmbYzj43I1RGqNj9MpDa8z7VhOWt/ONsz6oIjIWr8OPrkE2bJKHcy31wyTHo85dAqwUg7Vbwqr3JW1W7RRPllPpwxxxLo30uZ2XWUaCnmXVcaDtruq+a1EqkZzIeDDDFhR8Nj6MhCZgyjPXPafE1g6e38gfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792093; c=relaxed/simple;
	bh=OxgF0sgU8kJelkuDjh/RK/kYTlp1sBcDIk4CfwqFFXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r47ah2OW3uf/yOTVSWGwsD0g1w53dpxQNn5udWLfu+P2oHbEwNGrN0zkEqGoEWqeF/E00wRnHnHxgXfXXEVkXvl+DF00/n0VbJ9TpbXcKmPBn39N7HUL1kHZsallwwdVGDHl7nQYS7wdSVKUYv3ZcTKNMNrEgepA0iq7UQmdPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGLogjGH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-273a0aeed57so22143555ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792091; x=1759396891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i3lJ5UnNUwnZHcBsmIKwojuviTql3djQ9HFxU9mOWY=;
        b=lGLogjGH1Cy5Km7v3oWWZ4ZxugIpN/J9YFfQqRv4dsQnsozURZgzoYeU4kWVEIv/ah
         VCbDRdVBssCUMfB2Kr3zSKMKBUBdkEO/j8wr61YAZZ7xxjcQECZY37yJrpJqwh3jQ78w
         AmO8jKsAVIqXiulzkJlzoXeNvJp4/OHHXAePcwFLB3extJmj6bF94Sn0fUiAHOH9IQZF
         5c4WRTGgyshLt4oQ0pWagmeMWZp69ZtMLXU5QyUOXmufsz3rolPL/RcTXrw5PeAjje74
         ja8u10AvoW7OMZfLhP0wVjaivM9LttJuoWtsABRwCrG1jvFJepZ0fRB9pJRS/JTLU529
         bYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792091; x=1759396891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i3lJ5UnNUwnZHcBsmIKwojuviTql3djQ9HFxU9mOWY=;
        b=D/umy6gdsWUKQaUyUGU4EOUIFpjoWtoKfbdMlfwvwaztkizG0MRxAP7UThP+Dk0kkD
         T71g/9hXbPsDy2JZx3Q7tKj8YpnLD8tS6KWtkZp1gft9LBL7nL3M3jkj3Xk5aPBUSU6h
         Pi4kQX+C/LH7738wwSGo4MQiGhhI34g2WcR4vh85ZTVLlrvJ3eV8rGyPekOVuSOkyZoi
         z9kzWSwrRG/QpEZDTyd4x85qdtz6B63wiGvwk6BoEDMove94DqzXpktrOUUd3GaC38+j
         SqPxm1XweWIn2A0SzQL9TD0VnQyvl2bvpnTl6qqkbICa3TV6yiRUc2p01zJrw7DvrdgY
         tT8A==
X-Forwarded-Encrypted: i=1; AJvYcCVr7ezQJy6ZYjEtix1RsK76NLaVFlYZuEou2toV33vInaeSUCyIJK2Z+n4u0ToHUEUhyPEj/O6RfGLoC3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpCfAM/hUN2GPBw9DxPKTSVCFH5SDU0BB+RFPaakmYADglfoD
	mizqCYRbLUxVPJ9rG590muP0kIe+Zduo51ae7qR9uw2t93Bb5w8kN5u+
X-Gm-Gg: ASbGncsLhpnf8K7zROWksJhXU4OVR7Ar8dUVdQyFeiK5XmyM8u/shrsG3j9E1GrfBBq
	wsZQqqN86seK62NwSGaWPu7/UPJe11ZmGnotdh/J5Ez95br6EZMBKM8k3UiFbyE6mp/a98B5vQg
	lhGCzVIqxMUerR5mQkcTHXEJWWipsEBnqfHOaMiuhxqisH++OcyjyfYtQJReFN16WiTR8GtTCqO
	n5L1MUgznjGoF9ThnAG7MqE+RTZiE8tG/SBOWpOJi1Z2CRE1yobS4xTqmDQrWixw962I/O1Gb8T
	WtoKeKI736E2I9vByy9U/jxb7JasJiYjnOorA3TmIQjgNfpE1sBuJqQSGCpJH09FmXOSfZmh0pM
	n3TiDEuOPndwdNBR9aST9ivrpIFxuMP+tc5Bqgu1C/w==
X-Google-Smtp-Source: AGHT+IG+5cSlAA4yEB0iWJUxUwgl6Whpi0RXiGF7IG4Oc+3ZX5YIYSMwXvdgEh0mLgMwoqgR9eg6bg==
X-Received: by 2002:a17:903:166e:b0:26a:6d5a:944e with SMTP id d9443c01a7336-27ed71070b4mr24813685ad.24.1758792091135;
        Thu, 25 Sep 2025 02:21:31 -0700 (PDT)
Received: from localhost.localdomain ([120.229.16.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm18251855ad.30.2025.09.25.02.21.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 02:21:30 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Date: Thu, 25 Sep 2025 17:20:36 +0800
Message-ID: <20250925092037.13582-3-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925092037.13582-1-jjm2473@gmail.com>
References: <20250925092037.13582-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 is a high-performance mini router based on RK3568.

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..ec2271cfb7e1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -726,6 +726,11 @@ properties:
           - const: lckfb,tspi-rk3566
           - const: rockchip,rk3566
 
+      - description: LinkEase EasePi R1
+        items:
+          - const: linkease,easepi-r1
+          - const: rockchip,rk3568
+
       - description: Luckfox Core3576 Module based boards
         items:
           - enum:
-- 
2.51.0


