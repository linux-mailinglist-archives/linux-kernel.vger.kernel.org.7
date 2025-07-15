Return-Path: <linux-kernel+bounces-732026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB4B06155
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D66583EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC21DF258;
	Tue, 15 Jul 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/ySLpw6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A63597E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588917; cv=none; b=dPof69BQRau0VQi1gN88ulHhV44qayuTYP1j0ilsDL2jx2R49Hd/NVKnPYdk9hgNtJAR50duyZGsRp1L2dB2pERK+3t8zmrIHiiqEi3Jfv4rJzLNI+46lDXpcaknjHaH5vwUScoBwW0Fx8Tzk3WkINVXt/RTCq9//GBauA4w/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588917; c=relaxed/simple;
	bh=cYRvBfFBk+zWv7ODYqVflfYipFPbgCULQ+V/P58YDwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p91AGTRawnNKHHJ2HI4Si+tPWblD+pSmbcsvf8Odcz85eTHHc5dEqFQwUXny47WnfE8hThfvEw+/HLeGQcIl+SyJ/InrrAIAhneNhKnO5mjEpP6eywkLnabsNvLXrybWCpC8IIyHiS/5ww/iIxgJTiVz98SXzHS9lbQuSScy+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/ySLpw6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752588915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHaC3NM9+QwIy3pXqxbGtfDGOu55CkwVkRhyKfVul1g=;
	b=Z/ySLpw6omxvKL6PhmrNOYe8ObXkk+1FdF7a0NfroDtg1eVcWwm6V18FlAw5sROKFUToeI
	V5oYxbBFxO9eiz/6OI82LzBe5fKMK6e+pXIbKIEdu6+1dQ04Cx8Vx9gZ7X6VXw8ejVjXi6
	ewg1gwibzO8hr6ln19Xm5kupDs1Xixg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Scccbi0GO_ysHHtvIty8yQ-1; Tue, 15 Jul 2025 10:15:13 -0400
X-MC-Unique: Scccbi0GO_ysHHtvIty8yQ-1
X-Mimecast-MFC-AGG-ID: Scccbi0GO_ysHHtvIty8yQ_1752588912
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so3409663f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588912; x=1753193712;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHaC3NM9+QwIy3pXqxbGtfDGOu55CkwVkRhyKfVul1g=;
        b=aDwHmHDGLuM3Ta5Ur+xKHO+/FcbY1gxz5j76wOmup2C36Tctm66Wk5xp9vyObWoeZs
         ++F4Qh4pjPhd6xGeS3uHzZ9YULGzxvkghr47GM4eJeRsL/z2A9+qwf2nn6K6SPmoniK+
         XmEXerL1oeeyLgVHPCIDCDKGZmFlG8u4rkO3DjQ0uL983GSeXa/ByfwItErzThL4X/iv
         PSlbxrkGX8VgHoiMH5lug+qDhS9I6quFbhnQ/STZLeTckQKkzVS4zr/hf4gK0elkR8Jt
         IGqDGFnF6VtTBNFrY5U3Em6wMyW4/U2DgxZqZG0rGazuDD03AgbODTEul1xpX694LS+k
         DJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCX0R9HeZoJGXC+ZRFNZRWKiQOkI3TCGTNKL9GSiRgy1Yl8S0U4BMKVKJ526nstpjE1vZZM30g0CqvpYXec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjktq2IVp0JQwCVfHBaija0DN47egDcnI/aVXxBlb/kfa3+ex
	6CkF/wbh3FbI+NjApcVCaIK5B5LPoh8WywTaNoTJN9jfgyhlNvDDbgdThi+UMQMOBsNuvCHcw0U
	tgDCNwDdxlClmH55V65CTxd8tLVMeW1g9ISF7lavSOR/B+p3FX7uY53h0syVEi/HqOQ==
X-Gm-Gg: ASbGnctUe/DlR9oIhls9U7tSxYj6T+gYJqZ8B7db14Wh96NqcLsCzd607TsoNc4LkqO
	EZxzCN4MFLI88PBfS1R503ke2vX209IHKT3+f9111uZGbEV+U8D/JoTpfjRo1jlMtmojsoEPTCO
	hWkOQ2uEhLTNm2f3gfnp2iPKcKPYAUKF8jvAM7LpPMdijpPqLv+vZt2/9F8boyloAelJOU07jYJ
	YeJkZy54bM9aDJCbZ+m/bdjRnz80z/hAs3lmB/hdSF1a4rSagh+JS4DKBRB/G8kc8ZXzVa8hX2h
	9/2eYtub/jDwKzg6FZKEmy93EimZGyPVG1QN0A2/XbRspxUT1D+KjrwnNXqwkCubeBbuxCmfjn9
	7O/qUNZXsPMPVPvUVshw/dnatUw8HX+imRFsbY6Ohe1H3wibYohvbowFl0yqaaH8a+oE=
X-Received: by 2002:a5d:5d0c:0:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b5f2e448d9mr10913832f8f.49.1752588912207;
        Tue, 15 Jul 2025 07:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpyohQnpn/KxIdJ2KMc18WnTagGh3ivybzKaAC/ozw+/YD8D8CtWgwEjyEVReYxDXso7vSlw==
X-Received: by 2002:a5d:5d0c:0:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b5f2e448d9mr10913779f8f.49.1752588911647;
        Tue, 15 Jul 2025 07:15:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm14841701f8f.8.2025.07.15.07.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:15:11 -0700 (PDT)
Message-ID: <9c9b78fd-4698-4982-919c-34e679bbac84@redhat.com>
Date: Tue, 15 Jul 2025 16:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Andrew Morton <akpm@linux-foundation.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
 Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.25 00:38, Andrew Morton wrote:
> On Mon,  7 Jul 2025 16:23:14 +0200 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> wrote:
> 
>> There are many places in the kernel where we need to zeroout larger
>> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
>> is limited by PAGE_SIZE.
>>
>> This concern was raised during the review of adding Large Block Size support
>> to XFS[1][2].
>>
>> This is especially annoying in block devices and filesystems where we
>> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
>> bvec support in block layer, it is much more efficient to send out
>> larger zero pages as a part of a single bvec.
>>
>> Some examples of places in the kernel where this could be useful:
>> - blkdev_issue_zero_pages()
>> - iomap_dio_zero()
>> - vmalloc.c:zero_iter()
>> - rxperf_process_call()
>> - fscrypt_zeroout_range_inline_crypt()
>> - bch2_checksum_update()
>> ...
>>
>> We already have huge_zero_folio that is allocated on demand, and it will be
>> deallocated by the shrinker if there are no users of it left.
>>
>> At moment, huge_zero_folio infrastructure refcount is tied to the process
>> lifetime that created it. This might not work for bio layer as the completions
>> can be async and the process that created the huge_zero_folio might no
>> longer be alive.
> 
> Can we change that?  Alter the refcounting model so that dropping the
> final reference at interrupt time works as expected?

I would hope that we can drop that whole shrinking+freeing mechanism at 
some point, and simply always keep it around once allocated.

Any unprivileged process can keep the huge zero folio mapped and, 
therefore, around, until that process is killed ...

But I assume some people might still have an opinion on the shrinker, so 
for the time being having a second static model might be less controversial.

(I don't think we should be refcounting the huge zerofolio in the long term)

-- 
Cheers,

David / dhildenb


