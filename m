Return-Path: <linux-kernel+bounces-736091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C4B098B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82DE586FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973910957;
	Fri, 18 Jul 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qBwI34VU"
Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E52E36ED
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797052; cv=pass; b=H7WCuwR1ZARnPcjdALp2Y7ZXizW8oVh89d5P+Ao4xve6QOW9y8e19P/CqNNcI9MLTN4lfTQdVYOqNOdeMPjhT5NwP61FZK6dsMojYpZYmb2XWtigyYSDCbrGJrIzyDUWXl93F7VB0akxFuzwt9//izq36gEYt2hrALg2qIZROsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797052; c=relaxed/simple;
	bh=HwmELUTobQqfKmSAd8bIpSu7QkIYflvZPof++Blkhzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6XVLyIUeabAcqftI3EExlKT5a8A7PpxOzWw0dCC7H77YEkJ02yzlabxNVX6qOJMwW0mg6se9SqGSdrP8Mo1bTfMhDXKoZvffHWCZAQUO0GBud4W2crVZBsIOETsOBQUhy8YdeG0+wdb7nC+tqQ2GyeJkLGAHOIUwAuPepKFACo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qBwI34VU; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 29B0D2C5271;
	Thu, 17 Jul 2025 23:56:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (trex-blue-4.trex.outbound.svc.cluster.local [100.120.55.68])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id ADD942C5504;
	Thu, 17 Jul 2025 23:56:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1752796567; a=rsa-sha256;
	cv=none;
	b=NRsSXWScKWUs2N7ILQaBsLnfAmaEl2yf+1zp2IvGw5TG2LaE7XxxoMtVfUodMFQbbps8+4
	cSvodcFFTlFR624QN8Wup8TfpGRNwvIgTWVGIBT8NeE9H4LIcMh0VgoPIq3NGDH2wFsAhW
	Y0AOKyzhJmFOhGM8AHhm3giZ5/pzRaNy9zx3eELidRXXDwHLocs4YpHVFEhjWRM3+gL+i9
	BTaXK2SxbNY+SQWo5EMNNdNVbnxqKkQNKb4P8y1L2W2qEzMB2tQ6ZaJwlz86QYek182V8j
	2pMjzVw1Iy1Rr7kQqno7SKzqof8z+J6v+26idvip6/ItJ5ereFZq8fMSamkOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1752796567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7RtXfbLTQpUPXpNyLf5XdWP2Y2W1eG50TeXk0MP1i58=;
	b=DnjoKp9GOuzBwEQ7mDN4WF4q10YoLdabqOLAZP+HaZR4mbHepyQB9q8hHrKrR045n7euY6
	oEbaccFWzhMx44yINV+R3yklnbnvsgQZWq9o9WGYc7l5abL4cRt0Rmpf7dEOm4wSg/tq1p
	2aNkpvnPd4Q/EnbsahYF0tvfEvaDDocjVCxLx2/RvgVnEdwGVU+k8qT1NDMAVQzPvOM+kp
	yPFZNlO+4lJ3P/TSmT6sPV2tVnr4wynP2y6QnNEH/5UP+ST5OBk9JYU5W8EtLIZG6yWuOw
	0NTCP46PpTq11zHhm02Wqr+QqJIZk1bCZdTu8bafptYqwRRuCdA3DWR9aW9GFg==
ARC-Authentication-Results: i=1;
	rspamd-57f6596c64-h8lcm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cure-Average: 736961736fca3a37_1752796567971_656183971
X-MC-Loop-Signature: 1752796567971:2821274669
X-MC-Ingress-Time: 1752796567971
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.55.68 (trex/7.1.3);
	Thu, 17 Jul 2025 23:56:07 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4bjqZH1HtGzJZ;
	Thu, 17 Jul 2025 16:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1752796567;
	bh=7RtXfbLTQpUPXpNyLf5XdWP2Y2W1eG50TeXk0MP1i58=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=qBwI34VUD0DC5uzOIu1kZldwGkAkFxnYvaaszgSZZXdpos78DkN9GB6YID0u4ZOiK
	 uP9N5ASyJwXFlyqygL3sWg96AS51cY1a2L2s+gtQzqWGuea/HtH9RUErUOKVct/fCJ
	 h5UCCicDJH/QhQQsu3GtSOTB5AZF2QMcNZuyB5e9geHHlMqUpUWZd4wsMbJvHR+uGk
	 8OVsjePYIN2w/Za3mnaZCP2buEev1mpoUrHOq1neeF9z3HMNcPrfnlsq8YAoo10nLs
	 lbDlsPPC4DuwnabUA0z0o/GPyrP2KQZckNcylnIFPUIKjG9GSwRBi+pqQKobF8+ohf
	 o06Pjtsyx2BLA==
Date: Thu, 17 Jul 2025 16:56:04 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, mhocko@kernel.org,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, yosryahmed@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/memcg: make memory.reclaim interface generic
Message-ID: <20250717235604.2atyx2aobwowpge3@offworld>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, mhocko@kernel.org,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, yosryahmed@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250623185851.830632-3-dave@stgolabs.net>
 <ggavn7jgnti6uhdwlbgmuz4miplyh5zzixgmlye53qmaoh7tkp@3srwgtxrhtld>
 <20250717155246.1f2a90c76d71b401255f11b9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250717155246.1f2a90c76d71b401255f11b9@linux-foundation.org>
User-Agent: NeoMutt/20220429

On Thu, 17 Jul 2025, Andrew Morton wrote:

>On Thu, 17 Jul 2025 15:17:09 -0700 Shakeel Butt <shakeel.butt@linux.dev> w=
rote:
>
>> On Mon, Jun 23, 2025 at 11:58:49AM -0700, Davidlohr Bueso wrote:
>> > +
>> > +int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_da=
ta_t *pgdat)
>> > +{
>> > +	unsigned int nr_retries =3D MAX_RECLAIM_RETRIES;
>> > +	unsigned long nr_to_reclaim, nr_reclaimed =3D 0;
>> > +	int swappiness =3D -1;
>> > +	char *old_buf, *start;
>> > +	substring_t args[MAX_OPT_ARGS];
>> > +
>> > +	if (!buf || (!memcg && !pgdat))
>>
>> I don't think this series is adding a use-case where both memcg and
>> pgdat are non-NULL, so let's error out on that as well.
>
>As a followup, please.  This has been in -next for four weeks and I'd
>prefer not to have to route around it (again).
>

=46rom: Davidlohr Bueso <dave@stgolabs.net>
Date: Thu, 17 Jul 2025 16:53:24 -0700
Subject: [PATCH] mm-introduce-per-node-proactive-reclaim-interface-fix

Both memcg and node is also a bogus case, per Shakeel.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
  mm/vmscan.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4598d18ba256..d5f7b1703234 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7758,7 +7758,7 @@ int user_proactive_reclaim(char *buf,
  	substring_t args[MAX_OPT_ARGS];
  	gfp_t gfp_mask =3D GFP_KERNEL;
 =20
-	if (!buf || (!memcg && !pgdat))
+	if (!buf || (!memcg && !pgdat) || (memcg && pgdat))
  		return -EINVAL;
 =20
  	buf =3D strstrip(buf);
--=20
2.39.5


