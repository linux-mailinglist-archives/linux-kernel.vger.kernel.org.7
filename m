Return-Path: <linux-kernel+bounces-820202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E763B7C4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A77B16994E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F23090C4;
	Wed, 17 Sep 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nb8Pj4Ch"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE1305E1E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096345; cv=none; b=s4COja++gGS4a6NFmKaqJKm3QWDnLudjHx1s2bvLeTJg5EAf7YLtJPioaty9MTk7IKaKqXW8tBkqEwBCSowIMRFy1joy7qbQSMv9sLa6mfknkMfVtvTgLu9jIMW7FcsgNycl9GWju5m6XhKHichhDCKSdR/NqqOu6p3Hmkg/o9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096345; c=relaxed/simple;
	bh=osi8lZqw36mnUV7ANOU6dNqrRojLcplRBpUBXvUliAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKVBUnQMWW6Q0qnVvxl24fSWc7M10QSFe7yA2vfd2iBIcXV0ob+c8wYOs4prt2qCFYF4kI2Jarjm3cdBNyI84q5OmJCx55/gHuM5wQjwAZoGzfBYIxXa0y6e3/xApp5SmGoAcRLdZmuQbXDMiIaZuTIfx3f5z0sHs1jSfjvizf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=nb8Pj4Ch; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78ead12so912538166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758096342; x=1758701142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmFa+COnAgPwES0uM9A7F5hfXb6EgxmAXNl0CdhTVj8=;
        b=nb8Pj4ChynWTUawK+sIvRdPDSVJF4/LzWFMFnmwZLWK6Wc4XLkLV5kBK0qG4AURRUl
         MGrQytmcfcduEgoy4a0lOIKWWna0UVuxfFOXRJXjyX+T7DpqSrIg/vB+gOJR0yEKJP+8
         cNag6lzMqAv7qFWloSNmKwfzyJX6KxXpIuO3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096342; x=1758701142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmFa+COnAgPwES0uM9A7F5hfXb6EgxmAXNl0CdhTVj8=;
        b=V1q9Sq3HXSJWdGG4wbFOXXGE8p388p1MY0raVXetyJCbBuv55jp0jh7U8mMrvNgFNQ
         1wIaqCq9+/vcrVaK1avduNOKAtABh1+Ai4I/L5pEE2HcnujMWX7W2zD6gqnTRFT1sq/o
         FwQBhNw8MbTH1eFW80wg/lc5o/yfh+OVooBMP7S+yv3+uyKEs0PhdK5lJDvzEOvBnKTi
         iEMShV94Fx4YqJaRtRhKnyq86nhfjo+CGkNszF34u3mEdMy/dwQkScSUeaopKf4OagIH
         UhV1Ak0M1zLchXcgO9jlwoi9lFMIQnHG8B/uwAKONjNqTwmpPskco+cEPCDcL+9iGSus
         VjJw==
X-Gm-Message-State: AOJu0Ywe6pSkIR6psfj06aufw8/Xlhi8V7enIHsF2A0nzTN8e7y+hgQp
	2Qw/wojYN9eHYvuVBr0m0+Xd4urYuy1wEnC9rxLJNvdaQbEYjnUKNowRuY/ubQyt/cxKzH1tCLM
	kEguI
X-Gm-Gg: ASbGnct23udUOrtzV31RT0tu1ypkL+W+3K7i95ryD2zjOyPpI94LRqQYoivfqP3QAVo
	TnKS/PkrgPM1KRw715c8EH1uEI11HHL/9nQ/zFtYdwmjO+AuhyzmtejWHPtWAumxANJqwf8Vpra
	wLtvuOACi6rLP6jn7x3muVh8rS+P91Ttgs7rdC8HEl8jLO3I6i5OtebzksuCdKBs0zsvYtb5+tG
	fMgqXm4RmWDoC1SbO208SI+Q3zK8NGsTfqJZIfwTaJynwhpOs6INA8SGQZrMZplHr8TGGbq8NH/
	Yd5VnncdCzSpC0F/gZYO9B7vX7ULpp/lNwp+t12MWOqGvW/3o7w5nGyMqUtKFgGqiqcq09Ra2bG
	UNi/mztAAxWI2gKADzJxeP+hmHUFfmYDDmebdzL2Kj/l0a2rvxBfWW1tc1Ns=
X-Google-Smtp-Source: AGHT+IGzyypKx+M7bACgg59eJNm7wQj1XbSrIEOljpQMYh6T60VBtLYsEF9CNds7ILed2NSvvzXcHw==
X-Received: by 2002:a17:907:7ba1:b0:b04:9854:981f with SMTP id a640c23a62f3a-b1bb9268e9cmr163419366b.43.1758096341586;
        Wed, 17 Sep 2025 01:05:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:1215:4a13:8ee5:da2a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07e1aed5ffsm924936766b.81.2025.09.17.01.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:05:41 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Jeff LaBundy <jeff@labundy.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 3/6] dt-bindings: touchscreen: add touchscreen-glitch-threshold-ns property
Date: Wed, 17 Sep 2025 10:05:08 +0200
Message-ID: <20250917080534.1772202-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
References: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for glitch threshold configuration. A detected signal is valid
only if it lasts longer than the set threshold; otherwise, it is regarded
as a glitch.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Added in v2.

 .../devicetree/bindings/input/touchscreen/touchscreen.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 3e3572aa483a..a60b4d08620d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -206,6 +206,10 @@ properties:
 
         unevaluatedProperties: false
 
+  touchscreen-glitch-threshold-ns:
+    description: Minimum duration in nanoseconds a signal must remain stable
+      to be considered valid.
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]
-- 
2.43.0


