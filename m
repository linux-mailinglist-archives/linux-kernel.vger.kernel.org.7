Return-Path: <linux-kernel+bounces-763349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91235B213BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049153A578F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03292D4810;
	Mon, 11 Aug 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atOtRgW4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423C296BDC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934878; cv=none; b=NDWaldO2UPfc4dwnbmLaOkRA5qDmNg9tf4p3R2QwuMZ9BpqRzfACiAauhBjedixSf9fUm+Tcn6UCFmdYfcuac4BZhkyWvRSpZM3aFA2NKR5rneYJcc98E00yARm60WLHu8YP46WCEUmQceK9ubJXjjioqLKCc6Hptbi39xwpmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934878; c=relaxed/simple;
	bh=MrJ+jFM/qeE56lAaauXKmVUo66ueYOU0FMzuxzqgLLM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=MEWhvTe3dqTopir2dX2jKbMUdw9Ya3JYt2nEPLkbMeRMpGlWKUuXG4/OGVDW2wgDKjYovNIE/mHVwf/zQYrQtez53qOgxi4PXENj/C5BC/pbS16Qek6Itq4pXiIDPtDDdf+AHJ+q3RbqqRKHTFNo+XtYo0AXO9dZop2GhB+zHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atOtRgW4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754934875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=9om+qqO8G94oegS4pPBf2LrGuOs9ErV038pUk+vcwMA=;
	b=atOtRgW4OqjdbamWyBy46J4A2yZ87DZza2MRNmcvh79T/M0dkmr58fQso5sudlNJmSqT5s
	pfjhvsfGHyWgZDajK+iEOiDxa7WzKeYrWxb4lUdyzo7m3l1Wcl2C0/dkkKCRGy2VMmLMAI
	dRLcYaWnO2EDodfqMq/j/Nodqh3VF7o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-5845_O0BNZSv1W3Jf2vYGw-1; Mon, 11 Aug 2025 13:54:33 -0400
X-MC-Unique: 5845_O0BNZSv1W3Jf2vYGw-1
X-Mimecast-MFC-AGG-ID: 5845_O0BNZSv1W3Jf2vYGw_1754934872
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7891afb31so3446637f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934872; x=1755539672;
        h=content-transfer-encoding:organization:autocrypt:subject:cc:to
         :content-language:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9om+qqO8G94oegS4pPBf2LrGuOs9ErV038pUk+vcwMA=;
        b=PLKn1jdZSd2WEeh6qoGAfII1yRJrKPAvTNNspSW9lERx0AV94MW4i9yaG11ANDtGpR
         WL3ek1/550tc0mWbN4IV68w0+k1ZzbZ5/n1dIn/kk5zhDkkw2QkWjT4BnQuSoZce/9NY
         q+tElda/4SYkh+ArHyaodqgRoYK3siTX/A25I+E6cSS3psDEGqinXBmb/XUV5W+5N8hD
         oT+plsrBdNRVAQKYcYmlWdkOctkZxbUtl/oXNred3qlZLkxi4aJGqLLSYXgIaZvAL4x3
         Zgx1YTR0x12inOZ88twpIUW8ASPKcRcJT8kS8ulJ+jtVpmdaZHulkzgtOTVj99ejPqIE
         M4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9OUA+ttGK59HUiGJt2awZ7C2uOlrmU6ulFKGJaf7j8FsCCqNhAB5WFFYef0Neg7UR31BEKXDUq+MZZbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzboZWU3jJ2tg/rywKgPzbkboSTnxi1bPjKXgOsIiLD9k8br/RY
	2E6DCiT4Si0h2aMAovd70Oz4P4cqTmF0/BTbd/ubWTl2Q/FeKzaSvYOTTKIOQQkcqCziCOZoSyU
	T+ESgfNWJD8/JTqHv/2uxivUnYq1ZoOqro+AfRS3hshYSZGR9E+Vjs9rs6X7zcTr4M3ywyOgkKG
	hZ
X-Gm-Gg: ASbGncuZIo1TtnMaCXllLMg4PGHQF8wrL44eHdF4gG3bbWqLwcepglU+EvO9cWCUw9d
	HzmAXJbes5BrhC5tQq4zEOP2VcPs2vHpQ9t6a0cDTIj248CBORacEByZhlkMWKSrZkOExSNo4Lz
	OJ4YMVHise68PenYPRDsl5OM6js4tyE590wphwF+KP8j0Z7prIZdXOt1vbAnCltdyMmRmXMz4Nc
	IT27HOiDIzpNBpMjSl3O2p+QpPchBU5dFnVa5kjneEeC8pcl+Jl544NCBIcOVD4HnI+HVU0Y4/k
	Y1BusptJ7dzoNvrSkyIgA8r2UQ3t5wWXd0lizJs+Mtyc/1Zzs145uMsa5Fv2su49GFWNLEX+2Ek
	51ubcmBcqARdq/neBpQ1bTJ1FEr6Edj75alcQ5EzFkQmFvU3qbA7Uh++QuhbvwPamTzc=
X-Received: by 2002:a05:6000:40de:b0:3b7:9350:44d4 with SMTP id ffacd0b85a97d-3b900b49960mr11535138f8f.11.1754934872365;
        Mon, 11 Aug 2025 10:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUrZqJM8lPLbvZNhW2crgDKNR3EikOOGR0IxCBJv8fwqNeUnk26Qg7O6HdkMRGrEmcbXp7dg==
X-Received: by 2002:a05:6000:40de:b0:3b7:9350:44d4 with SMTP id ffacd0b85a97d-3b900b49960mr11535120f8f.11.1754934871895;
        Mon, 11 Aug 2025 10:54:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4d02sm40242259f8f.33.2025.08.11.10.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 10:54:31 -0700 (PDT)
Message-ID: <284f04e0-6555-4469-93b4-fdfc0dc7b91b@redhat.com>
Date: Mon, 11 Aug 2025 19:54:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
To: "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE/CFP] LPC 2025 Kernel Memory Management Microconference
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

we will have another instance of the

	Kernel Memory Management Microconference [1]

co-lead by Matthew Wilcox and myself at the Linux Plumbers Conference
(LPC), December 11-13, Tokyo, Japan [2].

Due to our past experience with remote presentations, we will only
accept in-person talks this year, unfortunately.

Topics we are looking for are pretty much anything that would be of
interest to the Kernel Memory Management community.

In particular, we are are also interested in topic suggestions from
outside the core-kernel community (user space, drivers, architectures,
...) that would affect memory management in the kernel.


Example topics that might be worth discussing this year include:

* Making Transparent Huge Pages more ... transparent (toggles, policies,
   khugepaged, ...)
* Making (m)THP/large folios a first-class citizen in MM
* What other improvements might we see from mTHP?
* Where to use eBPF in MM, and where not
* Ongoing challenges with memdescs (e.g., allocation/freeing/walking)
* How might we make allocations guaranteed to not fail?
* Which CXL use cases do we want to support, and how far should we go?
* Challenges with hypervisor live-update, and the integration into other
   subsystems (MM, drivers, etc)
* guest_memfd and the interaction with other MM subsystems (hugetlb,
   GUP, ...)
* Making hugetlb less weird


Please submit your proposals at:

	https://lpc.events/event/19/abstracts/

and select "Kernel Memory Management MC" as the track.

Please submit your proposals by September 30th to allow us for
planning the schedule on time.

Note that a microconference talk should provide sufficient context to
have an open discussion about the topic presented. When planning for
your talk, please absolutely leave sufficient time for such discussions.


We are looking forward to your proposals and seeing you in Tokyo!


[1] https://lpc.events/event/19/contributions/1995/
[2] https://lpc.events/


-- 
Cheers,

David / dhildenb


