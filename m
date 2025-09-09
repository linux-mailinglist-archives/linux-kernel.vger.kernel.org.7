Return-Path: <linux-kernel+bounces-808992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF122B5073D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147C44E696B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CB35AACA;
	Tue,  9 Sep 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="L5Ga6r3v"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A45199931;
	Tue,  9 Sep 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450648; cv=none; b=jDbgqdpL+SxpmtLIRLS6yzuaS3GG2fG6SgNqdwJIarwrGlFYx0hd1zPS/D3v9yrtbF4t97fK+FYPG1OkeeGCO1Cj5mLBj7tbJoTmgAfdgpcY1gsmsi4X2yt9kA2JiCRf3MiGA8rOQnmgNC7By8E79GHvn5w9p1ZbkiHCxkRrq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450648; c=relaxed/simple;
	bh=x1/bcEkt00Wt82HM1SB594Orp1NncGTyKCPRZO6ovu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ig1EHX9DZqhT7Zqq1QeF9/MtXbUKnFtzEAuDqh2E7YzhvpEuzVpTa+O7keY1IgfFfPE+DbZ5W/xCvtGsDYaBFCyixjm1WacqpAnG9wPSIdAbaCz6Yk3p9FYwofxurlFMEPRnLpb3QKJIBXdM15VRgovZvIb1+5MWywWBjficjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=L5Ga6r3v; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C464440AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450646; bh=4pc8eGK15FdLw0vhlpmD0GYE68PFPvZjLCldAwCexOU=;
	h=From:To:Cc:Subject:Date:From;
	b=L5Ga6r3vk5KcpHWrltwzhC1cGSi2u5GVmWwvtTNNyVLE4ELjzyFXmNtCwYtZzOtVL
	 uNeoRTDffTdBtgzYX693h23YwCATyBMurb1gwoyEEEd033T0Y5+Y0OCwNamONnCl98
	 z2Gav7jNS5XYsmIYeE8QT6+mARITfvEyHZlbNOSvNBCUiEqwclv+Lbb41cUGc7w1qI
	 FvOkEeCSitsXKxhZYBEQBky2Rk3FYOj0gFFLLmP9XiD9IXqMEFbCmUVSDvf3QDKeYQ
	 3YVJlnoNjqAojRSciQCocPmVXQZZcGEuSOotSoir3DOfXovW+c8tbJJ0+ld19c2WEz
	 4ov1qvIitdPRw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id C464440AF5;
	Tue,  9 Sep 2025 20:44:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 00/13] docs: kdoc: improvements to dump_function() and thereabouts
Date: Tue,  9 Sep 2025 14:43:36 -0600
Message-ID: <20250909204349.123680-1-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another series I've been slowly accumulating as I work to understand
the new kernel-doc; it consists mostly of fairly straightforward
cleanups and the addition of a number of comments.

This is likely to be the last of these from me for a little bit, life will
be hectic.

Jonathan Corbet (13):
  docs: kdoc: trim __cacheline_group_* with the other annotations
  docs: kdoc: tighten up the push_parameter() no-type case
  docs: kdoc: remove a single-use variable
  docs: kdoc: move the function transform patterns out of
    dump_function()
  doc: kdoc: unify transform handling
  docs: kdoc: remove a couple of spurious regex characters
  docs: kdoc: remove a useless empty capture group
  docs: kdoc: Simplify the dump_function() prototype regexes
  docs: kdoc: consolidate some of the macro-processing logic
  docs: kdoc: final dump_function() cleanups
  docs: kdoc: remove some dead code in dump_typedef()
  docs: kdoc: remove redundant comment stripping in dump_typedef()
  docs: kdoc: a few more dump_typedef() tweaks

 scripts/lib/kdoc/kdoc_parser.py | 269 ++++++++++++++------------------
 1 file changed, 120 insertions(+), 149 deletions(-)

-- 
2.51.0


