Return-Path: <linux-kernel+bounces-849004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C23BCEFFD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16857407325
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8481FF7BC;
	Sat, 11 Oct 2025 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdBKxHlm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E51DB122
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160157; cv=none; b=NUk3wnOIk3oJPQNqmtL/nqx7wt8Be12n8zaTaX8KD0Y1C0/HTutcTdOnhYnehLc8fBJle+SJAr6dk399Cu9w5lr+ulrMvX4EnpsfmHgj9RcEVkLR3JGhfnsAuqEQoRDj5Bh95pt2DcdAzb3Ej5Md9seGsdZxwAztzCJ6YjNZC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160157; c=relaxed/simple;
	bh=e04oQWhlj41jJDtpl4el4ThZmCFiSoM1TXi2OUeKSO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVtKxfYJ4+r3PeakbD06jUn6EJUfDg5s6urw3C+ocByv5TSwbclhgrti4rroqC0B+JyXLc40sKyOHVL8oHB9h/mlKzW9CTv6seqwqI8UXp0tWejDamGn99KdxrhqN5BIIV+yVnXEvgsEQpi9LNtoRnm2OrZM5WK3lQe/w50/cFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdBKxHlm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOrWPiTFGdMEMeP8X2LbrcJmInJ4Xbwuhaj7Gm0dZUA=;
	b=BdBKxHlm673Cy7RxbMwV1L0lBSVvEVO04CntJU9DB8CSyHyAQWTx5L7Ft7UUaCjddq0IbS
	ghPwRyNKwXBoTxrp5FpwsjkN2bo3A4pmSE4/oQw022xjTAE+LR1CIo/q55JYwzWOSI3a44
	Y0Z+DazNDe9sUyEyH2n4cdNnQyRkoDM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-wg6TjMAtP7e8v3hs2MYjmw-1; Sat, 11 Oct 2025 01:22:33 -0400
X-MC-Unique: wg6TjMAtP7e8v3hs2MYjmw-1
X-Mimecast-MFC-AGG-ID: wg6TjMAtP7e8v3hs2MYjmw_1760160152
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28d1747f23bso67637745ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160152; x=1760764952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOrWPiTFGdMEMeP8X2LbrcJmInJ4Xbwuhaj7Gm0dZUA=;
        b=Iwzx/25rcMWuSR8d73dDtN3qtNQyfdSwXscP1sall3SfQutClcDblP8rcBoemEDUoQ
         PQj0gy+7VjqbZb6YohjKrZevrjCspOabIHLwHICQA5u4lu926Gb1eMeUsIMwPeVZRFac
         TOY8CQ1tgkv1wLgZ1ZQkqI13p38fK4Xv3XZE50AzFYYK8bM8A5KO5VeJrk7w+yI91vJj
         wlpzgIodK2Otgv9/QQ55/wKL/yaBk2QquqofJwJJNo7GJvpoTB8cQ1fKQ22MdpX4rEFN
         ONyQj930988rC+E+LArOyTI+Wy+JJv/pcarVAxDTudofQxtpw/ZjCjqVu68YFu5EVSuL
         FI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5weUfAutQr/SB3EaJkTLhh0KAk9eLLWduSXeqeP+hEgAVsnw3q15VZ8tbAMAqRtxMzPKcpuEqMxed7EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jPanBfVMafUHwkg4gECBS/ZYNEssQkGURiAXrDREaEdDH35Y
	DNeoTQAaD5UuslBUJq846pbweUmYkg9KYNEH+ELZ7/ckCdRbTTEMRTWlr1g0hrdoxAuqm4VNuFN
	+EMZOKdZUVSg2HUl3/buXIOPB62x0tjKKzNRUMfBC+a1WDiC7pD1FVNILykx4DNVJvXk+p3RHGA
	IQabB3ccZt6b/XQbSpj3Z2FF2Sw6lt3eZZNwn/Y/rv
X-Gm-Gg: ASbGncswynLT6g8nR1aFu6PuA3+YhD9pZ2020v2KhkYFUwkSpsx/IGLkBJBFMtlXKtI
	N0WzFwqaXm5b9yvDBWbaqIBiQnvYmlpRwRttRzuvGxHj9ukJXURmw6IFwDR62zV0h0QvbC10dUl
	EVUgVP1VvCpliatDdLCw==
X-Received: by 2002:a17:903:2c04:b0:28d:195a:7d79 with SMTP id d9443c01a7336-290273569aamr186999535ad.5.1760160152243;
        Fri, 10 Oct 2025 22:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaIXAN+QxEwIj9euOLEBZqP+lrqQuyOE0OJMjvLYvUoxffY4RyNLYpCkZmbxudKcW+eMip7jkXCCWEkrirdSs=
X-Received: by 2002:a17:903:2c04:b0:28d:195a:7d79 with SMTP id
 d9443c01a7336-290273569aamr186999415ad.5.1760160151872; Fri, 10 Oct 2025
 22:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-5-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:22:19 +0800
X-Gm-Features: AS18NWCyuXcACrW_v1qn4GL9s4-F86uKmBzdbuqiFdJOXV966wmVyHItVpmf798
Message-ID: <CACGkMEsUpg-hcgYGimL7Zs=yr6M7LEKrWRrruBcDU+0116hoaw@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] vduse: return internal vq group struct as map token
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Return the internal struct that represents the vq group as virtqueue map
> token, instead of the device.  This allows the map functions to access
> the information per group.
>
> At this moment all the virtqueues share the same vq group, that only
> can point to ASID 0.  This change prepares the infrastructure for actual
> per-group address space handling
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


