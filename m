Return-Path: <linux-kernel+bounces-893112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BD6C468CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA6B1886AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EFD19DF4F;
	Mon, 10 Nov 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzPvevk7"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D32AD13
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776950; cv=none; b=lfE0wyuFsepzNK3AgYtYX2aTnaeUj6HU7QTZnRZpaYn47sv9NY4uE4eOhX0IDNnoLeZYplnHBrk2ysLHJda66LlXEWnU5PNkuDbIM3vkQsBhcTEbzHjiqFUzHRfFN2ddkx+e5aJJpewXABjcklsO+ThjfxABe1dXVAWtBAgRTnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776950; c=relaxed/simple;
	bh=L8BGqbB9mXhb9QhA+8Y/ns6WcRXrqxhhNfU7v+/1kic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uYXbpw95l3Abg+6XCoP59OQNbyZ+Ca0CSVdxGIWmiEwfzFZNQzIVFjebsIAIneB7BAVzx8l+/vd3EuUGtNXNO8GgTCxsp+BX2xX5QwHg5pIO8BeyqcXc5k5Co64XOSW5acBzxNMg6Zve2bTIPqHghZeUPHg8ogR1wzz7ZMKAdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzPvevk7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4774836c376so15475235e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762776946; x=1763381746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7u+CaWniXfNbRMSrnjLhAt9t/fpHXv3Sd1ZHtazOKg=;
        b=PzPvevk79S2oToraIX60BlNisqSaAiE/G92DQsq8e3Mu8BtBCLx5NEsTmGTBXBhRfb
         REd/B9sBMFmLhC5iLqyN/I/3/VQU0aWOWRoGE3iAzUGolPNeMF7A+x8XKN5DWd0Dl90g
         lFI17tLrFD9q4myYt10riVZEuDsrRv7LnmS0B56VF3ZpV4X+MPceGq9eU6OWQTCqdpoz
         GzlCuN8hDX7mIjA1xB6F8qYmqwT9Z2AaPpqNoakg6wUmQk4+ln/SzElJvQvrZ+Zd5D1Q
         VVeCScgpiQO0DtlMj3GzJbh0m56Q9v+1llGjtgrWBfcYtu1LzK6tldaxcpGL/+S9o6K/
         JzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776946; x=1763381746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7u+CaWniXfNbRMSrnjLhAt9t/fpHXv3Sd1ZHtazOKg=;
        b=vYC2E907H+8CWp5Qmb5y2uwoLdkMHxmb70zP8ZmdSfSeD2FWjAAt9WnOD5hwSit6vY
         wuQNyZqAC17/7XrazFNUovmVc/OEhB3HAdfugimGXZEtuYarXiGXTuyCn/03mYfMPlQT
         0YRYX5jsxfVE7P2r/omFNUnjL5RDCeTdYiQTOnggJAUup13N5J6Ooaujf8dqi8VHnt9X
         vFJUPHQhiERVCX8vRPCEnEnkrja/IrLq0HrE/XX54JNAZaYk7wTd8nzpeIj9p3x+nOhk
         p7fXvbqbPoMdrUtzuJ6kFav9pDfsLDhc568d0Gnl0qGmjQJ589g37t6tXArMJfImAhr2
         Rw0w==
X-Forwarded-Encrypted: i=1; AJvYcCUPIXgPMMlnAjr/ytbok6vfVZKLYNWU61RC8zKxo6VFcJ/xDRuJM50XQWE0HfqlCNdSwXqaF7//DddloVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypDxbbDevjD5CJqHfIyGzT/26Ch8qcDbLE+1C6xNG2Q+wpu6BQ
	vmKuUgimfqIDtdJ6UOpLPkyIe87RELenRQeORuqZLj6KF+NxrySjlcFw0992Gj+WOkh7BSNVV7T
	e9Stf5JPXJLdSfw==
X-Google-Smtp-Source: AGHT+IFsVkAJqDrA0QC1vNQvIugx9gGlCHC4/kl3pctZZHSVNpuIB2x8+7Vb8XbTb0E+0lyCnqY/M4AHDRthJA==
X-Received: from wmee11.prod.google.com ([2002:a05:600c:218b:b0:477:63d9:f561])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c15:b0:477:7c45:87b1 with SMTP id 5b1f17b1804b1-4777c45885amr34406585e9.36.1762776946520;
 Mon, 10 Nov 2025 04:15:46 -0800 (PST)
Date: Mon, 10 Nov 2025 12:15:45 +0000
In-Reply-To: <20251110112640.GVaRHL8GME4ODowica@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-2-2d861768041f@google.com> <20251025100642.GVaPyhMp4CEmsYW3xy@fat_crate.local>
 <DDSLTWM2FL58.3MIDS5WUOEEZW@google.com> <20251110112640.GVaRHL8GME4ODowica@fat_crate.local>
X-Mailer: aerc 0.21.0
Message-ID: <DE509XAYNMVR.2UH3ZEC7HIU69@google.com>
Subject: Re: [PATCH 02/21] x86/mm/asi: add X86_FEATURE_ASI and asi=
From: Brendan Jackman <jackmanb@google.com>
To: Borislav Petkov <bp@alien8.de>, Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, <peterz@infradead.org>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon Nov 10, 2025 at 11:26 AM UTC, Borislav Petkov wrote:
> On Sun, Oct 26, 2025 at 10:24:35PM +0000, Brendan Jackman wrote:
>> Hm yeah, I actually also thought I had some direct feedback from one of
>> the x86 maintainers saying not to expose it here. I can no longer find
>> that feedback on Lore so I think I must be misremembering, the flag
>> was already hidden back in [0].
>> 
>> [0] https://lore.kernel.org/linux-mm/20240712-asi-rfc-24-v1-5-144b319a40d8@google.com/
>> 
>> If that feedback indeed doesn't exist
>
> Just ignore everything whoever might've told you or not - we override all
> previous statements! :-P
>
> From Documentation/arch/x86/cpuinfo.rst
>
> "So, the current use of /proc/cpuinfo is to show features which the
> kernel has *enabled* and *supports*. As in: the CPUID feature flag is
> there, there's an additional setup which the kernel has done while
> booting and the functionality is ready to use. A perfect example for
> that is "user_shstk" where additional code enablement is present in the
> kernel to support shadow stack for user programs."
>
> So it is all written down now and is the law! :-P
>
>> then personally I'd lean towards exposing it right away, I don't see that
>> much downside in terms of ABI, since ASI kinda "doesn't do anything", from
>> a SW point of view it's just a very weird and complicated NOP. It's hard for
>> me to see how userspace could grow a functional dependency on this flag.
>> Whereas for general monitoring it's handy.
>
> The point is: once all the ASI code lands, we should show it in cpuinfo. As
> in: "this kernel supports ASI" and not "there's asi in cpuinfo but well,
> that's not the whole deal."
>
> Makes sense?

Sure, sounds good to me.

