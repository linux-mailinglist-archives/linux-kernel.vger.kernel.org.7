Return-Path: <linux-kernel+bounces-871939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73BDC0EE45
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299EE19C4BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C848305E28;
	Mon, 27 Oct 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+thIMVp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2A5695
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577889; cv=none; b=GAHz1+v9I3b8jM/IXwZ8DvRz4mJf9a1I56vT7o/oU5MBPYSvAUZFe8h2pgIuJAm5M7np9SyXvs+cMco9OQ2HVl9EEU7YyX06SnnT/u4xVhzy+bqPZUIsNGpyIw7R/ek0KcOhQA+gNw3mB5TgCC9XVDmjrxZ42sr9FYfXn+8rLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577889; c=relaxed/simple;
	bh=lMeTx8WKACZxktYPopjCcShpWfkYkjFg0gmpDilv+Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URKAasuVs6G07tQz6A4gzGckxH9LQezPErkvWKAXIwfivEj7GQfdSArBxObpdOjvWpvej50BuTgPxb3YcqIeNf2YFwQWN2cw6Ulppyb0IWH9T6TefPpayKliFh+BDB2tdAkPCId5O9n6RfAHj7MkdG36bHHtW0sHyNgFRe43Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+thIMVp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29292eca5dbso63520995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577887; x=1762182687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMXfMmOIM1+x1qfpV6gLLOVtUUnpEoN0L/vCSNSTs1w=;
        b=B+thIMVpBN16Gcx2VvajHtZJLAfJC/dNCLmb4yVo3jr6NKGTotr1p5fL/Ji6x5YxHe
         ESs8cbLxREQVayRyUs06QnKgJHPSQ2cFma8nI3cKwszNGS583LzYJ1Kdd5ANewDPONRH
         VExdztEYXKtzDzgvyl0EXjOG3T8+oKiOCVLr4TPyy5sTwg17odtixN6vHLY4TdpqqlGV
         T2H7ebjfoPC5CNp24lKawV6HQVM1yGVj14VMiK6mGWYJHdDko+F8hG2vMWdkxAsEIsXJ
         lO1qjtVzrCK/RqxcIy0lo+WMydnldlYMRqLpxo5y7Vgf+KAvj9791QHOTixfrLtJa3SF
         MNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577887; x=1762182687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMXfMmOIM1+x1qfpV6gLLOVtUUnpEoN0L/vCSNSTs1w=;
        b=Eorsc522qvWuilINPpzRGS6fS8yKY2ysXG4L/RjTWhP8n6jdv5VGDkCzh+a1c3Dc9o
         I58nO2aBRq5h45Llj9zX5l4G/jgruQcd9HH/QHaziJq2prGGIWJLsOEdNmuvt50l2fvH
         0cFcuQzS0iO9xeVNh6QlSNtprgtodMSXqn3ehIcnQOEGOFDz+KNak74+h27hFI8q6086
         fnOgl8tFy8Z1+ZjfdUSXpyHSn06rd31EgQV8XOtetwXIp9KtpYWbrlw3e1e7HhkMAN1+
         UZW9DgXE9kalwd3pY0tjIgSF5Po0hKzNjVvhUdlGHqmoyKg1fRbZtNp0nJFL+w+JCEVt
         /bvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhG6Qw4Mh84jdkRZVE3Nz2ncl7TD95FiPTqsdUvY8jgJn9RYBoB32mPlreTPyC1AqYsoTr00Zv885cXUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGBCsMtToLOe3QCxtpRQmCyfc2RNLNuvxXKJPcjr/vDwn8UoJ
	efhCBZGmIuSwi1Y5U47X0Ni4OTLn9JYADTkbNhAzAxQDJxKTLAPEA59Yyys/amm915idK8HdLgr
	k6VcT62j8Hamp9PFaCai/cd+Yx0aQwOg=
X-Gm-Gg: ASbGncsbOCWvh8zeDpfN0oIikNKlKre8mR7vQSkOdCNeuNldsNf5fXO/Rp2OlY4rbl0
	Cz6Vp729bk7StAROZ8J4RqJbW4JQtrtTRoaN9QbFj6w/uONWn5hhozSn7z7o/rHw0J3OWtn6FDf
	H/7jISE/jSesYJi8JtjFUlNAk8NNGQRt6GQYW+EPRGv5ryiIezBcUwYoiFG9VDRoxwsDBkE5Sji
	SdxuiizAMKeuf5w01WMFlFjDgnuB32+FFA2YOG4QJh+KrpUTg/x2RP2OuEofOCMIE1d43E=
X-Google-Smtp-Source: AGHT+IHvEIpzH61YALLxG8gdFqbGgN4XUy+Tq01KU2r2KGY59iowe6I+O3qMno8P0Baluus2Jy1haBpQChfxeUeLEjQ=
X-Received: by 2002:a17:902:d4c6:b0:290:c516:8c53 with SMTP id
 d9443c01a7336-294cb51bbdbmr2289265ad.40.1761577887232; Mon, 27 Oct 2025
 08:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
 <20251026044335.19049-3-jckeep.cuiguangbo@gmail.com> <20251027081125.n7far5BO@linutronix.de>
In-Reply-To: <20251027081125.n7far5BO@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Mon, 27 Oct 2025 23:11:16 +0800
X-Gm-Features: AWmQ_blGbxBV7S4l3PmDu4W7QBNWl1J0weVSFn5wNOneG3HXMQQG5CZN34vqzOU
Message-ID: <CAH6oFv+pqPx_0Q=bRmoi4vwxeXmt_D0gQGtxprL_8G43j5pC8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 09:11:25AM +0100, Sebastian Andrzej Siewior wrote:
> > @@ -445,7 +445,7 @@ static int aer_inject(struct aer_error_inj *einj)
> >             rperr->source_id &=3D 0x0000ffff;
> >             rperr->source_id |=3D PCI_DEVID(einj->bus, devfn) << 16;
> >     }
> > -   spin_unlock_irqrestore(&inject_lock, flags);
> > +   raw_spin_unlock_irqrestore(&inject_lock, flags);
> >
> >     if (aer_mask_override) {
> >             pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
>
> This is the last hunk. You miss the module exit part. This won't
> compile on its own, as such it can't be applied. It might be chosen for
> a backport. A change must always be self-contained.

I haven=E2=80=99t yet developed the good habit of keeping each patch fully
self-contained. I will fix this in the next version.

Best regards,
Guangbo

