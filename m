Return-Path: <linux-kernel+bounces-793630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD5B3D644
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908E87A25C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0CD1A9F94;
	Mon,  1 Sep 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v6gQ2nnB"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719B148830
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756689543; cv=none; b=ZMpRrq315jIwsKMgLLGYF3hmQc551jVaxZA+wSgsQcQAM8nZoPzAyoLQ3m0GAcTlvtdBRlQa2cFHKKa/e/ojXq3ThjUMpRPKtq7KenPv/h+vbDhsYQLNn6iQMLuiay5hp0it63tXsZ9z3kVwiT9t4BGmzPJrQzLwi5+3unHGePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756689543; c=relaxed/simple;
	bh=SrWMC/uDHrbbYZlysG9QCdPVTqrYW3gH2/qs616wf6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CP6FcIjzhiluuEebtI6KZOnufxkOWVTqvk97kIQ8YSgMLUsR730LrVxpXQoStZxq3JOfBhTM0N4T7bD1/AbHhPtWFY90vQwbd9INje1/Bq5lm2OmUetj6+ClMzzQ2TZnlXUfCdve6yK7rPhKPkwBAyBoeL6UTwiEX7TJMtF3KKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v6gQ2nnB; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e96dc26dfa2so3200522276.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756689541; x=1757294341; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbHdiemUVDkGhXF84LagmtCAtV3fnhhvE6fhQVYUm+4=;
        b=v6gQ2nnBPKqUxEBYn5PXXJFwno5hA/gDyxKgWIErMKOR1sSNIaS8ChCPj5TPmISKea
         1q1Xcdn2AsUBotWD6yR1gUOAdyHERjZl5hOdGTni6s+bkrUWrivtCOVATjaXFnk2+ove
         k0824Syqv1LGBdnZPl/ai+sPYCjEHbKT9TfjL8nIzNocclYV/m826/ilP256A0idMtf5
         7Pl5hu5u8y1Gf+EAZpvjOBr3/KnhCxBUE6QdZjGOwXpzYeX9HbgThy9jUA3afYvZsJN+
         PB3a4NFKeZlHUYE8D8l/qpd5QOt3owoh1wdZXmnZJQxTGNp3AFEWXmU4I7lszNPvcrHA
         YN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756689541; x=1757294341;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbHdiemUVDkGhXF84LagmtCAtV3fnhhvE6fhQVYUm+4=;
        b=L/3WC2f7g610nbtNMkN3iwYicMgPr/h668eW0w3tEYGTJyi7VjEcUDFNN/PP+zU5Be
         8YxcPUiNafMW4Ani2Cc7+oP18Ayd1mUOUAUiCJthK9k1QH2NkqkJDofp7j8TUzIXuW0n
         /cgtTqo5RAF5YI522DY5lk+ndVdglkywbpDs6G99dRakgaBP401gVDRGaGwxSQJTIsMQ
         oemhX/kLx7W7WB3X8lyCo4o00fFOLYR9C/0P4c5/Zl50lObMH6WKDfu6Dqm8YvW9SU9b
         7qYCs3Gtbp6PLOz0OnsKCnVPbVzU46KeZcbdKZcIhEkEG1miToPvAkkJ4rUs6i+zJc0H
         VtHw==
X-Forwarded-Encrypted: i=1; AJvYcCUKLZkFvHoi+ig5NbhH6XVYWvG6gLlmgx2D/5GIqX0M0RvdH+neWCl1SIUqI62dV875s2ADnWyL/ORZ3Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB57pM81Lf0ADCv689PJDVfusxxSEeyRnviA+4OJN8ZJYiwPDF
	Rmp4o2vLP4o9HkADqj/HqNSGhxo8EbxKW0s7kYP3oUCfxm7PPANkgRJMwL2XKr1JiQ==
X-Gm-Gg: ASbGncv4uikHcpAUMfe4Q5M5u0RxlAntnA6FFmgD59dEHhitbQ45vv6PcQkGwThqy7R
	KmlBX9jA6iNK9aSJAe7v4rZLutE+V+AKP/ueoEUiULbCQF9iSukHBOblZ3Lb100JwuKgsvvJEX3
	XB8ro0gNGZv1rpOKaRG2sxMK3i7UIijJfGPfVmvdPmVEtIVqdl8ESJxbbW6wR2q6CvYJTPdgo90
	2gr2VKTa0cWw3SKE70grSWTF6c31GS7D0VhTfLpldB31d85prRUP+2L1FLVCTxqAWu8fBRHEdPf
	2fGUl8lzGsH4c0ScMpnN8YVdHqgtFNkgIaPeTaN7iT1BAlVE6UyBTi9YnQxMgPj/oA4M0z2qmoT
	9Igi7/0OICz9hjanG9mhYtdv9/HIzHr6siwGUjogTNHUOt1/uUb5MB66kTA/ylELg6c8eapqZ9F
	I8WhSVQG43Z8Rzd8O/33cQ4go4
X-Google-Smtp-Source: AGHT+IHtpFnzZtOd5EAUI0dfwmf7wzns/HcB/2UzQjdwkp5/vhvwOwhxTlB0OmsWdGR+CenhvV1BEA==
X-Received: by 2002:a05:690c:7241:b0:71e:7a28:c0fe with SMTP id 00721157ae682-7227635ccbamr72100947b3.9.1756689540957;
        Sun, 31 Aug 2025 18:19:00 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7227d8ca596sm11655447b3.42.2025.08.31.18.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 18:18:58 -0700 (PDT)
Date: Sun, 31 Aug 2025 18:17:02 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Matthew Wilcox <willy@infradead.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, 
    Shivank Garg <shivankg@amd.com>, Christoph Hellwig <hch@infradead.org>, 
    Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>, 
    Peter Xu <peterx@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH 1/7] mm: fix folio_expected_ref_count() when
 PG_private_2
In-Reply-To: <aLTcsPd4SUAAy5Xb@casper.infradead.org>
Message-ID: <52da6c6a-e568-38bd-775b-eff74f87215b@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com> <f91ee36e-a8cb-e3a4-c23b-524ff3848da7@google.com> <aLTcsPd4SUAAy5Xb@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Sep 2025, Matthew Wilcox wrote:
> On Sun, Aug 31, 2025 at 02:01:16AM -0700, Hugh Dickins wrote:
> > 6.16's folio_expected_ref_count() is forgetting the PG_private_2 flag,
> > which (like PG_private, but not in addition to PG_private) counts for
> > 1 more reference: it needs to be using folio_has_private() in place of
> > folio_test_private().
> 
> No, it doesn't.  I know it used to, but no filesystem was actually doing
> that.  So I changed mm to match how filesystems actually worked.
> I'm not sure if there's still documentation lying around that gets
> this wrong or if you're remembering how things used to be documented,
> but it's never how any filesystem has ever worked.
> 
> We're achingly close to getting rid of PG_private_2.  I think it's just
> ceph and nfs that still use it.

I knew you were trying to get rid of it (hurrah! thank you), so when I
tried porting my lru_add_drainage to 6.12 I was careful to check whether
folio_expected_ref_count() would need to add it to the accounting there:
apparently yes; but then I was surprised to find that it's still present
in 6.17-rc, I'd assumed it gone long ago.

I didn't try to read the filesystems (which could easily have been
inconsistent about it) to understand: what convinced me amidst all
the confusion was this comment and code in mm/filemap.c:

/**
 * folio_end_private_2 - Clear PG_private_2 and wake any waiters.
 * @folio: The folio.
 *
 * Clear the PG_private_2 bit on a folio and wake up any sleepers waiting for
 * it.  The folio reference held for PG_private_2 being set is released.
 *
 * This is, for example, used when a netfs folio is being written to a local
 * disk cache, thereby allowing writes to the cache for the same folio to be
 * serialised.
 */
void folio_end_private_2(struct folio *folio)
{
	VM_BUG_ON_FOLIO(!folio_test_private_2(folio), folio);
	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
	folio_wake_bit(folio, PG_private_2);
	folio_put(folio);
}
EXPORT_SYMBOL(folio_end_private_2);

That seems to be clear that PG_private_2 is matched by a folio reference,
but perhaps you can explain it away - worth changing the comment if so.

I was also anxious to work out whether PG_private with PG_private_2
would mean +1 or +2: I don't think I found any decisive statement,
but traditional use of page_has_private() implied +1; and I expect
there's no filesystem which actually could have both on the same folio.

Thanks,
Hugh

