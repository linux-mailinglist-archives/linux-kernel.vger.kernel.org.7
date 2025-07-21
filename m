Return-Path: <linux-kernel+bounces-739122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A18B0C218
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243D17A5FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DE2900A8;
	Mon, 21 Jul 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8GhtgAz"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB94202995
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095763; cv=none; b=u7SQecxHVVSVZkSpqR366lR6bQAdIhYD3AT575sYwkdeerfANgkX4BBhKCu0usXNChMXoojiuBp7w9DMOaPpSAZAdppB71R4Rz3InzyxHOfBd3CXYlB9XkFy1Vlki0RoEoLEL6habXGf/8VFN3F9jWRyWidTm1g+nUXHD07xCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095763; c=relaxed/simple;
	bh=o66KmS0dvmnVwV9kRV+A231A5UVb86BycA3XuJzDjm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUy5pc+DcTcA/v/LjBDnFuryTNIDgXhvyDEgzBC80e6Y5R/p4ZswlbTpZZ/DBMPpUXpFJ7ecQ5tt1Xa2RQaBxfdYhqIClJaE7ZmzdULxSB8F1ioMQFn2jp4Y8MuU4xB0WfcQFSbHbCsbnKQBFYVpedWgA80kX9+jVU5WLwcLMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8GhtgAz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3140808f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753095760; x=1753700560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnPN47nMXqCMa/5FKC3NpcQPBDzZo2b6pouXJ5vXunM=;
        b=I8GhtgAzZraZ91MI5g1E54lReg3gyCK6gLTgpWeD/X7dOsAN+AayrmT7cyskH2s6Cr
         GxxjEwrRWwFIxDwsW32ejq3Yuu4jrEl04GBFAT3SPSJfy8trgSFWFcVdi9p21sOTWKKF
         Y5gYB1YeVPhnGGip5UIVP59sVTq2wrVelpLKdoTEX/UlxAaNyPDb5a9QA0CXaRJEe42N
         bNlbFKxXhGF59x45LLFxIor6xMWYAsplibUBZ/HA8mVm2pQLr5/3kxjXNkaBk72MD4cI
         T3bfOae5ZGaFvsof9v4JRhEJfgfRJVFRjudGjmObhmQZXhphzoMZ3M4pWFcAKZco7po0
         xpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095760; x=1753700560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnPN47nMXqCMa/5FKC3NpcQPBDzZo2b6pouXJ5vXunM=;
        b=KAc6nPePKW2rArMMSh1ygle/8wZBURNnmxUdIEMNxK3JwBRY9hsSPJRjvNPzjyx9K6
         il1gP9Pe3XNyWZtbny38Hh77HytBZpoj3Z5z5tprTWfZZCzhXVcPA/jRxKxjXCI7YqW7
         uQW8o3fea7qVW/VXaTC8oRcCpdsOv3OY8FXqkvQy6tjqFyWNinmuRJOnWtYXK0Inl3Z7
         IvbKoa5CAavROObY57DQwIo60HcTniXFcHSIfMxCENldrYtDNG4N1E2kvkZFNwqvJH+u
         epL825VnRqx6CViVQ3+kn9Iu11YAyVQCQqmZsHtP4zHzV/RpFD+G89z/SPwl8GaP+MnF
         865w==
X-Forwarded-Encrypted: i=1; AJvYcCU5iBZ4gQlWQK21W8vB2/chhSDuMw6dnnokxmDAD1eh4k3tACogRBHhdTLiXGrCV/7SLpVEpOuTropkMgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykED1OhhfYVdZolUvxXqzmfMqN+lrCmCTJhsIofBZCGML++CgU
	5K6ZK1/nvm8foXT6qZ+rZFvDBsmgW0C4OEIznmeFXtD9GhvpJrPjMQCe6BFugLHjeuE=
X-Gm-Gg: ASbGncs2XManmDmzLliulNVOEQ1ULOb7AYYxjvUBsTAnt94zhB5yaFP57Mh2RjvHny2
	rdkf7W6tJwFo60z8gekgtAPRMfVwRvmO6maAQsnZ4LJ63c9kiI2P2xOBaDt/Wju7CkbYjH9yiyv
	N2VT1vDL2QOH4H0xpygTmG5+ujvEFuWACffdy5iiyuOhiViHuzFsi3hJDv8EdVoRqaQpqlQFnCA
	KB+sB9Kdp+Oc0qIVpJSnJYOXtUWX3duLzULs7qbbekV7pUGQrCvyalveQrF/You5jpT7KxOEoi/
	ZbpQg3Z3KGt/2DVK4125KX9qqG2nh1FLPub1B2JV/h4u0aPyS9XFTUK8sWsrd0IwtjrZE9XEhrl
	XilIDh9nBsgE5HHyy0Qau826JMAC27RAFQ+OXta+Uuv4qeHNJ+YxAe0BQE7GDopo=
X-Google-Smtp-Source: AGHT+IFGN8mRXN/kZxyJyfdLFb/YDnz/Qv7FQJ0+kN5BasGH8tzT//CVFFtZf1yRBXL9BZ2mDjJbAw==
X-Received: by 2002:a05:6000:2383:b0:3a3:64b9:773 with SMTP id ffacd0b85a97d-3b613ab2bb8mr12942274f8f.10.1753095759171;
        Mon, 21 Jul 2025 04:02:39 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca486edsm10204994f8f.56.2025.07.21.04.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:02:38 -0700 (PDT)
Message-ID: <985111fc-3301-4c0a-a13e-ab65e94bdcbb@linaro.org>
Date: Mon, 21 Jul 2025 13:02:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] net: qrtr: ns: validate msglen before ctrl_pkt
 use
Content-Language: en-US
To: Mihai Moldovan <ionic@ionic.de>, linux-arm-msm@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Denis Kenzior <denkenz@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <cover.1752947108.git.ionic@ionic.de>
 <866f309e9739d770dce7e8c648b562d37db1d8b5.1752947108.git.ionic@ionic.de>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <866f309e9739d770dce7e8c648b562d37db1d8b5.1752947108.git.ionic@ionic.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mihai

On 19/07/2025 20:59, Mihai Moldovan wrote:
> From: Denis Kenzior <denkenz@gmail.com>
> 
> The qrtr_ctrl_pkt structure is currently accessed without checking
> if the received payload is large enough to hold the structure's fields.
> Add a check to ensure the payload length is sufficient.
> 
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
> Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
> Reviewed-by: Andy Gross <agross@kernel.org>
> Signed-off-by: Mihai Moldovan <ionic@ionic.de>

I think this is missing a Fixes: tag?

Kind regards,

> 
> ---
> 
> v2:
>   - rebase against current master
>   - use correct size of packet structure as per review comment
> ---
>  net/qrtr/ns.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index 3de9350cbf30..2bcfe539dc3e 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -619,6 +619,9 @@ static void qrtr_ns_worker(struct work_struct *work)
>  			break;
>  		}
>  
> +		if ((size_t)msglen < sizeof(*pkt))
> +			break;
> +
>  		pkt = recv_buf;
>  		cmd = le32_to_cpu(pkt->cmd);
>  		if (cmd < ARRAY_SIZE(qrtr_ctrl_pkt_strings) &&

-- 
// Casey (she/her)


