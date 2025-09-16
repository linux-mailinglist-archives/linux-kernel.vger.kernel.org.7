Return-Path: <linux-kernel+bounces-818380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED3B590F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19023A6900
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275802877C2;
	Tue, 16 Sep 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="wEGdEXHh"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBC27935A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012070; cv=none; b=EdzPO+4dMywx+FhNX7cfUJa4dLrGWMl5Ey6mB9xGyWh18Okc6K5vFIW16QNFUvxTQ04VUuEkbbgKRa9lAablAkHU4viCJiaOWUQ0pL3wqO7djSWvI2H6P8WP4LK8L2XeiJKe+jz8MEPUfk0cfH1lvazrhWEY/aUBUjjFtNinT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012070; c=relaxed/simple;
	bh=FRJeXYZB8ZEA/BnsTHbLV98OzevBAClHVJI/fOySR1M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mUuL/6KutBFMKvbVKxVG+SsveJC7nJSIYkKf3/PaFs8r6Iwbcdh95dUfW1Tji3IEDrSPpt9PbkO2bvPVF7frv+elHTHU3WaaThZzFv3I2C1+ocSae4aAObH3O7U32zxPwPhlLjEvTpuhnWtwUWdznBe93RWDIR8exKK8rknASIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=wEGdEXHh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0787fdb137so761960866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758012063; x=1758616863; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWjC7c8sK7mI2MCvaPgzYZk93Flu3sCU+XXjdK8sBEE=;
        b=wEGdEXHh5L6VWDxaXEgwr6OMMhUSBaqzO2/txebcvEhFrW0LvST6QlIlG7SIoZWFT1
         pQOGlqkwHv3MXGYY25AhPDuBgWuvn5iozsuPOO74TaaX0wFEF2w0ay5PiUmWEC5Y6nx0
         OMX3bJyNa/7tr+g87RMPF4PkK3iIREQpyl1nMfW8mGi06/r4cXf/sHintF3/oUFlSMEC
         MoQQoO11iXpxcdV+Nt0w2mWxVYL/4y6Yc8m1u9+9W3SEbRXyKXD/6TDIMYJUoCmW4XQC
         TtTkGSFK6RaD9cvFQFYPuzWFMQv/idE852rKCfoetysHBRcygYS8srWOdCyRsDZgwX0T
         CGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012063; x=1758616863;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uWjC7c8sK7mI2MCvaPgzYZk93Flu3sCU+XXjdK8sBEE=;
        b=lnh8NYlNkCfs+hR//LyiPd1EmY/Og+vlKGISXWPphPN2uVc4NaKgrfnNq/P6dIUn2t
         buhcN1dYgCPPnnREIva4KXkyw0Wm/1Jg7YVaBLFjZa+sKFSRTJQVeyJJXdSjIjJCFWi/
         W8DROE6DhGCK0ZmvrGVuMHLwsPYq1DA326VIoKN09JBZ1gN7jbEYe26QYyZYJSj8h3u0
         PsGFJmLMJg0gb3Sl0rTCXXCyc7xh4D0MVKNe8hMy4dnMK8rtk5Hk/GqhGdUrwByBSuIc
         p4TzqmC2n1xc+dOIt6iELTMmlhci8UFcAR9iBZ0nRirBd0EJ7xTHcx7yHY27r79ZVopw
         oydQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEw0te/XsCb4pOS19LLAkJxkUDN6Q+nQwelltth0U2/Q6N6+S+K+ITlQgHc/L5ffPCiMQoQC5q+nJPwxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXtK35FgQVDKsjAwwjNYX/edjqbLLsdrGwkC0nIY84dCJF/RS
	80UGGxeMVDdETMueRig2+NwCo4po4H1UiI4Ttt2PrMMb8TOpXk7XttsuW+SstRq8cQY=
X-Gm-Gg: ASbGncucti6Ou+uV2XpBILOhtdVmpcFjQedapt2X6F1/Da2gaZwiD492+AfJB8Si8cX
	i/K+LgAH3gvFrLlaawh4r9gzyRYSpPcRNqCGWyG/7zhgvrzgwhXCkJFYx6iO+k7EJV0LfoAh29v
	Xwb7RW9CCodp9ocQ8uiKqDQFiYfGbLsqGHMGhI+JyA9ROM7lyb5BFHXQsEuB/tplqR9qjpO8U9p
	7R0PcZbVFggODEo5mYUfzwUmWP5d1sBDo+6NsMM4ZnAlWDACjhWaPVEfexJhv3NE1tio+L+ms/2
	QYPqeJ16yy1sWx/cYaUp3HD98mSE27xJgwAIKjBmmwb1rD6pKVMoYW7jpujDGxll/eRBHkiZQk9
	JOVSafMQLOWhEoWRf0JN/TfLkpaVHMo+ccQlD1keJk5nWgrRAOidacaMlhtZDaZ7Qfb2A
X-Google-Smtp-Source: AGHT+IHLHmq1hdLoaxu1Z2A2YoZoxC/ixUlJXeQdUX4uX7Xdahe0aN/tRoUlrDHfbFQ20B3SCsh7CA==
X-Received: by 2002:a17:907:9710:b0:b0b:ff5d:3f44 with SMTP id a640c23a62f3a-b0bff5d480dmr1025662266b.58.1758012063394;
        Tue, 16 Sep 2025 01:41:03 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347b6fsm1118969766b.111.2025.09.16.01.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 10:41:01 +0200
Message-Id: <DCU39JVDVFAG.2EOCQ37KAS3N0@fairphone.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Wesley Cheng" <quic_wcheng@quicinc.com>, "Jaroslav Kysela"
 <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dan Carpenter" <dan.carpenter@linaro.org>,
 <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space
 confusion
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Takashi Iwai" <tiwai@suse.de>, "Luca
 Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250513123442.159936-1-arnd@kernel.org>
 <20250513123442.159936-4-arnd@kernel.org>
 <DBR2363A95M1.L9XBNC003490@fairphone.com> <87v7n72pg0.wl-tiwai@suse.de>
 <DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com> <87ms8j2on6.wl-tiwai@suse.de>
 <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com> <87bjnpqe45.wl-tiwai@suse.de>
 <a2a6843f-7e03-4b7e-b5fc-415ac9fc6621@app.fastmail.com>
In-Reply-To: <a2a6843f-7e03-4b7e-b5fc-415ac9fc6621@app.fastmail.com>

Hi Arnd,

On Fri Sep 5, 2025 at 4:54 PM CEST, Arnd Bergmann wrote:
> On Fri, Sep 5, 2025, at 14:26, Takashi Iwai wrote:
>> On Fri, 05 Sep 2025 13:47:28 +0200,
>
>> @@ -1051,18 +1050,13 @@ static int uaudio_transfer_buffer_setup(struct=
=20
>> snd_usb_substream *subs,
>>  	if (!xfer_buf)
>>  		return -ENOMEM;
>>=20
>> -	/* Remapping is not possible if xfer_buf is outside of linear map */
>> -	xfer_buf_pa =3D virt_to_phys(xfer_buf);
>> -	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
>> -		ret =3D -ENXIO;
>> -		goto unmap_sync;
>> -	}
>>  	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
>>  			xfer_buf_dma, len);
>>=20
>>  	/* map the physical buffer into sysdev as well */
>> +	/* note: 0 is passed to pa argument as we use sgt */
>>  	xfer_buf_dma_sysdev =3D uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
>> -					       xfer_buf_pa, len, &xfer_buf_sgt);
>> +					       0, len, &xfer_buf_sgt);
>>  	if (!xfer_buf_dma_sysdev) {
>>  		ret =3D -ENOMEM;
>>  		goto unmap_sync;
>
>
> Makes sense. I had to rework the code a little more to actually
> understand how it fits together, for reference the below version
> (I don't expect it to build cleanly) would split up
> uaudio_iommu_map() into one function that takes a physical
> address and another function that takes an sg table.

Are you planning to post this as a proper patch? It's a bit late in the
6.17 cycle already but good to still get this fixed for final release.

Or revert the original commit that broke it for now.

I couldn't really test your patch since there's a couple of compile
errors where I wasn't sure how to resolve them correctly.

Regards
Luca

>
>        Arnd
>
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_=
offload.c
> index a25c5a531690..f843c2181da5 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -539,32 +539,24 @@ static void uaudio_iommu_unmap(enum mem_type mtype,=
 unsigned long iova,
>  }
> =20
>  /**
> - * uaudio_iommu_map() - maps iommu memory for adsp
> + * uaudio_iommu_map_pa() - maps iommu memory for adsp
>   * @mtype: ring type
>   * @dma_coherent: dma coherent
>   * @pa: physical address for ring/buffer
>   * @size: size of memory region
> - * @sgt: sg table for memory region
>   *
>   * Maps the XHCI related resources to a memory region that is assigned t=
o be
>   * used by the adsp.  This will be mapped to the domain, which is create=
d by
>   * the ASoC USB backend driver.
>   *
>   */
> -static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_cohe=
rent,
> -				      phys_addr_t pa, size_t size,
> -				      struct sg_table *sgt)
> +static unsigned long uaudio_iommu_map_pa(enum mem_type mtype, bool dma_c=
oherent,
> +				      phys_addr_t pa, size_t size)
>  {
>  	struct scatterlist *sg;
>  	unsigned long iova =3D 0;
> -	size_t total_len =3D 0;
> -	unsigned long iova_sg;
> -	phys_addr_t pa_sg;
>  	bool map =3D true;
> -	size_t sg_len;
>  	int prot;
> -	int ret;
> -	int i;
> =20
>  	prot =3D IOMMU_READ | IOMMU_WRITE;
> =20
> @@ -583,20 +575,42 @@ static unsigned long uaudio_iommu_map(enum mem_type=
 mtype, bool dma_coherent,
>  				     &uaudio_qdev->xfer_ring_iova_size,
>  				     &uaudio_qdev->xfer_ring_list, size);
>  		break;
> -	case MEM_XFER_BUF:
> -		iova =3D uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
> -				     &uaudio_qdev->xfer_buf_iova_size,
> -				     &uaudio_qdev->xfer_buf_list, size);
> -		break;
>  	default:
>  		dev_err(uaudio_qdev->data->dev, "unknown mem type %d\n", mtype);
>  	}
> =20
>  	if (!iova || !map)
> -		goto done;
> +		return 0;
> =20
> -	if (!sgt)
> -		goto skip_sgt_map;
> +	iommu_map(uaudio_qdev->data->domain, iova, pa, size, prot, GFP_KERNEL);
> +
> +done:
> +	return iova;
> +}
> +
> +static unsigned long uaudio_iommu_map_xfer_buf(bool dma_coherent,
> +				      size_t size, struct sg_table *sgt)
> +{
> +	struct scatterlist *sg;
> +	unsigned long iova =3D 0;
> +	size_t total_len =3D 0;
> +	unsigned long iova_sg;
> +	phys_addr_t pa_sg;
> +	size_t sg_len;
> +	int prot;
> +	int ret;
> +	int i;
> +
> +	prot =3D IOMMU_READ | IOMMU_WRITE;
> +
> +	if (dma_coherent)
> +		prot |=3D IOMMU_CACHE;
> +
> +	iova =3D uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
> +			     &uaudio_qdev->xfer_buf_iova_size,
> +			     &uaudio_qdev->xfer_buf_list, size);
> +	if (!iova)
> +		goto done;
> =20
>  	iova_sg =3D iova;
>  	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> @@ -618,11 +632,6 @@ static unsigned long uaudio_iommu_map(enum mem_type =
mtype, bool dma_coherent,
>  		uaudio_iommu_unmap(MEM_XFER_BUF, iova, size, total_len);
>  		iova =3D 0;
>  	}
> -	return iova;
> -
> -skip_sgt_map:
> -	iommu_map(uaudio_qdev->data->domain, iova, pa, size, prot, GFP_KERNEL);
> -
>  done:
>  	return iova;
>  }
> @@ -1061,8 +1070,8 @@ static int uaudio_transfer_buffer_setup(struct snd_=
usb_substream *subs,
>  			xfer_buf_dma, len);
> =20
>  	/* map the physical buffer into sysdev as well */
> -	xfer_buf_dma_sysdev =3D uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
> -					       xfer_buf_pa, len, &xfer_buf_sgt);
> +	xfer_buf_dma_sysdev =3D uaudio_iommu_map_xfer_buf(dma_coherent, xfer_bu=
f_pa,
> +							len, &xfer_buf_sgt);
>  	if (!xfer_buf_dma_sysdev) {
>  		ret =3D -ENOMEM;
>  		goto unmap_sync;
> @@ -1143,8 +1152,8 @@ uaudio_endpoint_setup(struct snd_usb_substream *sub=
s,
>  	sg_free_table(sgt);
> =20
>  	/* data transfer ring */
> -	iova =3D uaudio_iommu_map(MEM_XFER_RING, dma_coherent, tr_pa,
> -			      PAGE_SIZE, NULL);
> +	iova =3D uaudio_iommu_map_pa(MEM_XFER_RING, dma_coherent, tr_pa,
> +				   PAGE_SIZE);
>  	if (!iova) {
>  		ret =3D -ENOMEM;
>  		goto clear_pa;
> @@ -1207,8 +1216,8 @@ static int uaudio_event_ring_setup(struct snd_usb_s=
ubstream *subs,
>  	mem_info->dma =3D sg_dma_address(sgt->sgl);
>  	sg_free_table(sgt);
> =20
> -	iova =3D uaudio_iommu_map(MEM_EVENT_RING, dma_coherent, er_pa,
> -			      PAGE_SIZE, NULL);
> +	iova =3D uaudio_iommu_map_pa(MEM_EVENT_RING, dma_coherent, er_pa,
> +				   PAGE_SIZE);
>  	if (!iova) {
>  		ret =3D -ENOMEM;
>  		goto clear_pa;


