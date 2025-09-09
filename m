Return-Path: <linux-kernel+bounces-809004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFC6B5077B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAC23A2DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350935CEAC;
	Tue,  9 Sep 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FWLdzBuL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C15369996;
	Tue,  9 Sep 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450654; cv=none; b=KVXyqdSEchYOPWtfs7O+xnXfdzQl3tS65MIVgGA80OrQ4p/2k8wI8ySOcaA94575Rxhn573MVWNCAYZJ7nlPKmZe9UYD4AcwNQsApMFiFP+63ZI9P7qj+O6Xr06SaFOuBqSBR8FkhysRaQ0XN2kvFa9Wk+lduo/zCx7iZ7zkyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450654; c=relaxed/simple;
	bh=7S5dUGAfJGWm8b/CJhy4nJzu5ZjFZu1HP4LLrFgDvUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN0Y+3PdDPkeTB/oMBgdrwEVNBNEJmzY90EPlrM8pX0j39+lG1vSfB4BhrbtP/fs34UcLfBrAYGkTZDaqEFfnytRwmwy2OElYgv7SbJhWvaNVdHK8fdaXZ8yGw3SpcBo3lrb6HQd80UopE64mSIx9P0HJgP+DYofAKzAeU6cbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FWLdzBuL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 43E4E40AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450652; bh=1ifSUfKnsb0QBGqZsGY9eFnpqWQlv1CiBS0YMJAWZlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWLdzBuL5JSgOlDHTv8fTvqIlFccx1sUkwd3zytWRl/8pJObeYNakFkNrxCmmZKE1
	 DOLZTseQAjyZyJ2y4Sx3P3Y6zBn5v9Vyaa3LAVNz7II8hzPT70z6NnTJZCFn5+qp9v
	 2yhuu15bPn99dyKWXokfZAxPGO8N7ODtDIqXXRKak8dQzyzw86dfTC/ZO4glM/g8Ns
	 t52+MZiBOJDy87yCH/KUIcfj1BXXLGlNm5eeGRCOqug/ZIFfebOi4aslgqDQxHTwYg
	 ObyzpCjeUxi/KCk2WTcUu44tazXWEf2OnMUfgFrfZ0qp075AY2bMU1k5SlKwegHqii
	 GlhbMN0xnQ3GA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 43E4E40AF9;
	Tue,  9 Sep 2025 20:44:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/13] docs: kdoc: remove redundant comment stripping in dump_typedef()
Date: Tue,  9 Sep 2025 14:43:48 -0600
Message-ID: <20250909204349.123680-13-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909204349.123680-1-corbet@lwn.net>
References: <20250909204349.123680-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By the time we get here, comments have long since been stripped out; there
is no need to do it again.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 7c739b495d58..ad9df0536bbf 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1034,9 +1034,6 @@ class KernelDoc:
         typedef1 = KernRe(r'typedef' + typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
         typedef2 = KernRe(r'typedef' + typedef_type + typedef_ident + typedef_args)
 
-        # Strip comments
-        proto = KernRe(r'/\*.*?\*/', flags=re.S).sub('', proto)
-
         # Parse function typedef prototypes
         for r in [typedef1, typedef2]:
             if not r.match(proto):
-- 
2.51.0


