Return-Path: <linux-kernel+bounces-775835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B36B2C585
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C54CA059DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE833EB1E;
	Tue, 19 Aug 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XYdd0+mL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF332BF29;
	Tue, 19 Aug 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609672; cv=none; b=fIIQ9Nva8iHN1dkIOvXZBnAfT41rqonVxFUIMtNva2b+n+xQH4fYqlTgscNH+65gsmtyPUN9fZ14WohK2T/X18L1A6j/hAo/ALIAdLegBebp80J3xAcDNh4G7vz9hBd0OAZ0Q1rGWmUknE+VYRSunra5IQM9SeExNnyRZvKrEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609672; c=relaxed/simple;
	bh=E4SaG2YnUo4NG10JAD9E7nMioi1BFmyERGD+gQPW8Hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J1HlcCzrAsShufs1kvKlmoZFhioj/qEYagI8VIoUFvkhEkuvSn3NFul1npYp8Ij4yZHD5fm2+BB571FJsElvkb85O0zTQEzmH4/YGyDVspdapJllkzYNkmSfa4/n2Lfukd3In3le1678+zQrmqiY4GqNJCcWIUqShn8Zs/kywLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XYdd0+mL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 74A9440AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755609670; bh=Ff91uUxiD23SHGk/G+5qDFQQGPwsJuNZWKli8q4KANU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XYdd0+mLD3zynpIqjnUQBsIuZZBDhd4SMX5pw+JI3ip5NGYldKqpCpxw3rznCBiM5
	 0WZPw9P/UNBgF9JyGCyVdZqxUelnqgDCLwzMBoiUd3qtTgqCwRnvOTOAXL6anOGCKZ
	 ki7vX5LoBPBsM8fcNaXZqfnol8YRsXATzTRYq33Z8FFG5WeEG4kC5jqICTz9S1JyDX
	 /SNeGdSgZPJoxmGODjaD8bk8hVFC5EbQ8jq/aOQUd8/I4RNAtEaoQBa7dwNZ0Gl4ov
	 PRZyIyJk/Hfqhq9plT+6c2rkHYcaKKfYwQVCU9riPSIJgw9cFVexpLUhl9dfj2pJQ7
	 BVBBSmprI1qdw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 74A9440AB4;
	Tue, 19 Aug 2025 13:21:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 1/1] scripts/sphinx-build-wrapper: allow building PDF
 files in parallel
In-Reply-To: <19f031e5-0060-4957-8cc8-9cd21e7d6304@gmail.com>
References: <cover.1755540431.git.mchehab+huawei@kernel.org>
 <26e5efca73dbd2f863a51018054a749c9e5f5a19.1755540431.git.mchehab+huawei@kernel.org>
 <19f031e5-0060-4957-8cc8-9cd21e7d6304@gmail.com>
Date: Tue, 19 Aug 2025 07:21:09 -0600
Message-ID: <87h5y3v456.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> I couldn't test this because I couldn't apply your sphinx-build-wrapper
> series on top of docs-next.  :-/
> Which commit does it based on?

It is built on top of the PDF series - I ran into that too.

jon

