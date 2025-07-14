Return-Path: <linux-kernel+bounces-730455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA83B044C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0674A0CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC86125CC75;
	Mon, 14 Jul 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6UewqHh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DF25C80E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508384; cv=none; b=c/AWnwPcuKKh4TCacTvFMaVOMAXAg9BYUmU7I5VA8XBL6usoaVAQrEdyqiRvPBzxUvFx251rbzYhW4N4CYsF0NH8sPqgU8wHzLZDQjAkmeF0bzN65QlH//QueUedEEN2b7JhmJeJXylahWmXl+mlq7tfFyY77e4fwpuElW1Me1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508384; c=relaxed/simple;
	bh=CEXnDlx2sJuPjvpQa1TuoassZAU72YqfbV4oAqQbjRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJJrguw+euYrkqJQMeJpuK14FgWvyTz7zX58ZI6dne2Lj7Hohr44d+ukXt2iAZ1GMX3vgvPwMMzqVvzxOLcR13Z56EWD6MT3Ee6eNasknXNxpUsMdo3ZM+OGcWPQDpkXphiN9qYsAPLYTLY5tpcpYzj5Lp3Fps2ukNrGFFclA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6UewqHh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752508381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Afh2mt2XLyIRGvzUM8w1YNZeAUkQs3mudyhuKeejHlg=;
	b=F6UewqHhJs/QOE3Bbw4HwxPnZNzk5EDFODRNUJA2F1YMIgSwl6PfOBSi/3Z8TCh7YIGWHR
	SUvcvdfFAdxfw1I9JbkKacvcuMU6vucyOZDfS2R3e1eQ17tcH9nE8+AhQyOZ5nibe+irN9
	r0+ZliEZ0bMynpm9mX/MY7BxxGDIe88=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-nh8-YFc8M4GW6gGYCJCLJQ-1; Mon, 14 Jul 2025 11:53:00 -0400
X-MC-Unique: nh8-YFc8M4GW6gGYCJCLJQ-1
X-Mimecast-MFC-AGG-ID: nh8-YFc8M4GW6gGYCJCLJQ_1752508379
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso3376430f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508379; x=1753113179;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Afh2mt2XLyIRGvzUM8w1YNZeAUkQs3mudyhuKeejHlg=;
        b=iMEEi5xu7C4TuU2kqlFNCCJwlljwf+GOwEZz6lTHKkoBDYdedBd2hW1hNw5OyNjDyy
         YEq5ROBSy0INffipPYGdw+lNZ98KUSGo49iRXCdIAHbi0Hm7ACTshpGFPDfF126rA381
         a+oeduY53PXZA7Wk8DKbfYpRwwO/7rdzns1C1scMj0JNwUiWBqyEKJwByH+nYfNdh0SH
         Kf4HdvzD4s5MsdHn/gW+qO6Ja+NxFsqfGV+Igxe07uZ6EIDbEOp7TOtXsoi1waM/l4Z4
         SqaVY3DR0rLHeyxbRM8JEv3MCKhlkMGekdp6ofj7URT2FnuWi40M0Cg5lpbw4iqOidVv
         tvPg==
X-Forwarded-Encrypted: i=1; AJvYcCUNRS+Oy9ur+cCK6MODvgVP2NEgk6NBI1J62oLGw+Sw9YJ/CWk9onqA8u7qNGRc27rqAAaF6xLf3NE/oGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGAjdyBDfLaa6Uo27bZ4YT+COp88b4RR+9ymka8y838IN19cM
	uaoogAVYwKzKoTOCTNSIZoxLRqs6aam3NGnNSc7aqOThAj0Bd4yXNI8Fc3oXJMEiHsNsezqE9LY
	whr2F7CCXA1TLnclmJYIxlva2r3raL0nJDuiTX3yig7kdckt00HagFUrZisUs2bzeDQ==
X-Gm-Gg: ASbGnctfZxc2TY69Ji5ENm2fZtMq5u5cx5ug2kqN6qBUKy9ZemqswFsFnyI897IRbQH
	E9SHJNjIsm0+7EOazOJymw9+vwbIWZG+G2vlDs2TH2ZAm31uozF6h1DEvxqt20hbfjVpWQS2y9S
	xarYE29ZqZ5XionOOe5yk4yDux1Bd/KNEfXrzzppdnqfUjfZiMFpDGBHG6KoR0UV5W0565cj0Mn
	kHOwBb+jBXMLCps9QMwjRh6NI+1a7pX/MbzN885BBXgBJlbnRUlj3YChCmCdHEbh+jtQCpPQMGZ
	tnpiQIULrhL8qrOc8TaBDTESX2H50Jq3yT8WMvSxSk5W60qJEXEH6Mm/hHXiLLEbn33HVhT5xVM
	mAt4cYhs7ksiUxtiADBQwj+wI99ARZDgP79KfxiOP2MHOwYNC1mbL428fow6F6ItR
X-Received: by 2002:a05:6000:2dc5:b0:3b5:e6c0:1678 with SMTP id ffacd0b85a97d-3b5f2e33913mr11397475f8f.45.1752508378997;
        Mon, 14 Jul 2025 08:52:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBfPb+kSBwtyIkauT6Dvd8T6nbUdLfyAgQVkHC+WtToEfbcUDFhxah83coYfbK4ClyFfZRjg==
X-Received: by 2002:a05:6000:2dc5:b0:3b5:e6c0:1678 with SMTP id ffacd0b85a97d-3b5f2e33913mr11397445f8f.45.1752508378555;
        Mon, 14 Jul 2025 08:52:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1890sm12680696f8f.3.2025.07.14.08.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:52:57 -0700 (PDT)
Message-ID: <60b0b01b-d397-4e47-8e85-295241ea3230@redhat.com>
Date: Mon, 14 Jul 2025 17:52:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
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
 <184d7f4b-6ffd-4047-b245-aec32ebda9d6@redhat.com>
 <d7959e95-c248-43f8-911f-628db9313a61@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <d7959e95-c248-43f8-911f-628db9313a61@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 17:45, Lorenzo Stoakes wrote:
> On Mon, Jul 14, 2025 at 05:41:45PM +0200, David Hildenbrand wrote:
>> On 14.07.25 17:31, Pedro Falcato wrote:
>>> On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
>>>> [...]
>>>>
>>>> But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
>>>> mapping?
>>>
>>> IIRC this was originally suggested by Linus, on one of the versions introducing
>>> mseal. But the gist is that discarding pages is okay if you could already zero
>>> them manually, using e.g memset. Hence the writeability checks.
>>
>> What you can do is
>>
>> a) mmap(PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, ...)
>>
>> b) modify content (write, whatever)
>>
>> c) mprotect(PROT_READ)
>>
>> d) mseal()
>>
>> But then still do
>>
>> madvise(MADV_DONTNEED)
>>
>> to discard.
>>
>>
>> There is no writability anymore.
> 
> Well, you can mprotect() writable it again :)

Isn't that what sealing ... prohibits?

-- 
Cheers,

David / dhildenb


