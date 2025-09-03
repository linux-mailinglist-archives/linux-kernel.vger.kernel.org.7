Return-Path: <linux-kernel+bounces-797671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545EB41354
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC6AD7A988B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36A2D1F61;
	Wed,  3 Sep 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYsn4Gcc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4D1E412A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872057; cv=none; b=PCOKzvyDrfC6a4w6BoOeIaQlfxe7Ds7R64gey0885E1n5pYvDdoFqFsrHhOv2S9SyyijdEtL6b56MwY63mKmU5EiiPDiFPNAQIAkTurRaNu9XHSYXCjBT8RBg0NBqnId90WOpVFAaVeYdt2MrZF1Z3Yysg2FF2HsCw6EuTeabKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872057; c=relaxed/simple;
	bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZyeSn9DApWxFOuwgo28PN1ZQagE7vqU2Sgrmjqyp+gBdINbh6Sn4v4qpIDOOsUVWWfAEOM1W/AUaY5cO/cxwND+4B29TF+1xG8Ve8OvXF+y25/6fSx1lUWwTsKVQewbCo5DxE6AHM8wsvqjoeJK57x279QYPfTizxvxVRgrZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYsn4Gcc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756872055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
	b=eYsn4Gccsj0DMz5OwFHuYs6+PuEp9yJ/ftoGgFOrRzqHKPH9TERXQ6YIaGop3hzWg7HWbg
	l20ArN4Yp5Fz1YLNg+3OaFDgaY9SFP4v8hBm8qS1wrHtDAAjezXxUvxcGJ+TGpZ2YiNg+b
	YBUsqvvOYV453OX2+JirSjKyE26vFsY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-FSFBuBcEPf293kFE1D0pTg-1; Wed, 03 Sep 2025 00:00:53 -0400
X-MC-Unique: FSFBuBcEPf293kFE1D0pTg-1
X-Mimecast-MFC-AGG-ID: FSFBuBcEPf293kFE1D0pTg_1756872052
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24aa3cf81a8so43638725ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 21:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872052; x=1757476852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
        b=MQXr2gmzkxCgO77DJ88ZjbuHCArHo3JKUFMPDEXID1LzzeVrQPu3F8twQmAFfn7kpV
         Qlzu1g6lP5c+zsGzQclcpNm+Q+rEkUrKS21ic7wnRDbPDiRn12FTfS3WsdlsHmt+xTyK
         sRcJYPDprQlRl/EYmC/7CXpmYOIdzxUx0SxRdRUjBI0uRtITRjhrsKR7X2z+VyXsn4kq
         sALQhkeKHRY4caSXFqg/Xn2ZoiqLAyNNT9EhNVO85kA06ayse1uWWUGRi6PN88np7lyI
         pj2VwOulgJVFaPpo6p1euQ7mAbyC6cziv8aVdvR+lA7yRhzBiTfss5mlAmnPh1s3zGDz
         6Zcg==
X-Forwarded-Encrypted: i=1; AJvYcCVSRVGd7srGFp3J5aq4Ra+IQs0ab7MkW7Zmp25QZFGozdzzmgxnGjnbz5Cbd4VItoUVZ8vsp2Gvv8bYJJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIFQx6BVEeAIY7Fi+q0XjH+E3Sp4bmB94wLsYoPXW6pMqy+ic
	wP5Q8aGf7g3oLPnMLlRcXr0w1zIDGaf1seQ3XLg+Av+uYxocpzEwDWVEymmuYqlSaWnxxVcHoZk
	1z/sGkvbFkj9RDeHX+E/rfJcVhYHZgH8b2DRBJh0hQF9cXrhXJDuc08Wqjc7azEcTrCTRS6WgkU
	o7oY0XJVADp7Dannwm5Oyqpg8p7iTiT7vMnUivdWMc
X-Gm-Gg: ASbGnctcc2gozMaEkXD11Qo4ClH/owMv/Wsk31m4XNEHHcAXnfB1OktIl0RB4clOlgm
	aLQI2qi5dohVF99pbdTeYbkiAAo/Pp+c3D8Jd3B6Le4BSeooCiDAs3tRu+ZgtJHHhja443lZNJt
	Y64H1lAY/8ibOh5kv+nKvY0g==
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id d9443c01a7336-24944b15b8cmr169377645ad.50.1756872052059;
        Tue, 02 Sep 2025 21:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5aB6Qqxj9qWYTbp0SCLMQoviI6dY5kYYbJnZhA2Hm84dGyl7OdRCsvBI+vTe21NUsYwxF2ONdt98uJqVn0hA=
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id
 d9443c01a7336-24944b15b8cmr169377215ad.50.1756872051574; Tue, 02 Sep 2025
 21:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 12:00:40 +0800
X-Gm-Features: Ac12FXzvemknOpwKY7V_bPmSMDz5x5JOaUgCJhdjwkkYam90CI_kt2z3omxI2R8
Message-ID: <CACGkMEviyLXU46YE=FmON-VomyWUtmjevE8FOFq=wwvjsmVoQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, mst@redhat.com, eperezma@redhat.com, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:10=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This patch series deals with TUN/TAP and vhost_net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> patch series, the associated netdev queue is stopped before this happens.
> This allows the connected qdisc to function correctly as reported by [1]
> and improves application-layer performance, see benchmarks.
>
> This patch series includes TUN, TAP, and vhost_net because they share
> logic. Adjusting only one of them would break the others. Therefore, the
> patch series is structured as follows:
> 1. New ptr_ring_spare helper to check if the ptr_ring has spare capacity
> 2. Netdev queue flow control for TUN: Logic for stopping the queue upon
> full ptr_ring and waking the queue if ptr_ring has spare capacity
> 3. Additions for TAP: Similar logic for waking the queue
> 4. Additions for vhost_net: Calling TUN/TAP methods for waking the queue
>
> Benchmarks ([2] & [3]):
> - TUN: TCP throughput over real-world 120ms RTT OpenVPN connection
> improved by 36% (117Mbit/s vs 185 Mbit/s)
> - TAP: TCP throughput to local qemu VM stays the same (2.2Gbit/s), an
> improvement by factor 2 at emulated 120ms RTT (98Mbit/s vs 198Mbit/s)
> - TAP+vhost_net: TCP throughput to local qemu VM approx. the same
> (23.4Gbit/s vs 23.9Gbit/s), same performance at emulated 120ms RTT
> (200Mbit/s)
> - TUN/TAP/TAP+vhost_net: Reduction of ptr_ring size to ~10 packets
> possible without losing performance
>
> Possible future work:
> - Introduction of Byte Queue Limits as suggested by Stephen Hemminger
> - Adaption of the netdev queue flow control for ipvtap & macvtap

Could you please run pktgen on TUN as well to see the difference?

Thanks


