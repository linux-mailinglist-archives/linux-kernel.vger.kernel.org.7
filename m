Return-Path: <linux-kernel+bounces-865842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED25BFE256
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D81A08277
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904932FB633;
	Wed, 22 Oct 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzaAbRP4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C126F46C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164543; cv=none; b=Od+E8RC0idyNV5PzAv8bTWubbF0iSeketlaGMOtJxjZwDiq1FRRmAKGC4eavvrekKxqb3r28PvxQb/T1j8cTqNxg8g/kjKoAv8TCDC2kANoAYGLHedlSX6EcSeELzLDuWSS9xt0+EAQgA4wpNQU10uXaBdIADfUQ5IJB/Ogl+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164543; c=relaxed/simple;
	bh=DWYaPiaWcSNWlJB+yckumHEj/fx+/QLLKE0TRdVfvlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2lGF3P1bShZkiy0BR8oTxG/gbgFkRNsmv0M3L4epdXTo5iq1ZZZlSDRAQ1h2K/FU+x6KWZTdqErWMyyVJk/ob4/qZ9xwGicVsE/h41g6k1yBq+tMQQurCy2W7Gdub2myGBv+fNFSDVzZ3rnoMTzkB72s4AGaQU1Hm1Hryz4i7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzaAbRP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761164534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tj5wSQiFxb3TCQrEl/pvDEnruwQl/VFhjMYuvBzqn64=;
	b=FzaAbRP4DjvMh8MUSv/saZVrYEMCBuCz4RoKW7oXo+vQkiu6SlhUA+m4hSPEm5Z7ltgrrr
	Jx8t9+PT+Fc2+zyWbdRKgYj4LVbWaVFnXoOVSsbzjilPYeTJTZ95nM4XKa6Fmmaa9J9qaO
	xgMoVU3U898Qmh9PA78w0m7RNzR3VXM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-DYgZmdnFPBi-A6Q5Weoh3w-1; Wed, 22 Oct 2025 16:22:13 -0400
X-MC-Unique: DYgZmdnFPBi-A6Q5Weoh3w-1
X-Mimecast-MFC-AGG-ID: DYgZmdnFPBi-A6Q5Weoh3w_1761164532
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42851b6a659so27977f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164532; x=1761769332;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tj5wSQiFxb3TCQrEl/pvDEnruwQl/VFhjMYuvBzqn64=;
        b=qdTcZjXWIzArY8F8e513RQ/XIOWYcLnjlqU4ekqyRaToQB62dL973m+oYSbnBfzR95
         dZqGT11o6CeMxyKUYNS23vRnF17xudr630wK0f27PXhRFExWU5OF9x4mFUdX8mvwmQHQ
         VVXQn6dq+JDXoEeyMjmhrCHd/87JZTPenobHQIFPtzQUW9wQQx3taoju8tl5A0mrr+Ff
         v7uR2r515usXlqxSF2djPJyuJMyYstbvKgxrBpU0q6gaCs0aNFQnDq9Ucx+Gy/E/wl/f
         I3o7VEc3YtAUf7/neBdRY7Jy2jUS/9k5r8P7KWysQGxLYZlkEeTC//sbOJItqG5QG2iI
         9iYA==
X-Gm-Message-State: AOJu0YwS90tC0fQtMoU5S4f5Vufmt2KKxQsZY6cT0et/wN3b5KvEmdDy
	Yw9i3IXTGe4Q8IV43WROZSNaChitFsF7MERu1gsWbItMd7wWu7r5+xvcxIvtyszEHAu0HmHseg6
	FuGzkiwTaC3GFm/vGuSrxztXjQtiXH4Wp6lwdvWZMCzUYDTllWM+XgQomElu7O8lsYA==
X-Gm-Gg: ASbGncui1lOii77WM1g6ztS17jh+APePfVVAt28jyDScStrw9eWKDHIInGSezmcV8TC
	P63ZP+qysU/AMSPdyXEXxuOGAGxk02oKhK0DVH+Y0LCI2L92yFac1KP904CnI6xGkyb2ab8eJgU
	b/FgSAHh6Wtl6hzGMcMmb2ku2AnJe18TIbZC4Lupons+QA42qg17Gwy6q7sVo2cQVv4311pankQ
	ROfrMDRiiu+kFvd09hjWJM9VGfxqa2VaY4k6Sj9XXAbLlUOAsS0PXg8dXvs43RMYMwplQDtCso3
	lYzJ7Mc0j8L5AT5q0NWif5XpwNtqfxrFh4lyWKnQVwMNfelKOQbgzMfl8+O+VwrWVQaEF8O0J17
	ajF3dKbsrBwFWWqlD27Kxz4SzYgQYcusYdPUGyIcDtAgJZ31c5ykUI5AOpXuGiIqH9jDfii4LC9
	+KRxUuNmbeIfn6Uo34Z1bXVr3C5WM=
X-Received: by 2002:a05:6000:2486:b0:3ee:1125:fb6d with SMTP id ffacd0b85a97d-42704d442c9mr12627254f8f.9.1761164532365;
        Wed, 22 Oct 2025 13:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEflzts1g+chOUXVAtCNc6O8tJrLlNij/gSjJyaO7Hf4ROLo8+ofs8zI8OpGFogxXz82hoJpg==
X-Received: by 2002:a05:6000:2486:b0:3ee:1125:fb6d with SMTP id ffacd0b85a97d-42704d442c9mr12627220f8f.9.1761164531914;
        Wed, 22 Oct 2025 13:22:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e785asm246899f8f.3.2025.10.22.13.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:22:11 -0700 (PDT)
Message-ID: <ed0887eb-6124-44ab-9d1f-1e87e9640e14@redhat.com>
Date: Wed, 22 Oct 2025 22:22:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 15/15] Documentation: mm: update the admin
 guide for mTHP collapse
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-16-npache@redhat.com>
 <bba40f08-1b87-6b57-0e10-6e96e4d7bde6@gentwo.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <bba40f08-1b87-6b57-0e10-6e96e4d7bde6@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 21:52, Christoph Lameter (Ampere) wrote:
> On Wed, 22 Oct 2025, Nico Pache wrote:
> 
>> Currently, madvise_collapse only supports collapsing to PMD-sized THPs +
>> and does not attempt mTHP collapses. +
> 
> madvise collapse is frequently used as far as I can tell from the THP
> loads being tested. Could we support madvise collapse for mTHP?

The big question is still how user space can communicate the desired 
order, and how we can not break existing users.

So I guess there will definitely be some support to trigger collapse to 
mTHP in the future, the big question is through which interface. So it 
will happen after this series.

Maybe through process_madvise() where we have an additional parameter, I 
think that was what people discussed in the past.

-- 
Cheers

David / dhildenb


