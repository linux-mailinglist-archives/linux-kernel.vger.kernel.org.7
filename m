Return-Path: <linux-kernel+bounces-829842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B498B98078
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D071B20F34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9897C1FDE39;
	Wed, 24 Sep 2025 01:49:39 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC11FBCB0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678579; cv=none; b=trm4+bs7yBgbg7/w/rOJKjTyytlWCqp+Ak4IGtvtfeW21isQS/OhLf6fgPRZPXWkMCsfJQmjNOB/ugxiwHmGhUe7zrWeuNQnLEBOV73+ri4E+6lRZLeOomP8P9GD+t3a3qyDjiBOFiO1xFQZfJwMoUGN2oiOi/Iw7uB3xFCjl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678579; c=relaxed/simple;
	bh=a78yOSPlJzqWA8H0Kkw+FyKGFUxbJvlfCgdJRUnIxsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hh3vEFf9p1124wh8n8XrDKE9+tM1th5QvrPTlsIoF3Utiz6O/hMuj9DdXXJQquDLWn18+QllhQKY1N7c56tM+QQpK6eCvFL4R3mlbSN7auMGyM1QUMeeJxPx4N9JaFCOBENOhi1MrUq6tCXu3gEra0Jfm47eJ1MuN2pKVC0J1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257ae42790so38562045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678577; x=1759283377;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXqa8ZVUKHN/2pgYA2lXi0pwYaxmIHLyLmFVk0Bbclw=;
        b=sJdVNlizpapAMAmsDU15BYCd+nt8Lx2TWj9hyc1PHxdmr3UKQThq3ORMFaTmnw2a0m
         wYf0Kp00gL9wPQ4uBOjolSxumn2bKDSTer1j5SToBXWVSRC8WtYwhERt9qW84wUJI+io
         +7+oPwXdaMSAFeohiN0y/2UxqEh4Y1tCbywhGsLhlZNSoX3rEeLpsX54EIfTDWviNN3c
         HqZtFOZiwy90pWM0OF8YII1Q8essuDfidsHbuG0xwHOsNUAse10JUCinQMYwuqk/eSyx
         ZVhCKYsh6UuiragvemsMWi4oVQKI9DHQD6r5a9az9HUW7TLNe5gZOtsFR9hu7LSQNLLt
         tjSg==
X-Forwarded-Encrypted: i=1; AJvYcCUJWCSD6UAjN+S+Srx9iBQnKq5kd0Nsv4kk074BH3o6Zn0xQV/RKea3Rp6WcLTlwzl/hMeM5jega3BTOXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRG0EGqP8XYHOmAFhVErD0MHQYOk2JlU4s3QNVYDpV/3/lFu70
	r637S86HMlMLty6Nt/Q911k/VheVd4xDiXcC1OhJyqK2n49BHvOypDylgmBM3hLWuz31fnpyY6D
	chlePjZsRvEmaPz1Ca5uNl+rILwEnx90MaFdmWFdh4RtN5d9vXzJ0NICLISI=
X-Google-Smtp-Source: AGHT+IErBKB2pIbdmGNVR8AR4U0hYMeSxtxw4hyHrsOw/lklznaPY96fkm/z7eIS8VTf9QqaCcltWUn3zmEkBCYyXHtqlnWZfzg8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:424:553b:f2f5 with SMTP id
 e9e14a558f8ab-42581e17756mr68269305ab.10.1758678576916; Tue, 23 Sep 2025
 18:49:36 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:49:36 -0700
In-Reply-To: <20250924014929.1097959-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d34e30.a70a0220.4f78.0016.GAE@google.com>
Subject: Re: [PATCH] comedi: fix divide-by-zero in comedi_buf_munge()
From: syzbot <syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com>
To: kartikey406@gmail.com
Cc: kartikey406@gmail.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
> The comedi_buf_munge() function performs a modulo operation
> `async->munge_chan %= async->cmd.chanlist_len` without first
> checking if chanlist_len is zero. If a user program submits
> a command with chanlist_len set to zero, this causes a
> divide-by-zero error when the device processes data in the
> interrupt handler path.
>
> Add a check for zero chanlist_len at the beginning of the
> function, similar to the existing checks for !map and
> CMDF_RAWDATA flag. When chanlist_len is zero, update
> munge_count and return early, indicating the data was
> handled without munging.
>
> This prevents potential kernel panics from malformed user commands.
>
> Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/comedi/comedi_buf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
> index 002c0e76baff..786f888299ce 100644
> --- a/drivers/comedi/comedi_buf.c
> +++ b/drivers/comedi/comedi_buf.c
> @@ -321,6 +321,11 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
>  		async->munge_count += num_bytes;
>  		return num_bytes;
>  	}
> +
> +	if (async->cmd.chanlist_len == 0) {
> +		async->munge_count += num_bytes;
> +		return num_bytes;
> +	}
>  
>  	/* don't munge partial samples */
>  	num_bytes -= num_bytes % num_sample_bytes;
> -- 
> 2.43.0
>

