Return-Path: <linux-kernel+bounces-769029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6CEB26950
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E8189C0A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA81DE4C3;
	Thu, 14 Aug 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX6iz4Ap"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A5134AC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180818; cv=none; b=AkqI8VE7QwBzp2+RIGZCajASjpcV36SFhLVmxHAl0JSZ7w39+oAIb7Onm+GbDtHB5Jc4DZZEim6UAxTUUB3/cF4RywAB/AUTSc2kLXJmfHjTQrxvRJgufwLdyXYHDwK1fAAZo34////HCRxuL1lFzNyHURBqj4IkESjmhU1RkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180818; c=relaxed/simple;
	bh=pms/k475i1tPoorXgh0K72TMYj016ye+g1NHO5ljpm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6+vfun1XVX74gmGaDXw+EiZ6iGGUiJgCTdK+8JHI02tz2KHcvpFD/cNFfGTNAoYhs83jhprvMEttBhcvVUXnoE2NqEb7hsKqdjqnQE4Ab6iFT5cvgVNZ92WJecmCcW6kjyLI7J38Vu2rQSn9oR4nChozw3NfaZ9CN3+2YEioXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BX6iz4Ap; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755180813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gp3s0yiTZmtyqC1kUr1wW6nLK0Q1HRFFPb0pk9Ihlv4=;
	b=BX6iz4Ap60Sb7zFB9mLfq/JHhzFCreolx10fhNuKIK+7k4qRycTnMhpacdvchv/2IH6ZRb
	nqFLFS7LQzZmLHEO/+n3/amKERaSSCVAL/HNKp6muxnzAr7geVQD7yET+ooX1PZ/6UyaKD
	QAFKBGNtW02/0/RkHH7yoY9NtO90Vuk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-Dloku39VPD60CO-8tiIz_Q-1; Thu, 14 Aug 2025 10:13:32 -0400
X-MC-Unique: Dloku39VPD60CO-8tiIz_Q-1
X-Mimecast-MFC-AGG-ID: Dloku39VPD60CO-8tiIz_Q_1755180812
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88dd04faso34340616d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180812; x=1755785612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp3s0yiTZmtyqC1kUr1wW6nLK0Q1HRFFPb0pk9Ihlv4=;
        b=rWZ5b8gZkay6WrXuA9OJQLea4m0sVxZYMLF3HxTyVFdl5bO3EagDoMVNYV5DbRcGBs
         h4Y7TwJ3Dpyg58pla8R5c1SQh+SU2pUbGA4DuWbfluiZw6lB30WzF7hlOa1ojBzFa9Gp
         QqkabsnIZN9u28yE/WNhkGxHwYFNuIRaKd4OGNaRVX/Qsu3hAtOHRvSGZddsHa0A38nE
         +jX7xDwm57nMkWBukZ1h6PAIWQ8PLSJxjELTQfOya9AhugWAjaxk5BJE1Xqi/yyNvZkz
         BSjgeIK6ZrClsv4uXl4YFvJZoZLFigPrKIZ8OZWZR2bvBJ2JopJ46iH3iyLSFGwc9Sdx
         fgvg==
X-Forwarded-Encrypted: i=1; AJvYcCXAYiRUoIwdwS+n+hPjFA47FeQIRr/vfz27Waxf5A8m6rm0RZu7NuOkLBzKsSicvd583iB4W2XLJUEFDdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcAPfvzJJ50ping4SpiMc5SSyP69NV2/yFJ+M31Tpk3Kebc3G
	kMHM1wCWk1Z5nyNQJn+8fV5kgNErgCdRrBPwxwHTXHjmiSqtjCV4+xU9v73MXgkIdoVfTQBQHiL
	4IZz2GzfthfCAJobTYs8GBdaVJpiXIMuYAUsJZn5cpzo+m4FkrCvb7tCIJ2Wb+sLY/Q==
X-Gm-Gg: ASbGncvtEYFD/YRBmC2abxJI7MLmQHdCY3rFWBghsFoGs5ZrAF2NQDHFc03rE8bHXt2
	H4poxlXc8wyPw883v5Ip0+qVUxLNpSZnPVAA+MhKWZ50N0Cb8P49mFwizhsOtsZrTT1snkR1kDw
	IGdTiURanw+DUdvFaeU9SpSxjucz7uc7xisLW9/+KJEKs5QZICw/NbTPGupyL7f9AzUMKTHaGQW
	FROwOGcwWYS9ujz+Q27dThFOBvbclRKwDf5Ndz/yYlGXmW3HywxnIGX0hNZTYp3cGpW7QCAz12u
	HDFJXAI5fFXBP4Pc89TbQavhoX+jaozwUjkxbX8A5aJ3i0lc5fJVAcFrE9GzpRKrL65myQ==
X-Received: by 2002:ad4:4ee7:0:b0:704:f952:1884 with SMTP id 6a1803df08f44-70af5bbc73dmr46617226d6.49.1755180811905;
        Thu, 14 Aug 2025 07:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd8oJQbczov0TdCoV9OF1i9+zcEgH9NUXfxqIq0j2I07MP+odGIBr+0UorYc+Us+CIw1I/uQ==
X-Received: by 2002:ad4:4ee7:0:b0:704:f952:1884 with SMTP id 6a1803df08f44-70af5bbc73dmr46616406d6.49.1755180811184;
        Thu, 14 Aug 2025 07:13:31 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.62.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b80440sm13346166d6.62.2025.08.14.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:13:30 -0700 (PDT)
Date: Thu, 14 Aug 2025 16:13:24 +0200
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
Subject: Re: [RFC PATCH v2 18/25] sched/rt: Zero rt-cgroups default bandwidth
Message-ID: <aJ3vBA_PmsaGSYUj@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-19-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-19-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:
> Set the default rt-cgroups runtime to zero, otherwise a cgroup-v1 kernel will
> not be able to start SCHED_DEADLINE tasks. The bandwidth for rt-cgroups must

Well, we disabled v1 support at this point with the previous patch,
didn't we? :)

> then be manually assigned after the kernel boots.
> 
> Allow zeroing the runtime of the root control group. This runtime only affects
> the available bandwidth of the rt-cgroup hierarchy but not the SCHED_FIFO /
> SCHED_RR tasks on the global runqueue.
> 
> Notes:
> Disabling the root control group bandwidth should not cause any side effect, as
> SCHED_FIFO / SCHED_RR tasks do not depend on it since the introduction of
> fair_servers.

I believe this deserves proper documentation.

Thanks,
Juri


