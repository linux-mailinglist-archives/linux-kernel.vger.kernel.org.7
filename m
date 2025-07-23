Return-Path: <linux-kernel+bounces-743179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A28B0FB80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BDD3BAE82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930D22A1D4;
	Wed, 23 Jul 2025 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G55YCzyg"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B951F8728
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302735; cv=none; b=S6bdyqxIp/DQOjfa+uz9o53WlVgKlvP2vgW/DEyacpXR3qtpnT4ysr4EQpkruA9X300a67p7ZnfSlmTqXIr7lZk2ySWP7VpooXwFWHNaQQbSBQa3Lp1KwOytisod7Yq2u7cOocG3L982eUmetD/sRqlTfJVciOa4iH+IAPeYR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302735; c=relaxed/simple;
	bh=GTXQscJU4LPgrl6bU/T+prkMwqEg/02bZaCUdUkEXXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQsL7bB6/pYup2sn4MOk8pj4nxJSZILOugxUqu4ID3ipH2fJhd26e4TSjTYYzE5RUUuoFbRw4UERKftwrUad0t7dFl5rVsNYFHFSU7H5EDKXbiWmf9sWBw6SQAVEfS462evy4h3F78cbnIlhVQzoEKjBJbVg9++MhBU5XqJcuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G55YCzyg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so549233a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753302731; x=1753907531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tW3QBWuerrQdiuDXr9GW4Ls+mtrfwnWITMUravp8ZU=;
        b=G55YCzygxpJN9/ThQnEuTYlUGwf8cJ189wmbpY0iTcAeKQw2CbMPr6sjbBzSBNMuAU
         FtPHX8Js2wiHiv5Khqr2UsfflnqT0R+nvTGVWXusk3Vdtxrhmk6MbGWtFyZzhfvbavz/
         YpBLrrhVmDeIFjB+87PgsHWFnaWoYMnzsR5jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302731; x=1753907531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tW3QBWuerrQdiuDXr9GW4Ls+mtrfwnWITMUravp8ZU=;
        b=oGLXwF4wWmCeGdhb5G0ps1A2METEJ8+1MRFHJGALp/ogGNbwbgpIwQsDWxu1udMKlx
         cYpfhG2EzFu4mf7HwEA867xMXzc7QDd164nmyFPSpTUtipBO6ApR8+YTZ/Q4wGrwgwh4
         QLyWKQxi9HTT4dgn+0wcpNf6LKWIzRKNrrhLbpv+3H6lHP0q5t6eAkRi/jolV4+1Wila
         frzJbsMgjfpW/yT3JEc4MV6w8DPtHbakiOEYUq6wITz2q0RKt2ggLH9iRIKNgzovq7XK
         ArVGV/7sfJ0GQ80BsQAhUBavzrbyl+ak24aSWDLhejxc0bOcz7T/IBVbHajJ3YGsVrXE
         lqjA==
X-Gm-Message-State: AOJu0YzBJQOaBaDYPysTMmB8x7qysEYuTEqAvzSDpyWpvVsRjFvHKtDD
	mADeHOmCkBj7f2CRUUyPYnYZi5+1cPCEgYWFsuhoX5XJLu0hci59R1OgvFZr8jdglxGMd8N2rBR
	K1kobS4s=
X-Gm-Gg: ASbGnctwQGaCqM9EQL5rfVcRouwp8wNjc1FflDWlOwfvz6GWYjR0WkyNLEHfE8TZQRx
	UjgRW2PD/EPUpComuJjctCGtoFj+EQT4lG1+ay10HGlX0+MsZtXMNC4kxoZuf3Gk4UR7tKUute3
	gWH0WJlKSMpMJtzgxhDU/v76i3z8aP45rAvZOEiqTNYxvwS+m7Uo1DT1ORHCdB7Lg1ni7Gx88RX
	/lAahZavV9qzpavF1aM1JJyCsVormbTuSwyWhoCS9RDrjxfFRYUPV1Xm+o2wGAjf6GXECFVfe3t
	v8a/BDok1oC3yz5DR9JeRZx+NGfdNnw+6CltjDpIBc7WyaR7qFAn+Fefre5pmTFcLVQByWmSxtx
	bENjEN/gjLilYOMvdIiJyz09PqAk2El3KutANy7GsVErqTFxzEHeWxGm5fBLghbpCENs1+erv
X-Google-Smtp-Source: AGHT+IEyhkFy1M8M4U4JnbxXVP1CGWu1E6BPdv6P+hZ3A7NV1bYE9+64CKJcXCRhZNqqP2f4cwpANQ==
X-Received: by 2002:a05:6402:2808:b0:606:a99d:91d4 with SMTP id 4fb4d7f45d1cf-6149b59d9f2mr4228034a12.27.1753302731406;
        Wed, 23 Jul 2025 13:32:11 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c903fd62sm8990172a12.41.2025.07.23.13.32.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 13:32:09 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so549157a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:09 -0700 (PDT)
X-Received: by 2002:a05:6402:2682:b0:60c:4667:b29e with SMTP id
 4fb4d7f45d1cf-6149b5ada7fmr3885377a12.31.1753302729207; Wed, 23 Jul 2025
 13:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723194141.617125835@kernel.org> <20250723194211.768813368@kernel.org>
In-Reply-To: <20250723194211.768813368@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Jul 2025 13:31:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbAruRX=xFVGevggtRpHNYyMVwgNYYJgYg5hMuU6ASGQ@mail.gmail.com>
X-Gm-Features: Ac12FXwxyPrv8gGTCI226Aa0lB-U1g53Om9xi3Ol5z0sTqQ_za5i5iEvuIY4KFk
Message-ID: <CAHk-=wgbAruRX=xFVGevggtRpHNYyMVwgNYYJgYg5hMuU6ASGQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] tracing: sorttable: Add a tracepoint verification
 check at build time
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Jul 2025 at 12:42, Steven Rostedt <rostedt@kernel.org> wrote:
>
>  kernel/trace/Kconfig              |  19 +++

Annoying "one step forward, two steps back" change.

You literally sent a "remove one pointless Kconfig option" patch
within ten minutes of sending out this "add two pointless Kconfig
options" patch.

Because as long as it's a build-time thing, please just fix the
problems it points out, and it should have no real cost to being
enabled.

We don't want to ask people questions that don't matter.

Of course, because you *used* to check this at run-time, you put the
new "__tracepoint_check" table in a section that is actually loaded
into memory, and it appears to be still there.

Just put it in the discard section, the same way we have (for example)
the export_symbols table that we also check at build-time without
actually ever making it part of the kernel.

                 Linus

