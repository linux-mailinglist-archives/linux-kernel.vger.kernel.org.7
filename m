Return-Path: <linux-kernel+bounces-742117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BDBB0ED7F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A855564608
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B387281341;
	Wed, 23 Jul 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOcwdH3U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813F28000C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260175; cv=none; b=AWb2zMyyx6o9UlK+xInyr+k4VecUf8jZlRrC8C8n22AbNlfXxOvzENlt5GCSDwz7mkxnDRtMKFRFaW89Wc6LJP37CN1O+kCot+nWk5i+/SZaLl6Lescq0+mWF1+o8dpLJXolVVUoFWSKTop5HnILZAe35lhlLIUVQwKWVaiSFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260175; c=relaxed/simple;
	bh=JTDLBo5o76AefFYuFVJrjoz0anvjFL/8y8RFx0tTCgQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P0K7qHuTiEq01enVsp5cb95XWYkQDRB6DsEseG/skltYl1Nkd0tPLgK118qQNINvqPc7JGcZVyRw0POr1J2GMGsYQTuW/JSeHmAI0uOTUUAncCbWL0Ffm5JtQYdzTPLREW4RW8VatKxpE1gJH/MoqVk4c2HF+F4SqG8AgVuOkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOcwdH3U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753260172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m016PQtjMJzQ3lrJfsjEi3M2oL5CSEZidrlqlSJ10Cg=;
	b=gOcwdH3UtkC/Tr48y7wUsePuTmWJFIdqVj5pO/K7oMdSZ8rgdFZrgvQa5SG4dR79CP+eJF
	84ZlsM5nJzpjAGLQVuHwiH82kdSGQgSwknx2lEDRo7Cg8w2TqytBI244Bo863WykODS+yr
	Hlzaz2MTtf62ozWR21cp+Y6PMsO5/fY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-EHT4X6KUNm2vK-QAGy-x4A-1; Wed, 23 Jul 2025 04:42:51 -0400
X-MC-Unique: EHT4X6KUNm2vK-QAGy-x4A-1
X-Mimecast-MFC-AGG-ID: EHT4X6KUNm2vK-QAGy-x4A_1753260170
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2371935f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260170; x=1753864970;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m016PQtjMJzQ3lrJfsjEi3M2oL5CSEZidrlqlSJ10Cg=;
        b=wfygNXStA2sUgeWYOt7RQqv9zi6RmT+4dwqyGgZGVW48VUkO7eLFEUilHhKKFcFVDc
         cKxKFRenGLtC4g+QD8HD4mx8HXbM7/1hqo1GtZ2AnooFvEVslSTeLukWdrIQuweZ6Hxf
         xDIsax6XGzJ/BkBqrBVC9B5VeeJ98KfT1Pu48NroEqPTLKrXY+WEi/aVdH1qlqTJtWtx
         0PTtMfQeoqM6D1aQqlEkQctQ2J4hanLzfBLmfSJUbGGf6AWBHj+8/80wWDqEPFLlISi/
         Bxs2q4jm9VbgUbw/K/tC3WSL0ktZwtASyOeUeGgXUIPC5I+SBUP9i6p1Q8cR1vzyTRDy
         YuPA==
X-Forwarded-Encrypted: i=1; AJvYcCWj5XVy9eQxINNkzeBt6CN4UPEsVIMhWh0jChHOAZyanf/8qhtq6Q62HiwANmgfv1MQE/IHWI7+Qwxz948=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HMAkFX/GQOG9Q7YSsdLfgv5SUS2g/ntYcOid0tudcqsszIIC
	gTvu58gv2RD2coN5RAaWEbSIM0S0VJ5+v3JjiroMN9XyWaBexm3jgf01xjfnug/2We7GGQ4YEGG
	+LMtQCl0V0OufSv/217URzGIYSEczqnR8F36B8s4q3A4E3ocZDHcZdApbLpgo78ozNQ==
X-Gm-Gg: ASbGncsf6Ner/X5hf85nOKasjqSHp0DEtquDRtBi2eRO27n+SGEsDzGE4LsEvwmjmmw
	/AIJ3dBS0n3ni1Vz4wpgtgoR8DJ7ko3FtYqF+oizBeEzZYmt8EjcPKS9lfMFfDFLIONRWszWzfW
	b2AeembDI4QFPw2cQaI7v3YqreUW35Bm9ivdxo4aMtFM9spmNX0v60J04T4HshGZ5vdYftw9hbI
	FtThnSCqHtRyxpnQdsk4N3k7xDmNisbAZ2+9ervGDKihYOaunoqjFIdOCS1Jll6ZXu2RS8naWNB
	msCIqX7GDcddna3NEzFJou+iPP16s/Q8Hf9KTP+BPDjIOw9+8NtjnNdOF5NNhGgHx+jxYW/WtCK
	BKkDOzhLPQWq4uJFHjgGfgGoO2OlTOm7QOfUn9OFLGsIT/1yYheh+MW7cqT/QxWmXtms=
X-Received: by 2002:a5d:5846:0:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3b768f27a57mr1700472f8f.53.1753260170190;
        Wed, 23 Jul 2025 01:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7ZThA85cZ+jlGeXWrNpkYeEIN7qUStmMhxE36AHwH/9cQLh4aUBociBhsllms9KBUpc3hww==
X-Received: by 2002:a5d:5846:0:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3b768f27a57mr1700427f8f.53.1753260169656;
        Wed, 23 Jul 2025 01:42:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45863a35298sm30650555e9.1.2025.07.23.01.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:42:49 -0700 (PDT)
Message-ID: <8dd1e8f6-f96d-4d36-ac2a-c258ac842f75@redhat.com>
Date: Wed, 23 Jul 2025 10:42:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
From: David Hildenbrand <david@redhat.com>
To: Xuanye Liu <liuqiye2025@163.com>, Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250723072350.1742071-1-liuqiye2025@163.com>
 <202507230031.52B5C2B53@keescook>
 <c7a32d87-efbd-47bd-9a18-9eb51e441a7f@163.com>
 <119c3422-0bb1-4806-b81c-ccf1c7aeba4d@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <119c3422-0bb1-4806-b81c-ccf1c7aeba4d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.07.25 10:05, David Hildenbrand wrote:
> On 23.07.25 09:45, Xuanye Liu wrote:
>>
>> 在 2025/7/23 15:31, Kees Cook 写道:
>>> On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
>>>> The check_mm() function verifies the correctness of rss counters in
>>>> struct mm_struct. Currently, it only prints an alert when a bad
>>>> rss-counter state is detected, but lacks sufficient context for
>>>> debugging.
>>>>
>>>> This patch adds a dump_stack() call to provide a stack trace when
>>>> the rss-counter state is invalid. This helps developers identify
>>>> where the corrupted mm_struct is being checked and trace the
>>>> underlying cause of the inconsistency.
>>> Why not just convert the pr_alert to a WARN?
>> Good idea! I'll gather more feedback from others and then update to v2.
> 
> Makes sense to me.

After discussion this with Lorenzo off-list, isn't the stack completely 
misleading/useless in that case?

Whatever caused the RSS counter mismatch (e.g., unmapped the wrong 
pages, missed to unmap pages) quite possibly happened in different 
context, way way earlier.

Why would you think the stack trace would be of any value when 
destroying an MM (__mmdrop)?

Having that said, I really hate these "pr_*("BUG: ...") with passion. 
Probably we'd want to invoke the panic_on_warn machinery, because 
something unexpected happened.

-- 
Cheers,

David / dhildenb


