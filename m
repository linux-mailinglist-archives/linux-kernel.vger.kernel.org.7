Return-Path: <linux-kernel+bounces-884195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD3C2F933
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8951895349
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B95430596B;
	Tue,  4 Nov 2025 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfnX4izk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6PyCRtt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3B1B87EB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240812; cv=none; b=n5d1Y6ufQqNTKi6c5g1RfhKexM3BDYumKmuH8ng2xpCL8WoLbcJcIr3qHPh8J/LGmAIvcOC+pY4VWnFmjypM0kQWysPOirIkNeAG6atCblA5+aiYBTj7A2SRKBDaj0CTu4omTLjwAlnr5DPt+uVd/20paOpoBjq8o94HXdK5A6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240812; c=relaxed/simple;
	bh=v7mUg8o5d4YbnHuWnnfU7f+zdxtoURTUi+W59zuTfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVX+JMpZgVUqmj+THfbxsR7e3UrxLdTZiJ7wUfduLrveOJnI6CN+gb7ppwOXqxaDbOt2ZYFqTZ/6m2mt9trCEuEC2pohxCa6amhrN940Tu77lO+PjaX965sWwCZ02grwiyMD6G6Nw/y4lNJz+uKUSlwQ82oM4TCR8PjQ8EO0zNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfnX4izk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6PyCRtt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762240810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73YCUBj4jfpBlE2x+0rguaM2jWl3OFSkZTRKpIlgxow=;
	b=DfnX4izk23fzRgiV+dhemWzTSYr5UBTRGGlI6/a2mRTbuLibd32mngw4VLM5aIgbngsteb
	yHBcrbzmql4mHjjrw1bPa6m4faHZfyyOmrB83DyMVrRpTCcA1qiIjBYdOOJNgw0mE7sWJm
	UB72yHnkEUVAtvvD1Vws0jcK4Vz8SN0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-7WfgvLlvNWupNtEygiELDg-1; Tue, 04 Nov 2025 02:20:09 -0500
X-MC-Unique: 7WfgvLlvNWupNtEygiELDg-1
X-Mimecast-MFC-AGG-ID: 7WfgvLlvNWupNtEygiELDg_1762240808
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cd08586cso1137002f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762240808; x=1762845608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73YCUBj4jfpBlE2x+0rguaM2jWl3OFSkZTRKpIlgxow=;
        b=e6PyCRtt5C1VhvTRVBO6Q/prkVQjdng5byQzZCuypWBH9gquG6+bbsOFgYqBLXo9vA
         OiJh70i7tHKng9ZGoYEvbXYbOTYjMTJIL+A7u+tupzn6pk22c6pDAtFRH5pvIUd/QOTK
         4kyMsWX0KsCP0P8ntOKAH/uDXlyU6LofFa2aJ/mew7twHAhg/f++hgdY7aMjsqtvWjN0
         3dcSHJoPfrv47WsrQiSxRz7Gtiw/jAVc1i3Y+MxnI7d++V/xkIUBn2UG0Xm1FzXOfQne
         Q+2+qKEoYeWRFGzwOEEEU99zUA9pzQm/iRplrYqqkpIOBk1pjK1Lv1YjVaGA/rk24AY6
         BnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762240808; x=1762845608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73YCUBj4jfpBlE2x+0rguaM2jWl3OFSkZTRKpIlgxow=;
        b=Red1G2DEZzvMGjcdiR+cRMt+E9iXbCKjvSvmw1/+XdvrjnI37nzV4VdYNzy3UhnbS5
         jpUw2VA8zEpkdPToIFVtA/XY7SVDxM6ps3EkTFo4Ly6sXPsm8MOkxUUgb9EzQ1ptWhIR
         lvQTc6B3hRlSEG+IpOwZcpMzAoykBRvAuxjgqCUOm/KNFSfLmKckba39DWo8Ijix2EGg
         o4oy7BBqNYY60Tt+mG1yCaXwCtLBdO+iOcg4XjXMZJQP03xaqmlPso+Vb6wKENNu0gUJ
         +rWGOIobwgm6zVMZ1c8l23V8uSYMU39A1RC3rNz9677Te2il2PpEZJdEyjGS7rVqTLnN
         Nupg==
X-Forwarded-Encrypted: i=1; AJvYcCXyIovdERJc65N1M8VC0BNFcrtwdQ388MLG+fnbuUIwgBeNgRrEjV032hFwY+HnvVWe117WgFtslNHvJjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaysaITHNqop1u3VWGuJWhlvSxdqxXAI/6xMAaxe8P2w12uQN
	zZXuxe1dbCYV3hqf/+jdbAhHodbhXINWcIQ/bZRaKpUgI0CbwImB4dRoXSQeidigD63KG2FezXR
	GNObI5g+aldnoOkX2Az+SJMQuotTQQ9BT1RjX+9Kx17TqsObS5Txj4snutxhahKY0Bw==
X-Gm-Gg: ASbGncssshsLwikHqdlJo1wVdzc6UOtxQetMxZNE1JWPDsOjc40/wOqD6B3Y4KcdbQH
	cBZOt/L/LiEsYbnPSH9Ew8an1pc1pUS/ObYIP2qEk3ZhGvThEae0a6vIcP2OHisimtYxA1yKVxI
	BEBwgOCTqYH2oUCWDNEhzJjYHRJOj0EwyPulz1cVPdX6uozoEfb8XXiTjiOEV3nOpw/sIZ687/H
	tBosoDcPIA34/k6O/rfWGLNXNYEfm1bBSDjnbZUf0BbmW9Tpyo0/MiVTRFNYVCadLmRGRF8oONe
	akOwqx3F933c1cxZOLpZgym2Md05nxSzW2hJA2bvZKm9QQE+cqaPbJYsOxp5fBE=
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr13671418f8f.10.1762240807872;
        Mon, 03 Nov 2025 23:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9No17j+8sKvTu81QHfZyLpwKipzhcNFRu6WF9IdUgkLA/8mjSFSLTp3MyIpE+dprvQRAAig==
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr13671379f8f.10.1762240807302;
        Mon, 03 Nov 2025 23:20:07 -0800 (PST)
Received: from redhat.com ([31.187.78.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbeadsm2857277f8f.37.2025.11.03.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:20:06 -0800 (PST)
Date: Tue, 4 Nov 2025 02:20:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Fix a typo error in virtio_net
Message-ID: <20251104021953-mutt-send-email-mst@kernel.org>
References: <20251103074305.4727-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103074305.4727-1-chuguangqing@inspur.com>

On Mon, Nov 03, 2025 at 03:43:05PM +0800, Chu Guangqing wrote:
> Fix the spelling error of "separate".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---

Acked-by: Michael S. Tsirkin <mst@redhat.com>

>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..1e6f5e650f11 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3760,7 +3760,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	 * (2) no user configuration.
>  	 *
>  	 * During rss command processing, device updates queue_pairs using rss.max_tx_vq. That is,
> -	 * the device updates queue_pairs together with rss, so we can skip the sperate queue_pairs
> +	 * the device updates queue_pairs together with rss, so we can skip the separate queue_pairs
>  	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>  	 */
>  	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> -- 
> 2.43.7


