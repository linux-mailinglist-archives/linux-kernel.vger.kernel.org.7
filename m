Return-Path: <linux-kernel+bounces-765517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFFDB23967
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E041B67151
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB792FFDCB;
	Tue, 12 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CEhG2j8O"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6D2FD1D1;
	Tue, 12 Aug 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028680; cv=none; b=WbJEBSoUXQDQHoa8O/aWMBSKjKIgoH2uACFlVhdZRmsNe4qAX/QYJcym3Wh4/b72lVKldF4eOEC9DeYbs2/NZhxDGg5xgTT5F6RWozdCUDNLvJNV8SxRHSsE0AdjMlE8ZXkwSOFO/UxtDSe1UIOi16AVsPzg+N56pXDrRJHW9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028680; c=relaxed/simple;
	bh=JvmLJDhjDkB39xb5xa2t2x70gtWreP21qkHEz5iz6ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDwh8UjX4PcssfMJkiABJNkDe36YO543/i5DDAdDwgerRKTtV70p8u4Nx8W4WoBdYBpyzqivQa9QNJKBIDVHZfasCwzYf2rqwHwQsahuIIzv/tK28NCa+evzF/qMo+bwH8JzEqn7Fhxdz0TFx43yi8P7mZk6H0TTUUo8zy9I9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CEhG2j8O; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0658840AF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755028678; bh=KMPgBSRi3GGUx39cwLfxSPIMnecJC+f5rFtqbGJHi2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEhG2j8Oc7Gwysox55CrDtRNmoEusNauZPHgXjyw4usw7lPU0TyDGBZh3wSPZDPGO
	 aVDq4F4yJuGBTQzCra0sBiae9U1hGjFqAinItr3HMcRUhcA9zgeGksiKk4iYL57V7X
	 oxUYi0T3mVxZjfjuV0jq2Hwv0LYNihjdAzxDa05JhvC9Ax6fIC41krFS8Mei6pxV7o
	 UZoA4axFb1/1fJzE2syG8inbbW05qFkF3WLHRjnSGrQQUOR/jH9ohbvKtKqLxUe1ax
	 OET60SK1m5aIXk8ai1i19/jMiRpm3KZfSJjf04kB/1/AA5WyfyLPMnV5+eLnLCrwbm
	 cVCM5nMqxFDHA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 0658840AF2;
	Tue, 12 Aug 2025 19:57:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/7] docs: kdoc: tidy up space removal in create_parameter_list()
Date: Tue, 12 Aug 2025 13:57:43 -0600
Message-ID: <20250812195748.124402-3-corbet@lwn.net>
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

Remove a redundant test and add a comment describing what the space removal
is doing.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 96e3fe4ec431..53051ce831ba 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -545,12 +545,14 @@ class KernelDoc:
                                     arg, declaration_name)
 
             elif arg:
+                #
+                # Clean up extraneous spaces and split the string at commas; the first
+                # element of the resulting list will also include the type information.
+                #
                 arg = KernRe(r'\s*:\s*').sub(":", arg)
                 arg = KernRe(r'\s*\[').sub('[', arg)
-
                 args = KernRe(r'\s*,\s*').split(arg)
-                if args[0] and '*' in args[0]:
-                    args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
+                args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
 
                 first_arg = []
                 r = KernRe(r'^(.*\s+)(.*?\[.*\].*)$')
-- 
2.50.1


