Return-Path: <linux-kernel+bounces-781627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05115B314BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4DC7A36E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61987296BAF;
	Fri, 22 Aug 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azy5aiMP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B481724
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857293; cv=none; b=ubrFLKzW2zGXRFaDMI0lqfZOqrx7YvSK4X02XgqCl4H7JfykapBR1t0eN4eTtiLh/hrWBMFoaswmJy/zHE/Q1Na7Hs3msi79QntrizNWj4fzswW7MT/u5K24U8N0PqKew8fFSy6hdjGaZAIcycOq3gXJUGyRtIbYthZ3QLZu5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857293; c=relaxed/simple;
	bh=VTMq5C98d5sTiqzfpTfra0ptRLg99zikanaHprFiL28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs++kMvTsGT2xAFJinzjhpBz+oHqkXETTAc6/+0iaTUifhIektHu7zLQyx+kTMGSg2U3SUIsH6Cf66CD0e8PwnJVjtLoxTNIPMYTnORqOMVXxrIzshe6cPUyBTfmF09XnQJIE49aQl2pLp2+fa2T03QjfhmjD54kMPxW7WoRDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azy5aiMP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755857290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QUnkbTSabMcbQIfqW2wjwFOAR821LvcoUL/CideIRuc=;
	b=azy5aiMPP+rQYt6uySEg7ccyvCPkee5iBgXtr8kqvcBYlzJWdBIW9mx8s7r8To12m51Yg3
	98t+YLQGDDFwkXBtGQSZjTCUZZdPUsSUsrGU4zSCM5EYsKS0Ynyvelt+2k2vbcmtq5C1VU
	i3ZJZmQT2SUazOGlm2DdWJYsGyUnlC8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-XJ76G8z_NciU7dQ0n3rjrA-1; Fri, 22 Aug 2025 06:08:09 -0400
X-MC-Unique: XJ76G8z_NciU7dQ0n3rjrA-1
X-Mimecast-MFC-AGG-ID: XJ76G8z_NciU7dQ0n3rjrA_1755857288
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso9959345e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857288; x=1756462088;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUnkbTSabMcbQIfqW2wjwFOAR821LvcoUL/CideIRuc=;
        b=GjVDWXAzcWZmm1+XdeX84aUSTCGspNP6PwtI8gMwWUlDXqrBMgygnylfjKcKk1cmvL
         KroA0XHtAOnHlF2kqyQ8qFLI1E06gAhQysZlzZMLsB5/PahROOgpm+ygSY3kd1bpCep3
         BQ79TixnH9ZJ7hSBy+6t4N/H9Sjhjg5LouX3T44RmoXLSxIdnK7TGPRJpGcFssjViUkI
         QfgwNrQD6DCHlp87AGU99MEkz+Vm28gxtmM72sHJ411BxyEXRJSP0mTf95XLnCV3KPhg
         pvfZod8bx4Vxxm0VzUllWEyo4GvK9hWeLyxnlnE/8RKV+f3KYW/hf6MmGastQoXqkIVj
         c6qw==
X-Forwarded-Encrypted: i=1; AJvYcCUq2vWnwVGLsCKX7afbdPtwldQySQzmBqbnnW4l6l+pwcjfrtiK5odPReTmpf86xKRB7BnjVVYB9bjOXu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdDTYD3WjOKmiszS2BR5W+NbQ6atOfgZjsU/BfJxBXTKnqUBZ
	9P2m8sBjEkA4FXUjfiVf4wgHhwUYk/9u0fVWdEe6bCzIj57QlPm6ITgOYxkIDvO0r2EDwngOqvp
	kDU3g3Ryg4CK5OQIa9JK5zolNXJRlBq2STn77bJkdAKLuPfDvmLIiy7NDqlLVyii0CA==
X-Gm-Gg: ASbGncumHlDg31nH+46i5OCjMYj6li0fmNKfTWGY1VOTD9dSCzDAv7A6M8jXtPnrTMS
	uj24PjXBmDH+bwisZh3xWWV5RA8oG9M+Pt1OWMnT/UEUkOQDzKxdDPIRe4TH+7aifeGvGep8i1n
	6+EL74YrS49dWc512e40U59TDklFdLzDY0Zm9JB0anZkfhG7SpI+d+/40JcsXPkYqlxo5k1tzcE
	XP1vlRC3CsuFbGSiZl9G0RlNZMBljXxpdD7bIXtIwkkdqk7Iwu5t44YoZrgazyaz1hBoRe9RyY0
	2MMm3DiK/QhXOv474szpCV3jVHIcAjOGh+0crKYcrjBVijuRvJDIgk78qlTawVwRyjD8KhJcKwf
	mZ9uuBAjYOg8COHgcsjUwg+rEfs2vPusDu2oVGKDj+dHdIKve8vFBff3tl98rKmtqGM4=
X-Received: by 2002:a05:600c:4f8b:b0:459:e398:ed80 with SMTP id 5b1f17b1804b1-45b517e9de7mr17372025e9.32.1755857287937;
        Fri, 22 Aug 2025 03:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/I2g5Hwlv8A5Dsi6tWz98HgDHMBLctARhHYJlNSxF7aASwtTM7voaNtLhvwMa1MvPTFOctQ==
X-Received: by 2002:a05:600c:4f8b:b0:459:e398:ed80 with SMTP id 5b1f17b1804b1-45b517e9de7mr17371255e9.32.1755857287336;
        Fri, 22 Aug 2025 03:08:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:6100:d9da:ae87:764c:a77e? (p200300d82f2e6100d9daae87764ca77e.dip0.t-ipconnect.de. [2003:d8:2f2e:6100:d9da:ae87:764c:a77e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dc023dsm32426085e9.5.2025.08.22.03.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 03:08:06 -0700 (PDT)
Message-ID: <f6ef7e0f-0b48-4028-ba79-4a5ec66e720d@redhat.com>
Date: Fri, 22 Aug 2025 12:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] copy_process: Handle architectures where
 sizeof(unsigned long) < sizeof(u64)
To: "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Kees Cook <kees@kernel.org>
References: <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
 <20250821-nios2-implement-clone3-v1-1-1bb24017376a@siemens-energy.com>
 <8c6239a9-8414-469c-9b94-a43735b4e882@redhat.com>
 <FR2P281MB15445D806CF865A0E1CD8FFCB53DA@FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <FR2P281MB15445D806CF865A0E1CD8FFCB53DA@FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 10:52, schuster.simon@siemens-energy.com wrote:
> On Thu, Aug 21, 2025 at 11:14:00PM +0200, David Hildenbrand wrote:
>> Sounds reasonable.
>>
>> But is this actually something that is already exposed before patch#2
>> on other architectures?
> 
> I'm not sure, but I would assume so, as e.g., arch/arm seems to have
> support for clone3, but also seems to use 32bit unsigned longs as far as
> I can tell and, thus, should also be affected:
> 
> $ cat /tmp/printulsize.c
> #include <stdio.h>
> 
> int main(void) {
> 	printf("sizeof(unsigned long): %zu\n", sizeof(unsigned long));
> }
> $ arm-linux-gnueabi-gcc-12 /tmp/printulsize.c -o printulsize
> $ qemu-arm -L /usr/arm-linux-gnueabi ./printulsize
> sizeof(unsigned long): 4
> 
> Is the above test enough to warrant a "Fixes: ", or do we need a
> reproduced kselftest failure on some arch for that?

It would be good to describe that this would be an issue on nios2 and 
was reproduced there without this fix. Then you can mention that this 
should be an issue on 32bit archs with clone3 support as well, like arm.

Then we should add a Fixes:

> 
>> (I assume above output is with patch #2 but without patch #1)
> 
> Yes, sorry, that one is on me; I've naturally first implemented support
> for clone3 on nios2 and then investigated the test failures, but somehow
> deemed it wise for whatever reason to switch the commit order in the
> patch submission...

Right.

I'll note that copy_process() ends up calling other functions with 
clone_flags that accept an "unsigned long", like sched_fork(), which you 
don't handle here.

$ git grep "long clone_flags"

likely is a good indication what needs changing outside of kernel/fork.c.

It should be spelled out why you don't have to handle the others. And 
likely in the fix, we should really only fix the ones that are really 
required for now.

As a follow-up, we should likely better convert *all* users of 
clone_flags to use u64 (at least the one in core code), not just the 
ones in kernel/fork.c you tried to handle here.


For now, only the following require 64bit:

	CLONE_CLEAR_SIGHAND
	CLONE_INTO_CGROUP

CLONE_CLEAR_SIGHAND is only checked against extracted flags in:

* copy_process()->copy_sighand() and
  -> We don't use u64
* copy_process()->perf_event_init_task()->perf_event_init_context()->
   inherit_task_group()
  -> We do use u64 already

CLONE_INTO_CGROUP doesn't seem to be checked against extracted flags AFAIKS.


So I suggest making this fix CLONE_CLEAR_SIGHAND-specific and fixing 
only copy_sighand(). That one should carry Fixes:

Then, have a second patch where we convert all remaining "unsigned long 
clone_flags" in the core to use u64. That one would not be a fix.

Makes sense?

-- 
Cheers

David / dhildenb


