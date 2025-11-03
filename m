Return-Path: <linux-kernel+bounces-883430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3794C2D74D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8E73AB36D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB0831B113;
	Mon,  3 Nov 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9mGWQcR"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C731B10E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190258; cv=none; b=aYsQqFvcRweA0hDYRC0TtWNqpWUUkKGY02+WosUvMisXdwL2p8j7oeozIy48fwfkXlBq9Hebt2lgzpZPpZSha/EvoRUYsUbhsgoibJd0vn1shKvOOq/HzhBB4uLvdRQXbhvjwSVfndtikv/zSMsxP3r1UC7sEa8kURvkTjnoiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190258; c=relaxed/simple;
	bh=Bh425ift6EKvXxJnyflVAGDPWyUk+hxBRIwgXrxB/NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaqEUM1hagNYEuIlakkFT/e0h+MzQ5RFpmRbFjf6M4Xxwu1LCQG0hw3yHEChZ+4tWVDWWrytBBMHQ5STIjpgAEwK4Hb7DiYuEfUjk7iLpoON9EoAh6/DnaNbt0F9YjRK18v7GGvnldRMVYu/vH3n09Xbue2pjKTVX1Z5z/27LWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9mGWQcR; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1290209b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762190256; x=1762795056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPWqT9ltZKPbWWhVTqxcM6qSbxQc4UppEkvUs5jJNuY=;
        b=j9mGWQcRrrK2vQ8ztryM9Y/G3wXB7bylfOzx3Jcr79XXT1mdbjkK36gDd3GKq+Iqkm
         ur1+FyKd9x1DE19WBbl23mCgyDZxL29WyiXdZHD7ow34kg0IOB8uXFJbpYeK38x3rFX6
         H+ukpS8caEbxNJ/RigWNnoOxv81z0WAE1i1AJGRgeCd/HQJ2u2r8/3rArX9A3tluWMCn
         dnB9eb2IMWGU9CCuo+UQSM1D+FGf5TXcY0pvm39G8FhKmOKcY+XFi2X+gSptm9Q5l5uq
         Uuj/ip+y/AeWamEX9+ZRxgRZn3jvxyQdArC98jR9CSDu9pKaupd+kIXZF7TEQjCz25Lv
         l62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190256; x=1762795056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPWqT9ltZKPbWWhVTqxcM6qSbxQc4UppEkvUs5jJNuY=;
        b=lIabTC1s0U10ig7koFpOS8Q+DurGhJ+GFzaWs1UXvsTMwvGIYmFxFrZGgPnli3QU20
         BYpqVW+idJcxeAWPbtWqciqj+y2L1lWX+IFyavHzrDSQULezQdmTH84Z1QAGtGzsYq70
         f5DWMr8MeH1L7Y4MYhkhyp2Y9ykTmoZzTBDxvLsXHYmwR2SCY3NsPMDJeRt6JtPpQW9/
         h0hLVrKVPrkzNX5Mm0vHFyCNuEwS3m98+84BTjQ/m+ONeLeWE224qGXjs0m5/jE9xIty
         3cRTWZ+g0rq8eqMlX8GCkB+YaGgOwSFO0rcKXvPxFIA+V1k8hwLo1hKwAMQOl63Y4Cgg
         nxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKSGrgYkSXg/kmXRjeaE9CF9dNj4Dxf3P++LstuJI+m86GWicnCema96T181ySKVMISZ3BS5HwCKBYSgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+xEvqCjNeq5dF0JVZyJiDsC8IUyo71RpiAdw97HwY0Snkrwm
	fGkRC89n303x1L9MqkILX4YKeDalHMgQyF3UOpSjMAeBIlA8GdorHZC9
X-Gm-Gg: ASbGncuv/llnkA26A6aU9+WD9XninkAKRa9bggsFQRYNj1XmBTQ4mMa5XH5W9NwPDAf
	kOljzXAnYRNQxqCZ6+1YPZFOykGv2UVBGkC0via+Sza9hadBsWiUknXjPj/iyAh9aw0u76CZ8Rq
	WUGqPVasix58AllFMiMdmQQhnuBD17PF3NKqPfRSnTi7Vph1Q3dBuNyPySNH4lcGwVFAlQMXGpW
	ixLIYLKfNZWHRgjwbxpcP/ezAMdxfw4O90iER+Im6jv7WHI4sqb2XfmYEGLgEzG6J3TigMfsp7h
	+EKyiuHNl9fIB/bNvMXfCyODF/SiTSLh8RXFI2/Ggt2YqUWmB/oF9yybi/Ju2t9/GejFdPKNIpa
	SYIO2mPqK0NazSHnAS/vdKfg1alcoTPB9Q8lvOD1WQdRXxLh+eC9ALGxcH7zDIp894wWZKeB7Sh
	3bwgp1BEA2xA==
X-Google-Smtp-Source: AGHT+IF/rCUTpuM1jtcm99InanDksEwGe6KOBOO9WDLmz0bycdnKff9axedjvSMnH2NA1RIHweT5UQ==
X-Received: by 2002:aa7:88d0:0:b0:781:2291:1045 with SMTP id d2e1a72fcca58-7a77737e08amr16094326b3a.8.1762190256392;
        Mon, 03 Nov 2025 09:17:36 -0800 (PST)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db28d3fbsm12148112b3a.43.2025.11.03.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:17:35 -0800 (PST)
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
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Add 9Tripod
Date: Tue,  4 Nov 2025 01:17:00 +0800
Message-ID: <20251103171702.1518730-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103171702.1518730-1-coiaprant@gmail.com>
References: <20251103171702.1518730-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 9Tripod to the vendor prefixes.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d188200..97b169f63 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -30,6 +30,8 @@ patternProperties:
     description: 70mai Co., Ltd.
   "^8dev,.*":
     description: 8devices, UAB
+  "^9tripod,.*":
+    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
   "^abb,.*":
     description: ABB
   "^abilis,.*":
-- 
2.47.3


