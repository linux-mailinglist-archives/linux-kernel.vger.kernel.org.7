Return-Path: <linux-kernel+bounces-842363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B12BB9964
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6371891A97
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B4C28727C;
	Sun,  5 Oct 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cdfLGUG+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65213136988
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759681250; cv=none; b=d4yuxcExWzybqbLOkn7Ez4OPDDY7waQaf8uJC1jFH2an7+iIiGxJ1W7Mo0cENpT+CYKOQunNXGGq2f1tlEVH5Yc1xuDbP+Boplg3AuZcVVP84lwSN4BvuBmiJcZ7houXPWV/w8Jy/qWsQdSO1hbbdhIsumleaFDrBAHdpPQVJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759681250; c=relaxed/simple;
	bh=eSqBwmnK0kMJBkdeVGZqUI1vKW/m7pXkhSg1DnonUt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJl+Y3j9ywGctbs5IoYRNMrz33Zq5fHJk1giDHgHFwisNozypPtA4TY7zzhv4BIN2ih167+KGTBNHD9EVU7ai17BGA7uB6p1eVAz1Y6Dtx14y3sv3KXLMGZCYZsT5aYQhzXPAoZomAHkigYAcr02D1Eh0pXLe76hqGgbBtuY7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cdfLGUG+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b48d8deaef9so547324066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759681246; x=1760286046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTqR0cSCdDhEbWfRDsABJwZsHE0nFIJ3xUu2Wtpb8zc=;
        b=cdfLGUG+vbvCyMbMTQfrXGvjOsLf1JYpSnamc/JCyIJTj7i49SonhOKva/un4BqUJH
         P85TEIGMJPx54e4U94/rZxxybHbnwPlPqpt+jkyoTdkOJDDwXe0bmeltlnr+ZUii2cnp
         Xwi2GkSCmPCoINjE6e67UqrAJhc3KqcXlbBf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759681246; x=1760286046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTqR0cSCdDhEbWfRDsABJwZsHE0nFIJ3xUu2Wtpb8zc=;
        b=X9aRTyYp3y253VA31uGECXugqetsR8cE79UsuIJpRptWL4r78bW2vYXS2gxo+OMhxN
         w8kTynn49VhqCYFWoQa0JjmoPDB5fPtMG2D6v36V46THna5On6xsi8SyUdyziagOnm9B
         jJVlyZbCeKBn/rhq8PffWfFOiRn5P9+E8CMDCD04JeyldbEIHihdg/cA4oNvsHb9Luam
         qiAbA3ViOQ0qEI19+HNbMrvhjyzU7BbyukmymRLWPXvdFepnWBoqNCVxIcijH8x2lK5v
         yS3BiUYHO6v6AQMVHHWV4DjZCfWmH0kn7YEcCvJwBiAnL7vS8HtWMoDYf9xebhfUdJcB
         6Q9g==
X-Forwarded-Encrypted: i=1; AJvYcCXh+uDYBBlvHZU0oDz6hjPKILpIoBa7Od2R6JNkNODIfVjfY+RTg5HD6RaIM8Wvy/wIuSTvwCFVWkTaoGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBBnseRB7sTJauohuD65C79YUEutaWULlYJ2jdUQpR3g9f0VX
	L8+aCkLrev/v3OxIXHHzRZnK4mH6Qu8oZ6FzdUhIWBQY11ti9fFb4hj3WncLp8USbCKMdzm1x4y
	PJpDP3lA=
X-Gm-Gg: ASbGncuMCp9R6k8Rsm9ZEe6ASQ3xvIWB1//kbqwigf+WHaLV5HPAxb4xASjCPS3n3Tl
	zxb3Q4cTlriawh/knC140rnx58S61pvydhu1AxQHYa1D6hdDoA/JqcXv+u81+EpGXrpmFsZyfJ/
	1lHL/kyCz3kyPadpVUtZu4rsY8RXfSdulf6vn8CyOdnJ95G81J+d3LC4p+nQuq9pZctIsrI7si5
	xTlmZYxLo1vmSyA0EJ9Jjy4EPRmS3KcTAPIupa8F8rtImfB54GJ7tV2a9EogyO17CTi7jyLoZCG
	2sAtsTaTWLgLMxqirZQ7xDPopBwpZVU2/AJ0BIXsMmX81VjKEqbWCS8xj8yLAes1xm4Ebr5OrK6
	Oun8yibrLiSyRU1B6cHtkNUsfMKKI2xsdrAyY/CFB7UhG8DOlnPBTGi4fJATa4nD0utAcSMonQ6
	sCkMwKygFIn9R7mFyUatOgBT+hqjPXKQc=
X-Google-Smtp-Source: AGHT+IF2XNZbAla0/BV6gwV6FBhSXqoHiakuVv/dqEWugxWocK3TTy0MBNfQ2GAWwMzlWk0R2NBfHQ==
X-Received: by 2002:a17:906:9f85:b0:b49:3ee4:d4a6 with SMTP id a640c23a62f3a-b49c19769e3mr1311857966b.18.1759681246427;
        Sun, 05 Oct 2025 09:20:46 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83e3dsm929930666b.29.2025.10.05.09.20.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 09:20:45 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso762453166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:20:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXT5OfUk6rPkCHE+LkHhucJmEtE6HOdo8cx/mqHeAv+YR6O3Io0SpZNLXcSgGQuOMy+aHOS1T9LENsput0=@vger.kernel.org
X-Received: by 2002:a17:907:6eab:b0:b0d:ee43:d762 with SMTP id
 a640c23a62f3a-b49c12809ddmr1201208566b.4.1759681245373; Sun, 05 Oct 2025
 09:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003084426.f2de6028fd74e1af4e13d190@kernel.org>
In-Reply-To: <20251003084426.f2de6028fd74e1af4e13d190@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 09:20:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6=DwTD7xT3=Zya-ytYrtS2969KtnTWRPskq5fx2Ev+g@mail.gmail.com>
X-Gm-Features: AS18NWANVjvR9DwbNNPI_6x1UfUIvzp1zWhE5qbFfnw-zTLb-Vh0P443wzf8bCQ
Message-ID: <CAHk-=wg6=DwTD7xT3=Zya-ytYrtS2969KtnTWRPskq5fx2Ev+g@mail.gmail.com>
Subject: Re: [GIT PULL] probes: Update for v6.18
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Oct 2025 at 16:44, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> - wprobe: Introduce a watchpoint probe event based on hw_breakpoint.

This doesn't even build.

  kernel/trace/trace_wprobe.c: In function =E2=80=98__register_trace_wprobe=
=E2=80=99:
  kernel/trace/trace_wprobe.c:176:20: error: cast to generic address
space pointer from disjoint =E2=80=98__seg_gs=E2=80=99 address space pointe=
r [-Werror]

and I see from the code that it has tried to brute-force it with an
ugly cast, and it still is horribly horribly wrong.

The fix for compiler errors is basically never to just add a random
cast. That will just make things worse, and in this case that
'IS_ERR()' function literally exists to find bad users like this.

I wondered why this hadn't been reported in linux-next, and the reason
appears simple: none of this has BEEN in linux-next.

So no. I'm not pulling this. This violates all the regular rules for
sending me new development, and then it doesn't even compile.

Since the pointer is a percpu pointer, the trivial fix is ato use the
per-cpu specific functions (IS_ERR_PCPU(), PTR_ERR_PCPU(), etc).

However, since this wasn't in linux-next, that's not what I'm doing.

This is not getting pulled for 6.18 AT ALL, and for 6.19 it had better
be in linux-next for a LOONG time.

           Linus

