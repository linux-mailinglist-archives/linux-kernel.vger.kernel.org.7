Return-Path: <linux-kernel+bounces-884474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211BC30399
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965141885DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8777328616;
	Tue,  4 Nov 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="MVto1bSH"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3732721E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247587; cv=none; b=o1OEJ7vUVhJek1PJNTN92lHVbInqAkZ9PPwztlBm+pPUWxgLodFf0ci+0qinQD/Di9DrOllCgcFGTdzoQsOocVos/FqITo5+YOCY9AIeeKQ7LqeKBDtDLpQfmmGn5G0KS36jJKRnVqbAxEFeoezv5PlE5d/vj47anO/2lCSV3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247587; c=relaxed/simple;
	bh=yIxs2AioBtNxH+/AGFGZy/aIa3xdZYvSTQEhK4fcqxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qva6k7Hg8ijd7P69q+KeovBIuMdEBfJ2jIaBTZ7h0Wy1HOU3dmwEsqPe55UTIsY2Xopwg9zhBJoFDfw3X15rgICw6f9NmH8AgV3P7eJWgi0ADeFx8c1Sg5VZeC5BH/MhxgCVJircwOwix31LS2nK1k6v4i57tT94DBt+T9Vl5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=MVto1bSH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592f7e50da2so6036172e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247582; x=1762852382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WaZfHpNXYI/jgIt8nw28ldDnnFYlbSFdmMyrVQxmf64=;
        b=MVto1bSH65r6ts6GC4za3OWJP2TSRIiESVVy6YzAO8YcVoq21dUDM0kporRdY/Eqde
         tM7w53pt17PONMdn1QvGTkqUiPEXBKBKJalXYrYLmFjaO5VBNqguu94fISkCFanlgKp0
         rDpquFNX/jQhqR+WTIeW9IW2+zMtj5lH0Nr64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247582; x=1762852382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaZfHpNXYI/jgIt8nw28ldDnnFYlbSFdmMyrVQxmf64=;
        b=RBjkAPmepeCBBf78SQoFZ2jqkUTqBZ22zFOC8DxL/dEzqgghScZqcDjbUMUZS0Rxwk
         RI68mQK/yLbSQhIKfNywqUfag3eMXP1H07E3feLzsf5bkiV5d5vYREIXtGPl5Nf+EzvR
         RbPif4rb75xVHOPg0x7BUUsIHKiO7022e3bQn0jy/aCooP+wR1AlqjGWRmT1+9oga4Hj
         FJtZO1iBo+o8g67ZFHlFNA62CBSosTYGsNo5criWelcnWHvqsfucpXfpRkn3u6eMWAMw
         1nVpNvmAHDg10ZmwVoJ4NMlV6EbQ8Ii4swa3bK5jusvt4m1LqZ3XYvNP709O3ZTF4ONF
         Hi8g==
X-Forwarded-Encrypted: i=1; AJvYcCV27IYu829MzUUsQ1jMiZR1EKbT6uycXeaYiWfRf2G+/dMMjIy1QzzfYc2E7lAz/kV5fv3wO7LvJAXeCQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YtD+fwgfypHSFAIaWjLKoM47tslzrK9Pwhqmm5O9U0fbpJ1o
	9xByBOmGyzUf1Cbx5BjO95JJwFMQZdD6ALlvr0GlJdgpJq9jUEhcy26Ckky1mfOMRB40CbN3q4z
	79jbDJTcjPzOUKPJCIlqJY22iLbEXxU5to9bp/Q3ijA==
X-Gm-Gg: ASbGncuHsxtztXTEjA4t8BbRdh3j5J4QSXdFeETJyOjtrFrYNyniQgCyywSAvbvZE2B
	yFgRdh3zoRIKnMgHH9BsputlfdvfquRoyLWEL3yUvyy/sEWih1KaUbY88/Nbgh3FjlJ8dx+/Zh5
	1kYH5q2REWtkmbj8JFQS2XoFMJdx8QdaZ2soEwe6JoRqLbAyimVn0Q/EkPpppxs7uIAm2nHnXQe
	TvDrsRrrQz9hmqQpn6wGXJfuwvCir2PlFPu/djUqJGIEisiJgwSMOJQywgY
X-Google-Smtp-Source: AGHT+IFKspgQB5ZMddkqJx3AsG/RMHPme6ArMDmpctK9LnyCoghREqanHqfgvPIow+YtsAoy7/dA4RxpS77KX7BD1xo=
X-Received: by 2002:a19:6b18:0:b0:594:2f72:2f89 with SMTP id
 2adb3069b0e04-59434885cc7mr521797e87.9.1762247582223; Tue, 04 Nov 2025
 01:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-15-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-15-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:12:48 +0100
X-Gm-Features: AWmQ_bm8xwSqN1blOPEp9Q9oEQiTaBdFJXlR49tAVrsZRlzfRNxWRmXCJCQdtM4
Message-ID: <CAJqdLrqc54CU+pvt9BMGv6ZmwK-=CjYAV8qGmtVpLEAjS8dcYA@mail.gmail.com>
Subject: Re: [PATCH 15/22] selftests/coredump: fix userspace coredump client detection
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

Am Di., 28. Okt. 2025 um 09:47 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> PIDFD_INFO_COREDUMP is only retrievable until the task has exited. After
> it has exited task->mm is NULL. So if the task didn't actually coredump
> we can't retrieve it's dumpability settings anymore. Only if the task
> did coredump will we have stashed the coredump information in the
> respective struct pid.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/coredump_socket_test.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 658f3966064f..5103d9f13003 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -271,22 +271,26 @@ TEST_F(coredump, socket_detect_userspace_client)
>                         _exit(EXIT_FAILURE);
>
>                 close(fd_socket);
> +               pause();
>                 _exit(EXIT_SUCCESS);
>         }
>
>         pidfd = sys_pidfd_open(pid, 0);
>         ASSERT_GE(pidfd, 0);
>
> -       waitpid(pid, &status, 0);
> -       ASSERT_TRUE(WIFEXITED(status));
> -       ASSERT_EQ(WEXITSTATUS(status), 0);
> -
>         ASSERT_TRUE(get_pidfd_info(pidfd, &info));
>         ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
>         ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
>
>         wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
>
> +       ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0), 0);
> +       ASSERT_EQ(close(pidfd), 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_EQ(WTERMSIG(status), SIGKILL);
> +
>         ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
>         ASSERT_EQ(errno, ENOENT);
>  }
>
> --
> 2.47.3
>

