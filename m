Return-Path: <linux-kernel+bounces-837999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C15BAE32C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7283BF1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824C4242D60;
	Tue, 30 Sep 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpq4a5UF"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418412116E0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253629; cv=none; b=R43akThQCHGoGBkZRZPrgM80kDuTluh4BNhPsFUDyd/59KkDDTCNVohxjo4wajmRTmU8KyYKgzvfwtlQ6FoVRd5FzdS+xIwxOhRRvLEgB6UEOkaRd4iHWNmMB4v5ILicpYoGE6VbjM6EJ7UcIBF1imC7QOLvYqMqbzxcH6SQAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253629; c=relaxed/simple;
	bh=7oaqfY4n8gvCo3G5WCbSUF/1L0kT2TAijUBs8QVAX/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWYvQmYnZhNndbMlSoxwYUttPcNc0EAJKWq6OOZ4jkLZ5w2ALk45F/d76Tu48lMgHs7MVFTBhe6LEMLi3VlmbKm+uw3fsr8Rk09zKTICAt0TfmNcDyxArTWaYQmkVZ6Y+l39tkN4HLQSOjHVjCsfpK5aBHH3NVP6+jUlxTPhJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpq4a5UF; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-43f8116a130so1079260b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759253626; x=1759858426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOQJc76/bjfzUHkGEG4L0ifBSjFnFM5dvfGqeltjYHY=;
        b=Zpq4a5UFnM4wkNcemHIaWOwoN0YL3mMN0vgMhADhYWn4jonhuLJJH1wthtOKepgMcT
         NLkO8vN0am7ACUBhrIqGwvtEQZC8CK5Rgo4PdDwRrZhMQHgIQkSiCs3AIZBj1Cwhfko0
         JgEggNpPpha6oum7E/U5tRvDU7GkoB9ce2IXevkP/KvxosJ3FzoxEYoQBfRQDAtRFkmk
         Z8YsS6r+rjr1XJobofGW5XAUmYyL3EfXMUmmdNTEKY/Ga920UPd+0ndmM+k9wzIaMOfK
         rlH1evPNbsRfRZhoSJvFm9i+IX1yvYWXEzZALjNTNhnQQKnhgp5IVletkAvOyIELCbE5
         YSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253626; x=1759858426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOQJc76/bjfzUHkGEG4L0ifBSjFnFM5dvfGqeltjYHY=;
        b=L8u9/rYvZ84hpgv5nW4GRbkPOlviBFwWU2RRCCnF2Ys+Nit4RqToCC2kpTnJ1hS2a3
         keLhAMB3p88Kgq0BBp2mCH9HK6ZYOh67FrbCyML2W9ui+9oiV8rzfM9RYmSj7vuBXEoz
         UEPAsP64hxNqR+dhbJN/merOrlEcopETSWbs4mfNoTiXG+E0SPQNZB1gSCmRzWMfmhTF
         SDDAoaOlU/PzdII276ZTIFRivWyJPUarrEZdxX+wH6fHMQQGwgtGO13Cem1GhVUiq+9/
         pwzcmDUfJNqVA0gHYDpS3ULjzR2yRIlYBjJ57WrMygHSy8z94H2sk5S9BvVS0OmFKbdY
         s6+A==
X-Forwarded-Encrypted: i=1; AJvYcCUemZZsKVPFC3g0KSzb6VKumXylbNGnfYCp3bgUXsfxrMMrDktgUl+PEM8nLidZFJG+WYtGeHv3jjc4UGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTN6tMA2+YfcosclUeisUEKtY+6nI8ggVwRyNuJIrMUGAYlC6
	rRORZWOofmSAAUJuVc98rwAUGeQ8RmqDVGSWjogUjYkVvlXxW7NWg0gsFY8BBbGsJvCE96jqs7/
	5hJlM+H3ewogpnjAOh/4zv4lYXT9GjWc=
X-Gm-Gg: ASbGncuny33x0eYB6p8TxKFrkZxr0C0PQRK/erU8QNjdIYDJKSb936ZRaI4PVfYjqEC
	RfYcNmCeGgc0MLxhJCyt0ejOm5rtEKRuoPihC5FrIEaugAz8XeydscLtZhyEZ1hEWpMK7ExxhoK
	LCMbS48NYqXLRuEUz+bR+qcv9roSpeWOCWaOMXa+RC2nQI4sQMoDmQsOTnA239B7qAoq/GA1hyW
	NLFrPqq/qeFH53WjJVah/JXCDuEvSDY
X-Google-Smtp-Source: AGHT+IGpOWfgvUg+G2VayONLt47j/R1hMVCBp8a+ycGnyRMKxU5QNMPGQonL1pcFoIep0QFwgJqh3mF74MDopg4J1p8=
X-Received: by 2002:a05:6808:4441:b0:43f:6654:c757 with SMTP id
 5614622812f47-43fa57a45e8mr9771b6e.33.1759253626212; Tue, 30 Sep 2025
 10:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925185043.3013388-1-tanmay.shah@amd.com> <CABb+yY0MzJWOGtS=ocphpUVcJ-gb6_ENCjSmJQiWfRiOhxrpCg@mail.gmail.com>
 <3ecf0bb8-a1f1-498f-8b7d-39483a67cbfc@amd.com>
In-Reply-To: <3ecf0bb8-a1f1-498f-8b7d-39483a67cbfc@amd.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 30 Sep 2025 12:33:34 -0500
X-Gm-Features: AS18NWCDmfzO57z9_IeDFtwzy97PTjLYrAOUglA9BCgS4QvjFmFKG7a3d3QwQI0
Message-ID: <CABb+yY388YaM=wLMy1aaDT0E1yN=7Ge2taMWMyEhWvyqDV=3Dg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: check mailbox queue is full or not
To: tanmay.shah@amd.com
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:52=E2=80=AFAM Tanmay Shah <tanmay.shah@amd.com> =
wrote:
>
> Hi Jassi,
>
> Please find my comments below.
>
> On 9/30/25 9:11 AM, Jassi Brar wrote:
> > On Thu, Sep 25, 2025 at 1:51=E2=80=AFPM Tanmay Shah <tanmay.shah@amd.co=
m> wrote:
> >>
> >> Sometimes clients need to know if mailbox queue is full or not before
> >> posting new message via mailbox. If mailbox queue is full clients can
> >> choose not to post new message. This doesn't mean current queue length
> >> should be increased, but clients may want to wait till previous Tx is
> >> done. This API can help avoid false positive warning from mailbox
> >> framework "Try increasing MBOX_TX_QUEUE_LEN".
> >>
> >> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> >> ---
> >>   drivers/mailbox/mailbox.c               | 24 +++++++++++++++++++++++=
+
> >>   drivers/remoteproc/xlnx_r5_remoteproc.c |  4 ++++
> >>   include/linux/mailbox_client.h          |  1 +
> >>   3 files changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> >> index 5cd8ae222073..7afdb2c9006d 100644
> >> --- a/drivers/mailbox/mailbox.c
> >> +++ b/drivers/mailbox/mailbox.c
> >> @@ -217,6 +217,30 @@ bool mbox_client_peek_data(struct mbox_chan *chan=
)
> >>   }
> >>   EXPORT_SYMBOL_GPL(mbox_client_peek_data);
> >>
> >> +/**
> >> + * mbox_queue_full - check if mailbox queue is full or not
> >> + * @chan: Mailbox channel assigned to this client.
> >> + *
> >> + * Clients can choose not to send new msg if mbox queue is full.
> >> + *
> >> + * Return: true if queue is full else false. < 0 for error
> >> + */
> >> +int mbox_queue_full(struct mbox_chan *chan)
> >> +{
> >> +       unsigned long flags;
> >> +       int res;
> >> +
> >> +       if (!chan)
> >> +               return -EINVAL;
> >> +
> >> +       spin_lock_irqsave(&chan->lock, flags);
> >> +       res =3D (chan->msg_count =3D=3D (MBOX_TX_QUEUE_LEN - 1));
> >>
> > 1) If we really need this, it should be
> >          res =3D (chan->msg_count =3D=3D MBOX_TX_QUEUE_LEN);
> >
>
> Ack here.
>
> > 2) I am thinking instead, introduce a
> >         struct mbox_client.msg_slots_ro;
> >    Which is a read-only field for the client, denoting how many message
> > slots are currently available.
> >    The mailbox api will always adjust it when msg_count changes...
> >        chan->cl->msg_slots_ro =3D MBOX_TX_QUEUE_LEN - chan->msg_count;
> >
>
> It's not possible to make msg_slots_ro true Read-Only. Nothing prevents
> clients to write to that variable as far as I know.
>
Correct, nothing prevents a client from changing 'msg_slots_ro', just
like nothing
prevents it from setting tx_done or rx_callback to 0xdeadbabe.
The '_ro' suffix is to tell the client developer to not mess with it.
I am slightly more inclined towards this approach because it avoids
adding another
convenience api and is more immediately available without needing a spinloc=
k.

-jassi

