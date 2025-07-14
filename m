Return-Path: <linux-kernel+bounces-730662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC1B047D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5A8188A954
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EEC27978D;
	Mon, 14 Jul 2025 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b="U4kyvs3q"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADC277C90
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520659; cv=none; b=Ln9A7JE6RD3eSewcWX7NFjHVP3X/VSIvHeO4hWupzVeBuU6dluC9BN4t4H/hEkDVabpIVu/45vboEYAMMjF7NxZ/aw6TKCNpRIplugLYutG8HI4QGy6qxeRjLfh8N9iF23YVeo6UcKt7v4PWYiUbUZbl+CIzcf6n+TKJTpXL/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520659; c=relaxed/simple;
	bh=ajA0H0Kbdkznv9eX+mJSjrE1WSDtNhP5sPV9UHoC+Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWKyukUT9dAE9u/c+lovuhDnDpt02OcMELVAH63Xvb6m8EL6ar5lcCv6HJpWfmfH/OV8krEYBOvzJPZ0g2YVBheMMDNxl5Kej0+xbkOJDPuK8GmwbhELvmT4hFTaWGcRToM2MmPzvLouGmDwuoqtshRQkD52Lw81C0sjljRyicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com; spf=pass smtp.mailfrom=scandent.com; dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b=U4kyvs3q; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scandent.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d95b08634fso299356685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scandent.com; s=google; t=1752520656; x=1753125456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFaUvrWskEjlMQIRMtJ+VSKoC1NmEmJ9Sv4J3gL+c0w=;
        b=U4kyvs3qGSSKTZlBjGv5agCgS8d9M6/VF+Uqr5Q8EMN0nuyr72Aw0/eelZ80nTiKyG
         LrQse744XrtoObl3Gm6i+zhMAlWntXWF3znNWIAYAcQP3diWedM1imEBzvMsO0edzoJv
         yFyRy8UtydIRFrwPem54Wbiqj8HvrqBU9zlut84iF0sy1Rl4Ze/s/MbONO4+TWsPbsRT
         a40wv+HcyqLry4RJi8L0H8NoIZo2AZ3xe3mx+B8/6vEaBy6je9bsnB4atp6zxEeEdnR1
         HgfCbSlv+pizJxNbMy2T8uSORFlxfIxVq6uwuF3eEUeJrKk4aCsd0QwNPu1lzpqaHX/K
         O0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752520656; x=1753125456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFaUvrWskEjlMQIRMtJ+VSKoC1NmEmJ9Sv4J3gL+c0w=;
        b=ePohVPIv2IdBf89iNQ3sPmuCyrU2BOrbTyXsaea75XjLhRRPBfrXfSLZdGsUzS8+fb
         SiB24QCtWUm7bDA08xFdDTr5QKOcvJOvb4dZaIun0sfYo4eJNWSMtS2QqLl2cOWh/v65
         KjbMn6pHwz87V523LBOUjdImIFVZ8TGcFKLCWftKmGbA0fsxKx9wbcXJTehpqBCv+u1q
         6rU3Z+2+2D8Q0uGUjCmzSM37E3atbhWUEt20RpRowgvnXRHUdxhGMq8iNwnk+cill3Sw
         jPNYzMliDbR7SaqqrCSoTu1tjlhvMBEuI4ZpibCmFc6E1mvh+Q27K76dkCpbZvuL9gx4
         VoTA==
X-Forwarded-Encrypted: i=1; AJvYcCWvntQWw3m5eQU+CqUSpN7eHzE8cLTNkGVYNNOf6QEC49aM8fhpU03TrE4TZs1duQzK8oTrtbICDYYr3PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSP0svWcr4Cp6Jsu2ytJgMTJSoHdKB4hUpRghSV7bY9cK+KEWU
	wr+DOHlAxnff6QbRryrPwp0OX1UR98b5+4Yvsp4TTGnOeqyxLruD8polWJrIoSFVDDQ=
X-Gm-Gg: ASbGncsc3oeALiJ1yIJz0l01K/L1gAsEzIBBP9UQYnhkmd8/cQTfqv5YGggReDcv/jU
	GzB5ZUyoOAi1trxrFHeU6n48SX37OPofHttPKd3Hk0Mw6ARSD1yBYvwT2R6sddfIE4mNVb39Ltv
	WvDbQVtQv7TaAwyX73NwUkXsx+zBDrOvSnyxe208tMkwgK1v3+VlcAjxOFNj3GrwWVtJLp9Wujk
	ec/2P4+Zcb36Hzd2BOLpYFZE3p8DP0RHGL8knQhhwO6udNtK0M1eiUAevHIqG01oqSkInzrhvMz
	ad1CRulBymd2jB2iaQcG1rg9ub6Q+nULo5f5QX7LUCZ0Gj0KktLpgWyhEjR0vP/ZyITOMD+szXQ
	gwMAaMut5rxWvu4Eb4LuCSNyj0lAJPZF2oyi0hR3UN9FbnT4p
X-Google-Smtp-Source: AGHT+IHrsHbbxm0SrpAxoF0c4hV0uQgYrBGTUzRv9iZiq/DU11326PFaQC3QWJvvDB74/arilf2aXw==
X-Received: by 2002:a05:620a:17a1:b0:7e1:9c2d:a864 with SMTP id af79cd13be357-7e19c3cebf1mr1063320185a.44.1752520656434;
        Mon, 14 Jul 2025 12:17:36 -0700 (PDT)
Received: from vserver (ool-44c5118c.dyn.optonline.net. [68.197.17.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab801e542bsm1482521cf.3.2025.07.14.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:17:36 -0700 (PDT)
From: Richard Yao <richard@scandent.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshay Athalye <akshay@scandent.com>,
	Richard Yao <richard@scandent.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Andre Przywara <andre.przywara@arm.com>,
	Junhao Xie <bigfoot@classfun.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Tianxinwei name
Date: Mon, 14 Jul 2025 15:17:21 -0400
Message-ID: <20250714191729.2416-2-richard@scandent.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714191729.2416-1-richard@scandent.com>
References: <20250714191729.2416-1-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tianxinwei is a company based in Shenzen, China, making LCD screens.

Add their name to the list of vendors.

Signed-off-by: Richard Yao <richard@scandent.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..cba78c531d92 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1548,6 +1548,8 @@ patternProperties:
     description: Texas Instruments
   "^tianma,.*":
     description: Tianma Micro-electronics Co., Ltd.
+  "^tianxinwei,.*":
+    description: Shenzhen Tianxianwei technology co., LTD
   "^tlm,.*":
     description: Trusted Logic Mobility
   "^tmt,.*":
-- 
2.50.0


