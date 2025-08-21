Return-Path: <linux-kernel+bounces-780534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5188B30325
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD80A17CF53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65CA2E8B80;
	Thu, 21 Aug 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="IFcvG0Bu"
Received: from purple.birch.relay.mailchannels.net (purple.birch.relay.mailchannels.net [23.83.209.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365F33CE88
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.150
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805528; cv=pass; b=L+agAcqUgBQj8PsiugOllNOaC56ZVMHuctvFrEIyQH8qo6kZDi1yIgkoyF7sLfoT7QOBW+yMmn8g8a1VQuY6K/azqQGdMsM3a0lh6jVwbh9XdXqIEmhtAFETtZMZIc4SUT94fdswbAWisaporIbIq8q6tYrl1dD4TtqbwdpJWtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805528; c=relaxed/simple;
	bh=OzNuHG3+NQODJt4XHvrP9emvOj9fQf/i3kdn2NVKDPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvS6HU1O0oMDZy/pNTNx3VEiCidwGwcGHc0Bj1dbqAP4NVUalU5Vv10g/dGO6/uYr1x76XjJ2A74Dz84EtBCVP4Rq4OP+OAHpMk3hdFQcPB8rBpjrjj2e4DQ5cySjQNNz2FAJEATniJ7EqN3MtBiScDrSPjC5xHt44SBnrvfgsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=IFcvG0Bu; arc=pass smtp.client-ip=23.83.209.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3CC6C8A5B9C;
	Thu, 21 Aug 2025 19:45:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (100-96-20-37.trex-nlb.outbound.svc.cluster.local [100.96.20.37])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B27148A67C2;
	Thu, 21 Aug 2025 19:45:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755805518; a=rsa-sha256;
	cv=none;
	b=MkehuG20y5GuL8jtPxx+qutsp3kUh0QxQfKcMlNzfkgCnvborE3/RDXXGu67aDxrb9LKvi
	5CBB91kagRuZ4TGeh/M8HKwcnrmCCKgY3yaP4tumkLhVMW2hpK/uq8cMumSB6yxah/GmAa
	c2QjinW8NqcmE1dAtMMHbEY8LOR9kJiNMHD/kWh/VN5D3G7eohuS6HSQG7D0Ac69ZxwM1B
	qna3P8Fjd/PpI/KcNIxZbdbcs0J7XUrgdDRszl+6B+svASV/xiD31u0OEYDfYOyJWwUp3G
	yXQ6nFNWPc6tbI/rvNRaYICElny/QJySp8zSFEKX4jDKFeFSH38yflkbz9U00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755805518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OzNuHG3+NQODJt4XHvrP9emvOj9fQf/i3kdn2NVKDPw=;
	b=Qbvqp10RfRV/+3Z/J9VVxsq+yTCOYgcopuWuGEQSiq3bemK3LiKp9/+N0/4K0YgXpK+hcE
	VVaskTN6CmyfS6Ql+FqgM4PsxvPKn+8Wx53JyGfRM8IN/tTzOXcw81FJLwcW9qqM9brMEM
	dWneEF2ZNZGqXcJRHRaZxieUYP3m2pTqWcU1xW1J3wI1fFNaWSvAYUQatsxQrQpLN9sBpP
	iErTxCql59mksRYRgyEiN01HfcN3C9sor4NKzyu/QThADb1qeV7mFyYtjEdWxkS55lb5g/
	brcXqFM6tfX5wYZTmYlWsBUKTUYOjSB/NtJQVqX9xeZg0uql9gwJdtX2L8v1wg==
ARC-Authentication-Results: i=1;
	rspamd-75798d6c54-6tzrw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Society: 7d8bbe8144872d26_1755805519096_1753827078
X-MC-Loop-Signature: 1755805519096:2732494681
X-MC-Ingress-Time: 1755805519096
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.20.37 (trex/7.1.3);
	Thu, 21 Aug 2025 19:45:19 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4c7DLj5GHvzLH;
	Thu, 21 Aug 2025 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1755805518;
	bh=OzNuHG3+NQODJt4XHvrP9emvOj9fQf/i3kdn2NVKDPw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=IFcvG0Bu0yYZn0jRu4sESeBw/KwmI5WcTbFV03cxPzBdcsPhZh4MVjrJ7TrlzwgIw
	 cGoge+8PRtEvywoKK9jUGyo5cDNw3MgIr8p/IJo4ToVx0Zw9m8ZVURCS43qten/NV0
	 nLTd5ifMJ6j8dZd9H8lTJTJsH6u5ysKKfGVz2Om8vMfc06LLExhTJNnNF2gnUHvWMW
	 UbDvVMXv7Eabyn3tg9N43ncTQkrPG6jGZgZLps7h/PstClptrn8gSUcuWYLchDXlhh
	 AX3H7mlfOh005RMir+3yBO2/8PsDbucAqoEp7whYYBo1T1TZS2vThu0cFaxtQ79LuU
	 CkDRmIWuSM9vQ==
Date: Thu, 21 Aug 2025 12:45:15 -0700
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
Message-ID: <20250821194515.ohw7rhgo4peepw63@offworld>
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
 <20250820025308.rkqlvauh4dz42oic@offworld>
 <aKdhuOMrwgdxE9It@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aKdhuOMrwgdxE9It@tiehlicka>
User-Agent: NeoMutt/20220429

On Thu, 21 Aug 2025, Michal Hocko wrote:

>On Tue 19-08-25 19:53:08, Davidlohr Bueso wrote:
>> Yeah, relying on time as a fix is never a good idea. I was going to suggest
>> skipping the reaping for tasks with a robust list,
>
>let me reiterate that the purpose of the oom reaper is not an oom
>killing process optimization. It is crucial to guarantee a forward
>progress on the OOM situation by a) async memory reclaim of the oom
>victim and b) unblocking oom selection to a different process after a)
>is done. That means that the victim cannot block the oom situation for
>ever. Therefore we cannot really avoid tasks with robust futex or any
>other user processes without achieving b) at the same time.

Yes, which is why I indicated that skipping it was less practical.

In the real world, users that care enough to use robust futexes should
make sure that their application keep the OOM killer away altogether.

Thanks,
Davidlohr

