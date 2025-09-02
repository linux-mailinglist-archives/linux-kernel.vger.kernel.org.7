Return-Path: <linux-kernel+bounces-796243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E646EB3FDB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3491B2587E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056702F7452;
	Tue,  2 Sep 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="O2BXkUrq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNXlwNZn"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04F274FCB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812149; cv=none; b=lZbLXRQ8g72Xmb2tvHsBhdTmDODJ1ZMX2J4AFkzpib4P8DO2fXggz8dQ4IvPbK9/sr7MCv6EcwAo5IqepglnNbaXZW/WEIAfYlEIbwq5YDE8HEvecMP54/QKxQUkIjjqnU0B6b7OU0jsx/kjEBLXWZMpXpLAv5vM+PZAsXmu3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812149; c=relaxed/simple;
	bh=m9IVeN4Zr8SfPupDyZhBUHOBpWE7ukB3Jq4DXHsp1+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt1wVWB/I0iH2Xo0YqDsxZ3BiVHmlc7B6yOLq54dbqHBtQLo7Fki7+XHMtCGLdFys021JS8UjZsg/pCaJjyer52ffut0Tz74cEyfebJpD7OwQeRI8q7AzUXnu3AF+9rXPwD/jnqCdnAcStFLAor4b7HPZ+QEA/IEVvIo76I1geY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=O2BXkUrq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNXlwNZn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4DF31400246;
	Tue,  2 Sep 2025 07:22:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 02 Sep 2025 07:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756812145; x=
	1756898545; bh=1PQWOI3a1pzWEaj/X6sn3yaZC01tqfWyJfPg2he1FmI=; b=O
	2BXkUrqvLuL+UWU5OQYXJu0kyuYAsiMomEZcPRG/v9lKlSSKliWZYSm4cvmfgljt
	4DoX/tsWceI2cczYpdKobkmEgh83TdlVw3CLbRAfvcnQVYxPVlanbVpnB0EsaKG/
	Iosk1jDizAsiUvHlLlb9gGFCzdKMqUCvKMD9avWzeFtBBvWML8kqeBdS1CpE2Yx/
	bqbXEQD/i+qJwoIbKLmZ1jmRJfqboI7Ym01swWVSFjmakeGN8Qgbj+xEfTH/F4xP
	Rr7XlJoiHKaQ19yXbhoEyC+QEEZ4RbbZLl71waLlUW3W6Tb9SKGYP/ezYpMOprQr
	sqKc24Q8l873Ti36fE0Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756812145; x=1756898545; bh=1PQWOI3a1pzWEaj/X6sn3yaZC01tqfWyJfP
	g2he1FmI=; b=ZNXlwNZnwp9xeh7bSCn9UtW/TgaTmnO0KqaUh4ejc/p+qfFfX1t
	KC2D83H58rVgwPl8gNYxrlFt1QJH80R6WY5ci/DzVQeXHpgrIlYpqPbyw296PnCT
	HhJ1kwUcyxGcDgHQkeJzPJgDEqr70T2g/dZrCL7dCl2lKhhozslW5loK08WlF86y
	6c2riHUSiqWGBApf2aWu15mMN6k9vdJyjv1bU0YH62TRrMe199oZRiszUlS8xu35
	fpeJ+6JK6dLUbE4LJf8jV3aWfnrkvTrG5O+d00uYhaopkDVgVAGjTPH91d2NtopJ
	p3LApxp0TjW7A15FfhOAL8RYToY8YNQPlNw==
X-ME-Sender: <xms:cNO2aK6WYbFv5qhE7G8KyCkzLRfRcCULV2BMK1Y6dd_znpubMH3ukg>
    <xme:cNO2aOsNjs_QQzOWduYtTrkAPKa8lZrt798LMglLLk76Wa39oOfgZqoo0kKDkuH13
    KI--l9hGB_V-5rsuiQ>
X-ME-Received: <xmr:cNO2aHvbyHBwh-OqHWDO3TAyQaQCzcyMoTNZ0PJ4l7N1i5q6VRMHQHVBPqzb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfuhhhu
    thhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtleduhfef
    feffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkvghrnhgvlhesphgrnhhkrghjrhgrgh
    hhrghvrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghp
    thhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtoheplhhorh
    gvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepsggrohhl
    ihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopeguvg
    hvrdhjrghinhesrghrmhdrtghomhdprhgtphhtthhopegsrghohhhurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehnphgrtghhvgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:cNO2aGutAYR8QsCu4heOsa7cvNQb6cLbJ-cX6uv3yIRcnmRTxml1fA>
    <xmx:cNO2aH55uEKW4Lbuud_CAiE-z-Nyf7YJ9eqRxRWt4vkPUR-iuf0TwA>
    <xmx:cNO2aJA5uXS3ir4_jHW0kavejFGjtmIBQHbNwWHhtUVPnXMVXVfubg>
    <xmx:cNO2aHv-qcobKTpSxUZ9hqBMxqUy5BykxK7oI2CfHELYJrceAYQtTQ>
    <xmx:cdO2aBV3jHOQrMrU6aMYVpHDh4cCi7JP7c9iLvUUbq__f954LbeJFu-U>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 07:22:23 -0400 (EDT)
Date: Tue, 2 Sep 2025 12:22:21 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Message-ID: <qh7s3j26aac3hyzgnr2ee6byjenstxhjnlwn4qxbvz2l32ohqc@qbhdxvpnuhtp>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902084036.208921-1-kernel@pankajraghav.com>

On Tue, Sep 02, 2025 at 10:40:36AM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> split_huge_page_to_list_[to_order](), split_huge_page() and
> try_folio_split() return 0 on success and error codes on failure.
> 
> When THP is disabled, these functions return 0 indicating success even
> though an error code should be returned as it is not possible to split a
> folio when THP is disabled.

Other view is that the page is already split therefore nop.

> Make all these functions return -EINVAL to indicate failure instead of
> 0.
> 
> This issue was discovered while experimenting enabling large folios
> without THP and found that returning 0 in these functions is resulting in
> undefined behavior in truncate operations. This change fixes the issue.

Could you elaborate on the undefined behaviour? I don't see it.

If you argue that this code should not be reachable on !THP config, add
WARN() there. But I don't see a value.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

