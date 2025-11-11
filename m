Return-Path: <linux-kernel+bounces-895823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10368C4F070
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F3C4E3F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79736CDE7;
	Tue, 11 Nov 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKxxuR+/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229A36C5A0;
	Tue, 11 Nov 2025 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878325; cv=none; b=YULoe0ihql5/piSA6x8/iagmTY4mgl5k7BJxdzGYChijS05+8hWVGJAXrdHvOAGN6rWy/0tqvlyi9EjRbwULoVJdV29FEXCXm2r8bAo3qwksPyIukDmo+w2czI1gHna7WfmsBY7u20ZmDbgyR2ylZRAzbLDNV86SERtbAw2QgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878325; c=relaxed/simple;
	bh=YdWchvOgy8gGRxhHOOtJy1b/Cfz9wucN7vsueWtnLLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVsiwDhbbolw8g7JGYTp7BhjMxsO9v+pWKzLneoOjeRt4ZEGWvx7Cs0gMXpMQwWjExVHUFz7FXCefuJAReTZXhIw55xgcLSbcNol3VjEtAgfg+wPTu7H9CuprBSbR1U70XU4CHc1FPPZExi708PWo4qURIRKgHiDiokUGGqYBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKxxuR+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814DAC4CEFB;
	Tue, 11 Nov 2025 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762878324;
	bh=YdWchvOgy8gGRxhHOOtJy1b/Cfz9wucN7vsueWtnLLU=;
	h=From:To:Cc:Subject:Date:From;
	b=pKxxuR+/ZkkBnbVgMJq0V++7zYgvJMKhPjIi+FrHVM+Lr3lwa/a7pAFi7KuOmlOy/
	 Byara9ES38OPy3eX3pRzVeGHkAypQPgPWplrB+b9PhqZVE4lUpmiMxxt0Obo5LUTgU
	 e3VaCu71g0Vs+KEmRI+4n4o8VvtRng8tuQkAZc6OIpPEhqDPZ88L9ggWV+NLj2i+yc
	 8czL/qi15bBWloIUxt/ZmmxZQegelJUZxOmnr63TYB/b+m7EYEL91ozS79b8Ihkrsc
	 tC/9iaIQHeBqg7eJltae4dUinuTR5scNyv3u2FPlkGxztV5KKSuQva8tGrqlwxstdh
	 ku0pA4MZXEd/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vIrBK-00000007szi-2Ced;
	Tue, 11 Nov 2025 17:25:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] A small fix for parse-headers.rst
Date: Tue, 11 Nov 2025 17:25:10 +0100
Message-ID: <cover.1762878176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

This was supposed to be part of v4 of
https://lore.kernel.org/linux-doc/87ms4ty8ni.fsf@trenco.lwn.net/,
but it ended I didn't merge it, as I forgot to use "-a" on git commit...

Mauro Carvalho Chehab (1):
  docs: parse-headers.rst: remove uneeded parenthesis

 Documentation/doc-guide/parse-headers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.1


