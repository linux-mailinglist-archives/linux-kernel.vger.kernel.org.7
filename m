Return-Path: <linux-kernel+bounces-849002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33554BCEFF1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DF5F4E3E2B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B51F4C87;
	Sat, 11 Oct 2025 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3hUJYVE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537FF1DB122
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160111; cv=none; b=NHxzj5TdVrNOw5QQ7tFx/SHRXEKG9zzST4IqjRKSJeyHh1wYChD6RJ2A7iKNkTaDzPWkKVKsqYC68mI5CPcWszDNT5aU3Q9dlhlGChN2/Hi6PIzybR+6rRevxWT0zzy7jq2bgAMu/ofCHpE+0xEO4st31FgnjbFbsQ/GAenUrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160111; c=relaxed/simple;
	bh=TJeg9Z4aALDqJap1+G0oltNt+C3Bn87a4wIzshptlQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3C7LMm6rALd918Hncne4Yzm5x6NoJ+gk7A56pEUx0dO6rz0s/pUc3hglP6Px0hM5L0p9xxRS9hIzPk23dhrouz5MOr+ZTh6vEwFrOChF6gFheBtjRC8PudcmDoKgMuOeXoets/iyNduAfkWVS6E6BT0aeaAY6VuGw6kKb5rUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3hUJYVE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yUOPtsTsKEv6cjl5rLeXUFskesAE1DpbF/midGppfE=;
	b=H3hUJYVE/In6wMmn3Typrp64FfH0xUg8cAjv0U1g4X2W9yprtsDCIEn+on25qK46BK/Aw0
	A/ZXXKVxDK1jsNv3aexholcUHL4GTV89t15Lzr6byDyrsUgrvSQnUvoGU5oNk8bEEbh1NN
	QCGVwu/Aw0VhJyGu2EAGx7uVd5eRRDo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-BODNbHaUOQ2W-ethQ1b47w-1; Sat, 11 Oct 2025 01:21:46 -0400
X-MC-Unique: BODNbHaUOQ2W-ethQ1b47w-1
X-Mimecast-MFC-AGG-ID: BODNbHaUOQ2W-ethQ1b47w_1760160106
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b609c0f6522so10266795a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160105; x=1760764905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yUOPtsTsKEv6cjl5rLeXUFskesAE1DpbF/midGppfE=;
        b=OYGBGuNgcif6ujRvwhGQXobIs4uo2tV1G1MYs+zxc1ObDVzSigSEo6iWUVxpDdgE3P
         u3U6eB2tL0BTkuMrYl/arEqm/4rr106PPzhMRFYEdVqrItdAqsdoUWIqYht8cFxsqYE3
         3Ko8oRTL6f2FgqqkLA+ZhkNpgqzBLAPX5ipup6O32u4plShlpelGTWgMmpQhQsBcYiQz
         +KfUCgaeuNmGRhDUj+CXJz5GSpr+Qfo9A4VE5SM23zaSPi/8yLE0AMlB2Qp5jmHT+5cd
         xp5SVb0JIrdFTw2U3eZj7adg2rtMb4JI7wtGQfTNsdh99WpyvbMKiH3aJuQw7SuwAgCI
         bA6g==
X-Forwarded-Encrypted: i=1; AJvYcCVzgigKwVbTsYAe4/vb/RhzyB0kKjy0SedG3ASzpJsiMM6i9aYeVUXKgAusmhlrMXDdOydAmF/Z0lg82ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcyPl26O93raqVHKdKV6XxOBeWvEk5kOqXK6k4I6qLm33EMYT
	+C5i0pH7BhuJMnjXw9XnRpQbRxTylR0kBrE2W7C+FEQSaQlZ43ArWMkEzX4C5d687TUv6vXDIg6
	CbkXDUlGWAktV/9wzqtApLHTJI5avfo44S0XROoUORoEwh4f6arxSR/gIE0hbCiFn8fbuDmc7fW
	KcYFZN36oGTl5pxZPVULIIKbZ6C01KSGIFWrwXiU+Z
X-Gm-Gg: ASbGncvruYqtLmmKXy8rx9V/MfBPRaZi15Jv/JaULv+JjpU1g0z1nBBO/Jhe1MFL4g6
	kKvvT5d43GeUdfbI1MJrpqjEyDZ+ucRuOBrAjNQHJ/qZU6T8UY136g0jJnK4rYwlGI7oGnogFPt
	HwBznr3rQHcFuqfvk8JQ==
X-Received: by 2002:a05:6a20:c87:b0:32d:b97a:fe41 with SMTP id adf61e73a8af0-32db97aff63mr12231307637.32.1760160105689;
        Fri, 10 Oct 2025 22:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESLbYaTQ/nRv54ze+Jvy0H6UYM9Iny3wDuAFsnzcLXByiZsI2i3VTIAPf0kNgN9LhzXrDvYt6DHG3MIt4RYtw=
X-Received: by 2002:a05:6a20:c87:b0:32d:b97a:fe41 with SMTP id
 adf61e73a8af0-32db97aff63mr12231290637.32.1760160105327; Fri, 10 Oct 2025
 22:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-3-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:21:32 +0800
X-Gm-Features: AS18NWDgOW4hAvaDJkPQBqz-cewMh-HRIF3tVFTzvhwvYoFoiUZL-6c_AX1jgSc
Message-ID: <CACGkMEujn923PtF1gUWk6MC0=fA6+yXPTFoyZbqiqRCHJfr4Ag@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] vduse: add v1 API definition
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
> This allows the kernel to detect whether the userspace VDUSE device
> supports the VQ group and ASID features.  VDUSE devices that don't set
> the V1 API will not receive the new messages, and vdpa device will be
> created with only one vq group and asid.
>
> The next patches implement the new feature incrementally, only enabling
> the VDUSE device to set the V1 API version by the end of the series.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


