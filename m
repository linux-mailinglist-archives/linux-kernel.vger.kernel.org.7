Return-Path: <linux-kernel+bounces-741317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D809DB0E2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F3717E49A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085C027BF89;
	Tue, 22 Jul 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jh8tCUgk"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CF27AC50
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206008; cv=none; b=D+N60ZxFPJTF+SOzcWXtOnmY1lZiCZVkejZYc8R2xlNCkdYjo4za1tDWFtmNGYvga/g7Hdz0S/sqhQqLlH/WSH/QXjbMVM/0L654pBoXMyl3ye1mCc2u41TKh8tD853HwHNHayUcfQ4KEKYxJhqm8xUgDSq6oAN/UmgcUDLW/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206008; c=relaxed/simple;
	bh=pis/st3q0bD0hxt/vny69iBoGbZmmxk2smGHf2c7Za8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vBqRabn+IeX0TdOAfyglkb3noEms12G75qwE7Ck1BKOt8jbeyb0MwEm2GQN9jmuBtLueg4BJt8Nb5IAE/WFzTvWZPM+V7fsOGZlhGMNePusLopWVEQSyDNQPnkk6DFcQDOSRF1oJtO5x9CCzLaDx1fX2jAExtQ/zm8pHXnp1PMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jh8tCUgk; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.47.147.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6C3503F6D4;
	Tue, 22 Jul 2025 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753205570;
	bh=XwYX+iNy3itHGdUZm+dwRPLINkv68rL2JwywnXO8Uzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type;
	b=jh8tCUgkyyxdJK9qWt4cOggORCnt/qzq+gyAnSfd1M3xF3lYlXsjuZwJoNO4s8bm1
	 2DVL+f1lUUr/Shdd0Hzu1Qi89eF30Pa7roihlhLLzb53vSFrR94jGWVjkeoy0jor3d
	 6/dGbr9TMi0P9BMj7K2vFXcgi9l+jIGwbsqRozsTCSKk5oZVSFUkEBVBAcvhcjzody
	 keDwx84UVZ8N6niFttQw/aye5FWGY81GjzaQBPoTWdL006nS4DHBIiACzMDjk1mC2o
	 SrlvyksfeW88wJ/Ww0wn00pjSYfDQKzWs0MdIL9Ddk8riRlmtS6L3CSoC0uojwZXZw
	 lj8RRng6zGaRA==
Message-ID: <9617acf2-293f-430d-a421-59c7675be7f7@canonical.com>
Date: Tue, 22 Jul 2025 10:32:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lockdep warning for non-static key in apparmor code
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, apparmor@lists.ubuntu.com
References: <20250722100413.117462d2@gandalf.local.home>
 <20250722102413.52083c6e@gandalf.local.home>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250722102413.52083c6e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:24, Steven Rostedt wrote:
> On Tue, 22 Jul 2025 10:04:13 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Booting latest linux-next, I triggered this warning.
>>
>> Looks to be associated to apparmor. Was there an allocated spinlock not
>> initialized properly?
> 
> Yeah, you don't initialize the spin lock. Is there a reason you commented
> out the spin lock initialization in 88fec3526e841 ("apparmor: make sure
> unix socket labeling is correctly updated.")?
> 
Ooops yes sorry, I split out the lock here to a second patch so I could do
some testing around the impact the lock would have against the unix socket
case. That patch was supposed to get folded back in, but it looks like
I picked the wrong sha (from the branch with it not folded in) into the next
tree.

I get that fixed asap



> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -508,7 +508,6 @@ static int apparmor_file_alloc_security(struct file *file)
>          struct aa_file_ctx *ctx = file_ctx(file);
>          struct aa_label *label = begin_current_label_crit_section();
>   
> -       spin_lock_init(&ctx->lock);
>          rcu_assign_pointer(ctx->label, aa_get_label(label));
>          end_current_label_crit_section(label);
>          return 0;
> @@ -1076,12 +1075,29 @@ static int apparmor_userns_create(const struct cred *cred)
>          return error;
>   }
>   
> +static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t gfp)
> +{
> +       struct aa_sk_ctx *ctx = aa_sock(sk);
> +       struct aa_label *label;
> +       bool needput;
> +
> +       label = __begin_current_label_crit_section(&needput);
> 
> +       //spin_lock_init(&ctx->lock);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> +       rcu_assign_pointer(ctx->label, aa_get_label(label));
> +       rcu_assign_pointer(ctx->peer, NULL);
> +       rcu_assign_pointer(ctx->peer_lastupdate, NULL);
> +       __end_current_label_crit_section(label, needput);
> +       return 0;
> +}
> 
> -- Steve


