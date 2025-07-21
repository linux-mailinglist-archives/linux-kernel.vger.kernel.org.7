Return-Path: <linux-kernel+bounces-738610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD5B0BAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4573AC899
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0920B80A;
	Mon, 21 Jul 2025 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmkPPp+L"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B0BE6C;
	Mon, 21 Jul 2025 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066051; cv=none; b=d8QYjfpVpmWDK0qXBV6paw84BrbiDMI3h2ARECjuUyfT8E4GzkN/lqRvDPWMl/gvlisHLB0fFY8845BzDjxjddcYLIOUydpoSsVPk1DVCUTLnF0WCPn1zefR+uAUw4lGwpmIIq1Q7YRkT0J+kfACFHoVjx+sq8DMRvHccmfq8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066051; c=relaxed/simple;
	bh=cSmSH5r3M0iZYCR6VNYvZpZsQNaPRAS/MBd0GKR1CC4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=r8Jj2Goi6xYkuhJ69jLzhU80HzZ0w6nBsZL6U6QnTGYjeOiM+Pt9eVLOuuZKOQqOzprdhmZazR3h0MVxNjWRDKYsxhqZFdSzEE8fFNV8v1vfPgLv+PxysW16SYN4DAj4hiEtGG3YjV7QIUbWqhvxXtsU65uXgrEQXEAaHc8jl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmkPPp+L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236377f00a1so30610855ad.3;
        Sun, 20 Jul 2025 19:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753066049; x=1753670849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvOMWARjnVHYi4w9X/V03KgS1OXIjAwe1KjFXsbx6tU=;
        b=HmkPPp+LO5WhsuGZdvlj9rshPLTkiIitqfuKgsy4Vi3oIBAS7JnxCAdyP9y+vteSNG
         QGUlwJ8bwfAo1SFfKA79ImHawpaVae0SxDDMhl0yIOweVcmbiQjQx0E409FQsz5tHhPe
         OJirgTqKKLxUUKvm9FCs2Qh4B3eUJVMbEiH2TpUAEytdW1aUp04hKSHzw92yLoz4ojLZ
         tVxGZGSo1oFZqZj48RY+IoSBsk664i6U7+x4oM+tkinUYHtzc7MlMrideMOXlGusmIdf
         rlBWKXi954cG0/XX7+k3PbqJmnxB+nud3EBwJgfdnOLQYaHiVvzWFI8Sk4yT4cGMF3Fx
         mwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753066049; x=1753670849;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvOMWARjnVHYi4w9X/V03KgS1OXIjAwe1KjFXsbx6tU=;
        b=YXHU8R31xBrGmq8T1wzkQvjhcz3CYs2rz+43kri6XxWjiszbPq7zXTYn5Ff0LlGp8Z
         ZYSJmFad44YSrGT3wUU54TwA52Q+ZMwLk/klYlLCLvtPkFv9J41nl49URa5l2oJ9pY0N
         DEAQCKNlD6sAM7Ag9iYd5jRbo8d/OGxtjG7uoLmXeftzXCx2doA44h8AqA4ymkbQwJT7
         iWrS7VUURfzpT0xJPK8qxOFc5BOB/UCPDeFC3MZTZnMTk4BoCdVamvwSt/+vVjAl13EI
         TjxdZBFgdutb5ijQKH+u+YtGqWgst0XOO8yTyj9k9T8hVRBpULhAez2dKPr1QDwTmgIn
         +zCg==
X-Forwarded-Encrypted: i=1; AJvYcCUW6hQKMZWVFCWFa3dneUAY5OhI4WF1QyjuspSf5mqxznK6U40EcV/OivEU2ZPvtih8kPj8lIUC0IzYLrsH@vger.kernel.org, AJvYcCXtlpseaP52HSsxd4uoxWbSCRC8qAdTJnZ20wE1+9qBYwblJdz1IsIRij6fCkrggkysiIE32CfhjuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaqi4frKndWkrdxcdOcBOXv1YaMrBETz7CKpEf5ZBihxm4zgjO
	rRIQrE0N4aTgY7002jPf+hdVqccjbHDdfZS+toG4DCswmaio/H+NgWrC
X-Gm-Gg: ASbGncuevPOGng+OJc2TAqFAK5BkvUnPGVh/W1ep7RbCWNNs25hP0b13sSHoCI+q8Y3
	yRjU4mm5Pqb8WQ5JrrgsGQwiQjr8ZvBwWrgKTBTOsvJDNvHW3WJzCozk5kzcDQSnbTkcDr9mapx
	pCUbGwN2GgzoWdNje2/JsLa8P3UQEP6Bxsr0X/xX9xHIAHkxeMuLbWF5BkU/xvqyjTk+aNGnXHH
	hHonC59ifNVvJ8ks/WnbhwuJkr/OjrRQT+Y+YSINNehhYhZDxj4d0v3llUTuSsc7mGCKacwIRw1
	+qba/Csm6EMvBaTK5OS7+PReREPfPl1i+1D99APYRp6XsMJRdNZLEVjv5byf+ACgySm410rBM0w
	KnMPXrUbnsSAYsgqxIMrAbh+Y9EsUeociO+MrxZeLIiSyaYuxDs/0ALgwHFfHbc7JzEUb
X-Google-Smtp-Source: AGHT+IErzmMAACbvfoxsl1bBEVkNcBZV4inHcZe4xlcIhf9LmnvoQCbVRB80bJMNDuQp0n5KG+LQpQ==
X-Received: by 2002:a17:903:4b07:b0:223:4d7e:e52c with SMTP id d9443c01a7336-23e24ec6ea9mr267895175ad.5.1753066049368;
        Sun, 20 Jul 2025 19:47:29 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f29dde6sm8887913a91.34.2025.07.20.19.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 19:47:29 -0700 (PDT)
Message-ID: <1e3c4ee3-f66e-4ce0-819e-e0bed6a744e8@gmail.com>
Date: Mon, 21 Jul 2025 11:47:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: carlos.bilbao@kernel.org
Cc: bilbao@vt.edu, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20250720160243.149595-1-carlos.bilbao@kernel.org>
Subject: Re: [PATCH] docs/core-api: Fix circular buffer examples
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250720160243.149595-1-carlos.bilbao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+CC David and Paul, who are the authors of this doc.

On Sun, 20 Jul 2025 11:02:43 -0500, Carlos Bilbao wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> 
> Fix circular buffer usage in producer/consumer examples in
> circular-buffers.rst. They incorrectly access items using buffer[head] and
> buffer[tail], as if buffer was a flat array; but the examples also use
> buffer->head and buffer->tail, so it's a struct. Use buffer->vals[head] and
> buffer->vals[tail] instead to match the intended layout.>
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@kernel.org>
> ---
>  Documentation/core-api/circular-buffers.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/circular-buffers.rst b/Documentation/core-api/circular-buffers.rst
> index 50966f66e398..b697915a2bd0 100644
> --- a/Documentation/core-api/circular-buffers.rst
> +++ b/Documentation/core-api/circular-buffers.rst
> @@ -161,7 +161,7 @@ The producer will look something like this::
>  
>  	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
>  		/* insert one item into the buffer */
> -		struct item *item = buffer[head];
> +		struct item *item = buffer->vals[head];
>  
>  		produce_item(item);
>  
> @@ -203,7 +203,7 @@ The consumer will look something like this::
>  	if (CIRC_CNT(head, tail, buffer->size) >= 1) {
>  
>  		/* extract one item from the buffer */
> -		struct item *item = buffer[tail];
> +		struct item *item = buffer->vals[tail];
>  
>  		consume_item(item);
>  
> -- 
> 2.43.0

        Thanks, Akira


