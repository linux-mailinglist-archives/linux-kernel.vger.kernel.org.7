Return-Path: <linux-kernel+bounces-730792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C170B049EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA773BA049
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06711277035;
	Mon, 14 Jul 2025 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b="RqMh1n08"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381523C4E3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530799; cv=none; b=U+dBE+cBxJ3fbGfCFJtyG4sOU4tag+qIeSOgTI2/bC801iKem0MSBC7TQ0mNAdDfRPDeLyT0cm+vAHb/+4cmlY7fz8pjMafoTbkmOeMKIS/5U+1RRkHi5513II/t/fvy3Fv4ugMtCLzoimaSTOYBmshcQ0bsy5M7mWU14iz9fnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530799; c=relaxed/simple;
	bh=NfEbJQ9APBMNxBx8/hFWpXBgQCXsN9BhVcLRIR0cydM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB+7XC3TJ2IkIF2QFZjCQK0HGeOcjfrhaeZgr+4aUoM0vjwzYVUYROeK6S+2se6mm5ML9X5uKgx4wTL527Lapsf4Wydkoo2POLodtVZf8ZknkRF6B/gY1g7Yb4Wdwszo+n965q4U7ZeFP3jPlqwMK7/KA4abbSWEJiQ2WU55bsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com; spf=pass smtp.mailfrom=scandent.com; dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b=RqMh1n08; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scandent.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e32c95778aso67397585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scandent.com; s=google; t=1752530797; x=1753135597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIaH38Gh5kKcHJRj8XVnX3nblAGXvNpyNwpxmX14OvU=;
        b=RqMh1n081xWjxb1XqBRTKC8Hz0u/bUWJ00hEdTPkf6gbhch5QgiCqM6k1Gy+23Pbc7
         eyE9C6WKB38Z4wG+QaCc/TOXQ/ZzGciquxBEHE2uclQIeEF8l7XL1xexuxC4v9GoLASW
         zVbtJxLWDf11+0DCHTDNHkfRRO2di7UV7UUcf7zQPzztvDKXbrqXCapieHdUJszxZi5c
         Nj6KPM4XF93lUOHsHQqvnU8feAiExeTO6xvBS0XawtBY0vNFleLNnp8wTRMi3IIKcD7t
         GrpMoNHuM37J1zbwWujyRJe6P8On29OGhNmf7q/PoUJehoUa4wyOAKRcp0c6XM3yUcAd
         Xj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530797; x=1753135597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIaH38Gh5kKcHJRj8XVnX3nblAGXvNpyNwpxmX14OvU=;
        b=W1VJ1ZZ1girZFLS9YMg+2FnlNg6jom9U4zGb+MLkA/AMCITwgcaOhITriwlVYYk7I/
         I8Tplplib8jhhE1WSC6LfT8ouUEWoWRgId+PC+RkWx2r+HsM8YZmX0c8pIpqn4DwV1qU
         YVQ+ezVYG60jOvmqkIJhTu9iCz2XNX8VfKQgbe0JkuJtCcY48hoAPmE02lN9K+KN294k
         CNE/F2PRrNKQ7spR0akJ0bNLRA8YQ9QnAxVq3EfPk2a9Rw1pXx8BJNLMPIR9HRoAg90H
         x03sfqWIBK7BWMZq+cIhkByTOGSEsoYDY3cswmzCu6KCFmLkeoqlb+ODGFedfu0Yg/tt
         OYBg==
X-Forwarded-Encrypted: i=1; AJvYcCVeTTDL3vIV3ru+mwgVtHR75TiRvbOFbfXninni8JpECEnpgI8xSiLpzW3DHqTmQbaJk4vbM6+QaQ/f91Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpeIyWDZVPRyM3+qLGVcyVqwdJBPUalynnbAmuDNb/Iz/TNS2E
	j5Bg0LJBTqTTeTjbPdShNOMaonNUuAsRkGJDAXLnEsEnZYnxi+ynDpMphJ1dxm7wPXk=
X-Gm-Gg: ASbGncvzZCPZNfOZiwX+aTrABJpgt+tVJIhrftEJA4T6q+zCJIE5inKgbpIfwsKxh0R
	Z8P3vMC+AJm2rfBFozqIZuwD8kUTa9Eux1xU5P66CMyHT/HZmpbvxRbddO5mQI1MIbSQobP4MCx
	wV74KxpR7rj2SFNJF/tSB1nXkO184Tm1MixlCEEH+Z4lonTT1dRRzD9rHanzIPsaAOfmU58eszI
	HSL51fTEydnScY4oOHkZTq0d3ty2sRBMwqycITFQqz1jh3xsTM21qT/p1eRXoPpRWFTFL6krFhY
	RaifCFzSM2PUUM3RjLiVXKG8A/DYVzqGQ+nXEMy91T1UkK668r+jry24yWYhiFisCyodVdG/0bh
	xKTcDN4huCdn/8F+QvoUQ7HAh5m7kXQuWh0dFaHSrnyshJ0SkVrgSNHTDprU=
X-Google-Smtp-Source: AGHT+IGo6sk1WOwGd8qfuaMpolZbEey/HPUdTGdDHSrcv6A5rEBSXicgFwOvAcgwkS+TBGqrLBP+/A==
X-Received: by 2002:a05:620a:371e:b0:7dc:8bf9:ee6c with SMTP id af79cd13be357-7de04fafb6bmr2174431185a.23.1752530796908;
        Mon, 14 Jul 2025 15:06:36 -0700 (PDT)
Received: from vserver (ool-44c5118c.dyn.optonline.net. [68.197.17.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab6fdc7731sm13137311cf.40.2025.07.14.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:06:36 -0700 (PDT)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Junhao Xie <bigfoot@classfun.cn>,
	Andre Przywara <andre.przywara@arm.com>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Tianxianwei name
Date: Mon, 14 Jul 2025 18:06:22 -0400
Message-ID: <20250714220627.23585-2-richard@scandent.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714220627.23585-1-richard@scandent.com>
References: <20250714220627.23585-1-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tianxianwei is a company based in Shenzhen, China, making LCD screens.

Add their name to the list of vendors.

Signed-off-by: Richard Yao <richard@scandent.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..a2151e2aef4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1548,6 +1548,8 @@ patternProperties:
     description: Texas Instruments
   "^tianma,.*":
     description: Tianma Micro-electronics Co., Ltd.
+  "^tianxianwei,.*":
+    description: Shenzhen Tianxianwei technology co., LTD
   "^tlm,.*":
     description: Trusted Logic Mobility
   "^tmt,.*":
-- 
2.50.0


