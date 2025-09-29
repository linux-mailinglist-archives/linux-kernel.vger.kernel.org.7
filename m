Return-Path: <linux-kernel+bounces-836011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A56BA8933
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087007B3E66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4C7283FFA;
	Mon, 29 Sep 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkpNUxzN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4E277C8A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137490; cv=none; b=SGbZrXxSqSbJ+VNtD+gpFHHKZstLfgo8Kcxg+XDOT4dye+VHekOkye2QwzB1lFNXo42pmAq35ENDeeB+J9BZJoq4cnJ1XQ2XvxfMhNTve99P0pXFCiQO85TJIK5QUaOdhuD6zUCqFprEP8Xy6WYiz7XQ0JbR0pWheBuGrHApoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137490; c=relaxed/simple;
	bh=Ks2BBBzQqjGWEUp3vTQtsltYJN13fV/jNGcOycVGv2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfkiRfoOzBbQsLzh2blRWxGml81qG7TQaulxpXl8zDUJFGWLb/11CQXaUTUE+Yqc3gpuW5agIOCYLLozU5EV7MLc9QmgvLqVUulgdMynS+t2aWtjh6ozBKWWHXnGmJz1ag6w8GycAiRV2IcR7rS1XK5xpd6dSs2R+HzUKhg1OYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkpNUxzN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759137487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vk82StvtzuvoQmzBkr51Z9nRoIXejYH8Zn9Ho/zzzFs=;
	b=MkpNUxzNfQ+8uLKu9LHNwjOlteMXoMTJ84pxvC7CtjiQPf83cdFYOW1Y3VbO7Ll1rt3w40
	sq211VeoBs9HL0UQqmkZ7cbuwl8xmJ63ESGJI6kQqR8kqNhCRnfMfkohqhxT0CEyxqjNBh
	oIY3YjYyjq6csxmCiVmGJzqhnZ4mWQ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-0jktKYBZMOibzCH-StmkvA-1; Mon, 29 Sep 2025 05:18:05 -0400
X-MC-Unique: 0jktKYBZMOibzCH-StmkvA-1
X-Mimecast-MFC-AGG-ID: 0jktKYBZMOibzCH-StmkvA_1759137484
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so2329427f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137484; x=1759742284;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk82StvtzuvoQmzBkr51Z9nRoIXejYH8Zn9Ho/zzzFs=;
        b=C76xDAyEcdMQScZBEm9TqkSS29H/UO81XHtYG9cCMgxBOJM5ql5FbGDaL9WEXJv4Kj
         MQlwGCxMuX2QBvgJra2w56fcGr1Yfjjdd8Momrg63v7RI6Piq7NhpJQc5G+JlQHIdn2+
         RogShoMcBZcIn500Hrkgih2XpnnTK6KXLG8LfjDN0LinRkKSd51J9l03u68YPjTig1By
         kK4HE2tgWr+3018Qgxw2BWF+8N45XcyvNtSETSOPZnRrKi/Lbymy1zR+JkYx4E/XtWpz
         sCXIFt2vkLHh1GG9VZiNnJ+7s+CLPOcqtNSc65CXeTnSXy3cGb4h7JQRMPhUi8Y0K6eb
         UVWg==
X-Forwarded-Encrypted: i=1; AJvYcCUiX3mjKJzPAAWejv79IGHUN6M7+PRjig+OPalXFsZlj8pyPgggEGyzuuoIk8rvMi3XBCVmHCVVmy+N2Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhLuMcwtTFcsefRGrTeMV8mQiGJ0nV3JHYwZtUoeU92A5JYk4
	27J/IoEDu+oY8zW7JtYS7CZs5lLejhvigxTotz7/RDCI0kVPi7RuXPM/veIPASKcMV0OGpf1v1V
	AEvoTVYuImtWguZX6WfwnV8pnh8r2K/+AxBAuT8jlgch6vu5sSGX3umL1GHE9YifNKg==
X-Gm-Gg: ASbGncsJMHlgXpYNR7LLTzfm37obC8Ap3ptZhzxFnZfyt5V9w0Ddxt6L3zXa4VnpOqy
	CnrsNEqgdJZy7iTc9jH77fXo/Oh5fXH80cF5mo6ROwpL49CC36Nuomm+TMqyHc845L69WVD+Jwp
	puY5tcmFeC+y3Ti2P5dqDNeIjwKxSh6KqrH52U32ZZYjUNx26q6eFJ0WY3gaRDHXRrY4EOhsJxR
	mo+/VZFhuWMttfC5lUgI8tKpkz10T3bIVYKMoMimcg+Iqj+qKikCI1SRHsZsP5xUqcEdcoXOshk
	qMS6UPE3lm1mb5lzp+fo5SGV2PWdLAUAeeiWO4eiPYwkQJ4Nek3X8XPveFA7Q0WD1yOiWkY8w0q
	oHv9JyzXqNTKr9zWBT6WEye9pacp5m0veJxVkrYwuNZbiVdw2ELU8tZ0HnX20nStJOg==
X-Received: by 2002:a5d:5d03:0:b0:3f5:453:77ea with SMTP id ffacd0b85a97d-40e4dabf28emr14251790f8f.58.1759137484480;
        Mon, 29 Sep 2025 02:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXlkIee2EP6cCZceUObBZoMhwWwE2P79HU2Td+9p0UV2c9KpI5Byo6/WYxtplqGTOY5+qGuQ==
X-Received: by 2002:a5d:5d03:0:b0:3f5:453:77ea with SMTP id ffacd0b85a97d-40e4dabf28emr14251773f8f.58.1759137484049;
        Mon, 29 Sep 2025 02:18:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f05:e100:526f:9b8:bd2a:2997? (p200300d82f05e100526f09b8bd2a2997.dip0.t-ipconnect.de. [2003:d8:2f05:e100:526f:9b8:bd2a:2997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb871d051sm17855205f8f.14.2025.09.29.02.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 02:18:03 -0700 (PDT)
Message-ID: <59730bad-4731-4c25-838d-9dafee1c6c44@redhat.com>
Date: Mon, 29 Sep 2025 11:18:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] KVM: selftests: Create a new guest_memfd for each
 testcase
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20250926163114.2626257-1-seanjc@google.com>
 <20250926163114.2626257-4-seanjc@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926163114.2626257-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.25 18:31, Sean Christopherson wrote:
> Refactor the guest_memfd selftest to improve test isolation by creating a
> a new guest_memfd for each testcase.  Currently, the test reuses a single
> guest_memfd instance for all testcases, and thus creates dependencies
> between tests, e.g. not truncating folios from the guest_memfd instance
> at the end of a test could lead to unexpected results (see the PUNCH_HOLE
> purging that needs to done by in-flight the NUMA testcases[1]).
> 
> Invoke each test via a macro wrapper to create and close a guest_memfd
> to cut down on the boilerplate copy+paste needed to create a test.
> 
> Link: https://lore.kernel.org/all/20250827175247.83322-10-shivankg@amd.com
> Reported-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


