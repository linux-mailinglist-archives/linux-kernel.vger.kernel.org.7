Return-Path: <linux-kernel+bounces-898170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911ACC547D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43EC3B3621
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D52D5C95;
	Wed, 12 Nov 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrTi6FfT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsLzctYT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728EC2D249B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980046; cv=none; b=KDZRG6J13Xfuput2TYRg+ohv545/bXlBJZwLawpgb8/Ah/WZVv3Rue/TI5hJujm2sJOjIiHyFvfpio10RqreLjzmACznL/q4VAcWtiPTKpabnPGrVaBDMlyVioFgg47Gfm4tI4mxxUdPUQla2KZZkKcDvE1/S94/rVGo8NXXS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980046; c=relaxed/simple;
	bh=gxTTxN3L7EVSOLksgiMzU/dnG2DI65ToYH4gH8GtPZo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gPYiNZmQBV8BMYTNGRND72j1yaHMJ8XIn38iWMB5j43ieLGx7yrg6QeRHWB8Ruu0e6IRp/bfXM5VDDRczImPFaGKnoAfpkW9X7zkX8Uskk2j/fpjOxVwYWNOb9zAqgsH+q3znf3+xal2uZ7slDCLkUD3xDlH7mmLGbWg+H9ZA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrTi6FfT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsLzctYT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762980043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meTvyP1a2xRSUJNa1PfofZMtKBX8/Zwm/j7mPyqIJIw=;
	b=GrTi6FfTYRH8boeyfoEsh7QZbBdOO5KDe4kkgszWET5+ho80ajvYKAPo4B3DLoXiYYsObk
	aJjVlQ3fv5EOez2rXouTz5eyuKSzZXNuOzoAh1OXKw8l0aAI5HsIlaJsWLd/EIG6QSy7M1
	+BVtFkkfHrLs000w2TxhdQs1r5sAFKc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-GHPKtTifOFys4DELRB3ctA-1; Wed, 12 Nov 2025 15:40:42 -0500
X-MC-Unique: GHPKtTifOFys4DELRB3ctA-1
X-Mimecast-MFC-AGG-ID: GHPKtTifOFys4DELRB3ctA_1762980041
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2194e266aso38883685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762980041; x=1763584841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meTvyP1a2xRSUJNa1PfofZMtKBX8/Zwm/j7mPyqIJIw=;
        b=SsLzctYTA0BU1t5Y4G0Re1ozeVJAbWrUp7BS2Aa9CBYcx5uTdhHpuIRLOceCi6OeM6
         z33sIaSte+mFW6MxUGwM1tvKBP0YqV8XHYfrOc4bSTnmHj8DHSTQ1H/m3muvAW0gvcal
         F3Pvlnxvx/hWDcxfnqGHxBRstWbzGY1urW3h9jRf47N7FeC9CF6o+xc8lQD3AHaXlxes
         asAielNXP+Kynb7zC0iEGaA3hKDPFXWye7mo1wwz8aJ6kqhhEUU4u1eFJLozz8nR+3eb
         kVjEOaHCBIchcXPlDLAmy+JTDeIwb7u6IqZft+IQGiwIE8OKMxlErvKqM3tNc7IislaP
         sxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762980041; x=1763584841;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meTvyP1a2xRSUJNa1PfofZMtKBX8/Zwm/j7mPyqIJIw=;
        b=K7oZfa5GYUg1d8ZSxX65qeQARIY9y7yAUaAD7KNvv3ZOBRJKWwPU3uHH+LWTWwmt3y
         lyQTgapJ3gnSOol50IGY8QLXrEyXOnrvye+yUOCe2uMWXB3LO+4YdnflhZI84gkRy+gO
         NuLUOiP84iq5RXuuAU6MCo12VQXO+V8bKsLCV4dWxtxIYjRXNApAJE5DIL2xHhIFlr1e
         AZG0/xjgJxopCrMUqxg6T20jVT7r7qlcGw4aai5Wui/8kOqI0yUDKw7nCx7uDXFbN4xj
         t7smbDXCdupyDZhvDJqrnXnjSoQsECKg9B0XfTak7OCIQZHFRqb5tKNmLhbBNBsW+Hd/
         I1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN7fyDMYcFkxxRfLBlkBekAjdimxt73WIL4I0t7y/UjdNAKW9G0+P50fqDwDIy8iiHjBKbKAaSBpqUf2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCU6HiCnKGRr0rn/9m+4zDBBsZ+9pU5nGbyEPlZ4nV8sb2IN/E
	qulTIOp3GjFaRbeVQYKD2miFaPhw5XHlfiMGfe/BR2H91LN6741ru/fL0fCoVHRS3ItN0eO9Xza
	qxPUugE4Kq8xhpX+t0wizY36Jtcj3OkrH9LEjvT2HXoe5H2HCLbjDE2i5UqYuVPubItxLgs3gYg
	==
X-Gm-Gg: ASbGncuXfAOOM56Vv1R11FEDKQrh3qaGF/X3f8Sew4UGXWw9bnUdXc9L/zIqhPzZfG0
	AbOruX5QZ2vmUi6D1IbAkLTz+T9y7kcbMlfV3670XWGLRnd5z/eiOUAhJJLb2pCIqg5rovhvmgA
	VfK0PERc8+70CAF1aHag6BK8Lk/ivDrRoTCJkNC5BWkXXBsMC/c3YwZlg+McQZwgvZc2ht9BClw
	oqsQwU3QIXJ5JhfggN904mhaTByX2seglQV4oMpWwjC7XQjt4Vvz6fw5fSkSS5Bqz+U6oPlwzjN
	UUEkrVCxBCOQajHAvjAoQ30gpKwIqrnjSszTN/hNCu1VW0pt3szL0jpz5ZfoVBO/Z5/wcgVEUIL
	5HRP8PWT4i8MMOeb+n848S6OerNCw/I8HvCw5LWP5i2W7ew==
X-Received: by 2002:a05:620a:4153:b0:89f:764b:a4aa with SMTP id af79cd13be357-8b29b76cb4fmr601023485a.18.1762980040901;
        Wed, 12 Nov 2025 12:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESa0cF9mOhl/LFwYPn0m7Z03bsgMvByXtJS4tECV4yQpiTHl+tQlSjtmEDSnxUdhU37GsGmw==
X-Received: by 2002:a05:620a:4153:b0:89f:764b:a4aa with SMTP id af79cd13be357-8b29b76cb4fmr601020485a.18.1762980040481;
        Wed, 12 Nov 2025 12:40:40 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa22f51sm257239585a.51.2025.11.12.12.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:40:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <95f36634-d4d7-4d47-b949-e34b6bb0cce2@redhat.com>
Date: Wed, 12 Nov 2025 15:40:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/22] cpuset: introduce partition_enable()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-5-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-5-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Add partition_enable() to consolidate updates to key cpuset structures
> during partition enablement, including:
> - remote_sibling
> - effective_xcpus
> - partition_root_state
> - prs_err
>
> Key operations performed:
> - Invokes partition_xcpus_add() to assign exclusive CPUs
> - Maintains remote partition sibling links
> - Syncs the effective_xcpus mask
> - Updates partition_root_state and prs_err
> - Triggers scheduler domain rebuilds
> - Sends partition change notifications

Could you add a leading space before '-' so that the itemized lists 
won't look like part of a diff file?

Cheers,
Longman



