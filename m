Return-Path: <linux-kernel+bounces-756468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA8B1B4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2697A188327D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA9C27144B;
	Tue,  5 Aug 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4B2Behz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23C1DEFD2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400000; cv=none; b=ancwdebbOqCNGgBlzH8HE5OsQsAioa7S9iHQLknkZjlj5FWTWi9SR/JmxQvgc4lBpQ729Ge3s8F6iV+z9gxApKeZzLqGgniwtEP7ZrZCUYCGasnmdCir6H8L2KusIuQB17aohoPtzuLOY6TZHSRKMg+Q4Q/tQBfheyGKOJo2zuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400000; c=relaxed/simple;
	bh=PKrXlMD6bPKL69+EGvWl5bYw7FjNhqXfT1LyQnmlguA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CS+hu6wDR5+57G/2w0k7MnSkbjPK9z7aevVibJw3ilBLRuCP/FnuegHqOIno0aMuAhSfrmsG+J8uwomnBdb1cAIr1sbxsG2JoAYtnr/e8Lexm6z/ssX3Bh1TQjUTN06auinI9d8Rm/i1ob0aEXI6mdscIwdhyIQyCYhYdHiDnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4B2Behz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754399997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uKjHUGrsDWlIciXXBKpkmJIy9RB8Dvha2GXqVYZz36M=;
	b=R4B2BehzVD9niIWJafEsAs5LpTxpYzPDtIQ20bSfU+tNLdUtArk9h4AHuT8k4DA5FxvCDV
	XL9i++6vHYg2j4NGtw6F1j+YCNG72tmpd/itjNeJNWITGYT424066DfhmahqRYAO0vECU1
	OudSOY8r2VodlgMlzIv+UTPxADBLk0k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-cdjSfyAAOsGFl0HYgsr1QA-1; Tue, 05 Aug 2025 09:19:56 -0400
X-MC-Unique: cdjSfyAAOsGFl0HYgsr1QA-1
X-Mimecast-MFC-AGG-ID: cdjSfyAAOsGFl0HYgsr1QA_1754399995
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459dfbece11so7482315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399995; x=1755004795;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uKjHUGrsDWlIciXXBKpkmJIy9RB8Dvha2GXqVYZz36M=;
        b=DHiRb0uqHwWQNMV+Txk0EDjNtYzBRbppDzg/1t6rnQGUWLbMbmXDPc6apdIvk0uUCx
         s9jhOsrISdzGGQe2pLllPuUE2ort8NOllpC65we2ZnRfXBVJo4AWXyM+labxneltigeY
         mM2eVPPyI4AWSWUXljtQJd9cBggQ+DCgMInHoDuG0T1piRRjDirPAnSn1PSEK4SfJBRe
         zlCcjiEHncPO4pdnMB8aR7U5eGTZ2Ga8UYtVpciwxQBzjQhklFPGyQKZYwL2qCL718V3
         wRt6XKA1Mjgqxlagjuul8PZGi6SD5Vhe35V4j2+q9MIuHsTh5ziSFmoDLCyUwXlIEHDA
         EQXw==
X-Forwarded-Encrypted: i=1; AJvYcCWXtlRbXTepauZ06znCQMZybohlqXYneo5/OU/Q4aL1dfiuugfY4tq+ahguqDGwVaAC0vuxFlFeYFtPcvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpmFanYsH/5xvbDzEBRzhSIbC2dDpgkiCYrZAXrwFiv0fdzau
	IKt5GsoYhy0EJGL2AGK6KVNFnFy0jJ0YbZOxkriWHqYuijlbryURGLaLv2uRRCLxqBDIt5PI8EE
	/QI8aqyxCmrJXott7uoZRxQghseN/W+LBjuLHpdonWYlqUSwhLCQr8PY0/Jvrh/8gvw==
X-Gm-Gg: ASbGncsMkwbbWPQon46soQNAYDgr9+T8FTWxw8pFQ/jdO3Z+CALGqmuGeXwow93SKxP
	rPsZuM7pMhUHrTFAWsmWAY/j3nrI5wASxFR3FI/je+F5b1h+lTbrDUtY0x3Bp0NXH0Kt20Armml
	LiA4d4CROjbHWBBNDC2uaD3mxwUvPG6xCE6zBOJZhRVyB60iynaufwNUV7InKIx+zcP624u1zNB
	KJFgT9XzZhQIb4bp5pH0BbVNHbQ3Xj2u8tDXQjBLYwoPfR8L5FhV4ZnHDve86K6lEc+8PoiGOC1
	/9dMg76XggAq812XKW+80MHXshLdusXe57R5mbs8WgcolMho07g4JKd3C5LVy5jli8X1PbU=
X-Received: by 2002:a05:600c:a02:b0:456:db0:4f3d with SMTP id 5b1f17b1804b1-458b6b4360cmr89319795e9.24.1754399995161;
        Tue, 05 Aug 2025 06:19:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxZCPdW4jNomcdv1BA5ieX82ZUHfFW5uQbqMAIV9lXfOD/QDV5r8VkyXPFZChi+1svMDTl9w==
X-Received: by 2002:a05:600c:a02:b0:456:db0:4f3d with SMTP id 5b1f17b1804b1-458b6b4360cmr89319585e9.24.1754399994765;
        Tue, 05 Aug 2025 06:19:54 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a26f.dip0.t-ipconnect.de. [87.161.162.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0683045sm9568169f8f.41.2025.08.05.06.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:19:54 -0700 (PDT)
Message-ID: <3d0c1bb9-2f85-4d55-b5ab-40a4ac9bfffe@redhat.com>
Date: Tue, 5 Aug 2025 15:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lizhe.67@bytedance.com" <lizhe.67@bytedance.com>
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com>
 <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <20250805114908.GE184255@nvidia.com>
 <9b447a66-7dcb-442b-9d45-f0b14688aa8c@redhat.com>
 <20250805123858.GJ184255@nvidia.com>
 <db30f547-ba98-490c-aaf7-6b141bb1b52a@redhat.com>
 <20250805125643.GK184255@nvidia.com>
 <a18a9b55-b3f0-466f-abc8-39b231c04bb1@redhat.com>
 <CAHk-=wiQ=9g=+A8LPWhPj9yRXFzf=tJKw1Cy-wpj1N9FKu-65w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAHk-=wiQ=9g=+A8LPWhPj9yRXFzf=tJKw1Cy-wpj1N9FKu-65w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 15:15, Linus Torvalds wrote:
> On Tue, 5 Aug 2025 at 16:05, David Hildenbrand <david@redhat.com> wrote:
>>
>> So I don't like the idea of micro-optimizing num_pages_contiguous() by
>> adding weird tweaks to the core for that.
> 
> Seriously - take a look at that suggested sequence I posted, and tell
> me that it isn't *MORE* obvious than the horror that is nth_page().
It is, that's not what I am talking about. I was talking about proposals 
to make it work in a different way as Jason proposed.

-- 
Cheers,

David / dhildenb


