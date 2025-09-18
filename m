Return-Path: <linux-kernel+bounces-765582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16548B23A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AEF1B634AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAFF2D7384;
	Tue, 12 Aug 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMszRP1C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159C2F0666
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032301; cv=none; b=cjsghO14rufLvaNbsI7v5QeXqPt7IB2TP7whga6e1SvQnMKBa/1+GpwiiJiX8n3FCG9ATWIP6X+oybXYxkz2q2AaXB6Ojsl4d8I15qe52XyLSu4tUj2sFOk2SyuxcWPRRGK4ftXVXeC0jjMkbR1sZjcfd0ySJJNyYD7lrvtLzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032301; c=relaxed/simple;
	bh=DCuRnIiqwJw4vWxPzd4k0W11x+S9xn/rh2v0FdqiHq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dci8GJg8a+497Drw3iSDClh2Gx+l/ivCtL8SFCOcLuy1I9vZxr/vZ2k6RSDUq4uMYDeZynKKKiUtBZIxeJfJs2ceFVzxJwkL3rgwGW5U2aAc+CovMQz9NfM6c2W3HVjjFA5MQkvnAcK1wGFZmgRe/mzWeY6naICaFqSBUixdSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMszRP1C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755032299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uLgG1VOToCvTU0vQ2PDerMB8RO+pRBAvNmdyO/d/EYc=;
	b=hMszRP1CYoKJASTLiR3gLsBI0mXMa3xqX2o6NAjAKEDnf2rGrOe+DDr02VGGS3Uya1jTwP
	jb85oVzGpOQlSXlFiA4FiNt4UXH9AOW/qtCcm+d8g0OoIq1t+1SkhXYm1TGbw5XJRf2OCS
	O+68iBd+5cG22OmODISMH6MZGmEWuMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-vomGGqcpOOesE9pMVQlB3Q-1; Tue, 12 Aug 2025 16:58:17 -0400
X-MC-Unique: vomGGqcpOOesE9pMVQlB3Q-1
X-Mimecast-MFC-AGG-ID: vomGGqcpOOesE9pMVQlB3Q_1755032297
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7865dc367so2704538f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755032296; x=1755637096;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLgG1VOToCvTU0vQ2PDerMB8RO+pRBAvNmdyO/d/EYc=;
        b=kTwbJ2A0NmxM3UMI9VCO/XCaFzwqLduf4ioVD2JYCOv3vVQjaUE/ZCWP27xVhIAiu9
         L0tPOOe9VjisEd/Vw01lvdpPqVxwlAfLT66UhV7eljltPpdcg0BnNrfSBlv8sVpz1U1S
         XkHBa5395k8qVxDlXBRYdOCpU9zMfwVXn87aGI40BRpbmgS7VkG13A9zfVw/lpz+PCpc
         htYino5wNkUCQdDp5ir/0sJzvD8FMg4zaGpDDsgHTfrK9Aj2Ng6CeV+TqGsCm+WdoDoC
         gFQlxi+MkvOuzv/kUUOcOQtF6DQ0zg/TuAPAAGbPUZ48Yu9mMu1pRstiVn4xKmCxLDlJ
         R3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVR9IL8WctCOEcBQieygHBVLoGbDMqu2kWmaPKrG0s1jp1fQfQZmo/P26KbV0pr+u/V1joF+HntVUQf+14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmuElm07w6rMjvyRrdgFgyc4GxfNId31DXx5UJyeLitrppqeP
	AsVv5FlwQbrY3ad60bxAa8uxpybMw3/J56sGod90kG7JgPs+mySDFLC1NKeoQeOKC7IWXZdx9V9
	DWbDm4VUMm3OmrcPi1XtW5DnCmZ0RAEghvpaefRebJg93G8iHQPgmO/3eRrMS4oY7Zg==
X-Gm-Gg: ASbGncsoLYbld0+R0shM6QhYuTzof7fVZPWnbmwaCLHrwWjfQR0D7a7DaQOCPA0YuU6
	Mxl9ouCh9rDsSJZsA9HT+zKJwOIQMciXZ23tsvF0r84ZuPYOD+mCawkEbwpCmaI3eqPJCpBqcEQ
	EB/GJ/ivzuSi3BF5GTFgkNz9z9KQ5sHkVZE0F1R1ekcVkBKlSQTDaNKgpNwn//x21iKcHolXSD5
	DVLcpyuUZFAXuViTIik0id6YdeI22J5f8la/JNVS56npu4LiqTVUncHnJ6gqOsGKRKLftbUurGU
	HgEBTCpcqRCHzSuBRgxkF0eGUkY3B/vNPEg5hE7mzIziyXtw3cnDtmckGKdTGA/EHrafk6+Br4K
	eWWMSaYcMKlnejQ23gMiPElmCPkw9jSSAxPKrc+H0dRX7mRxFNTeuz30UN+a+qcEASBk=
X-Received: by 2002:a05:6000:2405:b0:3b8:ffd1:80d2 with SMTP id ffacd0b85a97d-3b917e465abmr240561f8f.24.1755032296523;
        Tue, 12 Aug 2025 13:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFus9+PSGOYma3qAIBPvbqxlVjhulo3axCz2Rux1VimjwnzUeqE708H1Yik5XMuzNAGjgNRLQ==
X-Received: by 2002:a05:6000:2405:b0:3b8:ffd1:80d2 with SMTP id ffacd0b85a97d-3b917e465abmr240547f8f.24.1755032296092;
        Tue, 12 Aug 2025 13:58:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:cb00:c425:8b4b:d9ad:eee0? (p200300d82f30cb00c4258b4bd9adeee0.dip0.t-ipconnect.de. [2003:d8:2f30:cb00:c425:8b4b:d9ad:eee0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf93dsm45534645f8f.27.2025.08.12.13.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 13:58:15 -0700 (PDT)
Message-ID: <26a947b7-eb42-480e-9b17-3fb819ba896f@redhat.com>
Date: Tue, 12 Aug 2025 22:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>, SeongJae Park <sj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250812135225.274316-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 15:52, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> No functional changes.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


