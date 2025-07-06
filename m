Return-Path: <linux-kernel+bounces-711364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C7AEF9B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36377188B2E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5DD274670;
	Tue,  1 Jul 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep/rOLKD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8372737FC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375088; cv=none; b=hbIt6EcI86LJpLNQW7tAZlPjoI+CaSeufoSQ9bgttlk4q/cTstmB9qhM910ozXAsdWbWYA20D1Di2VVf4EY6x1/jNyNoKz0vEbodMm9ep27NTR7zq6ZwIxVZpM7M7UgGVhmEYrdzqDVnLpczDAdHKgeEERpWdm8REIzVzRkqJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375088; c=relaxed/simple;
	bh=1u6LtBFBZpYRhcRKXCfqg8lwwnGpi9KXfabJfPSkfec=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HDcdATSJLT0uhtTaOHxAMAZn7E6DOj4C3Y4FQxG2sxKEdhch43Lbg9Pa8rc5HUNMV7uzH3NVOse159vBSHYKtsmwTV1MIodSLUZwd3H0ZF83alBEBiegjhMivNtECIRBedYu9/hZKiU3ZtJhQCexkM8NqBKbtoh6zPffrOO7Ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep/rOLKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751375085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qg+m2/pNVkQnC5aBRNuH+sXdMQvLaC9DgJfu+jNhg0=;
	b=ep/rOLKDcNWGehsgIEYxfmdkGHdRgpPYayV4InvVQMTJEumwv7G7EPRkmPfpHrVdo5iUNk
	PD9l5JNKGEYlmH4NPOcjVf6kw2TclKYffHbCsFlyio7S33ZX+9hS0jv1pV/RS47/hcagxW
	+PCf6AyYo9dDnSh8c2IozperJvjaF8s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-POXgQ4c1P4CO4Div8OCWJg-1; Tue, 01 Jul 2025 09:04:44 -0400
X-MC-Unique: POXgQ4c1P4CO4Div8OCWJg-1
X-Mimecast-MFC-AGG-ID: POXgQ4c1P4CO4Div8OCWJg_1751375083
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4530c186394so14912305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 06:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375083; x=1751979883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qg+m2/pNVkQnC5aBRNuH+sXdMQvLaC9DgJfu+jNhg0=;
        b=jw1AxU18N87yvLJzjwnzNTaR7MrOcxG3pf6DqI1RhKi4kRJRA4m/UMoN3kjqBFARz3
         OtEdCwhHqT92NWUsdcyizWWY32fOQIa0iaI6Xqyu1wCW7Mk0EhbyKthzIbhMtyqQGuIB
         UKH+g1l3Jz3eqB86yD1rROgaBJdyvMp65aHFxWBPXOj6P2CIawJ2lJfjhLZMt3w7viV3
         vCBak1UdTmkBW5CYV9cBt15x9hsM986UlVFVarxB91FAOIeceq6rHNiNY2n9DGRw+Chv
         0kUVVOgreuvkkl1qshWhJouf1gK9wMVnt14E/DtpPZdRahfm3qnnITENq8xrZycKdDBK
         WWnw==
X-Forwarded-Encrypted: i=1; AJvYcCWEXO1HQdqLFcLTCtbsdD0cDt+jG/6TQGPteq1ZgevJBBDPa41VcwivLS2FgoK7k31RWl8mhNpWqcM4LCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsMXsVaQrGkOkeWV2pYCspTb72dxN0d4Efuya5PuwyEZB17pC
	9JK3Tu9/Ny8ozAsWOA9J0uELqQQ1YbjfdKcNj3MQm407jopGInET3hJac+Rk5cW3gNNi9Ig4lTS
	vGEj0W4XFk7+07FNfbT2BmI/oMFU3sbCEgqvqaJ/TjoW/0aTUHPzYVE9kcsNe2pIO+g==
X-Gm-Gg: ASbGncuK6rqk+0A7LojyPlKUn0ytq06TQHwc+DBwzkD9U0CrfiyBxZOqKlZIITsP9qd
	GrbtDFSR4T1K+7fvdi1QyIYh1vr6YoUQRkjImQ0yFfYDfLBTEzzReZ13vXOy43tfYWcPNAtFn8j
	TObHGiTqdcycwTWm1FeI5IACucKraMpZmM/kTOK7jJSEZUYKf1C8ir1WLjMqSdODe1aNmgCFDaK
	7qBWMuzhAoSxHoalds04JorOUxFPAHyXMTcGUJ1+p2l5KO4lG4ziy4uIi0NPM7/9LM55Pqomzcf
	Jt5+sHUmfUHL8UvEwZCZC5FXv+YLgZfFp4HfXQjhbKNK/OC2GhT3Tz+EIrN6M951lWSKig==
X-Received: by 2002:a05:600c:6218:b0:453:6ca:16a6 with SMTP id 5b1f17b1804b1-4538ee3996cmr207008505e9.10.1751375082766;
        Tue, 01 Jul 2025 06:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC9ko9vvQce71TOy0RBCS6sjywmO9bKtkGNw+DoVv+ofxTAO7zJYiibP6bcuGbZwr39XyKgA==
X-Received: by 2002:a05:600c:6218:b0:453:6ca:16a6 with SMTP id 5b1f17b1804b1-4538ee3996cmr207005335e9.10.1751375080189;
        Tue, 01 Jul 2025 06:04:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5b7fsm169229505e9.10.2025.07.01.06.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:04:39 -0700 (PDT)
Message-ID: <346e4b8a-2e62-420b-9816-6a35b8b63da1@redhat.com>
Date: Tue, 1 Jul 2025 15:04:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
To: Dexuan Cui <decui@microsoft.com>, niuxuewei97@gmail.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1751013889-4951-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1751013889-4951-1-git-send-email-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 10:44 AM, Dexuan Cui wrote:
> When hv_sock was originally added, __vsock_stream_recvmsg() and
> vsock_stream_has_data() actually only needed to know whether there
> is any readable data or not, so hvs_stream_has_data() was written to
> return 1 or 0 for simplicity.
> 
> However, now hvs_stream_has_data() should return the readable bytes
> because vsock_data_ready() -> vsock_stream_has_data() needs to know the
> actual bytes rather than a boolean value of 1 or 0.
> 
> The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
> the readable bytes.
> 
> Let hvs_stream_has_data() return the readable bytes of the payload in
> the next host-to-guest VMBus hv_sock packet.
> 
> Note: there may be multpile incoming hv_sock packets pending in the
> VMBus channel's ringbuffer, but so far there is not a VMBus API that
> allows us to know all the readable bytes in total without reading and
> caching the payload of the multiple packets, so let's just return the
> readable bytes of the next single packet. In the future, we'll either
> add a VMBus API that allows us to know the total readable bytes without
> touching the data in the ringbuffer, or the hv_sock driver needs to
> understand the VMBus packet format and parse the packets directly.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Hi maintainers, please don't take the patch for now.
> 
> Hi Xuewei Niu, please help to re-post this patch with the next version
> of your patchset "vsock: Introduce SIOCINQ ioctl support". See
> https://lore.kernel.org/virtualization/BL1PR21MB3115F69C544B0FAA145FA4EABF7BA@BL1PR21MB3115.namprd21.prod.outlook.com/#t
> https://lore.kernel.org/virtualization/20250626050219.1847316-1-niuxuewei.nxw@antgroup.com/
> Feel free to add your Signed-off-by, if you need.
> 
>  net/vmw_vsock/hyperv_transport.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 31342ab502b4..64f1290a9ae7 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
>  static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>  {
>  	struct hvsock *hvs = vsk->trans;
> +	bool need_refill = !hvs->recv_desc;
>  	s64 ret;

Minor nit: when reposting please respect the reverse christmas tree
order above moving 'need_refill' initialization after the following 'if'
statement.

/P


