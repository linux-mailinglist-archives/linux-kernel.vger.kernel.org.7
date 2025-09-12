Return-Path: <linux-kernel+bounces-813573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792B1B547DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FFCA01429
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66304296BA4;
	Fri, 12 Sep 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxaAqb25"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEE285C88
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669312; cv=none; b=p1gRY3GQZj/9+G1BIM1T7/NRWYYI8FyyNnNB6v5wIBxuSxhpfy6FdmnddqIEJWhVktD/++CfR5AEjM3mTNKZzmlsO7RogICYB83eTY/Rsr5kdlY5prb0yYXvG82Ge6L644W226N/ni4vYt5lOtGv/3btad3QcdcY+yywwPmNNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669312; c=relaxed/simple;
	bh=R7wEef/jOtkapfSgO7p2ITXCATNnRJOsQw4TC0DTQ+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Li2MJtK3dpgAa9JmP+HT4Nz7SJwu9dQQ9fOc/xwp4Q4+wm0WVHs+5sG1LSVai9JgcK48IDghSnzHXRnE2ojs4A7ggBf88qW/Bt0C4zFQJHb7cMP7naOmyDWysWBE/g5mSGWkv4WtDGmAt4jbYHlgMR+xTjKln9kVuDoxZ+4tNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxaAqb25; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757669309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q7Uh5PTxD7ESGcT6/GtnBW9W4Q4JZO2rqf/t4H/Zr2s=;
	b=VxaAqb25WwZZkaI3bVBE3fJfM0QD1w/c/yt52wmbG0xgmY6m20xUCmbJhWGg2YunXbq7WV
	71Ac54c4fo8ljKyG1vdjwLQlFsePc6dkV7hNgo7q+akNEiJKGM5fiJ0cbvoUqZem47X5EM
	u9QTpP4t18DPLmNvBdLXHJewguwrLzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-IHDfhKjlNCmbdwDyuotEvw-1; Fri, 12 Sep 2025 05:28:28 -0400
X-MC-Unique: IHDfhKjlNCmbdwDyuotEvw-1
X-Mimecast-MFC-AGG-ID: IHDfhKjlNCmbdwDyuotEvw_1757669307
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd62a0dd2so7791145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669307; x=1758274107;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Uh5PTxD7ESGcT6/GtnBW9W4Q4JZO2rqf/t4H/Zr2s=;
        b=q837IlAXdvz84Nb/EYgwd6ZTulHliwU0KqFPcGiGIPaJg2WFTZw70qoGhDkDG2ANgM
         maI4uF5BEY46VqueOo0Ufnqx6khzMoEob9vzgVIMpOsMVXz7WjY/+CMs1Z/7QVNn45R9
         8CmIEgvnpSxJJxpaK7OYpXfYBZeVLhI3+GVE8FV6iJYxl53AhvbVSJ5GniVLK/3lwssg
         WWf6xSq5UFJsKZKh/PPm2o+gHlZHSgCzVWncbDTJ45VoLAADJ1NObE5NBRxAbAVlQl+O
         cY/oOkCeLara1cOdGSIDrIByaVl4mhV1rKONTyHIM6p2JkOmXSCcMl+jj8Y289PBx9wx
         3iRw==
X-Forwarded-Encrypted: i=1; AJvYcCWQFCwCrc0GQ2O85O/4+fjk6jEvZMxsPdzSNAjtmRrlUlFlp8wQyC4z0jqHK38d98Hrzj1ApmMU+hE8bBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4DinorcWBH4sXe8YTJb4iWH5BeN2FpU0epZAOrfVTcGkikaH
	jxoW1gtKFNptQ00FLxnjWjsUl5yHgNCffhlmWUzISlPPgqHsWDqu5EXot1IZqK0KXfs4o4/cYId
	fyI2m+5o1WCGaDADVoSRYBzUFQnHKxaasrOEg9RWOohdobBGCsVOUONAVur7i6/lYrK8d/23s6Q
	==
X-Gm-Gg: ASbGnct+E9CIBlokzpIgjYNHrY0Ft79cVybWqgOFzK7ZGO1h46kzRMVNSgJtj1ip3vb
	+KFbanbr01PSysiaXzN0iSvqhd0Ndc9CIZcc9rvgFv3xYfemZOthpge/vV0rsvcWlrtzfFNBlBc
	O/ljToHRPQSlvJyDYg90Q9h15RvSLDRlsTsRDmu5ZSCl7HYSusr09u04AwZmZ0wvrkM8aQPoXz+
	JVcaOgKNhbdb1N10x6E1VY22sXcr69Yk4lC1D1nV+0/K72fqrgUkvdCyl9MtwzSMZWlubto32xN
	QDnVSW7cDSAqSvz8t/hXhzHJdNIh7cKMbMZuUam/KOMxKp+1Q5vLBg69w8IgxpAi3QdBdnvdan1
	Jp3hLjskczuj+cWZyNIZM9Ej4aqEvLwd3mxpwBJzGm2TC3X7PhlVYhvX2SdtZxLtklmw=
X-Received: by 2002:a05:600c:c3cf:b0:45b:8b95:7119 with SMTP id 5b1f17b1804b1-45dfd5c0dc5mr36986495e9.8.1757669307380;
        Fri, 12 Sep 2025 02:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ5nV58Kk+xJkGc6fU0GXwEXnehySepBoJWxSSaPQdthPtf0Tvw62s50h2qqfl4KIaewNpfA==
X-Received: by 2002:a05:600c:c3cf:b0:45b:8b95:7119 with SMTP id 5b1f17b1804b1-45dfd5c0dc5mr36986305e9.8.1757669306984;
        Fri, 12 Sep 2025 02:28:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607870cfsm6004344f8f.19.2025.09.12.02.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:28:26 -0700 (PDT)
Message-ID: <b6f38984-5f89-4a9d-a905-ddcdbd7510a3@redhat.com>
Date: Fri, 12 Sep 2025 11:28:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: transhuge-stress: fix potential memory leak on
 realloc failure
To: Haofeng Li <920484857@qq.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, Haofeng Li <13266079573@163.com>,
 Haofeng Li <lihaofeng@kylinos.cn>
References: <tencent_CA0C296180B9D75FF6A53D6B4F2130888D05@qq.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <tencent_CA0C296180B9D75FF6A53D6B4F2130888D05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 10:20, Haofeng Li wrote:
> From: Haofeng Li <lihaofeng@kylinos.cn>
> 
> When realloc() fails in transhuge-stress test, the original code
> exits immediately without freeing the previously allocated memory,
> causing a memory leak. 

What do you think happens when a process exits? :)

Correct! All memory ever allocated to that process gets freed, avoiding 
any memory leaks.

-- 
Cheers

David / dhildenb


