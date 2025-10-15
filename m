Return-Path: <linux-kernel+bounces-854067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B527BDD77F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52B364F5454
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA4313284;
	Wed, 15 Oct 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WT16p5pM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247373054D9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517717; cv=none; b=QsHaSD/hohH39TV4MspNpt6VC87owjnRlvDQ/ZGBakdbc8uZY4UY9H2o+SWw8xWoQiM9lEEt4mxRqJSqsYIh5IVHvAbRJ6JEql3eayNUNH9NOkEQiXZJhyCc/pJy+q9NfmsQSVbtNIpF/jjacE1e+dtW596ztc/F2tAxWzsFLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517717; c=relaxed/simple;
	bh=KbPEz67tEklbF4EPHgRj2yKKp8l8GhTpFWNCtyilI2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfLH30X2jL3hbSKQGrHCe+AGw4/IJ48glX8hxS/9o2VNjh3SdxXLT4aFb3g5hGwdG2W0LCjmmcai4d/kokSAoXTyJ91o8jUzlz4P8mkA1W6D/AzrwoFpTMdk4OnYawOc+1Emzhq8lBUC9KB10cT+a/7AkrImSXYyw+CCfCNNCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WT16p5pM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760517715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FZjabtHhwIt8AJhFPdoQUHmU/EUEXQFIsgKNu3JGvWg=;
	b=WT16p5pMUOUN1cUkLE4zf0w3nVpL9Lsx520OWsgj9+PUBHrbDRaJ98CXr/ypq0qOPZftD3
	0VikqgZTRONdffg0YR7hBARZK2PxDXCZYqsXgf9+q6pBBMpTqD54pDPO+Giz5yCUbdhBTB
	RuM1Q5s/H4+8pfYrQi1pnWdkA2nL9pU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-rdUazP7nNRSYqr860xX_FQ-1; Wed, 15 Oct 2025 04:41:53 -0400
X-MC-Unique: rdUazP7nNRSYqr860xX_FQ-1
X-Mimecast-MFC-AGG-ID: rdUazP7nNRSYqr860xX_FQ_1760517712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso1481565e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517711; x=1761122511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZjabtHhwIt8AJhFPdoQUHmU/EUEXQFIsgKNu3JGvWg=;
        b=BB8AKYO7KTmAvlI/qeOlV4CKrVDcJy2t+2jVZQaSqR0hegatXo6u6FK+GuO9JfMNY1
         8gIe0PBVmf++JbyMpms7Jd7x1US+nZPZclkskBn1uFy3L3RYe62gIuqtOMsxwXXewINd
         iYq7FX1HQR48+AJ4CMcJRPFdL4YgOKXmwX6zHAUDKe9Fjmif9yz7h6fl40fz3xGSdQeB
         1CjoRPMBTxbpxDcyJyOq/tm/QWhK7LZVG7qqxUTPIRttoqOudBuUTiIWD4RJ8Maq/fGW
         +Vm78mbxqDmzkHYcxRbslEc4RfE60A9V4eI/4u+MuFqoS5608MmD+tUfMwwF9DhCAuFq
         J45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDVJvFyEczFYvCZ2F+2gv7ssI4oDMDQbWkyV3ICOFAVk9gC0wuQlXbNu90MPAiVG716VrQPPpZ0nd7Q3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTiZ10/PgldOVvgtzHa4DSw9nj++iCoYao0PFLxHfR8ZxRm2tO
	7mK4Uw6TM6cTz0CvAkHFExH0/R98oQs2sojqcATgX+gUw7L9Vqm/Yeik/dWOOA0q+ew9bZj6kwo
	0nF8Mf3gIAdGwqhvXV0nzmqY0ag5LlIIresRNExSaKw7XvOgx399PQ9xjOYb1K+XXexzIwibfyJ
	fS
X-Gm-Gg: ASbGncv14mZmsx7hKmaDrpxneidtm1u0UQhOtvHyjfohSL8Q292+knoqtJkldz72jEu
	8lxDsD77utpwflBKJoEgSbu/o6zRn/9ooS03UHe3/68IloJk0m6cRFqWAAZo47VwQZwLB6KMzBa
	b4dwm6hGJG46R7BBtwBb8UT7ea1U7/M7GbdUFwtzuY4soOGwYIJ7gxbjsjpTwFhfMvu69F+lRTq
	g3RzkN0WnJt267K2YIuh+Mrs/Z6N+Dkey7/lLD9zsVG46DDSmkXyZC4yDoZU1CYBQykAREvsSiK
	NKoptpIzscv9Bv6OfXKEpQeJaD+XjIHfWUhbaf5MytE813ZLo7CRCneOieDZiVkBCw5mtmEN
X-Received: by 2002:a05:6000:2281:b0:415:24ee:60ac with SMTP id ffacd0b85a97d-425829a5a28mr22939639f8f.5.1760517711544;
        Wed, 15 Oct 2025 01:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTKQrREe+Jm0Z718CYRa01S9pL4zoJJhYHIvBsypXCpX1hg7gsrH9cAT3Yw5P8rdQ0E8H7GQ==
X-Received: by 2002:a05:6000:2281:b0:415:24ee:60ac with SMTP id ffacd0b85a97d-425829a5a28mr22939614f8f.5.1760517711149;
        Wed, 15 Oct 2025 01:41:51 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101be4876sm19227045e9.4.2025.10.15.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:41:50 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:41:48 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, nico@fluxnic.net
Subject: Re: [PATCH 0/2] sched/deadline: minor code cleanups
Message-ID: <aO9eTCDQDqDDbj0B@jlelli-thinkpadt14gen4.remote.csb>
References: <20251014100342.978936-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014100342.978936-1-sshegde@linux.ibm.com>

Hello,

On 14/10/25 15:33, Shrikanth Hegde wrote:
> While trying to understand the dl_server changes, noticed these minor
> code optimizations/cleanups possible. 
> 
> Let me know if these should be squashed into one patch. Kept is separate
> as of now.
> 
> No change in functionality. Could save a few cycles.
> 
> Shrikanth Hegde (2):
>   sched/deadline: minor code cleanups
>   sched/deadline: Use cpumask_weight_and in dl_bw_cpus

For the series (I would keep the fixes separate)

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


