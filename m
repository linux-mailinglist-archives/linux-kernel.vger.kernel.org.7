Return-Path: <linux-kernel+bounces-894939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF0C4C826
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5816E4F3CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3025B2F4;
	Tue, 11 Nov 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bl1d6VmE"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAEF228CA9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851700; cv=none; b=UoSw4eC9xxg2o6SlIsdppDHOZIhsQdECVcw9Zvlcnx/rFsbl2mvrQJC3E3mlTL/kNKtJMkSD7Vm0Xw8zOY4GbbV7sY5UHu2L+gDbfQwNT5Ce92Kvge/Ht1Dv3pjSlH780eTPC0FF6T2BncyXaJOr1Gk0jlVwsRcY0gK7cpOjZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851700; c=relaxed/simple;
	bh=LQ/YVcrasx9+XZH+uzfM5+gmHZwPvR4UMJFJLgRCMmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTWLstIig1w4coD73xY41LigByRwRNRxrAB1t1/jL8/kguPdNnW1y7dncQlIUMghoIlAFBvAtLE2dL4Pkw4zOl5D6OiLziXYchNR5JMkgFMvqpdQqcJ4tUW7gYwMaR6E92DwSkHQg5u6h7rJYHlDVVAkvz+xSTgo127p2ZHMCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bl1d6VmE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b25ed53fcbso392639285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762851697; x=1763456497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3GiAAjmzQ/VspCqloDpIt+ugCtvSToogOEL/VpV0Ws=;
        b=Bl1d6VmEn9R1tjzMZVvrqqf6DUSUrdoBGOZciAEvr6DaunbsmRO2Q4flGJvTlWK6zR
         nxhEbyb76+SEsLvEJsJwi5YkE/T+9p2hvpx4jxOqdt0USIIpPpfnTl4QnuIBjFMLSD8b
         pUNsPWFoRkX6fd9KP4hPGkOrOJeqQlXK3LmfAxCW4UlQgCYA+cHuBAhcg105DNmp+3yA
         PPQj4hK4GsPMJffmnYkpq37s2Q3mjv34n8P4lcEiVi6hhjGov7yrLoTC2B3FGuwmDU7o
         KudfRMc/26zAiG00BxD0MUFz1swyRPTGf7n7HlDce4f2I4Z9FDyRBMkW3zZJwOF1v4hn
         xyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762851697; x=1763456497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3GiAAjmzQ/VspCqloDpIt+ugCtvSToogOEL/VpV0Ws=;
        b=K47e4LGY1hKp+7l0y96GzsDOXPhWuX0Lm5XfBYTeCbFFfLCi6FDTb0CpkAqX7AatKt
         sbxhpjtvrnjQAPS5vQfmFyt1oTbQE0tryjeTlHWsqAAtKAiCWfHFQmmYO1HUs+5f/avi
         Rb0q9A/dX1wFOKovUhLWVhhYAllOXFZoodYrEDF5jSF8SMXnmrxdDxsBS/QI0AFjIreI
         vl6521y9NeFBcsJ1WSLdyu30TQmlpRnUICTIum8LLlg+bs0TyFbpCu1egkG+wQkU68Ii
         vO/U1ISZ8o7s6Hyu1dl2viEvnZtbzMwvtvF/rHVdAXp9x8hds0OduBb4mB+dy+1RQkQu
         K+8w==
X-Forwarded-Encrypted: i=1; AJvYcCVEm6ubqm7fHf7M8rfSJ7mCzvScSqkr5Ysy4oLpzB4ulGPrGVU+q8+pYFlxGiZOEG6jrn2EU3Yb1Q6Jzds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNIHzr7kiqkvGYX4wQnCgo+L3/Cbgm34UoftLOJpMMNd4nyW5
	FLsszThluMaclRxC/sNKzfgkc6LjmBvtWCzcRaaNKKgCyM8ltRl/l0r/WQBPYVNcvH1+60mrOTQ
	Ki8eJmS6rFiZAdDzuncevERIhCul1h3PNOFvGxiJL
X-Gm-Gg: ASbGncv7xMdDIVVI6Trh0a/xlsdyk3Ah2AMV6+xz4F+I3AK1Ms/j+OwpoYlTQcyz3ma
	KF1l0GtmFp1QlbPM18Dp0/Je/KRMhPlt1oxOOaQ14AXFGRc5vuky5MBseg9XXpKnmmNhK4oT2TF
	ClZImpVZdzzn7yjPNHIuGfJW20Vedd7bILdYhtrH/eKplZCLvcxnD6q5NZpGi0F3HZp/OWHKng6
	YcBmQ25Yg72IQDUsdlzemTGckA7nWZvcYKqHMZgaslfP+JKnNSpVQD8IZVWo+Yxv4WzWHfAx+Na
	6FzlzqbSS+w+SSWLYepKwAGFhYmBJ1R507AY
X-Google-Smtp-Source: AGHT+IHmbNWz4nrBYzIA6dULAnEplmbnkhIWWkrftwGIkZuDmlgOtFs93CqEkgKXIfWxtOJB7Fa7kj8HnLkgxuZShy0=
X-Received: by 2002:ad4:5f07:0:b0:880:42a7:7730 with SMTP id
 6a1803df08f44-88238731aaamr156015206d6.53.1762851696507; Tue, 11 Nov 2025
 01:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <d98f04754c3f37f153493c13966c1e02852f551d.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <d98f04754c3f37f153493c13966c1e02852f551d.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:00:59 +0100
X-Gm-Features: AWmQ_bku8cq-CFmbh2Cbwbizm47o3PsCv7pQitKRdKmveqfrADnJlpnymR3GFhA
Message-ID: <CAG_fn=WPQZ4ti3Lb+A3jSXFWLtn6291sTKJBwKBiLD2E9YbuKA@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] x86/kasan: Make software tag-based kasan available
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:11=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>

> -   ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN sh=
adow memory
> +   ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN sh=
adow memory (generic mode)
> +   fffff40000000000 |   -8    TB | fffffbffffffffff |    8 TB | KASAN sh=
adow memory (software tag-based mode)
>    __________________|____________|__________________|_________|_________=
___________________________________________________


> +   ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN sh=
adow memory (generic mode)
> +   ffeffc0000000000 |   -6    PB | fffffbffffffffff |    4 PB | KASAN sh=
adow memory (software tag-based mode)
>    __________________|____________|__________________|_________|_________=
___________________________________________________

> +       default 0xeffffc0000000000 if KASAN_SW_TAGS
>         default 0xdffffc0000000000

Please elaborate in the patch description how these values were picked.

