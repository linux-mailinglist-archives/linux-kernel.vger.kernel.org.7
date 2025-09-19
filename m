Return-Path: <linux-kernel+bounces-824732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE38B8A034
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751543A72D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4430F7E3;
	Fri, 19 Sep 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYqQ5NKH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1224DCEB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292740; cv=none; b=btgRqoOo2rjsiJNcjb4sTh+8wzJwBjRAJhcPAP/4NLA7Eq153sLUwwk3+Vx+uU19L3rnvGFv67qebWuLkU5gpsPkzwZriEAIybw9/3w58ZS6tJoiFqTcbYzp3p8+V6oZ/VeGuD+0Sgf0dhPCTrp9n+xsjPnxWmFt4ygJZzz4vn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292740; c=relaxed/simple;
	bh=Twjh4NWtzDitJHfSj2GicBAFkIVmXgC0lCrmTo7kGxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2PtwNG5LoVmygMAFXPWKOtBx0plp/SbTCdFu+l8eK5B7Cay9XPCTzKEcU5O0x/jlayw/4Fa5UYv/PGFGOBIyekiMO5QJc6P06AE1RrEPXUGTFzpGRmO7cKf92/kLe7cJlvMQo7N1IhwJEmKLf68gUGZIRIwWw2/YlnJo4vemNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYqQ5NKH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758292737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Twjh4NWtzDitJHfSj2GicBAFkIVmXgC0lCrmTo7kGxM=;
	b=hYqQ5NKHwXTB0sVDSewGzO6a2J1+JEEN2YpPQhSLXoSIWG6Qxl+aNEA+GfMeOX2u8BVsf2
	IjNj1BwnOyFEtPMDdJ0DOVz0xy3L2xFbECyrMHGPJZrc9GiTFzPU19d9sZeWx8gfQpFl2u
	HYQl7IXGk2kaQHlZgiNLzuC2HHMQZDI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-_Vo2jkpDN7epohAHSgfejg-1; Fri,
 19 Sep 2025 10:38:54 -0400
X-MC-Unique: _Vo2jkpDN7epohAHSgfejg-1
X-Mimecast-MFC-AGG-ID: _Vo2jkpDN7epohAHSgfejg_1758292733
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3146819560B7;
	Fri, 19 Sep 2025 14:38:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AF7B419560BB;
	Fri, 19 Sep 2025 14:38:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 19 Sep 2025 16:37:29 +0200 (CEST)
Date: Fri, 19 Sep 2025 16:37:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Matt Fleming <mfleming@cloudflare.com>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>,
	kernel-team <kernel-team@cloudflare.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: Debugging lost task in wait_task_inactive() when delivering
 signal (6.12)
Message-ID: <20250919143611.GA22933@redhat.com>
References: <CAGis_TWyhciem6bPzR98ysj1+gOVPHRGqSUNiiyvS1RnEidExw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGis_TWyhciem6bPzR98ysj1+gOVPHRGqSUNiiyvS1RnEidExw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Matt,

On 09/19, Matt Fleming wrote:
>
> Hi there,
>
> We're running into an intermittent issue where tasks end up in a state with
> p->on_rq=1 and p->se.on_rq=0 when delivering a fatal signal to a thread
> group. The thread handling the signal sits in wait_task_inactive() after
> sending a SIGKILL to all other threads, most of which pass through
> coredump_task_exit() just fine, but occasionally one thread calls into
> coredump_task_exit()->schedule() and never comes back because of the above
> state.

I guess you mean coredump_wait() -> wait_task_inactive() ... Sorry I have no
clue at least right now... And I don't see any problem in coredump_task_exit().

Stupid question. Any chance you can reproduce, figure out the pid of that
sub-thread which fools wait_task_inactive() and, say, do
"cat /proc/pid-of-that-thread/stack" ? Or any other info, everything can
help. Crash dump? Yes, you have already mentioned this is hard-to-reproduce :(

Oleg.


