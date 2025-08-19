Return-Path: <linux-kernel+bounces-775507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD53B2BFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D520E7B101A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD1E326D6D;
	Tue, 19 Aug 2025 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCnZUzT9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A131CA57
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601976; cv=none; b=DUdWMxaOZbuzQoNHfPhqVjfCq0am5rXHekvHwYwZl206LSLeT6gI0j4QxKjNgdLoXoCqNXMImu15q1fAMoMoJMGTTzuMGX552Vw1k995rFpLOAJse3FtOkM/VrcfvgEiL+dLbGfehNx7iwa2S6QdmX7BU7cinvJItfXlld/+mr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601976; c=relaxed/simple;
	bh=KPRuQ4WAAeo3vRtFpuFdkkdL0MiYgm8EWUFk0JOscqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifnpGkN1WI4SsGaaiKtPSAoOGTXPyyDH5Lr6OzCDDFAoz82/fjo36ZKVtWkr9zcEOXjdxumh4dgcjtnlXT13dxETAShlBZC3WO2TCPNXG6Xmyp0CdeXtgnNo3cHDHUVNCk66+ON+GjEdq3sFz5XyxDVnx6jDLPzue0SNaS0wDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCnZUzT9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755601974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwiysIJN+lj5NXCn81q0LCDHU+2Tt8hxnK1g8vZiVas=;
	b=gCnZUzT9q7gQ9ESnd7pxUYpBmbObqWSmMS3Nuw9kjv0ZZN3YXWPvkwr+ipzewi8QaqzfdY
	vmC7GA+j1OejMHuXu6lVTFbQbXN1mpmkKtO5ab23chWDJL/HTO2Ua66L77CpyWT/bizQCY
	gfTP6Yt9g/+L/6D43tuUNi3qdeQdyds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-3AlcvPOfMPCXA9tIyF8GOg-1; Tue, 19 Aug 2025 07:12:52 -0400
X-MC-Unique: 3AlcvPOfMPCXA9tIyF8GOg-1
X-Mimecast-MFC-AGG-ID: 3AlcvPOfMPCXA9tIyF8GOg_1755601971
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b00149cso17580015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601971; x=1756206771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwiysIJN+lj5NXCn81q0LCDHU+2Tt8hxnK1g8vZiVas=;
        b=FndnwAj0IqyT/Beiu63PJjbindnqqZdqAgDqvRSN0d7CLDmUXe5nVBeA9VfZfgCtUE
         ikAzKOd0sHvxwbpjusVPrfBnxSz9BVq+NvmvLCnKzEZCJDdOqHU0JoHkEZONBeUf+vha
         S6e47U8KZIeBmtUvNK1ovmJAcqsJy97l8alY3C0Ra0tHjNZ+q9KQPyeyC4wNCMJulWHK
         2rwiaY5A9URd43UvEwSo9hYBofR/1slJVwHyUSZFFXoHuYSnDM+3fgU8AJAVrDUd71mZ
         gUXgauYiP8IOKkfZYPT7gVKOC2yKnY0f4nVB9PvHol57ybx4Ko8VEsh5trXnYBBc66Ag
         U68g==
X-Gm-Message-State: AOJu0YxYZXohHIOpE/NH4FxMh0Hnxjn5ZK8PQaCg1kD9YK+oaGplKjBP
	noeTQVuB52p1kfBhTz0OhxP5jJZl4wJ8HlEUPjeFIpXjn/82wXACRHl88mFCxHO6BEKnM1yqDrc
	FELbjAmuyZcC375B0anzvvpU3uOKQiH97/mp3qWFGmHmYyxOeJC5kmDAvKenBdOP4JQ==
X-Gm-Gg: ASbGncsvYbvxZyuBU11/520vdNnX14VMT1HjaIgrn5AbSUltkPh6BoG6ktiPIFILTVP
	wqx+uXHXqmR3+BF8u1jCHMz6kwFIRBG49+nVb5QyBuAZMYH/8zGp8Qyp22hN6btA0Ep8ZfFamDl
	WhEKtZEkM0RVh1IBI3aKdgDpDG10ExiVNxgXygKOBS3aMwMRkkPBem2pAyIKFGKsMnxKSlBKSvB
	yfK7CentD2hLOtCOoR4uqpPxp+QJz18QNRHX449gRQJtdXZkLS3EAuGO6wFhx/CJT8yon3VEpKt
	MOcmYPGvzVdGw5p4ugxnycirF+s4PR2E
X-Received: by 2002:a05:600c:4f0a:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b4602acfcmr8598715e9.3.1755601971344;
        Tue, 19 Aug 2025 04:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsW3Tv+6q61sN/85hX28Egss5FzOAF8rmCmjNaTCZprfcs4Nki01Y6mv2kY7kjtPxcgy+NXw==
X-Received: by 2002:a05:600c:4f0a:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b4602acfcmr8598475e9.3.1755601970920;
        Tue, 19 Aug 2025 04:12:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1677sm3355109f8f.39.2025.08.19.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:12:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 07:12:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Hillf Danton <hdanton@sina.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 0/2] Fix vsock error-handling regression introduced in
 v6.17-rc1
Message-ID: <20250819071234-mutt-send-email-mst@kernel.org>
References: <20250818180355.29275-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818180355.29275-1-will@kernel.org>

On Mon, Aug 18, 2025 at 07:03:53PM +0100, Will Deacon wrote:
> Hi all,
> 
> Here are a couple of patches fixing the vsock error-handling regression
> found by syzbot [1] that I introduced during the recent merge window.
> 
> Cheers,
> 
> Will
> 
> [1] https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com/

Acked-by: Michael S. Tsirkin <mst@redhat.com>





> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> 
> --->8
> 
> Will Deacon (2):
>   net: Introduce skb_copy_datagram_from_iter_full()
>   vsock/virtio: Fix message iterator handling on transmit path
> 
>  include/linux/skbuff.h                  |  2 ++
>  net/core/datagram.c                     | 14 ++++++++++++++
>  net/vmw_vsock/virtio_transport_common.c |  8 +++++---
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog


