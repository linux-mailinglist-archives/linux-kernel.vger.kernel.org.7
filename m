Return-Path: <linux-kernel+bounces-840267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8D2BB3FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24A819C10B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A831158E;
	Thu,  2 Oct 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVCGzamv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED529ACC5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410641; cv=none; b=TAtojV264iFVtGdwnyrrfxRFTFiXqKIBDRh19omc4psxBAdPP+8HdyC+o582Dap3ksHAK31rKxvZImmAS640osY5H1fxQLIh2Ry+VgfR1eGHmfl3hILaMQKZa3uXQ5364c2+t5DYbu21nW/zNmssG9Yr0xVe1WtvxOqgoK+DiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410641; c=relaxed/simple;
	bh=QJF0XWL/CCTJQZd6xxS0NVX/uZ5nQxfdHR5ls490IAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxDa2p7hpSHaYrVleUN1AvkAaNbOVDif8BZ0PxPfZD2XnvoOfPKtFwbTtR0U9vB2kfgaLEn8k53sPuFMeNbJ1UjckdT1LIrjTYeveiNk9xZ746YNHOEj+rZ5BHDZ/QafD6f+B0yhvJ7kKrAst+3i6BdGGTYVCBzIrOPpMhvw+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVCGzamv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759410639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcEyFaY/aQDfkrlMUauMWUQe7H6acqQfJ7BWFwOP3Qg=;
	b=AVCGzamvv/9oyHE0fvbD1IGCsLuTS3/PbPADmsvD7IU5YmeHq5/gBwwwlm5P/SULfgoAW2
	Z1SKDntZ+gvTdQCkJTCCgnJu8hiW5EfKXo6j86qc6vHHbwpuX7ZKxH9talFiCWFPrOHtlf
	TmxnRyKUglPMIYxSMExV9LhQzcB2CEQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-z4q9pviePuCHqs-YWwi-Xg-1; Thu, 02 Oct 2025 09:10:38 -0400
X-MC-Unique: z4q9pviePuCHqs-YWwi-Xg-1
X-Mimecast-MFC-AGG-ID: z4q9pviePuCHqs-YWwi-Xg_1759410637
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7e90f268f62so19240146d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759410637; x=1760015437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcEyFaY/aQDfkrlMUauMWUQe7H6acqQfJ7BWFwOP3Qg=;
        b=Pe3d9/L5qQ9zx/GfnlYj9Ugjzt9zEb+2HXqjsPuINOviI2OaT7SAlzlmDjVRd6kmsI
         G/TsPKn4MSaslQaWMBHw/u56kqLN93+WtRWaqHjyjX0mqmbM+Aj9MezJLHRyD/cYzY7+
         klR7mCVIBeE6/ZeKZBaqXOWGmX8DmPGyMNn6PgO7/2EW/VE/GfCGpGSHeYFpkMlfUN95
         b150Haawl1vVz4PdNdj3Y34QEXx2oa7nyugptzzwqj2W5nv5RElxGbohqpOCyb+2M33y
         6s4ysGwjKk/dhCVhkr/4izBKo3JWa2H0Fpva2KcpLhgnkrxwfv7sfBQ2k20MYSlc3bLu
         E93Q==
X-Forwarded-Encrypted: i=1; AJvYcCV40iZFojTjEZyMQHZx5Kq5e9sH8f+Hu9txAp9RMm1wJLYcv2TDgimkr818GtNgP3QtmHcRRRDxyuu7M+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62Lh3LoSLj9y62r71U8YhX1X8havYIfDIH/nyU9O59iuFMhp4
	JxfWY3dnYP3z3qz+kUjQR+/lFdPxysKSIMejl7v5n4ooCnankXJUxpeJ4wVeubJf9mFVtKNDjPe
	vwGoLw55lUYtPlnMa9vU2ILD0EliiuuVfnYh+Z0qPK+Ub/HzUgEwSeW5PdchmeT7Wlw==
X-Gm-Gg: ASbGncu6t3CJSRbqc7ql9BdXtjCcuBRGXwMQgn2foaZN7K4ZPytH/eMWdth694/m/Hr
	UaRJs6NVoimBxK7eKbyGF8Fi6HA8E10ij/WkSYnIo+/wNG24grVCb8wtYfr1t+JZRhceXE3A5pX
	HSkGunN1WXXQxBxHipnnHYKu6U/qsic2k0R0ZhBdoNqOpATvxIYg75fPp5k54BHOvAY0R1Wk0Ye
	x1eRjF7Gwhut1cDsAxB+z6eNm27QoqB5Ut76QKygrNKQdsUtNw4ZV0PdBY/MZyjUmqVoPrgbfm9
	ZTc98gTyhsoQnz/HD4ppo2c0xwJHCoNhaAgtWNS5YQCbZT+PbFh+74amWRiuH3Wu0U+bWGeN3iK
	MG2G9jEyS5C2fe6UZrOc0Mz0Q
X-Received: by 2002:a05:6214:1250:b0:805:b4cb:c97f with SMTP id 6a1803df08f44-8739dbd0712mr99686066d6.27.1759410637328;
        Thu, 02 Oct 2025 06:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGUw2koOvldls4Z6/qT7gVeBzlRA5Y+qPSpIbfXIslJmfNVD01yi+5l7/U4eimA3EdpOMDFQ==
X-Received: by 2002:a05:6214:1250:b0:805:b4cb:c97f with SMTP id 6a1803df08f44-8739dbd0712mr99685066d6.27.1759410636708;
        Thu, 02 Oct 2025 06:10:36 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-6-60.as13285.net. [80.47.6.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf53134sm18453976d6.55.2025.10.02.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:10:35 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:10:31 +0100
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
Subject: Re: [RFC PATCH v3 01/24] sched/deadline: Do not access dl_se->rq
 directly
Message-ID: <aN55xzzO-LplRvIp@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-2-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-2-yurand2000@gmail.com>

Hello,

On 29/09/25 11:21, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Make deadline.c code access the runqueue of a scheduling entity saved in the
> sched_dl_entity data structure. This allows future patches to save different
> runqueues in sched_dl_entity other than the global runqueues.
> 
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---
>  kernel/sched/deadline.c | 27 ++++++++++++++-------------

Nit, I believe there are a couple of dl_se->rq direct usages in fair.c
left after this change. The are outside deadline and they are indeed
modified anyway by next patch. Just for your consideration in case you
want to do something about them from completeness.

...

> @@ -1651,9 +1652,9 @@ void sched_init_dl_servers(void)
>  
>  		WARN_ON(dl_server(dl_se));
>  
> -		dl_server_apply_params(dl_se, runtime, period, 1);
> -
>  		dl_se->dl_server = 1;
> +		WARN_ON(dl_server_apply_params(dl_se, runtime, period, 1));
> +

The move after dl_server is initialized is indeed needed, but maybe we
should mention the small functional change (also the additon of WARN) in
the changelog.

Best,
Juri


