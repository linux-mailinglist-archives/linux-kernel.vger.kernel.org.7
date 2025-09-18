Return-Path: <linux-kernel+bounces-822620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873CB84551
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971DA4A66F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A73043B4;
	Thu, 18 Sep 2025 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QT5TucPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fypwkU8S"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27B301032
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194527; cv=none; b=PzReFyvBIzpqTeNJ9lS6LjXb6ZYASdKLdtMb7KAcY3GM8B2bPKWfMtBILo3FndeS1/CtNsB+SWxUbd+CIBKEeX0zd2Wh9nEf9q7mYkVoHR7nE+XU/cVt8/OB+P3snSmGypdJ4nWy3zNv86snmgV0SR19HNzutp31eA2d7r7rcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194527; c=relaxed/simple;
	bh=vGnas6Og43U6m18ieSyrTMsK6c/3al09dO/TxmHlO6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqYZQs9cPcc+4JuSt195nYexFryVhwUAvZSd2dxEZyk5bxwPBIJwGCVCCi13wDXeqbshxdmQzTAg8ccjSn6CRPZgIBDFiM2O8GQt+B78K98BZmfAw4yX0JLbcfyYuczOlQtkLIVkmnhqPtTqfJ6zlwRVyeDoOVbYDlOWxR7r2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QT5TucPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fypwkU8S; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5ED78140019F;
	Thu, 18 Sep 2025 07:22:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 18 Sep 2025 07:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1758194522; x=1758280922; bh=TuONL5e3a/
	q5HMiQsTmfxQteh3y7sUS+8GfVC1rNLv8=; b=QT5TucPinBhNszNfa0MAXZ9Hbo
	lTXxdjl0D455MpY2dmtKd0BlkiQvMiS81SYrZf+2/VTV+UkAsgCaFMmBw5ZjAz8Z
	RLWNgCnezic/09CVWlNu9/N7xB56M8VJ1DV8Qmv9kCHoqMOqr4rklcH2+EWoKpx/
	8WY50wzluov/gkO7Le5w1kbNj72RlOFsE4cPIU0TejpxkphOR5V3dnp00ASfByQS
	zeTxHPSkg/iHLWXSx6XknxEWFmYK+tqRfESTwx+aYqemAu6F2MTLsYEoEOzSg6jo
	qaEvR+0odMqEfeyVpqCPxuNXz4xMfe+v+WHxyKDizmL5/ROujZ8QeiNxUQaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758194522; x=1758280922; bh=TuONL5e3a/q5HMiQsTmfxQteh3y7sUS+8Gf
	VC1rNLv8=; b=fypwkU8SiBjDmJ8FHg25oW1ZtzyJQE+xe8G1ntFcWIk6yq9bBAt
	msszl5e9W+lPOSBPC+aJKRLTP4ACBxCOboP+Pbwsz7aSkZhCBt6X/+WiPbjKM2QC
	v/vs4rU3Z3faxnWzuS6FHXrxdPRV9qbAeKhU+d5Oi3FGd18yCtSELd+Bv1fQd8Gx
	ZlveIEWtD+BOHoMJexWZuF6ezk6mj6WcC+NirSgavn2JMVpo/GnRMSYKlVcLCnyT
	I1mNYBCFTmim3GzXw+DNTob0kzldcsH+zYB70d421/LMEodiUlaysXHhFLn1bwlL
	5iUTZ4ePBU8Q0g01ohI8Bo00SFd/aTE6NWQ==
X-ME-Sender: <xms:WevLaElGc6u8MsRm3FcGLgpe7ZPEv0a7oqKJFGsSkMItBZi1-UzOhw>
    <xme:WevLaOuegiDUD-YZyGpDkUigf4uV9SrDVE6t9Ek5FQT_-74s3gWeWNlTJQLdu4opz
    -jbljBUqctmIxtl5zQ>
X-ME-Received: <xmr:WevLaM0Xb07THI-cGYF7KMb7GURu9NC6IvrH66ajh1nNq_6Z6Y-U1RZc8Kmi9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpehkihhrihhllhesshhh
    uhhtvghmohhvrdhnrghmvgenucggtffrrghtthgvrhhnpeeivdejveetueelgeeiveehve
    duveffkeelkedvteejiefftdekteevjeejgfeuffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepug
    grvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhughhhugesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdprhgtphht
    thhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvh
    gsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:WevLaCSOqrsU5J7WwB6P18Ki2gVViuhU94_5syI1NReipkFQPQsMCw>
    <xmx:WevLaItbu6C3-rdqsPD_3OKHAxFJ8P-c_5kF_XqOyQ0HilYNnu9vSQ>
    <xmx:WevLaALi1ZBrhUmc9dGCo35R29gxtHBiKPYufVquzSsT0I-i9XHbNw>
    <xmx:WevLaMfQeJdHWzwvwsQSqRp6glinSxHkefTTfm52TBy4ugrr5SV0Fw>
    <xmx:WuvLaM0uh74Z0_bun45mSjdRmEHzM-YNot_rti55JUoF5XbYUYQ3QEKq>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 07:22:00 -0400 (EDT)
From: kirill@shutemov.name
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH 0/2] mm: Improve mlock tracking for large folios
Date: Thu, 18 Sep 2025 12:21:55 +0100
Message-ID: <20250918112157.410172-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

We do not mlock large folios on adding them to rmap deferring until
relaim. It leads to substantial undercount of Mlocked in /proc/meminfo.

This patchset improves the situation by mlocking large folios fully
mapped to the VMA.

Partially mapped large folios are still not accounted, but it brings
meminfo value closer to the truth and makes it useful.

Kiryl Shutsemau (2):
  mm/fault: Try to map the entire file folio in finish_fault()
  mm/rmap: Improve mlock tracking for large folios

 mm/memory.c |  9 ++-------
 mm/rmap.c   | 13 ++++---------
 2 files changed, 6 insertions(+), 16 deletions(-)

-- 
2.50.1


