Return-Path: <linux-kernel+bounces-896303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BDBC50123
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F228189B79D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA202F60B5;
	Tue, 11 Nov 2025 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoP4witW"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D152F39B1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903951; cv=none; b=cvrfcj4lZGNZTsb+gS7CaZgFsiXwWXSDeRNmqfGW7R5XdbD1w4CLktMKGRmKEvRk6RPLUVhJeFgfWGEhSN2pv5DfxKrVNsEWaj7JXQQ6Jivl0uPe7mOCDlNjphVQLQUbpahEGI9yixFl/4YNSYl+gjbRETx/QvDVxe9ti92StF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903951; c=relaxed/simple;
	bh=dGmmDVhZWXvNAKzLPias817X9ESRrErZETjIHzyrXB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZXxS3tC+5G1ONhslD0wUqENFowGk4lKyld+jr/tg6NZKO38JkOvMG9qSvt3X8PIiyMpL0RERZXwu0y/04Lf+rYKy3iTDYDeCsw42rv2gioFU26Z7FghysQUFHA1Ve3nsPYEZtVudXy+0nCqpL78DU7BCMCrQNM3bOMdNYIRfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoP4witW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b72cbc24637so61936866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762903948; x=1763508748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reW2+QwMotnq4rhXvXOoTeWOCmK4BzSaoNoYEKFE2Nw=;
        b=aoP4witW+ElTWAkErjVEEqIdAlQwF8wsKL1QyyRCH0uAEG4J3ygk2iQ6znpGQyUdW+
         t2j0HvXJPn+Ea3D9F+z4dEacVLHqm4XaGuCBgx4S1Pkpf7JBRfUL+Q0hi1qW32E1fju5
         QOa0adJ+xdNsx52PNxVOMZ98kXUoV4I7O9tH9O3EY1XeQqpI9FZj9yLB8Q12sRH4rMri
         fBGIE0xQHAManSfHp6R7JSCzeu+p24qwzCSAvSEPzhQjef0rxTF3vzMTBzi6psC00Anw
         5c2vocOFMBq1oaXRVjHa6M75VyDXBXnwFrE1pU1MQWfH5GuU7U1cuwyMsmu4Kl8L3Gfy
         AjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762903948; x=1763508748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reW2+QwMotnq4rhXvXOoTeWOCmK4BzSaoNoYEKFE2Nw=;
        b=i97bpDJsiWmcCzngicEn/kGE5HmY88B4wtaXofReXN8msNfmTAk/30G3UweCZJS/dp
         gJhNR0Tz/CLtxPHig4os8D88cTHDa7KBWnyJVI2+RtlscIqU61D/BVK4rwZSuQWrR1S0
         3AJYuKgtJniJY5Ks987Aq5DZIW7xqWO1SdETzs1r5e2AypaP78JsSXTHGB5Gy8CKcutF
         yF+k+rUszyxwnH5WGjbrZAl+4DZ1Q/PKe2QdYk6RgfT1nkWo8yWiM7dzGl/J1fMPG0+1
         fsxnL0uyNON9oNhIe7TBnnbF37I8y7oEuP9jC8/vFGxR3B1LHm2CxxgxP+XOS2pZQz3C
         V5fw==
X-Forwarded-Encrypted: i=1; AJvYcCX9mVM5KIkJZfsYnpzaZMmyS5jpOYrF9ixMYm+Ljrt3WJ+ORXgKa5LxhSamzqtlk0TXmdz97TcArAoUl1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRWO649PrZs4TsMLAGek+gPy72y0wt2RYLvn67gY7Zj6sDxMa1
	aY/bo1ACU0HgH40j2VfrKoKXYZBRzZp9HUaIgMhgMirjFv5swFXE+sbp0FGtxf3pgKXl5MwNUVY
	C7szRwlSHXLEQAmqPUPN4k1eIv56ZNaw=
X-Gm-Gg: ASbGnctSP9FiY6RTBcRxgxJZ9Xd+lCtuaJ7hsjGLd/06SmRTzZcLfIcKUzd1e5LOpdw
	+hwbS0khJr8jh+GXYpf9ZKXaWRAgmsyzNE1PjB13K4uwE5bE3gEMI4MQZx1H9cGOaq46jfAikVF
	8FPNpwRRHW8XrObt+Yesa7YsRbqYBOrTubevko/ImRNBGfo1E7UvC6jugnrvOYP6d7G7FkD+a2V
	6vpo1kH8TNq4mXmLeestqydyfSviHUSTm05NKMvXmPKz5hs32FxiHlPz2AByoztD6yEKEaC2l+i
	hP4voLl2lwJXPzA=
X-Google-Smtp-Source: AGHT+IG3uw/6uvxht4oOdjOmi2F/0iIWJjYLpHYKQRgvzBx8kPjRQz3Jwr7IzYxm9dctoyz/qQl92E43O8w/1V+hTsE=
X-Received: by 2002:a17:907:a0b:b0:b73:21ab:7d52 with SMTP id
 a640c23a62f3a-b7331aec3a6mr86591466b.60.1762903947511; Tue, 11 Nov 2025
 15:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com> <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
In-Reply-To: <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 09:32:00 +1000
X-Gm-Features: AWmQ_bnjMYteWvIi4UzpsvFmh0JZtTtuo3DyWXAbIQxcyV3jCUaeqoz-YrmZSTE
Message-ID: <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:08=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/30/25 04:51, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > This can be done by writing the queue ID to te sysfs file.
> >
> > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> >
> > Note that only QID 0 (admin queue) is supported.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
> >   1 file changed, 31 insertions(+)
> >
> Please, don't. Currently we are using the same key for all queues,
> and we really should keep it that way as we don't have a way of
> specifying the key based on the queue ID (the TLS identification
> is identical for all queues).
> So we really need to trigger a replacepsk operation for all queues.
>
> I would suggest just allow writes to the 'tls_key' attribute; any
> writes to that would trigger a replacepsk operation.

I think the `tls_configured_key` is actually the better attribute to
write to as that is the one that updates after a REPLACETLSPSK
operation, see v2 patches which I'm sending now.

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

