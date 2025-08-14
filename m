Return-Path: <linux-kernel+bounces-768948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB0FB26844
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC378189FB66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789D2FE064;
	Thu, 14 Aug 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kLEZfiw6"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936D1E9B2A;
	Thu, 14 Aug 2025 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179546; cv=none; b=r3efDmE0v17EopTdTurHbzw5ZIJO8t1EutntT6A1UPr2jAPrN57osBByPptvJ2N9+91NI7CFgPnn0E0v61iDNJxSI6ufjg72tik39JrvB3pE28lL0qVDxom4SpbrLETetmRLmZfZEaw7n05jgktJGcUu19inFSmVtdLBFZKeE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179546; c=relaxed/simple;
	bh=H/ucUNltvWA/WNQ7vYUrWuJ/a+PdsIb2eVUVXAtMNqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OH2RJJMB8JUvSZlEMxPTASVGNrO01FEpJTznUTAyrhHvwjhNtBTqu71HEZbJBvsLFXJ6sHSWbEFrw4EUy+2hxOYeLGq8VlZpqJQOHaSPhLK95YBUckG96MDLW2E0LicR5ZlsadFpDkvBwpkkCroHnYnDmbLw0Ptbo7Was/wo7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kLEZfiw6; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D0D3B40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755179544; bh=dIIZeueswEIgOf/YgafKN0m66ZuMdvcw1i04wbyCAgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kLEZfiw668KanKXhgcHU9d/ETqcWCk9mKykyonNdemzyj7m+SPrCSFtIPyPun96Ok
	 ybRWmBWFyJdcTUsRMXFGM2taALmdaJRoqf9MyXcMCGoK4epK4uRkG6bEKXZcxzVAWK
	 G4Z5NgV8nJg+Qdep+qeqv8Ql81J75BN1JfesCo7tAEVJUizmoG5I5Md7xXEoLmx34w
	 QUo6Uy4dibhp+Ai5pW48Cvtyhnox3kteAfSKCfpqYVTsVNEtT5hHHShjEf/8HgmfvR
	 p+WAKcO2YKbgpUbmdvxRff7Y/9t4wXnB3OdJacXBLxRN+y/EtbHt99L33sjQdVKK1+
	 44dHNXfenty8g==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D0D3B40AB4;
	Thu, 14 Aug 2025 13:52:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
In-Reply-To: <20250814080539.2218eb4e@foz.lan>
References: <20250813213218.198582-1-corbet@lwn.net>
 <20250813213218.198582-8-corbet@lwn.net> <20250814013600.5aec0521@foz.lan>
 <871ppehcod.fsf@trenco.lwn.net> <20250814080539.2218eb4e@foz.lan>
Date: Thu, 14 Aug 2025 07:52:22 -0600
Message-ID: <87wm76f1t5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This series is big (51 patches) because it needs to fix thousands of
> broken cross references on media. I may end splitting it on two series
> to make easier for review, one for the script and another for media doc
> fixes.

That might help, yes.

> Such series affect this RFC as it is creating a tools/docs and placing 
> there the parse-headers.py code as:
>
> 	 tools/docs/lib/parse_data_structs.py                                  |  230 +++++++++++++++--------------------
> 	 tools/docs/parse-headers.py                                           |    5 
>
> Now, if you prefer tools/doc instead and/or place the libs elsewhere,
> we have a couple of options:
>
> 1. rebase my series to do the changes. I suspect that there won't
>    be much conflicts, but this may delay a little bit sending you
>    what I have;
>
> 2. add a patch at the end moving stuff elsewhere;
>
> 3. on your series, move them elsewhere.
>
> What do you prefer?

Between "tools/doc" and "tools/docs" I don't really have overly strong
feelings; if you work has the latter we can just stick with that.  If
you propose "tools/Documentation", though, expect resistance :)

As I said, my series was an RFC to see what it would look like; it did't
take all that long the first time around, and will be even quicker to
redo on top of a new base, whatever that turns out to be.

Thanks,

jon

