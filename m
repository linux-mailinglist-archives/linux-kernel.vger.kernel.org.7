Return-Path: <linux-kernel+bounces-841260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE571BB6A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66EC84EC01E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598752ED842;
	Fri,  3 Oct 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2nphN0j"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC671FBEA8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494569; cv=none; b=TcyzZwghNfUbDtLT4b9k9DyOdNZ+jiHFeUfa1FBpI9TRtZowJIy3ljvnouE+2Q/XbpsuCYdurIjPYzrmxA13WKY/1vTfPLPQAUaqI4YinTcHU29SMu70i/LCZqefUpwTwDIwAUVJG9sSHCEl/7FF1mV3ysmPOSsvcm5ozv6kF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494569; c=relaxed/simple;
	bh=/CND8t3BcBjV3O0UUv8EsdrO1dhpn6lKBDpZ2Bi/F44=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=tcCcxrH7sFttiXs1Ncqb/Jo+AiamxvGIsezeuzaSFo3bsYuE6elDHVXUZvhZaVUGTflW/6RKivlbY8D97gqguUl8WEtcgnwezBmql8UFzdk8qoXhQ7T6IYNv8qJhywdIbFTM/MnWNNrxGROhtFcw7foYD8Tu4LIa1Yx7jJdMyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2nphN0j; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33292adb180so2214174a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759494567; x=1760099367; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qcC/tcBvgf7hatQn8BuNZiQSeiX/UHWJ9TJd1uohRA=;
        b=Q2nphN0jo3NYBQjbVvIFXaK8JrpiIcsQOj1cB2vSe4pDeHMk6XSsADlJ04EuaLFZJH
         1dyraI9E5eLCn8n5KDmiuOoHjRBBm6J7D34YNXLe9zSP+RnamCI5e2v/7Z+G+maSfcIk
         OBt5q8QGN6C+4uGmM3A9zHeHlQ03VNuFHCehnswbg81UgMrMRtMA2dnO++jZK4lmxF5l
         fLBnp1noYqHSA/S9g9pm8hIZM3un4khkmVgjKD6BX84XLU8GlmpXZiHBi/t4zW12oDrs
         9quzj+cCa3F4wHeEY6P0oLf/h20M1pmJzK/KW8agPrXQZZH9/4fVt02Ompm2ove64U8e
         OX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759494567; x=1760099367;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+qcC/tcBvgf7hatQn8BuNZiQSeiX/UHWJ9TJd1uohRA=;
        b=T6VUi7cJ/C4qNiD2e/u1AQIpEypYduM/mQ+mm+1IwwiFzqqVGwlwGmh5FdZUrtteD5
         T/dh3aUTkDT/fMVRy78feFMRzG8a68wdzH7Wat04Dw+aEoLt9fRmAXsomZQf47nhEf41
         z9hgxCvvkGdUa/KK48YNp8qCuxy3kvSSuVkj2plo52cI3+q102Bj5gCefBUEWtyupr9H
         5sECXBvIY4CZ30BeRv5vKO6CTeIHDdJe8XSVm+G5FYC91tjpPU+yPk5kNVw34SIzdtcT
         dacJxeoX43UWyONdhUmcSlVMfpAdnE2KmBeDvOczX2aqhLCH71pEpE3rMZIlJ7VFzO1S
         pmAg==
X-Forwarded-Encrypted: i=1; AJvYcCUxQRLFyiAgvZaheWa7O3vSYvZJ+Bxc1URoKczuplSAJerFwg1ro654Jq+xzqdAdXRpi9MHndzEmeY8G8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3APSLyZ7uLTNpGQ+RrPOAZ5o9mJ/ssVcQ+HHUsfRErVYuXhLh
	rez1/Cn5EO7w0bQZ/kGWfQdJmwiAsoSymRlicLoJMkr8Hq/0IVhu2kDT
X-Gm-Gg: ASbGnctJ3VjOr6pNgvSv1xKYtQfFuUCIRMkeW5RSUmAgdkI0qVU+/uiK2sal7BiomJJ
	PqyNkQOaBqbP/iPB+jKaDj1mtCe1l66xT+SeA6vaiGFuBWhfhB3QmB/cCPoYjPUbFXI/ilf8cgl
	zq9ZkHOBv+dQw76lkUXf0lvWB/tSHozWSW6KRrw31uZ9utXddIt7nYSwTl+07mfUETv3EJLRY/A
	zwuaQZC8WDBeZyeNxMsmD1JyxEGtmQNKHJV33LddqBUvKCE0/tv4wwGRsZ3DgvufoZYzrm6cxac
	U1biUoUAV7jFRdUPwF33T3Rw43rgmgufcXGo+UiWjosYZOaWKOVmLRexBdbR+/LDMrrCMp7dyDf
	ioL1XP7H0RJI6qcIeT1pjjrOIi84VTnlzhJ1d3tyi1HyxJgI+/G6Vqw==
X-Google-Smtp-Source: AGHT+IEkFL+jbPprPabuphf95ftwUfyvcBuMrfOgsoujeM8/QjA6VQyryDCyOaAkQhLD58s0xdw0Aw==
X-Received: by 2002:a17:90b:3ec3:b0:330:6f13:53fc with SMTP id 98e67ed59e1d1-339c279e68bmr3245456a91.27.1759494567263;
        Fri, 03 Oct 2025 05:29:27 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f58ac2sm4545381a12.35.2025.10.03.05.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 05:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Oct 2025 21:29:23 +0900
Message-Id: <DD8ORNMB155Q.1JK8F13D9FLNR@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net] net: dlink: handle dma_map_single() failure
 properly
X-Mailer: aerc 0.20.1
References: <20251002152638.1165-1-yyyynoom@gmail.com>
 <20251003094424.GF2878334@horms.kernel.org>
In-Reply-To: <20251003094424.GF2878334@horms.kernel.org>

On Fri Oct 3, 2025 at 6:44 PM KST, Simon Horman wrote:
> On Fri, Oct 03, 2025 at 12:26:38AM +0900, Yeounsu Moon wrote:
>> Add error handling by checking `dma_mapping_error()` and cleaning up
>> the `skb` using the appropriate `dev_kfree_skb*()` variant.
>>=20
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
>> Tested-on: D-Link DGE-550T Rev-A3
>> ---
>>  drivers/net/ethernet/dlink/dl2k.c | 49 ++++++++++++++++++++++++-------
>>  1 file changed, 38 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dl=
ink/dl2k.c
>> index 1996d2e4e3e2..a821c9921745 100644
>> --- a/drivers/net/ethernet/dlink/dl2k.c
>> +++ b/drivers/net/ethernet/dlink/dl2k.c
>> @@ -508,6 +508,7 @@ static int alloc_list(struct net_device *dev)
>>  	for (i =3D 0; i < RX_RING_SIZE; i++) {
>>  		/* Allocated fixed size of skbuff */
>>  		struct sk_buff *skb;
>> +		dma_addr_t addr;
>> =20
>>  		skb =3D netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
>>  		np->rx_skbuff[i] =3D skb;
>> @@ -516,13 +517,19 @@ static int alloc_list(struct net_device *dev)
>>  			return -ENOMEM;
>>  		}
>> =20
>> +		addr =3D dma_map_single(&np->pdev->dev, skb->data,
>> +				      np->rx_buf_sz, DMA_FROM_DEVICE);
>> +		if (dma_mapping_error(&np->pdev->dev, addr)) {
>> +			dev_kfree_skb(skb);
>> +			np->rx_skbuff[i] =3D NULL;
>> +			free_list(dev);
>> +			return -ENOMEM;
>> +		}
>>  		np->rx_ring[i].next_desc =3D cpu_to_le64(np->rx_ring_dma +
>>  						((i + 1) % RX_RING_SIZE) *
>>  						sizeof(struct netdev_desc));
>>  		/* Rubicon now supports 40 bits of addressing space. */
>> -		np->rx_ring[i].fraginfo =3D
>> -		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
>> -					       np->rx_buf_sz, DMA_FROM_DEVICE));
>> +		np->rx_ring[i].fraginfo =3D cpu_to_le64(addr);
>>  		np->rx_ring[i].fraginfo |=3D cpu_to_le64((u64)np->rx_buf_sz << 48);
>>  	}
>> =20
>
> Thanks.
>
> I agree that this fixes a problem.
> And I agree that these problems were introduced by the cited commit,
> at a time when pci_map_single() was used instead of dma_map_single().
Thank you for pointing that out. I spent some time making sure that the
`Fixes:` tag you mentioned was applied correctly.
>
> But I wonder if it would be slightly nicer to make this change by
> using the idiomatic pattern of an unwind ladder of goto labels.
I agree that your approach is much cleaner. However, I structured the
code as intuitively and simply as possible, since making it more complex
could make the review harder. I'm curious about the opinions of other
reviewers and the maintainer. If an immediate change is required, I can=20
submit a v2; otherwise; I'll first post the fix patch to `net` and incorpor=
ate
your suggestion in `net-next`.
>
> In the case of alloc_list(), something like the following.
> (Compile tested only!)
>
> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dli=
nk/dl2k.c
> index 1996d2e4e3e2..ba81373bbca8 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -508,25 +508,36 @@ static int alloc_list(struct net_device *dev)
>  	for (i =3D 0; i < RX_RING_SIZE; i++) {
>  		/* Allocated fixed size of skbuff */
>  		struct sk_buff *skb;
> +		dma_addr_t addr;
> =20
>  		skb =3D netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
>  		np->rx_skbuff[i] =3D skb;
> -		if (!skb) {
> -			free_list(dev);
> -			return -ENOMEM;
> -		}
> +		if (!skb)
> +			goto err_free_list;
> +
> +		addr =3D dma_map_single(&np->pdev->dev, skb->data,
> +				      np->rx_buf_sz, DMA_FROM_DEVICE);
> +		if (dma_mapping_error(&np->pdev->dev, addr))
> +			goto err_kfree_skb;
> =20
>  		np->rx_ring[i].next_desc =3D cpu_to_le64(np->rx_ring_dma +
>  						((i + 1) % RX_RING_SIZE) *
>  						sizeof(struct netdev_desc));
>  		/* Rubicon now supports 40 bits of addressing space. */
> -		np->rx_ring[i].fraginfo =3D
> -		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
> -					       np->rx_buf_sz, DMA_FROM_DEVICE));
> +		np->rx_ring[i].fraginfo =3D cpu_to_le64(addr);
>  		np->rx_ring[i].fraginfo |=3D cpu_to_le64((u64)np->rx_buf_sz << 48);
>  	}
> =20
>  	return 0;
> +
> +err_kfree_skb:
> +	dev_kfree_skb(np->rx_skbuff[i]);
> +	np->rx_skbuff[i] =3D NULL;
> +err_free_list:
> +	free_list(dev);
> +
> +	return -ENOMEM;
> +
>  }
> =20
>  static void rio_hw_init(struct net_device *dev)


