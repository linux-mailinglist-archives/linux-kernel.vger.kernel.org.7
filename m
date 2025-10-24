Return-Path: <linux-kernel+bounces-868967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CDCC06997
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6E95505E08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92C31DDA9;
	Fri, 24 Oct 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QsSxPSxl"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3A31AF3C;
	Fri, 24 Oct 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314363; cv=none; b=cx4/fptbDkmIsg4oc/yFA1q8Yzhqsh1u1ci51ZqouxC9CXLstgHQvZ1NuN0YW8vG9eebynXIuXsG6bkCvW+iVd59JmchjZ2YGXkFi+fPGZiwUu7QGhwr/lw4PsOWAkg23j0emCzthgVllQVfiGUhY9JUpawDHMvZaeJycdD/zY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314363; c=relaxed/simple;
	bh=ofINEK2u/IpLS0SIBjgT0R2qzRiKMaV7PqEs5j3ep10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rhRtEve5s1DdZ0D06Sm5HOSg3ohRahiJ1SQhz+lqvD35jid7McshsanPdH/zzniDDndAyhj6WOUPUcy4tJgryJJwxB7sb2k9UusmkM32XjE0cSg35sxWL/jMQPnWv2EMdfPSj0nivljq5smatx09a5MvHbV+7tgT3E6xX+/7EoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QsSxPSxl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7A72240AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761314360; bh=dRERUy6Vb2iKFJR8a5MnKY1kS2D1WEjXXzuT1Iiq7pg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QsSxPSxlEXnisRIOFuRDTI412GRLNOCbm0htdMZSVpbTacg/AC9CpMH2q0tQxoMXY
	 cxrbEupVDK8dzTYoRaxr+3iq6s9q2KvGISAAjL7hMuYm/ijTb4whUZX5qzYKwGEC+V
	 iD9CnJ9C+x14m0nWhpptYgh9UGVmkowwU97ZOyNB0Rrn0q35829G/c5Fg9pD9AhzAq
	 254WAupHXK++MBDKX/e1RW5dh2hvYsd83yBeEyJ6payp26lUeTm2g/MkE4zsHe6coe
	 ZqyfF/rdMNGegT55mH5P3EKbiZQXrvpJPBMl/qJEh6zW/hFe9a/nHHLKJ+kNqOnzHR
	 JrndRvoMP6knw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7A72240AED;
	Fri, 24 Oct 2025 13:59:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Jani
 Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 00/10] Collect documentation-related tools under
 /tools/docs
In-Reply-To: <532dcafa-08a8-4e18-b904-53e061734b69@gmail.com>
References: <20251023161027.697135-1-corbet@lwn.net>
 <532dcafa-08a8-4e18-b904-53e061734b69@gmail.com>
Date: Fri, 24 Oct 2025 07:59:19 -0600
Message-ID: <87y0p0ieo8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi Jon,
>
> On Thu, 23 Oct 2025 10:10:08 -0600, Jonathan Corbet wrote:
>> Our documentation-related tools are spread out over various directories;
>> several are buried in the scripts/ dumping ground.  That makes them harder
>> to discover and harder to maintain.
>> 
>> Recently, the idea of creating a dedicated directory for documentation tools
>> came up; I decided to see what it would look like.  This series creates a
>> new directory, tools/docs, and moves various utilities there, hopefully
>> fixing up all of the relevant references in the process.
>> 
>> At the end, rather than move the old, Perl kernel-doc, I simply removed it.
>> 
>> The big elephant lurking in this small room is the home for Python modules;
>> I left them under scripts/lib, but that is an even less appropriate place
>> than it was before.  I would propose either tools/python or lib/python;
>> thoughts on that matter welcome.
>> 
>> Changes in v2:
>>   - Rebase on top of all of Mauro's changes (the most painful rebase I've
>>     ever done, I think).
>
> I tried to apply this series on top of current docs-next, and several earlier
> merge points, but haven't succeeded so far, even with "git am -3" ...
>
> Where am I supposed to apply this?
>
>         Thanks, Akira

*Sigh* you're suppose to wait until I get my act together, I guess.

It's amazing how hard it can be to properly rebase what seems like such
a simple series.  Lemme do it one more time, on *current* docs-next this
time.

Apologies,

jon

