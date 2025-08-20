Return-Path: <linux-kernel+bounces-778446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C9B2E5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B787A17BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C78F49;
	Wed, 20 Aug 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8jPfogK"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004526E6F8;
	Wed, 20 Aug 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719283; cv=none; b=WWLzRUbXI5Pru8VF6QsPWKtKbQhEVNgc0Qk6M/mvSSp9EdA9ipStVGuS4n2OGG0JNIef6CT9H1UAXeCIKM1zUbOhDBmYhesa27tZcLsYLMISEg3z6EJqiotj6FVcb1lHxQ0lHjAOPMEXMGApWCZu2wJVCzn20RNtJm3JbiPvvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719283; c=relaxed/simple;
	bh=7qIOJgBGxwOndXtDf/YRbfMmSwGo+zEFbUIAXg/RPq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gC/kFUNUw1gi2ilBylg9C7Nds+tEZDBXOWt/WUZntxTlOHqin5KqAF3AOzTMG8KabW2xkglWz7VZHxnkIFSEYlNxgqJFQVDSjvz05Ag91EoqX2NRO/gIWYrGo3CRBmqqnZZ07w+DbZF+GDHCO27wzDruEkylB6f2k7lErZMaS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8jPfogK; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e666f35fb3so1158565ab.3;
        Wed, 20 Aug 2025 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755719281; x=1756324081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KY6KYGcofy9B+TK2ypLM7wptypx5fcgkdu8vnUtAJYk=;
        b=b8jPfogKEFWhdRLA3A4H2n7ZRtDgCYUrl1E/riqOA2EzAVAQZRbwVjiAqnGdYxxMA2
         YI7JqOkov958OtMF2QMI5UxiYlkHjGUaih9MYEdX9px6bP/Yrjtoqat9ieN2MkxROwUq
         sMTrc2yUv26OvXF1m+vcOxdbImzBY72cVVhvWRhvhFNIwoOwmKGgOGReI7DFrgrpGFvJ
         cLUb3ijpwzFQny49E9iigQCWtA4S/6nY+aLrhmZcahD9GJnofJ6h9IIF1OrUZe9BlmRQ
         B9oUfaCLFMD+SnqhWNgWe+bYxz0w3TvGXirZge233fRoOsK0UuZGMi+8XJSoHEO3BbZI
         OeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755719281; x=1756324081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY6KYGcofy9B+TK2ypLM7wptypx5fcgkdu8vnUtAJYk=;
        b=eJuIq7fDWVYk6PikF1E/mIhUsihdOGTMX9OxGeDl9XEYPWxwdxNB3QwVp/WnYslr5y
         XMo7Lnh1KE0jXbsGu5Gv0hbrXpEModRyebDewROxouE8Octp4ab02B3N8x3Ee9oh0H8z
         QHHWfwpULLK/J0DbFR4WGo0mzjH4Ou+ZxypZDQQpDOrQLhSojviRte01zXzxkhqVLqNN
         s1WUsKHecKu4pTHlrbQuNzj+k70nt9M97FRdWBuqX9rVhEwJdtHtKf8EoTdQDjwK/JkM
         fjLbcrpZu6LcIYzEGmt5+Dg1pX7dHUMLIcLXGHv+EbR6GRlbzJQ2FrtzoH3C2JsioG5F
         lmjg==
X-Forwarded-Encrypted: i=1; AJvYcCX/2UOCTR2NXVlPQfa2GgfiUM82ouo5Z7cbs8S2FMcF1wGgZdZC+re5bO2J6x6q5kNmRyINw/HlAupZFGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3od0zsuMrNHl75kqKS/O6O1wdmyOxey37XEyTeBtBFR015cK
	yEyg35evnvjaD82/8uSyaswDP1na35nnHBRnU/k2uV9wNjysEL9lfDFOQ09BSaFB
X-Gm-Gg: ASbGnctb0NxXUxU9oEAAzPKFzvq5OjkLd602jvzZ/slCAPR4aQNE4l7EIjhP3Xbsd+l
	sq52b8xJUtD8XpvuvyaSqCuIY39jgvxH15vv91q6GREZGnZbFiq3otd437yQhCiI3WjOOojGwIZ
	LsMjZSEM8LuQQj1YCNeQMeASbVUg9W1LL5zyr5tnO56oCx/+c3tu0io4SSeI/R1fBcgN8u72Ku8
	Bi0m0mnLMlN1SGIqXvISjXqgHO689FGaf4MZgXRBUFMBOUF0GRoudvv6rP9St355sQDaRa2eeAQ
	ZMejno0L/DFQaI29xomx3p57X4o6tbOEAaGp/WQGQ/a8ttaYle5ysLrnmK/7uRDs+FqXPvqODBI
	6riRi+6mnaMoR/+izPCO/B4cYfYvNWlALRUulFWDzYwpVc5uRCJfLxUTFV7bUWUFtbIcirnDgiv
	vOKXBM/5uWCQ==
X-Google-Smtp-Source: AGHT+IGnW1O/nM4BGcR/+kr2nJncspBQAwK6G1rqHmHSmC9/Rsvt/wGgSsHf0jD2r7w0bTGdk7DNzg==
X-Received: by 2002:a05:6e02:1a42:b0:3e5:3d13:5d8f with SMTP id e9e14a558f8ab-3e67ca08998mr70705235ab.9.1755719280796;
        Wed, 20 Aug 2025 12:48:00 -0700 (PDT)
Received: from fedora (pool-99-240-65-82.cpe.net.cable.rogers.com. [99.240.65.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94998c35sm4249485173.66.2025.08.20.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:48:00 -0700 (PDT)
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH v2] Documentation: conf.py: remove repeated word in comment
Date: Wed, 20 Aug 2025 15:47:15 -0400
Message-ID: <20250820194714.130513-2-albinbabuvarghese20@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a repeated "are" from a comment in conf.py

[v2] Resent with full recipient list. No changes from v1.

Thanks, Albin

Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
---
 Documentation/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 700516238d3f..55299665753a 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -224,7 +224,7 @@ author = "The kernel development community"
 # |version| and |release|, also used in various other places throughout the
 # built documents.
 #
-# In a normal build, version and release are are set to KERNELVERSION and
+# In a normal build, version and release are set to KERNELVERSION and
 # KERNELRELEASE, respectively, from the Makefile via Sphinx command line
 # arguments.
 #
-- 
2.50.1


