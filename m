Return-Path: <linux-kernel+bounces-759529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2443AB1DEB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061F87ABD50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63472701D6;
	Thu,  7 Aug 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Gy4er/TP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4F2472AE;
	Thu,  7 Aug 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601417; cv=none; b=ovp9lNaig+D5ZwTxvzcvaeDSQPygDhm6YHGdKiSN14RCC2duYQ0A2dEQc4o0rwN5vokMnBmq9tX5d/1P65bZT+ogyhqeQziiomY803vTSOqAuPq8Ebmqk06mMxZpsGkUR0OuISFW4q48yZJcyZfEpgqP1neqw0shjDNKGfaUdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601417; c=relaxed/simple;
	bh=tbMgGZpRaCjDP10FLbn1GnJCo6mIb1HOMV4bFmHd/vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpLTIH+xGYDai0kKxsn5jbif54QYlrng7J6qXyHGIT8TK9S0mD3uy+eDqHe/34Z7OiKy9w7GAlP+sfuC8BdD1i+oQVyvKgqytBbhACBRNVrMB+PHrVot+NyKf7kJyE6Z14g4QsOJ3Jw7k4Yt2//fffWTEb1GGJClappxwvyBy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Gy4er/TP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3063340AE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601410; bh=vmO6d44uqcnUzHl4fvpCkwQ1jyHoTC/0aJaJguQ+Vi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gy4er/TP8mnDA+nhURdW09+yubtp/pbFARAZ+d28pwygtiTYJVgSau3NOuwiU7bv8
	 uP3GldwgCR3opXiUWIr4PfVmGQdQTOWZPs4fPAo/E/wuhXZa0idWMJVMkPrtqFrxqU
	 w/Adr2Nmyn/vpj3y3ATwKmcH0viaLi9SxyCYTAubZtUI00/IfQvmyGmq2BoQAvpHhL
	 pLN4nLRNoF+ywpr8EhqRWV9P2ayY4eag0Iq3xMpiqOPOryZLRSLFqY77hsTQQMkLOs
	 xqBLtXZsM4IwVVKt5V2bkeCNnUZ12ZeqdjAig0dXFDlYqF2Vg1iRuScUETGU5ACbxq
	 wFo2VFtOLq4Ag==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 3063340AE4;
	Thu,  7 Aug 2025 21:16:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 02/12] docs: kdoc: Move a regex line in dump_struct()
Date: Thu,  7 Aug 2025 15:16:29 -0600
Message-ID: <20250807211639.47286-3-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807211639.47286-1-corbet@lwn.net>
References: <20250807211639.47286-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The complex struct_members regex was defined far from its use; bring the
two together.  Remove some extraneous backslashes while making the move.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 93fcd8807aa8..aa6d11bf29b1 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -551,7 +551,6 @@ class KernelDoc:
         ]
 
         definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
-        struct_members = KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\}\;]*)(\;)')
 
         # Extract struct/union definition
         members = None
@@ -683,6 +682,7 @@ class KernelDoc:
         # So, we need to have an extra loop on Python to override such
         # re limitation.
 
+        struct_members = KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\};]*)(;)')
         while True:
             tuples = struct_members.findall(members)
             if not tuples:
-- 
2.50.1


