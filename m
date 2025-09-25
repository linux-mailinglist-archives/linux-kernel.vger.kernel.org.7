Return-Path: <linux-kernel+bounces-832011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DEAB9E237
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB62F1BC349F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22553278143;
	Thu, 25 Sep 2025 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8qNXfFe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F008488
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790456; cv=none; b=i0XlChhOkB5dVJcGVvU9LZRNqndMa6i70UiC7p2JeElIYkpCyNmicsVsGT8fERReLspW4dNZ2JR4pMMMCy9Knqf7eezY64iwGakHHBskRXSSK8qiee3/PJ0wTqyXyQpOzd5/o12r4m7iILDPFJU1GF7+EqdKMFXSKPNis4CtnhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790456; c=relaxed/simple;
	bh=sWVB90PRX+PGMxWifkpDrZpjU3a+Zb9UpSplPIG3QlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEVDruJ27YSkkrcHYZNyd9L25/GG5XF4LeizIdE2xXpv59myXVEoQ6XQFIUeiXS8t797LAGn5S8ZFshAr8Np55iZsSQstYJp9FwrvY5qXUm0Qeg5BkiiTcTHm566Qrq6cAInV4Nr7O7WC6UQF4khVDfDuHRaxPfO1UvV7MDgdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8qNXfFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758790453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1gsFn/xU4RBQz6XkcOaHJDRKfU+vBnP2TcZFpNfy7DE=;
	b=L8qNXfFeEOLppvPNn/xJwOZgG6U2A0lkFx6BbcTlQv4/pH/bQtK+PXeLxTmMRywrzzv19c
	dXI3TTAtDCVtQv9FIT6CBWw3t3Tur/IoCWXnts342L5TqD3EQPtYihOkdCEoGqnWkgnBFu
	NHHg8p0tNNZO4v/UOtACCI6LY4WAoNw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-IWRXZOksPQeCjzlLtesO-g-1; Thu, 25 Sep 2025 04:54:11 -0400
X-MC-Unique: IWRXZOksPQeCjzlLtesO-g-1
X-Mimecast-MFC-AGG-ID: IWRXZOksPQeCjzlLtesO-g_1758790450
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso5991025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790450; x=1759395250;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gsFn/xU4RBQz6XkcOaHJDRKfU+vBnP2TcZFpNfy7DE=;
        b=fBGvWP61bfyO+4WGAL1SMuAPg6Mfc9iABzB4lT480qnCEJEn/MPt3Q7UmatDrc5K7t
         fUjZDm8Wp5oShRKRIEDy1LHCPVaHLD0c582RzW/VnlnzgE0DJS7ZLmrrMux9H90/5Rq4
         Jiwm0Op3uv7eojW2BRXPbMTdSn4lxKzpIY9DW1zCZ26GF5O0gxdvb47YK/6STVYZ/I2x
         9anc6BYVD3OHCR3UzVPgUVsfRS3xrOMtVfIUUWYLmF4TTjecMqzJ2tSE5FSiQgndKtO7
         8oWau9VxX8ldb6+nRQcuTRTVZ8qysJtM3Ynz8xLqfwc4qhzipX0xOaTh43gwlgTctDJo
         mi6g==
X-Forwarded-Encrypted: i=1; AJvYcCU9QE3QPifeSXifBI5tkCf9cYEkEv/diPRzqF/5FFMmtin+cNRpCPuPKWmMKay7nO4fRTEUvn7eWAzBzC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbOCw6E8SPEWFMwLJsLdEQM9hqS55uvikqxoqKKSduifEZ4VXs
	cduE30h1ILyOvrQwVrjxO4/5Os3KZmaaBhUCVwzIzZgHykZQkj/v9DManStTarX5vbn+6UjAs/Y
	C7pfov7avM0rWHhMS7b8U2I9ZOYGjb3MlFDu/3ty5qPlgQoR4nixVPDREW1JIK9UlwA==
X-Gm-Gg: ASbGnctRiw/pITHD4E5RDSMu+c1j8d4l+7iUtvmjXXuHk5DWSHTO2Nunl76mlFWEK05
	3AYriTvtHcxKL3R3knhn9fYRobLhSPcLqUMv3c9tWh6oOg2XLnPSqM170spYnM7D+Ovz4F3j0bQ
	K5WBW8kWzoarATMvSAs8kTgqdZOc1qJeCsy+Sn2hIoUegGzZfn7O+xQtBU4zqk5J0x8KspMqYvi
	Uu5FGm1CPYjyXeDwQKCehOduat8Tt0hRsENVoGKC5eoyXRVj1nSHg6u4164ScYyyigejRVIDuIj
	AQFeJFxpkETJbEQeOHuNB6gKfAal53f2mHH40LGjmwL2Z8w5VmsFGYAIVuztJHGB6JhhPfnUQsW
	SRodS6MuglOPxPxaOstsajxhCYH+1Vn3VaCHiEMLvQ8ECiyVsrrdqQeomGv7Szp9J99HT
X-Received: by 2002:a05:600c:45d4:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46e32a26e4emr26084845e9.36.1758790450330;
        Thu, 25 Sep 2025 01:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7WIypjZMXxbyn5a/1aTfXoe6g5qRkRehIOgpqrXFKvpJdmOeQruAy+DajB3CSz8qmflRRXg==
X-Received: by 2002:a05:600c:45d4:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46e32a26e4emr26084605e9.36.1758790449876;
        Thu, 25 Sep 2025 01:54:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb1a3sm2096184f8f.10.2025.09.25.01.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:54:09 -0700 (PDT)
Message-ID: <0de65980-4333-434a-ae7d-2b7be46c2cca@redhat.com>
Date: Thu, 25 Sep 2025 10:54:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/base/node: merge register_one_node() and
 register_node() to a single function.
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>
References: <cover.1758736423.git.donettom@linux.ibm.com>
 <40257b5228dec05e5b252f02438608eb8d681a2d.1758736423.git.donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <40257b5228dec05e5b252f02438608eb8d681a2d.1758736423.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 20:40, Donet Tom wrote:
> register_one_node() and register_node() are small functions.
> This patch merges them into a single function named register_node()
> to improve code readability.
> 
> No functional changes are introduced.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---

[...]

>   /**
>    * unregister_node - unregister a node device
>    * @node: node going away
> @@ -869,7 +842,13 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
>   }
>   #endif /* CONFIG_MEMORY_HOTPLUG */
>   
> -int register_one_node(int nid)
> +/*

We can directly convert this to proper kernel doc by using /**

> + * register_node - Setup a sysfs device for a node.
> + * @nid - Node number to use when creating the device.
> + *
> + * Initialize and register the node device.

and briefly describing what the return value means

"Returns 0 on success, ..."

> + */
> +int register_node(int nid)
>   {
>   	int error;
>   	int cpu;
> @@ -880,14 +859,23 @@ int register_one_node(int nid)
>   		return -ENOMEM;
>   
>   	INIT_LIST_HEAD(&node->access_list);
> -	node_devices[nid] = node;
>   
> -	error = register_node(node_devices[nid], nid);
> +	node->dev.id = nid;
> +	node->dev.bus = &node_subsys;
> +	node->dev.release = node_device_release;
> +	node->dev.groups = node_dev_groups;
> +
> +	error = device_register(&node->dev);
>   	if (error) {
> -		node_devices[nid] = NULL;

Wondering why we did have this temporary setting of the node_devices[] 
in there. But I cannot immediately spot why it was required.

-- 
Cheers

David / dhildenb


