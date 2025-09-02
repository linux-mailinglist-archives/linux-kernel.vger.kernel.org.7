Return-Path: <linux-kernel+bounces-795884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87256B3F8F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB9A188891A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F12E7F1C;
	Tue,  2 Sep 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQVdI+U3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317C2E718D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802607; cv=none; b=tGbjXRekwS4e6HLf/A0Ris5c8wInbfFwG2+JM9snrA0PY4FKMP7wIaBTOpbYf/lLuXu1ZdAwzeVV7dklSAv9ksXzBSQ4jFFNcETbO60MK6jxlrSp9YjwtzSS4VMrT/8S4aiqOxhN9/UXC0rwujuke5dBMLfFRn6hUfPfRMil01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802607; c=relaxed/simple;
	bh=GOjPTFFkfUnQupV4+W++LMjMMjqmHozzaAEeN4FUGqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rz6XVhBPp7UEzZiOpxroZJYrK0e6Vu1zyH7XdxLjdgRkUHY0WxpxrthNxMHZvk3NKHrRw5hyIrOnFGYLZYc3dFafwrzItdF0iCcoGINZtu4GKbv6OOe4GhprbHk6gU9OskszX2F/Nh46Mu0hzw3aco8Wo71+WHLKRTVY4CBlL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQVdI+U3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756802604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yPC0fHJHVlYuso8L6DuKnMgTiDgj+lznSR9AEbNPOrM=;
	b=WQVdI+U3r2ldwNXDDxIxxdkIDwoe1DMIGW5QYuXaaqzPOZsoR7L0S1aWorXJJDBjtvjnDM
	ujP5ViEeJmvW0+0qvRPs6wCaAvgBboIoHuP9lEX8lHHA+43zOqOwsldJ+gnGKFELjaZ2wT
	VeS8GMvDyuEeeW7IUsg6jPhT5WUssuA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-JrIXQ7b4M2aWK9ltQ5wppg-1; Tue, 02 Sep 2025 04:43:23 -0400
X-MC-Unique: JrIXQ7b4M2aWK9ltQ5wppg-1
X-Mimecast-MFC-AGG-ID: JrIXQ7b4M2aWK9ltQ5wppg_1756802602
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so2362235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802602; x=1757407402;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPC0fHJHVlYuso8L6DuKnMgTiDgj+lznSR9AEbNPOrM=;
        b=SL60WK1jxA9pdyk4EsnVZ4yWt5xhLCmgB70IFAmWyW06hfg4e7vNdiIxJ7Z/Rd0fzC
         nRl5z3MTz8UdYu8aMpa2lITYg39u3WN7Ll0oFmg/xwQ7rwC8nF4RrGqYx6kaUTIt3d0W
         bpRzumqtdQExENXSfd4SjJMyJvh326xjoUx86Q4jTmnRPU7nyD11Ggt9psNgki065C0b
         KC7TFla6OaLxTRaet+TF6UgHuu6gkgb1zM5u0wUbiDnJAVk4B6P3ODU7g0xFx7Tk56/l
         9yluPlSvyqC+9DhVpwu35mXxgX1Q04QvVG69kjcGeDmyuPFj+cqEpItC61Nc6yPF+rWP
         EqLg==
X-Gm-Message-State: AOJu0YyEe92aAq87zZgy4HnmhggUS0AzMtZHosPfueT+BZWd+3zEsXzu
	B91zddPnCeeqiFchlESQJpo86bbtpyrp+CtHHZWJScznZWHjyduckb8N/Vvd4aPAYFvyiza0JOg
	n2otg1Er+vRAH6agNy6Q/IS2azCZ0PAeiTFSppmG6S00140YzAdRaLgV/PZ7N12lKOA==
X-Gm-Gg: ASbGncsBdUeJb5/2Cu6SmRNOX8TbczUQJxuVIkk2J+i4XoRrWTzbK4npgZKD26gVuFS
	UAJG2Z8HfpnJOeXKJiaguZvCp16DoSJ5HkYIzqDAwwnZJZG7gfDY/B+JbC0L6CygxRFYxAsquvZ
	s/rjrNTOib+xr+QEiYlP539BQjFE0/cKrKkXBFBiTEKTf3ikETlE5/wQ5+CDU7me0whe/R+zNYe
	N79dXwiz30PwltzlCnfLg1CsSTtwDsI73CZAYdcgRARmv7VvJVcc1QSIzHAR+sv/Ecj4nWEgGwR
	F593j16ELqfY4E/BDQ5k8CHS/Cd03A+Qfmfg13y1tjKjGaUBwMZ78KdKHvMzpFOWI+hLnIsrBkG
	7fmSP4fmc4QLDbx3bYGIwj5h3CkTWsJ5dACjsWDHXuoqg7Y3RYuODr5Cf5kCxEv+ap74=
X-Received: by 2002:a05:600c:3b25:b0:45b:8822:d6c6 with SMTP id 5b1f17b1804b1-45b88321d2bmr89649895e9.15.1756802602018;
        Tue, 02 Sep 2025 01:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH60SPINrFV8S13VnO7bzXjzRXFNuPCov0mkDO6FPkPgyTuB0VjmeJ6L20db9xSLB+WYMEnKw==
X-Received: by 2002:a05:600c:3b25:b0:45b:8822:d6c6 with SMTP id 5b1f17b1804b1-45b88321d2bmr89649595e9.15.1756802601610;
        Tue, 02 Sep 2025 01:43:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b661d87a7sm163776295e9.2.2025.09.02.01.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:43:21 -0700 (PDT)
Message-ID: <1acb705c-4846-4a12-9e90-f7853da8a295@redhat.com>
Date: Tue, 2 Sep 2025 10:43:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] huge_memory: return -EINVAL in folio split functions when
 THP is disabled
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902084036.208921-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 10:40, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> split_huge_page_to_list_[to_order](), split_huge_page() and
> try_folio_split() return 0 on success and error codes on failure.
> 
> When THP is disabled, these functions return 0 indicating success even
> though an error code should be returned as it is not possible to split a
> folio when THP is disabled.
> 
> Make all these functions return -EINVAL to indicate failure instead of
> 0.
> 
> This issue was discovered while experimenting enabling large folios
> without THP and found that returning 0 in these functions is resulting in
> undefined behavior in truncate operations. This change fixes the issue.

Currently large folios that could be split are impossible without THP, 
so why should this be a fix?

-- 
Cheers

David / dhildenb


