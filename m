Return-Path: <linux-kernel+bounces-867942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB6CC03FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 972E84E9EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86115530C;
	Fri, 24 Oct 2025 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxNItzkR"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8BD531
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761267330; cv=none; b=L5RQOHthtvW1Az0CkDZkIwi5uE9tA2iVahphLSJr/f46GSkXM8Lm3hnqYZM0w9caiq6mTqivvkWoFDXziATEd/KNime3Xj8VuiikiiO2NVmVlad986obM6kBxUiTLWK5KEFs23UIK4/HkeXvvgrRZFK0Lu0TLKE3AI8+ClcG48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761267330; c=relaxed/simple;
	bh=tXKN/KrVVqwaz+02gblMsY6fc9ysGlid1h1fF631yWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUgIFdODooLn22FSMC4Okgwyaf8mhPUNcsTqf9z5EnGH4Nkgbj+ArEo6qFlo0Sh1RulWhK1MKqdogk3Nd7XwzRVGbeWtqH5aoH3odItmUth0r3PH9/9Gpyh7p+GL5yuXNeLW+NIq0av5AmCJG05R3Ys92TIvMkdySHEfTFq15ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxNItzkR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8915bd01244so239354585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761267327; x=1761872127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoZA1pzb60au9cZqgJ68JKjRI8Zpwo2p8ZS7WXjaxS4=;
        b=mxNItzkR/PvtE8pkD7hher2bHq2NOhrtd/xtY5U/U4Bzld42KgKsNkTPe/IFIkXyaZ
         kQ0ivN/hDAvNzrqy7oD9sUytBcfJUnRBjqtqXAsB9PmM0hzqrSBkSCswBZYr9ZmPrOmb
         cJViJNYyHSGOHciy8m/9bsqM7q8mxNjFXjd3IhlMMOMawzhnvFaJUqsa4C/yG87kgV+W
         pBcD970U5nb00WxgL4gmQ++aqjNepLrPSvK4Qd5MK5v0vVQYWH/tFlvlvtv1TPUmWY/T
         3v0YPQ+4c940LRYp8IfokFxp7t1jRUNmp5P3hLjEIM1QEeZVonTFzuO3qnwAmynqilQN
         pVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761267327; x=1761872127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoZA1pzb60au9cZqgJ68JKjRI8Zpwo2p8ZS7WXjaxS4=;
        b=eVWMO2DuOfnXYFAcHj7+PrHlCY+kNdTcbve94SBzbnt9exJO4xf4gXR5bnOUI4rV80
         +JsDG0T5pShp6PfQgslzj+b4ihdJ0XVbyCg455ySZBZ3/XFvPqYMDFTaBFUov3Us/o6z
         HXwDujNduDwDfTx/ee9jyEWxebfgUW3hOytVZv08TsNl2FtnW6i3si9NBFd+L/42NKf3
         J+jEPfj8SV2pQBsoqYS/Jz/Ya/2v1wlZ4+QV74rKfKSFJSf3aLR92ZsboSn1Mp23Zl7u
         PLzjAHel/YpdVSM5pGmK4iZskYyp/5U6umu/D23m/PUybxPuhrY9vtXJT1eL+mbGWvsI
         2lRw==
X-Gm-Message-State: AOJu0YwOLNwXla8Aw09vMndxW7EiM7mLFi+MGudQJkjfb32NwTQSxhzl
	jc2v0eh7jSrcJVOo8WNi2mxIjfwXlpzHT3ANtow8BuJwiXxNPDglNOpf9AudRxRCeg8H7QgSuEQ
	aKZi5J1tqrJm9ED4kf8M7qdt+dbN5WyTbz9ku
X-Gm-Gg: ASbGncslfqPhRS5jzV6jFt3HSE//cUoUXoSJ3ToOW8+o2gLuC+VSJmjSj6mVV5e22zq
	N4EJvji++OASUWE5gMxgL2Vh76QsQkhhkzCvNVMVSiOVqm4Ha0JMs51gt0dSUewlp24akvOvUUI
	BRlX56RL8Io248kKKzMgO20ycE+yfRb30rOYtiNr+x/uMS8EDIamfKHMfQ/ZROSxck+zbZlv8X0
	8DwY/1/ji1piVSDVoRS74RCBtnYgvBkieHxpkW8lG+t6QWqBZgy2+YQCgeFSkg2YcYEnv2VjR6I
	AeJWvC3zggZbYrPVnWYmt0In4Js=
X-Google-Smtp-Source: AGHT+IE+SAUnlKElqK1N7vvqhnS62oEhjP8zwuFvyXUk8IYsYQVCMzTG6d2uPdHY+JTLUDRIYZQpAeojw0y0MF/YcWs=
X-Received: by 2002:a05:620a:2688:b0:85c:bb2:ad9c with SMTP id
 af79cd13be357-8906fd1829bmr3151766685a.53.1761267327245; Thu, 23 Oct 2025
 17:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021145700.38374-1-biancaa2210329@ssn.edu.in>
In-Reply-To: <20251021145700.38374-1-biancaa2210329@ssn.edu.in>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 24 Oct 2025 08:55:14 +0800
X-Gm-Features: AS18NWAZSayuAl28oOiZncAgrmfcMmCeN382YMqtoNrHp4tNXe78atUhszAss5U
Message-ID: <CAGsJ_4xL1rqqYLLg=PuxvYi_8fS8c7MTsWDk4T=RKs29qnCb-w@mail.gmail.com>
Subject: Re: [PATCH] replace strcpy with strscpy for safe copy
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:31=E2=80=AFPM Biancaa Ramesh
<biancaa2210329@ssn.edu.in> wrote:
>
> Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
> ---
>  mm/shmem.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b9081b817d28..6e5a5d6fc7e9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -657,17 +657,18 @@ static int shmem_parse_huge(const char *str)
>         if (!str)
>                 return -EINVAL;
>
> -       if (!strcmp(str, "never"))
> +       if (!strncmp(str,"never",strlen("never")+1)){
>                 huge =3D SHMEM_HUGE_NEVER;
> -       else if (!strcmp(str, "always"))
> +       }
> +       else if (!strncmp(str, "always", strlen("always") + 1))
>                 huge =3D SHMEM_HUGE_ALWAYS;
> -       else if (!strcmp(str, "within_size"))
> +       else if (!strncmp(str, "within_size",strlen("Within_size")+1))
>                 huge =3D SHMEM_HUGE_WITHIN_SIZE;
> -       else if (!strcmp(str, "advise"))
> +       else if (!strncmp(str,"advise",strlen("advise")+1))
>                 huge =3D SHMEM_HUGE_ADVISE;
> -       else if (!strcmp(str, "deny"))
> +       else if (!strncmp(str,"deny",strlen("deny")+1))
>                 huge =3D SHMEM_HUGE_DENY;
> -       else if (!strcmp(str, "force"))
> +       else if (!strncmp(str,"force",strlen("force")+1))
>                 huge =3D SHMEM_HUGE_FORCE;
>         else
>                 return -EINVAL;


I think this patch is incorrect. If the goal isn=E2=80=99t to guard against
stack overflow,
it shouldn=E2=80=99t use strlen("never"); it should use the length of str.
On the other hand, we should ensure that str is large enough to hold values=
 like
=E2=80=9Cnever=E2=80=9D or =E2=80=9Calways=E2=80=9D.

Thanks
Barry

