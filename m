Return-Path: <linux-kernel+bounces-889471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D4C3DB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA9EE34F01B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251034F478;
	Thu,  6 Nov 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdvlU66X"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CF29346F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469980; cv=none; b=GeEhBn3OI9s2i+qmCnrBS+8KVtEWviElo5U4ZOAehoFmjU3dMvhQdog/LmjpNOHRT7R5ZbkOyuqDKNGlaFi98+rRQehi+KrI/l2iseUznKcLlz8tZEK4qsQc5Nhij4YDhD16WAxz6XpIGwIdYmtH7JvUe6hm8ujV+15ZdL6X1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469980; c=relaxed/simple;
	bh=iFfgKGXsxXqqbK/r1KQuykijR7+PTg19keFMmyCyV/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AjStuhDyFLsDJFub1a5Up9Q3X31DeIZsuPJ6f5+6kq8aB6QytMxz3vWo2YXz1UgcDdiUX5K3us2li30TgaayJrX9dOAuUGMFbVarw+AjZJNnavfsCIRJS52ij32Jber5YiKIKUqmDeCpdicvIHis20TVurjGfhMe5DlwlAr4SUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdvlU66X; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471b80b994bso1287495e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469978; x=1763074778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hi+9G52pGopoyYkFySoeof3Qn+i2cqX8N5/nDU8LmHc=;
        b=XdvlU66XZG2f0KbIRjcpkYjKyaWtcWqyh5F3UoI+Kw/2coHxWSUBYX9AfNMHLoQR1s
         /yDowRKhKIWZzi/ludKPlYzFqVCdjIKUcDZMeqdAKEXvABubvLjtoWPQL5ppEySF6/4z
         eJGMQK0FVuPLpGA0Nh7Mf34NkcvTFkvhNEdAPfjCZNIK9WJmgJu5JsioMHTSlFca4v/x
         TSGMwfTq/Wt/R3Ql9j9A54+Gay+udE8JG0ljy/axECGyWO7Eg2xSZVsmoHp0xld6jsdQ
         nMB8AnCzdLDw3/7QuAKhedik5mxARc9VZbUuKjnrY98hcczQA9hALocDlwmiww53c6eh
         djzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469978; x=1763074778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi+9G52pGopoyYkFySoeof3Qn+i2cqX8N5/nDU8LmHc=;
        b=Q2gqR+YuD1Eo7Ph3KVDK4+8TkwMOr6pNBlT5obVhVrZgYYnT18Bt5fsLrta3y3gk1G
         051ADuq0maEt7Xt95dMb6rjK6ZAWdbIr4CjL1l+34EFNYayq7ry8nj6pJ87XAiBqK2lU
         Gw9gzdNpcH+tA+2QBwMndL1CIDlmKDfZYQnR/3oYzxQQhDXHH7yrKKIdly61oEW7FUv0
         vI2gUwqjhaNox5ADYDeAuJ1spF37AgUibgSR9+O3Cx+vXoxdgNDGXiQTDHAcaAeGLf6h
         EwMsafBgBcRrXnrh6IHSPVFlIzSsr/sO0xQ85EHfjqPFUedFbvDRWpKkXgKva0PCAt/B
         JR7w==
X-Forwarded-Encrypted: i=1; AJvYcCWMh1DM8yg/k4FY9y8TwXnZ7LHKvlUvzMPmUHcWeIVtYSrpGFNAE2zmyNk09rgjp6EKaF/9h3mPe5w/9CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv76TZxsIbVVm6s+wuHWyRQBqg1OKXB/Ly+EOz2VOeti2hQiW3
	B5smZGJ09tNufDNyWqbdXXdC+DBsg5GnmHj3FkSwVGtkrxCS4hVCE2f5
X-Gm-Gg: ASbGncu7F77+4Na2kij/Q8wwIfrcSRnY+n/2MQgdvWmn4hD5bc0m9EOGdyxUQu/yAIB
	a5WvjmSoxJuuLi4MQY4PGmJ7TPvkQfZ6lj3TK7cGje0Flw9viivUxZ+ALQJIwarwvhm2R/XZnxI
	jzjT18oMAJ/38+vXjcIdCUm3MZUhHTrDDGGdfowftgU3npTLvDNsOmx1JI17faFQqVmkCA3VFDw
	Bw+XjVp8PigPLIsz+L2XPD5KHvoWiTLgJd/U9Giakf38kuvZcR3A6Pqiqj01RPQ08Zsez6USXNZ
	4tii7Kq1u8LZORnqFxJbudpsFPEWCHKQukDpQTumDklr5QSwnKuQykflTvJN9QeQ4u7EMyXnLDL
	iwAXCSPyVkuTJ7x97Ye9PzpwAdihWkaexvab/GSzlilowVSBSHO6HSCjCUhLz3IfrvzZLOpmlBx
	tL/bdSimX03rr38WQ/zMI0uaaibbdIQg==
X-Google-Smtp-Source: AGHT+IENtlLcnvy44GLQGVYhK7qjs2eOpO1qdt6HoWtPgjvFNjDk1DciOd6xmPl52n+wvIT69vB/Yg==
X-Received: by 2002:a05:600c:6305:b0:475:e007:baf2 with SMTP id 5b1f17b1804b1-4776bcc756fmr7905035e9.41.1762469977539;
        Thu, 06 Nov 2025 14:59:37 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac6794f63sm1640000f8f.42.2025.11.06.14.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:59:37 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/5] thermal/drivers: airoha: Add support for AN7583
Date: Thu,  6 Nov 2025 23:59:09 +0100
Message-ID: <20251106225929.1778398-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series implement all the required changes to
support Airoha AN7583 Thermal Sensor.

The SoC dropped the Monitor subsystem and only provide
temperature reading. Some generalization was required
to at least save the common code with also the help of
reg field API.

Changes v3:
- Property use chip-scu for thermal sensor
Changes v2:
- Update DT schema patch to implement dedicated schema

Christian Marangi (5):
  thermal/drivers: airoha: Convert to regmap API
  thermal/drivers: airoha: Generalize probe function
  thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux
    function
  dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
  thermal/drivers: airoha: Add support for AN7583 Thermal Sensor

 .../bindings/arm/airoha,en7581-chip-scu.yaml  |  14 +
 drivers/thermal/airoha_thermal.c              | 368 +++++++++++++++---
 2 files changed, 318 insertions(+), 64 deletions(-)

-- 
2.51.0


