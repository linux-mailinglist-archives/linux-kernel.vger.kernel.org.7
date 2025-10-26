Return-Path: <linux-kernel+bounces-870231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC99BC0A3C0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90F418A1937
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C0D1A9FA7;
	Sun, 26 Oct 2025 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRMTOAyV"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088E1A0BD6
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761460217; cv=none; b=nHCDx49LGFlWxXaN1VG7gn0lVn1Dw9vr48fwEgILwEhwxlmMo8Xp4BOxpkFM1Ici5lmMJrKSIKGSkdPGxMKcRj90BU4+iDr/NKnQV+6V76Z9qm0VTAQrLJze61skoUYSIlxnz3+tLgp89BIyYp5G7Edmy/+QOLKJABZdidvSsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761460217; c=relaxed/simple;
	bh=l0UrZPDuQ1VP+DFF+jGn52ZaZbAfAyacMnA05GnYi00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1Vy30ghRaRL3M6AR/WryfrTWT8xs1hfXWUJkOUD58jsYsKdh9qX8ZS0p8TvKcfrezir+p0oV7Ih7sc1lLoYpVApctT9w0/swOalh8DjMNA5FoQylyMEW+MxQ9nevW0iX8+ARE+jHfFC9iWDXqC+K3RkrVRDLM/9WaMjZMnoqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRMTOAyV; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-290d14e5c9aso48736155ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761460215; x=1762065015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRxFuvKApk33BC3d8xXXeSMvlG/sWU//suNyfzB/QNw=;
        b=XRMTOAyVMp2ygdpEI9R9Okv0/+F6ELqOPmSDg20bwwDUAklPItxI4edr19Ic6ykqTg
         Efl3kAW2KTL63ICsFU321J1I6yqcH4reUUnUZFEX5A52oTvm5l9ccdcr28sBC//AWnf/
         G/x0GUFZt7wOxxBdpIBVJO74XGPMAcHe0FFwkQVko+Zu1bn5xiln+Iv83oCQjz6wkWbw
         099mLJSe8IkyGuQksiwub1XhbtE9CzHNSK1GBIixbfCDy+r3+xzU1zfIDawGw2TkkVTB
         CNbDgMAU5PT5zec86juiJNx3K+T1Lidtn4Wyj9aWOyvpRtzKS7IKDCEqkryVfebCsk8M
         wwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761460215; x=1762065015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRxFuvKApk33BC3d8xXXeSMvlG/sWU//suNyfzB/QNw=;
        b=lEaWwBewpg9rPkqNfAJL20at57DbSTaO2o0EGK1zrD0tNFEzozbz6uA8NTzb01ggd9
         1m0YRb/aht6OSL6IRgEQ//1P9Ce1PUjUOqLC7GX71x0F1XOx99YJCV0Sn09mCLZzCgYN
         GhGP0FSV22AuEeHrAcbPOSyUjQkS4170soI2m68wS6wgnz2LdXR2s8v/NXewSnf0FWwm
         C2N2C2ZIZCSCFve9JlM0fsr4NTZoX/1sGhJv3jYNEj0HTJZvceccZiY8dQBrK6RSk/h3
         FIJU6ONu5JlNl8Sjr/rJ74PCGnn120ebPNQmrxEGfsCnkErWIMlmXpODIHIvosHVsrS4
         3fHw==
X-Forwarded-Encrypted: i=1; AJvYcCULZ2YUZ3kEQbg1EM4gZ9kCHUwfGgPzA7IlrHz0jdxBxRqheQvuTbN2Dy/sVuD+5iZ6+ZJtKso5wKrkkzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1bAcvzERPHQbYvpEg+XoePaBFQgouqbTFSKY+VIJ4XGSh5OE
	4SxyvYgqUq61UZ5mh+ejO6uE87gkfouRfOnoAqtRpDthYXzIAhoK9MnU
X-Gm-Gg: ASbGnctkOzu7KAjI0hQwSI0m6+SF5cGo0S9MvjdQnUkkpwp7flJAesjJxV47SpVsOVm
	7j8jOwUXOeU+2dFyzisIC/D6pWn8R3y3a7JFXOHvm3saoTSLabZIMjQC7dgFCjCnXdtuvGpm/Oc
	WzMaXjQtTeR2Uq3GDfWHqlZ2xC/eBD//oCvLAQWfIZg8aza8TtCDw0DoHifuAa37sXlAlZuX69/
	4avr4C/UwCKbwStQJn54z47odEFm141Q2vBI6gCeud87gxYfQNooNxmM/39NKwM1HWtg5iMEKc/
	yKuiEzmSRvOkRdoKN+pD2MeIUYY59lxfjF14N+GDmC64G1w5vfnTz+XINadn62RTpGy/kwJSjOl
	n0uo6k0efT5YLALyZ9jJJHhKsRO+rWGyLCsVnoJgLY91VeoYeZTz3PDJLuti0ayiPnhFXcAVKZi
	U=
X-Google-Smtp-Source: AGHT+IH7PDnopz1QlhAta2BSK/2CCRB91dAXRXofbVcqthVpmjY2bJvJp6m9EQhBul9G/8U3I0lZNQ==
X-Received: by 2002:a17:902:cecb:b0:290:c94b:8381 with SMTP id d9443c01a7336-290c9c89dbbmr456083105ad.7.1761460214815;
        Sat, 25 Oct 2025 23:30:14 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a60fsm41583865ad.39.2025.10.25.23.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 23:30:14 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add NineTripod
Date: Sun, 26 Oct 2025 14:28:31 +0800
Message-ID: <20251026062831.4045083-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NineTripod to the vendor prefixes.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
Cc: stable@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d188200..37687737e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1124,6 +1124,8 @@ patternProperties:
     description: National Instruments
   "^nicera,.*":
     description: Nippon Ceramic Co., Ltd.
+  "^ninetripod,.*":
+    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
   "^nintendo,.*":
     description: Nintendo
   "^nlt,.*":
-- 
2.47.3


