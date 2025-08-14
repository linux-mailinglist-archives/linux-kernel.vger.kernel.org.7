Return-Path: <linux-kernel+bounces-769217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F460B26B47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B4DB62265
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216F52FE05A;
	Thu, 14 Aug 2025 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iDi3w90L"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984D256C9B;
	Thu, 14 Aug 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186051; cv=none; b=Gun4M2a4yIV8YXoNEjhC2bTpZU7RH1r2sl4NQs1PNH9f9rmfF0VNjXL2GPZVkIAwEjxRidBMDtutmgkdjTqprSGxIpQO5uqhl6vZtZrK5Lq6DOvA4OSVom/PxB3bceJF/TKKjz8SzQRFstptOodk1Y8Aa7PSfvOTsyRQRZBa4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186051; c=relaxed/simple;
	bh=Imt/CG95szkbrIF67vvhaiJ3vGrgJ4WnTzwuOgNJ+nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoSoVwBmv3dgwbymSk28w3dmTmvvNNiw4yaSRRnMrB0uThrSV57uYDTRcD49V2SPOYvp/f5PhpyScWFB0RjwS2MmaOECrZroGzYE0pUp5hobnAd2zZpIWmbjJHW3iSVcZBSK5C5dEz0xNJkqcx92fKbQZDvthehf3Bbl/GYJ6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iDi3w90L; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DD63F40AF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755186049; bh=+KzKeSXKpgE3Y8aAKGHjfgQDE1GqLmFfPVGjGHQTZD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDi3w90LK9KbYx4MujxXV2GyYr+MNc5f4UIvC2a3pGmFSGXjRA2GTk/m0syoGk1J2
	 B0RfGYrHycQqRr6Utv1jcD+AkfFkE0maQ+BW126a3rT8MpUWkXNEQz1xWVHTXWvp55
	 gtEcqSoRpeyQ5I8fjKq7BNXhbi7eZPw/zMCDy1tjTH/gsw7+TxpQKtloFthpC9Gpxb
	 +Lz6eDGuBh9nRHT5qRogvtVpMVYkGri+7H5Wv9Jyu/WsJDqsy8KeyqZ11I+fJZHOrv
	 DaEJuGHEIv6GDj++ZdYDCsg++fG4dRvPo9y7kUAzHsgPv6cOs6FGV2ouGByINHZWpG
	 4LF21l0PQd4IA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id DD63F40AF8;
	Thu, 14 Aug 2025 15:40:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 7/7] docs: kdoc: remove redundant comment stripping
Date: Thu, 14 Aug 2025 09:40:35 -0600
Message-ID: <20250814154035.328769-8-corbet@lwn.net>
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

By the time stuff gets to create_parameter_list(), comments have long since
been stripped out, so we do not need to do it again here.

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 998b1ece932a..a560546c1867 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -493,9 +493,6 @@ class KernelDoc:
             args = arg_expr.sub(r"\1#", args)
 
         for arg in args.split(splitter):
-            # Strip comments
-            arg = KernRe(r'/\*.*\*/').sub('', arg)
-
             # Ignore argument attributes
             arg = KernRe(r'\sPOS0?\s').sub(' ', arg)
 
-- 
2.50.1


