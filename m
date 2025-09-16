Return-Path: <linux-kernel+bounces-818426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D2B59198
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C3F7A2A18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933828CF5E;
	Tue, 16 Sep 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCOI4cbo"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A529B783
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013294; cv=none; b=X4c4e4IUQREk7BJGNoPXTdmL+k2cg/yotORhWAVocYNORSgqfcXYiA6rF8csNnm0sNLDkc7sbpNiCzY62LIcIE9ULTaT8A4vX/jH9tX6dLdSGzJbC4rO3sPhfnUXAr64fhvj5VAtr8hQq4G/L9Y8nuJfM2SSKKjy2VHKVz6LmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013294; c=relaxed/simple;
	bh=6CI5ECYgOzpE43PbCnYe1/+C0o9IMjem75bN/KqMWZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3/1GCglSRMAEMxm6vaEDUruiw1Rp+gNMc50fmJd7eqUhyRnpchDZn1lc4/nm+hzjYm7zh2blC5GD3si7aib6rpxFh/aXtxp8wh0Y9Px73981m1A2sszCwZS6aIQlHfm8qaR7rEzWQOGlH0iV5Qhdrb/GNTfZpJEIHb0JISEKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCOI4cbo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de56a042dso34126395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758013291; x=1758618091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn/O6EVQArdDsuUvojtCYkGjh1nRaP/fdtC5qzIrIQ0=;
        b=DCOI4cbo/4dqlsBIGjesWJZY9p5aqtD4gz7dlrnFKUlmt1u94XWYNzin65Akh6UTgk
         OxDaH+noI3H3IrIS9W0Ju5qG+ZUPYQtHvWJ7ADq9ikuOuven6K4bWwkNeWRdIeIWENsP
         uJhzvmKFLx0R3hNyd7Fh7lbOss24ki6IvKt8sleaIdxnpV0X1VqLtbKMwKK4t3T/8q1k
         HXFAMiQzkRBIiesslCyGmYIfRMcXH+H4PtqIgkEvLi7tfg6oIK90zs8AMIDnT2MiBniI
         3BqqAAbsSEb6syCjhs7PdA5o0fgOufW6bdhTyFE3sPtCEPXJPsRojysUuzA+dEPsRDss
         EqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013291; x=1758618091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn/O6EVQArdDsuUvojtCYkGjh1nRaP/fdtC5qzIrIQ0=;
        b=RlW/w/sH7fbEHANi10Cvd/drM1wI1wbR4Kde99d2lG2jFZ2wBJEg3atJpAP8XGhkMI
         DHrCByRUFfg2Rm4/M8MIigGX6sKkLkn0T0UKXJb3dJmsjczKPrSHrwybpjKk7SoZwhCO
         YLOpAfGCMazCQATu8gw1ZJmRAVLIFagCwb5So0ECpAWsyLVmihfoCEFo3bDI3xjIh8j9
         lP59yv1JOusvpeGg5AjpZQ+vRpUngOH09cDH4lBp79P+Gb7acFMqfkbMUwqWSMrs6sfv
         KpwS3Lwsy8mwoMdroklmaAN89svOpKzg1gCI5GZZPLN/yqFBpIHPe3mZWyCCYIuGHT2q
         PXWw==
X-Forwarded-Encrypted: i=1; AJvYcCUIPrUNdliJK5/7IQg/dsnGbp1GFHeAVFedvLfmBwVm2i3gDyt3Zw0vc6r3It6+Wv0pu7HUsTgAbyl0K0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqAJHNkXKW9W1NEYSiKsTq0UCBzL9sWJfJic9tz+erUP0+ri50
	PApaJRRS1WocDQYsw1eVditjfiBuc2lxCk0K5TjS3JBn5Ic+auOeh2RA
X-Gm-Gg: ASbGncuuDl3rhp864fGj6XSOsZNNsFxhZ+vuDzbNthmIL3hFqrqnB0HM170fh2IXQSA
	QRhZPwQCNg5cA/dy9B8zyALH3oy6b2NXRhpiWJXB8Lww8yBfJ1noI6aL1RzSzvZBaEChiesYUPn
	46HjuGjDRtOcxe+HNV4qEanKJcITYuoStlUp5wMPjh8eKWxLh10V8oeHpbZroG3Qw3vBs4lwuXd
	sVWxzZIFTxtIw7dVcKZz/2FQ9Zr5K1rbh16CemPPdpANOcNhyVpUhauD/HhlWe5FwzpRLx36YOe
	RgVujtMDPDRvfM5UIzkd728adv2xaF237zW4R0UYop3iupZ1/W6nardJ5Ozpejzef2OSgFoQeTT
	yzwCZIz//LVF5yI0DTMpGrHTEfFuoZTgAy+wNCr8g/16Tp8e6Ef1zWz8fdI81M37F38ZJuPNtvD
	uQ0tYieoUynlIX
X-Google-Smtp-Source: AGHT+IHITqnIEWy8SR8VOuG/NaO5QPHcpXy3zWJ0Y1P3XtsNJD2TrXAHW1mpeJ/+27n2bIwqaq7a+A==
X-Received: by 2002:a05:600c:a0b:b0:45b:74fc:d6ec with SMTP id 5b1f17b1804b1-45f211ca9dbmr161791435e9.8.1758013290736;
        Tue, 16 Sep 2025 02:01:30 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (42.16.79.34.bc.googleusercontent.com. [34.79.16.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm212975035e9.5.2025.09.16.02.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:01:29 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	andy@kernel.org,
	brauner@kernel.org,
	brendan.higgins@linux.dev,
	davem@davemloft.net,
	davidgow@google.com,
	dhowells@redhat.com,
	dvyukov@google.com,
	elver@google.com,
	herbert@gondor.apana.org.au,
	ignat@cloudflare.com,
	jack@suse.cz,
	jannh@google.com,
	johannes@sipsolutions.net,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kunit-dev@googlegroups.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lukas@wunner.de,
	rmoar@google.com,
	shuah@kernel.org,
	tarasmadan@google.com
Subject: [PATCH v1 10/10] MAINTAINERS: add maintainer information for KFuzzTest
Date: Tue, 16 Sep 2025 09:01:09 +0000
Message-ID: <20250916090109.91132-11-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

Add myself as maintainer and Alexander Potapenko as reviewer for
KFuzzTest.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..14972e3e9d6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13641,6 +13641,14 @@ F:	include/linux/kfifo.h
 F:	lib/kfifo.c
 F:	samples/kfifo/
 
+KFUZZTEST
+M:  Ethan Graham <ethan.w.s.graham@gmail.com>
+R:  Alexander Potapenko <glider@google.com>
+F:  include/linux/kfuzztest.h
+F:  lib/kfuzztest/
+F:  Documentation/dev-tools/kfuzztest.rst
+F:  tools/kfuzztest-bridge/
+
 KGDB / KDB /debug_core
 M:	Jason Wessel <jason.wessel@windriver.com>
 M:	Daniel Thompson <danielt@kernel.org>
-- 
2.51.0.384.g4c02a37b29-goog


