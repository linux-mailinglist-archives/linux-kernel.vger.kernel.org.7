Return-Path: <linux-kernel+bounces-880954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D7C27076
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C56A465D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958B313E2B;
	Fri, 31 Oct 2025 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idIKCFR8"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4A4A23
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945881; cv=none; b=om9TIbTW3KaXKOC+Tp3TvARx/qbb5iphRBLAPEuQSRpj8fBlYT/D0HXTUmH2OhBgKbJvPevo/vr6SVkqXeAYJAd7sKMJSsOPowBMlCJNAsEMuhZpFpgG4wk158V4DSMwCuGfR+U3kcXsPhEfosFsicpGWwTB+xLdyW+S85qEHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945881; c=relaxed/simple;
	bh=9s6lBULnUl/YSXyAoY1qCPq6/SaViqv68dbwmyDt25w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEXzWezXWDX4wOwOe3lksgzpKLdderbcqqw07OEa+rvKeCvNEZ1wJzhMT7NAIS6X48cyU0gByRpZFG45hE0ZFL71tYqJE7rZiKlONlw8oTh1ZmL1BOyBAmGO/dojY2l/azqTl4vp5+QhjmfDWuMyYVeOkhlfz6lh5c5j8GaPBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idIKCFR8; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5db2a0661e0so1393702137.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761945879; x=1762550679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpjoY1kBRDb3U8mH54r0lGN10P1a/SXqiDQkhCichcA=;
        b=idIKCFR8YC5UL1Un9CI2YkQgM2SRjJ+pKECR1yynggD1gm7kI54LAIapppmLBni5tt
         LZ/52BUEhUG0RPwnB9x9seGY/wDOHbjCaqw4ISaE/xDiFGxaBBWnw3rJuEQuMZYmzXw9
         KvcmNGcVDmu6qtMfeA/pKj/ny/oZ81ez2M5/5CLsBng4waeqdTSs7PlciUgye940GP9R
         SU7vyNboObFckmC+dv/UqL6CYtUT9Q6GxpoqbUq+n5q6wHiBg9Iee8veGvM9WDxf2uOU
         NN/ZcmER4yf5poKTLDBVAFTAJhLQszY1C9R3gVzOoGMDIEgfWeVBvaoO8oRe4v5hAoJh
         Qr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761945879; x=1762550679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpjoY1kBRDb3U8mH54r0lGN10P1a/SXqiDQkhCichcA=;
        b=K/Rh1+IMSuX8eCUTqEf5BTavZ6/uVt3FleatRMkM4YCyPH27aIveJYpUzywhW4Jbhb
         e1xlaJ/XvTNChzp/Ldi5WhYCaVbLw6v8oSQYMdV6gNepWgjlOiboENyD5OgPw2aJnLav
         OeR7jl/8d29IOra6RnxaiR6IrGuo806mt7SWzYNLa0DxB8F5TcaF3r1n2KW8+UxT5qsi
         yr2FzsI3ynOtBE4mMIcaYAPu9XHzQPmCL7ZlJGOZ6ndHyjWvCsmj/AOLECK1Vn+UjwLx
         4G93Mou2hngvwKQt9U+IFAkSBxazwHI7dj6IZlzvFo3RufvHYGxJv97YLp03QXWZdOw6
         fcYw==
X-Forwarded-Encrypted: i=1; AJvYcCWfwyXbItl01ol+I9i/xJ+W8vrivWwLdrnrcSW3EqGGi6Q7NU0uBlXs8V3wmlKIwEl6ayJ1K396m5cHXpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgzbOcIrr+/OLVOVEMqveYCrJ3bQ4BBbjUoJSf5ZS76rxl1NZc
	HGSn+Sl7jShO59nDo5lbfFiBE03IXcdEl5Z4HAloCY49xkkOceT8+xhES6DNFBsnUIJt1BOOmQr
	23JowfVyATTnvoI5m1ydVV9E55Gae9lkShWMZxyj5
X-Gm-Gg: ASbGnct5eu+jS5+evMUQhWUBWXYi/GUSls/Rl0djFl9JKRr/RPNZavoeoLWjc5PAR0Q
	EPdDrag9/xpiGIrg0nmFto8WvAxrhSo7jGMy7lJMsn6JFNTLQjPOXQEVhBwLoonTcfgrCpDSyJr
	xx8gooMICx8WG6OfhtJ1RldT1MjY3H1EiEcXm+OYFdpLLUm9WG81BqgufeZMAQ+uY8IAVj8u2TP
	F2qjxyiCPK7QIGiZxdXo39xcOF3x3nkFaHyjzq5A+p6Kxig6FrwA1so+derqApw1e5DWZkMnp2o
	5VBw7g==
X-Google-Smtp-Source: AGHT+IEa8weTwiMv4+k9b5iS3dxJo7V7HJI0Y2IJFPjlhSxnxnH+h+0r1Y3lLUHs6JV9h5eOAClJX8/QV7LblzeB9fk=
X-Received: by 2002:a05:6102:2926:b0:5d5:f6ae:38f9 with SMTP id
 ada2fe7eead31-5dbb13777d3mr2038618137.38.1761945878741; Fri, 31 Oct 2025
 14:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-6-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-6-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 14:24:09 -0700
X-Gm-Features: AWmQ_blW-_jGmkpvjMwaGlbcIquIU3vgzEhEhObtmLexKwiUx2hVmj47uKbslig
Message-ID: <CALzav=dmx9ykjujAN0EiM3FPE9dFVaX4oXk=3Er9frtzsUT+1A@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] vfio/pci: Register VFIO live update file
 handler to Live Update Orchestrator
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	jgg@ziepe.ca, graf@amazon.com, pratyush@kernel.org, 
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org, 
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
>  static int __init vfio_pci_core_init(void)
>  {
>         /* Allocate shared config space permission data used by all devic=
es */
> +       vfio_pci_liveupdate_init();
>         return vfio_pci_init_perm_bits();

The call to vfio_pci_liveupdate_init() should go before the comment
associated with vfio_pci_init_perm_bits().

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vf=
io_pci_liveupdate.c
> +static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_hand=
ler *handler,
> +                                            struct file *file)
> +{
> +       return -EOPNOTSUPP;

can_preserve() returns a bool, so this should be "return false". But I
think we can just do the cdev fops check in this commit. It is a small
enough change.

> +static struct liveupdate_file_handler vfio_pci_luo_handler =3D {
> +       .ops =3D &vfio_pci_luo_fops,
> +       .compatible =3D "vfio-v1",

This should probably be something like "vfio-pci-v1"?

