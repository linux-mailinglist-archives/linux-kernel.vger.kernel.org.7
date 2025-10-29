Return-Path: <linux-kernel+bounces-875703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 323F3C19A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 217894E2D86
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32F2F12DC;
	Wed, 29 Oct 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STipK1OX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25B2EF66A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733078; cv=none; b=GGuHbgwNL1obHXuzsfHvfWgfL29QBucZF1kDvKarraBAQUhFnGHAE/uTIrHtY5yCpJtTYFh6qPbzQjDs29wljdLZr9iJZlGcVGalCX+7viQuX93F4yX5oTgpNbBMklp3iH/12fHG9HDoe//fcSbHnpEKv2d771YvxgGPCQ02r3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733078; c=relaxed/simple;
	bh=ov5NJpcX/h29FHXKaENmqawt8Y42Vn6kL+Y2zog4UiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1oexUsvcKbr+JysEdwek0n/PCp86LBuR08/IqOFR8NZKAOsXGbp7kV1I4GDUgWWlPSkFzvK3n0MHH097ATwrg6HanE5lYKPh4ulwvg5PnO3SaPjE25y4M0XwWfBsRd3QyueZo7FiNI/q34RU8Ouau5rIIrn5wV/g2kGQ49aEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STipK1OX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-592fa38fe60so8560623e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761733075; x=1762337875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc3RYtne9Z34wcTqrxcL7TmWeAfRrTLykobfWAAkb1c=;
        b=STipK1OXR4JdN+7Mjsf9LFZJd7dy+8yh8aHikqOgJeOfREw9FBuGvfbqVwKH1TYi1f
         PQ80Xmmz4Lkd24/o75tJsSI1OZvtFKW0VZoCIaexVz+4DjgPvfpk5u/Vgwsk0MJBAnQ9
         ErmNRjqerR3uvk8xLfH4vAIFVq9jEMSVdfFsk19CS9a46N67NVXqHUNE+/EDvgiYJ8s+
         quJqbRVAKnZozPydk1G8WY+rE29E4BKHbglXcTqGP+9t9O3VQIdQYpuQmhwg8ebVL6Wu
         VmduGp+HrfDbKTfqwS5x1Y2WNM41DWJCJsedyEL29IoJlIyN35UJs0SeQD1hcrNHMnjD
         emCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733075; x=1762337875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mc3RYtne9Z34wcTqrxcL7TmWeAfRrTLykobfWAAkb1c=;
        b=bqW3+HCVOVPV5MDdZE+whJzsjAncgLauyEhTsq42eXRawHA/PlvuoEcyY0GQNEJrcy
         RyjSWSlwfZ1aOiSDYaBUpkmgMVrlq1V1WJOzghg4rYReHii3+G214kk2CQXcSGB4lx4w
         1RQg4h5zfNNCg1jmuiubwErGSPqfsAlz/AA9pt6onjCU6VTldSZHDpw5BJj1CDrFw1yi
         bPGzrTpAD+LfA+GDA7m32HFfi89Zp5POf+dyp3MTH69ihRI74U6bBMyO4sSeQDu3Vv1t
         kPN9L1NROryKz6VKgXPc8AQ3iNaY6D5l2e3EyNCpqKmezkrwct6e3xw63DF1af3DyJQ2
         RDVg==
X-Forwarded-Encrypted: i=1; AJvYcCVwUVAGxwk5x/+nMlhV+mRozdC6ytDBYyU9g/QD1b3UMsNkLv2G9knSzzE3IaF1cbsKxf6J8xfDoB1zpzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbMLNkAl8pVQl5LJe7z7EZAlsYTkfp+dLgtWj8X2f+7W2V3o/
	XB3ch8pWcUbRQQ33Ifxkv+s03zrmU8uwjYFht5zPOHcUAoklK5LMHFxK50rTVObKZTFTDz4ufXO
	PDWVmcL9Pc3pZeh+bYeAF9kMe3cZqtpA=
X-Gm-Gg: ASbGncsu73Gp8nfGTk7yTgmRyLjG5p1X6LyLpeF0gREJGNJ99W1MIL0U3c+ua1sVgDS
	8hT+hA08kkQVWHWLTCnIHayjXWntay+4L+viWgun59Q/fn51Jo9w2SMqr5icf+tzhg4r/fFvLed
	iGhb1L+W12c4uiCUkxTg9CEL8/vSvqV28YfhwMdx8fcClDv3OH+v6PcFGkSEgWXwXh2SLGW9/65
	XEM/BOoH4mJfvhBGb5PjUc1gElfOzWt7720X6yhwPLG90BVhpLyELr1gmknOQ==
X-Google-Smtp-Source: AGHT+IEvI5JuVV5RWgfOrOAC6kBe8O5q4mrdOfSpswRH4ipD8TC7Z1SGaqw7Uns4/VDNUnSfc7pjUV/4aQ5RmYJZ5pQ=
X-Received: by 2002:a05:6512:2383:b0:591:ebc3:a688 with SMTP id
 2adb3069b0e04-59412901d27mr651390e87.56.1761733070111; Wed, 29 Oct 2025
 03:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68ffe1a8.050a0220.3344a1.03a1.GAE@google.com> <tencent_B12C968C36824B2C74BD76FD66763DB13709@qq.com>
In-Reply-To: <tencent_B12C968C36824B2C74BD76FD66763DB13709@qq.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 29 Oct 2025 19:17:33 +0900
X-Gm-Features: AWmQ_bkW9Pkz3OeMwgBofVdiFJT9IUbkXlDHAnX75mvx4X_fAd3pLTi84SnYAz8
Message-ID: <CAKFNMo=+PiCPcq1M35mQxVP0OrNRw7ZYehbUhEXFOfbnyZb_vQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Avoid having an active sc_timer before freeing sci
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:23=E2=80=AFPM Edward Adam Davis wrote:
>
> Because kthread_stop did not stop sc_task properly and returned -EINTR,
> the sc_timer was not properly closed, ultimately causing the problem [1]
> reported by syzbot when freeing sci due to the sc_timer not being closed.
>
> Because the thread sc_task main function nilfs_segctor_thread() returns 0
> when it succeeds, when the return value of kthread_stop() is not 0 in
> nilfs_segctor_destroy(), we believe that it has not properly closed sc_ti=
mer.
> We use timer_shutdown_sync() to sync wait for sc_timer to shutdown, and s=
et
> the value of sc_task to NULL under the protection of lock sc_state_lock,
> so as to avoid the issue caused by sc_timer not being properly shutdowned=
.
>
> [1]
> ODEBUG: free active (active state 0) object: 00000000dacb411a object type=
: timer_list hint: nilfs_construction_timeout
> Call trace:
>  nilfs_segctor_destroy fs/nilfs2/segment.c:2811 [inline]
>  nilfs_detach_log_writer+0x668/0x8cc fs/nilfs2/segment.c:2877
>  nilfs_put_super+0x4c/0x12c fs/nilfs2/super.c:509
>
> Reported-by: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D24d8b70f039151f65590
> Tested-by: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/nilfs2/segment.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index f15ca6fc400d..deee16bc9d4e 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2768,7 +2768,12 @@ static void nilfs_segctor_destroy(struct nilfs_sc_=
info *sci)
>
>         if (sci->sc_task) {
>                 wake_up(&sci->sc_wait_daemon);
> -               kthread_stop(sci->sc_task);
> +               if (kthread_stop(sci->sc_task)) {
> +                       spin_lock(&sci->sc_state_lock);
> +                       sci->sc_task =3D NULL;
> +                       timer_shutdown_sync(&sci->sc_timer);
> +                       spin_unlock(&sci->sc_state_lock);
> +               }
>         }
>
>         spin_lock(&sci->sc_state_lock);
> --
> 2.43.0

Thanks, Edward!

I spent a little while wondering if kthread_stop() could actually
return a non-zero value (such as -EINTR), but then I realized you'd
actually tested it with syzbot and confirmed that it could happen and
that this was causing the problem.

I'll send this fix upstream.

Thanks,
Ryusuke Konishi

