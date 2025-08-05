Return-Path: <linux-kernel+bounces-756406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7DB1B39B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF11717EBCA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3E271471;
	Tue,  5 Aug 2025 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhNusIZ2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743F17BA9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397705; cv=none; b=WmhQfCxGkR9uTezEZAR3VaZQYime4F61PpWB5uZm+jnnpbH73JjAuc6F5zvstkpnEtRoy/+aKNHyCoKQdHd2cQfa7xd04lg5AUyXbiqbHyBA941lHagkCL5XYMl/rNa4Td6IFLTR9GGz1kaNsOaQFiJwt0oGkgXKKmQbF3BeW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397705; c=relaxed/simple;
	bh=4edKX8MFzsIe2nUyt0nx9Wcw7CNGyzbjHNoleZLrPrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doWeth4k0ZD1Q1MVYursEUyLoYqga1lZC4qnOjpo+miiZwWtfs8DLX+8mRGn50AXE+1cDdSt95ui0HpezFpxZfPXRToZ7ucFb6zoq8CeY4VmMxEhAFyVI37K7+dE5RkJQR4B61a8N8Dt/ZcqeqpEfYJElea6qdEO+/S78iqFKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhNusIZ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754397703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7uQFaJ04uOldMqJWhw/ZrijNlur8OaDP5isRSjWvgMQ=;
	b=RhNusIZ2RhYrf5ePdpLvm1anB6mnUVP47tz2iT/rPhH3za4ldqm1IC0GxmHQ74//U+CVPB
	y0YeJHP2tLgFXxci4rJWC2DvpROlnB3pWj2SMyPiUBQPpq2gORqz71mB3OtZjpgzuGrAIo
	zJPTyo2E/j+qks1jUQuDpPH6pMqbsEo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Tq7bJys4NymQBM2f2BMIpQ-1; Tue, 05 Aug 2025 08:41:42 -0400
X-MC-Unique: Tq7bJys4NymQBM2f2BMIpQ-1
X-Mimecast-MFC-AGG-ID: Tq7bJys4NymQBM2f2BMIpQ_1754397701
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so2261826f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397701; x=1755002501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7uQFaJ04uOldMqJWhw/ZrijNlur8OaDP5isRSjWvgMQ=;
        b=RSf/OjoaYW75OmjCIdAO4ADs5V0qM+UMS+bMiUdT0vIQwTUbM6id3ti6w4aZqq7ANj
         AmeKDJtZtVBcnyXwnKdPHjYleh0VdWM15AKBIHPAx7Lt6xixg1ZCxI9ldDMWOgXsHEV8
         ryXoz+Z9KLCOVk22ESK7CBYQ9V/oulUT9VSEFJRqWgJ7cET1D/twCMjTOK8NoY5C9C1a
         VcIGlRbfcTan9lEbKDDoU6w00t039ldhfgxJTeA+Ee9cE0tRppBQmUu6qTnsyUgrX+2P
         aVcBGsuH5AFEfFU1MO5ldPdQpjWiCFvCQyP3+y4JxaqcHDCq0y2fp369PTRe4hXWh3Yz
         r2+w==
X-Forwarded-Encrypted: i=1; AJvYcCU/CKJ9eFCh8DRksxTmvX5KPI4DfscNGRuOUghKjwfvMNkREZOSvR3JzXqTKimxr3KGpa5KxfQUKu7Aioo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HNq0eOIabeSFr9g+GkIUJibjjvMGkBF4ZzF7X/Vso+RvaVat
	qFZkJsj/K7m2hssgEYotNsEsxFZHS5MiWq8KSBB4+qm01MlBfT51YBg6armY4zC6I4V/QxRrwoR
	H7HxIuf9lT/vAR2wPS7ukMZVKowKmEdliuX91W6KCfbgtQVH+g8OjzxyOSmS+XlbrDA==
X-Gm-Gg: ASbGncuqfXUpjh1Cp7udcokmS8UFYQYUWWrg1BI/5vor9y8Xtif9NlpSEunGojIz8Wt
	tB8Fk0UIirb5cwUGpRzBgVTnsv/q3ClmrrrfJYaRArZ9WrPUMnMPkoFq7tCF+RsOYRPNK8ZfZH4
	lrtaSB4bJAVfNLZdTApqJ9xwxSRFRdw+IQ6ZBRaENHA5g32/zdU0SOTRs6Be/0ujjoE2dM21xr6
	3Vhf3VNfZXly+gtw3ligjKY0YxB2MNedgrkafiGcboakfTl7uetOsnvgRkB4OXhblk2RL4AvbmE
	RbDx5aIJO3L03c8H14VR8d9Mga5Qk3z80gOgxegbnt2CFlQRrHHNWCfPmf/NkgG7XySSYew=
X-Received: by 2002:a5d:5d10:0:b0:3b7:970d:a565 with SMTP id ffacd0b85a97d-3b8d94c1cbbmr11020610f8f.46.1754397700825;
        Tue, 05 Aug 2025 05:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoBs3LRRrnqueBBh8exXTO/EKois18at+tf4gceWomdxr1F6hie41LrH1QETZPlxlL1PfTfA==
X-Received: by 2002:a5d:5d10:0:b0:3b7:970d:a565 with SMTP id ffacd0b85a97d-3b8d94c1cbbmr11020590f8f.46.1754397700399;
        Tue, 05 Aug 2025 05:41:40 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a26f.dip0.t-ipconnect.de. [87.161.162.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47c516sm19149849f8f.62.2025.08.05.05.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:41:39 -0700 (PDT)
Message-ID: <db30f547-ba98-490c-aaf7-6b141bb1b52a@redhat.com>
Date: Tue, 5 Aug 2025 14:41:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lizhe.67@bytedance.com" <lizhe.67@bytedance.com>
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com>
 <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <20250805114908.GE184255@nvidia.com>
 <9b447a66-7dcb-442b-9d45-f0b14688aa8c@redhat.com>
 <20250805123858.GJ184255@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250805123858.GJ184255@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 14:38, Jason Gunthorpe wrote:
> On Tue, Aug 05, 2025 at 02:07:49PM +0200, David Hildenbrand wrote:
>> I don't see an easy way to guarantee that. E.g., populate_section_memmap
>> really just does a kvmalloc_node() and
>> __populate_section_memmap()->memmap_alloc() a memblock_alloc().
> 
> Well, it is really easy, if you do the kvmalloc_node and you get the
> single unwanted struct page value, then call it again and free the
> first one. The second call is guarenteed to not return the unwanted
> value because the first call has it allocated.

So you want to walk all existing sections to check that? :)

That's the kind of approach I would describe with the words Linus used.

-- 
Cheers,

David / dhildenb


