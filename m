Return-Path: <linux-kernel+bounces-755353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04CB1A548
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD8B18A2899
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14121F9F7A;
	Mon,  4 Aug 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4Gklk9u"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D15201269
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319123; cv=none; b=PrAT13jcDf8ri7kRih63XUkumk4wITHtb2If9GrI/t5smMfl3PIAtURmtdhSdUmKpokqEkbs83JAvahNw0BFo9IyhIomPt4M2qi9D3+7npf3lqi32Ice7qUOa4LydUEVyLA+x+orjvwk8fj0YVn4or8+7EAT1s4hrqLKIqfe9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319123; c=relaxed/simple;
	bh=2y2cW/nVA+NcdxY9F5J53rimKrYI8WYONjvDon0Weuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6baFLWsC8WV6r4UJS9WgdKWls/Fg2i61cEVR+Rs/yEiP9dX3ddGp2WS5mWktW7/ieyttwVfIrUDPPvpmlben/d1OpkeJGIV12KKKB4HHthLQ8IY2bLCmvzoWJi/P4O2lERej7x7PmFUVD5oWB4z1X4o37JNjEU4Jq4HxLdecKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4Gklk9u; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0739c6557so10800261cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754319121; x=1754923921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmE1vMT8V0fPcAqg3vqWWI1l9zeCtCrbJptVBplLKHg=;
        b=I4Gklk9uNjuM6GhzyVknuRJxojDW7cEats09IE6tO25GTA3cxsaEZGTULxiJDqxfy4
         m0Qw3apFcUVJ2Im3yhswMHBB+fcaHAsfbuAUhjkGlXgSKbHBzMtCdG/1f0LJcmv3SFuV
         7/d44xdDGombIdt9LvvoqldtkPm5QXPajM7ZKr7yOS4An3fEwZJ0x+qYoCVE4uVWt9hr
         Fa+fBc9ycC1XthId8JDPdO2ETQlO27hztpVScNTChrg66YY3tDr9GW4nA+m21zglKcpk
         Z3jpouZG0dj8BpCqc+Jvst54+846L0o1fyF7LZ8WRk06A7ksv8EQTUhzEUlJ44YE5Yyh
         71Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319121; x=1754923921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmE1vMT8V0fPcAqg3vqWWI1l9zeCtCrbJptVBplLKHg=;
        b=Cq3g8tEwKh8XTrVu3J3Hd0cVxboOmRL7KZZj218P8bSPgihIYeUTXSqQcE4nAK2O4K
         LH3I1TfHGjXjiSld4k/EZhB0qEHbjMkSgBq1Kq4u+C7zXhRipxYP6avX2LZRGmM9z7ji
         jWjs9uEXVgk2rp2VcOQIZantY/VUl1BDAkIx815geu3SS6yVe+XRtZuarnbGMAdOZT3w
         o4zS3q8tfZLZ5jN4c9Sz4swgXiholhiEYiVKLiBIdENw2L8M/4wKgw6IGb1e74ocuRuS
         XwEf5KrZTW722ybff2dnY+WkBifuZlNzxAF2FJLx/vKGaj9wCjf8sb8O/kH05q4aAUIr
         63gA==
X-Forwarded-Encrypted: i=1; AJvYcCWmQY1BilBTLm9XJs4RchRSPejj8MoytYAp7OpAYe9ODBB0J55ZWMBNkzJadIBBmfqRRioZnlSZxpD2q68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Uwd7i3FxeteT1CyH5i7s1pclkHaiKNzQ2PPay8J5Qh8P8l5P
	RIEIWhxk9dRKgAb4842O+f9ZaG4V8yCyytqNuBXOSQ4179Zsg0W7ev5AEF9SZxyQjUDH8X6Goba
	RG+X/QGmUxNtvusI5Iyg6tSmdKI1sduuqGbDEW9nF
X-Gm-Gg: ASbGncu/ziZ4+aOuFas9QM+PCN6tEzHB9mu5FfKMFT9m8OvXeDb5na9kiz3/edUJsmh
	5g0XYseTndYL7OFyT4s8glIqfn0gIM4/ghtSo+5BcN92tqbZy3RGps+itz7811F06BkCsPDQ+4j
	3pAS00JDfszJ2rLt+wKJGqdbaQpKB4ZJ/QS53CFLTp1T8Yjp6OeoTsTuw8E8L1/5RwxOPkJPULR
	v9f
X-Google-Smtp-Source: AGHT+IFN4OQcigJdLkT1/uANlBF6fmKo4Koz5CBEMaqvT84b+f/4ncu0Dsk2NICeTABkWTTkJzvJUKiP0P4dGY50/5Y=
X-Received: by 2002:ac8:5acd:0:b0:4ab:3a21:c08f with SMTP id
 d75a77b69052e-4af10ad666dmr136169211cf.47.1754319119219; Mon, 04 Aug 2025
 07:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804143918.6007-1-osalbahr@gmail.com>
In-Reply-To: <20250804143918.6007-1-osalbahr@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Aug 2025 07:51:48 -0700
X-Gm-Features: Ac12FXxrPFlqdIJn4rF2OSxwQzoUrreDnpy9ONFpa6xDERAqRhOrr90DDkNoP_Y
Message-ID: <CANn89i+UZOcFKjoTLJtx0M4-TPy1Do6CVsJ7C-OWkoLGQq_F8w@mail.gmail.com>
Subject: Re: [PATCH] net: tcp_ipv4.c: Add missing space
To: Osama Albahrani <osalbahr@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:39=E2=80=AFAM Osama Albahrani <osalbahr@gmail.com>=
 wrote:
>
> This commit resolves the following checkpatch.pl error:
>
> ```
> ERROR: spaces required around that '=3D' (ctx:VxW)
> +       .twsk_destructor=3D tcp_twsk_destructor,
>                         ^
> ```
>
> Assuming the purpose was to align the equal signs, I also added a space i=
n
> the previous line.
>
> Signed-off-by: Osama Albahrani <osalbahr@gmail.com>
> ---

I have a patch removing .twsk_destructor completely, waiting for
net-next to open next week.

(DCCP has been removed a while ago)

So I would vote for not bothering with your patch.

