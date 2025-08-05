Return-Path: <linux-kernel+bounces-756494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546EBB1B514
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A695262240D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8CD275852;
	Tue,  5 Aug 2025 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWA1RlYu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB982274FE8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401071; cv=none; b=rfMJd5eUHc6ftHJD8BH9DFOV/Qg6wvQLKiXH5jkekbQGsqiSPC+ZMUo/WoE828VekDG06duknl1kmAvamVMOpXbIsFSK2ahPmfBCntVCpUxFsmmtKpX2f7voATwODrr7OA5fzypivhuPCjtGD8/womzJHpy/qRPxQf719Y5fSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401071; c=relaxed/simple;
	bh=ur+3rk3Cc9JxozYX7NkdoqtewqGkG0MR/5EJ9ydJpnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI+tl8ORp2aPKgRbcLFz7TWrlO3xk+Q/IDj5TDG7SunoKKz3/D78dl6MpS6VsyQoBWPLKLuQBIf1eimQFUgDUTLyEgcs+Sqaa6Rr5aqws7TzFIUrtsA6A5xtq6lL4Bv518mhC8bJgqtWFWH8m4nx2N8RM7LFlk7WufWdQaQ00+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWA1RlYu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754401068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UpjJgzh4g7dtAXCY59lGQTt1+v956Gh1WPJKYgAgYz4=;
	b=OWA1RlYuSWfrhgmFvihdx0jnP8RlcRWiaoPXU77/8AoOYmdDUlKN997eLYWrWdE1s8v+KS
	swOSSX3K+yGinIP4NN9X10rnVM9da1MCpTEUq80DCpFa24hUtdrgKSg2WZDWOMycGdV7ND
	XSHw6CSW2X1QMiK8ZVloU6fAGCns7t8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-i9jzWm7DNEWPioGj4iXGkg-1; Tue, 05 Aug 2025 09:37:46 -0400
X-MC-Unique: i9jzWm7DNEWPioGj4iXGkg-1
X-Mimecast-MFC-AGG-ID: i9jzWm7DNEWPioGj4iXGkg_1754401065
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459e068b5f4so7712475e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401065; x=1755005865;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UpjJgzh4g7dtAXCY59lGQTt1+v956Gh1WPJKYgAgYz4=;
        b=a/tg8lxvluVjv2fscrxj+5WdLDqG4POhjz38k4CpXuP0jyrr09AU+aFEcSBPDOREQC
         F2/ByD0BHZ8KtttE1bijqmpyWI8BQgiqIqKRX5Z8+RiTgGowWcRr1XtJNzf1A9S8ouw7
         usKf+YGGaWue+GKVHT9WmHOYD1L/Z7Fo1jZ7okF+NIPkInvA0QSdpf8WnREIp5GbYHPx
         7WSA6E/B0EjRAYUcWVhSZjE64xnPz+EjUrvTm9yykTKyfqxyPD1bEldYAJlPucSn4PAD
         SG4ypRNIIU8eKbXula3jnKcQx0ijrwRK96ORI5+Qiz73Y/ZDOACWDJ1IdCPZ+drM6Alf
         lBDw==
X-Forwarded-Encrypted: i=1; AJvYcCX75WsVFMSu7Qi6tlXKxv7H6kJlEMNZ2TI3zorGWM8B6xjB9P2XN3I7Xh3CBK6mc84SHggnam9l7l8ND7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Svq+3dX30sKtqGZbAlP4a8Wr2frHB98sMVNnY0OFoDDit2rY
	JrD341RdqSX+cB1gFgiFpL/I+/JYXtlY3ErMky2avu/LFx4fEfmB8RYJlqqbk3dU4bciBIMk1u/
	D4n7B5eqS5ovmy9sz1xst1B+8MSsWLx47Y+uWA04UJcLocmDF7HrEdt0936ykTmnHCw==
X-Gm-Gg: ASbGnctnNnpGkb+2sJT+ggE2iouHfavNsf+ueNpxT26dJK+oArnqJwRn6tvsOrnFXkq
	TEAQjDnn6+t4g7Nl/ZtGjofar2opkkvxIFLpKsMNbfj20hwd4OCc3gfL/cxnQwj4OYrR3v5aAxU
	EggWUxg7AT5OFTJ7kZw5+q6YtkinnllSxNvprcOAwUoOkrN+TN8IelFWfRTaCDxES9yfbla4g9H
	7itpsg5khYTQMUBkuUZk60up22pcfV0r4andHOPhCOhTqTZXeOmT++h6WEfNzKhAjdHkOMPjWpJ
	vAVFinIH8T6oOTLRlqagU5oEmaETI127EatV9YEY439jRkevTsTwDjVAbm3LbtH7uawW4x78qbZ
	XNZT+Bmfce1DvRVSJKyX75obuPaVvekEp0Bn3jNWD8WfYmr/vqhdifXSVhpXfwotSeLk=
X-Received: by 2002:a05:600c:8b23:b0:456:f9f:657 with SMTP id 5b1f17b1804b1-458b6b667cfmr92362315e9.27.1754401064935;
        Tue, 05 Aug 2025 06:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElocaX9QbGihnr0Q8xsLrPze9EwN7eJJPY8YcWv8xr6TcgxKbF1B2JLhwFKxBC9bp7NuGp5w==
X-Received: by 2002:a05:600c:8b23:b0:456:f9f:657 with SMTP id 5b1f17b1804b1-458b6b667cfmr92362075e9.27.1754401064499;
        Tue, 05 Aug 2025 06:37:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4532c4sm19122359f8f.36.2025.08.05.06.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:37:43 -0700 (PDT)
Message-ID: <623c315b-b64a-4bb0-a5d6-e3a2011aa55a@redhat.com>
Date: Tue, 5 Aug 2025 15:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lizhe.67@bytedance.com" <lizhe.67@bytedance.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com>
 <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com>
 <7f891077-39a2-4c0a-87ec-8ef1a244f7ad@redhat.com>
 <CAHk-=wgX3VMxQM7ohrPX5sHnxM2S9R1_C5PWNBAHYCb0H0CW8w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAHk-=wgX3VMxQM7ohrPX5sHnxM2S9R1_C5PWNBAHYCb0H0CW8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 15:28, Linus Torvalds wrote:
> On Tue, 5 Aug 2025 at 16:20, David Hildenbrand <david@redhat.com> wrote:
>>
>> I think that would work, and we could limit the section check to the
>> problematic case only (sparsemem without VMEMMAP).
> 
> We really don't need to, because unlike the nth_page() thing, the
> compiler can see the logic and see "it's always zero".

Yeah, realized that later.

> 
> And in the complex case (ie actual sparsemem without VMEMMAP), the
> page_section() test is at least trivial, unlike the whole "turn it
> into a pfn and back".
> 
> Because that "turn it into a pfn and back" is actually a really quite
> complicated operation (and the compiler won't be able to optimize that
> one much, so I'm pretty sure it generates horrific code).

Yes, that's why I hate folio_page_idx() so much on !VMEMMAP

#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))

> 
> I wish we didn't have nth_page() at all. I really don't think it's a
> valid operation. It's been around forever, but I think it was broken
> as introduced, exactly because I don't think you can validly even have
> allocations that cross section boundaries.

Ordinary buddy allocations cannot exceed a memory section, but hugetlb and
dax can with gigantic folios ... :(

We had some weird bugs with that, because people keep forgetting that you
cannot just use page++ unconditionally with such folios.

Anyhow, thanks Linus!

-- 
Cheers,

David / dhildenb


