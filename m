Return-Path: <linux-kernel+bounces-724044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E9BAFEDEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7F34E16A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5392E7BB6;
	Wed,  9 Jul 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRpeezjt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBB2E7653
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075720; cv=none; b=JSfTprCwKblbLudFoQdW3SXbqdi57cPMKuGT8GndVKPFE+vLkpORpL5ztJQTN4BptKToFthUnoN5vHqGikoirAcbqyLyDUsmdoXtB77FOq0R62/EpY/+dQTIEiF+thZAelDrBeeVxCjLrimb2LvKI++/AcPtECtiXyXHEY8F9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075720; c=relaxed/simple;
	bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG7pr4iN4EYQelyugrXX7DpcFfEQaeRxgoNaTOXT/WOJ+kxu5Omz8MEH7OyIj3c52Crzu908McqhBht7PCU0Z+SjpAmQthRcA5ySgGSmtKMfTUPLdRLlvF0jfUMT4jyOmN4QQULJCiTCIbxPeq2bK3VLaAm2yqyovmvfIntOxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRpeezjt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752075717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
	b=KRpeezjtUvoNzpLvAqZmpn5f54I6NILh9iAg9iYTduM9/jycSw30KKgcCg6AQ7VgXuH15g
	1fSfgVS9vsc0uI2la3IXm5a52plppf+Zv77eHHiUCSjjoWmNr7YP11l9GausLNjdjc3cxb
	rtXvQRj8fNATJaC58AH/rhY4UPvK0jg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-HNItdP6oPsGcWMrovVCrQQ-1; Wed, 09 Jul 2025 11:41:56 -0400
X-MC-Unique: HNItdP6oPsGcWMrovVCrQQ-1
X-Mimecast-MFC-AGG-ID: HNItdP6oPsGcWMrovVCrQQ_1752075716
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70e4e62caa7so14883337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075716; x=1752680516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
        b=eFPSl9i3gLnCOgQ4rvr2FgZfq1kAhzHXYcCR28J9NLlwYkyOSwLs7KVaJVAWG5aZNP
         oZ+0ZENPpXK0tX4tzo1XOJylKJxpB0+OB+S2CNkFMiFnkWOtLJjqUw+5OhxphuKYIet/
         BovYoYnokgKIp5URBFoIbe6kjFduno90IdVXib87i6p7RizUFJkjm1gUQxp8AP/yq/x9
         /Yu1NJVir5nJ9uXhaX4ZRhtO3Scn4Lv363ganUH+eflV4U3kCHpXBgIev7QCXV/bnFNc
         EzBpQ9X9tfFOq1vMUUCVY7VbyFOJkXIuAjtY5lNkh3HduuAiAmauHZ0jqLpdh1armawL
         /0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5zSYi2x0SoGlu4QdpSsT4IJ7wzg7hh87DUGb51/s+EoFYrZtTFQ2Tdxg5LZBuPP4b4xXVHoyKEg23Ny4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIHOatb1A63s+kFkSi3Tl8DPsr8rbabWXEG48nHerE3mqVZuP
	YKq22ER2sOjcpJpivNDyy30k8W1H0mu/2lz1wPFodnxA2uXpmw5cKzF3j3iWsBdGb3IzfrtBMn2
	FygIsVb7UdYfZ2ryne1ITOKf0Us3JzyV5nNrzhln598tyRN7xu9mLNiejL8pJViKQcSjPNPIQPB
	AsKQ0IbqpB5fVjRncQlSElZulaq+aZdL9jfOEBD3yL
X-Gm-Gg: ASbGncu+CxaJuGAyREDUmLhKzbBDMh0jmQeq6+whid1yl+IjjZ1i4r0IhRIs0pItRfS
	23Y2F3DixOqwrgW129Cr39VlgJj29DfUCSu8mGxd2wS1BLDxNwDtdDl3E8P45bXN8PxjUOKoqIh
	4SJyET
X-Received: by 2002:a05:690c:6409:b0:713:fe84:6f96 with SMTP id 00721157ae682-717a044be8amr108447837b3.14.1752075715720;
        Wed, 09 Jul 2025 08:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExFxKvhbTdzloCbFbyh1tiZpUMkvI+DBzINVmDyNWIx7ol4flKg78d/Go2l26/5A8S/OniJB3RHqWchsMadAI=
X-Received: by 2002:a05:690c:6409:b0:713:fe84:6f96 with SMTP id
 00721157ae682-717a044be8amr108447057b3.14.1752075715039; Wed, 09 Jul 2025
 08:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com> <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
In-Reply-To: <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Jul 2025 17:41:43 +0200
X-Gm-Features: Ac12FXyROMf2rt0OlirwLyo137Qn7MCpqP2NG-8va_x4r6nW2FeYLXGlppWreyI
Message-ID: <CAGxU2F4GbeCJDYrs8Usd8JJcTrp99gyn3c_zXqpnz+UH2NNBGw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, v4bel@theori.io, leonardi@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 17:26, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, 9 Jul 2025 at 16:54, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
> >
> > I'm seeing a problem on s390 with the new "SOCK_STREAM transport change
> > null-ptr-deref" test. Here is how it appears to happen:
> >
> > test_stream_transport_change_client() spins for 2s and sends 70K+
> > CONTROL_CONTINUE messages to the "control" socket.
> >
> > test_stream_transport_change_server() spins calling accept() because it
> > keeps receiving CONTROL_CONTINUE.
> >
> > When the client exits, the server has received just under 1K of those
> > 70K CONTROL_CONTINUE, so it calls accept() again but the client has
> > exited, so accept() never returns and the server never exits.

Just to be clear, I was seeing something a bit different.
The accept() in the server is no-blocking, since we set O_NONBLOCK on
the socket, so I see the server looping around a failing accept()
(errno == EAGAIN) while dequeueing the CONTROL_CONTINUE messages, so
after 10/15 seconds the server ends on my case.

It seems strange that in your case it blocks, since it should be a
no-blocking call.

Stefano

> >
>
> Yep, I saw exactly the same issue while testing a new test.
> I already sent a fix:
> https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/
>
> Please, send a T-b/R-b on that if you can.
>
> Stefano


