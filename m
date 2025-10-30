Return-Path: <linux-kernel+bounces-878120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C86DC1FD7A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC7C189A926
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E332BF48;
	Thu, 30 Oct 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAvo1abI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A332B9A4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823888; cv=none; b=qatKJ0I9RRtYD0XqJy6Bf5CFgmKwZbUubo5Mxi5bYH/u8Pv/AzYxExr/FSk/LFOU+u2KtUbYFVVwYQrPub/ZZy8P3VOA46aiYIPExmHy/1VjyvEx0jO0aKay4ozm+1Q7XdwRB8yQTm2tDZNDHzWVUfohqpjE1fKHl6NmASqCVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823888; c=relaxed/simple;
	bh=j5oQ3lLxC9Dm0umVWw54qOjcuRvRlhiFSTBCxiaT7DI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fYex3vHL+JVjmHR6cll3fimsuWMhewUS3UGXh30p9d25XFFeWt78Bp022LPvUZAL5olJ7UKf9X4kHF6Qz5WAyY2HQ/t0B1myePVwGBw0sGc4xqRaKV/62X7oZwlc0zSx7EWo3rHmjgviyix3csr0NcZifd8bse/uqH4iawdafZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAvo1abI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E95FC4CEF8;
	Thu, 30 Oct 2025 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761823888;
	bh=j5oQ3lLxC9Dm0umVWw54qOjcuRvRlhiFSTBCxiaT7DI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rAvo1abIVquX0H5zWHjmKOEC/0Yinv9oyu4cczPMwsIpfasM/mwOaKZCF9MxOEJ1/
	 bPRMhs0HDL0G6fIclnrNwxRNsYmFr35y1Zk8EJ+50mUKHQ1EPdr/6TbPo8l3NsGXBk
	 lidy4MbgJsQ9VbTezqrj8vdClZ0ajTR9so5eLXvAZVfsf4xC41OJdVoYl54weA1EDi
	 ko89dMuwaKvHMk6bouiALrUjEcJ5h7Y5Po1xM8M87KROUuvhmrWZgSPNKQLeSQ8Fk3
	 uUQysxlZr1fG4+6cF418Weoqwq9b7OBo4AgQk83zB1HHSEqkNuoenhVIweBQwVx64D
	 tnOTH1+DQ6aQQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Sander Vanheule <sander@svanheule.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20251023135032.229511-1-sander@svanheule.net>
References: <20251023135032.229511-1-sander@svanheule.net>
Subject: Re: [PATCH v5 0/2] regmap: Introduce validity info for flat cache
Message-Id: <176182388709.31025.7042684531624049579.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 11:31:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 23 Oct 2025 15:50:30 +0200, Sander Vanheule wrote:
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


