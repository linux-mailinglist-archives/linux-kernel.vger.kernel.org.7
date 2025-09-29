Return-Path: <linux-kernel+bounces-835786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B138BBA80E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB251757B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5723D7D2;
	Mon, 29 Sep 2025 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4kR6gL0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649D23C505
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125965; cv=none; b=tdwPuW45gkRKhnAR9XlH5OOtjiHRTlv3ETWk2aPTvYw+cyGCVj5EU9R/Cbd96ZwXMLcjk/RW0LFCKTzhIHaezamZnTbW/ETs5zy+1yuVKzl+/2BtrIB+wmbiYllfC3o5MrMSc27LGQ+67eMSBbdV4b2Y+j7WUtkxRzfmhz52WSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125965; c=relaxed/simple;
	bh=4ZVJUKJcStOkfQvNu132ByH2QSL2oYRTRtM5t2938z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYxgBwTGU9PdPbh5HP0BjrzT3msk3pm1HEK130qLmlDm2KdAgDwlm4er5M+/FDJomy4hb4oLrOe3JFtIro74Luzhm6VaYCwXyz+AEdPl+Vx9Nh3J6w3hlt3Zqofa4X0VwM5SnRGVB+GRADpbxot/yyCRuyM8xn/UziVwWbJjj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4kR6gL0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1yGIQOsQZ3m8F6SURAT4ync4Dvco6agAIcb00xK3BQ=;
	b=d4kR6gL0gn0UmGGornCv3+kMmEB5AUYf7xmhPYMe+RDqDNeBVL5W4pQBdhMjcMI232BvNL
	0Du2N2pOUJuNW4lXiSEEuTbJv9N+V/ZpTHkhu/Th7NN2Pc6+4XA+Ky1eJaFaxTUZKYJFaM
	iAA2NOqtk7HupDyTzkuIB5LXnNT2VNg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-iVrH2qhDNxy3QIeaoJ9Zfw-1; Mon, 29 Sep 2025 02:06:01 -0400
X-MC-Unique: iVrH2qhDNxy3QIeaoJ9Zfw-1
X-Mimecast-MFC-AGG-ID: iVrH2qhDNxy3QIeaoJ9Zfw_1759125958
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-76c144b0706so45784437b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125958; x=1759730758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1yGIQOsQZ3m8F6SURAT4ync4Dvco6agAIcb00xK3BQ=;
        b=S72+fzZTSD3NEvhsvmacvbx5+My1wwgEa+9sCzUA4CoKCgdYFyA/uXZDwIK52EOvGA
         2+qnwixjfGqJnclbdJvHPFlYbL33I3Ovn8cJqxad067jdQP9GlgJ6cQFBjzWkC6+BCBa
         RXYyXsOxzuKBpzzVbbNaGsgJ9+M6iOm18iG35KG60yALdHYt9jo3Pv/tc2niPZm3nEqN
         1EMarQ19zIMQKlxw+pFPSVk868xpQKLoNZVmhDuWPgvy5tgOZwVer/BXIx68L4zGiXv+
         Xq0CSgotc3ragWlxF496ZT5lxlbhQX5NCs+guP45/lTRcdPwPjiVC07Qpj/X19st89Su
         Be+w==
X-Forwarded-Encrypted: i=1; AJvYcCXSYjshCD2AlJjSWunc3WdxziT/41laCKO85YgoNogOgSVIYP1qcFgavcNUgt5Llc94xhmmlLoc9VkS2qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1gJTp18XgGjWpc/yYpftprg9ZBIVYdf7PvPtY8pAH3ITGAZx
	iltzwMesIzFVfdhdSUt/GqwGbUoEQGKPZjtWY7FOo1E8doUUSrlR0zZ0tEmJTKkcYcbssOfhn97
	Hdr7EQOnWAAAu3nkCaBp91/ZbQNAPgu0sfxwaYUf/E7Hd5wwY1L5A7i0Dw1mcFn403iAygcWXh0
	5JVahzCV7Rxw2OdS1WVymBjJXIKKugaaRy7spDQL2P
X-Gm-Gg: ASbGncvqXP7kaQhjaTB+/o/I3O6uWCYtYnTxIkvHMkjgw9RfLzmUhf2mf+Mcuea2kuP
	xUsHwyskkdLvdxBxrUizO5wNhJM6pOw2RYwLAGbB6LoEmbJ9FnzsBex3UkhAPw1So7Co5LJD9aw
	UqsbWN2PkOJdd9IboNxPSrl3JNocNCR6WjqAHCLtqYYncauZcrcGSrwANsZD5nRyVQzY9Lc5Wh9
	VNDj3wk
X-Received: by 2002:a05:690e:4289:10b0:636:ca97:d6d2 with SMTP id 956f58d0204a3-636ca97d773mr16173573d50.20.1759125957873;
        Sun, 28 Sep 2025 23:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+BjaVuGyoNFx3yUGngOCBRLm43JB3sIAw6ThgC682NtQbB9nf4C73RlWOHPZlMIy2Osnpg0Z6d8vSJeF229Y=
X-Received: by 2002:a05:690e:4289:10b0:636:ca97:d6d2 with SMTP id
 956f58d0204a3-636ca97d773mr16173546d50.20.1759125957498; Sun, 28 Sep 2025
 23:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNfXvrK5EWIL3avR@stanley.mountain>
In-Reply-To: <aNfXvrK5EWIL3avR@stanley.mountain>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 08:05:20 +0200
X-Gm-Features: AS18NWBs1i9BHagRuYUX084a7zMJ_6ylNkBNHWiX3YPpcoyysxZQU5lwQENWqTE
Message-ID: <CAJaqyWfBoY0_X=xRnGBecDFUJqSJEitgVKzopumA4fsZVfC11g@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 2:25=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The group is supposed to be copied to the user, but it wasn't assigned
> until after the copy_to_user().  Move the "s.num =3D group;" earlier.
>
> Fixes: ffc3634b6696 ("vduse: add vq group support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This goes through the kvm tree I think.
>
>  drivers/vhost/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6305382eacbb..25ab4d06e559 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>                 group =3D ops->get_vq_group(vdpa, idx);
>                 if (group >=3D vdpa->ngroups || group > U32_MAX || group =
< 0)
>                         return -EIO;
> -               else if (copy_to_user(argp, &s, sizeof(s)))
> -                       return -EFAULT;
>                 s.num =3D group;
> +               if (copy_to_user(argp, &s, sizeof(s)))
> +                       return -EFAULT;
>                 return 0;
>         }
>         case VHOST_VDPA_GET_VRING_DESC_GROUP:


Thank you very much for the report Dan! that should be fixed in v5.


