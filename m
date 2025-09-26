Return-Path: <linux-kernel+bounces-833907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90126BA352C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE271C01C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933F02ED870;
	Fri, 26 Sep 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf7d3QVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AD2EC579;
	Fri, 26 Sep 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881792; cv=none; b=VBVgdCrrTBdn+9BiUsUnX8tZm4lHQvau3Pq70K/hCcjBwkUEDsDOO1ZoWCgkkYGMkkxNwpVjDXao7Zyo4TEt6tLOa/9yEgia+BaHJiCqagRZdFPif9khm+ZtpnQ6kRDfEwTobPy2izJ1XmrgjWlA0mnbAXFCVqnGs1T6msSDYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881792; c=relaxed/simple;
	bh=ujZRAe7rPt3AMIWHhiZBkGNb3QPKogTDKXEOZ3UroOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qhl5iON4IQZs8VLkmVDpXq2k1L9qVKg38DLwY8erAZNNXhwwcAL63bDBc+tICom4ABUhcfPZ5IR5r/xkKSP0+UINiVsZ/vk5GAZxIPa7Q1A3Go2zZUmE77r3LApmc2saQvmEBsFo9cLoazb3Yrjjji1tqheLzGUiDjp9ItnF7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf7d3QVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52919C4CEF4;
	Fri, 26 Sep 2025 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758881792;
	bh=ujZRAe7rPt3AMIWHhiZBkGNb3QPKogTDKXEOZ3UroOA=;
	h=From:To:Cc:Subject:Date:From;
	b=gf7d3QVgCJcbgRYiKscg9RUwvL8C7GL7BC+jYnDw4nAnT1s+mnTGcn7r5GQdL7plK
	 L1VWi2qbLZNkOCpKaz+R82H5fbmbGQWnelgXhdS+B4PqryfQ/wTY9r0m1v8tbps7Mh
	 Wp0UK3X31Ck2YF3oGEdD7wbaBVRW2IaIftzYv8jJGIWPkN9nwq2W8rudO5/EMWgvtt
	 Zww6PcO9afx34cA6KuW61HpJC2qkKBwzXCuyUFFSicA19j8Iril1W3Lin94iQZVepa
	 xBpUFtBAlb6f4CVV1vaIzjPDe3fPy6QXNes2BvsDDFjgJ/fW9iMZeQrydbFOgGv9p8
	 Igk0Hr6Q4c8sQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v25V7-00000005Xoj-11DE;
	Fri, 26 Sep 2025 12:16:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 0/2] some fixes for docs Makefile
Date: Fri, 26 Sep 2025 12:16:17 +0200
Message-ID: <cover.1758881658.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

Another small series against build-script branch with fixes.

The first one removes bogus warnings when latex is not installed.
The second one has a small fix to avoid writing *.pyc cache at the
source dir.

Mauro Carvalho Chehab (2):
  tools/docs/sphinx-build-wrapper: allow skipping sphinx-build step
  docs: Makefile: avoid a warning when using without texlive

 Documentation/Makefile          | 13 ++++---------
 tools/docs/sphinx-build-wrapper | 18 ++++++++++++------
 2 files changed, 16 insertions(+), 15 deletions(-)

-- 
2.51.0



