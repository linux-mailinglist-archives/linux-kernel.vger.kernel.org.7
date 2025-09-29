Return-Path: <linux-kernel+bounces-835790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A371BA8112
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CCA17C358
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E65423BF9F;
	Mon, 29 Sep 2025 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPRmIJZ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03723909F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126064; cv=none; b=Qtwwk+uD7UpXrTs5olT5Q9vJwGCmHavVVwYTNYTPdlZ8GT/qqkwHTqpanPadZb+7wTCZxfEcFBbN02xKie9PkkmwPGRdVs41C3IiKO46aH4MIJYCSdiie2/adh1cIlueONTqIsFgfziSnUDNOVUgJN2+07PNxicnpgXfd/qq47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126064; c=relaxed/simple;
	bh=IbEySVpKbLCFuZ9rrIjdK5cqttbR+AKe+UCoV2F1p5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxfHon2CDDx/sendYe4AYBDia7vkVB1KvveWmYMZfCXM6ogmcUip72PHXNLnx451HzJzU0tT++XvJKm5fsgdNcRCwWw0bX1hCKgrC2rQafsfuSoroH88zYa3G3NiC4XgOYoz96IIpFqtgOqgRebl1XQrX+g5QjOFA9KpMSIFueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPRmIJZ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759126062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBfJ6EZcrzpxQaUNzV7H/FmOU4A4hPZpwBb7rVCM3A0=;
	b=iPRmIJZ/O41BWHt9Bib6WEbZCsG9dw66mAo/o6tJ9/p3NWUauMi1kgExwXGQ9TDcE6KetC
	N7DrWNnva2d4Gj0rqIrrqaXpz5rMovTRlyn0Q8IzkOqWlkl/wsR1EuJfZvK8aqq+g7YCqD
	1DchwJx2//qOoKhddzKFQkDAQvKajZk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-JECvq-pZPBedLEPv7vtrsQ-1; Mon, 29 Sep 2025 02:07:40 -0400
X-MC-Unique: JECvq-pZPBedLEPv7vtrsQ-1
X-Mimecast-MFC-AGG-ID: JECvq-pZPBedLEPv7vtrsQ_1759126060
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7436271d14cso61741587b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759126060; x=1759730860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBfJ6EZcrzpxQaUNzV7H/FmOU4A4hPZpwBb7rVCM3A0=;
        b=AdHpdRMBoBeFXGGNjHPoZ81WuE+am3crUpsUqq/evZ6CovDMzSHyNwC1fhRh3+xfRD
         t51aJfHmh3yV+RPwWPUVVU8ozIjRsey/lasbZw+Ux9eAmLkHGPGvMbDZ7tL+cJ2LZgEp
         A0SIcuN+yz4CuoeUmjfDrZ5db5BICqgeTxRVuiX4lDo0gXEHE3oOKO/zXUOcEWJ9XSQn
         dpmzslCEqSTbYitlUEXyvmBVLLrjwhRT7v6XfN7xuoF1Mkqhd8RmDgsGKWyyQhRFnF4V
         f8APUMxNiN0HfwnWvK7sRNMvL8M3qCQWyrShqgnz4etRzuBwxcH+BOrMWIjH+F/o6PH1
         6Qqw==
X-Forwarded-Encrypted: i=1; AJvYcCW4HZNFkAhyenUXX15UjakOGP+fgJjmQbMGsfJB0s8Q4Feprkms3iwbmdABKrw3sbwBOU10pN/FqQL6Ev0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSZ/rlarh5OaGtKZBVveJWUNofoLe/7cwbAUzVVIVA6Tt8f1Q
	lcYOS0I91Jh33Q3ufDwHX0qzwVUO33MRlrfxBqGg+Vaj+6AgFnn9bN6BcA72BxHhQOe2RB5p66e
	m0EF6DNT8Uh749wWek12yMlAYN2SfYH5J+ZZEmFqhZ4bx4xKVvGzChDJq5g/k3YlJdDFxFDE8qk
	IaRF1VUDzQqbZ0hHPhLgvsm5JPvNt5EDFmOXnDGkmg
X-Gm-Gg: ASbGnct3LeqzEUH6PFP0tvekMv1yv3Go3n+xfeO0OvaGk5gqR0nzoo6Wzw+5alkX51y
	Qa7AwIbh/9v0t3TDSnsN51oy53LE7hU36WmlnMkm3YVBnUlJaH2sF718Tr1OKP9nwomb8ikNptX
	8av57VW3YZIjdKVDDz51Ryhu2bgtvERbwGHfNZqB27a4cdvbdYKR0RDebVDeATXVrguqUqHgOsn
	uz+FQ8P
X-Received: by 2002:a53:d208:0:b0:636:20c2:8eaf with SMTP id 956f58d0204a3-636dddd2be7mr7496553d50.20.1759126059829;
        Sun, 28 Sep 2025 23:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHruQhakXa8wGOKerNcye69UaAM4mVrSZQ9uhbK5P04HWTKnvPzXlUqVP3RMbc5y1i8ThnHdTlq1SvY2ch1664=
X-Received: by 2002:a53:d208:0:b0:636:20c2:8eaf with SMTP id
 956f58d0204a3-636dddd2be7mr7496534d50.20.1759126059494; Sun, 28 Sep 2025
 23:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <52c76446-117d-4953-9b33-32199f782b90@gmail.com>
In-Reply-To: <52c76446-117d-4953-9b33-32199f782b90@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 08:07:03 +0200
X-Gm-Features: AS18NWC7XMXAuGMO8Eptz-Q_otll5LtJWRETocFL-g0lU0gc6j4WgNxpmozonlI
Message-ID: <CAJaqyWc58wnym96C79E-tG6yBvem5skE3M3vdzBxMYX0aNJVLQ@mail.gmail.com>
Subject: Re: vduse: add vq group support
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 4:22=E2=80=AFPM Colin King (gmail)
<colin.i.king@gmail.com> wrote:
>
> Hi,
>
> Static analysis on linux-next has found an issue with the following commi=
t:
>
> commit ffc3634b66967445f3368c3b53a42bccc52b2c7f
> Author: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Date:   Thu Sep 25 11:13:32 2025 +0200
>
>      vduse: add vq group support
>
>
> This issue is as follows in function vhost_vdpa_vring_ioct:
>
>          case VHOST_VDPA_GET_VRING_GROUP: {
>                  u64 group;
>
>                  if (!ops->get_vq_group)
>                          return -EOPNOTSUPP;
>                  s.index =3D idx;
>                  group =3D ops->get_vq_group(vdpa, idx);
>                  if (group >=3D vdpa->ngroups || group > U32_MAX || group=
 < 0)
>                          return -EIO;
>                  else if (copy_to_user(argp, &s, sizeof(s)))
>                          return -EFAULT;
>                  s.num =3D group;
>                  return 0;
>          }
>
>
> The copy_to_user of struct s is copying a partially initialized struct
> s, field s.num contains garbage data from the stack and this is being
> copied back to user space. Field s.num should be assigned some value
> before the copy_to_user call to avoid uninitialized data from the stack
> being leaked to user space.
>

That's right! v5 of the patch fixes the issue.

Thanks!


