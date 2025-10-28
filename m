Return-Path: <linux-kernel+bounces-873961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E161EC152C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BA4D354738
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7722ACE3;
	Tue, 28 Oct 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGyFEA+2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692D21770A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661896; cv=none; b=Gs5B7zI3a5hFl+Q+it8wA8YrxBw3fgsatuW4KNW+FiORiyFl582Qj8y5Q75A3gIfu5K2U1QI0JfbGlUzvRMw7ZNMiOUIf/FR2f5qVRJAkrMZLW0LIiYWCqF2a7kU2JIi72iRtq0a+wiJRwuUUiA/xLciSSm/MKuIFoL1VI/wXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661896; c=relaxed/simple;
	bh=lSvM53GFft+J8S+6HgqdJu8eZNoSNRi/6wce+FaPoNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHp1kkrld1uQpngJAkOosoHv2qCkoOZQ2ydwsPcf7M7zHYTuUPsRng+1GlctDo/DQCZNaKj5NBT1foWNwy9iuwnCxeTJX+/8gMviJWFvP91m7a/397bC7iNrKhVeUIJcyqS9pvrAvP8kSk0gKCtkf7Tjk3FKBmh4ji7doxY6JKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGyFEA+2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761661893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73/xPfC9sPKYuWBDNGOrntIS8v774C/e1wt54BijNYE=;
	b=hGyFEA+2qNou4Kab0bzN/De7BVeD2N4vPfemk2obMoAu5zyolB/b6i6x+6650VKtlxkwPd
	gL6gd7w0GEz5P4SAes75p83y8Wnk4rUsCaKGuGhldCzseLsd0f49LybvUZE4GTnfZFOezK
	N3QOnncFGfdzJzFsmGPtYEHbsJ7AGDI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-9gJp-84EOWyQRbRySqksLA-1; Tue, 28 Oct 2025 10:31:32 -0400
X-MC-Unique: 9gJp-84EOWyQRbRySqksLA-1
X-Mimecast-MFC-AGG-ID: 9gJp-84EOWyQRbRySqksLA_1761661891
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427027a2095so3942184f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661891; x=1762266691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73/xPfC9sPKYuWBDNGOrntIS8v774C/e1wt54BijNYE=;
        b=JjK425SbRCutfwozLi8EkojnBK9PLaCP/nKRIUqLUPebVeT3ZRgAXd28WrvG0tO/53
         FUiM+d75ljwkXafDQP1KsKC8bKBseM39+hIxx7Xe5AumThoC6yjuS/5zDkI3Phbsb3jw
         C7dIreNP2XX5mHqFKN9nfOQKMoDyOqMJbt7bumlU3Q0pVRo/8lN86fwknrfNrm4D9wL9
         x3fax+K3DqmBJ5Cc60dhe3dMvyT+WK3k8hd4p+E+BgqAI59gQKS5SrlPW41dhxZwduol
         AWjmCXgdWGmYrVGXjd1i0n9K8BqUaCVGklyWy4/j9kPuZf4xMe6Dd+ci33zk2N3/hj5Z
         uozQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRMfzpEo2xXDkZoyEaUAlHDQHEoh7JhO6SSf7HF6sBEHzsFWdbUsQx8qgOmcPaa5NDodFFQRnjtUMFDLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyorQs27CgDuzBH6hPvDrwdRppWhgTErWYLgCKYt42XyAc/8TJR
	GLznOO1dVjNhc7tcyfSJIfxihq3QFJm4gX0rmIRWoDylHAPRqqEpHGcMpVkvXu545D8KMu+ppct
	tfewkzKoCB3Ea6kza80+yyD8nWaN9GpiUPM9P1HaWV+ag96F3W63Wi07KoSnkbrBZYA==
X-Gm-Gg: ASbGncvH8hGdAmj/fTAIbZFEU77fX74laqZEsprFekBw6BbA09mNMRHQ/rgtrUNpeJc
	0kR/1nbhD/DoKEWW4O2gbliYOFfpvmJnf0AdQhCvl0nxyp3Hu8Vt8fkV75VO6Cd+1wBji1KXCx4
	PvpzQwnT7o0jwkC69SaJDFOqX0d0idNBGqn+kvH81KA/0jMZyUm7HbMu1LLWxOE9YkWhnePD6Rf
	Ye+oTrYxN9SHxOKalrn1sei1B6dFXpZPLyePi9dgPpOrhaTKN2XoCSNQ34UIXer+Cqx6Dc0WEcW
	AFZfZJ93pNk2CX08VLUa/f8a4b6iYa9t32B0NVFH0pfWm0NKF9gDUQkucCGeWzJApein/kLNhyC
	UdNOXuD7yjwSKc5p1J7bIecNOVQzOscQwE0pcqNQStlNKzt8=
X-Received: by 2002:a5d:64c3:0:b0:427:928:78a0 with SMTP id ffacd0b85a97d-429a7e9cb6cmr3247934f8f.63.1761661891142;
        Tue, 28 Oct 2025 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMOTsGZSXAVq3SjJu/2WS9NseH84hxo6jnqAKfyR6/9FeNPp9QtVjNi6BEGt5SyDkugzoCAA==
X-Received: by 2002:a5d:64c3:0:b0:427:928:78a0 with SMTP id ffacd0b85a97d-429a7e9cb6cmr3247897f8f.63.1761661890726;
        Tue, 28 Oct 2025 07:31:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm24431112f8f.5.2025.10.28.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:31:30 -0700 (PDT)
Message-ID: <76598660-8b8e-4fe6-974b-5f3eb431a1ec@redhat.com>
Date: Tue, 28 Oct 2025 15:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, v3] net: mana: Support HW link state events
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Cc: haiyangz@microsoft.com, paulros@microsoft.com, decui@microsoft.com,
 kys@microsoft.com, wei.liu@kernel.org, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, shirazsaleem@microsoft.com, andrew+netdev@lunn.ch,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 3:41 AM, Haiyang Zhang wrote:
> @@ -3243,6 +3278,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  		goto free_indir;
>  	}
>  
> +	netif_carrier_on(ndev);

Why is  the above needed? I thought mana_link_state_handle() should kick
and set the carrier on as needed???

/P


