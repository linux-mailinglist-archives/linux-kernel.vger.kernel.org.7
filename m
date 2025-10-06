Return-Path: <linux-kernel+bounces-843407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD21BBF1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2275234B6EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49E256C9B;
	Mon,  6 Oct 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hz879l2J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5513BC0C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780010; cv=none; b=RmK2Qj+LrkJxYtdtOo27llAVLkAC+6ISP8IRpI9zSnB1jhRPCWIE38AFBM8Gvy25n75XvjdWi1tGxywvVfBtDuSdogrepOUerBgNlf2tSiHumrdg7OsQTQxldMNg30Q4EUNK+ziXzgW87+o2+49cAF2C/SeN/cXYdRL3jlqY/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780010; c=relaxed/simple;
	bh=RpzZsSQdr0hQNB60BVgDeuxT0TDaqlGHirWXIco0GKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoSLZeP0gC7PrnpaXWDzfNmzU6engWlU3ZFBLQrr4E5LlrP3jpUfGW3ydUaYtdIdVw5E6NMV1Lop7loOjm14y1xqwE7MJ0danDiXCo6463L5Mxbpy5gisxyLHF44lpBB3DZsBA5DF1zV2U3OClzHSsMeChwepFAecWTdr46qq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hz879l2J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759780007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEP4bvQgSEfzGRmi8Yd/uqvmJgEkoYKfsq3TYxXDi7E=;
	b=hz879l2J0g0R4CJ9k3RV6qygzgvyyjxKSVdcMcxh7ERPejuHLC/KTm9U5avmHpeJjPJQ6l
	dabghhjxOLjf3idCFOp5J4lQ7CilERswVO3yaykI0d3Kok5rp5zvFJ/leLKz/yMTrbJ86P
	0f4UxWcb203WNV2xU+qRmW6jY964YFU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-6hF_eWB_O1y2oIWEDlHMVw-1; Mon, 06 Oct 2025 15:46:46 -0400
X-MC-Unique: 6hF_eWB_O1y2oIWEDlHMVw-1
X-Mimecast-MFC-AGG-ID: 6hF_eWB_O1y2oIWEDlHMVw_1759780005
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9249b828549so90883939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759780005; x=1760384805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEP4bvQgSEfzGRmi8Yd/uqvmJgEkoYKfsq3TYxXDi7E=;
        b=CJ9udyuusZ9XC4JoMYGau0e51lqc/WvDAUTXdJitZp7QPjqbjApcSAi1jylTbxA0Mp
         EJvqQrZlxaLhRR/2lWUVC6CUZU4Me/+uVWe3MtdUrf+8NkivqJorX+MYVtlY/Q3vOVI5
         ZdIytp3s8hy5Xy++krBjfvkNIhaN4xd7+RTwCqjTl7Kpn60myaHOswUNW08R5Q53o00Z
         SXSJ7gIpTzRVkalZ2x6GhW1oOFBVyS+w9sOmWdL5xL7rB9keeVd5i+f5YfzaicgnyycY
         iGO0vmpuviWKZQVBSJe3WKCLnnviAVEeWw76FS1hbK51o6c088Kg0xKXTwOlaP+8b2Fg
         FHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsxzPfrkEG/Nx1KbpcyA5814ELDBCbyBMhreZqZFlq5OouOUJjKc8Okz3zzhOSukGogkzBSTQ+nuWjLaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHfA+dd+nms14VIy7Q8bFEY2lOfAV8XoWcKTHQxn8K3GaqSDJ
	TdLCTWDReL9mTiWoKVhvnza0x3usiQxYnomKn+20B6yqkpErUJ8rZ3p9SzKd3NKJTa01rTprs6Z
	EbJXu4zaOptrbcJqHRQps4FplC80Yz+42PZZo80kQ/eqGDgAG9WI+bjEYhpRJy8U9Dw==
X-Gm-Gg: ASbGncvU1mIDTp0Fs30XM/+j3CE8Zn1SsmR0FvwkBR0RFth+5wD/qZ2oPlwTuzeIsoh
	CNY8eBbBswheJygsap9QfaTvphIEkOJ2fWjp9RGYlavNEybVrRbqJsQnVGo3scX/VlP8kJDtoB6
	KIftDGQtgS/DC0P7ym9G54URIHVg6oAB5S8QX7WBfB/DvPTcAW80hAi13E9/GxMt32y2SV3OPDy
	Je5XiROwJ2ITkFloPWUuPWYnXp46I7V/3TAkcseiTgAIrNjHoNx8gPaD/kxxiV1ewCTb4BlawBp
	XneBQ7ccpbWSOsfYepwnz9ffTLtjaVB06O5T0RtcJbpJ71Sd
X-Received: by 2002:a05:6e02:1a81:b0:42d:89d2:bb with SMTP id e9e14a558f8ab-42e7ad894ebmr73562605ab.6.1759780005299;
        Mon, 06 Oct 2025 12:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEifc22XtdKCJ76WuLXjkG/CH7GbrgaM1lNvaHoU49PuB2rEVRz9xNuIY1xjj+apJYv7FEpWA==
X-Received: by 2002:a05:6e02:1a81:b0:42d:89d2:bb with SMTP id e9e14a558f8ab-42e7ad894ebmr73562395ab.6.1759780004792;
        Mon, 06 Oct 2025 12:46:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5e9ec393sm5228654173.14.2025.10.06.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:46:44 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:46:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: Dump migration features under debugfs
Message-ID: <20251006134642.4aee649a.alex.williamson@redhat.com>
In-Reply-To: <20250918121928.1921871-1-clg@redhat.com>
References: <20250918121928.1921871-1-clg@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sep 2025 14:19:28 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> A debugfs directory was recently added for VFIO devices. Add a new
> "features" file under the migration sub-directory to expose which
> features the device supports.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  drivers/vfio/debugfs.c                 | 19 +++++++++++++++++++
>  Documentation/ABI/testing/debugfs-vfio |  6 ++++++
>  2 files changed, 25 insertions(+)

I think this was overlooked, but should have been considered for the
v6.18 merge window.  Given the plan to get the DMA mapping
optimizations in this merge window, I think we should pull this in too.
Applied to the vfio next branch.  Thanks,

Alex
=20
> diff --git a/drivers/vfio/debugfs.c b/drivers/vfio/debugfs.c
> index 298bd866f15766b50e342511d8a83f0621cb4f55..8b0ca7a09064072b3d489dab8=
072dbb1a2871d10 100644
> --- a/drivers/vfio/debugfs.c
> +++ b/drivers/vfio/debugfs.c
> @@ -58,6 +58,23 @@ static int vfio_device_state_read(struct seq_file *seq=
, void *data)
>  	return 0;
>  }
> =20
> +static int vfio_device_features_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev =3D seq->private;
> +	struct vfio_device *vdev =3D container_of(vf_dev, struct vfio_device, d=
evice);
> +
> +	if (vdev->migration_flags & VFIO_MIGRATION_STOP_COPY)
> +		seq_puts(seq, "stop-copy\n");
> +	if (vdev->migration_flags & VFIO_MIGRATION_P2P)
> +		seq_puts(seq, "p2p\n");
> +	if (vdev->migration_flags & VFIO_MIGRATION_PRE_COPY)
> +		seq_puts(seq, "pre-copy\n");
> +	if (vdev->log_ops)
> +		seq_puts(seq, "dirty-tracking\n");
> +
> +	return 0;
> +}
> +
>  void vfio_device_debugfs_init(struct vfio_device *vdev)
>  {
>  	struct device *dev =3D &vdev->device;
> @@ -72,6 +89,8 @@ void vfio_device_debugfs_init(struct vfio_device *vdev)
>  							vdev->debug_root);
>  		debugfs_create_devm_seqfile(dev, "state", vfio_dev_migration,
>  					    vfio_device_state_read);
> +		debugfs_create_devm_seqfile(dev, "features", vfio_dev_migration,
> +					    vfio_device_features_read);
>  	}
>  }
> =20
> diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/t=
esting/debugfs-vfio
> index 90f7c262f591306bdb99295ab4e857ca0e0b537a..70ec2d454686290e13380340d=
fd6a5a67a642533 100644
> --- a/Documentation/ABI/testing/debugfs-vfio
> +++ b/Documentation/ABI/testing/debugfs-vfio
> @@ -23,3 +23,9 @@ Contact:	Longfang Liu <liulongfang@huawei.com>
>  Description:	Read the live migration status of the vfio device.
>  		The contents of the state file reflects the migration state
>  		relative to those defined in the vfio_device_mig_state enum
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/features
> +Date:		Oct 2025
> +KernelVersion:	6.18
> +Contact:	C=C3=A9dric Le Goater <clg@redhat.com>
> +Description:	Read the migration features of the vfio device.


