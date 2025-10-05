Return-Path: <linux-kernel+bounces-842472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCEBBCC8E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB7018949F0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4EC2BDC1E;
	Sun,  5 Oct 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7ggeLPm"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CE1CAA6C
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699761; cv=none; b=Prgr8yUn01lgKEcPaKhE+f+InnyFUMhQGkRzHXRznXEx3+M6De9dkqka2BRisVDjjUpXIWPTuBV4rIYrsx4IhPnmexxVOTNVd/oYHI7+ngV+gKRstnS6UFSDlkj/EHqRTdzBh/Pjgir5opqMrQHBOVlb+tZScTvAz0wyiw5vLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699761; c=relaxed/simple;
	bh=jwBiU8rBJyfy0hIrN+9UdEqQBiAEMFjI/OXJALXj3EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz3ft5tY22vG2t45wevxLippv6EUsOW2puDP8ucS3u0qvXMBNgj+6bacX8wp3B8yAkxbgs+zP6NlNUD5PaNBBZC19ss2tiJqVv37CDcnMA7LYJvYljzTY7mTGKK/HetINENaPTqdn9eVe+6VcsLFS6did4MbxC8JKFMNnlaqWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7ggeLPm; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-64e3e259f93so2063248eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759699759; x=1760304559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o2TOg0k6IWIl8VdR4B9mf3AL58I4LVgFxkfcM+WkCU=;
        b=Z7ggeLPmy5hFyDBsUr/hZ45CpjeZ+kMWm/Ei+n3+pkwQ2GUZJmPfMuuCnVvvIt5KEc
         gACVlfwQV4AVszshRh3r/YeUmh9X8mGFn+MiZAaHWtKxk7IXitnOy1ZXnjorqs25WyNU
         OX9zsxAchl4hiTnWruqChCMG9TAv+5sCMxDm5qB9POTkyE6jkvHZlECG/1cnomQo6FRv
         3xKjCIMdK77vALFQLym7fuyMw8r42HMP77/7CUtHXwE9f3AyGeJgJrSS6VTHGF7djrAA
         AmaURLVNpHr0gXnbVjNOiQBmY13jZyMamHcf+ldG2i3F8xRvOhLTVVGcmPKNJ0QXcnzh
         4YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699759; x=1760304559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o2TOg0k6IWIl8VdR4B9mf3AL58I4LVgFxkfcM+WkCU=;
        b=uxpFuyJPThZaw5YrUBtq9OK2AyNS2fN49JIV/rqdsUkXAMhj9Y4djwsj478V2irreO
         G+byUEL+VtA+K7StdQPfSkNrhncDfHvbF888gg507m3tEiLVmUEed6VpmkdTqq2wiwqT
         DTIztU8CqgJsTb9Z7sZ65u6ZAw50F6S7GZVZX54r+XvIRu5L/AE2/z0WAZnXsLczVtTV
         qMorBi9U7BRIlt1O6zavxfF65oFBmL9YFcJMlSGALLHMsP5l/nk4e0uyW3r0Z3JB5sv8
         5c4xoX6dzrR0I40REx2olJ9xPK85z9yMT08IJhCG1TXFcF2Lzk1ZsX0q0HyrPrW0BGgw
         h4kg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Tysd5AuZT9geXU5dEBIa/EdFYMPRTXD8iRIAwv06irDtzNznwkgbcIw8vS6/mREMlMoeeWlW3BONtYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7BeGDS5ZdynXQgplq6MNTRuV7zU3ck7o+/ytLMN0WsGlR8O4
	5uzCX2/3ZxOCFlHyRY6PiOAiSx3iHszkz/vEMJ34Y22JA6t5VUZYnynyWq7qotoVwYdJ1FAUfkR
	K2D83NTHJSABa2OLrlQgzbI9B4gOV2KU=
X-Gm-Gg: ASbGncvNEHPlbkQELLcWzuBNU+4TlMS/X8u1cwPTU28BBB0xqKY/vmkealbfAtxm7A/
	E4fm46ReQeDtFBvVvygHSjEuaUKr5TK9UwhOiMa0gMW0jHdGNpAVXAInW7oX702KtzqtwoNf5jG
	ZV/4ZEWelkyAOQOcFCBFo7nUaXeoQ9XkQ7SEH+Acl1HvAGAyUMcuR+2psaFoKITS5o+YCwrF8pA
	bcIiooZ9y1rEyn0wOP1OLEDbG9+p+Xk5qM54YZJ7A4=
X-Google-Smtp-Source: AGHT+IHSD/taCi9Ux6T9oOEN+76qc9NZsXUV4XRYcCBn5g+09Kgy6Q5JWqCYduGZS5k+iG7g7Y9+SQg61aT7cbUXawM=
X-Received: by 2002:a05:6871:5823:b0:3a5:81b0:8339 with SMTP id
 586e51a60fabf-3b1018ad4acmr5552603fac.31.1759699759141; Sun, 05 Oct 2025
 14:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
 <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
 <CABb+yY1w-e3+s6WT2b7Ro9x9mUbtMajQOL0-Q+EHvAYAttmyaA@mail.gmail.com> <3c3d61f2-a754-4a44-a04d-54167b313aec@amperemail.onmicrosoft.com>
In-Reply-To: <3c3d61f2-a754-4a44-a04d-54167b313aec@amperemail.onmicrosoft.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 5 Oct 2025 16:29:08 -0500
X-Gm-Features: AS18NWATM3rjVCftataNysY7UQuMLs5RrQDj0NVCBPWbbYhYtZsdg0yjDMjBqRU
Message-ID: <CABb+yY2-CQj=S6FYaOq=78EuQCnpKFUqFSJV+NHdLBjS-txnAw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Adam Young <admiyo@os.amperecomputing.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 6:17=E2=80=AFPM Adam Young
<admiyo@amperemail.onmicrosoft.com> wrote:
>
>
> On 10/1/25 16:32, Jassi Brar wrote:
> > On Wed, Oct 1, 2025 at 12:25=E2=80=AFAM Adam Young
> > <admiyo@amperemail.onmicrosoft.com> wrote:
> >>
> >> On 9/29/25 20:19, Jassi Brar wrote:
> >>> On Mon, Sep 29, 2025 at 12:11=E2=80=AFPM Adam Young
> >>> <admiyo@amperemail.onmicrosoft.com> wrote:
> >>>> I posted a patch that addresses a few of these issues.  Here is a to=
p
> >>>> level description of the isse
> >>>>
> >>>>
> >>>> The correct way to use the mailbox API would be to allocate a buffer=
 for
> >>>> the message,write the message to that buffer, and pass it in to
> >>>> mbox_send_message.  The abstraction is designed to then provide
> >>>> sequential access to the shared resource in order to send the messag=
es
> >>>> in order.  The existing PCC Mailbox implementation violated this
> >>>> abstraction.  It requires each individual driver re-implement all of=
 the
> >>>> sequential ordering to access the shared buffer.
> >>>>
> >>>> Why? Because they are all type 2 drivers, and the shared buffer is
> >>>> 64bits in length:  32bits for signature, 16 bits for command, 16 bit=
s
> >>>> for status.  It would be execessive to kmalloc a buffer of this size=
.
> >>>>
> >>>> This shows the shortcoming of the mailbox API.  The mailbox API assu=
mes
> >>>> that there is a large enough buffer passed in to only provide a void=
 *
> >>>> pointer to the message.  Since the value is small enough to fit into=
 a
> >>>> single register, it the mailbox abstraction could provide an
> >>>> implementation that stored a union of a void * and word.
> >>>>
> >>> Mailbox api does not make assumptions about the format of message
> >>> hence it simply asks for void*.
> >>> Probably I don't understand your requirement, but why can't you pass =
the pointer
> >>> to the 'word' you want to use otherwise?
> >>>
> >> The mbox_send_message call will then take the pointer value that you
> >> give it and put it in a ring buffer.  The function then returns, and t=
he
> >> value may be popped off the stack before the message is actually sent.
> >> In practice we don't see this because much of the code that calls it i=
s
> >> blocking code, so the value stays on the stack until it is read.  Or, =
in
> >> the case of the PCC mailbox, the value is never read or used.  But, as
> >> the API is designed, the memory passed into to the function should
> >> expect to live longer than the function call, and should not be
> >> allocated on the stack.
> >>
> > Mailbox api doesn't dictate the message format, so it simply accepts th=
e message
> > pointer from the client and passes that to the controller driver. The
> > message, pointed
> > to by the submitted pointer, should be available to the controller
> > driver until transmitted.
> > So yes, the message should be allocated either not on stack or, if on s=
tack, not
> > popped until tx_done. You see it as a "shortcoming" because your
> > message is simply
> > a word that you want to submit and be done with.
>
> Yes.  There seems to be little value in doing a kmalloc for a single
> word, but without that, the pointer needs to point to memory that lives
> until the mailbox API is done with it, and that forces it to be a
> blocking call.
>
> This is a  real shortcoming, as it means the that the driver must
> completely deal with one message before the next one comes in, forcing
> it to implement its own locking, and reducing the benefit of  the
> Mailbox API.  the CPPC code in particular suffers from the  need to keep
> track if reads and writes are  interleaved: this is where an API like
> Mailbox should provide a big benefit.
>
> If the mailbox API could  deal with single words of data (whatever fits
> in a register) you could instead store that value in the ring buffer,
> and then the mailbox API could be fire-and-forget for small messages.
>
> I was able to get a prototype working that casts the  uint64 to void *
> before calling mbox_send_message, and casts the  void * mssg to uint64
> inside a modified  send_data function.  This is kinda gross, but it does
> work. Nothing checks if these are valid pointers.
>
Even if you pass a pointer to data, what validates that it points to
the correct message?

API doesn't care what you submit to the controller driver - it may be a poi=
nter
to data or data itself.  Some drivers (ex MHU) do that, and that is
how you could do it.

-jassi

