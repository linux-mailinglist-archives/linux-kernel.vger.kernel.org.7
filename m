Return-Path: <linux-kernel+bounces-732029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780A7B0610F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935FB1C24931
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF521421E;
	Tue, 15 Jul 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGdgTVl4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FD1FF1AD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589015; cv=none; b=BBvxe6dzMbZLC2DsesgKmBX9w6QSHq4L1R2NexDAOLACvMjDg9oZxe3/4HeAnYu9kQPhGTZT8WFeCwryLkdp5ojkRVjLfan9TmQaL1MJss1qCGlDDXSAo1EgRFqxY8i57Qe65EseREKysLx9m5qwB7eE+U5WThN/TWapiwUTBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589015; c=relaxed/simple;
	bh=EeCCPvYaO/vZ02CLQpqwrR7TomDQ+vhuMVSKzhcc0jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmJRbMbLUu2qdmSiiczdt2ytPyIrgg0O+sCr6t02qkqB43Qj9e0XKR9l0a3GbvHLg5eGHBDZTv1az4o74FDufWFsJ4fMTKeTN3vdA2mCHq4541wKYLAYLlvRx0UK3LrF+a+Q33jQ3A0xDYUldaDXXhQJPVGOgSQDaVe4Pa3W5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGdgTVl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtUFd8jIZdacMgVpErwt3tqjgeqdKXPmgyL5wbxQy4k=;
	b=ZGdgTVl4tjlFXlFmYyI5OkeyjSRk2nNB7cHJ3XVLwHcyFocjwYqk2uPIFOJxTMtqXWGqHK
	xXofAjIB8V9uVCE6GaSnNrREhAwhQIjF9unq7/0g0J9Os3z1WZbzrMsGuQf7E9nlpEt1qB
	41CdjSrl/h7aJrwv33Ln826f3iih1do=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-T-WhXqL9OpqSysd464mpNg-1; Tue, 15 Jul 2025 10:16:51 -0400
X-MC-Unique: T-WhXqL9OpqSysd464mpNg-1
X-Mimecast-MFC-AGG-ID: T-WhXqL9OpqSysd464mpNg_1752589010
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45359bfe631so33219085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589010; x=1753193810;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtUFd8jIZdacMgVpErwt3tqjgeqdKXPmgyL5wbxQy4k=;
        b=lakOyJFWDo4XJyTWlj8Dqy/ycdNVUZtu/RXIcl6CRmdu2zUCStASZkjemYILFbZ//b
         wE/f3owgiNNMwCUt5KOOoRUiknZmZvqTgD5yPydr3rY9+C5H7ZH9oX7XieDPzFW+fjAV
         yiBT/Gx5GaEdScrsRtVdnHTgFIT+XWJ+OVbYcAE66kZ8FZuBqd6BhhsbF2/xblHc+xjH
         E8HKgKfdsARv3DodLv6c7o0bpU8VcrD5Adrh+Dt4cUDxM+CWgUDlYHrhcYTUI7q1nERl
         TYyQIKGZX8T+j/3wWkoqWBZdsylu0tBitHI6UEdXEdB+V79Mf8KCHsH7nVKO/tR1hBW9
         rczQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvqt9+Rd6jenOJZJxLkkBQq35PfPQvDFE5B4UQ9oWrrendr8+k+iDXCWwWCsI5tnKAikK5SuzCH1qqCdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTQIgVdGSFDnTZGKu9Alm6f2A/Oa9EhU1iGoUY3G7+1ui6vUE
	f3z3mQfUBgOqDZh8VPpBVzXVGKNL3KKn7WCuWJcQrxB5X8ev4gizyrT7oQj5iqzAVNLPz2u+tcM
	VZqkGOyRv00rqL3Gw14apyrA40rJGPi46xDMEzEHFwk9GjlUgAmKmHqQX6OzZIo9ljw==
X-Gm-Gg: ASbGncuT0cYyvGYje7QZpqQRHW489phcpECU7w2xKkT8fXkPjgJv+jpz0jFzK8hAOtR
	+t7nMDjBMdWWTcX6/ZXr9OVAvv/C68FZyo3AvQpX9OBFIOkrpkKNfG2q52N9lAoZBrEwuhGOiFS
	L8iHbW51sSFrCD+HgBJJ5ae8kSSRoNto9kXRHRJEzy6MLkaHO654jPowpzhimmema/fpqMKUlwd
	MWBHiTeQMkPqeZyleChQS+OOml9+QEd/cPOAXndwRPjXyRdg+6EZV/p5cyS8PeJCmwj+6wl+h0t
	CnFThc5iDSqdnCHg9KtueXnoPnJYBP+jEUnHR2nwpMsfIy9zNVFtfqInuiDUJ7NQHIISQIrdLZ+
	Ivvu4ek8GWIjzLwmCukYLEJw/t4YMukU+AxsUGWZMa2CvY6vp/zN2zcjBpMXyHo/OBxA=
X-Received: by 2002:a05:6000:2283:b0:3a5:8600:7cff with SMTP id ffacd0b85a97d-3b5f1875938mr14092624f8f.1.1752589008392;
        Tue, 15 Jul 2025 07:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtF3aNyi3pbj6yCkk1zAFYxYfd7ezRbzUP3crF9cjiRso9uL/U1MBxt8As/NbiPD2fcAEmzQ==
X-Received: by 2002:a05:6000:2283:b0:3a5:8600:7cff with SMTP id ffacd0b85a97d-3b5f1875938mr14092465f8f.1.1752589006625;
        Tue, 15 Jul 2025 07:16:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm15527533f8f.14.2025.07.15.07.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:16:46 -0700 (PDT)
Message-ID: <d7fa2e67-1960-4b1f-a8b7-147371e37010@redhat.com>
Date: Tue, 15 Jul 2025 16:16:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pankaj Raghav <kernel@pankajraghav.com>, Zi Yan <ziy@nvidia.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
 <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
 <c3aa4e27-5b00-4511-8130-29c8b8a5b6d9@redhat.com>
 <dca5912a-cdf4-4f7e-a79a-796da8475826@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <dca5912a-cdf4-4f7e-a79a-796da8475826@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 16:12, Lorenzo Stoakes wrote:
> On Tue, Jul 15, 2025 at 04:06:29PM +0200, David Hildenbrand wrote:
>> I think at some point we discussed "when does the PMD-sized zeropage make
>> *any* sense on these weird arch configs" (512MiB on arm64 64bit)
>>
>> No idea who wants to waste half a gig on that at runtime either.
> 
> Yeah this is a problem we _really_ need to solve. But obviously somewhat out of
> scope here.
> 
>>
>> But yeah, we should let the arch code opt in whether it wants it or not (in
>> particular, maybe only on arm64 with CONFIG_PAGE_SIZE_4K)
> 
> I don't think this should be an ARCH_HAS_xxx.
> 
> Because that's saying 'this architecture has X', this isn't architecture
> scope.
> 
> I suppose PMDs may vary in terms of how huge they are regardless of page
> table size actually.
> 
> So maybe the best solution is a semantic one - just rename this to
> ARCH_WANT_STATIC_PMD_ZERO_PAGE
> 
> And then put the page size selector in the arch code.
> 
> For example in arm64 we have:
> 
> 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> 
> So doing something similar here like:
> 
> 	select ARCH_WANT_STATIC_PMD_ZERO_PAGE if ARM64_4K_PAGES
> 
> Would do thie job and sort everything out.

Yes.

-- 
Cheers,

David / dhildenb


