Return-Path: <linux-kernel+bounces-883225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E851C2CFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641A6620A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A3731C587;
	Mon,  3 Nov 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="XWIY9mFt"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168431771E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183211; cv=none; b=cqo0JNnh4ZOZV3BnX4J+KmH0EsqlBAZ4hA9CAxhYCFGuDDHwQ98NRg2NEkVZRLyihMQp5hDi6L//E7s0g/5T4LLGMGV7JqskJvegjEVCuKnxzZvksIx2gAwzNz4QVFDAe+6snm3KGHBpBy5xRSOe8nkS3NdmPwqyxAc0A3mpYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183211; c=relaxed/simple;
	bh=QS1ElmiWGQ8d6SqToAtWmVYVs7aFmR5jmQxgEOOJtxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMc37jO6Io9q7nRl/JbJTIk1+lI4K9ZeXam9NCRBYRrq6jtL794GLHrfbr1Lka4MZu5kswfgPuILLhSK72WNXF8q97uvUt79eWlQdQz8G4PI5xs1JRnkmipdxTWHKCpD0XUPE9XKh+p8WqgjFWnk7VhCl+2HmfHioSde98rCu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=XWIY9mFt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5942e61f001so763299e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762183207; x=1762788007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swWtueJTD1lLAj0Vx8RWi3wNNzWbJ/rmL7j4fFwS3eg=;
        b=XWIY9mFtpXyhud5yq+Ux+/lo5PGYQuUSCVSRU36fC5DaZL+ChWTAUCuMTBr9Z8+Pkc
         mHJ5hkC73UVOJ3C7EVaYhFxQ6AjU53+HUiMSA9ImZzxDYv3GVgrgxqa4i7NsEhLTnQRg
         ZN/P84hLzTSANHXCZAva9VblzrgI5UCoRppeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183207; x=1762788007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swWtueJTD1lLAj0Vx8RWi3wNNzWbJ/rmL7j4fFwS3eg=;
        b=QL81fQhy0tfAJEJOBn00Ps1pCaXqQGUi+ouRZCYusrKAcANWFmjaEajb2zVJnUUJy1
         mb7IMe1EX2bsHPGyIsiDSQhXXO39AYQLoB4LqmUWrZJdueDJ1zSaxAr8hkvMuKUC96eJ
         9hVu9k7n8mo7Oj7Gb+REVWBfMXfYX7ClnfDj33ooezBSq9evRP6dHQgsv8harM2IcwTq
         W7CoUffKmw3Lc+dscFLcx2FNspwD3dM8s2qUoh0aqvHDyPCWnOuAp5UntukfUY78oXT8
         FLnwNcz8nGF/9BftDBA1+wF3CuZDZNirL6+S0yT7XfjVyfyIoYTJxHTFMHMeoHrt/sqM
         Dtfw==
X-Forwarded-Encrypted: i=1; AJvYcCXYyxti5+WWIYVQVL6j2muvV0d+MVYg4GCCvwXlVWwARSlonGSLZSZ3WCF2TccNZBGxG9/3dM/cGIDlUSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4aFTBjlIEMtn21VuY2hMXaZytRqQc0hsFmzpQswdTv8ZumA+
	Mv5cqfMrnXJSmMpIXKWfT/UUEFatP34dIilo8JanBwoEp+Iz8oc/3BfAEuVNxcO3rcCWArhH6aJ
	b0sECJYuQ7TLOb3xQ1P2OI79OaUuygsYIE23jWCdL/g==
X-Gm-Gg: ASbGncu6IkU7OAhJ/vHgxW4CCcufoGqZbuhjVqhJa2RMsOF1IlTLno5OpAQL7ZS0CxZ
	ZDQOJpvVltXYpF34/K1QsfdEXRuKICBDdkvPLR23RaH6wTYQ7UNUaFuaVESbc9Mu9mbo7IsGQXT
	AUwj5kyakX/SyqrqS5nuAPhK3blQFwfV+C2NdAUQjiNVpS/jFjis7lxzDbf+JEPG+c4nXBRyGrC
	NhbYT1pwIS+4p3W2yKNj5Djdf5ume+YsiZfJT0Ti9sdV0y7L7Wf/3NAMyVq
X-Google-Smtp-Source: AGHT+IH1cXvY32biC6d9IC8g8KBhsDvrUFBnAjz78J5RdRKUTPT5+cM+MWvSntweydUvtixKj17jmykz9aBU3OYssOo=
X-Received: by 2002:a05:6512:2212:b0:594:292f:bbe9 with SMTP id
 2adb3069b0e04-594292fc192mr1635258e87.36.1762183206953; Mon, 03 Nov 2025
 07:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-1-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-1-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:19:55 +0100
X-Gm-Features: AWmQ_bkzsjh63BlFZ4oGK_EUFCxELlywhVux4yTLgGIGyeMzLSBxiwaHojVQJLo
Message-ID: <CAJqdLrqy8OoGtzobGdRO=+AqMejesUnYcgzjrk8q4iueHiHJjQ@mail.gmail.com>
Subject: Re: [PATCH 01/22] pidfs: use guard() for task_lock
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
> Use a guard().
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 0ef5b47d796a..c2f0b7091cd7 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -356,13 +356,12 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>                 return -ESRCH;
>
>         if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
> -               task_lock(task);
> +               guard(task_lock)(task);
>                 if (task->mm) {
>                         unsigned long flags = __mm_flags_get_dumpable(task->mm);
>
>                         kinfo.coredump_mask = pidfs_coredump_mask(flags);
>                 }
> -               task_unlock(task);
>         }
>
>         /* Unconditionally return identifiers and credentials, the rest only on request */
>
> --
> 2.47.3
>

