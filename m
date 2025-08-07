Return-Path: <linux-kernel+bounces-759129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45623B1D8E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA85B726D92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0225A320;
	Thu,  7 Aug 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKiCcbvW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A41136E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573021; cv=none; b=m7YuChEM2X7IjMWIbCwiGi+OpiDmqAxpTa1Mdo6chqtkntYwUnYQokssw7ib75No1KivaIvInmNmZMneW6PZWkD3XOuTGLRXQ/Ss9GzVFDxFsTTAmgVNpfpitNfYenQ805X05oGGSsnnhSLaW0iUWRKlDsu0K/lvK+7oKe6qWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573021; c=relaxed/simple;
	bh=taABECypNKPTf7vtV3e8Ce9Y9Pvl37xuy09CDO++jWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmjWiH0gnPcHLS8SKn1uG/SoCVGI1bNmo94Ww8wJ17RO7qNoF/t3V4Q40dPqIlIFE4ZhPu8MEJ7abOpF9SiBBlw7z/qbunSTT1csRx2A6G/0e7G7mNPrQecGZ5bnmsPmtm0mWA61bIyu/ZY+lo3+aHvCiOL+95jQ53UmjYBQWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKiCcbvW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754573018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHA46DuTY9pFuv3EKrWijSQmC2yks3Je0CkaUrfoHJU=;
	b=IKiCcbvWfpXKRHFMSX4zua9l+mOHQna50VO2bNx5yjF6zk1nlPl120t4ZLKQvS3oCRLgo1
	3KnL8o0Ro9zfTdKFbLulGIZ7AnGgMpYYBIdrpPgVTelaKM5k508M2CjVdzQj+pwOSOonWg
	+W4+RPK1MAncokoTD5yQynHFDtTX2G4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-q0JOzZgmNtmZTLnwb5lKKg-1; Thu, 07 Aug 2025 09:23:37 -0400
X-MC-Unique: q0JOzZgmNtmZTLnwb5lKKg-1
X-Mimecast-MFC-AGG-ID: q0JOzZgmNtmZTLnwb5lKKg_1754573016
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7812e887aso401171f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573016; x=1755177816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHA46DuTY9pFuv3EKrWijSQmC2yks3Je0CkaUrfoHJU=;
        b=c7MqJBwYrhA8fUpxhnuDP9bKPSJAF1jPDONz6P6CGK4ktTYP4JjK1eM6cl1yYX91Rt
         KSg9h0buPUgsythQjTb7j4nRd/PeL/wCJxJg5RHV/h42hw7c1ok778HF7CUmALlPOV8T
         GdxrkOATe9ItptsUsfShUAs0j7J8/sfFd3+IDhYYNalXq9pDbfW9ZHnNL7nsjSnbCtsx
         XWeNFlMPhbtlHvG0nco1qUQYYIu0mpuWFueI2qVgPLqEqdAOzTEV0Q0ZEYX+kExIqajJ
         JE6HHFR6so1V10D5zz9Txy9n5Q4wsiSlDAD0LUfPXlKI3urkmBOapS8DFCTFzxGgTD4W
         IdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxnHGcq+/8gm0EuGtpd12Oh7qJ6g5Y+QGMr7iNNdKnwe/M7Mig6H8mdGWzqLZtuxx354I0EnsODjewy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvstKNjnYNfL/v6fYFz3fKj2bPtaeOrO+neuYP+9IuaqzxMKhe
	SdkevDEh5Ei6spAIrRPiHhrRJqGvKM6evA2SouwuEgk2Qw+1Ss1iDrcOR6TQSlPLy8b+QJR+8W3
	NVR3YjII1/gQVHwPmFnrr2I558DcYlKZhhUnpERpEwtP31mB7EIFCnmfXwkRPEsKHxg==
X-Gm-Gg: ASbGncvGHaQJqFaGRYNaP+t+06dQ5pbUZz7yGvwJHJmuFq1Un+g/DLz/8BLpRZv01Jo
	9t10FberZvSq8J9tDXOHO7lHscUitEGAQ7ExeynyBOYLVC6U8zJ0KeXLOULjzx2LJ02lPbZCs50
	lE/5UO0ijPfy1Cpc1WnsdDWzLJjF5ypMApQM5UgaqTL0QaOP0fuF6yre9rvhxRv+4sUPxo59ff5
	kgiVQDmA+Y4u2vY6zgqMppMkf9Lhqit25bNP7LSwRmyjH7RRlTIcWPaHpK1xgdrA68+9xwpB7uQ
	p3V8NmZf59aIe56mysHRCAToqI/H9SmDmQt+YmsD5kNA7QOR4LC8rrTPUCG+vKZsFNDz5A1EaEB
	KsvvUBtj5BqQWU4PWrGzNYQU=
X-Received: by 2002:a05:6000:18a9:b0:3b4:9721:2b32 with SMTP id ffacd0b85a97d-3b8f48d4f26mr5474486f8f.10.1754573016386;
        Thu, 07 Aug 2025 06:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK7RPK/BHk+aiKWpB1FOVkMIFKk4URmY7R5cJde+3vREbiJsn51qHzJTF0lGZx3w/Ix4ugKQ==
X-Received: by 2002:a05:6000:18a9:b0:3b4:9721:2b32 with SMTP id ffacd0b85a97d-3b8f48d4f26mr5474465f8f.10.1754573015962;
        Thu, 07 Aug 2025 06:23:35 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-151.as13285.net. [2.102.14.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c33fesm27226884f8f.29.2025.08.07.06.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:23:35 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:23:33 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Kuyo Chang <kuyo.chang@mediatek.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] sched/deadline: Add DL server activated message
Message-ID: <aJSo1bvZ54Kl_vKb@jlelli-thinkpadt14gen4.remote.csb>
References: <20250805155347.1693676-1-kuyo.chang@mediatek.com>
 <aJRSmWCJI-GlApsR@jlelli-thinkpadt14gen4.remote.csb>
 <9f91f77e5f39857aa84373fe1ae504de2a881533.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f91f77e5f39857aa84373fe1ae504de2a881533.camel@mediatek.com>

On 07/08/25 15:52, Kuyo Chang wrote:
> On Thu, 2025-08-07 at 08:15 +0100, Juri Lelli wrote:
> > 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > Hi,
> > 
> > On 05/08/25 23:53, Kuyo Chang wrote:
> > > From: kuyo chang <kuyo.chang@mediatek.com>
> > > 
> > > The DL server is introduced as a replacement for realtime
> > > throttling.
> > > When RT throttling is activated, a message
> > > "sched: RT throttling activated" is shown. However, it is currently
> > > difficult for users to know when the DL server is activated.
> > > 
> > > This patch adds a similar message to indicate when the DL server
> > > is activated, which helps users debug RT/CFS contention issues.
> > > 
> > > Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> > > ---
> > >  kernel/sched/deadline.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index e2d51f4306b3..8e0de6cdb980 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -2042,6 +2042,9 @@ enqueue_dl_entity(struct sched_dl_entity
> > > *dl_se, int flags)
> > >       }
> > > 
> > >       __enqueue_dl_entity(dl_se);
> > > +
> > > +     if (dl_server(dl_se))
> > > +             printk_deferred_once("sched: dl_server activated\n");
> > >  }
> > 
> > Not sure if we want/need this, but, if we do, I believe
> > fair_server_pick_task() might be a better place to put it, as it's
> > really when the dl-server is called to do its job.
> > 
> 
> Thanks for your suggestion, maybe the minor patch as below
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e2d51f4306b3..82d1091e56f5 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2395,6 +2395,7 @@ static struct task_struct *__pick_task_dl(struct
> rq *rq)
>  			goto again;
>  		}
>  		rq->dl_server = dl_se;
> +		printk_deferred_once("sched: dl_server activated\n");

Guess it could work. If we are going to add this, maybe printing
information about the task dl-server is servicing might also be
interesting.


