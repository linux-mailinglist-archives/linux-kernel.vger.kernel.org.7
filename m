Return-Path: <linux-kernel+bounces-728209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62417B024A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C2117DC85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F51E47A8;
	Fri, 11 Jul 2025 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWCcRa0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE619CD17;
	Fri, 11 Jul 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262485; cv=none; b=I6e6v3m6aBfI/YUiiuL8cbNnsxjR0zSm2oOfnhn90JzllwBRuFNgHhVxSIidc8SJaLCHO3UR4kqlaPp+larep2B6i2B2iVeGRIIyLPeoI5INaSmNJ1yvpgJ8QRWPoRkj94w+8cPZa3tL4DoL7DG27n/vCpckYTs+O96laUXseQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262485; c=relaxed/simple;
	bh=v6iG3EMkiGieJSsdeDjHrneCcUNBwgtcJC/HKqppA5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZG9p9aBL1radF6HK2hEkKjKb22cP8rIasD8JMNxW4A6uuiWmOYAnE5McLmo74C76qHWbr8b5Wmz/owaisjJytySVQ30s1SvNje73Jw2xoCea05v+KyGpiqYMUnwdBDgeQ5VS5rigkyJwmXId7bev+LwQ8xrojV4vVJr9dfaMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWCcRa0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BE1C4CEF0;
	Fri, 11 Jul 2025 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752262485;
	bh=v6iG3EMkiGieJSsdeDjHrneCcUNBwgtcJC/HKqppA5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VWCcRa0znuPZ7lhEAISJu8y+kGUzvx/Kx3f0P38Q2v7dStY35WQUftUFj7xw1AQvN
	 mJVpg4Wy3ESF3rSxYHqz9Qujw21I75rB7zVmlKIqoeG24iiX5QM1iSkZKpC31H1HUu
	 wUPuCcYtnyDmJ6aZzqShgjZcZiYptmGPwqGPa8Iwn2xS5cTsZ3JB7l9cJMDWGaQMgi
	 SxmLttUaQaXsjj4SUW/80Jb3xi7go14c9c0OjuYLuXMB2TaBaLvb0A+Y0n1VLNBALN
	 0CTDkptIvRFs8Me5uJhZJautl0GmIsUn/DzPmisl3HWFvNoBujRqpfnfRvX+8QU48x
	 ppXE0CNYfbUBg==
Date: Fri, 11 Jul 2025 12:34:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
 <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
Message-ID: <20250711123444.71747051@kernel.org>
In-Reply-To: <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
References: <20250711151002.3228710-1-kuba@kernel.org>
	<CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
	<20250711114642.2664f28a@kernel.org>
	<CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
	<CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
	<CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 12:30:28 -0700 Linus Torvalds wrote:
> > I spent several hours yesterday chasing all the wrong things (because
> > I thought it was in drm), and often thought "Oh, that fixed it". Only
> > to then realize that nope, the problem still happens.
> >
> > I will test the reverts. Several times.  
> 
> Well, the first boot with those three commits reverted shows no problem at all.
> 
> But as mentioned, I've now had "Oh, that fixed it" about ten times.
> 
> So that "Oh, it worked this time" has been tainted by past experience.
> Will do several more boots now in the hope that it's gone for good.

Fingers crossed. FWIW /proc/net/netlink should show the socket
drop counters. But my laptop running 6.15 has a number of 
GNOME apps which never read their sockets so it's not going to
be as immediately obvious whether we regressed or its a bad app 
as I hoped.

