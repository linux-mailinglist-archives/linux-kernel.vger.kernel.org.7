Return-Path: <linux-kernel+bounces-812407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5130EB537C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15158AA25AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913E34F48A;
	Thu, 11 Sep 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja6RCJEj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FB34AB16
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604592; cv=none; b=OfFR3QOGluCvgQf5RMiGA+aVxCZRa97lWW2w9vlvh2iVW2/SzKWHM0LAPgY0zHyqAFalb6cetsoWufALcu2kRGDtnXkDQFVlN+JzRa3JowCgIg3CzUiCnppcl63CYYfE1xi7qKGB9jY+dNIyLrFtW1OhTiL0+nTpL85U6g4YdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604592; c=relaxed/simple;
	bh=XbDtg/aIaw1B5D8Qz7Ye4TFL53yX1kLwrqeZdSjEBm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfbNjeaEUmHDzZgLfBzqCbT9iKspPcIaMDVBSyoD+nvILroc9OKSaLTQLjfL7MAxhLbNzTLGNKlYRmm6biBmuXLXk/62wd3gu6ZKkAXJW3IKW8Gl+kzGIPRK9Ta+Zpp9oKXT7HfOeKjE8OVWyOivVX+yHehw0J6LqcqE2g+rUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja6RCJEj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so6493895ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757604591; x=1758209391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kThTStovM5zRnmTibRovdCW9EC5VzQ8qr9pFwun47c0=;
        b=Ja6RCJEj0lIFWpldCd4g6zsatKwIkiopU83AHyxkk+RTF/f6+iJy24xgYlH1PJpfEN
         3iSHv6OIGctpGoMvKjBNoxit5vnSLJEeQmOJuZrUkdPxjot8YITaJ2XpZOEBnrV5L9Nz
         1IVCM5FXzVr+uJb9Zno4DdudL/Jv8PheeB5wBsrg+9aqiCapKp7WHpgN4sLfjpkGWE7s
         n9Us3RWvdZnrdxqz/KO21alqkJn2i+yuECde5SY0psIi52FMXufnLjBg9FTIRJ7g4RG3
         lqK8004z4dDv/aG5bxaIdgPYjTGC/EVA+POlgFTX/R12oNUWnpAL83D7R6K6uFfFtYtX
         mSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604591; x=1758209391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kThTStovM5zRnmTibRovdCW9EC5VzQ8qr9pFwun47c0=;
        b=ss0a2n2pegO9upXNqNCcdFWXblvkNrZBQS2w6YofrW/jQexYrlYoe6pBPJt2IAEZwX
         woPzLU4onIHKHR3CRFz7I7thlRnGIfVeBrFc4/xH1SVVZQWYn8BOczGK02JChMIdbMId
         57WAopV0OwxEDyAipburPnMJfBMwSHQJAeOI6ebQLzkyqtsURNTzYugFMs1FBYFB33r5
         z2MeEoz8rnwnioLfrhPgW11yEtBd15+ypMWBD080KN7Hve7LYEdfb6+AtpaAmOQkxMVQ
         PRKBTudWqjiQkCzUNdS8P0DAQNmH36ymn7GxVEa3EdrvHxDJUU/Dm8zUZC3eubSHEpeA
         yF1g==
X-Forwarded-Encrypted: i=1; AJvYcCXfyqLQ5bp2UfQThwkHc7UK2rM97nt4/C+bwcmsVVX9L4FikN3X9XL6Gn1P+2IkgEvCaRnZI4plfrjyWDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMjKAsjvmGpmRhHyKZM5WOBpImIqiLu1yWyj7N61IxhCIGAOk
	2VYtszKaCdSIxgvmxM35Nf7v45AoLfusQlpnf5Jrwgy3x2/yFynPVpk6
X-Gm-Gg: ASbGncvP12eAru3fWcFzW1EJhHuBwKC2nTlB/a6M12LmtjSyp5wqWV3sxdEl5OpKPo0
	gxU1d2YRX1+Zd2k+2v9hEe3fPWzShS4Mlk2fRp7nJu31OWjCGXep3CPrKTMn+1XLtjjuhn66/pr
	xFbtOSaPsGi8G52FSiQJOO97WFbySPG057eHlWjcrQv2IZ+h+B6NCDrwwl5nTG/FIjQr9awJIek
	QHFIqvibIbOEaQWRFu9eMulgnQmXmR9EtBZpScixEHIBw7AwGuRmoDNSENcV3uDS304MVySYeqQ
	Jf8BieymMmhPRX+5AWiyvqF3ENg651jMzmEfqFhiWq9O8pqzsRF7ZcOXEOkleUl7icWWY1SwREE
	SQwvY71kftB9bU9K7Y3v4G7a5kCBSS4tI84/H3olya2c=
X-Google-Smtp-Source: AGHT+IEm+RRE/bSI/p1po+MT/rTHPppO+spju+6fiNrk6imJFGLoJV3GyLq2kmt3HiwkxgdZ+AvXKg==
X-Received: by 2002:a17:902:db0a:b0:246:a165:87c7 with SMTP id d9443c01a7336-25173308aa2mr244946455ad.42.1757604590762;
        Thu, 11 Sep 2025 08:29:50 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6c2csm22602105ad.11.2025.09.11.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:29:50 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:29:46 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, tglx@linutronix.de, maddy@linux.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	gregkh@linuxfoundation.org, vschneid@redhat.com, iii@linux.ibm.com,
	huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, vineeth@bitbyteword.org, jgross@suse.com,
	pbonzini@redhat.com, seanjc@google.com
Subject: Re: [RFC PATCH v3 03/10] sched: Static key to check paravirt cpu push
Message-ID: <aMLq6ht48Mej_4zW@yury>
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-4-sshegde@linux.ibm.com>
 <aMIrgI9J4fuXntRz@yury>
 <b751b212-c4a5-4e7e-ad0f-df8cd3de19f7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b751b212-c4a5-4e7e-ad0f-df8cd3de19f7@linux.ibm.com>

On Thu, Sep 11, 2025 at 08:07:46PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 9/11/25 7:23 AM, Yury Norov wrote:
> > On Wed, Sep 10, 2025 at 11:12:03PM +0530, Shrikanth Hegde wrote:
> > > CPUs are marked paravirt when there is contention for underlying
> > > physical CPU.
> > > 
> > > The push mechanism and check for paravirt CPUs are in sched tick
> > > and wakeup. It should be close to no-op when there is no need for it.
> > > Achieve that using static key.
> > > 
> > > Architecture needs to enable this key when it decides there are
> > > paravirt CPUs. Disable it when there are no paravirt CPUs.
> > 
> 
> Hi Yury, Thanks for looking into this series.
> 
> > Testing a bit is quite close to a no-op, isn't it? Have you measured
> > the performance impact that would advocate the static key? Please
> > share some numbers then. I believe I asked you about it on the previous
> > round.
> 
> The reasons I thought to keep are:
> 
> 1. In load balance there is cpumask_and which does a loop.
> Might be better to avoid it when it is not necessary.
> 
> 2. Since __cpu_paravirt_mask is going to in one of the memory node in large NUMA systems
> (likely on boot cpu node), access to it from other nodes might take time and costly when
> it is not in cache. one could say same for static key too. but cpumask can be large when
> NR_CPUS=8192 or so.
>
> 
> In most of the cases hackbench,schbench didn't show much difference.
 
So, you're adding a complication for no clear benefit. Just drop it.

