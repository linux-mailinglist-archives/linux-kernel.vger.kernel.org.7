Return-Path: <linux-kernel+bounces-890026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17FC3F19C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 365154ECE70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C8316918;
	Fri,  7 Nov 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMUuKhdl"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8F316907
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506728; cv=none; b=TWp0+dPIYbafi0RMRP85sGtgPY8NqbdeyFJw63BkIN4KXJeE1ifnqLU5e31pVeyPS7pFoZ1ZegtSMzqK+g4rxxJ7mEXuVpiOsSya7P7yYzkltYVZDUgOHQHs68OxElcvf/fbY8P0/mdqYrvYFoUgKpRJb8CJVzYSQJgKmBc9zUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506728; c=relaxed/simple;
	bh=n1f++fTTN0ZZCsYTORS918MUIyFdFN5BIHm5HBjy9Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=baJBOV1iYqGr2JxhLuZMmGSUR8u3nyalPciGGUR2hB32jhRRsHIbGC8DOS/oapaJzXlO7VTI5r8sQGvv2nrC8G2tCg0tmPQWTODpyxpLvk03aUP3bdEBvaOBoSX773cdOMwDEyHBll864l5DzspwFy3F6JorOlS570yNVjRxXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMUuKhdl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so309489f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762506725; x=1763111525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfu6hWVOdhakKToS/FAXRGWAJMpHX+j6Qi6pqG2zebo=;
        b=WMUuKhdlsy0PkqDsktR9psNthmPQ9JXeuKWJdqVcWCzClx+p7FVvJM5XD7osQlSZ0j
         aZlDtlx/IB7GKzZniJ/epN5dc8QNa/oe4q2WgoTaWOmWXH5dkk7aNsfeFZ9Bxj9WyQaq
         z0RKNQk+VILLSD1f7kmxss05INZ2/0lPY90oq0JN8WM3jqmHAG4JuiQZ+2xec4kqboz1
         ACKjNvvR3wPK5C37Dk+yNZk3aVCKAC96DvZsfUXF7xwigyUoA+1c1R8eFuXo2RQHU1qr
         Q/tjtiwiYX/XhQoyqHatxaHKXqBjjb5wLg+EJqE5xPUjycAKTs3P1Z5giI/4gUNMlc7I
         67rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762506725; x=1763111525;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfu6hWVOdhakKToS/FAXRGWAJMpHX+j6Qi6pqG2zebo=;
        b=UkLtwBS4pgnB+NNupc3dcAFND5EthfSX8ZpNL5MVPwkKEmKHiu/n1fMCqtV518U4FA
         nTXBrICGpQd1CnzMUhSV9CG/9VmPH3Nekbdwdu81WBpigtQE3VpY+xEj606F3fWxwPgA
         wucprW9tVz6AEkQ5P7YtS2j+LD+twzxGjpA9nGZRT2K0EBTAHYFAek3vCqBPr+Q+KYqP
         hvMWRlNbWf7AywAkXnuk8HNn9TScZKekAruRFGdrVRqN//9snYmna4osTfh3V4OuKNKa
         4NdF45imFY5kuWwPFpT1S96UNRxvHN5lZgGQtiN0Nse2VURWHtYsf0UsjBc7jGbL/cw9
         bJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoeTvt+R+aUTZsjiDu62TObNsZ7JFqQUD3o2mb3FlYgwxipS2BKVuvJose0cThG+gNrp6ML2qwcppoyT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfy8RZ2UYGJWwLcApdng+gXS+TZFuL0Qm5p/sD3UfrhdsC3C9s
	vuwQRb0VCkVZY/k49VGB6ZQefPbl1iJ25h2BASYjXe1lM5u41lncfkzA
X-Gm-Gg: ASbGncsV8FijK7kna69HmRgXcufThIyktyWjhyASG6MATRD4utkpIMb+t3IdIUWaIRX
	/NzXEqQjXgm+UENOupjJlrcbOtLSDXElKPT0bbPDbin/eQKM2eL3C3PTUFbiBUyo8BgRcsP3fG4
	Cemq0odYOYOuxjEq4krYKTpjq9q7l3387iipqPjCc4tPfSIWrb63MtFY5xcMRQd5c1vxB4bPmQq
	NUdS9H62FEWNvpJykHSbWHhfDJQjQLatovFk++oQ6NIWOjQd8hPiRkNSk7wV881dYCkYFSmkOkJ
	R8+5KbKYA3XIt35FIv/mU5Xa8cZ/i41YFr4T9TQrURDg/i5/5/RteBZkD8kL/A7b0xCWBfVSDHR
	b9Y1BRjryIICTtkQK6lgzKydJINKTXf8G2W4YvqVVDdJFmQ4tehpX7uEhFRqyRP+epOuTd00qPA
	7I+d2y/UqnC1NsfNScYq0DzWt5vhqZhFF7H4pPvtQWVENuHvaQLg==
X-Google-Smtp-Source: AGHT+IEEP0U5dTddGyGuUJGvkU9GrhTnDh8Aic0GqAcQP/ISEpYqab5xsiyolY/2271V8nj7hJgVHQ==
X-Received: by 2002:a05:6000:26d0:b0:3e7:6418:247b with SMTP id ffacd0b85a97d-42ae58b2cc0mr1921056f8f.10.1762506724699;
        Fri, 07 Nov 2025 01:12:04 -0800 (PST)
Received: from [192.168.3.141] (p4ff1feb5.dip0.t-ipconnect.de. [79.241.254.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675c9fdsm4089150f8f.28.2025.11.07.01.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 01:12:04 -0800 (PST)
Message-ID: <0e616478-96d4-41e9-b6c1-fa641c36fba3@gmail.com>
Date: Fri, 7 Nov 2025 10:12:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
To: "Garg, Shivank" <shivankg@amd.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, zokeefe@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
 <8bc796e2-f652-4c12-a347-7b778ae7f899@arm.com>
 <ozkb6mcxuymlz7tm4vcnqf266gd4ruiik2zal2koo5ffprgxfk@35godtyix2cf>
 <43a8c8a6-388b-4c73-9a62-ee57dfb9ba5a@lucifer.local>
 <77a54f63-f5da-42a2-b24d-5c8a0f41d1e6@gmail.com>
 <0b84865c-5b23-4be6-9902-af9d5e63c182@amd.com>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <0b84865c-5b23-4be6-9902-af9d5e63c182@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
> 5. Yes, I'm calling madvise(MADV_COLLAPSE) on the text portion of the executable, using the address
>     range obtained from /proc/self/maps. IIUC, this should benefit applications by reducing ITLB pressure.
> 
> I agree with the suggestions to either Return EAGAIN instead of EINVAL or At minimum, document the
> EINVAL return for dirty pages. I'm happy to work on a patch.

Of course, we could detect that we are in MADV_COLLAPSE and simply writeback ourselves. After all,
user space asked for a collapse, and it's not khugepaged that will simple revisit it later.

I did something similar in

commit ab73b29efd36f8916c6cc9954e912c4723c9a1b0
Author: David Hildenbrand <david@redhat.com>
Date:   Fri May 16 14:39:46 2025 +0200

     s390/uv: Improve splitting of large folios that cannot be split while dirty
     
     Currently, starting a PV VM on an iomap-based filesystem with large
     folio support, such as XFS, will not work. We'll be stuck in
     unpack_one()->gmap_make_secure(), because we can't seem to make progress
     splitting the large folio.

Where I effectively use filemap_write_and_wait_range().

It could be used early to writeback the whole range to collapse once, possibly.

