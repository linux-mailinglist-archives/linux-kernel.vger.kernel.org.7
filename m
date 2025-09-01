Return-Path: <linux-kernel+bounces-794642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E1B3E4A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2904F7ABD7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934CE322A18;
	Mon,  1 Sep 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcVJwnz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313E277030;
	Mon,  1 Sep 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732887; cv=none; b=mt3lAN/ahldOfBcDwVeGTiMP6CjZAhsUkOxOhTrG18gDlEnUKMrW+w3wkwRYHyQO69Tp8csOPeEQh2T/YnCH7n3101SyV7lWevTAaEFim4EZo4qz13x5N0oJDsWrSm21r0xSuwwPniZ2iiuPTTkgaSEYGkd7OxKgX8jHzMVKo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732887; c=relaxed/simple;
	bh=ueI4xsycPkgXTSZUs0weV9OPIinCS09w05STlPH/AsY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zy+Mqh5sa9F2Bx77BZoS76tBIq7OfFqu5j/X31gtD0P9zDeime2dhhRhttve8mCd2qv+xR9RxYNyPdUW/H2p4dZ7Fge2Y2gb0KCeDgV8T7CMCONDAm//gsJwA6d6wj/lZxaBooG3Kadankwojxl8bVgHyJDyePkqGUNdD1j3qw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcVJwnz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC54C4CEF1;
	Mon,  1 Sep 2025 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732887;
	bh=ueI4xsycPkgXTSZUs0weV9OPIinCS09w05STlPH/AsY=;
	h=From:To:Cc:Subject:Date:From;
	b=lcVJwnz3r/VWcuuEbGg/lKXrAXz4y+v4x+luyP9/icSyHRs6RI/ny8iqSPxbb/0TQ
	 w2ez8Hkfkeh8YvjUJKWul1/l0f+CM9puroLUoWI3nKVdECltwn7+o2npUq7MqAqgk+
	 umIwtGlLneJJGtmGTivqo0SGgNWbW22PaKh9NirehSqiw5R6DgeWCXntQcQlgW36QM
	 j9h+MpXpEwS7sl5m9AV78T2V3+w87uxgH8IojTSJ30otNNy7nW4dAc8mNCefMAGw0M
	 L4w5K9PE1yh4aqfNzYoCFWRHqsGwifypdcNy6OYOayOVPu/PW9AA3zHselWj2Y1nr9
	 /CjjpTG1amVrQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut4TN-00000003DcY-26uF;
	Mon, 01 Sep 2025 15:21:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kernel_include.py: fix a regression on linux-next
Date: Mon,  1 Sep 2025 15:21:20 +0200
Message-ID: <cover.1756732363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

My past series broke when O= is used. This small series fix it.

Actually, only the first patch is needed. The second one is
a cleanup. I opted to split on two just because it contains
an incompatible behavior change. Not really a problem, as only
media uses kernel-include, but still I opted to keep it in
separate, just in case someone might be needing it.

Mauro Carvalho Chehab (2):
  docs: kernel_include.py: fix an issue when O= is used
  docs: kernel_include.py: drop some old behavior

 Documentation/sphinx/kernel_include.py | 43 ++++++++++++++++++++------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.51.0


