Return-Path: <linux-kernel+bounces-859723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CEFBEE6CB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1A189C78D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2A2EACE9;
	Sun, 19 Oct 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H02iDho9"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BD2BE02D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883660; cv=none; b=mrXD51AKTjRXN0aZ3N+hUVHWCZeViyolcHAJ8xhZwNX7Xxu23OLrytpRKDy0TYXz5FVMUkNU2vKwSHBsKeM55ETQ8MTEMJIxgeqa0ldPD7kO0q7hItrmEcEOPL1z6OXS7J0W6KvbccMHvuIY6amRCIx6pEfCmuZRwJ91Z+BDbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883660; c=relaxed/simple;
	bh=FBp/hrhyzsH+yC95U1RgeDSZJtaDadLI8NwWmdqcFQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWzGfV12IvoMLzaSRXlfcNePuX+SpVYAK/P+B0XY7qPCJEVy503ntHdwU5iLfi32zZm6bhPlRsM2Tk7JCyd3EjWPG0Jaoeq74uLLye+Sw/eP/r/3NyPCEkrgTk8mDBb05PovjD0KxvPGNCUkLGGjmdSYOxQpUNMvdQyVDwjLzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H02iDho9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47118259fd8so17839055e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760883657; x=1761488457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNwfswXuk6b86cUinRg+xMrD56clpn37pgGLAjruqJQ=;
        b=H02iDho9j03OsxgdIKnlR56vLEOybyqNBNoKCNJFN5BSYfbypvMekT53CYuIG8QvC8
         tb8apRGbs9fElDE/970kwQeV408Chbz1iKjgQY1uY9cjDTofiRFyZeV0o7V1IL7i0lnB
         UxQBFM3bVEGxyAygh7M07uSwDZt8L5BIzROKP228eJU+cjG7xTYReyNVg+qoYwNtdjZo
         fhZNleOj99m+SVTq9bX+R+beVzCorWYpwyq59lJZx1PvmF/kwGUZFHEn0Mtu6K9WviY7
         WskAeHyTvJiqneJ46UkEC1n1NR9yDheY8+t5kIfSX1ibaB/j0qlTsUpH5CikrMic9amY
         tA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760883657; x=1761488457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNwfswXuk6b86cUinRg+xMrD56clpn37pgGLAjruqJQ=;
        b=O1vuYU325xKrS333HFi9DifWx4uyosIWLnipxKoTo45MKSA7v88hsIXumpsFLkj9Ti
         uTyUvEXcGCtatxguf3EezwT2lwPOQWaDxt6ywD56qoyarEOtHoeLZ5GKvegrsVjUIR/t
         2aPaNkMLXvag+F/FDBJ28CUkdu2jb5YDAjExF7NIUnBOyjnTtKo9nF6J5JfStCINDGhN
         p58cYv+34v3+fKrOf6Rd/O85xQJT0anEOBFQJ7DbjpdXn6P5VgDLYvLWuLC6RjjgtL/0
         hl4UgXnG3zI6Um1FvabtYMIP++/cjdzLk36tPcuUifo9OySr8DQdw48yeF+aXV2jIsdB
         c8dA==
X-Forwarded-Encrypted: i=1; AJvYcCVLqH0or9KL+7P2aDmgIinbuec4AHLqQmjWlqaYiVFPAXUfM9Ldc+NYzKwLIMRdppYlRTUr9Tc6Gy2sItY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjsx/VSlO0bBIyfnxyDgt7HhaX9ZUrPiN2/vTUGjaj5Ma/Ba/
	Q9g8A2vqX72gjGr6fKz9ivmDD7mUeM2UEv/VrerWa3kVkXr/zbKW6GD1
X-Gm-Gg: ASbGnctlQzL1ZAhE/l0TrSvgfgy6P5A+YoRbxTi7nregFF61gGeFeA4pzN/aP8QDq+i
	5aaTOd+de+QapbGD9hmc009dR+S5DEGz2jYMl8kBum0U48hOwlTbWb8gStHcV1wNu6InRYZ8Mef
	5T5Ke7Q9lCKBbJ4fz9pZoqLbkzNa1hBoCpL5uFF7J6q+dkwkPdRZnmMXGm/Ah1wKTiKhnADq+tc
	HGelciwEka96pJjkNAcYmJZZ3xg161xu6xxYmUPO9ESb5TMHte8O7ISmujst7MxwDzcMIeUumkV
	+p3NtRO4xPR7v/e+9L3kmrRTdlDoz6+arp/qgLf6fJbdTmymbQNY2Kg6oywBld8NWdPlNGCEz4W
	zu3Js1TtvmHSfmabXg4ppjqCkMj3Oz1AR6XPrIyb6natU2lXfEFKBBHu0ca3CvAaGGgFB
X-Google-Smtp-Source: AGHT+IHnyvRQso2sIdKSn44sYHdiDNSMWI71jiqm7/h6dk5+/XYFEPh2AXjuBP/zzSUTKQwjNh/YYg==
X-Received: by 2002:a05:600c:19d4:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-47117901801mr68374015e9.23.1760883656886;
        Sun, 19 Oct 2025 07:20:56 -0700 (PDT)
Received: from debian.. ([95.88.133.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c91sm182002285e9.11.2025.10.19.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 07:20:56 -0700 (PDT)
From: David Petry <petry103@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Petry <petry103@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Enable second HDMI output on CM3588
Date: Sun, 19 Oct 2025 16:20:53 +0200
Message-ID: <20251019142053.11047-1-petry103@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the second HDMI output port found on FriendlyElec CM3588 and CM3588

Signed-off-by: David Petry <petry103@gmail.com>
---
 .../rk3588-friendlyelec-cm3588-nas.dts        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
index 5fbbeb6f5a935..10a7d3691a26f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
@@ -101,6 +101,17 @@ hdmi0_con_in: endpoint {
 		};
 	};
 
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&hdmi1_out_con>;
+			};
+		};
+	};
+
 	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_LOW>;
@@ -335,6 +346,22 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+&hdmi1 {
+	status = "okay";
+};
+
+&hdmi1_in {
+	hdmi1_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_hdmi1>;
+	};
+};
+
+&hdmi1_out {
+	hdmi1_out_con: endpoint {
+		remote-endpoint = <&hdmi1_con_in>;
+	};
+};
+
 &hdmi_receiver_cma {
 	status = "okay";
 };
@@ -350,6 +377,10 @@ &hdptxphy0 {
 	status = "okay";
 };
 
+&hdptxphy1 {
+	status = "okay";
+};
+
 /* Connected to MIPI-DSI0 */
 &i2c5 {
 	pinctrl-names = "default";
@@ -840,3 +871,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi0_in_vp0>;
 	};
 };
+
+&vp1 {
+	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
+		remote-endpoint = <&hdmi1_in_vp1>;
+	};
+};
-- 
2.47.3


