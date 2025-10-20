Return-Path: <linux-kernel+bounces-860655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1200ABF09FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DF318948E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCFA2F6560;
	Mon, 20 Oct 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn/Bg8X6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB11242D89
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956886; cv=none; b=HdTC3vw0OCPk1up/7+nRwsIzg471NoKfK7sViZaBS4T4GCQZenuWvbL6alwubDTw86PeqjLXnxtTm5RNnCYNjmAGSnGXWFg6jcv0mEptqCPsfHs0fVDTUUK7OhW58r2zUdcf/bbusmcffGMdI2S5ajm1fke+VJtkZiU+QEbmw60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956886; c=relaxed/simple;
	bh=CcQkYsoG2la8PjGJg4TbayykuTETfZyzuwQgmX5Fxm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNB3hMxMZZo+MYs+3lv/VwJAvZ1tQQ1OhXRIyPQk1glDlu409GaA/BmuePNRIQbIyg7otNKSJin9rHawVMCSzhvFOEGiOdifRjkccnnyyQHLefH233c4Q5ZOPwV+K4k7t8JX08EwXHZ6gfpHDjp8IpzaHYhicidW3tL4lJW+tg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yn/Bg8X6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760956883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD4hMybcacQqgtz97VVu7SE15VjVlFQ+1w1a1zq8NKk=;
	b=Yn/Bg8X6Bc9hds3LVSmO7S8PA2eOHKZHEfGWIWssAOcg1J+NyRJ1FkBbq1s+oNeIIDX2+q
	AKl+hFPC/zji32Nr3DNxIXKcMY3qBoRPCP0hJoVYzsAb3NWJQnzQYJO4IBswPfuJIY4dxq
	6WfvDmI2qSldJkHX14MnIeLEcpFPLfA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-xaymsV1PMdqIm7de14c2HA-1; Mon, 20 Oct 2025 06:41:22 -0400
X-MC-Unique: xaymsV1PMdqIm7de14c2HA-1
X-Mimecast-MFC-AGG-ID: xaymsV1PMdqIm7de14c2HA_1760956881
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so1979967f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760956881; x=1761561681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD4hMybcacQqgtz97VVu7SE15VjVlFQ+1w1a1zq8NKk=;
        b=uie0JSmygrkcFfGAORBRuMt2ZCnOiJFSywc4Pz2wRdLj8G6MCWdLrErRhazTjO1POZ
         hn2k9g5o7XvI8VuytiIiKWma4O7M15v/7Q9LV4De8JlmfQtLNPv8gYoQSj9fdcN8K9pC
         lM0NIfm6EGYMkAqXWNDENfrXfT5vtqH4sZAhOqJRx/sOj8zybZLFsENP7bfShb22zPk0
         pU1GeWSkYli5qKoWjKHNiZ1ADOUybFgDPNtW9LWgFa1vxvvAGkEnyCS0Mw8dL5z8cdKS
         HveD9a0JElz0sj4W6cMX+SNGr8+MzsMmO6jSH6KQWmvwm1naqpOiMd1N/E13cLVPioYW
         fG9w==
X-Forwarded-Encrypted: i=1; AJvYcCViTRYFt3i/fxGWxIozPCvUwHglpgl+y8OPFg0zvGJZjtaskuzJtVLRsuAeu38MjS3ykHxkMS6HqGK6tEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0X6jflVEQbvkqvTYPTz69QtxQmqemZMbIoys9Wek9z3w65cUW
	pjoJW2awdq2Xb5Fbih4CVvuPmJ3SrY1ltG3sM0sQ6GUCyMXI8xb5SYX1UCKW+PdhyReqE0GVQZd
	MqOSLL13TCR2y7eR40rkt8wTshLdk6JOObPSb0n5RLbWz8YMTB/TZEF2Doo6eBsxBd4Fq3rgcCA
	==
X-Gm-Gg: ASbGncuO7QSJS5GaM5kopEEsW3470mEbgiyMWOSrzxYPKI/8tBWmxZs1TqvlnbGoU80
	BNFF8aB2uQUmS63o+sY03UHBUPBsx4sVGzaBW2lfrHUUkNE2SeSCYScsJDkZyq7BQWllkEe576Z
	32+LQ5RZurC2YqtP02AuSlGrZK5PJ7JpEAB2TkYYKm7SIUUC0os8ummfRPS6JBswY708bGKCkBN
	525dFa91XsD8ptsLaDUEKdc2xHaWVzQl7Fgm//zmbGVfFfN/Ib6SKyrZg4EPh98qtZZ/y74YBV5
	N0WVeg2cqj0NreAipKPEXnv6vRRv2HDr1KzFoCETjI3fS1X6svlK9dgggO3CAfOruPJa
X-Received: by 2002:a05:6000:22c6:b0:403:8cc:db66 with SMTP id ffacd0b85a97d-42704db5bb3mr7676841f8f.32.1760956880950;
        Mon, 20 Oct 2025 03:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESGkrK8BdZiWqHNVZP5dwff667CqbFjjVNbL+HTFadnfLILbeuzj4kC09sLI16/SoNU9SPqA==
X-Received: by 2002:a05:6000:22c6:b0:403:8cc:db66 with SMTP id ffacd0b85a97d-42704db5bb3mr7676817f8f.32.1760956880483;
        Mon, 20 Oct 2025 03:41:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm14621716f8f.36.2025.10.20.03.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:41:19 -0700 (PDT)
Date: Mon, 20 Oct 2025 06:41:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20251020063831-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-14-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020071003.28834-14-jasowang@redhat.com>

On Mon, Oct 20, 2025 at 03:09:57PM +0800, Jason Wang wrote:
> @@ -2782,7 +2874,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	if (!num)
>  		return -EINVAL;
>  
> -	if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num) == num)
> +	if ((virtqueue_is_packed(vq) ? vq->packed.vring.num :
> +			               vq->split.vring.num) == num)
>  		return 0;
>  
>  	err = virtqueue_disable_and_recycle(_vq, recycle);


This is exactly virtqueue_get_vring_size:




> @@ -2985,7 +3072,8 @@ unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>  
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
> +	return virtqueue_is_packed(vq) ? vq->packed.vring.num :
> +				      vq->split.vring.num;
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>

-- 
MST  


