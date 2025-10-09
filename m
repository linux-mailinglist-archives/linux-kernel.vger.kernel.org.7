Return-Path: <linux-kernel+bounces-847172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A17BCA2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 958F04FBFB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07E9221265;
	Thu,  9 Oct 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JFyn4TTi"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46721FF4D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026718; cv=none; b=QKmgcNFiZeBscNh65LNila8NAqNK01iAbcUU2M3YhY/fuuzzFeUH0ba0cxcfmTZ4bdzJkk7K0S72ckekkl6feg4F3swwg95PJYPZjdD/WnV1DtdGjCQManxVziX/93k61stiWBzHiLsdqJ06ZWU91m52BVJ4iqSuMi9DMgDjM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026718; c=relaxed/simple;
	bh=pKgW/FiDD7JXfeu5Btr1uUR8YDssLKanghWI0YPbyuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1PEFIPFZAmaxpTkrX/VR8Su8d1SRcdhFBEIXYq+Hsn12DH/glAnqJY7rHu7Eluvo6csixH61tX1uGVkm8e3bqhhZILnZrfgqrO7eM4AE1hXsc0Mi/WM6EFLgH1z9cyLEDL/ncEt8JeDR+nkc8NCMje+eOkZJIKffeWFqtixWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JFyn4TTi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so2309773a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760026714; x=1760631514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KOYPf6HtonrKnUW77oe5fBekthouM6Fck3wrNzFXE8U=;
        b=JFyn4TTilDcK1ePUXbew/QHKjEMoy68FxVkeccXkIplBOU0PCvDUVNhjQyBECiBwe4
         PzPKcy2EfiiUwY0or+Qp6dniii/e6whj/MTTybUcFkJ6X0RS2oW0tnajAqbTtn9C6udD
         H81w9HrK0ift13tUerRx7+o4GPvcxtdJjY0Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026714; x=1760631514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOYPf6HtonrKnUW77oe5fBekthouM6Fck3wrNzFXE8U=;
        b=W5/bcmLhK0wKTWr8HqkXhxDrSv1QbXDIzAO8ViXIX8Qi+mxXRQud5tJxSiYss5CWFY
         lsoNNCIQShbHNfaBCAPVYk8onD97OLnRJocrJKmU8yHT75WFuwy7Vl0Bwr9/UzLB1kHK
         GLQDuv5biv8MEmr+ojwK9p1Xjnyh9pMUYcc2HZ2hyRRSCE/PG1+9uV86vUBj8nnbtozq
         bO4TPkMn8dqZnj45RSywFrW9WT+b6gJCJTh+a8zvuSVeSMrxvz8mFk4Zm3121+4ZLf21
         Jio9iPuFr1yvuT3JiZudxcwGxP+wWP8MLXBV//bl1ngrXIEyHyYr2GF2gTYHNm9p37TG
         yaDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC89UsUcbrp5DnGZ927MsuzOWVnZTUAXt8jao2qt/Ru6mxHcWTyNMDhoLiZTRHA3WWN5pM7ewK4AU6NbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnyhJ0EQNPPlWDn+jBmTxgacMmo7Du+Dgfz3XDnIV/p7QNq/T
	nTTq3zgWAGw25BuX40Tl5z36cVquR0mifx2qVxGhtoFJ9VVovuG1Azzw/sVLoNLFPR34Y8yqz//
	hIQGd9jgQVA==
X-Gm-Gg: ASbGnculVUpnHsGYNlrGEIjPmVnEML4tLrlb+MC1Sz6syjwhUSCAp8XXxIoIy2xip+n
	u+e7jwWz/8J6OYuBOuab9mS2dDurWJXJbZEkQcVGtrF/Fg9HovmR8VfenUY5VV8hXb/zxuejLCf
	+Egems6VYlOMFMdGBYAU71REIezqtmGwcHDXHKpXoTDI/qL8RNe8OT1mIP06ljxVZBd9TZws5do
	Sg7GewvSJqGugJS4Bxv1zDJ1V4TvDM8V28IwJDFVTvQST3CXqrmiyl0jROadXlisvnh6hLNYMlb
	8syNqUn5A+p4wXA/lhfJm2h8H8EAZr5mNOVOknDlWYc3pxJH1bC8EQRbXBq2SjrD/BdSDGVPwmH
	1481d2395+y6U6aFwS1BhLpgUWxyO49MHjrWH+xxLkxXrixcR8WX1RXjue+eCh4CB3x7bXsUW6n
	vgF0RyV/0yP7Vlh9Hu0bE+8PLWThTmdPQ=
X-Google-Smtp-Source: AGHT+IGaeppmzilYkUoBg2Kr95EvCx1St+z5Psl+3IrczpCe3jll4zfsv6JkiE7z9lqJ9LQwJ1j7Cw==
X-Received: by 2002:a05:6402:358a:b0:639:f254:beb9 with SMTP id 4fb4d7f45d1cf-639f254c819mr4720725a12.10.1760026713653;
        Thu, 09 Oct 2025 09:18:33 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235e9ebsm123475a12.4.2025.10.09.09.18.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 09:18:28 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so2224057a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:18:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQzaZU2UnE+zh5QEbW5qdL+kJb6LeB+/tuY44tINGBqmisxbnJrM6ber0Vdz4RCmAX5H4Mo/wzIS3N8Ig=@vger.kernel.org
X-Received: by 2002:aa7:d859:0:b0:62f:386d:aedb with SMTP id
 4fb4d7f45d1cf-639d5c75ccbmr5576340a12.36.1760026706599; Thu, 09 Oct 2025
 09:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008123014.GA20413@redhat.com> <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com> <20251009143748.GA2704@redhat.com>
In-Reply-To: <20251009143748.GA2704@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Oct 2025 09:18:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXae3b7nOf8bEHtzRcQAZGQFe2EbvXDxg_V42h8AraHA@mail.gmail.com>
X-Gm-Features: AS18NWABhXRa-CmcFEoBLnUydmKXC30kwKDwbfWDW7-wCRyddybProe-Wda_JkI
Message-ID: <CAHk-=wjXae3b7nOf8bEHtzRcQAZGQFe2EbvXDxg_V42h8AraHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 07:39, Oleg Nesterov <oleg@redhat.com> wrote:
>
> But do we really want to unroll the loop? This code should be optimized
> for the likely case when the lockless pass succeeds.

Dropping the unroll magic certainly makes the patch more palatable,
and maybe it doesn't matter that much.

It really was mainly me going "this should be easy for the compiler to
see the flow statically", and the need to keep two state variables
annoyed me.

But I guess many of the users are complicated enough that you actually
don't want to have two copies of the inner body. If they weren't
complicated, they'd just use the simpler

   do { } while (read_seqcount_retry(...));

model.

So you are right, I was probably chasing that optimal code generation
for no real reason.

            Linus

