Return-Path: <linux-kernel+bounces-840159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5BBB3B73
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F9B19C6C46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D230DECF;
	Thu,  2 Oct 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPj20AYm"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77830CB42
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403124; cv=none; b=U6JTBXEbZcCL/6yWaOTS/xBdrpZxOYBzjwmQV4nPCz6zBQ1hvgU4vJzQB0ORDgAu7SekJcJlLvW/XrG0METdWv7fWZiavhw7/nlTaNLChOQAue7bL9ObPDf/bB7wo4kFynU0EHQudhstxqW1ZkbNZ+UE0Wy8DA9qMA9904ohBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403124; c=relaxed/simple;
	bh=IL2uchrrlVJI0To0OGIK6OnERKr5SS8vcf+vwilHx8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hOIaqSO2nXjF/PQk+Vj6C/ILfX7pl+fzN4pr/0YmK7iTTVek7CQ2RII9bEQx9Q9Gh6XC+THf4lTFAIfSGrk/E4eAPsRxaqp5YXv3whPWDgM0WCFjSQdq5piQ1Ouk9ncLRY4isKAkrSR2Ri4p2GWlyfz71iHm31Snkz6sQCw+hNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPj20AYm; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso4286295e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759403121; x=1760007921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IL2uchrrlVJI0To0OGIK6OnERKr5SS8vcf+vwilHx8o=;
        b=RPj20AYmkt9aN7XqJjYOFVutp6haifi+WjPgL9zxI0xShZZMwJla2xgv0iWK7mmEcX
         eionQ4viuKc6Fa9Jgu222Nsgo1ZnmOhVsF/XCmX62cjBbIztiYbawz3I4wpsCLNcJCYC
         NhqOeo7WTLP8kbyHhBQt72lmSckm+9P74kyBia3S+IiQa9dRXBGtHVnXuuSwzh4H24vT
         wXlA5HViyAMbwxUqD4Y0y53bVWAquSU0h+4DYEFccAgV3GE7zEBwv9ElhsKUvvWO2jpk
         FWkYIh+EdQEd+XViAh5UKzXFX7ggGpTajIOvVlGtnLuOT2tS+0IAkzQkzfDB3dv+AUB8
         wfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759403121; x=1760007921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IL2uchrrlVJI0To0OGIK6OnERKr5SS8vcf+vwilHx8o=;
        b=bl5fiZmKMuRJvQ6lMGTJFm+q5L/91N67FpqsGRiLn+8iW5550cWbhn8p+YbJ30h379
         pD4C6/jOtra3N0H+2ck5TkGJa/9h3NTvzkF/wSmSg++jcsEZW6ptZn9oR+RLHhYcTuXx
         Y4hXwCg273/CDiXzZmS1dRUjuwcXr8+l6tn/iz0VXX8Imc8NLz/2b9pWI0Hnkif51e91
         Rc9q8l7XxWstLbFKryuUQUGkzfXg1TbAscDzF90CqRE87nkioyBSqkGFdIytfasmdtmg
         MtjygBlU8GpDq1HlU5PNcEnIaPD8TweykC5b0cQmqcjNWAXoYGr/VBKW6x+qMpcf9VrQ
         Pe+w==
X-Forwarded-Encrypted: i=1; AJvYcCXz8n6LWocKWoX7+hvYwsh+9MFiTBPosQ3H0r+bg5M5MWBHlDcYa20aB3TgIyHboEfswXDHqcxVLc5BMfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMatRz9ssMQcmeLkO/Rpcshp7tPFu3ktE54MnFtgVGIBoVWm6
	VN2+WgZzeaJgl6Sr+87IPlugZ1WjgkG+t+Ev+eifznIqEGCtBpfLaw2Cr5SjjYW+NKyqu2kDX6D
	lV6uBMVnvT4C/aQ==
X-Google-Smtp-Source: AGHT+IGw6rncY8Zxg7i+a3sTyj/cTgYVjAJmgkG70hNLSfNqxn0MIvjZU+YGtE0bN/lyYtFOJUyzYiuJGMMOBg==
X-Received: from wmhf25.prod.google.com ([2002:a7b:cc19:0:b0:46d:ab31:6ece])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c95:b0:46e:6af4:ed83 with SMTP id 5b1f17b1804b1-46e6af4efffmr14013925e9.23.1759403121371;
 Thu, 02 Oct 2025 04:05:21 -0700 (PDT)
Date: Thu, 02 Oct 2025 11:05:20 +0000
In-Reply-To: <7dd29a1e-cea8-4889-bff1-462ad00e25fb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <726d6a45-d732-4c23-a7b7-766d6a62122e@intel.com> <eajnyirurulezkgpqaonfqmh5ydi7ujzztgok2ab3fsumcmtwi@34ios2bpwxk5>
 <7dd29a1e-cea8-4889-bff1-462ad00e25fb@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD7SCRK2OJI9.1EJ9GSEH9FHW2@google.com>
Subject: Re: [PATCH 00/21] mm: ASI direct map management
From: Brendan Jackman <jackmanb@google.com>
To: Dave Hansen <dave.hansen@intel.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Brendan Jackman <jackmanb@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, <peterz@infradead.org>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 1, 2025 at 8:30 PM UTC, Dave Hansen wrote:
> On 10/1/25 13:22, Yosry Ahmed wrote:
>> On Wed, Oct 01, 2025 at 12:54:42PM -0700, Dave Hansen wrote:
>>> On 9/24/25 07:59, Brendan Jackman wrote:
>>>> As per [0] I think ASI is ready to start merging. This is the first
>>>> step. The scope of this series is: everything needed to set up the
>>>> direct map in the restricted address spaces.
>>> Brendan!
>>>
>>> Generally, we ask that patches get review tags before we consider them
>>> for being merged. Is there a reason this series doesn't need reviews
>>> before it gets merged?
>> I think Brendan just meant that this is not an RFC aimed at prompting
>> discussion anymore, these are fully functional patches aimed at being
>> merged after they are reviewed and iterated on accordingly.
>
> Just setting expectations ... I think Brendan has probably rewritten
> this two or three times. I suggest he's about halfway done; only two or
> three rewrites left. ;)

Yeah, I'd love to say "... and we have become exceedingly efficient at
it" [0], but no, debugging my idiotic freelist and pagetable corruptions
was just as hard this time as the first and second times...

[0] https://www.youtube.com/watch?v=r51EomcIqA0

> But, seriously, this _is_ a big deal. It's not going to be something
> that gets a few tags slapped on it and gets merged. At least that's not
> how I expect it to go.

Yeah, sorry if this was poorly worded, I'm DEFINITELY not asking anyone
to merge this without the requisite acks - "ready for merge" just means
"please review this as real grown-up code, I no longer consider this a
PoC". And I'm not expecting this to get merged in v2 either :)

Maybe worth noting here: there are two broad parties of important
reviewers - mm folks and x86 folks. I think we're at risk of a
chicken-and-egg problem where party A is thinking "no point in reviewing
this too carefully, it's not yet clear that party B is ever gonna accept
ASI even in theory". Meanwhile party B says "yeah ASI seems desirable,
but I'll keep my nose out until party A has ironed out the details on
their side".

So, if you can do anything to help develop a consensus on whether we
actually want this thing, that would help a lot. Maybe the best way to
do that is just to dig into the details anyway, I'm not sure.

