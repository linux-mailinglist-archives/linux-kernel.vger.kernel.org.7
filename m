Return-Path: <linux-kernel+bounces-846981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3237BBC9954
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F24FC0C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015E2EB5DC;
	Thu,  9 Oct 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfYG5imS"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A62EAB79
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020918; cv=none; b=nSwOSpJmUSUQR94n+Sy01SoeM663iXwiWpJUh6baIjmZ+gLcjdBHncZiILtKKwOAUSadNsAuFnk17W3tjkLhS430n4al5QvJ7zvSdHLy36OuKl42ZlEL0HYWZw0tWqM8RJXguHRrVjUlxvtnIbQ47TiNn5qzXTvXlbXc2ZSZjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020918; c=relaxed/simple;
	bh=vcUXPNtJwoL7+NXGHAlI4JDCeHOqRJ0c+A9aEkTJBKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiMpW5KNa9TVRz54CM+h+VcWQsO44NB4cs7aS+WIwIV6qFwWApHh5eRaN/AvZTAjmCrlE0iA6kEvR0jepuP22+2CJOnkRFqlQByF20WrWTSdaCkjAYWbcfWRirkNQUy4hhi20sqIjwEy+jjPS/gpZ4Vj1pVQNZgkiZvHXPWeSho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfYG5imS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603a269cso10599347b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760020915; x=1760625715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5fH3ttKU7y+blOL+SyOyeselah91xmMAP+YR9bbmUk=;
        b=bfYG5imSQ2SQgI4jU61PvupNTKhLjNYOcjNSH3bkEDtaAyza+nm+YcxCdjb1igK0u3
         BRcPscpm4Ba48EqxuMrR7t2pUFjqvS2vadwUq71zReadnCF7CniVrTMJuO5Nh39HrRa0
         lc6oQcxDlSg7fU4u167ifGW2yCsx90IAB4NAXfQnLAaYjwso/J6b2pXGxzCjDN3TVomj
         VHuG6PsAazUUTdYsFpM95tF4kylic0IVEndbaJx5oitEbmLasXJtgThl89XyTI4xmCuU
         oYx8jhFfpF85SkpJpKkM0ll8WJifNAMYMrAIiGcz548bV/8mjEdIqaISdqYHv4aBdWCo
         s0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020915; x=1760625715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5fH3ttKU7y+blOL+SyOyeselah91xmMAP+YR9bbmUk=;
        b=QqzEk1GFjG2nGWt/j2r7U0tqFdfHAZZTe8TfVwXOG2YbjmQmewWqX5A9N1AGbkQ1Fe
         UF7278b1KnIfYmY+Hmd89fi/ZjL57La+gXCE5eYADQMmbT4HxX0HW2Bwr4bHwIb1gGVd
         Dd9Jy/dbrs++U9ulkb59yFQtr8kLAKglXoZ0eiOoaihKNgza57a1IHh7FU2S6ymxOnQJ
         AfMpPx20JIiEWi+IN6m0RBJJWkNCSN3DJ6/2kCN1TcfVvCmhsyZAviNjVmo9Cm7r1sLe
         v1ybJnPfyPvCN1WgkNqlI3hZKhP7HNtK2bXbygPRTpbby9Dk2fJcCCJ4rhzfF2naaerB
         jUNA==
X-Forwarded-Encrypted: i=1; AJvYcCWTyoOZ/HMhMrJ533O48Ry836zUodi3N/ZvZyEBz99OY5n9qk296ZPgGLS/3uAGekiaSnPDqfs69SJrG4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YydgaTArOuZECQhLb9HKKgxoNvN7DjhlaiRP+7DpYNtjr4xPrih
	XZZiwoOpNDoe0FRh8nY+ThcuToImBlU6TMtUHKD4q0xf/lcnVfMkq/94va8l/w==
X-Gm-Gg: ASbGncsjIa2QAYtwVEsWM3V0aNFbC3UVcSbi/BZJdoZ5vUnH20TUCUyMciJO1J+QFfU
	imCk46/1HWJNTZsEDXYxlsrjMdP9IAVS3yOyXvT/hvplPgtSUlphWpsdD+TL6A4Ba3iQL2Gn/xH
	rInirWVNmkqSugBTv5FvsojWT06px/++iYczEsk5yXCKBAMxH761jGMja6NzWk1CJ5K9xGJEGzU
	bHXYcvR4dyIc0Ihz05nneluwkmHpmO+wrw02nOuhsuEqpGMa6h95bOZXRJ/5YtlWjWwBRIdSQBN
	bAyJ4H5hP6hHL3q8A15gyuY2jH7SJmHt5qHId+R3YfszVRAUQPgGyUuBHSz5hVA1qfkmIt3ekQC
	zkzYW3Jxi/skkpm0mCB2vO4RIUZgf47EqxZqoW1WZBsvRFQTVAhlmtTX77TelyaxX5Umq+jjvqo
	thPDxjkP1TNr43rtTicDrEBgYK
X-Google-Smtp-Source: AGHT+IGJSwqoQuFYtwut/GSunHlbpgz+UchKDD+A+mimo1XFZik/IcNM0hD34iJY6+QugyEnsKPPBw==
X-Received: by 2002:a05:690e:428e:20b0:636:1844:119 with SMTP id 956f58d0204a3-63ccb82530bmr6320760d50.3.1760020915011;
        Thu, 09 Oct 2025 07:41:55 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cd9516074sm922826d50.4.2025.10.09.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:41:54 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC] [PATCH] mm/page_alloc: pcp->batch tuning
Date: Thu,  9 Oct 2025 07:41:51 -0700
Message-ID: <20251009144152.909709-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87ms60wzni.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 09 Oct 2025 10:57:05 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Hi, Joshua,
> 
> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Wed, 8 Oct 2025 08:34:21 -0700 Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > Hello Dave, thank you for your feedback!
> >
> >> First of all, I do agree that the comment should go away or get fixed up.
> >> 
> >> But...
> >> 
> >> On 10/6/25 07:54, Joshua Hahn wrote:
> >> > This leaves us with a /= 4 with no corresponding *= 4 anywhere, which
> >> > leaves pcp->batch mistuned from the original intent when it was
> >> > introduced. This is made worse by the fact that pcp lists are generally
> >> > larger today than they were in 2013, meaning batch sizes should have
> >> > increased, not decreased.
> >> 
> >> pcp->batch and pcp->high do very different things. pcp->high is a limit
> >> on the amount of memory that can be tied up. pcp->batch balances
> >> throughput with latency. I'm not sure I buy the idea that a higher
> >> pcp->high means we should necessarily do larger batches.
> >
> > I agree with your observation that a higher pcp->high doesn't mean we should
> > do larger batches. I think what I was trying to get at here was that if
> > pcp lists are bigger, some other values might want to scale.
> >
> > For instance, in nr_pcp_free, pcp->batch is used to determine how many
> > pages should be left in the pcplist (and the rest be freed). Should this
> > value scale with a bigger pcp? (This is not a rhetorical question, I really
> > do want to understand what the implications are here).
> >
> > Another thing that I would like to note is that pcp->high is actually at
> > least in part a function of pcp->batch. In decay_pcp_high, we set
> >
> > pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX), ...)
> >
> > So here, it seems like a higher batch value would actually lead to a much
> > lower pcp->high instead. This actually seems actively harmful to the system.

Hi Ying, thank you for your feedback, as always!

> Batch here is used to control the latency to free the pages from PCP to
> buddy.  Larger batch will lead to larger latency, however it helps to
> reduce the size of PCP more quickly when it becomes idle.  So, we need
> to balance here.

Yes, this makes sense to me. I think one thing that I overlooked when I
initially submitted this patch was that even though the pcp size may have
grown in recent times, the tolerance for the latency associated with freeing
it may have not.

> > So I'll do a take two of this patch and take your advice below and instead
> > of getting rid of the /= 4, just fold it in (or add a better explanation)
> > as to why we do this. Another candidate place to do this seems to be
> > where we do the rounddown_pow_of_two.
> >
> >> So I dunno... f someone wanted to alter the initial batch size, they'd
> >> ideally repeat some of Ying's experiments from: 52166607ecc9 ("mm:
> >> restrict the pcp batch scale factor to avoid too long latency").
> >
> > I ran a few very naive and quick tests on kernel builds, and it seems like
> > for larger machines (1TB memory, 316 processors), this leads to a very
> > significant speedup in system time during a kernel compilation (~10%).
> >
> > But for smaller machines (250G memory, 176 processors) and (62G memory and 36
> > processors), this leads to quite a regression (~5%).
> >
> > So maybe the answer is that this should actually be defined by the machine's
> > size. In zone_batchsize, we set the value of the batch to: 
> >
> > min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE)
> >
> > But maybe it makes sense to let this value grow bigger for larger machines? If
> > anything, I think that the experiment results above do show that batch size does
> > have an impact on the performance, and the effect can either be positive or
> > negative based on the machine's size. I can run some more experiments to 
> > see if there's an opportunity to better tune pcp->batch.
> 
> In fact, we do have some mechanism to scale batch size dynamically
> already, via pcp->alloc_factor and pcp->free_count.
> 
> You could further tune them.  Per my understanding, it should be a
> balance between throughput and latency.

Sounds good with me! I can try to do some tuning to change alloc_factor
and free_count, or see how they currently behave in the system to see if it
is already providing a good balance of throughput and latency.

> >> Better yet, just absorb the /=4 into the two existing batch assignments.
> >> It will probably compile to exactly the same code and have no functional
> >> changes and get rid of the comment.
> >> 
> >> Wouldn't this compile to the same thing?
> >> 
> >>         batch = zone->managed_pages / 4096;
> >>         if (batch * PAGE_SIZE > 128 * 1024)
> >>                 batch = (128 * 1024) / PAGE_SIZE;
> >
> > But for now, this seems good to me. I'll get rid of the confusing comment,
> > and try to fold in the batch value and leave a new comment leaving this
> > as an explanation. 
> >
> > Thank you for your thoughtful review, Dave. I hope you have a great day!
> > Joshua
> 
> ---
> Best Regards,
> Huang, Ying

Thank you, Ying. For now, I'll just submit a new version of this patch that
doesn't drop the /= 4, but just fold it into the lines below so that there
is no more confusion about the comment.

I hope you have a great day!
Joshua

