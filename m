Return-Path: <linux-kernel+bounces-806053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506BB4915A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABAA3A71D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F4D30BB99;
	Mon,  8 Sep 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpILN5c4"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE31227EA7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341701; cv=none; b=CQ9awVh1knmJYJ3+jLy1FGVSVSLBs2CL9g6whLyerQS80AZA5xBqegWwM19d/f1QWEXhRIwnBhudV5BylvEXQdeELV6+m1WZg5lyAw0wMLNvxcVzjQN9eg4DCGxSxFwwxRpnwmaxsxdwB2XNkihKvzEJ9jaRVyDkHhpA60M/shM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341701; c=relaxed/simple;
	bh=JbKs6lUyMAsg1YHWCzyYZ6ggQbWBhB++ZW5dnlqQi0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0wY+Yzvi9oCWKaXJbTmi8TKKsPJsn4xa9oWkEkOyOO01SfJzQZdxA5rgQX5G4/jVc09Njbx1mCXIdLbwfzrrdWJcT0jDovtfOxK/b+sP/VAIi/d+rTjUvhjgGL/Zs/VVYkEKCXRb/AMEbmv6G/tisKIch9gxDlnxbjhoUinWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpILN5c4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-817f3d08465so87713585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757341698; x=1757946498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkQvNzNp9Np9r2urRAnfM6gA70u5E/wzFHlmS7bRCBQ=;
        b=JpILN5c4BR09ngCENkrYdR4pebZfz6zcXfhuaBep6KJtEqcQqTxA2qGTai12vgkFDQ
         hvZyj+CWAp8Apj0YqK/IFcQln47ZtkDzj2DIM8Wkia3mYaxTRb1syaW1lJdZGjicPqAk
         LdQ993LvqZEO6Ub1jrHkU7AgkEfb0VezXSCA4jEabemm095HrUXl61cPlprgyt/hw3KI
         cv3m0Ah37UrF+6Vo1Qqt+l2gVxb0UCcr0lyk80seYcaJ89oUSZj8QttqW54y+XevYmDh
         qRrlR5yfceKF7cU/zqm13ZNgjyTVHNdpqfHq8N4ShIBcesKQgkbzMzFA4cltHxDVldbL
         38jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341698; x=1757946498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkQvNzNp9Np9r2urRAnfM6gA70u5E/wzFHlmS7bRCBQ=;
        b=pSXWayNVQtIdBgoX8MZDuxExFhWn6SBkwYE+n4boZJ0kSKDFZw7pQgZrn06LdXKa2t
         /mIbyU/a9rufZarf+8RYr9S22Ps0mLlgEY3vwtEXsWQTXjWOhLuVC2IN7e4IKFrSIdXt
         HJU8d51TV12CduhSbuiUXjYwI7xDJ5sXx/3Ub5R+W7bKcajj0fgSfiPSxwxMSWhrojI/
         ebtMPYzef+IHxoAhfnKCLcOa6zmuCRIaB9btF0Q2auXVglNZdfiJpOWxVN51LDN/O7L4
         0OHUC4TO3hqXD4VkLKD7Uyss7j7lumLeYLbyzvRHZjWs/ToZSknQFyDBHpY5ObPsqX3A
         7diQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW4BHAGKyctrnwBKwhHynZdA5cFPZowpNo0domVe87T+JQe6hUvnJyDSRRtOg6zofRa+krx7QlEpvYQ7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1EHrpTBjwCiuSj/AUPwKCjGl9mKsiuM0mAvUp1NO/1nG1Jv9
	rZXtPTGkX3CULfNsf7YY7UWSU7HqQIe/hvLDoGTB9sxi2NVDgovIzacB
X-Gm-Gg: ASbGncvXtkUQq/clZZV9dCpX+UT5vIucv72aI5bnTLWal+AtnzS6GMtrEVGGgPHbjlQ
	ccMxAmDdDlrGVcWiccghd9MFDE10Cq3Yl/Qjc+RZxFD7Ogfg5Pq9/yeGCbnMLwynBWNDAq1G2ck
	3iZSUcuPNGusPVaYDc5X9NUsY8sWaHwFkfqrLWily9gw8HhLvmx+50NpGktvPiIvsOtbji1qb7h
	L3U5FIj+I3tKhdz5HvUff0Tjk+TjBp07kmYN14m/E4t/aCvHfFeeQPWbdHbSNSB/zMO+3duWdX1
	iKo+dQ+4O4FBLXpXqwHMMNCyLcTa64fJyVvGBmiPtqsfzsXu7tuH4e6sYX2aDrG6LUErhws1a2r
	gOpVIAzHKke+5CbUJuev6FeQGgRQsF/aC99bnfHt7k/jZoTqFNgUOlv4wWR9c98Ebe9d6IIHgCv
	cu+7tS2P+4y1E=
X-Google-Smtp-Source: AGHT+IG3FI6qQXWbQjRiDr40C6wDknp3bM4B6cMgZXxuj30zC2RffBMpUFnNnKDRFGROvsosTsCJTA==
X-Received: by 2002:a05:620a:720a:b0:814:bfd2:fd73 with SMTP id af79cd13be357-814bfd2fddamr766450685a.15.1757341698260;
        Mon, 08 Sep 2025 07:28:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1456:e851:ddd5:be9f? ([2620:10d:c091:500::3:4e10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-811b7490eaesm715891685a.65.2025.09.08.07.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:28:17 -0700 (PDT)
Message-ID: <fe2655f8-1f8c-467f-afd1-49da0d191744@gmail.com>
Date: Mon, 8 Sep 2025 10:28:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
Content-Language: en-GB
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com
Cc: Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 ziy@nvidia.com
References: <20250908090741.61519-1-lance.yang@linux.dev>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250908090741.61519-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/09/2025 10:07, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
> it does not make sense to try to detect whether it is underused, because
> try_to_map_unused_to_zeropage(), called while splitting the folio, will not
> actually replace any zeroed pages by the shared zeropage.
> 
> Splitting the folio in that case does not make any sense, so let's not even
> scan to check if the folio is underused.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Usama Arif <usamaarif642@gmail.com>

