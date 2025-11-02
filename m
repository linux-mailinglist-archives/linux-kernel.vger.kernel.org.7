Return-Path: <linux-kernel+bounces-882057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A181C2984E
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED6F3AE985
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751919B5A7;
	Sun,  2 Nov 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJWsYRZ8"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6C243376
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121819; cv=none; b=WLxJX6ao9Set0hj15PmSRpY7BdTDyryIY2QJ6+8B664ZouxKKaidduRV1bHXjm7O62gL3vG0E7J6iyF5mJHa7RrBcXxKxERaqABa4osvewxCfbIIa63btZy8EiOiEzz7Nn4f3Y4Tzshz8v+gNqlkqzi/xzoOJSK5RZMv1ZFXjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121819; c=relaxed/simple;
	bh=PhZLtyuX6rsStPuOx2GzI5uvef40yRsEPWniw+A0HX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjqBNjRmNPJBJJbbJrssIi+A0Kl8o54bGRZQVJW2/Vt1v5ayNZzJZy1kD58zJWbR05cha7QEQMFx/tQHriPan1mleKclJPey3cxZbm8SmDPN+YEOZGJq6wr8aLJYm+72u9MpStjo35VHX6sESyBHK9ZcTxq9SOqj1vCTF1LwkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJWsYRZ8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b98eb673297so290506a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762121817; x=1762726617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++a2qLFT2GMKZSkfaoicvFef3e/M9je5Z9y3CGUMY9M=;
        b=HJWsYRZ8wV+reWfkB/zKBhyOzaA5IIEitvFDrGUlG0CHlGVspNYpXKNSGEGKwQNgIz
         tGWHYtGOIRcpUDy2pbTXisvkvRUPPh8xpmqIBCcwGoJ8Djh/iUdSfaclohzxReOROa10
         Bnq4fwanDX0jNFhBktmXaVDNH0la5qJEe2CjpSY7mI7Bv0yjNdHsAWwkt9lfgT4XzuX2
         cXDv+gmtEKXcEWBH3bWMBzA6BovEPftS2+qcFScnNuthSEGR3BvaCSx5DzjQHc35YcV8
         tXVn1tJF0gcL69dqdszFgbSuBZrI6iVrjg6wboFNMc9AfZ1HKG25N+uI7ysXLWVPdejN
         Eumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762121817; x=1762726617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++a2qLFT2GMKZSkfaoicvFef3e/M9je5Z9y3CGUMY9M=;
        b=Rp2EPZ89v2U1srPibhzeW8uSOcp/N5sHrS3+o3ZjUR4/1SAH2NAUcWt2MnrM/4THF/
         99JdD+s7rlehaGJsFYorePvMQhZmhyEjZeKKSqK84Mk25zvIB44DTJMiMfEoeF4pANEn
         3bFm7IWW9/oGPw4gdp/P8lN7ztpI14mt4CY2/EIbE1JKw7TB9rAuo82ow8gfcf3oLKbx
         bB8WTIMJVPwB2YAfsiv129H1V6FDF/nlqi9MaFtclG6A+6A3PiE9RpWFavT+7CQzKzDH
         iwtY8BAxvgj2Z/+zkBPf3rVR8QpSC4EmzagBlfXdNi9V4b6H83RE4d0oJxXsfsjJJrbF
         33tw==
X-Forwarded-Encrypted: i=1; AJvYcCVxT3hF0zyZDHZw2T6RjA7ZDcN69MX/DYlNYrHkG6HBaglSv8YdbjOW/q8BZuEpc3D5PPmyPxnv63UHdP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZfSxwe7BWkW8Fu1ByMv+I0qSHGvkwmwYwtwFm7VhFmqisLVr
	xgcG/uw5xuAEKwDzkwPuNWdMiahfD+UdcclLto9VCmoV3gS5TLHQvBdcD7yrLPh/Za0=
X-Gm-Gg: ASbGncvq1zp6sOqmE2d7aFI8H3ymUR600btvhtICpXYUCLMsO4tWWeWJk3VaLtJvHh1
	nBeFalX/EgsrtzCv6GP2OgMkzC18GWV83vqRcpktKgTNc4JiO4ZmxbaRen2yiwe5EdJzPXOf4Le
	NVdBvzLI7GUZ9fZ8/mRUA6an6JiaYUTyPynPaka3bLGNutKvjqa/CFNtp6LxCcVZIXJBzguqdHl
	a/d/G0bniNQyI1ajyNRSxpJMu28nGX+E6mcko5PVWCzqRpABuaeBNlWtLDX5qidqjlLOMTQN9X0
	1bdKuhJV2JPJD6x7PxJOSt8gLPkjVdWsarrOCea+rp30YIS1itc/W9Y2d5JczmDCTd9LASXvyfI
	X3WnRrmeiNCl3IVggkPODj4ezfbQnDhXLcFKTZdAyJGhZIGPvnQzVC1VemL7OCa51hE69FB1IVm
	wtyHIFl61XcNqa/ECVA0bHNV4=
X-Google-Smtp-Source: AGHT+IE/IJ7vHfMPuDFfKJz9U9NU8Ff7jxfU7dFthw7esoi33MHL4uL+OykKom/Ms2RJAZVJxbkMeQ==
X-Received: by 2002:a17:902:e84f:b0:295:507c:4b80 with SMTP id d9443c01a7336-295507c4c3cmr93301125ad.61.1762121816969;
        Sun, 02 Nov 2025 14:16:56 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:860f:2214:33ff:7c70:4d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295357a1851sm83362835ad.27.2025.11.02.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:16:56 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com,
	wbg@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: proximity: Remove Lidar-lite-v2 from trivial
Date: Sun,  2 Nov 2025 19:10:26 -0300
Message-ID: <20251102221643.9966-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
References: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lidar-lite-v2 IC is not a trivial device because it has a few more
pins like power-en, mode ctrl and supplies.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2eff6f274302..e344613aa265 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -357,8 +357,6 @@ properties:
           - onnn,adt7462
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
-            # Pulsedlight LIDAR range-finding sensor
-          - pulsedlight,lidar-lite-v2
             # Renesas HS3001 Temperature and Relative Humidity Sensors
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
-- 
2.48.1


