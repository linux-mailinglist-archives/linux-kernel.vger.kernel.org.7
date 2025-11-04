Return-Path: <linux-kernel+bounces-884477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5682C303B4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39F1A4EC85A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F1312812;
	Tue,  4 Nov 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="FrBR2f7D"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C41313296
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247605; cv=none; b=lmZcGbrByMvWVdB1RBmSLc1hRVqviIFvE6s5GgXcOVh/HPJT9eS+oglzIQ6f9vEP5R2S4PxrEfNkyChXgvpNNF0bBaI/ZgypHY0FOJpea9E6a+sULUbAZGJHbttesd47CFiTOg/8tfq9Zf1ewwRuQ3CiamoZXcbzOAjaCxR7G9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247605; c=relaxed/simple;
	bh=ehXOSlokC20bIBLdoni9PsRvN8h14azKPpnSVKqbVkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/sH13WQRTH4DUj2f+Qg2HVr+6yw7XZcmNUqnCu9V7jkSeI2xb1W/nW239Qpd1wU1v+31um2RSeXVSZRNu2+Rv+fQ70nAZQAkFIBTDXe26CTCX841GK81TP/zcAT84vDtzJipJBq7Gc1qolzUBsy+8bs/uKHUoC1F3MyXSbjhaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=FrBR2f7D; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-58b025fce96so4392116e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247601; x=1762852401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbTpJ2kd0vtcHnRXRerhpDDb9m7VWCKBi2OT36dhbVo=;
        b=FrBR2f7DUfJiIem2YSez54O6uhJuJNN6K4m2YavvSG7v2VNsnpw/CEMgqbvpJK3OrK
         jdji97ABfUpcWxHaBgZWLWksc1S6pMggiz8Q9X7r0uMN7bgdbX2Y9em+BQkKSdsC/rth
         o1mp7dm2QVntzfRcbtKkIhzLTRh2G0zubatYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247601; x=1762852401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbTpJ2kd0vtcHnRXRerhpDDb9m7VWCKBi2OT36dhbVo=;
        b=kLpTGPv5ImeKEVuM6JZqo9f7jxhitkXumz3EqBpivAOllIxT3z3FoEa0IIWtEUJy4/
         8DZ02/G1RBOPALA/qTVXyqRgI/re0hJIdPCG+oYjqifduPB5kt7cysk2qWxO4vbuZHaD
         BOYMYj/K9kH+aBjyki2E3DGZ05QJAmMoCU5SFO/fnVQ3y4wBvx8rHDb/slv2zZ3fqQyt
         cK9nEw/Nvh9oP/So1MYPmIcNCWxq3LK0+CTrwZCKb+QHDKElEvoVPd2UJV23puAs3chi
         LJWONprDF3zTc21DV3aB4ZfNcJrFpXSSzntREftIC/3ErxFs7iHwhYD85wZNg3gXXxCN
         Iy1A==
X-Forwarded-Encrypted: i=1; AJvYcCVVI2sSq2SNW9N9IuCtzzaC6p52cFSnvSStU8UPq/h2XnGUzru33Brh5z0Jcma20lbak+clbGL7KL4CE8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwImCb0sjh4q9P/sV1t/tdE9rhaPN3NFJGgGoYr23bG1E0jlig4
	N8ZHQXfhqTq6nu1T4aR6eYRwBXMzgjrqZbYFyoDNgsrzf7JtB3VtffmIr9WnCBqNpbtAk6hS3oP
	cAV6I7/5J37uM6mmApL93jgExIH8u1IeMtAlLqtdsKg==
X-Gm-Gg: ASbGncv/LxnaG0QZfq2y+zewwQuDjRfsSMLZ54Iqji1eM51yjDF/LGlMiwiGuz3UJSR
	40Q/qKmcJYpNookLSNTMqYs47AU+rxHeT+rANgFyqy7fYsQsW7SdhsHW2OJ/am5wy1ul9sOCwAk
	BStRdFvbR9+aDNT93bMj5JG2fmki8gSatgPZTFH0TPvBGcY6/t/FtR9RZVXbdReyoDu0KKUSpOv
	cAxoPpA7zb8hKk2tppAiZX0ysu09cqT/Kva5PcvdCIvYRIV+1h+ASSTqhIw
X-Google-Smtp-Source: AGHT+IHLWOjQzOq4EZEexl1y0s5TIFbR+H99TnsmW8bcHc62dykPOU9F431Ol1GwHd2wZKuQvjGDL9rD6FA5jNk+Oqo=
X-Received: by 2002:ac2:4c4f:0:b0:57e:c1e6:ba8 with SMTP id
 2adb3069b0e04-5941d50dcbcmr5053378e87.12.1762247601332; Tue, 04 Nov 2025
 01:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-17-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-17-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:13:08 +0100
X-Gm-Features: AWmQ_bn8XS0POXmBLNCfkFpdbJSrLm2S0Y6hVDKz6kn0uAZYZj2a91Sws73mBO4
Message-ID: <CAJqdLroCjAwveicSftrf9BjCSZUdR3X_oG3pvkV-_cWuP4qfAA@mail.gmail.com>
Subject: Re: [PATCH 17/22] selftests/coredump: add debug logging to test helpers
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
> so we can easily figure out why something failed.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  .../selftests/coredump/coredump_test_helpers.c     | 55 +++++++++++++++++-----
>  1 file changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 116c797090a1..65deb3cfbe1b 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -131,17 +131,26 @@ int get_peer_pidfd(int fd)
>         int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd,
>                              &fd_peer_pidfd_len);
>         if (ret < 0) {
> -               fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
> +               fprintf(stderr, "get_peer_pidfd: getsockopt(SO_PEERPIDFD) failed: %m\n");
>                 return -1;
>         }
> +       fprintf(stderr, "get_peer_pidfd: successfully retrieved pidfd %d\n", fd_peer_pidfd);
>         return fd_peer_pidfd;
>  }
>
>  bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
>  {
> +       int ret;
>         memset(info, 0, sizeof(*info));
>         info->mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
> -       return ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info) == 0;
> +       ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info);
> +       if (ret < 0) {
> +               fprintf(stderr, "get_pidfd_info: ioctl(PIDFD_GET_INFO) failed: %m\n");
> +               return false;
> +       }
> +       fprintf(stderr, "get_pidfd_info: mask=0x%llx, coredump_mask=0x%x, coredump_signal=%d\n",
> +               (unsigned long long)info->mask, info->coredump_mask, info->coredump_signal);
> +       return true;
>  }
>
>  /* Protocol helper functions */
> @@ -198,14 +207,23 @@ bool read_coredump_req(int fd, struct coredump_req *req)
>
>         /* Peek the size of the coredump request. */
>         ret = recv(fd, req, field_size, MSG_PEEK | MSG_WAITALL);
> -       if (ret != field_size)
> +       if (ret != field_size) {
> +               fprintf(stderr, "read_coredump_req: peek failed (got %zd, expected %zu): %m\n",
> +                       ret, field_size);
>                 return false;
> +       }
>         kernel_size = req->size;
>
> -       if (kernel_size < COREDUMP_ACK_SIZE_VER0)
> +       if (kernel_size < COREDUMP_ACK_SIZE_VER0) {
> +               fprintf(stderr, "read_coredump_req: kernel_size %zu < min %d\n",
> +                       kernel_size, COREDUMP_ACK_SIZE_VER0);
>                 return false;
> -       if (kernel_size >= PAGE_SIZE)
> +       }
> +       if (kernel_size >= PAGE_SIZE) {
> +               fprintf(stderr, "read_coredump_req: kernel_size %zu >= PAGE_SIZE %d\n",
> +                       kernel_size, PAGE_SIZE);
>                 return false;
> +       }
>
>         /* Use the minimum of user and kernel size to read the full request. */
>         user_size = sizeof(struct coredump_req);
> @@ -295,25 +313,35 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
>
>         /* Set socket to non-blocking mode for edge-triggered epoll */
>         flags = fcntl(fd_coredump, F_GETFL, 0);
> -       if (flags < 0)
> +       if (flags < 0) {
> +               fprintf(stderr, "Worker: fcntl(F_GETFL) failed: %m\n");
>                 goto out;
> -       if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0)
> +       }
> +       if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0) {
> +               fprintf(stderr, "Worker: fcntl(F_SETFL, O_NONBLOCK) failed: %m\n");
>                 goto out;
> +       }
>
>         epfd = epoll_create1(0);
> -       if (epfd < 0)
> +       if (epfd < 0) {
> +               fprintf(stderr, "Worker: epoll_create1() failed: %m\n");
>                 goto out;
> +       }
>
>         ev.events = EPOLLIN | EPOLLRDHUP | EPOLLET;
>         ev.data.fd = fd_coredump;
> -       if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0)
> +       if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0) {
> +               fprintf(stderr, "Worker: epoll_ctl(EPOLL_CTL_ADD) failed: %m\n");
>                 goto out;
> +       }
>
>         for (;;) {
>                 struct epoll_event events[1];
>                 int n = epoll_wait(epfd, events, 1, -1);
> -               if (n < 0)
> +               if (n < 0) {
> +                       fprintf(stderr, "Worker: epoll_wait() failed: %m\n");
>                         break;
> +               }
>
>                 if (events[0].events & (EPOLLIN | EPOLLRDHUP)) {
>                         for (;;) {
> @@ -322,19 +350,24 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
>                                 if (bytes_read < 0) {
>                                         if (errno == EAGAIN || errno == EWOULDBLOCK)
>                                                 break;
> +                                       fprintf(stderr, "Worker: read() failed: %m\n");
>                                         goto out;
>                                 }
>                                 if (bytes_read == 0)
>                                         goto done;
>                                 ssize_t bytes_write = write(fd_core_file, buffer, bytes_read);
> -                               if (bytes_write != bytes_read)
> +                               if (bytes_write != bytes_read) {
> +                                       fprintf(stderr, "Worker: write() failed (read=%zd, write=%zd): %m\n",
> +                                               bytes_read, bytes_write);
>                                         goto out;
> +                               }
>                         }
>                 }
>         }
>
>  done:
>         exit_code = EXIT_SUCCESS;
> +       fprintf(stderr, "Worker: completed successfully\n");
>  out:
>         if (epfd >= 0)
>                 close(epfd);
>
> --
> 2.47.3
>

