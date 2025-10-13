Return-Path: <linux-kernel+bounces-851525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE3BD6A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83744F0245
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2742258ED9;
	Mon, 13 Oct 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MvaYYW+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D32C15B8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395571; cv=none; b=Tyi9fooN4/Cx66IAKOn70NUUEYGbvPkfCFEBuZa6f2r1QnWRWvfalNOIdLETENm+UUC7r1R6ZcJOlJnCl2ZuHIt3VQiHaVQFtsOE8vGx0RauynueUm6JJJNvdr1sbRZXHjNJl0ymIMtK3QXISdjLwBPETmZSTjfYEOuyG3tfGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395571; c=relaxed/simple;
	bh=bn5DgtyssQVy7kgsuL/eXuL0gtRJPdrFG9f3arTM+PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J50zl8SnVYElCxjxnOi5xsiSFh5WOZc7Rwsww2m0JKAMBSbJ1ltaf7K/4wX9P/rDKSNxlKvENc2MJHDheZuXmSgJ6szTw4oFhzM4TVlAI15VQ1O2TdTP0g0J3gImdosWwAsz2W+W2A9oJ9O0EazaNmUJiWjEZO79S87LF707K5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4MvaYYW+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2731ff54949so465355ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760395569; x=1761000369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boG0FYGXiJ5nfzzHNCBXL7GzK1oH6osAdbuuGp7I7vs=;
        b=4MvaYYW+EPw2K0nh6Y4YZxQr0mrD/Oxw09A0f3jsAMpxWPzQI2zBbwIQoq6/TheDuK
         bHJvVj8GzafEPdGdRO5AR/u2XrJtHBNGXH7gbot7up9IT9NEFmlvy+38vQrFpkNDq3Id
         0pimn3C61CQJFeH9nZV9iVZNsJxsNb7lmFzhIxYOd1/4lm5iygNc0K/nnQVUHDUxHmjH
         sJGA2pWrlOMDFPIMGW815LIKOB/W63XnknspQRpSAvoYe9aHzKc8XkSXSWdbRMrbJ/Rm
         wtAmV1wagv8DwtHrlpKHkfZgD5a30Db1xqVjbVtLCOtz86YCNSvnVuVQsgL9MqnSW8dU
         KpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760395569; x=1761000369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boG0FYGXiJ5nfzzHNCBXL7GzK1oH6osAdbuuGp7I7vs=;
        b=C/TmIys2JWJj4V5UsIsrDSXXGbJoKPOT2MwRTB0eiF2WbgWgEKjunKT86HVxyT1sbv
         nmdwxfLjpPuK15+y9oH4ooiaMXdIVmyFsY12yCCZ9vAUQOh1yjmvVRCaRBgSCdhttqUu
         DTQhNaZKedBh9RtxzQDl3TRKmBU8vKIXJlxxlloGwM0Yq2kTwvx6GOeJOww+6kH2l9nH
         9poywiiEJQIxyP4bfloSIPMwRRiFSjG0hpLkhzYzehGiBVnXURHwQefnHXGhJZJZg3DZ
         PHOWQlYeOBZk25+0l1r3vfYm2YiDG4Mavf+Cbjzu2BPcuEf4VoILNuaOkzmvodjjXvsr
         Zs3g==
X-Forwarded-Encrypted: i=1; AJvYcCXuR7bQiJ7FNxukB8AUYa5I26B/gDJW0Xx8/Pww3aksd+T0WIxcfw3b0nYuYiIQDsDHRv9w/Cf0XvneA38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dOFZQGdn7wydhGBkW3VjJAsDTOadrpR+c7ZhW+N0/qNQCB5l
	/eO4HXpI9Yit1KUJDaKuN+SishailcigI85WQ5Z2UNzJZNZnX5ScXwIdtnw+QUSY4H3XeOPrpDO
	AkfPloCa+jHuwmslSbt0BuFsFIFr2LYS+KsZPXnlt
X-Gm-Gg: ASbGncvMXAg0yQgtjlHUZLSXSwcs39WhHDfUreQSbpn+Tgw4JmAoqWuDxrUZiBHOcWK
	4Gdfhwosp2hGayt3bJwpbLsI3mz7DurcItiXuDXMGvJsmxYqE8pED3ZlXLz2imhLvJNOiR/O+y0
	GL2vIrA/hOW7UGqozRrmkxlu8tzbbFOdqB/WQofnXK2l3kFpVU4sjZB1RTbZB+hvFMRow80ZEE5
	K4n8+nJfrpduHKgH29hBMMch0M/AQ==
X-Google-Smtp-Source: AGHT+IGWZwRjignMddDzAcrQKQ+jV5fOl2eBnQYPKGt15BQt1b4GNJi1cMOcFtGANtK+8a+v6Bml24pSJeHps65zPew=
X-Received: by 2002:a17:902:e80d:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-2902768e95dmr30753515ad.9.1760395568304; Mon, 13 Oct 2025
 15:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011082222.12965-1-zhichi.lin@vivo.com>
In-Reply-To: <20251011082222.12965-1-zhichi.lin@vivo.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 13 Oct 2025 15:45:31 -0700
X-Gm-Features: AS18NWAFYuVDl39MLezHZYVp_BmBrZmW5mIGPQxpuGRh3UtKpZc2ZuPApDPdjfQ
Message-ID: <CABCJKueiQCfSgnc7E5kzyrQAYbMkdCMoTOio8DP5afiV9OgqWg@mail.gmail.com>
Subject: Re: [PATCH] scs: Fix a wrong parameter in __scs_magic
To: Zhichi Lin <zhichi.lin@vivo.com>
Cc: elver@google.com, akpm@linux-foundation.org, will@kernel.org, 
	andreyknvl@gmail.com, yee.lee@mediatek.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, xiejiyuan@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 1:23=E2=80=AFAM Zhichi Lin <zhichi.lin@vivo.com> wr=
ote:
>
> __scs_magic() needs a 'void *' variable, but a 'struct task_struct *'
> is given. 'task_scs(tsk)' is the starting address of the task's shadow
> call stack, and '__scs_magic(task_scs(tsk))' is the end address of the
> task's shadow call stack.
> Here should be '__scs_magic(task_scs(tsk))'.
>
> Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")
> Signed-off-by: Jiyuan Xie <xiejiyuan@vivo.com>
> Signed-off-by: Zhichi Lin <zhichi.lin@vivo.com>
> ---
>  kernel/scs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/scs.c b/kernel/scs.c
> index d7809affe..772488afd 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -135,7 +135,7 @@ static void scs_check_usage(struct task_struct *tsk)
>         if (!IS_ENABLED(CONFIG_DEBUG_STACK_USAGE))
>                 return;
>
> -       for (p =3D task_scs(tsk); p < __scs_magic(tsk); ++p) {
> +       for (p =3D task_scs(tsk); p < __scs_magic(task_scs(tsk)); ++p) {
>                 if (!READ_ONCE_NOCHECK(*p))
>                         break;
>                 used +=3D sizeof(*p);

Looks correct to me. Thanks for the fix!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

