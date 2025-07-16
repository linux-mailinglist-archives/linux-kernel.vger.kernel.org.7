Return-Path: <linux-kernel+bounces-734332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE6B08035
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95C43BAA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB922EE5E3;
	Wed, 16 Jul 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdJWB9xl"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F45214818
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703636; cv=none; b=V0p5dOySISPo0KFX3J5T75xh+Pvio1P/qrc6uD9bJnpPlXHFe3WDxxHGHNK9eiT06ocN6JuKKokalPyFR/iSKFniB1zARgsGtSyZCJxce7QyZL1uu+vy216gzwggiiK9/tuIHW8u5O42urFU22s+c6pSeLrHcNvnDaRScxxMv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703636; c=relaxed/simple;
	bh=V2MRUeTCtr2nQO3lknECRdk6doBc3SZtHnBZVqsqfnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U493JM+QJS2KOkbgnVRAMGvn8sGMx/WTvobyFF6HYdeL1UbHXvqjushttr28frPTQ80wMbeekoYKqooY+qGY4faVsBK5xlO2taISpRViWdHk/qKzUQErFlj6NWniCq7wOZDUbe7r9IvxcdY2I0N8gWaCxYrWBtuwK2Ck9K8zTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdJWB9xl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso1450860a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703634; x=1753308434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jfGUMmZf59vXYw7Ue0PfL2Mok0na9p3Eo87Y4IHva8=;
        b=tdJWB9xl+/3rM6Pv5iN7q7kI8e2iUJA4gyuBBL/kCnCE4x1V2BWzc5Oft2/X5PM6cI
         ZI8mN0/hloARaDMcw+/oR1/zGOpvcum1JeQEpsI7vOv+dpVT5AxAF0aXpBXJlECprqP+
         q930Ucz3AtOh3QeFW7wI9WlLId7PvgerUsrdtIaxv9lvVOMhhUx7xEG2AgPLcn2gT9Kf
         ntvBJ29V3uw782x0uQqzGHm4g2a0+al3Xsg4gewgzHs70GFPd32v/IwdZkfr8/5gd0Ev
         aAQhFQY0SSZ7g64/qpRWQ6rPEHQMlA29xKp38DzKQqGWTgK3GsrbLrdnmu6tRBERxsAc
         N92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703634; x=1753308434;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jfGUMmZf59vXYw7Ue0PfL2Mok0na9p3Eo87Y4IHva8=;
        b=pvIuD0GVTlM0TgDSkSAAoU+tlcuuBRJOhrGIDYUucT+nE68H1pIcDmc5SkwNsmyPdb
         yQakw7gm1198cJFJBDlUsGE9P5DUMz/cvP60rwn9C15ICQdLQulThOgO1disWkzQK13N
         rGWn2QHYrZE44acipCPxUsaDuaqzlGpPKwqYXMAuqttdQ9za5gdn69G71NSWZ5pRVjDm
         0dK8BNzf8X00KmQchsyf3+whon20vNRNf78v11UgBkGCaGIncHCJqqcl5KEHjYnYkhcB
         8nryuS5ediu9J60WS0n1UVUl6PXW/Xg9hYFxpOhjcoKLc2In8fRdvlrrQ09CjJS9+qNl
         lkTg==
X-Gm-Message-State: AOJu0Yz3o9EECCQEqA6yiJP7vytXdbEjFmCsSSjm+I1QMxGiIm/hSZNv
	dElu4noVQadltcqNurmsWDrT/NnewJFqAJXA/jjzO5hH112e32BguSBU5fvv8vCB6ltoelc4qWE
	pSy41epE61Q==
X-Google-Smtp-Source: AGHT+IH2BHYFzOP7sDAjRtznf+546Wj+XlN7qYKbEn4wE46e8sr3AS4GvJPHhHQXIWbdUbIWZSLjblR7aoqw
X-Received: from pjzz15.prod.google.com ([2002:a17:90b:58ef:b0:311:ef56:7694])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c5:b0:315:f6d6:d29c
 with SMTP id 98e67ed59e1d1-31caea211cemr1344352a91.15.1752703634500; Wed, 16
 Jul 2025 15:07:14 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:07:12 -0700
In-Reply-To: <202507160726.EC296DBFA@keescook> (Kees Cook's message of "Wed,
 16 Jul 2025 07:27:24 -0700")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-2-ynaffit@google.com>
 <202507160726.EC296DBFA@keescook>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8ldon6b8v.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v3 1/6] binder: Fix selftest page indexing
From: Tiffany Yang <ynaffit@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXY=?= =?utf-8?B?w6Vn?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Kees Cook <kees@kernel.org> writes:

> On Mon, Jul 14, 2025 at 11:53:14AM -0700, Tiffany Yang wrote:
>> The binder allocator selftest was only checking the last page of buffers
>> that ended on a page boundary. Correct the page indexing to account for
>> buffers that are not page-aligned.

>> Signed-off-by: Tiffany Yang <ynaffit@google.com>
>> ---
>>   drivers/android/binder_alloc_selftest.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)

>> diff --git a/drivers/android/binder_alloc_selftest.c  
>> b/drivers/android/binder_alloc_selftest.c
>> index c88735c54848..486af3ec3c02 100644
>> --- a/drivers/android/binder_alloc_selftest.c
>> +++ b/drivers/android/binder_alloc_selftest.c
>> @@ -142,12 +142,12 @@ static void binder_selftest_free_buf(struct  
>> binder_alloc *alloc,
>>   	for (i = 0; i < BUFFER_NUM; i++)
>>   		binder_alloc_free_buf(alloc, buffers[seq[i]]);

>> -	for (i = 0; i < end / PAGE_SIZE; i++) {
>>   		/**
>>   		 * Error message on a free page can be false positive
>>   		 * if binder shrinker ran during binder_alloc_free_buf
>>   		 * calls above.
>>   		 */
>> +	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {

> Nit: this comment is now not aligned correctly. Probably the best would
> be the leave the "for" line above the comment.

> -Kees


Thank you for catching this! Will be fixed in v4.

>>   		if (list_empty(page_to_lru(alloc->pages[i]))) {
>>   			pr_err_size_seq(sizes, seq);
>>   			pr_err("expect lru but is %s at page index %d\n",
>> --
>> 2.50.0.727.gbf7dc18ff4-goog


-- 
Tiffany Y. Yang

