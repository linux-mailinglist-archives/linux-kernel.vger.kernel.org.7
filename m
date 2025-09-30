Return-Path: <linux-kernel+bounces-837610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D3BBACBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35846188EFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66EB2853EF;
	Tue, 30 Sep 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlSu87lr"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703527B331
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233456; cv=none; b=cqpFigV1fuKrsmyDvM6h3HeNt0Ca+2XMi/7GpOm+JKbwmI3phSOJMR3HySDsF+dIdzxrffqdwCbUolcs8QvkrDjvYrhvtfcH/1+UnoIaBBoVNVV6DQ/17KhmN0rEgZ9PdOcVTWdkQvE8P3ywexfa1iqwckL0/45OyEwP2VnlFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233456; c=relaxed/simple;
	bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBxbEW/zhJ1J5VGLLtRBo2m8pqr/VQ6Z4dO8xvd1ayRVebl9wEElTg1xfTHpw3a6/JeFMyKlmy/3GQj1sGgQSwIoVag3UEdjrghh6/hbKbJzKkKMzO812trcXp6EYTpZaSGsKbDRC5YEUpM8DxWyZq7ovjIib5HC49jnY6AgrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlSu87lr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso8027342a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759233452; x=1759838252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
        b=JlSu87lrBGp51zsJOfS9Gtmj29SnA4ufqCSxSgHLG/eerN4NAGR0zwFC7Vn0rRPmGr
         lfVXhT4I5SLzKGbFeyhTPLIki5kJryEdq6lqeZibAhgb/goZkpLkO5idZrqNj4Xwdfgq
         n+J68h9pG26lJcNOrEZGolrcmJLF9TTGyevKASMmtAi7VMutSl5dHEyFdjTzleVzU65i
         65v/+tpc7UINF+ghDj6DUn5uXatBBuk0K//EfbskD7pdUD/kdH/BNThSVtsYM6dltJbl
         dX4q52N9EaeEAY+hgi65d7EiMBoHYHnpAA/RyB9R5iKlBmHHEbuH4+rhyjaafxJtyF2I
         UwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233452; x=1759838252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
        b=Qsu7fS9xdlqlGer1tfWaQCHxww0LiEy9ge3kfOsp4+uM8txyH5WOrJ6toK5EX48OCf
         H3aGblaC3t5NTL3FfA5+sQaKWJaURAykyhu5yOJTHUoVEb6/e+y6gXiEnqD+onUphflG
         PsAQ9Hxk2dEXcjrd04PJ0c3slamE5tiuW61Ugn4MVICG5apixFvmjJF2Yrzw1tHOT8YD
         w4myJMUjc343zJPsMutyvDvSBw8e8EmZ5PdzQk5MdSV0pYHnx6CGZrY1pBToY+a8jFOq
         e43Caa6dee0pMdAH4nV9Po8wI7nv4PEqb8epPXJtOOLOGG4zSRHpKA3ytxZJCboOLzoD
         jntg==
X-Forwarded-Encrypted: i=1; AJvYcCW+zjtOYxPO1wC4W5xA9hy+56FbZjmj9MpITyWiQ4KPGq7vKQHipwzmV5epcxErzPOxX/KEtFOi5MIKaf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+XFT5I5nANLm9stHbaXQlQgB5yLXJVkdfdCWbcDJQagIG8fU
	HQCAT9LyUUhxHxfsb7nwFdcCfZTh3MnxWXuiHUIXzLRLPp87LZ9z9I4sqSOcrhpliwGg+RAUVux
	xKUQCzP2ehaXXpdexkJ1ZcOm8uRnGePQ=
X-Gm-Gg: ASbGnctKFw5mp8+jQq7SHjrr9Y2tE5TTPF1rt5cD27U6A4HZG57q6lmmPTYWdcOPm+L
	tGNUjtPZMR9BM8N+mg+q4Bgw1TB13+d+gN+uWv8lKYoDKpJgd9itRrNgPssO+EIT6hMju3OvBai
	i+gUeVDnpXe6ABuhhOFneg96vURjIu+0FqqbLuMOXfarUAuFdW7PIu8tb/QORoM0jgp9C3uNBZ+
	skx6k1hgZ4I4HwZ7zsgYuWS5yCluxKBJKy/lzGRPZ7bougT1Bzb4xbBi/a86umVT7x3QR270tO+
X-Google-Smtp-Source: AGHT+IFMtK7lQG2C6CXy0BdUz73VA5EZWA5GWFM67vubKVCmaj1C4S2cfo3XpGObqlbGqLwQb0CID+MEAVyWsVhI3os=
X-Received: by 2002:a17:907:1c95:b0:b46:1db9:cb7c with SMTP id
 a640c23a62f3a-b461db9dc6cmr76159766b.33.1759233451417; Tue, 30 Sep 2025
 04:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930100656.80420-2-sidharthseela@gmail.com> <a21498ff-4dd0-4b3a-9b2e-9b932b5925ad@openvpn.net>
In-Reply-To: <a21498ff-4dd0-4b3a-9b2e-9b932b5925ad@openvpn.net>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 17:27:20 +0530
X-Gm-Features: AS18NWCxdvM572oUhIGZSez5YvvgrvAB2_xyu9_VKgGBmy-3EY7uowJXb-VjjF4
Message-ID: <CAJE-K+BrTdtXTF6VgRzen=YVmuUgU8ktu_36nXqc2vTF=u_vLw@mail.gmail.com>
Subject: Re: [PATCH net v4] selftest:net: Fix uninit return values
To: Antonio Quartulli <antonio@openvpn.net>
Cc: sd@queasysnail.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	willemdebruijn.kernel@gmail.com, kernelxing@tencent.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 4:50=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
> Hi,
> Thanks a lot for fixing this - I hadn't see the warnings with gcc.

I am glad, thankyou.

> ret goes uninitialized only under the "if (!sock)" condition, therefore
> I'd rather assign ret a meaningful value instead of -1.

Yes, you are right.

> How about adding "err =3D -ENOMEM;" directly inside the if block?
> Same here.
> ret goes uninitialized only under the "CMD_INVALID" case.
> How about adding "ret =3D -EINVAL;" inside the affected case?
> Both values are returned by ovpn_run_cmd() and then printed as
> strerror(-ret).
> If we blindly use -1 we will get "Operation not permitted" which will
> confuse the user IMHO.

Alright, understood, Thank you.

Sending in the changes in v5.


--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

