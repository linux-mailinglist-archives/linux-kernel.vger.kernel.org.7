Return-Path: <linux-kernel+bounces-783353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87C5B32C17
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 23:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63990A02E51
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9192E9EA1;
	Sat, 23 Aug 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2G5oCS3"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC881F4E4F;
	Sat, 23 Aug 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755984464; cv=none; b=VCaDwjdFokYu37cx2wrHKLCLk0CUWag24mVkcpA8xgUyrNNK91MpdaLYW6x38QbYyG7vjLvCDyiJoJKiY77qOWP37jlrGuN+Mg86yuhinJOMPL/pQcWr77dCsR9yque6vcMTWhh8bKcv/VqhIT5il7eFoI5jH60raLol8/urd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755984464; c=relaxed/simple;
	bh=9lB/x0q6k7LUImz55plsN/l5+3YVz5Z9NsUTm1bXZB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsRHXhcC768Depmq2ony8Qy4RK6RRFzu3+SIUSoGyhV4ff4TZZ4+4YkWzhzdWJGo6XVBFZzheOC6ibxvLeRjTBVxxf0mu4Ux7XRr0eAvKHlJoiFxCDP13x7d/wMy5qHusp5OKwfT+HGiOnpQLLAxtIb174GqL0S2zTN5Hk+6m1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2G5oCS3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24457f581aeso23699545ad.0;
        Sat, 23 Aug 2025 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755984462; x=1756589262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3f0+4Vh1MwZCJAgeds3L4wK1Y2nN5MFSu2EhurxFoGY=;
        b=R2G5oCS3va4xQDjqZoYz/8/Bk93ZqtaHjgw2MRDJdfUwP/fD3v+J8FtGGh6EU1bKgk
         6AkaYCwtloRnF5gqx4GSA/NxDJEwVCzwhDYkDO0T3JKFON/SQTfqmNG1Eo5E4UFqF5gh
         5epal5zGhknqvK3cHMwwap/GbyZeicqr+kq8if3miGu5TbWy5i+r20rfcK2qe21Aln4B
         cNGoKe+XzLhMuTjyhWnnyuzqtBTIFAGjSunnEfzpLeBIpWn5AVB7hqziHJ28CG9KGsUf
         Kjt+AiRXMyXBGiOns+ceHU5q+/JvROEFucL+4ZKwctCGnpZ0cuD0rfeglTchnllESfFW
         fQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755984462; x=1756589262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3f0+4Vh1MwZCJAgeds3L4wK1Y2nN5MFSu2EhurxFoGY=;
        b=Jk92n2LeDfwSFW+HMYnHWWGLgAbCsG5/AyTmQrK/7uuldtFTAL9w2eWI1T4u+bHN8i
         K2OEhsaIaSqZXE3ti0dWnc9/GF7eK9XoCTh7AeHgkxNqvr8FH9rugVkvMxRAW3/w10Rv
         bUui+eSFnW/7IkOcrVwu/rIGuhzOWys8iDb5P5xcsU49dv4sw4+8i0H0beI/XZa+b3HI
         ZtZ3e6OaGqKr4rwY0eGusQoONTXDVo+C6xoK6UU8C9aVaViA+cmca55ZQuZGIF0q39cE
         pdA+202y/aqqy4vrA96ZYVj7hwF+O6ENGANHPmyt+1XAhUnz/vcsRBEHKnc2cMm8fyxu
         sm3A==
X-Forwarded-Encrypted: i=1; AJvYcCUMsJ8QI0OzydpShqMadW/jr91z+lfOeznz65FTDebKkQo4ll4G9phDpovKezPHRHmXJ59iwq6Cx41cLCt/@vger.kernel.org, AJvYcCVlERXkwvidladuvYZ8s66/zitWCxFmmCXvtpeaOvLwsQddaxYVB4SLhiQ/jzMWqqncQ9D6whxxibFp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Qkf6IOjbdJF1/7A2lhYVGKxTsVMY/TaDNASKSRJvRtpXCkxz
	4rZlWmMkwAgLnHduHlufix1z4U94nh7E48gibOnl97hqOzGR/IwbHOf2
X-Gm-Gg: ASbGncuZg7GVX+fbgSkeZTqe56cuo1Masz/9I6vT0rHDEVGGfhTbAxX3yDiDD8nrzpl
	uP+25dzz/v+6+l6woiXL47s9HS1bIW3X0EBVkYD3/G7WTZco2SQ1qAA5qkZnWb+4p24Jx+qSjK8
	X18CuGOUw0aLA2RtTKVAcxcVnxwMKR0GrarKdE7vLAi6vbqS4r5YYIRxFiomclUND87nQ/0UnkU
	q2/IbST2kLcuuCMdUkpi+suCGRdXsvcxGOiMhcqi6ZlDQPBB5RzdYuMFiqldLqIv8K2GeoFJ1Jm
	bo4gbYyv08DcQ0JS9iLKJzOH7K6u1YF4wcRweyzRICFWLKU1R6lWBJQWQpoPWS0X3wu5Nt4k3gy
	sIp3oGkENHPtEOlLZKRLYNXEaBpURe6xqwrMB7kt0V3IOFzhueM/w
X-Google-Smtp-Source: AGHT+IG+vW5JGkKEGGGdp4Hd6sF1BS7DCoubVeclZE2QYEcmrjSVeoAj24TqBkympTdtodtDi+cCqg==
X-Received: by 2002:a17:903:17c3:b0:242:cfc7:1fd6 with SMTP id d9443c01a7336-2462ef446cdmr79305085ad.32.1755984462256;
        Sat, 23 Aug 2025 14:27:42 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889de85sm28982615ad.153.2025.08.23.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 14:27:41 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: linus.walleij@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH] arch/arm/boot/dts/st/ste-ux500-samsung: dts bluetooth wakeup interrupt
Date: Sat, 23 Aug 2025 14:27:32 -0700
Message-ID: <20250823212732.356620-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Interrupt support on host wakeup gpio for ste-ux500-samsung bluetooth.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts | 5 +++--
 arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts     | 5 +++--
 arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts     | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts
index c623cc35c5ea..03c679164c11 100644
--- a/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts
+++ b/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts
@@ -383,8 +383,9 @@ bluetooth {
 				/* BT_WAKE on GPIO199 */
 				device-wakeup-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
 				/* BT_HOST_WAKE on GPIO97 */
-				/* FIXME: convert to interrupt */
-				host-wakeup-gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
+				interrupt-parent = <&gpio3>;
+				interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "host-wakeup";
 				/* BT_RST_N on GPIO209 */
 				reset-gpios = <&gpio6 17 GPIO_ACTIVE_LOW>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts
index 2355ca6e9ad6..bedffd969ec9 100644
--- a/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts
+++ b/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts
@@ -475,8 +475,9 @@ bluetooth {
 				/* BT_WAKE on GPIO199 */
 				device-wakeup-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
 				/* BT_HOST_WAKE on GPIO97 */
-				/* FIXME: convert to interrupt */
-				host-wakeup-gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
+				interrupt-parent = <&gpio3>;
+				interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "host-wakeup";
 				/* BT_RST_N on GPIO209 */
 				reset-gpios = <&gpio6 17 GPIO_ACTIVE_LOW>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts
index 229f7c32103c..64562a3a262c 100644
--- a/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts
+++ b/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts
@@ -481,8 +481,9 @@ bluetooth {
 				/* BT_WAKE on GPIO199 */
 				device-wakeup-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
 				/* BT_HOST_WAKE on GPIO97 */
-				/* FIXME: convert to interrupt */
-				host-wakeup-gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
+				interrupt-parent = <&gpio3>;
+				interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "host-wakeup";
 				/* BT_RST_N on GPIO209 */
 				reset-gpios = <&gpio6 17 GPIO_ACTIVE_LOW>;
 				pinctrl-names = "default";
-- 
2.51.0


