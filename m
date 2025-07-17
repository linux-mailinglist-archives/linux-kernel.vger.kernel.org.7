Return-Path: <linux-kernel+bounces-734520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C3B082AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF901AA5949
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659CD1C8605;
	Thu, 17 Jul 2025 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhytWQQu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B102E36F3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717760; cv=none; b=AcyFVy42Wf+0903s8shA2bLDvq/NBKMKg7K+EfAO5i9fJKJWaMfOBOmPxbn4+BvcEifRnV28fYWZg+A9vEO4RhPdm1MlTEJRKKbBq0TW5ZVuYMndTQWBn6QOrobbkbUeUMMFnypCnN/piF2rO3kC9/DIBqxrEw4G676Nsk09ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717760; c=relaxed/simple;
	bh=0GZHNVlrO+mmKMgTeSzkW0wKBWAd9//7yTO7Ox115SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUuO2vU3w5mQrgkTDYaacfNOUTGzhXy0PvNiDp0bNnkFSImsLkHr0XIDshJCNwZWQ8308DNiEa0XI4KRTDJ9YHLLqKkXEdchVs6zVcDwjmNKDznEWDXJ/M1oyu5OYn3W0OiqC1Z2xNnsbwmhOBDTi5aHzq3+qWkWRSoIEGbzQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhytWQQu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752717757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M14DsGiQtqzXQpY818urP9W5ujH4yY77Exoy3IyUIdA=;
	b=QhytWQQuRL8KkjohOa4Qk1Ld9ZelJ6bhkH6e5ExPALB3zoiDUY0gM5YJDzLs8wUf6y3oWU
	pZN/PVAvzyIVW34LHHQBmXTJ6pHUmpD/0kNAbIK+SMEsHOVC50dNIWGHiZqG5/1FonZsWl
	DLr5UqSGgnwuASNZNMHHDKwY6P5GC04=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-hRQiQ3n0OkqAbsrIu6W0YA-1; Wed, 16 Jul 2025 22:02:35 -0400
X-MC-Unique: hRQiQ3n0OkqAbsrIu6W0YA-1
X-Mimecast-MFC-AGG-ID: hRQiQ3n0OkqAbsrIu6W0YA_1752717754
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-313f702d37fso623728a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752717754; x=1753322554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M14DsGiQtqzXQpY818urP9W5ujH4yY77Exoy3IyUIdA=;
        b=lIUM5pl3sDDI46HQiv7oA4/rOqZvJ4H+eJf5Tq3tPbw2Fz3glBOpTWJZS+SWIe2Dg0
         heBfGdwgCo/WR3CBHRJdAMyqKuOff50hAOP0PtYD7QcSKq87BsoEDiS/Xys/Op+NnY8q
         fCXvfILoL/18raqnvBwIPJRG2BtwvBeiMhnrDoFEBd4EXdcd34BFrnLTK6C8vpdCokIN
         cXE16lnn81+fuDTCRN52tz5fdQi6ETGnM/BtAak+FX3t3vPRi5QAjSaWgb0Tx5fVraVa
         Q7FuWYTGcXyzl3IlUxmHnrUHtiUU7QUrddiUWUMO2mNQXqKyrokiBJ2UBE8nnDRvozSw
         uY9g==
X-Forwarded-Encrypted: i=1; AJvYcCVXKchBdV5I9+rFwR4l+xjjzO4ALPjgPls97CrOs7hw9KX4Mvj+kwATq7fVzB0I7BryQckSNXJcktGEuGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbHoibnWJ6hA3GdUtazVKJrG34xM374FYGljInOzg9Rt2u0rq
	N7w2akLh2Xoz1eCkxzb20t9NvVuqPoa/xJjfkOwJfibmXdqCsP2Mps5f4Tu6JhZn2cqVUVvY8xn
	vnWyduoJBKLNrwDY5x5R/SZKRNraBuOKagXu/CGMQ0YIzgvIUD/HDFZx19JyNQv1PQ9EvDlABwU
	sp8BitvuHSW0EUDCF+b/zrxXaKg1Xb3jk29cYA4+pk
X-Gm-Gg: ASbGncu+iElDwEYF0DO+u8oiO98T5lgc63c1GFOrkurE0D0HszBWUXzlYSwg1bwR1kF
	lt4mU3NLfu8XXYV4DI0dZbg6l9TFkF90t34uduchFAOn1+wfDHlMAU0Pe19+WXg1uXEmmw6AvA5
	xQ6HOwnavS521m9FQZGcem
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id 98e67ed59e1d1-31c9f44bc2dmr7521578a91.10.1752717754214;
        Wed, 16 Jul 2025 19:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5iPUiqqpQyBmPLZCPtjid1ls/tJqR3WHYd9f5uSW/9kS6qJ/9PczlVKVSg/orVJ4W9fRrd/6H4sTsVPc7n5k=
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-31c9f44bc2dmr7521534a91.10.1752717753774; Wed, 16 Jul 2025
 19:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716115717.1472430-1-zuozhijie@bytedance.com>
In-Reply-To: <20250716115717.1472430-1-zuozhijie@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 10:02:22 +0800
X-Gm-Features: Ac12FXxK3fHuuCF0pftokODGN7tkaUVBIGycjF0F-57Uypg4whIM51FXe-X2b_o
Message-ID: <CACGkMEsSD_r0akWpsP+Xa4_CvCAEVbF2cQ9GrE6VYhZ7m2C9hA@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during probe()
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:57=E2=80=AFPM Zigit Zo <zuozhijie@bytedance.com> =
wrote:
>
> The deadlock appears in a stack trace like:
>
>   virtnet_probe()
>     rtnl_lock()
>     virtio_config_changed_work()
>       netdev_notify_peers()
>         rtnl_lock()
>
> It happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while the
> virtio-net driver is still probing.
>
> The config_work in probe() will get scheduled until virtnet_open() enable=
s
> the config change notification via virtio_config_driver_enable().
>
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state =
on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


