Return-Path: <linux-kernel+bounces-870402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55468C0AA6B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025D64E8D25
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF8924CEEA;
	Sun, 26 Oct 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBSrYqI5"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF443218EA8
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489439; cv=none; b=gqo2lDksVebFlcFmL5ibStZKizwnjUTW3VSTnhM2xJKyKSIdyZhoWQAD2nD9Www3u8EqmfVlq5AcM9vOpgPwJZtwuE466m04jhlBpUpg1pbOuDEjwDXyD8le1DJsrNo6nbGDSBieGUForu36NDESWSDlk/9/TxiIdq1YtH+6kdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489439; c=relaxed/simple;
	bh=A3bSV3u8AarAyp31lzoLWMXHtLeH04d3zGSkueTEkDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ER4ngcufXRJ6qzedPPvggKgONBwvsDg0//a8QNRY0dcDLV3TmzXRWNyLfQTmZCd1glXMIBhubIwyao/12TW/Zvl+uvZPxqjCVuF+kp097rhm1vpkykErqwoU+9NfCEc6KyuZH9BvbJyxb1U4FnYg5f42T0MtscdF0uY4xsTibl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBSrYqI5; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso3531567a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761489437; x=1762094237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Px4DGTedr0t+HqBVc78Zx84UzxWlcHUehvdoHcOj/G4=;
        b=FBSrYqI5hEZuRWt6RLAH/G8MPdRZRWukxu+uSwJ4CT/VWhg8IwNNltXnHxNcZt27t3
         qzBeUPV//viQMK2ZpkysJhiY2q5nquXdNbx6k4/lkibvMCBqjyODrNNJ+56Z9cXv8WJK
         PzCW0iuXIAvI1DBSis0BNnGPqMP+8MG8jgcHCuCWm3ZgkdXxKxSxXtpD7RbLSqAs35/Y
         tSOWBy+YEWE/2U/nz36o9SXb0r2v//nWhHddb4j0wSN8+xEufIQA+MgBvUx8apx6Beqg
         yvQdIAghqwXpoAkhZ/nYVm+ggVZ61jJiJN9dcKGygI539RbuZuUJS/wowgRH5/OTlQYx
         3/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761489437; x=1762094237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px4DGTedr0t+HqBVc78Zx84UzxWlcHUehvdoHcOj/G4=;
        b=Wq0gmSsofXEFBe52JcWXIhqZscNf5B0TTKymZUTghWAqlTrqso8JGtL4upIFGx9Qp3
         wk9R+8L+0hPaU7Nyw3BPRuvRIken/gZD5Cmj+2tFIGed9/lQ+Hoph0JMaUs4dR1gBvRQ
         di93CGPTQrPTpBVJ6yh70OOm7W0DQ2zXlE8iuKueVV7R1bC56LPtkW/Qo60n4FO5UcoU
         i3d6iBkGXgYzg3bIoJxE9j09+EN1BxpyI6aH5c4qUhJFf/ujc1GkxP+dAwwGVR8GzfBs
         65ergl3YqAec+L3WWzYDMm6r7GbeiWiWkDUtoCtaBF8DIhfaymkFj4bke5MfB1iKFypF
         v7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDRHVYVxFvHCCRl6bOr5PVRAjk9OWZL0lu1WymUO+ZL+AZNt/jngn83Tb861ZlT2xcKcCt8ztIkaIGi8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAyyBee2RgMncDaeZgfFsxr8xg1lsrFTUXA9S/kktflKvbSY6
	RA9WXPnAtvFyCkjuKFcbxUoS4yCwmI4q8bCZwZpFMxDzB8KJrMQyx2f4
X-Gm-Gg: ASbGncvMRyn5StioliXpD2u0GR+uRRLDX3uw/tsZhdIctofdWF1tf/rke1prhOVoawj
	m6LRsS9eTVBSjmQN8UQW6BUMCt14KOhjEihnaBrRZY+Vj8a7SUgBAjRZp0QOLnjevXhxB21IWZE
	zdXSXeKGRnt3/nC1MhjIm0CTmiXkl9dGDjaDMh5vQo4PUpGVJf0SmAofBYY26jNkI9cUUWbr4Ol
	e2fE3hdMwlMZesBV3mB4CfHbjK2AkuAnjMrYhCsoWNJa+MoE+jmkqlzD6w7Z/XOu2dE5BGGhWjz
	GGLZBJ1Eh6Mp00kmQJgp5H5mJAC1VQ9xbYr74F4S/Dvu+5OGZYnIqsGXEuIeM4cdk6szqSAGREj
	FaEerdHNLzqF4tCfG7UNA69LbhP0a7KPp01gGMaxzDbR7MaX1JmJiLSVWXsTQD9B0BUYQcQbp6C
	k=
X-Google-Smtp-Source: AGHT+IEfx0AH+HyiwJ68//xsscWnnszjfjuh908GaFcgwt1A/M2fn3D2pU1eaom3Q9nzHLoe+m5ueQ==
X-Received: by 2002:a17:902:ecc8:b0:290:c516:8c53 with SMTP id d9443c01a7336-290caf831d8mr427173395ad.40.1761489437072;
        Sun, 26 Oct 2025 07:37:17 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128d4d44esm4652691a12.21.2025.10.26.07.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:37:16 -0700 (PDT)
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
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add NineTripod
Date: Sun, 26 Oct 2025 22:36:44 +0800
Message-ID: <20251026143645.917588-2-coiaprant@gmail.com>
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


