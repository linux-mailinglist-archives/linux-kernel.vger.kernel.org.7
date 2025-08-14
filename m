Return-Path: <linux-kernel+bounces-768865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA1B26681
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA4E723015
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D0301019;
	Thu, 14 Aug 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+KdK/3+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6713009CD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177058; cv=none; b=ueAZvEDlUwDi4npwxAZyQsaHdfktJKqfRLucV0UhFzjUwqmWYq7gsCug0LGPvS1fW58QYH+j2gVbKYMgmH2Lx1Kf6x3SIjyui+598wH8ZaFQCTG45HZGr4f9wBw12/QtKFrUxvwJIMEhQTo+wslwXkP9Q4as5GZXmpEfUze47sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177058; c=relaxed/simple;
	bh=X4+/WfTXy2EGpX8MQmtccs2NkQei85yhvg8mmpAKCt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+IQMwn4WFg7kzhIgFZzxzhyYhAiXlQ3VkthAv3Pm0CjNNZwM4fs+6/AQ2rNJSTfxddqwP0naDNVnXowJbqScqEeRLhyOrErUmcmgx/GGISIksDA5EAu5mAEJM0QxHuGTMfhtnbksa/TJ00FEz5f5OcMT5nUiwW02WHFBCZ6kTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+KdK/3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755177055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9daRKeqWtuowNYWAYBAEnJnsV0LGiFCiPyyQK9EshIc=;
	b=U+KdK/3+WvyBO38CJoOuGDuc3RkwvRwYMB/g4k2a0euXqlBM4GPkSOZTLosL1ZdI2X+U+Z
	NWABCoQxfXCthFPHdWHvbbRAIAe0zDKvVYDXFIfDdmX6VAt7YM4B6hAyJnk6vPcoyIdCsT
	O+GQLzwrBcZtxe049mwvGVaeCwskrbQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-hhoP0BH1PDy_L60PAbJR-A-1; Thu, 14 Aug 2025 09:10:54 -0400
X-MC-Unique: hhoP0BH1PDy_L60PAbJR-A-1
X-Mimecast-MFC-AGG-ID: hhoP0BH1PDy_L60PAbJR-A_1755177054
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b1098f6142so17772731cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177054; x=1755781854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9daRKeqWtuowNYWAYBAEnJnsV0LGiFCiPyyQK9EshIc=;
        b=m65jxyKhTHXuMWsPPWU9dHH0nDxGW5jiJtilW2TPQn5cmO6mH4O0busLw/1IpBhKJX
         LTUj/BlSHRZe5a64WR867EsQLuwndY5YOcbBb1toI4N31UuxLMaymnOLrIs5pX+NPHId
         8hGd5quHAzQfPJ4KiVaz+Zt+sYHka8lFWgPd7V9q9hTGlJVzcXVT+PleqFQcjrANeZzV
         F2H9ktpejTedSuQSP2wkCnmdj4q61uWXcOpADRoks+T4KjyAipn1np2alnLveNIXFwXV
         8tBNZyQ+AnE/8tQk0YLSukz1/ldvkwAAP1gbIrxjvLknLuW0MynKI5ollr1lg3AL1hiC
         nRWg==
X-Forwarded-Encrypted: i=1; AJvYcCVFUSLf5OtTw01bxcqVN2VCNCASK14rTy1y1a5AcmRN8s4wLqhdaORPLIOqUHSsIe29axdbQd23qjUlR4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqvjareGaUdQJRsaOlVFC6oVKFYpczNc9AMdTauVp3OcajZli
	Pi7dkNlwggME/r4nqCx1w9eda02IcF+hWWQEhnKrkk75hxFxtV31K01RrmQfLKXioztirV7el43
	S+eo1wrNgL7KooKisLlbY65WrBt6itUW35i9DFRKaZGaSXcYZZ8oY4vl1rfrry14bfA==
X-Gm-Gg: ASbGnctqAaiAyCfi7pDhduKv67xJJc635eIOIztX8QMA+tGr/u2p3WApeBRNpPtZEyW
	JvO5xl++v5wkGwJjtKbI6/4E1XizFXjn/CFqWuwMZ6L19VHa+0DkXdbyntAfa94wpmG9YoBtT1X
	wOi07q2ibi9RNn10xZzIFzQ7PmrEZuu3T9TAKNXV8eJPISu9nl1wWqJPNmRCtqTOkOdTDV0N7gR
	yCOzX9cJAULC3Yiok+RY8UdZB33jXWMMViHmp7LD9yC1KZa9jS6YrjdolQNu7O3ZpLB+XOrvs4Q
	8ii7PMI7ZWG6+8W+yOZdhkCr1Us7imZB+OZ7mqFAh7pxeeRHaRUGNMThD8meWmYT2DF9uw==
X-Received: by 2002:ac8:5f13:0:b0:4b0:dedc:1176 with SMTP id d75a77b69052e-4b10ab01c12mr42949821cf.49.1755177053680;
        Thu, 14 Aug 2025 06:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrjQkoAx76aI1g1wd/vcIGYoxJOl/aVvP97mJrhfGZNpcG6YTfGg5/U0qUc/UJn81wFJcBhA==
X-Received: by 2002:ac8:5f13:0:b0:4b0:dedc:1176 with SMTP id d75a77b69052e-4b10ab01c12mr42949151cf.49.1755177053128;
        Thu, 14 Aug 2025 06:10:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.62.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07e8ccb6asm137001761cf.24.2025.08.14.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:10:52 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:10:46 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v2 11/25] sched/deadline: Add dl_init_tg
Message-ID: <aJ3gVqoGV7wZclyT@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-12-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-12-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> This function is used to initialize and/or update a rt-cgroup dl_server, also
> accounting for the allocated bandwidth.

This function/this patch are usually frowned up [1].

Thanks,
Juri

1 - https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94


