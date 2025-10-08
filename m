Return-Path: <linux-kernel+bounces-845554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD36BC5599
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2C4EBC9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2789628A1F1;
	Wed,  8 Oct 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fvKjg0XJ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D328A701
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932231; cv=none; b=Bl/c+ZX6l3Ix9MouUEsg0NzcUA5geX0+qUS+MaLHVcu2mWYQQr9NVrynHV3pKiKgHkJ9J7+K3uoj32Ie2kQQC8HKORp/ZmUF66PK/Vk3kwrrSiSIF2g90OwDEz6N0F29brkuZU737FFqdH/pLlROJbYMxeQS327Fziq3DS57lQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932231; c=relaxed/simple;
	bh=zhWhAM1KwX7qt0gWVKlyCzaBnwFOpm8U3Mw/8MYT5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsMTHsYsEgAFS9NsOW32mUjnhPbJo9qTKSkWfbf0W6lI0pOVtd2t0NaIhuzQj3OV/tQf++LYeQNlAxw0cgsyhiQExFOEdjxhACKWqcjMkkkDdFRTk2avk5N0HeMZ7SMDkFfPt9tPtpJRQ6Sf67i2Ar7x9eYYkVwDJj7VVbKe8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fvKjg0XJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-639698d2a0fso801709a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759932228; x=1760537028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhWhAM1KwX7qt0gWVKlyCzaBnwFOpm8U3Mw/8MYT5dc=;
        b=fvKjg0XJ4e3d48tnftcZM9NzYdxrbSIWdSBbJl6jnJQLpgN4TtSIwvs+g+nwxyTFbq
         zueWznjRFFoxysarswKSiIpi5YbFqpHbFzm5PFkLS0ybrHHoclThRogt0LM0pLkl5YqS
         CEDNAFcJfbDFmS8HezumE3VHeZGuEILP/1XQnSVxtzs5qymzd5kxnQ9OrxL74ijU6NsB
         IkyjTM7Xc5fIghVg8JAgg2yNswUqFVbvUgfVFLnMjzVewMixP0r3I3xhhjYC7q3fSxDI
         jwOOp5krzvwY+ocFaiFmsHdw9KzZWrI6ScyCjLIkVvbQZ9jedODDdrbI3xA4cNNYB/q+
         WK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759932228; x=1760537028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhWhAM1KwX7qt0gWVKlyCzaBnwFOpm8U3Mw/8MYT5dc=;
        b=hTJlo+DAH7DasTVkv1qQFGqLbqFSw7AtVgfWH72gLWRMO4V2zq0JdEG9Se1XiQuGsq
         CP38+K0q+14uyq8paW/5x+IVXTd9OM9yX889IPefg9NPGJIojeSPEs8SRZLqe9r6RKzQ
         l5XcgHwiXV1c9SQTOMJlxpufRyFlJUgHkDDeljut7l8HVduOmB3a+DgjePehhzxQ4yDA
         6HQ44Ndd1vnUWgRiPUaCDvFJmTZ8H1xSCONmBOVLFUWmwDnX8Hpnma7LK4P/LjyGRvpI
         Z9rfrd37imZ6vVsyATxUPEncTYdXDMOQC+CW+yAfHDSQbOvhAEHvl/xCSWNTXzsvZtFw
         8e+A==
X-Forwarded-Encrypted: i=1; AJvYcCXmG0t0NghWxC2cqD2w7f8JKMizRX+bh2z3vPrKkjVLQHeSH11jvPZ9skkkrIwZ0RIqG9pwa2SgO9aCFFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8Ub52ksynm3wviJdeBX0ROJbmy7AIN1GW94YpLzb4i4Cbidp
	ucqA30Dm2jsMzY2WqsOueypQ8AefU3RQ1WklmZgGWJf3EI3pT3Yp9idX4H9o3PaaaEw=
X-Gm-Gg: ASbGncuj1vWuUQLNzQFIw88DpE66+trWDqw3ayYuB3rxFgNOmVWBkwKEppNJFROaj+v
	Q1xs+SoY6ccd2ydS/16jPQNv4yCE7eEHX5phSl8hJfx2UkCkzIyMOSFQgkw+Spnkk2ms/OJ9liP
	qCKJBvR7vpC3jd+qmysv6ucCkSgrliN6TCLcdEIgc/OcCeaWP5DLgmZn99E4hfDnDhRM6Ft6hVc
	i/31rxzUR5ENEJaektMYy6fTmUTRwWIs6nREthRpcjbW9sA12b3oL8plcFkIfv3qs2Vq4Zqw6O/
	av/TrboV5H1LSQo5UpTRvEElkAiyx+ORKtbuJKXrIddqTbk09ZGPV8GQeocvMjBKjyfDwyI6g71
	uYr/z7dLl3W0qHDAReDzkeCYCxbzQ7lDLM28pu3oe8w7Raqd9bkJXrU8Rr4aObkk6loLqhjQF0T
	8fM/yjDGXIbmlBRKP9DCaTlqBarxQ3sdGfu8oJYHpCbrkQtHBoklZ8
X-Google-Smtp-Source: AGHT+IGZOgB+E/vPh+cE53osrUHAhg0Kfx4DPtuuQYoiFkEwSOmlljThIaI8I9e5kWpogzuutUJ1nA==
X-Received: by 2002:a05:6402:2354:b0:634:c4b8:6813 with SMTP id 4fb4d7f45d1cf-639d5c593fcmr1660848a12.5.1759932227679;
        Wed, 08 Oct 2025 07:03:47 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f3cdbe93sm50945a12.24.2025.10.08.07.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 07:03:47 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:03:43 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter
 with early_param()
Message-ID: <20251008160343.146bd470@mordecai.tesarici.cz>
In-Reply-To: <9628cba6-f793-4301-8620-8de46e0c5c97@suse.com>
References: <cover.1758906115.git.ptesarik@suse.com>
	<63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
	<9628cba6-f793-4301-8620-8de46e0c5c97@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 15:50:02 +0300
Nikolay Borisov <nik.borisov@suse.com> wrote:

> On 26.09.25 =D0=B3. 21:01 =D1=87., Petr Tesarik wrote:
> > Use early_param() to get the value of the tsx=3D command line parameter.
> > Although cmdline_find_option() works fine, the option is later reported
> > as unknown and passed to user space. The latter is not a real issue, but
> > the former is confusing and makes people wonder if the tsx=3D parameter=
 had
> > any effect and double-check for typos unnecessarily.
> >=20
> > The behavior changes slightly if "tsx" is given without any argument (w=
hich
> > is invalid syntax). Prior to this patch, the kernel logged an error mes=
sage
> > and disabled TSX. With this patch, the parameter is ignored. The new
> > behavior is consistent with other parameters, e.g. "tsx_async_abort".
> >=20
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com> =20
>=20
> LGTM, also could you include some rationale why early_param vs __setup=20
> for example, or arch_param_cb (which by the way has yet to find its=20
> first user).

I'd love to, but I'm a noob myself, so I simply followed Borislav's
advice here:

https://lore.kernel.org/all/20250915143909.GAaMglDd5oRSPDDuqu@fat_crate.loc=
al/

@Borislav: Would you mind explaining your request to use early_param()?

Petr T

