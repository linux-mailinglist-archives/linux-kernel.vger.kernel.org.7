Return-Path: <linux-kernel+bounces-878121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E9C1FD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7A640666C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8FB2882AA;
	Thu, 30 Oct 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXJhVcJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CB33890A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823891; cv=none; b=kf5D/nmipRukyoJs1zUWy5KRvmqmxpib+/uwR/jJ033dWCYfUEqNalCMVyQY/JXKa5GJQ8GkKEo4jDPDRuVXWIdAhcNaOJZ9i6UrWfF5mkkYEdCVAPsfO6dH2zS1ZZ/uyqDI0cw3ZLv/WJfU+HYp4V+DUW6cG3f+9vXu1dXdNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823891; c=relaxed/simple;
	bh=oS4B1f0cm9DjI/AVSEQ6VEtA5EjpVx7Of/OoeKvHCSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RTFqshNv+qT0PvcjeS3lVYTM0lafM4VQqrAOfmRbGcw/fPA2i72zhWrWzOBxpNJfxX3+dI2LgTnFxWClH4W3wtS1ZpYBYNicF6p3rK5FuxXsFULTJ+jeMYALb/mMutUYfEkzMmdepJnFNzjElqs8a0TDRMuHJ5NZU2U9xNaC1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXJhVcJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3447AC4CEF1;
	Thu, 30 Oct 2025 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761823890;
	bh=oS4B1f0cm9DjI/AVSEQ6VEtA5EjpVx7Of/OoeKvHCSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DXJhVcJsoyBLfe4Z2bHijtpHxR4ImnOD3s3Sugkrggqd8WVnbLEqmwlH/S1vfYQpw
	 B5EahsPbIaEENk8c8qfb6E5T75AmQei2CqMIK03WWz96z+cpc6arMYAlS2+UrtAR8p
	 2Vowa4ecoN/R4zshzZ8Nti3JP/iWHYXNMMRDwQJnE07aof8nuQx871iziG8eeQ6KIr
	 eUfINAbKm/s4ZKCDkg174eCgRjkyQ+LW1/VTSHdkGTDhMoli2ALmTmCt7qh62NejPZ
	 bF1R7RGTBijD+cDmU21JaHNdj8tHtH+0pdzkE6ncpvYuo1oE0oZ8rJ3hV84Xo+kB73
	 u9t0Y/2MWGZwg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Sander Vanheule <sander@svanheule.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20251029081248.52607-1-sander@svanheule.net>
References: <20251029081248.52607-1-sander@svanheule.net>
Subject: Re: [PATCH v6 0/2] regmap: Introduce validity info for flat cache
Message-Id: <176182388892.31025.5838334092689511987.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 11:31:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 29 Oct 2025 09:12:46 +0100, Sander Vanheule wrote:
> The flat cache behaves differently from the other caches, in that it has
> no way of knowing if a cache entry is valid. Initialization has to
> happen either by providing defaults, by loading defaults from hardware
> (via num_reg_defaults_raw), or by performing the required register
> writes. This difference in behavior may be unexpected to the user [1].
> 
> To provide feature parity between the different cache types, a new
> variant of the flat cache is proposed. This allows user to migrate to
> the sparse flat cache (or a different cache type) when possible.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: add flat cache with sparse validity
      commit: 9c7f7262bc1affb9b9acd2ec2fb1f6314d5d474c
[2/2] regmap: warn users about uninitialized flat cache
      commit: e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8

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


