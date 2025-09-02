Return-Path: <linux-kernel+bounces-796935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3AB409AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8863ACD58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005EB32A3CC;
	Tue,  2 Sep 2025 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFilMg3d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC807324B28
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828102; cv=none; b=IPQ1fO/sdDQsnE5xYOakxOnO4GdUcGrer/1F8vg0DgLkYMKoUIUxDJTK/xOrVarw56LnrXuatiVvkJK9cOHNuR+J/UxvBlK0QAjMq6je526lwtkt8hcn6hWWpsiFN0ar+L095p2hBO4Sl9oYYwFuhDUyJhBnIGmsapyuI5obXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828102; c=relaxed/simple;
	bh=4z2rRxRRKYAs4qazUSn1yuM6/TlYfm3hqQtQ0M1ZIls=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fMIMN2aSMxRWMzNjjqyr5gIv6s/bKE3HnONmdZZ7iQTXdOE186IxQsiTX1Mva4T4/qNeCMRm3Cx5iMXOULZEljU9i6coDs88sadJzWDyq5hbsyit+IMXPCvNSvYmGc24ZqA64FtfWeKDrT4vP3bo2veNvqCVD77ApY+pxn+3rFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFilMg3d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756828099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhaCe7UWtAErc1tHpsJG+msaP+N2Pr3q6msa7c8CHQo=;
	b=MFilMg3d056R+8xRk6WkJAmKrJm7gLir71adoRY1RLwcXfxRQLcSj8vgmw4mdrcDJUruaS
	4T2qU9RYmAYa6XpqM2AEHKqQuiOIJLl1HtMaEyA+hjT7gOpf6SDYcoc+pXSw1sFFn5kdTf
	if2fMg8iBUPP9WhGqjgW+i7EhRIoyV0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ig28QuHDPrC9r7c0GX2Fgw-1; Tue, 02 Sep 2025 11:48:18 -0400
X-MC-Unique: ig28QuHDPrC9r7c0GX2Fgw-1
X-Mimecast-MFC-AGG-ID: ig28QuHDPrC9r7c0GX2Fgw_1756828098
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70de6f22487so99378116d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828098; x=1757432898;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhaCe7UWtAErc1tHpsJG+msaP+N2Pr3q6msa7c8CHQo=;
        b=asH8UaTmukLLQcFB3eNFiwgCERs31hVCERrKTHSlKx1+VsmoxHGgKLh0KHsNMZEBBE
         jIEbBYz5cEIvCkAkidRcPDzNFqhOXBBl37S3tXNySGbwLXzmteRFrGKpxn8N6Wol5q/d
         UcXdDLJ4NsOKzaoNihpcn508/0CY1TFDBKLcp55qW+SUnK3wkoByu/n4EDop/er+VUNo
         wYK6jIS/Gko7fcnNNPRqcpRUc6fPW317UNlJbJUSKCoctGyAV7uwJBb0ATjW2nrHw7fV
         huY/gkkXGIwE9VvIhvA37sg0SQ6vW6eeKEQYWmoEWbwAX+oiUm4/jBxa9/pifM0767+s
         0Fmw==
X-Forwarded-Encrypted: i=1; AJvYcCV5daUm9xrptJsL8LHK5n6Ihfs0TSe+vfLNNXn564PLQrRN7CvGukXoAMjLLMZ7hob+l92HcankUPq0RlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYTLOgzhQVXqTUqKx2LzNOQo5PBB16RDcNsAE0m3daPpoc6/C
	MdICgZ31lVTyulqoMGuf+eBG2XNdWFQ0TK00hriQomqkZaTl7u545tWC4EamJMN1ON4gptkPKUr
	8mTpkhtPhiHEaiOKM8MhJTPPjOIKoMT+Z1nFL9u5WgP+4mdt3GuILtCtCatvVBDcjXQ==
X-Gm-Gg: ASbGncs3U2xNeOhDw/bRDKoFVHFO+DY87jSDDcbTpthHQOE4IMXD+fP4PScmhQgNt5F
	fg37dBxPxlo6LQlf/B1qIW5vbdX0FI3DObOEdlhF5WMcHWBzfrwekiAmILUIkv8WAQdu9aYykDA
	gnUv4OL4IYD0PJkbhdb8kyxSwz8yaKcf3QRhHXu3FAKVCi1hERIHLJY26vscJRLUzURsgwyMpAg
	bQEy1LmmtJAKVhXxjwSr/p14IkZcmYCl9XQqDIOBrbOO0hJiziEeS0tLU0+uad3G2TXHCIw4Gsd
	KQKmYNUzdiyJ4BQDn0LpLrcQ8Oo/qc51t3kWU7DI9fK8bpSYSYpgElyMbiTpcc2fiKiw+8q/YBL
	kgi1UyPLVug==
X-Received: by 2002:a05:6214:f08:b0:70b:5320:2fe8 with SMTP id 6a1803df08f44-70fac6fb0dbmr115841036d6.3.1756828097912;
        Tue, 02 Sep 2025 08:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBdIoGHKBwEZLhZvs8Zx22a/1nef3bPgwGHjFFyDHMKxpWx0vQvFqY7eW/qlVzc7etWFIoNA==
X-Received: by 2002:a05:6214:f08:b0:70b:5320:2fe8 with SMTP id 6a1803df08f44-70fac6fb0dbmr115840706d6.3.1756828097511;
        Tue, 02 Sep 2025 08:48:17 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad897a98sm13837816d6.26.2025.09.02.08.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:48:17 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <152b067c-1fa3-4b73-98f3-7e0a0c87e388@redhat.com>
Date: Tue, 2 Sep 2025 11:48:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] sched/isolation: Remove HK_TYPE_TICK test from
 cpu_is_isolated()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-20-frederic@kernel.org>
 <dc75acab-36c1-4340-9cf2-35a35361c32b@redhat.com>
Content-Language: en-US
In-Reply-To: <dc75acab-36c1-4340-9cf2-35a35361c32b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/2/25 10:28 AM, Waiman Long wrote:
>
> On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
>> It doesn't make sense to use nohz_full without also isolating the
>> related CPUs from the domain topology, either through the use of
>> isolcpus= or cpuset isolated partitions.
>>
>> And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
>>
>> This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
>> alias) is always a superset of HK_TYPE_DOMAIN.
>
> That may not be true. Users can still set "isolcpus=" and "nohz_full=" 
> with disjoint set of CPUs whether cpuset is used for additional 
> isolated CPUs or not.

Instead of "is always a superset", I would prefer to use "should always 
be a superset" as it is a recommendation but users can still violate it.

Cheers,
Longman


