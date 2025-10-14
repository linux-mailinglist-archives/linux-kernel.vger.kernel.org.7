Return-Path: <linux-kernel+bounces-852896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D2BDA2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8CD4E5972
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5652FFDDB;
	Tue, 14 Oct 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr7zFS88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865118A6B0;
	Tue, 14 Oct 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453892; cv=none; b=Lr0xupNBzgvgJ+7fn2FFBEzpsrX06FsAHCOgkNpfRfYH1SfIbe0fKpF9Eos9C2nVjrOu5/W9UXTzTI14I0kaT3Ps9+dTd0BB8/0o113k43BGfMMkrx/6+aSRHFTYYbWoFK2J5G0RdqTXieLw8vEv+A7aIkQi8aLyD1sB7ZKll1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453892; c=relaxed/simple;
	bh=iVa7EOANGisZpVCN5woTl0K1g0oTi969VNzdtPz4cLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dExaQFo+BufAalAhYBz1QXy8No+sPbSyqHbw4KHHKV/zOLBwHzSCcJhc2A1fU3Wd7qYuJWyqVIHtIm3F14K6f4MOtRgps0XBWXq2T2Zus6ZmqL2sN/1p5/uIa38R/j/hmxCgtbm0O1aEiToS5kIj8zJuPz3eBJUpqbgZBaLxCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr7zFS88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D96C4CEE7;
	Tue, 14 Oct 2025 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760453892;
	bh=iVa7EOANGisZpVCN5woTl0K1g0oTi969VNzdtPz4cLo=;
	h=From:To:Cc:Subject:Date:From;
	b=Fr7zFS88jo9Y+b1IBY7d6aw2ZBkqJTySGTIEbL1gMlrbPxWsxa9XTyuWqHZklZe4a
	 DP6ja8l9z/6jQvXMgKOSuE2zXmIzJZbTRPAFIufD1MspOrU8i3wacQoCwN8U2Az3dF
	 p4eFyStmFiOASgys88VthQA6xfmgjZndL322fx/5aCo4E9xoqOaAAZTggDpwXWYTKU
	 vmMFRuAFVw0VbLCHDo9iz94N0kOk9njcB5D/kkooaMdt3cvHBSEZR0iFK6J3cTVUY8
	 RcHJrLuxEzPoGt3C3nDdZMt8Tb2kjIMRG2VKP6Yy2YK3Hik1aQoctjBqa+Sub7r7mY
	 ni3v2tkmJuCOA==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD fixes for v6.18-rc
Date: Tue, 14 Oct 2025 10:58:10 -0400
Message-ID: <20251014145810.4880-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 73cc6ec1a89a6c443a77b9b93ddcea63b7cea223:

  nfsd: discard nfserr_dropit (2025-10-01 15:54:01 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-1

for you to fetch changes up to 4b47a8601b71ad98833b447d465592d847b4dc77:

  NFSD: Define a proc_layoutcommit for the FlexFiles layout type (2025-10-10 12:53:50 -0400)

----------------------------------------------------------------
nfsd-6.18 fixes:

- Fix a crasher reported by rtm@csail.mit.edu

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Define a proc_layoutcommit for the FlexFiles layout type

 fs/nfsd/flexfilelayout.c | 8 ++++++++
 1 file changed, 8 insertions(+)

