Return-Path: <linux-kernel+bounces-790167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABBCB3A1AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29373BE38D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07E221B191;
	Thu, 28 Aug 2025 14:19:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823819C540
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756390746; cv=none; b=Lwy1NHPxQFC2Uf92XgY2BHaXNqS/qBGZKqxOOI0W5r9gLe0LFipGxM9N1fCfltWaLD7tfElsteyl6dls5UBddZ5uDcbm+3bz2gTfTT5fwjqhYFOfxeWB9Z3hpcMTdbPesr5iDrJ3/OCiw9yR+bZrwgRfokOxKicvtrbUZvsVsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756390746; c=relaxed/simple;
	bh=3cQdIAQuhU1GXAB3jlcby/wd6kRK4ewxh6fbJ9H1EKA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BIrbXDmA64Ndhgxc2F5Ioy2wo0he+fYZ7dnrd19jieWJiTYJJSHQu1AjWhMnyDDzoZDH43xKuV4cuEwPKuwrqfwzRM3VWROWVWa6mTEnfPqtrgw29sIKmd0NQMq5WgJKaFXIoULnErfysjejQHTB3oS8c4gkjyoGX2BR5nj4kQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ea6a44ffd8so11932885ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756390744; x=1756995544;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vNxow1Z7vCc8nY6sViGrYogZaBqbU6MUUUZBffzoGs=;
        b=eifeHJnP8tGBAJD/br3vPVwR7bj7v1e3W/cku+3Zf6qrhAuGd4ged1i53ZnjHoNsYS
         TutMZ8HwzKygvSOiJoGTiAyo65NDWwPly+lrO6kxknibcjuAufrECAq4flFbU9MYfdmq
         BG5ZNb16tumnhej7LggpWy8/+ObhWQZafhn6wIdTtSDnDI4/yijotbSz9iksFULhkeRh
         l+YyPfZIO+p0pNxDBfMLX56jwovOTNiubW+W0oGtgqjwEKZ7SZ+64EDldWjAXbPKVwIu
         mjfrpwlTGbpIgCKuo9U8GMj0eq6hEaZ3Y2MZXVFL6G6DWX7CX/RGZUWYVst2A7eLtnjb
         bokg==
X-Forwarded-Encrypted: i=1; AJvYcCVmVWeyW8tSEnWpBHSTFJZWyXCbGZx/1bS58loOuraf2cLtiVDu3UVZAomeJWy172557y2j1p54UrAVok8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhBescedt0M16dHl0ypY/T5jLOrOs6VBkJv8zj7scCd3jHG6n
	u7dTUZyjLkmqHDPSUfdSlgYG35WUEv9pXkPNBC4BuYXh65e9H0QoF7fCKThYlMk1ESuH4KvD3o8
	9K6cTBxP0Dn3K1okeyPmBzPLvbYamWWRed1alZPbLkknbKOCgYQ+Sorg6yWw=
X-Google-Smtp-Source: AGHT+IEAsfDAB+GRCAtz9L47WXgVDN8Fafo/oZRUP6vraSq8iAYKs0bPJewkCZDCo3k0DBEApDeQxYxSuBgLL2hUhJOuYKBNT8kl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fee:b0:3ed:b52f:214d with SMTP id
 e9e14a558f8ab-3edb52f244bmr154580235ab.23.1756390744049; Thu, 28 Aug 2025
 07:19:04 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:19:04 -0700
In-Reply-To: <aLBlIsFngakFf5vO@Mac.bbrouter>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b06558.050a0220.3db4df.0022.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 release_sock (2)
From: syzbot <syzbot+e5e64cdf8e92046dd3e1@syzkaller.appspotmail.com>
To: qianqiang.liu@163.com
Cc: qianqiang.liu@163.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.

>
> --- a/net/bluetooth/af_bluetooth.c	2025-08-28 22:02:06
> +++ b/net/bluetooth/af_bluetooth.c	2025-08-28 22:13:46
> @@ -292,14 +292,12 @@
>  			 */
>  			goto restart;
>  		}
> -
> -		/* sk is safely in the parent list so reduce reference count */
> -		sock_put(sk);
>
>  		/* FIXME: Is this check still needed */
>  		if (sk->sk_state == BT_CLOSED) {
>  			bt_accept_unlink(sk);
>  			release_sock(sk);
> +			sock_put(sk);
>  			continue;
>  		}
>
> @@ -310,10 +308,12 @@
>  				sock_graft(sk, newsock);
>
>  			release_sock(sk);
> +			sock_put(sk);
>  			return sk;
>  		}
>
>  		release_sock(sk);
> +		sock_put(sk);
>  	}
>
>  	return NULL;
>
> -- 
> Best,
> Qianqiang Liu
>

