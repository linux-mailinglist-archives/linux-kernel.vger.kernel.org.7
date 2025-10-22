Return-Path: <linux-kernel+bounces-864809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6CBFB96C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC6819A8088
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9F9331A77;
	Wed, 22 Oct 2025 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtZ7IAcJ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63432F746
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131810; cv=none; b=b31wIhjmLzQFEYpwvHZwEMRv0yF+92qDKrntH3CaF2G9KwmMi0mdivS1E2DqZ6kaJYBkzwTO/l8xGVgbBzBf8oxNSaBKzewPxmwP9lcK8LKr2NxpivRmKETdHJ3xiAGM7mrooTo1h3BC+VTUK0vD3sJXvmU76vV2jwiydWl3P4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131810; c=relaxed/simple;
	bh=MkLx2R4aQDQRSte1k6rDu2d4S0+mLWdRZ24YtDib+QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUHUBZT69kMTh7jqUxOzMCGm5g7SgtHad97uq1z6F/mnEvBV3LjYLoEKOpFQOFTBe4TknIX42cgbeSxVk9p9M5CLc8DIZqIxtrmh8nTmvYJTkpFaUCNkEsxTnktqOLPphLFcOSWGPUCwzYUByCMVkc5deF534G84mAwoczLQDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtZ7IAcJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so12687478a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761131807; x=1761736607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUpfROanALk009O5ukzxUjqqmJACMBILWAOKJHciC34=;
        b=GtZ7IAcJ+qPUT1UbyjSQlczc/FYy37J5wFuyZSAtHhyN8k8n4AQCldnUC7PgsdQ/Ds
         nQ9DwjeO5G3bQs1dfBeP0ZiaA3kwUeIuVqrrrDMmpvXtbKgkoC3YE0aRj0MSiIIjOQfm
         O0h28Bn0E38Y8RxtcMLU6yN6BOzpM0KSZALGkq+kphNBZkwBB1zabOwMjBnSGgIYLHoj
         eAPCezGxDjNyexsTJwbVrWuZkI1m6S0PagwCbHBXelSO40N+BIGIQkNIso4gV9LZIKak
         obLWnXS/nhyY3mC2H1SbOaX1toSgPt/gVJdbgNTrfE1lwxxiFxCyYLdjYTyDgoYgd7vb
         Oc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131807; x=1761736607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUpfROanALk009O5ukzxUjqqmJACMBILWAOKJHciC34=;
        b=MidyI0RzvX+y0dkJ5b/kLk/8vs5x44rIqZfMS7HH74J+AThs1LA1IA6Oc1L2ufsd4y
         uJuV/ZlnQiQMhRHjEdi7vUgh5+Upd+etX83jJhnam7gdUazVuOhj7ADeP5fcFTelgKcK
         KwJCOFywSld9YeNIA+fvNeBazEE9r8m052nIbzyA+X+V2HiRD23n5p+99cMIz0jupsDK
         BICjFFwkYTwtbAuCUBNXKnmP08lnOBy9a7nFp1XBk7kixvVITMTFAPxzjj21gpo6sgy2
         xVa5L9z37ZmjCSfoGOLMkVdg/mJ5/5DmfA7NVQ36ERNRrdWS6kXZbhJkr76diLkhGNXD
         N7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVsMcGucg8hP0UBUQ1sNeaoG83ejyLfUDhP+l9zlzHm5T2kmVKUTh7UHLUk2wBlRfr1EL5FR77JDSbe3zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrZYxbm6zETjDk7ins1DcA22A+0iTbruFHKafQdYPRKaqlN7S
	OLX0N5VMpMfTgVC8Z7NeBCBfMZcMBm5qVRifFloYdAzYKe248vrY3ll6Esdh2JsD0jthyC97rvj
	W4jp0swlGl/VIvA52JjH6Xlh9vN/XtoA=
X-Gm-Gg: ASbGncuWikxH4hpDG/ssR1HmI3sXVxY0f3D6Q9TFa7zhOY4OM81EOZID4OGQqtDOp47
	FSm4vf/9zcHgHOSI04rccfSuLnwnoJkeUGw4jnqsNryhaYRiV1FR+3e4TmGeIyAhNSlC0/irl0j
	DbjSdTDAoZ2gdZAb79nTBCOb4Yl5bqIxaheNXDTh4C8uZE2RwuoexL45u8hV9BixRsta+YsFzY1
	OgnA8QCHvlmLcene2hLPHfn6ZJY0HF2KpydfBPHG/fg6MgtBNQ1Sv/uMJ0VjMujIkX6+q6assM+
	ddoZCljvIKBLkAW2gDSQaZ4Q1g==
X-Google-Smtp-Source: AGHT+IFeLMsqZpbHAvlJBzKIdahXOOBShjYQZyOY7ATbt5n7WHdXXR/ON08TB4hturxLMLEB0GOq3i/bLAd52DC8p3U=
X-Received: by 2002:a05:6402:13ca:b0:62f:8274:d6bd with SMTP id
 4fb4d7f45d1cf-63c1f626dd4mr21176233a12.8.1761131807215; Wed, 22 Oct 2025
 04:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-6-alistair.francis@wdc.com> <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
 <CAKmqyKNBN7QmpC8Lb=0xKJ7u9Vru2mfTktwKgtyQURGmq4gUtg@mail.gmail.com> <4b2e5998-a646-4f99-8c87-95975ff8fe66@suse.de>
In-Reply-To: <4b2e5998-a646-4f99-8c87-95975ff8fe66@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Oct 2025 21:16:19 +1000
X-Gm-Features: AS18NWBDgW-hay2VUeCdIjfUCzoI0NhxABO1jEUfCaPHUmJ8eBnU71SyICyiPWc
Message-ID: <CAKmqyKM-uX6_a+Ru01RD3-CwoucTN7P_sU+d=MEKSo2pxG_tDA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:56=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/22/25 06:35, Alistair Francis wrote:
> > On Mon, Oct 20, 2025 at 4:22=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 10/17/25 06:23, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> [ .. ]>>> @@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void
> *data, int status, key_serial_t pskid,
> >>>                        ctrl->ctrl.tls_pskid =3D key_serial(tls_key);
> >>>                key_put(tls_key);
> >>>                queue->tls_err =3D 0;
> >>> +             queue->user_session_id =3D user_session_id;
> >>
> >> Hmm. I wonder, do we need to store the generation number somewhere?
> >> Currently the sysfs interface is completely oblivious that a key updat=
e
> >> has happened. I really would like to have _some_ indicator there telli=
ng
> >> us that a key update had happened, and the generation number would be
> >> ideal here.
> >
> > I don't follow.
> >
> > The TLS layer will report the number of KeyUpdates that have been
> > received. Userspace also knows that a KeyUpdate happened as we call to
> > userspace to handle updating the keys.
> >
> Oh, the tlshd will know that (somehow). But everyone else will not; the
> 'tls_pskid' contents will stay the the same.
> Can we have a sysfs attribute reporting the sequence number of the most
> recent KeyUpdate?

Why do we want to reveal that to userspace though?

Realistically it should just be ~2^64 and it'll should remain the same
number, even after multiple updates

Alistair

> Cheers,
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

