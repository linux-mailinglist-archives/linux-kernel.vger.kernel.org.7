Return-Path: <linux-kernel+bounces-848420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE809BCDB47
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51EA93562E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A782F90D3;
	Fri, 10 Oct 2025 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCEOFaKG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6A2F83BA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108711; cv=none; b=R5K/+n9ORiBqe9caqkGxpSMLUQkrjbUPSGDX0ZQOFInRUgD6uDlSVLfisybfBgJEOpsqwe1WlqgTPOD/2V5CswmWYFTdp89LHLvfqZ52qgKpDHuPOAxnlqBprk2zoM7XG856JxZijQcZObjmtLtiP0md4MtHg3/HVi1SGXVrMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108711; c=relaxed/simple;
	bh=cGGzf9hN3EGKjgIyz3nrHIYTNGgrUsMbns4BgkbDuv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bhqvys+qBA0GIf502HfNyrg9ZywqxzImkHa0saTZFPtkOamQsYEC4V+FV0MHqf7EsvxTD392Bec9RGqyd474vM6JdW3U2lxoHp17jP7gbi3qhVQu8u1QnkPIZnZzpPBg6vO70If44bFLRaZvVu7TqDc/N2tXKyV7DXgRRvWfSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCEOFaKG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760108708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=14x8DQmV6z2ehBA4LIP2D9xCeyvVVgYWSqxD44RO2o8=;
	b=MCEOFaKGAA3dNT1Q0KtExeva9KqJbWyfpaW/PUP0elcfx5RNYEe/goHfdsu/GxEsV8BeuU
	MvVplb52T7ZG20Q265RxJQa0NE2ngvap2v6vNpt/jJzWXAlDjbsBA7JtXAKPS/tmDcM5vg
	BVPtPYSFs3GZ8szfpcBV77u3BJ4KH7w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-fVvYwFRpMtesd2hNMSOq9Q-1; Fri, 10 Oct 2025 11:05:04 -0400
X-MC-Unique: fVvYwFRpMtesd2hNMSOq9Q-1
X-Mimecast-MFC-AGG-ID: fVvYwFRpMtesd2hNMSOq9Q_1760108703
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3efa77de998so1952568f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108703; x=1760713503;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14x8DQmV6z2ehBA4LIP2D9xCeyvVVgYWSqxD44RO2o8=;
        b=Q9VOCWaeUcDR3ajUidZZuMpMm+Zj+2/mNdvYs4Y/katVroprgxagdOWS9mKw+UYt3b
         oqG99K2aslnwpyip2YSOR/1jVMqojE8ZEWHTswhEzn3jgO3hFg/LW37F5+Yj39Thg4eN
         kdYhg80C1jeeCvaY29ESa13J9B6ptQJEIvPdAQ1Itd0SQgxW8l4x0lk9ZiuTBMitcuc0
         aKhiKZxJ9A+83ObkSxSpuhAEskTdKT/tSXJQKkOQUmmWZI1Ux2N7HGB+r73voUHR41fd
         iGPqbdgLOxKOXgFXtwLtXB6y4MBvXAExtLYeubdkwdZI9jA9UzhZrWetGUrVuke3PAwf
         EULg==
X-Forwarded-Encrypted: i=1; AJvYcCU9VCt+M279KGh12/1KpxYEbri631fSev0jtYzca0oWomC9ZWepzL05lq2OyTaBi8iexbPH1RScyMzXvSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYDx3hPKfYAazSLnZMI7f7lp5cV2/4agaT/iH8GmwLRMbba8H
	xSSDFf2BfGg9OVuQAB5QX6CwLCf6ct5ZijnH5RC1rndCgrTiop22+eM0bRCme1I1czyqKG8Wwja
	B+9rpn4KwY20NTze+J3o+Gp7hnD6UhQ3R1ZS+1sGdsfLM7EmVN1EM2AGATuCnilZI6A==
X-Gm-Gg: ASbGncu+XfIZ+VmnUi9WeVZjzjJXmD1jQwTvsVF/T8tCw850OYUkjkpOUW6XjEahzgx
	tkZveRzgdbUEp19ZbYwnf9GWpPeZ9A5vJ+X//lIqeWXBoXdY72Q1e97wSOuALXk5S6WT3e13u8i
	hejeGQdWBKlEqKwxSxBxnbCZ9kO0rKX7sFhD31uN+8loB/YI4OIynFb9yI7juO9uoAo0ilcm5J5
	DeeAO4xnIkwEXHvdv/HLJFolDUPGbF6i30jcBgiXF+9vSQFKjldSSQ59Tvbe3/2E/z/FoMcBfKe
	n1/MIDFDxy7scGP5v4eX5sLqK0UrrZjufcy6Ld2UkUKhJ/4fc8LVH55K4aNxuBxGZb/0tn2WDXi
	P1JI=
X-Received: by 2002:a05:6000:420d:b0:3f8:e016:41c0 with SMTP id ffacd0b85a97d-42666abb540mr7265834f8f.10.1760108702259;
        Fri, 10 Oct 2025 08:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdAL2XeniwemES/tB1DQlU4huABJjIG2OWey2XifuXvcbLTvo6OdHTiDcsvIO+vABjUKKRDA==
X-Received: by 2002:a05:6000:420d:b0:3f8:e016:41c0 with SMTP id ffacd0b85a97d-42666abb540mr7265802f8f.10.1760108701605;
        Fri, 10 Oct 2025 08:05:01 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b44sm4575185f8f.16.2025.10.10.08.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:05:01 -0700 (PDT)
Message-ID: <76daa3ed-4f75-494e-ba3e-0bfcd7a367e4@redhat.com>
Date: Fri, 10 Oct 2025 17:04:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] KVM: selftests: Create a new guest_memfd for
 each testcase
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20251003232606.4070510-1-seanjc@google.com>
 <20251003232606.4070510-8-seanjc@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251003232606.4070510-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.10.25 01:26, Sean Christopherson wrote:
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

Do we have a Closes: link where this was reported?

> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

-- 
Cheers

David / dhildenb


