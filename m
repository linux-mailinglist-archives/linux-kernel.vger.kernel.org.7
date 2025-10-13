Return-Path: <linux-kernel+bounces-849992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFBBD190A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EE73B005E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8519D071;
	Mon, 13 Oct 2025 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTV953Ho"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CF1D5CF2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335247; cv=none; b=MnHsxjabwDESu4BFMT83N4ge2xJQKuqd05qTDxLwWlCR/ZyOBXgAcVoKpAHkIGuahLqZnohBDdndjCXiHzNcstb+dVbMjVh6GiFLVpnWgeZg+1ZGmWMXhZa+GaFVhuSviFaHa1q3TdUYh5phZO/Sd7CJp585Ar6u083aPdcvIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335247; c=relaxed/simple;
	bh=0i8+DknoxQAjvpBVwLLCnjqj1KkrlAyOUec1giywe+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abIBnqs9vjynRYW8WDje5QkPytNyORmFkvjptzsMK1/sfbxhLXu2ZtAxPjPWQqxUFPCbvL4BRLRNVd++YNJxRcateBFwa8YUMmw3MwvsLq4JXHa3DOVI0hYuP+87AvHPOfcDAUCv1hO7JZG1zgdVFScZTO889YM4SfopDK0h04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTV953Ho; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b00a9989633so707744066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760335244; x=1760940044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZUcnCRcwQHZ20XjWalfDU23D3XdkLxWMGXACq1syco=;
        b=ZTV953Hot+DxYkEcxv3+D2B9bswcTonClQ5Zg8uBpMdAkmglZCWmKFqs4OwT49WN4V
         t2leDM5uNXdU2SgVtj5hCs2p7rdkL5ugzG/dkT23q/qzY5RYWPH6ODQVvs4P7vh0wsOB
         3uYA6bL+E9Yn5khA9owjJUODZZS2jnX1ASC18N5iYhpfRgrXgPSiz5IsL2FbPavGqN/5
         4Omvh2tNy/wRNQVD1ffGyLGseD+qrntYtyBxIOTfv3kS5n8WxNzec0PxwQT74bwr4DWn
         npOZPqrZupGL1lq+MBUjjPah/QibtZxZBdqvkHNQqSUcxt+IZFgTNmXNAbh79KKeUHWk
         6n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335244; x=1760940044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZUcnCRcwQHZ20XjWalfDU23D3XdkLxWMGXACq1syco=;
        b=gBlRBI3V8gr6hdMqansmIMhseRG72K9JvQ0syo6lASKQxzrJ4MsSjigSOKGZbvcj7s
         v8w9RyyeinIWnSj1ODRlu5krSa6knt02wfri82+R07OE7NkWPofbzeC3CzNUWohRQnvd
         kDz25fyjhC2B+vaxHh115+yI8TZPKKCtqzEGaDoapztXNGHrTnP5L5zswTLGBuIzamyh
         eoa24yDb1BZ8Uc0cIArOlz2uefEFNw4PLIyf12TsXaXoIbtt9rin7Vuz/tOp5HreW79w
         CQkGJ9bA+lsOlo/9MLuKv47rSsWJZbMs/ckFKHagkkBe4f2ZicJZVxlJVnWVZRCqnQhk
         VWjg==
X-Forwarded-Encrypted: i=1; AJvYcCWQGAG8tC1VkmqwrWzd5jZXPiWIA69kxePr0LvoxJ56diXh+20ey8ilv++XNoa8E2fQxaO8kD3FZ6WzIa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUC1npBzGeaCkjyWX8ht3X4UBS305O5Q8u0xHzgZOtddkT123a
	aqkI7FhSVLuYTrNcjCCFCt3kwB+TwTcDRxmsEkgD+vEKI2cp59M632ip
X-Gm-Gg: ASbGncvNcd8DGj+aUCPKyVFte4cBLZkcRUzcMpGDWHHF+asFa0CxE6tnPWCnNd5n9vS
	DW/AD1vtf6iCa7yEk4bgI2H2oLTWqun3KKConLLDV7tOcHDETICEpStAIZSDJwGzo3RyePnJqW/
	MjIn8waLtPe302Bg8JgiV7trMkeglsNo1fM5qmI9kEj14ii7pcrsoFK3UAxGCG+3tFSu/pvFTRj
	CHHQMuLyZ+Uo9vbuNJu+BEvRwWHCrKRL7LtTp9r32c+zutju+0DQb+SjVVwLpraI5l61F4a5KIc
	nFGKNmFkU+Gr5AMWhVDyZbxOku5J8CE1VYffIEoTmHpgircxKMNaVigeX1bIN1rUmA9BvJgkP4X
	1amaaksnUOR6bunYzuUiUR5jnZZFUkF6OPnq+Yjd3Njg=
X-Google-Smtp-Source: AGHT+IHWc/g3EJigTLvVfxiB8jWGoS53+EIwNWR6rz91UdvmkSEhoG6xGpbuNvbew3becTvy8KOkSA==
X-Received: by 2002:a17:907:3e14:b0:b0e:83e7:f6e1 with SMTP id a640c23a62f3a-b50bedbf399mr32638666b.15.1760335243865;
        Sun, 12 Oct 2025 23:00:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacba7sm848329466b.5.2025.10.12.23.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 23:00:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2 RESEND] i2c: muxes: Add GPIO-detected hotplug I2C
Date: Mon, 13 Oct 2025 09:00:15 +0300
Message-ID: <20251013060018.43851-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement driver for hot-plugged I2C busses, where some devices on
a bus are hot-pluggable and their presence is indicated by GPIO line.
This feature is used by the ASUS Transformers family, by the  Microsoft
Surface RT/2 and maybe more.

ASUS Transformers expose i2c line via proprietary 40 pin plug and wire
that line through optional dock accessory. Devices in the dock are
connected to this i2c line and docks presence is detected by a dedicted
GPIO.

Michał Mirosław (1):
  i2c: muxes: Add GPIO-detected hotplug I2C

Svyatoslav Ryhel (1):
  dt-bindings: i2c: Document GPIO detected hot-plugged I2C bus

 .../bindings/i2c/i2c-hotplug-gpio.yaml        |  65 +++++
 drivers/i2c/muxes/Kconfig                     |  11 +
 drivers/i2c/muxes/Makefile                    |   1 +
 drivers/i2c/muxes/i2c-hotplug-gpio.c          | 263 ++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml
 create mode 100644 drivers/i2c/muxes/i2c-hotplug-gpio.c

-- 
2.48.1


