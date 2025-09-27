Return-Path: <linux-kernel+bounces-834998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C8BA6002
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B654C23F4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043651DE4FB;
	Sat, 27 Sep 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl8taeLZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC871A3166
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981373; cv=none; b=H6uI3aNmkLbIFAhZ+MNqu3iouncFIP/KakhxZDSV0Fbjge6wAcZGwV7K36MnM0MWQmYggkgzv6SLHmMcrWY9sckv+CZEqrWKgLIv3M0T6oXSKQez+2yGv0HraYqW6Mjgr5S6EHq05/NYXPDLUMFL19plRF5Q7mcdaddM/D9VL2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981373; c=relaxed/simple;
	bh=ureChU45nREqUmvZTTVk+SwNTIJzvHOY5zs5cEzl+t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6rrMsSKzRe+aW7hsm1gsiDCZmaj+rslcgMpXUIzU5WhWkrHXfUvnTr5IUxdvRvm2bWQq4zi+SiRge1/Mf/O57XYuoxunrRC/cOM3fbPF/W7tRjkttO6I7bqspNPox80WPmw9oZzjXkbeZ112gtoBNNOIh2LX0OAK0/H5nMfw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl8taeLZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e3ea0445fso8028585e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758981370; x=1759586170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ureChU45nREqUmvZTTVk+SwNTIJzvHOY5zs5cEzl+t0=;
        b=Wl8taeLZnSuAkaYOcGiWwHKKI0GkeDjdflDaWh6frmYQL0Z+k0Xx3jt3oZUPBO2PqF
         98avA75obFkBGIjilt9vyuxg1DdCi5eiI0RN29bC1O3+2BOewamOw/Ff1Y8evzLlX5Ln
         eOI6Axl76EKmWtoitIKbIDFVB70ixzJ4AJrqQNLXYjq9degIA7/ybCmsXwt1qb6QS8tZ
         kcsqJBgXoL5Nph4MZ7ld9jxvW/lmD2u6bOU6wOGhdctGysb1alze/Ijnxyr/jcD0Phjs
         mvdJG0EDXfS9RaQYlmg7AvXfTSQFB5lDfQjcn8weyOwqNvjftEPUMqvxbcYg3uB5k4vc
         fU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758981370; x=1759586170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ureChU45nREqUmvZTTVk+SwNTIJzvHOY5zs5cEzl+t0=;
        b=Mom+IuYRf+CUSPzsZJUL3ptQjZ7VPmQwpKzSWVo3efs4sKLrAbUJZLA7W9eRbSTszH
         u+t3mqi7d9+iFpqQbaWcb/yRESJLaQxqXcrZm/KCohpzQHYgm6LcNG6VUQnR24fjJe/5
         iygDuN0S6JyDatznMsmI0ZhSo4/kdoYVV/M1MQpvThn5uT5BkvOqKfaqX3Tue3m4nvrx
         G6jAyqu7i0LuBKLiaOM8zeY2c9cw1QQMh9mBNGHUoteZXhUoeLX49SeL/8xQUjcVhsye
         IarxBmT8mwtlJRUcdOdOku5XybN+842tIwzaZcvFn292cnkic8yi6qQ+Ps8LwJb1Se6P
         DO7A==
X-Forwarded-Encrypted: i=1; AJvYcCVsDEEhAtUUvmBANX8mf0RVziWYVMqRur5veGFPI/q8BCG58Ma2PEHxYntu1ilpGA7Kj/kk+ycf9peLIKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt702DKEsZku5wI8eMIZjXno3e3Ja6v1tMEooTFLi6ecuYrHwh
	P/0RgqpN3inBVBzytua2y4s6OYX16bZcwjvEMKJmR+EDIxhZuqU6ZVjhozV+rsFH7VBHOx/O+n5
	HofrlGojCYcKANUlyY9zAAMVGCEVM12M=
X-Gm-Gg: ASbGncvKzROqPUJdTRJ6lNO1vjUzGjS9CiKj0srfo0SDQGQEp1a9kwN79wxinGTmhDI
	C7uG2qjAbPEL/8lVXeVzYHsHsGbLdc0827WhM7pqmZoeMM43N7mhA9GcrSZNxaZ3sFicS50C/QY
	EfUf8NRduBbsNx3/JplZE0U3ohll6GdK9v2NxdeUIRV/Ln4P8XOTS5hsp0AvTjmjpp+phNq06Bt
	y+OEBHXxiqMBwu0LRxslOKrVx0ugBCILrgrXtcCaPNKlmTl7eGsd+MIj8CVTTLJFa0fg0agn4BY
	2V6P/hYj
X-Google-Smtp-Source: AGHT+IGr8zOK+RC+hHIYloBf/M6OFm9CLonT2X9KL0+nRhOcgIc58bzH/HUeqmIKXIC0EyAYm8IIg0+2JgEjPzNIGIA=
X-Received: by 2002:a05:600c:3594:b0:46d:7fa2:757c with SMTP id
 5b1f17b1804b1-46e329eb02fmr105794995e9.19.1758981370031; Sat, 27 Sep 2025
 06:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912163043.329233-1-eladwf@gmail.com> <CA+SN3sp6ZidPXhZnP0E4KQyt95pp_-M9h2MMwLozObp9JH-8LQ@mail.gmail.com>
 <aMnnKsqCGw5JFVrD@calendula> <CA+SN3srpbVBK10-PtOcikSphYDRf1WwWjS0d+R76-qCouAV2rQ@mail.gmail.com>
 <aMpuwRiqBtG7ps30@calendula> <CA+SN3spZ7Q4zqpgiDbdE5T7pb8PWceUf5bGH+oHLEz6XhT9H+g@mail.gmail.com>
 <aNR12z5OQzsC0yKl@calendula>
In-Reply-To: <aNR12z5OQzsC0yKl@calendula>
From: Elad Yifee <eladwf@gmail.com>
Date: Sat, 27 Sep 2025 16:55:59 +0300
X-Gm-Features: AS18NWBlYzv4rg7URg9J1v208P3mV2tQeMkzKbuflldE-TNBrvutb99r7dTcmXk
Message-ID: <CA+SN3squaSg08e=GKLZeStS3bSaKQZz_n0SWOB=Cv8cuLhO1Vw@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action
 for nft flowtables
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:51=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
> You have to show me there is no mismatch.
>
> This is exposing the current ct mark/label to your hardware, the
> flowtable infrastructure (the software representation) makes no use of
> this information from the flowtable datapath, can you explain how you
> plan to use this?
>
> Thanks.

Thanks for getting back to this.

My goal is per-flow HW QoS on offloaded connections. Once a flow is
promoted to the nft flowtable fast path, nft rules that set packet
marks are bypassed, so a driver no longer has a stable tag to map to
HW queues. The conntrack mark/labels are flow-scoped and persist
across offload, which is why I=E2=80=99d like to expose them to the driver =
as
metadata at the hardware offload boundary.

To address your =E2=80=9Cno mismatch=E2=80=9D concern: this wouldn=E2=80=99=
t change the
software datapath at all, it would only surface existing CT state to
hardware. Could you advise on the best way to proceed here? Would an
offload-only exposure (drivers may use it or ignore it) be acceptable,
or would you prefer a specific software-side representation before we
add the hardware export?

