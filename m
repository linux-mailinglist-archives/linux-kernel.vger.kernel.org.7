Return-Path: <linux-kernel+bounces-757122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A04B1BDFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EA418A67D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F7B824A3;
	Wed,  6 Aug 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRHWrFnD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0461E4AE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440866; cv=none; b=QQ0DEb5vb9NLU7gEWA/1p6dxLyJHC9fixSnMnUmc9UzeYA0PuhZLVBlBXnG+KdGvbtKh0uZWl7NGH88Om9BpCaib6pc/IXXiUayke4/+YN+CJZfnyPWYRdjwe6ahHocH/dx2qyB4fX1CqbmlBMabpD9P2/Ar14Z/C4p9XlWv8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440866; c=relaxed/simple;
	bh=Nj+D3V+ErQiuBO/LLfcd2WNVdOoKV+K45DhEivVfaTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOapV3JwZdhoooL415I6cx03z4kZj/zMFj5jx+UsgPZPK4mbw6Hb+8DevO3EjnBHgAUkjK468Tn3Wqy/ai4kk+zXDI173skheIEKW5KWx3h69trn9EeaatHo7zB3+kzdoMm1puoMp/QizIpGtaxu3BtEhUypeO3GGsvW0gATqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRHWrFnD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754440860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFOUKfyF9eht2Uz3lQBAC39G9bdYnu6PboLaGAsorNE=;
	b=SRHWrFnDWQcCWmUXzCQ6N/tvVklOoYiEzfrp5RVxHWBsqnWQ+XCXel8P1e1d1jbxp83Yu+
	rYvSkh9TLg2y/MCw2/FAY0ABDjXUO3vcCYhoUR8/iJxpyQ6kgw/vTENal+tseJJlQJpB5q
	HvlG5HbPuC5uzqWjJBEClGG8/HR60aM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-in5Pdab9OteuuE19dcGTiA-1; Tue, 05 Aug 2025 20:40:58 -0400
X-MC-Unique: in5Pdab9OteuuE19dcGTiA-1
X-Mimecast-MFC-AGG-ID: in5Pdab9OteuuE19dcGTiA_1754440858
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70e5e6ab756so71872927b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 17:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754440858; x=1755045658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFOUKfyF9eht2Uz3lQBAC39G9bdYnu6PboLaGAsorNE=;
        b=eyhRvf75/iUSlRvPbpPT1FKf5sSlD4BftqJOUKT8fpB9jkBeBkScD/AEDr+y85fDqZ
         Rrs4kMxiJj5NV+q+R6NjXFWE4jY7ApIEluemJXyPdi79Xj3rKnNucKU0ZGcj2zTG4iZB
         ROqQzA4w6zcfTpOUODI+U7tm9MYtquEew1nRAFGy1gZ4DHFn6QNx13fRRDq8OFbyAjKC
         d/zWiKB9sWXzxJ2lU0euWQR+qK91N3aRNwiwMhnl13EISHIfHEnc+e+k2PrI/gWHi9gS
         7rs4RQ0OZXjHbYBcUslmgdCv/E+xEqgAfCbNiYYq/cFmsiYUdJWOALrInQjnBeshcC8H
         +sBA==
X-Forwarded-Encrypted: i=1; AJvYcCVKjspM/9Ade5+bb0E1IO6xX/4HncNRGok1VDno5auvTdZ1G+qFYk2lWF7qEo4vuaxPX1s6nIj/qqnG7Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDL2ZJyapOyEGJ/P9Pf/FoMWT+cmfHn/A1jlG9gao7tLXm+E4
	NPn9eFzZ1L+IZ3JbDnh7wD0vCE4a5+OJIf1lqy2FGzZc05bzIfkjnW3apED4yh5IV1Wo5xUzB9V
	otvrGkIFrpKXeNofbm7C3NH82uWrm0y6zJRjcIE2GJGq/cCWfooiFruIFpDvpUCDd7Q==
X-Gm-Gg: ASbGncsAKmt1nT48SJbM7tNSNqotHU3+UPdA0K8jhfVREBrN3xv8mPSl8rZ1PB+VOdc
	eXYWSSD9GI452kRORS357eV12R3vLDuoWTe2IDQeEkj1tXI4BIfXxeFzOj+rbw0BL9YjZBB3+eG
	imogRHyr2UC787audkVaGoyAN1FFMoWZuP/0ar3gHI35c0LUg1swpxaKqtl+derU+F4YbMl71L8
	WBplsXVyClTg7Zgue8FApKz+OQcFThcORJOs9/jqLH42YZqHZNSXb+ttD1sQZnKxfJ4Yeb8G1bW
	YNtPJSQidue5wzDFFTlUzIJ7ThX9Rc8+
X-Received: by 2002:a05:690c:6186:b0:71b:4739:9d67 with SMTP id 00721157ae682-71bc96f338amr15082487b3.4.1754440857859;
        Tue, 05 Aug 2025 17:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHku4dtclIuv1XK8QUtmPlV8XuTKcYcnt2F/++IvmdFem+YdSw119Wr+7uOLta+er71F1OKg==
X-Received: by 2002:a05:690c:6186:b0:71b:4739:9d67 with SMTP id 00721157ae682-71bc96f338amr15082337b3.4.1754440857503;
        Tue, 05 Aug 2025 17:40:57 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cc2fesm35969157b3.72.2025.08.05.17.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 17:40:56 -0700 (PDT)
Date: Tue, 5 Aug 2025 20:40:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aJKkjEYmeq93w35-@x1.local>
References: <aIz1xrzBc2Spa2OH@x1.local>
 <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local>
 <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
 <aI1ckD3KhNvoMtlv@x1.local>
 <CAJuCfpHcScutgGi3imYTJVXBqs=jcqZ5CkKKe=sfVHjUg0Y6RQ@mail.gmail.com>
 <aJIXlN-ZD_soWdP0@x1.local>
 <CAJuCfpFzP_W8i8pwL+-Uv-n+2LixgFrzqn2HsY_h-1kbP=g3JQ@mail.gmail.com>
 <CAJuCfpFEf92gTR+Jw+1wcCcT0fEt-SP193NHzpyxVXJA=VAwng@mail.gmail.com>
 <CAJuCfpFeSVq+hq4JRJStLgFfQgmS6SQ7zoFsj4=SeQT89r3TTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpFeSVq+hq4JRJStLgFfQgmS6SQ7zoFsj4=SeQT89r3TTw@mail.gmail.com>

On Tue, Aug 05, 2025 at 04:41:18PM -0700, Suren Baghdasaryan wrote:
> Ok, I let the reproducer run for half a day and it did not hit this
> case, so I must have done something wrong during my initial
> investigation. Sorry for the confusion. I could have sworn that I saw
> this case but now it just does not happen.

I'm wildly guessing you might have hit the numa balancing bug I mentioned,
that might explain what you mentioned previously on the testing results.
It might just be tricky to reproduce:

  - We'll need a valid THP (pmd) first in the MOVE source region

  - THP needs to be selected by numa balancing for a check (marking
    prot_none)

  - (before any further access..) UFFDIO_MOVE needs to happen on top trying
    to move the whole THP being marked as prot_none.

AFAICT, task_numa_work() is the only place that can mark the THP, and when
it happens, should see change_huge_pmd(cp_flags=MM_CP_PROT_NUMA) and then
returns with HPAGE_PMD_NR.

[sorry I am still pretty occupied with other things.  I can try to reproduce
 together with you after I get more time back]

> With migration entry being the only case that leads to that
> pmd_folio(), the only check we need to add is the "if
> (pmd_present(*src_pmd))" before pmd_folio(). Would you like me to
> check anything else or should I go ahead and post that fix?

We could fix the migration entry first, then if any of us can reproduce the
above numa balancing issue then it can be a 2nd patch on top.

After all, so far we didn't yet prove it, either some unreproduceable test,
or pure code analysis.  Meanwhile it might also be cleaner if we have one
patch fix one issue, rather than having one patch fix two bugs.

What do you think?

Thanks,

-- 
Peter Xu


