Return-Path: <linux-kernel+bounces-883261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC45C2CDC1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1AEA4F92E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB69284671;
	Mon,  3 Nov 2025 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="DuuUb9kS"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD3148850
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184192; cv=none; b=rDpQXbncUHslmZOMzGJ44wHIGYR/lcEokezc9O4S/3ahIlt/siLB3SZEZhrevSUNF7zscOnNwaA30DL7Rerny1kEm502HGEbBajMZ4OVagZ7dxDFxdDyAiJU9BDom8XaTxZYw96DzaHWdwChxDxtIVfarE4VNu8GbN0fNUYbTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184192; c=relaxed/simple;
	bh=gEnexRt2+csi5XaC3lzTGlhcekCOaPMwHX1bHBIBtuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwhB2uLu8/9BOoeeLHzs4NBPu/fRai9I41O/M3Up6Z7XuQbrmA4NaSzL0w6af3ABM+lt9G/2S565FuCOcXXAneXNU12Ek+AUn99VTK0VY46+jIeQgLzhLmdwXNN4JcYLxTt+39OsP0SRSMTkTAxgAPML39E2S3+5bzfGaa3tuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=DuuUb9kS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57992ba129eso5578077e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762184188; x=1762788988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zzaNsEzQhP5goti+8a1Sk9MxbSfJlJSHEPqAlOOrCs0=;
        b=DuuUb9kSsjBABxTq9zhbEI0S6w6uuVQwTBfqcybvKbOqplf4u14sU7T3TjVoWjwjJk
         B+Zcwb9FvR0Hmm4URjL1EdhoNDL0V3YgwICDkOwCjVykmXEB5+PT4I6sRt5C3YP5AeR5
         a6gDZkDZDgdRv/clMPxtOP3v19j98ooSB0pco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184188; x=1762788988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzaNsEzQhP5goti+8a1Sk9MxbSfJlJSHEPqAlOOrCs0=;
        b=MBDk3QyuIGFYGclLwpYXxgK64FM6dE3YIuvp/avLZ7OWtehSjvTWXKxA09CXz8Kt+f
         szpkgChKyI4cXZ+kSERQcerVEu68HbPrLu2hGaWaZbdMUo6tvH65s1lLoGXUlTMFcgpM
         ognexG1A4wFs+AMLHXaJ8q1kgvKd0sl5atZFF1eVFpPYd5o/6I9yf3cXYAEQ5oYe0Oh+
         VEsYEcpWLn5gANewKvQeJnGq3XCnIyKQo0pziZZz0CE+IdACORIJzA1K93rEGmFVxCsY
         IeIt8FfvIvuiZLS/OyA4ILmgGyTpmFA6/VQtvycFyz2N+nD1Qll1LNCrnXcawLbamTYh
         WkPw==
X-Forwarded-Encrypted: i=1; AJvYcCXbTCLVm9St8Ooh38afHnuEsqSwnEsLN+dAODUO6AihBacU/Vo7DkP1W9CKX7h1SqjjHDTPYaR9PBnyxb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+kuUuPpMM/cpRnsOtCqdZ2ltwIZ0qLPF2uixR4N697VtkYi4Z
	k+jRAcd34p06mxODHia8gbyNuyUnDWo5JVHNfRE6Dr3v5MVW+TY0Z4WLOHu+6FUAzo19nWuSV+3
	6yOsNojHpL71/h10LrmHQKNarWZLFspvj6vzGHmAytA==
X-Gm-Gg: ASbGncvcGx0E7KGRnduY761+LoiD/InV72/uDgo3Tc1Gp2hVmrbsUSeuKLUSvVP7sBC
	xjVFMSBaxKSQcVMvP0dtV043pc4sILdJGTsHZ/VsM4Wl5lV+yQxJ5xryqX0gJlmsqw5n1VwqV+I
	pf6xDEa3kDj3pN0F5S2r8gmhsc2mksWbku6tFOZVJRCVKdaBqZovKsBG8jV3XErN3LpwWG2ypGp
	LxQsRHlS6LpX118stAXkSJcfXY7naxFp7KrewFeRexvedUMZchlwpJhdlpISddYiK78MxA=
X-Google-Smtp-Source: AGHT+IH9HFX6m2RKwMUsRL27KWY/hEtnivxTOj9RRRvqz7hBvsvziImPZeLtzdqcc2cw0n4sxqvyxW74pWwgcfRjuf8=
X-Received: by 2002:a05:6512:3e10:b0:594:2f1a:6ff0 with SMTP id
 2adb3069b0e04-5942f1a7404mr801173e87.9.1762184188265; Mon, 03 Nov 2025
 07:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-3-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-3-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:36:17 +0100
X-Gm-Features: AWmQ_bkG7jG1pb0tTG3Lf2yxUryV1bOUHLFfSOR9QoDXujCIssfdL2lCJtw2h04
Message-ID: <CAJqdLrqvH4Trs=mbQ8qQGqw1tFdBg_5CLSByT8Ectxbk1p_36Q@mail.gmail.com>
Subject: Re: [PATCH 03/22] pidfs: add missing PIDFD_INFO_SIZE_VER1
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
> We grew struct pidfd_info not too long ago.
>
> Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  include/uapi/linux/pidfd.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 957db425d459..6ccbabd9a68d 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -28,6 +28,7 @@
>  #define PIDFD_INFO_COREDUMP            (1UL << 4) /* Only returned if requested. */
>
>  #define PIDFD_INFO_SIZE_VER0           64 /* sizeof first published struct */
> +#define PIDFD_INFO_SIZE_VER1           72 /* sizeof second published struct */
>
>  /*
>   * Values for @coredump_mask in pidfd_info.
>
> --
> 2.47.3
>

