Return-Path: <linux-kernel+bounces-838563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505ABAF8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E576E2A06FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC772773D4;
	Wed,  1 Oct 2025 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flAWpbM9"
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0F26F2A6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759306225; cv=none; b=APcykwtbrjTmEY4ckUhBrqjPlN4LPsHMFMMZt6D/9Ivf2NoaY5/O8nOyUnXQMCRCmg0ppva5wBQLq+B4QCESPwWSMYMTemWzYDnb5iHxFl4h1o++qFq/r9oUQBaZm82MYKHpzjMh7xC1b/TnuMDqJLKEzSTySOHSxNhka4cDs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759306225; c=relaxed/simple;
	bh=pmWV2npHtHYRhiTx5XMZ+6dGBBL9lNsB1bWFIw2plJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IKFYU2Q8MtfAJ8qCsLk2oRf9S839+l3kSmQa+b5Z2hzED0CImBnihUBz8yuVqGpNi5OiAs4qWy19N4p5Y8IWNDtTA0nL84hefsadENTO+bCWh/3b4vzvxsksAE552PnkNSBXg4nMXuct18DQkG3DGX8TimPToDGxf0wtaDrtXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flAWpbM9; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-635355713d9so5859798d50.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759306223; x=1759911023; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmWV2npHtHYRhiTx5XMZ+6dGBBL9lNsB1bWFIw2plJ4=;
        b=flAWpbM9saJNClxw9k4xOAMJPR4o4p0gWsDdfAcfXXnQOAmJN7myI6xiusmBDxy4Ws
         4PvngisG51nWgQWzK2g3Jzs1FS/naEDVBceTznt5TwUE2YhdlIsd3ulL6OSsSXHssVTj
         b81Ke19bjhan1H8Ei3TNDy0VH9ALZyhPkyLao6qwjidVypE8BEtPCZ2L4THVMp1fj1p9
         X7A0igF2DSv7EJSiXKZoREJEG9Wk8xUXF43RsiOVZwY4ehgNLZ3rzBqnMgok5dZN7gkK
         NWhLhIkvP+NY+kHHJcnIOYO+8OnRqoML9OIhm4kIFC4xdQZOp4ehrX2y7eAtYdUCa/PT
         pHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759306223; x=1759911023;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmWV2npHtHYRhiTx5XMZ+6dGBBL9lNsB1bWFIw2plJ4=;
        b=bcLHIppFN4H1zF5/Xi0qaMohDdCQ7ajmMPwJEixN4MsUBlShLCSbu0zeZ8VIxFQiM6
         ECR/KpM+Hv+UzfcMHbCUmwadl1716MR0DZBqjjJoiendElfSi6ZtmoJpYP+cgvMuK2nU
         FHm+wDcxTHBLfx//NADDP8pIsho4AVdwe1McXLOH9aJHqm/oOC+K6esT6AeoE8hQSAQ3
         e7zY8HTdzchBJ+Dzqh8mjA0yvSq7p8msdQB5T0TvUuC6iC6c5Upu4bJ0H3cG1ZU/IRNP
         zdgbGEg4RZTjJFLft6RMgO0nfjJVWtZ5Q8x5h3o9/g+NNFqZdfzpXaANYg1z4lz/HC+Z
         /wdw==
X-Gm-Message-State: AOJu0Yw/h4gv0uVCwx4cxc9ZfBidImaOTUoAGRkM/I4pQO/UkkGcon4h
	zEKmT5M5VCUxnX81wwfB/BQGdDsSkjrOp/XxEM+Moh3cZvDOXLBEGNN5WtmhMO2xbz3MLoa1SOy
	0bJLWObmNpVZp1sKaqMiJ56Uy6gJhYee8UGd3T9s=
X-Gm-Gg: ASbGncsNyLZhpF3TV1pC7tTfMkdAqGJVnrssPML3AbPGKvk70cFS0K1YEmVeuiJq781
	8rhyHNgEq65HT3fqmaWj7gZvfkl9s2WqBGbfqIQNu0dSVo/M0X2XFfFBPtIovVHfzOzCh72N9tr
	cA2sd1yfXjLJp5WOdHXh6RdeQYa0xlooZDPYEiSOc7lYBdA5Iqj65sWbkm8WE4+Vzzry79Lb3W/
	FZI4ixxcT08eewv9qHI+Frnct2D6czLGxhS7pUS1AWCUzNixAetzP2+eOq64tM=
X-Google-Smtp-Source: AGHT+IFehpqyyHavCtjS/t1Rk8emBQapCAppet0skLIS+JI5vP/Bnh1y5lMbP8wFw+lncZzUa+WPcQkKfUoHRJgGJ4Q=
X-Received: by 2002:a05:690e:150c:b0:633:961a:bd46 with SMTP id
 956f58d0204a3-63b6ff7e962mr3279763d50.25.1759306222592; Wed, 01 Oct 2025
 01:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFf+5zjc3gCtdXLsZqDtw41njt9Z_xtNxrJ92ftWGa9o6AvBHw@mail.gmail.com>
In-Reply-To: <CAFf+5zjc3gCtdXLsZqDtw41njt9Z_xtNxrJ92ftWGa9o6AvBHw@mail.gmail.com>
From: Amit <amitchoudhary0523@gmail.com>
Date: Wed, 1 Oct 2025 13:40:11 +0530
X-Gm-Features: AS18NWBeM8KU7SVTxGrncUzdWE2wSKJ5QwT42TxtP_36EC2Xl88xaLE9-p-pQD8
Message-ID: <CAFf+5zj4Tg-uNqPaSzqmryC7kPDY5bfUe2iu0EeSJE+k_nwUrA@mail.gmail.com>
Subject: Code performance vs Code security.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

People are against input validation because they think that:

1. Input validation will lead to ""significant"" performance degradation.

2. They don't want to put "arbitrary limits" on the user.

---------------
Point no. 1:
---------------

There has been no research / study / tests done on whether input
validation leads to ""significant"" performance degradation. So, this
claim is not backed up by any proof.

I did some experiments with glibc's qsort() function and I found out
that the performance degradation is only 0.6% - 0.8% per function
argument. So, let's say that there are 7 arguments to a function, then
the maximum performance degradation will be 5.6%.

So, now the question is - do you want to give your users insecure code
(without input validation) just for 5.6% performance improvement?

Another question is what do users actually want - no one has done this
study also. So, we can't say for sure that users want 5.6% performance
improvement even if the code is insecure.

These days, I think that most of the people want secure code and
probably they will disregard 5.6% performance degradation.

And so the code/specification should also change with changing times.

Some people (exceptions) may not want 5.6% performance degradation but
then we are satisfying the minority at the expense of the majority.

---------------
Point no. 2:
---------------

I am not saying to put "arbitrary limits" on the user. But reasonable
limits should be placed to save the user from getting hacked.

As an example, what should be a reasonable limit on qsort() function
as to how much data it will allow to be sorted - My opinion is that it
should be 5% of RAM (size_of_ram()/20). If the user wants more then
the user can change the code or write his/her own implementation. I
myself don't like how few functions of glibc are implemented, etc. so
I have implemented my own versions. I don't use those glibc functions,
I use my own implementations in all my projects.

Now, we can't give more than 5%. If we give more - like 10%, then
chances are there that other processes may not get desired memory.

And 5% is probably what most of the users would need.

This is a reasonable limit, in my opinion. If I write code, I will
give 5%, if the user is not happy, then the user can change/implement
on his/her own. """"But, in any case, I will not give the user any
insecure code.""""

But the point is that to satisfy a minority (who wants 10% of RAM or
more), why are we giving out insecure code to a majority of people?

Also, in my opinion, whether the code is ""low level or high level"",
the provider of the code should give secure code.

Also, the user of the code should also write secure code.

So, in my opinion, secure code is not the responsibility of only the
user, it is the responsibility of both the parties (provider of the
code and the user of the code).

Another point is that if some specification is not taking care of
security, then in my opinion, that specification is wrong.

As an aside, insecure code has led to loss of millions of dollars
(ransomware attacks, exposing users private data (SSNs), etc.).

Secure but slightly slower code (around 5% slower) will save millions
of dollars and also save lots of people/governments from lots of
trouble, etc.

Let's say that some hospital software got hacked because the code
provider didn't validate the inputs because he/she didn't want 5%
performance degradation. Now what will happen to the patients? What
will happen to those patients who were using medical machines and
these machines got hacked because 5% performance degradation was not
acceptable even if that resulted in insecure code (which ultimately
got hacked)?

----------------------------------------------------------

