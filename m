Return-Path: <linux-kernel+bounces-799407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809A3B42B39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9550A7C4923
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342132ED34;
	Wed,  3 Sep 2025 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="kdDzlrhD"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB92D46CB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932229; cv=none; b=B6cPWVMaPRgpt/ixKiFn0fEDv1wgtaDdWTvMnpRuUJQXIHCOGsRWU0wWP689jgmxSytDdFCZE9u4CR5cXHmno8aNhSBILdQvTcw0E7H4Z12FpqK4JxxmRBf2Pwqw3yzhGFeVFonhopZO52N3xfYnZGP1c/6JPe3l4WanuuWvpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932229; c=relaxed/simple;
	bh=4iUM+il3WPoOqYkawtnO/d+wiaQWAu4xGyfE7VMDBBQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MhOc32nLkKS4+BISDB0rHhC1ExJGsXT3I2U6BA4QUsSpZsZaYyQlmxAeNubTDGJJu7TP9JTGax5mXBS8gd7lBe0LYaPQEkoSBqavZcWQQQuZ900ljcwTUHn+DfWu4fruSSTXe3bNeKBM5vAc2C7Gsndl1BIp747a8H4HJAnwLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=kdDzlrhD; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1756931596;
	bh=4iUM+il3WPoOqYkawtnO/d+wiaQWAu4xGyfE7VMDBBQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kdDzlrhDwtc98J0QsaSJ9bF6jG31fVtMfjczNzT/xehdJ/zVoY1z7JQDM3g0W9lKy
	 1Nv4AdDROwVHe3W54M3dmH/UGj7QbVVfG8wp+HZIaCo43Z3K8Yay2Bu8weQog7Dlwm
	 NB2xPpfCFkWJihu7wePGx3AvuJXcZHvg/sLxv61g=
Received: by gentwo.org (Postfix, from userid 1003)
	id B548E4038E; Wed,  3 Sep 2025 13:33:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B0D56401F6;
	Wed,  3 Sep 2025 13:33:16 -0700 (PDT)
Date: Wed, 3 Sep 2025 13:33:16 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: Valentin Schneider <vschneid@redhat.com>, 
    Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com, 
    peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
    rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
    frederic@kernel.org, linux-kernel@vger.kernel.org, 
    patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <CAKfTPtCtR7Q6PxRRXGxfKnhyPTODBGs5cFRVL6A0nHx_GnpA9w@mail.gmail.com>
Message-ID: <cc41029e-ca82-bf3c-0cb9-c7bd907a4680@gentwo.org>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com> <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com> <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com> <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <1db2d6df-16ff-4521-ada5-da585b87b06f@os.amperecomputing.com> <xhsmhfrdblnp3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <916176fe-ad43-9dd2-ed1c-6f05f838d491@gentwo.org> <xhsmh4itjlnnt.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <CAKfTPtCtR7Q6PxRRXGxfKnhyPTODBGs5cFRVL6A0nHx_GnpA9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Sep 2025, Vincent Guittot wrote:

> > AFAICT we have (at least) two options:
> > 1) Trigger NOHZ balancing on a busy housekeeping CPU (what this patch does)


Isnt there a third option?

3) Trigger load balancing if on a NOHZ_FULL cpu and multiple processes are
running on it.


