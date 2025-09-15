Return-Path: <linux-kernel+bounces-817685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C135B5855B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E4E48470B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF291FDA61;
	Mon, 15 Sep 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VAFTReJ8"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B72320F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964926; cv=none; b=bWcUd30SY1S9U7/PmKPlReNz2feSs9aPJqxcytZoCqhVZkI0wTf9HcV6f/dhq1YgA0Dev4/PF1kEQuQ9PQCeCcpIUVrFyEWV53ZG0EsCgFBlXRHmSy9Zc+H4/GyWPxYcP75pulwgHhzAIElcSMCUqZRhJaQsvJPf9ae7R1L8hsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964926; c=relaxed/simple;
	bh=qsrCux5uG5F+vFPb3AdHz26bygDHOMWX00ODfHuapU8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pbnjirNr9rwWCVJ5VqiKjrK6KbqbUjj+95kfSxPhVL3Lwm6w7G+YwGC0xYa2NnCWCi0z3nimcQz+rKMEjT8p+cashEfm5+vBzAO/5eeZNOISehx/Zbo/zZEe/b8yxu7faHMdoBnMoR18PEevUko8OlxR2m4R1etskO0zkBTDFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VAFTReJ8; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757964912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsrCux5uG5F+vFPb3AdHz26bygDHOMWX00ODfHuapU8=;
	b=VAFTReJ8dXyhRYmYyshNH34mb0cJQbWurGthvuslr3xAIwpo3yrMks1U0LP/WoKltzil2u
	nLTAlnj2sp+BRvd7ytYwhnSficd4bTwjCKasfmiO4LpnXdwP5//0jfoJnxpJUDh+X2aoKi
	LnrAlcV3EkTjVEd+4c898mq/NNkKjyQ=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] docs: maintainer: Fix capitalization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <c85881bd-a159-4bb3-9615-b87ce4ab0575@infradead.org>
Date: Mon, 15 Sep 2025 21:35:00 +0200
Cc: Jonathan Corbet <corbet@lwn.net>,
 workflows@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E32E7460-02E4-4E85-8482-E91D3FD12253@linux.dev>
References: <20250915192235.2414746-2-thorsten.blum@linux.dev>
 <c85881bd-a159-4bb3-9615-b87ce4ab0575@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
X-Migadu-Flow: FLOW_OUT

Hi Randy,

On 15. Sep 2025, at 21:29, Randy Dunlap wrote:
> On 9/15/25 12:22 PM, Thorsten Blum wrote:
>> The sentence starts at the previous line: s/Indicate/indicate/
>=20
> Are you sure?
> ISTM that the entire line is a "sub-heading".

Hm maybe, but then the layout/rendering on the web is very confusing:

=
https://docs.kernel.org/maintainer/maintainer-entry-profile.html#key-cycle=
-dates

How would that be fixed?

Thanks,
Thorsten


