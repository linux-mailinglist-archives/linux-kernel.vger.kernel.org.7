Return-Path: <linux-kernel+bounces-812546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 771BDB53986
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA41D1CC279B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F7362064;
	Thu, 11 Sep 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHLoIa5+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EEC35AAB9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608857; cv=none; b=LlrrCLLzoKdqppT+X2zqygPdZpr+wYOI/4HZKUIGwcfJ4BqCVxqW+hOqrXAnIBS2bzqhgUC+4Ltdi3awv5y6UuEWCZ1bJ2OskBiZ/v4Xsp18RL1ro5HmN3g2097dRxd/n7/s3iaQlDGXdisxfymR3wxYsM5fTR+84qGKVgJjhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608857; c=relaxed/simple;
	bh=RPBQwPNuYyYtQUtZ2JZFYIKb6yx1lRSpbGv4ihtUNa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjVt/dLG+6+i5SiyUZy1zz/asUOZPzu4sTJMNIIjn5TI2HoWFGngFELpQWRjgUnv0SNajpt4edKFFwXPkdWUYln8IuuUndmb2wj/idIssy3nxvAvPYY3Pf9McqUJlCigVhpirQ2G8xdl2VYdN4pKBW7trZvzA6kF0nVVJN1Ak/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHLoIa5+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so8351545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757608852; x=1758213652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMQMHx+8Y9PVtHu5Fhv1ceibqlTqO0/BLpLsbyBHbrQ=;
        b=BHLoIa5+gzOmNMr0fYq78vEnc9uG8tGUGlDRut6vINYZkTQkybTQYtt7vM9yi6YWGh
         jc8RVqtVKVlp+N4up1Ovkd8istgYRw9TzOWFJRPSrGDGB3VkJZn5lcgLv5ab6BKCErTm
         SbfRXGrFCUczlIl5JSa/4N7AvnnbYJSH/UoEXm/OPKqsfiD9xoTu/hID3fDKV/HSO6Y0
         RmDXGXqEAsf00zaITMNteR8drVrfBbIVMT7ClbrRou0/cNiNiP7VnSiq+EvGAnR55sUN
         +R57fkBaHOU9gN4FLa30QdEyGz93S2BxskNGZrAEZMvgp1K7X6CvVTkJO03KvdO1m6tR
         HgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608852; x=1758213652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMQMHx+8Y9PVtHu5Fhv1ceibqlTqO0/BLpLsbyBHbrQ=;
        b=U3et+3j6IJHHcgH81bYnmEu0vihaq6dzds881DABe8K6ZNhBS0+629AC0tBHtEV2Xy
         uCWY7DN08ccYMjZi8f9qMsnzPKYnUS2TJ5PNxdP04GYkCRjVyaW7Bko8xRbeB3M/6AOx
         vmA25hmZ6sKOLFYJf0Ue6Brm7HkRFb7EmKhg7sHwI2q5lYuxiTx1QTKGA4P7YmD2ZB7r
         9Gh6jvRd7NsnCKwLmnhSGBJi+ZlIDen1s0JCSn3U77iOBLZONGH0GXbbDW0pArX3oEGQ
         AiaF92WvETljgKILw7SwVOOUFd+YSXPkZF+QIMxjG/YeyfdJxCgwKBZc9cu3tKR7QBvB
         zHAA==
X-Gm-Message-State: AOJu0YxTCMsd4SEtsqXlj6IZiGq+ji117N4xaGLy9VXCp4hWCezhqdYx
	feliiUvyJi+AqsopkzbppFGILRS9qNwwcRA6b6JU5p8k+BHAG9/Y4eIS
X-Gm-Gg: ASbGncsjKR9Fw3YPLR6cExm9upzBziXSaQYEvKNfAxWIGNMa/oVozect9DDNfDDXk6e
	VbHXYjbfYzpGBHXBlueDcIaun2e25HEXKnJ2s3WRgsUoBltZH2ObdOYesHEaPP5BC0A8UE23jx2
	9I1O4/E+fRi23l45z0KEF1YjbQX562+/dWSTUlaXwGrw1vPewnFnMUhrq189DfLG6vtrpedWXld
	KN6Tz8gG5YlCu+V0XjazDdcBBNZxONEJPWmgWMNaTLrK1BhawyJ+BzZ2ZPdnCYdmScmcg8s5gWo
	8FuzEEVIViQmB20S/nUU6CcPBK9FX3UUn/kueWan/luBIIxe+3DG8MopXB2VhBAltYxADRlz4Nz
	N6Ivw30xiBqxcgQ7DmNI+QitFYRibYHQ6UOJUtPDcCUir
X-Google-Smtp-Source: AGHT+IEV2fAo5+1KU/1dEim/AbauImb4ZS8yoNPDcA6mm9LIEdb6hwKHDMfpgtEkevMzMRNv1mgNcA==
X-Received: by 2002:a05:600c:1c19:b0:45d:d259:9a48 with SMTP id 5b1f17b1804b1-45f2128cba7mr155095e9.9.1757608852107;
        Thu, 11 Sep 2025 09:40:52 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e01575fadsm32846505e9.6.2025.09.11.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:40:51 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Thu, 11 Sep 2025 18:40:00 +0200
Subject: [PATCH 4/4] dt-bindings: clock: st: flexgen: remove deprecated
 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-master-v1-4-5d5d5ea9af22@gmail.com>
References: <20250911-master-v1-0-5d5d5ea9af22@gmail.com>
In-Reply-To: <20250911-master-v1-0-5d5d5ea9af22@gmail.com>
To: Patrice Chotard <partice.chotard@foss.st.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=RPBQwPNuYyYtQUtZ2JZFYIKb6yx1lRSpbGv4ihtUNa0=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBowvuMhoMAqyg4f7fuJzIMrdJHVjiH3Pjtk3Qyt
 6C1PmXFFlmJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaML7jAAKCRDnIYpo1BLC
 tcXuEACV0LaWPJcYAtrzhR+HUM1hlanPrthmPqzH1P5CP1R8qHkOgPC1Je5dJ6GbZ6ww3m7LWSu
 qnVmynGir6SfQSjeGy8BxOW2QtF5hACVCtxbj99E2Y6CME8TN189WQA5sKh+hZ552OVE4HydKmm
 5X/FsBHjTMfGEUVYt94jgMWOu9ZdRTrbljkPeZFBcHxn9DXqSXrVsFByeXVYy0R6qyzQKzBuHCy
 DpsVZlkzBpsmKc0rhOEkW6dXcxHBcW8ZSaiY4A6V7zJx0CU0HZXGa37e6A3OHMk7NzdvVdsHOt9
 wUZzXrOb5neMOR0uvKyUI+huOqaX8e60KPSG9gdPlMZ38EeCtRy9EYjEm9GFPVLf2LMpmfCBJ3a
 RzTtxg6ZWLVI52hhCjWI1KpUD1X7nXF7ziGedtfbQbbouMTyGIwkM/L13iVwfFzEDBYfSOrtp6R
 Tqan0wj4eJEdbfg0j/wT8LyOWkxN8II7NGrBb1DVvE1jSjJJZpYKAPYPJDjtsCUepOMk5vRDfe0
 T1fbWm1oJCAvLiZaV8Ber7aWciZJOjMyicInGQCLWCfkex1jSvVa/bMbzsxpRFmS61I4gtqfgbK
 Exh/tNbOonAl+n44/6BWPBDNKSESBaEV/b5V3pFUfLxI4QTDzr8ijiKRJDMajmFHFdDCcpx/UQM
 UxRer5rlsjPLcFQ==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

st/stih407-clock.dtsi file has been removed in commit 65322c1daf51
("clk: st: flexgen: remove unused compatible").  This file has three
compatibles which are now dangling.  Remove them from documentation.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 Documentation/devicetree/bindings/clock/st/st,flexgen.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
index c918075405babb99a8f930f4a4430f57269417af..a9d1c19f30a3366c2ec86b6fe84e412b4b41ea56 100644
--- a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
@@ -64,12 +64,9 @@ Required properties:
   audio use case)
   "st,flexgen-video", "st,flexgen" (enable clock propagation on parent
 					and activate synchronous mode)
-  "st,flexgen-stih407-a0"
   "st,flexgen-stih410-a0"
-  "st,flexgen-stih407-c0"
   "st,flexgen-stih410-c0"
   "st,flexgen-stih418-c0"
-  "st,flexgen-stih407-d0"
   "st,flexgen-stih410-d0"
   "st,flexgen-stih407-d2"
   "st,flexgen-stih418-d2"

-- 
2.51.0


