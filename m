Return-Path: <linux-kernel+bounces-770220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A41B2789B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212EDA01F44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844429B8C7;
	Fri, 15 Aug 2025 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgVYaE/W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD2253F00
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236320; cv=none; b=ZRIxbNg8YVDUjgilxJHHxuA9XFmqZgRBQ85Pcl+sobaEqORTluL/eKx2YBHUon76gdtztjZa1ZdkZYxPujtB+jJD4oJ0+rbBzguwHe49L5szrFonX7npDFHMuYrGdE/V2CwBg8ygin0Npa7DXxXutqCtoim6mcM+cEV+m37/9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236320; c=relaxed/simple;
	bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ih/Z+tIxxBGL//Wj8TA8U9N06aWktKkEH9jQMpjeiCiNM2jQozJ13m2Jy10u9Ygh58zx/bPrkJuBZ9MZH/89L6bMHADI7p++UT1p5vJfmPb7hxddtC7mP1KcTQUHJ/WSTHa8xZ14Zvp2HQvt5EtSqROfd/rwA9VuLVqt+qHMWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgVYaE/W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755236316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
	b=XgVYaE/Wu4SrOZLjy55Y8/kA3eJslhXSD4DpONp1z4ji4NwGwnExG81DOEAWho7K36IysO
	A+CVjvD9jOb8y95dNvUc0UHBWI/E4HVzW3XKmW7pRvrwnO8nDpMlB2DaM34WjaDTvafztr
	CPNWnn5qWM9rq2Z4tstOsFpKKLjhnQs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-VhVgNHpTPNy-s7BAOW2wSw-1; Fri, 15 Aug 2025 01:38:35 -0400
X-MC-Unique: VhVgNHpTPNy-s7BAOW2wSw-1
X-Mimecast-MFC-AGG-ID: VhVgNHpTPNy-s7BAOW2wSw_1755236314
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457f44a29so18484025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755236314; x=1755841114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
        b=fk38ORixKCUdsR4p3xXLHH2G/YQSjRQSHLCvA/LLK9CGVhHjX3MA/VBwRAecLJ8tYV
         32k0d+H7RgxyLAnvgJ3XK8CNzsjpEsraqSm+xFXHTWMieaEWjkw035Au+7a7B6hTb0WL
         W8naNM6JL7+oQYHU/tGMF/5ZkHVGQPsZmN/cZq2IYIJ192TmoYU7jWN9urzgISHHQ8Gu
         /1+Oh506PMahR+5u7HbyhyH2a9g8yt02AGWLTWgnGK0f2bLfFOWMicPiLnydVweFJZZ+
         a2oNXV7a5DXVHqFuCrjwvLs7LxOWLpoEtnEH2niN8E+pxXW5xLJzlzOTBO/O42f747+g
         pqaA==
X-Forwarded-Encrypted: i=1; AJvYcCXh9xOgxLO6Z8PX3Slkr7FnnH76MYcTYL+OXfFEhBrofdJ+1N2PGc7MY9KxJ6UuUZNzCJCBz5hTcBoD+CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeEm+D+zniyU8WdM80TOqYum9NdITkGb8xCvb89KUdWCwFVWK
	Q5DJra2XLGyjJSmdYhDl2grPQ5vIHx6u38xCSGcXn94qU0NwFuy2k3qZ+WreCpwTarw+od5k0oK
	g7vejSXtKA2yImdiQ3d5FrpqTBnyGnwU/XrOz+xr1iIAbUcvgkoqzV+5J6/qrBbLGE0SHZ22h20
	PceViS3JxCaSMf+719tBaocrF5eR8cVw+cMiFdKVkX
X-Gm-Gg: ASbGncs6xjlPpiiqZPcr4zC1kSVrn+luuYFQqQWhbJoc4NYhSWNdOLiiKVryvLZS2Nx
	rxTePpe/Ih9CdIrElMOIy4c+BGqymmWClwvALqqZmHGugSNQSXoiKxrN5OH1xkM8Zt0djjIUK3l
	lH5+1BVgC3zwsZW007YeJ45A==
X-Received: by 2002:a17:902:ce84:b0:240:5549:708e with SMTP id d9443c01a7336-2446d8ef2dcmr14828015ad.46.1755236313897;
        Thu, 14 Aug 2025 22:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNF8ixWW+K/UQ+wsBh6Kk+3CTYVr9Miz4ZwB26y/XjbpOCpnb8qBRzSIZa7K8FyWNx9BMFUAKlBAn4MxP1R4w=
X-Received: by 2002:a17:902:ce84:b0:240:5549:708e with SMTP id
 d9443c01a7336-2446d8ef2dcmr14827585ad.46.1755236313492; Thu, 14 Aug 2025
 22:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e@epcas5p3.samsung.com>
 <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com> <20250815022308.2783786-1-junnan01.wu@samsung.com>
In-Reply-To: <20250815022308.2783786-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Aug 2025 13:38:21 +0800
X-Gm-Features: Ac12FXx0bLK4_QgLg7PMFy71tElM2n26_1WoRrHpv6PfQj0ttolriEFKlqdwaoQ
Message-ID: <CACGkMEtakEiHbrcAqF+TMU0jWgYOxTcDYpuELG+1p9d85MSN0w@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, kuba@kernel.org, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:24=E2=80=AFAM Junnan Wu <junnan01.wu@samsung.com=
> wrote:
>
> Sorry, I basically mean that the tx napi which caused by userspace will n=
ot be scheduled during suspend,
> others can not be guaranteed, such as unfinished packets already in tx vq=
 etc.
>
> But after this patch, once `virtnet_close` completes,
> both tx and rq napi will be disabled which guarantee their napi will not =
be scheduled in future.
> And the tx state will be set to "__QUEUE_STATE_DRV_XOFF" correctly in `ne=
tif_device_detach`.

Ok, so the commit mentioned by fix tag is incorrect.

Thanks

>
> Thanks.
>


