Return-Path: <linux-kernel+bounces-736678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2CFB0A061
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DA3561A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36FC29C338;
	Fri, 18 Jul 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSNXEwZr"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7144299957
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752833415; cv=none; b=fKP8m1ly5hxTYuJbB2KPh4xOd5shwAngeGZ3jqJYcY6Roax/y7WtEfQCbsT7j84cfxaae8OGau6fYGA0+fVjDM3H+AR+5WpxI5HLW+0v83T5UaHh+d831aCBxDjFjS4CWBbMKHqkWw/EvO21zMblT+7uvhkMdK49qYanXqsGuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752833415; c=relaxed/simple;
	bh=jEPCqIH2/jSbx3GcTZK0ApZM+EPW/w4+Xq1YOqzaECc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUsCwwUT6AK0fIrEdHdSWdy8yukf/iUWJc9583gy9IAzM+PC8pnrxciIw7DhKKqiJe3iqHGRYRuSogDWwB/QQJV6+Iau9b5FqKrs0n++y+FP3XQRzPV4BOdCpzbosAn4RB2CDXeZtmi0fLAiLDQTVADLh+Mb51fqWhFpsHhLvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSNXEwZr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-700c7e4c048so31529096d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752833413; x=1753438213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEPCqIH2/jSbx3GcTZK0ApZM+EPW/w4+Xq1YOqzaECc=;
        b=xSNXEwZrXdfhAOsfw8vD+KQeAE1DlLLWZg8XmgIdaUT3pbQq5/ejEIICi6Nxcgw4Es
         jssYio3u7Uj3x8uQ31q39k+kpwz65fljgpgzPDL1qnH8WStG54mzUEfK4rZyQr9BiC8v
         Wy85NoJcxs3OGq4k7+AQo28vbdRz+tZK+pzT8TU8CjCe4SRnY9/G82DXX+nCvbT6T9Mp
         /RRaRkAphX2E40tZFQMPECQaRXT/63AEFNsSYCzuIcN3nEGIKdmL/aSYwvF79mlmmNYH
         58S7t90/tiQokGvlcXRcIGTmzWh7S+cRZsPWfvWoy+pdVnatS0B5pprj+8W1Frjsk+iT
         /U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752833413; x=1753438213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEPCqIH2/jSbx3GcTZK0ApZM+EPW/w4+Xq1YOqzaECc=;
        b=jSEJIOse2B8AqsRbcWlKOCmrcAjCMNDGlbZMciqbLaI73qt2nr5yjTfzXtSJsjn5Qo
         +/KS+x1rYPe4bXcDadHo6BkQegu6CuWxuXM0YS0c368N6q9cl5aQOMbW08+pDPp7ipqC
         iMXczgCq245w/8q0l0O2DaYrPV3UNBQsTf8JMy36wQBckurosB3fDDuQ0Js88If/9CR1
         R1ieuhloFnGx+JRC+ccLUxc2ppF6O7macUlCrdgOMDvw4p9WzFotE/8a1OYJBKnh+OH0
         wwXqUEaecD2gyCXrSL9Cad/ADvlr2Qct1JhMHRYm++j3ph/hmg9PgfFzDMkINNeoHOpy
         qADQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPbn9hj+VACNhvhI1T8mlmo89M3tzAp4tFczQpOWxoBhUKTi9FP5MrYbK6po/jmTErUW/Pzr9iZduzKUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRuYU7Uu1VaUtSPzy9swh6qo+2lG5Zk84LE+OY78PUc2oNN7iC
	R/2U8VaS1uXP9GdFpy7jHRFT3J40QI8aymoI2o96w3XVVuFBpArFNvf8mVWKZ8ABG0+zxjUwBXr
	NNsvu+KolGItxyeCJuI3LTDgRP4rS7V2TOh4eUAv3
X-Gm-Gg: ASbGncvHgdHUtnJtUs37v+wcjJJq3Dxtpk3zwM0Myx4RV7yOaVY1C9cxVp/WCauUZxP
	dCMCYPBCl1jp+rpDMefG2e+s38YMlwr4wlxdIIzebA6Of6GYuJAyx4WrXCUUxb+Vp+fMx7uwyYG
	8BKqOgwURU5cM3A/0L/VMUbg1a4sF3ZL3w9BJdydXP5Fep719heW2hv1b507gd1Yg66B+1AQ9i4
	YjMbUL4P0Ssz7VDD7MATEdYdbxEYJVcB/jVturzKqVJO5I=
X-Google-Smtp-Source: AGHT+IG/wYxOJUxanaQ6g0B5XOVA0zS5Iwdf94oep4+xLX5zyj4bePYdHJMZ1gAUmHRfiZKt8dy1F7Mfinw3/h2KSLU=
X-Received: by 2002:a05:6214:5192:b0:704:95c6:f5f1 with SMTP id
 6a1803df08f44-7051a15125fmr34835966d6.34.1752833412173; Fri, 18 Jul 2025
 03:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <746aed.1562c.1981cd4e43c.Coremail.baishuoran@hrbeu.edu.cn>
In-Reply-To: <746aed.1562c.1981cd4e43c.Coremail.baishuoran@hrbeu.edu.cn>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 18 Jul 2025 12:09:33 +0200
X-Gm-Features: Ac12FXwsHM_uuBa1qVrE5Gm7fmdma5LXAF-jfsts2wnYsvJPRzKuXDI3yQVqq9k
Message-ID: <CAG_fn=V+3kgtcvv5J9FZ+jf12SDVhcdwxnada=b=UuXbu+2v6Q@mail.gmail.com>
Subject: Re: KASAN: out-of-bounds in __asan_memcpy
To: =?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 11:19=E2=80=AFAM =E7=99=BD=E7=83=81=E5=86=89 <baish=
uoran@hrbeu.edu.cn> wrote:
>
> Dear Maintainers,
>

Hi Shuoran,

Your colleague Kun Hu reported a use-after free with the same stack
trace in May: https://lkml.org/lkml/2025/5/21/611
At that time I pointed out that this bug is already well known to
syzkaller, and there is little value in reporting it again.
Note that the out-of-bounds report is also known to syzkaller:
https://syzkaller.appspot.com/bug?extid=3Daa6df9d3b383bf5f047f

Is there any particular reason to report the same bug over and over again?

> When using our customized Syzkaller to fuzz the latest Linux kernel, the =
following crash was triggered.

Unfortunately the fact that your customized syzkaller instance found a
known bug doesn't indicate that any of your customizations work.

>
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream
> Output: https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/KASAN%3A=
%20out-of-bounds%20in%20__asan_memcpy/11_report.txt

Both this report and the stack trace below lack the file:line
information, which usually urges people to close the email.
Please refer to
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel=
_bugs.md
for some suggestions on how to give the users more information.

> The error occurs around line 105 of the function, possibly during the sec=
ond kasan_check_range call, which checks the target address dest: it may be=
 due to dest + len exceeding the allocated memory boundary, dest pointing t=
o freed memory (use-after-free), or the len parameter being too large, caus=
ing the target address range to exceed the valid area.

This is clearly an LLM-generated description, and a poor one. There
can be potential for LLMs helping people to understand bug reports,
but when working on a prototype you'd better check every text that you
send out.

> We have reproduced this issue several times on 6.14 again.

There is no point to reproduce bugs on 6.14 as long as it is
reproducible upstream.
If it is not, the best thing you can do is probably to find out which
commit fixed it, and notify the maintainers that the commit needs to
be backported.

>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev=
/746aed.1562c.1981cd4e43c.Coremail.baishuoran%40hrbeu.edu.cn.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

