Return-Path: <linux-kernel+bounces-723726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755EAAFEA57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB1216626F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8A81C1F13;
	Wed,  9 Jul 2025 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul6riFNm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99D276025
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068170; cv=none; b=siqkQxbxXy0wClOV/hK0v+89ArdaF/96syArPwy5cepSGsB1JNPSJbxqRAUanL92x4Wny8KTU8jxSQm/PSt+Te4AdQl6lQ+8I0Bwk+PAinT523PXeiYYGhLNGU2HGdfzBi6b7L9B4++b/GSzECKJ5r9DPcTEQ958ZGtZmh+IVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068170; c=relaxed/simple;
	bh=eqEtyyZVHwgeHDKi4pSEA0NHYMoZ+A867z2ivGKxh20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGmnoWQBMK07gps+O2LtZXTh/N8tNH7Re8VEWyd59aWBV5hAa4WGpf2Cq1WoPVUHd8s9ntaQvssXm/KtHuaHmJG5UCwuoH0BjxueoXhWL2E0QcbGi/1Sfs0hoChM0rjN2EfktdQh8PEKh2ZwzvbbOGhndon5aepfjN1Ae/YLacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ul6riFNm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752068165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqEtyyZVHwgeHDKi4pSEA0NHYMoZ+A867z2ivGKxh20=;
	b=Ul6riFNm8HFgQTsEf3zUvCEmIm7x5+LdzuPuKzt+dWscChFMIcN53GjYh8Yf/XFSzyZNWu
	nZ3LMFcgF95o613DyDekLu8LDCpCSvp+y7sJT8WEcqe5pCZEyH45koM0ESbbojm58Iysp1
	miiu7cFoGNyLtB0aY+ZR9Zhc1nVB/40=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-S5U8XQ0JOWKJXohChf3HmA-1; Wed, 09 Jul 2025 09:36:02 -0400
X-MC-Unique: S5U8XQ0JOWKJXohChf3HmA-1
X-Mimecast-MFC-AGG-ID: S5U8XQ0JOWKJXohChf3HmA_1752068162
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a9e1de6f5cso10672081cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068162; x=1752672962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqEtyyZVHwgeHDKi4pSEA0NHYMoZ+A867z2ivGKxh20=;
        b=KKfHWXPLEWegnWwBNu2ZZk+F2Xw+S4vzJeJt9mm/Ua9Fwr0bOgiX02DCfT3HMTDviz
         YyjeGyKBIGG35aIETYdjVwoHwEmoMfXvMSZ4U/mXokuxmdr1MMRKdntw9bFB5nc28zJg
         9lBCSxYdPDsFaKw0pnMN69wWq2GSAKQt72awPamPdY5zGOwkjWtJFdC8WGGOECJw+PZi
         rLCFU3X9WPKyXX2qUxYyTcwqurz19W+u0BbWvPTlMBS6enIUCKmm24BvgP2NaoA3iijV
         4eI+WWyEusRehGxti0HoSWeN5xLaMYJZY1aLLkYCr6FsKgusoG7EEyFk+m3IfIzSYiuI
         704g==
X-Forwarded-Encrypted: i=1; AJvYcCXelJ2Du3GA0K/tdRlRp3xjYvgD76EqoBKe8t06lIKU1ree9ZrbGf8m2UBm6G0NBebAH4DwRCKYXdbBFfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6WlBNs3XUV1QCc0lRNrY64iDJKkaiZdxXWW/OtUs8TxN9WJX
	UET1V8vEiYEw9gQVnYRxZcSAa22gcoyStJm31R7InudGc7ZMv0nhlOp9UY3SE41+nPA4WC5rVAI
	nMtsJF2Kx+CIqz4OCp4yXebwGuwU7Kheiwi19/Wd1Vm0trWzemHLlv4mvUDswR/lkw4ThdVKGTh
	cCL8N8Ctv4T8hN2rUgZJEW2QjjPAt5C+2GXJW16O/2
X-Gm-Gg: ASbGnctJ5vvBmfHV4ZAmMOosAQiFe+UK1zdSxQm07K4V9OGPmbzKvap4gtDlwxbZsOD
	mbwxG/NEJsevlkyJGCFqPZOmUuTG2MjB/tdBXZcTskS8fxY9LJwZiBbVP5Jo/QJkLL+G7aMs7uT
	82Zp7GJzlg3k9GKqLCFq9+9z2s5gxL5uNeq9c=
X-Received: by 2002:ac8:7f09:0:b0:4a9:93f0:e228 with SMTP id d75a77b69052e-4a9dec29279mr34551821cf.1.1752068161591;
        Wed, 09 Jul 2025 06:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYc5vsGllycl+RXMiSuYfzk8U7dnfUY+sNJIFkjl/O4iokoCHvRs0OAlE8JVinxjj5VrbetYBd4QXqaj0LYBo=
X-Received: by 2002:ac8:7f09:0:b0:4a9:93f0:e228 with SMTP id
 d75a77b69052e-4a9dec29279mr34551371cf.1.1752068161026; Wed, 09 Jul 2025
 06:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620085618.4489-1-gpaoloni@redhat.com> <20250701195939.3e297e20@gandalf.local.home>
 <20250709100626.fc0611eb6801b7a8dad9164f@kernel.org> <20250708212539.054a7d5b@batman.local.home>
In-Reply-To: <20250708212539.054a7d5b@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 9 Jul 2025 15:35:50 +0200
X-Gm-Features: Ac12FXx5NWw9UHzx8YL3iucBA2PdBGf-Feo4aqU3LLlrumvb9g_yTwBvoL9WwGA
Message-ID: <CA+wEVJab6Gwkd7q58=v8uVhfmKpwNRAqtK67f15JtZcKSB_ziA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending as my previous reply had HTML stuff and was rejected]
Apologies for duplicates

On Wed, Jul 9, 2025 at 3:25=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 9 Jul 2025 10:06:26 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > On Tue, 1 Jul 2025 19:59:39 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > > + * __ftrace_event_enable_disable - enable or disable a trace event
> > > > + * @file: trace event file associated with the event.
> > > > + * @enable: 0 or 1 respectively to disable/enable the event (any o=
ther value is
> > > > + * invalid).
> > >
> > > Saying 0 or 1 should assume that those are the only values. Don't nee=
d the
> > > content in the parenthesis.
> >
> > BTW, it should be "0 or !0"? (or we should make it boolean)
> > This description means if it is "2", that is undefined.
>
> Hmm, now here's an interesting point. So this is to define requirements
> of a function based on what the function is doing. But does the
> function have to have strict requirements?

IMO one of the main goals for these requirements is testability.
In order to have testable requirements we should state what the
valid input values are. In this case:
0 -> disable, 1 -> enable, everything else -> Error.

Now checking the code again it seems that the switch statement
is missing a default "ret =3D -EINVAL" (or else it should be changed
to boolean, but I guess it would have a wider impact on the rest
of the code...).

>
> If it can handle "0" or "!0" does that mean that's how it will be
> defined? Or can it just state "0" or "1" and yes "2" is UB. That is,
> it's not part of the requirements but if someone passes in 2, it could
> act as a 1 as it's UB and implementation defined. Not a requirement.

Right now if 2 is passed the function would silently return success,
but do we have a use case for this? I am trying to understand
where the implementation defined behavior would be....

Thanks
Gab

>
> -- Steve
>


