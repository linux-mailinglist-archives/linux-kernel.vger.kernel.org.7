Return-Path: <linux-kernel+bounces-809003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4148AB50753
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13994E89CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190836CC79;
	Tue,  9 Sep 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ErrT+I+W"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90045369341;
	Tue,  9 Sep 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450654; cv=none; b=aexCwl/5E7bg8kbKDpRxZacYlukJs+ixO6MbDG5zDndxM8twsXyWaVwQ+tmDY9jjVK3pK3KDPFD07t+UDjYTex3LyusK86DEEzYAKmhxrwcntxlNf0UjHksrWSbJNf7ED0bPOAxfgLCDbzsqOzM41RveI3FAq1HVmxbfuhSWWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450654; c=relaxed/simple;
	bh=5jYxorbLgCEpYTieVLb99AISkxmhC85Kru2W56AqpFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrfyJu5BZPCTdRZFLAlYYTL8uuJbW9hbqkQQpnd/cT6LxO4ntTBIDNuYTe6Bi3bnYz+ulQbv3gtimyWlotFNhqtrEsRh4J9iJkcIpH/mhirz4CgxUOjvEe6bt3oxALrBNwr1z66jut2rVkbZe6SsSeSds1Pz5QjCN8yHMPY11Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ErrT+I+W; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AD57E40AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450652; bh=9kn0Au9AyM4/U2zNWSXOAZeKscoX0rDzipkOnd9Uri4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErrT+I+WIL20KD3e//Ww1AIuTT1ydccMVlYr/iUVPR7MGDLKKrYGq0mzNghWsYVAM
	 ZTsHjuDS4FBRbIUH33GhveETW8ynJyY8sKe1sxB4g4MBYMC7UozHo16nx1YipLlyd1
	 AmHJX0mlJ5pBRUidWd8r0SMRz1QT02ZDwLkQjnVIZi9sJ2WS+XcsVdpWoDXEvIOsaF
	 Sq0RP/v2SOL+cG1C9GxzmKdvPzTkrWwGLJoU4Fiu2i4E2lK8M8mHKbWEU1/2Kq38HW
	 /Ibj1bWvdYL3GMYhGofPYg3JoKfwCBX0Wg2GRiJVtFxE9SJ+X1Sh1+sdH0JtFbd5Cj
	 cT7lOfaN1UgsQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id AD57E40AF5;
	Tue,  9 Sep 2025 20:44:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 11/13] docs: kdoc: remove some dead code in dump_typedef()
Date: Tue,  9 Sep 2025 14:43:47 -0600
Message-ID: <20250909204349.123680-12-corbet@lwn.net>
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

The regex in this block of code makes no sense, and a quick test shows that
it never matches anything; simply delete the code.

No output changes.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 5e41acfef7b8..7c739b495d58 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1060,11 +1060,6 @@ class KernelDoc:
                                     purpose=self.entry.declaration_purpose)
             return
 
-        # Handle nested parentheses or brackets
-        r = KernRe(r'(\(*.\)\s*|\[*.\]\s*);$')
-        while r.search(proto):
-            proto = r.sub('', proto)
-
         # Parse simple typedefs
         r = KernRe(r'typedef.*\s+(\w+)\s*;')
         if r.match(proto):
-- 
2.51.0


