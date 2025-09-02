Return-Path: <linux-kernel+bounces-795695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F6B3F691
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D6B189635A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ACB2E62B1;
	Tue,  2 Sep 2025 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjE8oDue"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159103398A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797878; cv=none; b=TPhdJbxJkH/JqL7ioplSKF+PLsAmx95Xo69fjD6WLcpa3t825OvEBbMFlHAYL7cIsAPtp4QKjZOalQC0nF6gITV2cpl5G0/YE4GeCQ6qs8Yn+2iyVAegaa/bzoBCyiSAANWfuqUdlT95ltE0NAyoZ1kB6axNSbvALIdzezMFogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797878; c=relaxed/simple;
	bh=eju1T8pCVvx89ZeKHN3PMLyReKD9Trk3dm/ZoDrU3XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByOHxptTYkL31KGnWAXOWEqz9lM8i0ZJY6qm7jmq9bXETCGWl4wVaPuKfjysDBCsrtcK9V8SAX+WVD6TGUQJgIHQFbdyLHUrxRdbjGxbPyngyPqw7CaiARujNHnW+8jRbkTEWXod59m0fNe79zApdxr386Ep5u50XYWHKw4cV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjE8oDue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756797875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eju1T8pCVvx89ZeKHN3PMLyReKD9Trk3dm/ZoDrU3XM=;
	b=WjE8oDueM7FrHlDlUquDnm6r5vnlShCA8sbjpVf2jiNHcc4yuO6k7qPrvD0I81p4dIfiJB
	kVQYaHbrLoqLFJYyh3Y7YtutEzfiOIW3V/liysnT/fhBxXDhA778Rks/LjPRHF0uI7s9tr
	9OItp9oYPt3Ggjid3xVLxJ09PMSa9A4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-rSt5XtwvP3K9nkRDlQSmVA-1; Tue, 02 Sep 2025 03:24:34 -0400
X-MC-Unique: rSt5XtwvP3K9nkRDlQSmVA-1
X-Mimecast-MFC-AGG-ID: rSt5XtwvP3K9nkRDlQSmVA_1756797874
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2f7851326so127109371cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797874; x=1757402674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eju1T8pCVvx89ZeKHN3PMLyReKD9Trk3dm/ZoDrU3XM=;
        b=ebW2c9z9UqLsCQnEU80p4OJQCCYETpyQ2jvmytf0i8l45TQCSlBza7wLJ0NqETR3xM
         AI/ipPejgqrq+Z77DisJumZu0KzI0P1Hb22chNLg3pK4RQ7vsK0Au/FrGCP/+bceyHld
         bkUh+4FiY08ml72GSmqykQvMKUNJv+TYX2flQ2KWCGwlmPMb/lur87m0u0VCXFNqQ66l
         01lIN6mmKMW+uOpgHRQ6xLG/nSXklRAvm+cUNvES7qCYAZIUbZjNd3rfVSn839NheAjb
         fLdGYrYuFBGhChzkqNlJtxJ/gcqVEq5SPbqjebjdwkc4nvwnuHdejkoyMA5pzPfdsqAl
         TwAw==
X-Gm-Message-State: AOJu0YzYkpBy1wbiXyYb6xq+3PvR3Q+kzlhhoMoFqfJWXythLObufzpb
	naUScx8y+uXTIjxEB72R6gqO1dKWutl05mxNV3IZ6107nGiIeXcc11DjCl0rAiHwaHzUacfb0GR
	XGJLA84qE8njkEpjVSl122lcSeDgaqfdxR2Pb/iMmFPCkpB72rZzFrIjpZ1N2vj21Dw==
X-Gm-Gg: ASbGncs5TdXk5fm+PzqdWLqgL+9FiW3Eu5yYnUgmzvhaWrOKm5tM+1dSDrRYq0V12CJ
	KaoDXwe/Y+rQfRLKPQtcFlDnO8yCh8IyyfMYUPAmBgpdYqIl260V6552V/BXiEGi7jE98UoYU5y
	bulK74rWE628Oa14fl8K0O30rZJ4sO4dyoysF2V5FMdzJSEqWCdLjg95sJeYWpkxnG2q03bxdTe
	qEJB1RLxuSjXwXGqV3lJR06zF70omoWblsYQ8IcEr1y9CHj9X7KSzmKl8sBaDS0bufIzCHaYb7j
	HzNyMkBxpujusRFgVRbmC08KD/X733poiYipqjO3l8cKqWn53OdX8+DWMU5aYA5NYrNCdvA=
X-Received: by 2002:a05:620a:29cc:b0:7e8:23c1:f472 with SMTP id af79cd13be357-7ff26eab1ccmr994505685a.3.1756797873922;
        Tue, 02 Sep 2025 00:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPg3hdu5JodFozpWkdD4pgt31QG7L5zOYnyAbFPu7ZX/efiTBjunMP1yXYo/JW79MBOL2yLA==
X-Received: by 2002:a05:620a:29cc:b0:7e8:23c1:f472 with SMTP id af79cd13be357-7ff26eab1ccmr994504685a.3.1756797873553;
        Tue, 02 Sep 2025 00:24:33 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069cde2863sm90429085a.58.2025.09.02.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:24:32 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:24:28 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
	Alejandro Colomar <alx@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/4] man/man7/sched.7: Update the real-time section
Message-ID: <aLabrBwH4Mz8seCu@jlelli-thinkpadt14gen4.remote.csb>
References: <20250829160200.756194-1-bigeasy@linutronix.de>
 <20250829160200.756194-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829160200.756194-2-bigeasy@linutronix.de>

Hi!

On 29/08/25 18:01, Sebastian Andrzej Siewior wrote:

...

> -The FIFO and RR scheduling policies are then used to run a thread
> +The
> +.BR SCHED_FIFO ,
> +.BR SCHED_RR ,
> +and
> +.B SCHED_DL

I believe SCHED_DEADLINE would be more correct?

Thanks,
Juri


