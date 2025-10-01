Return-Path: <linux-kernel+bounces-839456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B05DBB1A64
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511B24C4BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAB32E7BD9;
	Wed,  1 Oct 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4AwYsXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265752D94A0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348280; cv=none; b=U4xOS046Qr+UUGezs/3ykTzdXZZK4KRghoNF48YPyow3bPg7WzFf0dYD0Sr2CR9t95XKc+K65WHAuCOgwmkGbpE/TK+J7y4JJG5OwBi9dsT0TorwmcnQTkcVZg7xJRt5U+GxI8f3CGgA3ts9+QAz9wq7sOAI6jF12RhDtX+xmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348280; c=relaxed/simple;
	bh=wwBQ0QKu00IYQyl3veAz+jlkThM9j22LNCFoLL1M414=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qWa9udbK6C+YCWYFv3bwSUwYQvc35CuKmxkzA5Kn7MeTDz16/t4tcv7xxzzgtm4eTVxTVYACTSY3bHhCWs9eaaD2tvH9Vk9o5X6rCNUkES3/dcxmWTk8ljaJWkonI8ZeduTI3Xvx+o6vJTHKcMY/F9WeI3LPhp0zDIKgMOEyDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4AwYsXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F0CC4CEF1;
	Wed,  1 Oct 2025 19:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759348280;
	bh=wwBQ0QKu00IYQyl3veAz+jlkThM9j22LNCFoLL1M414=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k4AwYsXYe1BsbiLtIMYDU/J7OqwIAbbflhjIE4E1rN4DCOGtv/tZ4D7ORtYS8pnHo
	 JeNAecUi2lxcgVR9TfzMe4sS8jOsC5eqcXIY9wnbk2PytomHF90OruydBz2RCIO0Dx
	 bv80s5jhDJwG3xtttl/15AwQUFkV/wNUCWMNLC1sqQUUJTMeCXIV8jZJ99Aff+b4Wj
	 77YJZ+mL3TrtQKcOHTffKLsNLHPir0GmlPtzFpXJ4AqmrptqqSh9amQCwRgxL6GqBB
	 RDkyXm8Zhh0jqJDyuXQyt8fzeQDhaFFxKpAYk7QdLzwS6UBmdavYA0p2oFHUhrR9vv
	 qZvtwHohFfd2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9F39D0C3F;
	Wed,  1 Oct 2025 19:51:13 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001140230.GW8757@google.com>
References: <20251001140230.GW8757@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001140230.GW8757@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.18
X-PR-Tracked-Commit-Id: ba3b29a639fe5173033914db6ee58d8d9bb86aba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3479214c05dbd07bc56f8823e7bd8719fcd39a9
Message-Id: <175934827222.2595637.8549776836998162539.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 19:51:12 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <danielt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 15:02:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3479214c05dbd07bc56f8823e7bd8719fcd39a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

