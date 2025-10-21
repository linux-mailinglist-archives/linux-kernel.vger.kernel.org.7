Return-Path: <linux-kernel+bounces-861998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F30CABF4371
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E80E54E6042
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFB21CC47;
	Tue, 21 Oct 2025 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf+6tmfG"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9286347
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008534; cv=none; b=JL1qWKgH1RHbght6eRGW9otQvwI4hD8hhjh6u3MvDf8KWLQ1KRboIhBDh0OdkINl/AgFn9vwMv3GiWiAu1mw5b1BXRzUJaRmOjVyCC4pKO1gzKCKKk5TfeKzF/JHqL0SrpZ/Ssbyb49/gwrOO+2QApcQkevmJQ8afGCYR9UJKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008534; c=relaxed/simple;
	bh=qZLBj6arx9QOTLUUblWHZMf3JCAP1L/JUAsq+xSZU/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8SuPAzUSbTakQFd8FtE63qG3yAQr7z3RVyAy0ATePLwF9hQlnlNYkvKbykk5wMZT1XzeedevHZQ9iJyvZHF5X3KGyafMOdq00Nxf8BGiuJYiva2wFamp2/zs+PdxweaL19N5ij9SOHUtUfCSWHWehlEcc6x6VqXyxEHn1TZgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf+6tmfG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3ee18913c0so956745266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761008531; x=1761613331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdrgppHkZAyxxVFGpYMxDncigVmTn7Xgn5GmJmM4fFM=;
        b=Sf+6tmfGpZDcI/M0c62kkU5qeaG/2FJJK5UAolk3tRNhBAOm9fD7xllxZXs93aSczH
         2DXzyVC6B75L7qaLqaqGSQSQ+gUXPllOtdPnS/BmxAccVCAa8WGt4D1l8vGuBXuiKdD+
         q5vbFhUvD1i8N52HiSj4F1TYmGeSlghHKiPMjDBdMMz50l4SoFnCOKfrNi0ZvSQ10nWQ
         dtw1kZ9GDeDIB7BIu+PRZXnxzALM/JhTUzSr6ohNGGhlVRxhercxLD8zeCKLqBI+zNTJ
         xCQwgAMz3szZQawuYe+Q8U6er4lCpu8VNS9mVGECfAw6ImjZOi1I9xox//02avtmC9fD
         e3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761008531; x=1761613331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdrgppHkZAyxxVFGpYMxDncigVmTn7Xgn5GmJmM4fFM=;
        b=bAuQmZ1FKIKuUanN6DOJbEg79Smj/SY+cS1ukH+pMLflvdwYP/j+HYq3A6bL/K9teo
         Gb8c+vK2ma+N3LbYGGCzCqdEMEI2+9JmyEiNG0T+AgnwgFPKQJXwsHYuoGfNff0twfSA
         aBUtAJAfiONIQywNtZTd/aMriYtO0bGVlCtoeqMwKuG1txXApxkEQ9Thog5SIBGcq4Va
         StUoPW2HGmF9qqkdf9wDj/KEUCY0nGajJCydKdoVfh4IZE8F15MDfRHQ2c6avb41m16+
         HRpepLmsYrhcLTBQz68xrDZCi969f8e7xiX16Np/uaUN/re3mJOjDp8baM5pZdSNOLlB
         7BUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2unMcuI0xF0bN6Y74GiRr1tI3z/4bO6eF13DJrQ2UPSHHgEa2/7c8kxAFxjfL69OLxtrYGFZiWkTadQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxMKRicDyhkVodX2Yb2n5jPors+P/p0GLQvPy0RH6CAht0IfID
	pbTEDMsdktY6MA2NUFEMWxBs1K07qxTTAN7CKKo0Nd5dYCVkhGfcOmHEnNLvN3Gr8k7bhe6P+6S
	97J8ljVMP75wq9c6BlPSqHhUXFbMR0xU=
X-Gm-Gg: ASbGncup5l7BF5k80ksQd+nUqvvp4RJ3C68I3ZQsIX0cQh765CsINnRTX3s4Y8fKPy9
	9r1dYIHVlyqG9oeBvDVhur5aaZuYQIPfUQ7TGj8Sll3F0+LnJz3oANtvE635EnjuNuVP63CVgbH
	u5YMv8+nLVPf/PUTosqrUu9V7s4MtEKch+krLzRxqiV5EX3MHNJ7GlEtH4gYy0I1Pw0BXoNcuB1
	+3kBLc3VTdwiYmBb4Igs+nVdPOgxAl4zZ6pznVJlb65npaVdaJDHPddbDJ6bSXTjv5vG6wUJ62H
	pIPYBNYXjN+r81s=
X-Google-Smtp-Source: AGHT+IEKUvPReN1WIc8WWqIkjL1j43sIvxC4HgtgT3kVUG9Iyo7fRBo0aTHcqpyZOi9DM/GsvtqbZf+qS2DkcF9tE4g=
X-Received: by 2002:a17:907:a07:b0:b3b:f19:ac7c with SMTP id
 a640c23a62f3a-b647443cef7mr1691282766b.36.1761008531342; Mon, 20 Oct 2025
 18:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com> <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
In-Reply-To: <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Oct 2025 11:01:45 +1000
X-Gm-Features: AS18NWDiepjJ-jRwTWQwDakRt00NDvcpR1iprtqV_ILiMUcAXQFVJU3hWPRHcZA
Message-ID: <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/17/25 06:23, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The TLS 1.3 specification allows the TLS client or server to send a
> > KeyUpdate. This is generally used when the sequence is about to
> > overflow or after a certain amount of bytes have been encrypted.
> >
> > The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> > can be sent by the TLS client or server at any time. This includes
> > when running NVMe-OF over a TLS 1.3 connection.
> >
> > As such Linux should be able to handle a KeyUpdate event, as the
> > other NVMe side could initiate a KeyUpdate.
> >
> > Upcoming WD NVMe-TCP hardware controllers implement TLS support
> > and send KeyUpdate requests.
> >
> > This series builds on top of the existing TLS EKEYEXPIRED work,
> > which already detects a KeyUpdate request. We can now pass that
> > information up to the NVMe layer (target and host) and then pass
> > it up to userspace.
> >
> > Userspace (ktls-utils) will need to save the connection state
> > in the keyring during the initial handshake. The kernel then
> > provides the key serial back to userspace when handling a
> > KeyUpdate. Userspace can use this to restore the connection
> > information and then update the keys, this final process
> > is similar to the initial handshake.
> >
>
> I am rather sceptical at the current tlshd implementation.
> At which place do you update the sending keys?

The sending keys are updated as part of gnutls_session_key_update().

gnutls_session_key_update() calls update_sending_key() which updates
the sending keys.

The idea is that when the sequence number is about to overflow the
kernel will request userspace to update the sending keys via the
HANDSHAKE_KEY_UPDATE_TYPE_SEND key_update_type. Userspace updates the
keys and initiates a KeyUpdate.

> I'm only seeing a call to 'gnutls_handhake_update_receiving_key()'.
>
> But I haven't found the matching function
> 'gnutls_handshake_update_sending_key()' in current gnutls.
> So how does updating of the sending keys work?

gnutls_session_key_update() calls update_sending_key() which updates
the sending keys.

When updating the sending keys we want to send a KeyUpdate request,
which is why it's a different flow.

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

