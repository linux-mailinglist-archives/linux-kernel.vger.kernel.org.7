Return-Path: <linux-kernel+bounces-698588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C6AE4700
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A863C4A1527
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3E256C6C;
	Mon, 23 Jun 2025 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="gGG3Pc4H"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC52241116
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688933; cv=none; b=durccTDKyq67FgJ+M+jOKhRjd5aoP+AVx4UDDN5/8upmPyIZdyaDV2vzlY+MdZfcDkeJ8NIs9iHafFM7TLq1qpnVlfgnZX3KX8zWv4RZKiEekYhpLCoAvAfB80vOVKmCljaTEkPrFYwMmc/iCZOIhNlDHomGlrLVLUAU2uyWfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688933; c=relaxed/simple;
	bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhZiAYfTLCJm6aE2F3C4l2DpOKccojXAfxFvrLB6A6qdO8zrNDQ9hEFip+RPRx3ZR5+78W2Yf2nl2J1BVKdP8BOfdROyCEqTpPj3CUw+xQCsS2IOQXJdvarbW7DbCA8Ram3fhvR4+S3xD/mUbawJoZ3jeEkuhKqq6ziDQ850Xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=gGG3Pc4H; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a44b9b2af8so20584821cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750688928; x=1751293728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
        b=gGG3Pc4HaxosWf5dMaa+c/J3BbeyQ3nBdt1Z1bcgahYj/++kkU4K3oOnOzwDHkvgo5
         /fKJBOBLhmXf1XhwSejoDNSqtrdxIMLwS8bJyccDKvZzwbuyWbPQmKp/ccpNLnj1z+wU
         r+XcSMoUCpUEQ4N1C8Gobr6CozOBzG7Nebo4doxW6k/3FCl44cX+Dsd/e9EW0nQJz43X
         iBqk2APQE9NJt1OXz5SiZ3jYdqLizYH7JDip1faAfaMO1Rp3rJPuKBD5lwOcbx2epR4F
         +5WdhJ9ukYoSNwE0Cr5Mvm6TeunTmawLmGTxsq4L0i5VC92rTOREwNXhH1uLGVzAe1+w
         t4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688928; x=1751293728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
        b=II2epRBpcGrbzb3Z1fmP9r3tHut5FVr/x/xFkXlN+9dDmWzrty2m/FUx0RSNGdNlAV
         GaTwuQhZSakIXCzdAlVz7N0ioerNZaTlIZZZExjOiEhv9nQB5kfnh71xuPMQeiTW7nlY
         /0iUi3U+IrCedaG92pJyOxOuXnve5zY+i7qyJ3DjxRke1clcG9ZghnT+02VlbPfQFVut
         i2vAJ0LgoshH7WhH72QrIbqVKdedW7tXkLpDIaVaxoBGzVFGjHWEqZ4maGc+FRVwFqAJ
         AsAiZr4CoplDzQzgYUAyDRoIjldAikglp2n5AMU0Js7QVBc9jnUMBjASQZp0C2nIMKcI
         n+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUQhETtzTVqAqumnxAKpoBqH2XoJ22rYzv5fuQ3vyZqGKlbVufDxlIxarj1qWSWuM3MLF3Fqab0x6K/nog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpaai5lz3z9erXwjuCMYwWTIs3dl0PQir71se22R2AKvntzIM
	/n9CYJRkTSJ+hSMsX4eGbGm53Bu4klwX1/HV1kKgjl34zWXMr6x3iWcHIq9f615ffFlPMo+2PSA
	8ExMyvq0yxXYEDFoJAGxBFR4+hgstPoSfyoRalrCoMA==
X-Gm-Gg: ASbGnctDLh+KvUHvzlJ7FkT7+BeI0eNwHIW6FryWVt4Fymn07mtsEjywf0iE27F9ktr
	WhG/Z8o3XzMNW2twDjrVYrx8Zkkw5uSehVYYk12I/wf4uZPGIza8IlM1smlp4H8DAIHQwzQVIgz
	PE4YmeMGDC59XAV7N+XGUvu1MhPryClxQfwqQXgHTq3daisV5p9nS0HdI2eGoiRaR9pzsygNCkq
	VjxJw==
X-Google-Smtp-Source: AGHT+IGAEU79vWFsEbGN71mgZpuPejwVzDs9CuFGRu/kIPPECPSaBJWX6S8IOXgJzNmRFrQ3GoKYDSjB9QaqmPokmug=
X-Received: by 2002:a05:622a:50f:b0:4a7:146b:c5e5 with SMTP id
 d75a77b69052e-4a77a20840emr222574351cf.21.1750688927718; Mon, 23 Jun 2025
 07:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
 <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com> <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
In-Reply-To: <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 23 Jun 2025 17:28:36 +0300
X-Gm-Features: AX0GCFu3hePJcE8mBSHlKXkSVpPD8N_41tEP_O5fU60lBvVDsaWZNc7CeBwagRc
Message-ID: <CAOEp5Oet1P2EWTwLJnMYY4CVAzDWgdM8wbvV3+BH6aY0kE+O8g@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jun 23, 2025 at 1:40=E2=80=AFAM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > > Yuri, can you help to clarify this?
> >
> > I see here several questions:
> > 1. Whether it is ok for the device not to indicate support for XXX_EX h=
ash type?
> > - I think, yes (strictly speaking, it was better to test that before
> > submitting the patches )
> > 2. Is it possible that the guest will enable some XXX_EX hash type if
> > the device does not indicate that it is supported?
> > - No (I think this is part of the spec)
>
> There's another question, is the device allowed to fallback to
> VIRTIO_NET_HASH_TYPE_IPv6 if it fails to parse extensions?
MSFT expectations for that are at
https://learn.microsoft.com/en-us/windows-hardware/drivers/network/rss-hash=
ing-types
If I read them correctly, the answer is "no"
BTW, my personal opinion is that placing all these things with hash
calculations into kernel instead of ebpf does not make too much sense.

>
> > 3. What to do if we migrate between systems with different
> > capabilities of hash support/reporting/whatever
> > - IMO, at this moment such case should be excluded and only mechanism
> > we have for that is the compatible machine version
> > - in some future the change of device capabilities can be communicated
> > to the driver and _probably_ the driver might be able to communicate
> > the change of device capabilities to the OS
>
> Are you suggesting implementing all hash types? Note that Akihiko
> raises the issue that in the actual implementation there should be a
> limitation of the maximum number of options. If such a limitation is
> different between src and dst, the difference could be noticed by the
> guest.
>
> > 4. Does it make sense to have fine configuration of hash types mask
> > via command-line?
> > - IMO, no. This would require the user to have too much knowledge
> > about RSS internals
> >
> > Please let me know if I missed something.
> >
>
> Thanks
>

