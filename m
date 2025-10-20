Return-Path: <linux-kernel+bounces-860582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD6BF0722
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5FEB4E22B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0612F5A2F;
	Mon, 20 Oct 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j9EzymXH"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29A23507E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955093; cv=none; b=Zmyf+VJQ71WCgwVQLeJdis5XTchrqN8wsqFUDUCp5xiXGNHNTp0hHAVDWklm5/rTQokeorzysNV/EDoQQsuZI9Z0tLKEOPm3Y8hEpujWgtEuiQRbEB4ckc2Bzubp72sfkwxFJ+iO8P2wT3lUBNuXCmi7rNAOLAaYepBUCtJiOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955093; c=relaxed/simple;
	bh=IKyaMslWq1y2YKzDPM770ge87lSKrtCwH8m2MdWwFcE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=iOxtdzD3rnWChNhGt1Xvd1sGpahIWkNuZ+EvAl6HhUxY8IAcUN+O3YLgODIuULOsJShfEg3B6NvrA3epzQlY7aNY53msZlWC4K+I1/O51UakYffuSPCDoO6toeIyuZjyaazRjE3l//YLCeYWiaWx369h6jzE0WZ601Xoi+rsMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j9EzymXH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760955086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thqmaBr5SnMdqTFodzowvqsyJlTkVDv3C36xUDXcoMQ=;
	b=j9EzymXH6xplPMFkNiSM/r3T/xoM6jYPrxOz55fSbSNwrbRZdZP/+Apng27+iIx9pMY93j
	JpB9fW2aWc4guQvlXazw7tm8KW8NSfyFAy+GMXCAVPS4/dBX3EPPjhM8xX+aajXoykb6lA
	YVocxzm+BkNw0sckolpU7eICCWv0PX8=
Date: Mon, 20 Oct 2025 10:11:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <db4d9e73e6a70033da561ed88aef32c1ebe411dd@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] mm/vmscan: Add retry logic for cgroups with
 memory.low in kswapd
To: "Michal Hocko" <mhocko@suse.com>
Cc: linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie"
 <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "David Hildenbrand" <david@redhat.com>, "Qi Zheng"
 <zhengqi.arch@bytedance.com>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <aPE84XfToVH4eAbs@tiehlicka>
References: <20251014081850.65379-1-jiayuan.chen@linux.dev>
 <aO4Y35l12Cav-xr4@tiehlicka>
 <a6cd4eb712f3b9f8898e9a2e511b397e8dc397fc@linux.dev>
 <aPEGDwiA_LhuLZmX@tiehlicka>
 <46df65477e0580d350e6e14fea5e68aee6a2832b@linux.dev>
 <aPE84XfToVH4eAbs@tiehlicka>
X-Migadu-Flow: FLOW_OUT

October 17, 2025 at 02:43, "Michal Hocko" <mhocko@suse.com mailto:mhocko@=
suse.com?to=3D%22Michal%20Hocko%22%20%3Cmhocko%40suse.com%3E > wrote:


>=20
>=20On Thu 16-10-25 15:10:31, Jiayuan Chen wrote:
> [...]
>=20
>=20>=20
>=20> The issue we encountered is that since the watermark_boost paramete=
r is enabled by
> >  default, it causes kswapd to be woken up even when memory watermarks=
 are still relatively
> >  high. Due to rapid consecutive wake-ups, kswapd_failures eventually =
reaches MAX_RECLAIM_RETRIES,
> >  causing kswapd to stop running, which ultimately triggers direct mem=
ory reclaim.
> >=20
>=20>  I believe we should choose another approach that avoids breaking t=
he memory.low semantics.
> >  Specifically, in cases where kswapd is woken up due to watermark_boo=
st, we should bypass the
> >  logic that increments kswapd_failures.
> >=20
>=20yes, this seems like unintended side effect of the implementation. Se=
ems
> like a rare problem as low limits would have to be configured very clos=
e
> to kswapd watermarks. My assumption has always been that low limits are
> not getting very close to watermarks because that makes any reclaim ver=
y
> hard and configuration rather unstable but you might have a very good
> reason to configure the memory protection that way. It would definitely
> help to describe your specific setup with rationale so that we can look
> into that closer.
> --=20
>=20Michal Hocko
> SUSE Labs
>

Thank you for your response, Michal.

To provide more context about our specific setup:

1. The memory.low values set on host pods are actually quite large,
   some pods are set to 10GB, others to 20GB, etc.
2. Since most pods have memory limits configured, each time kswapd
   is woken up, if a pod's memory usage hasn't exceeded its own
   memory.low, its memory won't be reclaimed.
3. When applications start up, rapidly consume memory, or experience
   network traffic bursts, the kernel reaches steal_suitable_fallback(),
   which sets watermark_boost and subsequently wakes kswapd.
4. In the core logic of kswapd thread (balance_pgdat()), when reclaim is
   triggered by watermark_boost, the maximum priority is 10. Higher prior=
ity
   values mean less aggressive LRU scanning, which can result in no pages
   being reclaimed during a single scan cycle:

if (nr_boost_reclaim && sc.priority =3D=3D DEF_PRIORITY - 2)
    raise_priority =3D false;

5. This eventually causes pgdat->kswapd_failures to continuously accumula=
te,
   exceeding MAX_RECLAIM_RETRIES, and consequently kswapd stops working.
   At this point, the system's available memory is still significantly ab=
ove
   the high watermark=E2=80=94it's inappropriate for kswapd to stop under=
 these
   conditions.

The final observable issue is that a brief period of rapid memory allocat=
ion
causes kswapd to stop running, ultimately triggering direct reclaim and
making the applications unresponsive.

