Return-Path: <linux-kernel+bounces-755344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C87E2B1A536
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD2B166833
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5251EA7E9;
	Mon,  4 Aug 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvNcf/1/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99805367
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318961; cv=none; b=qswEig3JdowGU2QTa63KClaaev2LvJoz2ZzfU2k/zwJECGxCg30xdB8LUgGjjKgTTOuvmqXqapV5/eB1AEIqWUeeDGnLo240zC6WLlMElKtttAoWPq43VM/bthHfrLSs3QKshnL6BSwp3cniWjoYq201lZYsuCseCceDos+CISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318961; c=relaxed/simple;
	bh=ilOcd2IVHzgU1pjhqsBGp0wZ8Cjcl5fXO5qbZf0hL6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4IWGFH7rKGCYWX38ZLyMcwjw0gyDxRW02ghpl68yJgW4Ql/Se2DpRgyksu3vGw2XWnw2ufW2BMqX6HWzWHEhHCHIX5UUIbbM4JljDy5kKGKw7eOVeVG+Ab3w6u6hiAU0chcvKE1y5eL7XEyJN92zYubwphjYI7lagND+vfLVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvNcf/1/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754318956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ilOcd2IVHzgU1pjhqsBGp0wZ8Cjcl5fXO5qbZf0hL6Q=;
	b=AvNcf/1/rk2EiGGifSdGIWTm5C49kpTpi8Xcx/vRsVZx372E50lgSG65pE6mRPinF0Fw3V
	jBdJgmeh5YbiwYlHwarhAE062FrevkZhbnlLq/ofP114MpE64TfCAIWGgZwXIlHMOXihxe
	6oJb0p+iv/StcLD0ZXxlHNgFEaMvO2Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-MbBKYyK9P1GQiwVfVoNhTw-1; Mon, 04 Aug 2025 10:49:14 -0400
X-MC-Unique: MbBKYyK9P1GQiwVfVoNhTw-1
X-Mimecast-MFC-AGG-ID: MbBKYyK9P1GQiwVfVoNhTw_1754318954
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073b4fb53eso82423546d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318953; x=1754923753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilOcd2IVHzgU1pjhqsBGp0wZ8Cjcl5fXO5qbZf0hL6Q=;
        b=tck3xfxpbcplsiZbq9+4BjCgpwIOq0CMfLQYoMsV0w4gUYOChB7hz9mBavSUyQnJK/
         HFkb65B1qVVcI46EIWUaEO+nxtGZu7I61EkY7zLqcWK84i/iy2/X3Fm58eBkypZ/gSWo
         mZByApppVWtW3QhjHw7TUH//qscKQmgd1VyNVzabQZPHkcAOmb2NMdikhtKvHNYOO4K0
         mWgwyTC+SxCe6oZ2ogHlgpFXpiRs4zmRO6+SNYhYUOml6w2szuzKN+uQJeDzLsW07/Lh
         FXlGc6HJFx/SpJ7WYAlZWLesuzm94eCI7tf8H+DLT/3ENQtPTOQ8bOPyfLWNJ8HilIrj
         PhXw==
X-Gm-Message-State: AOJu0Yx3B65d/ZianUtMeeC6wVC0lavJbAzoFIAPAGysCEVFli3QbId5
	FNqmHg3H98gIK8XcUDLl7h5axWRCRh9qoggGTfNWQ4zyxxWcDb8Iyc4FnidtPUUlVrT+yLGKqIw
	4ejPPxGPTdUhva0i8Wolpnm7qZYkEHWbBFK43a0KYUyDLvE721EYzi0N/xbu6C7IrhVjTiZRYYc
	wXDno=
X-Gm-Gg: ASbGncvksF9HabjWbvxh4v1q0UQP4VKZ1alNV0xKD0+m0DrE0Vkxb8d/L67Qwk0mAAY
	uhA1VKM+gsDbb7F2OFL7TBQtVcOr5lP3SRtDNghiLm/tVlytA7RhkcK+vYN7lAqQiBfPDrcErKE
	TZ9Kx6MUeWh4PKLug+FdfFp28Yabf78q/Vi45jGUZthex36HPIhVoIAcwzzBn9cQDjPzXlgtUgU
	KhocY37vpazGZqN4aIwQ2jNb0GAIb71Gr82mcHCzlYa5iHsIi1ZDdQzDGVe3yD/1XvJiKjkQ+pf
	oZ85T5uaZbcCbcTgOqpNb/tFikWBCDzdw+rZ4wvGbZUJ6JwrPlHCkXfC2WqweOPILuTuQI2CVWK
	DLYw8tqSXB1SRqkImGI/RpTA=
X-Received: by 2002:a05:6214:2626:b0:707:4b37:f6c5 with SMTP id 6a1803df08f44-709362fdd09mr139912906d6.35.1754318953115;
        Mon, 04 Aug 2025 07:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLt921hdgWfPbIL2QUEMOiQgoAa0QUEsCVzTXk7EiyPLQBWvdQoFG4m7h9clf2PMRB9cAYFg==
X-Received: by 2002:a05:6214:2626:b0:707:4b37:f6c5 with SMTP id 6a1803df08f44-709362fdd09mr139912326d6.35.1754318952437;
        Mon, 04 Aug 2025 07:49:12 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-151.as13285.net. [2.102.14.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde6062sm58919146d6.71.2025.08.04.07.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:49:11 -0700 (PDT)
Date: Mon, 4 Aug 2025 15:49:08 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: David Haufe <dhaufe@simplextrading.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
 Interrupts on isolcpu/nohz_full cores, performance regression
Message-ID: <aJDIZNyoehnzIqS2@jlelli-thinkpadt14gen4.remote.csb>
References: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>
 <aIsUwT1Ai0zcMRpT@jlelli-thinkpadt14gen4.remote.csb>
 <CAKJHwtOZkrR9kEj+tffq=o0i1fPi3P+8BTHz3RyPDmn=uDOF7g@mail.gmail.com>
 <aIyDfs1Dh0OGJEgM@jlelli-thinkpadt14gen4.remote.csb>
 <CAKJHwtOdiFTenF=zCL7_8c148Qs37r53k9uAKURLjq1JFJGeXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKJHwtOdiFTenF=zCL7_8c148Qs37r53k9uAKURLjq1JFJGeXg@mail.gmail.com>

On 01/08/25 10:28, David Haufe wrote:
> I am sorry, but we cannot get this branch to boot on our hardware.
> Looking through the code of the branch, it will not address the issue.
> I believe the issue is more fundamental. In
> fair.c->enqueue_task_fair(), dl_server_start() is called when the
> single fair/SCHED_OTHER task is added to the isolcpu/nohz_full core.
> The check here is simply checking if there is 1 or more process and
> kicks off the dl_server_start() and the housekeeping timer in
> start_dl_timer(). Once this timer is running, it will invoke
> dl_server_timer() continuously. This timer calls __enqueue_dl_entity()
> and then inc_dl_tasks(). inc_dl_tasks() increments
> dl_rq->dl_nr_running++ and invokes add_nr_running(). This code will
> eventually call the sched_can_stop_tick() function but
> rq->dl.dl_nr_running now != 0, so this function will always return
> false. Something needs to be done to prevent this timer from running
> in the first place, or maybe have some checks around single
> "fair/SCHED_OTHER/etc" process running on an isolcpu/nohz_full core
> which prevents the need for the deadline code to run for the core.

The fix commit I mentioned should at least make entering nohz_full work
again even when the dl_server is active (but deferred). We still have
the 1 dl_server_timer firing each second (after recent additional fix by
Peter), though. At least this is what I am seeing at my end.

Will try to see if we can remove that periodic timer once nohz_full mode
is entered.

Thanks,
Juri


