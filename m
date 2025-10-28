Return-Path: <linux-kernel+bounces-874906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D071C176CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FFC404956
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504D30C378;
	Tue, 28 Oct 2025 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXDaDgDc"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B02D9EE2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695787; cv=none; b=UTi1hF2sDrQRL5m7UVG8l797MAYbpozeri0HjGoVB3wFzERbgwrMnxi2OkFrAWbvcaiszD28YsZynRBatZ6qG68GLXMYsrb7ruQxyJzIEhi6lTGxylTaNN8kLq39cZ7sWx1u5SYdNZWqNvI/C9pfp81H8g40t5Qa6w1CNfOnIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695787; c=relaxed/simple;
	bh=/0N9ORma9yyQz483I8PiFsWtj258v9pM/8bShwWPf8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIMkjr/3AubZnJjeeCkhydHI/H0W4edgYiwFckO53QVYxhnEAenQ/FaTbHUGmguDOAKNjTgn9D+GCLVIpg6l1ZGFNxq1RxXzrkRkmfm6bOU2752ZsO6KXcN9BVxnguZzLvaWexkzyjAwmBXSkaMTOU9JJcgT4U3rv3M6LOMkM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXDaDgDc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29292eca5dbso86399065ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761695785; x=1762300585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0N9ORma9yyQz483I8PiFsWtj258v9pM/8bShwWPf8E=;
        b=zXDaDgDcNs9/G07Umlokhtb0jQcHU8suvrh6g7yhS4HmDB2NhynErBQpbdTYqfi4xu
         VZMM9Q7Oe4W5jOFpaaTuIeUbAi5Nxfd4bZ92hKTJ9TquixmLdyl5LZ5n2uZpP1xS7YN+
         b5YUp13cQIYpwVGANsa6fzEqAfYkTKKOLlC6BjAhQn3V/mAHvfkN7jtRG4ZEvz93eqXX
         AZtwd+Fgd2PAQobu8wGBMqlWJ+I1g9QejjLX2n2noN3CNCJU+f4sz0CpxWWHMdvnbcAg
         JDKCr5zDcCBkYVyleT+0rKqdALKxukxCQkNJIOIPIfnekQRXSDmxwxYpzlHrSN+gKju3
         ZTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695785; x=1762300585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0N9ORma9yyQz483I8PiFsWtj258v9pM/8bShwWPf8E=;
        b=K2vp1uctePR4MIfGhBPB8c0Yyp6sFf0MrCglQWsMh/uyhSnFeNVz3NinwUX66f0+HZ
         H00xR1rIaSkkujlScB6XR0GkpdN4ulYfcZryxPzROb3TwDwp9vQXPzf1xenHhpD/yyC6
         HTT3rZtzT0EDHGV2kX994snIiRmcC2S2wIk5IgXBNNcs51IqYx7ZWtOTBdirWcwxGnli
         NR/qJ2pmO2LOqf+kp8ykCtPmpLMgOHm9oOV9n2y75D+iyxQpWA1XuLYlSKDXkVN/qdXI
         vCJhLkd++TNnb9Zhf1TQXjmu4LjPDUEN0vWckjHKqZivYHPRXqu5MZ3bIAuKtHXhvjd8
         kLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC/7uyGIIq5sgCBWIZ567cUXIoo5nbskg1X4UuAFfqZTNGfqTVA/TMY1xrCJonb+WesuViU/9bLdsklf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1MPVot9fL0c0+2MAOrHDEU+iD5LNTIycCfnwP6c6SQnOLwDg
	4sINr/PCJ/FjTU1I8+4D0+EKDkEqxqfsv+HKCpCLmpvW7WzUR0FICaf+1jJatDxbdLtOcvVkHAZ
	Tmm+G5AaYGRPeUd3ZH577WZxpP6YKLNkHNKKv4ye6
X-Gm-Gg: ASbGncuyXFLv8txZBeTgF59XMlMTlX8rkFcSrobg97HopiJUFlPpIBgkxpVezWo4ipT
	+sulRufmKac8Hr4d9BkduqOQrijlUZ+ZuGRBrm85cwIxrnlnfIciEIQ6jBX6M1rD1JANEQKkLrt
	l6J47Md38FHtB5VD4kYXTEiQZGpfbKCEB8V9dUwddQHieHnrQ7RamTHCEOQvTuFxwv4SuU8Wmlt
	UEK4rDRPcFcYTNQTkd+n2b83z3oanJMER7PVrRgXzUl11TsdQJIcz7otUYoQQHYsJRjlbknlTmi
	KuXZpYdtDfs+5hk=
X-Google-Smtp-Source: AGHT+IFatLYbHgumwd6jQygPW3FigVQRptY1GN8W7MZvNB10udE7xpMJ0tvoBxr9tzO+iQklpZ2J3exztSNO7TP/YHU=
X-Received: by 2002:a17:903:1ca:b0:290:d0fb:55c0 with SMTP id
 d9443c01a7336-294deee2019mr10424485ad.43.1761695784834; Tue, 28 Oct 2025
 16:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org> <20251028155318.2537122-1-kuniyu@google.com>
 <20251028161309.596beef2@kernel.org> <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
 <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
In-Reply-To: <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Oct 2025 16:56:13 -0700
X-Gm-Features: AWmQ_bkzayhokme2D3DiD1Ejdr_9Y9DyGrBM9QjBOQ-SDBS1bm6E5J5PPfZPDSI
Message-ID: <CAAVpQUABk5vw=Re4WqhoL0qZ3cDZ98Hg0dsN2OEWF89DzTC_EA@mail.gmail.com>
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, junjie.cao@intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, thostet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Oct 28, 2025 at 4:45=E2=80=AFPM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
> >
> > On 28.10.2025 23:13, Jakub Kicinski wrote:
> > > On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
> > >> From: Richard Cochran <richardcochran@gmail.com>
> > >> Date: Tue, 28 Oct 2025 07:09:41 -0700
> > >>> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> > >>>> Syzbot reports a NULL function pointer call on arm64 when
> > >>>> ptp_clock_gettime() falls back to ->gettime64() and the driver pro=
vides
> > >>>> neither ->gettimex64() nor ->gettime64(). This leads to a crash in=
 the
> > >>>> posix clock gettime path.
> > >>>
> > >>> Drivers must provide a gettime method.
> > >>>
> > >>> If they do not, then that is a bug in the driver.
> > >>
> > >> AFAICT, only GVE does not have gettime() and settime(), and
> > >> Tim (CCed) was preparing a fix and mostly ready to post it.
> > >
> > > cc: Vadim who promised me a PTP driver test :) Let's make sure we
> > > tickle gettime/setting in that test..
> >
> > Heh, call gettime/settime is easy. But in case of absence of these call=
backs
> > the kernel will crash - not sure we can gather good signal in such case=
?
>
> At least we could catch it on NIPA.
>
> but I suggested Tim adding WARN_ON_ONCE(!info->gettime64 &&
> !info-> getimex64) in ptp_clock_register() so that a developer can
> notice that even while loading a buggy module.

Of course this needs to check settime too.

