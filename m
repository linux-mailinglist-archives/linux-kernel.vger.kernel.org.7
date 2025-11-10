Return-Path: <linux-kernel+bounces-893133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 049ABC4696D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92D74346960
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F52FFF8C;
	Mon, 10 Nov 2025 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hktgAA1f"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92095CDF1;
	Mon, 10 Nov 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777706; cv=none; b=LoOnMIQe7d8Hzz36UVORk9oZzN+o4BJdi4a6VuhOChDJTVG/CHW8P5dB5jzLzUA6BeEKuf23tqHogGZRcoeixuY7rjNCFoCXAoPh8KVIDdklF9C+hP9qj0q8yywefyCH/mai5+rl29/mqhweplY0hRhAHF8q1gDrplGMRkpx3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777706; c=relaxed/simple;
	bh=9gauU5H7P+yTcvy9uIPtEhjqpw4kBXqmKao9hQUUv8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMkXiOiZEpRepyrdsNSxf1QT1mm6q71NH/Lztr3FglB+LaeqmyK3qzmTwyJA/UMLI98IRpv6C9O2XYmM6aLbPy5V8OaRzRyXlanrrfzXEMkZT+MZQu6TaCwe7+34/jOFJxhhBKRCWuWZczoRdrVaT0HKgEaSvkxnHNQIsi81Dz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=hktgAA1f; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pQDBMcobExT7gFh2edKrLcNt/mHLpqXOb1P1QSqrTks=; b=hktgAA1f8D3Mm49ekjTzPMvrcx
	BlTMEivl3tiAIRsACGBNMsxHW7KYH1FDnB5UrTln3ScOGEWUNCTtTMOYz2jKSO6dP2PkbWIwVmm7H
	aj7C0568Yhx1FPxakoz/3dE/GLXDoaYPxfzFj6nsT5HxTfv49cT1IG4OSMevZ5I5gmbno0eZyh0L5
	Y1mkyrrW1IO+nkX1AERsOQVkTL+oAIIbbaxdH9LYcAUAEJDK7fT/pUzKaTh7KrfwX2n0womRdqBSc
	qp5F7pLorlonlR4ZS1VN8G2CGf7JCERvyC0cnjvtYj3S+Cf0wN+7C+DCMJbMEsaO8AT51L9Tk5sQt
	RwUw4U8Q==;
Date: Mon, 10 Nov 2025 13:28:07 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add Fitipower FP9931/JD9930
Message-ID: <20251110132807.1ceb82b5@kemnade.info>
In-Reply-To: <83b3dbf4-0916-432b-b46f-bf459ce264f3@kernel.org>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
	<20251107-fp9931-submit-v1-2-aa7b79d9abb6@kemnade.info>
	<20251108-vagabond-lyrical-hawk-ad3490@kuoka>
	<20251108152114.53422ea6@kemnade.info>
	<aa330123-e6d9-44ce-b030-b266cba1df9c@kernel.org>
	<20251108175244.0b51fac6@kemnade.info>
	<aa54cf7c-cabd-490b-9bdd-a7a077ced35c@kernel.org>
	<20251109221212.182d7862@kemnade.info>
	<83b3dbf4-0916-432b-b46f-bf459ce264f3@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 08:30:41 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 09/11/2025 22:12, Andreas Kemnade wrote:
> >>
> >> You must drop ref. That's the entire point of common unit suffix.
> >>  
> > I tried without it:
> > 
> >   fitipower,tdly-ms:
> >     description:
> >       Power up soft start delay settings tDLY1-4 bitfields in the
> >       POWERON_DELAY register
> >     default: <0 0 0 0>  
> 
> Arrays are in [] (see also some examples of arrays in the example-schema).
> [0, 0, 0, 0]
> 
> And then it should work, but does not which I think is bug in dtschema.
> I think it works fine when you drop the "default:" completely, so please
> do so. I'll take a look at the issue.
>
ok, dropping default makes dtschema happy.

> enum should be in one line, btw.
> 
> Your patchset has also blank line warnings.
I fixed the ones shown by

checkpatch.pl --strict

are there any more I am missing?

Regards,
Andreas

