Return-Path: <linux-kernel+bounces-878077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE01C1FBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF551A21A74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EEC354714;
	Thu, 30 Oct 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd643V7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2D33B94B;
	Thu, 30 Oct 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822568; cv=none; b=VNQVzldY/LlVO9oqSsxbkDzpIR4esp8RlmGx2eRLQLnCk8tULscaBOULEOGGu2Nb/GR00uY4k89aVWOn9updnnjEj0vn0M0Mj8VEh5A3ODb66/jllJnJCc6bqUbN3wz7hLhh9e9APbwc0PVlrtT3WQFkn0X3NRPiU8J/dboTMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822568; c=relaxed/simple;
	bh=/jyxz82Rs8lMFhLCKbv6MeuXvAxkVmm8s1WZg6B+U2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HWFe6VdvhTAIXgdzrFclVOTstI6sMJ3/CpttuagPCvaCQ5nNuscMoQ5DScQeMoRK3nCq/+Qg1gyHHpUAVhfCj/KHBz+ODQ2tE/nC5dXLaw5QMhb95JSCrVNzKk0MIehuSwaeLL9ve3cZ2dx8f68ib8ajnSlZXQ5bHl9aC0cDGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd643V7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D3C4CEF8;
	Thu, 30 Oct 2025 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761822567;
	bh=/jyxz82Rs8lMFhLCKbv6MeuXvAxkVmm8s1WZg6B+U2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pd643V7ixRjskTAFNWlsbwEKq/IYExhfBKt4HE/JXXcKxKnO6+PDmp/7xiPvbfu7n
	 uFkaYz4TOqkeGSu5aUc1lPdRy/3f2khQ0S4WHISQlHphXhdEJlME17P8uLQIsA+UlS
	 26wr3EKF32nyBOA61Wq6ovde51GjrKQOyWdn30HuUSQcVKAFRN3+W7Ixn/O2Iuquch
	 UXv05Od6DWqfqdXqSiINeO/EAuBIpx9V9msNW/6IOr8c6XISwaEn+q1PCFph7Uuw5X
	 5RwxWZN5utIl14CamGFnqwkMwqgMKyBdGBRm8XU9ak1wbji/ds6xqBBfBR5xlSgogY
	 ue2cA7K6vtP0A==
From: Mark Brown <broonie@kernel.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 support.opensource@diasemi.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Rob Herring <robh@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20251029081516.83298-1-lukas.bulwahn@redhat.com>
References: <20251029081516.83298-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in DIALOG
 SEMICONDUCTOR DRIVERS
Message-Id: <176182256554.10414.9428685076956872040.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 11:09:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 29 Oct 2025 09:15:16 +0100, Lukas Bulwahn wrote:
> Commit 6277a486a7fa ("regulator: dt-bindings: Convert Dialog DA9211
> Regulators to DT schema") converts the last txt dt-binding in DIALOG
> SEMICONDUCTOR DRIVERS to the yaml format. With that, there is no file,
> which matches the pattern for the dt-binding txt file entry in that
> section. The existing yaml files are already covered by the file entry with
> the pattern dlg,da9*.yaml.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] MAINTAINERS: remove obsolete file entry in DIALOG SEMICONDUCTOR DRIVERS
      commit: 28039efa4d8e8bbf98b066133a906bd4e307d496

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


