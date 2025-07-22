Return-Path: <linux-kernel+bounces-741285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB1B0E26D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AFDAC0637
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1103127E7EE;
	Tue, 22 Jul 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FRZCaG8o"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A46AA7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204255; cv=none; b=DmHk5jGlqHLN0ngZ3psUDugPIUImkbrvXh2v2Cwda/1L2c8DtCD6lgNTF3Ye0+Fyx+h8b0l67QUPf9DKLRNkk37YV3n/R1K5VO8ZylQU0pvpwU4tLCwfi19CIQke9byuXqMj7flZFsIte8rgYUOchcoB65it9M+zmgqfDNjFgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204255; c=relaxed/simple;
	bh=t1n5k4zWsS+yBT33V6fQJITfO4yqpkogfYtm5vbb1+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RYs2Cqy++Gyiw2ejKNJxGhXhNw0Vcq+ZyuCpoxEgaR5Hv3fFWnSdN2hobce794rhujR9vaJWcKX59MRzZ6YtyRkQ8wkEwnmaA0E7qIRRSEEyoT2tC2R9mnEpuF7gQWlT3LTSJ3DTTL8EX26NO7AZCCc00WmmYFQdOGmH2S/PRC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FRZCaG8o; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CE1FF403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753204247; bh=zAL/BL/suItRLxEPiWD7sA0wD/C+YIg7Gg6+n1fp0q4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FRZCaG8omvueYV75DwjSPVEa8AyXoHfCvGcvWlzNreJ7Gs/+dXkXCQDIb6+jSD2Bk
	 y3FSrZ82nHGa5/R76K5x+FVllV8+GspAXfTSEynPv7SQfDATuTBKHPMTzmcogDMNZs
	 uyKuATSLOMfGonockBKLvrVx8h6YPsEzAyD/AyH+E4JCW554NujEikU3KytYqgteLx
	 nhL+U/MwFZ8TU2LKgZsN9k6Zs/6FTsVSp9c4hVEHuImHM4Q5mPozf7Kef+t5dpVqCz
	 xsj5NzCFKjhczWbkzlP2Lhsi7UwwMS+a5J0e3XQ8N3m2oWxJ3pzwxXAvTEjhdE1jiH
	 HmYQDG5/oi2zw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CE1FF403E1;
	Tue, 22 Jul 2025 17:10:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH 00/11] Various trees,shell files missing the shebang line
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Date: Tue, 22 Jul 2025 11:10:46 -0600
Message-ID: <877c00f8x5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> This is a human being with flesh and blood.
>
> Shell script files were missing the "shebang" line aka shell interpreter.
>
> Note to Randy,
>
> This is for your spare time Eagle Eye stuff, if you could...please.
>
> Oh, I might have inadvertantly added some harmless blank lines too.
>
> Bhaskar Chowdhury (11):
>   Shebang line was missing,fixed
>   Shebang line was missing,fixed
>   Shebang line was missing,fixed
>   Shebang line was missing,fixed
>   There was a space between bang and shell path,fixed
>   Shebang line was missing,fixed
>   Shebang line was missing,fixed
>   Shebang line was missing,fixed
>   Shebang line was missing,fixed
>   Shebang line was missing,fixed
>   Shebang line was missing,fixed

A bunch of patches with the same subject line and changelog isn't going
to help anybody looking at these changes later on.  Please, for each
one, come up with a proper, subsystem-specific subject line and describe
the actual work (which file you changed) in the changelog.

Thanks,

jon

