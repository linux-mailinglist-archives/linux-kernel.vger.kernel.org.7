Return-Path: <linux-kernel+bounces-744972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3C2B11329
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9D01CC8263
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B334322B8C5;
	Thu, 24 Jul 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQcUy6ux"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927AF9E8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392757; cv=none; b=ciCbA9B1v+StecmXCxnQs3lF3zlUu50kkgHQE0IAK78uX3QmuSBcF6UJk7Jb7q1dYrZZRUCSGWTB0t7m/njyKNqazwkWDRYJbgQkFtQKviR8MCxI2m4HhxXowVzWEoWvHi8HgfEsJZkN0P50s/LCGgQ7Za951wu2T9a5g0B0t58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392757; c=relaxed/simple;
	bh=2cGQ56dbsxK1druA/XiJMH+oxCfrEx6kK6FcnWfJKjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naW8ZNI4X/REl75ZjqJPeHFs87VAbNZ5poJQS7bhWELKWNlV0nxu4WdSxgGGiFnDBGWSDkJOEjRiZlkcTHAqNJeA0ABaqaEbZO0/2hkgMrYPHkCTqGikzlD4/NFMch7Y8mVwMUGJdm8Y9CLksO9iIZDl+xJgUStGyd4e5AC1GtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQcUy6ux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753392754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=azr2brsZ6Ua8mVeqP54+Ze96cYo9iUAaUmwXzQQMwtE=;
	b=SQcUy6uxLin3kYmEdEefT72XhVJCYwGsjYpdYzHOW1358NQhq3cI4ysq93b8NzYO4Dhz6C
	As/8B4ULfuhQeMc91sga/FGJnbHn0D1xrdQavHrcMjbFPBQbvIARCFLgrtMMTr3O79qGzl
	2rbjdkr5hRse+3UU/3atArdYcuWplOA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-M4bhmrB7P3qQZ92op6cQxg-1; Thu, 24 Jul 2025 17:32:32 -0400
X-MC-Unique: M4bhmrB7P3qQZ92op6cQxg-1
X-Mimecast-MFC-AGG-ID: M4bhmrB7P3qQZ92op6cQxg_1753392751
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so965364f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392751; x=1753997551;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azr2brsZ6Ua8mVeqP54+Ze96cYo9iUAaUmwXzQQMwtE=;
        b=r9r6GG/8l/lpdYeNc+ZsdC9Apdw186I0Jd1I9Oc3u3noVhYE2w/mBMUBjbBzwWdx2R
         tgNRzreWQOjHceAISvDL3I6UzyaHvyz7YcLjZvSqNaIZ3voRPA5ZW6rBWk7sGIUnNSak
         G2cZAkRsrV24F1pB6hxmrCM0XRtNhBoUZen8OThGVFwiEIMtcDw13efWCj+cNdBtNOls
         HJG0G+owkHd4RIi1ywZIiBEnwXRI344rjTJI1W8IgKIe/dtgJn9bSH5zWcfN8ZNFWa5h
         vv+ze5D5nPGuTvQ/u0Uw0dfAdZpAOh5Kl/EKkJDlQqkz4+Q2cyRHiPprrbp53Pozl5Oc
         6YRw==
X-Forwarded-Encrypted: i=1; AJvYcCX2sBVDzAn/BgWmbD5GqqdQKtiea2gCLE7kFWXenY1tzjBIdckfJIjAKGGzthaLT1KaRdmaRvrCT4SfJYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/UYBZc99GNLWJq4+zfEhXD9xPFBPyD/yG2pupOWm+JxTtatuY
	8BJ+2zb+81Be/lEPndfY9M+TsVaeQvnvjtKCMjkiXwZyCDcA4mnHX75d3lVMyIGbWOg3iSFRywL
	D5VIegJbc+jGBI6/+T6a5ASXSTEpzmk1wqQxSLtdNeAOwn38QG334iCDTsPrtrFKbFg==
X-Gm-Gg: ASbGncvHNaq5vzzkEfLxWwB09UO3MnOUoq2PZRHDxArMOJ+YVfaVPmgMI6csLSSY4YH
	EfL5KhFarAz4VOagC+hVXSlkW47Ai0BmsJi+trtSq2BM91tKDGvuOn0VtxFHn7PzCBQweW8TLPe
	EkDLz74EJTGRdadsMgU/7AXhEI5RKX6KXs3NUWxn29Xr6UyHZ3pKJ3/F8PeGZuoIHSl/QViMq6N
	e5k8r6iuxmo+xV1y2T0twoewvAQoXX0c2MT7FO/8Bp9X1jR5Ub3QwP+jmgkBUDXcKOv846b2L04
	JNy3caLLprokhrLgjvZlTNGDBtr7BXttwXUlDvKVm53DjSIg1D2PgVnBlnf05b55iCElj4I=
X-Received: by 2002:a05:6000:1a85:b0:3a3:4baa:3f3d with SMTP id ffacd0b85a97d-3b768c9c13dmr6966259f8f.6.1753392751358;
        Thu, 24 Jul 2025 14:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBbZa9GDR0ki0Hy0VjprS/a9IUEWZpzBMehLKY4L1dDoNNRYdZKztKjdVKH6ITX6Do3wdiKg==
X-Received: by 2002:a05:6000:1a85:b0:3a3:4baa:3f3d with SMTP id ffacd0b85a97d-3b768c9c13dmr6966239f8f.6.1753392750862;
        Thu, 24 Jul 2025 14:32:30 -0700 (PDT)
Received: from [192.168.3.141] (p57a1acc3.dip0.t-ipconnect.de. [87.161.172.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad2b4sm3213491f8f.47.2025.07.24.14.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:32:30 -0700 (PDT)
Message-ID: <e0a22433-541c-40b0-92bb-34b0596db642@redhat.com>
Date: Thu, 24 Jul 2025 23:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <202507241352.22634450C9@keescook>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <202507241352.22634450C9@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> As an aside, why should discard work in this case even without step 4?
> Wouldn't setting "read-only" imply you don't want the memory to change
> out from under you? I guess I'm not clear on the semantics: how do memory
> protection bits map to madvise actions like this?

They generally don't affect MADV_DONTNEED behavior. The only documented 
(man page) reason for EPERM in the man page is related to MADV_HWPOISON.

-- 
Cheers,

David / dhildenb


