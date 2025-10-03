Return-Path: <linux-kernel+bounces-841376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E0BB7212
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A9819E10C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4674A217648;
	Fri,  3 Oct 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeDEWomn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1D20A5DD
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500734; cv=none; b=QRSdi2RVQqjVwCuVdw0TvEE0NycroqFyemnBvtKpuCQH3QC6gzLJEo1Ix4M4+OylSqZQsGrqux0Hitq7ZH3F99wCoxFmXa3Kn2IYKvwFrAsRGPCV8geHUwrze+f5pa6nGmtuXYKr+oFy5D6lqRS9GoxIY+SYuQ7O7nclixoXDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500734; c=relaxed/simple;
	bh=fGLQZPdCvtcHc2MkDN2DGhBQlUE98zkGacuiPRbjY3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY4rG8LnPutQh91w4UQOwUJM0dVeHPrVMaGqp05Nv/aB31IfawW6+waIrwbtdB9Yumat3btGpSLLiO8HIVLByU+AEHlZtHuEYA+Yrb2O8SYxrCNG5C4ucS9sVRqU8mkZEFCI+7FsICkUG6KhXzePU6enySZx6uvhgIUlh+bCosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeDEWomn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759500731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIh0ta/ySV31IDAsjscXZdxDAf93kz39y+kPAUa/I64=;
	b=DeDEWomnhxZIw0Jb7AAYMjg+Rnm1OL84Dp6RNn/E1xD3M1d4Lxe0vDwVvkke9sPrTfUU6o
	npRVV1dhzIvwW++lbrFP6qI2yY1duEwmTcHcBXphFtygFsieDGkrl6in4sOcIFxwmV5Sx+
	5yZM47X70MDrzB//xXq2frvEALkvMAE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-57expxQ5MPiI3MgUC2v_Sw-1; Fri, 03 Oct 2025 10:12:10 -0400
X-MC-Unique: 57expxQ5MPiI3MgUC2v_Sw-1
X-Mimecast-MFC-AGG-ID: 57expxQ5MPiI3MgUC2v_Sw_1759500729
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so15906495e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500729; x=1760105529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIh0ta/ySV31IDAsjscXZdxDAf93kz39y+kPAUa/I64=;
        b=FR8y/zYwwWXUTBkggMRr9h4CCPcyZX9tpv0LxlVpsEGxWe+4vIWF15PniPvU7kVTTQ
         yJ7CpZ6D/CRU0Eq1hTVhIuo9O6esoT0WksWPiEcYGUpkNGYtyBzeFig4Hx0fNMF2DvhJ
         boFoAgitCrOX/q+vHI9pQwVwQbZNOzxVWYigGa5BIpQtxZd7RgFjuYy0XmLeEY+Hfg0N
         aWKp4Dn0cnH6VEAAHbX3Qmm0w/XJXDwbagXd09NXfcDOYdD3Z90gdty1ILBnXzNtLFZN
         7X6BzRBQvoo7NcNV1bxj1kr6T/UfJxbaHujyBu9IQD6aoWFYX274Nf390CyyU7AETCXH
         oD1Q==
X-Gm-Message-State: AOJu0Yzh3VANhRmCRg9VYYIVNK+/HQIZhslLvIvPlAwfE3UCHex6eszo
	FZp/LkYb+D1gr6Z1/LrMoaCUbvWxwv64jPml/cgNnU80kO6tJxmJFutNUwYDZSDn7/HHGu5EVk7
	/xrLj+T80pRdrCp9Lhvpy7hP3/B0f83vRxSU2iVVM1338IfEu2/AzypEZFU0LOEeV7g==
X-Gm-Gg: ASbGnctHqg0RI/d26irXSV/9cywi8Eng9/1nDK64vzNt4Kv8JNF7uoJVP9gMBOqQgPu
	srwwfO+Rxmv+djBjwalp+Z7PGZi9Hg7fMho1vpM5V+KQlIPEj3zDNeJ3bN1rz8HHv2yGerMcwkc
	Cvk94gwGEt437i0bVrtE6F3Lx+6ehLr/oNXBde4YwmO1e9jAW/Ck+kXg1n/f1MBPK0o3cbOMSZO
	SbQUeBUwFQmuJnW2XHaiYEwIfc87eiGCNZju7BUAa/oTI8XtZjk4+VUGWj0uFXKQVzq0aGPVFDV
	1P8Q6RFDsl4xvYBr9fSVEw==
X-Received: by 2002:a05:600c:1986:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-46e71109f78mr19836915e9.13.1759500729010;
        Fri, 03 Oct 2025 07:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvZE78Vlry2HWGKctUpuvV3NYdSpp6VF7NSq0LXvMOwPsaZRtbqFATFnYhybF+GpisNk1RcA==
X-Received: by 2002:a05:600c:1986:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-46e71109f78mr19836735e9.13.1759500728555;
        Fri, 03 Oct 2025 07:12:08 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f69bsm36548575e9.8.2025.10.03.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:12:08 -0700 (PDT)
Date: Fri, 3 Oct 2025 16:12:07 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, 
	Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v12 3/9] tee: implement protected DMA-heap
Message-ID: <20251003-majestic-indigo-emu-d9dbdd@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-4-jens.wiklander@linaro.org>
 <20251002-sceptical-goose-of-fame-7b33d6@houat>
 <CAHUa44H3nGgY9q68YRRp5A7Q6Ku3P_URuv+L7H8chYzLAKd8mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="uh2g5nrijwsim4uc"
Content-Disposition: inline
In-Reply-To: <CAHUa44H3nGgY9q68YRRp5A7Q6Ku3P_URuv+L7H8chYzLAKd8mQ@mail.gmail.com>


--uh2g5nrijwsim4uc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 3/9] tee: implement protected DMA-heap
MIME-Version: 1.0

On Thu, Oct 02, 2025 at 02:57:25PM +0200, Jens Wiklander wrote:
> Hi,
>=20
> On Thu, Oct 2, 2025 at 9:54=E2=80=AFAM Maxime Ripard <mripard@redhat.com>=
 wrote:
> >
> > On Thu, Sep 11, 2025 at 03:49:44PM +0200, Jens Wiklander wrote:
> > > +static const char *heap_id_2_name(enum tee_dma_heap_id id)
> > > +{
> > > +     switch (id) {
> > > +     case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
> > > +             return "protected,secure-video";
> > > +     case TEE_DMA_HEAP_TRUSTED_UI:
> > > +             return "protected,trusted-ui";
> > > +     case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
> > > +             return "protected,secure-video-record";
> > > +     default:
> > > +             return NULL;
> > > +     }
> > > +}
> >
> > We've recently agreed on a naming guideline (even though it's not merge=
d yet)
> >
> > https://lore.kernel.org/r/20250728-dma-buf-heap-names-doc-v4-1-f73f71cf=
0dfd@kernel.org
>=20
> I wasn't aware of that (or had forgotten it), but during the revisions
> of this patch set, we changed to use "protected".

I think protected is fine and what is documented in that patch, right?

> > Secure and trusted should be defined I guess, because secure and
> > protected at least seem redundant to me.
>=20
> Depending on the use case, the protected buffer is only accessible to
> a specific set of devices. This is typically configured by the TEE
> firmware based on which heap we're using. To distinguish between the
> different heaps, I've simply added the name of the use case after the
> comma. So the name of the heap for the Trusted-UI use case is
> "protected,trusted-ui".

I guess my point is that, without any prior knowledge of how that heap
works, I have no idea what the "trusted-ui" use case actually is.

> What would a heap called "protected,ui" represent? Protected buffers
> for a UI use case? What kind of UI use case?

I agree with all those questions. They apply equally to trusted-ui and
secure-video though.

If you want to have a vendor-specific name, I guess that's fine. But you
should at the very least document what all these heaps are for and the
subtleties like the set of device that can access those buffers (or how
to figure out that list if it's somewhat dynamic).

Maxime

--uh2g5nrijwsim4uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaN/ZtwAKCRAnX84Zoj2+
dk9GAYDf6fryp88Ahl12b+j+v2rumlMEN3n/cHougouDTADzYYFHD5FrzdVXoXCH
2w49Sa0BgPbuh4M8qU3Ly9kSPtLFD2tEJs/iA5V+MezAw2Egx8cvBUXOLP8pdylA
HFFK1Cqtug==
=PVWB
-----END PGP SIGNATURE-----

--uh2g5nrijwsim4uc--


