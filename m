Return-Path: <linux-kernel+bounces-743050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC8B0F9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5B03A89B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6C20F079;
	Wed, 23 Jul 2025 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI4uJKob"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707F1E8324
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293783; cv=none; b=LCaVXZfFOS0ZTWFRdHRb+UWc6kN9R2QFg8anIRQ72QyjZ4WuCW3BjG7Po/9LH9nh8MDg4lnOHiYjCuVgaJ34CEnakQ64zdeWyDAYQs9hCt9GDuVe3aMQDEt/fhcPO3zfZ2hIsNZX4CXWOlVWCKIeGe7b8fjVNiPdVQbEjtF8bho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293783; c=relaxed/simple;
	bh=2iebzDMl31aYqICEJCQtJeRntCkcwu/khnNK/tJyxxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5mtOITSx33mefzYjyh7613abDVqlHdZ9ES7R9SA0f31ArKq4m1Jewu6bxxAz6pnbiYz1n8JQd7wPeIPVlci1I8q/NmiIWsx+QX18R4vkpDD4MIbi6yqkMFcLmb/syNpyA8fWKhU1IrmhdBMkEwjfwu2jkIRWvarcvl5Fhu5OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PI4uJKob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753293779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G3whOxkstbMxt2nhGLk1bQZXFsEZXlxQlt2XWZxhuog=;
	b=PI4uJKobDM8mGXiDPr+5RqREWz7fXvaXA1eYPH+DO+N5v2DEnjAsYOuS3AWiWS1L+SYpyc
	0PEa9cHFUgRazPkGw3mps+9TKHVflMWWpVBylQv5HX7ds1VDuXlHZXlRTxC2tFS+2DnuBw
	EyuXAtq+wmACbOtWqn5ggweecnCCUdg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-ces8b7akNQ2AgstRsn-1Pw-1; Wed, 23 Jul 2025 14:02:57 -0400
X-MC-Unique: ces8b7akNQ2AgstRsn-1Pw-1
X-Mimecast-MFC-AGG-ID: ces8b7akNQ2AgstRsn-1Pw_1753293776
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso58374f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753293776; x=1753898576;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3whOxkstbMxt2nhGLk1bQZXFsEZXlxQlt2XWZxhuog=;
        b=iWuLzPK4TvB/r94nOsp2jBFuylApewQTFrvraGDFz3jhJskS5xeVvfT7RFsGQ+qmUV
         KVIcKFS95bLusRN5ppgZj3WJgTM4KRy3jGzF8jJtapnoSk10cMG296NyNPf4V5rXK1oy
         V8svT0i1rIkJPf17S/DRwbqgCx5hW/p+ebXoXPkrPwkXRA5x0AlrZPgrnyVN3/KUhHSy
         sNoyj7SDdHYAgqdTcS11bAk81raT4rsKe9v7BaE8jH5UhfbFfr+VLaAlzHlY4YcM3o1r
         JisbRUxMjEJA588lxXAQCFh3Yv0qx3UPqyqYiPrbap2sX2X9lJJZ66LVDUnwszIAJck7
         QQQg==
X-Forwarded-Encrypted: i=1; AJvYcCVH6eh+cKWx5iN/DlhyRjD/1pMv48wztqRgVn5X5GJQ3RNjxtMi0ciyyLkdVoTrOuB8YIH/Ubjw8Vo3Lco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vS6eD5MHiOHJwuJsmDa4P8rAEb3WoO426M7994cu2YogJGP1
	2InvofjgzknLTfyvlIAKOQjhUUBU1hSdd2urXNTJhToISGqtKsywe1G5sPuNn2ppUUFCfx4ShJL
	AU+hiGH0AEsM/cEGVBbya1cVH6KCH4/OhlnpRqlZpbXUR19aDuvh74EIhee1T7Q+nrw==
X-Gm-Gg: ASbGncv8sn7yUSuy1qHudeuZJtMGjxYDR3tOguiytB0Dl5VHNbEg7fEy8kwcTeuIRpm
	6u+uzsYoizmhtABXVAfoVn+qFps2C+dxzFvmj2uSgaJshMBCQW/knPiWMjpdGcYPW3foLgPnmvF
	eXM2DEiH+K+KkR1YAHLkPoB9k9EOhpM4yVxSy4RjiXVK2STcbbJV8QxnNDCfm/rMkRBfaUalXgW
	GhO/h8CRXq7CWGKBje9eZ/CGXcMF720fGG1ZwsdrO7s6DGbrOjSDZ+9DwXYJn199V+vZu8kTZsk
	XicbwETMQ34hcQTTxmmF88W2MCEyGg7vO/CQbN+PxFFix8ZWFDJWjg5K9taB8bZ/tecXlQ==
X-Received: by 2002:a05:6000:2013:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3b768ea011bmr3550360f8f.17.1753293775536;
        Wed, 23 Jul 2025 11:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEZg16J4+gnyGIzNr4yWSx/6st9lfF2anNLh6lxP/xRh+IjVjl07vljj/vUaQGCZ849yfF1A==
X-Received: by 2002:a05:6000:2013:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3b768ea011bmr3550304f8f.17.1753293774863;
        Wed, 23 Jul 2025 11:02:54 -0700 (PDT)
Received: from [192.168.3.141] (p57a1af43.dip0.t-ipconnect.de. [87.161.175.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691b2adesm29652445e9.32.2025.07.23.11.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 11:02:54 -0700 (PDT)
Message-ID: <383a957e-badb-49fc-9913-30bea3a1c5a8@redhat.com>
Date: Wed, 23 Jul 2025 20:02:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
 Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20250721090942.274650-1-david@redhat.com>
 <4a8b70b1-7ba0-4d60-a3a0-04ac896a672d@gmail.com>
 <5968efc3-50ac-465a-a51b-df91fc1a930a@redhat.com>
 <003c12a7-cb3b-4bbd-86ac-4caaddcabf26@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <003c12a7-cb3b-4bbd-86ac-4caaddcabf26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.07.25 19:07, Usama Arif wrote:
>>> Thanks for the patch David!
>>>
>>> As discussed in the other thread, with the below diff
>>>
>>> diff --git a/kernel/sys.c b/kernel/sys.c
>>> index 2a34b2f70890..3912f5b6a02d 100644
>>> --- a/kernel/sys.c
>>> +++ b/kernel/sys.c
>>> @@ -2447,7 +2447,7 @@ static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
>>>                   return -EINVAL;
>>>             /* Flags are only allowed when disabling. */
>>> -       if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
>>> +       if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
>>>                   return -EINVAL;
>>>           if (mmap_write_lock_killable(current->mm))
>>>                   return -EINTR;
>>>
>>>
>>> I tested with the below selftest, and it works. It hopefully covers
>>> majority of the cases including fork and re-enabling THPs.
>>> Let me know if it looks ok and please feel free to add this in the
>>> next revision you send.
>>>
>>>
>>> Once the above diff is included, please feel free to add
>>>
>>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>>> Tested-by: Usama Arif <usamaarif642@gmail.com>
>>
>> Thanks!
>>
>> The latest version lives at
>>
>>    https://github.com/davidhildenbrand/linux/tree/PR_SET_THP_DISABLE
>>
>> With all current review feedback addressed (primarily around description+comments) + that one fix.
>>
>>
> 
> Hi David,
> 
> Just wanted to check if the above branch is up to date?
> 

No, I forgot to push. Now pushed.

This is the diff (excluding description changes):

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c4127104d9bc3..527aa4c9645fd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -324,8 +324,8 @@ struct thpsize {
          (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
  
  /*
- * Check whether THPs are explicitly disabled through madvise or prctl, or some
- * architectures may disable THP for some mappings, for example, s390 kvm.
+ * Check whether THPs are explicitly disabled for this VMA, for example,
+ * through madvise or prctl.
   */
  static inline bool vma_thp_disabled(struct vm_area_struct *vma,
                 vm_flags_t vm_flags)
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 1949bb9270d48..60e496ecabe04 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -179,8 +179,8 @@ struct prctl_mm_map {
  
  /*
   * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
- * is reserved, so PR_GET_THP_DISABLE can return 1 when no other flags were
- * specified for PR_SET_THP_DISABLE.
+ * is reserved, so PR_GET_THP_DISABLE can return "1 | flags", to effectively
+ * return "1" when no flags were specified for PR_SET_THP_DISABLE.
   */
  #define PR_SET_THP_DISABLE     41
  /* Don't disable THPs when explicitly advised (MADV_HUGEPAGE / VM_HUGEPAGE). */
diff --git a/kernel/sys.c b/kernel/sys.c
index 2a34b2f708900..b87d0acaab0be 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2438,7 +2438,7 @@ static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
         return 0;
  }
  
-static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
+static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
                                  unsigned long arg4, unsigned long arg5)
  {
         unsigned long *mm_flags = &current->mm->flags;
@@ -2447,7 +2447,7 @@ static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
                 return -EINVAL;
  
         /* Flags are only allowed when disabling. */
-       if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
+       if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
                 return -EINVAL;
         if (mmap_write_lock_killable(current->mm))
                 return -EINTR;


-- 
Cheers,

David / dhildenb


