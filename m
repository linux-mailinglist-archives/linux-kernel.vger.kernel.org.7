Return-Path: <linux-kernel+bounces-628752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501D0AA6202
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7616AEE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928AA11185;
	Thu,  1 May 2025 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="jklqky9l"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079201DC1AB
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118983; cv=none; b=dPumT28cbGWwdXTUnwHiJHL0Rs75zFYJnLO+Lp5a4fnqWQgVW9m5aJkw0I53ZQluz3ilop6wpjVJgdNDG1JUwLkTEVtW+q1XZZsoK/2tDR+Q6vjIojD2moPZ1bDm8o/gq8aPeFqJDxU+PzUc2ZZ4IP2+f6NFblAg0DN/0zSRg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118983; c=relaxed/simple;
	bh=dSiDMd+puSYJs9M8bjAAeKiONSkB2Z55opOgZxMzSVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=beCwXvm9Qokp3PsDxo/nSll3Gd9TRykZAGGkOYh64zlXNpOZOksrbOHLOOvz2KYy9eqbJifKdECRA1LYbShaut5HzxoYxRqDDMKTssamp01Y8ko00yNmCbvZLgaCPypesg+bDnheiKMxXzQxTFpgpIi8KtGhvW1v3hu2WqhRsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=jklqky9l; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5a88b34a6so118140585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1746118981; x=1746723781; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AnmKRR26C0Aot9dN/CEjPuuqw6IsSEUnG0n8Vnz6PHk=;
        b=jklqky9loAaWH7kxu5bR6gu8UFIUxD4t5PQ+RgMKjtK8XYjYTaXPulNdLWldKsqUqn
         1Byt7Xbkx74OZZe1CG4XorioXG2CHdr7grQ5miS56WyXN4dlnd7u4tL6H9vOSl4x6SuY
         EDZRKEfmvMxE4RCIdjwNEk5cXzZmQPVdPvCc9kZseK0E4zQR6kpthQRcpblOqQYxC4Us
         Xw9fAGeuOkiA9j/cMvKwagkVLOIMZzlJl76sA9VIJ2d3IFMY3+7aM7XbinvWgC2VjtpF
         DFnMT0y7J+ACHA5ZDKzwv9GH4BO/FCDp2mO0PP1W6/f03ZArGaTcIz3lpEbM/GrtkCP/
         LR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746118981; x=1746723781;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AnmKRR26C0Aot9dN/CEjPuuqw6IsSEUnG0n8Vnz6PHk=;
        b=nlSUIlVho6G8I8CiAo1HQaLokSm81Bd7CFAfvlJloUVt8/bXh/utPhK6BEsMQrqBMU
         YTRa/wu7I/PrCJ1YwvFnhr7RZch3/Kk4YBVPvJUt72uxJ3Ss6HkP1NyMq+7/wxiar6k7
         nG1c3wsdfRScxU5J+WtZg7IlVoavW1BRzYIWuhhRz4xozZ3GPDyOWAEkBxpvPQvJFHrb
         spOAD1QIHsO1dcsiKpLAT0hycH/9VkY2vKA7GiqNfjqbnZh0qEv3uRGncflqbHI9PeeN
         N85ttL8tGDmlXV5oTtdEHoO9aMSSvI8pK8ROi6Ii2SFvXp2+cQkr5xUMJgHfsAE5ppMX
         PzYg==
X-Forwarded-Encrypted: i=1; AJvYcCUV97GP01xeXukOcAA22e6it3MFrb438LtTPLtr6mft8Y7f0KB/rbmUQrfzauk6HcBvBZuVlpM1i3ukK6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YygPckcSSpeZgKltTgGNY3i0Edo744KAg+bZjgenOX9F9Ykh1Wf
	CJfhZsjsORO+GHTKcqki1K8Kwu+1t8DZJVScn4JQLYxvuVN8rlx+GMfOcZy2NCU=
X-Gm-Gg: ASbGncsGINcArWc4a+uEQ30nwvX7UTU4gh0AKOhnpyj6AUrOzY/a6i1KgBIHk6H4PVt
	d7g7Ctu6V1zBZ0KmR991xsTCE263ELE1zzmMeMfOBA9Mty1PBrM0xnDzm/nJ5VrrX0gZMZ1TJNR
	R9tikwI/Yrj172PcuSfM+KMFkt5V5gUI0PCB8FGlHt9gf9TKUjWADbYpCITCD7lSNo+WDvNY88E
	zOTUmhkl05MUtocTWLRUUVnQ5bKvALVahHaCmEPjgaLImLXjt54NF2kSsVxCqI9F7y/t2arbPuS
	3pwdJgQTb9N+77VaKDjt/VrSKrbJ45Y78s4pxcV29QcRFQ==
X-Google-Smtp-Source: AGHT+IEWhy01ShAhWfub+iOOfu/TJN+6Qalpa374amdQx7s9VHC4cwQvXlZq/+brCm8fEf5wo6mH0Q==
X-Received: by 2002:a05:620a:4694:b0:7c5:4788:a14e with SMTP id af79cd13be357-7cac7e97b3cmr976977585a.39.1746118980731;
        Thu, 01 May 2025 10:03:00 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:8242::5ac? ([2606:6d00:17:8242::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23d1c99sm68552885a.63.2025.05.01.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 10:03:00 -0700 (PDT)
Message-ID: <c9981a1e01281153748a1edd4096f4ce1aaae576.camel@ndufresne.ca>
Subject: Re: [PATCH] media: imx-jpeg: Account for data_offset when getting
 image address
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: ming.qian@oss.nxp.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	mirela.rabulea@oss.nxp.com
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
 linux-imx@nxp.com, 	imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org
Date: Thu, 01 May 2025 13:02:59 -0400
In-Reply-To: <20250430053928.214-1-ming.qian@oss.nxp.com>
References: <20250430053928.214-1-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mercredi 30 avril 2025 =C3=A0 13:39 +0800, ming.qian@oss.nxp.com a =C3=
=A9crit=C2=A0:
> From: Ming Qian <ming.qian@nxp.com>
>=20
> Applications may set data_offset when it refers to an output queue. So
> driver need to account for it when getting the start address of input
> image in the plane.
>=20
> Meanwhile data_offset is included in bytesused. So the data_offset
> should be subtracted from the payload of input image.

I think you should revisit this commit message a little in the next version=
.
While the overall patch looks good, I believe you forgot to add code to ver=
ify
that addr + data_offset still falls within the HW needed alignment. I don't
have the HW documentation for that chip, but I have never seen HW capapble =
of
handlign random alignment.

Without the data_offset, the data is always page align, so we don't usually
have to validate that.

regards,
Nicolas

>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
> =C2=A0.../media/platform/nxp/imx-jpeg/mxc-jpeg.c=C2=A0=C2=A0=C2=A0 | 42 +=
+++++++++++++-----
> =C2=A01 file changed, 31 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/med=
ia/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 1221b309a916..035368d65913 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -587,6 +587,27 @@ static void _bswap16(u16 *a)
> =C2=A0	*a =3D ((*a & 0x00FF) << 8) | ((*a & 0xFF00) >> 8);
> =C2=A0}
> =C2=A0
> +static dma_addr_t mxc_jpeg_get_plane_dma_addr(struct vb2_buffer *buf, un=
signed int plane_no)
> +{
> +	if (plane_no >=3D buf->num_planes)
> +		return 0;
> +	return vb2_dma_contig_plane_dma_addr(buf, plane_no) + buf->planes[plane=
_no].data_offset;
> +}
> +
> +static void *mxc_jpeg_get_plane_vaddr(struct vb2_buffer *buf, unsigned i=
nt plane_no)
> +{
> +	if (plane_no >=3D buf->num_planes)
> +		return NULL;
> +	return vb2_plane_vaddr(buf, plane_no) + buf->planes[plane_no].data_offs=
et;
> +}
> +
> +static unsigned long mxc_jpeg_get_plane_payload(struct vb2_buffer *buf, =
unsigned int plane_no)
> +{
> +	if (plane_no >=3D buf->num_planes)
> +		return 0;
> +	return vb2_get_plane_payload(buf, plane_no) - buf->planes[plane_no].dat=
a_offset;
> +}
> +
> =C2=A0static void print_mxc_buf(struct mxc_jpeg_dev *jpeg, struct vb2_buf=
fer *buf,
> =C2=A0			=C2=A0 unsigned long len)
> =C2=A0{
> @@ -599,11 +620,11 @@ static void print_mxc_buf(struct mxc_jpeg_dev *jpeg=
, struct vb2_buffer *buf,
> =C2=A0		return;
> =C2=A0
> =C2=A0	for (plane_no =3D 0; plane_no < buf->num_planes; plane_no++) {
> -		payload =3D vb2_get_plane_payload(buf, plane_no);
> +		payload =3D mxc_jpeg_get_plane_payload(buf, plane_no);
> =C2=A0		if (len =3D=3D 0)
> =C2=A0			len =3D payload;
> -		dma_addr =3D vb2_dma_contig_plane_dma_addr(buf, plane_no);
> -		vaddr =3D vb2_plane_vaddr(buf, plane_no);
> +		dma_addr =3D mxc_jpeg_get_plane_dma_addr(buf, plane_no);
> +		vaddr =3D mxc_jpeg_get_plane_vaddr(buf, plane_no);
> =C2=A0		v4l2_dbg(3, debug, &jpeg->v4l2_dev,
> =C2=A0			 "plane %d (vaddr=3D%p dma_addr=3D%x payload=3D%ld):",
> =C2=A0			=C2=A0 plane_no, vaddr, dma_addr, payload);
> @@ -701,16 +722,15 @@ static void mxc_jpeg_addrs(struct mxc_jpeg_desc *de=
sc,
> =C2=A0	struct mxc_jpeg_q_data *q_data;
> =C2=A0
> =C2=A0	q_data =3D mxc_jpeg_get_q_data(ctx, raw_buf->type);
> -	desc->buf_base0 =3D vb2_dma_contig_plane_dma_addr(raw_buf, 0);
> +	desc->buf_base0 =3D mxc_jpeg_get_plane_dma_addr(raw_buf, 0);
> =C2=A0	desc->buf_base1 =3D 0;
> =C2=A0	if (img_fmt =3D=3D STM_CTRL_IMAGE_FORMAT(MXC_JPEG_YUV420)) {
> =C2=A0		if (raw_buf->num_planes =3D=3D 2)
> -			desc->buf_base1 =3D vb2_dma_contig_plane_dma_addr(raw_buf, 1);
> +			desc->buf_base1 =3D mxc_jpeg_get_plane_dma_addr(raw_buf, 1);
> =C2=A0		else
> =C2=A0			desc->buf_base1 =3D desc->buf_base0 + q_data->sizeimage[0];
> =C2=A0	}
> -	desc->stm_bufbase =3D vb2_dma_contig_plane_dma_addr(jpeg_buf, 0) +
> -		offset;
> +	desc->stm_bufbase =3D mxc_jpeg_get_plane_dma_addr(jpeg_buf, 0) + offset=
;
> =C2=A0}
> =C2=A0
> =C2=A0static bool mxc_jpeg_is_extended_sequential(const struct mxc_jpeg_f=
mt *fmt)
> @@ -967,8 +987,8 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *pr=
iv)
> =C2=A0			vb2_set_plane_payload(&dst_buf->vb2_buf, 1, payload);
> =C2=A0		}
> =C2=A0		dev_dbg(dev, "Decoding finished, payload size: %ld + %ld\n",
> -			vb2_get_plane_payload(&dst_buf->vb2_buf, 0),
> -			vb2_get_plane_payload(&dst_buf->vb2_buf, 1));
> +			mxc_jpeg_get_plane_payload(&dst_buf->vb2_buf, 0),
> +			mxc_jpeg_get_plane_payload(&dst_buf->vb2_buf, 1));
> =C2=A0	}
> =C2=A0
> =C2=A0	/* short preview of the results */
> @@ -1827,8 +1847,8 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx,=
 struct vb2_buffer *vb)
> =C2=A0	struct mxc_jpeg_sof *psof =3D NULL;
> =C2=A0	struct mxc_jpeg_sos *psos =3D NULL;
> =C2=A0	struct mxc_jpeg_src_buf *jpeg_src_buf =3D vb2_to_mxc_buf(vb);
> -	u8 *src_addr =3D (u8 *)vb2_plane_vaddr(vb, 0);
> -	u32 size =3D vb2_get_plane_payload(vb, 0);
> +	u8 *src_addr =3D (u8 *)mxc_jpeg_get_plane_vaddr(vb, 0);
> +	u32 size =3D mxc_jpeg_get_plane_payload(vb, 0);
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	memset(&header, 0, sizeof(header));
>=20
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> prerequisite-patch-id: 0000000000000000000000000000000000000000

