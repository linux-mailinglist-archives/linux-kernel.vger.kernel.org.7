Return-Path: <linux-kernel+bounces-835418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D764BBA7092
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FAF18969F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E72DC346;
	Sun, 28 Sep 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO2Lq1Bm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02062D59EF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759063972; cv=none; b=fyiDavAmi6LKc+pBu0XDMOMS/2yRcSBm5nk4PP95IRrzF780/MLkEg21iVDgFX5CGpyS4Wa8UkyMzfdg5Ma1rKgacqSEszE2JM8ilaWQ+oRhJREQr1jvyaru0x1xniUIsfpWG4XPWw/2/f5DtjgY5c1yRmbQ0bzSW2Dcll6y8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759063972; c=relaxed/simple;
	bh=o0dRgkYPt8FVyYHCzavSccIzNEqH+Of0fl8Q4I4bCr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXW3hITyVXGpnX9G8+5JEbrcGtTL9ZjRdWrfrMMh26974tqgAa1ezgJ78N8zW6pU1gkxR/ZHyA1KUaIYUsEu3hQiz2hPwa/bBtzMckjNAIEf3+ad4rNuyfYZFpuajuB+Ax8E7k4S81qeOQaidPnNzenayY7yR/O94JryCCWplBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO2Lq1Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8D1C116C6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759063972;
	bh=o0dRgkYPt8FVyYHCzavSccIzNEqH+Of0fl8Q4I4bCr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YO2Lq1Bmn4D2kQmQ/ZhMV/e7s3RykwqoKHSKFl29euneODYZgOdI7dFwScby6+t6G
	 z2ZWxzh2+igf/+sP+EcqjKsXMsouo0KFUObzNalL957WVlHXNqQyRgeukGfpVt6CCm
	 nK4oviBoHN/88yfofREoJnMGozBcWOuAwlDY6jio3ZfSOsvUINYFIVPEchVwHz9PjD
	 vLBLDXKQwPsBCbb88CFkFG0jRV583lA2LIGnvChIbkiHn/2eYRiF72N0i2iDCbN3Nf
	 LgR47E/oIAeDXMnwKH8EitORD0K3XeSwHWiBVwSjlLGZbJ32+UydnP0PnPJqZudQni
	 SwO8yntjT/18A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3d5088259eso61777766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 05:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0Jw8DIigbblQXON290GQORiM5NLaBzhN0hK5cMcHelcKM/G1xoEsZCCOM+QSfJchYMQpVYWsF3ojiEJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUQRU9QDBmaC+PzXpfoopbdpr+x/2VYS6Uk3cm+Or/qbCCSV7
	bOUyZ6DitZGmyYIpZeqcVFozwV1vJQ/JHKTVsnCcrSz0wViuGkS930m3Z3o+Q5j5shD+pZik0tr
	0lHDrVPlUFg6LwYucoy8diaRoQ0y4J60=
X-Google-Smtp-Source: AGHT+IE0e5GdGmwcL9fJjsh+uc1S16MNhJRviy7PI0hwaXxlefeqRPOvEi//6qTK5+/VTlWMcJ2dONh2yfV3gQbs4gs=
X-Received: by 2002:a17:907:2d26:b0:b30:880:8d4f with SMTP id
 a640c23a62f3a-b34b720a94bmr1375731566b.2.1759063970754; Sun, 28 Sep 2025
 05:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923061722.24457-1-yangtiezhu@loongson.cn> <53b3b0e4c12f048d17e95111ac97b59fa35dea23.camel@xry111.site>
In-Reply-To: <53b3b0e4c12f048d17e95111ac97b59fa35dea23.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 28 Sep 2025 20:52:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Q9g3u2txE5qf7r9tb8R+-g+8bYOPQMHHe=bT+Xj_Zug@mail.gmail.com>
X-Gm-Features: AS18NWD4TDESgj-bY93W3Gb8tMnvkLiBdYaDOEsQrCu3p4ikA1M5VWoltL5_4f8
Message-ID: <CAAhV-H5Q9g3u2txE5qf7r9tb8R+-g+8bYOPQMHHe=bT+Xj_Zug@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: Add -fno-isolate-erroneous-paths-dereference
 in Makefile
To: Xi Ruoyao <xry111@xry111.site>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, WANG Rui <wangrui@loongson.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:39=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Tue, 2025-09-23 at 14:17 +0800, Tiezhu Yang wrote:
> > Currently, when compiling with GCC, there is no "break 0x7" instruction
> > for zero division due to using the option -mno-check-zero-division, but
> > the compiler still generates "break 0x0" instruction for zero division.
> >
> > Here is a simple example:
> >
> >   $ cat test.c
> >   int div(int a)
> >   {
> >         return a / 0;
> >   }
> >   $ gcc -O2 -S test.c -o test.s
> >
> > GCC generates "break 0" On LoongArch and "ud2" on x86, objtool decodes
> > "ud2" as INSN_BUG for x86, so decode "break 0" as INSN_BUG can fix the
> > objtool warnings for LoongArch, but this is not the intention.
> >
> > When decoding "break 0" as INSN_TRAP in the previous commit, the aim is
> > to handle "break 0" as a trap. The generated "break 0" for zero divisio=
n
> > by GCC is not proper, it should generate a break instruction with prope=
r
> > bug type, so add the GCC option -fno-isolate-erroneous-paths-dereferenc=
e
> > to avoid generating the unexpected "break 0" instruction for now.
>
> I just proposed GCC to use the same "documented undefined instruction"
> as Clang:
> https://gcc.gnu.org/pipermail/gcc-patches/2025-September/695981.html.
I have discussed it with Tiezhu offline, and we prefer "break 0x1".

Huacai

>
> --
> Xi Ruoyao <xry111@xry111.site>

