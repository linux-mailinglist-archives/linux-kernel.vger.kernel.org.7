Return-Path: <linux-kernel+bounces-650409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61BBAB9114
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 22:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D454C1BC7FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0129B78B;
	Thu, 15 May 2025 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiW7Py5G"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204A253F3B
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342650; cv=none; b=sel/1tZtiXce28m96bxsfUlOb9END2rC4WdDKt6dltp3TwJ/SJg2STKycxCoDOw4RgvY/BndMXtnPfIu/ttMJgO9uTZCDG1Q7YUhiN36d1chVLCOTbTRKt6Dl0jmX+JsQY6JkA7Qpvi4yFy+99xn1QC6HZ2xygQPMU/L6wGGdLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342650; c=relaxed/simple;
	bh=taP41+wJpy0yc6RsFja33qPnKJw1y2Xhs0S/9nTHmSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOivgKaRDi+Ouk1FTEdAFJTMBg0/qQ2+2q6c0DvBEAKRf8YspKKIj1JcYrOkebION7/fJYj8TosMss7Z+VDlzOSi6XCrwrRIWZNyatZL9TnE8KkAi2XdUgAPXqLwUpjH9CeNBdDaUDGF59GIX7n8WlrFMm6ooKxtQiAB7UYsR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiW7Py5G; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so1376a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342647; x=1747947447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzQSePE6o2SkN8jAbdnZRBJyZ+/cJeSuYPGHH8Q8rmQ=;
        b=NiW7Py5GNvTJUqdHnmdVS0Vx9w/DCUN4NtA1oHQEAKK115jXjMwDE6wq6c431WVkEu
         FYMxNwI0EUxnLxXl4L5RCPL81+QXnvaF5LrroJG+bmbSdTpfiGKH7mpSiPK6oVS9TL8o
         yYqzQLmS9ue4AVnAlXCZ56QFBvk2Sbswmjl48iuVq3lgSF0uXhA/NRDs09SsNSCwsdA3
         ZEqUkg0EAJTeig4yIkHZ6l1+b9FfVldi5DTr/nU/2X7O3wS6EcmTMyOgeRaeHOLjaJhY
         JWP81uMyPFAxNI81Vd+kc3kuKL7ExeiIgJ8tbZRJ5C3+f+Z9Pdk6iFWZwixf8Ro8LaZd
         u2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342647; x=1747947447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzQSePE6o2SkN8jAbdnZRBJyZ+/cJeSuYPGHH8Q8rmQ=;
        b=noxGnpMeSwP3HicfW7kK5+ZsjM88l0Dl7KDov3721V69Ez0/nXWSNPm1abRF+kmTKk
         l/W6juzlO8NgMI9Uy2+hPfySGvrTlIAPxyC4SVnbeGjrjp7H6MdS3OL5c1hD/Nc2T4j9
         zBNGrE17KGeUs4OSy8oFx6RtuGerIfwPbsr5VcoOz1sMIDNpsEZaS6RgGM+Fx0JcQ7BB
         LNxRN0MEqxo3VjGe9qvM7dmI+H7b7esHSdb65Xufi7FwspR5c29UHz72nCvIeKC22Wff
         XoMjhor1vlRtrVrWn+MVsgSgRfxRO/T4qBkjTfReaNDqZh2oVbAQTww3OTq0cscHlpHm
         p+OA==
X-Forwarded-Encrypted: i=1; AJvYcCWW7wJj0lHzXvu/46KqDDZtxtbUPVCvMUA3j3cDV1aZcKFgt1NQ+qs5Bns6UYwpN4rjiyHAZ3pDm7NPJrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk184ot+UKSIGTmnhnXiMkW+u+bHEezAYqS2tWlfgqoy+Q257T
	q15n37JOt+rFbEmslXFzYWXwAsFyHxMxBD51498BFnpA047axKokGFqvrYx9xmqyCHVSwrh4jha
	o+o0ZK9ED/E/X6fO+6r1V6J4nHyuQL8iPv8Kf9oaj
X-Gm-Gg: ASbGncsoV6Bvpgosmq2fSiGDIZzv8h/OBfmnEsbJtN7DMz9f9FgsqzsDuEeZf+ICda7
	Jd0DyokJawiYhbw0+OzkYandJuamjnvAB8KnrKaY5Jg3Wbnifq/TKg6bJRbez5JJgcrvrpyrRmi
	bJBwHFg7VRw89gAmMaJfuRSBDozLFwbP5Id3yhvtVwIc1u/GwAY49xwSvwPGY6
X-Google-Smtp-Source: AGHT+IHUGBHKzk/laOxpxDdk5AaJ2CSKL/1StLLftbiH/My4JJgfMegIqDYIHn/O9agKIBI1Jj9t4zcpldbNJNharAw=
X-Received: by 2002:aa7:c392:0:b0:601:233a:4f4d with SMTP id
 4fb4d7f45d1cf-601233a4fc5mr3907a12.2.1747342647239; Thu, 15 May 2025 13:57:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-7-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-7-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:56:51 +0200
X-Gm-Features: AX0GCFsc9k8E5H-5e-dJE76E_RGv2ErOjmTrupW0-m9zZnC-HBMPkef6m1hs5Ng
Message-ID: <CAG48ez1wqbOmQMqg6rH4LNjNifHU_WciceO_SQwu8T=tA_KxLw@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] coredump: validate socket name as it is written
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> In contrast to other parameters written into
> /proc/sys/kernel/core_pattern that never fail we can validate enabling
> the new AF_UNIX support. This is obviously racy as hell but it's always
> been that way.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

> ---
>  fs/coredump.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 6ee38e3da108..d4ff08ef03e5 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1228,13 +1228,44 @@ void validate_coredump_safety(void)
>         }
>  }
>
> +static inline bool check_coredump_socket(void)
> +{
> +       if (core_pattern[0] !=3D '@')
> +               return true;
> +
> +       /*
> +        * Coredump socket must be located in the initial mount
> +        * namespace. Don't give the that impression anything else is
> +        * supported right now.
> +        */
> +       if (current->nsproxy->mnt_ns !=3D init_task.nsproxy->mnt_ns)
> +               return false;

(Ah, dereferencing init_task.nsproxy without locks is safe because
init_task is actually the boot cpu's swapper/idle task, which never
switches namespaces, right?)

> +       /* Must be an absolute path. */
> +       if (*(core_pattern + 1) !=3D '/')
> +               return false;
> +
> +       return true;
> +}
> +
>  static int proc_dostring_coredump(const struct ctl_table *table, int wri=
te,
>                   void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -       int error =3D proc_dostring(table, write, buffer, lenp, ppos);
> +       int error;
> +       ssize_t retval;
> +       char old_core_pattern[CORENAME_MAX_SIZE];
> +
> +       retval =3D strscpy(old_core_pattern, core_pattern, CORENAME_MAX_S=
IZE);
> +
> +       error =3D proc_dostring(table, write, buffer, lenp, ppos);
> +       if (error)
> +               return error;
> +       if (!check_coredump_socket()) {

(non-actionable note: This is kiiinda dodgy under
SYSCTL_WRITES_LEGACY, but I guess we can assume that new users of the
new coredump socket feature aren't actually going to write the
coredump path one byte at a time, so I guess it's fine.)

> +               strscpy(core_pattern, old_core_pattern, retval + 1);

The third strscpy() argument is semantically supposed to be the
destination buffer size, not the amount of data to copy. For trivial
invocations like here, strscpy() actually allows you to leave out the
third argument.


> +               return -EINVAL;
> +       }
>
> -       if (!error)
> -               validate_coredump_safety();
> +       validate_coredump_safety();
>         return error;
>  }
>
>
> --
> 2.47.2
>

