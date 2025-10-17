Return-Path: <linux-kernel+bounces-857402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E962BE6B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D9514FEA6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB330FF2E;
	Fri, 17 Oct 2025 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLw+iC//"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F33101D9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682787; cv=none; b=eycpPUnfP9ASAXC5EMMcNTtKLIeV31fgdOjqNd6ne9zRZr8DJDFfa6B22h9zCOBAAavaKvt41edgaQ6c+xCQOdcSWzxdIE8rtsfu5VgXzWRNhKwGCboS761cASDsEESeRgRm6g+SRj3snuQrPU3qD0c4OcA3ZGt6cEtwM0qfyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682787; c=relaxed/simple;
	bh=Eh0bw9xfLqENZ7WSEYw/OQLt15jF4Xt8KicazpJsMcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/E4H3xyKbZ+tYpq34p30Fz3PfBgfADoarDfx/T/GspculsNt4SRMQQXpkDpmSGZfSe9lRe2MaPfDuefQoP/33epkJhv1QQL/fybcrU9zZ9Hs4F5LYDNPX/548tMi4OeBun9cBzTgKgSPx9byF4Lmo7s4GH07vLk/cxD0evTXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLw+iC//; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760682785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUOUSWGdX6YFzL2A8L1DmUXyIE8Zv8t8/RNyJEsJ61w=;
	b=fLw+iC//xKWRDJhD8RSSmrBn+HCBcbiu7g9IAQvSf7CkGVXjkxFD5mmdHDuYHk8kTzYqtz
	GstW8WGrdE9Sy92IYNFChO4lmSNFPuI92/4hFEfAc+e8Nrt8Hu4C0ZRRSGF13Q/+7bliwR
	VaED+rpcLoexiEzvs513MFgTqNGJdwc=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-r-RCv4MeOhahsBL3_3pLsw-1; Fri, 17 Oct 2025 02:33:03 -0400
X-MC-Unique: r-RCv4MeOhahsBL3_3pLsw-1
X-Mimecast-MFC-AGG-ID: r-RCv4MeOhahsBL3_3pLsw_1760682783
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63bd9110435so2268698d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760682783; x=1761287583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUOUSWGdX6YFzL2A8L1DmUXyIE8Zv8t8/RNyJEsJ61w=;
        b=pPyQJUZUC/2DVUePPW8E4Dd5LSmJs2ZGdMQ10cfEqrjvxrGflaOffy6jCO2IBLIF9J
         ZqfvMgDmq0OF2d2o1xLQLRAuqDZNM60rFkjdCVEXVX526TBpf7V+uLKrFy/tMbtWwuAH
         IEdW7pWP8Dt1m8xOmsWN2wqn+g24d+OwzXAjrcTrL5FYRn/QWCRB83p6tE2vPECLCBUW
         4fOC0/mpSaH1QiAhPYl0JxCa9I1rip/KK8Ipj5f+QWa5eaxy0J3MYqKSDav4IXVZohiX
         IMeMS+q8YA4DdvzqKIYxOuM7por5slNr4B2AFkDY2M4x3lrHp2cZTmZklPAzQo6k9zpP
         e8ng==
X-Forwarded-Encrypted: i=1; AJvYcCXrhxXWtK8OPYGOfhf5YrJan1xHWbgcZLrUPLsAio3HFRwx28FoadHLqstjKsR/HjHwBZvwcMfI1mIfQwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwryOhQ07/031CtrbUkmD4Qylki8DyL+daNgiZNl1bS1dnwf/DW
	FWwVzLPnF18e1T+ei75OA1uSaFekVZDP9yyZPqA3/Au15Q3jm19YuPwUyMuZFeYn4G1nQ2K43u4
	tr8Q+N+wQKzv0OMLHhRwDMGpYQOG2ecNT0prV+uWi+rex3jaIHtZitegtaUi3K2KsFNdfosQAL/
	iaUCuxhT2/Ldah6knD2JNYcMj8gfavRE9y2ckpyfza
X-Gm-Gg: ASbGncuhLPGBaAZFVdQbt04UF98UQms3VaMYokuE3bZuxJ3GTu/aXbExVZahQM/GSCo
	eh9oroFdB/9NqnE6Va0wp3S5Vyjgzox5NZGb2l4IsipwuOoMjqgaQWt0T1UgERVpFx679O98Vwt
	MvXHo5dHia8umAA+1FdonEFg9xec9fcRCeNJowqd6MQzqHD1xetidxTz49SDUWTPQWPv0kMJcuy
	+Ev+f9MRjGfktpROWlS/YMyHfyNW43hYPN9wLPUUPA=
X-Received: by 2002:a05:690e:159b:20b0:636:1928:b16b with SMTP id 956f58d0204a3-63e160e9837mr1907677d50.1.1760682782731;
        Thu, 16 Oct 2025 23:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfzzpU0/QnSAE3gDCuvNGr0BTm1Q2jkW11j+3JcVjYg06H1vsoa05BOh9Esr2FnoyTCv8k30KTHta7yNbDCr4=
X-Received: by 2002:a05:690e:159b:20b0:636:1928:b16b with SMTP id
 956f58d0204a3-63e160e9837mr1907665d50.1.1760682782357; Thu, 16 Oct 2025
 23:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-2-eperezma@redhat.com>
 <20251010081923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251010081923-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 17 Oct 2025 08:32:26 +0200
X-Gm-Features: AS18NWA6LyX5KsRP5REs-F-lAntoOrYBFcpi5dHbv2GWv2WR1X9PGIz96C9KRbQ
Message-ID: <CAJaqyWdSgTcH1sLcmMbySgW+=G3VvjHoy5mW1xz+QNmnXhEbgw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] vduse: make domain_lock an rwlock
To: "Michael S. Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	jasowang@redhat.com, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 2:34=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Oct 10, 2025 at 10:58:21AM +0200, Eugenio P=C3=A9rez wrote:
> > It will be used in a few more scenarios read-only so make it more
> > scalable.
>
> Well a mutex is sleepable and rwlock is a spinlock.
>
> So this does much more than "make it more scalable".
>
> "A few more scenarios" and "scalable" is also vague.
> RW has its own issues such as fairness.
>
> So tell us please,  which operations do you want to speed up and why?
> What kind of speedup was observed?
>

I think you're totally right here.

Yongji, would it work for you if we leave this conversion on top of
the series with a simple mutex, and we have bandwith to explore the
benefits of this? You were the one proposing it [1].

Thanks!

[1] https://lore.kernel.org/all/CACycT3v=3D_Nm6fefJGFEyoU+Xf5G=3DKzi0sXhhaB=
HnJQZcG-4EqA@mail.gmail.com/


