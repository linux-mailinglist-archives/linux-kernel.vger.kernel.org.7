Return-Path: <linux-kernel+bounces-848394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBBEBCDA2D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE8BC4EFCFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AE92F7459;
	Fri, 10 Oct 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnHU/lEU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B5257848
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108196; cv=none; b=qLh88heDpMgJc/BpX5RJSUvowqlMFil7GgWhXsh8uQ8ynW6RbNF640Hfbh/qvui/whfVRi3Sq16F5MFLdsTexOdRQj7cDiDvwWsiekPsI0NGT+7wW19JPeuxyD/7eg77fYs/hvc7YDmjuZTkHKrSuWBNofszC62nZ1HjL1zu8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108196; c=relaxed/simple;
	bh=1Jhcg0xv8VWaEgihjzPeUziID4oG3ExKtqP9zC0KWCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yb8wyFpcOZHTokuaX+FpeAg5dO0Fi/p9E9n6OadoKVt+8hR0yRAAiaDGGr6xtE9TFBtUVmyDVOkzrVfDinClWqmjmI7sDWUdy2ev8Ojy20DiLOvrjEuGYtDBp7oMlYDjQQTdSNW2yS4VzIZ0efAB5Ps3KvaQZZjVXWt/Mgu2SDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnHU/lEU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760108194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1P5X+NGWefQQJqZl15++e1LnM8GbiR8ChaM6QOBRs6E=;
	b=VnHU/lEUMarqMKZGXISFJSNs2O9utbb6/GGG4sc5Ki79q0NxyDtacUfTW1bcGJLZxAZ8Md
	efwJ4EjDVs66JreqLFc1uggKTJBDiWB9CfO/uKJbRopTZZyIQKRpIaIH/LCCK3ClHiie1s
	u9zbFUbl7fPGd6qfgQQJwosp3h37rTo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-_BSOYXyANJGsBpFm2g3y_A-1; Fri, 10 Oct 2025 10:56:33 -0400
X-MC-Unique: _BSOYXyANJGsBpFm2g3y_A-1
X-Mimecast-MFC-AGG-ID: _BSOYXyANJGsBpFm2g3y_A_1760108192
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2f9dc3264bso531363866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108192; x=1760712992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P5X+NGWefQQJqZl15++e1LnM8GbiR8ChaM6QOBRs6E=;
        b=XOI5dVSrgnrIMtAlZ9TcQQmz77v7xCjzrcQIafVhYCdi6W04PX4EVwJuE5yzwHomWo
         4064HzZvN1+JxYeTOT0qIH2q+zf+SjO1fqekUaWBfbhU6UKaOzWlgmNZVnzuuFIZLQCK
         /7/L3T2TBPhM9B2Je8Y6ikqVuSxHDGMppCtQ6HcdOUJYZ6Gnlh3m5L5BVwPzQoKfq7un
         xsipvT56HpvVBTvB9Wr92LUD3bmCygko3nJSjK0zLqEOCNvahy3pt4F+Lv76V7DJjm/+
         LVRgXqNdJumKGdoqQUTNhfnpvuDDfPJ6S8iO5lg+vsjxCr5srwx45pYTuCNYVpmCdXgu
         N9bA==
X-Forwarded-Encrypted: i=1; AJvYcCWX+j5kXKHJmGVcBi1mjI7NAA9PXj5DMJY++6r+OlE4vouPw2snMF1OpP1CcwDFWeHZZRQ4Bqnjmnw0iHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+vTUawkKpeWApBxOWL6wPTlD/uB8Ea0uSeVEBjTkY3b41h30
	GIjoRo9eAcJ2ciTBljerVBtLvs1EZzidfKmmNflWDqVUv+I2k7QF3pBO/QfMkO5WFrFascSNh//
	5jhmz/vFqFjJZ+S/OJX2Ae1X3E3H6fAy0dKVtZjSYXiOegPN4kHgeRILi2O2L6rRyRA==
X-Gm-Gg: ASbGnctQw2ccMiM9NA+FPt1naQBZkfGpU/DhLRy94Ld0gX8So7zb3BRmfPT4v88e56d
	xThhiqOAKNkeWOMuaNn5ayb8x/Xx5aYnijE1hWvkHHWhJjIlrXrPbUdcALDWTOw0Vredf5ndXTV
	oXYBjHyk+fNfVJnClOpCw4Bt88QzTCbJfxw6vYMbwcP3KexIm9snZyTNtvvpJ9XFpg0WqdVgnsy
	/WGt6JkefkJifxj5SV8KDw2N3DwnrWVqQXMihyE4RCiqS0JHxvbpAG3VJm3OUJvgtmk9iHNl/KE
	7ovMl3WmgoV0EcbkuR6sW6XIhv+pPEFmkR7O2e9PPpP2Kxh4Q+EdF3lh/pDNILPpPwr4SdAtw0Q
	iiGar2LayeHVV
X-Received: by 2002:a17:907:ea5:b0:b3f:f822:2db2 with SMTP id a640c23a62f3a-b50a9c5b35emr1276356866b.11.1760108191606;
        Fri, 10 Oct 2025 07:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9U3OHPHv03/njQrGc9l3W5M5GCK0ZytbxV4E62A/ghGcguoBHcO5uBfWotYvFJEwS98Ry+Q==
X-Received: by 2002:a17:907:ea5:b0:b3f:f822:2db2 with SMTP id a640c23a62f3a-b50a9c5b35emr1276355066b.11.1760108191199;
        Fri, 10 Oct 2025 07:56:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacbeesm240224566b.15.2025.10.10.07.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:56:30 -0700 (PDT)
Message-ID: <bd3149e8-e213-48b0-8f8a-0888d1837b84@redhat.com>
Date: Fri, 10 Oct 2025 16:56:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: check jq command is supported
To: Wang Liang <wangliang74@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20251010033043.140501-1-wangliang74@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010033043.140501-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 5:30 AM, Wang Liang wrote:
> The jq command is used in vlan_bridge_binding.sh, if it is not supported,
> the test will spam the following log.
> 
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # TEST: Test bridge_binding on->off when lower down                   [FAIL]
>   #       Got operstate of , expected 0
> 
> The rtnetlink.sh has the same problem. It makes sense to check if jq is
> installed before running these tests. After this patch, the
> vlan_bridge_binding.sh skipped if jq is not supported:
> 
>   # timeout set to 3600
>   # selftests: net: vlan_bridge_binding.sh
>   # TEST: jq not installed                                              [SKIP]
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

This looks more a fix than net-next material (and net-next is currently
closed for the merge window).

Please re-post for net including suitable fixes tag(s). You can retain
Hangbin's ack.

Thanks,

Paolo


