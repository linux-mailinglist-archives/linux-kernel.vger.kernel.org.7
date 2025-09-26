Return-Path: <linux-kernel+bounces-834735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0CBA563F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC8A1C07BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4AD2BDC14;
	Fri, 26 Sep 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cYpos5U5"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68EB2BE655
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758929607; cv=none; b=p+rS6rSoM7ZKOQFV/HHTyhmYN+NzlqntSWTUg/EZXh3AVUtiqe1/z+U7bxiu5WbPBUtAuW8GXuG+XoXNJXd+ULtE43IffrAnf8jKEdJ4jd2Sk2ksuX+w1sFkXH0i1rSxZY4awSZZPBnMsRekHn+pF6Q2OEVwDUdU8+5BZs4fWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758929607; c=relaxed/simple;
	bh=NQC8XNXnjygLJqox0g7Xz5VWBXH+Z35TTJ2KFtxLMJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=br28ucugBFnqGDHCQYRD7z3YPQc87FwRbrY5JVAat2Qc8fQs8vp/Nh1YjlyfstEgRct9qCzwydCm9wmFB3/ItzEt410ttuoYeSZOxqU1denWBbbzwEIc0a/lQmZT4zw0nyv+As/2svg3o/z7cM51boX/+ChImLTEu/UzzCfc+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cYpos5U5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2699ef1b4e3so5360035ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758929604; x=1759534404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTw+KZvrDjb5UTFpK7FAxk2eU7ODCJYc2yTxNUcpgiw=;
        b=cYpos5U5v+7SxlNiHlQwlbMry9yxmtLOOPiakEIbAbcNTlgXKkmDdiNMl+3+YSIuJR
         iLVKbEkvUBe41NmmPEIduUku0tosrO+/Li8h/Gitm3pJgKrykWHBGs/YX/YUceZR8SiZ
         s42+gzQ/QfR8lxvmEOxoB3OUgTxF9omBSRdFquMJYTmb2arYVhO3bBz8Fb1JuyAaF/p9
         nAhhxDJUOmrkPucShxr8cV1wZJNQIoPkqu6t5LUYIEalQBTRYmpRbAesdqoqxENzOFoz
         sngXUD97ScodJFfX9fitiy12PoquukW71A/SCa8opdqyuCWBmMz0L90kyzkeTDUPfwXz
         hbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758929604; x=1759534404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTw+KZvrDjb5UTFpK7FAxk2eU7ODCJYc2yTxNUcpgiw=;
        b=Nafoj5MBYbmSwNl9SL7GkC8ayO14w8WVHZE33MJlOEneZtvnQCxfwSujgsuni2G3ud
         A/AA82OjydiT+iOsO8NC2RNucs//u5NP4hy1RXQ/s6z4v0qCTTsy9UXh4NEIOdJ03nEt
         FD6eyJdm9DdssFUG5Dfsopzcr9gkQWcUCY2gaXPiIs8jk0NxdWi32jyaTh7Fl7MvIjXP
         BPlSoA9s7kfe4QcLpdPXB/RlJbTuZgnIL4IuDJyujHiTjB31go6CZyq5+3HGzhA2mEVB
         rNxDyE2x+Pp49EIwJIourBBmzV4fSRmDBL0DTnd2Eb6CE034iV8EKR+uH4mHUHhcdgQz
         zRtA==
X-Forwarded-Encrypted: i=1; AJvYcCXSzHYKrwRFTfiD0/F4nb3I2geL9oj/ROhsIuDkoGb523BKnnl8f0EW0Qw62Zj+ipnvjM2TsIyewNtkblQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7FOz7mlBGvo8hRK/Q9AzeY/hCW5t83d9I6UymTaHBbdpQRuy
	Mr9VLxVfsNcz9Pl5c+WGl6K+DkQ1YzO6+w9TAXkGuuvmasbExc0OJ5M6hzllrJcG1yVCkZF+wz4
	NE8d1AjYgw/PG+i1AE+2y9X8+4rSvGD3aylzuKnRD6w==
X-Gm-Gg: ASbGncteYQ5u5GdsHQvPc4Pej6BT4QOlYzpaza/mPcGRlakqNeHYmz/6g7EWLWWYepD
	78JcQSlLpzV8SWCT0rA40FgxaTfZO4cxnWgbTNIqlPdv0xkVchN4EWVuIK4jhO778FpxaJSq+CO
	tZ08fQAqd16NqciN1oOZTVmKgKJhFRzlwrgAQOzEQBXJeMUxUewHe+jkHzT+/JnTpIidjs8AJd6
	2kp09jt6ZUR/VLx++Op3Oel/WfiZSzTpIgp4eR7
X-Google-Smtp-Source: AGHT+IEmwasV917F/ENXUuMXNw6qnyku7SdrL3S46yOq+ltmtsWNtQZ4LiJG30MWacaYm9zGnPUEEk+jqqdkXCd8/H0=
X-Received: by 2002:a17:903:32cf:b0:269:80e2:c5a8 with SMTP id
 d9443c01a7336-27ed4a36556mr59261245ad.7.1758929603929; Fri, 26 Sep 2025
 16:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw> <20250926065556.14250-1-409411716@gms.tku.edu.tw>
In-Reply-To: <20250926065556.14250-1-409411716@gms.tku.edu.tw>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 26 Sep 2025 16:33:12 -0700
X-Gm-Features: AS18NWDAPU1wF1fnKK0roMsQSKKSRQQvsh9BWc75x2xsf5jzdJWlHk7wuynVlkw
Message-ID: <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org, 
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, 
	jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:59=E2=80=AFPM Guan-Chun Wu <409411716@gms.tku.ed=
u.tw> wrote:
>
> From: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> Replace the use of strchr() in base64_decode() with precomputed reverse
> lookup tables for each variant. This avoids repeated string scans and
> improves performance. Use -1 in the tables to mark invalid characters.
>
> Decode:
>   64B   ~1530ns  ->  ~75ns    (~20.4x)
>   1KB  ~27726ns  -> ~1165ns   (~23.8x)
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 5 deletions(-)
>
> diff --git a/lib/base64.c b/lib/base64.c
> index 1af557785..b20fdf168 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -21,6 +21,63 @@ static const char base64_tables[][65] =3D {
>         [BASE64_IMAP] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrst=
uvwxyz0123456789+,",
>  };
>
> +static const s8 base64_rev_tables[][256] =3D {
> +       [BASE64_STD] =3D {
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1, =
 -1,  -1,  63,
> +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11, =
 12,  13,  14,
> +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37, =
 38,  39,  40,
> +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +       },
> +       [BASE64_URLSAFE] =3D {
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 62,  -1,  -1,
> +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11, =
 12,  13,  14,
> +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1, =
 -1,  -1,  63,
> +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37, =
 38,  39,  40,
> +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +       },
> +       [BASE64_IMAP] =3D {
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  63, =
 -1,  -1,  -1,
> +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11, =
 12,  13,  14,
> +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37, =
 38,  39,  40,
> +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +       },

Do we actually need 3 separate lookup tables? It looks like all 3
variants agree on the value of any characters they have in common. So
we could combine them into a single lookup table that would work for a
valid base64 string of any variant. The only downside I can see is
that base64 strings which are invalid in some variants might no longer
be rejected by base64_decode().

> +};
> +
>  /**
>   * base64_encode() - Base64-encode some binary data
>   * @src: the binary data to encode
> @@ -82,11 +139,9 @@ int base64_decode(const char *src, int srclen, u8 *ds=
t, bool padding, enum base6
>         int bits =3D 0;
>         int i;
>         u8 *bp =3D dst;
> -       const char *base64_table =3D base64_tables[variant];
> +       s8 ch;
>
>         for (i =3D 0; i < srclen; i++) {
> -               const char *p =3D strchr(base64_table, src[i]);
> -
>                 if (src[i] =3D=3D '=3D') {
>                         ac =3D (ac << 6);
>                         bits +=3D 6;
> @@ -94,9 +149,10 @@ int base64_decode(const char *src, int srclen, u8 *ds=
t, bool padding, enum base6
>                                 bits -=3D 8;
>                         continue;
>                 }
> -               if (p =3D=3D NULL || src[i] =3D=3D 0)
> +               ch =3D base64_rev_tables[variant][(u8)src[i]];
> +               if (ch =3D=3D -1)

Checking for < 0 can save an additional comparison here.

Best,
Caleb

>                         return -1;
> -               ac =3D (ac << 6) | (p - base64_table);
> +               ac =3D (ac << 6) | ch;
>                 bits +=3D 6;
>                 if (bits >=3D 8) {
>                         bits -=3D 8;
> --
> 2.34.1
>
>

