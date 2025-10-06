Return-Path: <linux-kernel+bounces-842695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97113BBD51A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D268349AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1241EC01B;
	Mon,  6 Oct 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXtStlBh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7910E1C3BE0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738601; cv=none; b=F9X+nworGfpo+XkSpyI1BaompEe2JkkV39tg/CfPAeoFH4AqWTN+cH7h3GWiL6DsHkogBJleYE6bsDTnwiT7Dq8oAp5HCLSZr2Ff33zxGTIEWZGzSJz/ibYleaJCsIDdH6xC+sOPbeoZr3WLx7QvvwQjne6FhpW127H7GgqZTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738601; c=relaxed/simple;
	bh=WnqFdlc3EypFLnrx37RVzl4hmu45JYc2hrvi52TSC6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pro9/oa/YF7yLyETcJHIHvttWx7Mv14MAlsTCMUPW7JlBEfYdlBjoWSf0jvIP8V3zKfdivPqHAbZFh+Nrqp74sAGg1tP2tFvCX+UApaBZGMOlJQu6O7oJznJ1Mfu4p/VH+nP9qpBKMrJwV3YahVa3GMoTkkTGx646DyFO/td2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXtStlBh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ozKbjZymvzxaFGC1L+Ulki1LLDfgmV+JknWAMRxxmQ=;
	b=DXtStlBh96U+zyP7QFs4k31efeOVSxJKG5NXMMkuks+0rJ7wnkfLML/ccX/SPM9ILW8zXT
	teIS3PtnutB366NvHADSDckvuWJZZ/p5F21PZHomcF1iGEQvJHrLxgaUy+5hKldH8DAVEg
	7loSrbYnzdmaFhAixaFZB7S5nO9VYNk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-lW40ufL2ORKziQ70AFyJaw-1; Mon, 06 Oct 2025 04:16:31 -0400
X-MC-Unique: lW40ufL2ORKziQ70AFyJaw-1
X-Mimecast-MFC-AGG-ID: lW40ufL2ORKziQ70AFyJaw_1759738590
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e303235e8so43919985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738590; x=1760343390;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ozKbjZymvzxaFGC1L+Ulki1LLDfgmV+JknWAMRxxmQ=;
        b=TXxYtW2xwkpEJ613jxlvUDWPhKoIZ1l2CEokFWIOksTmAl+IUBnMa4w5PbtUeLLG/a
         96PTNZYgtu22YgVS+u2jrcVLCdqiaj7Vkh0MQzSjyXvve65NmJOiWhGvFzLPgl3jCbY1
         3dcYGCHqfnGj6ojVb7wYGezhf8bqoKHB9eFVTdjB/xo3u/rwibm5OXRq1IRBvKbA9DBS
         /qMAjKHXp3pEoO1I1cXtDf99e/SKdpvXb6zBuBGuGlBMHLH34ZGPIg+5Sx9AXKyoegf4
         Kj6Bt1AxOrY/jRypZ2FDdjUVrPaMPvQhDCj9lXS5VKJZylew2bG5JMLbtKgEKP7JNcQa
         VyoA==
X-Forwarded-Encrypted: i=1; AJvYcCWPMKhvOS+LqYgRxKVzmeQYRDPbVNOnl3mvfnCgJNufWhf7WVlIKsNiY2KhbkneweypGBSBeOkXQQ3IXNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxodQauEwDNpgyU7mjio4DaSBVzd/dBux3sKfOSvdPssvBaok1t
	9U+gPD9Fg/8P0jfr1EXylGbKKCM6gFg9ADN2sOodNSSo48vL2VyfBdtFHTnye6KaUb/1X7/DfF8
	zGLEB+KGYuJqwplz0UO/vAohTAQsSyCid+OhUY/SccjrsWLD8g7MEhpdbh9VsZC17zA==
X-Gm-Gg: ASbGncueOJRvzDoxb79tByvkwit5uKZooKEqmRiuKG8smAiPAeVRUwurW+B1pqRlqOG
	eqRfvFXI98Jm7HGmXzGWE75QyL0XDFeHGpCpBo8g6/u8lrOUGzWmEywGg8tDsGvSOAsN59/gGFG
	ybldE4l1n3gPq+2SjgusiYA8zsCKRMyOLgGHYK54xZVWJfdoCLzIpXLTALRlpxVE+ZCqXwZrK6b
	G+sOijeJ9ShLwK5h60hjpkY4kCISeUl4fREM74bxNVh76whBni47nTFt48nTnmRYURGzAvIYoDy
	efROi5nBYqdlhHv9tTHLCyO5lFXIHB9o1bheV4giUvWqGyOi3cAipgtZv6Xih7vbgLYuvvRfxsJ
	DpMMsqOl8XEnz
X-Received: by 2002:a05:6000:2dc3:b0:3ec:e285:546b with SMTP id ffacd0b85a97d-425671be366mr5916404f8f.50.1759738590270;
        Mon, 06 Oct 2025 01:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0t5/ZRi3WB5iBQu5PY93ByrOhPhQLYlFTkpyWdF95wKH+yZsK2Dv4pSCdzUgOdT6JtNIidA==
X-Received: by 2002:a05:6000:2dc3:b0:3ec:e285:546b with SMTP id ffacd0b85a97d-425671be366mr5916389f8f.50.1759738589875;
        Mon, 06 Oct 2025 01:16:29 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4ab0sm19684661f8f.52.2025.10.06.01.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:16:29 -0700 (PDT)
Message-ID: <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
Date: Mon, 6 Oct 2025 10:16:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: Breno Leitao <leitao@debian.org>, Jiri Bohac <jbohac@suse.cz>
Cc: riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.10.25 17:51, Breno Leitao wrote:
> Hello Jiri,
> 
> On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> 
>> Currently this is only the case for memory ballooning and zswap. Such movable
>> memory will be missing from the vmcore. User data is typically not dumped by
>> makedumpfile.
> 
> For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
> from the vmcore, or if there's a possibility they might be present but
> corrupted—especially since they could reside in the CMA region, which may be
> overwritten by the kdump environment.

That's not different to ordinary user pages residing on these areas, right?

-- 
Cheers

David / dhildenb


