Return-Path: <linux-kernel+bounces-819363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F97B59F56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499872A4F49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C743275B12;
	Tue, 16 Sep 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iX7UzgJd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C623643E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043969; cv=none; b=OKAGiRvO4LXiYkcho6fs55AK51o0I3jhdnkmRhTlgrtuDy5+IRIz69PTwRUyYhuW7McL5mHKQlhmeeHEkaYXlbsJLnAB3jseAC/xKC1dck9IbegXRlSItBZHRG3v9bzbgmrIuTSwPpmZhMJCfqcWB5sSoQ3aOSmtHwA46JKQV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043969; c=relaxed/simple;
	bh=kvopPC7wISmXLcWTRs/go7M7k5Lq06iltnjWMRGhK44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OytJMhpcGV2kb1ThhfpNjqvzZ8mRqSq1rGiSIzhYsr16PkWqtDPpEEQDwurjgMdfbtw0pxhqxUHHDRqkHQyHn5EW9/J8c7coQSayLDoIXn4m7P/eKfBMIEbAkOsynJd/DxNanx5q5jWocNQFcTmPt4Kp/9v0ApM3qlj/b2QaHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iX7UzgJd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758043966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDkWoJJ7psiuI5a12l9ncax2PPOR6bXl5QNfeCRZ83c=;
	b=iX7UzgJdX/Su936gPEF7Gg+ERkyX4qtOhL8QYn83U9trE5ZFXoyz3df3CqaYFrDVqp9ykt
	Asb6b2JUWQXbzjF6ee/c4I5brlk3yLbkyyaL+oUsOZDWs/ZoQhLwVylTGEWB+yRo1Kj6wG
	PS8gKkgcIQmhmB+41TfG4IzPH29xKTU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-vcsFJqZYMommlTNKV2knHA-1; Tue,
 16 Sep 2025 13:32:42 -0400
X-MC-Unique: vcsFJqZYMommlTNKV2knHA-1
X-Mimecast-MFC-AGG-ID: vcsFJqZYMommlTNKV2knHA_1758043961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66AA019560B5;
	Tue, 16 Sep 2025 17:32:40 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.65.67])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0D8B195608E;
	Tue, 16 Sep 2025 17:32:36 +0000 (UTC)
Date: Tue, 16 Sep 2025 13:32:34 -0400
From: Phil Auld <pauld@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, shashank.mahadasyam@sony.com,
	longman@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <20250916173234.GB5293@pauld.westford.csb>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
 <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
 <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>
 <3emv4bx2o7mdv7oc72ffdinlltqohqjt5nxgccdiyw47xjgbww@drvkcpiy5zq5>
 <ziakoghx6xbfvcocc5kcrcw5gv4xlphto44bptadkfbbtyf6op@d2fvj7rbec26>
 <20250916170735.GA5293@pauld.westford.csb>
 <ttgdkklsa3dsni2i2yy2vf4qmu7vfwlwnkl3qpprikgb62li7u@5vcwgd3vgt46>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ttgdkklsa3dsni2i2yy2vf4qmu7vfwlwnkl3qpprikgb62li7u@5vcwgd3vgt46>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Sep 16, 2025 at 01:23:36PM -0400 Aaron Tomlin wrote:
> On Tue, Sep 16, 2025 at 01:07:35PM -0400, Phil Auld wrote:
> >  CONFIG_RT_GROUP_SCHED is not enabled in RHEL9 and later.  It was on in
> >  RHEL8 which also defaulted to cgroupv1.
> 
> Hi Phil,
> 
> Sorry about that! It is only enabled on RHEL 8. I can see under
> redhat/configs/kernel-5.14.0-x86_64.config it is indeed disabled.
> 
>

Hi Aaron, No need to apologize.  I just wanted to clarify :)


CHeers,
Phil


> Kind regards,
> -- 
> Aaron Tomlin
> 

-- 


