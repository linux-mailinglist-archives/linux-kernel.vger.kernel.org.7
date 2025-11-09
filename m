Return-Path: <linux-kernel+bounces-892210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CB6C449FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DB1888C3B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6892D26B2DA;
	Sun,  9 Nov 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/8yL8Ie";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nNfzWD2w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0A72602
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730391; cv=none; b=qC4mpLHOXiLnJ+dxTw7c4PSfscGW2c5BRuhjv8pW2G8AG7QMEkyeL3wK6vqxv3k+NLKJa4Q1AwV3JUy6RUCLI+PWcoqHzxnRUOrHtBYJjQgwZ7brU6168vZwSS1AG0qcGrAbH6n18ITN3VarIzUjL6EkQG8NRewk+Gq/340erSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730391; c=relaxed/simple;
	bh=lrytaMAcYx3ZKACpSPuLLmlxwodrevAZ0NMZJ+T9g28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiLppUH6egb+PAj0OLk2i3s39WJjJQiNehUcp5JTFBXIbN8E3jOLPKcvzlRwJBfy+2FM4zUebYY8RHQmVvPbOsmavdPj5FCWwZnTYMoOJJ1vuad9T0RKP5+Fl4VqMRysxMGSmLKcu8CU1Dz84acLhvB31AztVw77znDv70jirD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/8yL8Ie; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nNfzWD2w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dubJJZUeDuyLgjxuOinZfNrgxD8y2GPrhW+uof5Koyw=;
	b=H/8yL8IemrLy1/7KQvhc4IJycCsSX+PClzL5O7OCAeygrBDvq+36KKfgMtwV7Parms1AWG
	YT+H4Y3Ln8R82VDZ/6EhXJBIPECAtD9xbSvdaElQ4FMJzZwQjwLUTWyjerk8gWwOhyo29/
	NzmDaij6UZD39rqNFK3qvK1SEz7DyrE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-dgx19xVjOwa4wtNTzeSA_w-1; Sun, 09 Nov 2025 18:19:47 -0500
X-MC-Unique: dgx19xVjOwa4wtNTzeSA_w-1
X-Mimecast-MFC-AGG-ID: dgx19xVjOwa4wtNTzeSA_w_1762730387
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso2722824a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730387; x=1763335187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dubJJZUeDuyLgjxuOinZfNrgxD8y2GPrhW+uof5Koyw=;
        b=nNfzWD2wzfE2taALxqkz/USJKMeP5D1l7KhVHzUAn99dITFvoWZef9X7BYwbs53URN
         rM91rzVkbkoQy018ijc5LQ9M3oQarF2HNwKMJoTNm1ZhdEBMZxc0jItToPLLGiXIWcOp
         6Yp7BlaSM1IZveUJuvYBQwW3A3JwHD9i4lFRl/wsQCnzCI4D6FeaIkF/g9ntSCcPMwk8
         nTNPEiWakcJgg6vrYyWNOkO6gCcdxUJAo7swqMmWe7NZIMkuvNK4MbR2DEbfEttdTPWN
         Fe92r8EOjSevkgkBuFwjB7H03sYD8bFWtJQyk9oW2kuggdfSmqKzl3LSXiMMTsl2eqNx
         327A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730387; x=1763335187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dubJJZUeDuyLgjxuOinZfNrgxD8y2GPrhW+uof5Koyw=;
        b=fuAwsYZol64ojZ6bHHFqK1gK2h5GMwu4a0jEUbdhd9SRiBxrVqtYTRwCsxgwu54zhM
         UenZll0zIhqqcz3IkQKLtYx9Z/ODJVeEvhmQcyfEEPv1Mh/KazmmIVpM+1Vd4bTyePUj
         HMT7iE31pzkp1SnWrGMaNjmpzXuHKam57ygJbUDKLd7s1nyA/4MXqOigq4CyKyR4PsWo
         nMn36KyqgRNl0My4ndY15KumzaW3m/ETu/KiZscey46tb35j3c1E7CRFO5WsSLun6DhY
         UJMrbq3v6S3+OA/WHTTD6Qcq6KZkeSOVAc853MHhJQ6eP0RZLr+H7kROOEtN/Pc0+RTB
         fBjw==
X-Forwarded-Encrypted: i=1; AJvYcCUmDY10D9A2/8ROepHxsECefzutXvZYvMbWwSg+SXh1VaODlP4vX7vhy6GgCNS1lhv2pEXRNbKfENM7yvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywser7mdX+fqRStVMMQzgyxB/xfdVt6OlreVX79GXpLf33XSU1D
	0KYDoRvLZ+QSXd7I/3UyGONHQYa509IZJhVQNWJlPRH5w8kiL8MFqarKKj6g+gfFUKSVVg6Fee+
	zx7WwK0bZ0Us0jKwcnHznFiBsEUemI5ratptqPtWEZ8An0wYKrANYwl4vxH7ZKS2OUA==
X-Gm-Gg: ASbGncvZ0lTnZmssL4Xs6GlOC35wLyvVlYUhsafS4uA4SHXBBcAZPJjzWtNNk+K5Pzm
	n/rYW6cCXpOwT9dmTAE0LZD/HlFsxTFoQGvno30xkHvvSt3HQKZFxar1zSXXKBxhq+IDn7tiYze
	Iuh2oZioJ4WQZGQJMt8luSJf3CiOGHsrMXd+IsI85bfPxulzVDFBjWYfz1qbfdjxBHoL24zg635
	laROIG2SdmQg2Cmv03QhO3xN5zQ4x2l9np0eRSQvchBuyck6bkhz7u7+wQibzKvdG0rLa853SLH
	twg9RvTVY8o26WLqGZ2Sjl76vrS0qLBojkJcOwi4+5VoiHAoV+3HIygmbCCr1NXW9n51K7y6nFK
	c9PwKYSsQxiOpjb1qHkF9f+LnFRhfAYd/kweFPz8=
X-Received: by 2002:a17:90a:e18b:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-3436cb73cc8mr6923404a91.5.1762730386877;
        Sun, 09 Nov 2025 15:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLmBsEtvmrbu2EisKkS/8V7PL4jymEDPy9iS1fiQDMzqvfm6s80YMHDPtL+IUqN7rphhGZ3A==
X-Received: by 2002:a17:90a:e18b:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-3436cb73cc8mr6923390a91.5.1762730386503;
        Sun, 09 Nov 2025 15:19:46 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ce9e9sm15157570a91.9.2025.11.09.15.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:19:45 -0800 (PST)
Message-ID: <f7947bab-46de-41e8-8e4e-f18f163b9e5f@redhat.com>
Date: Mon, 10 Nov 2025 09:19:33 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] arm_mpam: Add kunit test for bitmap reset
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-33-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-33-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> The bitmap reset code has been a source of bugs. Add a unit test.
> 
> This currently has to be built in, as the rest of the driver is
> builtin.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/Kconfig             |  9 ++++
>   drivers/resctrl/mpam_devices.c      |  4 ++
>   drivers/resctrl/test_mpam_devices.c | 69 +++++++++++++++++++++++++++++
>   3 files changed, 82 insertions(+)
>   create mode 100644 drivers/resctrl/test_mpam_devices.c
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


