Return-Path: <linux-kernel+bounces-831145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD20FB9BAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6873427831
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73243126CD;
	Wed, 24 Sep 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7c/Gzua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A092263F3C;
	Wed, 24 Sep 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741789; cv=none; b=LaKJjDM2BRii/tZTuYbul3qMP+SKfhRFWSxwbSjkW34RfQhdw7SKiP8z88mjI+au7EUGFZCcduqzCoU9uASAlaq2gyacijKtZUcUKw3ytnqJg8BGQiz+twUYzL2sK5B1NX/8m3vZXO/L/zl/+4WsZt6RqqwkKYVqj36ApjfqyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741789; c=relaxed/simple;
	bh=GXcvNBF50K0c1GDQVLvQ+Q+vWKBVH84ob4/uB4CLzE4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Udcc2FzXFhmGpgSBV88KgNVXbyiGQhFcCch5IKYFtqYfuJ8WtkSuogfU+xCdhwW5Jjd7gp/fNXjId6mRmVToHksZlExE2wMeX+M1405TI8V1OnvWl7RlL87TEqXNH/F2+fo7nNQceoryPAp1hRo5npdnSSDY0sAccAWGu/Tf3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7c/Gzua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D10C4CEE7;
	Wed, 24 Sep 2025 19:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758741788;
	bh=GXcvNBF50K0c1GDQVLvQ+Q+vWKBVH84ob4/uB4CLzE4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i7c/Gzua8FfJn5CcbA3uB5ajyDw3SLn6C+Dr1/9GSBHZDKnxZLapUfC2puQskJk3U
	 tJhZIAzyBlzkzxLF21z5yM7xKg1264kOPXeWnoZP0/gRn4EqMlZnTcQb0MpkEF2ua5
	 BhIFVEfOOdYlCr6CwKcE9FFSt9m2NQMTHGtu5tAsACZKlWr6JG6lTvp3DOKwQBeGqv
	 xNuJMHzWTcrvVGcUVdAinIE8eH7f1PGfMdwAe9M0ZsbUXO8LjIcy3H+jZwQ+LIk3g/
	 dl9AZbdWC/sUXIMhzT9ntxzx8Y3tacYjVkRhfG9ZOPHEczqgnsmYmF2ns8uF4jJGsE
	 7kUQ8TA7wHRzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6045F39D0C20;
	Wed, 24 Sep 2025 19:23:06 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mux1-atMBd92EjpP9HYrLWWJDCC+=DNx+yVxti7ejDNhw@mail.gmail.com>
References: <CAH2r5mux1-atMBd92EjpP9HYrLWWJDCC+=DNx+yVxti7ejDNhw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mux1-atMBd92EjpP9HYrLWWJDCC+=DNx+yVxti7ejDNhw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.17-rc7-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: f7f89250175e0a82e99ed66da7012e869c36497d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd7d927587c7db5005d90623447c5d3b7750533d
Message-Id: <175874178506.2659978.5440524906151785308.pr-tracker-bot@kernel.org>
Date: Wed, 24 Sep 2025 19:23:05 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, "Stefan (metze) Metzmacher" <metze@samba.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Sep 2025 21:21:42 -0500:

> git://git.samba.org/ksmbd.git tags/6.17-rc7-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd7d927587c7db5005d90623447c5d3b7750533d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

