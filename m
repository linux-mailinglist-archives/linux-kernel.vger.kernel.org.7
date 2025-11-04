Return-Path: <linux-kernel+bounces-884488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52FC3040E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C3CC4F5F95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16731D373;
	Tue,  4 Nov 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="h5k7TrE+"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D765313277
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247955; cv=none; b=H8SsPkW6AAnGLYjTCB28x1JBsVzCd7mQsPXAfLuFZUIHz6y1JMX78rvE41o4hV2w2j1pSHLQryk33O4S3A5e+VFyxLtC6Jnk7wG/veVE6sg4rz1QKvZ5zaTL6D+63PMYNpaAeIzvrOrZXv8qozB2zG6DheaYdUQEN5+6JD8iC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247955; c=relaxed/simple;
	bh=uDqRIWPXjRGJmcryVpS5Ql/R4NyQVzAGXa6ccteG9Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSCNB3oAnH64TzC2YEzmPm7/KzbAEBi1TDP4O3BuI84AJKFHp/lpsNh6s6bhQUYgBxUc+UzqtH8XeGEQApEN/1xHfdKsgLZXlYV36wjZHfZmfRQViDU5k9c55M5Q5bI2rpwpv2h3MIxdDFo1LuKPTylcFY+aevtfkd+ioY2XyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=h5k7TrE+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786572c14e3so34750227b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247952; x=1762852752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=upAd2mhS6nHu+JpldajZRBhX0K6ISQppgklMoNRm97g=;
        b=h5k7TrE+Wgphy4Ed1Y4BRt+aAzC/KJgyhHH/GlFA/LBLgRqONmUuyF5KXstLZ7D5uC
         ZqtAWfeIn64HrYieT0SWqfWwzSf+ndvtOA0x6iWf5dFaklWqfHO5/EiPzkIYmwZDuYdz
         P6IX7/5ieUJ++Ro0uJaNaC6pKJSr/Pzo6cR/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247952; x=1762852752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upAd2mhS6nHu+JpldajZRBhX0K6ISQppgklMoNRm97g=;
        b=mUntbg8THs+P7wV5cylc24zvk2MsUorbkBaPiG4WNV0hY+qzAGcL4PBUsuQWKW7Zod
         vpt9JcyK7LFhvNAks1/7vMespSyNAXCtgZoVABHnLPdh+tOHrE35+0p39qpEjEr24ojF
         JI1Xguk5Y04D/3sb5xNbxb0sFcSq06HkL2qkQh893By/LQzO84zKgpXtXMH9dlE4pepE
         RdK4jf1OANys3UfamBEUKIvv7Ct6ypCrTDFtlARCodWLqnOFQM4XZHoQVmy0foZhwmcW
         kzqCFsntqTB4QnpiIPyITsh8E8Ko5vnQ6QfzPul5mvMRmHpRVOw/cPbYqe9k9HvzL+qn
         K/NA==
X-Forwarded-Encrypted: i=1; AJvYcCUVCDnEKpN6/wOckbLUiNC54UIyAnVYpVQl/gwU3hiK90la4WO9Vi8cye7zSZGOv+50oQt+GoDwlXQyDhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNFMhBBT9kg4nT0TzoJbPvMojBhjfNiRUhngJGLjj9xOvIiCy
	sTRinUeMub2ZvmOx0RQFHHeBbdyrHBWd2WVb4SPB+W4QR3R3mwbPhPCgUbw1F6ZMA/nd+pKwL1c
	hCDBxgZpLRTxh+BYInybgETCGCECx5QbWqKDxYH28AA==
X-Gm-Gg: ASbGncvpwSLlZ3ueP0yMso9VqtFUFeqvFJ+/hII4AqTW7wHus+yRBBtVyuxdBSi1FEl
	XB2SLAyUUWAd3X5yIFP0Pyi4GDnnHffc9SUoOCJa01NqcFqfW/MzMe7VeMHwOD8B1m2cR2XBJLu
	SxrBTOptDFJGMbNU69nCBOnMF1m5Y9sFzc/D51r/ueN2wb2JHa9+mdUanLxuacMzDSOum8afZH+
	Uotru3g4uLiuJpftV0Qz9UfdBs4uS8ioneVenIiKUXzZZ5+9CJtwpPiYr9Y
X-Google-Smtp-Source: AGHT+IHd1msd09zmjh3/G3h+4Ex7hy4E4xTd9NtsrOW361SFh2b1Hnao/HYf73YXaXzSFCpg90v9wQzQLl3S+x1qZJM=
X-Received: by 2002:a05:690e:14cd:b0:63f:b4d8:1f4b with SMTP id
 956f58d0204a3-63fb4d820e8mr5254481d50.33.1762247952288; Tue, 04 Nov 2025
 01:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-21-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-21-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:18:57 +0100
X-Gm-Features: AWmQ_bkD4aQmDeMRwUJO12jpEEtaXZFATT170ONMybMUMcklcqQ5wq6LFHcyUD0
Message-ID: <CAJqdLrpzR012WmcAJ2TP2cNghYzMz4aQsvEeNx1neEkD7LULug@mail.gmail.com>
Subject: Re: [PATCH 21/22] selftests/coredump: add first PIDFD_INFO_COREDUMP_SIGNAL
 test
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
> Verify that when using simple socket-based coredump (@ pattern),
> the coredump_signal field is correctly exposed as SIGSEGV.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  .../selftests/coredump/coredump_socket_test.c      | 146 +++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index da558a0e37aa..9d5507fa75ec 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -430,6 +430,152 @@ TEST_F(coredump, socket_no_listener)
>         wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
>  }
>
> +/*
> + * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump
> + *
> + * Verify that when using simple socket-based coredump (@ pattern),
> + * the coredump_signal field is correctly exposed as SIGSEGV.
> + */
> +TEST_F(coredump, socket_coredump_signal_sigsegv)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: create_and_listen_unix_socket failed: %m\n");
> +                       goto out;
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: write_nointr to ipc socket failed: %m\n");
> +                       goto out;
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: accept4 failed: %m\n");
> +                       goto out;
> +               }
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: get_peer_pidfd failed\n");
> +                       goto out;
> +               }
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: get_pidfd_info failed\n");
> +                       goto out;
> +               }
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP not set in mask\n");
> +                       goto out;
> +               }
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_COREDUMPED not set in coredump_mask\n");
> +                       goto out;
> +               }
> +
> +               /* Verify coredump_signal is available and correct */
> +               if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
> +                       goto out;
> +               }
> +
> +               if (info.coredump_signal != SIGSEGV) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: coredump_signal=%d, expected SIGSEGV=%d\n",
> +                               info.coredump_signal, SIGSEGV);
> +                       goto out;
> +               }
> +
> +               fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: open_coredump_tmpfile failed: %m\n");
> +                       goto out;
> +               }
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read, bytes_write;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket_coredump_signal_sigsegv: read from coredump socket failed: %m\n");
> +                               goto out;
> +                       }
> +
> +                       if (bytes_read == 0)
> +                               break;
> +
> +                       bytes_write = write(fd_core_file, buffer, bytes_read);
> +                       if (bytes_read != bytes_write) {
> +                               fprintf(stderr, "socket_coredump_signal_sigsegv: write to core file failed (read=%zd, write=%zd): %m\n",
> +                                       bytes_read, bytes_write);
> +                               goto out;
> +                       }
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_coredump_signal_sigsegv: completed successfully\n");
> +out:
> +               if (fd_core_file >= 0)
> +                       close(fd_core_file);
> +               if (fd_peer_pidfd >= 0)
> +                       close(fd_peer_pidfd);
> +               if (fd_coredump >= 0)
> +                       close(fd_coredump);
> +               if (fd_server >= 0)
> +                       close(fd_server);
> +               _exit(exit_code);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_EQ(WTERMSIG(status), SIGSEGV);
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
> +       ASSERT_EQ(info.coredump_signal, SIGSEGV);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
>  TEST_F(coredump, socket_invalid_paths)
>  {
>         ASSERT_FALSE(set_core_pattern("@ /tmp/coredump.socket"));
>
> --
> 2.47.3
>

