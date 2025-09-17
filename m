Return-Path: <linux-kernel+bounces-821625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36BB81C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FD6584CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0EF2E2F0E;
	Wed, 17 Sep 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPRBHiBB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DB28FA9A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141112; cv=none; b=nn+yyDsPqh4PrM/LMz8ipRpA5AwlV80l6k6uo+VDf/vPAsEJsm0iZVgqZeVJ/+WogW13etcjrbfLuXW1oGTytg7e81IjmpC3tDrq34pazKPpt3DuZi4+cQnPFa07kREZyssXPoaD97AmRHxjIwGJGikmp2ZGI/pYvmHNaWAMw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141112; c=relaxed/simple;
	bh=5OBIs0bUsQlBfNz/o3OM/cckvzwG61wfY25aaGHql4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbK3i+jDaUFqp1R7d2XQOqD5uxu8hG9dDmgyBlX4HO4ohFcg41UvayUo0yLeNHd62T6p1KeTIZrXzzYahoyY5DnQUno5ky3/sTvQJ/1Ui4nbLSG4ZSM9VPkrPRc4mv+XgTDnkjq8EMzrp7YeqAzMiPZE1yN/pcjEoY9mGieHQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPRBHiBB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-267c90c426dso13485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758141110; x=1758745910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OBIs0bUsQlBfNz/o3OM/cckvzwG61wfY25aaGHql4M=;
        b=iPRBHiBBNchRzIgeBGxAgEvAguVI4ofWDB2FMokbFInew0Tlx5LZZoHFSAy6xQje6G
         LZHaNDddx8SucnH7T4p7gYxOSxd8UTRqQYDckmQpUaAeU8xW7XXMNc1/pVsnM3FuirPI
         4oJVfSH82hK6IDsB2wGXcrlEEyMd4iMBRA7S7usUq8QL+m1RT7ZpzqDAMMSuw9qURSGp
         99vh8TslRh4UeIuJjt/yVQsmUTcBKjoU0RSax47ut2vz/nQzpfPJyZR5UHsIJGEIz4Zg
         dxm5CwPRCA70dUPQBbQO7ETbURshVyia+iI9t6lrLp8wZuyQJmTJgFDfnFqF/2iFMhJf
         4/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141110; x=1758745910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OBIs0bUsQlBfNz/o3OM/cckvzwG61wfY25aaGHql4M=;
        b=fFiFFvvcPuvtGbtV3spDVgY2Pr953baLCeNXCoTlpggStPQ+J8N+ejg4mNqNwEIuGj
         +nOzOzueIH7IPlQvWWOrtRJXAwME5bf/sEL1ecxzmNftf4wPvl81DZ/n2KLRpXCh3jIf
         w29yS4X2PbUL7O/lm58pZmBSJoA2pIgSl/RgEl9FCbHs2kzjfXWQRXzbn0LO2KckXMfv
         unmBLMG1KfipmsxOGC+Htkg03EwPIv3LE7O4aq4BsEo9MGh910/bQU5Ml7yJlxDZV95G
         m/8WQxAz3EeqZIOrkPPL0pSkRkF6PW6XEyhXfHSBBnqWjN05m1KFECyaHkQRS9LeWRvO
         dDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVXW1avS8OeFZCOEA0Rg6Sbss4NTs7m2WFCnmdGF0skKu3CoLCtXN1E+oioZbIRCKgf6+xkm48/9w+leo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXAol5jaHT/P5aFLTbOtY1vmYWYQ/Nt8wZUjRUGNy58PPYCPG
	T/T1eNAvSKvhrKFQtmelv8lQ5TNkawB3ZXz1mFomXdQVk0aIo/KAfQf6ihNf92HbOgiRC5aOAOp
	dzeku1klcn9PtFEV49LAfdXLDwN1Wxr0dKK7q2x5B
X-Gm-Gg: ASbGnctyzOG00PTVVPFQLAKcX1yWgQbocSlHBDDqK7sUHY6hnPl75aZbUnXRundTGN/
	bIc5ShUS+Ihj5QEatayfkypBt0+xjpMwdvyfFYkvEefXVxcqiDVmEkMAqBPZZw7sH2IRL5tTBE8
	3Yju0scos2u0cSZxXTVjocVM84QVQimpmQWgrkl5neDhQN98+zLZu4/dI+DDVL/vT7hnoW9vURM
	L7Jx+qhkNwfaxCak8QlC6eTyI03/ta503lesXlDyFVK6+u3gz1Q9kYp54/+aAw=
X-Google-Smtp-Source: AGHT+IGi1Cl1cxLljbDRwITE9vfhwz+DrDPsOJguUQv2zzG51+QwzyCb4weDhywo5yliSwxcW6sHs7Lpaphswpsb2Ak=
X-Received: by 2002:a17:902:e550:b0:24c:f4b1:baaf with SMTP id
 d9443c01a7336-26808a33cc5mr6423875ad.1.1758141109587; Wed, 17 Sep 2025
 13:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-7-kaleshsingh@google.com> <eb7820ed-3351-4cb5-8341-d6a48ed7746f@redhat.com>
 <CAC_TJvctkyGEKv8mVE83D2DzCd-HiXh9co_DuZfwuF86FJoiJw@mail.gmail.com> <322fd5d2-d7f4-40d8-8a06-6e7c5e9ef180@redhat.com>
In-Reply-To: <322fd5d2-d7f4-40d8-8a06-6e7c5e9ef180@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 17 Sep 2025 13:31:37 -0700
X-Gm-Features: AS18NWACcEbm1lm4H8WkQEbyfcTpHlrzU-8yyCAEibl_VJPt8WSVNJn2mY9O19Y
Message-ID: <CAC_TJvf84Zerwe7-UiRW3AYnC=_Zu3tVSSWTRcaEyoRGEnBHug@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mm: add assertion for VMA count limit
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:34=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> >> Can't that fire when changing the max count from user space at just th=
e
> >> wrong time?
> >
> > You are right: technically it's possible if it was raised between the
> > time of checking and when the new VMA is added.
> >
> >>
> >> I assume we'll have to tolerated that and might just want to drop this
> >> patch from the series.
> >>
> >
> > It is compiled out in !CONFIG_VM_DEBUG builds, would we still want to d=
rop it?
>
> Due to the racy nature I think any kinds of assertions would be wrong.
> Without any such races possible I would agree that the checks would be
> nice to have.

Alright I'll drop this in the next revision.

Thanks,
Kalesh

>
> --
> Cheers
>
> David / dhildenb
>

