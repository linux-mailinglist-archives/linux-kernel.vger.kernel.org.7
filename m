Return-Path: <linux-kernel+bounces-830624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230EB9A257
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262EE4C573B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ADE2046BA;
	Wed, 24 Sep 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4Lkhihe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899E302CC8;
	Wed, 24 Sep 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722666; cv=none; b=P8Rq8UaMV9PHwNx1ffLhfAeJ3M+spE51oChUybNQMrUmbwYsII0/JxOhtf9bBszArJqHKNBuOuyN7vfYVcgH3gX1pN6U01yNA0EsB907jkcGkFDWYnEr/naE5UN/5wC+OT7MDRLnu8jp+N9XVUHUhvxZ9dNKnvcPivR9KS1Bt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722666; c=relaxed/simple;
	bh=dsO08fcg3srSb7kpu3rvFMd5vSL48gCfv9kOMUP1HZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ntQGSbx+mj4NrqdkbtKmXeNrgXLhM9zA4MJGENcLcYfGHCeN6UV+naqnjQ47mEtDVrznQ1sKtIP85/+BqNAv1kPqsKiK4bsZSYzoxlYKYYnqba3a1p6ZKCzrK8KeFeQgMZcrx2bKWDseW93p7dkqhaUgx9uIVlY+v+UUUdEJPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4Lkhihe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410E4C4CEE7;
	Wed, 24 Sep 2025 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758722666;
	bh=dsO08fcg3srSb7kpu3rvFMd5vSL48gCfv9kOMUP1HZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z4LkhiheuA7T6FVnqXet4UgUibLzRFn0qBnABeTtCL8Ok1emS/sKYmUf7K37cO5pB
	 4Ys0S57/fEkAjTNPVXC8ginDPFibrPOA2W9CVoVRfsrNojH+9xoWUhMlXuIOFinGnU
	 ciWEZY0/SYAbQ6oWYsXkD3ljKzpfR6ZVZB7Tmg3TKk9PzKdyRZ/4wwDXXgNZqEeebB
	 ICHB8LpzACOl9cyiHyU9QBV5CR+QVz5kvt9HmChyvaRSV/yYYgzk39xx1Xs8K3EWPO
	 NrBoUvhdi37898Sl0VdiLHpdki74iRsr8VYz5//+leNqvYd8h1zaCf0dTo2+TDxtQI
	 UoZgzZAZ9+GDQ==
From: Mark Brown <broonie@kernel.org>
To: shenghao-ding@ti.com, kevin-lu@ti.com, baojun.xu@ti.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250924020540.234560-1-nichen@iscas.ac.cn>
References: <20250924020540.234560-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoc: tas2783A: Remove unneeded semicolon
Message-Id: <175872266402.1250098.15941093216733932187.b4-ty@kernel.org>
Date: Wed, 24 Sep 2025 16:04:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Wed, 24 Sep 2025 10:05:40 +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2783A: Remove unneeded semicolon
      commit: 70a0bcde87512c269269443444c109740dcacc19

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


