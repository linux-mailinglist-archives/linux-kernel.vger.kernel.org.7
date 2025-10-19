Return-Path: <linux-kernel+bounces-859850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C73BEEC37
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986771899852
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487AA2EBBB4;
	Sun, 19 Oct 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXxwW3T/"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5D27E05A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760905306; cv=none; b=uWyuGmt6BBkfyo2vlqKb5tJyonlea2dQS2O5uM6REF50zXKFs4Eu1077w4+7wzhdTls3HfjhvYdbFdH05TUhNFZnml/Z9Nu+25Zh6kji608TDGl/qi7+CfZni9KOUefwAUoGor0/83CYvw9BNTj7jbrBTr9+qLqYBtyrXX6ao9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760905306; c=relaxed/simple;
	bh=gGu2YtK+1Y5nFXjuDa3Kb9xwoFV9zRmdc+Fveu4vvOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozz2jdv/HN0hyOcwgIjiJIAsf4mJ5G0x7YGXBCdSnt7XJMvPaGywOLzW621Xf9m4LRJk2GnMOTPuJzyxPIyTmSMsj1eazpdcBl/iXfEFU8j4RR9/CDZpzbgGlpofzjl5vUpkmSVEasGYtP3GenvsywASXvI8P6X/9j/+o/GkRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXxwW3T/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso3130618a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760905304; x=1761510104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hB+X2cZMccNnKRizXYDot4taZGWIkTvEwSaVJ3T+pA=;
        b=QXxwW3T/7hzKiFi3wfqSWZZ/MKx/VUvJ/mJFBhXhlxISFTKb3KgPdZLQePxGiuSkAG
         UBPf9GNkRF7TAUzuJdo6CP8vyNUNnVi9ZyKwg/GEdbYKWVOyr7WPT5ZAnHlqxv4sfs0h
         w+9T6hiDepANPCzx7SpXmHPq3rZaKCiShqEImEzX/sLrOZZi/W6rXkCAtmBcPv15iglY
         guwAlSLSmoxy++Yuspwoel9vurZR0043fhJZ7dKUJfCjcYAmU0QQ8HctoXJddN1jn/gX
         8g8Rn47m9Uxo6hMHgJZiJQMTTFHY0EdyyU2zsRHTRAepLQKT2dGSqAuxrmtZE5f6TKmJ
         W3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760905304; x=1761510104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hB+X2cZMccNnKRizXYDot4taZGWIkTvEwSaVJ3T+pA=;
        b=WBz1sxmjwt1fWx8hGeRrqT8xhTYTMlKay1MbwYH6esGN3vCaIIC7kI2zwGyLWglKO8
         nJPnEaHdMP5My1wAGdL/yGhfW3libXdMBntIw1/D4no18IbFKhlEpGkQ+fix3HQ40ZaT
         AlSgIPw7vEwohxfawucon20gjqT7IC/eaP8qQcIT2DjVvDRY6+0DcQ0SySSsivTPxExo
         gGnDi39j0nK57XimA/FlEw4tDiVUky/phb3PfBU4sRPYCwPEwtmoaG0ERxJyNVZxOdKQ
         w9uFIp3YWv8G9ngci6CbzRNVBaC7iahUavBX9dSNlwbYqdPAITL0fdXKrsXuZV9UMiiw
         jdSg==
X-Forwarded-Encrypted: i=1; AJvYcCWKXLwrgo/B4BJyYn26d+Fxkj+rUvnNnlNwcyQt8UziTqkGTHmmzyBk7dfmbP7KVrd2f4uRyNJSC+KLAK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPHqSeGIp7he8S2Je4lVmRiClRoEjz374Y7JYHT6tzkX0/kQJ
	OYIoajLgQ1RIRsNzIow0hAHcIWJqdJa3LTxwwiz8enrScy/80AiWKzdDgGOuIzjo
X-Gm-Gg: ASbGnctckKWVc2OcaLe6FUOSjsXRFO0TYhceTAHYuyXAysLiKtLl02jyV78TNsN22sS
	WQmsiCE/ThI+NNfGF07MUywcjYewX05p0o91TgGqI4JMI53A2BVqo6Bhi1JGKZXPYrmxWxB/eDY
	SGAevHsC5PDKtMCOHHF4uLTqZupN1W+VT9KN5zkYk+qum0eZUuB9/u0CrUaqOs7H9tOVic3u1B/
	Z2cBlcc1OhfTIQ5TqzkiQxTEPAlHrDIF5ilcrJ7a1iJZoSjOQM9LyqTNbBOwKZUHzWQOj7ZbBgp
	umT6TYqxJBMbb88waVAl6dfrd7kFSzo3zFmI6BdHgiM81KNqqvmvqvr2n8osv+5zXNg3qpQvHwz
	81e0rNfQiN5MGPTt3lz/Fem3yWqp0DzXFDeRnzYw34uQFhwSzYhn2wCHB5psSJPP+1RXjmurk/M
	NswYZ5uFoKwy2YH9kfTZQt0frxugRU
X-Google-Smtp-Source: AGHT+IHwV/l+fanQwGducXFLQEk6QG9s9UbeNxJJ798QkPYS0+g1yKsDg6/EIQaYLLJzyIqHSsDEfw==
X-Received: by 2002:a17:90b:2789:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-33bcf928b12mr17093893a91.33.1760905304309;
        Sun, 19 Oct 2025 13:21:44 -0700 (PDT)
Received: from clint-Latitude-7390.. ([110.226.183.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33bf3sm5894346a12.19.2025.10.19.13.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:21:43 -0700 (PDT)
From: Clint George <clintbgeorge@gmail.com>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] docs: ktap: fix minor typos in ktap.rst file
Date: Mon, 20 Oct 2025 01:50:53 +0530
Message-Id: <20251019202053.285723-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix couple of grammar and spelling issues such as:
diagnosic -> diagnostic
Cuurently accepted directives -> The currently accepted directives
It's website and specification -> Its website and specification

This patch aims to correct these issue and enhance the existing
documentation.

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---
 Documentation/dev-tools/ktap.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index a9810bed5..155d792cf 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -5,7 +5,7 @@ The Kernel Test Anything Protocol (KTAP), version 1
 ===================================================
 
 TAP, or the Test Anything Protocol is a format for specifying test results used
-by a number of projects. Its website and specification are found at this `link
+by a number of projects. It's website and specification are found at this `link
 <https://testanything.org/>`_. The Linux Kernel largely uses TAP output for test
 results. However, Kernel testing frameworks have special needs for test results
 which don't align with the original TAP specification. Thus, a "Kernel TAP"
@@ -13,7 +13,7 @@ which don't align with the original TAP specification. Thus, a "Kernel TAP"
 This specification describes the generally accepted format of KTAP as it is
 currently used in the kernel.
 
-KTAP test results describe a series of tests (which may be nested: i.e., test
+KTAP test results describe a series of tests (which may be nested: i.e., tests
 can have subtests), each of which can contain both diagnostic data -- e.g., log
 lines -- and a final result. The test structure and results are
 machine-readable, whereas the diagnostic data is unstructured and is there to
@@ -94,7 +94,7 @@ keyword preceding the diagnostic data. In the event that a parser encounters
 a directive it doesn't support, it should fall back to the "ok" / "not ok"
 result.
 
-Currently accepted directives are:
+The currently accepted directives are:
 
 - "SKIP", which indicates a test was skipped (note the result of the test case
   result line can be either "ok" or "not ok" if the SKIP directive is used)
@@ -237,7 +237,7 @@ Major differences between TAP and KTAP
 ==================================================   =========  ===============
 Feature                                              TAP        KTAP
 ==================================================   =========  ===============
-yaml and json in diagnosic message                   ok         not recommended
+yaml and json in diagnostic message                  ok         not recommended
 TODO directive                                       ok         not recognized
 allows an arbitrary number of tests to be nested     no         yes
 "Unknown lines" are in category of "Anything else"   yes        no
-- 
2.34.1


