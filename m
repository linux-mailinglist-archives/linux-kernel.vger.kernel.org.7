Return-Path: <linux-kernel+bounces-839478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F16ABB1B20
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D283A48B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1327F010;
	Wed,  1 Oct 2025 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6RXH8LA"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCFC54918
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350754; cv=none; b=WPba1NbKo9tFWa25d2+9zbFt9dpR52F+NMoBqif30ka7YZ8zMuuPxntKohw8B4xRfH+tQr5P5TRf2SeS10NaEfCwuPzUezLuRA9DP/ICdeAUb4qvZ5vPeX+lQCaIYVR+KjnBq0OnFvPPJIAOxjyngFx/idXy2m+izOXHav5aoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350754; c=relaxed/simple;
	bh=G0rSyp/sRdiQNj5upgrqgaMgmPTfXN51E8qhsVMMm0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzU/PN8c/RaFzTrGyxelxA5SHiTzJy6wNtguTOACOAh7XyyNfxKJHAgbxcphFecPDaXMIEYMLo6iTqSSepGGVnSt3ICIDsOrpD5phYBRfZd8hv5QFNXi19xweiCGmhFwTTAuXyIkpTs4mC+nSHc69KHCfxS5ivPvrIaJuJvT0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6RXH8LA; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-43f554ed252so201070b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350752; x=1759955552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROkfBcmvVJYkILd+CGDVg+7arfVWHonkG/mlRIhc5ZY=;
        b=P6RXH8LAz+3RVbixlliNsVnWAP3CJurJv5Hg+idSGJcbUEcks8ZxT6gwI4NXFFP5LR
         8QHAZhKXcRHZQt3A77kuELA8sV4fRgrEgetziDOZjwuDjjRA8eA4YrsfmkBo5Jr9NXmP
         UAYeUvqTsqCofmBguvuaL3Nt3hTah/CSj+ID0ZtcOeD/JvT99Fgf9xAKHg8vZqU6PHDg
         zVy2L19T5OMuh6ELzPNI7Msc7cq8arM674vdk4vV2aL5hEiYiYi5tXTlUo4QV2ID9gib
         y00BOQ1872TtJqohhRleAhLBP9CjNJeRNET7f5FErl5P75VYaAnopcUOO5/l+9E3zzTm
         FQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350752; x=1759955552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROkfBcmvVJYkILd+CGDVg+7arfVWHonkG/mlRIhc5ZY=;
        b=CuauGmb0ZaVuZwRWTqNSooBA81LAi+vQ12/hBKCzLOU+slbtTB/y8kpxhQP0hvjc9Q
         QXNdTjUWnDlkbD8lKFZXy0SlbzrQn7y6WRxCHuS/cpZsqMHB3aylE941+mjxIFiziTT9
         nCeksypqQkKDMnOjiZwsRgsO02GTgnAv4xS1rR5AapAzFP8Y8gJrLftuvNg/LkD083PS
         mYFFYL3L5j5VsEToTgSTRyEZtq2sPeUph3iFofpt8/FByHXXzXEik6fR5SFrGvzqiHor
         OaUpByELgeJ/gyEuxsS/AB2l12gYWOJAhUtZlidi8sbjFpgKHIs+h7X1x0BKE//+4z+G
         uIAA==
X-Forwarded-Encrypted: i=1; AJvYcCWBMm46uQuf+dykziEmbVDLCtL+t5rALQj5wZMHD6hyt+T1Jj5j2y3a5WOba7OIcFIALC+lP6ArwGW4ZBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Zn7kSlzc0K4tqkjZ8qZ7lVdhpCH6YF9GZ1LuevHeZunviThE
	ErR91AlZ8DB1zlmJsCqu/km0Bi3Ya3QGieknd2rjYeU5sPuvFmMMYHKV+7bUl4mOIBYrBqfPfzN
	0sUT5S61agZtnezfL8LPJE9aL+aAupug=
X-Gm-Gg: ASbGncs8VDD2hZ7TQ0g4PrHpFejbDeYpACIHRHylv1193cnA6ECm/v/zJ39GrsX59SL
	vxPHm3F7/2ywXewzRb0CUefqxgPNwDM5EW3TqRz5BK2tjSSrOuHw8i4qpkvKnx6pkQWq6ToD/B5
	EuahBJH2WwQkbUOQbGyC4cvBA8/EcWlkg2OcJnIM+dk8t7bopmQjDcD5uZegEBVktAFGFq5PzW1
	HoCiGN4U+0WwZzLGUjUUz6nozD9yuCU
X-Google-Smtp-Source: AGHT+IEwaEQOnGsnARBGr3xeupMy2phTmZXTuGJEZCsj1Dp52mP6s7xhLvUlFO8i94FavDtGwYr3+FXKGGQhYWqnqRU=
X-Received: by 2002:a05:6808:f0b:b0:43f:3d56:4dca with SMTP id
 5614622812f47-43fa4337201mr2833617b6e.50.1759350751961; Wed, 01 Oct 2025
 13:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com> <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
In-Reply-To: <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 1 Oct 2025 15:32:20 -0500
X-Gm-Features: AS18NWBsc1WeTorEJlVcceR4cL-NZe4hvZlUCilIVOfDJ0iEb3NXj0ni2aLcMpA
Message-ID: <CABb+yY1w-e3+s6WT2b7Ro9x9mUbtMajQOL0-Q+EHvAYAttmyaA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Adam Young <admiyo@os.amperecomputing.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 12:25=E2=80=AFAM Adam Young
<admiyo@amperemail.onmicrosoft.com> wrote:
>
>
> On 9/29/25 20:19, Jassi Brar wrote:
> > On Mon, Sep 29, 2025 at 12:11=E2=80=AFPM Adam Young
> > <admiyo@amperemail.onmicrosoft.com> wrote:
> >> I posted a patch that addresses a few of these issues.  Here is a top
> >> level description of the isse
> >>
> >>
> >> The correct way to use the mailbox API would be to allocate a buffer f=
or
> >> the message,write the message to that buffer, and pass it in to
> >> mbox_send_message.  The abstraction is designed to then provide
> >> sequential access to the shared resource in order to send the messages
> >> in order.  The existing PCC Mailbox implementation violated this
> >> abstraction.  It requires each individual driver re-implement all of t=
he
> >> sequential ordering to access the shared buffer.
> >>
> >> Why? Because they are all type 2 drivers, and the shared buffer is
> >> 64bits in length:  32bits for signature, 16 bits for command, 16 bits
> >> for status.  It would be execessive to kmalloc a buffer of this size.
> >>
> >> This shows the shortcoming of the mailbox API.  The mailbox API assume=
s
> >> that there is a large enough buffer passed in to only provide a void *
> >> pointer to the message.  Since the value is small enough to fit into a
> >> single register, it the mailbox abstraction could provide an
> >> implementation that stored a union of a void * and word.
> >>
> > Mailbox api does not make assumptions about the format of message
> > hence it simply asks for void*.
> > Probably I don't understand your requirement, but why can't you pass th=
e pointer
> > to the 'word' you want to use otherwise?
> >
> The mbox_send_message call will then take the pointer value that you
> give it and put it in a ring buffer.  The function then returns, and the
> value may be popped off the stack before the message is actually sent.
> In practice we don't see this because much of the code that calls it is
> blocking code, so the value stays on the stack until it is read.  Or, in
> the case of the PCC mailbox, the value is never read or used.  But, as
> the API is designed, the memory passed into to the function should
> expect to live longer than the function call, and should not be
> allocated on the stack.
>
Mailbox api doesn't dictate the message format, so it simply accepts the me=
ssage
pointer from the client and passes that to the controller driver. The
message, pointed
to by the submitted pointer, should be available to the controller
driver until transmitted.
So yes, the message should be allocated either not on stack or, if on stack=
, not
popped until tx_done. You see it as a "shortcoming" because your
message is simply
a word that you want to submit and be done with.

