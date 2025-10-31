Return-Path: <linux-kernel+bounces-879359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA072C22EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4287C34E1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26F26B77B;
	Fri, 31 Oct 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="McGKKpkq"
Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46912B93
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875692; cv=none; b=YhXG+p8DlZmmZ7rbUrqEly2T3WMSpr0AKLz1rpdGELdYjUmuqjAAQag0GY/4ZwMYsYRR/g37eoNj0YogQrdSWeFNG9jKZYYG31ajz0IBUwvg+tH7t1V/4XRlB/dM5ctBgHbQ38LbRvfxg6N2Qr702pG0oqM3fJMvw1lJzTwdS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875692; c=relaxed/simple;
	bh=EYDna7X6Q24qhLAXylBmBQN3mnh7dUClWaMNPgBXVxo=;
	h=To:Cc:Subject:Date:Message-Id:Mime-Version:In-Reply-To:References:
	 From:Content-Type; b=R+b6lKR8AJKWyUtlhHUk7dGK3KuHwMxXCuS7s5Dy9XlhVqLlaofF7ElcWDYG2mqzXplYAHvmoxTrlkP34KsxLqv5kM3sxFONXIn/pD52/RGsKkQyJQ2LdBDhi4HifGGt5fixrPfQqRzebgAZn0fALXjqUJ40r+OBl9ChbroK8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=McGKKpkq; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761875680;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Gp1o4UTplKCOgLfZkeY/qHSRQIpdLB1Hpz5bGpRY9ug=;
 b=McGKKpkqbwWzFlS/MYnPTGgrnSHwnGKDldrvMAjXv8KOvI+JZdMCEp5DcQeU8WS/3v9kse
 bOYA7GWFnAHiJqqcNMBaDNyIL9Glzak53wU9cnzmijhfb30uyS4sXavjGBpCWStV4IY3vX
 23steuH7mvtW8s2Uu8yNTnWaPUWmhepETyLBZ/R17psTfpAzreQLFQ36Gtkw1IwtHxGSgp
 jur2N+s0CNOsVDwJgTl2tk4e1K9t0LjhOH71CQCCGvu+Ty6j5OgYEXP/fHK6uPbqFZuI06
 Xu0xHITe4zEGPjMPJz651SOw5GzEgpMG+TTlrPhSRXlhOe1ZBX6Z+wQgfGS99g==
User-Agent: Mozilla Thunderbird
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, 
	"Tamir Duberstein" <tamird@gmail.com>, 
	"Daniel Gomez" <da.gomez@samsung.com>
Cc: <lossin@kernel.org>, <nathan@kernel.org>, 
	<hust-os-kernel-patches@googlegroups.com>, 
	"Dongliang Mu" <dzm91@hust.edu.cn>, 
	"Nicolas Schier" <nicolas.schier@linux.dev>, 
	"Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, 
	"Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	"Andreas Hindborg" <a.hindborg@kernel.org>, 
	"Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, 
	"Danilo Krummrich" <dakr@kernel.org>, 
	"Masahiro Yamada" <masahiroy@kernel.org>, 
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"open list" <linux-kernel@vger.kernel.org>, 
	"open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] Makefile: Remove the product of pin_init cleanly in mrporper
Date: Fri, 31 Oct 2025 09:54:36 +0800
Message-Id: <af756391-ee14-42e3-bdc5-0558e6b4fa92@openatom.club>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <CANiq72n3uB+sgkak=2JrPD4iY4pFidDe=TbvF8h2idGKCwedFQ@mail.gmail.com>
References: <9500284ff72ad4e4dc4799fa5392a7bbfdd34f3b.1761814593.git.chenmiao@openatom.club> <CANiq72n3uB+sgkak=2JrPD4iY4pFidDe=TbvF8h2idGKCwedFQ@mail.gmail.com>
Received: from [198.18.0.1] ([114.249.194.57]) by smtp.feishu.cn with ESMTPS; Fri, 31 Oct 2025 09:54:37 +0800
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+2690416de+b46a89+vger.kernel.org+chenmiao@openatom.club>
From: "Chen Miao" <chenmiao@openatom.club>
X-Original-From: Chen Miao <chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8

On 10/31/2025 1:41 AM, Miguel Ojeda wrote:
> On Thu, Oct 30, 2025 at 10:08=E2=80=AFAM chenmiao <chenmiao@openatom.club=
> wrote:
>> -                 rust/libmacros.so rust/libmacros.dylib
>> +                 rust/libmacros.so rust/libmacros.dylib rust/libpin_ini=
t_internal.so
> I think we will need the `.dylib` too, given the other one is there
> (for the macOS builds some people do -- Cc'ing Daniel and Tamir). Or
> did you avoid it for some reason?

Hum, in fact I just seen the `.so` so I ignore the `.dylib`. I think should=
=20
add the `.dylib`, I'll make revision later.

Regard,

Chen Miao

>
> Thanks!
>
> Cheers,
> Miguel

