Return-Path: <linux-kernel+bounces-839919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6638ABB2BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3549B7B0B95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE092D2394;
	Thu,  2 Oct 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bz3oyk/J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26FB1DE887
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391267; cv=none; b=aimFIF/Djl1fckIm66bK+yhX+lrD6jzHixXTACy7SDAg/ur87pRihttS/mR4Jw8bmO7+/NHPd+YXfaZxQOQSSyUNRH+hErLvyDDCgvBa/FhnJV51iyN3sfrFaxvF9jOVNx66k8018v8inHFW4MM2CXUMnzgKmkbi5QhT35CY4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391267; c=relaxed/simple;
	bh=o5Ski1KE2v6C3aWnVPjLwK3jMJPNXrvIgg9TOn5sZUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMkF2Vhtjb9DWiYtWUq3NnmTA2ejHqtXNQedeHcPFk06OpIEEHeqgEa1bVGfIR0SuTFwZsyeqAkosklaTKNdkGiIyZCSenzROH5DmHdWW4LVpVBdM0z2CoRwur2EykEA8bsWdGkTQF+mFTRCAr1Q4rXUqVu6xhpofYJTA4IRFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bz3oyk/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759391264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgVDpIUaXbRIFaGTvmSsiE/BFfaSBmSlnmsfDON0gMA=;
	b=bz3oyk/J4DOvP6rr7+o2KygN1cAgJxY+KBpSL0zhI99/OfHMYgn5VIS4WJPLG0X+Rh2jsP
	sAOXUhOaaaHsY28h6f97zUwvbJq0j5Z8DGL/dcavFb0EdoQAu70IQZIaDcNQufIFdE6j84
	3seHCJIjQm02CtGJbvOx0ruFnuCSrWQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-xaB715leOuiOF5kRQOW-_Q-1; Thu, 02 Oct 2025 03:47:43 -0400
X-MC-Unique: xaB715leOuiOF5kRQOW-_Q-1
X-Mimecast-MFC-AGG-ID: xaB715leOuiOF5kRQOW-_Q_1759391262
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f42b54d159so442795f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759391262; x=1759996062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgVDpIUaXbRIFaGTvmSsiE/BFfaSBmSlnmsfDON0gMA=;
        b=apkUnkX0vhJx7MOVn6yzGiJrTz5C1+gAPtRHVew3PXM6n/Fy8sITId5jAozsnfdfQ6
         DgysxfW8DehVbJic5zFrjcHdfgObZtOSTLgtmnrbYdaubWnSpi7F78Qb4pmfnt21ropL
         UvwgtQ23xpWjymg88ehXQQ+MArWDvV7FH+nyMmLdJ/OWeVj/54ivnWqIazpMjf0w3MLh
         vpW3wPeGBmhjM+NAh5DXqRV0P2FuN8oGe90RkUAlaBqDwZb8PT90c8NpuKZ6NUaCo+P5
         X/WG1x7zai0XLUmf6ONiwptRMnDLnA64qlEGSbhgCygsja2WUhkY2uv2IF6+izNHtPBw
         B1Dw==
X-Gm-Message-State: AOJu0YyxpnHr0lwdimXzLKVYqhOMOhyK6tHT6+KPJrAedLjpoTGWG20F
	/wCNr7pet72ol5U6QYyMqDufKXeuP0reA7qxcaw/5A1YY+pnuNSPAXRTa47fOZ6zPLnvL6/6J/M
	oBu7PLnWpsIlpSC3a/YhLSVXz1Np/1eS/TDcLtJjlq9ruwfJx1tNTWUuJDycdgh7EHQ==
X-Gm-Gg: ASbGncsRh83ADyOgkXWDK1QcKWzToRxGcDLDgqrrR5PkG9h9h3gZYArykTxpdjN3bxr
	h290wOETOma+CaoVDEji9ekB/8udu2Rs5ZNVWMrYQhs4i75k/mIMW3Cg4dv1xUigb3KXJeXpK8T
	LBIMC72pe7oUBtbh2DtUMW1yYtwjjltW/lY603MOT2p2uQ6d8MOdcLkbk4vU9O3CPFkbr7Eu1gW
	IZm9aEoKXtLRRT1Mek9fO9NoS1aQf3FNqPWHPLYy0ppuPrGJLaPGuNKEhjMvPLDi0sHEKwc+GH4
	NnH9xGNT0XCy/Xm6TRMeDA==
X-Received: by 2002:a05:6000:615:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-4255780bf79mr4246063f8f.29.1759391262060;
        Thu, 02 Oct 2025 00:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP/KnwbkkSVeQQvgR4f/j6yP7T3XyqaNDmBwlBCTQIJSAplcQo89U5KExVEQ0LiNnNhN8Wxw==
X-Received: by 2002:a05:6000:615:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-4255780bf79mr4246043f8f.29.1759391261558;
        Thu, 02 Oct 2025 00:47:41 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b5csm2470879f8f.5.2025.10.02.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 00:47:41 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:47:40 +0200
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
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
Message-ID: <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-3-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="gqzh2ah3mmdu76ac"
Content-Disposition: inline
In-Reply-To: <20250911135007.1275833-3-jens.wiklander@linaro.org>


--gqzh2ah3mmdu76ac
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
MIME-Version: 1.0

Hi,

On Thu, Sep 11, 2025 at 03:49:43PM +0200, Jens Wiklander wrote:
> Export the dma-buf heap functions to allow them to be used by the OP-TEE
> driver. The OP-TEE driver wants to register and manage specific secure
> DMA heaps with it.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/dma-buf/dma-heap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 3cbe87d4a464..8ab49924f8b7 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -11,6 +11,7 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-heap.h>
>  #include <linux/err.h>
> +#include <linux/export.h>
>  #include <linux/list.h>
>  #include <linux/nospec.h>
>  #include <linux/syscalls.h>
> @@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
>  {
>  	return heap->priv;
>  }
> +EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
> =20
>  /**
>   * dma_heap_get_name - get heap name
> @@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *heap)
>  {
>  	return heap->name;
>  }
> +EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> =20
>  /**
>   * dma_heap_add - adds a heap to dmabuf heaps
> @@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_e=
xport_info *exp_info)
>  	kfree(heap);
>  	return err_ret;
>  }
> +EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");

It's not clear to me why we would need to export those symbols.

As far as I know, heaps cannot be removed, and compiling them as module
means that we would be able to remove them.

Now, if we don't expect the users to be compiled as modules, then we
don't need to export these symbols at all.

Am I missing something?

Maxime

--gqzh2ah3mmdu76ac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaN4uFwAKCRAnX84Zoj2+
dgXFAYCRqMeTP57unkLdOGOydUleXNO4Hyw5XxsQDOrGvzMhBXOO+wkmNxAyspbp
Ufq67PMBfjTtOUKXQIyMWncxOakNOIj4KKpCcpuXU8G+m0dpGkCeFoK4Z85nhhK9
lbC1byfHEQ==
=wMRm
-----END PGP SIGNATURE-----

--gqzh2ah3mmdu76ac--


