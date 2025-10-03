Return-Path: <linux-kernel+bounces-841024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C77EABB5FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 448163446B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FC320298C;
	Fri,  3 Oct 2025 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMU7L1Ij"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125F19006B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473018; cv=none; b=k/iP5D+u0ZgQA43QieUIhuODkq4rnencb55cfqXHcyQBFZvYLAwQf/tkDjaSeZq9gd+mAjg9TwEe6XjrhJA8YgkMi6t4nyeNc/uoXovET35PpE6EJ/beUETOk/lsP8PB6aEJSs5RDfPUcexUZclpp9aQUCNgUA+7hlR0fk1ZETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473018; c=relaxed/simple;
	bh=eMBSmpZnqrRnkDKn+p2xZ6jv4I9lQldCRuwyBBKDowg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uoZmQDELK/euE2sDuo+qId7k2i2jqAh+ayw8GPTLEVL7AWdbnHeuaR8a1KpZuJecQU2JXSVc37oFRFRCtmJv9hcRzl9CDB5Jpal5g8sP7Vi4mXh1EBqfp6brxGrBARGMwVXAh1qhh2TVbXCCK68wrBZN/AAAfeSl+Hc1QTSSrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMU7L1Ij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759473015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eMBSmpZnqrRnkDKn+p2xZ6jv4I9lQldCRuwyBBKDowg=;
	b=hMU7L1Ij6iJn9nFHKASLFtH0zmqdYO9nbjyNNw/ZpXec9q1QBFHw++zjXJNVh8oMBnXrh/
	yYJBoGXZyhoJKPccqbX4Pv4cJndKYQBkCIgz5NqYxdUXL59RxZrxI/Q9CSGlQ19g+1POtw
	FcLCCxobtAgLAiDy3CTattkQVa17778=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-igdXe1MPO4uMDXx3IE-SmQ-1; Fri, 03 Oct 2025 02:30:14 -0400
X-MC-Unique: igdXe1MPO4uMDXx3IE-SmQ-1
X-Mimecast-MFC-AGG-ID: igdXe1MPO4uMDXx3IE-SmQ_1759473013
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so1448527f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473013; x=1760077813;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMBSmpZnqrRnkDKn+p2xZ6jv4I9lQldCRuwyBBKDowg=;
        b=MsWdpg9l0Y9fOguABcSfRJ1tGGkjSBnSeRHU7zKvIx4FByCgPaWotIwR0Zp1awRPKW
         d+qFgDfV2dTcA1JUmH0qvpac8WgyFilk02fFMDl5nuw2VjDutZ2AGbDPZ+vNv4q3JbI9
         9dKfbKIa7yAjJepD4VP93sSd5oyjmUAD/oS3P2zQCvDYaxlasQNcHMs75nnxx0/CudQ6
         WXmVFuYMYVcTMZndWzPghH0XTJEB+XJimalZsd8s1Wc1uQlNyjGYMkmnLJtucqJHOopf
         TNRRTqFoxylMIA5x8CHpPav1HKAPTKrWIZArQeIvG9AuCCRBp1ljbNGqPDSCbxaiIY0H
         mt0g==
X-Forwarded-Encrypted: i=1; AJvYcCVr/Zg4V3yNemx0PCAwLv+0z6ZVBlTli7RJS0SYTVvIo+o0+o89e9TkwU1Kc7DIBnx+m8acps2Cyg0btZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzefgymsQA6SNuljE6EbzVzFO03fNqb8q3oDB1o8J6KDxINE/eJ
	KkOQ3egyvRyAxRLhZVrGo5GJz35KCEc4s6xaEEK5uPyVWAompgmHKM94zgcBztMs2rQz5hmO9wZ
	YW5s6GdNuzo5vDkRBOUyzRJNICs9bzQ/CpXQPLChLqpsNscOHLyQH0T9j7QKQp+eZDEz1/R7uWn
	AI
X-Gm-Gg: ASbGncu/BM8uMUcOvVDptxxZr1uDM8HcYThYqjw2nvDSZ8QbM4pIOcKJWbZaECkbhPH
	vSiVz585nKAGD1wWIUHZB1mHI1QJ4TN6Xg1fPaoChQERXeN6Afw+iac3swkYaA9E/XBZnhjzRyz
	DhPFMHi/Gtwf6zOH8qcpEY9EDowShSOmnQHESsYmN1SJLZaFFCNltUVd10Ztd/HJMSCFMQnRdsu
	UrpvYCx4AOKQKSr6f+kvv1nfhJ2wMa+O2n4Qs5OYNTM9nWxLQx+mlJTmP4FCGOE3Tgi9OzbLxKN
	lnUopuz4dB7o0ng2qgbiN+4Sruciw/dgswosWuEg3hsTPDvwNvGFwZTmciwEYxarQOgp3G4=
X-Received: by 2002:a05:6000:40dc:b0:3ec:dd27:dfa3 with SMTP id ffacd0b85a97d-42566c5354dmr1300945f8f.25.1759473012851;
        Thu, 02 Oct 2025 23:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELR1JYmclf4EKUfrFyht98SyMCf4qSX9xmzaypmk8A7lQqrolOq939RWKtbUXsUaroq0t3UA==
X-Received: by 2002:a05:6000:40dc:b0:3ec:dd27:dfa3 with SMTP id ffacd0b85a97d-42566c5354dmr1300929f8f.25.1759473012477;
        Thu, 02 Oct 2025 23:30:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm6443426f8f.2.2025.10.02.23.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 23:30:12 -0700 (PDT)
Message-ID: <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt	 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Fri, 03 Oct 2025 08:30:10 +0200
In-Reply-To: <87ikgxqrna.fsf@yellow.woof>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
	 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
	 <20250922162900.eNwI7CS0@linutronix.de>
	 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
	 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
	 <87ikgxqrna.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

2025-10-02T14:56:23Z Nam Cao <namcao@linutronix.de>:

> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
>> I am wondering if it would make sense to add a new tracepoint that
>> fires in addition of the reactors. That would allow multiple
>> simultaneous consumers and also bespoke handlers in userspace.
>
> We do have tracepoints for each monitor in: kernel/trace/rv/rv_trace.h
>
> And yeah, I think it is a nice idea for all the consumers to use these
> tracepoints intead (that includes rtapp testing, and also the existing
> reactors). It would simplify things, as the monitors do not have to
> worry about the reactors, they only need to invoke tracepoints.
>
> But this also makes me think about the necessity of the existing
> reactors. What do they offer that tracepoints do not? Myself I almost
> never use the reactors, so I'm thinking about removing them. But maybe
> @Gabriele has objections?

Well, many use cases might be better off with tracepoints, but reactors do
things tracepoints cannot really do.
Printk is much faster (and perhaps more reliable) than the trace buffer for
printing, panic can be used to gather a kernel dump.
One may just attach to tracepoints via libtracefs/BPF and do most of the th=
ings
you'd want to do with a new reactor, but I see reactors much easier to use =
from
scripts, for instance.

LTLs don't benefit as much as they don't print any additional information v=
ia
reactors, but DA/HA give hints on what's wrong.

I wouldn't get rid of reactors until they become a huge maintenance burden,=
 but
probably we could think about it twice before extending or making them more
complex.

For instance, what's the exact use case of the signal reactor? Isn't it sim=
pler
to do everything in BPF? Is the signal needed at all or something else (e.g=
.
perf) would do the job?

Thoughts?

Gabriele


