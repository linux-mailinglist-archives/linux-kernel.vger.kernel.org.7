Return-Path: <linux-kernel+bounces-746461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5CB126F4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D01C861D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53123B616;
	Fri, 25 Jul 2025 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLrWBITs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6A233723
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753483071; cv=none; b=dHzZEEaBq9hnJ9A1sF8Ucw68VfdnjhURc3pFQ7tjvsijkeZYR3hp4cF83S2sgA5BPSSOBLKDPQADqSqKVueEoJhQp/awJCMw3MHekBqU8MO/pHLEacUcOkdUIWHCl4STEJ5XOCKS826uUp2GHodeF7565Ri0292jF+1fVVYjlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753483071; c=relaxed/simple;
	bh=PxMQJ32P9TM5LgrkFm1FLN9ED8pQui3GJRtf4HfC5h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJMobEVOo1pUlhTzt9B48PfqgeRx0qFdPnesahWaw7Xk1SDDJT6fey/7QbrMprji+Emzw1CTZWxs9tqtm2BO247pxY50er/ipA0d1dpCZJ56ue8R3rEbnBnKaNEiwZgKYhZoJtXZn64X8WaMTMfJRz39lzLCaDRpt8o35CRpVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLrWBITs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753483068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxMQJ32P9TM5LgrkFm1FLN9ED8pQui3GJRtf4HfC5h4=;
	b=HLrWBITsS8zgU/vH4iAPhs4UCRrHuraaL9dC619wNHtl3I5VJ+3xCqVdoggmjWEQm5ZKjA
	lrvNkjGr2eESy6/hfbeqjExx4vrPUdWgCvVHAVsN9p+Fc88fbXL4ypdq+/yFbLQp53O6lN
	/GeIUDt6Dhd1fznXArGUxYHZDpi35cA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-UlWjVOnXPQOxNZWjcuzXkw-1; Fri, 25 Jul 2025 18:37:47 -0400
X-MC-Unique: UlWjVOnXPQOxNZWjcuzXkw-1
X-Mimecast-MFC-AGG-ID: UlWjVOnXPQOxNZWjcuzXkw_1753483067
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-707cf1b0ecbso42044837b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753483067; x=1754087867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxMQJ32P9TM5LgrkFm1FLN9ED8pQui3GJRtf4HfC5h4=;
        b=APEGSt5NixDxn92UjN20G/YBlwUzPK1KJDA5AWBMLJ7bEVqXKjdaSIq6VwIo/TUocD
         LWBq/FncRCvA4wjQqKQAVTDQK1oniAdzSDV+UKoR1sBFXC0QvgSnhgWzYs/1qbq1mwov
         qdS6O4R6P7Ufure9JSNv2qDL0ZbD3uGH2EJ+xow9XKKwnDr3LRRoThSsmch9Xo8lhAw/
         yBj2jMWSeiSLRCJ/KaCM2StO2tfIZ+XIsCJdP9vkkoeZnH9QbTOQwOOrHpZqgBXmT053
         eq66oWxoiQj8z+Ct7CWrSRox4WQoa5ezJk7da7f3xTunSYU9eoLxs6fK2HTaMZSkMMjv
         QSsw==
X-Forwarded-Encrypted: i=1; AJvYcCV2l41B3MvnNJ9NwD60aX9HrMn1BKmEKB8Irw2MF7SUXLqVZ052v7ipthEQf43zPCUlap7NhwDaAs1CeTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nVhB5i1SjF/LJ19PUj5AZaKq0HN9ZWP0E+wOdXGKRH1FMzri
	ejcKg5aH6S/G+wHn3v0kziQ0nw3xkC96iOz5f41rxpsllOWxrbpRmkEOSDo+PgurpWO1QGK2zEW
	nWahjcueCtDlg0Uv2zZ2eb0iFtA0ZzvaGOg1fzPZ+CK2gHRWSGJunnJeCzSxVtSlC3ZKuAfCHgu
	DIWwVPIu07vbeeLr4O9IT2FUM1O3qOdKw02LmQYQ0F
X-Gm-Gg: ASbGncud6oshoiRCkweh0RFEe3hd1bedFzi7hLjppzapuWvSE5ORntC1ibV+q58mhHI
	oSkViJzZVnstHBfhTf3EpkZAR/z9cgG6tQVUI4l9A5wsh6Qbk0/WBl+4TsGE8enOE2TAUu1FHkk
	gWnpeBREklB/0RhJI6NJlNH+c=
X-Received: by 2002:a05:690c:4513:b0:714:3e:f424 with SMTP id 00721157ae682-719e3461242mr52042987b3.35.1753483066680;
        Fri, 25 Jul 2025 15:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfOqA9QhdPY+M0vEESx6VKf5ml2IvqKk9pj3fqjSjpp95LtZTi4ZjJtdc1Jt2Guhr63gv18jpOEl7GBVnJQNw=
X-Received: by 2002:a05:690c:4513:b0:714:3e:f424 with SMTP id
 00721157ae682-719e3461242mr52042437b3.35.1753483066311; Fri, 25 Jul 2025
 15:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-6-npache@redhat.com>
 <f87dd075-59e1-463f-bc36-0f6582abf31c@lucifer.local>
In-Reply-To: <f87dd075-59e1-463f-bc36-0f6582abf31c@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Fri, 25 Jul 2025 16:37:20 -0600
X-Gm-Features: Ac12FXy2-qDATzXIVs0g2RONSMMgciAzDMU4oBvRHpQajDJJel4xlOl2pw4wSCs
Message-ID: <CAA1CXcD0qKMqR4KSD-uqVORk=_gB=JwfkQ5owYV792B5Ng788A@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] khugepaged: generalize __collapse_huge_page_*
 for mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 10:15=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> FYI this seems to conflict on mm-new with Dev's "khugepaged: optimize
> __collapse_huge_page_copy_succeeded() by PTE batching" patch.
Yes, I did notice this last time I pulled. I haven't taken the time to
resolve it, but will shortly. I want to make sure I do it correctly
and that these two dont conflict in any undesirable way !

Cheers,
-- Nico
>


