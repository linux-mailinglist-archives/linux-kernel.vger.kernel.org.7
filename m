Return-Path: <linux-kernel+bounces-752639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97BCB17892
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37DD3A83FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54AD26C39D;
	Thu, 31 Jul 2025 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+IxHVB6"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3732586C2;
	Thu, 31 Jul 2025 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999002; cv=none; b=N7kjge/jv2TGD+0haLoYSnVlDlgvt8URVNI61fw4a4E1WLWqn9RWhZvYjh7/hNNFKg7TLHhBgUpMSO997SusLonURBtGCKGy2FzrSxE0IpK2iu5h8WlHW0703iRfEm24QhS4cwhoWd/HZNBw+juoMCUy9ffyrx62A6HOmq4kJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999002; c=relaxed/simple;
	bh=ROMM3glXRQ9Ps30yivQbJ9GaVlxEEOEmAKAfW9WxXKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATRJaiO9jHfQXO8bJ0PzVYr0vs+Tn3HLa2Vos3boDGDjcYLGP4cB4U6coQCXvjkxRvtHqY5euQCVraQFaNrObLtajsct/FEKAZtDeOYsY1EQIc0/3XaYvUjZ7K8KvC3DMenXVrwUCE7+Y/U6PeejgeEzTEK75jhwpo6YkvtA2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+IxHVB6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b780bdda21so141215f8f.3;
        Thu, 31 Jul 2025 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753998999; x=1754603799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/y6q5jhYnsLkBnsKrFlWmlkmeeZ+sBL03mECmYcjFMU=;
        b=Z+IxHVB6Cwl1TaIo4XP+hvYpyr266Zm9V3YAQlR6NkEHCnf82npQtNmxvsFO29ESJJ
         RsjjNu7lTLsUGyUtBXxkBBVDb5wK2dWHdOl1S07I82lsOEeUY98Hx8is1acUKV2wdw+j
         ryASC+b6J8PQSwARMf+tqHPtA/qKyqYxmxsLXZyyeKGfOAhXjvlNCvsa0gNLZFbxC3cM
         EYdBq+D9/VB4IqnkhDAKKlevwQHsPAB2cCvvZF+figerQgzhKBAeL+6pGeHsP0XkAut/
         mh4aD8xRsIy/k5b+YPXXoXQqV7ROdJlM+dnrzzmMRPV8YAe0ycpvswNkpuUay0tMtoqE
         rRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753998999; x=1754603799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/y6q5jhYnsLkBnsKrFlWmlkmeeZ+sBL03mECmYcjFMU=;
        b=U69fyO3KQ3CHA0Q5eM/jX5wYekS1YLFIYwJQwGr8ijNxW7yk8DC1FFhDfAytqL6j/6
         geuWXwcckP5cFmfxDXdFWsBfWEfb2mP8XSnbhcJDTlOQYLBiAQE4w266VzUByCJ3rKn8
         fgWQ8mB++sMLNq8nFWmAXdKkXSi99M/n9uwqYfWgXQHP8oLqTzCMbUqX54yxZ2YSBgvT
         8CWfxmJAz1OwX2ouxMkosIyjmvf5NQIQEkdsHWObnUP7DbZ9AIf4nPhjrtWjeg6ZTKH5
         W/UqlUHdMGd4i1nWcfNIdo7c2owuJyZzck1DH2OU+VCbNs5xsUhK0ZozsecMJTnkgU/d
         ElEg==
X-Forwarded-Encrypted: i=1; AJvYcCU1IMQbCrTqSYGw6hyG9TsE+b+SkXBnfCQd+F0IyB7F3a6rlw7FkHAK3vqx7wmVB6zCkaM9DmvnqW6u0xJV@vger.kernel.org, AJvYcCXQOtEfYKAXeI2BtNMVyJFPLHRHMWp1zRdSlz0PT4ajnEars4/TbYPFtaGn4S2676OdWqiIVQ2Y6rOA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ojYA2A55fAv2Bd0J210MMLO/wRp4/QlTliD/9Gx9ULt+E3cD
	kFcJuwwmY1bcbzpECRrQrL1NEFHWbJLYf2rT0v4suRfKJA9c0MyDqt8=
X-Gm-Gg: ASbGnctyA/jA3/ecALhk0SPoAnZL2LHrjOlizzSl1o1FvN1eH36GHvhtX+bMKVUpevw
	ekoWNpFw6KS5YsBMurN6USUkFC7LF6KLGtgAThzpexFteLym2uAWAY99c4cUOfPQNCpgrLx+J60
	+uJClhgGGE5biHTnYXivkGpyU8qHKj9UQOlBo50r8mnZKDjooMim+iqx3JzHCx6IeN9VLeD4jl3
	G6awCzk6WfnhHyULYsZjo6MXmHBqC2eznH05dEcncdMo5kXCYMrYyaEMUYofdlKWsnTTDaf15sa
	LZeRJtpTYkA1Fm2c2jONkjNUFvd63gcqjx8T6mvxv1remwOeHCRuamRwzUWwzxwZnGCtP4nYfpJ
	tNaoB6S6OmuLzHXFzoO61Ct3jzBf5IQkpJtksq1NS
X-Google-Smtp-Source: AGHT+IE1tY/6E/jfgp/CpzL9rt3r5x2G3oGCNcS2F8KmXHu4NjoZ32DkfrrbPshw5F+ilCUo4y7TGg==
X-Received: by 2002:a5d:5f8c:0:b0:3b7:fbe3:66c2 with SMTP id ffacd0b85a97d-3b7fbe36a82mr2729336f8f.50.1753998998731;
        Thu, 31 Jul 2025 14:56:38 -0700 (PDT)
Received: from alex-x1e.localdomain ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536abb1sm86622565e9.4.2025.07.31.14.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:56:38 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: display: panel: samsung,atna40cu11: document ATNA40CU11
Date: Thu, 31 Jul 2025 23:55:08 +0200
Message-ID: <20250731215635.206702-2-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250731215635.206702-1-alex.vinarskis@gmail.com>
References: <20250731215635.206702-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Samsung ATNA40CU11 panel is a 14" AMOLED eDP panel. It is
similar to the ATNA33XC20 except that it is larger and has a
different resolution. It is found in some arm64 laptops, eg.
Asus Zenbook A14 UX3407RA.

Raw panel edid:

00 ff ff ff ff ff ff 00 4c 83 9d 41 00 00 00 00
00 20 01 04 b5 1e 13 78 03 cf d1 ae 51 3e b6 23
0b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 cb fe 40 64 b0 08 38 77 20 08
88 00 2e bd 10 00 00 1b 00 00 00 fd 00 30 78 da
da 42 01 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
00 41 54 4e 41 34 30 43 55 31 31 2d 30 20 01 2a

70 20 79 02 00 20 00 0c 4c 83 00 9d 41 00 00 00
00 00 20 00 21 00 1d b8 0b 6c 07 40 0b 08 07 00
ee ea 50 ec d3 b6 3d 42 0b 01 45 54 40 5e d0 60
18 10 23 78 26 00 09 07 06 03 00 00 00 50 00 00
22 00 14 e7 f3 09 85 3f 0b 63 00 1f 00 07 00 07
07 17 00 07 00 07 00 81 00 1f 73 1a 00 00 03 03
30 78 00 a0 74 02 60 02 78 00 00 00 00 8d e3 05
80 00 e6 06 05 01 74 60 02 00 00 00 00 00 91 90

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index e36659340ef3..5e2ce200025f 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -21,6 +21,8 @@ properties:
           - enum:
               # Samsung 13" 3K (2880×1920 pixels) eDP AMOLED panel
               - samsung,atna30dw01
+              # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
+              - samsung,atna40cu11
               # Samsung 14" WQXGA+ (2880×1800 pixels) eDP AMOLED panel
               - samsung,atna40yk20
               # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
-- 
2.48.1


