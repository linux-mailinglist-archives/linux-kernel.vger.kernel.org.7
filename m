Return-Path: <linux-kernel+bounces-840240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50350BB3EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E438116B1BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5931065B;
	Thu,  2 Oct 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="uAa/gtdX"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52330AD1B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408846; cv=none; b=Xm+Q9kqQIpCB0hybIzSCBxLQyIQYzVzie58dYcdChqaoey9HCNRth0ZUGrG7QvuJUmxjWOSgEpSwanCPkeBOWnc+lG7W6ANpN0gNX1aQjUpQ1OXVTft83btinXZhnzH9eVy/QmDa5ANy4CtUM44Yz7VkH/V+u94GsQdn7TNMHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408846; c=relaxed/simple;
	bh=dqw7ChviJ3egtYgDVIDKcHGr1DxNENX9MEkcL5O+J18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QC3/9XYQlGqjqmMO60BYX0kSgmT1Pjw0ucpSzpNQZ2R2ziBKdcUIRChinq4VsJ35ALJOglP3i3NokZ6WJB9XxHr/1sBJQZwZYCgKihNkLvs7Ay7Atsxfr60/Wx6yHD3sYFKikkxrxpJYrGeDRoMc5YNdpwUVPQ5AjkZYRyCfpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=uAa/gtdX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85cee530df9so112790985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1759408844; x=1760013644; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tG3CglHbeY/0AI4Rz2tx44tc/toPYUH7TVppo+t14c=;
        b=uAa/gtdXfc4Q5ihBR3N1ZbZqySJIDCcUexroTl7r5ktxyaHy3dYIu4TmWko0190BdR
         RD8F8Ko/GNWNAF1o1ixgedBSIVSFBC7G5vS0WiqPZYNo690na9iOrHzb+0L7f5uZWRPI
         8PWizKgGgvEi2yfIeLmpP1t7q21JppXj6lDQ/KbL18VUXZYsadmKetOKRvH8bl3R4UP2
         pxlXjnfkQtmo3MihCA6+XklUh4XAAKXr03DL1aQHTjxY+QyRISa61ePwIUEsu2ZGxFiT
         K6YyrZYoX7yoyEVQ5MJ5fRpkBGMQANfEwArwy6zaRaIwHGO0vhCY8Fy1nJhr9Ated5Sn
         qlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408844; x=1760013644;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tG3CglHbeY/0AI4Rz2tx44tc/toPYUH7TVppo+t14c=;
        b=pdN9XWLEc1Dd22b+pdOR/TDmtvp5t+i4xxj5f/uo4jN57uoODPp0jOjVp5SoWT9mFV
         IruffFjBGPiD39wZtUiKOctnWUwSab8Y0o9TXDtmiTdEDTkANpbOZK05uf8yaxBz+BTb
         wp4hUDsntg00seOPXv0/S3eQSugEoHb/n9Jz8HV3p/HPAFw/m+Wd90IZyUlN4HfMhR0I
         tWm5bIbJzTPz/lNWqn94tWySis3EuDCeX3mDqlj9zw0QvqmV++8VJoxQxnRbHFBBW4WE
         cVUWOeFtIsicYEYukQyOXDU+1JIlIOTgrSNq3UF0DlBcNhHWlVuMwMlbRYf/og9Qglq6
         8ToA==
X-Gm-Message-State: AOJu0YyNHB6sCghCZwIVT6jcRz+4W872Y40/VIKPajPvdMsjKYNjSdC/
	Ykw0QidG+92O1+1r+O4HzA6PVp5PCP3CpYP9ayTPoda8x1s4oKbxwpbR2meZ3GHudtk=
X-Gm-Gg: ASbGncuIv12WojHM1rqf7xybHonU4bH5/TYJa1ALI3asqhxYrLP+Kq9DdqTtFpdlH7F
	I1i3iYpHYcDzvz6NyQrXoT74zGp/UGBEUz3WMo88hHraHFZPdJy5efYAjNIODU7VhGjUNea3TlQ
	dDjPP+6UOzX/+ioPhmqRM1FyaLc+yqtuDbFSPmGkSeb19yl6eW3UDtyUNBq46YakrEn3IKJAx4q
	DutpHQb6BOsmuLQWKwEnhJu4g61qhFWtlmRzzGrD5Gt77fgLhl7Zr1h4PgS/YpLGKakpKUre27j
	xYjKht/5JtKfUht2BtaWikH6/2vWe6ULy8A1K9UZopZYq/67AXhk6GXQ6nS1iX3hpbzinim+/5o
	QKTN9HuBa5zLhZFtvk1xSLdg/6eW7oSgUTYWF3xrHryWWemWtXk+LrJiKChIbO9Q=
X-Google-Smtp-Source: AGHT+IHfFbRDc0lxQJHEnEb/USvJWquapfe/e1sD30gNrrrl/FzbGv+DojWArzyJNLJRhyT1vMSzeQ==
X-Received: by 2002:a05:620a:1a0c:b0:85e:5022:33b7 with SMTP id af79cd13be357-8737780ae60mr1022559585a.72.1759408837081;
        Thu, 02 Oct 2025 05:40:37 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:ebd3::5ac? ([2606:6d00:17:ebd3::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129fcdsm200898385a.13.2025.10.02.05.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:40:36 -0700 (PDT)
Message-ID: <9ca0e8b7b644637101f8bbc3f69cb71f20665f04.camel@ndufresne.ca>
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Maxime Ripard <mripard@redhat.com>, Jens Wiklander
	 <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, 
 Olivier Masse <olivier.masse@nxp.com>, Thierry Reding
 <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>,  Sumit Semwal
 <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey	 <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T . J . Mercier"	
 <tjmercier@google.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com,
 Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone
 <daniel@fooishbar.org>, Rouven Czerwinski	 <rouven.czerwinski@linaro.org>,
 robin.murphy@arm.com, Sumit Garg	 <sumit.garg@oss.qualcomm.com>
Date: Thu, 02 Oct 2025 08:40:35 -0400
In-Reply-To: <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
	 <20250911135007.1275833-3-jens.wiklander@linaro.org>
	 <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-45N4bvp/oD9a6lFdlKUD"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-45N4bvp/oD9a6lFdlKUD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 02 octobre 2025 =C3=A0 09:47 +0200, Maxime Ripard a =C3=A9crit=C2=
=A0:
> Hi,
>=20
> On Thu, Sep 11, 2025 at 03:49:43PM +0200, Jens Wiklander wrote:
> > Export the dma-buf heap functions to allow them to be used by the OP-TE=
E
> > driver. The OP-TEE driver wants to register and manage specific secure
> > DMA heaps with it.
> >=20
> > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> > =C2=A0drivers/dma-buf/dma-heap.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 3cbe87d4a464..8ab49924f8b7 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -11,6 +11,7 @@
> > =C2=A0#include <linux/dma-buf.h>
> > =C2=A0#include <linux/dma-heap.h>
> > =C2=A0#include <linux/err.h>
> > +#include <linux/export.h>
> > =C2=A0#include <linux/list.h>
> > =C2=A0#include <linux/nospec.h>
> > =C2=A0#include <linux/syscalls.h>
> > @@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> > =C2=A0{
> > =C2=A0	return heap->priv;
> > =C2=A0}
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * dma_heap_get_name - get heap name
> > @@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *heap=
)
> > =C2=A0{
> > =C2=A0	return heap->name;
> > =C2=A0}
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * dma_heap_add - adds a heap to dmabuf heaps
> > @@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct
> > dma_heap_export_info *exp_info)
> > =C2=A0	kfree(heap);
> > =C2=A0	return err_ret;
> > =C2=A0}
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
>=20
> It's not clear to me why we would need to export those symbols.
>=20
> As far as I know, heaps cannot be removed, and compiling them as module
> means that we would be able to remove them.
>=20
> Now, if we don't expect the users to be compiled as modules, then we
> don't need to export these symbols at all.

Maybe I'm getting out of topic, sorry if its the case, but making that a ha=
rd
rule seems very limiting. Didn't we said that a heap driver could be made t=
o
represent memory region on a remote device such as an eGPU ?

Nicolas

>=20
> Am I missing something?
>=20
> Maxime

--=-45N4bvp/oD9a6lFdlKUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaN5ywwAKCRDZQZRRKWBy
9KyVAP0e+zNS/qwzQzV67XRNZS/HR4iYLotJyohgk+o985wA0gD/cUs7EW6a2cas
LUv2nPsRzhxVleDso0vC+2RD1vBV7wE=
=kgiD
-----END PGP SIGNATURE-----

--=-45N4bvp/oD9a6lFdlKUD--

