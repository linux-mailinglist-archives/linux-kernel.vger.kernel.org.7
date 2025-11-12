Return-Path: <linux-kernel+bounces-897769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3609C53B16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD324A5390
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434E33DEE8;
	Wed, 12 Nov 2025 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADgUrUQn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJBlpCR0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A452D130B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965689; cv=none; b=l/JbPgpK2HbagsTja3/Wz85W0qLkJFQ0XBjaSrqJi+Fx7SpFk2MMAarFHU2GtQb87XpYodIr8NlJP8mCC4M98CpOLE6Hrx8iEnyoBsrOJkrfP23JNI5bht44KxDNP8mOhTF73NvofjagyRhLfFN0akT6rQXNAOPZEaI89j9Bg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965689; c=relaxed/simple;
	bh=a8AJGhL1VAPG262ScwQLe7whI1dlfXisT88+QPWVjEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZvHYfK+OJJ3zoOni3NL9CSEzPWSHyP7fi82nA1A2Ybhwf0+Ci+BWe3H0i3tuFL3/llXCUqn4P/1Wrb6hLqqymV2LckRQrbsvt23t6i7MGDYSira0bjB3fBWl2OR+s347BtJjMaZmCPc5Gn0PgXVEpBwd8VtjJXb8n19IQXNCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADgUrUQn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJBlpCR0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762965686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikdXXsrAm3HhwuEKeAkHhU7cBlMn2TwrNGMihSwPVNo=;
	b=ADgUrUQnQZgb3hF42q543P+CaNRtn7wEvaXClnK/ufLn5mDcUbrpjq5PBzcZ9R/SKGjHWv
	TfztLGtwl8Vx2jEE4Eqox1oHdRxqpmu+xVLIJgcLUEQyLJSmyTtcbKa4N3eMTX3xwAHIQh
	JF6rDr8c2lcXZu5qy2PLe+0V5ZfLmBM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-czqB5w0nPg6OE6tMP7LOow-1; Wed, 12 Nov 2025 11:41:24 -0500
X-MC-Unique: czqB5w0nPg6OE6tMP7LOow-1
X-Mimecast-MFC-AGG-ID: czqB5w0nPg6OE6tMP7LOow_1762965683
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7338a441a2so54647166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762965683; x=1763570483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikdXXsrAm3HhwuEKeAkHhU7cBlMn2TwrNGMihSwPVNo=;
        b=QJBlpCR0gR7cNhGlY988rUwcTM0OQstUIk9V7TilZR+p8Bw5FipbEgvPMv+KmY1eEm
         jTo57o3F3nkh4lQikx6PW43Ykq7GiTuSVXD2F/2SnDWRRszXeLLt8QcxMJNE8pJ2P7TD
         hErp82oltKeFjvymAi6f218NFrbLyswqyckxwzO2Kp1S2EDgmZGl/s0sHXsrgiTY7Vst
         1t7aFk3jqj34p+ChlyPX5HL/fsxkNpW8CvKV92CR94NM6LdbyWjuSHL40WSPaZqOlkbQ
         Yb/bm7B3aYE4aOzjxqs/639uv5TGlxshFoEUqWWGHeNMzxTOdxErqtzCz44pB9RUffbz
         ZA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965683; x=1763570483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikdXXsrAm3HhwuEKeAkHhU7cBlMn2TwrNGMihSwPVNo=;
        b=R7GjxvQX7iG9KF2uqhHXhUv6jzlBJVLsBsV1vh6j3VVvJn8Dh78MwP6Txg8cRs13UT
         wyeSUII7SQ1MHBtYOXSEN+5cLTvGu+XxCk2NbSqMhBu0YBrcChcWAnDH96MXuIk3F1Ga
         OdYui7B3y3hVJCg3s/ADCF+EhAGhBQ+FJuf4XnE6Sf6Q0e5rjDeM1wxIoTE5nhCF0kj+
         NsTEOUgm7dPS8zQB/lFzZE0wzw/FEGl9p/FYt8Sby8yYDyzAJfytZWZLeumgicA96fYP
         obpk6GVArZhS7bMbBMZHV34+Y7GUtsXc7oY6JSVlTLcTGbY57Dv1rP7Tf557RxsEs6UU
         /pCg==
X-Gm-Message-State: AOJu0YxO7425kpjKlnw0EY+1XGHylJh28GPf6olneEGvKT4aNmf5+ekM
	ikAN2jwuqb379QDMNWhpR1STyJDJsLtLl7aIXwD8YOJ6+S5HqqDrupbdGqd/02KkCxaxP8wVWmH
	b6BGK25+ZnvnSKoMjBXdtCiq2Q3slKMrlNnxB1WQ+XDpTOW8iQAtC1vLz0JjTRyRu/fu5qTl8lr
	kfgpx4Qsb5ltCrzk6yX8oUAOpTMoaQGVP2Ivkr9E9o
X-Gm-Gg: ASbGncutztqay7YToy0TwdX946/X281c8svFhkOK3SAWUi9QX7tsqehk8iZVBAt2J0G
	asNk/o+kN1BSVh4FTsO4PK7oP/SAyYplfVziwuertzBAhCkRTCwkZix0f/qtTkf5uvt0lC2KHTl
	caOtjJc4roxIAneGJYYd4puhqGK4aQyRgS9iiShI8fa/AkXo0kreMM3pulJRJUvjrXgBGMiREX3
	C/GpYy8J2X2dA==
X-Received: by 2002:a17:907:3ccb:b0:b3f:b7ca:26c5 with SMTP id a640c23a62f3a-b7331b26dc5mr346896666b.59.1762965683131;
        Wed, 12 Nov 2025 08:41:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRc27NqW8+JUpvUh/cragVc2iT9XVTBXRx/J0JvT27BwmP6Bx6hZwHI5ZAmhOEOWRcd6vQa72Z36X+KnpkIc8=
X-Received: by 2002:a17:907:3ccb:b0:b3f:b7ca:26c5 with SMTP id
 a640c23a62f3a-b7331b26dc5mr346894266b.59.1762965682584; Wed, 12 Nov 2025
 08:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112113556.47ec9d12@gandalf.local.home>
In-Reply-To: <20251112113556.47ec9d12@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 12 Nov 2025 17:41:10 +0100
X-Gm-Features: AWmQ_blxXMedttQ595QdqBFXx9o1e_Sra_b48yscMGVD3xxwKAJfY9BmkO7vLyQ
Message-ID: <CAP4=nvTMknOzMeUj-bW2sdGNTP-4D1U+L-buwyXZo8et1XyY_Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Tomas Glozar as a maintainer to RTLA tool
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Gabriele Monaco <gmonaco@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 12. 11. 2025 v 17:35 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org=
> napsal:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Tomas will start taking over managing the changes to the Real-time Linux
> Analysis (RTLA) tool. Make him officially one of the maintainers.
>
> Also update the RTLA entry to include the linux-kernel mailing list as
> well as list the patchwork and git repository that the patches will go
> through.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>

Thanks.

Acked-by: Tomas Glozar <tglozar@redhat.com>

Tomas


