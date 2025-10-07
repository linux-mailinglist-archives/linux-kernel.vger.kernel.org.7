Return-Path: <linux-kernel+bounces-844402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD80BC1D39
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E4AA4E7AB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C972E228D;
	Tue,  7 Oct 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z7O4r/VX"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226402DF121
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849051; cv=none; b=cuv6k9w3ZSvB5c6L/xIcomWcnZU+uv5Ri1+iLDMqwGbqmqPCm5AFl3OpRejQXhgQwaiv6OPV8QAcPNXyStcvLzzPchd4OSSNeDf9+ZKMIF/EpJeum3fawRl3p7wLI4EylCdnh7009orD3xdgmA5aXvGkvq7HQp86gSdT9ZaC74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849051; c=relaxed/simple;
	bh=ZDE1e+KCG32IH950eEsaCHN21GX1TQqVJE/SIf5AWIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VT9dZlB7iMZq9P4/rPNKxlivKkKm7Rw60jFVEnOO1jF7xuqhMFuFyzeBcREmY65tx+Kxip+RSzff5p1oEjsZZrr4QRmYAZKgKFCRp9yxSDwTbVKkHUDgcDfEkENFcsSKSepvsBqO1ZtMozpEPwwjxzFNQ6+Qk3xvlMxGHe+Gzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z7O4r/VX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-333abc4394dso1125324a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1759849047; x=1760453847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVQVTdLz3JhO8K7IozwO/U1pe3WO/g/3ZfFjqGmOQ1A=;
        b=Z7O4r/VXFoU9WNb2Wt5gnftYkldkEB27u2WrouCO5vAEoIxnI5NvXs43yOMiZe9rY9
         4S3oPvnQZNHl9VZ8Tr87grDDZCS2hR4ghQahmJUF4r8FdFLyiWWb+vDOsmeTlpWOCIlz
         +LqszBwAe25uw+ZkQeBaarsJ6loi5YBiT2c8zQBJJP1hi8nnzrCIMjnVyLJBacNCmwQ9
         mTSUm1OmIJ+NeXhoKgI3BzNDdOZr7mqFKgvyM8UxIUcdJv6TF79/2JOxeixQMR6sMf1h
         XVOvvvBenM6hbgcM2Ohmszk+Xa6gcIuDOup0OLm0UOPIpVWEf4ohOifvhtW9t3W7bk5r
         +Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759849047; x=1760453847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVQVTdLz3JhO8K7IozwO/U1pe3WO/g/3ZfFjqGmOQ1A=;
        b=vqQSvU30HN8imsNha1tKzGuvVZ52aZ+2WosQWlftT5fUC3XsM+xbSOkEWvRWvJibzc
         8th2Y/KF9p1PIw8/Nx1XzY93I1Zrm5BqES+yC80ft+76lWdr+nWPa8xxhFWS+RZGy/9M
         Zh6IbXNGrlg+UoJYEL7LyrrycsthB8nP2SwhFRUeTk1JOveE32aix7ovQW79j5MBKDj5
         L3iU233bm+OI0RDl+KB0qd62C5J7PYqto0YOM2Y0NskN/drNlCt9As1PJ0w/gAo5J54Y
         P/49KL4iaq6vH/lneSKdkV1qOoDBmW2J5UbAMduhogXTpydJKU945vYhUnDIzcRBr6/f
         mxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM3qe0ztf6QYhg7sQ5ubhk5nZIsEGh38qbW54guUGEgnVh+QYWvXcZufOfRWQRF8Gzu9D57llThR0Wsg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7vkxaupZGN+oMDZdyPp6/COcYGuWz2juNG/Po+V/4fSRHeiM
	oEBgw3q7qTVh8lw+0Mn4ugskgZor/774N/YY+TMzKlLTzNsyoJXqk+GgbOXyk9QBDB//NnsBH8y
	OQUJbyH6rxQ+6dSdVPjsoTZr/1Ty4rDfCVnqUuIptzw==
X-Gm-Gg: ASbGncsHBK+5TwEx/knUwS27SsXyMD8H+HmwAEBpzAhf8Oof9engyNe6d6TOllbC5tp
	YGOcNg4wI3OcWlOeFLCouiTCtChM8BSofWb/dAJmnJqfvra4590IR6CAlUNzoRVDZ1VL+VwsluC
	f5XPnhRFbV0L4t1xjGPN/Z3ugPjARH9o1o2MJfO+65oD3/JrNqXopzfdz8q1O1stBd3FCRPOTak
	7rC2Puqz+dyxnB+OUQoDMIlzBCfD+PC7WFKL01RHjaAzojYdkHT5er1XREr2AbtdB0gB8+YPQ==
X-Google-Smtp-Source: AGHT+IEYhWaq4b8LjsaTKtHCBOMQ6ujrAp6CxxaKz4k/uq34nEHmzVPTH9dqGuv8aLeFBZEOCRgXi4zPqI749dfPXeg=
X-Received: by 2002:a17:90b:33c9:b0:330:944e:4814 with SMTP id
 98e67ed59e1d1-339c27b9669mr10779782a91.5.1759849047310; Tue, 07 Oct 2025
 07:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065556.14250-1-409411716@gms.tku.edu.tw> <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
 <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T> <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
 <20251005181803.0ba6aee4@pumpkin> <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
In-Reply-To: <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Oct 2025 07:57:16 -0700
X-Gm-Features: AS18NWDbyq1DczXc9CALQ9HeJCtJn-7fS8_x4v7YcPrMpuNbLjPHQxFY5TzoCBQ
Message-ID: <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: David Laight <david.laight.linux@gmail.com>, akpm@linux-foundation.org, 
	axboe@kernel.dk, ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de, 
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org, 
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 1:28=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.edu.=
tw> wrote:
>
> On Sun, Oct 05, 2025 at 06:18:03PM +0100, David Laight wrote:
> > On Wed, 1 Oct 2025 09:20:27 -0700
> > Caleb Sander Mateos <csander@purestorage.com> wrote:
> >
> > > On Wed, Oct 1, 2025 at 3:18=E2=80=AFAM Guan-Chun Wu <409411716@gms.tk=
u.edu.tw> wrote:
> > > >
> > > > On Fri, Sep 26, 2025 at 04:33:12PM -0700, Caleb Sander Mateos wrote=
:
> > > > > On Thu, Sep 25, 2025 at 11:59=E2=80=AFPM Guan-Chun Wu <409411716@=
gms.tku.edu.tw> wrote:
> > > > > >
> > > > > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > >
> > > > > > Replace the use of strchr() in base64_decode() with precomputed=
 reverse
> > > > > > lookup tables for each variant. This avoids repeated string sca=
ns and
> > > > > > improves performance. Use -1 in the tables to mark invalid char=
acters.
> > > > > >
> > > > > > Decode:
> > > > > >   64B   ~1530ns  ->  ~75ns    (~20.4x)
> > > > > >   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> > > > > >
> > > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > > ---
> > > > > >  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
> > > > > >  1 file changed, 61 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > > > index 1af557785..b20fdf168 100644
> > > > > > --- a/lib/base64.c
> > > > > > +++ b/lib/base64.c
> > > > > > @@ -21,6 +21,63 @@ static const char base64_tables[][65] =3D {
> > > > > >         [BASE64_IMAP] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghij=
klmnopqrstuvwxyz0123456789+,",
> > > > > >  };
> > > > > >
> > > > > > +static const s8 base64_rev_tables[][256] =3D {
> > > > > > +       [BASE64_STD] =3D {
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 62,  -1,  -1,  -1,  63,
> > > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9, =
 10,  11,  12,  13,  14,
> > > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35, =
 36,  37,  38,  39,  40,
> > > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +       },
> > > > > > +       [BASE64_URLSAFE] =3D {
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  62,  -1,  -1,
> > > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9, =
 10,  11,  12,  13,  14,
> > > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25, =
 -1,  -1,  -1,  -1,  63,
> > > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35, =
 36,  37,  38,  39,  40,
> > > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +       },
> > > > > > +       [BASE64_IMAP] =3D {
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 62,  63,  -1,  -1,  -1,
> > > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9, =
 10,  11,  12,  13,  14,
> > > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35, =
 36,  37,  38,  39,  40,
> > > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +       },
> > > > >
> > > > > Do we actually need 3 separate lookup tables? It looks like all 3
> > > > > variants agree on the value of any characters they have in common=
. So
> > > > > we could combine them into a single lookup table that would work =
for a
> > > > > valid base64 string of any variant. The only downside I can see i=
s
> > > > > that base64 strings which are invalid in some variants might no l=
onger
> > > > > be rejected by base64_decode().
> > > > >
> > > >
> > > > In addition to the approach David mentioned, maybe we can use a com=
mon
> > > > lookup table for A=E2=80=93Z, a=E2=80=93z, and 0=E2=80=939, and the=
n handle the variant-specific
> > > > symbols with a switch.
> >
> > It is certainly possible to generate the initialiser from a #define to
> > avoid all the replicated source.
> >
> > > >
> > > > For example:
> > > >
> > > > static const s8 base64_rev_common[256] =3D {
> > > >     [0 ... 255] =3D -1,
> > > >     ['A'] =3D 0, ['B'] =3D 1, /* ... */, ['Z'] =3D 25,
> >
> > If you assume ASCII (I doubt Linux runs on any EBCDIC systems) you
> > can assume the characters are sequential and miss ['B'] =3D etc to
> > reduce the the line lengths.
> > (Even EBCDIC has A-I J-R S-Z and 0-9 as adjacent values)
> >
> > > >     ['a'] =3D 26, /* ... */, ['z'] =3D 51,
> > > >     ['0'] =3D 52, /* ... */, ['9'] =3D 61,
> > > > };
> > > >
> > > > static inline int base64_rev_lookup(u8 c, enum base64_variant varia=
nt) {
> > > >     s8 v =3D base64_rev_common[c];
> > > >     if (v !=3D -1)
> > > >         return v;
> > > >
> > > >     switch (variant) {
> > > >     case BASE64_STD:
> > > >         if (c =3D=3D '+') return 62;
> > > >         if (c =3D=3D '/') return 63;
> > > >         break;
> > > >     case BASE64_IMAP:
> > > >         if (c =3D=3D '+') return 62;
> > > >         if (c =3D=3D ',') return 63;
> > > >         break;
> > > >     case BASE64_URLSAFE:
> > > >         if (c =3D=3D '-') return 62;
> > > >         if (c =3D=3D '_') return 63;
> > > >         break;
> > > >     }
> > > >     return -1;
> > > > }
> > > >
> > > > What do you think?
> > >
> > > That adds several branches in the hot loop, at least 2 of which are
> > > unpredictable for valid base64 input of a given variant (v !=3D -1 as
> > > well as the first c check in the applicable switch case).
> >
> > I'd certainly pass in the character values for 62 and 63 so they are
> > determined well outside the inner loop.
> > Possibly even going as far as #define BASE64_STD ('+' << 8 | '/').
> >
> > > That seems like it would hurt performance, no?
> > > I think having 3 separate tables
> > > would be preferable to making the hot loop more branchy.
> >
> > Depends how common you think 62 and 63 are...
> > I guess 63 comes from 0xff bytes - so might be quite common.
> >
> > One thing I think you've missed is that the decode converts 4 character=
s
> > into 24 bits - which then need carefully writing into the output buffer=
.
> > There is no need to check whether each character is valid.
> > After:
> >       val_24 =3D t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18=
;
> > val_24 will be negative iff one of b[0..3] is invalid.
> > So you only need to check every 4 input characters, not for every one.
> > That does require separate tables.
> > (Or have a decoder that always maps "+-" to 62 and "/,_" to 63.)
> >
> >       David
> >
>
> Thanks for the feedback.
> For the next revision, we=E2=80=99ll use a single lookup table that maps =
both +
> and - to 62, and /, _, and , to 63.
> Does this approach sound good to everyone?

Sounds fine to me. Perhaps worth pointing out that the decision to
accept any base64 variant in the decoder would likely be permanent,
since users may come to depend on it. But I don't see any issue with
it as long as all the base64 variants agree on the values of their
common symbols.

Best,
Caleb

