Return-Path: <linux-kernel+bounces-840355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A93BB42E9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AA13C8036
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7E311C27;
	Thu,  2 Oct 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brZ2gA/k"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537091957FC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415972; cv=none; b=L/8IRKhsSKgCJofYFSY5nKRb/ZvWiFHvpZ1PbvdCujbHtP3nB6dvxLXDc7/lk7/ymI0vWL1ra2g0I+TmHfe5GQ/gvQ/HV8ZcFhdxx0H6gi8xJEjHiU4jKUVfD0BOKeiUAjc6bTfoFiwvNQATEHmTsDSqKQ7W8mFyYk14bFHV2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415972; c=relaxed/simple;
	bh=ZgJifKAYclwuksAzdwVb4LxMXtZ9KivKO0SSX/qAq6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V+hvbIMEp3vRUYl/e3pwWIa/bWj/Pbn5XuLXcXzAde2F95lCYXTbAhvzrjlPpqQkBUK/HRmsVUOWx2XUTt+tPRl5HuXWOi/tD7fKZspOQ/1iHbB1f+rpy9h6w0cj3A2BRWaBW1o6i/jiE3cB0bHCCn0QHinz7veQm5bH5jtjAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brZ2gA/k; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b479e43ad46so96945266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759415969; x=1760020769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OXmRPiiy/jxXhEQ2QANIVQqqqCVGSfAH9NdCa3WEjBc=;
        b=brZ2gA/kSOkNxC/ZMR/PLntSPARSydjpFGzVoM6w/Zgoon+ObsUlz9ujtKZR2K0S7I
         eJIfqcv1uaLcJJdmjB7f38jHaq4b/0L13O00riR6uS41E4O+nt2rhCqDG8pxYl9x+p1h
         FCJrZE5Qa6weNX1F1AsNAt4hXeBmUwc1KFmMuKmOQ59xAVc+KK+O89ZJxJw1XACrRRQl
         vHE6VqydDAnrRLJG0bgPe2ndp9T12PGSjk4XvTMqJC+jIUqI4EgcTYbrDMeTGZ3kzBCO
         wh/xyPZhgbN7zHRwWfywxK/yAXIC+1N99tfFbIpA938ZYjktHbzHk8V1WTMjdjpJQnf6
         gobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759415969; x=1760020769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXmRPiiy/jxXhEQ2QANIVQqqqCVGSfAH9NdCa3WEjBc=;
        b=IB3pGKTLl7gjAfrF6VHwddEbAqjAFy3lOTCFT9RfjMFY7ARFdsirsgwtSnM/3pH+nB
         Rz0+oaksmzsT5FmBJiW5L9C8tKD304d6LH84J7+9FKxiDpqu4dRemG0NNOsgCOMzh64E
         QNAf48oKYqZeW9OSK5sYpH7+jQuQJphuOm955C/F/Zapywk9+k6gtPti6pSRqDMATRix
         r1GpBLXpClVtntWabB74L6zC9PmQTlVDEMhBJuihbHK1bxxCgG9j8LCPc26TEn+V/TG0
         iqxwe02et88qulrN98L/TVeVt7enWaNdJ5rHSO7Q5aJmf//G9Bk44t4cBZ+KZj6/GsX6
         BEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTy05BbvaF7YcCtFG8TiOGypH6mn4RDt7l4kIrkZ/t1H5TpiRmDFVY37VcdeddO0C8ePBJ80A5n1++ol4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywohd4F2KZvzNgB6oPHrJ6zhgkDjHN61/kXpuFhoh8qpaw9jwrw
	koJNg8dEfKRsrQ1t2oZpGImqK1EZzlM6R1/kh9Yb5IFPQLlFSWa2S21hCAnKiOIbioNJtmJ1oiP
	G8GR3a5X9elKLkw==
X-Google-Smtp-Source: AGHT+IFnRkf9ot3Skun0op0G7EM1gEJs7lrJQJnh2eFwDF5s4NKmeG9rSXFP7Ix3NYG+PqPTDK5hgURKWHPSPw==
X-Received: from ejbo22.prod.google.com ([2002:a17:906:3596:b0:b3a:79ae:c785])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d43:b0:b3e:babd:f263 with SMTP id a640c23a62f3a-b46e4b8ec24mr986902266b.3.1759415968473;
 Thu, 02 Oct 2025 07:39:28 -0700 (PDT)
Date: Thu, 02 Oct 2025 14:39:27 +0000
In-Reply-To: <caee3410-a01b-4e40-9f0c-ff7810caf323@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-11-2d861768041f@google.com> <caee3410-a01b-4e40-9f0c-ff7810caf323@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD7WWPE3YSPZ.1E51AQNHNEU2G@google.com>
Subject: Re: [PATCH 11/21] mm: introduce freetype_t
From: Brendan Jackman <jackmanb@google.com>
To: Dave Hansen <dave.hansen@intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: <peterz@infradead.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<mingo@redhat.com>, <tglx@linutronix.de>, <akpm@linux-foundation.org>, 
	<david@redhat.com>, <derkling@google.com>, <junaids@google.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <reijiw@google.com>, 
	<rientjes@google.com>, <rppt@kernel.org>, <vbabka@suse.cz>, <x86@kernel.org>, 
	<yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 1, 2025 at 9:20 PM UTC, Dave Hansen wrote:
> On 9/24/25 07:59, Brendan Jackman wrote:
>> @@ -2234,7 +2235,7 @@ static bool should_proactive_compact_node(pg_data_t *pgdat)
>>  static enum compact_result __compact_finished(struct compact_control *cc)
>>  {
>>  	unsigned int order;
>> -	const int migratetype = cc->migratetype;
>> +	const freetype_t freetype = cc->freetype;
>
> Just as I'm scanning this series at a high level, this patch looks too
> big to me. There is too much mixing of mechanical changes like this
> s/int/freetype_t/ and s/migratetype/freetype/ with new functionality.
>
> I'd be looking for ways to split this up a lot more.

Ack. One avenue I didn't fully explore would be to break it into:

1. Introduce freetype_t as nothing else than an annoying wrapper around
   migratetype.

2. Add the sensitive field when ASI is compiled in. 

The reason I shied away from this, is that part 1 will look kinda weird,
because in some place I'll be switching the code to freetype while
others will still use migratetype (code that will never care about
sensitivity), and the distinction might not be obvious without first
reading part 2. I'll just have to try and write a good commit message I
suppose.

