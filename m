Return-Path: <linux-kernel+bounces-858736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B83BEBA10
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9551850147F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C652F353217;
	Fri, 17 Oct 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RlHRXSu/"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46334EF19;
	Fri, 17 Oct 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732025; cv=none; b=L8JoQFkN2/X5fw24zpxqpUTvjDzPCz7QVN0PyzJ3lDwc3XsDxuyV/ZGpmMxMTWo/H5umL/IjzEN2Y0LgzDXvjLgdfPyPT03A0a1fF1BwJ3dtE+Xgu2fC8K9AvoIXvcrCkDV7L4AAgm063dIiqGAwz3k/8yKVVBk/3QAQWQMJeOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732025; c=relaxed/simple;
	bh=fg/aDgFXGOW1dNkTiOLmBYlehTAOg3mQHbnGOOTiQNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E81W8re97RK0JfH6sOOws0R7OGeRmXWtue7OZmrOBwcnY9wHgyfYc/g4LBVjNNkthqr9aCQvo1jWMDdIZUvqCiZ/ekP+W/fHtkKTTDvC2rLoiIrryEvPD0RaMZVfVgZbIEf9RFaWq7cVLEd2ck+mKNx/kZ+UpdeXiAL/srPBAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RlHRXSu/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 17A0140B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760732022; bh=fg/aDgFXGOW1dNkTiOLmBYlehTAOg3mQHbnGOOTiQNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RlHRXSu/C6Qmg6jjJj7MOhPh4UeloffbfhwsEdrprROFeZfvehBI+NJbNsGpiLq65
	 je4cLA2BJbneMA8DyNwMunOcKcaOb/edV3NZqM5UVJc1dTedBH/ZgLCW6ekwmyoVVn
	 41tn7NFh7tPUJVnEdULCT3Qy5qYXEH75zQQZ0UMWvuxgydUhs/h4+1tuP9+cjC5dCs
	 yJtW+b6BhfUco/CXQugiaetRcWGPenPOy4/FbOhXep1ppJsiapclsEnIj4QsrEWLT1
	 w99JVYTgjnMsxKvf2QMt7sEDPBek6SDitWs9qffPQ3Ts0BIEJNUtA7ffez834UukgP
	 CaSCIdhM/+Gwg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 17A0140B1D;
	Fri, 17 Oct 2025 20:13:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v8 00/24] Split sphinx call logic from docs Makefile
In-Reply-To: <cover.1758196090.git.mchehab+huawei@kernel.org>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
Date: Fri, 17 Oct 2025 14:13:41 -0600
Message-ID: <87cy6l1e2y.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> v8 contains a bug fix for ./tools/docs/check-variable-fonts.py command
> line together with a new --deny-vf argument to it, plus addresses
> a couple checkpatch warnings. Only 4 patches changed: patches 1, 2, 4
> and 5.

I have just merged this series, along with the accumulated fixes, into
docs-mw; after a month of separate exposure in docs-next, I don't think
that there is a lot of benefit in waiting longer.

It still makes me a bit nervous, hopefully all this will work out!

jon

