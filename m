Return-Path: <linux-kernel+bounces-764377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A0AB22240
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF29188B851
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C3E2E4249;
	Tue, 12 Aug 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQUDCRLz"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19351D52B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989155; cv=none; b=XPhI1ANaxEqgXXFOJ4FAx3Kui41sF+MsEsel+lQZcc+iMe0RUZes2QLiN5jsA3wXdljQJdeWwZGPJVvAXWW98bxEO1/L9DU9kRYoC3Z4pdBdCidTdQaZtlBbxs7GQAD/K0qmonOzMNujdeaAV6Uxg3meX78i2jAQa4hR8ylwChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989155; c=relaxed/simple;
	bh=aVo0vySJdU/GbU+4akaorxhBe4ts7YUD++0ENml4rvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgXn8HZhiq/oa0J/up5s8ahwcEHR37lIzeh1HNhNVAYziCOqh8+6wu4LM+OXONiLHOrU/LKgZs8fljD4f7MpC4fsVA0uIbW+/oZ5ndp9EsPOhb3WdVorXQp+bo8hAJnm+UuX2F5BkI3SaUL9AzehzHCtcU7XWnqmOwOy0nETqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RQUDCRLz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76bdc73f363so4621220b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754989153; x=1755593953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ4gc/Zl5lzZDEjUwdPD/JiqefAjh6ZunVQqiM20mjs=;
        b=RQUDCRLzku3v80lBPqOA4XgMvmYfU+l4kOEeyRfl1CvpPSKC4v9zvcHdw9X3/oID6n
         K59j8F14La5OFn2ZzNLU3kibzJ3HxZZo+vGQv6zDjj7O3WAb9DPvXSAyK92TCgf5TFX3
         8OpaQsu1sWitSBhg0IMx8c76R+AoCZBfZekJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989153; x=1755593953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ4gc/Zl5lzZDEjUwdPD/JiqefAjh6ZunVQqiM20mjs=;
        b=YeXy/rGHJKZnNK/c9ZV2R/31DtBWBV7ljheXsmEsrppC9vpay7pCVrTC1mqVj9eRPi
         3cwZIa5S0gu7df8O0uf8bvyDXrHWrJSU2av6s2wtDc0CS6aeSIfs1TRyZ0YJhVm6Z/k4
         I1lvjlHUX3boJ929CZEBfBByqtRG8kq40b3CTXTz+Qy3luJefJzBJaN2W569qjSW7X41
         FnI+pvHKkirAxE9pM5dy127ryyzczh6QANdyGWfvXNR2YjnpMCPP7lv/hFnggYjId90s
         D6i8Xn8F31zoCGsb3w4+E1FEXzm8xBcrEjW+BeTNrrHG8+FZO/IVYW7kME+4vaxMzpj1
         fefA==
X-Forwarded-Encrypted: i=1; AJvYcCVWOUSCGmshtXbDDrYWgVn9x4AYG/2Fcm/CVu7H4M5T6U7zrpLrz030fLnOAVnrEM9GEm4URXFzJFjCOs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywDPn6wM0dTmEwEAydVplC3IKzMJxU4VL0FFv/44P0K0to5Rtz
	BZF1Lp7/NY3mf4wwbjyD2rcQOTrlFfAjw2Z8Fy6s3rYcEFFw7TqxlEOJh4oaaURUgY4j4XzOFie
	iCNc=
X-Gm-Gg: ASbGncvlVB840hyEvb0z0MdY1HbVZAatmmdQabuk2kFzVC2tGwGFvpJL9yZ5ZpeY4uu
	78XD4qc/1BruEyOq3FA5vby9tP8mZl8iWuaqyU1TWPbC8qv0MemfBd4K6qvunLxcbCcrsMoqHel
	BmNw6SKbtbtKF/2/iH4kacN0QtBFg1ReqDl9Jo3KIvQvRDE4YxJNkL0P4y4ujCq6Wdm8JT08cOd
	/VN+756eqIQSuAJLkWvX1OrvpcypQXlMLkLppZY1xTBp6iubCM+W5fFf5KzXMptQ4iYh0oXMtJF
	ChFrM1miTBDdnk4+nLEFICwwxmszkV+wTRdhSDRiMUPC9efyQ0t4bfjWwy0yO9oEdHSiBz01vIv
	8mMvgcSGUu7qCLsl8dnF9FgNSFhd8uP08Xr0O+Wqi
X-Google-Smtp-Source: AGHT+IGXDOk02fIlA5qGSfKYGJ9s90O7hcZRHRwO1X5CkCWLtg4wt+uUNkT/Lzp453pl+RrYTnvzDw==
X-Received: by 2002:a05:6a00:3c94:b0:76b:8b13:e06a with SMTP id d2e1a72fcca58-76e0df53209mr4119372b3a.14.1754989152945;
        Tue, 12 Aug 2025 01:59:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f81e:7c91:8fbf:672a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfcb26905sm21989442b3a.123.2025.08.12.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:59:12 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8188-geralt: Enable first SCP core
Date: Tue, 12 Aug 2025 16:59:00 +0800
Message-ID: <20250812085902.3309160-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first SCP core is used to drive the video decoder and encoders.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index c5254ae0bb99..10764786bc21 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -164,6 +164,12 @@ reserved_memory: reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		scp_mem_reserved: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x800000>;
+			no-map;
+		};
+
 		apu_mem: memory@55000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x55000000 0 0x1400000>;
@@ -1146,6 +1152,16 @@ &postmask0_out {
 	remote-endpoint = <&dither0_in>;
 };
 
+&scp_cluster {
+	status = "okay";
+};
+
+&scp_c0 {
+	firmware-name = "mediatek/mt8188/scp.img";
+	memory-region = <&scp_mem_reserved>;
+	status = "okay";
+};
+
 &sound {
 	pinctrl-names = "aud_etdm_hp_on", "aud_etdm_hp_off",
 			"aud_etdm_spk_on", "aud_etdm_spk_off",
-- 
2.51.0.rc0.215.g125493bb4a-goog


