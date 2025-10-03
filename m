Return-Path: <linux-kernel+bounces-841312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EDBB6FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D4C19C0E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22392F0C44;
	Fri,  3 Oct 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HodfxINm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42E1C6FF4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497815; cv=none; b=iooLoJEnyBnPK+jZ+uxYU/MToTbbaelP9BuyFMtrI5Bu0ZiIhv4ny4qBDDOP3S9wE+HxGvx0Lg0l6ECzFQaptDhXWNCL6jqYnyaMPholud/fvtFGGwlRl2H6FQLhAPLbVBoFgptTAEsXsOYeB6iYDOOlTn9ONNgzsoq+/irjf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497815; c=relaxed/simple;
	bh=dsc0ppfIPY/8mXhi22n4Pmr2Qi2oy/rvVbX2avU6HNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF1Vup3G1UrgV6wvgbJw9L+PWboG215e98+DCfVQAgVf73eMytmIObANFy3Egj1tS89TaAd/hyots2fU4A+yV2muO4fHzVMvjmelfkWI1oWyCoQbnYWS5usSrJcOFMCMXRAh56qaJOcKrlOL74n/aJ3xISB5zOd3m2ZCkjEr+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HodfxINm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759497812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3OgrM6kqtp8r+T8wasXEeO2qtaqUyEZzjkjuxIwoHg=;
	b=HodfxINm++2lnUCJAgORolHxNFS8j2NMJoCS5kUkFYzLUAaBBDYczn6Wnvi0xGWDz1JozI
	NQTUh71/CjNs58PK5PzqU+AWj6UJUhKLjBASmcBg4iLsCfmP8cVHzH9fbBDqvhUYBoJjwm
	Ku18QXmWL6j7EbePPL79O3aJ4eeyCfA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-RfT0E-5wNyCGjW8ZXBYZfw-1; Fri, 03 Oct 2025 09:23:28 -0400
X-MC-Unique: RfT0E-5wNyCGjW8ZXBYZfw-1
X-Mimecast-MFC-AGG-ID: RfT0E-5wNyCGjW8ZXBYZfw_1759497808
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e45899798so9593115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759497807; x=1760102607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3OgrM6kqtp8r+T8wasXEeO2qtaqUyEZzjkjuxIwoHg=;
        b=hM5jHF2lq3d+IMsfw3XgobrPjdHxWo4nBgxi0htAaYoaelV8EJusyXGotlvWIqZm2N
         nkbbvwBppVYzgwmIDEqKdSAhNNn2Z2cLzNtOy+whk/0gLfNkifureIyy93hVRnJryRgK
         s7hkZ0isz0OerZzLiBu+4366LfFcvCzTZ2lKozO5HuohV6fBgcjYajTcZLWo/cfsqQyG
         aBhuCTDDswgcwq3QiazJUhgSGqH+6/NkHCftPVABe8jpDZV90b0nnFPlio0wbOFKdga9
         QErfuqNpn+9Ue/MDxekbcqd7p49BD6xiLHpCduYOBullCq+eJSTU9swCHhnA6USr+YZK
         DtzA==
X-Forwarded-Encrypted: i=1; AJvYcCVAoh9M3+/HrzGtxzp0pZUcC66e1yl90zsbBfAtmu/0TRV6ksWfEjEGZ3k15yosPfKuAjh70X7wuTqXVwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbUQLkyz7nNmy+/44XinCGu9eJK8sNH4wmi7elDMzXUgKrn9T
	LolKUgqkO01goEzunj0Jv8teWKNPnzjN2bxyC10bZ4UhPeIYVyoMIZ5gTUmgpTiS1pAaMfWLFsF
	ytXhQczletsFBREKLsBsZ5Is2KQ6j9TRHgfkcEb6EJL3IXkCC1RPQzLLV47zmqhzMcw==
X-Gm-Gg: ASbGncu5c+EoZU8RuYbKFZYtsfVPIP9QTVgnDkqCBJmzYyyzDFCukfbh9YVU0OWZQy7
	DUkPzuPv58qGT1l89wtSRaWH6V1hnhNAYDZrEMxszqO5BJCrwuM4OrSu03LCJ6uZGB2tkEfHkEj
	+51zHaboXka10qRjakl3yWvlC1ihZzfsR+sZLgnvCFZX3dRT7bsPzPl8IUEmpiDEQ4VuBt2WNwG
	k1kC9YHbN29LqAtwZ/Z1lyKcDJTY05s6Eg4I8s+4zsR0lYeNlJt4Qe4ClfjRd7ipPQha7p6xOPy
	90DW4ene8c2aaKQdi8RbkQ==
X-Received: by 2002:a05:600c:4510:b0:46e:59bb:63cf with SMTP id 5b1f17b1804b1-46e71140be1mr25355325e9.24.1759497807545;
        Fri, 03 Oct 2025 06:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOjaj75XO52nWI2I6UTsKjmFKM3jXrNLUe3y6zOumiOqPFkEXqNu9rSWvZBXSmGhaUe3KVg==
X-Received: by 2002:a05:600c:4510:b0:46e:59bb:63cf with SMTP id 5b1f17b1804b1-46e71140be1mr25355005e9.24.1759497807018;
        Fri, 03 Oct 2025 06:23:27 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b5csm7942733f8f.5.2025.10.03.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:23:26 -0700 (PDT)
Date: Fri, 3 Oct 2025 15:23:26 +0200
From: Maxime Ripard <mripard@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, 
	Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
Message-ID: <20251003-brilliant-golden-lion-fbedc9@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-3-jens.wiklander@linaro.org>
 <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
 <CANDhNCqS+WKhTWjeC7yBL+x4erK4S4bievTxdneaCu1haA8=hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bmweveq2oxpjd6s2"
Content-Disposition: inline
In-Reply-To: <CANDhNCqS+WKhTWjeC7yBL+x4erK4S4bievTxdneaCu1haA8=hA@mail.gmail.com>


--bmweveq2oxpjd6s2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
MIME-Version: 1.0

On Thu, Oct 02, 2025 at 12:45:41PM -0700, John Stultz wrote:
> On Thu, Oct 2, 2025 at 12:47=E2=80=AFAM Maxime Ripard <mripard@redhat.com=
> wrote:
> > On Thu, Sep 11, 2025 at 03:49:43PM +0200, Jens Wiklander wrote:
> > > Export the dma-buf heap functions to allow them to be used by the OP-=
TEE
> > > driver. The OP-TEE driver wants to register and manage specific secure
> > > DMA heaps with it.
> > >
> > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/dma-buf/dma-heap.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > > index 3cbe87d4a464..8ab49924f8b7 100644
> > > --- a/drivers/dma-buf/dma-heap.c
> > > +++ b/drivers/dma-buf/dma-heap.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/dma-buf.h>
> > >  #include <linux/dma-heap.h>
> > >  #include <linux/err.h>
> > > +#include <linux/export.h>
> > >  #include <linux/list.h>
> > >  #include <linux/nospec.h>
> > >  #include <linux/syscalls.h>
> > > @@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> > >  {
> > >       return heap->priv;
> > >  }
> > > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
> > >
> > >  /**
> > >   * dma_heap_get_name - get heap name
> > > @@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *he=
ap)
> > >  {
> > >       return heap->name;
> > >  }
> > > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> > >
> > >  /**
> > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > @@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> > >       kfree(heap);
> > >       return err_ret;
> > >  }
> > > +EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
> >
> > It's not clear to me why we would need to export those symbols.
> >
> > As far as I know, heaps cannot be removed, and compiling them as module
> > means that we would be able to remove them.
> >
> > Now, if we don't expect the users to be compiled as modules, then we
> > don't need to export these symbols at all.
> >
> > Am I missing something?
>=20
> For things like distro kernels (or in Android's case, the GKI),
> there's a benefit for modules that can be loaded permanently (not
> having a module_exit hook).
> One doesn't have to bloat the base kernel image/memory usage for
> everyone, while still not having to necessarily deal with
> complications from module unloading issues.

Ack. We should at least document it then.

Maxime

--bmweveq2oxpjd6s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaN/OTQAKCRAnX84Zoj2+
dtj+AX9Z6mfBBmJxP6k0eTgjg+qG1U5U8jSi9QuHw6zfKnsmrcwgrOYtur1R6Pew
cpDvn3QBfR0GnE+hRXWrYWoFPItAzGGTqManWkqHoYmL3MvlOwO7ECQmeIAe8L4a
Hi/ZAVgLUQ==
=rb0f
-----END PGP SIGNATURE-----

--bmweveq2oxpjd6s2--


