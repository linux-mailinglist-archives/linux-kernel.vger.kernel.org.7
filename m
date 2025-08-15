Return-Path: <linux-kernel+bounces-769965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4126B27569
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C08168B04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A87298CD5;
	Fri, 15 Aug 2025 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aJ24+SUb"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E85294A10
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223523; cv=none; b=irBIz6Gq1GPHO/j7ZQbVnQldBGwklqKx8Ryt87ORbZEAve+x1gNWppzuSlaq7T3mZjzWtfsX7hsbDQWu+PYNWjD99VN+jnY+vOWrXNbM2Ns4V1MP2M4AOO1byb69Tt1XHLbYrPoz0nsvVOEJ/l+0Ki2IIGel6A4IMZevqcafFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223523; c=relaxed/simple;
	bh=qORkR3wVopq+YUsdTjTIGDl/nDcPEBniGidcjDhySDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irwAsShk0HJWHdQECKzNyx4hPstmWadhCZwtlG7VAoJOALHiRNJsli0Vk3g4uv5dh+ul7TWToJyxn627qDEVYfHZ3URWqSLfs3klpOJuNRknm7vPs1KpXg0JBxFxEYu2U8CelRDb8fEl5G1jyqAjVD4vVVZ6unXKcST4bNwwHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aJ24+SUb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1583624b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755223516; x=1755828316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czq9Z+KET/jVXs/EzDrGbxQ/5L+K1L0esuJSVThSc10=;
        b=aJ24+SUbcLOVVK2saXNFltoEkTWFsxp5REUSk4pQGmWF6GCDnAnkS0ydcvI5gGULsC
         iojD87RDfJ8R524DHdu5k8QxHEr5gQrg3R+l/wqxSS/tQt6lDvmnEg+gNdK1Ui9zPDky
         Aa1Dh+NypKnbEwrGcka16gAL55zbhbfWrDtLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755223516; x=1755828316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czq9Z+KET/jVXs/EzDrGbxQ/5L+K1L0esuJSVThSc10=;
        b=It3yy0wL74WXk80XJpwA0NQDN8tgjUvV5jtbGu1RBM4bkqIgPoaI2MmBSjyY4eJhed
         ReQ+BT2cy/a6/xWgjkH+4JcOobV503YagNVXeBzXKinmuOcC5awLTruni5aUIcF/ETDa
         bznnidM6M92qfAzNXckEhnHLpDRrf6XGJPDBmqO4QckCj2PSTFeeTaXU3RbvLhYmuCsd
         9zO9tZ/QuymqrwOBneJNUH1RnYsDcQ8T/KYNf1ijXDx2qGKU4+8lDlMLCosWJp8ylH93
         /oIY9wCoaqLOIMFonNLwTIVDH4HPonuDHgM3bXwol9lFs+3MV6fIyApntcz/1bYbI9F4
         yJuA==
X-Forwarded-Encrypted: i=1; AJvYcCWe0TG0+PgC9oc/gInN7A4tWBOd2mKaK19j7DcB4lWLSKxaFc5An+IivQv1RzzFDJDSlzkL/Z/Vw2cu/ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0mZ0rZilkq9/9bYsP4qvlEhNwxTAnqg1BCF/4MXhqWKydeB3
	Esvi5mKRC9gDIUCD2Ri69e/12DvQngkF2paju7AEz43AOUROrrJbX94Af8yQoEm7CuOdqfF2yub
	NrU8=
X-Gm-Gg: ASbGnctXjS88MInjDTzQHaJ1gIOMEFwAUh9FL9DGQxXb7Ju7uanhofROrgucnX51WfH
	oW3hO/AoU1RV+GgYauvkMqReZ/kX/oKEUz8DEY+9dh7QjU+qQDDUWcHuhAL04AY1tzN7GqN7147
	QYq69apC83RgmNkbuuE52OmQzNWk1Ey6yjDYe07JEqoSVXyh+1MytinICEaJ7DkJMIPeKc4Akj9
	FNNicuHks/ePPCPclsIpRW5ThOOoXA//uKT6AlO6BqoR8ZSr/cazaVOZUH/pnmWuBwDJwiEQCDz
	jlOe+WyskKxrhs3xGQ3MsPaDpoVAmjFH0pmAuonEgN+qNX4lapC6XqjnSVPHnHmLD8JyD8rauOG
	TKfZ0w4kS4oJQltdEKNh3GEwHF26VBJCRP60zoaeSiiW4oMF1qUe2Rf5Q4N2V2IfBIA==
X-Google-Smtp-Source: AGHT+IHdMDVQ+z63KgBx6hQxmO5QlcJG2cmn+kwerjcC7fSBxR3CRL8Q11bQeMdUYK+B85yyc0I2LQ==
X-Received: by 2002:a05:6a00:4649:b0:76b:3ae7:37a8 with SMTP id d2e1a72fcca58-76e324a87edmr6599455b3a.7.1755223516463;
        Thu, 14 Aug 2025 19:05:16 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558cdabsm35390b3a.94.2025.08.14.19.05.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 19:05:15 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b471aaa085aso732538a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:05:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNja/cR/Wx6LKEAiWfC18jew4Dlq6qp50ISEK2n52+IZP9ceLgV1dV76TpV8HLqnBG+zvYQ5LSL2lgPGc=@vger.kernel.org
X-Received: by 2002:a17:902:d50b:b0:242:b138:8110 with SMTP id
 d9443c01a7336-244598679d7mr74419825ad.24.1755223514160; Thu, 14 Aug 2025
 19:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
In-Reply-To: <20250814220130.281187-2-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Aug 2025 19:05:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com>
X-Gm-Features: Ac12FXyz0N6lYfN0uKFzb67JigmIfAX8HYG9O649Ly1mqN7DuMLlThvvJiVlxQE
Message-ID: <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and memcpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Nir Lichtman <nir@lichtman.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 14, 2025 at 3:02=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() and memcpy() instead and remove
> several manual NUL-terminations.
>
> In parse_grep(), we can safely use memcpy() because we already know the
> length of the source string 'cp' and that it is guaranteed to be
> NUL-terminated within the first KDB_GREP_STRLEN bytes.
>
> No functional changes intended.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v3:
> - Extract the strscpy() changes into a separate patch and focus on
>   replacing the deprecated strcpy() calls as suggested by Greg
> - Link to v2: https://lore.kernel.org/lkml/20250814163237.229544-2-thorst=
en.blum@linux.dev/
>
> Changes in v2:
> - Use memcpy() instead of strscpy() in parse_grep() as suggested by Greg
> - Compile-tested only so far
> - Link to v1: https://lore.kernel.org/lkml/20250814120338.219585-2-thorst=
en.blum@linux.dev/
> ---
>  kernel/debug/kdb/kdb_main.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 7a4d2d4689a5..40de0ece724b 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -727,14 +727,10 @@ static int kdb_defcmd(int argc, const char **argv)
>         mp->help =3D kdb_strdup(argv[3], GFP_KDB);
>         if (!mp->help)
>                 goto fail_help;
> -       if (mp->usage[0] =3D=3D '"') {
> -               strcpy(mp->usage, argv[2]+1);
> -               mp->usage[strlen(mp->usage)-1] =3D '\0';
> -       }
> -       if (mp->help[0] =3D=3D '"') {
> -               strcpy(mp->help, argv[3]+1);
> -               mp->help[strlen(mp->help)-1] =3D '\0';
> -       }
> +       if (mp->usage[0] =3D=3D '"')
> +               strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
> +       if (mp->help[0] =3D=3D '"')
> +               strscpy(mp->help, argv[3] + 1, strlen(argv[3]) - 1);

Let's think about some test cases...

Old code:
mp->usage =3D kdb_strdup(argv[2], GFP_KDB);
if (mp->usage[0] =3D=3D '"') {
  strcpy(mp->usage, argv[2]+1);
  mp->usage[strlen(mp->usage)-1] =3D '\0';
}

New code:
mp->usage =3D kdb_strdup(argv[2], GFP_KDB);
if (mp->usage[0] =3D=3D '"')
  strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);

Example string: argv[2] =3D "\"xyz\""

Old:
  mp->usage =3D strdup("\"xyz\"")
  mp->usage becomes "xyz\""
  mp->usage becomes "xyz"

New:
  mp->usage =3D strdup("\"xyz\"")
  mp->usage becomes "xyz\""
  mp->usage doesn't change (!)

To match old behavior, I think you'd need "strlen(argv[2]) - 2", right?

I'll also note that with a different (malformed) example string, the
old code would have also been broken.


Example string: argv[2] =3D "\""

Old:
  mp->usage =3D strdup("\"")
  mp->usage becomes ""
  mp->usage[-1] =3D '\0';  // BAD!


That should probably be fixed too. Luckily this command can't be run
by a user in kdb and it just runs stuff at init time...

Maybe a right fix is something like this (untested). You could even
put it in a small helper so it doesn't need to be duplicated for both
help and usage:

len =3D strlen(to_copy);
if (to_copy[0] =3D=3D '"') {
  to_copy++;
  len--;
  if (to_copy[len-1] =3D=3D '"')
    len--;
}
dest =3D kstrndup(to_copy, len, GFP_KDB);

...of course, that stops using kdb_strdup(). I don't really see why
that exists? The comments make no sense...



-Doug

