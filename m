Return-Path: <linux-kernel+bounces-830046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB4B988F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C6D4A51A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A727E05A;
	Wed, 24 Sep 2025 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYkv1o8C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D527BF99
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699218; cv=none; b=a5UMxkH/sRSa+gkOjzd6OfDgZT3XYEUxwebL3vau8V5bSTH09gx2LWJFljpv3FJ61zUZQB0/mtgMtTqkPEESn4YgIjve0Z6txA/WF1Th2yAspEj44euMxboL6t41Fiiwu0vqwOh8xA6dAU1mM/UElosQUVcaZW9vmo7WUn4/G5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699218; c=relaxed/simple;
	bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJ5o8C2faD2UiljOCQg50WqkHEMe8xsDb9H3Tmcfe7NjCE6hDVo85d1L+lhSMrOr9g5JPCEker3v9CSQd0+zyxP2G7KcJr9Mu3HBY/K7n5SD5yr3pIPZjaQmvgIPFK67hKA3WpkTVh1KXNsI5jaDtkyMdVnH5ImDaHPq6qj/ZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYkv1o8C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758699215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
	b=hYkv1o8CfCzWdgmGBlJRoWUlnHPmmm9kemt2e9wLkVz+0krWZXPYVGz71dyNBYPxsOX2Qv
	VjiXQunPZdvCkjBLyJOxdgaaMIp1JPDm5bdbN4b5O92mZCkL2x4j4twCZR6XY9UdGgK4CL
	ZteF77lUjeMpnG/xYbQJGgWJnra0GqE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-IhNgqgQkOkG1aSezguqEeg-1; Wed, 24 Sep 2025 03:33:21 -0400
X-MC-Unique: IhNgqgQkOkG1aSezguqEeg-1
X-Mimecast-MFC-AGG-ID: IhNgqgQkOkG1aSezguqEeg_1758699201
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329b750757aso5423621a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699201; x=1759304001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
        b=ndLBmz6IaSTnHNhXFuA/IegDDIbK6dTjlrM9CyrFcsBoY6hajeqilWtE9ZFP1GIFsu
         cR/ZC+mYzQiP5I5qJIFhXTIG1PDXxQ8jfdTNt4EL8e/NFkwDpGyn6hO6seFUrG2I7n9n
         og3WktAfHLJ1ba6y5HfJAEl9+978lA4QxnrqwOyOnUbd971i9Eif770dCBHZGKp9CZPh
         u6P8nGCLsVDTlEQMKeTo9NLXP09MNW4V0NDsMNTPemGwf1TYzwnk1RgMWhza5K2X0+MV
         /ItASkxun3JaZnoUxRj4jVZnJuvWPzndqdCQ4NTjIpJBFiLKHanzVoCUpisyYWtAmPRk
         4W+A==
X-Forwarded-Encrypted: i=1; AJvYcCW8YoegUeue56iCU+Bu5+1mfT01g/UchcJ+ayELdpd/eQ/KNdQmM2JhZH8rHrrG5LtOhn2HysqPkGzY+1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZ/kvd0DihDkfNBtr0c7UcIeMc3LuOVX3alykauTUpjap1Q8F
	xqHCiqZ+lSNxU1fP1Ffzyau04IbBuuuDijE/FIpdsb07RChkPSDwBZ+eEAyefQuiaP1MOfvkn/u
	xbrN7VT9f843cySvY/JMXVCkyEA46C+CRXLfvR6iMIuTjE01HE+qxv8n14OrJzYTe1fGb+IWnSj
	RDjK72Rv2cnlR2VyVQ0SC87qXAStYlLxBgDZvMe1zl
X-Gm-Gg: ASbGncuqn/yTSO7Yh3zvt45zT/gp/SEjRbJbwpr8HD4Nse823h+CkCT44UM5AalYEKX
	PIppPc3r3rS8nVySPf1iwDEIv+gZobNPq+k9HEmgsbxi0cteM+ECc5qBPwzw/E/YN1QztTDJL3t
	zx/snZDLTtbdYUE+cISA==
X-Received: by 2002:a17:903:190:b0:265:a159:2bab with SMTP id d9443c01a7336-27cbaf0e24amr61534795ad.0.1758699200726;
        Wed, 24 Sep 2025 00:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+14SJa59MjbvP9DJUdCwTBFSU+ad1kkLu/Xoi0kve8FMkca56Fj+oIDkby//sq4cwlX8+6BEG+AYJCQZEwnA=
X-Received: by 2002:a17:903:190:b0:265:a159:2bab with SMTP id
 d9443c01a7336-27cbaf0e24amr61534425ad.0.1758699200205; Wed, 24 Sep 2025
 00:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de> <20250924031105-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250924031105-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 15:33:08 +0800
X-Gm-Features: AS18NWBSU_1fvQZUvaWmku_qO0_MGvBZjZq20karT9w3KYqASj9gmSz5-R3j6Bg
Message-ID: <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > SKBs whenever their internal ptr_ring buffer is full. Instead, with thi=
s
> > patch series, the associated netdev queue is stopped before this happen=
s.
> > This allows the connected qdisc to function correctly as reported by [1=
]
> > and improves application-layer performance, see our paper [2]. Meanwhil=
e
> > the theoretical performance differs only slightly:
>
>
> About this whole approach.
> What if userspace is not consuming packets?
> Won't the watchdog warnings appear?
> Is it safe to allow userspace to block a tx queue
> indefinitely?

I think it's safe as it's a userspace device, there's no way to
guarantee the userspace can process the packet in time (so no watchdog
for TUN).

Thanks

>
> --
> MST
>


