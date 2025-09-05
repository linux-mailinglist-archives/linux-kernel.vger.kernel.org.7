Return-Path: <linux-kernel+bounces-803857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D99B46671
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635767AB563
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9712F60AD;
	Fri,  5 Sep 2025 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZXyDRSfH"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE22F28E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110337; cv=none; b=r5nSYUJZqptXpAET1XjU2kcvksEQXN3nGKdpH8RVqXk8OYJTH/hmTh0/Iiaew1zJ8AzU0Z6OQMnTqJ7FDTdVqGowTlNpUx5ENkJpb48dgM3qJVU3AHmjo2ZQCgM6vNVNYWksKKOoKC0LQ/0kJ7adbW/zMWAzpZKdctU66Ml9Na4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110337; c=relaxed/simple;
	bh=BS2eV+MmamMy0xsm9+vg8yFdZbJEXJn1T+NTTl6/7oY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICFViYE+stntmFZ0jw4YX5jBesW9masKODxwl+9ELWO959kKbEzF4eOmIbZbxs6TyxrJ2umZ9kVOSI8ZjJI7vDpMwxfPZB2sp3G42yoxN6knSfVcZJryXKdCYQ/rPZYyxmZ0cwzDEUTVBS2nxlmC5aADuQHNrnSPhRy/BDA6omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZXyDRSfH; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1757110327; x=1757369527;
	bh=BHaBMEFVDewwSKp7thargfT1P3IxRVYDym7J1XLx8cw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZXyDRSfH04X3Kd8NpuKWqSv6SLyErmbJUnFOAcGhMcATkIasuOkCRdZ6hwNiPZ5+Q
	 BH6LeBvfPwVRjNc2F+EpWab83/C/kncZa2F7DmNjRSbVyBQUIt73luNdFGGGPkhE+N
	 Jqgv0vyL7Paz9dvu6U520+XlUlPHx4NmNzgVHKwJFeRebdqKsjO7T5RQ+TJi9SEqj0
	 xhk62cUOrDCxMp/a7mirm9JXWEWW9jm4yuNdEB5kJEVvKHdajw7cjgjIdglmzpRIhg
	 zEKIn61k1YdQB0EbiRYcB3RO/KdIo0zP4a/xuhueDqamWVYskiEoKnaey58E6rWrdy
	 1y/I9JEBao16g==
Date: Fri, 05 Sep 2025 22:12:04 +0000
To: "kuba@kernel.org" <kuba@kernel.org>
From: =?utf-8?Q?Maksimilijan_Maro=C5=A1evi=C4=87?= <maksimilijan.marosevic@proton.me>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com" <syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] ipv6: Check AF_UNSPEC in ip6_route_multipath_add()
Message-ID: <u3HUdiCPiMCv5kkEVMXU9bKhZLDParnZCqUybez-bALHM78ymOclmc2pzUXgAGu-Bdwi30aV_LJkhicY2rwhZdjBzvYWyErXQpDQN3w4Ihs=@proton.me>
In-Reply-To: <20250904090301.552ef178@kernel.org>
References: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me> <20250904090301.552ef178@kernel.org>
Feedback-ID: 97766065:user:proton
X-Pm-Message-ID: a0a4e673389a6769a8cd4218687215afaa60f323
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Sorry for the delay.=20
I've managed to devise a test-case that reliably reproduces the error, but =
I now believe the fix can be implemented better. Unfortunately, I haven't h=
ad the chance to work on the new fix these past couple of weeks.

I'll try to finish it this weekend and then run it through syzbot once more=
.

Maksimilijan

-------- Original Message --------
On 04/09/2025 18:03, Jakub Kicinski <kuba@kernel.org> wrote:

>  On Mon, 04 Aug 2025 20:42:53 +0000 Maksimilijan Marosevic wrote:
>  > This check was removed in commit e6f497955fb6 ("ipv6: Check GATEWAY
>  > in rtm_to_fib6_multipath_config().") as part of rt6_qualify_for ecmp()=
.
>  > The author correctly recognises that rt6_qualify_for_ecmp() returns
>  > false if fb_nh_gw_family is set to AF_UNSPEC, but then mistakes
>  > AF_UNSPEC for AF_INET6 when reasoning that the check is unnecessary.
>  > This means certain malformed entries don't get caught in
>  > ip6_route_multipath_add().
>  >
>  > This patch reintroduces the AF_UNSPEC check while respecting changes
>  > of the initial patch.
> =20
>  Hi Maksimilijan!
> =20
>  Are you planning to repost this with a test?
>  If not I suppose we can enlist the author of the commit to help with
>  the selftest..
>  

