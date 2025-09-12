Return-Path: <linux-kernel+bounces-813243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE3BB5428A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031551C2351C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB927FD51;
	Fri, 12 Sep 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtqRNNP3"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9827A139
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757657377; cv=none; b=V7PFHkdapqCHTNhoKkwfDDh/eZ+POUVCCUDpHq3pcr9JfEwKS3YtRKiMgG58Hs0RUDWjtLy01AEixHhfnkxHYv+PvR82QvppbozFZ4YoeWYxflD6FW6h1CsXSsk61nuMlFGo/C2IeaEChnJNPjvwXoI64xBteOSyQsgIkiTnD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757657377; c=relaxed/simple;
	bh=TlPRpYbwmr7OOZkidAJONG6hHcs7sWog2LIz+3WzMac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ca6RYbRDfqNO+2HCFQhJex/imVB4bo7DibH+mpB3qeveb1c4S4sMkDP+QU/mZS06MICopZ3Hyd3LlTIGh+V/T5y5gwj01pThtt5cMmacfleNRJ3IuhNXYV27kMPnIsaPGtuFVoH5+zAY4pzEVojhSbdV1hkrhaTUUsoPp7vlhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtqRNNP3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24b21006804so17495255ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757657375; x=1758262175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHmi2Axy7+8qo7U5BHpZrqKUEVgZm49/TnuO9lYmy9g=;
        b=TtqRNNP3wgbtANd/ophykWYyITzB4ghl2VcYLStaefIep+2vbp4l+VRzphJ4Nv9n+D
         SqK/6gFcdq5+zSmF5RLZQM/IBo+juToTtaBbD/SwBD9QKy/IupQChujXOS7tb4TFoCke
         4i8W5HuY+pwmsXw4Zi/aZxY1VVLcSWfeInL29gRzzvEzkrutuLasyho5+pgeI37GGXeS
         2HQcGHXMa7NzPxMv8R073rigUU4T26FkhuVC0tHeeaQ6/jU8OaaHD4KOMvoxufVU0Nb2
         SV3s/aea5Ilz0w+5Eio4ObGwnZND96gKWZ8OTUb0NSGTGFIkGSBzhSDnks+VLXjXeI9M
         OrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757657375; x=1758262175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHmi2Axy7+8qo7U5BHpZrqKUEVgZm49/TnuO9lYmy9g=;
        b=ddnABEc5X8YzNVbWn6kBtiJWmnUtWZVv69egoTWHhwAfWzwl6Hs8MKY2Y6L3Mzi4VL
         oRXoxjyddByG6/bNG6iR3ZmjUsA+yLlPNZA/fhlrQPjJFc1w9m3zQFu5kOK1fLsZ1ios
         9EseaSAU6B0d8C4s/cpTb6ZtzGPAWw8J9wB9m7/mZY5/sskYYrSy33db4aX7ReYdTp0K
         sunbbbrRm6eeW5DE3cT/4cQiX8U+hgWeh2r2A8WalL24jH7djoLQBuUE9lnL9zsNJovE
         sEriQzmX0+2CN5zBwRQsgaFooYcS3YJ5nrMcTzL0k6AEsIBv0z1a0eJsJ6BDlXusolrZ
         Ir7A==
X-Forwarded-Encrypted: i=1; AJvYcCWhRQzK4XwPS5yCg15QM52HdbI2PN/9Cu0CKiGgygne0x1dwVqPdQFXZN8/yZn6eFsyYCHSFJmBu+0AkBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZv3dEgIHhUbexq+/qDuu5o7W+fpgU/bCS9OQB2kFqzwKdlpr9
	0ziy9GYydibfjVXkC/R30Tb78FhVq+rSW+JKk8mjYZS5hLsshu9S6/BxwJKPHnCl
X-Gm-Gg: ASbGncto/nOTQHx5ZuVY0TCEGOqdHLzvZumh3lIDeG0mBaQax9K24UFDEnPowbFD+Oo
	ZHfJVXVpMG7iA0S7WG7ZNjhoNrJgft7a8OumxIxCvjyRc7ERSNn8XTO7pac75F1oJGSdb37Sy6/
	k5AnIQqRlVMyh/KnifUqVNGRRfhAsLiilPJD2ksh2Juo9QEXCqMWgj+oFQHw/r+CbKVJKoAIrTh
	dP7sIhnlULQ++sYDWKNh4MiXB60HGJt389WwEnfhAe09dXap+tNfkvZ405T0GzOGFF27RKFh9DS
	h4R9Nue/AWABRMN8jn6QuAxMJeC9zgcENVJTsXVmAikNNx1LgR60fRXxhW++byaUZhfdfO/AhH8
	aFykcnuOg1UxCxWAidV56mdQqekcJzKBfhJ0uUtUsjv6EeKhxyWdAJ1PKyGDi4fpOeA==
X-Google-Smtp-Source: AGHT+IHdgaOA+rY2BJxhFpOhHU/02YengieWl6nPssZXURpbM+MI8UqJa5SZOjcf/XiPCvyPg/7X/Q==
X-Received: by 2002:a17:903:11c3:b0:235:ed02:288b with SMTP id d9443c01a7336-25d260795bcmr20375935ad.30.1757657374806;
        Thu, 11 Sep 2025 23:09:34 -0700 (PDT)
Received: from af623941f5e9 (ai200241.d.west.v6connect.net. [138.64.200.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ab43506sm37885845ad.98.2025.09.11.23.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:09:34 -0700 (PDT)
From: Tamura Dai <kirinode0@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tamura Dai <kirinode0@gmail.com>
Subject: [PATCH] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of compatible.
Date: Fri, 12 Sep 2025 06:09:04 +0000
Message-Id: <20250912060904.7659-1-kirinode0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ref. edt-ft5x06.yaml

Signed-off-by: Tamura Dai <kirinode0@gmail.com>
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


