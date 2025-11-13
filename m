Return-Path: <linux-kernel+bounces-900039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F0C5975F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D7A4EDF01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7B3590BB;
	Thu, 13 Nov 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="36IUaeQx"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D02350A1C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057902; cv=none; b=A9mpadpZZIQi6E0BnwGPs/MXofpuyDbECLlieI+gORGbUyPoy+fU3gF3skJs6kBrgEMq095ATQVT31k1U1Rre5eQ0r0uYolI/fcE3YiLvkrSYY5ceUHQ26dx6J5VmdlbFO69s51oju06LuOojBI5Gi0CTRr3IMSB1Zerw6ryyI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057902; c=relaxed/simple;
	bh=f93A8f9WizXVEioHDGwq53XkWjYdfcGuJMPgZoANb4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXA6GO3L/kw9MNHbPV3NYxUh/EFYUEGLLVwdUybntiAAKuEXj6GvvMJQ5tu3aGw9VtE4W9Apeq3RiQ1PB9uvyD1GjaslK2KI2Nwin9te3gEaqgAOM9EYZhwkg4zA8Ws6PNtVvQXsbiHY1bMnKVeR0Sw5YZoFrlYp6UaGXR25Ao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=36IUaeQx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed82e82f0fso10680391cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057900; x=1763662700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QBuS22KKbiezuFoBj2dmfv64zRYES6WVPNoY+VjaJ4=;
        b=36IUaeQxb9x+hgJn4O+0r/a0pAa8ZWuIf1qdKFUV1OeAehBQcIHYaZyENRrC5RjryL
         +EaWvQcxzZYPZbNbplErH3FzNhQMJ3inz9vJizmSqlxNOzpT318EmKAI21J7YooBhe+l
         PkxLU+HkWtqVeX9A8EkX30uJZ2AdUUlW/VjceselwtvkD2lKOnMTllKHKz9eNDhLbL6U
         XEU47QHSjeBmIxI5JBraMOyvxQELLzxcz2CLD3r8zCyFaHma40xhv/Qc2f0cUVu2fHP7
         Hhi7893zLNBBhiP3ngM8wlEm1+xy9XUoCEA/pWaqigZQ0HRauTRwrCmY5Ibzs+UheGCD
         Qarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057900; x=1763662700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QBuS22KKbiezuFoBj2dmfv64zRYES6WVPNoY+VjaJ4=;
        b=xEPBRLpNTLE8pAJO+V9Yvef8uY18ulevsSP012ygCtZsIn+VkOA3lmLtr6e7pkaOMt
         lq/WMpfFW5DjKescrWw7VCA7oVWQsQfkUhkjmdm2XB472KK5TMV2WSVddRgitlTT4+k0
         7U1+/YseSZO/ta3mvml8AFD7+GLmH7JdUpbt213vljwfVb4G/0JoQz+Miq6f7hL2Ir5e
         IS6qwbWnbjGPNO3Jk0FSC9qF47rYAizGD6kOK2VmxC/TAjK8DLQJlW02PzfwwXuK5OqZ
         rgRKhiX+cJYl0GXaxeS7CgLw6pdxrF4KGqIA0xbwQPJow0XeLfxjJUhsp742jF/d9top
         deuA==
X-Forwarded-Encrypted: i=1; AJvYcCUy6tsmKjLi8pzftBhQhrv6uE/Sjcu1X2SIKj2UAq7l92016Hc7K8OZQWxGKjFQSBp49sqqsnoL+aBqwu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kt/Ic/a2E+wEdQ2cgoQmL1YQ1d7yv3LlB/vk/zxbvNQ/pN1j
	Ci4ny1Ye2zjkVBtuc0CLGQaMbhXKj1F4W/tNkmwPSifcw/EnxHkiB7LViRz9bMupd5XmhSdOlme
	Jt6Dshlrx78NThJl3izGGD4LIkzjeVnyOcTRCQm6Q
X-Gm-Gg: ASbGncsWf/92gfr6cIMZV0+3LggrC1Amavj9QCzFceemCoIBx0o65dLY8Xi5aeBqJEC
	0b6+jk/B0Rw002/wkah8btQ2ArL/B27wEHxyoqLvAoBpDMhWB6q6kC1EUyEmRIS43ffGWJyiYGC
	RLdH3Z5R59a9OLGQ6cRUepuKyGAvWESyIsHNKDWsFsC8pzKqBbScz3k9dxSpqLWQhMTUQCtmbPw
	O2gFLgbfEkI/I5mVIqKP6sniBUtJ/0Dq1tNs5ovr2dohdXQo0aSoJCGy3H7v2kLMSidMgIUG0ou
	ClvFc0I=
X-Google-Smtp-Source: AGHT+IEQb04EFItfps7wK3T9VKeqI4lb3lIvgW5wj3WpfUwF+JMSWLO5U+qF/ZS6pMqBD4ypHVy70XyD0uBVStQarWs=
X-Received: by 2002:ac8:5f4c:0:b0:4e8:9e8a:294a with SMTP id
 d75a77b69052e-4edf214edcemr8281281cf.58.1763057899577; Thu, 13 Nov 2025
 10:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113154545.594580-1-edumazet@google.com> <c6020af6-83d0-46c9-aad9-2187b7f07cbe@intel.com>
In-Reply-To: <c6020af6-83d0-46c9-aad9-2187b7f07cbe@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Nov 2025 10:18:08 -0800
X-Gm-Features: AWmQ_bm1U-Cyn1UVeB5sUpv_mHKHBP8-jEH0QzQq6Q_vk9iyjpxW3NSAMkJeXvI
Message-ID: <CANn89iJzcb_XO9oCApKYfRxsMMmg7BHukRDqWTca3ZLQ8HT0iQ@mail.gmail.com>
Subject: Re: [PATCH] x86_64: inline csum_ipv6_magic()
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:26=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 11/13/25 07:45, Eric Dumazet wrote:
> > Inline this small helper.
> >
> > This reduces register pressure, as saddr and daddr are often
> > back to back in memory.
> >
> > For instance code inlined in tcp6_gro_receive() will look like:
>
> Could you please double check what the code growth is for this across
> the tree? There are 80-ish users of csum_ipv6_magic().

Hi Dave

Sure (allyesconfig build)

Before patch:

size vmlinux
   text    data     bss     dec     hex filename
886947242 245613190 40211540 1172771972 45e71484 vmlinux

After patch:
 size vmlinux
   text    data     bss     dec     hex filename
886947242 245613190 40211540 1172771972 45e71484 vmlinux

I found this a bit surprising, so I did a regular build (our Google
production kernel default config)

Before:

size vmlinux
   text    data     bss     dec     hex filename
34812872 22177397 5685248 62675517 3bc5a3d vmlinux

After:

 size vmlinux
   text    data     bss     dec     hex filename
34812501 22177365 5685248 62675114 3bc58aa vmlinux

So it would seem the patch saves 371 bytes for this config.

>
> Or, is there a discrete, measurable performance gain from doing this?

IPv6 incoming TCP/UDP paths call this function twice per packet, which is s=
ad...
One call per TX packet.

Depending on the cpus I can see csum_ipv6_magic() using up to 0.75 %
of cpu cycles.
Then there is the cost in the callers, harder to measure...

Thank you.

