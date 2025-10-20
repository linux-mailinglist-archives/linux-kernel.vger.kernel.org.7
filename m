Return-Path: <linux-kernel+bounces-860789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F423EBF0F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FE4F2E58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592730CD9F;
	Mon, 20 Oct 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnoo7ygt"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFB3043B2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961408; cv=none; b=XHXmj91EBlzSmvTwrut/Ew+0jYTPnXqdF9UkQ7f+fw3wbcrGqn+oDlImdd0+ijqo6hctmWPM+fVXtGa8biyLXWyB7c5+m62b2HoEPzLylKwBSQDDIXdxv2jSjNoWmZm0TRWBi2Aj4oAtQwW78lAPO4vYmf2F068T2y5lxlfQ4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961408; c=relaxed/simple;
	bh=hTskfQo0NjdF1aO4CduW40V+ZawJynYNJviEmtJkwXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nf/AaDd/tEPWJutNhWTWis9fTGdsCk4DSA52188csVys6LN3BstWsKduAN4XH0ebkjvACt5pC41XzMh0gGFK5GFJU3OQGfLmh/Mg0jqtktF7svFYLXbQmb2zm6VRPl7kuRdwKBohLvyMxfd7VR97cNviD0Qld0Jsha1654k7gUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnoo7ygt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so22951135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760961404; x=1761566204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVRRLNVutxbrlT7gr0KnLXf9XWES3Zc9MH2pzODtziI=;
        b=dnoo7ygtmJfCQ3oABjv7RH/BrUoVZ2AvtX+pTcsA/W4A6XPbcWD1suRCAI7wjdnhQe
         nitMQcPM02RuNUXEGVm4T5e9I1uPvsGCrSTabMjLlwSGWmSx5oy2pH2do2Xh5di+8HPn
         +A5phMQNpzvuLNU9jCWJ700Z9Cda/U14pjaqjDfsnDjGNjNCQek5bT73St32UyGAN0em
         CkOzotNuIe8XUt0lNTs+CSUZz6PmSeO/Dh+zG54LKKZ3mIazngh1JyuPgRvkpLVobfnl
         nUXCvF+GOCgxjmRzWH5syBhlrfu3yl7CZxKURuioyY5VVNQ9ze7mqL+XV5+oQR7TGvCU
         EaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961404; x=1761566204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVRRLNVutxbrlT7gr0KnLXf9XWES3Zc9MH2pzODtziI=;
        b=pafyEoMvJYSV1yZdxRIzjvdzFs/nYmfHg/Btmint5QKVJ0eCh84NYutOe7kmirtCu8
         yznrcJoILN3sf3CsFcTTIanFOFZUgD55m+VxsgWghptUHj0uL+nNXDawbKK5fngTPXCV
         n5fRR1jzRCc97NdV2f/lwFbCOKySZSQOHjv1BPBKe2Z3jBeJVvNqwch/dsgOPIXe/Tv9
         w42j3iqUSnFETfEXfar6sxx6UKaJZq4zJwT7S7tAV+4SBWYqpRaRKlaNuZM4j4Fsksmf
         bnkkQiUYDwfXJMcOeCdBbt4nPrBpelUZm+9hfGuAHkZKTPHQmmGIdNECQL4+mEjUT2AW
         6mBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMrpMQjMqYd02apA0pYucVku5MQk8Zqu9Nh7AglImTR/4luNRDvYfwzFGzSlc9Dd0AFXa7J88uGaWMprs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+9cN1IIpgOMqJE6Cqy9Yjgy79ZygzeXovSrnDGwoXDbCNAEw
	RtS+a7xt3Az2Zj964hHAgsLD7pIXxBgE9IHyAMh8xahMSd7rNJ5f+aMZ
X-Gm-Gg: ASbGnctQU1iXCee0q6NFbOUjLbm5D4bxj7DYk2hUY30Ur4l9MKwOHFz7eSSeZAmpTWf
	YEYFkd/PFi1V+0sdBF4ONMeE8UPcGtyhAUXUfNz45PLGeQgVRS/0CBpLey3iasc3mOO8+Qq8Hs7
	B5yBKikKFEZDblEIAnTbrVk2/pNyYO3A9Nb3aiemMf3Ncr6wGiltMlhAUGHwZ6oBCgR4IfcmpUr
	r0IyG20eIHMoP3YfcmJiz9m3CwF5nvsd4eKmJjkVOydzLe9w+2TQmVmt8Uf0+jauf/jXD6PWkXA
	PL7aW3I476kl73J3VGJL+yTzxf4PoTdz+5LMQGPKymjbwNxc6yN3r0dORFYxLqy0O9AaEDpuE1B
	2T0hB07zccmlfl6PaL2RQisjtljo2wkRqSsBpvJcgSI+A5GwF1GK6f99LeH7r29PL6IGEaawPp+
	qxtEbxRdfaffdT+imYPw4YJz1ZtX79KOi0xchbhLXrUU/ME23VmjZj
X-Google-Smtp-Source: AGHT+IFkDJRMPYkAfm9Q4Et+bgkNbe8x1ULe2dIiNCf2fKKXr9KvgcUITnst4gVjGHdTTBSDvIhbSQ==
X-Received: by 2002:a05:600c:1d9b:b0:46e:6c40:7377 with SMTP id 5b1f17b1804b1-4711792007bmr90837795e9.35.1760961404075;
        Mon, 20 Oct 2025 04:56:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d90bsm142450875e9.2.2025.10.20.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:56:43 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:56:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?R3LDqWdvcnk=?= Clement
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 11/15] net: macb: replace min() with umin()
 calls
Message-ID: <20251020125642.35c59292@pumpkin>
In-Reply-To: <DDN4GPV4RONM.1Z2JDM26J7D8E@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
	<20251014-macb-cleanup-v1-11-31cd266e22cd@bootlin.com>
	<20251019151059.10bb5e18@pumpkin>
	<DDN4GPV4RONM.1Z2JDM26J7D8E@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Oct 2025 13:44:43 +0200
Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> wrote:

> On Sun Oct 19, 2025 at 4:10 PM CEST, David Laight wrote:
> > On Tue, 14 Oct 2025 17:25:12 +0200
> > Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> wrote:
> > =20
> >> Whenever min(a, b) is used with a and b unsigned variables or literals,
> >> `make W=3D2` complains. Change four min() calls into umin(). =20
> >
> > It will, and you'll get the same 'error' all over the place.
> > Basically -Wtype-limits is broken.
> >
> > Don't remove valid checks because it bleats. =20
>=20
> In theory I agree. In practice, this patch leads to a more readable
> `make W=3D2 drivers/net/ethernet/cadence/` stderr output, by removing a
> few false positives, and that's my only desire (not quite).
>=20
> I am not sure what you mean by "Don't remove valid checks"; could you
> clarify? My understanding is that the warning checks are about the
> signedness of unsigned integers. Are you implying that we lose
> something (safety?) when switching from min(a, b) to umin(a, b) with
> a/b both unsigned ints?

The issue is that -Wtype-limits warns for every case where min() is
used with two unsigned values.
It is pretty much impossible to code around it as well.
It also warns for other #defines that are trying to check for invalid
constant values.
The checks are there to pick up invalid calls, using umin() (and worse
min_t()) to avoid the warnings is making the checks pointless.
So you may know the code is ok, but the compile-time checks are there
to ensure it is ok.

	David

> [0]: https://lore.kernel.org/lkml/176066582948.1978978.752807229943547484=
.git-patchwork-notify@kernel.org/
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/=
commit/?id=3Df26c6438a285
>=20
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>=20


