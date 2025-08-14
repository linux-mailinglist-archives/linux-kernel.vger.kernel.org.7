Return-Path: <linux-kernel+bounces-768840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DAB26628
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5AA3B207E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506E42DECB7;
	Thu, 14 Aug 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfZ0pfu2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EA5137C2A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176648; cv=none; b=fs0udf78l26OeEzGY3P0Tx2t5PnksKYA0jVQNB1Fm6O1bUPEXTDIQVjdaMrzf6m+jms/buPzkuvJFFgvVelKYBmhcoHW5vIUgwcBevMakWxgTZCFE3NETiH8ltFgZntpPTW/CmgfepNwhtZicF4nigKg2k5mJg0+nbSyr9GAw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176648; c=relaxed/simple;
	bh=XDMFofL/ZP+EZgUdbtY7LRNhMrtxctJoamKPrRrxzSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuxTv6ATg6A9MFdv495niYZG0+d1fQh4ezr5xETyfvykUOo1GbYlLKBPfStBSb6yhjVCwAyCbBEpkRLqgV0PkB8aoA/7Ah1pZ4TJdrsJ620oeHr2PVQswH7wNMNij/gf4LnG2WAL1YTIizrMvgcKt6p2iIhqi6dKydpalL9gtI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfZ0pfu2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755176646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXcQKajmOZ+POA5c103w3K1rHzObe51yOGTIjJ504N4=;
	b=XfZ0pfu2ha0oLe7mBVRe08UKK/5lbtiivp/Ba3fTlcsr/TC0zx7H+0ii0lXVWiFJiJOwAL
	S3OvCuMF3wUy0uqL1tdZ8+UyAf+/wcbPh0b52wdVgcTf/IJJfCJn5qbMTMWWnvmxLp3q36
	F+sISZN6N/jsjlWDvb6jV2xoSL8/lFE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ny5ckux1O3G_6LqnG9r-Cw-1; Thu, 14 Aug 2025 09:04:04 -0400
X-MC-Unique: ny5ckux1O3G_6LqnG9r-Cw-1
X-Mimecast-MFC-AGG-ID: ny5ckux1O3G_6LqnG9r-Cw_1755176644
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e87068f8afso221511885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176644; x=1755781444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXcQKajmOZ+POA5c103w3K1rHzObe51yOGTIjJ504N4=;
        b=EcNzkF74bEbvqO3JiJR7HYEJ712kRCLSkNF6MDDDCFSsXGolfBMO5XqJ8VKlQUzgJj
         th8Lus0YgVeabG2kMHyDHTP6k+2h7qhJ/1n5rpnOQ8H+xL4kao+FwOJrDt/v9vI8nuU+
         UGmOSJ9a6566WBZ4BCKb8Vltc3xng4ir6TVqboGflJl1rBXP7jY58Uk/MRmQOYSrOE08
         aQMnc5Z3WQdzieBAIJZ5+lpw8dbegZFnbvrrfTBKeOb2713l4hc4/BsMhb4EJlFM4/bB
         8DI0KaRs+XKdOOQqDcH8M4pSR5H97pPoVEKWzHD014Y7JBTBWSnoTbSIPZh1joYuYhFk
         +Fng==
X-Forwarded-Encrypted: i=1; AJvYcCU6w9lccDyYHmRkzxsDAZKDllovYAJ1Ooy1x0pf5yDTrTCb8VvSJdldyfheIKsMPogvOLIftmZb6TlB0zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl42ZaLg3MHMSrNesHFP4DARFizszPYVHQeWxq4z6QILQw17r6
	kYIq3XNAoJIbeqMvUK/pOd8u6ma5hpWWGWFJcS3dyaUyp00av3v+Py1u8vPLQTHEDSVtlsnFmLC
	croUF9a378q8/dI8wNkpp17CoxrukhvDowYdRkoa2uO+EPqYaJv/AAs/QfXOvtSLFkA==
X-Gm-Gg: ASbGnct185TvB3fcT3qILsdhQQVFkWxwch/Em5x+H25i8nvelK6vwT6LDbdxJQlosew
	3yjUb487swWqCbn/PoiXNNbRz8/fMNJ2pEHBvf+0vWkIFnSjAifZ91ugswe4+LOSbzm4/rKldV+
	l3EiIDV7RvTgoTZSYZL5QpCtWko7cUDyeINem5rljGGEsTEXWvFO2bcp60tUQX44fBPqlwAe94g
	xUopxinVPpZwQcvnygVEL9TOEmOEIg5IeROIU1n3vsoH6NP/YdsePzbbW3KlQURU5KGOCHHpzvo
	IL1k0VhmPRTLPSORqUelG37RYVQlQrG82nHrq70JqdfuPeJOVHDaUQKvP2EfPn3uQN0p2Q==
X-Received: by 2002:a05:620a:7088:b0:7e8:74d:fdf0 with SMTP id af79cd13be357-7e87053f48amr460084885a.41.1755176643930;
        Thu, 14 Aug 2025 06:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1IV0lzhHFhPKLnr0t0pznjeDtcyjyN5YLRlf/+Pm6NMcKaJsLiHjGfMOHUnMcw9+py5/7Eg==
X-Received: by 2002:a05:620a:7088:b0:7e8:74d:fdf0 with SMTP id af79cd13be357-7e87053f48amr460075685a.41.1755176643243;
        Thu, 14 Aug 2025 06:04:03 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.62.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085586307sm137837751cf.56.2025.08.14.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:04:02 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:03:56 +0200
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
Subject: Re: [RFC PATCH v2 08/25] sched/deadline: Account rt-cgroups
 bandwidth in deadline tasks schedulability tests.
Message-ID: <aJ3evCuoSV83FCx8@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-9-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-9-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Account the rt-cgroups hierarchy's reserved bandwidth in the schedulability
> test of deadline entities. This mechanism allows to completely reserve portion
> of the rt-bandwidth to rt-cgroups even if they do not use all of it.
> 
> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---

I wonder if, from a series flow perspective, would make sense to move
this one and the following after the changes that deal with groups
initialization. Also, please consider a little bit of squashing.

Thanks,
Juri


