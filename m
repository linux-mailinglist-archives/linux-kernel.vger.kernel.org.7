Return-Path: <linux-kernel+bounces-884408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B4FC30224
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D3E46100E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBF9313529;
	Tue,  4 Nov 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="PiSoxJrO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A42BF000
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246396; cv=none; b=ugy0lROcaaw8TFsMXwbrKySZ3DLAyd26BemGYznN5AXzBYTE7IWKoOJF03O132O/jAuaiL1aVYLi5jbFGqAhl8Q/cuAjEwnlYF5500zmE9Ic6/KKDB3DxT615ZNoU0IHN5Mi7L/++jR5Lx4jW8qcldy0qyecBFQC4Qk5crh7oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246396; c=relaxed/simple;
	bh=aq0omEoi4+53NC8HrfomYE/g5rpil+xDKbV+0OWd/9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmxKpiCGvox3LrPjIX++ao8HrEznzLgZJjfjt7Gi6xB4iBTTf0ALPBxH/CTTuBvbCWLyZFuP5pTKzREqboM8c6G3QaYmgwveSBEHVnnfYHDbVheIqmwjaklMysqH4uMTobTNm0/Cc06RV7oIf+JJlFnk/kmGTymO3BJDenTfI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=PiSoxJrO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-591c98ebe90so4847034e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762246393; x=1762851193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X2BYWHPcs6UGsM6Z7RjRBFBi7foOq/GE7TEQzUwZJ+g=;
        b=PiSoxJrO3xNSV7jcBL8dIoMmseZ3/1HZF1ITqpGStyfAqywV+dWoRT//XSRnmmLKbn
         X1TPmSYa37oqs6+0BEKnHqB948IOCguGm+fTNVrEF5xlgBHC7oKh5tiNCvBwzmEtNvPr
         ysx1UqMHnvGnmkKc36MYBw/o+5oYv1g+bVBu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246393; x=1762851193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2BYWHPcs6UGsM6Z7RjRBFBi7foOq/GE7TEQzUwZJ+g=;
        b=iAkJrkK9fxQi3PWMDlELjDttoBDfmJEgWOQSq5pL1sWvb/2Hm2dMr1Chz2SrdBU9TB
         f/OKulKIrx1tRXDMoLbFu9JQoiaFsLwBodKUgWU/Hk9BVly+HN4miT3ZgtrkqO7Jb0Uw
         tdYNqBuFoS6KntOzrpK6Lvi6UY9F94SQnMss5pnE3QB/Kn4YJTT4DHDy2m9ehzm0+tXp
         bEc/hfskTFxZLzdYp1W+o7+e0SknEXFeeLObdiLUlTbte1A4MbqRTsosQd3iNm0QNuyH
         3glJ410jukJGtDKaVVWVQ6w3o5d4XVX6kq0ER7qhUBrg6TbHS7GEO3d4XBfsePdJzMKI
         w88Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmeWC0Fxi/S/kR7S2JLwQzHIlIXMCd3MA+vZwvPDBoUtF3iUQTT7rRqky0nqOTWSITDVJNXcnA0Zc3BbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysUnHW+2um+9xkdiUs0NlCRaoiMZJSv8UWiibtyb7hSj1cQXYl
	x63yTLZRSL7CkrZeIwVp1SY+uI4K2dps30cpwWAJT20iu8DPrDValQ0fXJfsPu8mn8SOLZZslrI
	vM7WJWWDwt77ki3srWWDQaqptpSqMQx+E1gFusLSPT4tHJhWGIA5jEEA9+fKRYyU=
X-Gm-Gg: ASbGncs1jIeG81yqGNNVYz+0ubpvh1eIBy3J6kEFu0U5bWOANe5XLkZhltxC6PkiayO
	nC+fo7jxPCxEyW5IANFrdGVe7LQh8fg6VV9VWdDqyemeNrM98jbnsg/aUCO5JvWGXApZ6DMsjVf
	UZAEeZxRbOZ44gUtQw7JSzloMQlrvwKaKqmTltZ8Dwe2cQ97cR2HHcvvZhGj7u0S+ahGVzqcqPj
	NLh8H02G1oFg7NUR8RDPHj3BUlNk+GEn4kdBp22xOr3BdGl8dgXtI/vdV3r
X-Google-Smtp-Source: AGHT+IHaVkIZmiY61cwluXteqyDeM2eT2eyEncQyyx+Uds4hJ8EyPCT+scmZL5PaUyj9H4iMCL6H8Yf2ra3DqynTIKc=
X-Received: by 2002:a05:6512:2387:b0:594:3564:437 with SMTP id
 2adb3069b0e04-5943564079bmr547358e87.49.1762246392566; Tue, 04 Nov 2025
 00:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-10-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-10-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 09:53:01 +0100
X-Gm-Features: AWmQ_bk6vv7fvWPe0zWpUUuRPlVtxmU_G4j1JWfNzhZ22ZvVNF4yvVqf69K-kzw
Message-ID: <CAJqdLro5Mtr_JRXnPehxEErY9L=rxAb-iXavAPqKxp1fTto-rw@mail.gmail.com>
Subject: Re: [PATCH 10/22] selftests/pidfd: add first supported_mask test
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
> Verify that when PIDFD_INFO_SUPPORTED_MASK is requested, the kernel
> returns the supported_mask field indicating which flags the kernel
> supports.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/pidfd/pidfd_info_test.c | 41 +++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
> index a0eb6e81eaa2..b31a0597fbae 100644
> --- a/tools/testing/selftests/pidfd/pidfd_info_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
> @@ -690,4 +690,45 @@ TEST_F(pidfd_info, thread_group_exec_thread)
>         EXPECT_EQ(close(pidfd_thread), 0);
>  }
>
> +/*
> + * Test: PIDFD_INFO_SUPPORTED_MASK field
> + *
> + * Verify that when PIDFD_INFO_SUPPORTED_MASK is requested, the kernel
> + * returns the supported_mask field indicating which flags the kernel supports.
> + */
> +TEST(supported_mask_field)
> +{
> +       struct pidfd_info info = {
> +               .mask = PIDFD_INFO_SUPPORTED_MASK,
> +       };
> +       int pidfd;
> +       pid_t pid;
> +
> +       pid = create_child(&pidfd, 0);
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid == 0)
> +               pause();
> +
> +       /* Request supported_mask field */
> +       ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
> +
> +       /* Verify PIDFD_INFO_SUPPORTED_MASK is set in the reply */
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_SUPPORTED_MASK));
> +
> +       /* Verify supported_mask contains expected flags */
> +       ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_PID));
> +       ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_CREDS));
> +       ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_CGROUPID));
> +       ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_EXIT));
> +       ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP));
> +       ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_SUPPORTED_MASK));
> +       ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP_SIGNAL));
> +
> +       /* Clean up */
> +       sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
> +       sys_waitid(P_PIDFD, pidfd, NULL, WEXITED);
> +       close(pidfd);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.47.3
>

