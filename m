Return-Path: <linux-kernel+bounces-774772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE3B2B74A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CF2E4E3803
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326229E115;
	Tue, 19 Aug 2025 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M00/pavj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124F2882DC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571738; cv=none; b=cqiWzEnBt0P57NP10RkeuM0aqwv7ZwUA2TssLvPC4oaNr86zBddtzuW2+z9eBd0gHBK7gK2eAWxJe8Gs48rOFsSFTjK03g8SS8fix/Qhjuxt4BW0KuIFy+x/3pAE1hIPFf+ZipWsq2yVra21swb1Ru6BX7hagav29bdeFd5XSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571738; c=relaxed/simple;
	bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDz/hri5jL1oYVeqIvWY/PX+Zka6rFpLmP0ReMAid/IkEfrBP6e8nF+3V/+4HSI9QpN9LQRiV6wC+J+8Oy9UTfe3bi3clri2iZqW9BMnMavmLA5DIPtWWYHjTBQLMVoEi2pUfMiHh8aFg1Zltf1sBEJNe0k7vc4i/LDfre+gmuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M00/pavj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755571735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
	b=M00/pavjlU8vzskX9xzbXJjKq2utamOvyhWXQN9ZX7zwAJfLcqCXkjU/F58+7Q0+4px+lu
	dGAoJkQwM0PR96Vwa4rl1tS+c5QlNTWfFGvErV3ECXlTlx0dj6g5Mwi5SWHhdMcbp7/1dE
	fmlbPgXzUmG8QpYL62J+ZlBnT1VrtQM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-PCouq-ChNPWEuU2biT61ow-1; Mon, 18 Aug 2025 22:48:53 -0400
X-MC-Unique: PCouq-ChNPWEuU2biT61ow-1
X-Mimecast-MFC-AGG-ID: PCouq-ChNPWEuU2biT61ow_1755571733
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32326e017eeso4691969a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755571732; x=1756176532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
        b=Z0Np3Eq0LGRydwIzrh4D8IhbaPyhYglJGDqWcEvPePlzjgffnf7tPpBM5dwXFBL75Z
         RB29i1Lsp5KLzVmVdw3IKNjNOAxCOmyozEMzZZqqWKo/EoVxVB3GsUKLT8N3mKSj1oBR
         xNYx68a4yDZ2gxP74W4GVf4Mi4U9iLJ9mpKIoFYPQoRBs+tXscY3DnasSgF0Fco/aQoB
         Q4U4+4mjlnKusfQo4RLaOQvlfSWI8Z5iQew/7xCqWyQw6vR2Oze6kDbhGZFRZaSrVbZy
         CNAsEoveRI8cSXPgBsSzDV5FLZaKtzWdVHh56VLjOYNusS2YRYwPaR8cNcCXRUZHjFsx
         oK2w==
X-Forwarded-Encrypted: i=1; AJvYcCW3l/0lcs1i4WZJrGORESc+ehKoR4yy4abgE/usukJCS0CWlAo1ZsbTh82PzzRj8BeXWIqgfKg3e44/gbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNt2zI7mzHcT9mb3C75oLPbO0E6f/lhvjT2la+RaLxYBs1Fvar
	6YPHjqLVBrk4gJScParlzsPxvPxscrZ7GXIb12u7RWWevrDOuOeNI1lGCYroQfde3/fXual2q9D
	bl3W2zI9D9d2cqjShwcW+y6G1/1JX301LjDakOKMBwBIuKE5NTrUV8diX/QtKDNJendRgPyW5u1
	27ZYfHqrodPw1irUMGsj9mKUs/+HmmO+1dgz6yr6Jv
X-Gm-Gg: ASbGncu3iziX/ONViYQfyF2koV+ijItos1WRABW7a5bR3PTiTk3ewovtleUcwP1H5my
	84xVV4RsmTmWhGCYrVf6pBqBaJNn6OHgmDbbQ01hsE3pcBpO9K5cEC4jZ8EX5T7Pke9TSWo+8vg
	7nkJWftP+cOHCY6AuoDmMmEf0=
X-Received: by 2002:a17:90b:388c:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-32476a6c3b0mr1536794a91.21.1755571732544;
        Mon, 18 Aug 2025 19:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6dKD0oWKP+FU214PIKLYVdhY8eEWItrOTXjcxGw6l+G1j5qcpIfVxj44ZLVtPTiZnrRSk7uCddgfYxZ/3F0A=
X-Received: by 2002:a17:90b:388c:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-32476a6c3b0mr1536750a91.21.1755571731921; Mon, 18 Aug 2025
 19:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815085503.3034e391@kernel.org> <CGME20250818011515epcas5p21295745d0e831fd988706877d598f913@epcas5p2.samsung.com>
 <20250818011522.1334212-1-junnan01.wu@samsung.com> <20250818083917.435a4263@kernel.org>
In-Reply-To: <20250818083917.435a4263@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Aug 2025 10:48:37 +0800
X-Gm-Features: Ac12FXwGjt0tc43brXAcZucIny41hc0azUrrUQ6OWLOA5fDrbWEhAZEnJ-HtEtw
Message-ID: <CACGkMEsVJcb2YYvfXYA0soE++cPEmQatkC0tB+shNKB=OTteWg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Jakub Kicinski <kuba@kernel.org>
Cc: Junnan Wu <junnan01.wu@samsung.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 18 Aug 2025 09:15:22 +0800 Junnan Wu wrote:
> > > > Yes, you are right. The commit of this fix tag is the first commit =
I
> > > > found which add function `virtnet_poll_cleantx`. Actually, we are n=
ot
> > > > sure whether this issue appears after this commit.
> > > >
> > > > In our side, this issue is found by chance in version 5.15.
> > > >
> > > > It's hard to find the key commit which cause this issue
> > > > for reason that the reproduction of this scenario is too complex.
> > >
> > > I think the problem needs to be more clearly understood, and then it
> > > will be easier to find the fixes tag. At the face of it the patch
> > > makes it look like close() doesn't reliably stop the device, which
> > > is highly odd.
> >
> > Yes, you are right. It is really strange that `close()` acts like
> > that, because current order has worked for long time. But panic call
> > stack in our env shows that the function `virtnet_close` and
> > `netif_device_detach` should have a correct execution order. And it
> > needs more time to find the fixes tag. I wonder that is it must have
> > fixes tag to merge?
> >
> > By the way, you mentioned that "the problem need to be more clearly
> > understood", did you mean the descriptions and sequences in commit
> > message are not easy to understand? Do you have some suggestions
> > about this?
>
> Perhaps Jason gets your explanation and will correct me, but to me it
> seems like the fix is based on trial and error rather than clear
> understanding of the problem. If you understood the problem clearly
> you should be able to find the Fixes tag without a problem..
>

+1

The code looks fine but the fixes tag needs to be correct.

Thanks


