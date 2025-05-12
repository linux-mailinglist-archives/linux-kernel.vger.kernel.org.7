Return-Path: <linux-kernel+bounces-644906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B13BBAB4605
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 23:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CC37A7118
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034F5299926;
	Mon, 12 May 2025 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CA8CYDez"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B173171CD
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084793; cv=none; b=WRkG1ROanc4Hz3X7ZQVZhCRioXoOGqLhofVzZ/3xXMjqmg/uSXD8egJ7tiJnOXLVAXIBEDTJW6zwD/agPyy9LMWniMXCaEXjwBrO4MD4GpfCNda2y7b7PNNTykT5hwUvWGtntHUqSo8vJdnQWy/10DSv7uUHLOj/8zWLTpSmKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084793; c=relaxed/simple;
	bh=lCcujwKSU3w1jcYrwfrSXtqlQ/NrzkUtlwo4Byv5mLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlMrD6+C6YqgFwLK4PzmDa4UQGO/Oc205nupAmlYf0uE/kuAHc7omWjf7HOzZm2HaMt0f6IKjbl9jYmvLZ5pNArtEvsFPtZawmjC1DjMqPpHUi4bJow/7BdT8kLxVWlMauLrBXHPNl1W1x3XdiS/APNP1h7l9dTgHi7O6vj7aXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CA8CYDez; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7099bc957d9so42245567b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747084790; x=1747689590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwRV/MUXoZXzKoHi8ax+Cf7gPvGpnwdQMG2OKwPrQys=;
        b=CA8CYDezQJaQfv8vG+f6EMwyLDmU1LZpRmIADewLaOnNyyVwjj4CCyBeoDoLYWmQNy
         x02cR+f5lIsy8I9hDEzyzdcbw/dwVQdi7YReWDws/yNSt2GA/8tJS+oYo/I5AmmUtxD3
         C5hZXS2h7mHRw75KEVlAiTjQJ+gNvdIJFFWPUBLGKRAObFB1ZHfUtAcaiETHEu1XcGFV
         Y5wo7Un50qImynPS1sAr2WKrMlQv1ZyWyKJPzv6yOX2907MfcdTxl+6D0u04PfxhBV2K
         SHhQZcRBpv2Q63trWnda4UNJmJ8tZu19+EFYBc5kuPgAgRnf96dyfonpXtWnaJvz94Mi
         avtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747084790; x=1747689590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwRV/MUXoZXzKoHi8ax+Cf7gPvGpnwdQMG2OKwPrQys=;
        b=YH7c0nLrq3oa67813cGXAqye2mTYNOzgh/QjzTajFjc1eOjRvc9JRk7/qRoeep6S+2
         LkForLa+cqKXTqGd4KZmDPmElbyfW1+0mkVOx23itU2KjD8hzEYzwAfqvAnCZoLAtgZu
         d7nPVm5ouh9yvP5ESUoRMFcnb+sqDtndn6hfPWs6pN9jopn/fI1Ii1xXoY8gppKPXFfZ
         o0zSzgNEJUDy0OOsGESeHuBxvo/mcpsbCDHf0672yK9xBtSdya2y063rF92wlmbA75mi
         w2QaSJyxTLCvDIvvf3M7k5qATvy90lkJWAkuqKwc/HFHH6rRsDPsz9Y5K/JD1RaIkK3H
         VFUg==
X-Forwarded-Encrypted: i=1; AJvYcCUznzB+zixTjbuDOcQzZ3LSqOSKwQNX02GmpPqtmPK64Yb6GEE/3AmbwaQlxVv/RMjD+q+Kz3rYRmhxPjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DzwzdsoiGONStxhVKiuE1wGLGEkwPfKNUok3FzhIXJzRTlmT
	gmW2s8JKLRM3CW5e8kOAm01nNQjlRkoDXHrtcGHXTBVyozxw0WM3ElXxXOSfcXPQN9okZqxrHVd
	/A/pKTTmgMz+WiZJsGXePiTkH6O7TT9swxFHr
X-Gm-Gg: ASbGncvNcz0N1ANHVM6KUz0P8DkWRh+4/Lsy8TIW7kyBTrQ1lXN8ednpIaNiz6ifTsr
	Ox5VMbKkmhN3mpmfnMvsFIejzRM/rbtZgjtr/zS6UgJtR0J5+n3TsaFz0sMKdGqFbH0C4o77Ll9
	eUl1wLQ0RFOf1ornoVqalSJDCVAGZWpjXr
X-Google-Smtp-Source: AGHT+IHaBwWTfT6ruc1d2NRMdZAxfx9GA4jA5DmL6sXeH1MGGlqeGp1tSLycaLgQ/VJh63iFTSJsjl/CTNuC0tQ4maY=
X-Received: by 2002:a05:690c:708d:b0:703:c3be:24ad with SMTP id
 00721157ae682-70a3fa21281mr196479397b3.14.1747084790434; Mon, 12 May 2025
 14:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
 <20250509032326.GJ2023217@ZenIV> <20250509043712.GK2023217@ZenIV> <20250509044613.GT2023217@ZenIV>
In-Reply-To: <20250509044613.GT2023217@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 May 2025 17:19:39 -0400
X-Gm-Features: AX0GCFt5UrvqELAd5GmquD5DudVlR9GHsaIry6o_6ef-FzHHAxMFl7KmdHPjI7s
Message-ID: <CAHC9VhRp5Nb_1FPu8tF6EUsPpSEbbTT0K7a3V-Z7OWKNXy9Yyg@mail.gmail.com>
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in securityfs_remove()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: alexjlzheng@gmail.com, jmorris@namei.org, serge@hallyn.com, greg@kroah.com, 
	chrisw@osdl.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 12:46=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Fri, May 09, 2025 at 05:37:12AM +0100, Al Viro wrote:
> > On Fri, May 09, 2025 at 04:23:26AM +0100, Al Viro wrote:
> >
> > > I have fixes for some of that crap done on top of tree-in-dcache seri=
es;
> > > give me an hour or two and I'll separate those and rebase to mainline=
...
> >
> > Completely untested:
> > git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #untested.s=
ecurityfs
> >
> > on top of v6.15-rc5.  And I'm serious about the "untested" part - it bu=
ilds
> > with allmodconfig, but that's all I've checked.  So treat that as an ou=
tline
> > of what could be done, but don't use as-is without serious testing.
>
> PS: I'm really, really serious - do not use without a serious review; thi=
s
> is a rebase of a branch last touched back in March and it was a part of
> long tail, with pretty much zero testing even back then.
>
> Patches are simple enough to have a chance to be somewhere in the vicinit=
y
> of being correct, but that's all I can promise.

Fair enough, although unfortunately I don't think anyone has anything
close to a securityfs test suite so I suspect this may languish on the
lists for a bit unless someone has the cycles to pick it up and
properly test it.

I haven't compared the patches you posted on-list with the stuff in
the tree above, but based on the timestamps I'm guessing the on-list
patches are simply the ones from the tree above?

--=20
paul-moore.com

