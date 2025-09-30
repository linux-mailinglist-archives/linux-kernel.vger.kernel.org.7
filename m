Return-Path: <linux-kernel+bounces-837741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D3BAD14E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3321D163D75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398C269CE1;
	Tue, 30 Sep 2025 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRG+gCcX"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351551DFD8B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239282; cv=none; b=eZF0ZpEwgFw8RUudrEIIABnFeUMp19NdMaXAHO4cQrwB88G+X3EJwz3N47kWfFmkxRYcYASyk7FdV5XytJUS2QL8i8S4ze0QVvQr8arjbD5zw3fSy0qpBGGAGIiF5kbYG7T5MR0LxnTNlW/yR11KzGvvNfn5FxUL4dtfOw0E+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239282; c=relaxed/simple;
	bh=QYA9ZS3nTBF31+lC8H1HhwMWJOz7p0DGAI957bXrWdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwpAmBjA2C5aZUYteKYzqutCBrwtFaoaBwraYsio2n2qzzAAUZhTUW5wZGRAhvyO6TifKnUfl072GyCcOwhEhdrEXRy6bxHaFexquUPIJCGIybgGbl7Rr5/DlEZN0LNO2T05N2RBflWbSlIiXdOGXq+56+T9FEzc7gonBRLCUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRG+gCcX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eeafd4882so239975ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759239280; x=1759844080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZQOSklwaJbj9QMf0lihBQFKqqaQfGKCx5cuxtJa5tc=;
        b=RRG+gCcX87TLkYmq5M1xZ7yHQILaJdy4kVnfrRj5J0vEtGhYqbbMyqicdetUnsa3Bf
         7FriTkM0eIh1kwA0xXbFNHoVb+5PKSNsqeXNY13qSkISJ1agtLx6SIh+8ZaC9/WThOYf
         rK250joDrnvTQiHXBtyxzBj/emireZoXqWgA6wM2K5/TVycCzaVSweopDgsM16de/GH6
         fFDntL4dU4+60imvjqQH6MN3PSF3KCiaLORvlpsjoCDMEJx7jmmfakShdAjxfwNivF0z
         nzUmjnukYmHB/T+NViiTPGZ/pq2jkGNXmyUkqPQakF4oFLjCdxWarl5IJf1W+klduvhm
         RLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759239280; x=1759844080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZQOSklwaJbj9QMf0lihBQFKqqaQfGKCx5cuxtJa5tc=;
        b=nt3Halpekp3QJnQ6Tv/lkKCZWMpMTFkaJrSFjBCaVywWruHCAgybUMeiTLXbzqdfjP
         eO39LcXhCboG46Dv5FHaPlc537svb/RsnqkYTUaYmH9BUZ3UJt4WwW89jxvhlQTZoVMV
         Ca7ueidsn1wukHCS+dlsc6mCbwT1ib1zhyitezhixIkd/3+Pw8gGvUKT1APCvkNIpLhl
         jEmSkLy0nwHK1SjZMGLON2y9do/WZD0daT04SYbrALKvY5obbpWOziQMNZf8ZmHJAOq+
         9xNX9mVpqPCKrNV5IcGnMJeeq3j4xeQHM8RTxYQCqgP+1VOuYTxZ+WQPTN32IxQ3nsJ1
         0EzA==
X-Forwarded-Encrypted: i=1; AJvYcCVWMM44sXJUhZZ2hzfo9ysKy1ZPoQZgLTx2ochFBdE+ze2i0qV6geyd8EOI3896aG1qRN6LxYB4O8VbKfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr13qdKWhi27jyaJSZVnvVhIpDXsmOikP8QW+lDluSjebFAKpC
	aTyv4NquxjVEfcCmKkx4lakBfi4FfAYdUpJ7H8lLZIS6Jp977FvFm/QqQK0Y23ZVHqwdT6Hf2dV
	VYG2qVnSh7iSOxfo0gC3P0Q01mp5utVL15+bRPzif
X-Gm-Gg: ASbGncuAwiHj8MjJcHYmEzkmysC+726oUEyxzEx29qko4VncRZEHwP4bkL+vw86LfQO
	iGeIV6LuVb6eujRr8UJ0M32QOpcbTvvzL/1PVV98B3R06UtDF+4fsEJzNt2Ud++pPjDMlrWea5K
	oEiDx2moN0TXZXEqHlSm4a0q8rmj9ZAgrqIDZoVCjo+1AewIq7lm+HT9kd+3uN6wsUUcELn8m6f
	+ccyNV7zzR535EiFNhBq8l10mkNZ0J655ryqRx3ORjgmWopZyisFqzOD2EVd1x32mjg4oRgnyRL
	UA0=
X-Google-Smtp-Source: AGHT+IHqisIbtiuNfwe6E2XyhxwiOfA4N7QX7pdJVONS1CfRxUb90g8yf5fvfGlC46BM8AA58DwsRsPF5r6X0yHekQI=
X-Received: by 2002:a17:903:2f08:b0:274:506d:7fea with SMTP id
 d9443c01a7336-28e641723demr3683925ad.5.1759239280084; Tue, 30 Sep 2025
 06:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI1PR02MB39525F61113D96E3671BFA1F9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
In-Reply-To: <VI1PR02MB39525F61113D96E3671BFA1F9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 06:34:28 -0700
X-Gm-Features: AS18NWBDNfMrvaXr5ucR3ZJBWu_057l2ITsOvsDbp7Wm-ryZHvd39gE4bNj8rcE
Message-ID: <CAP-5=fV+hfVLcmfPR-CKo7_ZB+AT7JpwV8rVVUAb7rmJNL705g@mail.gmail.com>
Subject: Re: inux-6.17/tools/perf/util/lzma.c:123: Strange return value ?
To: David Binderman <dcb314@hotmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:19=E2=80=AFAM David Binderman <dcb314@hotmail.com=
> wrote:
>
> Hello there,
>
> Static analyser cppcheck says:
>
> linux-6.17/tools/perf/util/lzma.c:123:3: style: Non-boolean value returne=
d from function returning bool [returnNonBoolInBooleanFunction]
>
> Source code is
>
> bool lzma_is_compressed(const char *input)
> {
>     int fd =3D open(input, O_RDONLY);
>     const uint8_t magic[6] =3D { 0xFD, '7', 'z', 'X', 'Z', 0x00 };
>     char buf[6] =3D { 0 };
>     ssize_t rc;
>
>     if (fd < 0)
>         return -1;
>
> Suggest return either true or false.
>
> Also, there is a duplicate of this problem at file linux-6.17/tools/perf/=
util/zlib.c
> line 91.

Thanks, a fix was already committed to the next branch:
https://lore.kernel.org/lkml/20250822162506.316844-3-ysk@kzalloc.com/
and the fixes tags should mean it isn't long before it is backported
to the stable branches.

Ian

> Regards
>
> David Binderman
>
>

