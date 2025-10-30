Return-Path: <linux-kernel+bounces-878816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE54EC21870
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E73D3B740A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62D536B989;
	Thu, 30 Oct 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxoLIinw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4036B978
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846017; cv=none; b=EBn7AQwB06t+abb6j/6xJjfuXUfLAn0uelwRVNWo/u1Vu6JDoezEsmAEDx14oHzNeQyxwfjp1TvwOedf1Yuc0k1MoCg/9ccwLB2hlJeL1ywQoSDHkf2zIIAPaRNlQfCpmTvCmTsVei9ZB3A3BWKOjiSXI9PBEpA1wPaCD5t5cZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846017; c=relaxed/simple;
	bh=lMIj8+PQkZSoYivaKeiRGV2v5FbpQQ6QRml2yCrC2/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKML/QgBeplbXMO9eIb0dajOJRfzEscbBJNkWpTlKGiAxIt4LTHsT9UCmRr/2TqhaYLxT0tIE661GEDk11mlOrWV0ZeEtd9W/ckPsfbq3YxfFOhKkWB400ZVdyUqRZ9/PahlqgZmPSwE2fwzBKwwiPbby2NmsaUM9eBNgz51VVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxoLIinw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68458C4CEF1;
	Thu, 30 Oct 2025 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761846017;
	bh=lMIj8+PQkZSoYivaKeiRGV2v5FbpQQ6QRml2yCrC2/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IxoLIinwXFFEa5VNVZK7HLcgc7mOPPe1TY1VI3CqLoVZxvKg2GDNFQa+OIZ0fymcq
	 gubAjinGATTjLFphGvgvgOqVuX46kXe5zGRVv973r92Yhqnhlfa/vcyjOGnNPR//My
	 HWfTOJ2Qr9hhPtcUUHsUHQ4StQJXZz9QYpmv41uj1RUtbN39IukWWKiJoghZqOhGNp
	 a1DUtt5u9d028H6UY9bZ2QLYcAji53DYGf3Zyyd2f5ZrO/O6Nc2cgYgTTby2dnmJ6U
	 f/cF0W95anIjKiJl0OoiC+ski20genh78HMq4K0poMtfZqnmKNkQywQijTUq7Z4B7b
	 5vPTiWfaVSEMQ==
Message-ID: <58ce03be10ba5adc2b3896e9f5872ff26a74c195.camel@kernel.org>
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
From: Jeff Layton <jlayton@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>, Jori Koolstra
 <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Khalid Aziz <khalid@kernel.org>,
  Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jan Kara
 <jack@suse.cz>, Taotao Chen	 <chentaotao@didiglobal.com>, NeilBrown
 <neil@brown.name>, 	linux-kernel@vger.kernel.org, 
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Date: Thu, 30 Oct 2025 13:40:15 -0400
In-Reply-To: <dceefe7e-4cd3-464d-b5b4-f80c02b4331d@linuxfoundation.org>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
	 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
	 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
	 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
	 <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
	 <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
	 <90143686.3161766.1761833369803@kpc.webmail.kpnmail.nl>
	 <1ed30710481dd6739e6e9b4bd6f57c7c9d7e7de3.camel@kernel.org>
	 <dceefe7e-4cd3-464d-b5b4-f80c02b4331d@linuxfoundation.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 09:44 -0600, Shuah Khan wrote:
> On 10/30/25 09:12, Jeff Layton wrote:
> > On Thu, 2025-10-30 at 15:09 +0100, Jori Koolstra wrote:
> > > >=20
> > > > I don't see a licensing issue. It's BSD licensed. Also, this is a
> > > > userland code, so we wouldn't need to worry about that too much.
> > > >=20
> > >=20
> > > Oh, my bad. I thought Minix (the OS) had some licensing incompatibili=
ties
> > > with Linux, and this repo takes code from Minix. But that may be long=
 in
> > > the past.
> > >=20
> >=20
> > Minix is BSD licensed too. That's not completely incompatible with the
> > GPL, but IANAL.
> >=20
> > > >=20
> > > > You're quite right though that userland replacements will need to m=
eet
> > > > some criteria before we can rip out the in-kernel versions. This mi=
ght
> > > > be a good discussion topic for next year's LSF/MM!
> > >=20
> > > Would an in-tree but out of kernel implementation be an idea? Like ho=
w
> > > kselftest is integrated in the code, even though most of that also ta=
kes
> > > place in userland. That would guarantee a level of support, at least =
for
> > > the time being. I could take the code, verify it, and write some test=
s
> > > for in selftest.
> > >=20
> >=20
> > That's not a bad idea. We already have some userland code in the kernel
> > tree (the tools/ directory comes to mind). A directory with replacement
> > FUSE drivers for in-kernel filesystems could be a reasonable thing to
> > add. Anything we keep in-tree will need to be GPL-compatible though.
>=20
> Jori, if you want to continue working on userland slotions and working
> to initiate deprecating, working - please do.>=20
> > > And there is still the issue of what we do for the syzbot bugs until =
a
> > > more permanent solution is achieved.
> > >=20
> >=20
> > Yeah, that's a different issue.  Most likely we'll need to fix those in
> > the near term. Replacing minix.ko with a FUSE fs will take time
> > (years), even once we have a new driver in hand.
> Does this mean Jori can work on fixing these while replacing minix.ko
> with fuse progresses?
>=20

Caveat: I have no real connection to minixfs. All of my contributions
are drive-bys where I was changing some other vfs layer interface.

I see no problem with fixing real bugs in the minixfs driver.
Personally, I'd focus on things that are actual security problems --
crashes that are triggerable by non-privileged users.

In this case, the problem involves a deliberately corrupted filesystem.
As a community, we have deprioritized fixing these sorts of bugs.
Someone with the access to mount a deliberately corrupt fs like this is
in a position to crash the kernel in any number of other ways. With a
legacy filesystem like this, fixing problems of this nature is usually
not worth developer/reviewer time.

> >=20
> > We'll need to mark the old driver deprecated and then wait a few
> > releases before we can rip it out.
> Jori could work on patches for deprecating perhaps?
>=20

That's probably premature until we have feature-complete replacement to
point users toward.

> >=20
> > > Anyway, this probably goes over my head as a clueless beginner. Just
> > > trying to see where I can help. Thanks a lot Jeff for you answers, I
> > > appreciate it.
> > >=20
> >=20
> > You're welcome. We all start out as beginners!
>=20
> +1
>=20
> thanks,
> -- Shuah

--=20
Jeff Layton <jlayton@kernel.org>

