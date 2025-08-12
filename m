Return-Path: <linux-kernel+bounces-765515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6716CB23963
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C4F1B61998
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC4A2FF17C;
	Tue, 12 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="TMPyhi/5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193162FDC2A;
	Tue, 12 Aug 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028679; cv=none; b=U2qmiJD0Adqc6grwRhBO9K6aH/i1skP24By1lEfrNvTfX8kNs4rGBqBEUAL6VUx6X1kJOUknYusD1wh0rkEojSMEWeORuVNZl92o0YCJk/xvjkvghxqyb0s0o0hc08ZE5zjlhI8ufy67oKLzVKd/uwo0AR00Ll42ILtGD2S6hSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028679; c=relaxed/simple;
	bh=ff9MZ3twqiawY8AP9yPIGXkZEPlec3Pwowbz5tBBMhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPdPY7wUiT2mPPIm+l2KI8fHOXCvZMmHJmCfmjJCItrJUcEP1VPdeahysQFKQIfaszKDYLQDQPeBI9QrFXbUx0klLLNQjfJJZpXG/zWjPT31HJ6DWdfxyDqHKJGkXS5MLOXab7btU3f1bAfIn6JRGqf0mL4cmNoYaVUvMkr4xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=TMPyhi/5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D662040AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755028677; bh=GXltM6bObH8LlmtNIFS9nAUDLZ3f9XYsC5S+63MqLfo=;
	h=From:To:Cc:Subject:Date:From;
	b=TMPyhi/5q30gQKiqTBSvmoeATn6RqCHpBS+LT4Gpnslsf2jqvw/gXkQcx/2q2837K
	 mesAejHThtD8rnHG3TEBrVoPTPYOTnKyfAT9px7BtVfmSAI7h7RTHoq0yAYgX7D23o
	 mJg7Wu/FeDrdEXA9keqH3ekxDLATo0mwEojAxnQcUh7r0lLdV8DpL+RR1wguB34ElX
	 6HbKbjfJQCqUsyGTk3GvL+kn8oq9lxHsqzH6q2MsREFW02eZf0/5natUNTKXMr/orM
	 Um5B4RGjCkPLaPqOw12QtPfrhljrPh8b36UnWWNU5m6XqRbojGUIwCCzb2z2JH+Xgy
	 XS7r2i3WSQWaA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id D662040AB4;
	Tue, 12 Aug 2025 19:57:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/7] docs: kdoc: tidy up create_parameter_list() somewhat
Date: Tue, 12 Aug 2025 13:57:41 -0600
Message-ID: <20250812195748.124402-1-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A relatively brief series to straighten up the code in
create_parameter_list(), remove unneeded operations, and add a few
comments.  No changes to the generated output.

Jonathan Corbet (7):
  docs: kdoc: remove dead code
  docs: kdoc: tidy up space removal in create_parameter_list()
  docs: kdoc: clean up the create_parameter_list() "first arg" logic
  docs: kdoc: add a couple more comments in create_parameter_list()
  docs: kdoc: tighten up the array-of-pointers case
  docs: kdoc: tighten up the pointer-to-function case
  docs: kdoc: remove redundant comment stripping

 scripts/lib/kdoc/kdoc_parser.py | 96 +++++++++++++++------------------
 1 file changed, 42 insertions(+), 54 deletions(-)

-- 
2.50.1


