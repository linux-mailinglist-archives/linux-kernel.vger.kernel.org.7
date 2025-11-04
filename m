Return-Path: <linux-kernel+bounces-884449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4860C3039E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027763BCFE9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CD3126DB;
	Tue,  4 Nov 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="N7ep6UGt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D4306B37
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247551; cv=none; b=e3S+AXO3BGxlLlaCKSKUSpea7BX9Cv76j8B6oV6cZ8HO5qakZCKYvtl01OS2e2N7RMguqE/Gqmhg690Hbu4NgkRhN80oxeX9nv3ZoXeAWi4UGI+UNNnK4M+QMXKpw+8Gpz6HD6eAp4IxWvOrZEBZnq+lf2MyS60XhCrc1SvmEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247551; c=relaxed/simple;
	bh=o2ZzE9o6XdB8UMA5K+0nNLIJydPTIlCljJKrkC6Lwxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5RWa4qtQPnUuOfu3luOCo1HEA9dlpT8VMftJrs33Fn6tDrMOb/OPGqlIGr5ytBQuqsnlTVL6QiELr8F+fwNQD2TQA6XDIXc8hAnnY4vQvyKlep8gxW998db4whSVfOi+wngSfMbF7sNxcJ60/o952YitsH/BHjkpB0hY/LQesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=N7ep6UGt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592ee9a16adso7190065e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247547; x=1762852347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs7U5bpbiQ1mNNfItM2FfIlqMSB3YqM8ruxgZoN9Fso=;
        b=N7ep6UGtcH3i/eeuhd9ndVhN0VnODYggAwZ0v7jnvg2uY31zRNMgECgMv8xtcwZYof
         CmZJySXp13ZccqJZnOsKgwTL21zhxIKfXiWJ1Vzc39toB8apuGLFJlJWGjeoZrM8N3dy
         vCtgbhJgiUB+L19Q4Ol90rQw1Z6OxaYKb30sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247547; x=1762852347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fs7U5bpbiQ1mNNfItM2FfIlqMSB3YqM8ruxgZoN9Fso=;
        b=gE18DFw+i4/L15475YLBAFLxfxRKLHfr/9DEBBpODvWZ9lYfTQbzNlkx5bJdWdaE0I
         nNK3a0zc8CzVEopeuJPS/sECLPoSY4D4KtlLg4Mt4OxQuKOxVqS5lx6LV8Lt9RKfgg58
         GaJQ9ZjLdYv8z2jHo7senSuKJ9rHGWRV/tqZJSUT+sH7IjE8pJ+47RmRJyDvtgXrOM6G
         W3xwvtTOxksqNBBJS8tCnK53V8EJZ4zqSu+E+0V4u1PUz8QAhaqq7yTkyiDyLlqibX0f
         R4YkzuqnHnH7clYegODFgjq6wtzpOcozYU23GyRFWxB8d9NA4lkjsoRpZsj+UOdhjkBi
         sMaA==
X-Forwarded-Encrypted: i=1; AJvYcCXVwNoVzt0rtrBV5DI9HIKyDGcWmf53BpbAiyQrUL72g5qALWuX1NgtEO6/cx25dZvkFW6mRIoKitvUgWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsdxJ8a3sfPNgPKxuHTwBER6utPi9QObHxlOS1bB3sfKikm0jv
	nLsjv8J01SegQq9U6fKLlMffyzo+4YjAIeKE+5zYB1pnhDN6oNNrarIH6hFY6G++xuh2TJ0EBYh
	8tRiXe+FGXP2EYc056Nm3J8gPAPFIR1kOWfq7EpXqEQ==
X-Gm-Gg: ASbGnctp41ZTdpM4AHhhp1J1KKSxwE7TUmx9GWVZ8Uk+VHJWesnqYG3lMzIBPtx/h6E
	xHUk4o5BRkMWm+Z6jHY9n8zJ1fs6RovFc9JKapDiQQuwPFyAW+gMGMb/eqshO28vCrLpCAcby76
	YpyaQM9rYAYvOQOQYQbMA8H63PJ1/qvDPG86rpfu+XTKuVsRgv7oaOOyzrkrbg50KjKkILEgOcg
	VP2wGl+FgC1ceTvq1jNYyWsC6O30BFI0DcG1wjBNlwo8ZhXQ9w9JU4Js/kS
X-Google-Smtp-Source: AGHT+IFcRPnbXV81VbRg+b0pKL3fjLwG3r84Jxl9s6fmHyDhp2MgXhX5jyPThzIbVyI26Bwuo8r4Rksy8II5R71gfhg=
X-Received: by 2002:a05:6512:2256:b0:594:2f25:d48f with SMTP id
 2adb3069b0e04-5942f25da87mr1828563e87.6.1762247547246; Tue, 04 Nov 2025
 01:12:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-14-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-14-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:12:16 +0100
X-Gm-Features: AWmQ_blneMo9_if6WBzLQjXedv-DfHARDPtiOzJNxkYWsXHmtGpv8StzmJlpQWs
Message-ID: <CAJqdLrqiHUfKk2FkCUQZXs63_6g32tEV2e_iPtJoNioQFu6xVA@mail.gmail.com>
Subject: Re: [PATCH 14/22] selftests/coredump: fix userspace client detection
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
> We need to request PIDFD_INFO_COREDUMP in the first place.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/coredump_socket_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index d5ad0e696ab3..658f3966064f 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -188,7 +188,9 @@ TEST_F(coredump, socket_detect_userspace_client)
>         int pidfd, ret, status;
>         pid_t pid, pid_coredump_server;
>         struct stat st;
> -       struct pidfd_info info = {};
> +       struct pidfd_info info = {
> +               .mask = PIDFD_INFO_COREDUMP,
> +       };
>         int ipc_sockets[2];
>         char c;
>
>
> --
> 2.47.3
>

