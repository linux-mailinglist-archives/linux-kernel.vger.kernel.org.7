Return-Path: <linux-kernel+bounces-796970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 667FDB40A24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0694E1BA1DED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA9B32A815;
	Tue,  2 Sep 2025 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbCBFlpq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD52652A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829306; cv=none; b=nufVOEpdOWDDYL3i6YOhdqJL1E7npEYY64gFZQAGIxySWxbVeNbDIbNs+LX7vmrJRM3o98seU4JdM05DcFooYKzGmDKaIzhiYFEoWR/eIXPs2GqWJxCjV5CS6ElWJL1OMH8F4DJkZm8mmMXOS9Wfwsf9Ci0Dz19n2YRVjb2OWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829306; c=relaxed/simple;
	bh=dna6K+zTp+mL6pV6PsmJFAbKbDyJ80ELhmKvpejBxpY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Wu7HKbCeNkBeA2T2hE4/H+Y6U1ELl589t+VAyi39yfniX4OReo5jeKQfAkgNgkSpaanOOe/Noe07gTWC0jxndJSsHcfpcAMiFRzoGb+NxBhXQz/0IHCZ+Ub22SLQNk1z0EySrn+CZDYMmF0yrbVHapl/k0aahHmdFg+vltlne/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbCBFlpq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b7ebe667cso36771475e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756829303; x=1757434103; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r46homxMqyQ5zIMnJSc9KonOfrd6IbolFE+lEsE6Xbk=;
        b=LbCBFlpq5q+sBnE9MBO5qk96sVmzz8I/qriazw7WHr7zorAWwFp7oP95aUtM0k/P91
         6KGdPBA1QqdHiVd+FTdswZ3zz6UfpOeubm6bvTNDwL+/RmT/DaNAZ4ABh6PNDGJPy6Kx
         c0fCPq66ZcGi26KhouJhbwTrc7rgGScgqrzpqsDfUfPzS+i/KoJXAIcH1R/bb3hYZrvg
         Z4PtOqJjTDowdBIRTx1k2eVjoub1TTMI8fVFWsSTeDk65XaIhW6xStVV1ZQFVsogKbuo
         Nj6G580+eoF2kzgS8e1NMxXaDXXPt/dyF3dLr4H51cCrHsgRSAi0f5rWcXBdLuGEtamz
         iR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829303; x=1757434103;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r46homxMqyQ5zIMnJSc9KonOfrd6IbolFE+lEsE6Xbk=;
        b=h+hYr/NmWt5M+SU+Epv80Nr/BNGS+7qgqzn11l4uY+lQgxwsQO/C7Cx6e+m/xJSU49
         Qw9hYy9QNnPm3EA5NIcKCuC+t/txez5QEdnep1e+MUmWQqXbolD9BP63b+vbFu41bABk
         xjUtjIJy3a3AU3mgpVC1FSRC3Vsosn5RMRLCNkz3lDSWb2LRdeRnp1OwSS8YN8LAlujD
         tc15ZEjjCSpBG1iCamD1JykYPZ7ju7wEVAaJqy4Y/iAmHB9vqkt98kV+3yaE1RSSwNuS
         KsG3YxxZn2psX71al5KykTH1um54QxrcdpSkwR4YxzgEG+iH8KX8LQAe+9/XsP2cCBrp
         3IwA==
X-Forwarded-Encrypted: i=1; AJvYcCXVQCAreIJxCMk9D3JeKBVSG3Gi8daF4aaBYGd4P8duXXEeqtHhPCTB8qr489BSNstlaJtoorbk9v64srg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyYrS+MamN/Gktg/5RKZmnpqvCwWSXiddIFEV5+cEWABWKiq6
	2mwTMQcz1WQ6KgGoXHd/WdsvCnGP/cTNvva1iuGG0GWYsm1Yrp7kpLNm
X-Gm-Gg: ASbGncufruWwgp940IacqD3BEFByFPi7CMezIStgpSgGWCH6/+4wgijWZnwaBQ2lPSI
	r6HJdpE4qzrG5lEh8RGKuuRFAsHLKe+b0SU9PGlvJ3jXJD0BhRTngZrP1rbEENtv5z6n0nrmoWo
	Svhf6ybVzlNJ1/6Eh7SwfiKe9W5mMvNSDhbQLhaienTVdsyM5qEjeFkcg9OeDYcFzM/wUpKpiIc
	aILaAKo2sVp9GqOl3N2u6jxZHwlqDi1WfVXhIWS+/7YxuQ+84xl2Ir2nljYEZAHaguBlRKnRsNI
	PSdomdUDTxkZlyUlBHSodYxKGYgof7yerlTdz77WGX3ZtFOd4VvEhA4Of95vCZyi+qdHLb23x3N
	BZxVSmd9V72EWgJWV5Aq023Ob2NPTI+ErfjQp
X-Google-Smtp-Source: AGHT+IFoDDfuZFBxFL2nmkNRl/alJFJAAS32Y7dneDsmV1fJotev9K6MTCtxdI5juyreqyXWylIb8A==
X-Received: by 2002:a05:600c:c8f:b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45b855261cdmr91999625e9.2.1756829302500;
        Tue, 02 Sep 2025 09:08:22 -0700 (PDT)
Received: from smtpclient.apple ([5.29.20.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm202851315e9.3.2025.09.02.09.08.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:08:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [BUG] x86/mm: regression after 4a02ed8e1cc3
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <913a509d-d985-4520-a879-538a1198b946@intel.com>
Date: Tue, 2 Sep 2025 19:08:08 +0300
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Rik van Riel <riel@surriel.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 peterz@infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 zhengqi.arch@bytedance.com,
 thomas.lendacky@amd.com,
 kernel-team@meta.com,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 jackmanb@google.com,
 jannh@google.com,
 mhklinux@outlook.com,
 andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com,
 Ingo Molnar <mingo@kernel.org>,
 baolu.lu@intel.com,
 david.guckian@intel.com,
 damian.muszynski@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3990BE94-FB14-4D33-BEC3-07EB487A2490@gmail.com>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-2-riel@surriel.com>
 <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com>
 <913a509d-d985-4520-a879-538a1198b946@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3826.700.81)



> On 2 Sep 2025, at 18:50, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 9/2/25 08:44, Giovanni Cabiddu wrote:
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index 39f80111e6f1..e66c7662c254 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -1459,7 +1459,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, =
unsigned long start,
>>=20
>> 	put_flush_tlb_info();
>> 	put_cpu();
>> - 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
>> + 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, info->start, =
info->end);
>> }
>=20
> That does look like the right solution.
>=20
> This is the downside of wrapping everything up in that 'info' struct;
> it's not obvious that the canonical source of the start/end =
information
> moved from those variables into the structure.

Just a reminder (which I am sure that you know): the main motivation =
behind
this info struct is to allow the payload that is required for the TLB
shootdown to be in a single cache-line.

It would be nice (if possible) that callees like broadcast_tlb_flush()
would constify flush_tlb_info (I=E2=80=99m not encouraging lots of =
consification,
but maybe it=E2=80=99s appropriate here) to prevent the misuse of =
flush_tlb_info.


