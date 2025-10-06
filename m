Return-Path: <linux-kernel+bounces-842612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFBBBBD26D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC24E623D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D525393E;
	Mon,  6 Oct 2025 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlmsdmuZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171696FBF
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759733204; cv=none; b=Hzfov3D03Ed2unZmbG0SZYJYlmYElXV68DSWaVcqQl4YhoU8T1NYs3JWpOiWZZG9OxUtI0wdV51F7bYJkzE9DVebAvJ3tmaWxds2/uNp8w5KwHevLZ6A/vYfIlYsVakoO2S9+uCnvbLyTr01CCU+r1P6kTQv09XitQPFfrc8Reo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759733204; c=relaxed/simple;
	bh=TQnTfFUs+Mg908nWMV0ruuhsFAVbVHKpN+hUC1L7tUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+YzLvzEyeEW483uyjmHml98U4cET7iyED7jwrwgzqwYX1Hsppe/bR1wUvT6+cboo9eqdnFGmEIqAxbXTzzvwhhnBqtxQrSntbFcQ3KxbamTfLpDXvDbYSlw48CQACxbKZ2xG6Y8DSF8SajL/bsa7hPhymEvlgVcmP4c2ot1Ng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlmsdmuZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759733201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4EVi3IC+VD9OTyIfuQoplPqPl1jhS5tZPWBqrRRN26A=;
	b=PlmsdmuZxsk6kRG0fuUVLZ0mJvsnogAvG89tfI+GGbaezxSMQN6Np71UzD8UPRD2N3m/Lm
	e0UixU+3EW6mjGLIjCtw7nHYjoH5ze158r56ZoWF5+EtK+4ddVTvCjELeEyfrPrRhewfdP
	/ylQoPgsj6YKKT92APAMf1ZPjMGA5M8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-m5Xe4Tj2OImWUa5MZ_jPNw-1; Mon, 06 Oct 2025 02:46:40 -0400
X-MC-Unique: m5Xe4Tj2OImWUa5MZ_jPNw-1
X-Mimecast-MFC-AGG-ID: m5Xe4Tj2OImWUa5MZ_jPNw_1759733199
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso15905975e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759733199; x=1760337999;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EVi3IC+VD9OTyIfuQoplPqPl1jhS5tZPWBqrRRN26A=;
        b=kBT59zRTfCakoKw0UaxpRKYTPDw8+J77++ljx8Et+t11XQDiEXsJRvhkHekWRoUqmA
         cMrG+udFP4q6BdlfcwPJuRolDIxrXsxqRuA+rytJDwBYmjpJMAMI8AFArvHNTL3VOiVv
         1cNgcZLzLX1xnkYbXCjs9cUyI9hte+zujsIWM3IUPYLerqb1K/24vopoDzapXYx2A7QS
         HnZFi1nTt/aDcNsvrvbyiQgoliMufxxre2QAbsLfBluxF4cATgdtUGSdB5hrBxy9LfNH
         2EwmQ3CTvm/vdjn7O3C2QOeV7ZkV3gieEbHoV5O+8aJmkwthteftLkaz6g5TcXMO7tN/
         19BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN3MBxRjvl+BFsnstDwosRUeJGdZTXgPMKwuCboiYw2rnYevsrvrwMzmp/x/ZIPS1uCoTSfVwvfgSAh0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKBBtTmhu1IVz7zUDwxNKsPKs/V773ipJovWaxa9+0rlkehKK
	ulJJhsN78d8JsjODLAXQOYU9M/KcVlkiBO059pl+Rt6cVuUhbMc0ImDirC7im42JQw0/JtfKEZX
	WXDRe3c6ZOzOrmxc8GRFkDvs/aUIbH67ZRJHnfOZa18lSI8+gOefUX4mQb0i0kZXc2Q==
X-Gm-Gg: ASbGnctKD+mO8SHHucmvV/IRcmHiu9isZitXwwn3G98mHmueHbzs53J0j+mhPzkp819
	J9vbSFephaDr/ZQPW+/jfStAI8a3cjU+OPc347zX9LjzbR55IU/76zrYWyNdzHRKLrQPU1oz2hN
	py6O2WImPvH96kOdSyIbxcka517fopIbQWoOeegpy7h43q+VhC5q/2QJsWFBwjCzT3Xd2liQtdh
	rtVCdOx9lK2X/Wn7ofpNONbIaybXO1lO8rM0kCsMPAYT5jh3JH5p9kvslX9WryEWLJODRPRhRg2
	HxdRw3mLmaNTCzqG3BdoWxWrSV/1vS08oXhK8sj53wuAyymvU4IZ9UG1VwQ/kKD3Dp7XJnZgDNe
	w+XL1R9mB
X-Received: by 2002:a05:600c:8718:b0:46e:3193:fecb with SMTP id 5b1f17b1804b1-46e7114680dmr67606695e9.27.1759733199340;
        Sun, 05 Oct 2025 23:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvwz+OXGnsIlk+C8wzDZFDgyJpUrRBsLqCQT5ExdPtJxykmdjWSSQ3rfmlasZacEMy+dxtAw==
X-Received: by 2002:a05:600c:8718:b0:46e:3193:fecb with SMTP id 5b1f17b1804b1-46e7114680dmr67606505e9.27.1759733198968;
        Sun, 05 Oct 2025 23:46:38 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f011bsm19722250f8f.46.2025.10.05.23.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 23:46:38 -0700 (PDT)
Message-ID: <488a0640-9096-41d0-9a5f-34ba5f2a279c@redhat.com>
Date: Mon, 6 Oct 2025 08:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
 <a01588414c9911f2bc912fa87f181aa5620d89d4.1759510072.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a01588414c9911f2bc912fa87f181aa5620d89d4.1759510072.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.10.25 18:53, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Similar to list_lru, the split queue is relatively independent and does
> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the similar mechanism as list_lru
> to reparent the split queue separately when memcg is offine.
> 
> This is also a preparation for reparenting LRU folios.
> 

Much cleaner IMHO

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


