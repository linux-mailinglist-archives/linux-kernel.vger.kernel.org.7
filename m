Return-Path: <linux-kernel+bounces-884479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D64C30492
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FCA4679AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9529B3148BC;
	Tue,  4 Nov 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="NqcNBd0O"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC33148AB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247626; cv=none; b=FM67iPkTEOS0ypCjpDGFuHGH0NUKzsx8lcX+By3l6hOy5VmSl+k4eCbA1GBqk3sP33qxMcPxtOWIgezbSo8bD0BBn8lE+2RfWVTlL5mN9q/LrfD3tyC/OCg3q+HnmApBTnbeZQiAnfd1rS0p/beVKhTInY80vQE13/YQc5OlOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247626; c=relaxed/simple;
	bh=MI4rvGaf5+qBxe1eYaQ/cF276sgHtZi/7LUzoSh5xLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFLCCe24DbRUJ5GngsoQGN4UYI1CP4GCqjRBseZtvG3pFOJldFrAQYVPI7oMIXwkJaac2oa0M54EsMIxDSqDasnAAUpJYGr/LlhQDCnO6rb/digIYP9i/N6ofdGU7lCIhdvhbc2wr5JNFLDqFR/aiRMCNPTFXBXPGxQVLJG26lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=NqcNBd0O; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-594285c6509so2161398e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247621; x=1762852421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TRtCSb/PeVqLjfigeszxoTcXk///Del6ry6zTiM1bI4=;
        b=NqcNBd0O2XIIQlLLEAdUEMvknSyVGqi1FztgvecAX6OCUeilRMHnbM8M7QWWlgYjVI
         AEeQPxiKPx+xgfC00D2BPspFkFWqLlh8EoynEXbWksV/ih95QD8bLrEmOpPTrCRlDL4z
         eSa/pxjF0Yr36nyvGgBXVOpxjS+M036jOl3ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247621; x=1762852421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRtCSb/PeVqLjfigeszxoTcXk///Del6ry6zTiM1bI4=;
        b=f/b6Ps+vIFZtKA8gOn229GUL7XY5J8vGp3tsQh9myR7O8YVL+W7i5Y5v1urOK82toN
         dJ/h9VxKS45/Dti3Gn/7zppSQmsoAH0rfeK3W0+BY3Chk+LZFUIHC//QD1M1jYSubpiE
         J7Jo2QT8lq2VnwQCq741QDm/aYVkHqccUR7fyGFFPPskOyDmG1+XMxLg7XypEnSHneqC
         vPlOiUpFsuVfM2OBK9yUsSXfBKlmaMFFRFwejMiwwYFs/adm4Y3VWZZz8bK1AedoMAS5
         O1PDgCfptiS7KbWvAdHMPz4X7aYpic14UGbMcACufpFHBtgQowk1nUmjCklM2tdiqcxp
         q5cA==
X-Forwarded-Encrypted: i=1; AJvYcCVTuaa1Dgz2ukUyikFI270TkncugjY7vCExgCTzf1QKhdYGXjYM0xrMEHgtG9vOydmjA/vjs4oenAWa7/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1Yi0/mIT2JHTw6kNzrMtUSemQrU2C7rwr52rILTYAcoxwqz3
	gR0mb2YcgI/5q9fHR2GW7egk6x2VWEypMf+nkPdUaYOYe1tqbKVS8qeYbeJ4pYPTNTLDigYjeKF
	wXolV8Jd3N57NHq8qnA1EZYI/lgRFeNJ+wxSIOOomUw==
X-Gm-Gg: ASbGncuxKt5q7H/ylMzzDc0M36ifZmteZ/yst9sZU8v5ipWBTohw5PsmzAsveTkI7Ya
	ZABlZ1ovI6KsgXbnARyLjPICGkS0yWYf+wNnBnOjwX2MiRAoteF4BqJb1jXytNNE5rC1nVd99Ku
	MACxO8uTEfr/kl9G4++1YbK3fo2h69uVota04OAAlVVSNw5d81XPspbNIo/I215rkg8MVpZdUks
	xlmI3PHMnS8rEMV0d7rN81+GljtMqPrm0E7xAl0hTtniXOfxSbczY75+7qC
X-Google-Smtp-Source: AGHT+IEgHwLLbJemmI/hxcOoRWX0ColNLK3+QlQGBGtksvHgYR2nlbtnNpIYMk9lBBUvTwt4XSiKXLef2/z/p5dJfwM=
X-Received: by 2002:a05:6512:e8a:b0:592:f5e0:3cd with SMTP id
 2adb3069b0e04-5941d56edcamr4775431e87.44.1762247620746; Tue, 04 Nov 2025
 01:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-19-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-19-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:13:28 +0100
X-Gm-Features: AWmQ_bmuQPdKYeDim0hldmPtpj1YegOjyknsvRxeEQva8Adw-3PeicXOfCBHlak
Message-ID: <CAJqdLrrjOS2aAUxQFc1pYeYifhpxX7XJOUY8dOuPRNK7zx-5_A@mail.gmail.com>
Subject: Re: [PATCH 19/22] selftests/coredump: add debug logging to coredump
 socket protocol tests
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
>  .../coredump/coredump_socket_protocol_test.c       | 485 ++++++++++++++++-----
>  1 file changed, 367 insertions(+), 118 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> index cc7364499c55..566545e96d7f 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> @@ -101,67 +101,97 @@ TEST_F(coredump, socket_request_kernel)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_request_kernel: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_request_kernel: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_request_kernel: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_request_kernel: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_request_kernel: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_request_kernel: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_request_kernel: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
>                 fd_core_file = creat("/tmp/coredump.file", 0644);
> -               if (fd_core_file < 0)
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "socket_request_kernel: creat coredump file failed: %m\n");
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_request_kernel: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
>                                         COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                                       COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                       fprintf(stderr, "socket_request_kernel: check_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!send_coredump_ack(fd_coredump, &req,
> -                                      COREDUMP_KERNEL | COREDUMP_WAIT, 0))
> +                                      COREDUMP_KERNEL | COREDUMP_WAIT, 0)) {
> +                       fprintf(stderr, "socket_request_kernel: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
> +                       fprintf(stderr, "socket_request_kernel: read_marker COREDUMP_MARK_REQACK failed\n");
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
> +                               fprintf(stderr, "socket_request_kernel: read from coredump socket failed: %m\n");
>                                 goto out;
> +                       }
>
>                         if (bytes_read == 0)
>                                 break;
>
>                         bytes_write = write(fd_core_file, buffer, bytes_read);
> -                       if (bytes_read != bytes_write)
> +                       if (bytes_read != bytes_write) {
> +                               fprintf(stderr, "socket_request_kernel: write to core file failed (read=%zd, write=%zd): %m\n",
> +                                       bytes_read, bytes_write);
>                                 goto out;
> +                       }
>                 }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_request_kernel: completed successfully\n");
>  out:
>                 if (fd_core_file >= 0)
>                         close(fd_core_file);
> @@ -225,62 +255,89 @@ TEST_F(coredump, socket_request_userspace)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_request_userspace: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_request_userspace: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_request_userspace: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_request_userspace: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_request_userspace: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_request_userspace: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_request_userspace: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_request_userspace: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
>                                         COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                                       COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                       fprintf(stderr, "socket_request_userspace: check_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!send_coredump_ack(fd_coredump, &req,
> -                                      COREDUMP_USERSPACE | COREDUMP_WAIT, 0))
> +                                      COREDUMP_USERSPACE | COREDUMP_WAIT, 0)) {
> +                       fprintf(stderr, "socket_request_userspace: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
> +                       fprintf(stderr, "socket_request_userspace: read_marker COREDUMP_MARK_REQACK failed\n");
>                         goto out;
> +               }
>
>                 for (;;) {
>                         char buffer[4096];
>                         ssize_t bytes_read;
>
>                         bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> -                       if (bytes_read > 0)
> +                       if (bytes_read > 0) {
> +                               fprintf(stderr, "socket_request_userspace: unexpected data received (expected no coredump data)\n");
>                                 goto out;
> +                       }
>
> -                       if (bytes_read < 0)
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket_request_userspace: read from coredump socket failed: %m\n");
>                                 goto out;
> +                       }
>
>                         if (bytes_read == 0)
>                                 break;
>                 }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_request_userspace: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -338,62 +395,89 @@ TEST_F(coredump, socket_request_reject)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_request_reject: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_request_reject: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_request_reject: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_request_reject: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_request_reject: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_request_reject: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_request_reject: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_request_reject: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
>                                         COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                                       COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                       fprintf(stderr, "socket_request_reject: check_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!send_coredump_ack(fd_coredump, &req,
> -                                      COREDUMP_REJECT | COREDUMP_WAIT, 0))
> +                                      COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
> +                       fprintf(stderr, "socket_request_reject: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
> +                       fprintf(stderr, "socket_request_reject: read_marker COREDUMP_MARK_REQACK failed\n");
>                         goto out;
> +               }
>
>                 for (;;) {
>                         char buffer[4096];
>                         ssize_t bytes_read;
>
>                         bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> -                       if (bytes_read > 0)
> +                       if (bytes_read > 0) {
> +                               fprintf(stderr, "socket_request_reject: unexpected data received (expected no coredump data for REJECT)\n");
>                                 goto out;
> +                       }
>
> -                       if (bytes_read < 0)
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket_request_reject: read from coredump socket failed: %m\n");
>                                 goto out;
> +                       }
>
>                         if (bytes_read == 0)
>                                 break;
>                 }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_request_reject: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -451,47 +535,70 @@ TEST_F(coredump, socket_request_invalid_flag_combination)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
>                                         COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                                       COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: check_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!send_coredump_ack(fd_coredump, &req,
> -                                      COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT, 0))
> +                                      COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_CONFLICTING))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_CONFLICTING)) {
> +                       fprintf(stderr, "socket_request_invalid_flag_combination: read_marker COREDUMP_MARK_CONFLICTING failed\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_request_invalid_flag_combination: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -549,46 +656,69 @@ TEST_F(coredump, socket_request_unknown_flag)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_request_unknown_flag: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_request_unknown_flag: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_request_unknown_flag: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_request_unknown_flag: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_request_unknown_flag: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_request_unknown_flag: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_request_unknown_flag: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_request_unknown_flag: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
>                                         COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                                       COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                       fprintf(stderr, "socket_request_unknown_flag: check_coredump_req failed\n");
>                         goto out;
> +               }
>
> -               if (!send_coredump_ack(fd_coredump, &req, (1ULL << 63), 0))
> +               if (!send_coredump_ack(fd_coredump, &req, (1ULL << 63), 0)) {
> +                       fprintf(stderr, "socket_request_unknown_flag: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_UNSUPPORTED))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_UNSUPPORTED)) {
> +                       fprintf(stderr, "socket_request_unknown_flag: read_marker COREDUMP_MARK_UNSUPPORTED failed\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_request_unknown_flag: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -646,48 +776,71 @@ TEST_F(coredump, socket_request_invalid_size_small)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
>                                         COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                                       COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: check_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!send_coredump_ack(fd_coredump, &req,
>                                        COREDUMP_REJECT | COREDUMP_WAIT,
> -                                      COREDUMP_ACK_SIZE_VER0 / 2))
> +                                      COREDUMP_ACK_SIZE_VER0 / 2)) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_MINSIZE))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_MINSIZE)) {
> +                       fprintf(stderr, "socket_request_invalid_size_small: read_marker COREDUMP_MARK_MINSIZE failed\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_request_invalid_size_small: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -745,48 +898,71 @@ TEST_F(coredump, socket_request_invalid_size_large)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
>                                         COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                                       COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: check_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!send_coredump_ack(fd_coredump, &req,
>                                        COREDUMP_REJECT | COREDUMP_WAIT,
> -                                      COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE))
> +                                      COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE)) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_MAXSIZE))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_MAXSIZE)) {
> +                       fprintf(stderr, "socket_request_invalid_size_large: read_marker COREDUMP_MARK_MAXSIZE failed\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_request_invalid_size_large: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -850,49 +1026,75 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
>                 /* Verify coredump_signal is available and correct */
> -               if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
>                         goto out;
> +               }
>
> -               if (info.coredump_signal != SIGSEGV)
> +               if (info.coredump_signal != SIGSEGV) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: coredump_signal=%d, expected SIGSEGV=%d\n",
> +                               info.coredump_signal, SIGSEGV);
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!send_coredump_ack(fd_coredump, &req,
> -                                      COREDUMP_REJECT | COREDUMP_WAIT, 0))
> +                                      COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigsegv: read_marker COREDUMP_MARK_REQACK failed\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_coredump_signal_sigsegv: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -957,49 +1159,75 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
>                 /* Verify coredump_signal is available and correct */
> -               if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
>                         goto out;
> +               }
>
> -               if (info.coredump_signal != SIGABRT)
> +               if (info.coredump_signal != SIGABRT) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_signal=%d, expected SIGABRT=%d\n",
> +                               info.coredump_signal, SIGABRT);
>                         goto out;
> +               }
>
> -               if (!read_coredump_req(fd_coredump, &req))
> +               if (!read_coredump_req(fd_coredump, &req)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: read_coredump_req failed\n");
>                         goto out;
> +               }
>
>                 if (!send_coredump_ack(fd_coredump, &req,
> -                                      COREDUMP_REJECT | COREDUMP_WAIT, 0))
> +                                      COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: send_coredump_ack failed\n");
>                         goto out;
> +               }
>
> -               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
> +               if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: read_marker COREDUMP_MARK_REQACK failed\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_coredump_signal_sigabrt: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -1213,11 +1441,15 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
>                 n_conns = 0;
>                 close(ipc_sockets[0]);
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>                 close(ipc_sockets[1]);
>
>                 while (n_conns < NUM_CRASHING_COREDUMPS) {
> @@ -1227,28 +1459,45 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
>                         if (fd_coredump < 0) {
>                                 if (errno == EAGAIN || errno == EWOULDBLOCK)
>                                         continue;
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: accept4 failed: %m\n");
>                                 goto out;
>                         }
>                         fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -                       if (fd_peer_pidfd < 0)
> +                       if (fd_peer_pidfd < 0) {
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: get_peer_pidfd failed\n");
>                                 goto out;
> -                       if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                       }
> +                       if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: get_pidfd_info failed\n");
>                                 goto out;
> -                       if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED))
> +                       }
> +                       if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: missing PIDFD_INFO_COREDUMP or PIDFD_COREDUMPED\n");
>                                 goto out;
> -                       if (!read_coredump_req(fd_coredump, &req))
> +                       }
> +                       if (!read_coredump_req(fd_coredump, &req)) {
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: read_coredump_req failed\n");
>                                 goto out;
> +                       }
>                         if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
>                                                 COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -                                               COREDUMP_REJECT | COREDUMP_WAIT))
> +                                               COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: check_coredump_req failed\n");
>                                 goto out;
> -                       if (!send_coredump_ack(fd_coredump, &req, COREDUMP_KERNEL | COREDUMP_WAIT, 0))
> +                       }
> +                       if (!send_coredump_ack(fd_coredump, &req, COREDUMP_KERNEL | COREDUMP_WAIT, 0)) {
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: send_coredump_ack failed\n");
>                                 goto out;
> -                       if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
> +                       }
> +                       if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: read_marker failed\n");
>                                 goto out;
> +                       }
>                         fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
> -                       if (fd_core_file < 0)
> +                       if (fd_core_file < 0) {
> +                               fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: open_coredump_tmpfile failed: %m\n");
>                                 goto out;
> +                       }
>                         pid_t worker = fork();
>                         if (worker == 0) {
>                                 close(fd_server);
>
> --
> 2.47.3
>

