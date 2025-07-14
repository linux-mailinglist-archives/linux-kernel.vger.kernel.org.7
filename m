Return-Path: <linux-kernel+bounces-730441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BEB04494
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57263B69C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36B26058D;
	Mon, 14 Jul 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRezMyDs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446B25D21A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507713; cv=none; b=Wr/1Zs207Z9p0n5cjgyYegzwXgP4y3n7tDUTivfXf4TGCqPmZWXaqPwwcelvwVSVn9Fmsz2HF/h7mqG1vCoUjzjG8d0zgO95I1pA8F/WtRlaQVs5P326LuUDmUrNmUf8AOdegIC71SQc9cxlsRYpDWxHDv/+Fj4s/EKpzFwd06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507713; c=relaxed/simple;
	bh=nyxTj66M8SeFzlKUf8cjUsIM6DR6iRRe1sAL9e1amJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJtnJhZSwybwKUJE9kZKSJLlmrdvq7ErPDj5YS2XAidjNpPyQJs3XxP9Zoy+jZlpjvVrAVkpw27kJmk49vUIVBeccJGfl1JFOCI91WDhimt+jTvFd50z6eMfXNLYKYlYAeks/1ren3Qaj4GndgAQN2ID087u48t7NEtl40qsK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRezMyDs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752507710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EyL8PLULJWxZs9v5o3OvV8o7HM0f6+3a2rmXQeELJI=;
	b=TRezMyDsOS7ByIXmgmTyqLHD6IlkSej7YmJwyEd2aFmOsxvVKgDk78azOV2nAiajNr+qr1
	FnwiKY1XRdOOnBmLKuVp6zMaE33XBnBI0HnvQWvV6pWwfF9xsGWb7d7czizYiolny1OvWb
	D0KYZXa0OPduzFT2k3wxeYTMW1Xkcv8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ALs3qIA-Np6Ti_A_CDZ0yQ-1; Mon, 14 Jul 2025 11:41:49 -0400
X-MC-Unique: ALs3qIA-Np6Ti_A_CDZ0yQ-1
X-Mimecast-MFC-AGG-ID: ALs3qIA-Np6Ti_A_CDZ0yQ_1752507708
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so2716226f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752507708; x=1753112508;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EyL8PLULJWxZs9v5o3OvV8o7HM0f6+3a2rmXQeELJI=;
        b=n58PlFDpEra0vk4iUjUHbkEu4sd0F9Q23Niry60XDwX/z0nvYEmG28cmobJSeP0A+Z
         BYLBL81IRKuqFrxZPnvAnDaI5vs7NUATCsu2AN7dIXqbt+9uJ20JP1xV5gIJEST/daUg
         zeLafHDaNhXK2EEnplyC/2RVHkbdiGLhTkLQ7MieC/h9AOJJGvlegbXYKvSuIjdGP1qi
         GxiPc2xGxIzi5HPaTiGMejRpc6IoBiJRYmnSzZyftDBIERhjazpk3FS66lIWIamufGUi
         VOyNEI3ztZK1hmBak89L1NNAK+QT0FTPxbLhZkBKvyBPIoFmOJ4BYR4LYeWzrmK6CcjR
         EyGA==
X-Forwarded-Encrypted: i=1; AJvYcCUCquRUlW2UGoiVuoPDXdMYgANA6OVbyaev/aVraEEQ5EibtmpH0TRLjmGgFezOHCA2HsRbCZ3CWZFjlew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJCtySN7uLlmc5Vb0fKmmU8lA0f9f+3hEkDejfWl+pVw+Y5xW
	5D2VCNze0Uc43tacRrojdhHIvMTcV+U1vyv1PnYvs9E5FsQkZrnq8mA8bPGVfNGiH/nyBsOxSst
	efBUiHkYT9ox/+1hQ5Ss7cH30WYnVVPP4esWhZadd8+O54jPMQOYBSQkrTqCye48LLw==
X-Gm-Gg: ASbGnctUN/WtWmfrxYiAo8aLnvHi+slO7fZUZtQbVv1n0uCqpZ2fyVsIpaYs/L62zyn
	hiUHRx42Cd1a2HmbRkjjRl2a5pWyJpeCy/hasGa88gb2YaLViGHPQKrHzOlL3bl4DORns7ZiADG
	jcLQilKtWfEZTq8cNx87e0nBtEBhRc3NGyu+Tm+f3AOtfLSLQIVdiEND+zkZhpR67Attbntqglt
	kUBi8WJlQUGpvkWUfACU0uLV+t6qBgtIzm7QFlnHL2b8fWZYcw+sjk4xOvBBC+HVy7s3SGFTnqw
	rUpxHpbqRRwh+sw5slamrt67/dHKTiISbadtPEMmnGydtJojBgznl+8ycEcH1+glf3uKXifd578
	6S9hhtNRFFWr+dBFXROpUNBRWyfSESUppi9TEObAvzAk6D6BVICKKTY18qVlwlchY
X-Received: by 2002:a05:6000:2c0d:b0:3a5:2e59:833a with SMTP id ffacd0b85a97d-3b5f2daced1mr10276328f8f.1.1752507707677;
        Mon, 14 Jul 2025 08:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA+vpiTVyDW0Y0eRYnF2q3kdwdJv9gAxFHSJQiQYyQSRu1MZxBbP8Zvi2kVwgyOqxbXDZ3wQ==
X-Received: by 2002:a05:6000:2c0d:b0:3a5:2e59:833a with SMTP id ffacd0b85a97d-3b5f2daced1mr10276311f8f.1.1752507707297;
        Mon, 14 Jul 2025 08:41:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45617f18d99sm44212725e9.8.2025.07.14.08.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:41:46 -0700 (PDT)
Message-ID: <184d7f4b-6ffd-4047-b245-aec32ebda9d6@redhat.com>
Date: Mon, 14 Jul 2025 17:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
 <nnm4cmygbeyzwxfwqduo5lq3d5cthuic5irof2l3tb5x43n2hz@mmjklktcfk2o>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <nnm4cmygbeyzwxfwqduo5lq3d5cthuic5irof2l3tb5x43n2hz@mmjklktcfk2o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 17:31, Pedro Falcato wrote:
> On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
>> [...]
>>
>> But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
>> mapping?
> 
> IIRC this was originally suggested by Linus, on one of the versions introducing
> mseal. But the gist is that discarding pages is okay if you could already zero
> them manually, using e.g memset. Hence the writeability checks.

What you can do is

a) mmap(PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, ...)

b) modify content (write, whatever)

c) mprotect(PROT_READ)

d) mseal()

But then still do

madvise(MADV_DONTNEED)

to discard.


There is no writability anymore.

(Just a note that, with hugetlb, it is fairly common to 
mmap(MAP_PRIVATE) empty files and only work with anonymous pages.)

-- 
Cheers,

David / dhildenb


