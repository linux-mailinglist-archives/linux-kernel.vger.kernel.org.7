Return-Path: <linux-kernel+bounces-752752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4870B17A82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACE4188E46D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5044207F;
	Fri,  1 Aug 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Nb7Cykvc"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D438C11;
	Fri,  1 Aug 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007225; cv=none; b=fyQ/nXWXktLGMEkN7oJJnQoQA80HAgaSVqLe/X2xkwu+0DgcEHDq667NLPML0hFO2ufKELw07XMatCzT9KxO6z8GjKZSYWJp/Yn5BrKMM2xii51Gf5pl1DSJZXccitvhXGfiuJVq/SZZtYpFKqNKFIxJ//i3+9v5Ehi5DCiDcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007225; c=relaxed/simple;
	bh=op22pxxfC1qXD09BhvHCY4wVeYqrF211zaxQRQ5DQNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hquIw6nycrGkwuqsO+BDNvZRjk+aq4iEKe7De9eiqAp+HX1cUPaWhxLbOvoX8aFoGiYksEOhYRhVRXydfgW0zxHOwdOKbZ4/HNqmA1gJ1ydkcKVYZFliVRAQNbEr7rIKdy20SXVzsKuUIBfNBS0b8NXZqwQNYYHVrnGhr4KR7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Nb7Cykvc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4AD7040AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007219; bh=R152Lx6LEIOU/wqrwvCtDXqUSZvnz4jIXtOr3wAg6rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nb7CykvcmOdg/uTT4ramExxz3hH4zXGTjOgr+InFxSAeII8IKneVKRLpWwRzzEaQj
	 r2XtCAqSWR9krju+8th6MoR8vhA84ZWHZARo1dXY08acBhjKofSRCOZHWWUnSyZ1IO
	 HA0dqfhKX72WB1C0W2T7B3iSX1z4khQg12bXFjG5FuLUcwV+ffy3qOlXv2a4oJp49e
	 1uLgQUHhSWrb5ygiSgsIB4m0ybiQ1TIC3V7Vao8eWxS/9vm74lmjbY06Gpjja7pXQM
	 VZBr0Oqbfc/Q4sKFuXYAvZ5W4qxgDgxgpu0wtA0DErpifARgeP1hiLoXOUooOHEhcz
	 EJK6WQbE11uCA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 4AD7040AEE;
	Fri,  1 Aug 2025 00:13:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 08/12] docs: kdoc: remove an extraneous strip() call
Date: Thu, 31 Jul 2025 18:13:22 -0600
Message-ID: <20250801001326.924276-9-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801001326.924276-1-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

...the variable in question was already strip()ed at the top of the loop.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index efc5888fcc74..b751fa8edde7 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -703,7 +703,6 @@ class KernelDoc:
                                 newmember += f"{dtype}{s_id}.{name}{extra}; "
 
                         else:
-                            arg = arg.strip()
                             # Handle bitmaps
                             arg = KernRe(r':\s*\d+\s*').sub('', arg)
 
-- 
2.50.1


