Return-Path: <linux-kernel+bounces-757467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AEBB1C27E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E04181460
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F2289345;
	Wed,  6 Aug 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnjBdp8I"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCC289367
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470310; cv=none; b=MeKjKByWeY95KKvPF0PKrdOfBNBaQRRDGAZeg1bYCJFi3grrRYR4UoLCv1NRb3dDbba2dquIO+D/KSt8cwjyvzKPMPUb6c2ptqZe5B1/gGgFU4De459x9T2qeVzKs9CYL2Qm1buzYs3e364k6O0niugNeinQwguELS34ivD+lyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470310; c=relaxed/simple;
	bh=qn+da6NUV+VK6TZyQ220xYn9XBWEkV1vJu5G8KrmkBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUufOFITuLCHmFmwHF99G/fQt5CS55i71SWOpbAlDnilJKHFBKqW+xQG//jTjSyDxZRGHkGfSHPD9enj7QsroUaMjHJMQdSzrr1FFcqkmjpCt9sLFkRnm+nfAPJnA1xl5yyvLZAG+rgyk2QBJFF0Fo0yXp5lU5HqkJU+hJ+iwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnjBdp8I; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4af123c6fc4so40977271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754470307; x=1755075107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn+da6NUV+VK6TZyQ220xYn9XBWEkV1vJu5G8KrmkBo=;
        b=vnjBdp8I7GiCT0wib5Bk5IB2YVWBwHyPvsdiIx3jY+uayeLdSjyIkkXTgB9tCDRhCE
         XGFql+zWOnix0VbRoJGb90p+cJD3eg+qaOWToLqcMMxyxvAPh9r3hrWhAZ5OGQNLgh5L
         W5Bgr+K1YlK2MCd3mnkgwKg9SaZD1gmjViYF7rwB/UAEvHNkl0547Q7cMOdCXMmwQC6/
         HGo66cf5c/bG+tzioAIi4qjR29G84saFeKlPdv7BGotYfOiQN4iXCeamAQssWv+pA8C2
         GUxmQA95JfO1AgPyeTOFYAuPk63zcNe5HcymWxGYdJhqIGMMmkg7lmLp2uMndw+9COIn
         Tyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470307; x=1755075107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn+da6NUV+VK6TZyQ220xYn9XBWEkV1vJu5G8KrmkBo=;
        b=wt98zN8WlP11HO6M0B8JDpeD58vpHaielwu4TQB6RK268J+8lxWW65oey/9EbVvDH0
         p0SRGUDNucoVbuU36IBvApL9sRp+QOWdEBB5Fuv4hI1egrqTf7ARgesDDJ0TpQvHdyg2
         0oXwaoxMI9lLOVRkHBynewZC52XQ5TCb8m/cOkJRnRp1VGr9KtWlfz88hNe55XqG6mPV
         7LUHIX7JEgNcQ6OWRcrhUz/o0NVITIxvRfpbqebeBVrEjy12y5TTeHrcE6/XHECmlRCP
         OW3j/5LdZRQDqGvhsPX9mVCrLB/2qnC6ru5o9TQEMWbW6LIhnttVCzEW7pRp/7SEd9kc
         HZIA==
X-Forwarded-Encrypted: i=1; AJvYcCWWRJQUQrRB1q5Ms1ssLIdrz6NWMWL0SA+jxuqbbtutLb4PL36P25WLSYTkJggGKYup2yw6jZsHX+ON5kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxwGeeIZwVLlyp4MvmnDg7gYr1SIAPSnKZnzkw/6t6c1gUP2l
	WbMy1gs8egfDbWJ470G8U+yyYNO4HAjhQODDjYGB98XjZQq7nnEffASE8ykkkbPygXW6n2VFv3u
	x5WfpQA0ufsT1hB7yjP4WCATMd6vIGFcj/bauivPP
X-Gm-Gg: ASbGncunBigYw3vMjo06FoZOsYBrwaUyOLzCQWSy7YXU+5NeojSS5xb1Z2OlSu5GzMQ
	IeiwLw9R+n0YYPSmd9nCwqld02jvWcmxW9kFesd6JRpNjgS8THNCqtFYzw8tSRm5TozyJPyk/Xm
	MokoCu3nXsqAS+1ai3x87Qy3w/x+Zs7LQt+WQxOR+ehN42yokMO5lfMvVoyLhinKKx6+6sjWTIU
	aaJJRM=
X-Google-Smtp-Source: AGHT+IGL6MT36ycjN/Z2kzDW4M5h69hOhbRXJ2BWZUCsi//eLzj+Pojd4e2nsf04f3CGggbntbB8f5Eau53j54zGrTw=
X-Received: by 2002:a05:622a:5519:b0:4ab:3d2a:7f6f with SMTP id
 d75a77b69052e-4b091543bb6mr33409941cf.33.1754470307253; Wed, 06 Aug 2025
 01:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806055210.1530081-1-jackzxcui1989@163.com>
In-Reply-To: <20250806055210.1530081-1-jackzxcui1989@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Aug 2025 01:51:36 -0700
X-Gm-Features: Ac12FXxf0CU4fmy-lD7GRMqvzg1F4P1w6fy3aRPBUx6y2GnFXkFQj6-DyAbECsI
Message-ID: <CANn89iKpG2-+oj45SEwOggj+3j682Cgh+L7+61HF6Q0YspPikQ@mail.gmail.com>
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:52=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
>
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Add hrtimer mode to help
> compensate for the shortcomings in real-time performance.
>
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

I doubt we need another CONFIG option ?

Also this seems to be beneficial for HZ=3D100 or HZ=3D250 configuration,
maybe worth mentioning in the changelog.

But more importantly, I think you should explain what difference this
really makes,
in which circumstances this timer needs to fire...

If real-time is a concern, maybe using a timer to perform GC-style operatio=
n
is a no go anyway...

