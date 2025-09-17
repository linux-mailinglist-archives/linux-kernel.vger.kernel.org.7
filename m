Return-Path: <linux-kernel+bounces-820675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED41B7D9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4568617B1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1F337EBE;
	Wed, 17 Sep 2025 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="XQftBeOB"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A32337E92
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112075; cv=none; b=R0IHuDn0pqEHGibSOcZKLHs2GoJknZ7Woh6OZ/Xzka+l5pH07xQ4pvCP+3MEY7YmswkvmM+8ZeIeB2tRJ3azRLCfAQD/47RJRzb3L9dw1UgyJLqepu6GvK+ygDvlYUDdS3xXLv7xu7YgXYWcaAlPvypPEZkeSwmALiuxeudoM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112075; c=relaxed/simple;
	bh=CM7wbSN5gzRVQV1tWHTEz8a5G+HPVfMzSPAV8GXY4kc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=aTv+Pkc1l+EoTk3mMA3TagXGyD3fynGgKOmMX2rMI+xVim3teu15v10D5/YXwVbFJGGc6QvaYyU9bki0ICrWMOeNMFm/YwMTT2vAA43hxQVTDx6vSUrnlnvFYseDiIRRXP/GtBxQHk9Q44t2e6DSf9vZesWPfc5iakOv79m2A1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=XQftBeOB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0411b83aafso967850466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758112072; x=1758716872; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blL54xflJH9dY0OWBchzNYlQr7kJG5/J9yOomzmbQrk=;
        b=XQftBeOBA45LH2006MoUmBNJVRXnJkdfwFh5jFVmFjnF0/hV+O8/cOR1X+LrpTnzRk
         RqLFApR2zvoySy1YkIYoWaoU+BFEkkfdwFP83vX25a1C0YCU4yS4Mg7mPkW1wn3BNMoc
         iqP++25SOFmkSSIq5tkNaTkTcbGGR+JtI8FCSFu3zzVekVnUVN1RKVLKyC8wcskiq6Fe
         GpPGoG7KIIYpWuLBzS3aFATyWJk0FVWy47tGtUGWhYWDJiAjGKDwezYzCY3v4EuNKbH3
         qzeX24YHj+kMRYsfUJlJBvGpLS3ML9TN6KcgAaGSI5MPvKapoZXxDg92Skpv37B+1WfA
         0KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758112072; x=1758716872;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=blL54xflJH9dY0OWBchzNYlQr7kJG5/J9yOomzmbQrk=;
        b=i89xJpeJF0SKDHadmT9SsB7sbmDY9v5fjXogGf2Ibe2pnJYmhQVXdCI3T8FZqrzh86
         /RW2jMVYI3/YfK1guDa111zlcTfByNiXg3VlO4c8OoYoXT5Q5E02ksxvVm/JgbfDiK5J
         lpLxUOXHEA/aswTzqMDkwqO9cahV3LoajvfmGOz+FgqyGWM6bPb6Zk7IoyCVXmTlKvc+
         RKyaEB3/qIOcwgAOKS8DZTD781kFeFk6y2l69+HNKII/K+YIxcriIDRLUneB4WX1YUzT
         0SksQABeyYFCql2wSVuzYVcdeRqEMONgKlA3IIOaVjWKcU0XHO7qDuVG5v9cC7f7yWpR
         zCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyfN9aU8FCuOSN8u5Ux2u/wVljHxbMxrblMJwzfD65ia81I5NL3Hwkj5lXyjRZu7BiReCKuaLQwoMSQP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaQFvA7WgPzkvDBl026EU/NeutSIOWFjiXfTnF1Mb4fXkqis3
	y/dGnPom9k8E7G6vlPWOZr67LejPuEHMUYKMnJ/yqg9INjrN74sATyV3AnzCVkJ9jO4=
X-Gm-Gg: ASbGncsrA/hsj8gWyFFRPCyLCQeOeaGgEGId9u9AJl8oQcysq1juKc9mYyNaWzxmOII
	Zhyfgf3v59+FhJ/a0RjvZtAMFjKgqlHZgwTeOtCjEHgXVnmQA+mjDX6NlKQOQ6sNioPLmWmNt6F
	Zps4/TteRjRwaHcF+vyXy/S75xcKzL0TAb6rlMUvsZ+EWIyeRwNea4gGE2EPmfh+Wm++Mz7a+J+
	+KSTIk6zzflOtIbhENrS60RmgnmBlJ2/M3gFtJAD7NTDDAscDjn9qMvnVhQOJaOY8mVH/YY4FSG
	3ROlifcUKT4cubaPPsAtxZdHI3bf/zkDf1QA9Cfmksq320Q5TXfVS7M1Y2Raffly98yzaNbSaQG
	fF+SrD+eVg7nmdp65MkPNNBYr73BMrEQkXfKp6bKJ48xJ/RPylIyIyTKl6jD8drwD+yRD
X-Google-Smtp-Source: AGHT+IFim5Ho1xKiTioG+hm5maDccyOjDHnMhuv+Ox8gAf8MRbn9Zcs8mvFt15NCiDyDnO8Ur0rbUQ==
X-Received: by 2002:a17:907:7fa1:b0:b04:806b:c612 with SMTP id a640c23a62f3a-b1baf60e28dmr222760266b.10.1758112071540;
        Wed, 17 Sep 2025 05:27:51 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f20dcsm1347952166b.90.2025.09.17.05.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 05:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 14:27:50 +0200
Message-Id: <DCV2PRB19Z2Q.2B8JK33Q0FEI5@fairphone.com>
To: "Takashi Iwai" <tiwai@suse.de>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Arnd Bergmann" <arnd@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Wesley Cheng"
 <quic_wcheng@quicinc.com>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, <linux-sound@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space
 confusion
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250513123442.159936-1-arnd@kernel.org>
 <20250513123442.159936-4-arnd@kernel.org>
 <DBR2363A95M1.L9XBNC003490@fairphone.com> <87v7n72pg0.wl-tiwai@suse.de>
 <DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com> <87ms8j2on6.wl-tiwai@suse.de>
 <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com> <87bjnpqe45.wl-tiwai@suse.de>
 <a2a6843f-7e03-4b7e-b5fc-415ac9fc6621@app.fastmail.com>
 <DCU39JVDVFAG.2EOCQ37KAS3N0@fairphone.com> <87o6raxtu9.wl-tiwai@suse.de>
 <DCUXFIZ5KRCU.3JANM98BSE8SE@fairphone.com> <87v7lhwkf2.wl-tiwai@suse.de>
In-Reply-To: <87v7lhwkf2.wl-tiwai@suse.de>

Hi Takashi,

On Wed Sep 17, 2025 at 10:30 AM CEST, Takashi Iwai wrote:
> On Wed, 17 Sep 2025 10:19:23 +0200,
> Luca Weiss wrote:
>>=20
>> Hi Takashi,
>>=20
>> On Tue Sep 16, 2025 at 6:09 PM CEST, Takashi Iwai wrote:
>> > On Tue, 16 Sep 2025 10:41:01 +0200,
>> > Luca Weiss wrote:
>> >>=20
>> >> Hi Arnd,
>> >>=20
>> >> On Fri Sep 5, 2025 at 4:54 PM CEST, Arnd Bergmann wrote:
>> >> > On Fri, Sep 5, 2025, at 14:26, Takashi Iwai wrote:
>> >> >> On Fri, 05 Sep 2025 13:47:28 +0200,
>> >> >
>> >> >> @@ -1051,18 +1050,13 @@ static int uaudio_transfer_buffer_setup(st=
ruct=20
>> >> >> snd_usb_substream *subs,
>> >> >>  	if (!xfer_buf)
>> >> >>  		return -ENOMEM;
>> >> >>=20
>> >> >> -	/* Remapping is not possible if xfer_buf is outside of linear ma=
p */
>> >> >> -	xfer_buf_pa =3D virt_to_phys(xfer_buf);
>> >> >> -	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
>> >> >> -		ret =3D -ENXIO;
>> >> >> -		goto unmap_sync;
>> >> >> -	}
>> >> >>  	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
>> >> >>  			xfer_buf_dma, len);
>> >> >>=20
>> >> >>  	/* map the physical buffer into sysdev as well */
>> >> >> +	/* note: 0 is passed to pa argument as we use sgt */
>> >> >>  	xfer_buf_dma_sysdev =3D uaudio_iommu_map(MEM_XFER_BUF, dma_coher=
ent,
>> >> >> -					       xfer_buf_pa, len, &xfer_buf_sgt);
>> >> >> +					       0, len, &xfer_buf_sgt);
>> >> >>  	if (!xfer_buf_dma_sysdev) {
>> >> >>  		ret =3D -ENOMEM;
>> >> >>  		goto unmap_sync;
>> >> >
>> >> >
>> >> > Makes sense. I had to rework the code a little more to actually
>> >> > understand how it fits together, for reference the below version
>> >> > (I don't expect it to build cleanly) would split up
>> >> > uaudio_iommu_map() into one function that takes a physical
>> >> > address and another function that takes an sg table.
>> >>=20
>> >> Are you planning to post this as a proper patch? It's a bit late in t=
he
>> >> 6.17 cycle already but good to still get this fixed for final release=
.
>> >>=20
>> >> Or revert the original commit that broke it for now.
>> >>=20
>> >> I couldn't really test your patch since there's a couple of compile
>> >> errors where I wasn't sure how to resolve them correctly.
>> >
>> > Could you check the patch below, then?  At least it compiles without
>> > errors.
>>=20
>> It does compile as well for me, but looks like it's not working.
>>=20
>> It's still triggering the WARN_ON from
>>=20
>>   if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
>>=20
>> [  214.157471] ------------[ cut here ]------------
>> [  214.157491] WARNING: CPU: 4 PID: 12 at sound/usb/qcom/qc_audio_offloa=
d.c:1067 handle_uaudio_stream_req+0xecc/0x13c4
>> [  214.157510] Modules linked in:
>> [  214.157522] CPU: 4 UID: 0 PID: 12 Comm: kworker/u32:0 Tainted: G     =
   W           6.16.0-00047-gfa3c1e37ba38 #1 NONE=20
>> [  214.157531] Tainted: [W]=3DWARN
>> [  214.157535] Hardware name: Fairphone 4 (DT)
>> [  214.157541] Workqueue: qmi_msg_handler qmi_data_ready_work
>> [  214.157553] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
>> [  214.157560] pc : handle_uaudio_stream_req+0xecc/0x13c4
>> [  214.157568] lr : handle_uaudio_stream_req+0xcdc/0x13c4
>> [  214.157575] sp : ffff8000800b39d0
>> [  214.157579] x29: ffff8000800b3b40 x28: ffff0000895eb6b0 x27: 00000000=
00008000
>> [  214.157589] x26: ffff0000d6bae960 x25: ffffa11dbe275e28 x24: 00000000=
00008000
>> [  214.157598] x23: ffffa11dbe0a4ec0 x22: ffff8000800b3c00 x21: 00000000=
00000000
>> [  214.157608] x20: ffff8000800b3cc8 x19: ffff00008b128ac0 x18: ffffa11d=
bdfaa258
>> [  214.157617] x17: ffff0000803e9388 x16: ffff0000800162c0 x15: ffffa11d=
bdfaa000
>> [  214.157626] x14: 0000000000000500 x13: ffffa11dbe03c000 x12: 00000000=
00000000
>> [  214.157636] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffa11d=
be0f78a0
>> [  214.157645] x8 : ffffdee36909b000 x7 : ffff0000d6ac8418 x6 : 00000000=
00000000
>> [  214.157654] x5 : 0000000000000000 x4 : ffff8000800b3968 x3 : 00000000=
00000000
>> [  214.157663] x2 : 0000000000000000 x1 : ffff0000801a4100 x0 : 00000000=
00000000
>> [  214.157672] Call trace:
>> [  214.157677]  handle_uaudio_stream_req+0xecc/0x13c4 (P)
>> [  214.157687]  qmi_invoke_handler+0xb4/0x100
>> [  214.157694]  qmi_handle_message+0x88/0x1a0
>> [  214.157702]  qmi_data_ready_work+0x208/0x35c
>> [  214.157709]  process_one_work+0x144/0x2c4
>> [  214.157719]  worker_thread+0x280/0x45c
>> [  214.157726]  kthread+0xfc/0x1dc
>> [  214.157733]  ret_from_fork+0x10/0x20
>> [  214.157744] ---[ end trace 0000000000000000 ]---
>>=20
>> Should that code be removed with the new code now?
>
> Yes, please try the revised patch below.

This is indeed now working for me, playback works again.

Let me know if I should do anything else for this.

Regards
Luca

>
>
> thanks,
>
> Takashi
>
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -538,38 +538,33 @@ static void uaudio_iommu_unmap(enum mem_type mtype,=
 unsigned long iova,
>  			umap_size, iova, mapped_iova_size);
>  }
> =20
> +static int uaudio_iommu_map_prot(bool dma_coherent)
> +{
> +	int prot =3D IOMMU_READ | IOMMU_WRITE;
> +
> +	if (dma_coherent)
> +		prot |=3D IOMMU_CACHE;
> +	return prot;
> +}
> +
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
> +					 phys_addr_t pa, size_t size)
>  {
> -	struct scatterlist *sg;
>  	unsigned long iova =3D 0;
> -	size_t total_len =3D 0;
> -	unsigned long iova_sg;
> -	phys_addr_t pa_sg;
>  	bool map =3D true;
> -	size_t sg_len;
> -	int prot;
> -	int ret;
> -	int i;
> -
> -	prot =3D IOMMU_READ | IOMMU_WRITE;
> -
> -	if (dma_coherent)
> -		prot |=3D IOMMU_CACHE;
> +	int prot =3D uaudio_iommu_map_prot(dma_coherent);
> =20
>  	switch (mtype) {
>  	case MEM_EVENT_RING:
> @@ -583,20 +578,41 @@ static unsigned long uaudio_iommu_map(enum mem_type=
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
> +	return iova;
> +}
> +
> +static unsigned long uaudio_iommu_map_xfer_buf(bool dma_coherent, size_t=
 size,
> +					       struct sg_table *sgt)
> +{
> +	struct scatterlist *sg;
> +	unsigned long iova =3D 0;
> +	size_t total_len =3D 0;
> +	unsigned long iova_sg;
> +	phys_addr_t pa_sg;
> +	size_t sg_len;
> +	int prot =3D uaudio_iommu_map_prot(dma_coherent);
> +	int ret;
> +	int i;
> +
> +	prot =3D IOMMU_READ | IOMMU_WRITE;
> +
> +	if (dma_coherent)
> +		prot |=3D IOMMU_CACHE;
> +
> +	iova =3D uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
> +			       &uaudio_qdev->xfer_buf_iova_size,
> +			       &uaudio_qdev->xfer_buf_list, size);
> +	if (!iova)
> +		goto done;
> =20
>  	iova_sg =3D iova;
>  	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> @@ -618,11 +634,6 @@ static unsigned long uaudio_iommu_map(enum mem_type =
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
> @@ -1020,7 +1031,6 @@ static int uaudio_transfer_buffer_setup(struct snd_=
usb_substream *subs,
>  	struct sg_table xfer_buf_sgt;
>  	dma_addr_t xfer_buf_dma;
>  	void *xfer_buf;
> -	phys_addr_t xfer_buf_pa;
>  	u32 len =3D xfer_buf_len;
>  	bool dma_coherent;
>  	dma_addr_t xfer_buf_dma_sysdev;
> @@ -1051,18 +1061,12 @@ static int uaudio_transfer_buffer_setup(struct sn=
d_usb_substream *subs,
>  	if (!xfer_buf)
>  		return -ENOMEM;
> =20
> -	/* Remapping is not possible if xfer_buf is outside of linear map */
> -	xfer_buf_pa =3D virt_to_phys(xfer_buf);
> -	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
> -		ret =3D -ENXIO;
> -		goto unmap_sync;
> -	}
>  	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
>  			xfer_buf_dma, len);
> =20
>  	/* map the physical buffer into sysdev as well */
> -	xfer_buf_dma_sysdev =3D uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
> -					       xfer_buf_pa, len, &xfer_buf_sgt);
> +	xfer_buf_dma_sysdev =3D uaudio_iommu_map_xfer_buf(dma_coherent,
> +							len, &xfer_buf_sgt);
>  	if (!xfer_buf_dma_sysdev) {
>  		ret =3D -ENOMEM;
>  		goto unmap_sync;
> @@ -1143,8 +1147,8 @@ uaudio_endpoint_setup(struct snd_usb_substream *sub=
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
> @@ -1207,8 +1211,8 @@ static int uaudio_event_ring_setup(struct snd_usb_s=
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


