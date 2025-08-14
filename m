Return-Path: <linux-kernel+bounces-769212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A6EB26B64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E0C1CC3E64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248F2571CD;
	Thu, 14 Aug 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QIeEBQcn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47A23ABAF;
	Thu, 14 Aug 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186049; cv=none; b=BfsPV/QKu68VsEwCo7sc4c8O6GHv3jJ+iGib9QNmF0IU3iBB6tgPi6BmxjOwlYVJc8P+Z+++v45TfMJYxDsrMEb1uQv9AVksXIPi0Mqbl4U/FSFKTV49Kk3mIaF8kMBvwYalJiFe0zRtf38+z5PT44XnkR5Z18RAo5dNNkcKzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186049; c=relaxed/simple;
	bh=28F8C/NhsTapDShFQG87dbSaXHiEW5eNCvsqqW7MNx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n17tpTEuEExxfYbmYyr3QSoE1KbFt+mjiGi5UdvFBp+jMX+Q9h+cWJbM1D+C06n3FLy/VLG0LrRtb7Br5lU36/kB+DEGoiPX1cjG8BSY1z1tcdRpg2HNnXLmCgnBiyYSKwjUoaSIT0DvKpwngnnyWYv6bdomID/gmtu3x0moLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QIeEBQcn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0EE9A40AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755186045; bh=9uaRAHZWdznycc5uOOSPbqkjtsTiEE7IHFczLLA5sWs=;
	h=From:To:Cc:Subject:Date:From;
	b=QIeEBQcng3XOFK/aFaiyLk90kpbfcpYK5c3G/wteCqRdmrs475BZYVtWFJkBA6hJa
	 J9eAcVgAQHonfWS3GSt3o+NTliNt9uv2YraQCs6ZL+5YHSlcMR37HIS4RIB7UqL5zE
	 yNwKXhqs/h8tPNfWZ/QNCqgg6ZRaYrL/aIrOG84dSgygPKOVyUa99ETok6WYDhpkA9
	 xVl8eswvkBxT68BNsA8myiiZkXpq6wTyCc6JtNXQkOs/gBp0MYnktNALSrfauGT07w
	 8mG7qTr1z5mDlwBZ+fWmfUCMSmhVhkaNsaKyn+cIgRAopTe3iatfbph8mcF9Cx/RST
	 LFLhonS0Q9spw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 0EE9A40AF3;
	Thu, 14 Aug 2025 15:40:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 0/7] 
Date: Thu, 14 Aug 2025 09:40:28 -0600
Message-ID: <20250814154035.328769-1-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

docs: kdoc: tidy up create_parameter_list() somewhat

A relatively brief series to straighten up the code in
create_parameter_list(), remove unneeded operations, and add a few
comments.  No changes to the generated output.

Changes since v1:

- Put split regexes onto multiple lines for improved readability
- Simplify one overly complex regex
- Improve the patch 5 changelog

Mauro, I've added your tags from the first round - scream if that's not
what you wanted!

Jonathan Corbet (7):
  docs: kdoc: remove dead code
  docs: kdoc: tidy up space removal in create_parameter_list()
  docs: kdoc: clean up the create_parameter_list() "first arg" logic
  docs: kdoc: add a couple more comments in create_parameter_list()
  docs: kdoc: tighten up the array-of-pointers case
  docs: kdoc: tighten up the pointer-to-function case
  docs: kdoc: remove redundant comment stripping

 scripts/lib/kdoc/kdoc_parser.py | 100 +++++++++++++++-----------------
 1 file changed, 46 insertions(+), 54 deletions(-)

-- 
2.50.1


