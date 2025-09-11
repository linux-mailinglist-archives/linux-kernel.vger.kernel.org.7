Return-Path: <linux-kernel+bounces-812870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAFEB53DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422985A5BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B4B2DF150;
	Thu, 11 Sep 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXDYUqkZ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0521D5BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626731; cv=none; b=kJSAfXiWkkalrl5DAMAURhSMm3c2lCm0WChaA5RBH6/ExYp1fBYkoo/P8VZ7RWPJjSkVz0a3sZ/eEOe2/8XaPaVXNN9of8w5APbNC/4s2ZppboFF0NGD4PZoyYfSDYrYxJ7bRl0d9ykqx9YOYXzw6xn0Y/X7ScAbOyWYcMo3KWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626731; c=relaxed/simple;
	bh=sPUfeSm5BrFc1JGDfQfBW2rqApZnuuum7JmLHXwQcOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3nVybej5H/93slomv8Jtcm4+F4N/01lnrATwTEkOp+Ew5la4Izp8boYJBQQhELOO+QozdcxEY7xT2y5FuNrMsuQ9vYyn+r2LsB0VXNeEo94AkJg/RYK5qlBdyMeqVSpmU6aSKvOpNHKqYk3uKQuCev3yR4oLbe+ObXxxENT+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXDYUqkZ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88f49be4c21so34962139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626729; x=1758231529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upmZ+84nb0PGLfZ0odEvQVtU0YnnK5GejiW4j5Z157Q=;
        b=jXDYUqkZIfafaaj564KOcErXS5ZpLDxorFCOtZp67qqNG1qB9tr76exfynfa7cZy4y
         UKcbgXoqrH9VlBhEsYwZMo4fwHBPam09gXnbLuHuUg23T8W3aJBQWzfTIgwZNKplLX4d
         dXLv42xlGN0n2MVxy2BCE6G2xgwRlru6Erq4IdPQvCgc3Um06Xglbq0/q7M5f1KmZPNV
         4m1rsfO3j0p36bP1iD344l7ZaEaycXGKn9G4zo3ArAcFwFkyzRiMJKCwGw4r1ggOrF6R
         2C9X1wz6GINhyBZq7xFucFWrDxxqv5ryzAMftciDTHSC6Y+tI9sfli6OJmbSmOmDLRZb
         0q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626729; x=1758231529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upmZ+84nb0PGLfZ0odEvQVtU0YnnK5GejiW4j5Z157Q=;
        b=My409qU42+GACzhC+NVNNHdWU3SmhO/QkY2V+zJmEyoLuja05nwyd7DIQ+tdxriFFX
         +tt7Z5DOxqQKv6oC/xtO8y7AIumqKPpILU9RLIxyXEs46+lUL0fDXv0mOAZcwENx61Nd
         PEFL748kkmJiKxmchtySmhXwHMkuulrJKV6Xiw4VRcSGfCnpkhb+OLgdxILJ7NY3nNNb
         fg6KFQAVn3i4gSQUxcldrKxPKxgdJCMeO/sgbyQFh0ukLF7/E25cFmmtCiJi2uidfNGb
         UIn0b0sh4+x9w9Mr9STzKx2uTFzCGFOtVoUJsXWdx/xgY7cgM2q2ZSZ9LJuiApe6ridI
         zm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdLxa3MK2AYvvLSvA9lJfOsZwB1z9RhT/5G9SHU+i5DWjffOXUeLDcJcjy8Xolj1ZYE0xKONpfhX6OxRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKczOUSTSybq5jW2Qolts9CwdHCKrfPRhh0PrgLGa+5qsgXH0p
	as3GDOqgiJWX5Cv7ZTeAELtJ4xeDxJBe8k73EWPVsqyvGhGXS4ebgQ+m
X-Gm-Gg: ASbGncvGqDM4y44kQwQ4R0wMjyzghRDv7qVbRjwbs30hqF0gss+0TTfujpDIFfpLNrt
	AUmE3dkhEwHlEFK1AtzOYFv8P92Pzu281fEklOnG9ij4cL949UEIgNUfuRJekyBl9G0d+mzGcdd
	QAN55JBh22tfwkb3GsMjeOQA+dcP9x9n+YwFhITBE5b68/WL6GWFQaPMXk7xYOPDYylXfDVN8st
	3EQgVjxWipUT0wqu9k0SivepL5nIn9gSGoa0V+spU74ZRw2cRcUnSNoTHTFMnkG5hl7rIjj8LgN
	4mF1PeIXQysFVIRLz5BxXg4zfbw8aWcOL5A1COWPabMSmPDZA8ntF7WHd3dyp8YDWZsBkpDmHF4
	3xhfgnkXxkuuunm144nm7S+1c3l4efdsELlsvRy8DGV5KmM1g8miu5PX0/JWXl59Wyd+ExDjf54
	3IwGU=
X-Google-Smtp-Source: AGHT+IFu8y/WUPR1ooMKGsVlSMKShA3ec98P60+uCdhE86rchCRKo5RimU6XdoYh0nHTIMRHf5T/Aw==
X-Received: by 2002:a05:6602:6408:b0:887:6330:d5a4 with SMTP id ca18e2360f4ac-89032dde9d3mr121777439f.5.1757626729147;
        Thu, 11 Sep 2025 14:38:49 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH 02/30] docs/dyndbg: explain flags parse 1st
Date: Thu, 11 Sep 2025 15:37:55 -0600
Message-ID: <20250911213823.374806-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4ac18c0a1d95..63a511f2337b 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,9 +109,18 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
+Note: because the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword values.  Flag errs will hide keyword errs:
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
 keywords are:::
 
   match-spec ::= 'func' string |
-- 
2.51.0


