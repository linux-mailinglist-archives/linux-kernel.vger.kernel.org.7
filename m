Return-Path: <linux-kernel+bounces-852346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0056BD8BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 594C94FD6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C572EC0AB;
	Tue, 14 Oct 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDz9KSu+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214662E8B7F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437333; cv=none; b=kld9cmLGFwD5tiTDIZh6/XdOr31NfwepKBRcbujnu1Ur8FBzOW1T4a2NMhU7CBbRWiKkWSv5HRvMf4vvVE5ZZxejGIg9Pgyk33MLw/kR+V34AGyluOvH/S5cKRd3zPlgqt3V9Ry7Ag35A7XiowmW8PX2u0o5HIbRKA77vOrZNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437333; c=relaxed/simple;
	bh=8L1RGzt7soJt9IKppmbflYl6y+ueOV8Q0zaTAUUOegE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3Ax6RDIslZ1TLAMWKsq9KLCwg6rw2PGNqV+Z7E+voPHFDzRTOhJ14MzXJw077wV9+5Va0Fm1y2a9YqjsUZOQed83OhgNjMhcQK5DWvITYIryHSoWWMQBgo+gfu2q65UQhwwVyGa4tAY69syTHjlfQE5f0yYOPw/6ZVZ0soiBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDz9KSu+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760437331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8L1RGzt7soJt9IKppmbflYl6y+ueOV8Q0zaTAUUOegE=;
	b=bDz9KSu+3wrJj7urkwROd88Off118U2OGrVhwUMDjU8RN1P7zp7PpqK8zGJUHy6YdToHza
	tQjQEOEtz4tTTtYyQb0PizzdzlP3QeTjS+sBwGv64UktrbYhQ+etMOyBWh4QBzCSKUnNHj
	vqeXoAv9ddFzYrf80vWmg7nSi7y+te4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-yCAHfg4OPUSPqh5502eUOA-1; Tue, 14 Oct 2025 06:22:09 -0400
X-MC-Unique: yCAHfg4OPUSPqh5502eUOA-1
X-Mimecast-MFC-AGG-ID: yCAHfg4OPUSPqh5502eUOA_1760437329
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso3886026f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437328; x=1761042128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8L1RGzt7soJt9IKppmbflYl6y+ueOV8Q0zaTAUUOegE=;
        b=VXYEMZPXnvdgSLav9lAsYLAOIELMLmC8/wFojIfWKQDBL2VLM56AeGWPvQSqtwoo4P
         CQDoP/O69+195TRzCE2UYfzKAfoFRYkk3J5/xM+4sz6VOnVP+DVCjFvmdrPyeL2mbuV5
         w1H/kA1v/iw81RuQImCxD7kxn7uHeL2PjSVNdT/7klnST3USU2ed2TxV6BxKz+Dpgnuy
         dSRw/q3/PpJ/qJK+xNapGTLA9poKM7t3n1SHQmIV3hw19XaP77jqW7okglpDhm0Zl80E
         e8DhKyXO2s9XK8Jh5TsXKx7yrq2V1xeL3RWAaJ/FInu7x+/kdj1P8CYe09QsJmedJUtl
         eu5g==
X-Forwarded-Encrypted: i=1; AJvYcCVjlVT3XRpBqkSnTruCgkaLfd9Pb6VlARlKybBR5CzVGMiOtuq1LrjscTjqvCVU3bv9kdPkyT6JB/Qzf3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/oQzf2IePOJ1O26etnN1gkS0fmof1YilhACfb4ZQc7RzqvgWu
	3tbrdI+2GoKw0+rjWKRtCNR9PDpnjWsssYZkhJS9BDciZQjgINoccx4lhMANXbMa1PghprrqLZ4
	4i/RPHLbEsAWsBxTyCvJS6Q2UglFmREdC4bAlbujIl7k2sULqgfh1Z6a+MRsZ8McdckwLF+ELGt
	+Y
X-Gm-Gg: ASbGnctcUnPor2/ls1Ox/ArBOeD+iLy3MhH0TqaZspbS5v9wNODS7lR9WsdPljYxvlo
	WlAqRye6/V6C8T78+IgaWjp7I9XhayX0rdZLbyqfR0qJH4OM2yHxnN5XIM7Zeka4CwvJuPX8rEZ
	BcV/Y2l7HZYznLuipNcXCdYa2uMicfiZh74M2iyLWI3SCwNFFmewF1kb3omYa9yI2kQtkUljIL+
	hQvMzqEzT5hDv58XGk3ZhKdDzR7LP6Pq4C7d0EG5vMrID2/yhMOQsmUomPjtISCONdb3GX6Xdb/
	5Wyk7ZIlV6KCK5hp/mGRVImMOIMqtHuUIX+pj/E+I750MHKtacJoM4nZ2YNLVUsuQQ==
X-Received: by 2002:a05:6000:2c0c:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-42666ac39afmr12909542f8f.8.1760437328623;
        Tue, 14 Oct 2025 03:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI8UJI60MTklfSrxiStm/XC5egkna5mdYCP8ifnCsQpxVWUiBUgX/rrIY4dwlcC95NJb48vQ==
X-Received: by 2002:a05:6000:2c0c:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-42666ac39afmr12909529f8f.8.1760437328184;
        Tue, 14 Oct 2025 03:22:08 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm22705271f8f.45.2025.10.14.03.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:22:07 -0700 (PDT)
Message-ID: <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 12:22:06 +0200
In-Reply-To: <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
	 <87qzv6szku.fsf@yellow.woof>
	 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 11:46 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Oct 14, 2025 at 09:38:09AM +0200, Nam Cao wrote:
> > The reactors are invoked in tracepoints' handlers, thus they must not
> > trigger another tracepoint, otherwise we may be stuck in an infinite lo=
op.
> > (this is why preempt_enable_notrace() exists alongside preempt_enable()=
).
>=20
> Sounds reasonable. However today not even the printk reactor satisfies th=
is
> rule as it transitively calls trace_console().

That's a valid concern, I assume it would become a problem also if we wante=
d to
use locks inside event handlers, as it was discussed some time ago to bette=
r
handle concurrency.

> > I'm not familiar with the internal lockdep. But I think these would
> > trigger trace_lock_acquire() and trace_lock_release().
>=20
> Indeed. Right now no monitor attaches to those tracepoints. We could
> prevent monitors from attaching to certain "well-known" tracepoints.
> But then we still need to manually track which those are, which is ugly.
> Or we move the invocation of the reactor to a workqueue/task_work.

I'm afraid also workqueues might open a rabbit-hole (waking up a task fight=
s
with locks in many scheduling tracepoints).
At a quick glance task_works also do some IPI/wakeups that are traced.
If I get it correctly we are looking for something absolutely lock-free/tra=
ce-
free, I can't really think of much at the moment, maybe abusing RCU callbac=
ks
but those would have their set of problems too.

As much as it might be interesting to write monitors on lockdep tracepoints=
,
this seems challenging.

We could opt for a foolproof Kconfig solution and prevent reactors if lockd=
ep is
active (leaving only the error tracepoints that are hopefully still safe).

Gabriele


