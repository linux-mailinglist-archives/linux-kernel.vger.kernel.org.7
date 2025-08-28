Return-Path: <linux-kernel+bounces-790630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A771B3AB14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBB31B24110
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCD284882;
	Thu, 28 Aug 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE42vYZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2327144A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756410403; cv=none; b=aDyyj/TtXKk1XzdhNBxIAy9iWQ0BQS7P1BR5RoyN1FZvghe8K+A9HoF2yxMjXZtqbN81X7HD8rK4A1xqW/KU5VxM4iW8WjMTiK/tzAUnr2qgujgW8abt+flV5Qv9Soto36qx0+ZuXsVeJHKnKaQ5EER9pqoJ4L536hJTKy5Kbrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756410403; c=relaxed/simple;
	bh=9nxCh6GzB4pDeVv2PcrqJqNAX2vTE5yZCRSW+Uu0GCU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=scEiqyHh/QgSD14uS/DjlclXrQDPbLKtHtEFejmc2BoP6N7ckcmElDXuhzBbT2gwI5DmbwJjjUkqkUN78Zpx3Cp3cKbJfu9hC9p78sX3eTkSFa/cnhxxW/rmKUz/DKCHcHi5X6jxSd3sw37xLj7QDKegEwZ6yInVvr8GmmFpJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE42vYZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB25BC4CEEB;
	Thu, 28 Aug 2025 19:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756410403;
	bh=9nxCh6GzB4pDeVv2PcrqJqNAX2vTE5yZCRSW+Uu0GCU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=CE42vYZWFMSoTyLmS3bWsA3++EgSeLcg5J+O7eWZTO5/B2xPGokA9x6OIk/xRtbU0
	 kNFSe+Wf3Lu8m5NvFsJIABYtKdGU2o1awarXZ+PzGrfIhTbKZCMVp1IA8wwIshArUw
	 IC0XBXPKAVDyB0yLsRlFcwCzIxMUWLBLfgnIE6f3w62W+p+NSG9lYH28zkvKAb7EmA
	 5T+bNDUDmleMk8lfhhVoTKPs9THgi50YdtqQdYTGGfEN7QN+snmfaAuaKtIuJ2/Ku+
	 PgFRrq1EcFFlI2HRb1YqX11KqWtiMjaSpU5L3IyS3J1inAppxdK8T2Ae+EHrS2V4AS
	 fnFEK/MeJORLw==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250828150702.193288-1-rongqianfeng@vivo.com>
References: <20250828150702.193288-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] regmap: use int type to store negative error codes
Message-Id: <175641040139.360587.13244973481999143024.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 21:46:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Thu, 28 Aug 2025 23:07:01 +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from unsigned int to int to store negative error
> codes or zero returned by regmap_field_read() and regmap_read(), and change
> '-1' to 'negative errno' in the comments.
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly as pants. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: use int type to store negative error codes
      commit: f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c

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


