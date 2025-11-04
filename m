Return-Path: <linux-kernel+bounces-884489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE6C30417
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 800A94EC162
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27FF31E0EC;
	Tue,  4 Nov 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="WJbmeNEn"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD431D727
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247964; cv=none; b=kJw/BgzsNhvB5KPN07L1Uf7wGDR1hgpe15JqktcfCwTljPPIaQ8mkWHaIelE9QEdzZhxii/DyWeftUqIwT/0Z17oDzPWni6R1toWK1KNYp5/Bw5PXgtpk6i3NERdVRt9fkMQPaX2Zdb50m9K6mEYwXF1n+CHFgnZuiR11BOVk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247964; c=relaxed/simple;
	bh=pFTVfZkUF+VqpU9jGrSFHtwz4C0MOUiHGcg7AeJthdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VO9NvKUFgCy5nJMNe8LrTjptMcYKmFUDRVrZqvuc+sHGQdPSrVsMaQUfyxtWsam0dRpyVj6i4M7G83HrXP59y/nKJOWqaDrvcadQ2Y4LJZ4Oewu70AgXQGTVc1XCOYHAP9N8IRHowHPyujr+XygVnMK62Bq4yAzFfyA4rG+bUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=WJbmeNEn; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so711864d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247961; x=1762852761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ComhRXEc0XhGJ+yc/8aQayu4sPVvc28d9BY1h1SNo8=;
        b=WJbmeNEnP+f2icAXTT1eFGWDGlnht6hRNqxTUpCdYRJh6MkKueBJRWicipiBtmpkX4
         qiT5Y46UC9PtIWtGPejCfMwgSisXLaRtIcnT2GfS7L6b60zqy0FjebFwYt3U7fVzSCWw
         IZNPt0GWx6yNrQvHsC3faNHFBrak/oT/hd4q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247961; x=1762852761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ComhRXEc0XhGJ+yc/8aQayu4sPVvc28d9BY1h1SNo8=;
        b=GnWYqhf2MjW39mOrjFRIOT9QH8kPVAn7gcoB50cNxQU+NmPiAvBdPnUFyYuXMEc5ID
         OD+s38cPN1Mg58xRzEq1C1qiQoc7rXBqLs9r492fMWqoOrF0QwTEfEdVOLFJXAgklIyP
         b+GU1pwFLW0oSzGshJ0RJfQTjFpkZlb3e9s7aA/Cqkd5WYvdwRc/1qne1Qs6Xw831RuC
         V/TmKvE4XPxwRQuRY29MUDJnCWDQngZ7w5+niZNTcOWi8IxXK/Dp9B9RDYiurP/Xb6SY
         DoXGrV5eb2jnYh5tbYWBNHkFcioxYFJsccnUvWx+dCT/M5C2dEKXonHE7MeobE63NAPu
         I4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXXvT+9cxts6ZQUofm7Fs3S3b/Qyrq8CFfQzqhHoCHAOV7aVB56pB0lY2s+XEQwpadArynfwuOkfYnE3tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQiTMrha5ziPyTkZlq4YSbGMk5ZFQImc3nerM+iC3/nvp4TF0
	MliWr9m3GrM7E9d9k+FCUZ2Gebzhe1he62xONyXqkDzF9KedvpnPv+3Y9XfDdx07o3HcFnPFsZq
	K6MWd0JOliJjPyrfQp7iRY5dF30OIJ0MWrlaD7FZKMQ==
X-Gm-Gg: ASbGncvpOGjnQu8S0wrl0bc9avk2xtLweU4t78MCvjcAq2DXgebM7QHeMWKi/oX2nbY
	WqXI+DYMA39cyUyn+u7cOeVIDHnquzZDUo99abK1RG7cgqjZupDEoQszJlTjmTVczi7RRbIZTPA
	Jb/Kd0zWYuEUnPhP5spLSZWHL5Ib4nY8qR5hOOw4LX9y6cAz+7r3mEU1vBbzeFL1f/2QykO8R+1
	8rkgyrnQMYsCfV6QGYHyTNT+svJMzyD82a2E2khZq3mPhKfY6NnK98yYxFr
X-Google-Smtp-Source: AGHT+IGLCbHwaxSFHn8CeIQDkdfEgt9r9R7rbvhZFSq7p6aUS9y6cZ62ygpyHucQOa+9MZsJXcsa5Zx9qnk/L/wVN/4=
X-Received: by 2002:a05:690e:4143:b0:63f:a87b:2066 with SMTP id
 956f58d0204a3-63fa87b7aadmr6765111d50.16.1762247961138; Tue, 04 Nov 2025
 01:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-22-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-22-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:19:05 +0100
X-Gm-Features: AWmQ_blPI-NZGMqZiZIbB5MjO1ibH-88TuTdZS8FCPgXIWUJDucqAf0utuCZE3M
Message-ID: <CAJqdLrpGmJ=-kYKssC-LvaaZUzX-A5Ni19cY0qFi8TR8jFfeYg@mail.gmail.com>
Subject: Re: [PATCH 22/22] selftests/coredump: add second PIDFD_INFO_COREDUMP_SIGNAL
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
> the coredump_signal field is correctly exposed as SIGABRT.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  .../selftests/coredump/coredump_socket_test.c      | 146 +++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 9d5507fa75ec..7e26d4a6a15d 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -576,6 +576,152 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
>         wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
>  }
>
> +/*
> + * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump with SIGABRT
> + *
> + * Verify that when using simple socket-based coredump (@ pattern),
> + * the coredump_signal field is correctly exposed as SIGABRT.
> + */
> +TEST_F(coredump, socket_coredump_signal_sigabrt)
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
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: create_and_listen_unix_socket failed: %m\n");
> +                       goto out;
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: write_nointr to ipc socket failed: %m\n");
> +                       goto out;
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: accept4 failed: %m\n");
> +                       goto out;
> +               }
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: get_peer_pidfd failed\n");
> +                       goto out;
> +               }
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: get_pidfd_info failed\n");
> +                       goto out;
> +               }
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP not set in mask\n");
> +                       goto out;
> +               }
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_COREDUMPED not set in coredump_mask\n");
> +                       goto out;
> +               }
> +
> +               /* Verify coredump_signal is available and correct */
> +               if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
> +                       goto out;
> +               }
> +
> +               if (info.coredump_signal != SIGABRT) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_signal=%d, expected SIGABRT=%d\n",
> +                               info.coredump_signal, SIGABRT);
> +                       goto out;
> +               }
> +
> +               fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: open_coredump_tmpfile failed: %m\n");
> +                       goto out;
> +               }
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read, bytes_write;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket_coredump_signal_sigabrt: read from coredump socket failed: %m\n");
> +                               goto out;
> +                       }
> +
> +                       if (bytes_read == 0)
> +                               break;
> +
> +                       bytes_write = write(fd_core_file, buffer, bytes_read);
> +                       if (bytes_read != bytes_write) {
> +                               fprintf(stderr, "socket_coredump_signal_sigabrt: write to core file failed (read=%zd, write=%zd): %m\n",
> +                                       bytes_read, bytes_write);
> +                               goto out;
> +                       }
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_coredump_signal_sigabrt: completed successfully\n");
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
> +               abort();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_EQ(WTERMSIG(status), SIGABRT);
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
> +       ASSERT_EQ(info.coredump_signal, SIGABRT);
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

