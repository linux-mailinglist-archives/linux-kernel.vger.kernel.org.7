Return-Path: <linux-kernel+bounces-823165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3AB85B61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E085D1CC0D92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDA2314D09;
	Thu, 18 Sep 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nQCh3sjg"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302E313E34
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209803; cv=none; b=g5qR1HxtPeZU980NOLSJOu0vH/mdak0Yb7lKGroCr+1Tt4rBaSrnQ4KTg3UaH28/6O+X7uQq9R+/wGDz7GofZoB5pLfMZCVXYHge+sHQdksDiGS17OeFd4zRQpd72emtdk5V1RM5iY53yaB8k49En89db58l9w0pLaqI0t2XAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209803; c=relaxed/simple;
	bh=+49SRGaRIxmipz3ICarmrQvVbL7KzASPcS7C4Boj4ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ6LqjAlut+qMd4oo78xc1d/YVUGfS1+MdRNzmx0J3Z63IoAt/vzJGsbwyIpnhcZ07G6LRLlO3IJkBfLcB4XIO0D85as7LzrglEQPhXgyH8St4d2jjIQc0J7Ov5KTjg922iQUDJp27Y8G0glyQDcgAiekNs3aUDJzwOTeETZaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=nQCh3sjg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso4248159a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758209800; x=1758814600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNO/I2yItTXLiDSbQlltWztaUTi6rNx8Ylu9Dt/JXIk=;
        b=nQCh3sjgMTF+hR9c9mSPdRxBkTXSzRYyUenWhRdAPG2b/9AkB7/+2hQQHPPBsSk7vY
         CiQTYtwmpqRasZc7uFyeUaXH7a72F93SZn1/0oTHcI/YrHI8vgSkBd5in2rWH39VIUqT
         gIf3vEdRVgjlcVJ7mUmrjp0hcj6M3AeAmtXH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209800; x=1758814600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNO/I2yItTXLiDSbQlltWztaUTi6rNx8Ylu9Dt/JXIk=;
        b=fXTTnU4jwAUOMpG3O5VvRmKDnyuxiKPJ1+rnJIrNi83naeeeQwG82sMjDzF3nKxn46
         A/aR7X/hUvxEfWpuO/QiCiVo2DrjcGhn5yMIA+opfeVRhOhEPPDP1oSQi0Njs7WGXL5M
         OYtiabsV3YRRXWxjwl+X3M8BejcbHNuS96hySRHwgUdNx0V8+eAqVaRFOwjobStpBegm
         sWwVduD/w1UbXatWXL2cJEXcs2C5Szl/QstFyiI+ucwl22lcq88Cgbc2rteL/9LTq41y
         fFCVu1IJZfhPj0iixRiGgrwqHK6AmuR/lMr5vDn113N7vDCLw24qYiw8ZGlWbFus6u17
         cnaw==
X-Gm-Message-State: AOJu0YyKXZtoI5kn+dOL6paGwAvkd0KIzcE4isewaf2zt66eVh7uMdM3
	1mfv6HPcAkF7RFByj9v+mDpDGnzz5VDRxXix5V6hpxCA+8SzFW5T89ZpULng16TcuGGg3SrnNFf
	bVRy1
X-Gm-Gg: ASbGncs7VO+KMKQE3WG4Ckdj1f5683EXlAHWoqq6+FhQfMTOnj88jgQt6PTSPB114hx
	q3bnZ9XljM+Zy2e9BGDs21mebf8vkNBH0EG8WgF+PYnadaEeOWHZV+kFN87z3hdFfktmoXhKy+M
	w8dQBAYvEaPYIPk1Fcl5pIGPtah8dqkMGpTFUzHWXJr6Sz+7AC6XC3vkEWlGOZGrl3yE/Dr0bqy
	5pcIY1MRYzwLMyM6+XwT8XBnPUFYEapPYLamDisGodIAtXyDhAbqovkeF4mJjhRIbScFMOwjrLq
	/uHf8Vrkg2RxEHeHLtfjFjIUShBlBBCgO/3ANOZvb4sTPiWOWh5bkFWL/4iZ1hzi+L2MzW5qGkI
	DqJl35dBMqT32ABb35sGtCc2EyhkH66qseDx7spEmQcddk/skIO+K/idOPZghv+o8p1JF4MC1jw
	29wpOKJsYyxsKkXXTAHR9wGAEIRvBiWJdcci+TYqwIegSNUe4F1zAvxeVzj7pUF74W6koQivG9D
	Y+V7euxwPRTLldChEBlEA==
X-Google-Smtp-Source: AGHT+IHHoXU0i3krxfj/ayKHEAuFsB7LewUpC+X2Hw0TTk9jlaDxf33gzR19IirWjjXDnMMeOUQg5g==
X-Received: by 2002:a17:907:60ca:b0:b0d:95cf:2eae with SMTP id a640c23a62f3a-b1fa8359440mr456702266b.5.1758209799966;
        Thu, 18 Sep 2025 08:36:39 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd272026csm212430766b.102.2025.09.18.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:36:39 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 5/5] dt-bindings: touchscreen: remove touchscreen.txt
Date: Thu, 18 Sep 2025 17:36:10 +0200
Message-ID: <20250918153630.2535208-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
References: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 1d6204e2f51f ("dt-bindings: touchscreen: Add touchscreen
schema") touchscreen.txt is no longer needed, and since no other file
refers to it, it can be safely removed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>

---

Changes in v4:
- For rohm,bu21013 bindings:
  - Drop description from reset-gpios
  - Simplify description of avdd-supply
  - Rename bu21013.yaml to rohm,bu21013.yaml
  - Add Reviewed-by tag of Krzysztof Kozlowski
- For zeitec,zet6223
  - Drop "Phandle to the" from vio-supply and vcc-supply dscription
  - Rename zet6223.yaml to zeitec,zet6223.yaml

Changes in v2:
- Update the commit message
- Add Acked-by tag of Rob Herring
- Add patches:
  - 1/5 dt-bindings: touchscreen: convert bu21013 bindings to json schema
  - 2/5 dt-bindings: touchscreen: convert eeti bindings to json schema
  - 3/5 dt-bindings: touchscreen: convert raspberrypi,firmware-ts bindings
    to json schema
  - 4/5 dt-bindings: touchscreen: convert zet6223 bindings to json schema

 .../devicetree/bindings/input/touchscreen/touchscreen.txt        | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
deleted file mode 100644
index e1adb902d503..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ /dev/null
@@ -1 +0,0 @@
-See touchscreen.yaml
-- 
2.43.0

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
branch: drop-touchscreen.txt

