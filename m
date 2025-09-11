Return-Path: <linux-kernel+bounces-812263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296EB5352F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C837A6C51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B003375CD;
	Thu, 11 Sep 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StwsJvNo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F703320CC8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600667; cv=none; b=h29jhswsI8jKomT8RYNGGkyxARDIT2DVmHMTvNqy5Mv5Bq4QrM+O7YohOx7GbIxy/ryrE+TtfHcYSHikjkwdwlJJmoWFq8xGeRBnsBzp2WXmyhVIDSfXl17hAhEmJZpZyYMpjakIRk7RsxYuw3/AIrtLHZiLWytWwa3r+tbwO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600667; c=relaxed/simple;
	bh=Y6a/86+wjytTrdNd1x/+Y3lFyfNxUHDS/sgjqthX3Ug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IifQNCJiCFoG1G25bk9udC5EJ+Z2oPXov8oPF8ZkFXcNjtR6MnPMKajOYPwfhBNyPBS+0U5WlDewZdKZmFI/GBBI5wxE5Eel9N7rugKZM7V6YMnm07kFnQe32vbP6sVixsaMZ5ErIPt0Xh+k/xARL6rkgIQSgwmmlNrWraftSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StwsJvNo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757600665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHsNAGKvOotxj7lLw2vsOxsdCk/iz2T3/ZLVYRgdaOw=;
	b=StwsJvNo+vnhbS1Z+NHyDzzuiRl4xurw9xxGhxOzucCx1XVAZVStXfzPolDhYUGENsa+Di
	fKYmzPnXI3Ts2z0Lw513qvru1PMTlaVl1Ro21IXyaoC21xtJ05hJX5EOudInTsTqSXWyNL
	KvmnZIWQRZBLyt+WheEuQHfbXYYYQhU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-X5ASO3z4NZWTiLroS11mwQ-1; Thu, 11 Sep 2025 10:24:23 -0400
X-MC-Unique: X5ASO3z4NZWTiLroS11mwQ-1
X-Mimecast-MFC-AGG-ID: X5ASO3z4NZWTiLroS11mwQ_1757600662
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9912a07dso4031995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757600661; x=1758205461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHsNAGKvOotxj7lLw2vsOxsdCk/iz2T3/ZLVYRgdaOw=;
        b=LJPGgij46tbxB5gY9SqZgRozkb5ZHY9LFOlz32A4vf6QVVCi2SPeHo9N/+9pk2aYCq
         sT9yj1mMWuLiRKhvuEIqr6m/YVIcPkWQg6Kt25RRNaxPJYE1hdAJ+6r3XJkvSdxxNgRr
         QhdVquY3wRYVb8EZ9KQySqJVsqYVoK4VxaZMjhCa4qlNopHyYAIJLNcL/yVQ5QLXHV4Y
         PpqQ2ivbAyAaiR1jCjLgPGhvucZLBGjykY6OpuYxC5JXknK+g48NL8R5A11NOgq1L86Z
         LdYsRmojhahpFUdvtP6O0BQiqH7roOHspepa/h93fHwxgsR4NZmDUaLnV+iHEXvsQb3b
         3gAw==
X-Forwarded-Encrypted: i=1; AJvYcCUHgWN41PbY7WmJJwJJfF6A85M+S1mnmYLZybtcdqx4wjaJRcIRdTM/avBTUkxiPYj4LCMBA1S4y+rB5lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKI86QA3txIeGiuB0k7Qoajrfci5IW5dmHTNFjcItZMmoZn7uj
	JiaokzBKfTXgHyI8Kj45ieHUTmFuJLCfUDZdfa674GebZ/YXw/OivA8ASUtphx7AdX6nCRnfdTC
	1NzAWlOhqYSKx5tSU+LfKsPVKtj6qvdv2zeWCHNU4ZFHXCLgpvuNRiRcnmPVynrSITQmk1YfgMw
	==
X-Gm-Gg: ASbGncvn4SJZ/h4g/YZ9mk7/Ca5W7JJQdRQh4REBtt6bWrCTi2eKa40r79c3sUZyKC4
	0ELwm7MPRxhz9KvHDB3cU/gVi2fRM7l+3MzqoBXDLUcKu6J4yVK5ajeuZpfjwla0psJBBsgKMjE
	/dCYeR8xXeHEwKHJaxjqVjs3wrHG5NS5zkiJ8G8lBFZTIB92ibKG5rqUY0rH1WbtfpYgAoWMJpU
	i12416U5dq2fQgZlICA00Nw+dRxDSpfdh5/+6Pctu52Y5aVNZ42ObbMifqP/eGBQqCff3r8YXKb
	F9oynkhzuhX77XaakW2+xqIiWumbFt7mCE1EzjBLBOY=
X-Received: by 2002:adf:b350:0:b0:3e7:41ac:45f8 with SMTP id ffacd0b85a97d-3e741ac4939mr10290873f8f.55.1757600661471;
        Thu, 11 Sep 2025 07:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9vOlqkWFXwoDUxcYYpXeQRpsUkfeWLqOyZ0rHn85FAwejsWx3SKbDB72PCR7M/2FZa6TABA==
X-Received: by 2002:adf:b350:0:b0:3e7:41ac:45f8 with SMTP id ffacd0b85a97d-3e741ac4939mr10290856f8f.55.1757600661007;
        Thu, 11 Sep 2025 07:24:21 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372aea2sm26368435e9.7.2025.09.11.07.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:24:20 -0700 (PDT)
Message-ID: <45cd5086-193f-4344-a5f0-78dde71474d7@redhat.com>
Date: Thu, 11 Sep 2025 16:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.17-rc6
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250911131034.47905-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20250911131034.47905-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 3:10 PM, Paolo Abeni wrote:
> The following changes since commit d69eb204c255c35abd9e8cb621484e8074c75eaa:
> 
>   Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-04 09:59:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc6
> 
> for you to fetch changes up to 62e1de1d3352d4c64ebc0335a01186f421cbe6e7:
> 
>   Merge tag 'wireless-2025-09-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-09-11 12:49:53 +0200)
> 
> ----------------------------------------------------------------

Please do not pull.

We just received a report about a change included here causing
regressions (usb, again).

I'll send a v2 soon with the blame commit reverted.

Thanks,

Paolo



