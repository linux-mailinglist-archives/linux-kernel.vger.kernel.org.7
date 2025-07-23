Return-Path: <linux-kernel+bounces-743125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35173B0FAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387F2189C5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6403229B21;
	Wed, 23 Jul 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="MGky4O9x"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A62192F4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298720; cv=none; b=iTj8TtgPu8HJi9ohQosbT4bkCKm6d+enKq/veod/5UE9u5OcWBZFnCy4tyd5vEJpwlv8u/v9LHVppnNHEVRoHNIl19+IlOrPjZIsWRTkhdxa/+14srxi+3BAm9RA0scU/eNfsVY4eh7bZDNdxjpU/J74tpU8+CsfKql/wQG6wUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298720; c=relaxed/simple;
	bh=BkbfST8VnkNe2dA/eG0x4Zv7iq6xINXAglN3NoSKfys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhMSO8hhwonviL5NNYagAcqsSQlbyyVAuc9xvAji2Ww3uknsSPZ1ovhnIKXKkXc9GrU3V9wB2jZPCcUUSuOBJw/q8ssRjpWBVNrwOc/Z0bEfMK/wP2QFOOaTHWKLQCPQhX7jUr8IF2xMYs6Uidm2QBsutIWcZBHY9cBDcmFEv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=MGky4O9x; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab82eb33f9so4224191cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1753298717; x=1753903517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ja0+u1t4v2GnYrO6vfHRjNkhPG9aXnqYbT0ae6BB0O8=;
        b=MGky4O9x2AETvR2H/qYFl08V1e5VR7MlQsPlDQP4Oj3YdiOEt1v56QjOc3ZlW6epWC
         tiEI7pef4DJUwiODErN6G62pKqoBEm6YdNWVwIDnc6WY6a78qL/IQuLgFK8HotdwnAgk
         yIFfsTMIccwjvge1YOMKkkP/VLsAQSKGVA7XXieUn5FYjhJhYrN5PkUhP0Hbs1EGk3rt
         JLRRtJzu8zB/1ytK2Q6lxZlCvtTNtItMEDYx0IUqD7K6/o8lCobZFvfzSwnrkX6gFAIF
         B8OBnViiXD/Tzvzyk4ecU0g8Rj/lnbCXmECt/gNaTjZuozKiROKguUwzNQ6kU5VsZ7ru
         gcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753298717; x=1753903517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja0+u1t4v2GnYrO6vfHRjNkhPG9aXnqYbT0ae6BB0O8=;
        b=BFS5Kez5AfuL474v+5RasjYpG0hd5u6UUz4hOGcz10H/vF2CrH6/aTgXAxtEzOgvOp
         dSNqMqhao0pf4WVSzBrNeEGG/8j0MjZrjWOgBHqk2267F/7EnDSzoh5xepIXJAUq39yt
         cJxUw/sZ1Iuja9+0f4e0nRerr2jjScAnQQj5N7yKpVFO/ArHwjW/5lATG/O2Ck6kGrpk
         Tyi8vXGIPfhXnrwSGONtH8Qtrt4aX9SagdTYjzHhjSclqPAEPZtd1JretFcdiuL0PYOc
         pKjZsvxk/yy/Tj8vr0pIWlnSWEh+6V4iuLox1Lu3LP5i5sv5Q9bdUE7ji65KT4Wl9/xg
         8Ibw==
X-Forwarded-Encrypted: i=1; AJvYcCXWLfwHs21u4ianr1D+cEEL8FEAFgoFBKpa+mvjrHo9QnqQzBqvtfKLkfqrIThGG1i4YYLuG41IL8mNDrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy25hfOB3J8PiAECVgI8pRM0ZjtfQhYrBdnKFrh2nQXvyiGIOJl
	OuLy43iOSPDM5j1srXp6zdIbnqZWMRhDgAkVJkccjdAwj2S0AHFsv3i0k2L2YWxVig==
X-Gm-Gg: ASbGncsTeQ9SEq4Uff9OjUmAgSpwpZ9AUEKuDyS9UXAv66SdvYE08qnTnCl0JPHXaL5
	xCqUVunB/a92Z3jidisGQ8u/jNGJjdAsBo9fZL3m5hEYDa1g2iZ5OsGRhvK3uaKWJRS6K8msSmy
	l6oZwM6jINdPdM4QxhLGzjUBUZR/OCVI++1Lkp5VRBw49gld3lyilOSvLQCqVUCj9HVuxZbeHKT
	9FOzqfSpjC/1uM4pqauvwqmryvoKCFrUHdcHMy95M3vfh7GJm2XiXn2ECFlUpkr3w1CR+yqBl7m
	/+OHVJHpny08PZ38XreecDPRwwb/46ZXGwW8P+ycix3vuRYEXWZvWyoHdUsi0uG+4qvU7O/hC52
	S2vbRqNrZmr+1b5kAyYZcThub7Jd8qFawngAbAihz6R7Gx1ymKCZ66G98UmbRg904/w==
X-Google-Smtp-Source: AGHT+IG8vOZUCry43fkriuOa/tnIX5d5irFl/w/P6a2uToDSFLiTZ8ufd5Tr7TYG4+WypOiZc7k5eA==
X-Received: by 2002:ac8:5913:0:b0:4ab:9551:3b4d with SMTP id d75a77b69052e-4ae6dfe9242mr49397451cf.54.1753298717332;
        Wed, 23 Jul 2025 12:25:17 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:3d4c:de64:63d3:50b5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb499fcd2sm70834141cf.17.2025.07.23.12.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:25:16 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:25:13 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
	quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [RFC] tools/memory-model: Rule out OOTA
Message-ID: <b9c250b2-e4c0-4e8f-b37c-b51d93b980f0@rowland.harvard.edu>
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
 <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>

On Tue, Jul 22, 2025 at 05:43:16PM -0700, Paul E. McKenney wrote:
>     Also, C-JO-OOTA-7.litmus includes a "*r2 = a" statement that makes herd7
>     very unhappy.  On the other hand, initializing registers to the address
>     of a variable is straight forward, as shown in the resulting litmus test.

...

> diff --git a/manual/oota/C-JO-OOTA-7.litmus b/manual/oota/C-JO-OOTA-7.litmus
> new file mode 100644
> index 00000000..31c0b8ae
> --- /dev/null
> +++ b/manual/oota/C-JO-OOTA-7.litmus
> @@ -0,0 +1,47 @@
> +C C-JO-OOTA-7
> +
> +(*
> + * Result: Never
> + *
> + * But LKMM finds the all-ones result, due to OOTA on r2.
> + *
> + * https://lore.kernel.org/all/1147ad3e-e3ad-4fa1-9a63-772ba136ea9a@huaweicloud.com/
> + *)
> +
> +{
> +	0:r2=a;
> +	1:r2=b;
> +}

In this litmus test a and b are never assigned any values, so they
always contain 0.

> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = READ_ONCE(*a);

If this executes then r2 now contains 0.

> +	}
> +	*r2 = a;

And so what is supposed to happen here?  No wonder herd7 is unhappy!

> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = READ_ONCE(*b);
> +	}
> +	*r2 = b;

Same here.

> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +locations [0:r2;1:r2]
> +exists (0:r1=1 /\ 1:r1=1)

Alan

