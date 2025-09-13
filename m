Return-Path: <linux-kernel+bounces-815069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4FCB55EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9D21C8830B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA22E7BA8;
	Sat, 13 Sep 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJQZunZz"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9172E7659
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757745695; cv=none; b=JEj5teaJd9+XIV0PaM+Y5PEpLjFKwp/G3oy1Pci9xe5sPjsB/vfPhngdbkgXSim4tsTiw2mAdkcNOd5O31DZFmtXTDQQsjXD63tHOGO1tYdymY3DMGR3o0DY7q9lp9NBxlTz0X5DWPm3rfg4suxaO+QP1mB4pGK+jg3N6yb3jgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757745695; c=relaxed/simple;
	bh=b4u/3r8EbbEWIWFxBt9+YcYVVzC+/qin113CQAU/g5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xgb5uMUlm+VprgCX4s+sYkJhaf4Gz7x6PkyiTegrgEbb792FOi0fnWMugyfLzWH/LuZ7hbCyVCS6AkXEHF1m+eLcaOk15mCb/0HEvyCXdU5nkJrVWQJ2F6Ax1QsAolL47Jl974sOigg0Dc+d5CLK7/r6NYYbgz0bxNQ+4WZjCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJQZunZz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2570bf605b1so24578985ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757745693; x=1758350493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+9gSbQhTkyUKu4oc46FN0yP83tgnQ9EveENpBOiA0w=;
        b=YJQZunZz+Z3KjLKM913jEadZLnOuK6XkCvNGtjDKJYuQvXCeWyAKlRceC/SYVcLBTC
         ha4La7ce1PBvnhIYrt0puzT97DoAIE0VSdpsiXCH9swN+4qjCAseUl0boKlUPfZakSvT
         6eD+cVH5PJQANKcq/55jWe4zGvhC5RwAisRKw/CcGt6YHkLmyFcrT03JGiPEsonvSS00
         IqH7RnBkeua2QRM9ZElQ99/o6BOEj8joeMqL1zzeuCWY/qw5vQ1nTLVPnGPFqO6Dx8vX
         7b1NQmlrqXQwDvNIa+3E8Gsyf/mC7jGn7FSdCipkLjyzJJJtxiRR16UIpANndrLHJBhC
         vQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757745693; x=1758350493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+9gSbQhTkyUKu4oc46FN0yP83tgnQ9EveENpBOiA0w=;
        b=ikGzKKFMxdaOBwaiqGVpH+Gk6ndbwS+E/0rHx/Cz/LUxS7oxzBlzd6p5WyOO0fJsNP
         vYmsQL74a41C+MFuyJpR9NeB92mLro3Na+ejGBBSOqiSH9cANpXeSU89MjF4rluE9YP5
         HhHjjklesTCsljYd5eVa0rh/2L/vary/zlCJgAoYNWo+fdc/xGJ4chgELXOhmw/j9S7k
         RA/LDnORXGJpWOj9gp2wTiizEZztjvi+Jin3JYwbcaQ045RicNLyTx/JHtVqNLrodLPE
         z09mqK986BF5JhFS4w0axjJRkYffxUGSka/uEk8YEZKz423eXZ7xUKIEZCgFw6wCWrYO
         k+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW5VqEYDdMQa0B+TlhbTvrkOUnJHpoDzGM9D0l4s7HMrs1IfFqg0dsXTYO+zAL1JWw3dN4RYAczalbXHIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySslDQq4gDdVPgY9XL8Ar5/FRu/ZfzIbDn4rS6AZhfIh1/fGiY
	Azn6S3d1D/95f1S9LolekuY2fTZ0tpalsH40F2O8dus5mo+PfMFM5Coo
X-Gm-Gg: ASbGncsRyLXrEaKbWMLwjW3rqs+ibbpGhoFg6yA/M9Zn06MVhN5IXDPU9hFr3Aq7MQy
	sqiu2wn6GoO12GqM3El+R8XviNwxWoi8KB/O03kttYQZz8C74WEMc9yy1cQeAawxwOWz+lrdr5z
	p06aNT8ByRHVQhI9BbAadGiTxFL3djdM1pf/4Kx9HdL4KlpgSJIgRrmGUav+PwtPKNKndsVdVT5
	5rp53SZTxz/sPnRSzSV4oB377Gcg/Hy9cCXel30zuERBehnUyliDl2T4QcCKFnWssHX1Yqq+rti
	Xc22RBPt1QBCVK/SRbVtpf70aTVZ8JbtSHxh4gMfXAbv4ZGlX+AagVrKfBx9hImIUfA0hdfvB3k
	8l7gOi8THBItzrBwXH97Q+KoTSugokC4AmUaNi84piqKgkaV/gL0KrV4UDn6EISGGYQ==
X-Google-Smtp-Source: AGHT+IEPMOXqhtSRG3ommkdDyK73YAd9aNroh5EmvYiCkuWeEel+Gu02hYUJwz3pnEOvbev7iIXNag==
X-Received: by 2002:a17:903:1666:b0:261:cb35:5a0e with SMTP id d9443c01a7336-261cb355f8dmr13755645ad.57.1757745692902;
        Fri, 12 Sep 2025 23:41:32 -0700 (PDT)
Received: from fb990434ae75 (ai200241.d.west.v6connect.net. [138.64.200.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c341aabafsm69525245ad.0.2025.09.12.23.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:41:32 -0700 (PDT)
From: Tamura Dai <kirinode0@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tamura Dai <kirinode0@gmail.com>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of compatible
Date: Sat, 13 Sep 2025 06:39:59 +0000
Message-Id: <20250913063958.149-1-kirinode0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Message-ID: <2d41c617-b7c7-43ae-aa90-7368e960e8a5@kernel.org>
References: <Message-ID: <2d41c617-b7c7-43ae-aa90-7368e960e8a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in the compatible string for the touchscreen node. According to
Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml,
the correct compatible is "focaltech,ft8719", but the device tree used
"focaltech,fts8719".

Fixes: 45882459159d ("arm64: dts: qcom: sdm845: add device tree for SHIFT6mq")
Cc: stable@vger.kernel.org
Signed-off-by: Tamura Dai <kirinode0@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 2cf7b5e1243c..a0b288d6162f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -432,7 +432,7 @@ &i2c5 {
 	status = "okay";
 
 	touchscreen@38 {
-		compatible = "focaltech,fts8719";
+		compatible = "focaltech,ft8719";
 		reg = <0x38>;
 		wakeup-source;
 		interrupt-parent = <&tlmm>;
-- 
2.34.1


