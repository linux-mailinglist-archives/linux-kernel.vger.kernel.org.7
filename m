Return-Path: <linux-kernel+bounces-717996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00E4AF9BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6027F6E0214
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 21:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173523A989;
	Fri,  4 Jul 2025 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="D/W6O1m4"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465E217F56
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751664466; cv=none; b=j4wuoEPt2Pt4gL44jXlgMDKz+6Xeytoc6HnN1AbmWZv4y0bf6MFa8GKwAplYfhDVp8BiDJ9hfbJwa0qGYntIP318G7js2J1KxbQ8h8IkleFmDzZ+JZnpeubY51Lmx/3H1KcHUhawITEOjIAI/8O1qugrLf5JVz2pRgl51y0MzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751664466; c=relaxed/simple;
	bh=Kgg/RKJy8xEDDuxlWknvCpjWS7jJF/UFzea/o+2ajss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU0cRRlCFw8eQNJVLWS+7peCjMUfW31GkS2u1fC351TQukjSOssKVPmSct4BNyEyHqWF7zp/oUQIj6vciIrZsBpKCeBLVMfnX1NiltvHuQCWH0zM4XZD8k+AQIltJSAnZY0aPcmBRdLayAjQ/fhnvJlmHzb5tQ+S+TftsmzZ+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=D/W6O1m4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a44b3526e6so20381471cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jul 2025 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1751664464; x=1752269264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TQkwHrKOM7GBKYdSow9FOChuDO7+LFMsjIK09/6sn0=;
        b=D/W6O1m4kvzvw3gw+xtZJffd2vYKhKkpVRpfW2Lmj6L90jjHNte6XJt5Aalp8op7g4
         SGWgLawjO2YuhrK24QA8rlfQG2m78Fd3BgfjgQNRi7JiSV09T/8/v0AIJzGp2rx68AyX
         JwBKP+iwlhxkfHBNDVqnsqebU5vyveyi5N2PpoJ49Rb0Crwl+GLQqYmSGZzi8snZeugA
         fVgc/QP9vDhsZrkc8duwpGYKiyMN20pRBa77kiCzdbkH6QwI1m4OaDErVMdXhdIwncA2
         dPu9ifcfePujky3EhIvGkQ8Xdcye+6irLZBA1AtdqcTHe0mvmxbLvGLSv22ZYEZ2fjIs
         FqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751664464; x=1752269264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TQkwHrKOM7GBKYdSow9FOChuDO7+LFMsjIK09/6sn0=;
        b=KAhmlCWa6oDNfqswR0wmSyDHOa2mlBdG95/ba0wED1BFxJz6vrRnMIPgJbdviBCR2W
         o5XyrRUzJ4dNyVro55AyenaZCiCy2s/jY89giMvGi0Gmqen8rHIHF5ig+C4zhg85qPYd
         REySqy177d3I4Tr3/B8mTpR5I+xLnPiygnWBUQ3zUuODEM3g5OTBpqD8YeUzUXmG6hzM
         RjFQ6kwiew+DKqBblFv7L65u2UkVe14VosncY5WQ9aNwZvI6t7A3nMZ6G3PV0NEuJamB
         E3VQhvpTWoGNw0Fi2t3ygrUNmMWkZRUBqBJMXGjc74CRQG67GkrUYR2nMQCQte6GEz6t
         pfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN7ia5RfJ8HqgP+E19Ce7MuDjDUnz0Nl1fQCa1dU1jnei2iDmKoeHwc25RlrhIJO6J8rDBiV6LxIjDl/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+wVJZRHCaglQFgW5CfiEYZdtMjSTDjipNsG75iVhvfu6uDYa
	XORIxmaGtnceKsDGyQGvzvtzJoVXjAOrxbq/mSUDdUEs56fYufJdZIKOTE+0LSKHI3OE65fklUQ
	s04YfeO8PyIuZE3RoXYh0nAWdnRn9GrGLTkXlQaEebA==
X-Gm-Gg: ASbGncsntQHsrMRLLh3BKzkVeVhz79LxFrIrs8dcoVHvpVMTnJTQIZ1CDnVIEDdK2HR
	wSIzTS48xxIyhLkYddEG8/UqUwMLRopOZ2LgF+z2Bw6mUumMb7ZDGzk0DLrDq/8/7yLSz3/+gC5
	kIWh1oVlpwVY2NX9/IdNIQ8cdq9bf6GrhGfjSmh8mZoMQ=
X-Google-Smtp-Source: AGHT+IGwRxeilUXnNTdyTmvD/TxGpaex9AA5plhgd4LQeziorhQNSpF9IPdyc2W55Icnyp7w2dKKaCqhFLE3q9BjF14=
X-Received: by 2002:ac8:5ac5:0:b0:494:a283:1c4a with SMTP id
 d75a77b69052e-4a9a69609f8mr6114921cf.32.1751664463660; Fri, 04 Jul 2025
 14:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625232653.GJ369@kvack.org> <CA+CK2bAsz4Zz2_Kp8QMKxG5taY52ykhhykROd0di85ax5eeOrw@mail.gmail.com>
 <20250704173340.GL904431@ziepe.ca>
In-Reply-To: <20250704173340.GL904431@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 4 Jul 2025 17:27:06 -0400
X-Gm-Features: Ac12FXw2Yd-cXQEJ8nXkM_HsCPClfwCnN3pDQjubPyn-7sQcW8XOW2RmSJQEGm0
Message-ID: <CA+CK2bC6iUfh4Y36oTVfsbTgow+3D7V9EE=Gj5jz4hsk0JU+xQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/32] Live Update Orchestrator
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Benjamin LaHaise <bcrl@kvack.org>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 1:33=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Wed, Jun 25, 2025 at 07:44:12PM -0400, pasha.tatashin wrote:
> > On Wed, Jun 25, 2025 at 7:26=E2=80=AFPM Benjamin LaHaise <bcrl@kvack.or=
g> wrote:
> > >
> > > FYI: Every one of your emails to the list for this series was bounced=
 by
> > > all the recipients using @gmail.com email addresses.
> > >
> > >                 -ben (owner-linux-mm)
> >
> > This is extremely annoying, I will need to figure out why this is
> > happening. soleen.com uses google workspace.
>
> b4 also seems unhappy with your mail:
>
>   X [PATCH v1 1/32] kho: init new_physxa->phys_bits to fix lockdep
>     X BADSIG: DKIM/soleen-com.20230601.gappssmtp.com
>
> Though I spent a few mins trying to guess why and came up empty. The
> mail servers thought the DKIM was OK when they accepted it..
>
> ARC-Authentication-Results:i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass =
(p=3Dnone dis=3Dnone) header.from=3Dsoleen.com; spf=3Dpass smtp.mailfrom=3D=
soleen.com; dkim=3Dpass (2048-bit key) header.d=3Dsoleen-com.20230601.gapps=
smtp.com header.i=3D@soleen-com.20230601.gappssmtp.com header.b=3DVxWLPP8s;=
 arc=3Dnone smtp.client-ip=3D209.85.219.177
> Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone =
dis=3Dnone) header.from=3Dsoleen.com
> Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfro=
m=3Dsoleen.com
> Authentication-Results: smtp.subspace.kernel.org;
>         dkim=3Dpass (2048-bit key) header.d=3Dsoleen-com.20230601.gappssm=
tp.com header.i=3D@soleen-com.20230601.gappssmtp.com header.b=3D"VxWLPP8s"
> Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8259b783=
f6so264959276.3
>         for <linux-doc@vger.kernel.org>; Wed, 25 Jun 2025 16:18:45 -0700 =
(PDT)

Thank you Jason, I think I found the reason why this happened:

While DMARC itself was enabled, the Quarantine/Reject policy was set to non=
e.

I will resend this series.

Pasha

