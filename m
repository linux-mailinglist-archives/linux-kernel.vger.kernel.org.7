Return-Path: <linux-kernel+bounces-852052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A68BD80BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 481734F5030
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC2330EF7F;
	Tue, 14 Oct 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3lhGg7F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82830E852
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428774; cv=none; b=HNimiSPZJHVqibutXxd8uo/ShsoCBaUajobFGbVKT6v8e/enHmdTRSblmU1ixzlfs3z/AFKVqUqXJZGIotL8Rd3iAvQ+0MDTD2RBydJOHHHQtcJCcVb1VilwR07sOvz6QRjLfG6dHSPZdM8KnRwRjipGIEAKnFaqXjHdLE3qFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428774; c=relaxed/simple;
	bh=srzEV4uHOz9yBYJFcr3/HRQwSQglUYfQiebcdxSVhPc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CReQAsoas18gRYhDH0ntHuvsK1g7be/9dnhcbkGFISTRrAlr09e1vCYDkYVdK0qxhFM1n0s/IOGnHIPC9dvWZkGLb6SKMgV3avvnTByQSVw5jHdsSRoZ2mSK5M3ACB9+92u+s9G0MVdHzQS7BMtQ6YV6tevbmGnXS2qD8XkQZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3lhGg7F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760428771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g+evH2w+/SD0aBvnKN9sijIvN4jHoC6G+ugKhqQCEeQ=;
	b=S3lhGg7FsSHFSVopLNmwMW5PiqiVDe7Z27Uj0AahhUD9/NEqbGZFcwjJGZNhc1VZJ+VIqO
	79bgW876zL3iHWQJpgfAyaNYnJsYVKa1T70VCOweDKsmVF1cTJkP6Ya3a/5G5V9mpHLPLY
	D5rb8PeQiGXSHRJvwKhMb61E2dDapoE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-fAPCJHrCPuG_nSVhDITMig-1; Tue, 14 Oct 2025 03:59:26 -0400
X-MC-Unique: fAPCJHrCPuG_nSVhDITMig-1
X-Mimecast-MFC-AGG-ID: fAPCJHrCPuG_nSVhDITMig_1760428766
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426d314d0deso2063217f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428765; x=1761033565;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+evH2w+/SD0aBvnKN9sijIvN4jHoC6G+ugKhqQCEeQ=;
        b=wXuNURbFDuSgqUFfSRTf84tA5gsabLfyrep5EDzMmprcsqvjHgQ/VIGK+J2CtDCUpL
         T/cG0XArzOOerJ7u3G+/UzhcSHQpzAVn4di9KDMQPuWnvDRjIqtke1m7AIV9AgptbhkK
         /KJtUBxRRCEacqtFEnEH10w+a6pkHOzp2jWwzOlofL7Cx2BGC8JJcqaVgv/catlJj1rt
         otU13GY2lrSuL+GDrywKYPh0h5yqz6seRYrv/PcvkWAnEtjOEjaG8ydmCIqE2t3TjEdh
         6Huw2d0hhNE9zmG/vicb7e29IccZfgK/djhkObOh6YM2BYPd1b0i58Ihng+ck09Typ2T
         Hhyw==
X-Forwarded-Encrypted: i=1; AJvYcCUFGoK2SnJQ0Us1Fjs1rUz6Zf0TzyVf1gt2qRswCnWGrg+RLa5k64+YQxj28b4qtQ7xwPR+h3XosJQvZlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6UiX9l7bQukRnXuz58j02Rd4KhuaRGvf4PvJPjziAddXHUhC
	+AgP2QYAaIQGXtES4nxr5PKAcfrkF8stScdx5LNofBxw3FDlASB86DbTczLJ3H7xf+llyCysxq+
	tHFbvHFzO7G6iu0TMZ5p3L67cOJbAzHvxTtajQUZGiKHzQyUbAqnw12R15OkBSlTazQ==
X-Gm-Gg: ASbGncvCDyckc7iiBsYGk/JVUvH2hUepD5WdFYO0KuJaqepOFHnUhrPWt/hj7Ww56dG
	bwyUAWDdRxFpLy8IVcJJc6Bggk9duSEgDb8fnx5D+C1dDHEtyQ3TAuLD4OAwz4Z7Cv8I+1u28yV
	XfH+kURulgypSwUyDoVB+wjX9qxC08bZ90EiUipsqoiwyUge7LUgIfmcmx2cr/cK1QBncP0Q8cY
	j+dOkOoLPm2M56QOkC03+eSt/JHLasgV0zc66R/Qt5HrUZST/2qah0HBH1WwwSZfJT5yrf8bW4k
	Ew3tbDV9XTEnesJLgISjHudx57pWSr97QTpUHXVxU9xtEsl0W/4OAQTkuOiIjp7QvHXZCOF+iw=
	=
X-Received: by 2002:a5d:5f54:0:b0:3ee:1586:6c73 with SMTP id ffacd0b85a97d-42667177de1mr15280661f8f.19.1760428765585;
        Tue, 14 Oct 2025 00:59:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE68IeQzBd2dgMq8g6Muhrra3mxHKk25wfQSGnOAJFSGP9NdV805qDrZXher1hu8/MM+LRtlw==
X-Received: by 2002:a5d:5f54:0:b0:3ee:1586:6c73 with SMTP id ffacd0b85a97d-42667177de1mr15280642f8f.19.1760428765181;
        Tue, 14 Oct 2025 00:59:25 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm862060f8f.0.2025.10.14.00.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:59:24 -0700 (PDT)
Message-ID: <57b73517-9b4a-4203-a39f-3d412ad4c7b9@redhat.com>
Date: Tue, 14 Oct 2025 09:59:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regerssion] [KSM] KSM CPU overhead in 6.16+ kernel compared to
 <=6.15 versions ("folio_walk_start" kernel object overhead)
From: David Hildenbrand <david@redhat.com>
To: craftfever@murena.io
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, regressions@lists.linux.dev, xu.xin16@zte.com.cn
References: <80b153cd-8bba-4bcd-9b56-3b2ad3f295e1@redhat.com>
 <46d26246-5bd5-43f7-b1a4-dc721f717413@airmail.cc>
 <26a8f0aa-8d67-47ba-841c-2daf7010a2aa@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <26a8f0aa-8d67-47ba-841c-2daf7010a2aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 21:58, David Hildenbrand wrote:
> On 13.10.25 21:54, craftfever wrote:
>>
>> Unfortunately, yes I can reproduce it. And I thought that lockups does
>> not happen anymore, but I was wrong, I booted today with 6.17.2 updated
>> and KSM enabled and whole situation is back. But, it only happens, when
>> scanning pages corresponding to a process with huge VM size, like
>> Chromium with 1TB of virtual memory. The rest is alright. It's look
>> like, that the folio_walk_start called with much higher frequency, than
>> in 6.12-6.15 versions. in that version page scanning of huge VM size
>> processes is pretty fast and flawless) Right now, when Chromium is
>> running, I expecting constant 42% folio_walk_start and 15%
>> ksm_scan_thread on 6.17.2 kernel (contrary to 1% folio_walk_start and
>> even less ksm_scan_thread in 6.12-6.15). I must admin that whole system
>> is not freezing, just Chromium with high CPU usage from ksmd and kernel.
> 
> What about 6.16?
> 

What you replied to in private:

Just compared stock kernels (6.16.8 and 6.17.2) and must admit that the
behavior pretty same, same lockup, when just starting Chromium and same
kernel objects and ksmd overhead. No difference. (Approx 20-32% of
"folio_walk_start" and 10% ksm_scan_thread at this time on both kernels)


IIUC, 6.16.8 dos not contain a backport of Lorenzos fix, so we can rule that one out I think.

There is another VMA merging related one in 6.16:

commit 879bca0a2c4f40b08d09a95a2a0c3c6513060b5c
Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date:   Tue Apr 8 10:29:31 2025 +0100

     mm/vma: fix incorrectly disallowed anonymous VMA merges
     
     Patch series "fix incorrectly disallowed anonymous VMA merges", v2.
     
     It appears that we have been incorrectly rejecting merge cases for 15
     years, apparently by mistake.
     
     Imagine a range of anonymous mapped momemory divided into two VMAs like
     this, with incompatible protection bits:
     
Could you try reverting 879bca0a2c4f40b08d09a95a2a0c3c6513060b5c on top of 6.16 and
see if the problem goes away?

Meanwhile I'll try using an ordinary pagewalk that covers a larger area
instead of a foliowalk that walks each address.

-- 
Cheers

David / dhildenb


