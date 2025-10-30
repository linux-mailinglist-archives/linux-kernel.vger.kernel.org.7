Return-Path: <linux-kernel+bounces-877530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A62C1E5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058B4406D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D612E5B36;
	Thu, 30 Oct 2025 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT1FPXAu"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0D208961
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798912; cv=none; b=XHwfNrnRIN3WltBzW4QhPBZONhU5RhZUr+vm1AlTMI9EyGLASKhSwKhU0QmL8pU2wqC0JPkgzzFnVtiSbzdLYuQ8zBr8p9V7Op+OCcRhB0khOcmQ65VDa3Mo4DyyB0QlRoxKoSNJxAc5BOFKIxjGx8lD7IuCXxFqTv7INIGAmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798912; c=relaxed/simple;
	bh=Bnmw9eM1KEBbGa/mEgftz0Kw3XIdW+EgFqkvfyfVjOQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References; b=G7VgRR2drNaPo5wWgJ4uQ439y2nPFsxyIb4d0e0Dkq6QWtbnAfEEG7Ut8L6OAFElTl6Kw5qQvsPxhtF9oBTc7+QPIltH7yVz7aUOHbR4Ct89ZDW8OyZUPV+XUT7QUOgim/DlQievsCwJNgLk5OmzrynsA8QuKvA91EqdTaKv6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT1FPXAu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33067909400so478288a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761798910; x=1762403710; darn=vger.kernel.org;
        h=references:date:in-reply-to:subject:cc:to:from:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T1IjWo6i6ovO6dMEojAGaj3a/KLGmm2gjTEUcV51NUE=;
        b=dT1FPXAuMP3m1HXEtaZ58qJ+hBpWTouJrxR576pR3ifMntNiWmzLBkWUS/a+ngIk59
         7VXKvZcLm+K2wmzKiyc7dRdJMrKQAky+mI3GQqVriBzeg1Jy/fhBIurxuoxH296erZP2
         lbDevTvRgjbHecwBtkZHP9loTrRtdqWr9vKr/wKugQJdEABTSY7s0vViNKA1uHU2l+PS
         5ta6crN+gFXLWT4kAYP9IjR/rsLVdd0op+FuZDW94pvQT0wpILHkCWYI2UfUcMr8G7ii
         E6+BwCXsKPLwB2a37c0HGSg4lryhTk6Zt9TB4xA1rBxYMyIhl7xPNKcCC3Naw2o5UgcD
         2Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798910; x=1762403710;
        h=references:date:in-reply-to:subject:cc:to:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1IjWo6i6ovO6dMEojAGaj3a/KLGmm2gjTEUcV51NUE=;
        b=V84A58MoJVEz3bp9lDQ4Ut0nGjDL59dF3q4xkPzUtrWy7JfBJgs5OhdCpWFt3VH3y4
         e9Ypa9hwklEYpswE4Xiuim4DF3i73kaaJCsTrrtB+mFhz3Fpul41c6hdu2vhIk1Mm1ID
         4xdUPzo6K92h3H669xBaxg6l+o4BhCQBdGLYGHrwedi8l+NU5a/udMDvaV/zopdt3k4U
         LFdMlr6OdM+X2kRvUfEBuq9Np5/bi1mtBQ5OWuT03IO0rHovFdfbteIMcAdA3OEgsJSD
         P1fT/fmvQC/+tpeQehLhEm6yaQbavv98e0VaCZxUlQydZBQLzVUB1oGvT0YGqHIze/Xi
         nTHg==
X-Gm-Message-State: AOJu0YxhfNJsGo02h4s/fn09Nw/vtS5uJ12gJ56+nmuUPXQJCrixitBB
	T9BZW6Q075QD8CwHDUX3sS0AVwUsRFF7uE6cnNnreVTtyYaV9UaqFdCB
X-Gm-Gg: ASbGnctP/fUfN/e2vdItrLmU0iUgj4/auRJ2Zp+Fj5u+PilAzmmXkhxL+BLIKxp2VvP
	FgKsUrhCR8dqPiepIZM6XShSxodpEa1BeHPFnRI/8KOHY7gDv3IKc7fNmTP95hIMrnqBTzyCSR9
	D/6jCTskeQrMyqTPHIgOipYIg6sb/gfH4XEsKWEhYRwRTLvIXFscU4L8ht07yQ1vsI0qeKQnWCe
	cDJGxfs7sa8UH4sVnKm6XwkPspDGwU9J7FvMWiEbFLE0lUiwAqz07r8S9NX/uLelOGkKPDhUAWf
	EupqN7l3E6IxgzXJZdHqrD7tQ3lVv7Rz6zNPjJ3nATU0RRCvnSrvwj3QEheediuYAmi2Seuoqln
	b07dHOKIASqvPSeM5zKlUrxDZc7z5K7l9P+TIzxHB+qfGOviV5HKWiTarPVDkmbke5k3X+A==
X-Google-Smtp-Source: AGHT+IHl6weE6GF7HNNqHe1114ZnX3tZMdh5kdEiK8Xsyp2FEK/FaeBC/Wnwk0oV634HPAnFIGig5g==
X-Received: by 2002:a17:90b:3a8e:b0:32e:7270:94a1 with SMTP id 98e67ed59e1d1-3403a29a2ccmr7189133a91.17.1761798909800;
        Wed, 29 Oct 2025 21:35:09 -0700 (PDT)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509727absm886808a91.3.2025.10.29.21.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:35:08 -0700 (PDT)
Message-ID: <6902eafc.170a0220.271be2.319e@mx.google.com>
X-Google-Original-Message-ID: <87v7jxdn51.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/02] scripts/gdb/cpus: Add support for get_current_task for powerpc book3s64
In-Reply-To: <cc4af3fa0fcda2a52cbbab05463e0ad0561fd017.1756521755.git.ritesh.list@gmail.com>
Date: Thu, 30 Oct 2025 10:03:30 +0530
References: <cc4af3fa0fcda2a52cbbab05463e0ad0561fd017.1756521755.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> This adds support to query p $lx_current() for ppc64 book3s64.
> This allows us to utilize gdb scripts functions like:
>
> function lx_current
> function lx_task_by_pid
> function lx_thread_info
> function lx_thread_info_by_pid
>
> e.g.
> (gdb) p $lx_current()->comm
> $1 = "swapper\000\000\000\000\000\000\000\00
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  scripts/gdb/linux/constants.py.in |  1 +
>  scripts/gdb/linux/cpus.py         | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)

Hi Jan, 

These patches still cleanly applies on upstream tree. Any plans to pick
this up?

-ritesh

