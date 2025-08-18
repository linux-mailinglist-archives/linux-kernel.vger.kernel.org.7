Return-Path: <linux-kernel+bounces-774453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1691B2B282
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DD5E533C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8717D2236EE;
	Mon, 18 Aug 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IEyknZHQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E815278E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549327; cv=none; b=WJcqB1N34qHE54zuZhoTvHVY+FqWMEm23AEZ6Fr4huOyLepJkwh9JG4M2ZnSt3p67Kb5UbJvApy2rlAl2EXxbHUJIfmcRnR9liRMkHCXuNdq5XtAyNzAp/cx+uCgA2stla75xFZCWhCFnQ91AVwiWKFVcmJgOPQHEYMaRpYULOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549327; c=relaxed/simple;
	bh=eqVkeZYur4vB9IiQRm1NCdJ4YaR7bQVBv12DWTl1zCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qe/xiHT5gQ1jELr8popAJwgofm32XocEgeyoi5qMIywZs5UgWOITcLuK/ngjnrf9FR3n9fOlho7z4MO86h6CVmNqS+5hH3rKrafKcZC8zOY3Yn6RcL070t/SEpHyy5zHcXdxkT9WmBsUdYFwKIFIDJigu/4wjW+4s0SsJbqwMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IEyknZHQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb72d5409so733902566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755549323; x=1756154123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrUPoAix4GJmNCXAtshi2uvFt0DKJJ/xCnFV+qY1rgk=;
        b=IEyknZHQ5HTtcAo2Oh+mFmqwS3k4mFoYqp712C8v/Sb+O4Q3ElF5T+kEfmrpD6fjQ6
         bPFCnWEmV1CvJFPBS/Xiw1x1I5YCZAACr6zpV3J+7l6quwDpV772nWLCeJZe7CFq2vZu
         C76MyV2JkX53mtKnHiYY6rCi34DNYEV8uZvEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549323; x=1756154123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrUPoAix4GJmNCXAtshi2uvFt0DKJJ/xCnFV+qY1rgk=;
        b=qrvh9+32QtHK1BcpjDbjdk6r/TYwtWuwKHc0b+U65BMqSwHrt/ZMVtEOOejY3XH6wz
         dPh3VHiaXo0hoNB3yhsbzPXairPyT29t0lC1KKiKkqDotW8glYv6ocNO3taTW/DJeumY
         QgtNe3fCRXmXjn44jTKrtD8iuw0oAePAoLeok7Mm+aVmPxu4NOLfsvJqdk+Lo3Ni5za8
         e2mRSM7tUJNAx8rRRn0j6HJqs+BaZo7IoEhJcyBA15Y0UMezJ8UhssfSk+HcrLSrvMv2
         NorMqzEfFS4YuLL51eeqRx1g4arfPDg/jxkPDm8OPViNRfPcnTceL2cmVXwdb0irj1UJ
         dJKw==
X-Forwarded-Encrypted: i=1; AJvYcCWwTErb5TUaV6+g/WxAgmDAFnafp20yzhMp+JH0nrZAOvtMdwlF2R3cKejghXZMpK9yVHeHiR9Itf6TtcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZDc4ReapFC5DVMKaLBijHuq8m53vLVAVtpDPIOQ9j8J11OiF
	9EejtRsK+crF/vvLNStJ6DE6FZ3hd4srMC9meUNqIQzzkK6czSkpSg/9cnETBND+Z1caFPMpcgP
	tpw1jY8Lz
X-Gm-Gg: ASbGnctGfZdhaW+JFHss7EuPz83ik2oPlfUjykPtDb5TC8ZzhbRB4erjzHQ30+/BRr+
	5f/rBuhxsS/OAaBhrS0BMrWyJekJMJlZl9+k2oojrkgFDgn4jc4V2+/AQTBTCALm9eN9tAEsaI3
	G2UHbL70uEAWpK8jd2OSEP5Z4FC6lUHrbewLVltp5+32bnhpQuxKSXrOOOU5IrfM3Ro0qDhBQ7D
	gaOa6OtiEcc3xZ+0Mz4sG1GrD/PsXiwwBNv9vj3eUGXAUsqj7fPVU+qyK4fbPSpfzjHzWL6+hO8
	nHLyhC6zfCkuRanNFCYgY/9LLhfy8y/7FHREd6kOBT4QYrGFGfbY/PssDiuwc20LOqlkV3ECxyJ
	pmnSFUo5RiXX0iUZFFuVVydWLz3OLVfeWqecgBXIcfDY5zQIdbKgRt4ULwZ6W1gVDNNLt+mIC
X-Google-Smtp-Source: AGHT+IF8a75bKlaD6vjH3sZFXLxLIU68+UO6/ymmjyrxO3p+Zkp8+yYURXEfA7Cw5j1gXXvFbsvfjw==
X-Received: by 2002:a17:907:3d8e:b0:afa:1453:662c with SMTP id a640c23a62f3a-afddc96169cmr11837166b.8.1755549323270;
        Mon, 18 Aug 2025 13:35:23 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd018a4bsm846200566b.100.2025.08.18.13.35.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:35:22 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso651138366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:35:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsYyxG3kAxojgSoT9GDijhTWEVFBhAtjn1KBP0DNreQ/3LHqeTMGwTkSO2hMnU7i6AnWEkDZO6/Z7u0E4=@vger.kernel.org
X-Received: by 2002:a17:907:94c8:b0:afd:d9e4:51e7 with SMTP id
 a640c23a62f3a-afddd24e88emr11714066b.63.1755549321531; Mon, 18 Aug 2025
 13:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818181153.661431-1-thorsten.blum@linux.dev> <20250818181153.661431-3-thorsten.blum@linux.dev>
In-Reply-To: <20250818181153.661431-3-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 13:35:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7Qhz4dNnhb3t4+Bz3Fk5iKxRNwrq8u4X73tpGsg=hyA@mail.gmail.com>
X-Gm-Features: Ac12FXzfHvX5IPb4DpSB34IuOPv7zZbGkqkbrqt_GWvH8ZKvsXy6Qt9lVJvk3rU
Message-ID: <CAD=FV=W7Qhz4dNnhb3t4+Bz3Fk5iKxRNwrq8u4X73tpGsg=hyA@mail.gmail.com>
Subject: Re: [PATCH 3/4] kdb: Replace deprecated strcpy() with memcpy() in parse_grep()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Nir Lichtman <nir@lichtman.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 11:14=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> strcpy() is deprecated; use memcpy() instead.
>
> We can safely use memcpy() because we already know the length of the
> source string 'cp' and that it is guaranteed to be NUL-terminated within
> the first KDB_GREP_STRLEN bytes.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 7a4d2d4689a5..cdf91976eb7c 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -860,7 +860,7 @@ static void parse_grep(const char *str)
>                 kdb_printf("search string too long\n");
>                 return;
>         }
> -       strcpy(kdb_grep_string, cp);
> +       memcpy(kdb_grep_string, cp, len + 1);

I'm OK with this:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

A part of me would rather use strscpy() the way it's supposed to be
used to simplify the code a tiny bit... AKA (untested):

-       len =3D strlen(cp);
+       len =3D strscpy(kdb_grep_string, cp);
        if (!len)
                return;
-       if (len >=3D KDB_GREP_STRLEN) {
+       if (len < 0) {
                kdb_printf("search string too long\n");
                return;
        }
-       strcpy(kdb_grep_string, cp);

I guess this does "change" the behavior in that `kdb_grep_string` will
still be set to the empty string in the case that "len" was 0 and will
still be set to a truncated copy in the case that "len" was too big,
but based on my quick analysis of the code that should be fine.

In any case, we're getting pretty far into nitpicks here, so I'm also
OK w/ just leaving it the way you have it. ;-)

