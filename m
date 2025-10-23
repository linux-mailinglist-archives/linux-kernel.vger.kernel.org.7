Return-Path: <linux-kernel+bounces-866583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A776AC0026B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5053A4D69
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CEA2FB620;
	Thu, 23 Oct 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XKzMvU22"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2C2FB61F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210779; cv=none; b=TKXGdktailKCz09kV/Da/Brtq0Ty7bQ3jesL7yagZhtM4NCDEEEkC7V+tZTAcDYPR6G/2z/sfcUT742EWid+ePaMQw4UtFNqfh9M19F796fFakzxtGQIf1SiG9eYLmD7UwhXrBhabNGceU1Z9fMYNz2z2bPd53rJdeHwDBGr6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210779; c=relaxed/simple;
	bh=DHSH0ZRwbF+Mt3B51jKncFl1eWtO/SCCeKsTW87x4PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5l5ZuwsB02X3DVJIJn5aUb4BDRE7rMJAbk7FL6VsDojMqN8HtSqJ5ZHA9uxgXa68fMC85762s/m0YzylOL7E4i/a5SwXuoC8y/O+LMwdMktqlut5naA4Ml9QBQF+0feMszAbqWEYjP+RRkuMnD43suVilEn8fIQsoGQz5LP/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XKzMvU22; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471bde1e8f8so2952395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761210775; x=1761815575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4YBI/EqtZ3J00PcXn67Kjmze22CptNisRya2F4tlEU=;
        b=XKzMvU225IgeRtr/12RC96B8Os8Z0LnRTaAG4qAkSaT533/u4liba5eUgioIxmqIPO
         VRspO6+/wolg3wCWqHpVDELja5FCRHYQQmZDiT8pgKpi1d5ehh8p5btfysFQDQ0Tmk8P
         lMnNqpiKc7g9zYcq+PXV5mfdT6F+wY0PquYVAH7hVTgivHxGxcTHYRtZ6KvrZDNXv2UQ
         HwfhOCNGsgAo8Rh4PeW+2+O2MvwWPEs5JeaYHn8TscsGxiFISTy6fXpCElUQsep6r7Ws
         DtKTVxnYLWJh2dyqh6mle1c1+0CON8usyf554fjg3zh52AaYkEGKNT7PTs5lgugG8S20
         oI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210775; x=1761815575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4YBI/EqtZ3J00PcXn67Kjmze22CptNisRya2F4tlEU=;
        b=fQ/sBNmOHlD+LXC7pKkwzthhUM1dam5IJnOusfaTexcP365Xkske+ucGLBD+UJU/+6
         2tWxEakt8iGhQjcSp8UsI3RaRtPVr8YiNnduOtieQJvjREgAZOzM/XI2EQr7Q8yhh6XU
         YFi4T02bUVKgCybyZtky/x0CdDqW7RwmOmkzqe3S98sD29N+ykXPmMTd+bRLxfTYuRST
         1CoeEEWS63tR5792TRpoON0eg6/IhLvjShmdf8URrUy6cfUULCJj6tfeZ+lzP33hwYgi
         /RB9N9gyy8BCyEBK9ivRuiWvHW3aJDqHUxSdooB0CSUU8QnSJ6aL+B/VlPPXwXZ6NrHN
         rp+g==
X-Gm-Message-State: AOJu0Yx8l0lJYAf9ZgoTV0uct5rQlrD54zSij5N6Tvkp5WRuo8iOU8ZW
	E0hRIAfx/7ETZKVTGDOpYibVYZP0krkGH243imEzDxS2q2v/ox/z13ICEvpURbJoGxs=
X-Gm-Gg: ASbGncuYPuJCkr8//1GgQ7U8TyoqvWBf9Az7Te6jCVYwD/ST02OSB1OV4oDK+KZYaIK
	dnjMkWnGvtYIAMvabmDqISRnq3jZF/LNd3m2xXESgU2h4rykoVKNEwiU7V8WnG28TMmA8K+WKoH
	xwHT/2+nesoKJVYfN99qS5WKx4HD70zDvqKm6HneV5QoaFch0N7ZMRGENe8fopVEhRd5S6qfZkY
	s4sxkjAqGbQWvQN0zR3f5aWsDty4PLEaa3EAFDUGmwVk9wizIa+wDne6obYbfqMCTAZH9tMph20
	rTkGUw2p9nlFXz5yu21NrJXeLyucxK8jbB2aPSOfhYb8QqHJlAhlpMz/DfgyaxdnZJmnwm4ujOn
	toMnzdAof4MORHlS81/hpuV25aCWX6myJ3unmLbKH1t6Dg4qLuJzwpOoYP9vEtguobPC38nArMR
	qke+OshPs6oUuQUVCyig==
X-Google-Smtp-Source: AGHT+IG89jvdKxuLQ4STXYciOZm7sh9+DpSTyapJXa8dA1Qq3pMQ8PymDcsITN5Fq2o+BBm71Hcnuw==
X-Received: by 2002:a05:600c:3512:b0:471:12c2:201f with SMTP id 5b1f17b1804b1-471179134f0mr202907375e9.32.1761210774820;
        Thu, 23 Oct 2025 02:12:54 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342946sm85046525e9.10.2025.10.23.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:12:54 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:12:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>, joe.lawrence@redhat.com,
	Naveen N Rao <naveen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, jpoimboe@kernel.org
Subject: Re: [next-20251022] Kernel Boot Warnings at
 arch/powerpc/kernel/trace/ftrace.c:234
Message-ID: <aPnxlEkV1rL0hWOm@pathway.suse.cz>
References: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
 <cdf7c458-b28f-4657-8708-1f820369baa6@linux.ibm.com>
 <aPjW3P2AU7L71S-s@pathway.suse.cz>
 <ee9aaeec-23bf-42ac-8a8d-4ba899cfdd13@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9aaeec-23bf-42ac-8a8d-4ba899cfdd13@linux.ibm.com>

On Wed 2025-10-22 19:56:45, Venkat Rao Bagalkote wrote:
> 
> On 22/10/25 6:36 pm, Petr Mladek wrote:
> > On Wed 2025-10-22 17:36:18, Venkat Rao Bagalkote wrote:
> > > On 22/10/25 1:52 pm, Venkat Rao Bagalkote wrote:
> > > > Greetings!!!
> > > > 
> > > > 
> > > > IBM CI has reported kernel boot warnings with next-20251022 kernel. I
> > > > see there are couple of warnings hit and eventually system boots to
> > > > emergency mode.
> > > > 
> > > > 
> > > With the identified first bad commit, is casuing the kernel to boot to
> > > emergency mode. I reverted the bad commit and built the kernel, then kernel
> > > is booting fine, but with boot warnings.
> > I guess that it is the same problem which should get fixed by the patch
> > https://lore.kernel.org/r/e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org
> 
> 
> Thank you Petr, for pointing to the fix patch. It fixes the kernel booting
> to emergency mode.

Great.

> But boot warning still persists.

I looks like another problem. I would expect that it is in
the ftrace code, either in the generic or arch-specific part.

I would suggest to add people proposed by:

$> ./scripts/get_maintainer.pl arch/powerpc/kernel/trace/ftrace.c
Steven Rostedt <rostedt@goodmis.org> (maintainer:FUNCTION HOOKS (FTRACE))
Masami Hiramatsu <mhiramat@kernel.org> (maintainer:FUNCTION HOOKS (FTRACE))
Mark Rutland <mark.rutland@arm.com> (reviewer:FUNCTION HOOKS (FTRACE))
Madhavan Srinivasan <maddy@linux.ibm.com> (maintainer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Michael Ellerman <mpe@ellerman.id.au> (maintainer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Nicholas Piggin <npiggin@gmail.com> (reviewer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Christophe Leroy <christophe.leroy@csgroup.eu> (reviewer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
linux-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
linux-trace-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT))
LINUX FOR POWERPC (32-BIT AND 64-BIT) status: Supported

into the original message with the backtrace. Or maybe, send it
once again and mention just the WARNING. The boot to the emergency
mode has been already solved...

Best Regards,
Petr

