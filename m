Return-Path: <linux-kernel+bounces-724252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFAAFF080
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1E1173F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072922367AF;
	Wed,  9 Jul 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx8Uo8YA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3721D3E9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084587; cv=none; b=RLtYkjDffgVFfZXD0+UR/vMtWF684nb7FIf7LzSVgRRsZ17/7dn6IgwctbIGzMlQPsaioIYBESB0fvlkgbCG9ivaHOtNkECe0RnQBabMWfl/0WnbiS+6+djIGR5uFYtXlZs0uk9lEtfyezCabkLwQksj7pNLjVFkpoBQPFsD51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084587; c=relaxed/simple;
	bh=phHLJ3EvywfcPLMn5ezWfhv0ep2yOCJcyMLvx/syR+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bhMR/B/f19s68BzzD0P0gergyjU3X8F7Ytk04S/S8wTZqK+I0DhwL+p8CEgw1PeTv10iaaOsoKTW0nqm9fdEWCos3SmM77jo44PAlPdkJnueqVwAJFJEeGaVy/oF5LTPc9B/m79KnXSX8sBpa602BhZ0pT4z8mX3zgdoTchc+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx8Uo8YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EABC4CEEF;
	Wed,  9 Jul 2025 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084587;
	bh=phHLJ3EvywfcPLMn5ezWfhv0ep2yOCJcyMLvx/syR+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cx8Uo8YAvjT97aO21/vTtiJvX22G60EJjJhzYhGh+QCf+5/FTLdoOTDAmsKd99TSJ
	 SR8p2HwLbEAhUBggtbun3Y1Nhj+ydiLBm/wk7whGzijAdowOfLrNriYwNb+uLYTsSs
	 12dT2aBF0wmeep1TclUQ2WahK+Btlnvcq8nqFuJFHJZUhrpIwESUvjNH2ew0QSXpqc
	 C6qCcz8ltLK7dhvLpPIDO/7Fhl8saRmZs8+nSqowDK9IMx4AiDJTW4bLC2kqOZ//Qh
	 O/Vd11GLarjWOG8QRJjqqd8uqcCkrSLs6jrRztjOwYDAVNQiVcgnMM9PqVggsUE7NC
	 Jwbcst1/CWpUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE24F380DBEE;
	Wed,  9 Jul 2025 18:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: avoid splitting bio when reading
 multiple pages
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208460952.806926.13620512272731608715.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:09 +0000
References: <20250630125753.650630-1-huangjianan@xiaomi.com>
In-Reply-To: <20250630125753.650630-1-huangjianan@xiaomi.com>
To: Huang Jianan <huangjianan@xiaomi.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org,
 jaegeuk@kernel.org, shengyong1@xiaomi.com, linux-kernel@vger.kernel.org,
 wanghui33@xiaomi.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 30 Jun 2025 20:57:53 +0800 you wrote:
> When fewer pages are read, nr_pages may be smaller than nr_cpages. Due
> to the nr_vecs limit, the compressed pages will be split into multiple
> bios and then merged at the block level. In this case, nr_cpages should
> be used to pre-allocate bvecs.
> To handle this case, align max_nr_pages to cluster_size, which should be
> enough for all compressed pages.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: avoid splitting bio when reading multiple pages
    https://git.kernel.org/jaegeuk/f2fs/c/185f203a6991

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



