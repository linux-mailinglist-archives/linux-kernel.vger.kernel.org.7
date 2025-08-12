Return-Path: <linux-kernel+bounces-765518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE60B23969
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354981B6734E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB236302CB9;
	Tue, 12 Aug 2025 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="d9aQ/asY"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBB2FF167;
	Tue, 12 Aug 2025 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028681; cv=none; b=Bnq3xSdCZiLsjaYqpRlRJW+s3F0IluesZrIhELlvhVVov4xFmYJV+0+d2b8W8tz5Cr9dGRWCrt1p1t4C9dyklfYQ4+XK4Vv96nX+4Ns68cGotrgFjzCtDp0P7EjssjZZD2uitha4b8d5s0TgXGfmIjpih2jpfc3JuNJ3kXZiDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028681; c=relaxed/simple;
	bh=OBhaUtTMbyBlh53qINhRG3itKYtY9IvNRUlFEQmkpv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKDmootcuaJYf8Dkbk2ge16ajhx3wEFRFvKAIs3sLwe40o2LG3eAl2xsQ+yatP/StIX//BtSp7LbMyDtMFNpJ16LttBEMqOQKfusPfuJR5t8h7LM1p/6nnZ7+m9ok5MrH768O1/PjS2/wyP9xve2XI3aKmTIJXfSrBsPFX4ZAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=d9aQ/asY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 95E3840AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755028678; bh=jGM1icqt6gjQ/B6dtIFBPdZEfj3b0lX+FbDflq8OkGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9aQ/asY3QyX7PGfHp7GQXKL8CtOI9KrlKF4fte9P38M0pDSl80hX4Ele/SUiShTr
	 jv/N6uKDA9UKpqsBOwmdpIQsGq5KBJe92lOTDp2B6oyOQtLiWvFOwO9iaWBjl5LTRP
	 6pjGlchmY0WRtGZnNxpc/kXQPEwH2Vwz8zRQja/QfehpLhSmy8p8LM3Dpj28902TPg
	 Syex+gPfGza0XMkGYu5neJAf4mWwwab0mLLRtPYjUQ7BDHWXHqnBKH86qsjA9Anw2V
	 JyafiAcfL+8oZt3V3zLNo/CzJ8otLE8jMxrnsNSVE1wD06wl6V18+AbNipqdc7sCgb
	 miCaiTOyN9PJQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 95E3840AF3;
	Tue, 12 Aug 2025 19:57:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/7] docs: kdoc: clean up the create_parameter_list() "first arg" logic
Date: Tue, 12 Aug 2025 13:57:44 -0600
Message-ID: <20250812195748.124402-4-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812195748.124402-1-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic for finding the name of the first in a series of variable names
is somewhat convoluted and, in the use of .extend(), actively buggy.
Document what is happening and simplify the logic.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 53051ce831ba..47f7ea01ed10 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -553,18 +553,18 @@ class KernelDoc:
                 arg = KernRe(r'\s*\[').sub('[', arg)
                 args = KernRe(r'\s*,\s*').split(arg)
                 args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
-
-                first_arg = []
-                r = KernRe(r'^(.*\s+)(.*?\[.*\].*)$')
-                if args[0] and r.match(args[0]):
-                    args.pop(0)
-                    first_arg.extend(r.group(1))
-                    first_arg.append(r.group(2))
+                #
+                # args[0] has a string of "type a".  If "a" includes an [array]
+                # declaration, we want to not be fooled by any white space inside
+                # the brackets, so detect and handle that case specially.
+                #
+                r = KernRe(r'^([^[\]]*\s+)' r'((?:.*?\[.*\].*)|(?:.*?))$')
+                if r.match(args[0]):
+                    args[0] = r.group(2)
+                    dtype = r.group(1)
                 else:
-                    first_arg = KernRe(r'\s+').split(args.pop(0))
-
-                args.insert(0, first_arg.pop())
-                dtype = ' '.join(first_arg)
+                    # No space in args[0]; this seems wrong but preserves previous behavior
+                    dtype = ''
 
                 bitfield_re = KernRe(r'(.*?):(\w+)')
                 for param in args:
-- 
2.50.1


