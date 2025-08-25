Return-Path: <linux-kernel+bounces-785245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14AB34808
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7662C189A7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D43019D6;
	Mon, 25 Aug 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aaxX9KoA"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CC2F0694
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141023; cv=none; b=ouuwzXoWoTWjdw+s/8MqGDFtj/g+50asNT3aAg73axrnIGEzIFXzjJu2aGdQOPolU7V2EMGIQkzzsZxGfilJ9cHbCBilxti3T+RHbkHP70TugYXRoMXKu+tSOXAXrZVnPPOGs3A8jteiLN7XbJi7avz1MsRGyE+uyGgJtbzEaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141023; c=relaxed/simple;
	bh=NAPZqISVKAEwgxkMeXQwIHHj6CxIXWWQHoJY30zQfUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vd4qKj660OIBKeuE5A/eF+9BapQHbfAj7np45mlLgS4HNuVJCnljFYpHHkFdh7iIQnRfHxaLBzZmeeiqpcUCQ9U6IVnO+h6HYGlqymP5sESaLSsXni75DnGyJdkh7QVJzZEwtzsWhIM9BckDD30EO/CSBROfLKJy5LYkgSSEyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aaxX9KoA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756141019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAPZqISVKAEwgxkMeXQwIHHj6CxIXWWQHoJY30zQfUw=;
	b=aaxX9KoAIRU7hcngB3MtEt3ChqHOEscLudD75M3s/FotORLWw0z+bT8E63I3g9xcvYi1hC
	kgZyTAHgJvVA9hIGN3LpAa/tnkfmm1xMAfH4tjAX3wkJx7ZBrzt2gHYLfwy941zbce25af
	HTyYBnyzuYVGc/CCcOGEwiEhB5kVriY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,  linux-mm@kvack.org,
  bpf@vger.kernel.org,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David
 Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/14] sched: psi: implement bpf_psi_create_trigger()
 kfunc
In-Reply-To: <c1b71664-91c0-439c-9cae-7407fa5b0358@linux.dev> (Martin KaFai
	Lau's message of "Fri, 22 Aug 2025 12:57:20 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-14-roman.gushchin@linux.dev>
	<CAEf4BzaSLWB1xpCjX35oxg2ySvvgRvEmQ01PtXv+xEz-Zkz07w@mail.gmail.com>
	<87ect5lde2.fsf@linux.dev>
	<c1b71664-91c0-439c-9cae-7407fa5b0358@linux.dev>
Date: Mon, 25 Aug 2025 09:56:52 -0700
Message-ID: <87h5xvxru3.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 8/20/25 5:36 PM, Roman Gushchin wrote:
>> It will. Idk how big of a problem it is, given that the caller needs
>> a trusted reference to bpf_psi. Also, is there a simple way to constrain
>> it? Wdyt?
>
> The bpf qdisc has the kfunc filtering. Take a look at the
> bpf_qdisc_kfunc_filter in bpf_qdisc.c.

Thanks! I'll take a look.

