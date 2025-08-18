Return-Path: <linux-kernel+bounces-774466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89892B2B2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4901BA2EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A21276045;
	Mon, 18 Aug 2025 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHLP25TC"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DD276048
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549755; cv=none; b=IqvvwPvttunll2wof5PKSSyu/Mt4oxZiCazf9UJYm7O/gq1iQMZE/QzLH4zjKf01hu4dH49QRcVQvCmnOPCISF38C3T4WUPRsTEQ1vFreTELeEykUdAsLj6oXntjy7DjmOKtnW3qM8AsFOYY1y25ZRU2Aez2IiOvwer6kT5syTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549755; c=relaxed/simple;
	bh=NmR2/IL5WTkW71fZow9sS8wK7G2c13V/YGNMLRRHbV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVb57qbmlECPs4h9JrrIXndp0y/jO1E5gpngx8hTS2rAakXTRwM4AZytZGjwoZWkdPBk1gC3Vmm35ZpUqS/n8Bx0Oqhb4KeWzTbL8dI0Cx9CsarZzQvg/NnqzHD8fhBMWYn7tsvlq81WDD9q5K7E3vQOSzZL7oXl6SFYSLWyBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YHLP25TC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2eb4a171so5709067b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755549750; x=1756154550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a5SHWZT5ObhjuEG18Uce/tsKkrsIEanMlhP2HGBzsE=;
        b=YHLP25TCV2wDFcvliv9QbfyCd3g4edLLBcyYys8bEsm5tABhbrB8snBB81t/8j5D7/
         8tFg8+CoHVRotCQmm/RwUExOz33ZdWNZDpe+3fpXiGjvavZDhIUeNhZaXWD63Tz1t448
         pzSbPBEQ4YwsW41n+rh0Y0oKaMMWLNgy79bSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549750; x=1756154550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a5SHWZT5ObhjuEG18Uce/tsKkrsIEanMlhP2HGBzsE=;
        b=AgBUMVj7wAX00mm1Nev/1H4xju3TBFOqXGpz1KX4HCdhjBrxS/nI9gTKRfJ0oETshi
         WsiJ2RRA1Y2gXC/QbKDa2tHowtoxjSKiJ1OAREIQI4SjhwF6HsCD/RdDsN4hR73HxT6g
         lngKeXZHijs+MvQAjanHgA8bZ7+nBKcI3LGby1vTtgB0nUhG+4k9hS8VjFhwQA7F8nQR
         yqEaZcv1BBDK+Wzy0L/foXKzndJE8DYds/0WdKcahG1rlLxzxEgoosu8TDneYLH7L35o
         3ZjujN1q9FwUTVI0w9/LEuNWM8rMVqDYW6Izj1n4GJhCsu1zItb7+/YFChcDm92g+KH7
         bqtg==
X-Forwarded-Encrypted: i=1; AJvYcCU8rkGn3LaT9LdQ44dujKpXy73TlOOT/swZHzzCXj3O3sUbwRguR925wrj46aggmlrKYOAMLTg71k0ymlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/S4zhB+vqixxdfRsc6U3ClDPnp0q+F3VV0LjS+XU2cIeFALjE
	OuOtarsF8HVE7C5UH2YNTTWAuwPR5gBk2JaJBqInrazpnpFaRU93L7XthY4ecg/mGVCnlHJ8O9D
	8OibUGtRf
X-Gm-Gg: ASbGncvxHyBu3683ggYk88vnQeoMdvHM/Ejjb+GgHq4Z7iz/DKqPKcx7bwZKMw4qIXL
	ZeUSsi5JyCCahueUTPSKPnSDkrGeyXcgHrB9YZWR0KF6qpzIgCEbpag5cvFV9gyX/TUkj5VzZSM
	UNdS32aZaDC825T/BWLyFxLk1n5w/s2C4hAeYQx+9X5EXDqqMxsbaDePC0Sj2hZAS3pYwBDvkxS
	EKHwKs/uU2EGMsN2lgKIiA8mtYcifgtrrqk6RlwTjiR4vJ/yjcTYDktfSs0PQA7VXn6/aMk5cw9
	O2/IhQDIrytWI+ZXop6dFpIqHnpW4XF7D1yvtBeAg4uIm3uspjIbGCYMigK2+dwtTfrNTMpOr7B
	JlbH9+oX83WAQkD8Q8fDHNrznTnGTwp9pJrFAQEvJ+wDeFUlOpjsbJ+8uAIit3d32LQ==
X-Google-Smtp-Source: AGHT+IEaOoi1Th7E3q6vy0kvhDFI/RI4YIR4QPxelWLAN0Sr8uML9C35iNB3ND17JEO1eY6RxDBn0g==
X-Received: by 2002:a05:6a00:1953:b0:76b:ffd1:7737 with SMTP id d2e1a72fcca58-76e44818e33mr18649286b3a.22.1755549749783;
        Mon, 18 Aug 2025 13:42:29 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f798fsm459479b3a.60.2025.08.18.13.42.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:42:28 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b471754bf05so4031686a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:42:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdGsBbERT78zc6QME4uDvyO+2kVUQRCvNm/cXrwt4i8sXy8mZ4ZjGt7bfLN9rdyT7+I5mQnry1aWw49bE=@vger.kernel.org
X-Received: by 2002:a17:903:28e:b0:243:926:b1f3 with SMTP id
 d9443c01a7336-245e030c986mr619005ad.24.1755549747360; Mon, 18 Aug 2025
 13:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818181153.661431-1-thorsten.blum@linux.dev> <20250818181153.661431-4-thorsten.blum@linux.dev>
In-Reply-To: <20250818181153.661431-4-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 13:42:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhEeZdCwL0kVmDHZF03q+Jp5iOiUvbNNoCDuBr3os9qQ@mail.gmail.com>
X-Gm-Features: Ac12FXy3Z47CKyrKqijfaotNViVGOwKbhTPJHzFwx9GEuH8Qe5j9BxC7wx8gFu8
Message-ID: <CAD=FV=UhEeZdCwL0kVmDHZF03q+Jp5iOiUvbNNoCDuBr3os9qQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kdb: Replace deprecated strcpy() with helper function
 in kdb_defcmd()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Nir Lichtman <nir@lichtman.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Heng <zhangheng@kylinos.cn>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 11:13=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> +/*
> + * kdb_strdup_dequote - same as kdb_strdup(), but trims surrounding quot=
es from
> + *                     the input string if present.
> + * Remarks:
> + *     Quotes are only removed if there is both a leading and a trailing=
 quote.
> + */
> +char *kdb_strdup_dequote(const char *str, gfp_t type)
> +{
> +       size_t len =3D strlen(str);
> +       char *s;
> +
> +       if (str[0] =3D=3D '"' && len > 1 && str[len - 1] =3D=3D '"') {
> +               /* trim both leading and trailing quotes */
> +               str++;
> +               len -=3D 2;
> +       }
> +
> +       len++; /* add space for NUL terminator */
> +
> +       s =3D kmalloc(len, type);
> +       if (!s)
> +               return NULL;
> +
> +       memcpy(s, str, len);
> +       s[len - 1] =3D '\0';

Very nitty, but technically the above memcpy() could pass "len - 1", right?

It doesn't really matter other than the wasteful copy of 1-byte, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

