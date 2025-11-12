Return-Path: <linux-kernel+bounces-896709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64BC5106D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BB3F4E8538
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AFB2DC32C;
	Wed, 12 Nov 2025 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zsjL+X3D"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE90524F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934140; cv=none; b=K4Sb0IVoa3mloCOPSkdmYipGzLMqFKXW2Ut/js8MP96TCOelVjTssohJAMDpPLMw/6uX67+09JByALY+Al/71bHSNgb6SxlMGg+fDkBBQHrH9QTISYMNGbeoFxYP2f83nodQt4jNwbHfzBh0mSFBdaDq2V+USpv6P0uUWEPuzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934140; c=relaxed/simple;
	bh=PHbL1ERA+MG1ATR0olU7fO6x26gtp/SyVAUf5H4qP5o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JePf6UeZ7C+WK7lR3N2csaaJpcmOkvp5bOIdIf7fMwk6CqznfMd+RQ6Od36ExvQaB5al4ARXxp2j47s3EM6K9nNR/e4+hrEKE0oX8QYAUOg+X5z07EkxWmn88bMTfMt0lHnh+d5xHYNwUSuNiy2odOJTXJNJw+oZ5G1n66u0R6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zsjL+X3D; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787eb2d8663so6864647b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762934138; x=1763538938; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl7gNLb9e1XNfHZ1ke1YgjbEDtdx1ds8TquivJFZA5A=;
        b=zsjL+X3D5ohdxvttpppKARpUJPuoddz4/2VIVtoLkUGrnutIxua+ZohT3kZH6s+Vu+
         Mp2aXlbvegr0Po5J0/Oc71v7gzxHdIWrymytnkE4qcuzuytVnWPNGKgp0RS5vo0djG7l
         0rG9vWGPn0V0uZp0fwdt4+2VAIDRWLwvEQiRfu8pnKZOhiYGnLSJcCostPmet6nlSjh2
         6BymYq2ixtqTHnz9OGF2rD9+smu/RcKYzpx8tunL3vV0gwOtORwjJ7eCsqyj1JI+xW24
         1SgoVbc65ZYwBKH4jo2T+lGT8pNZTQuxCkktehL5hq/Md0AK2xFj2+wEfDRHStIBGE07
         sA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762934138; x=1763538938;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sl7gNLb9e1XNfHZ1ke1YgjbEDtdx1ds8TquivJFZA5A=;
        b=hDV+ePtwRqMEqZUEG3QlAH0hnueeJRcpTALV0ftd4+Qvc4Z90ZLlC9I4fBugxRQEMk
         pfLyaga0pYCsZuUvRjQYaEVl/hkGjpZ7ZqnjWuW0joIjUqVOinmGAE4Nu8EJOfJh4VMb
         p69hmLK7odydpsbte9o5yv+hEuUvZdY7yWHzp0QY96+ImGkBJ/8M0LYT6joLR1xwH+kq
         tb9wYxoIAXfum8gYvLxU2rFrZsGwDt7g/BPep18JkHr+Oeqy0QWZubwWMeNmBpUqm+xS
         /dzJz8qnxbOPtcX4wbOdx3WbQAmRhsJYnz1a17S2S3SCttgFDgWfMX/GEZaKYXhmLaqP
         YcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnvSw9mjGM8dHRPKSMUop50t9meh1zDZUPoN0CuIMhjpX+EUZesJA+LG5czriTVsPt9+zCaKSUTQggb9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyKamq1ItW+NoycPFjPiAKilJyUZBR1UlDS9dq9+DbVEw4y3A
	vYKzm73fm0+YRnKyuRIrkldnXO2sfi4jMV1rDCvt03zni0k1haQvS3QDQ+6OEIukUzzZDfRLCPE
	KQx5H74bT
X-Gm-Gg: ASbGncsk1QUh/sraFX41PWrQBnxAY8xLZf6wWj17PZ4IN2oDVt7N3Yvam6r05K4kntQ
	RP368vyGj0qKP8P+U0DWYtYhbEEd+ayCQhDvDEVONDnyoaTNSiJQsLDLirN7AqdPMMpDFDbxWDs
	SxSg0+YbtupdiMUijeBd4qeTXFDNCGY/uAIoLCv+LFc0K/i6tFp912i8JBxoAF296dIC0B3nWmw
	MNBHzgxCP+L0vfj4ktg3rIwYYBfBQy8dG+X3AenzfzxMqoKnOJCZwlzyZPZ+erEWKdkXDuXGO7B
	v5bOV6hIdSPd6eh5IMnX5TwUSAMdzeh63K2hj/DUfaUAihEyRQ5m1iem+wnYwsKJq/mlENRMMXp
	Mowz4I6F7tvaf7qQ6toUU1Vg0TvNF1X/F31Vt2mptw+vwh3LXtyj1g2Qeo7F3W+5OkhQfTJegNP
	cT832Vrqc0kyx2q5VwHt29qO7r1hlUzcey6y1b2XLCWbx6vi2lBb2d9kiD2n8CwdX7JN32D936u
	acwrH2Sqw==
X-Google-Smtp-Source: AGHT+IGjXmFCn3shGcJBm4bkU5Nd/oIYOdwifgyIyaTbMQ+yB+EiuQ//lL4hWR3mfTV88/f2KB3tsA==
X-Received: by 2002:a05:690c:6c03:b0:787:c44d:4b39 with SMTP id 00721157ae682-78812f5873fmr19686587b3.4.1762934137651;
        Tue, 11 Nov 2025 23:55:37 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d687e26esm39783697b3.27.2025.11.11.23.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:55:36 -0800 (PST)
Date: Tue, 11 Nov 2025 23:55:17 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
cc: Hugh Dickins <hughd@google.com>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
    Vivek Kasireddy <vivek.kasireddy@intel.com>, baolin.wang@linux.alibaba.com, 
    akpm@linux-foundation.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
In-Reply-To: <CADhLXY4qMvBTqirNmzgiPszn8vCkCFV6GGeDkNpxVDi32uhzEw@mail.gmail.com>
Message-ID: <a6d0156b-5f65-9426-f27f-8a1af59bffa0@google.com>
References: <20251112031631.2315651-1-kartikey406@gmail.com> <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com> <CADhLXY4qMvBTqirNmzgiPszn8vCkCFV6GGeDkNpxVDi32uhzEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Nov 2025, Deepanshu Kartikey wrote:

> Hi Hugh,
> 
> Thank you for the quick review and for looping in the hugetlb maintainers!
> 
> You raise good points about the approach. I chose explicit zeroing in
> memfd_alloc_folio() because hugetlb_reserve_pages() can allocate pages
> without seeing the __GFP_ZERO flag, but I'm happy to revise if the
> hugetlb maintainers prefer a different approach.
> 
> I'll add the Fixes: 89c1905d9c14 tag and Cc: stable in v2.
> 
> Should I send v2 now with just the tag added, or wait for feedback from
> Muchun/Oscar/David on the overall approach first?

No need for a v2 at this stage - Andrew is very much more than capable
of adding in that Fixes tag and Cc stable if he's inclined to grab your
patch for mm.git in the interim, but let's wait to hear from hugetlb
folks before finalizing (I expect they'll say __GFP_ZERO is no good).

Hugh

