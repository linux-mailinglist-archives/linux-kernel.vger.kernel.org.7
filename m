Return-Path: <linux-kernel+bounces-878802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C7C2181F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA45A3AB54A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244B36998F;
	Thu, 30 Oct 2025 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGQZF3ak"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FA32A3D8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845497; cv=none; b=ZtOfhe2gdRveg5ZLaxU/b4VZBrqv7tH6qvZa7mAiEg9ZnRj4M4T1E+VS0izMXzs6QmI7qeIfB88KqBdhRi7FkBSJHT1RR63O2spUW87mZRpg9EaYtXXzUjgNn9pM9T7eAyydZ6yeg7Sm8/ZALcBSoF+wiLhbnNoKguz82YCWbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845497; c=relaxed/simple;
	bh=91kxninMOJuDZGlQ785bNKkAwCmu72JTeQOT5NZzEjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXym9irm+LDR7z4VMRx00jNftKK/FcQ7bX4ii9EQbX+8h63p3EaKsxNGvXgy0BJ+RXs+OFQPFXsXpx+MaukPVKN7djMAC+eOcB9oJrNtI5dBW3mI1+b+KFGPoYjgDLfjnpPjh3Yg7Jjk/Sq8GoFLB6ZB9suB056btNCPMYKLaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGQZF3ak; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59303607a3aso1602196e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761845493; x=1762450293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FX+GUEAbTZu0XdxLl+sLP6JXHQTyzMeCDlR6Th/SyyQ=;
        b=AGQZF3akLb6iMAgp94IHhTuXhKLsnKp+GMlwP4z8HfN8nZk9Jaz7Yut1Nov19frSSe
         28p6/Gfhy6zE3s1QE1687C3nqBG3vWoSG4N4Xaft/EUtzEOkEl/wa8DIKCr1eR542m+U
         y8ihFJh+WXbID5NLpvB2ER6lerGL2Wi2Lujkk/UOEEti2AZ/57qq0eWil+nvKFEesMKx
         OQNTEIxoM2h6YDQp8SDG2lXg9HQ7D7+uGsRbs4Kqy1l7GgEQxjxtGQma/kHo7CfMkDqn
         k8J2G0FGtP0vpVVwbi0xWx4ltRJDOiv+RzVcsFJjCBsSBUc8u6aF9kEBlAkSeAWvtbzE
         4B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761845493; x=1762450293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX+GUEAbTZu0XdxLl+sLP6JXHQTyzMeCDlR6Th/SyyQ=;
        b=PenbvKrHTssQCXGvhZCLBBWxZxi8G/VgdyLy7/ydrpp/yT/Pec9u7lmYdNB12g7u9r
         8reZzUOKk6VslMn1Y9X3I9nJso7AVCqRhYWRrZGekfHj0Iit0fy1xYF9d8rENRaqHVHx
         J8YPkQn0YGofd162Rc8KckFFf7RdDxwyvEGWthuoSWabTunk/oa2WFgmadKkEWPvHp4Z
         Ez8P5wb5dsL/71AR7DArzDeXPbs423s6FrWLEXy0Oeh2Tswy1DXaD9145i+Pa8kJvs6X
         BCXPcwKyg4WE5tS8OxH8ys0Cf2GD32TbPdGrXBvKUH0aOAq6KnDAor0vEZVcNFoX2FX1
         CxTA==
X-Gm-Message-State: AOJu0YxePqm0Y0YKtZ79oZWYCc7WwBvU94wAIzTS+/f46RjcMoGeNi2/
	EuZ/j0GIHK9g6ygcCqjzvCkPZxSgSwgKoImVHpa0g3+qq1pvZW5n5ukHA+leONkZ
X-Gm-Gg: ASbGncv2Na5LSoqQD13Dmkn9uw5Hv6Zk2far+vWRADhuUWp/ID3LjkeDmA4AcWafKGG
	jZYjO1SLmDRIWqweHvwabztmVGK1nnt/Oy7nHExwp1DbnSUMlpsMvHB/nblqalhaZjAaTd4RRvt
	homcwFzLj8IJzlE1AIlpOZOj5G9xACGoSSTdxEEO8D69qteLQsxpiU2GV3vBrccqAMaFEpae66t
	SyBmAvhWobK7fdR7SuuM222sz2hJrMDqFCz+uX+Oy1IaD7rR7iHr63rURqMKyKjmpmEJzjR35bS
	9X/PRsgLIyGLDVVglHIY2r35I1KHByvNEZp/j6z369BME9pIU8RUonZMIYtin/tEmv1pwnoAIyv
	BfDXaKulUaLWt1Y58+BQzM2VCG+50VY1sm2xeej02ZXO2oI/IYRikR0/WMsey2KVoHGvVslg1pQ
	==
X-Google-Smtp-Source: AGHT+IFbmjT0o8ZBMKZZVnXGZ+nvoyPS75FxtrDSYxxUTEmQliAFW1a+zq2H8GHf5bj3BmT0Ipidpg==
X-Received: by 2002:a05:6512:b17:b0:592:eeaa:7b7d with SMTP id 2adb3069b0e04-5941d5209ecmr197904e87.22.1761845493057;
        Thu, 30 Oct 2025 10:31:33 -0700 (PDT)
Received: from archlinux ([109.234.31.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41cddsm4673392e87.17.2025.10.30.10.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:31:31 -0700 (PDT)
From: pgnmirror <vacacax16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pgnmirror <vacacax16@gmail.com>,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH] tools/perf/tests/make: use IS_64_BIT for generic lib dir
Date: Thu, 30 Oct 2025 20:30:58 +0300
Message-ID: <20251030173058.27713-1-vacacax16@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the IS_64_BIT flag to set the lib directory generically for all architectures.
Previously, this logic was hardcoded for x86/x86_64 only.

Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
---
 tools/perf/tests/make | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index b650ce886..64066e011 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -53,9 +53,8 @@ endif
 
 include $(srctree)/tools/scripts/Makefile.arch
 
-# FIXME looks like x86 is the only arch running tests ;-)
-# we need some IS_(32/64) flag to make this generic
-ifeq ($(ARCH)$(IS_64_BIT), x861)
+# use IS_64_BIT to select lib/lib64 generically for all architectures
+ifeq ($(IS_64_BIT), 1)
 lib = lib64
 else
 lib = lib
-- 
2.51.2


