Return-Path: <linux-kernel+bounces-829840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6BB98063
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5F87B3265
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B83200BAE;
	Wed, 24 Sep 2025 01:47:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28B17A5BE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678455; cv=none; b=FIWsN6KRZYfvfDipi1vrZW8RdsJe+kTlNi4moccDQinNUU6ZjwtrZo/n08sJ2ON0tlMHBQGDt+Yw0aUGZKfjcqtlyQZDj33cxMgz3m9gkYqDMCaNJ+H14NLd8jyLXHPNrtYo1etCD/BIKjXLzTVozrU2WMTbrr92ttdmBqyYEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678455; c=relaxed/simple;
	bh=a78yOSPlJzqWA8H0Kkw+FyKGFUxbJvlfCgdJRUnIxsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=qsVBZyosRI4ozXiO6x5gfPRnoVqRlxS8IcxJjTASCu5ENH1xDf1nCVAmFleyZC8BJ/omqDcVjzG54NDGqYQjLxiyrfNpUCwJKc/GB0dZ3y4hrimHps+FXWjtle4dGBYQ7Nbz4/KOGtdP1VZO9Xx+N6KbIPhx+8mcnPZMaRQ20CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-893620de179so1384887339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678452; x=1759283252;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXqa8ZVUKHN/2pgYA2lXi0pwYaxmIHLyLmFVk0Bbclw=;
        b=AqKWjQigTBwrKdimAFzFTnDly8ELo4HIBIlZRBsUt2eyQfuu3F5i5OjkyUNGvcdOZ6
         zFpRAJaIXhxlfqLjAkHZ/zJlBzG2fdrHQ4flqq7z14NOdViAf2sE1GJKlYR7rMiJXEN8
         pgubwwwny8NERBxDJ/BLpDCRz4ivf1iZ5X+TUoryXkAlsGtjCnG/OH0naSIO0ODnp3DV
         mF8amEon67oSgDCfL5/1KS3O9lPIeydGPl2NTkOUnmIuCKlBTSZTJx67JLe1v1GMcE3w
         Ln+J9L3n52k6+xDBoz/DArIvvVFekgO4Cd5SBszmbWpNb3fymZefqnEBS4W4lppU9QK/
         VdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUStGnR9CmFglxTlT6paGcbgVMNU88KVivoV6HtluWSVtqYVe+uEig5bmT3NYD/pjBQgS9yVPrVBIH9kbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxID5nzl5PlESTOjoe01N2TIG6fuMk82A9POL0K0zYbhUFRYZh2
	1x3U/rvrVK4evYvq+kvv8l3IVWFgGWsm03hnYd8peA9Z0U1ImbfRIeC4gPFVpJIBEPeDn1z4Ty1
	4wtDo21wumOZuUlqEFM9J8oLGks5YYphR0T/SOuk22I3YElmWCABtwO4Gmts=
X-Google-Smtp-Source: AGHT+IGOgaHNUpAopmgCGvJWfvbUXxy4mu5SH+S2Meqo+2nd5S+KrKKE0Eqj+YYf7O72l27Qm+TT+pWE0S8KgoOeqVi7WWzrGsVI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:425:7ae2:b8c1 with SMTP id
 e9e14a558f8ab-42581e10bfamr79342505ab.13.1758678452463; Tue, 23 Sep 2025
 18:47:32 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:47:32 -0700
In-Reply-To: <20250924014724.1097866-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d34db4.a70a0220.1b52b.02bc.GAE@google.com>
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

