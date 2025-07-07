Return-Path: <linux-kernel+bounces-720629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E547FAFBE76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3BB1AA6EA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C448202997;
	Mon,  7 Jul 2025 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD8A3XBb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDF1C7017
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929318; cv=none; b=R7tcFTbvF4O/48tFKz5Db8c2e266We9z6mAK5VOG/9F1rgiRiriqwrGZvsWXtQYF9MtkGfjr48f70A0/No+AeX+rk4k2HIgnNYBlYYF4HIR9DJfr8woR4ez//SEvuZ4sOIrUJ+9mk800WdxrjoHrPPW2/2XCdrHZ88K8aT/oXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929318; c=relaxed/simple;
	bh=NWYb7kg+EA4vnGJkD3NDmjxjBhDX0fH9qxctiLPwwYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k44tbNyQ4AjjuzC3QJT8cbrEpP8JrU7NsPsXRLpJ40LfCcMaNQYYyRWxZDMHZp5hRvN5NMHQlbRhmT1DZCDlvSTxn0GMcGTDVtpCVgkgCcEpWWTRf1WFnYVVpbYNCUgPGqGF0SZovL7VZ41AF89sNuEg9KQ7AA2ZHYuu5jpSNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD8A3XBb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751929315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FaIN382YiD4f3jvKxJ4HgwgyNOYIw2HApGPlci5B5LM=;
	b=PD8A3XBbz67I0D3tDC2Rquqm9JKlcYI4G8Bv7az3Ab/RWzVVMWkqQF0dx4+ROKMV4pg1kg
	UJO/31hZidGEiJ7W+4ZHnaWsbVSoPIdzlUOVuP99muIJfzXXMD9E/oo/K7BH0z+b8ASxqq
	ogn03WoYqTZwtzx8SlfWxvjBGZYr2U4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-xatfKZ5RNHq-N4pg3m2qtg-1; Mon,
 07 Jul 2025 19:01:53 -0400
X-MC-Unique: xatfKZ5RNHq-N4pg3m2qtg-1
X-Mimecast-MFC-AGG-ID: xatfKZ5RNHq-N4pg3m2qtg_1751929311
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E88AF180028A;
	Mon,  7 Jul 2025 23:01:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D1EDA19560AD;
	Mon,  7 Jul 2025 23:01:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  8 Jul 2025 01:01:03 +0200 (CEST)
Date: Tue, 8 Jul 2025 01:00:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Li,Rongqing" <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>
Subject: Re: divide error in x86 and cputime
Message-ID: <20250707230057.GC15787@redhat.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
 <20250707220937.GA15787@redhat.com>
 <20250707182056.66a8468a@gandalf.local.home>
 <20250707183331.029570bf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707183331.029570bf@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/07, Steven Rostedt wrote:
>
> On Mon, 7 Jul 2025 18:20:56 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > I would say this should never happen and if it does, let the kernel crash.
>
> >> [78250815.703852] CPU: 127 PID: 83435 Comm: killall Kdump: loaded Tainted: P           OE K   5.10.0 #1
>
> This happened on a 5.10 kernel with a proprietary module loaded, so
> honestly, if it can't be reproduced on a newer kernel without any
> proprietary modules loaded, I say we don't worry about it.

Yes, agreed, see my reply to myself.

Oleg.

> I also don't by the utime + stime overflowing a 64bit number.
>
>   2^64 / 2 = 2^63 = 9223372036854775808
>
> That would be:
>
>                                    minutes    days
>                                       v        v
>   9223372036854775808 / 1000000000 / 60 / 60 / 24 / 365.25 = 292.27
>                            ^               ^         ^
>                         ns -> sec       hours       years
>
> So the report says they have threads running for a very long time, it would
> still be 292 years of run time!
>
> -- Steve
>


