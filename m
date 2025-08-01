Return-Path: <linux-kernel+bounces-753297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC9B18124
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBB5170BD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62AF23B60B;
	Fri,  1 Aug 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="2FxpaxeZ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67704153598
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047909; cv=none; b=Z7eD2o5+u+l4ebJ7RqzsWnD9cgMAhgKQ72jwbW23uPWFqRMlu6CuE0Y7o6Nqa+L3uP1Yq3Ygnl8Usljws1tp2e0ntpv6cSZN+fjMipM1Gp2uuRp42IlbB3IGpy9gfMbgVs6IhjoetzSUKhkpMAXaBal1k9U5GUmihcxpUvlJ0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047909; c=relaxed/simple;
	bh=J5UPpdHzbElO/LerJoLFnDQLcWqRRQyXV38LyklGryk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Sc6hTA3HyG3UkWcsCL6ieyT4yONM6Zq9BFU5RRgM7mbdt5SBUSBtHPIRR3EA1eEKckEyYr5rtpbYcM0qfSZAJ3+FPwGqoTtpGUHaOt1bsCH5cc2rE8xZIuvmR+cg/1lvyeOP9nkS8hO1aLfNfj2xYxM8G6X7pSQvicOBJ870W4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=2FxpaxeZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af939afe5efso33792266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754047905; x=1754652705; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTRnv8bkVO24PVOynZ+74pwG0nQTMCB1PSdC7quT2Is=;
        b=2FxpaxeZfyCucNSmBn1FapSkU1bvDeuD56eRVeiTIj4WmeihjUHllOyTOWdaPHa/sZ
         1R0wTLxf8SPY1ssABHLV53wjsr3ssmW2zlLMiktSAyNxYFfKalJRL2/yJbp515QNLu3N
         hr8Jj7U2tuKUqVdMD5+gI9vbdEw3SXA8E26Xrrqr0HLmy7l/0Ff7cc4uERTwZ0c53Flx
         zTrdh92hqaeOa0I8JbP2aGxNol7eyXudfuWtQy/T4wfN3Gsjdp+5Peh0z9mQRjU+foMM
         BU4xGewijdUSV7OkxaTY1GFnA33w4kxOGJij+hx+92h/7oifBDlmoI44kxOcBHrTTSnp
         O8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754047905; x=1754652705;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XTRnv8bkVO24PVOynZ+74pwG0nQTMCB1PSdC7quT2Is=;
        b=v1+BXqAOql56yCQeZ7zMzYmOLO3kvrm0dDVpB9KprMV7/rLzUA+6gXseYVaKOO+KPg
         gpH6/9Ij9vb58EBsLDYRBuuKKqGEOwGJjeB+TQ6SBDW8gPuk7ACZZY33N4UdPy6KUEc4
         EKTBx3KyNZ9giK+cFYHOu6ZpN7f2Tmu5Eb3SGd0N9Lz4Elk6+VbDuiLZWpfC9x2CjSha
         s941EK3szvA4KbE2UUO63KCuMr10/FIuubErT+mgFr/9Y4njt5Q0EmPPelekfj7om+ty
         udDnV7/nTAWgNFGQUK6Fk+XpyzhOIoclv3Dw68VOuvkhL6oqmzgIfzn9grX9dzU1T++V
         z2Og==
X-Forwarded-Encrypted: i=1; AJvYcCVEF6Yhp00de2g4atYbdBd+Ehf5iTVSiwYN7uPLn9+zvVhskA74U2qe0F96fE6fjXtp9ISKKaO2UWdH8po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxOxxZJqOQkbeAg7Te3irbs+BB5F7wM5mdWlNo3G+Kqox5RfZ
	8/SRNvB5OzzxW2v4v/fonQr74eD//1cCRLqSbGSjNF1OGU7nLmDTa+XOWYxZ1FWoXrw=
X-Gm-Gg: ASbGnctaicM02KpanyoGBJ8TPnqVkLcNlwLWIPo83hzAKighG08DgUmw6bWuU9SVav4
	EdkLm3SxqgvHISY344qCbelXcyDHOGExrlh7foc19hXATph0LUofDHwdzV4VIC97DQLikApyzZ4
	jB4D4aGWB70gGKKBFC8QCS0WZHgDbkh9H1x6FRvpTSjU9CQDWXTM1Xzc8BsEsOx1/ViEl3J26yi
	LIuOXQZ0PjcmHRCZbPsNNI4znpUe2v2djdYyFCPQGu02DyrpkGAjFrpbgxv2A+A/2ZrrJ6rk+Ue
	SBJiuP9BSry80a+4Yp8PUp0pNaeGgwHDIVF8a18n+Qy79Ta4FPuIKvvqo6oqHewHvo2Cm7mSCsC
	fPvS++7PJMdXJEzqk+d2mF/J7iKQ9d1jOjS9ElxlPl9x0fPbrV5ajXN1R4r6pW9zf3Gg=
X-Google-Smtp-Source: AGHT+IGbs04C/69p2IRSvPJXayjZ95SCDVXX6ewRm58HHO++rWJLKySFyqQVl/VwHj5QS5glUwOsGw==
X-Received: by 2002:a17:906:3ce:b0:af9:1ee4:a30c with SMTP id a640c23a62f3a-af91ee4a88amr536767766b.36.1754047904574;
        Fri, 01 Aug 2025 04:31:44 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm269042666b.97.2025.08.01.04.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 13:31:42 +0200
Message-Id: <DBR2363A95M1.L9XBNC003490@fairphone.com>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space
 confusion
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Arnd Bergmann" <arnd@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Wesley Cheng" <quic_wcheng@quicinc.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Wesley Cheng" <quic_wcheng@quicinc.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, <linux-sound@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250513123442.159936-1-arnd@kernel.org>
 <20250513123442.159936-4-arnd@kernel.org>
In-Reply-To: <20250513123442.159936-4-arnd@kernel.org>

Hi Arnd,

On Tue May 13, 2025 at 2:34 PM CEST, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> uaudio_transfer_buffer_setup() allocates a buffer for the subs->dev
> device, and the returned address for the buffer is a CPU local virtual
> address that may or may not be in the linear mapping, as well as a DMA
> address token that is accessible by the USB device, and this in turn
> may or may not correspond to the physical address.
>
> The use in the driver however assumes that these addresses are the
> linear map and the CPU physical address, respectively. Both are
> nonportable here, but in the end only the virtual address gets
> used by converting it to a physical address that gets mapped into
> a second iommu.
>
> Make this more explicit by pulling the conversion out first
> and warning if it is not part of the linear map, and using the
> actual physical address to map into the iommu in place of the
> dma address that may already be iommu-mapped into the usb host.

This patch is breaking USB audio offloading on Qualcomm devices on 6.16,
as tested on sm6350 and sc7280-based smartphones.

[  420.463176] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: =
AFE Port already open
[  420.472676] ------------[ cut here ]------------
[  420.472691] WARNING: CPU: 2 PID: 175 at sound/usb/qcom/qc_audio_offload.=
c:1056 handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qmi]
[  420.472726] Modules linked in: rfcomm zram zsmalloc zstd_compress algif_=
hash algif_skcipher bnep nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_=
reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlin=
k ipv6 fuse uhid uinput snd_usb_audio_qmi q6asm_dai q6routing q6afe_dai q6u=
sb q6afe_clocks q6adm q6asm snd_q6dsp_common q6afe q6core apr pdr_interface=
 snd_soc_sm8250 snd_soc_qcom
_common snd_soc_qcom_offload_utils snd_soc_qcom_sdw soundwire_bus soc_usb s=
nd_soc_core snd_compress snd_usb_audio ath10k_snoc ath10k_core snd_hwdep sn=
d_usbmidi_lib ath fastrpc snd_pcm mac80211 hci_uart qrtr_smd snd_timer btqc=
a qcom_pd_mapper snd_rawmidi bluetooth libarc4 qcom_pdr_msg cfg80211 snd so=
undcore ecdh_generic ecc rfkill qrtr qcom_stats qcom_q6v5_pas ipa qcom_pil_=
info qcom_q6v5 qcom_common
[  420.473018] CPU: 2 UID: 0 PID: 175 Comm: kworker/u32:9 Tainted: G       =
 W           6.16.0 #1-postmarketos-qcom-sm6350 NONE
[  420.473033] Tainted: [W]=3DWARN
[  420.473038] Hardware name: Fairphone 4 (DT)
[  420.473045] Workqueue: qmi_msg_handler qmi_data_ready_work
[  420.473065] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  420.473075] pc : handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qm=
i]
[  420.473091] lr : handle_uaudio_stream_req+0xc84/0x13f8 [snd_usb_audio_qm=
i]
[  420.473104] sp : ffff800082f939a0
[  420.473110] x29: ffff800082f93b10 x28: ffff0000cfb796b8 x27: 00000000000=
08000
[  420.473128] x26: ffff0000842afc80 x25: ffffa8e75a23b0e0 x24: 00000000000=
08000
[  420.473145] x23: ffffa8e75a23bcf0 x22: ffff800082f93bd0 x21: 00000000000=
00000
[  420.473161] x20: ffff800082f93c98 x19: ffff0000939bb740 x18: ffffa8e7792=
5a4d0
[  420.473178] x17: ffffffffffffffff x16: ffffa8e777ef9728 x15: ffffa8e7792=
5a000
[  420.473194] x14: 0000000000000000 x13: 0000000000000dc0 x12: ffff8000800=
00000
[  420.473211] x11: 0000000000000cc0 x10: 0000000000000001 x9 : ffffa8e7794=
4b880
[  420.473227] x8 : ffffd719b5f4d000 x7 : ffff00009033da18 x6 : 00000000000=
00000
[  420.473244] x5 : 0000000000000000 x4 : ffff800082f93938 x3 : 00000000000=
00000
[  420.473260] x2 : 0000000000000000 x1 : ffff0000857790c0 x0 : 00000000000=
00000
[  420.473277] Call trace:
[  420.473283]  handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qmi] (=
P)
[  420.473300]  qmi_invoke_handler+0xbc/0x108
[  420.473314]  qmi_handle_message+0x90/0x1a8
[  420.473326]  qmi_data_ready_work+0x210/0x390
[  420.473339]  process_one_work+0x150/0x3a0
[  420.473351]  worker_thread+0x288/0x480
[  420.473362]  kthread+0x118/0x1e0
[  420.473375]  ret_from_fork+0x10/0x20
[  420.473390] ---[ end trace 0000000000000000 ]---
[  420.479244] qcom-q6afe aprsvc:service:4:4: cmd =3D 0x100e5 returned erro=
r =3D 0x1
[  420.479540] qcom-q6afe aprsvc:service:4:4: DSP returned error[1]
[  420.479558] qcom-q6afe aprsvc:service:4:4: AFE enable for port 0x7000 fa=
iled -22
[  420.479572] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: =
fail to start AFE port 88
[  420.479583] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: =
ASoC error (-22): at snd_soc_dai_prepare() on USB_RX

Reverting this patch makes it work as expected on 6.16.0.

Let me know if I can be of any help to resolve this.

Regards
Luca

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/usb/qcom/qc_audio_offload.c | 32 ++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_=
offload.c
> index c4dde2fa5a1f..46379387c9a5 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -78,9 +78,9 @@ struct intf_info {
>  	size_t data_xfer_ring_size;
>  	unsigned long sync_xfer_ring_va;
>  	size_t sync_xfer_ring_size;
> -	unsigned long xfer_buf_iova;
> +	dma_addr_t xfer_buf_iova;
>  	size_t xfer_buf_size;
> -	phys_addr_t xfer_buf_dma;
> +	dma_addr_t xfer_buf_dma;
>  	u8 *xfer_buf_cpu;
> =20
>  	/* USB endpoint information */
> @@ -1018,11 +1018,12 @@ static int uaudio_transfer_buffer_setup(struct sn=
d_usb_substream *subs,
>  					struct mem_info_v01 *mem_info)
>  {
>  	struct sg_table xfer_buf_sgt;
> +	dma_addr_t xfer_buf_dma;
>  	void *xfer_buf;
>  	phys_addr_t xfer_buf_pa;
>  	u32 len =3D xfer_buf_len;
>  	bool dma_coherent;
> -	unsigned long iova;
> +	dma_addr_t xfer_buf_dma_sysdev;
>  	u32 remainder;
>  	u32 mult;
>  	int ret;
> @@ -1045,29 +1046,38 @@ static int uaudio_transfer_buffer_setup(struct sn=
d_usb_substream *subs,
>  		len =3D MAX_XFER_BUFF_LEN;
>  	}
> =20
> -	xfer_buf =3D usb_alloc_coherent(subs->dev, len, GFP_KERNEL, &xfer_buf_p=
a);
> +	/* get buffer mapped into subs->dev */
> +	xfer_buf =3D usb_alloc_coherent(subs->dev, len, GFP_KERNEL, &xfer_buf_d=
ma);
>  	if (!xfer_buf)
>  		return -ENOMEM;
> =20
> +	/* Remapping is not possible if xfer_buf is outside of linear map */
> +	xfer_buf_pa =3D virt_to_phys(xfer_buf);
> +	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
> +		ret =3D -ENXIO;
> +		goto unmap_sync;
> +	}
>  	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
> -			xfer_buf_pa, len);
> -	iova =3D uaudio_iommu_map(MEM_XFER_BUF, dma_coherent, xfer_buf_pa, len,
> -			      &xfer_buf_sgt);
> -	if (!iova) {
> +			xfer_buf_dma, len);
> +
> +	/* map the physical buffer into sysdev as well */
> +	xfer_buf_dma_sysdev =3D uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
> +					       xfer_buf_pa, len, &xfer_buf_sgt);
> +	if (!xfer_buf_dma_sysdev) {
>  		ret =3D -ENOMEM;
>  		goto unmap_sync;
>  	}
> =20
> -	mem_info->dma =3D xfer_buf_pa;
> +	mem_info->dma =3D xfer_buf_dma;
>  	mem_info->size =3D len;
> -	mem_info->iova =3D PREPEND_SID_TO_IOVA(iova, uaudio_qdev->data->sid);
> +	mem_info->iova =3D PREPEND_SID_TO_IOVA(xfer_buf_dma_sysdev, uaudio_qdev=
->data->sid);
>  	*xfer_buf_cpu =3D xfer_buf;
>  	sg_free_table(&xfer_buf_sgt);
> =20
>  	return 0;
> =20
>  unmap_sync:
> -	usb_free_coherent(subs->dev, len, xfer_buf, xfer_buf_pa);
> +	usb_free_coherent(subs->dev, len, xfer_buf, xfer_buf_dma);
> =20
>  	return ret;
>  }


