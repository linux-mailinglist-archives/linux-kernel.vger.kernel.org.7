Return-Path: <linux-kernel+bounces-778124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A022B2E19C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F25F721D16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5032275C;
	Wed, 20 Aug 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2NtjjLl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D3322762
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705387; cv=none; b=Z4B7wrmfV6V8q2KjQUqh0+pGoNursvJDkm9nrSMQM3PXbYWig2eSnuNuzHGbH/jc27U1CB5xO3wZEDu2bwd26npqck+jnB9Ryz+Vhlm55nSmMXUgijl/PAxqPanqsv4jgyBhYKXwuU5rKZwR2YfYfonai2gD+iUO3gJcR3TwKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705387; c=relaxed/simple;
	bh=R+Ptmzm6SrCTWJS8/j0R6UkbUGMTtTE9b9TRKD7b9iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7oqICN61k0KB1qx6fsTWGHmfdwYeifu4ukXZaAtsIVSJU6wDPRdx0v7CjRCQBiNaw7s8+5hx86zZ0d/ax6c9dXgs3UlMWe5/r2lwCqtPDSJd7aT0L/tdy/1HRRJymDI5pqmTDtILO21H/yCtErzQa84RFFFnWDShklqZ8qqjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2NtjjLl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755705384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Er23qODQtG4idaztLuSjwC5wmfZWAF3dygpF7gAo74Q=;
	b=A2NtjjLlxaiCYVYCws2eZQpKLcUNANzn5d9BGPK9gCxPJHX+eSpsy/hwGDl9OJ9oX0H3rK
	zNtgCZ9cUGEllIKWLUny23PnfFe1g7x9tPPaMkOY+pP+DVRBKnqb8zTju8xDMNEcgo6LnJ
	imolLZcfPLZSVRXL1la5nAd9lOjHoBs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-zGnAcZdQNnyW2x-TtQ9ulg-1; Wed, 20 Aug 2025 11:56:23 -0400
X-MC-Unique: zGnAcZdQNnyW2x-TtQ9ulg-1
X-Mimecast-MFC-AGG-ID: zGnAcZdQNnyW2x-TtQ9ulg_1755705383
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71d4cc7fa4fso18542127b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705383; x=1756310183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Er23qODQtG4idaztLuSjwC5wmfZWAF3dygpF7gAo74Q=;
        b=ssJsSIVnkAhi6OCxkuROdZ8QZVNpBXTKul3l96Qjur8LyOCAhDoq+UF3zU8FqvHbHv
         00MHWS557wS5YAmVSkd0YtF0pF4q38NIb8rsTmanDNz318MLg47Q4EJWY9wBY0ohm6sz
         GfM/tuPc53o9cxxQmTfvf7bNQ3rr/M0nOMjtZa1r3rxz4XzbS9dSLTi2kXlskvaIeSOR
         Xx377aFR39dAXRuQnNqM7wcxvCuyOHk4H8kgV+wj6VUNw4w/3vhX5aFC3A4OhwpzrjNa
         7z01bedoTxZsT75W1e+8ViUsuw3vyVkP41RTE4IUPzOKXUBYNtKO9vtpmcWznNC6ysQJ
         93Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX/1f//jYkFtQWcq/fE9Q8xqc0SFTNu8wDchX/ywooYEPyKYxDF5APL7Faa/eL0zsllZehQg3uhApwJQns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQC8rvnYHO0Mj0gZ5NcDNurTutSEjjzCX1qqe/J1h7qFrAID9
	C8oqaz6w6ppOwC6ZpXg5UTEE1HC6sbN2XIBTUID4YgwiGXPP0jgWlFPmELfkpuD1VlMQVS+Rw5h
	+cj4VTXLEX5pEhjrSKEYfYut9uslWUuJaXdcCTjGq82hWV7aB9ZwlkEUoYLlfB9yVNTVCgRSOXz
	JDzNojKli+KTfFlo8zIjhlbHRDb3vVJoWlLNVnczeM
X-Gm-Gg: ASbGnctDKmxG+IGBubhgMZnvnhzlneDjVN39hNv/bKSndQoLZfhBCXhaR+d4Vwss5Da
	YIgLpg30OihQLJuVpbkUMJPpNEMzyV9pMi4QRaFz46aI6dhMKCQUN6PyfgjQ7aotRvfB+LeeJHb
	uamgdn7LOfqFYX73EexlDyy0s=
X-Received: by 2002:a05:6902:2b85:b0:e94:fc8c:e1f6 with SMTP id 3f1490d57ef6-e950485820fmr102028276.5.1755705382733;
        Wed, 20 Aug 2025 08:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS+QnZtdkkS1vjc4OhO99gWxx/B53oOwhGsZXtA1ANwD9WwiLwFVxw4OYIIrLt4QKiuxs/inUSPFs93SI8/Kk=
X-Received: by 2002:a05:6902:2b85:b0:e94:fc8c:e1f6 with SMTP id
 3f1490d57ef6-e950485820fmr101964276.5.1755705382248; Wed, 20 Aug 2025
 08:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <20250819145530.243e02184b743eb9ec506856@linux-foundation.org>
In-Reply-To: <20250819145530.243e02184b743eb9ec506856@linux-foundation.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 20 Aug 2025 09:55:56 -0600
X-Gm-Features: Ac12FXzgXuKDwPVbATQMmVh6NLWeMMDQC0r_rrDLYa5BGBJGyBVrKKAptFCfllU
Message-ID: <CAA1CXcDpRywoWKXyoJPBgs0TCbENooQsj+hDzYVhP4eYsiiFJw@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 3:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 19 Aug 2025 07:41:52 -0600 Nico Pache <npache@redhat.com> wrote:
>
> > The following series provides khugepaged with the capability to collaps=
e
> > anonymous memory regions to mTHPs.
> >
> > ...
> >
> > - I created a test script that I used to push khugepaged to its limits
> >    while monitoring a number of stats and tracepoints. The code is
> >    available here[1] (Run in legacy mode for these changes and set mthp
> >    sizes to inherit)
>
> Could this be turned into something in tools/testing/selftests/mm/?
Yep! I was actually working on some selftests for this before I hit a
weird bug during some of my testing, which took precedence over that.

I was planning on sending a separate series for the testing. One of
the pain points was that selftests helpers were set up for PMDs, but I
think Baolin just cleaned that up in his khugepaged mTHP shmem series
(still need to review). So it should be a lot easier to implement now.
>
> > V10 Changes:
>
> I'll add this to mm-new, thanks.  I'll suppress the usual emails.
Thank you :)
-- Nico
>


