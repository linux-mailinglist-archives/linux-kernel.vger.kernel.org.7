Return-Path: <linux-kernel+bounces-791326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29016B3B57D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7064C1888528
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE72874FF;
	Fri, 29 Aug 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+v2d1Nx"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8727587E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454871; cv=none; b=rzblS5EHUydfdNdu7JD51E9aBHfYq2MabJOrd6qHrbhVO/+XoJBKEcU74URkG/wk2IXVWO+lIGARfQz6lUdRqXfwEeayI+c/ENAJ1Q1bvEf1KM688S4FLUhp9PHXVEWQ+aXJiC1P07fnVLhVx/DL0q0AAbVwxBBgaoK96p9NpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454871; c=relaxed/simple;
	bh=g7hvdpZ9t6wXWWr1/ENXJqfBe4wdItmI1tbNY4EpySg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HYuXhwAsk58p9ifHiXDzwRa8cB0oRDXeF1fouaw5mcs4VU/CBLGsVcpp7gPfSJMcX6BA8TeR35ErayKVFWQe1Yuw/e9K1nD/vrPCLqWxprwMKup6bf6g08VruXMJG7RCfAWgxMww1qIOlWwmtXBrD+Mkv6SQJPXReiUpjkqjaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+v2d1Nx; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3cef6debe96so470055f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756454867; x=1757059667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfOnoSdMFEY12A5kAdJIINWz+0z/4T/piULOnnacnTU=;
        b=E+v2d1NxESh57YYXyDhqiQb3wrqT32yuoKreFhxu0+cpwGShXHCu+3Vm8nVdQAmNNF
         nsjeHmUMtLa6F8gCn4AXj6rrB8HVj/8O6c2bmd8PnHjInQSRA7npU2Zpw6nloK+UuRml
         8QvP2OoG67r+yB1JxlBUr8uCexhmdtY/ZXxrpczJR+mBtpyHJKWT6h/HOYZMt9ADTqei
         9u5R+plgsgctcBfrSOnlB6rkvJkt8jsouAaMkfkTDsLtMpH8Zp9u0BhaAYfys/DcT0pl
         SPFH+s7uFxETCCjR+w0qqbhWpB2RG+XtLnqf7mYnhU6tqqfaVAaGaxoOYa9spc+0UvpN
         /Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454867; x=1757059667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfOnoSdMFEY12A5kAdJIINWz+0z/4T/piULOnnacnTU=;
        b=SoeWI0oZr9pClSPoWf5ZoVve1WOzIsBkPBiiH+XxtBUdL4HROHCYFdCPlMs7OeffWY
         0Ozsv1YOPiuBOhPp7abihpoIfqIlbTF4LI+/E3x+I8MvsW8m3opqS/52boNWs21c25qY
         iSo0WjAlWEVPssWaVXlolRJcPhzu1wVwH5b1/GrWMbVWL0MNvT6w9DCQhgK1gzeSPG4j
         HNqmLe5j/dk5000mPAXjUJ/uNUV3XFKzi39nzKRCyg/ajSbB0CsbvpqFZtxAMBQe1dyh
         jOIF0pkKKFu0ajaBladE7SkdJYvYQUM1t9TYjh9eYo0ZuZ6NafxTo0khK46L2L8hIRcZ
         8o/w==
X-Forwarded-Encrypted: i=1; AJvYcCXgrmZN0ytih9HyYUXXh3BDviDYAbDu7UxX4IJosctzO3fAamiN6rG5yOfF4vNhWb2wljXfMoHMy6N5cFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAelvbjH1Fof5XRDoZrJlv55e1RaL406G2mQKBl2YO9c3e4vJj
	hp39gK4a4TsC6w9caA9zAHnx6FQzTt8gpfMAcN6aCdKPCmRLQYcmSsr0W9iTJe67jojxemX2ueM
	VSiEiGiFi12vttg==
X-Google-Smtp-Source: AGHT+IFJ+ze82M8nDeFw85CqWHL6EDCvm/pvyvGMy6Ixf0Ev+KdhEZ+X2YsmGSD4LRNTVXGN7ctJ/yclVGX+Ag==
X-Received: from wrs1.prod.google.com ([2002:a05:6000:641:b0:3cb:ea8b:ea9f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c01:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3c5de34badbmr20447829f8f.59.1756454866646;
 Fri, 29 Aug 2025 01:07:46 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:07:46 +0000
In-Reply-To: <20250828155412.2b1b2095125428af24896af5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250817065211.855-1-ujwal.kundur@gmail.com> <DCE2EJ3KWX3K.1Y198FHBV8UG7@google.com>
 <kd6uteyd4vzlnbdwzjydwd7hoqyxewc5fx24z5sq7svmtoa3oo@n57xyeu3vtyy> <20250828155412.2b1b2095125428af24896af5@linux-foundation.org>
X-Mailer: aerc 0.20.1
Message-ID: <DCERAA0PTPE2.1Y0KLQS6IO5O9@google.com>
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>, <peterx@redhat.com>, <david@redhat.com>, 
	<lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <shuah@kernel.org>, 
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Aug 28, 2025 at 10:54 PM UTC, Andrew Morton wrote:
> On Thu, 28 Aug 2025 14:49:37 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>
>> * Brendan Jackman <jackmanb@google.com> [250828 08:37]:
>> > On Sun Aug 17, 2025 at 6:52 AM UTC, Ujwal Kundur wrote:
>> > > -static void noop_alias_mapping(__u64 __unused *start, size_t __unused len,
>> > > -			       unsigned long __unused offset)
>> > > +static void noop_alias_mapping(uffd_global_test_opts_t *gopts, __u64 __unused *start,
>> > > +			       size_t __unused len, unsigned long __unused offset)
>> > 
>> > After a rebase this is now falling afoul of the -Wunused-parameter added
>> > here:
>> > 
>> > https://lore.kernel.org/all/20250731160132.1795351-5-usama.anjum@collabora.com/T/#m0449dc0d6a5ac3b1f71f7182c13b6829e1b444cf
>> > 
>> > I really don't think we want that flag, I'll comment on that thread, but
>> > just as an FYI here too.
>> 
>> I was under the impression that it was decided to drop that flag,
>> otherwise I would have also spoken up about it.
>
> err, yes, I thought I'd dropped that.
>
> No -Wunused-parameter, please.
>
> The v2 series needs work and a v3 series is expected so I'll drop the
> v2 series "selftests/mm: Add compiler flags and fix found warnings".

Ah yep I said I'd reply to the other thread but upon re-reading it I
realised you were already against -Wunused-parameter, thanks for
dropping it.

