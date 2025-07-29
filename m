Return-Path: <linux-kernel+bounces-749683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1BBB15194
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462CB179C51
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191EB2989B3;
	Tue, 29 Jul 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcXuhf+/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D52980C4;
	Tue, 29 Jul 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807445; cv=none; b=nRuYTahDl6Z22CNfG0watNMKwJ1Ye3Bop5zwd7IrbaGrkdIkPD2aVqdETjyjcFg9ECW59zcuQppt2Y5wF3HwQJ9+TuBVS0tlkdByiw87zXCkqJcaCXlRpGFEcS3wlheqsGCAPpkL7UNqWd3HcgbMYPbiqkAkJGG+90523qumS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807445; c=relaxed/simple;
	bh=ZnxXmZRWsS/uKbUuoGgQ3H2tPqexH5/pzA5JKQMi1do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5aiaVX8/gZB4rm55iWei9/ASOnG+B5ySEdYaW7xHALXTsJGmkzJF1Wu5kd4qaUs0P7rsbm5Yz0yA4OHbQieN8gVaHo0LNP5TtZ7qixQ6AmBQK/RwIh1yLk5Dk3Fn985cE6hbcYgEQOUqQn7ifb/jCIn7tfQSHtLm2XvKDe6vXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcXuhf+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C866C4CEFA;
	Tue, 29 Jul 2025 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753807445;
	bh=ZnxXmZRWsS/uKbUuoGgQ3H2tPqexH5/pzA5JKQMi1do=;
	h=From:To:Cc:Subject:Date:From;
	b=rcXuhf+/NiWoXW08oJAjPOuU+1k/I0Cl0ZBKcquoeVsqVRROaUAoEj3RE7C5/awLp
	 eCXL03ejE0D+ejGPxVn/Hp8op7gm6+JupcoHF3m3az/IGJ6aRRA+sgaMBYJuxqeT1d
	 acv+0SPGUG8yU21oZr0jUJWSpRJpCG6C3hMN6wpwmuiOrwcpUEuY8qBfcEcirQqmcv
	 wL/dlKGphKTz0+VYaF4zGTR0L7PYZQB22zhjhG2A9S51cvckKqyBpEhlfe7Fqdvbe+
	 CktV6Z6eEUYo/ILdOn2sqgGZqcRNwCUWab1Ns2Wbp9lK9JU4Q3x/YrMVBNFpA7Kv4H
	 opSoify/sAk8g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugnQo-00000000Lit-1U7e;
	Tue, 29 Jul 2025 18:44:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	workflows@vger.kernel.org
Subject: [PATCH v2 0/2] Better handle and document Python needs for Kernel build
Date: Tue, 29 Jul 2025 18:43:02 +0200
Message-ID: <cover.1753806485.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Hi Jon,

It follows the second version of this small series. It contains
missing patches from the python backward-compatibility series.

I dropped support for 2.7 and did some changes at changes.rst
per Akira's request.

They're not urgent, IMO it should be OK to have them merged for 6.17.

The first patch ensures that kernel-doc won't crash with version
3.2 (tested on 3.4, as 3.2 is like an unicorn: docker containers v1
don't run anymore on Fedora, building is broken since at least
Fedora 32, Anaconda doesn't have it anymore).

With this change, on elder versions, it would emit a warning and
do nothing, as the actual code depends on features at 3.6 (f-strings)
and 3.7 (ordered dict).

The second patch changes process/changes.rst. Currently, it makes
one  think that Python is optional. While not having python may
work on some cases, it breaks on arm/arm64 with defconfigs.
It also breaks with allyesconfig/almodconfig (at least on x86/x86_64),
with clang (on some archs) and apparently on some other
subsystems that I didn't care enough to identify, as for me,
breaking on arm/arm64 with defconfigs, and on x86/x86_64
with allyesconfig/allmodconfig is enough evidence that this
is mandatory nowadays.

So, remove optional from Python and add a quick description
about where it is required, leaving it open to one's imagination
that it could break with other configs we didn't map.

---
v2: drop support for 2.7, updated a comment and updated changes.rst.

Mauro Carvalho Chehab (2):
  docs: kernel-doc: avoid script crash on ancient Python
  docs: changes: better document Python needs

 Documentation/process/changes.rst |  9 +++++++-
 scripts/kernel-doc.py             | 34 ++++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.49.0



