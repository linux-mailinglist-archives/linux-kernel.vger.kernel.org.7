Return-Path: <linux-kernel+bounces-776306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6550B2CB99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2AD5E3AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF330E0C7;
	Tue, 19 Aug 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yf6aUXUa"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297CF30EF74
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626610; cv=none; b=mRJOHfzudGoo/qzWRXWsReq7ZZyT990AZL1S1jZhHfXUsmP4dlklgNeCB94/q6mY80ImNdJeUgbPxwbA5QQ9kwtt9bwq/gmCgn+buoI69gejU0XMM6Y5++K1WYJBkHbWoFYB3kkxGJ+oe2YgL+yVv4dsyPAKBQE+8uh3dzY+ixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626610; c=relaxed/simple;
	bh=fqsRSQcivlb7hrKxPJRqT/o81Pngr06pv+ixisBGnlE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YCNvf3G7Vto5oIQLuvzAZoAMAYj7mcldVPfFtqJFdlQ30Jsc541CHaRoknCoEdOPVxaTYjbmtBPyCbbghz2L+LmjiSM19HLgjRVDLx7PKsM8pcT1nqsL/wjpTPEjvBQLZfEFZ/CCByOMcossUfH2UxZEeJ/0Ksw/PNBaOPVsBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yf6aUXUa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0071c1so20708165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755626607; x=1756231407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KF6Ep2y33XCgTx+h8iRawRIyytqbsVvE9Zs0AVU//wM=;
        b=yf6aUXUaKeSzIfEvUrnnmZxRZ8JOmnQpEUU7+4/eGu3SrIPJiDBIJQmSWskhZF0LBl
         Qhug6deinwQgXJM4c4a+aDcUWmN8UxruZZrdA+Pcw0opYBcIxUEVd5clu8z6w+Ot9GmJ
         W/LTDaaEclCvQexR2zgAb7SCXTOiOcuAOX6EYhvDUngeh6rh7hqyWS7Do5KiEQ5xOBYR
         E0qHFt+BYYG4M/T0preTyq0x5/KZlOLi9CDFTcAHG0R9ZzcPshG0dFZUOiSMJpNWwoIk
         0b2YWdPPPT7KVEICE93ZJ5o680YNDyzl+MDROvvwSgpDvyO+0PhaWaRkK1w2qUe1naa4
         M67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755626607; x=1756231407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF6Ep2y33XCgTx+h8iRawRIyytqbsVvE9Zs0AVU//wM=;
        b=DCHqG+njlm72PEttS/g1caW9M9F3mNruXScSKdm79pfNWzySn/Xh1bqAw4QnC03/vL
         atTUS8jCNmLApAF2Kb6C45gu5IoHUg9uR+1y2ttycwtmOetQ3c/0mKgTq7gdfQBcO5Cv
         4mbrPItM0+MOnPQQm2Cwfnz1C5ad20MQ+NAyF2lfDsZaRnHo2ZKRyx4FlWFPR84B5GnX
         MHtYT5lXW0c9VEY4ETggsRjjNngfd7khfFpzbdNDyJQAPX1l14aDQsD91qGvRYWYdPPE
         Y7xtLmAt9HD2pzpD9BGI3CdUHr0+16VZ8EWjQfDU0SDeewzmJUsnpqtb8S/nXqY0i1kz
         1Z2w==
X-Forwarded-Encrypted: i=1; AJvYcCXJGxoHs2h6h+DPoBHsnMyNHwaYkDr8TzL3BWM+QBGxHzbzcO6kf3aL0r1ceEGBsiV4LbtoxgTXdUeeko4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAt/sEO1pKps3g50PfNwpgnHN7HZwO8/bWrZYS2Zrn+QjAI43e
	fmzJOj3j1JEd8qsAIBR6ORXbgJj80VKjGZN/MjuuScZY25c19LYp3pRbsL+R6r6AK9t3aMtpoG/
	mQKZmr4y2lZBm0g==
X-Google-Smtp-Source: AGHT+IGAP/5kOUw2xl88tGIMUg+2rJWqwENGYoQPUjN+xF7n1jDCKhH55XKAw9uS4xoVCgiwisZ9ko0ZaQaaQg==
X-Received: from wmqa17.prod.google.com ([2002:a05:600c:3491:b0:459:7c15:15b9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474e:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b43e0eed4mr28241025e9.26.1755626607329;
 Tue, 19 Aug 2025 11:03:27 -0700 (PDT)
Date: Tue, 19 Aug 2025 18:03:26 +0000
In-Reply-To: <20250812173109.295750-1-jackmanb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812173109.295750-1-jackmanb@google.com>
X-Mailer: aerc 0.20.1
Message-ID: <DC6LOWXFIPGQ.1RKZL23ZW0J73@google.com>
Subject: Re: [Discuss] First steps for ASI (ASI is fast again)
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, <peterz@infradead.org>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>
Cc: <akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>, <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue Aug 12, 2025 at 5:31 PM UTC, Brendan Jackman wrote:
> .:: Performance

> Native FIO randread IOPS on tmpfs (this is where the 70% perf degradation was):
> +---------+---------+-----------+---------+-----------+---------------+
> | variant | samples |      mean |     min |       max | delta mean    |
> +---------+---------+-----------+---------+-----------+---------------+
> | asi-off |      10 | 1,003,102 | 981,813 | 1,036,142 |               |
> | asi-on  |      10 |   871,928 | 848,362 |   885,622 | -13.1%        |
> +---------+---------+-----------+---------+-----------+---------------+
>
> Native kernel compilation time:
> +---------+---------+--------+--------+--------+-------------+
> | variant | samples |   mean |    min |    max | delta mean  |
> +---------+---------+--------+--------+--------+-------------+
> | asi-off |       3 | 34.84s | 34.42s | 35.31s |             |
> | asi-on  |       3 | 37.50s | 37.39s | 37.58s | 7.6%        |
> +---------+---------+--------+--------+--------+-------------+
>
> Kernel compilation in a guest VM:
> +---------+---------+--------+--------+--------+-------------+
> | variant | samples |   mean |    min |    max | delta mean  |
> +---------+---------+--------+--------+--------+-------------+
> | asi-off |       3 | 52.73s | 52.41s | 53.15s |             |
> | asi-on  |       3 | 55.80s | 55.51s | 56.06s | 5.8%        |
> +---------+---------+--------+--------+--------+-------------+
>
> Despite my title these numbers are kinda disappointing to be honest, it's not
> where I wanted to be by now, but it's still an order-of-magnitude better than
> where we were for native FIO a few months ago. 

Some people have pointed out that I'm treating ASI pretty harshly, I'm
comparing mitigations=off vs ASI, while the "real" alternative to ASI is
whatever the kernel would do by default if we knew about the vulns on
this CPU.

We don't know about that so I can't do the exact comparison, but I can
at least repeat my compilation experiment on Skylake, without ASI,
comparing mitigations=off vs the default:

+-----------------+---------+--------+--------+--------+------------+
| variant         | samples |   mean |    min |    max | delta mean |
+-----------------+---------+--------+--------+--------+------------+
| baseline        |       6 | 54.15s | 53.94s | 54.36s |            |
| mitigations-off |       6 | 46.53s | 46.37s | 46.71s | -14.2%     |
+-----------------+---------+--------+--------+--------+------------+

So that's pretty comparable to my ASI results above.

(I'd love to just run ASI on Skylake and show you those numbers and go
"look, it's faster than the default", but the implementation I've posted
doesn't actually secure a Skylake box, we'll need to add more flushes
and stuff. So that would be unfair in the other direction).

Anyway, I'm gonna crack on with preparing a [PATCH] series now...

