Return-Path: <linux-kernel+bounces-861158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D135BF1EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711BE461AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED5E229B18;
	Mon, 20 Oct 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyopwRDT"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6470218AB0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972024; cv=none; b=m+C/a8Vz5pB6Suzp85kAUznFR4S/0WfRF1dUKxvwlfNcedltP3CXABq3HaNPPtY7UA4YoKPVqYFfAskKKGfRwcslRJPmcqq9DMQCYoyaBhosnb6fJucvKk/N0TjCcdZ3DXlLEK3hRz06HJeSHZGtziO48A/uumNGqEj67jXhb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972024; c=relaxed/simple;
	bh=Qgmm5n3QgGYHJXMdGtmtk4unsoI55ELPPsP//oF6jlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fj+KNd5wd04UrBYVozhjYKn2/0mpp94npi7sju5jYsgp9Ye21xISMTA+RiYiupsHHUIAv+EQCyrftx9btS0wbz/QbBkkrLaHUSOCir0OiZ8pQKY5AeOgJnoHGKARRU79W/9AUoLQWzccPKn00RKnHOCzy/SBcXBaBslbjYpn+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyopwRDT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781206cce18so4533658b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760972022; x=1761576822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ/VR7vR62blRBnvkVTsR0wWUxwVHVWxsZkAw6EQ2kA=;
        b=eyopwRDTzsYqa7D6TT4ydJRu6wVtm+4RTQ/6mh8/r3ny496mCrriAkyk8119gLYOJA
         70h2h44snrnT3BA/yajKrCT3Xytaezl/ZPs5fpif4jJAhJCJ73bvOHwgVlsmB+ByxVyV
         +6lVSlh/xyQPmGM3RDWtIfrIt12txH5hKBSk/+LS0G2EkPuXIlHd7ZM7fx5rQhoOmilV
         JwNq8vPPcQXBiGWhI5kUsO5B9oJNsdyN9xntCqHFoYlIkp3BoN1zVrFvYnQiaEtyN2aB
         XHGUy+/3Mjb4ro9j68+SdJK5ebxBROiJs4FDW2mPuXPRrAH9E9prMjSB3ymCKkJomEOy
         0gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972022; x=1761576822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ/VR7vR62blRBnvkVTsR0wWUxwVHVWxsZkAw6EQ2kA=;
        b=TdmU46Rd8ElAP+0dr0PrfwZE65Je5ZirQjLyyaaNWFke6dUY0lOc30cV3rn+2PoYXb
         Q2mzg2m/ngfanZ+HSxCjBzs9H6pJj/Fx5f9oIU3w5FeUf6rsYrfcsC0RWxNRUSgcCVWS
         tR4RTyXvbTyR/6j4IdTmhTF11hFQ32nQqbFIa6rCtcnhDirtqIpR8nQ8ulJ/QXRq9ven
         pPDkiQzhtayvDGLVWQ/PEmcu1mWr+iSluWLkqfFxlK8mlHONUrTyOboCb9sdZnLg3AtO
         f9evGeIqXn+WOX5MFq2cmz638pDQEiXMnfWjsBr4i/b0CHFQWdqvR3zQ5P0zKnncQVrA
         otTw==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ+uGA22PdUKMPW62YZmVmxjeCU8nxzrd9koiJQrIEcDylkOuawe+dB10WohesfrxUY3H73VA2D6B5DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgL9HKKzdQg2xqzIT9lHF7wdCJUU0nTq3Mrj8S6pz3mIO5cHO
	xGRuMkyZLLrKKsjVlJYUxv37uG/K8+u+XJ125gqzbrzeWVC2qB1NfhlerhCWBOrU
X-Gm-Gg: ASbGnctUPABpcH3Hdzek1As/awmo5YRe6kQHK/buw/IYbCAIXyMR9R3SEg1vXJI2pR3
	tKCvMO5GaSu2w2xsYFUICDC+MzV3P0srIhBsM2i5qsr9R03inf1TtUZQ5e9Lypjp4vVKnzB8ald
	wn2nKnp8nWRiC2527q+Q3C/1oxH84ZY/KFVpxsqmn6rx8x9fYOS+degzgkfXnziEr0g3S01uGL0
	GzfqPpCs8YZNFPRIPkwe7sggUNdi01SdJzlC1CtkWA+TmNwhvqYrnu3hjEkcMA6R2iFWYYnJLOf
	94QqHmknbjGN/3KLjjvCw1yaC7jiH1KOCe8Hp6eENwewANBOdBff0UrU0pWpwv6k3uV7YOWCN/9
	lmkjttDQvIVpn1lpevBB71SkX0wbBVpM4NqUqqe+ujbK6NpLgdzGGYU71A9tblGVbSItRPLMKqQ
	8U2trK0F0ycl1iTJ5Kvw9RRac/kiAN
X-Google-Smtp-Source: AGHT+IGTdtRXRVBqo/etSZIrqHnDE2k5yUz+r6mePyKfylMditsns+sMecwWotZWB5+Cv8bZSvNjyQ==
X-Received: by 2002:a05:6a20:549d:b0:32d:a6c0:15bb with SMTP id adf61e73a8af0-334a7a5fed0mr16479924637.31.1760972022096;
        Mon, 20 Oct 2025 07:53:42 -0700 (PDT)
Received: from clint-Latitude-7390.. ([110.226.183.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f159csm8497919b3a.46.2025.10.20.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:53:41 -0700 (PDT)
From: Clint George <clintbgeorge@gmail.com>
To: rdunlap@infradead.org
Cc: clintbgeorge@gmail.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH] docs: ktap: Revert incorrect change
Date: Mon, 20 Oct 2025 20:23:34 +0530
Message-Id: <20251020145334.65356-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ba148c36-8778-425e-8c94-35ebd708fc80@infradead.org>
References: <ba148c36-8778-425e-8c94-35ebd708fc80@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you  Randy for pointing out. I am really sorry that i missed the
incorrect change while creating the Patch. I have reverted the
incorrect change in this version.

Fix couple of grammar and spelling issues such as:
diagnosic -> diagnostic
Cuurently accepted directives -> The currently accepted directives

This patch aims to correct these issues and enhance the existing
documentation.

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---
 Documentation/dev-tools/ktap.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index a9810bed5..faaad92e6 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
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


