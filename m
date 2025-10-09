Return-Path: <linux-kernel+bounces-847044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44950BC9BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 014D134BC35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098E1DE2BF;
	Thu,  9 Oct 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QchALc0U"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4C34CDD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023092; cv=none; b=kqejOFz+mBYkF2q/cgAtdzlUGeIVu3NE6rWV0GzPxaHpO86CI+qJAuS47jtHmaU++Af9ELVe5PedObU9OQcYE8vjZj+svO000VkjQ83qk5y331urWzp8YlG5AE73LacmwxRIeQIEQpMMoSdwoJ6LqydelhNYBLu1IvPubq/NZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023092; c=relaxed/simple;
	bh=2OdZCuvMPhyb/oX+g/qQuxgXRvbsQA7OE8rAsab4a9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=am3+8DrUsYygDlvtJDhBBjWpVmXXR8sRg2pGcgS8/JQ5+XuTeZBqM4WAttLQzFxtwwdIcd6LM08f3h8fPBfca2WJQtGDKNgaKbJ12eDaAQSpVyTQeYdqV413Bpk1jSuT9RSJVt/s0itJFH62DguIir2vhiP5RVn5D4IGGOYyCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QchALc0U; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso680969f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760023087; x=1760627887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OdZCuvMPhyb/oX+g/qQuxgXRvbsQA7OE8rAsab4a9o=;
        b=QchALc0UupidtcvXks1cDQ0qMA/LiKjiUT1/XnC6sALCfjESIJNyJm+VYmDglFw1ML
         5ZG1GQZO6IdSlYLvHMaXhrgMnviyO9QtVI4mmaKx+JpqACwb55/EVudawSO20yIeiNan
         TUzv6lg70xxLGrVxI5EdmMGnzLdZfIMTn9N1KTRLF3lUamOJjrVPm143ob2Os/o8uyPe
         ty6V5HOlheh8P9S0BSvQqgHU3qDRJMxsj+OUhcXlAQYEJK2nh4q/0o30MUNoafmBpT9N
         2SxWCZYYffwv1kZ+QD/1znoghHUfr8ekUL1wJuMI4ptmkKiB7KwjYGGO+K2l96RDXN7L
         1aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023087; x=1760627887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OdZCuvMPhyb/oX+g/qQuxgXRvbsQA7OE8rAsab4a9o=;
        b=kZ23SFDvFQKfSV5O7a6g7X6t1culi/rO4LrfhSzbVbJd4lzzQXqKUgnpgb6DDqqmn1
         IiYZeFa24900fCJSoI4S171vd7jUcXfx3JQA6oEkNkmFg4G9VCH9fxWf91H/dwMo/uRk
         USEcuLK8/T9gnu0cTWGi9jHqQi5h85crl6vOpawkaS2XJE5S9uMReg1ZjSud4Q3pFfTk
         S0rpGbXm5prod3ERDm7tCfQyOIVOu2QD9GcCR3EyH+j2acFJLtspREDz7np5pL5WDMqd
         z3+9jMYEx1CtJ6xp1C5CkTK+yTyGd0MGE3jscQoWmZXblnDQgclaovbAP3OSUxBjpXrc
         MiHg==
X-Forwarded-Encrypted: i=1; AJvYcCVfS9Hxhrt7xHTBwdnYebGY5NeMpyEqTY0n1slvUb1xxvckBZwdE9e9dvKdwIF0kg40+NGbGW0G9JCAmlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZXT4bxTSKGs3aU1bl5ub36i2DCaBEBSAOAF5Hh+eb4PTDR3/
	Ur+YC4/7e17xyojOqKcbkHmCBf54D3voqI7QzFDCHk1jJkC4sBKe8hb3S2rnj5PiUGagNaaORcZ
	F8vD7Z5xw/hRQoYp78yiAsO4fSNSgbAs=
X-Gm-Gg: ASbGncvhJmIS9WGg2QqutxIYHV5YE1hgkoOxuHqhmoR/fZEvykNwD+8lvVHJRq6ztpO
	7gptcA0GM+W7SMxCzdaJMGfzbNHJ4uLgzNUTv6Ols2XZ/46u/vUvPHxfZDBZm6TSdDSdCCcc22E
	vZF2cPnts2CG0dLIabgEZfd7Ow8qDJTIgm9WCcfv/I4wabXTRVuVQbq6TJf52ISaTritvn5WRlQ
	8EOkcWcIdwQuT7/eoEp/bKnmaenHFQdIOpuNDa4ViRKB62Fpi+nFL6mDE17mMdS4AwMkmZAJ9I=
X-Google-Smtp-Source: AGHT+IHFIW2ZRuVj6JW+2Xc5kVTwqVxqOqN9ru2LkZbWzNc2F/DIEJsdL0gLuDd10vTbWFu9LcmuEXrfEs4ejeimT+E=
X-Received: by 2002:a05:6000:2c0c:b0:3f0:2ab8:710f with SMTP id
 ffacd0b85a97d-42666ac39afmr4150639f8f.8.1760023087351; Thu, 09 Oct 2025
 08:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759875560.git.fthain@linux-m68k.org> <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org>
 <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com> <20251009070206.GA4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251009070206.GA4067720@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 08:17:55 -0700
X-Gm-Features: AS18NWCd-roHqFuBtFB_rLNuX70SLGKwer7HfRV2M50Son7-GOgDqpYYiOdZQVU
Message-ID: <CAADnVQK1GqQKxdoM9e1Z92QK68GEjqgMnC36ooVgS1uUNiP6eg@mail.gmail.com>
Subject: Re: [RFC v3 2/5] bpf: Explicitly align bpf_res_spin_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Finn Thain <fthain@linux-m68k.org>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:02=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Oct 08, 2025 at 07:10:13PM -0700, Alexei Starovoitov wrote:
>
> > Are you saying 'int' on m68k is not 4 byte aligned by default,
> > so you have to force 4 byte align?
>
> This; m68k has u16 alignment, just to keep life interesting I suppose
> :-)

It's not "interesting". It adds burden to the rest of the kernel
for this architectural quirk.
Linus put the foot down for big-endian on arm64 and riscv.
We should do the same here.
x86 uses -mcmodel=3Dkernel for 64-bit and -mregparm=3D3 for 32-bit.
m68k can do the same.
They can adjust the compiler to make 'int' 4 byte aligned under some
compiler flag. The kernel is built standalone, so it doesn't have
to conform to native calling convention or anything else.

