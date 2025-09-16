Return-Path: <linux-kernel+bounces-818012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0450B58B95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3DE7AE9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADD22422B;
	Tue, 16 Sep 2025 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heyquark.com header.i=@heyquark.com header.b="Op0/4x4X"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70F1A295
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987838; cv=none; b=KG6Ydi8kR8Sk6h6nzp55vr9XvpmV8thkUbdE/381y4djTrMNsKq94nZf14Cq7MqU04+c7MxyPiEtWKDgggJENdeKvOARrxnyJensiwguJeOteOFTOHayIrjj5Hqa6QUFeX3/jycSXe8aYJOK9xkmb2o+x4aNmjztaM/W3PAD5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987838; c=relaxed/simple;
	bh=FgxDkQGwEwVbfgZHHscPbiP9oLrfgEf7RXxKz/Rv96A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssV0Yy53fcBU66avNmIMTjHeDKtjy7c3VzGyZqWQ7nnH2BGK24g3wCleRXrtyVpsYqOuXcgZCfoX2PQsSyVkDZKbzlRmnjCjwCSa6q2DSMQbLjQ2PElbsod1aCZbgf25I93YKzZEVk1ZlJ7zcbt8WdjAtZixij/BLaetmAQOnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=heyquark.com; spf=pass smtp.mailfrom=heyquark.com; dkim=pass (2048-bit key) header.d=heyquark.com header.i=@heyquark.com header.b=Op0/4x4X; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=heyquark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heyquark.com
Message-ID: <11e667d6-2210-47f0-a9ec-a134a60e138c@heyquark.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heyquark.com;
	s=key1; t=1757987830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vre4VQdls+C6Fg3+3Ay6LAhZabA5fF49M2ujQWAzVo0=;
	b=Op0/4x4XJ5x0+J+qr5sJ60cG5jP5EnaIQDUlXmonQR64r8S5O5rmQQ1lj2Zw4CPEUVmg0q
	g6Vl5Sr8zZ+We27APTCUqWuUvu6z7UGgQ1ZK0y2hDgz5DCgGAOFmZkxAkM9Fo/6+/DzxJc
	ImNn2O1iuk3qg2u69HVTKjaKqPdR3V/6ZnI/9qp2L4dDg/mXdfYVMGsvfcs/hbTFxtn2H6
	WbsgllneruKh9bNDGUfuLSeja3E6Zuk2JLcJd9jPVz8PwagQKAG0SxMh+BhZHz7vnNDbgl
	9KHx87PJl/A/NAniPpiYLoggz0E4uvxRVNJEz27IZuh4qnMPi0GcfFcxxvPJ0A==
Date: Tue, 16 Sep 2025 11:57:00 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 32-bit HIGHMEM and game console downstreams
To: Arnd Bergmann <arnd@arndb.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 officialTechflashYT@gmail.com, "A. Wilcox" <AWilcox@wilcox-tech.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
 <432e049f-886d-4734-ad59-52569a796046@app.fastmail.com>
Content-Language: en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ash Logan <ash@heyquark.com>
In-Reply-To: <432e049f-886d-4734-ad59-52569a796046@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/9/25 23:52, Arnd Bergmann wrote:

Hi Arnd! Thanks for your reply.

> Like most other machines, this one is probably fine with a combination
> of a custom LOWMEM_SIZE setting and using zram-highmem, even if we
> end up removing support for highmem page cache.

Good shout - I'm now testing a 2G/2G split which allows for 1536MiB 
lowmem. I know that's a somewhat aggressive setting for userspace, so 
we'll see if anything breaks. I read Rasbian shipped similar kernels and 
had issues with Wine, though that's not a common use case on PowerPC ^^

> The smaller devices are probable getting problematic sooner, 96MB
> in the Wii is already really tight and this only gets worse over
> time.

The maintainer of that downstream claims to be able to boot modern 
text-mode distros on the GameCube' 24MB, which I find really impressive!

> Just to be clear: there is no general 32-bit deprecation going on. When
> I talked about phasing out 32-bit platforms over time, that is purely
> going to be those that have no users left, or the few ones that are
> causing more work than they are worth. E.g. The ppc405 ones got
> removed recently (after many years of discussion) because they were
> making ppc440 maintenance harder and had no known users.
> 
> Highmem does get in the way, but unless more -mm folks make a strong
> argument in favor of removing it all, it's more likely that we'll
> go with Willy's suggestion of keeping highmem on page cache (anon
> and file mappings) than just keeling zram, and even that would
> still work.

That's good to hear. I would like to have the page cache, though I'm 
still going to try and maximise lowmem as well.

Thanks,
Ash

