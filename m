Return-Path: <linux-kernel+bounces-827377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD60B91948
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CF1424635
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103501A239D;
	Mon, 22 Sep 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cHpxZmbi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCB19B5B1;
	Mon, 22 Sep 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550069; cv=none; b=VhQbmRuhyinxN6QoXIBn2dQZpVzf0mvkRGMbOimsm1bvA1dnpzpdzvCa1wVLK445b4MYY6e6lVS6Q7SqEViICehATC7oSP9f/A1HcRDSgmskOX2zCLdaIQV/C3p+5t8DeYgz06HPyQWEToI1ingqPIOgPmkxF1i2uBNv+Nvc4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550069; c=relaxed/simple;
	bh=BPPSz6hzNxw/BkOQj3BI4PluIp4XPrI/5Q/keFRiJao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nn84MM4KZRX8faQKX5q7oELg24z5PLuxs7OF7+x8IrcnSV3cwgNZqYgOcbqTINamiDwboORV65/NoC3qWpzj+44lhu5Qs0XiOUUt73F3KgwomfCv67ewY6sGaODGiX/MJinwO2FSZYyDRH37hgDzsVRCwcW47bpGsVgkOPO5vx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cHpxZmbi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 205F640B14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758550061; bh=wrAKOb4Dg8BoryMsjaOuNWjedqWrjt9a2y1SFMZMrPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cHpxZmbi1aAcGM80yOEoIa7Q9NnjdwGu0/ooI4yLoFhwAad94UPyUEYhFLsqsK41r
	 j3TgFTzSbxC5OCLHg/Cb4CPGj4LlPTCiCc8kOUjaI8xouz8FUsFZZ60srJfX9Dz8G4
	 8O97E0XyIJWMBi2qBMZjDtrnKMMfPyw9sbYFMPkWMpREY4qb2BJ8V5LFPfFInulrUA
	 0DZ40liVLS0M63af1JPomG1YFBJGW7rtfTt8EIX2nT/g1oPzQyO/fmAmQyrLZJ0oYi
	 +jSRCprP9C91D1c3ms/hNF1HPJA+X8xhvsmmj/bQ/xpZaUgKRECuSkVAQ76vGoj0Bk
	 oWH2usq+io/Dw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 205F640B14;
	Mon, 22 Sep 2025 14:07:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>
Cc: Dante Strock <dantestrock@hotmail.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation: process: Arbitrarily bump kernel
 major version number
In-Reply-To: <ff092ff5-8ee1-4e91-b7f7-e5beb1d6d759@gmail.com>
References: <20250922074219.26241-1-bagasdotme@gmail.com>
 <87h5wu8x7o.fsf@trenco.lwn.net>
 <ff092ff5-8ee1-4e91-b7f7-e5beb1d6d759@gmail.com>
Date: Mon, 22 Sep 2025 08:07:40 -0600
Message-ID: <87cy7i8tsj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 9/22/25 19:53, Jonathan Corbet wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>>> The big picture section of 2.Process.rst currently hardcodes major
>>> version number to 5 since fb0e0ffe7fc8e0 ("Documentation: bring process
>>> docs up to date"). As it can get outdated when it is actually
>>> incremented (the recent is 6 and will be 7 in the near future),
>>> arbitrarily bump it to 9, giving a headroom for a decade.
>>>
>>> Note that the version number examples are kept to illustrate the
>>> numbering scheme.
>>>
>>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> 
>> Just FYI, I've pretty much shut docs down for the upcoming merge window.
>> I'm probably not the only one.
>> 
>
> So it is slated for 6.19 then?

If it's not in docs-next (or some other subsystem tree) now then yes, it
will wait another cycle.  We are at -rc7, after all.

jon

