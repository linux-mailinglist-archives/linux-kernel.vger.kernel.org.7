Return-Path: <linux-kernel+bounces-891251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B730C4241F
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7284188AFF9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612DC29DB65;
	Sat,  8 Nov 2025 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp0nCpkk"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC22701B6
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566271; cv=none; b=kafv+XO+VAfFoaHR5jJQ9PNoz//6K4elvkBToFlc2rJE53T0vSwn12Do7xaR5gpY2Ls0AOkroP/7orkLlmI/Z9nTpOAjqiliVO+hJQR3j3VVmR5UKQJlyWl14iNAqZ5QyLxnL3TK3jxbky/Yl9UrsFBXhD4atPbqU/8lW/uEGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566271; c=relaxed/simple;
	bh=0guTedJhI823d1qbNjlNhspFMNH29JHvsn94D1G+3oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mobUX/UFy6une3l7G47bjpuG+DhhOSEazxXwFBEQDC1JJ8BIY/MFOHMshQ90ij6NkTsRxMFdw9h60a+MAdgs1nKmOO4QdCfY1gJDI3nSB11u0uzISCZLxDS2DkfJicaE2pS0PI+2mCUPIYQUJjkOhmAPG+3sjPI7HtSDlm1w4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp0nCpkk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso1400146a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762566268; x=1763171068; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHGSN17jZMfxWvKzapCEmQ8MEhEu5sMdAfX0dihLnKo=;
        b=bp0nCpkkMaYh7dUHEUS16T/pw83qBP84bj5zTMZT9adHyfSJK2L4EM7t8OVYzkQSwT
         igVn8PqTPGwXEXia//a5B4T7gUqULyIjvDt4U+CKhclQHo4na0H9hK4+Hq9IZsbwbwkS
         xaoTCpLkhSM2BMRmlPXfBnCog45FwB5oiqM+FYylAqiTIvDfdajgCxPpU8X4PC9xuDWY
         ZIGlLzi5AHUwp/1Ecbq9IKHC+WJv5b2UBQBTB9UEho5FBrn9gagur806LOTZRXK7PT3Z
         YpVSXrTxr8DZc4fVOl+Bm2ywU+VgrMTgRNnnJ4ylmobXYADqxWtB3qDHXYPr9Rbjp3yI
         rdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762566268; x=1763171068;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHGSN17jZMfxWvKzapCEmQ8MEhEu5sMdAfX0dihLnKo=;
        b=MOe34JlRN5DJgm8biq5K+yyHKxu3dumFG3MQp7aXQzW+syNGFJr/dOiYAnmH57trBO
         MbjPVklu2ikKcR1mnCDVC/JzPzkIBfTjQQS6YJxswDQtv9DYwt94XAKu/aCln/a+6qgK
         JAGeyAhUjl0HN9w8wPWLCAmyA9hi/OJT9ktJETk+TxFTSinlnY6deECnEPlUtGjZJBgG
         FBLzQ30YQQcg9AoYpUAZhUVEUMKC8Qzs8fMOVHUc//Xqn1IYjHgXlqoQl1biWI/sON2c
         bQGj0deB7m0e8RiBylH08VN9UdhDMlOZv1dqCwn8psjBBcwCT1uI2k5PhwuH0G29eVBG
         twFA==
X-Gm-Message-State: AOJu0YxZaPwGYEBOAIkDnnAkPkz7yCa9u3EXv/caP6ytWKpc8GHaKEqZ
	NtYF52lJxWu19NmbcHEbKNiq1kivsE73bbLytWRoMQIyr1aof078z3wk
X-Gm-Gg: ASbGncu9PoJ8VW6uA6ZLe/u44ot6hvaWnylpR9xNIazg/BaMwX5FyVJkuO5rHXYbI2U
	am/fYROrYKgLNN43yKj2ZSJD3pmrKqNBdX1PuYxMNqd136F9RL704Qv3eDHh/XwtKaM+jmsrGW4
	/98RruWnkN5cQvNfxcf/SvK+zH0X5pSJCM+wf0g/CElo+vE6l/3nxUI9xuNoUkeWjGqy3jFJVWv
	vhuEHGMLjNOyEzhv03ROQkZ7pISprBgBTGrA9NmtcIbrkpmxUmGDds12wtoSPnOJ6Ig3qXMYPd+
	WIlw1+p3THVFL/M1ZajitA41YbaKMGRQngmNbgCDobRD7vya7BuOiFRdgvz9wzbW+ZPdcCoQZqz
	bUcPqi4CxB9hEWsGvyeM8d/p9MGThKtTrfew+4I45cpHwXvW1Of7EM0N8TfWd5NCSSzyMIfbvn9
	o5BbJWdBBnIQ==
X-Google-Smtp-Source: AGHT+IHhwXLk7xWiTIAmHwBxke3RFdw4hY5rd+dV3nC2lXtWeKTLFKd/7oouP3Wzzn4re7c2VoD8dQ==
X-Received: by 2002:a05:6402:524f:b0:640:c454:e9 with SMTP id 4fb4d7f45d1cf-6415e5cccfbmr868352a12.4.1762566267419;
        Fri, 07 Nov 2025 17:44:27 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm5471242a12.14.2025.11.07.17.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 17:44:27 -0800 (PST)
Date: Sat, 8 Nov 2025 01:44:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 02/15] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
Message-ID: <20251108014426.5lwchfsvgkoo72fc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-3-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-3-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:04PM -0600, Nico Pache wrote:
>The khugepaged daemon and madvise_collapse have two different
>implementations that do almost the same thing.
>
>Create collapse_single_pmd to increase code reuse and create an entry
>point to these two users.
>
>Refactor madvise_collapse and collapse_scan_mm_slot to use the new
>collapse_single_pmd function. This introduces a minor behavioral change
>that is most likely an undiscovered bug. The current implementation of
>khugepaged tests collapse_test_exit_or_disable before calling
>collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
>case. By unifying these two callers madvise_collapse now also performs
>this check. We also modify the return value to be SCAN_ANY_PROCESS which
>properly indicates that this process is no longer valid to operate on.
>
>We also guard the khugepaged_pages_collapsed variable to ensure its only
>incremented for khugepaged.
>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

One nit below.

>---
> mm/khugepaged.c | 97 ++++++++++++++++++++++++++-----------------------
> 1 file changed, 52 insertions(+), 45 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 6c4abc7f45cf..36e31d99e507 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -2370,6 +2370,53 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> 	return result;
> }
> 
>+/*
>+ * Try to collapse a single PMD starting at a PMD aligned addr, and return
>+ * the results.
>+ */
>+static int collapse_single_pmd(unsigned long addr,
>+		struct vm_area_struct *vma, bool *mmap_locked,
>+		struct collapse_control *cc)
>+{
>+	struct mm_struct *mm = vma->vm_mm;
>+	int result;
>+	struct file *file;
>+	pgoff_t pgoff;
>+
>+	if (vma_is_anonymous(vma)) {
>+		result = collapse_scan_pmd(mm, vma, addr, mmap_locked, cc);
>+		goto end;
>+	}
>+
>+	file = get_file(vma->vm_file);
>+	pgoff = linear_page_index(vma, addr);
>+
>+	mmap_read_unlock(mm);
>+	*mmap_locked = false;
>+	result = collapse_scan_file(mm, addr, file, pgoff, cc);
>+	fput(file);
>+	if (result != SCAN_PTE_MAPPED_HUGEPAGE)
>+		goto end;
>+
>+	mmap_read_lock(mm);
>+	*mmap_locked = true;
>+	if (collapse_test_exit_or_disable(mm)) {
>+		mmap_read_unlock(mm);
>+		*mmap_locked = false;
>+		return SCAN_ANY_PROCESS;
>+	}
>+	result = collapse_pte_mapped_thp(mm, addr, !cc->is_khugepaged);
>+	if (result == SCAN_PMD_MAPPED)
>+		result = SCAN_SUCCEED;
>+	mmap_read_unlock(mm);
>+	*mmap_locked = false;

For all cases, we would set mmap_locked to false. Not sure it bother to adjust
it.


-- 
Wei Yang
Help you, Help me

