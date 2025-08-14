Return-Path: <linux-kernel+bounces-769213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAFFB26B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5536A041CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0B623BD04;
	Thu, 14 Aug 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FBZPQJzv"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DFA23BD1F;
	Thu, 14 Aug 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186049; cv=none; b=i5/Gi6LbzJplxH5S5cQcC4K0tvEbIT9AX/xnl7lLDBuw1M6DMu0dIrL81D8gRPAUUSVobp6clssquWVG9L2OnnRKhGNGXBx/NqBOoeO5SGKpphaRp1S5sawX/KtsK1jO2WbEJ18h36rqQKEMI2a2Fuk0A24/reUCiocIctnQBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186049; c=relaxed/simple;
	bh=4iEX1t7jEAeEe7ybDdIUVO/vmvtgOs+kPaaWmmIsuiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j82a155nCYIFN5e0LSv5uaAwTRrffmTJpaqFghMevv1ftyjP7kst7VqQo8MK0izZA+hOhxyI9Zqt6pKfCsAk3bDhnnCrnF115IhWmPBCfp9IHCri+kR8IBOHfNNCSUrayUpa30i2/SEcl4ai6wEcvzTxFmvAn1/IcT0D9YxKpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FBZPQJzv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BA71840AF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755186047; bh=ZAeV3z1UZGaVZP5QfUsLli80+tuX1mZukp23m87DZdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBZPQJzv7WIpwqAuznJZGNOXeLk0+ZG+QyvGgKmoxlwQrOKflW6zKRD9NI0rzFND/
	 tTGJ6L7dxDBOmG2qUZqrvXuO5Ebd/A6cjXekvHvAFPdGGsNmEds/ToJuSXUgtqLI3w
	 7Z37Sjs6drj9Rvln6/7zCoctn4AuoOmCTUcvXzNOUQBtabdtQcvHkSsPTpIBsziMhy
	 tWPwKPt3zohJhsP5lBb2rR17lfYCyj/jM9809Xh1x3Z/Yw7ZcarkV+CLe7RPM9xoiS
	 NF+7oxrSQRZgWkDMZLpcHk4BaIc+4IeG7cwBqKvkhBToD9WoyEnnLNQ6mvOecmog/Y
	 okPMyESANeU5Q==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id BA71840AF6;
	Thu, 14 Aug 2025 15:40:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 3/7] docs: kdoc: clean up the create_parameter_list() "first arg" logic
Date: Thu, 14 Aug 2025 09:40:31 -0600
Message-ID: <20250814154035.328769-4-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814154035.328769-1-corbet@lwn.net>
References: <20250814154035.328769-1-corbet@lwn.net>
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

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 53051ce831ba..07234ce04409 100644
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
+                r = KernRe(r'^([^[\]]*\s+)(.*)$')
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


