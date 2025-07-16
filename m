Return-Path: <linux-kernel+bounces-733724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C065B07840
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E9189A276
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAD25A2BB;
	Wed, 16 Jul 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8QZA7TB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E02E36EE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676660; cv=none; b=UstFH927Q49onaoCcKNigRyJ6vawXXfznpp/wDGSqi8mayKsoJuusMritwpbuDvVT7jD7AYlupre3K9MjMHCgXDQxyTqJ4t2R9jvSnYuko3Bn8ORT/tAr9cRodjLYOeLgYTVummQW0lj5Xby0wvZgWgoL6aUW8KdQJWX9d3qV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676660; c=relaxed/simple;
	bh=ybOji1XCgQcG040SR4/MeBPxRT9BFs5Eg/3usGei6OI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z6ORJrqg7vJEmMK2NjquvqEmTWpeNBJ4JGDfR8nZ0wB7LIqaynAhwhNlqaE32pNnsBripIzafZfI3JAcl8a+aFoVdugbnyX+jU4/0CMjz8JXKx+JJ48LAl1qXwNpw700iICiP1xIWeF7HK6XMD6/pYcHvyL+pt/nM70J5TcKUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8QZA7TB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861F1C4CEE7;
	Wed, 16 Jul 2025 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676660;
	bh=ybOji1XCgQcG040SR4/MeBPxRT9BFs5Eg/3usGei6OI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=R8QZA7TBQ1A2E30oCTghGHxh0+NIK8aQi5lbHTAPyXV76gdNaANzJLWqF+5UyqKcX
	 pd25+1K4VkIewIMe+SwKjvF0v6W4R+0PPoRQp9LibkyMslhFvWH1hv3Srl+n9NBUIa
	 Bq3oDnp1ZnDAGrxOuPE2zKwqb7nTe6z8cfMPS+6/3jbR0GDgHzjJWlmqP7mwP5V9OG
	 ujIwyL3vyVPx0H1qg3g/bBrEB9NQqIu+6EptJLMAxl5H67/2quLyzk0CgBwqm+AGNW
	 /zVd1yfj1WWWUbrQ3+5TdQH/AlyuZ3dJL3ek5omzMjpvYug5vOjqVQjDZyJ6Hms1Bn
	 tilnz6lvCSMlA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 jeff_chang@richtek.com
In-Reply-To: <20250716021230.2660564-1-jeff_chang@richtek.com>
References: <20250716021230.2660564-1-jeff_chang@richtek.com>
Subject: Re: [PATCH] regulator: rt6160: Add rt6166 vout min_uV setting for
 compatible
Message-Id: <175267665927.613446.1954648006381914089.b4-ty@kernel.org>
Date: Wed, 16 Jul 2025 15:37:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 16 Jul 2025 10:08:30 +0800, jeff_chang@richtek.com wrote:
> 1. remove unintentional GPL change
> 2. using switch case for Device ID probe check.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt6160: Add rt6166 vout min_uV setting for compatible
      commit: 63be976da994260ea116c431a2e61485dbede1b0

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


