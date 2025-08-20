Return-Path: <linux-kernel+bounces-776881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5847B2D280
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9294058760D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8CB275AF5;
	Wed, 20 Aug 2025 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="jtrroeHd"
Received: from purple.birch.relay.mailchannels.net (purple.birch.relay.mailchannels.net [23.83.209.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64E258EF6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.150
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659906; cv=pass; b=r8hLWYkCX2F9D3I02oGrWabN6vk6+WkPM8B7E7KqawBguWytuvhwUMOBJ3A4PxoOOmJSL9jTkbBcAHWOZKjhpSkWI4YyC0QTE9brh74VQ+cbcYwlgVSZQvN2GSGUD8PhLcjeIaquxRCha0zPZF13t16lmFGaLnAmRSBBMx5Q4bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659906; c=relaxed/simple;
	bh=iZir/QKK5JTqAfdGmgVb/hXLInesr/tGQLazPkNll88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG2GFla0THBLAceDfk5N1gMiu7e9hiTwsDbZ6uek8gXdOj87DVl28kHW/B0Foa9IOPIsc6olAF4DGpghLtGVCW5sUuVCaFsDPCxMX2dDWa5oZSCoo9/IKpmpDGd3/HGBl2LhzhV/85pre9p83BErLqDZFFysmbZazuP2S3uOJvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=jtrroeHd; arc=pass smtp.client-ip=23.83.209.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EE20D8A5ED9;
	Wed, 20 Aug 2025 02:53:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (trex-blue-2.trex.outbound.svc.cluster.local [100.96.24.204])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6EF568A5E79;
	Wed, 20 Aug 2025 02:53:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755658392; a=rsa-sha256;
	cv=none;
	b=XM2faQq9OTuEJNEwo04eH/6Axi/dDX1xJkrb4oZd18HuWF/dAX7RdXuxBUajph4KMjxTcG
	ui9p8wnRxnxtw+r/exFpowMerR9Ebos7KUM28IGGCnoXpAfUBS5IfkzKRx+4ctRrveBsXB
	mJPzRgNZT+ZC7SjixaChUPNuqNhZcdNM1J8XYDWTd09m/aoZc9BOnDZ3fscnPW+rDnGF10
	DcNzJhauhnxBPLh7SLmFD170HEydxeReyuLQZo8jd34vK4GnibIb83uj21q+JdSgPLjZVJ
	5G2K3tT8VGS59WnUJPnT6Ld0fqtze0rcQJABG+ha/0DRZZJqHcFHZBqzlfERXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755658392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iZir/QKK5JTqAfdGmgVb/hXLInesr/tGQLazPkNll88=;
	b=R6IWtoToKQz1gB8/I4CawnjzuMUDAbmbUdZypQY7XQHBFp60oc8E4Y7P/dlMmi3PHZ+5MI
	92ZuRDoRsrj860fBbnbrs3klsmqo6OsDHQABapRV3iTt9PKQXGXiwnzmpXwCWTceghI/dS
	7txFbg/Iv6546g1H925RGBSHGkHaTDivEGEe7oeQh7lVTRHcZD7V3Z5x5iHNnj/ZetsTvQ
	tlKqD6TKDpHOq3Qn2pDeRWALg5L5110kWXH1AX68vApbcRshK1nq12Y5IhcII7e46G/6Yv
	sk9YutHO+/VhxjqMW15l0FTfzxEVv7fIwQ1JDST6NLJOYtIIe3EowNQDEJvq0g==
ARC-Authentication-Results: i=1;
	rspamd-7dcc9cf4b4-dlnc4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Bitter: 24cbe2cf071be96f_1755658392800_1249402012
X-MC-Loop-Signature: 1755658392800:1048781
X-MC-Ingress-Time: 1755658392800
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.24.204 (trex/7.1.3);
	Wed, 20 Aug 2025 02:53:12 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4c69xM30YWzFG;
	Tue, 19 Aug 2025 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1755658392;
	bh=iZir/QKK5JTqAfdGmgVb/hXLInesr/tGQLazPkNll88=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=jtrroeHdkHuJtsqb5l11kvf1MI9vMHXSmzA44PUngxs/RwGTt4cGZSAvff5GR+dvm
	 qhNeuI0ZNVn0oimGsMDmMMHhTd9hIHDPomPJjVHJFLe8MdtSSMIRhS7OiAW8SN4eGP
	 DsqRBGt6MtWDWPc7dGFjAO1exLJ4MBOy2SB9POuEBvqkpdFRKIQlRjQ9QfBRiJYPDX
	 ghHEi85tmIyqQK5NbHDoRbgVJYNaCIXho3a+xjphr1Z1S86DbPx0D70+9fVj73zujo
	 e5jwSxu81ikpAoBx7AT9kUcMcFRAsY3WXPhGjHeva9aw9mCv3QuAtdEcIgiKY5olGR
	 sovbvoUeJ/wPQ==
Date: Tue, 19 Aug 2025 19:53:08 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Michal Hocko <mhocko@suse.com>
Cc: zhongjinji <zhongjinji@honor.com>, akpm@linux-foundation.org,
	andrealmeid@igalia.com, dvhart@infradead.org, feng.han@honor.com,
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, liulu.liu@honor.com, mingo@redhat.com,
	npache@redhat.com, peterz@infradead.org, rientjes@google.com,
	shakeel.butt@linux.dev, tglx@linutronix.de
Subject: Re: [PATCH v4 2/3] mm/oom_kill: Only delay OOM reaper for processes
 using robust futexes
Message-ID: <20250820025308.rkqlvauh4dz42oic@offworld>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>,
	zhongjinji <zhongjinji@honor.com>, akpm@linux-foundation.org,
	andrealmeid@igalia.com, dvhart@infradead.org, feng.han@honor.com,
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, liulu.liu@honor.com, mingo@redhat.com,
	npache@redhat.com, peterz@infradead.org, rientjes@google.com,
	shakeel.butt@linux.dev, tglx@linutronix.de
References: <aKIvd4ZCdWUEpBT_@tiehlicka>
 <20250818120819.26709-1-zhongjinji@honor.com>
 <aKRWtjRhE_HgFlp2@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aKRWtjRhE_HgFlp2@tiehlicka>
User-Agent: NeoMutt/20220429

On Tue, 19 Aug 2025, Michal Hocko wrote:

>On Mon 18-08-25 20:08:19, zhongjinji wrote:
>> If a process holding robust futexes gets frozen, robust futexes might be reaped before
>> futex_cleanup() runs when an OOM occurs. I am not sure if this will actually happen.
>
>Yes, and 2s delay will never rule that out. Especially for frozen tasks
>which could be frozen undefinitely. That is not the point I have tried
>to make. I was suggesting not treating futex specially because no matter
>what we do this will always be racy and a hack to reduce the risk. We
>simply cannot deal with that case more gracefully without a major
>surgery to the futex implementation which is not desirable for this
>specific reason.

Yeah, relying on time as a fix is never a good idea. I was going to suggest
skipping the reaping for tasks with a robust list, but that still requires
the racy check, and your suggested workaround seems more practical.

Thanks,
Davidlohr

