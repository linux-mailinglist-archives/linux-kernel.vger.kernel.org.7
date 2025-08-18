Return-Path: <linux-kernel+bounces-773592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2EB2A1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E051462025A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C932FF15F;
	Mon, 18 Aug 2025 12:41:05 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284B27B345
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520864; cv=none; b=ew4xwj0FlC6sYMUyHxth/7CFVqFW5FQjYev283Sqqb9tGOK4EHQ+2X4GQkNlMLIBvRKLqRZA3srBsPlO+g2Lp50uOl/bRbch28A5J1ZApHC6tREttfMZP2BXbVdohKBsxy+t/iC8+5FR2FaGGf3xqKWgIypifYv9VQJE+OxUSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520864; c=relaxed/simple;
	bh=8qEQ9HEGvDjn3/kUo+qn7h6K1E8WtwTBzyfnQY00NtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd7np7Ciedu1Ug+NVZmgZzjk1ivocrjRRLjx9csunQB2mQKMdI8yaSNf6OK+UrkqL+SJFPmdg2POgyFaq8rEy5GV+T8q8Pr8qcSCmGPdnkzyebikjv2LO7WLE3CsCFOVk8cgJ16ZMVxeDd3G3knsMgP050DIN9PbxLlw1AlGj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a3a085so637879766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520861; x=1756125661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH7/XBiVNbcKdnwEYsvCP2G7eQC/5IdZVru9q/OoYKo=;
        b=laviraOUrttLEzKl6Jh/bHOPlWTPeQE+XGGqB99KbJQ7p4paCaiR2TcuMA7xs1QgcG
         fpAsdybnKQaGOBAYMWfVaRIaOwElMnwvkx5KT58Ifis8XepBxQTj7AgrBk+5aGbOpWca
         qIbq0xNLX7HdqBDZsUEg3qwCYEEQyGc7dFKc44hHYl1qtGUSat7DNOG5QRz3s2As173X
         Pbi69VWcWgg7cFoGFZfpA1Ar+H1Eui88zkpV3ANxp2RRipzyK/2ZnL8qnOiElXUbJNBs
         gwbYAruPXtRqOdk93J2upq7pzm+Wk5RmDYtCAkUaYz65+hLC0x7oAsM+h9oqlsjn3vx5
         599w==
X-Forwarded-Encrypted: i=1; AJvYcCUywVEgSVzGhB8Jypo8u3poIWOZiFkGaad9FhFFix0UdQWwcVRMXhTs4mmprv6P7YKcD2e/AUNrc1gTpV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68Ja9qorvA4Om4N+2bHftBzbSu/RJrv4bOPc7eBFA+8yDm/yh
	q2+DcsxJDNqGy965qv4JT8WsunexcYyz9/LoZaScsX91CcDCXtYrWhwj
X-Gm-Gg: ASbGncsWZ5N+U8ylONkFdmblhaN6EFx07IMJFzTwLGZMCwFfoJo4axP4FDn9Gj1HAD4
	j+MH37Rb720ishn7vV/j8AvkBFUt1Cu0ri75qZMyeIcy9uWgFvtIXxiMpXf4xdzUFlMhzbBi+4X
	OjBBAxKFfJtp4AfS7S0DGbC5X0I/Yu1p1fWICkytwxGxZPIK+slZQbt22vbhUMOesEv8IpyMuQm
	FSghucpXEDkdzTZXaCJelCawDRn/CxvFPmDvr46Nun3hWjHCdB2oSFH//SuYYyaNJFqgta4/CPC
	WqA1L4DEZNW1nb0t35Gw6CAT/7cfr5QhqOUAn1sWnXv+ZYMX0I0vtITEzySAuRsaW+MIJfxPW9m
	Mo240SNyRyyN044dUmL9GFH1Dwxf0FMAF4w==
X-Google-Smtp-Source: AGHT+IH1SlaiC89AymtSUQhecZZZHredthvJxDqK3+RjxhdEjb5UZiFconD2tK9Av1Q7IL0P4219HQ==
X-Received: by 2002:a17:907:7b82:b0:af9:a1e4:a35b with SMTP id a640c23a62f3a-afcdc1a2f53mr1103158766b.7.1755520861111;
        Mon, 18 Aug 2025 05:41:01 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfcce69sm781663566b.82.2025.08.18.05.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:41:00 -0700 (PDT)
Date: Mon, 18 Aug 2025 05:40:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+f65a2014305525a9f816@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid
 context in vfree (2)
Message-ID: <4tu4bjs72dqx2pbamu7mc72dg5fxmrbaklbljyppxllr2hccmf@ig75eaoswryd>
References: <68a2decd.050a0220.e29e5.009a.GAE@google.com>
 <20250818100758.5020-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818100758.5020-1-hdanton@sina.com>

On Mon, Aug 18, 2025 at 06:07:57PM +0800, Hillf Danton wrote:
> > Date: Mon, 18 Aug 2025 01:05:33 -0700	[thread overview]
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15232442580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f65a2014305525a9f816
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cbaba2580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1157faf0580000
> 
> #syz test upstream master

I was hitting this issue and I've tested it and the BUG is not there any
more.

Do you know which commit caused this "regression" ?

> --- x/include/linux/mm_types.h
> +++ y/include/linux/mm_types.h
>
> @@ -689,9 +697,8 @@ void __mmdrop(struct mm_struct *mm)
>  	mm_pasid_drop(mm);
>  	mm_destroy_cid(mm);
>  	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
> -	futex_hash_free(mm);
> -
> -	free_mm(mm);
> +	INIT_WORK(&mm->drop_work, mmdrop_workfn);

should INIT_WORK() be called at setup phase other than at any 
__mmdrop()?

Also, is the scheduling overhead a concern here?

