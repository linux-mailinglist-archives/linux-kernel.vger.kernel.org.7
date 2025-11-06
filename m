Return-Path: <linux-kernel+bounces-887952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FFCC396EA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF11818C825B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EC27FD59;
	Thu,  6 Nov 2025 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eg8tCdHU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mh3Zu0en"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC5246793
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415127; cv=none; b=RLpcfSjdTBCzlK/so80HlCtVWuWBcfFr7zBu33Med1imY4I1XEHrkcVsjC4M6A7QLM1J3n94DdSD9vmLQGKg8IAjYUpIvZcNT8OgnkaH+arBqVf9YtScZg15AliX5YxXV5eT6sQKLc8sNDpcDnBkn6HUdR1KwEsJk/eHPtJN2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415127; c=relaxed/simple;
	bh=FhMRkeDHmpx7UOf0s82NhMDUTYAcPcf84qt3b/CzGrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk6AxQVJFnCMOxrRk+XxxqqPAZl2XhmJDwQVm3STSWa4e/kCV1O6iF2znBJqBSBcTdFI348UDMhIJchLN/YC+qgGILBLyruXeij5Ih1PryVkKx7teHEwJPnTrDWwpyAvT63klndBzcMIorZEdINaB8vZmGl4BT6kxsAK/Tj4v50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eg8tCdHU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mh3Zu0en; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762415124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiaOGRzrooFT8bXw1lOEtDdsYPzEgg3vg8aNgC4OOFc=;
	b=Eg8tCdHUhTNLsgP+cZKDrAJHkbvuXAlJFna6UHLhC0QYiOsJQ08SwTKc1jtC4pCKFemJZL
	wqDK9ghlFNtrh3jToNpwt4G5BoLVTgPYQYQF6qmbLl4mKWvKpQGNpiSNNtbncM+NW+wMjo
	4WnnLjJJiVbsIkGb5uscxyR+M1IvZ04=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-KMbP8Oi1POaZs_mGQRuZkw-1; Thu, 06 Nov 2025 02:45:23 -0500
X-MC-Unique: KMbP8Oi1POaZs_mGQRuZkw-1
X-Mimecast-MFC-AGG-ID: KMbP8Oi1POaZs_mGQRuZkw_1762415123
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5dda517c3b2so698662137.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762415122; x=1763019922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiaOGRzrooFT8bXw1lOEtDdsYPzEgg3vg8aNgC4OOFc=;
        b=mh3Zu0enUud8wiVPPbd9Ek+xrV3tKUJ3x/+G5Q200Y7FMNTioUncOxW1WAwoU+2QJy
         3nlJYkBShPA8FhXk811skwFniBpUoF30PJ5vb4aXq0D/8i4Kl9MpPbQuxjDLdC9bNjVv
         Glr+zCw/Sb7CzGDVipH6UiDY62iav3lSd61tB0TQEstWs8/2I3RCcU2srzubCNzpX3JF
         Et7hVTo5/QTkzHqJ0Iw4+hjZk+LrTGZv6xSkoq78I7hIYzHOqZmJP2DY2CZkTN6POiFs
         Jfvn8BfKkpZ/KHMISv4yMkvylRa+vfd8W9yBCFX8SiiK8Z+1BL/B11hvjRH1UZSwkB6P
         EHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415122; x=1763019922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiaOGRzrooFT8bXw1lOEtDdsYPzEgg3vg8aNgC4OOFc=;
        b=fDEEM6btlAWc6IXm+11TCnnWpHe+WtBkVFJc/6UknxiplH5GAJVSeioxebKbfQBdRE
         xo2/xucqKbPmu6IidDa5UvBoleu0tTbSsxYAG8y+oSFOLzApBhFb3HDAdTw5qage3Qlh
         0fqy2Y+NKnEgxRqPnOubQZjfp8H9tZCgI/YIpjKEoeSK8uwFQqp3AzGsQriGkmBo7tac
         M+O4RP9ClXUvFA17VOMxAun9e4vweBUugNvO1wsMLTjJCHUxej0DNC39v4i1YZQ6MIJI
         1AbUJ6nwVp1SvDnD/pyALDLAezrgDc7S1vgik4gk4ldl6LjYV/iF3oO+0t+qhR3CcHZn
         LGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTqBHFLPS/h6b2L07nBFx+JxZ50joJq7WWCcpAU2Mt6EnTP/GNms6QcFU8LA5Of9uR25CLwsBYMJKXNR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NZsiHLFlnblFRo3eGg+BlHwX1CsicMwzqoIcZr/v2S/k0PcC
	rOXinePWNNiKftXwADoc8Nl2BXpvt6dCDDvO5mI6zGSS/9NVHeTjAzXwQF5jP1t0TVkSl+xNtxJ
	HC/uJEnjG1YfkYg1TYLmvaSb7aM59/7a1z/I0skwxhRHjJokbnCyc5cWkLj8UrkUfq28K+5Zq60
	Pr6vp1jSToRpDxvuCnlwEXBGvhDTUn9/yPAM64J0MS
X-Gm-Gg: ASbGncs9c2DfzMOY7ACmEkDbhIp9t5VlUBLxLyx1J5BzpkmC3jM1A+pYyNT0Rrgsi04
	8/JoQ+wEbpK+EPLMsHIKuWtFHjmO2CMojV0NT3iP9WG3CUx2UVEQF32OdjgFRVwtpDsqy7LYNCN
	BFK8ab7Ymg127DBCXEBTcE/dRvSDusInZErMmZ45fBShqOcr6yzCy1QKnJ
X-Received: by 2002:a05:6102:292c:b0:4e5:8d09:7b12 with SMTP id ada2fe7eead31-5dd9fd2cd60mr811428137.7.1762415122674;
        Wed, 05 Nov 2025 23:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoxQxGcPfXwcbcmbtlPOZH7F8/LcPCM0wVxj1FiXZSVIZFK4pL2HzFx5j4VbHCoOUFIxQ+8vbnywLMUKBcuK0=
X-Received: by 2002:a05:6102:292c:b0:4e5:8d09:7b12 with SMTP id
 ada2fe7eead31-5dd9fd2cd60mr811418137.7.1762415122317; Wed, 05 Nov 2025
 23:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <CACGkMEvriYoN2XZLmB0KcJmH4hVT3iYj3QV_ypfgHSQNwv296w@mail.gmail.com>
In-Reply-To: <CACGkMEvriYoN2XZLmB0KcJmH4hVT3iYj3QV_ypfgHSQNwv296w@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 6 Nov 2025 15:44:39 +0800
X-Gm-Features: AWmQ_bmGkLtddYZ3bfFGmUC5MtU_iZvCszsK1uxQmJBuiKqg1ei92qfwpzApvMs
Message-ID: <CACLfguXcgMgczeRG1w4Af=FnaR8_0MhtMd+bO8E3Vm-y6RTRXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state check
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 there

On Thu, Nov 6, 2025 at 12:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Nov 5, 2025 at 4:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> > feature bit is properly set only when the device is not yet in
> > the DRIVER_OK (running) state.
> >
> > This makes the MAC address visible in the output of:
> >
> >  vdpa dev config show -jp
> >
> > when the device is created without an initial MAC address.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 82034efb74fc..e38aa3a335fc 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_d=
ev *v_mdev, struct vdpa_device *
> >         ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >         mdev =3D mvdev->mdev;
> >         config =3D &ndev->config;
> > +       if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +               ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC)=
;
> > +       } else {
> > +               mlx5_vdpa_warn(mvdev, "device running, skip updating MA=
C\n");
> > +               return err;
> > +       }
>
> I don't get the logic here, mgmt risk themselve for such races or what
> would happen if we don't do this?
>
> Thanks
>
sure I can move this to the reslock.
I added the VIRTIO_NET_F_MAC bit because when the device is created
without a MAC address, this bit is missing in dev_add. Since we now
configure the MAC address, we need to also add this bit. I now coding
in QEMU to use this bit to identify if the mac address provided by
host.
there is no vdpa_config_ops for device to change the device_features,
So I add it here
Thanks
cindy
> >
> >         down_write(&ndev->reslock);
> >         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > --
> > 2.45.0
> >
>


