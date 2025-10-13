Return-Path: <linux-kernel+bounces-850474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8669EBD2ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCF4D4F1FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65F27144B;
	Mon, 13 Oct 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyUCVXQO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBF271441
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357438; cv=none; b=jSUUsoPte8PGf2f/TDpivmzLxCq/03ys4IWbpOkaxqaO2hcF33011pX+kDrp+SFqDHRpcbJo1gEMwC21NQd82MBpvGQW0dBanLE1+A00l0LyGd+nM6B0QDpp75PcrX3PloeTeHF4qJPw3AvFCdCsn0TJWNya1pgKEt26pw1I2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357438; c=relaxed/simple;
	bh=/UL8ClL1TChG9maoeTDyUv+AFngUHpA02X3Cek9Drfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pezJzNcv+r7xLhGZjatWqYAoReN5J63NifVAsI+xQsOlmOW481Nmd+cIrdJfG7oO0l3+1yqj/kTTruNJJ3XOkveJWgjILhlOyTMudUDfNXvIY5pYDzcGsmLaE8CScWS9bA55RxxBdk8q06VTRzIWDC0ArCv68COIL0lw6/ULjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyUCVXQO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f343231fcso2493250b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760357436; x=1760962236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzBgszwUIJdj2pITMIqwCF2kxKK5kVVnHly7yKNXWBk=;
        b=GyUCVXQOG1fDDVqPyzjoxq7zq3QrOSd5v6YoNmiPAQk12pGZfn0KmbOXDOk7VoAsP4
         /cxocbQna34QIE1eA9Bf0rNp/3unYdIayBJ+INBR/2TGbP0EZPOl/0aQWNKdhHq7LI0y
         iUZ1VEARJZ+z/HuhEvkjjnxvMH+Px+P60C05SMMGuKrk4YjvBy12AmN27381pbG+njyt
         XiMKGXLN+ftQKbYPj++AvIChdVq2OVsWg1vcMTXxnDk7MPa8k1HiarkCIajHQQ1UoiG8
         qZj9moGhU31L5TYQw2C9DDhKZ3sjIjwhfwMMc4LowhXe3Jgvs/y9fx7IlZoBcZUZDxx1
         QJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760357436; x=1760962236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzBgszwUIJdj2pITMIqwCF2kxKK5kVVnHly7yKNXWBk=;
        b=C3BMbP3OfJDck/BhJNPi2oGuwYPf0nYlG5HdQDKjbkinNZMHL+t5n7VhJco8hvHUYC
         dhSZlSPP7snFDxmiXR5ea1K4Lr8KO7jLzASW2lym/ycDUfwTd7pDx22PUwcGCOZY/F99
         xbDOk41o7j16j3R5WQcSsO9K3+vqGjCue0r7ws7IA5WCoGy7KPoXkKTnVDmRtqaALLC1
         +o61PSmvFSbrNhJviXYWBpGfVbfOB6ekqv6Exl4E0j3E52LD+veZiWZbWYkpPWhzI7FA
         N8CK+wUx5E6g1twhcV2NL3hJD+ABPmtsC/dXPXDoHliRpwxLCL6Q9HfdttkFWTgtwDzI
         404Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBSLJCVezyfxXuuLyXkD2RjBLswGJN6229V4Gn2XS4MLT/3G1/kWiOOR7CcBBZvoUbl7Jvjz18p6TqzSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2SF46Rwa1lStyqVRjX9Du0s17T8gUcHpAz9JWPCbq0/nu2R+
	zTWcXYygRITyb65iVZ8XFW+LkV1Luw87X1m7pCyxghFzDZXearJC9u/5
X-Gm-Gg: ASbGncuR/PBBBCMbo/aJ1Am1eAPQnWfin28LMWH7rgYSai5w1+L4GMRhOEGnN9SdoO2
	GlSQAcEEESZM5uPbuTQbhUsibzw1/suCr1R5AidXUj9djABxcdSKSs7VT31rtNzHjEDOMb8GllQ
	dnOp2JcWgA46ZdLx7tsP/GbBC7S16aup/LWz0X6v+ajFuUfXEPEtrwp5bT7VwmLhw2LKi2vTEIh
	SH9/PFV0+rrsRmaDgXcHvH+wxST3tjY3O/kVwFjrQtVMmnIIoQ8Oduaz5BjJz5RKe0+mtpkYEso
	F/7A3eUejvO6cV0+gfmo0RjP4X9yjWz3Hak2MUA1Pq1zhTq7Ri/Gv34bljOhWYzhaB/bPVBhzHK
	DQiFe/bR9ItRJiytx3/h7ysxVQUrJWdO6+eDR8e4bzmlvBySjVEmsBrlB1bIS
X-Google-Smtp-Source: AGHT+IGrfoT/bqpcaxwCJ6pm89bbGg1SBZTMeAu1UvF5nVYhh8joboK5UxNYcACKPY6tv/hz8M1NNw==
X-Received: by 2002:a05:6a21:3086:b0:2e5:655c:7f92 with SMTP id adf61e73a8af0-32da8462bd8mr27128764637.50.1760357436544;
        Mon, 13 Oct 2025 05:10:36 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.98.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df48a83sm9633354a12.31.2025.10.13.05.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:10:36 -0700 (PDT)
From: Jonathan Brophy <professorjonny98@gmail.com>
To: lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jonathan Brophy <professor_jonny@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: led: add virtual LED bindings
Date: Tue, 14 Oct 2025 01:09:47 +1300
Message-ID: <20251013120955.227572-4-professorjonny98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013120955.227572-1-professorjonny98@gmail.com>
References: <20251013120955.227572-1-professorjonny98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Brophy <professor_jonny@hotmail.com>

Add device tree bindings for virtual LED groups.

The use of the virtual status function identifier allows users to distinguish
virtual LEDs from real LEDs in sysfs.

If a virtual LED and a real LED are triggered at the same time, an undefined
state may occur. Therefore, it is assumed that hardware LEDs are blocked when
a LED is under the control of a virtual LED driver.

Having its own function definition helps reduce ambiguity and improves
clarity in LED behavior and trigger resolution.

Co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Signed-off-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>
---
 include/dt-bindings/leds/common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 4f017bea0123..39c34d585a47 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -63,6 +63,10 @@
      "lp5523:{r,g,b}" (Nokia N900) */
 #define LED_FUNCTION_STATUS "status"

+/* Virtual system LEDs Used for virtual LED groups, multifunction RGB
+	 indicators or status LEDs that reflect complex system states */
+#define LED_FUNCTION_VIRTUAL_STATUS "virtual-status"
+
 #define LED_FUNCTION_MICMUTE "micmute"
 #define LED_FUNCTION_MUTE "mute"

--
2.43.0

