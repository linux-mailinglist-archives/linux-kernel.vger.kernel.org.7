Return-Path: <linux-kernel+bounces-884476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1626C303A7
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A81888661
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A929328B61;
	Tue,  4 Nov 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="aDC1exI6"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3B3126DB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247594; cv=none; b=PucsvAxh/r1IGtIe2CLm1b8inmetHRsMV9KLRRfKqS1ws4+lHuCMLVbdreGDSj9p9jhqWtk83IG1jHlpAX84/3IJSpGivf4+LoTKq5KiuwXJo2sQiEhPbPlQbJY3PtPF/04dzkJV9xl0Xt2oq7GSUZkZGUPXu4Qo3e+vzga6ZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247594; c=relaxed/simple;
	bh=NDU1hiQwu7FdHTpMhd0I9FoiS/nc8IPLEwr44cI7vmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvkArn1XBMJTytvZ6KrTLVAoq9VeQaQScLR1naJ5Q4hfVbiQ8rxHs8jsdtGpvC0bR2MP9p2PBsBRFb2DGqTu1evISzjXY2gv48SU9EoRu85EOH4GFXBi0XwStWWewOxGn56HelYTLQsp3qCcWjpWdnNpB0B6NRCw6xqqlPzyvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=aDC1exI6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so5257330e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247591; x=1762852391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JJwXSbqr+v12TtiF4SUvzSMGeBbQ6+WpMyUrdAjzl0=;
        b=aDC1exI690qjpWiKayywuA8Eq/3IwToORd/8kn7JT8cuAuuurmD9EQYzl11U/f8+am
         spMuHdsiLBFI+mwakT26jYJd4Zq5z3cbrWlmuvotGqQgP2KXFjPX0GOG+BnjHKiJH4Bg
         Zl8dTjOVx8D6jEinZWj51pCaMNFcPZdvO/7U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247591; x=1762852391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JJwXSbqr+v12TtiF4SUvzSMGeBbQ6+WpMyUrdAjzl0=;
        b=YT5pkWa/mu/nNNEjLXyhAZlwwtlADNK+ksmy0drdFAp+5vUoilKkfZ+ljk4rRBhZxn
         JBRE4EDBK3e7P+mXRmQo659D5glP2Xlgh/0IgYAjpnwoI2G8wYhvqXhghBP7iWn/Pkxn
         jELlGOI0+M76U2Az++7KPcakgCFq7oQjKYOB4p+mIM1/UhOTNUOyBNN/6MXhEty6n/oy
         Kctm/7mRYp6dnELDf2M487EPQUB/HW7T8SVkhSjgYX+WVVax8l1/Q5biMmOfXMye5dG1
         Ij8leftKMkoflxJzY9Vny1/W0XN7CINXwmfF5lT0FdNUA+UKVCUoBVE9gNVne7uj8+jL
         ss4w==
X-Forwarded-Encrypted: i=1; AJvYcCWdT5cBccj2JdoOLJDeChHXVhWP3e6bKCdCveBSDtvwQCtOLmRZZgooqAa4l8YZzqgWIAOKtn5wAMA0sFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJMR6cbERI2oD5UjUEtGLxsrE3OVk7NpIHhIxGM3Zw7FSw/gB
	PvCWqL5aIRIZ3/+wtCkpo1KcCl1R5dRiJ35Ka5iQluaqFTvcYv1Vz73v46eASf5qh2KCqon+vBE
	AJB5ccqn40Q+T2NrFVdxmob2rKqhZ27zjYXIOT2/WzA==
X-Gm-Gg: ASbGnctGWg/Bn+tMyKbxgkNwpqxzdc25lPw4YChV8f2M1c/vJeXOzjwOBOHf3Uw386p
	zLD/C9m8eSeQJY5kf5wjwGyKi3P+rz3nXeK/1avqPyw4RMMJmb7q2bzqWqGj2EiecYqBs655byG
	CJ7B2QjEBnsJ4ddNQCB0HdcN5N/QnkrOalP4FV+9vYVzTKvIwmRTHCSDhpTfhhkfYi852FXVJyZ
	Hs8j1noK8qcIGQsTQfqezhtQpyYHotxF4za85OiwXFA3Z4CbiHyz7jZr+8KorbEF1MgviI=
X-Google-Smtp-Source: AGHT+IGIrgqZur4fdDqVzzBvNjnqurbHh6qFq/W76MRjvcgGMQTlFuhtN29tyTK2nV0YI6a9E/yOj99hDn+LYF28LEI=
X-Received: by 2002:a05:6512:b8d:b0:594:2997:629b with SMTP id
 2adb3069b0e04-59429976537mr2228773e87.0.1762247591236; Tue, 04 Nov 2025
 01:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-16-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-16-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:12:59 +0100
X-Gm-Features: AWmQ_bmXdEopZCYfcyuYWp30tuUpRICJUFmghYYmVfsBZAPlWH78ckTbofZQDFc
Message-ID: <CAJqdLrr25D+-M0kPhFkh-7pp1J3Z3B21DhfQaXOvTEN-3D3LQA@mail.gmail.com>
Subject: Re: [PATCH 16/22] selftests/coredump: handle edge-triggered epoll correctly
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
> by putting the file descriptor into non-blocking mode.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/coredump_test_helpers.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 7512a8ef73d3..116c797090a1 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -291,6 +291,14 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
>         int epfd = -1;
>         int exit_code = EXIT_FAILURE;
>         struct epoll_event ev;
> +       int flags;
> +
> +       /* Set socket to non-blocking mode for edge-triggered epoll */
> +       flags = fcntl(fd_coredump, F_GETFL, 0);
> +       if (flags < 0)
> +               goto out;
> +       if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0)
> +               goto out;
>
>         epfd = epoll_create1(0);
>         if (epfd < 0)
>
> --
> 2.47.3
>

