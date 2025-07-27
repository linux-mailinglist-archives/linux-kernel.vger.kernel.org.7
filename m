Return-Path: <linux-kernel+bounces-747207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C2DB130F6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512231895EED
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8E78F59;
	Sun, 27 Jul 2025 17:37:02 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358814EC73
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637821; cv=none; b=luA/WSOwpz2D1QPaOwNeR5zItDIcEYGxIisCVPeXYNrUda8xWsRH5jbLyO1M8SASPY6Tfa5ywR1ZX03bfAnAeGZwQovxL3M3X1ThH6WkkWe/L9qdOUhGttzb4au1AC4jlWZQZkEolqh79xDPHvLVW5i6ADzszMDHqbAPuM3+tJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637821; c=relaxed/simple;
	bh=vpxWTWaAM4+EGjcMAHAdAIXHxUMpqtXZxal36t1fRlY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ateqWdx46s78n4DhoH225p2Aghs4YCctLGFOck6K4LMs/rNIvlbLSdBV38vjFjNGVVNS5HX6CAOGd2lUVHPI0Kr6RPjTCOFtgmL8ygx+6RiJ7EGsTd1I4R+l+gz8uIAY5oSrNAOFRzLcTGqGhoEGGf60O8bMaxYJyB/6R1O/fdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e05997f731so84056705ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753637819; x=1754242619;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmldO4aZoz/ZHmPhdfht9+3CJtsX+TJYFu3fQEoJed0=;
        b=BI+gPNQJ6LlT5304C0TNCX1Z79xqKIo6RVFI4IMHiWct6OW/duI1ScKHFhpzN8yncj
         ihX/h9r/BcoM+IuIQEkSXmspn63R6yDXBWz4i810vymhqtp71BuxIfWMIjE1YNumG/lb
         vAZM/EHpbaRtMnrYlt8b5bRYX9+lSzpDr6YE//ucY3SeUbYJeh/gV4EEXUqYafc7lwrT
         t/f0FkkxoS2BVIqfxT1+JBxJfEKnTWt8XwTKNklYSTex9HyyaBbdQdA+pClIJmFKqD6d
         WMraLxFZuNUVbxbBb+v6B1lIdtXmUvePqHAWfX6rlqczlz0HjjqMJv1iyqJaRHe1r1ZG
         rqIA==
X-Forwarded-Encrypted: i=1; AJvYcCXpS1ZaKAaT+saO1/uzlm+erw87oe5WTQH/U7y1wiEz5zWBmpVqlCnQ/VOA+VKQDn2uCpJJfl1LbJpVZYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwwZRLf1HvSLH++oTnE1Tf+aTX6yi4bdZmiE5ONwYWK7Id/hrU
	Hc1fXl+l6Z1rSx9Zk2BMjVc3eKDaoRvd7kv+vmzgnmcZcphycC7FkktU6Ilq2DD8geohLfUM4rl
	hsoHy4y2sy1/QTdJuGr/ISQklKehgdpAdTvTT1GaLjtkxJGyXRy0j+cVplQU=
X-Google-Smtp-Source: AGHT+IE3mvtRK/LCgQXb7FtyrpGReEG9Ww9IekKbxaSWC39BOrf53A9ZK7zxtNz1iFqoAHv5KwCvdpkH3EkvyxCpqj9Hw6we3i2Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:3e3:a35f:a1b2 with SMTP id
 e9e14a558f8ab-3e3c527f044mr190607205ab.8.1753637819622; Sun, 27 Jul 2025
 10:36:59 -0700 (PDT)
Date: Sun, 27 Jul 2025 10:36:59 -0700
In-Reply-To: <CALkFLLJ3Vwsb+idOxXrM4mPXOwjf9JwyV1Jg+tFqFhzx3-+v7g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688663bb.a00a0220.b12ec.0061.GAE@google.com>
Subject: Re: team_change_rx flags sleeping with bh disabled
From: syzbot <syzbot+8182574047912f805d59@syzkaller.appspotmail.com>
To: ujwal.kundur@gmail.com
Cc: ujwal.kundur@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 8bc56186b2a3..4568075fea6e 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1778,7 +1778,7 @@ static void team_change_rx_flags(struct
> net_device *dev, int change)
>         struct team_port *port;
>         int inc;
>
> -       mutex_lock(&team->lock);
> +       spin_lock(&team->lock);
>         list_for_each_entry(port, &team->port_list, list) {
>                 if (change & IFF_PROMISC) {
>                         inc = dev->flags & IFF_PROMISC ? 1 : -1;
> @@ -1789,7 +1789,7 @@ static void team_change_rx_flags(struct
> net_device *dev, int change)
>                         dev_set_allmulti(port->dev, inc);
>                 }
>         }
> -       mutex_unlock(&team->lock);
> +       spin_unlock(&team->lock);
>  }
>
>  static void team_set_rx_mode(struct net_device *dev)
> -- 
> 2.30.2

