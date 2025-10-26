Return-Path: <linux-kernel+bounces-870232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E4C0A3CC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A68D3AB42B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B32194137;
	Sun, 26 Oct 2025 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5o0SPve"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543A1547D2
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761460253; cv=none; b=srTDbG7Rw73QijyqQRfEcP4gYhCVSyynBJJNYguR1HHJL7fyBZRI6qW5O8IQGuwdeau9udahPMpti9yh8mfTeq/POYtz10wshHTsgrBiUsAJVbDNbX2rWjm97KMjM6xg6qNIBcpy69qqpI0gz/+H3mUuc4eTCZ7mHxGHqagbEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761460253; c=relaxed/simple;
	bh=B6weJn5yTMgjU51LGFKgA/6LCJOJwRXqJ4YGQQN0U/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGD+dUWN2lT402I9hJGRfVvri9097Cop2a0djw8KhDXS9uxSVYM0ZfykY1aIR/l9fk37KFwoHehKrAlY83jGYXGXYtQawki9bdAKQBEJgoYwA3nWYxHnFi5NAHiCn/mzir2s9Ww7KNxkmRA3oUSd6J3OCnGsz2IlfcnQr3iWNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5o0SPve; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-27ee41e0798so50710475ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761460251; x=1762065051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZBj0vgRHJC6aX96xN8RIRtjeiDt3AOgOJls8yqVpTU=;
        b=E5o0SPveolWQlTKzX+cNashO9kncsb1+p1WLGgrkQh+6D7MalV5+9buL9sshgNm8nM
         EfIz3ANnpi5O4K8TqW9QnJsL4Jkh6PFrZSiPltnOFnqAbH8KthYJ+L4GJ3P4QbNwejbk
         CiFW6Sa5nMVR6m6ivBwrvdPgqJQnDVvCyMbl38H7p6LtBVR/HEDmm/zfoalzjFzzhWxA
         U2Tt7j20McOZ2oH3DydY8QBOQINNwukiBuyclH+5cr/97SM7mr4MTcclfQdqslF4NXOt
         4UDtSLsojSQX7A+Wtw7jMHdR8DtSrpervyoRkoWHVYtW4atuFbJm+5x3h+nbV00MvGmI
         wYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761460251; x=1762065051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZBj0vgRHJC6aX96xN8RIRtjeiDt3AOgOJls8yqVpTU=;
        b=rbACJ3vYJ/Ks6L684/C8a9CFoqbqPyonLQpP9FzOP/XcEZ5D1/jv6bw2qVOQeNVHip
         Q6XozIZx19Hizvnl3DD/r6ZTdZnNDZRvmUhoYdPK7ZJBLuDn2kI9Q3E4WKLoXrTyebQX
         q9CZDPaHqqPFTS8A9j2aFM9YdD219f8mG2zYnoN+RRnKTd+Lb45hV5y/GcVs8/ZmHkHu
         GJ9bcjdGiENclybuR4RQFIOhgarcFzUKBXv5ACKj19HCjdMBu0CvTz/kQSHeMH8Xsweh
         7KHXbNVJc9Hn4mdfuCvvjgUw3Fifg3OX3AxuHSdgvX3zk9PFD6d3sEDCAw0MeIPJU/I9
         vJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVJUYURiH1ySzF7QRRIhpw3nwtxdAAHtViq9rGI9PtJvXd6/mnPsCC2SDX3RBfeD1v0i6MY/+DZTI2hlLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3XuxkkuHu0t1OY5PdnSDnAslivNYe6ohNla+rwG9kxppzL1u
	nal9CfwU92HKxTp4FlUx/DaSqi7LMjsQ3iHS2kSwaJPB3aLJq/eeIXna
X-Gm-Gg: ASbGnctob1OuO/0da1jhSrQD1uhHzSXoTFCuRFKoQsh3/VVuANBpDdg2yPMHNuVTWt6
	BrAHl14XDNYgwprsKOewuHcg6Bw+LjOXt7PcuWa41T8N87McVKjhD3f+aQBLegLK3H7ZwqNLdl1
	4WhSk8GVekgniaIrbxRyVVskrjCdOEETUCHucTxVNlxtLzXjRp5j21Qs4i4L4D9egoZXz6lWG5F
	QuJ0t+3q7VNm9axQNICOxy5gsCU/B/jCjzWul+CMoC/MiYEptBKwUoMMv68euDtfmyx8SkB0l/e
	iTfjOABM57s2V4Nb7eEIAGgDAoEQVtcn6S7O6pcxK5tGcO/vp51lPkoOCWemF17zZVN1DIDpkzF
	JQwjYf3C/tSEYM4aqzbOn2i4PX6/CWny9bCIKltB9hPAhCtAvbwCN5WPp0ep3t5KD1aH7ukDuRP
	2Ld0m42r95YA==
X-Google-Smtp-Source: AGHT+IE1eXwoc08oMm0xal+/gwZlEgSxffRo65GMqV2tDlYe8mdGyu57eUdYIjlh9cI3ppLNUpa66g==
X-Received: by 2002:a17:903:388d:b0:267:e097:7a9c with SMTP id d9443c01a7336-2948ba7a6bcmr78804325ad.53.1761460251468;
        Sat, 25 Oct 2025 23:30:51 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a60fsm41583865ad.39.2025.10.25.23.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 23:30:51 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add NineTripod X3568 series
Date: Sun, 26 Oct 2025 14:28:33 +0800
Message-ID: <20251026062831.4045083-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026062831.4045083-3-coiaprant@gmail.com>
References: <20251026062831.4045083-3-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents NineTripod X3568 v4 which is a SBC based on RK3568 SoC.

Link: http://www.9tripod.com/showpro.php?id=117
Link: https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf

Signed-off-by: Coia Prant <coiaprant@gmail.com>
Cc: stable@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6aceaa8ac..417100209 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -777,6 +777,12 @@ properties:
           - const: netxeon,r89
           - const: rockchip,rk3288
 
+      - description: NineTripod X3568 series board
+        items:
+          - enum:
+              - ninetripod,x3568-v4
+          - const: rockchip,rk3568
+
       - description: OPEN AI LAB EAIDK-610
         items:
           - const: openailab,eaidk-610
-- 
2.47.3


