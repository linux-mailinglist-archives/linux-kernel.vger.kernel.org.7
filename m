Return-Path: <linux-kernel+bounces-883263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8DC2CE65
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9319188EAEF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB6C312812;
	Mon,  3 Nov 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="gY+Djymc"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53492980A8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184207; cv=none; b=tx8RE3DN9COSxPyFbCLpwIvl6E0zRdt9fJyVS2Tosf+oVvUwn2xdeZEovXR03LISmp4xi+9W4b9RXJi0ShIy0K3dQQ+hYUrbEv0ITidUuy6X/RRFg4milykWkTzavphTzlHoU6ZOKazsyZfAgIQPe530q0sF+izfBYrYA58KAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184207; c=relaxed/simple;
	bh=ikVP98TfiRRScnRxsnU1IXkxvzvmFrY/j1DS2qMbV4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iB4PT8MvBXUNns6dOy2sBI0fSQ3gpUDerPHI1gHkyQ17SmP4UYgZBaG/AaIUa5C2SxT8Lh9OXBao/bUNthpSQK9288/P1ZJKUqKqJusd6haiZPfQw5jPFAQegVgzQFG5gE9BFKw4CWXE2zwk/+LhK2cfZ4k3XWofjEhULbDiDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=gY+Djymc; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a2dced861so12796831fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762184204; x=1762789004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYFXjvaUMn3RT9j1VhXINzYM8N/jgwBZb//bniINmBM=;
        b=gY+Djymc1FioOPBYjn12Q/Amebgth4LSUPz439X+b2xDKLT9ruzKJrmdvQ9CwVx0SL
         azMpWeM5l6UgQdGXMxBH77bRe8PHPykQwDsNfbtw3/ljOsnczRsqA0HuMxbZeQZiFHvr
         4lfga6g5BTDKuBCF2KVvZ904nS4ymA1pPHZWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184204; x=1762789004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYFXjvaUMn3RT9j1VhXINzYM8N/jgwBZb//bniINmBM=;
        b=f64nPBG0NCRzoeri03Y6hMSAEdWA6kMbT0p2b8xhoDdArOs9MV/Tm2ipzN7pj57lUn
         QroravSlpv8PM6srjCCH+J5cxW60QQRBU6MZ14tNdsV9ChHnJh2Y/1Kt2YwcJBJTHyx8
         tK+9goSc2v0PAmAKfBElaMrtrW1FrllPMMRnMYGcE3e6jXPEevNsO+1qtwquEf0vHmf+
         aqShESW3IXVdnn+5oiZ2fd3+xb6ZC95ygAUqTSEdOTZpzlCZcqEChgMXoL9dng314VbH
         jiRsTE1zIF2y63rJVW3VEniQWgXPbTihpFlmXyjKmOSfAaiW8fLYeOMihqq92wuSh3Fv
         WIDg==
X-Forwarded-Encrypted: i=1; AJvYcCVIuBTOaBkVZzJ/1nUk4E0665zVwear7sXUeR3mY5ETE9aSSgqNGzaWdMvYSh56Ry2FsmuVfz8WpWgp0xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7sYwUJVaDCrClSORd6LKWOF/gGhKEVzV2DnFRuSsOswtfBbR
	8uaQm+VMmh6NZI37PRXnsSHti70wOJSrqertj+NFykWAi58ypevONd8dyahRtiMv5T2xK7Gnfgg
	4eg3pz2blUWdzMlkgyrs8BZuN3XBF6gsBXW5riE1BBw==
X-Gm-Gg: ASbGncsvdysI+Go6mtpcSF7VXw7dIuXyg+lQRfrzFpXwWq9gcS9rnecxAE5P9yiOlX+
	kG863qQ2bSC9Mpu9VTEBI/JNsk2R2cH3Jy7HLGmyeCDecLZGS7fNb9n6jyAiwlInJgRASSeiUpf
	T6ZLJU4ftWfvSqjQ5UzzZaUBcnM9jIhqNCHYUAZ4IdhMSiM0YqJJUpdb38rKdicE60CpSydbJ6q
	tkvDeatb+oVzEmfhkROWsmqQ/JUV/SN4b+5BFC0I/tf09inVLN6iBB7eTZS
X-Google-Smtp-Source: AGHT+IFi7UO7rnjoss1+fg9U6YEcUF6hllcQqEKbYq0KWBD+AXmqXAUDoWxNdc50GuqKKu3zTdKQDg2CK1jYQhNpAWA=
X-Received: by 2002:a05:6512:159c:b0:594:2c42:abd4 with SMTP id
 2adb3069b0e04-5942c42afafmr1339827e87.5.1762184203826; Mon, 03 Nov 2025
 07:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-4-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-4-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:36:32 +0100
X-Gm-Features: AWmQ_bkajVHUGOSjuUyvKnAOM48UBvvzrT4R0yioBSGxJGk2W9s55McYYFL6ZJg
Message-ID: <CAJqdLrpdwVu-aPpk_+7tqrjez6h7nW4Eb+-aDK=gSUnY7JCcJg@mail.gmail.com>
Subject: Re: [PATCH 04/22] pidfs: add missing BUILD_BUG_ON() assert on struct pidfd_info
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Validate that the size of struct pidfd_info is correctly updated.
>
> Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c0f410903c3f..7e4d90cc74ff 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -306,6 +306,8 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         const struct cred *c;
>         __u64 mask;
>
> +       BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER1);
> +
>         if (!uinfo)
>                 return -EINVAL;
>         if (usize < PIDFD_INFO_SIZE_VER0)
>
> --
> 2.47.3
>

