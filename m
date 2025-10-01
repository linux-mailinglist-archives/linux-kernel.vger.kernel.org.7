Return-Path: <linux-kernel+bounces-839025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B523BB0A93
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457DF17CB7B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859C2302176;
	Wed,  1 Oct 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltgKe/dZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A32FF65C;
	Wed,  1 Oct 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328051; cv=none; b=Glo+J4c/RI71O0LQmalA5L/6sOQWGFVpD3MmS9U25JfngZIJEn+k/Ug4ruJ+CxL4+8cVccSzjBexTtwqih+pxLIEyzuki2cAWG4KlcCnlhnEQfnHiaSFbCXzq+tUjOlZUPdV0/1ILDmQrjtdDrmUx7ufpWNBafKblCr9SA+KmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328051; c=relaxed/simple;
	bh=1E19GaIv/tCKahDxgHNKX9sTojjjSiAdKY2Em4ESOVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2HcuZxS01yYh00lCfLBnlBFrcwu4bkbWhQrczU68EghbZvzY6U2PcyAnDyeo+IzQaR/XQG36r6KYCvLaLsRpwDT8SCm/vy4m3Nh+dhxYvbN7DZifNGcO7WRJd9qevwA/MVlzEy0ltZcHUlvbqBbIsLi+G/yxC3z1mVkkcepzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltgKe/dZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682DFC4CEF1;
	Wed,  1 Oct 2025 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328051;
	bh=1E19GaIv/tCKahDxgHNKX9sTojjjSiAdKY2Em4ESOVw=;
	h=From:To:Cc:Subject:Date:From;
	b=ltgKe/dZ2YG8Se9kxwmcmadJRiWJGXzV+0RSOhfr7KO3U02B07IvcRkUS+VA/wY7v
	 vtJpz8VDP82bdgjMKOVDaHtZM7wIuNwYzcBlnIHbxDfJoTbvmPtjrt/+RgMKtHGSqr
	 obY+8K1ZgaNdIwXOtA+m5LqSkAkh6Ydvkn6p93MGI8rEQ85g0GdY1sFql/8R54Cms/
	 scJ8eO8VXde93ZPL+szGkvVkforcb0ToEgHyp91DmO4dTJmzra+29hywJfgBzEE2Lb
	 +GXLB0LcBBHI0L87+8bS++AT0BC+q4gp2oj0y0BK0OInVGIuyMxuMvcqehmSY/pnwd
	 gLtdURS+vun9g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v3xar-0000000BJ5W-24NS;
	Wed, 01 Oct 2025 16:14:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] man pages: Add a SEE ALSO pointing to Kernel source
Date: Wed,  1 Oct 2025 16:13:58 +0200
Message-ID: <cover.1759327966.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

It is interesting to point to what Kernel file contains documented
item at kernel-doc man pages.

Mauro Carvalho Chehab (1):
  kernel-doc: output source file name at SEE ALSO

 scripts/lib/kdoc/kdoc_item.py   | 3 ++-
 scripts/lib/kdoc/kdoc_output.py | 3 ++-
 scripts/lib/kdoc/kdoc_parser.py | 8 +++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.51.0


