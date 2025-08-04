Return-Path: <linux-kernel+bounces-755644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E01B1A9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DB3189EC81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA088285078;
	Mon,  4 Aug 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUdbm84A"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7C213E7A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336879; cv=none; b=DYuMQCw/euXgV4YnbuxWRi3z6Ai8gL2GoUR6O6d9/afgkzUkBFXoEOepDu/ijyrM+mvSLovi0ydxyYPGJukOwaWfaA4tzWkxIDqn0epyDiAej4k75rf6zo61DFFbkWeUYVlcNxp4vVza+UQlOqsiBoEexU3J2OJvMZx7VHZr5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336879; c=relaxed/simple;
	bh=QTWznTbgv/hmeJ1fBa87AUszKW8tkF7EzOr0/pR1stg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOOlAb0pgwnhVr8cInsPAbev/yGZk7cASuoWcW0L13iO/3eQaKUHc6U+F5P8rLJq6Y2nRFCWhYKs5v0HB/N7ep4v289kFFzqZAYCO0ZEJiMElPhgBIiPvHHB5+kThoUhUDEt3IuFonF8oelxwBDNfTPmdOjnNZBywmOTMjCBNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUdbm84A; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0673b0a7cso136041cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754336875; x=1754941675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrOnGWzkIooUjPhodPTfN2zjEbxz+9LZiG9j8SdmlDM=;
        b=QUdbm84AxvEaZku+UwbYsF5aJ+a5Dl8DvJnpDUuO4gOoy5AvA062yn5zEZW6Ut5VfW
         I/+i+jWSorfUzwYEmu5MI3nVt6zMdNmy9XqbWGs4vpJF31kRqqckoGthgMd08WZJ8YAa
         FvZLyfBL5iqnM9f/0V3lrfW+pn4lz9WrxRmPjaFXMVZ5IcrGnB4vY1GmUcibvkyU4+Gh
         9lbY3vilh0eFnQICF9fcuFFGJ3VMvHmmV3KCumeboS6I7ihkrKXCUWtebLU9CgCft3rV
         1We7Dg2MqR9zNShLLIfZDkfXKEbB9U2jvTbA5vGLF2RP6rVB0pCMfMg7jXZi34Bw1IXc
         GOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754336875; x=1754941675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrOnGWzkIooUjPhodPTfN2zjEbxz+9LZiG9j8SdmlDM=;
        b=h8T7abQrBH0jcHOkX3YUND9pa7aTjQJl8Z57ja9vnqWkpt9WTY9r2g9TkMGfoX6hPa
         VVXauskAOrKZ2BFUut2Ig4JXk4iJK6+rdVXRE1ZHddgVWQ+7TdAKoVKsv1RjdLYPHb4/
         P8VjSpaTjdo8m50ghnkVDPISItky17vLfZI46gEAq2QNYhoRq+fWqG68K55wxVhHkaFo
         JH4ri31XT78mfgcBa0RUsZ5tCbipgcvu896bkohkIbt/yDaKy9Q7DLt+ZubscNpGaLYN
         CLjm3tT3GICKYFMhIUddiQzSD8LlEyH+KfHhpL8Cfkur8j4j63Ol5CFZ6YaHDhncN+HA
         nzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtFPdLyFu4wcgynoECNj27qIe6BGMxfqmXEOP0Mh8rDc1CNuqwQxf+p4EExC62f74C2KKSvEQF2qtszr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjr9QGogT0UA6RJhRwgE20CiOl8pAgmwgpcd0LKAoWi33LpuPZ
	0wqvUa+EZ4oNcnfkFIQjLfaQ4VK+zxFYIIJFz45XNoNd9ob8yEeRXnKs7QuTNZuxPbE1WStYIQK
	n7ln9c06Yq/Vt4IVOGAErfp/1i6emtRbaUh28Z7Sv
X-Gm-Gg: ASbGncsyEg7UZBAmCZmxR7wp5uYlJGb6UQKa6VtPTS/rakRRwIYAzQT122Ptc5zwidQ
	kHy1jZJBUxP2+KMd6RRA1IFwfMcnPKzSV+hN2c+W7ccSB7clGYIZBzCGaQVTcI1UTOhcr9XX3HM
	WZa9rFmgvNvXPz5KsgFo+fVQFEw2zZrf6WyItislliHvZAJG7koeEOK4Mj6pltO7+FUfHynQle4
	6ql1VHt+Tc8CEMR5AisFZ5OxJVgR3sjSFBcQ+F7ljgj3KEO
X-Google-Smtp-Source: AGHT+IGGkXixoGEopgPQv5ZQ3AULcDnsyZ7goBmJ8ApcANZ57+NTCDIxVUNfKMZhmEp89RWhBkkf8KOQt4ycU2NrFZ8=
X-Received: by 2002:a05:622a:287:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4b0810767b9mr725341cf.3.1754336875055; Mon, 04 Aug 2025
 12:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803204746.1899942-1-hsukrut3@gmail.com>
In-Reply-To: <20250803204746.1899942-1-hsukrut3@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 4 Aug 2025 12:47:44 -0700
X-Gm-Features: Ac12FXxSpVG6cJouTBBDIkB3VjU9nbAkPZdRVTaV_ZXsscSmQ5CiigJdhAnw-OQ
Message-ID: <CAJuCfpF8+MJ2xmS+dC2O3LLtorW_ugLNJozZw-KM+7fmnSHFhg@mail.gmail.com>
Subject: Re: [PATCH] selftests/proc: Fix string literal warning in proc-maps-race.c
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:PROC FILESYSTEM" <linux-kernel@vger.kernel.org>, 
	"open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, skhar@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 1:48=E2=80=AFPM Sukrut Heroorkar <hsukrut3@gmail.com=
> wrote:
>
> This change resolves non literal string format warning invoked
> for proc-maps-race.c while compiling.
>
> proc-maps-race.c:205:17: warning: format not a string literal and no form=
at arguments [-Wformat-security]
>   205 |                 printf(text);
>       |                 ^~~~~~
> proc-maps-race.c:209:17: warning: format not a string literal and no form=
at arguments [-Wformat-security]
>   209 |                 printf(text);
>       |                 ^~~~~~
> proc-maps-race.c: In function =E2=80=98print_last_lines=E2=80=99:
> proc-maps-race.c:224:9: warning: format not a string literal and no forma=
t arguments [-Wformat-security]
>   224 |         printf(start);
>       |         ^~~~~~
>
> Added string format specifier %s for the printf calls
> in both print_first_lines() and print_last_lines() thus
> resolving the warnings invoked.
>
> The test executes fine after this change thus causing no
> affect to the functional behavior of the test.

Please add:

Fixes: aadc099c480f ("selftests/proc: add verbose mode for
/proc/pid/maps tearing tests")

>
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks,
Suren.

> ---
>  tools/testing/selftests/proc/proc-maps-race.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testin=
g/selftests/proc/proc-maps-race.c
> index 66773685a047..94bba4553130 100644
> --- a/tools/testing/selftests/proc/proc-maps-race.c
> +++ b/tools/testing/selftests/proc/proc-maps-race.c
> @@ -202,11 +202,11 @@ static void print_first_lines(char *text, int nr)
>                 int offs =3D end - text;
>
>                 text[offs] =3D '\0';
> -               printf(text);
> +               printf("%s", text);
>                 text[offs] =3D '\n';
>                 printf("\n");
>         } else {
> -               printf(text);
> +               printf("%s", text);
>         }
>  }
>
> @@ -221,7 +221,7 @@ static void print_last_lines(char *text, int nr)
>                 nr--;
>                 start--;
>         }
> -       printf(start);
> +       printf("%s", start);
>  }
>
>  static void print_boundaries(const char *title, FIXTURE_DATA(proc_maps_r=
ace) *self)
> --
> 2.43.0
>

