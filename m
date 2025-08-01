Return-Path: <linux-kernel+bounces-753112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB38B17ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE63E7AC670
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D9218584;
	Fri,  1 Aug 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXmYFlUy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6D14F70
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039175; cv=none; b=BOk5MLOuQQxfQtINnv95AqdqCU0xXS1jBN/rvLpdKieIMJY/mbDPaxFWZccH7G/LqjrUfhG6N4IWMZTAQl+HIjld83LZnTf5fwKBJtvbMY+R5Pjy2eLQ3bbrB0d7ryMIiBVGoKLBiY2tFat44mxD0q6nmlqMVm7w2ituutjpTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039175; c=relaxed/simple;
	bh=CoCj0hlnhxMtx48zaAGtk524FDJ1/DuDwggLxXvsSIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dus36S1L8Cgusl21TzWLp1tAEG6Dgjl44+G35nBiKLUY5lGpUdwyf8qsCPfyRrxqvuxihzyH9G/GC4EYWVi2e6XazLQzctwgFWoNysB16o8R2Mi0l5zfjlT874mvhllblS86r1gK4yZIin3MVNX7l9XUUOPGuSdtiVMHBUv+aYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXmYFlUy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754039173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5CR5jl7F0fSUqZEm0AUvx7ezpEgL76Cth4F+ybafT8=;
	b=RXmYFlUy7CEcss8K2oFJU6eN+q8eUIQxDJCh2OWvK3rzo4rkvORBaERX+6O1MsnkNFCcp5
	Akxlekj12g86CDGpfh0nVV351snvMFzt+9NLRvv3rO193NzMqNMgK1srA8Gf7G8Mkq/7yN
	0IOAdutFdl+IeTO/JMLuLyWv225mBYQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-YXxMXbvHO2uoWB1qtknM5w-1; Fri, 01 Aug 2025 05:06:11 -0400
X-MC-Unique: YXxMXbvHO2uoWB1qtknM5w-1
X-Mimecast-MFC-AGG-ID: YXxMXbvHO2uoWB1qtknM5w_1754039170
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so744129f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 02:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039169; x=1754643969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5CR5jl7F0fSUqZEm0AUvx7ezpEgL76Cth4F+ybafT8=;
        b=QnAK+y8fEhcs1+p8xehvGfZpRdvwMtrRGdmSWbUkAAM0HHmq4GdcJt+yafVAqS4k1R
         G+f0MkOgVV+Hw7buq6lGWLNerdJnpXfOkDXszIXtCgDVZiHniyRA4Pi+0KPZQoSHOfdi
         vpmHh0c4M5W6FBNZB2Fk3C06j6ic9w31hYOxH9QhBNSKNdXf68inQiFrq+TWP544yDu0
         /22zHEfv9Q8n8nd5uYrAmfCLCG6rVqfNUEAcKMMn1blNcRGaW2+aKMle1Xj96SmXzP6y
         d+kLXPEV2Rcpw0D/HUKanT89OH14wVuzbozfxgf0HVqWS/v3GmjP7WdX/GGt+sUS6J0o
         JquA==
X-Gm-Message-State: AOJu0YzvPEUPomSBL1DDNgDUloTw80aDbQ/unhJokPSzVUIvt4Pjfnhd
	K3ZLJztUMLFqHqS3gLcxPcIVfv5AtOggMVcDsjk8K950fsjx+mcH2n22TTvH8TS44rpr9r+6B5/
	/KlNxb8RWpvEi2OHI74SKJBMlEjxkx+C67qfkDZya38aLfWb06bY/ZkBI5r9fNgcw4ZSjgAFKiE
	te
X-Gm-Gg: ASbGncsIssqscqKBsDIIG+zmm4AbyPm2/LLqBFrOV/k3uadg/5+kbqJyOD0RIVWo1C4
	cy8W9XApdtoJOWjivmqBhMquTRXmD7V300oj6SiDA6YWDG5NTxS2SezK2JxOwHMMwcnb67gcj4I
	zMEuq8+q86Eu96WNUBWszBpxBaU7nmsz2qHl3e0QMvrwoQ6BDPrxAP3H1CrV3wL58gZwMYfGQBj
	QPrZbWGGLAGCwzSawVtBdc1odQuu/K1u8aDe8MptZh54s0aZEKlhRxCKgFAToQwHNIHBcCpGLNm
	5/bRUKV30fxlRjnhiHnYndq67rq1uhRiIytfAks0K2xOYWWYawb1HhunPnJ6r5y1BdpwHQ==
X-Received: by 2002:a05:6000:24c6:b0:3b7:6828:5f78 with SMTP id ffacd0b85a97d-3b8d343afadmr1682726f8f.4.1754039169093;
        Fri, 01 Aug 2025 02:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTi1Fa9TEH8nqKMEd+slRdcxzYt6awfrK20vVt4LCyIMlXwe2dJepCulZgCynDTlUyIzj2Eg==
X-Received: by 2002:a05:6000:24c6:b0:3b7:6828:5f78 with SMTP id ffacd0b85a97d-3b8d343afadmr1682683f8f.4.1754039168597;
        Fri, 01 Aug 2025 02:06:08 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.46.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a6ff7sm5236741f8f.75.2025.08.01.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:06:07 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:06:06 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: David Haufe <dhaufe@simplextrading.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
 Interrupts on isolcpu/nohz_full cores, performance regression
Message-ID: <aIyDfs1Dh0OGJEgM@jlelli-thinkpadt14gen4.remote.csb>
References: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>
 <aIsUwT1Ai0zcMRpT@jlelli-thinkpadt14gen4.remote.csb>
 <CAKJHwtOZkrR9kEj+tffq=o0i1fPi3P+8BTHz3RyPDmn=uDOF7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKJHwtOZkrR9kEj+tffq=o0i1fPi3P+8BTHz3RyPDmn=uDOF7g@mail.gmail.com>

Hi,

On 31/07/25 12:48, David Haufe wrote:
> Kernel 6.16 shows the issue. /kernel/sched/fair.c calls dl_server_start()
> and there is no assessment prior to that point or later of the
> isolcpu/nohz_full+single-process condition of the core. Same function_graph
> trace generated. Code is the same at tip+sched/core.
> 
> On Thu, Jul 31, 2025 at 2:02 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > Hello,
> >
> > Thanks for the report.
> >
> > On 30/07/25 11:51, David Haufe wrote:
> > > [1.] Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
> > > Interrupts on isolcpu/nohz_full cores, performance regression
> > > [2.] The code for dl_server_timer is causing new IPI/Function Call
> > > Interrupts to fire on isolcpu/nohz_full cores which previously had no
> > > interrupts. When there is a single, SCHED_OTHER process running on an
> > > isolcpu/nohz_full core, dl_server_timer executes on a housekeeping
> > > core. This ultimately invokes add_nr_running() and
> > > sched_update_tick_dependency() and finally tick_nohz_dep_set_cpu().
> > > Setting the single process running on an isolcpu/nohz_full core to
> > > FIFO (rt priority) prevents this new interrupt, as it is not seen as a
> > > fair schedule process anymore. Having to use rt priority is
> > > unnecessary and a regression to prior kernels. Kernel function_graph
> > > trace below showing core 0 (housekeeping) sending the IPI to core 19
> > > (nohz_full, isolcpu, rcu_nocb_poll) which is running a single
> > > SCHED_OTHER process. I believe this has been observed by others.
> > >
> > https://community.clearlinux.org/t/sysjitter-worse-in-kernel-6-12-than-6-6/10206
> >
> > Would you be able to check if the following branch, containing multiple
> > fixes for dl-server, is still affected by the regression?

Apologies, I forgot to share the actual branch. :-/

Could you please test with

https://github.com/jlelli/linux/commits/upstream/fix-dlserver-1/

Among various other fixes, 219a63335b67 ("sched/deadline: Don't count
nr_running twice for dl_server proxy tasks") is making sure we don't
count fair tasks twice, so I am wondering if it can have an effect on
entering nohz_full.

Thanks,
Juri


