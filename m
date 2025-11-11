Return-Path: <linux-kernel+bounces-896135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF057C4FBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71A4434D2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDE325721;
	Tue, 11 Nov 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kjZeZPDL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFEE324B0B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893785; cv=none; b=dSRWr+n4292ueeqypkKxTbaAQY+i5E9KlVQAm8i+2KiECAxg1yf5b972UvdMrWHGyBsOWcjb0T2IQrSDDBYEY7jfOZD5/utLN6kaQujfOhJXJmKQIvSwk2bb9xueZUabAiYm8IbFBIM3W3I3Qx9w1QoZoLxIsM8W9tYNMwHr/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893785; c=relaxed/simple;
	bh=afDorv6qTDLWr/6bW/pgEAxgseeZod61+oQ5b0c9gVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/uKXlHLNhexyzP6w0ylEbGPtklg1gaa7t0KvntkMEQ+LPGxApfj/7tO4vLhkRfb2QvKq1eIVZ8T5KsNtZo/9HJQItuIuVEuZPJOjIjviFTQ44J8x4ysCL/X+lhQG7BWzMRKWUSM9zo5bpZy29Wl+xF7PzA+r29puaHENdeXNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=kjZeZPDL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so124792a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762893782; x=1763498582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPkvNL6hC2GnwSkZWOxF7zaqo/2CIWUpjYpRKjrtIiQ=;
        b=kjZeZPDLc9huzMRycBoiJ6E38hShgDY2fnCGfqXIwYNmofiMbcYAc/p8YxqWDjqTNA
         JaVeuBTJXnQzgo0YKMVLWywCgKwDxmJNWSSarlRE1d1WbZ3aU9hllAoTBFhNV7xhe230
         R+qeLbnKd53WUVG1UB1CgfZ5XbEbeeqQ4hIuPdmM1JIwL9I2ui0FZmKWLJzAKQRtoNCQ
         iaCHWnvChovqOlyX/2R6gKTSQYE73+inIluJPzo2XTiwCJUd7a4HBbiAhOZmfWtX3hKy
         Qv40wzz2avQHoJB4kKPktx4Gnn6lsWffBPm7wI1LjgAEJuSgniTJP3QF+cbdER95ylKx
         h0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893782; x=1763498582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPkvNL6hC2GnwSkZWOxF7zaqo/2CIWUpjYpRKjrtIiQ=;
        b=BRBvTp9dJ11XXS72vgIW7qMjk8Z/xRxSrobr/nYxycI+pv+by5unJBkT6X2h27ZcFZ
         JeuGDDLY3aFwh05rbkYHKqBGrBzOd1gt1yFnoCfTDfWfYKGVXHeYXq5MhWDRZh04Siv2
         mfGxJenfl7OQOXOea9OSM0G/od+sXQslVdAgISNHVwgIh9zL9I50nxvcyVR3xfLD9vgc
         czezqXOHz7mF/NbJ+h1JppMZ2Nu3bHdltvRm1niZveZ/C/2TOMzzAVk2Rejd2QIZwm8f
         BJnfpB375FAzVjInKlIgCCluTXROOgS9bJkEwDGVb6kupGYvyN84a4OIkONQt0/Om5I1
         vGog==
X-Forwarded-Encrypted: i=1; AJvYcCVjeHakOBD4QIdlUsMlzjmmCFw0L0wDI4XwfGqi1h5vMvDEwaNz+OytXv3QTYcowobyd8NapHDwaNkU9qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZY4QSPGBS5c3qEXu4pW49uyI2n8ultL1+EZ0U/nWIorRiZPo
	wG6Fm0QVaWazh/3dxwRn5ODtqRtXfgqGT1V0826AeOBFPQ7vpihFVHFsLH7I3ss1OR0cA1yuBmD
	qJt5KBZUion96mXeYnAHGnvR/2/ZVxkrk03SOn+4Uaw==
X-Gm-Gg: ASbGncuviLPuyTbM3yX1P/0rlUZxwRl1ZDqnxcTIneSgCz9Pg1DMUXftZsGT76+FcsP
	8UUBgUl83zOZC4P2kfu468vetmD+FibTyn6I87N/9yPVzNVYlqSjxumFLQs85y/1+wGc+HQRUd4
	h5Dap+8dU7Yzaohr62JOeXdbEU+0G84wBzHVqkExOEBK1ajFS76/5NScGneylq1bOMfirgKQFXF
	0J1clbs10oY1Jvby9+cVZlGJoQRDSDVBpuNI5EneVU8+v4sbPK6J8AwzMfcE1y/JE1h
X-Google-Smtp-Source: AGHT+IEAy8cPLsziX/RCDUv2Dd6Ywa5OE8z1bKSydNZGkCZ2bkHrdBqmgyzeg7NbMT02IJqrhiQfoZnn25FUb9ZItfc=
X-Received: by 2002:a05:6402:3046:10b0:63b:feb1:3288 with SMTP id
 4fb4d7f45d1cf-6431a55ddb0mr392712a12.25.1762893781751; Tue, 11 Nov 2025
 12:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRObz4bQzRHH5hJb@kernel.org>
 <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 11 Nov 2025 15:42:24 -0500
X-Gm-Features: AWmQ_bnMmE_G9j7GUZRZnZwadwZMShQe0h1eQQimW1N6CMMoPEVysMT2zmRBrNU
Message-ID: <CA+CK2bD3hps+atqUZ2LKyuoOSRRUWpTPE+frd5g13js4EAFK8g@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 3:39=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > >       kho_memory_init();
> > >
> > > +     /* Live Update should follow right after KHO is initialized */
> > > +     liveupdate_init();
> > > +
> >
> > Why do you think it should be immediately after kho_memory_init()?
> > Any reason this can't be called from start_kernel() or even later as an
> > early_initcall() or core_initall()?
>
> Unfortunately, no, even here it is too late, and we might need to find
> a way to move the kho_init/liveupdate_init earlier. We must be able to
> preserve HugeTLB pages, and those are reserved earlier in boot.

Just to clarify: liveupdate_init() is needed to start using:
liveupdate_flb_incoming_* API, and FLB data is needed during HugeTLB
reservation.

Pasha

