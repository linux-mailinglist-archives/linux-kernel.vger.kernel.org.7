Return-Path: <linux-kernel+bounces-847561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCFEBCB313
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E26B24F41A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B92882D6;
	Thu,  9 Oct 2025 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L8QCOKWS"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063726A0BD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052408; cv=none; b=eUqqPNzZcVgTGU7zOkr2H+hbNIbiAFnAfkiXqNnxZZUJEQQMWKJKKefUGYzWnjg6bhRs6dQH1AiL3pb9WTt3PMyoNabESpg/SOmewSPCpnBAn7W3agfa53X5t0cRecR/A8kXsl01we6NraRktBV8hwOacm2bHsbsTl2vljL5Fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052408; c=relaxed/simple;
	bh=hVL44E2rzDrw3Z4FeZH4xTzpF9jmYsqnLCtPwRQgUhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLGofKpIQDRZdxDmiSZtzb2CYkjYeCvNIPbiQHlD0PeTy1Jsq5yyLk/xJ6tGBChj04e4PfqGn2+NI5ghB3Fc6L3fn8CZuIX0+jU5ok5/gn7dSMF7/1FVd3hG3yFJ5jUf8Zm+Z/YN8ru6lTaJ2F3Qpqrud8yuzHlpz/AvWEZm7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L8QCOKWS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso2634331a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760052404; x=1760657204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TaguQp4rjV7WTHF1XBdiOnRAL6LaynVZVmVVnMUiBb4=;
        b=L8QCOKWSHYP0/t6mI3xAPmEgOopXSGm+/Z2BQulwlXtVA0tzqFxUAlxTPJwWxc9d52
         lT4ZoW/eqt8zccwGpF8q6cjI31R3Ntz4cWKKsGZ4IwSQOyTQmAqA0etMhZQTacXRdlGJ
         tUmlT7gzR7fwScEE/3Tg43nQRrffLRQoR1Unc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760052404; x=1760657204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaguQp4rjV7WTHF1XBdiOnRAL6LaynVZVmVVnMUiBb4=;
        b=mxY/nCm40xuZHKagM1Lk+CgN6W+yhI6dmka1Nl6cWyjWXst0JGppMGrXnPEG+6ns8G
         WZcagoxW7jdQDqdR83JCGh/yGDm3FTGz1LRCKmg4A+JfB4pI3hUHE3HgXU0rS7Z3tlLM
         n8bATVTw6MdGD2rSTWGXi2LvMCxjPy6vebIt1QogKuA276JD9KYkFI+yxo6LMigZp14N
         ndHEAJhFMEKHH+W2O+W9nohyLeFo+zIBmiv/Hm/EQ4EP093v4B5Xe2Hrf2APU/kkCnSo
         UjBHG6tAdxr3AYwTZJJ4u09xzUVWe5Av/JFi+TReRsMEgeQ6+imXfcps5NyD7qVZJSum
         TFVg==
X-Forwarded-Encrypted: i=1; AJvYcCVei/JbQFC4ODwCW4C89wVnMYoRXpq1uPS6XvTJsYS74pzUKAIOkIJNFhFMy7x+lnqDJexLCU+V6kJ5fMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MBdNEUoWq4qBctGkVrQAhigk9NZmBu1BuJwuZp7rLykB91Nb
	7xYaGsCn7l9shJftq6QD5BbkL7UV6fVLgWYslXZfqOCwcOSZQmQRFlhJLXnY8cDGCSUhhpoI3rw
	Wy9DEIp0=
X-Gm-Gg: ASbGncv+4zJ7ZVwnPX9l/o8psT/LLzGeQOw5lGr/TKy1O8gMm4hJo9k13TYiFKr6Hqx
	p20xsPihK608O21btxtMSYkq+llzdBOr9Xo7FZzfBoK05d+zfS91quj1nkCd2OVX/YrxnNVsnOc
	BEKrCqShdFiOJ1zdjDenqckbbxu5z9NcpkOK/gpIFA9h0GWHUzMLTgSYfHy1JHmSxb8hbAg0CF9
	U4kab+Cq6kX3Pt4w/Gcw+3R/qfmglGEa468wqjXOWXE3TFl68hgLlGeZKWXovd/6m1ki3BkDMW+
	Q3O4lpO5AGGMekxoW/fhYjLuEpzq+lVwKm1GITom2TNeLAvsORALekwtLeweCGVcKbFcId3ZrRz
	ypjPdQpZD+2+i8l2RCDpg8SnlzvCEMXBTB7RED1Jaj3dXWglQ3oGfXva60j80l1C8dvkTEg/E6F
	g5ER0M1V2iFsscObyiHiYc
X-Google-Smtp-Source: AGHT+IEkkipvCiHVTreQbGV7Mm3sdkKi9G1oHHd3hnrROCNTQVX/VyMeOiR8BOX1IeYWnYlA8FPq/g==
X-Received: by 2002:a05:6402:274c:b0:638:7fca:adda with SMTP id 4fb4d7f45d1cf-639d5c52c6cmr9743997a12.28.1760052404124;
        Thu, 09 Oct 2025 16:26:44 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c322e91sm739920a12.45.2025.10.09.16.26.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 16:26:42 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so3003119a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:26:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgIbGIryzePCduCquoUSfWQuDf2/1E18GFooBgTb733voVOgUIYhmUq6f8QjgI9xfeH+fGpij/NYBm5uk=@vger.kernel.org
X-Received: by 2002:a05:6402:520b:b0:61c:9852:bb9f with SMTP id
 4fb4d7f45d1cf-639d5b57922mr8168547a12.1.1760052400339; Thu, 09 Oct 2025
 16:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008123014.GA20413@redhat.com> <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com> <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
 <20251009221242.GX3419281@noisy.programming.kicks-ass.net> <20251009232008.GM1386988@noisy.programming.kicks-ass.net>
In-Reply-To: <20251009232008.GM1386988@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Oct 2025 16:26:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5oLhtvxqTv9-rANYAaA+juN-kfdnbpqP2VpzzZYTTyA@mail.gmail.com>
X-Gm-Features: AS18NWABRcZU2uY3wjqz9qNJ41KqaaD3wrimeCzV3Fkuy5GXV_aPidD_Wxav3yk
Message-ID: <CAHk-=wh5oLhtvxqTv9-rANYAaA+juN-kfdnbpqP2VpzzZYTTyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 16:20, Peter Zijlstra <peterz@infradead.org> wrote:
>
> The moment I use a union gcc-14 creates the whole structure on the
> stack, while without the union it mostly manages to keep the things
> in registers without too much spilling.

Ouch.

Do the union manually like I did by just using a "unsigned long" for
both 'seq' and 'flags'.

I bet that works fine - it seemed to work well for my - admittedly
somewhat different - version.

              Linus

