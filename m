Return-Path: <linux-kernel+bounces-880670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801E0C264E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D34621FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD33019B8;
	Fri, 31 Oct 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fud+pnBF"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A7288517
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930577; cv=none; b=tLU2X+0T7B5k+bHolE61tPPwh+r+HdEOMrZbngEhB44ifEeS2LTo5omgfJ5guXO7058ox8y+hO3g35SknubGu6p71aZmV8qf789Cy5SnP+OlXbsajxipFafF2LtEh/k0B/MkpQdGo1S/pvjOYG8I6JuM0tq3AYLs6vklbqc5eAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930577; c=relaxed/simple;
	bh=Zal0qUvQYA99X2Dr2KFud1Dc/yidJYhG7mu7wr/gO1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvpCfKia8ywF63IfIAqsBHpkto9odVzDivcjp7W23gs5Z1GA20PG2bKb3jpQlphjL/B65GkpEztdpgkV4hlq0V+qcMpKBQlnqLOHcccNy3OhP2/GJTLMuc29669myntUmlqc2M+KzxvjdUXwTk0FmuB8Lb6UGmKc7HNKdqkmYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fud+pnBF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ea12242d2eso13281cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761930574; x=1762535374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL/56SuWwh5/Qtuu8QLg7wfoYDppiLXxfP3gfkDqRJ4=;
        b=Fud+pnBFejx6yO/IxC3TkqmhS8eDD2JHMypc/F5uQnEkPo766+5ZXPTdWVXrkTbJRB
         0r+nQyH3WHBHWhOAPUEGp+zGf0+LnPGLkp5bWszq64CCp4IS+lW1P7hyHutJ6CoVOeA+
         BqvAO1NVAinlMDpbdx4SU1y8/+7REObvRA8nw2UA7lSik7E79UymgPBXv/RvQB1go+8I
         doZ04JZMH1yY/I13et/lojuXDlAbxc7eUXAArZAR13n+TpIxwzbTcoQA0gQByhjeVglR
         fHgeP2WjxpIhP7hvjHAswQgPlgdIBxOgsaXBR931AYt9uLN4qEE4Ll5BZKxa3lXlLjIM
         nNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930574; x=1762535374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL/56SuWwh5/Qtuu8QLg7wfoYDppiLXxfP3gfkDqRJ4=;
        b=ZIrKR4CMJOkg0KU9J9lvFKNGuMaQq9yEzlblzuJAskzsByfb654QtGUbpVDY8LL+dv
         B01jxpmZwcR2fP81N/2B2mLb70wByBfp3WAS8vGWfyS8uLxwOa2USpXg5rST+t7KiDvg
         b/wm3dQ6TzcTG5Eofudhe2/qPAhIw60nEygvqXLFtP9PO56P//zmCtLaTakgnvVp23mI
         ZOidmZBz4BX54norRZaS1PD+TTR0n+NapuGCfWPCw/N/yDA+FHJaY3YhcC9QT6bG7lJS
         nxIRSZDEvHUdcy+oPt7hBAu6n7AkRie/z2sRPhv6Tk0ch59u9ESZpg6TcrX6loEoET55
         RhNg==
X-Forwarded-Encrypted: i=1; AJvYcCU4gBUrikbZRS7Guz1sq9vBfjyFpGt0WQSm6Sf0g8Ask/yF29XTZA9WeA/eJZeDivAkhmNOfzLEJbs1j6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+cVZ1MIODj4/WzfPtPIoGvMdsJ14C9yQVujiNaNuvp5blgTl3
	sLO5iSokMyV1nnxl54CrAK4nOH4H7cUtSLFmSbMVr/XbxK7TIQvRSf7oZX+vC76GEo9OJjdxX3Q
	0CmUjd9gKXRvg7begmQBvnDQAo1wwsOLqnv1MACoG
X-Gm-Gg: ASbGncv4V3JD5haMGSD0ivbJGAmGcMXoTgxBbkOMrqHGqAkWQe0eDJf0FM/kK1KH6WG
	VG3JqxYQ/pXVWjD01EUCmJuzz/5MQzGSQg9r3QJBt7DQx+nC07xS5hNcFoGqL6zuWTbbwJmPN/k
	pjluUlSRMaRz1pnkOGSn+qw3oqdSC1ZGP/0+TsDwXaWStJfAX+Kt/tG5z8NXsCm5QCd1JPO/Cyv
	ubR5oe7Ld8harY+MhHVPE9tCwIoT6I9N+4abp7E/gJC5f8y74fa7aU7vqQ1dX0/jYs7EukOsjrX
	p9AEHHbWOviBNQGgdw==
X-Google-Smtp-Source: AGHT+IGkg40mPW3bovCZHX0roaA3kWbGoki1BIr82JU93FEnyQBIurMN/CgDlciqSLrXLxGUzokfypjDG670BnEk3sY=
X-Received: by 2002:a05:622a:1911:b0:4b7:9c77:6ba5 with SMTP id
 d75a77b69052e-4ed338fe804mr6958681cf.15.1761930573914; Fri, 31 Oct 2025
 10:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030171238.1674493-1-rananta@google.com> <5e24cb1e-4ee8-166b-48c7-88fa6857c8dc@huawei.com>
In-Reply-To: <5e24cb1e-4ee8-166b-48c7-88fa6857c8dc@huawei.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Fri, 31 Oct 2025 10:09:22 -0700
X-Gm-Features: AWmQ_bl8RKNXMnZYsYniUFcgOw-utCMK_OFyrH-gMOtH0dhIyQfPT7TfvZpSNAw
Message-ID: <CAJHc60yak=kOQmap7Tmp=84cx7Z=h_15K_ZP9kdvxBc1h15rgg@mail.gmail.com>
Subject: Re: [PATCH] vfio: Fix ksize arg while copying user struct in vfio_df_ioctl_bind_iommufd()
To: liulongfang <liulongfang@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:34=E2=80=AFPM liulongfang <liulongfang@huawei.com=
> wrote:
>
> On 2025/10/31 1:12, Raghavendra Rao Ananta wrote:
> > For the cases where user includes a non-zero value in 'token_uuid_ptr'
> > field of 'struct vfio_device_bind_iommufd', the copy_struct_from_user()
> > in vfio_df_ioctl_bind_iommufd() fails with -E2BIG. For the 'minsz' pass=
ed,
> > copy_struct_from_user() expects the newly introduced field to be zero-e=
d,
> > which would be incorrect in this case.
> >
> > Fix this by passing the actual size of the kernel struct. If working
> > with a newer userspace, copy_struct_from_user() would copy the
> > 'token_uuid_ptr' field, and if working with an old userspace, it would
> > zero out this field, thus still retaining backward compatibility.
> >
> > Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND=
_IOMMUFD")
>
> Hi Ananta,
>
> This patch also has another bug: in the hisi_acc_vfio_pci.c driver, It ha=
ve two "struct vfio_device_ops"
> Only one of them, "hisi_acc_vfio_pci_ops" has match_token_uuid added,
> while the other one, "hisi_acc_vfio_pci_migrn_ops", is missing it.
> This will cause a QEMU crash (call trace) when QEMU tries to start the de=
vice.
>
> Could you please help include this fix in your patchset as well?
>
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1637,6 +1637,7 @@ static const struct vfio_device_ops hisi_acc_vfio_p=
ci_migrn_ops =3D {
>         .mmap =3D hisi_acc_vfio_pci_mmap,
>         .request =3D vfio_pci_core_request,
>         .match =3D vfio_pci_core_match,
> +       .match_token_uuid =3D vfio_pci_core_match_token_uuid,
>         .bind_iommufd =3D vfio_iommufd_physical_bind,
>         .unbind_iommufd =3D vfio_iommufd_physical_unbind,
>         .attach_ioas =3D vfio_iommufd_physical_attach_ioas,
>
Sent as a separate patch in v2:
https://lore.kernel.org/all/20251031170603.2260022-3-rananta@google.com/
(untested).

Thank you.
Raghavendra

