Return-Path: <linux-kernel+bounces-875015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D5C1804F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3A642079C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61D2EA177;
	Wed, 29 Oct 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNWuKYHM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216E2D2391
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703814; cv=none; b=bXv5qLj/GvuxE7dmn4RyrsvlVASGKpsX/UPbQBjgUHpS/F8SVbGX6mJqqKWtUY0JJs96I8Wx/1aV1AEwkRDXmgx7NtSZaEQDVFiNYNnuFNrkjdrdbEo3QaeqCoZjjoFN6qKBjGWFiYq3EgEH9tjsWneeBqGDWHXCf2e2xZVVNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703814; c=relaxed/simple;
	bh=ZLh0HlWnhacXMlrR5BhoWOl5kF7rDUf50gDtd1Bbnt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9oLEBukJv3sQcWsXRYnMFF/FpXwGUsgtRj87Utgz4RTtnH/h0cF3MKhrdOmlz0UDRV6TSbccpQmtgtgVGMBdSFYzJkEhd4QG7adPQYEhFrJdAAva1TAIQ35SWsFNatm5+c9E0JjuTGbXh7TZ/pauJOcGQG/0tSUTVOObwYthCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNWuKYHM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-58b027beea6so2533e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761703810; x=1762308610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9lWbIyuET21BV3jefDHD4hEs4Ep+M4AnO2qpSJ9Lmc=;
        b=rNWuKYHMpoNsbW5MZAcQUpDba2pNTCv6mZEerDSRhHJizm965zTsuWMrOgb0R8ITUR
         rr5/Ohn5Is4dFNOzQ9B1yeof1eiAtkk5mbatfHxnHDdMgQYwllWgy7wXhkmHy8DyFz3W
         AmGYQsyC2TenwWnEhjUboECFWel6unfPTLF2mFXr2RdhCYfS/qMjZNT7689D1R5dfri2
         OWn6SAWIG4oSv4NYwGo96+WgT9y9oCOMB0tMrAKAfoDjnHznGFi4fVbsmyF/KB8d4AoC
         wNO5cr3HDJ9LhOO50LknuLgflpOdhedxRWZHgHl1fU6j/AJg2j7aTgD1CLGaQH2a4Rff
         nSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703810; x=1762308610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9lWbIyuET21BV3jefDHD4hEs4Ep+M4AnO2qpSJ9Lmc=;
        b=fjISPWO33+g2VynZWhV886eWNggbzJl/AWtW8IaA4wbxAAIgbx+7g+OundWQpi8a3c
         IhUynb3VxvX2v7cFjC/guQvAlbc7OmcsGcT8DkrJrza+bmF7SMiYzAbcOtz+5GCCUf72
         uiBYDeiH1Y0VuMhdfF+clKfPFmh7gk9HAWQcUILm2Y/0cQP+uGwWIn+OBvLigQKy1kPD
         jk8awi9nz9QL/dmGoO5F1Wk+fnAmNxC6PMhxB/j0GAgS8kdc4rVzjCQXf9B8+wI7bLnZ
         f8s2HIvKkbo+N0vJ9Zzph5kHi1H31hcdzjBKjw/Pj4KM5gMzgDJSFTVIIekOMWixWOq+
         TEvw==
X-Forwarded-Encrypted: i=1; AJvYcCVXR0dOGB1yXuZnNH2e7TW6LLwiK1DEAeorgRBsl8ceAc+GlTXaYACXslKyf/Ly3gVPSNDNKtl42qgSc3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDPj6Ss1pLPxoxt+IrNFhS+bfiRXGCxyacpawOOg5PiElcuJ2
	Sm8YHayaStO1IupfWNHjf1Lt7PbxoNsndgTma9JxvlGUwTkkJoWbf+SLTmR7J4hnCFAI7UmQTHr
	uh/HyrvjHkCalst8YV22UApnsriMZ8qyb3qM99NRI
X-Gm-Gg: ASbGnctsEyk0tsEFZfygd0Yo/Pd/oRfZtLjyKVJGgsYcdL0wzXkng4j568K4fSYhZ8s
	E4cRLA0eb/g7CdgdpY6dhN7LO1NWVMYulIsvpLAlhsKZboMB3DRDPj/8sF+sWemDYGK8TkB7Dxo
	XhzFA01F7wvDGqgFXIV6PL2h3YG3Hug8Cc9yvMtJ9eSSA32kt+7jIK/zLdeMJnjuLLN4U391bSY
	7APRVmNcqAEMNDSD1xe1jRpy3YARHQRawWRR7f7va0utU2Mj6ApIDFWZtXK3b5W+XzY3Bc=
X-Google-Smtp-Source: AGHT+IGl9Y9GqxxvDKMo/6fF2Rx0aNzgG8K8zH4GCOKZlaSF98H334A80Kbn6ua00QewNRYJME87yOhYU0lYXUUWLs4=
X-Received: by 2002:a05:6512:4141:b0:57a:653d:ff94 with SMTP id
 2adb3069b0e04-594133eb3a3mr127371e87.1.1761703810319; Tue, 28 Oct 2025
 19:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
 <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com> <aQEyQVyRIchjkfFd@devvm11784.nha0.facebook.com>
In-Reply-To: <aQEyQVyRIchjkfFd@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 28 Oct 2025 19:09:58 -0700
X-Gm-Features: AWmQ_blPOzhHIri3399hiWRunYMSkTopiADU8tgIF1xFYS1SKs5IrXz8b7aA-_c
Message-ID: <CAHS8izPB6Fn+_Kn-6PWU19rNYOn_0=EngvXyg9Qu48s32Zs9gQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem autorelease
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:14=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Mon, Oct 27, 2025 at 06:22:16PM -0700, Mina Almasry wrote:
> > On Thu, Oct 23, 2025 at 2:00=E2=80=AFPM Bobby Eshleman <bobbyeshleman@g=
mail.com> wrote:
>
> [...]
>
> > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > index 8f3199fe0f7b..9cd6d93676f9 100644
> > > --- a/net/core/devmem.c
> > > +++ b/net/core/devmem.c
> > > @@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > >                 goto err_free_chunks;
> > >
> > >         list_add(&binding->list, &priv->bindings);
> > > -       binding->autorelease =3D true;
> > > +       binding->autorelease =3D dev_net(dev)->core.sysctl_devmem_aut=
orelease;
> > >
> >
> > Do you need to READ_ONCE this and WRITE_ONCE the write site? Or is
> > that silly for a u8? Maybe better be safe.
>
> Probably worth it to be safe.
> >
> > Could we not make this an optional netlink argument? I thought that
> > was a bit nicer than a sysctl.
> >
> > Needs a doc update.
> >
> >
> > -- Thanks, Mina
>
> Sounds good, I'll change to nl for the next rev. Thanks for the review!
>

Sorry to pile the requests, but any chance we can have the kselftest
improved to cover the default case and the autorelease=3Don case?

I'm thinking out loud here: if we make autorelease a property of the
socket like I say in the other thread, does changing the value at
runtime blow everything up. My thinking is that no, what's important
is that the sk->devmem_info.autorelease **never** gets toggled for any
active sockets, but as long as the value is constant, everything
should work fine, yes?

--=20
Thanks,
Mina

