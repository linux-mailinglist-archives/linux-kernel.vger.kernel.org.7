Return-Path: <linux-kernel+bounces-884478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4AC303C0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D66189FFC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78A313E09;
	Tue,  4 Nov 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="fYHehwHJ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E47313296
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247615; cv=none; b=mdBiHkzPwQ/5OImNlAGWDw7YDZvlvEP5IU5ki6kWr0cpTfvMVlCT/3qTQjYbK+037DK9BIaO1NAXR0ax5Uyk0clAKrtrd/S2gUfBbVnwCI3UdrUgTF3BXDLoS9r1CxZvwWwoW46nZx1HEH7x3Wyg05Qo6o4QETMT4CxT8IJcHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247615; c=relaxed/simple;
	bh=X3saQ01HvAadyE0U0yxTSLkzNUPaSlSNgq7Nvk1Fyr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKXLsmyZQernpFOHPSWfT12QBUx04lDK7a2UXKqmTdAcMxhLxGkuy+zAdAnQE4X6J0d8oEiXz9iZlRZjhqwie2LFfhZvqhOjm7HKXSsI6h1fyqC4b8ktSNILvBBUFL2HsfJYizrdg+p42UYSxIdiKBraj35ggKVZUe6R+6tflG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=fYHehwHJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-58b025fce96so4392264e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247611; x=1762852411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yC5ZbkKSZm/d/xkH+mRhsiaCkR8T/+9iGxUGIpCNOpo=;
        b=fYHehwHJWuLJe3Dc/x7jQssgEh90WPjJ3LXvxt0B0QfG6DuunS2XucREt6PQ9hYXXM
         gmwSyEvPfYjwJPeULvl0C5HpOhyXToP9tNd9q9whdcWOVfdthblSQ8jJXiqTFqjc0nkR
         MBOyE83zdlFwASkoox6dmyQKM3w/4UbIW36A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247611; x=1762852411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yC5ZbkKSZm/d/xkH+mRhsiaCkR8T/+9iGxUGIpCNOpo=;
        b=bmTEBaJ8cACeiEYfkrXT5E8J60qhE8eddWhgUg7raOK2MMgMSlgCTO+1PdUWiK1rcD
         lTovXJ+XFbKfkFVc2qIjiCR/Cpd1wm5j3FVWIIf7jhN/LiItaMrPA4iYbC4eYjnc1/+A
         jtHQ/9Yp9pZ34US4J7qj5l46yGyae4U0amnIzn56hi9NghDDGohdPSU69GQkyPd7uL+o
         S80TU8c/ininJIqFxJ+DOAt2SJ6m81LDDgFeX+gTOV4yLM70AYD0jwXMtFgEXd0DSK6q
         jlAKkXE4Gc8+ZIYZXwdA6VRHschLe96Ijl73On8KTpMrOn7J70A0fm2QEJ4m64Lyz0w1
         hCmg==
X-Forwarded-Encrypted: i=1; AJvYcCXEf5zVULz1spFsirkHDKgl0MYiRXX1I7dqTh28q6g01EUPVYoY9FA9f5OAj9qeozp6CE6fuP1Ig3UjQwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHUo7uApVSPpQMCW4drzuB9SaKdIiSmyBcRs4uFOiTOGLm44C
	RczGHyNDJJ2jErcz81m0FTSVgTTt3E0EacF9V8l5pYWq+6b9Nw64kcd3ciyPQeGxE6MVLUfdfL/
	5UqqsGhI0U6/9ovXGxK7j+91+WaoS4I4vE0WfjadhAQ==
X-Gm-Gg: ASbGncu0LQqQwkUiHRl8nltLYrAQ+v9e4RdDWfwZJT5a5IDdGXSXzIY1cyLnpDwgj88
	K2Oa/sSWNxlotq4mXtkKQ0ZQ1+VvDIuv5i4XN1CGlt3zdGBs4sYJThi3O8S8atYxg/pKO5DANk1
	eK4H8NwtN9wm0ZOz5NE77Q/iMm12++vNGruTvg2/X2JxpKTnqhP9JuJgk/CN9jrge+ZnbZoCTmi
	Nm7lkwcF0Ne+DUXFCW87+6NNr+RRXf7/vc6so1Rh3WL7G0I2ueVD+jZRwH+ZUwA5o4/4z8=
X-Google-Smtp-Source: AGHT+IHmEn+S+vJ02GNEiM+x2ag5QTVD0QFKLXPxHM6pgjwcpgFALU+ffxa+ka06Oxk3WmhLU61d1LG5jGxn7fZgGh4=
X-Received: by 2002:a05:6512:3f06:b0:592:f6ec:112c with SMTP id
 2adb3069b0e04-5941d5827bdmr6234166e87.55.1762247611189; Tue, 04 Nov 2025
 01:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-18-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-18-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:13:18 +0100
X-Gm-Features: AWmQ_bnwJcjiJfpzJo_3tQPvegRV8ps1oOm0HCWWp98H0G31lwRhyHQCEYGdwIY
Message-ID: <CAJqdLrrba2RtnojjWTU0=KZ1HBnNEs+9m4+5SuOkqGB9fn83QQ@mail.gmail.com>
Subject: Re: [PATCH 18/22] selftests/coredump: add debug logging to coredump
 socket tests
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
> So it's easier to figure out bugs.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  .../selftests/coredump/coredump_socket_test.c      | 93 +++++++++++++++++-----
>  1 file changed, 71 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 5103d9f13003..0a37d0456672 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -98,52 +98,74 @@ TEST_F(coredump, socket)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket test: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket test: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket test: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket test: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket test: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket test: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket test: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
>                 fd_core_file = creat("/tmp/coredump.file", 0644);
> -               if (fd_core_file < 0)
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "socket test: creat coredump file failed: %m\n");
>                         goto out;
> +               }
>
>                 for (;;) {
>                         char buffer[4096];
>                         ssize_t bytes_read, bytes_write;
>
>                         bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> -                       if (bytes_read < 0)
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket test: read from coredump socket failed: %m\n");
>                                 goto out;
> +                       }
>
>                         if (bytes_read == 0)
>                                 break;
>
>                         bytes_write = write(fd_core_file, buffer, bytes_read);
> -                       if (bytes_read != bytes_write)
> +                       if (bytes_read != bytes_write) {
> +                               fprintf(stderr, "socket test: write to core file failed (read=%zd, write=%zd): %m\n",
> +                                       bytes_read, bytes_write);
>                                 goto out;
> +                       }
>                 }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket test: completed successfully\n");
>  out:
>                 if (fd_core_file >= 0)
>                         close(fd_core_file);
> @@ -208,32 +230,47 @@ TEST_F(coredump, socket_detect_userspace_client)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_detect_userspace_client: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_detect_userspace_client: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (info.coredump_mask & PIDFD_COREDUMPED)
> +               if (info.coredump_mask & PIDFD_COREDUMPED) {
> +                       fprintf(stderr, "socket_detect_userspace_client: PIDFD_COREDUMPED incorrectly set (should be userspace client)\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_detect_userspace_client: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -263,15 +300,20 @@ TEST_F(coredump, socket_detect_userspace_client)
>                         sizeof("/tmp/coredump.socket");
>
>                 fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
> -               if (fd_socket < 0)
> +               if (fd_socket < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client (client): socket failed: %m\n");
>                         _exit(EXIT_FAILURE);
> +               }
>
>                 ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client (client): connect failed: %m\n");
>                         _exit(EXIT_FAILURE);
> +               }
>
>                 close(fd_socket);
>                 pause();
> +               fprintf(stderr, "socket_detect_userspace_client (client): completed successfully\n");
>                 _exit(EXIT_SUCCESS);
>         }
>
> @@ -342,17 +384,24 @@ TEST_F(coredump, socket_no_listener)
>                 close(ipc_sockets[0]);
>
>                 fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_no_listener: socket failed: %m\n");
>                         goto out;
> +               }
>
>                 ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       fprintf(stderr, "socket_no_listener: bind failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_no_listener: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_no_listener: completed successfully\n");
>  out:
>                 if (fd_server >= 0)
>                         close(fd_server);
>
> --
> 2.47.3
>

