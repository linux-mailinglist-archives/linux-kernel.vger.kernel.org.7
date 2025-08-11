Return-Path: <linux-kernel+bounces-761752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84928B1FE0B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379073B7939
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D78624678D;
	Mon, 11 Aug 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya2But8F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F045BE3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754881898; cv=none; b=mZLTQruFe45JCznzSTnpONyZpabyyy6ENJKmF61RhW7l1Q1Y2Ion0GvDf8hA8+rqbeXu+xyhm0AczaFn2PNHpAK8FPmtfIua3WYug28zVS3Y4ngHraauIJIo+x8u7rGy+fkJdphkddoVpXWNvIXaJRKNlDBKbqBMoFy2MjmVksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754881898; c=relaxed/simple;
	bh=maBI7Z0cjVr3fr8aTy9OrixNNANW0wIyfdiqxV1IUMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coPkqEkRTCk0VdcT3Yi4WZOMRq2uwB/r99qododUL4av02DL3fAaCpkcSRauso7RpaEvwKhgiksxTyfuTf+jl0u5wEKXTH//O2doR5WfS52NkkVzP/5Lv21c50uz/c5Gd8rhwPrKcTWfm2tw3hGTv5Z/PEfUvbpHyYsYjakFfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya2But8F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754881896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pEQbTxYjhGDFsHuiWNheJaVv2nv1u7UUbIdxZWb26g=;
	b=Ya2But8FQkX3gUFAUQzW5GG3z/9s6jjvDSOtUIawWYWU9HhemQIHjO1h/UXdqXEn+sWdUv
	89VzQ+FfHtUiblghR9eDWTgA4SzAgfk3XNeB6TkbnEJS6bDRuhB5En/a7z++wOMLPBqxqv
	zdzvFQnnXHvp4AUTbzF0n+iJTgtcMeY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-KXjsN7aOMTGR0zbNqfv8mQ-1; Sun, 10 Aug 2025 23:11:34 -0400
X-MC-Unique: KXjsN7aOMTGR0zbNqfv8mQ-1
X-Mimecast-MFC-AGG-ID: KXjsN7aOMTGR0zbNqfv8mQ_1754881894
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3928ad6176so3331020a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 20:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754881893; x=1755486693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pEQbTxYjhGDFsHuiWNheJaVv2nv1u7UUbIdxZWb26g=;
        b=Zid8aPA/JRsGbfBED7sNItaMhz4iIlRqnJ7Jqb+Y7GIQ26WktXrKo4R1vQj/w6g1yh
         HfjSL7lygCDAvCmv0VvSRuHy5GQlr7ZtIfDUHMxsP7wBBT3qlmU04Z8ylOum0lJVn1dd
         neRAIHCoR3t9B9fJFA7JOr7JuhgMFlQaRlvolr15L4uaY2fK6Lc0zoU5coQSdY0LUDsr
         ukb41ndZY2jR48j03YBTjBj7aHNVgLBXF/qzLcZSlnL7lqYD9LFnPhc6qUkcHJ+IzisP
         I9wgalGpqkskPa/lukkGpvIObSFY+XuyYXwfVyicTgEU7WISsg/CgQJAXaltCPFs8IqZ
         WtxA==
X-Forwarded-Encrypted: i=1; AJvYcCVfRVZnkHG6OJqoLlz5+5Kpi2fYmKCC4ngggWmxyvRQeFsHO69aLuUzeEPm+nN+FerlMegi/shpOhfw+2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfP60nDdNm2GbtyO7uXOJYbiRN4A6mIRhwnsUbYRVtU75EFgz
	4WRQ3mj0XYN9kIJ/Dk3cyCYk25C/IXp2vOSVjqYseJXPY044+mTi3ZJIrgqo3UsRMwRPHmOBdsz
	aL8M3q+2dx0luFM+j8Y7WSSrVKIv8SgEaA5nnFpry/RwMRTAr9Fmx+BFvFlR9T3blxV6FHA4Dbm
	HeEiCmBYR9pnkazj2JxfRBguviLuh6fgbb48mrVY+7
X-Gm-Gg: ASbGncsHyKxTSAc+St90MI1G7HSraktIwnzMcrj3Rs1GNhSqYlCPLfmjC4wUTRfwuiL
	tHqDO7eN7knO6Ocnh5CKMO9llTUGfS65oMp/Wl4U8T5U3FwbGaqFD0RHTFcgpqC1ycjrwdiSY+v
	mQGpx03qRcvVpSlMiizmU=
X-Received: by 2002:a17:902:e88c:b0:234:ba37:87ae with SMTP id d9443c01a7336-242c1fdb1a4mr166559235ad.4.1754881893623;
        Sun, 10 Aug 2025 20:11:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtsx3KVyEM5/UWa7sqePKmGH3R/EGRQ55o/tUcNQZ17kWqSxEip+vydOQXtPV+WGUnScm9VUwpJK8slj4FmTA=
X-Received: by 2002:a17:902:e88c:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-242c1fdb1a4mr166559055ad.4.1754881893271; Sun, 10 Aug 2025
 20:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-5-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Aug 2025 11:11:22 +0800
X-Gm-Features: Ac12FXwId_v-tQZlxWMiTuxB91Fl1Rss-uSa9iR_qSTFJ8fcB0sIt4v1QCSUZe0
Message-ID: <CACGkMEurTUOb6t9g+nVdzwU8LrZ=eAAxzHYVCTH1XkQkRtAUXQ@mail.gmail.com>
Subject: Re: [RFC v2 4/7] vduse: return internal vq group struct as map token
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Return the internal struct that represents the vq group as virtqueue map
> token, instead of the device.

Note that Michael prefers to use the iova domain. This indeed seems to
be better.

> This allows the DMA functions to access

s/DMA/map/

> the information per group.
>
> At this moment all the virtqueues share the same vq group, that only
> can point to ASID 0.  This change prepares the infrastructure for actual
> per-group address space handling
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks


