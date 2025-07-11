Return-Path: <linux-kernel+bounces-728379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A829BB027AB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A96A462D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9B222562;
	Fri, 11 Jul 2025 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7mgt5VZ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362978F29
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752276508; cv=none; b=rjIrY0KAw7I/RkSUs7gayxBwZcnU+LCdt7JrmTLkqikIxKlNITiyxHgzZzj+E0FvTWoKuxCUvYK2pJAx1hbHAW5OizkBRZsKPeEdhK4DU6Sny0lA0SAiSVStIB5xzsd+qBxfU2VVGVrImk0uej1nwNCKgKKxNdMQMtm2ElFQbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752276508; c=relaxed/simple;
	bh=cK4Fdk+yP+BTF/rMC/gSTkLbOLYtkeYIHfxo7B+GCmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phETe+FmJCAjr2B17MbIThZ8CsiddjVPuxCNFZ2DdgCKTJLDKxEteEYsqTwAPkdCuEdXn0DI/8PcI5Y8S2GIwnChesZl/siMdwd0Ca+ryWYcwL5T9cqrFX7LkwYIvd2LcRcJ2CezAgeOozEDuOw6c/MCcGx3IIuODnE1Fj8XIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7mgt5VZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab380b8851so9180451cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752276506; x=1752881306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abYDJaPXQNoISIuynhsBnhk8NWJ6fYOSfTVWiFEpAEY=;
        b=X7mgt5VZAuNzUvKDq1MjQc7WodkxRDpcTNrX+FhfQIlT0N/FhszqttTcaUDF8l+Hhc
         h4ed/05rZhYZ6Kvb/LHQCm6Y7rCCVMMEEvsKCfgrtvaTt75/JXMVCsZlI75gKmCZg8Gv
         W2onkvi5M2yx+K4bk07ZoJSsBTHZcphqeW6xsZ8vti/uEpOLVgEZO+hF3iQ6ceYfhjr2
         YETkddL15YrmSzeJ3DqWIeFz1dvI827IqlNUjAlQNO/olMuRkX5VnNuKl+qQCRszAmQc
         /pXbIndYODG4wPytsMB2zJgy6N5hTCfIxTzT9o/rlJC8mPCEoA4NfqIzuZm1eMTu7dkP
         bvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752276506; x=1752881306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abYDJaPXQNoISIuynhsBnhk8NWJ6fYOSfTVWiFEpAEY=;
        b=jVEKrJ8byH2OHJJXe+21gi5WLVQXnmQRNw2nNU90acj18rv4DWur6O1xIyf0TW65/8
         FUD0rKfhnesHniiJRigwaxYvPJ78ZRbBKTFKxMauxsRSZord8A0u6nCFkA7VtzlqN/OP
         kGV3kPbH4pK/B00OHHZSIYv4Zf91DddjJ1a5HzQWpaFSTAIuzyQnA60SYu1c/CSfkhvS
         XwrEV/6+bNPQqrpIKsUCaYSEurR4xb9ODuikw2hd4kjyvm62EscTxCdohKlZ0XXTNd1s
         WaPraO90spytBXCh8JnymruCMWTI3LgmmUsoYzELTqrswgbDQWHOL9UvyRlRNjyf1uaW
         oLgg==
X-Forwarded-Encrypted: i=1; AJvYcCUBHhL35af3NRXTpAMS6PHJC+Z+Fr6j+nNSltDQni92L+FnH+rrM6+GWvADsWTrwra7dnEWfGiLhTCSCnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4r/WJVWNNy8ePCsP0ektPBY8BHcKZ7vl9EgSl53pzwDua+6K
	nAwMqP6KgRjP6OtyvMR7g7mFAzULBAGGN5C3BxnEwab6oDF53b9mxAQK
X-Gm-Gg: ASbGncuYq7OeiOl85dpqJrCsuEZIB0DDskSE4t/tbjfiN3vsZceXRKYBsqVbmE3VerT
	lSh9rBbna24uliruPP7pjZnbNQDUYgacgLMYr3ZjvN4AHiw5ZA5VkWZnhmCuSKy/O0KHCkplGH0
	8OByUEMBbGaajncrVBTz2DyuriJI50O+HCKeqxVLuMabeLjIp2xhzGyyNi8C5zySC8nIFPuu9+v
	/zg7+nZxhjfqzW+dgf0ksDKTZxmclhj1tZMY+aqpJaM1gpPk/LDMNf6XLh0KQ6Rlj5JPg+RCf5W
	G9C3yn/cToWZovvqbu3RC5M5oESNASDK03eLIyTCb0hvUHeuXcMiX+f1tPrY/+vfz7w/uWhI0cC
	4JTDICIRjjQR6OTCS4wBjrdwzDV19CILdB/xqfkhw35PPg2ZmlCn+pPEtZdgJ6p5ODr7NAH/YJ/
	/iGyk9NEYCIk/q
X-Google-Smtp-Source: AGHT+IHTUIbrI5+zd26ehFkhAGb6xm7EWCQSOLcb4FPjHxKvJx+PKBuwJm7CVbrDx6Qnz2F3pH2jlg==
X-Received: by 2002:a05:622a:1f13:b0:4a7:2f49:37d6 with SMTP id d75a77b69052e-4aa35e7fecemr66134651cf.5.1752276505877;
        Fri, 11 Jul 2025 16:28:25 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9ede7657asm26579291cf.46.2025.07.11.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 16:28:25 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0469AF40066;
	Fri, 11 Jul 2025 19:28:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 11 Jul 2025 19:28:25 -0400
X-ME-Sender: <xms:GJ5xaO_Dth14oHzbnGVT9_aHJhuMOqAC0naw3BNKIlYU9m0GqXUYQQ>
    <xme:GJ5xaLrkulCAafFGE36RtZJFDae5SV57-BLf8OxZENkr-2n26uw-UbhbZ2Ysh4GRT
    qKQTfLqymZvt0gc4w>
X-ME-Received: <xmr:GJ5xaPqcc-W__AA51gsqDbAXdUiYTGtKklXo-g3sBh6g4HSB1FDqT1rZ6YyF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgvthgv
    rhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsohhquhhnsehfihig
    mhgvrdhnrghmvg
X-ME-Proxy: <xmx:GJ5xaO0A-TtAHVpZ1BJICBIuDf-xc8SNK4gTL-OuZ-IB0bwI0VOefQ>
    <xmx:GJ5xaNFQDoHiIW9FcHg2-7owNBtawdfwDtBsDLhoh8a-HCicj7G6BQ>
    <xmx:GJ5xaJF_IxHijKFNvBFNEpBzeXLiylcmsispu-O0NW3fuOAH4xueeg>
    <xmx:GJ5xaA53GbsEJtC0g5k3d1c98PNnmjBIudZK-3QNcNmq9nwShFyrrA>
    <xmx:GJ5xaOwZ1Pbcq8L6S1P8VPqTXhbZHQyBffS9rnNBom01A-nqtBi7gLhn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 19:28:24 -0400 (EDT)
Date: Fri, 11 Jul 2025 16:28:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
Message-ID: <aHGeF7ko_4uXHUgl@tardis-2.local>
References: <20250709193910.151497-1-longman@redhat.com>
 <aHGONjuRiA3KfH1q@tardis-2.local>
 <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>

On Fri, Jul 11, 2025 at 03:30:05PM -0700, Linus Torvalds wrote:
> On Fri, 11 Jul 2025 at 15:20, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Meta question: are we able to construct a case that shows this can help
> > detect the issue?
> 
> Well, the thing that triggered this was hopefully fixed by
> 8c2e52ebbe88 ("eventpoll: don't decrement ep refcount while still
> holding the ep mutex"), but I think Jann figured that one out by code
> inspection.
> 
> I doubt it can be triggered in real life without something like
> Waiman's patch, but *with* Waiman's patch, and commit 8c2e52ebbe88
> reverted (and obviously with CONFIG_KASAN and CONFIG_DEBUG_MUTEXES
> enabled), doing lots of concurrent epoll closes would hopefully then
> trigger the warning.
> 
> Of course, to then find *other* potential bugs would be the whole
> point, and some of these kinds of bugs are definitely of the kind
> where the race condition doesn't actually trigger in any real load,
> because it's unlikely that real loads end up doing that kind of
> "release all these objects concurrently".
> 
> But it might be interesting to try that "can you even recreate the bug
> fixed by 8c2e52ebbe88" with this. Because if that one *known* bug
> can't be found by this, then it's obviously unlikely to help find
> others.
> 

Yeah, I guess I asked the question because there is no clear link from
the bug scenario to an extra context switch, that is, even if the
context switch didn't happen, the bug would trigger if
__mutex_unlock_slowpath() took too long after giving the ownership to
someone else. So my instinct was: would cond_resched() be slow enough
;-)

But I agree it's a trivel thing to do, and I think another thing we can
do is adding a kasan_check_byte(lock) at the end of
__mutex_unlock_slowpath(), because conceptually the mutex should be
valid throughout the whole __mutex_unlock_slowpath() function, i.e.

	void __mutex_unlock_slowpath(...)
	{
		...
		raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
		// <- conceptually "lock" should still be valid here.
		// so if anyone free the memory of the mutex, it's going
		// to be a problem.
		kasan_check_byte(lock);
	}

I think this may also give us a good chance of finding more bugs, one of
the reasons is that raw_spin_unlock_irqrestore_wake() has a
preempt_enable() at last, which may trigger a context switch.

Regards,
Boqun

> That said, it does seem like an obvious trivial thing to stress, which
> is why that patch by Waiman has my suggested-by...
> 
>           Linus

