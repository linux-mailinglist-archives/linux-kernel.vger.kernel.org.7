Return-Path: <linux-kernel+bounces-862758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29338BF6181
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC8A42434F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2432ED28;
	Tue, 21 Oct 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJT8aqY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F832E755;
	Tue, 21 Oct 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046636; cv=none; b=UZgT/d2yT3Drhaa9zJfZ0BfZ9Ol0/9QSfAe5oToy1LIzMQ8Eqe5yBqnGrciK8Oj4qWINFb1FjTSQSx1/tRpUjiDPnQOc2to6KksFMmRIwYcCQhDPfJQTL0A3IZcDlTuErAD09daqJn/tbQoktZ2GbhM533wVH70bF3DFegP6EHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046636; c=relaxed/simple;
	bh=i3cq7g3Nb0kQV7zxH9lIj10D07qQbCzEdxIrPZnjEso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oIwFRWVpVpyMWO4Ia2JvF+uSK6ZQb0XF9emAXhIhR87z6VBe7lfKSb4mEHR/eSdc4MKqMHqv6IhLWty98yKNSx+InxmBiGCvxo9eOLv8RmNQJe4UkbmmiBI7k6A6eBYuXn8/ux1iET1x5Bfw8f9eLEwiz67uOU5uOL8Wg4Q43to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJT8aqY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71092C4CEFD;
	Tue, 21 Oct 2025 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761046635;
	bh=i3cq7g3Nb0kQV7zxH9lIj10D07qQbCzEdxIrPZnjEso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fJT8aqY/7zIhxw110u/4fAgkMlPhrZ5PpxiGTqIaszdSj0dxnQBiiMUzAvYmi7qrW
	 JF65Eng6h7YkKI0020RM2Qeox7jn2vrvaDIOIvQzJVHXBSwNUauabdYTK+wJU1bScH
	 IJ9Oeu3UAU+IUEVnGIKGnot9bACdOsREXzPHaKXzK7JaBDwmEW9clYmkKtX7c5qbit
	 qjjq3jsw7YkxIJE+5uqDtLTJCmaWw/QIznizsbz4/ZhRXXOaSTYb2lHcvhtPEEy3VA
	 ZPvCOCPxF1ZDqfur8bYj2Lq8bmOBug4Fs+JBPdnprVT1rMQ+X/OCcUTNidW0VpBXzG
	 pUuB+ijLT+gCg==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, Vijendar.Mukunda@amd.com
In-Reply-To: <20251016150837.320886-1-simont@opensource.cirrus.com>
References: <20251016150837.320886-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: amd: acp: Add ACP7.0 match entries for cs35l56
 and cs42l43
Message-Id: <176104663419.21978.6068676602020179835.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 12:37:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Thu, 16 Oct 2025 15:08:37 +0000, Simon Trimmer wrote:
> This adds some match entries for a few system configurations:
> 
> cs42l43 link 0 UID 0
> cs35l56 link 1 UID 0
> cs35l56 link 1 UID 1
> cs35l56 link 1 UID 2
> cs35l56 link 1 UID 3
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add ACP7.0 match entries for cs35l56 and cs42l43
      commit: ef30cb1304f033eaee3b46e22b8f523446db8f53

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


