Return-Path: <linux-kernel+bounces-896425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED192C50550
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA173B260D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96041FDA92;
	Wed, 12 Nov 2025 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EarAueks"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0405197A7D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762914106; cv=none; b=APGX99XLgxJzKyuH+rBWANXoCpMgCZ0uH2H80rdv+ZwCiAMTtVVHqaAMRWG8jInhrXFf2n3kOIXwfzCscoVUgoZt/TDPJ9Gp4hNe30Tolw+tXhxvvj3QLvSDYFI+0ftytKwj/+riDmcWDRFvgvehImhk/6hsM8128eaNucZr+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762914106; c=relaxed/simple;
	bh=PapBOzpG/ziMdJml0NRT3k9KoqFzczVF1AqmZJUVkic=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=E/kqhX5Eg25JDnDoHHjwkwmULBh6ke8CXVcrAx1NzpX4rFOHf3gL3faY+daaTpOXUGmwr6NnlZrgl2sWYR1wDc89i4JySFHmzyKA6FAvFMi0YXqpsIdRaJDpnecDCKjyF856isKRpOTcfPQ4+iaxu+Pbm0rJ9GhgksN+YorBVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EarAueks; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762914101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvK6l0Spby2Ufnh2o78Z5U1zll55EzgJKPTf2NI2yt4=;
	b=EarAueksC5BoIPzUkMnwSVxkjYw3cjkzTp84rwgAyuj+Z9xxvSmzZj8+Swb6FIW8oJET0g
	wbmHxttRUtr4W7o/9nHChRXgMs/SYZdknRA6BtN1AVC0bLAJG6n/c5E9fYmICPF5GOkHWD
	Gf7TcIc+vefye2qurTC0PH3VRAGTd6Y=
Date: Wed, 12 Nov 2025 02:21:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <59f26b5b0c49f8d0f3bdb33f99d69dd3d442ed60@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] mm/vmscan: skip increasing kswapd_failures when
 reclaim was boosted
To: "Shakeel Butt" <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "David Hildenbrand"
 <david@redhat.com>, "Michal Hocko" <mhocko@kernel.org>, "Qi Zheng"
 <zhengqi.arch@bytedance.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Axel Rasmussen"
 <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei Xu"
 <weixugc@google.com>, linux-kernel@vger.kernel.org
In-Reply-To: <e5bdgvhyr6ainrwyfybt6szu23ucnsvlgn4pv2xdzikr4p3ka4@hyyhkudfcorw>
References: <20251024022711.382238-1-jiayuan.chen@linux.dev>
 <e5bdgvhyr6ainrwyfybt6szu23ucnsvlgn4pv2xdzikr4p3ka4@hyyhkudfcorw>
X-Migadu-Flow: FLOW_OUT

2025/11/8 09:11, "Shakeel Butt" <shakeel.butt@linux.dev mailto:shakeel.bu=
tt@linux.dev?to=3D%22Shakeel%20Butt%22%20%3Cshakeel.butt%40linux.dev%3E >=
 wrote:


>=20
>=20On Fri, Oct 24, 2025 at 10:27:11AM +0800, Jiayuan Chen wrote:
[...]
> >=20
>=20Can you share the numa configuration of your system? How many nodes a=
re
> there?

My system has 2 nodes.


[...]

> >  if (nr_boost_reclaim && sc.priority =3D=3D DEF_PRIORITY - 2)
> >  raise_priority =3D false;
> >=20
>=20Am I understanding this correctly that watermark boost increase the
> chances of this issue but it can still happen?


Yes. In the case of watermark_boost, due to the priority having a lower l=
imit,
the scanning intensity is relatively low, making this issue more likely t=
o occur,
even if I haven't configured memory.low. However, this issue can theoreti=
cally happen
even without watermark_boost =E2=80=93 for example, if the memory.low val=
ues for all pods are
set very high. But I consider that a configuration error (based on the cu=
rrent logic
where kswapd does not attempt to reclaim memory whose usage is below memo=
ry.low,

[...]
> >  - if (!sc.nr_reclaimed)
> >  + /*
> >  + * If the reclaim was boosted, we might still be far from the
> >  + * watermark_high at this point. We need to avoid increasing the
> >  + * failure count to prevent the kswapd thread from stopping.
> >  + */
> >  + if (!sc.nr_reclaimed && !boosted)
> >  atomic_inc(&pgdat->kswapd_failures);
> >=20
>=20In general I think not incrementing the failure for boosted kswapd
> iteration is right.

Thanks. I applied a livepatch, and it indeed prevented the occurrence
of direct memory reclaim.


> If this issue (high protection causing kswap
> failures) happen on non-boosted case, I am not sure what should be righ=
t
> behavior i.e. allocators doing direct reclaim potentially below low
> protection or allowing kswapd to reclaim below low. For min, it is very
> clear that direct reclaimer has to reclaim as they may have to trigger
> oom-kill. For low protection, I am not sure.
>

We have also encountered this issue in non-boosted scenarios. For instanc=
e, when
we disabled swap (meaning only file pages are reclaimed, not anonymous pa=
ges), it
indeed occurred even without memory.low configured, especially when anony=
mous pages
constituted the majority.

Another scenario is misconfigured memory.low. However, in our production =
environment,
the memory.low configurations are generally reasonable =E2=80=93 the sum =
of all low values is
only about half of the system's total memory.

Regarding how to handle memory.low, I believe there is still room for opt=
imization in
kswapd. From an administrator's perspective, we typically calculate memor=
y.low as a
percentage of memory.max (applications often iterate quickly, and usually=
 no one knows
the exact optimal threshold for low).
Furthermore, to make the low protection as effective as possible, memory.=
low values tend
to be set on the higher side. This inevitably leads to a significant amou=
nt of reclaimable
memory not being reclaimed. In the scenarios I've encountered, memory.low=
, although intended
as a soft limit, doesn't seem very "soft" in practice. This was also the =
goal of the v1 patch,
although more refined work might still be needed.

