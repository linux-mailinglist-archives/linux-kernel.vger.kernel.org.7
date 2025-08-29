Return-Path: <linux-kernel+bounces-791666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1283B3B9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C971C84117
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8F30FF2B;
	Fri, 29 Aug 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyZPEndN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680C3043CA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466440; cv=none; b=dolBE4xwKwH+DiIX7NkPDqGUjMbSeadQ/Wt8ICxCjqPDU5jbub6cuDFMSqHUL9bVsCkESIURdDWzVOz1lS1nrvciZxoDeu82+7TuwNxmkX5+CLceJwv8Mnmgou0o6YExziWPwywGEZ6Lh8qkf2JBMNNeBA3BBMKjs+r1rLblijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466440; c=relaxed/simple;
	bh=MAgkG6oiBfZ1BR1iIsEQsox016XwbS/bjOqWXO/ViQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pOz/68nTbx+kk1/pCCE+WxvGpfsWfdP3LazbH+ezwjxLUCvNy4nD7tNnsDlIpD3Oxjm5IafopTcgcmgyqw5RgMTNYRdf8p79H15OYhRsZ+U8GQasYOhydh408ZvgGeJ/Y+E0jtb06+TMc8Loei6Urm+p8G/OxYV8bnOTQ50altw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hyZPEndN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so20705635e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756466437; x=1757071237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMZx+r0Hud3j//XxrS83eFfSTnjOGkzpkCOkpFgd4O0=;
        b=hyZPEndN5gJMNE6Hxag7yRFQ4erVsOpkjMuKW302+EWLWvu2m8fTQ37/cEIFN03dHF
         T7A3AVa21/S999+BEI3RI0gEb0qZLn03MXj06+/zrg74IrQ3V+tkUmcgncIPkojpB3yQ
         lDGn1IZUk4EFOW4auQaQJv9h9CcnPSrtXg++nvS7TALDok5rb+SWvXHaQz1ZHPCBWRIR
         fdkMnvJCmwZUuvJgRL4e4Sr0ubKirNn30K96Vo9gnvkwdN5zkKo3jRshP2hY6XFLADe9
         I364PM1a/HxgIm8XirUD9es+JaNRlA43cZnA0mI+UNY7fLkK+dwInzqUPrYYTP3JReZc
         0+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756466437; x=1757071237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMZx+r0Hud3j//XxrS83eFfSTnjOGkzpkCOkpFgd4O0=;
        b=MMYMGCXpWYF9KKt7PpyYWS19pXI0UzBTgHYZppnfZE3WSp/MdxkOimX5/zXSYSChAc
         CwFNAYnUncONBONhyiIcDauvJeJlWZWJw9szATgDq3o9ttR0YkA4FmnjSPvJIAaAX3Ho
         L9NUXL2H+j0TM611pMPnpf0kNjn9JGEATrZgyvd+FA4kq5a8wUWdcid44SqbIlT0V/ya
         oPialHM0EeuoJ4i0k9X2Im2EEj0W8/6jboDKpcFOuC1lp9jxd10sVp7CXNDYbtl7l2kQ
         K18kOx4RYwZdSrBjHGlhBnvBkBIjfQqXkUvVmX3BwTCc5I8oh2JsOxJ4vRHvFUHH5aLD
         e+3A==
X-Forwarded-Encrypted: i=1; AJvYcCUK0BUFaXtfNxo+StlSFVebKGbwdUd6QuU5Qu/hAlfe0Slj3LYDAj6a+BWHZr6WaLFUGlRg/MCQD4kAF9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNpC6ldb/7g/KTuM9bt8Xn8v/0Hhgaj1fLMf7d6P9MojBS9Hy
	95V65If4z01pQ0ZXRjCwIH4vpf2PfcGtLKrqFhc5RAKin7xXpVrDYOAouDUF7Rph0n4i1xY2Gdr
	uNMLE4NBXBLPZgA==
X-Google-Smtp-Source: AGHT+IFoJKnXd+Meni3wLFOMGsEYNQl20W186Gg6WN3MmwOInaFlSnun4yJtYAcqczMV8kqIowcrP3+LUood6Q==
X-Received: from wmrm4.prod.google.com ([2002:a05:600c:37c4:b0:45b:6360:643f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5c84:0:b0:3ca:b6da:a5ce with SMTP id ffacd0b85a97d-3cbb15cbcf3mr9482921f8f.23.1756466437518;
 Fri, 29 Aug 2025 04:20:37 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:20:36 +0000
In-Reply-To: <a6571b18-a63a-4e9f-b911-7cc10c72a4c1@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826-cleanup-should_compact_retry-v1-1-d2ca89727fcf@google.com>
 <20250826191320.d5aa551eb5abef316de41175@linux-foundation.org>
 <DCDBG4WR1ZDF.23COVR1IO2OSJ@google.com> <a6571b18-a63a-4e9f-b911-7cc10c72a4c1@suse.cz>
X-Mailer: aerc 0.20.1
Message-ID: <DCEVDXL7WZYH.320PPWEYJI0NN@google.com>
Subject: Re: [PATCH] mm/page_alloc: Harmonize should_compact_retry() type
From: Brendan Jackman <jackmanb@google.com>
To: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Aug 28, 2025 at 6:31 PM UTC, Vlastimil Babka wrote:
> On 8/27/25 17:30, Brendan Jackman wrote:
>> On Wed Aug 27, 2025 at 2:13 AM UTC, Andrew Morton wrote:
>>> On Tue, 26 Aug 2025 14:06:54 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>>>
>>>> Currently order is signed in one version of the function and unsigned in
>>>> the other. Tidy that up.
>>>> 
>>>> In page_alloc.c, order is unsigned in the vast majority of cases. But,
>>>> there is a cluster of exceptions in compaction-related code (probably
>>>> stemming from the fact that compact_control.order is signed). So, prefer
>>>> local consistency and make this one signed too.
>>>> 
>>>
>>> grumble, pet peeve.  Negative orders make no sense.  Can we make
>>> cc->order unsigned in order (heh) to make everything nice?
>> 
>> I think we can't "just" do that:
>
> That part should be easy to convert to a compact_control flag.
> Zi's point about going negative seems like more prone to overlook some case.
> But worth trying and the cleanups I'd say.

OK, I can take a look next week. From a quick glance it does seem to be
worth having a sniff, there could be bugs in there where code is
expecting non-negative and doing stuff like using it as a shift index,
in cases where it can actually be negative.

