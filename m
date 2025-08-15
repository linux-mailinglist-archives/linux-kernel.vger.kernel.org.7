Return-Path: <linux-kernel+bounces-771035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4FFB281E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017E456120A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2542244693;
	Fri, 15 Aug 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BH8WkmDM"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F28225A24
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268379; cv=none; b=mQVSmJRc3W66dt+Y3M8mVrbdyd3Jrp2CSOsAQCMqZYuKr6y6NSxp2hdIS217SM7jgvKt4iuNE9A6nAl5MEJSvYG1kUbfXn9aTK8Xbq6rxTQrBnm9wqkls+MfMZvwadHTpdH1TSMnU8bmr9a2LcyKBcSX/BsqSq+IdxopTAFmBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268379; c=relaxed/simple;
	bh=AN2BMV6s6s+J42sKLs0G5mD6S9TR1PkBT2u/6WOkMOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE5tAKsrSTPwJ0m3o46peVEiW60bgIIq3fyTvy4ynXif336cyDGLChhJQ5uvAQF7IinKMMbot/5jc6uh5HUUlJ8xrSZRQQgB/+gWULrS6YaiJReLdWdu9tz3Y84i3BZnPiXUVv78Z0n6E+Q4DuxgyzRp0duWcLftQoUN89+FgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BH8WkmDM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47174beb13so1415650a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755268375; x=1755873175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUPDlQYeNV8xVNLPQ4s+Wppv5EkSz5BsCNrMzhAzL8c=;
        b=BH8WkmDMFVJsEf0mvkuIUaDOG978bejjNmSns5Odmd7YlQfNNdslboM2vTbgJaj8Z/
         cWG5ZhLLGG/P+nyWvpZ89r5vvd2OagS02+v35S4I6uhB43JGkw8kzQVRFLIpUL8uZ5hs
         qm4xZpp6mNMq5orh9UWovMX4+nb2i71L3YCuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268375; x=1755873175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUPDlQYeNV8xVNLPQ4s+Wppv5EkSz5BsCNrMzhAzL8c=;
        b=iWiYrQXitTGw6EWP4pfyxMgT+nzBQKdLLz2p/wHjPAVv2XX7ZneOjpSr+78oGxljWl
         1epY5AMhbDw0M24j+a0m0kfSl8Y6uEvs19azUWnKSxUGmvEgFjWkoTMyWcE4YqmO3m95
         DnDXPpFXAB67Po/l3++fULQwSxlH6TOfcJ/qXL28+9XegLp3LP2eNsiYjTolt9IaXBSe
         7OeUOh7lVmR8OmgmwBVuCVuG8PydC2pU5cL9AuVkpThL1FIs8VuSOjdq46aqzqFimZyI
         UTsyifUzpWqCYyUF1zdO7rtJKXX0vVQNV6zYQBYXIF6XvOAY3V1cEa5un+5FpfRxqJFN
         SofA==
X-Forwarded-Encrypted: i=1; AJvYcCVKR4MXn7DXmHBcsHQNFiHVPsEjbDdTHrNMYJtDNo0AWu+m/aBO6WtIalIZrBSAwp1CW8QLMk2RhewBW7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvHUG/SCEVaov2Oo7sI0ARvT3CiiURhIgP7bhyM1IVTL/PD6y
	0bAxTlZdtv90xdeVFUqx81lD8OoYJTOWESASkp4PslZQNnfhsvP5grQd9hPnPWG2lJVuMEv9aFu
	H8KE=
X-Gm-Gg: ASbGncsfKUJu/Ed97dJQYje7N0jpN+z5ORizW673rSbuBiQQ3I5W5Gt488z3qfG+P0L
	QZlxhhSulInBf/+n/bLc/jyNnlrlYg6K5jOYJZSZuJ29CMTL297+8l1RYFW3GyimjXfH2/JCpBq
	WxA2ZX1U3tS4EpkUZ2l4bAW7oas84wU0ywVBrj3Mo2SpLncg/NGk50g+q/qde+6x2Ty4Lx+KD8t
	S/4ARGYFxTCiRPjnqTAuSthZexcv/S6GpqHb5JLvGq3TvwHQ7QWFFadrwqtrErIPruDYOqRDKC4
	EaM5VNOwJQsfhIpBiIdfkeHWiJabE4a0PboGSiEetxvxrmJ0H6hh2te748KXCrl0SPD8oTTZc8Q
	ECjM/cpHaJ/7frpTw+3s5InKm57NfclLPq6/xgS70H1AeS3WudFOCi0EIEOq1OY0Ueg==
X-Google-Smtp-Source: AGHT+IEIKopMSoMa4q6uOXanZw8vX21QG2DvInBZL1Z+3yib3vjTnPfOa3IWgglG3acKiRyDTL9YYQ==
X-Received: by 2002:a17:902:d2cc:b0:243:11e3:a764 with SMTP id d9443c01a7336-2446d6eef7bmr40898305ad.12.1755268375245;
        Fri, 15 Aug 2025 07:32:55 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ea9asm15639025ad.25.2025.08.15.07.32.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 07:32:54 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457f3edd4so14827445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:32:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcoOGI1/GcM99C2NxwLQlWwC6fXcAuI8pAN9v8GEewpBRpybKuCHJEfoCKTk/darBbgXhPKQEnYxua74c=@vger.kernel.org
X-Received: by 2002:a17:903:19c7:b0:240:92cc:8fcf with SMTP id
 d9443c01a7336-2446d97a21dmr41288195ad.49.1755268373349; Fri, 15 Aug 2025
 07:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com> <0BB3AC5A-5B9B-4149-90CA-80171B8B0A48@linux.dev>
In-Reply-To: <0BB3AC5A-5B9B-4149-90CA-80171B8B0A48@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 Aug 2025 07:32:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V06iHUurHQYN07ri=2-5tHon3G2OMnT1rtZ2Qp7EAW+w@mail.gmail.com>
X-Gm-Features: Ac12FXxL2rPDKIvnBjqZEgiiOTotbJwxpdaBhPYpGXK_jpG3oTuZHDGRA0uWCfE
Message-ID: <CAD=FV=V06iHUurHQYN07ri=2-5tHon3G2OMnT1rtZ2Qp7EAW+w@mail.gmail.com>
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

On Fri, Aug 15, 2025 at 3:48=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Hi Doug,
>
> On 15. Aug 2025, at 04:05, Doug Anderson wrote:
> > Let's think about some test cases...
> >
> > Old code:
> > mp->usage =3D kdb_strdup(argv[2], GFP_KDB);
> > if (mp->usage[0] =3D=3D '"') {
> >  strcpy(mp->usage, argv[2]+1);
> >  mp->usage[strlen(mp->usage)-1] =3D '\0';
> > }
> >
> > New code:
> > mp->usage =3D kdb_strdup(argv[2], GFP_KDB);
> > if (mp->usage[0] =3D=3D '"')
> >  strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
> >
> > Example string: argv[2] =3D "\"xyz\""
> >
> > Old:
> >  mp->usage =3D strdup("\"xyz\"")
> >  mp->usage becomes "xyz\""
> >  mp->usage becomes "xyz"
> >
> > New:
> >  mp->usage =3D strdup("\"xyz\"")
> >  mp->usage becomes "xyz\""
> >  mp->usage doesn't change (!)
> >
> > To match old behavior, I think you'd need "strlen(argv[2]) - 2", right?
>
> No, it should be "strlen(argv[2]) - 1" to match the old behavior.
>
> In the new code, there are only two steps instead of three.
>
> With your example source string "\"xyz\"" in argv[2]:
>
>         strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1)
>
> evaluates to:
>
>         strscpy(mp->usage, "xyz\"", strlen("\"xyz\"") - 1)
>
> strlen("\"xyz\"") is 5, so this becomes:
>
>         strscpy(mp->usage, "xyz\"", 4)
>
> Unlike strcpy(), strscpy() copies at most 'size - 1' characters and then
> appends a NUL terminator. In the example, it copies only the first three
> bytes (xyz) and then appends a NUL terminator, effectively replacing the
> trailing quote. The result is "xyz", the same as before.

Ugh, I missed that strscpy() implicitly takes away an extra character.
So, yes, your version does appear correct in that sense. It's
definitely non-obvious and I agree with Daniel that it doesn't feel
like the right way to use strscpy().

-Doug

