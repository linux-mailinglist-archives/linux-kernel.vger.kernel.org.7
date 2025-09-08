Return-Path: <linux-kernel+bounces-806689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA9FB49A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FEA1BC512A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDE02D5930;
	Mon,  8 Sep 2025 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLxVOvV6"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56A2698A2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361428; cv=none; b=pW513zflCqlxuNcNGCtJa51csGtoWkZ8NJ9F5Xh66jnqty/RjdX5Vm6qyXRWLDMfCDSiydkug6vkaZR/it3sofzw6ykntp80aXP13+PEd6u4kq+1Iaxl4+/RhrxD5AiLV8uTGTZeSUgBr3jkrH2OX3UJvsAY31INT4sgvJQUrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361428; c=relaxed/simple;
	bh=j6HnEXSAtqCKeWJJLJ+uKJUb/6XN8Wu+ma3pNqzPIuE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ggD7fh42xBtKCREZILlsvX5QvhBJrCa3UZMQk91hw5+ZM9c2VFyqFjMlWejG/F5hnmICsuCyWZ6pJsmeUp4aDkz3VrJxhxJ//pH5WDRP0tpQH+2o/bGqTuZNVS+XbIjKR3N/1cOdwPTjYpjYm01ZUbL0GNPjZdql5ZlKdR0+kNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLxVOvV6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603b60cbso44042647b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757361426; x=1757966226; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IoLXbGMjxLNA/suFUGEkTpr9rzpTqZI/pHyN/Th1x4w=;
        b=cLxVOvV6PEuQzFQo6p0U2q6rG4SGoC7YC/Hw3/I2ccK/dwR7yuojW2zguNi9WSAtHS
         e9YJWdWxs3airLFRI3xURDKD/ByeIEtxT3zPhbEU+xgAWYF3979fxckxIibfegxUy5PX
         hdc11jiOBKlqhzWzGRVsmusCxfHwGfUQQP9YPYwd28k2k5OawEgfwPcPXl4giSXKa6cQ
         Ky+HcNQDznn3vy2MWfLds5N7dCmVb5CghvCBAbfRS9+ckAzZMuf1DYrTvFhxkmhhxDGZ
         qn1XrxJ8CKKHIGbNQDJ6u56HVk77Tv9F6VofJySnDKqJo//mtULKDA4FqxcXI9vT7fOB
         Vs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757361426; x=1757966226;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoLXbGMjxLNA/suFUGEkTpr9rzpTqZI/pHyN/Th1x4w=;
        b=OW+pU4cOlmaN1L910yWRZPlseHqRDr9tVuw5rFOHyIgwH+O/K62uiqUs75rU32wvkn
         xzs1jWrUyAtoGU+M6ST1paJxl6BriMrt3GzfdmSPr5SARir3wfhz8FpIp0F3zbfU3qpa
         j8ZZ0pA9wPaXKUANpE84Y+mSX2LBr87oM23qtGioMET6YamsKj38vNTiPjfSTV9OFDji
         4Vr//gYHCfPbcTVvZV8jQb43SW4cFtnlrOMnjxecGilV1v2Hv3g61meCmpBGNICK2O0/
         4cZoLkwO0y7kLwWUxBa+L7GX+0AuEhrHDKVMQALMmo2w+2fM+gdPljBshZmiMKa64Mhu
         EqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1hAU2F/o0T8ln0LkqtUNz9BRVdUbyH2QKLRtyeHQckLEndtOPXR/8jxSzG22hY7N/G0+ZeIes3VBgki0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDPACOkWvHNczRHA1lo/3K1BwhjlDcdvTDEGYG481hlY0JAtq
	z0YDAupSgaiPsKAjR1wfaC0WVgPUGkj/FgC6S8RjBgF2WaQewr+fFxT5I9yAb0MmPQ==
X-Gm-Gg: ASbGncu79LtmAWoLt73vXx88QJAYUmFY6U3gryqoYVyLuLSdzCIO27t6jiCsujrk4PC
	pNiL0Mjw4+7E5Hh+HjZPK+Sio2WhmAJpe37140nFURLYMvjL9grGcd2tmCNJMmtEQKCEwFEu0pE
	Jmp7WxFMl1OedxRou+wKyBhMUM+ryeqfi9vIRlD/RzDZGUcIYtvUCdH7nkhS3x94jCPDxEbFyPt
	BTGNEl14OIUUddy9bqxmkj34DL2f1oO+l5BdRFcM2+F1e8r7w3LquNWcC3aAZekqeV4aIYO8RbY
	BlKSfkcEr2cgGnpYVRvVpREao0hUMM0+rFnkZfZANv/Pt+/PXVvRwInYOxyarEweONROHP1t2BL
	0gpL64ZMHV+rADmCGjbG0B3ml8L/VFkaSQao1X/C8kEEd0lRBUx7jAjaHRfJL2m2+xQoQhoq2me
	MN9BLjFuRnHJB+RlmRYg==
X-Google-Smtp-Source: AGHT+IEp/mRnH+3Dncw0ZHtHoBb2u3crhoWQ36w+MTA76D0QR6yb+nxhPQtfdxvv7OvzOG6eN8DgOQ==
X-Received: by 2002:a05:690c:968f:b0:71f:d459:788c with SMTP id 00721157ae682-727f368e699mr88931137b3.2.1757361425548;
        Mon, 08 Sep 2025 12:57:05 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5ff8ed34211sm5953906d50.6.2025.09.08.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:57:04 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:57:01 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, Shivank Garg <shivankg@amd.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH 2/7] mm/gup: check ref_count instead of lru before
 migration
In-Reply-To: <1f714ba0-cdda-4122-b6a1-e1e0ea44b1f2@redhat.com>
Message-ID: <d5333648-7b88-9293-dc1f-e080dff65d1a@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com> <47c51c9a-140f-1ea1-b692-c4bae5d1fa58@google.com> <e54b1d8c-ad63-4c7a-8b1b-b7c3d76446f2@redhat.com> <b008aef2-f69f-e2fb-d4d7-71a42d308529@google.com>
 <1f714ba0-cdda-4122-b6a1-e1e0ea44b1f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Sep 2025, David Hildenbrand wrote:
> On 08.09.25 12:40, Hugh Dickins wrote:
> > On Mon, 1 Sep 2025, David Hildenbrand wrote:
> >> On 31.08.25 11:05, Hugh Dickins wrote:
> >>> diff --git a/mm/gup.c b/mm/gup.c
> >>> index adffe663594d..82aec6443c0a 100644
> >>> --- a/mm/gup.c
> >>> +++ b/mm/gup.c
> >>> @@ -2307,7 +2307,8 @@ static unsigned long
> >>> collect_longterm_unpinnable_folios(
> >>>      	continue;
> >>>      }
> >>>    -		if (!folio_test_lru(folio) && drain_allow) {
> >>> +		if (drain_allow && folio_ref_count(folio) !=
> >>> +				   folio_expected_ref_count(folio) + 1) {
> >>>       lru_add_drain_all();
> >>>       drain_allow = false;
> >>>      }
> >>
> >> In general, to the fix idea
> >>
> >>  Acked-by: David Hildenbrand <david@redhat.com>
> > 
> > Thanks, but I'd better not assume that in v2, even though code the same.
> > Will depend on how you feel about added paragraph in v2 commit message.
> > 
> >>
> >> But as raised in reply to patch #1, we have to be a bit careful about
> >> including private_2 in folio_expected_ref_count() at this point.
> >>
> >> If we cannot include it in folio_expected_ref_count(), it's all going to be
> >> a
> >> mess until PG_private_2 is removed for good.
> >>
> >> So that part still needs to be figured out.
> > 
> > Here's that added paragraph:
> > 
> > Note on PG_private_2: ceph and nfs are still using the deprecated
> > PG_private_2 flag, with the aid of netfs and filemap support functions.
> > Although it is consistently matched by an increment of folio ref_count,
> > folio_expected_ref_count() intentionally does not recognize it, and ceph
> > folio migration currently depends on that for PG_private_2 folios to be
> > rejected.  New references to the deprecated flag are discouraged, so do
> > not add it into the collect_longterm_unpinnable_folios() calculation:
> > but longterm pinning of transiently PG_private_2 ceph and nfs folios
> > (an uncommon case) may invoke a redundant lru_add_drain_all(). 
> 
> Would we also loop forever trying to migrate these folios if they reside on
> ZONE_MOVABLE? I would assume that is already the case, that migration will
> always fail due to the raised reference.

Loop around forever?  That would be unfortunate (but I presume killable).
But when I looked, it appeared that any failure of migrate_pages() there
gets reported as -ENOMEM, which would end up as an OOM?  But you know
mm/gup.c very much better than I do.

If it does loop around, it's not so bad in the PG_private_2 case, because
that's (nowadays always) a transient flag, much more like PG_writeback
than PG_private.

But whatever, yes, the move from testing lru to checking ref_count
makes no difference to that: the failure occurs in migration either way.

Hugh

