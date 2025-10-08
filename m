Return-Path: <linux-kernel+bounces-845842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27DBC644A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133584061E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E91E2BE625;
	Wed,  8 Oct 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtdGpqsl"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B82BEC2B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947674; cv=none; b=m78pvJF13UN5kaFVAb6x709uOz/OAXrLEfxk3GzgncoSjiXxZPgOfT3tOvMNs3BRGO1NVvw8Ms6tXOC+MfPqH2BBGAU3/y/EdIXdyfCNhmMc8wtrcBZzE1g+uCBcLjdMzMCANuyb9JdqW0blxY9aud4azlTm/YD7Nsm1yN0qPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947674; c=relaxed/simple;
	bh=AQqdMa04vXC2piy9UqiS53/4Xv5soFhx22ppyv1jBes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSOUSZyF3E6numYNVEMK7/3/W24xdG2QJnlrO1ssHwYHVW5+P3V4mB0Ust0LzSwNXnKn9t9OPQ2UGjFUxvmV1zb6+4NHbaYuqF49OIbMh+QhSR3cKVnnP/OO++PPgWt1TL7lrJQAPbbNe0Z3yaEgoYux1P7rfYP5xEu8D4rYVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtdGpqsl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57ea78e0618so204415e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759947671; x=1760552471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r0xvqxT6obqyR1rkhpk/b1maW+DJaEvwFyv59TGQqp8=;
        b=dtdGpqsl7xzMq6wwN8mtt7OPO1nW7jtDoeXMbdVau17W3agQq7cl35HSsP7xlJGS8b
         P0tIfUiIJKaordFfrYx1SKJaCJRbVYfqnYftLSZIGdUEiLlDw1n+LN9/Qwm2K53qDAjz
         crQYjZLsaj6scjY81/xFilYdQw3xwu5NXunDgK39Aj1sTrnrmEzz3NWNcmOC8N0UP79n
         601NSe9BylRIvauZDB34N+hkwspROl6QMrS/54k6nop/dFFCi5a46ZNBUp5qOsQERXy4
         iB0G4mFRe13L9Fz1oXD67bm/os9sRsZHStb/ZeVDh9WopGVXmxjkhbsXMI8za4dXVfnZ
         b5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759947671; x=1760552471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0xvqxT6obqyR1rkhpk/b1maW+DJaEvwFyv59TGQqp8=;
        b=iqULEuy8nDlXekZ0oVTIwwDKpysVNaKXXODJrpD7M8ZAW7/vyKiDQD8pohU8/Hw5iD
         rR1+EbAZvAT1sJIZUYtNNHArUJvu2MdfZV9qC4opxyuosvt0qGnAiLn3BSG4SwbIvn7c
         vavoDmAADZd6al3M8QcHpscjRA9sLx+b0DXDN4xg8xXHgeCH2+A9mCKuvR3lYRutknqk
         amBxKsBD0XJlZHHM9QD4GylfzDAIb4TKlLHgfUQOaNrpGtJ0kMbvoYwWL+Wk5JMsnJ12
         jUjJdRk/9dCMgYknmqerbl6pSW3drg5kNeo6TWxBnDqyR+6zLBKzq3FflhN4f5liO0gu
         bZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4OYE7puZXBvWnsvedhm7ECruLYXZ8PiTh8/uJ+seTieO9CnzJ1MCZeem7YNtcAWTAdu7PYsKXqn9VAQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeTDpeSVe4aBuJcSHdO0ltb/4IOCuGWsTaSwR8gbhSGkYuMZI
	OwD1gaAiiFUtqEmcccJMUt315HEoNH8iksq+w4MTwPEdTGgZPyeNkpfz
X-Gm-Gg: ASbGncvbwyfpywcA6YoPaIn4NRWJ0XYl7nDXoee/zrEi9KCt8LUl3G7KbFEBSI/UMKA
	OGee43z7yiHmEwhYvZ0ohUm/6Uj/TmG2iMW9y2HolQQjR5CCnTGveEr4oREA8O5KKQNtVBzgm+R
	c4KdVZU0I7sH9FtfYE5Cp1Df/JBQUexwrmnioI1LQkCF430qWeBkIogqEgFBnqSmioua/9YGT1g
	wFGzdNB5RZM6MBmqKq0xi0hxR5Cv1Tqoo/incYOwsXtXe2429Z5F6tjd1/ytakHV5Za4hBJttn7
	tgMj+VYSKoEqbwEAMBqaHhXXgarlYC73J8LWNmYBmIwy1oUyviI9MGCwx8ArzbuR+3qHTvkUOWc
	8xsCQhQEfj3qWNgyPaa4FtUS9MCLw+SNOKzpTPI9C9wL4E/rGohvaQTM=
X-Google-Smtp-Source: AGHT+IGUmDxJhLMmq3olsZ1CaUePrJF77nqg1cSWJUcN+Jh1SFYb8Y4RqO/vHveCQONc5FBDfJj4vw==
X-Received: by 2002:a05:6512:230c:b0:57d:77a1:715d with SMTP id 2adb3069b0e04-5906dd527a6mr1407474e87.32.1759947670361;
        Wed, 08 Oct 2025 11:21:10 -0700 (PDT)
Received: from crusty-box ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adb1268sm223930e87.90.2025.10.08.11.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:21:09 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v2 0/2] arm64: dts: qcom: msm8939-asus-z00t: add initial device tree
Date: Wed,  8 Oct 2025 21:20:18 +0300
Message-ID: <20251008182106.217340-1-xerikasxx@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This dts adds support for Asus ZenFone 2 Laser/Selfie (1080p) smartphone released in 2015.

Add an initial device tree support for Z00T with support for:
- GPIO keys 
- SDHCI (Internal and external storage)
- WCNSS (WiFi/BT)
- Sensors (accelerometer and magnetometer)
- Touchscreen 
- Audio input and output
- Vibrator
---
Changes in v2:
- added customary newline before 'status' properties
- removed odd newlines in pin configuration nodes
- reordered pin configuration nodes by their 'pins' properties
Link to v1: https://lore.kernel.org/linux-arm-msm/20250930132556.266434-1-xerikasxx@gmail.com/

Erikas Bitovtas (2):
  dt-bindings: arm: qcom: Add Asus ZenFone 2 Laser/Selfie
  arm64: dts: qcom: msm8939-asus-z00t: add initial device tree

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../arm64/boot/dts/qcom/msm8939-asus-z00t.dts | 256 ++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-asus-z00t.dts

-- 
2.51.0


