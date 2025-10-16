Return-Path: <linux-kernel+bounces-855557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B86EDBE1A03
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85F7D4E45E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463EC253F1A;
	Thu, 16 Oct 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haEb8pIB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CEF242D70
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594654; cv=none; b=uOxhYtsslscL2QXcO1OVyl+3nW9qQHJF67Wl+zkFCj2b1DeCKVkekpUWJmTLn/VgCwVjkRrHjbzjxK87AIHMd60/EXhjkz45xVRZF3r7tgk3ULwek4Q5S29AhcT/0LGG8ov251p/fVwq4RZa/0/RjungEnCO5cbGcmQQkuYe7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594654; c=relaxed/simple;
	bh=fzWQ97isS0aFc0gzpnyA+DyrdqHK5QpHgLLtTb5CyoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3Sccl1hewaLiE61EE/yAsASHQ1qEQIB4tA0yibSMp5Vvdd7G9SJ4j6PIX2aUFIxFYTY0XXBg6B6iGqdBATmzAnPiDJNThPFp+4qQ1s6b+tNilNfX4V5lM+7yOgb/2J5+T0gVEO3qQnCtvzzuZ5EYbPLnB0DLyQZ8r/7NJQ5oXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haEb8pIB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760594651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBDQEp6dY6z3vDFe/pLFiO7hi6/5jG11qLJqUUlD44o=;
	b=haEb8pIBleEHEsfYgeO8oF8HuRhLUUL2ux+afJqc9WXSNHadoo6KU5Xoi+WlIY4Tcfc0bF
	wj9Ik3Z6etFuZCFsp+DaTS45HOenfIZHitewpLMdAxfK4Ciz5sWueWvnfCHrrKCqQy1OWH
	u72P1kLTLSmCI1M1UuGDJm4XYNO+tSA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346---thNSygPC-Pryq12pi7qA-1; Thu, 16 Oct 2025 02:04:10 -0400
X-MC-Unique: --thNSygPC-Pryq12pi7qA-1
X-Mimecast-MFC-AGG-ID: --thNSygPC-Pryq12pi7qA_1760594649
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b551338c2c9so270699a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760594649; x=1761199449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBDQEp6dY6z3vDFe/pLFiO7hi6/5jG11qLJqUUlD44o=;
        b=HIDo+0ZLSmc2R73jo4HBXDUq6JryzGPRWnfXvLaFtf9LneUvmg7YThzflohzAfqgEU
         fNWlsIpqUVk3Ol4dtlLJ4A5kBJZX21nQluzTfzKJz64CitRjqdPKUNGyJUEXBSbergWe
         Pum2MTgPsWzeuTl0LQgRNzw3oWzAlrJef7kYf/PItyaK2FW1Yl0deco8zMikFhLyP5s/
         /FUeh9PtJuAFiL0DuKgdv0uF4ekgXsoRgoahOVsnlhaZ5jV99v38/Lr3L3pk6FGETMOP
         qcJVqWZqRSLU7Tfy4qE76TW5eXsTNRlH1Elmh4XdvfLvwqedzTabIfnIzUrsmzlarryw
         PvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNCP3By1j+nEsQoyhIWNvbfGhpZO+91xnbMKlkm3qgwF1sg17QLr93rtZkch/C+xr2tpbIdvscZaJa3hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0x8faFVFZdvCe+qEyMGm8tBNDZq7h76Ek/BnIoFOvZts7VdYT
	GeWsislGYigcuFlnh2zlx2eBaLIIY/pPKutEK6XeSfVLv0/33RCgR6nM0gJ2lmmIYAYft+N2D61
	W8xgkMvGW7AZoIzyMy2RLrIuCzPxzLx1VUMz/WbQcbbjojk5Gb1JAZCosfDq6lm2oIPXrTi7JgU
	8Zhr60E4w/VYjiU7kqOUpcG5OehHJ64kghTGxeaJM0
X-Gm-Gg: ASbGncsu767XjPMNfI7EUTGCjATW9P3vNvQxB+MAagcZRR3v6F4+6wz007uselp5VgZ
	CquA/LOv2mNIQ4qtmU8W15rAzLZnAcj7XFNJCxlJDyFVC2rnMrMG+8y4ywCp4Rw+YB5SVCmuVXY
	xk8f3oFOEKNOKD4t1vjS1Wre98To2lV/6l55y0GFw83T2vQD8PKbEj
X-Received: by 2002:a05:6a20:7287:b0:334:79cd:fb13 with SMTP id adf61e73a8af0-33479cdfd6bmr8988329637.4.1760594649024;
        Wed, 15 Oct 2025 23:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY+kHqhWF11sY33iOBSuNwi2TBCw0YITrMKtg8kGnHaEECZ9BwvNrmu9v04hgAF1z9yPKYxqRrVB94L6OvOt4=
X-Received: by 2002:a05:6a20:7287:b0:334:79cd:fb13 with SMTP id
 adf61e73a8af0-33479cdfd6bmr8988300637.4.1760594648627; Wed, 15 Oct 2025
 23:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com> <20251016014328-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251016014328-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Oct 2025 14:03:57 +0800
X-Gm-Features: AS18NWDuqYwgVzom1r2COmBXOe_87iF6tjmm9zly1hmhVkJ6KXe7eh1hEIR66RE
Message-ID: <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > >
> > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > 100 messages to enable/disable promisc mode - together they
> > > > have no effect.
> >
> > Note that there's a case that multiple commands need to be sent, e.g
> > set rx mode. And assuming not all the commands are the best effort,
> > kernel VDUSE still needs to wait for the usersapce at least for a
> > while.
>
> Not wait, record. Generate 1st command, after userspace consumed it -
> generate and send second command and so on.

Right, that's what I asked in another thread, we still need a timeout
here. Then I think it would not be too much difference whether it is
VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
can only advertise NEEDS_RESET since it's a device implementation.
VDUSE can not simply break the device as it requires synchronization
which is not easy.

> But for each bit of data, at most one command has to be sent,
> we do not care if guest tweaked rx mode 3 times, we only care about
> the latest state.

Yes, but I want to know what's best when VDUSE meets userspace timeout.

Thanks

>
> --
> MST
>


