Return-Path: <linux-kernel+bounces-841202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F076BB67CC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B209F19C5510
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAAB2EAD09;
	Fri,  3 Oct 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if5H8jHK"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313D28FFE7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488691; cv=none; b=IheOC64FIhOlBtxxJkPkvRZUy1ndiUoTbgjnuxq0I6m6cLkGmzPiFgrVOdckDTmQSV/bA3+hgWY6J04duxEfoFe02ocZb4qrT+zcX421gwd2EFwLBHKupYTd2A7Lnc9i/epseTMp6LmFjpa28/Q722vu/KrAJZsZm/bP9eRSvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488691; c=relaxed/simple;
	bh=7WuQvN47KuHlxwLh6G7nSK8xpgJhPrN20X/kb2POtC0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ufOMQPJ1MRkqcr5Dubch5t0raBGKdwQm8U17MW8epbAhVPA9d+N4hTAwob9G2OvBNZzSIp9jDduTcHXLDOKWQ3+undJv4yE77YBXFUz0mxzoHUm0xFhBJ0pAOzucmVlOxKWblreu188uaTTTbA4cuADZjGqRvBNADgVXx9qxlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if5H8jHK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso806876a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759488689; x=1760093489; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZqbWA0IXZxSaSS6yEesjjunZ8q/gDhE+C4uxmvRgz8=;
        b=if5H8jHKV5hp/39fO7rge7OEiqFDBY2xYz46avQgGzkMrpdlIS1W8HW5r9RycOOJcj
         SUYt4mJOe+5BHt8bH7oEwaZ0YLL1NCZ3L31YnyiU/S64wAkDANvTDUbk63Ax4PaBWq2d
         HecPBa7I+Z95/qHivlYgPsjvZt3DYPz8MMLGLz+rXutwnz9rcKMrjWOcTM8HWZ6T/MuP
         9OLbB/eZfWsPX4YuwKGYCFEPxvaOZScDjddmFtevbjd+DRwGqtGWQFVWRfS1aNtWILVv
         bEuSfFYtnhlourWB4ccS5wBfW6ri2C+xbzDaSQB0ieUWwknrqcq+QoGGDq7jogKuN8M4
         x9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488689; x=1760093489;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CZqbWA0IXZxSaSS6yEesjjunZ8q/gDhE+C4uxmvRgz8=;
        b=DhvoFSSKfWbo2FH5VuhOWPZSZErFprMIwErp8P5I7Az7RXRb8lkAA+Xo4wCFLumNd4
         cLupLwWcmAhImzVYnSDN4/yR7oT8T/JtvMDuuBwmF6L7IgwGWq0DgAA76+GRGKGNcwcl
         LVDfYeSlAypG/+X7g/CI3yVKiiNaELnQR+DYViei6mv2anY/obHga6fIui30t+zlYIwE
         nxxXHGR3+i25p4eXJX+L5Wilz0GpmRaqu5hf45BlUwi4MIBGd6bRh7KxC1sv2Tm12Snk
         7jzqkIF9hfaRHNVn++fpwNO2Tmcy3zbaMUQ3R+Br9jUQxWdapBg87U7ClXrX2eeCKLiy
         Axqw==
X-Forwarded-Encrypted: i=1; AJvYcCXZL8bA3kaZ4z6VDoUrLGp0PNMFaZM1cw/EdMPPWSFoAJVHfhfismoKwBEQceKAfqA31N1ypNxywqpHmFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdHkltio/MEXg5lHHl3pJotwzfUt/cLp51+lTI1bXdFoLHiY+
	/VtsE9LH97keersNMoqOn16q1q3iKczQxZjbGzx+9DxtKcegimG9YTpt7YA81Z/TtXk=
X-Gm-Gg: ASbGncvoY4Oue+EwQGvbYVe/hk7QPOFQaFy/JwQjd909dcKt4n0ZaDDFf5plWdZ9CL0
	06VS5OOo9jXU3AoS3ucZEk9NIxExiZ3nYQTNHPbhZHtMy7Qfoi8N+eC93DrLJcRKP673gJqCOWv
	1e1N7krtGjYEE6uXwuYGL7WXF0sFQJIB1VJBBKsyt/DOSN0SM+BR9hyhWAfXqvnqB0dzZBiCV0y
	CTNSfSXmGZQFiEw/h3IPZPU4Z2sbv3ICxYiaU6O1an0QDaVDGq6MhMHiRhG6KQjAKCuEuJamT4n
	4/I7lyC/FMUVhLo6NPI6STtt9b5cgKc5M+i+po1vMYQ7MrTXag3IHMTwIRKigmwzFHMk6KEvYkP
	OKr0ZZW05k7Gdx4y+cT+Mz4Zvaup8kk0uOnohOGOlGLM=
X-Google-Smtp-Source: AGHT+IE019qLAGqT7xhh+U6XQyWt1WqJ6du27GF4XNEYndo9ZUvlHYAGBIV5Qn2fBOC1wrpWm/3mZQ==
X-Received: by 2002:a17:903:41c9:b0:27e:de8a:8654 with SMTP id d9443c01a7336-28e9a674da9mr31151765ad.57.1759488689195;
        Fri, 03 Oct 2025 03:51:29 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d038e4asm47405025ad.0.2025.10.03.03.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 03:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Oct 2025 19:51:25 +0900
Message-Id: <DD8MONMKM9ZD.1PT79LGCA7U06@gmail.com>
Subject: Re: [PATCH net] net: dlink: use dev_kfree_skb_any instead of
 dev_kfree_skb
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251003022300.1105-1-yyyynoom@gmail.com>
 <20251003081729.GB2878334@horms.kernel.org>
In-Reply-To: <20251003081729.GB2878334@horms.kernel.org>

On Fri Oct 3, 2025 at 5:17 PM KST, Simon Horman wrote:
> On Fri, Oct 03, 2025 at 11:23:00AM +0900, Yeounsu Moon wrote:
>> Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
>> which can be called from hard irq context (netpoll) and from other
>> contexts.
>>=20
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
>> Tested-on: D-Link DGE-550T Rev-A3
>
> Hi,
Hello, Simon!
>
> I am curious to know why this problem has come up now.
This came up because I have the hardware and recently dug into the code.
Until then, it was not considered an issue, because nobody raised it as
such.
> Or more to the point, why it has not come up since the cited commit
> was made, 20 years ago.
I think there are two combined reasons why it has not surfaced for two
decades:
1. very few people actually had this device/driver in use.
2. The problem is difficult to reproduce: one must use `netpoll`, and at
the same time the `link_speed` must drop to zero.
>
> I am also curious to know how the problem was found.
> By inspection? Through testing? Other?
While looking at the `dl2k.c` code, I noticed that its logic calls
either `dev_kfree_skb()` or `dev_consume_skb_irq()` depending on
interrupt context. That logic gave me the sense that a similar issue
could exist elsewhere.
>
> ...
And read other driver codes and commit messages, check `networking/netdevic=
es`
(.ndo_start_xmit), enable `netpoll` and set up  `netconsole`, read
`net/core/netpoll.c`, read comment in `include/linux/netdevice.h`,
add countless `printk()`s, build millions of times... and so on.

