Return-Path: <linux-kernel+bounces-813235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A00B54262
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B983B3256
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D6927FD51;
	Fri, 12 Sep 2025 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="k+GTp2jT"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CF27FB2A;
	Fri, 12 Sep 2025 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656838; cv=none; b=bYrOeMlxrNTbV39Rvx2prXck/OH23ieb56VmCwXVkmT6yrIBPSaR/prENKyA/p9x/fTBrTkfJdXJQd16tohTiYLCAdlqr7HAbxJ4gvjoLFmVFXEKox7R2VK0i8WlDO9oe8Ab953qByYlMUkwg8Yqw5ee32rW93L+z0wf4FNs7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656838; c=relaxed/simple;
	bh=bRRpWfZkBP84qqR11V7OO0VP/NNBzl15kipJhHZCBZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXqnyf+/vko87/UdOByPUP+oqnE6O8o4DLdCwF9HZv3toAUjLfgzup23To2pB6+BbaTfRiYqnE1fYh7lhHbOqhEaXaAzFyXkVzFUhAvh9IXTKpQ1SGKlLNl7xEJzWQH2DvuefHb4GbIl/pygmr+LIljJYMKIuq4BE6pcCRCWVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=k+GTp2jT; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757656819; x=1758261619; i=markus.elfring@web.de;
	bh=PNBRq35TmhAY2KL78JAmIw+p27LY239sDzoMTJ3S5ns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k+GTp2jTe0RUkmTTSQGGdH2wuVJ0L5WtA60dx9AA4B6K605HM6XQyuZX7HQgkhhp
	 tpMJQcnsICPN8ZjZWnGb3y7pBzLJxKRp4S+V+5UdtuX7eIYvS7Co6xd4k51DW55ZQ
	 8jkedvVNDSU0hMtrp3fuUtic/rKEOMBTlxcA+L40qhhAJEz7Z649qxQLFIR8WXHQJ
	 VDXem1XDCo58WdAPfmVRoYyddUsUJBmPhwz7pw2LNc748quQ95n50xYWm6dy6nQ/1
	 /ppALhbddw9jZVw96Owg7E09tmydchZ09v55GXo6bnI0BFRfgNgur/Tl+lpMRB66d
	 CSAzGAdDUc8aaJFzqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.219]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyO0s-1uDlhH1msG-00voTF; Fri, 12
 Sep 2025 08:00:19 +0200
Message-ID: <b89eda12-c930-43e8-92c0-c2e1699284f7@web.de>
Date: Fri, 12 Sep 2025 08:00:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: trbe: Use scope-based resource management in
 arm_trbe_alloc_buffer()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Leo Yan <leo.yan@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>
References: <3663eb06-6a98-461b-8fcb-6891165d107f@web.de>
 <3f2137d5-5bfc-44e7-9269-3069e44eda31@arm.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3f2137d5-5bfc-44e7-9269-3069e44eda31@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ROLkD4ppWa0eZgi33BI5e1vHecWSXWhdafQxUhhYhyZFT5Iqjv
 0+qnuQz2XfORRDr5xT+GALBkYxgwKs3GXQRawRhJEu0uxl+SrfKoftQOoVy+UEQ3y8kpZLC
 iiQ89vTdQEN5cSBVXBjFNYDnmSMlusuWDnSxppNTt4m9mxFyW5iABe0RAdUv/WjzWq5xwyN
 VUR0Xl0yy/xOpWZQHLh4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eGZ9mSanpnY=;lvcCsd+HGDAwvIfSnHYnoX8kGQK
 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
 cFaN4B4=

>> Scope-based resource management became supported for some
>> programming interfaces by contributions of Peter Zijlstra on 2023-05-26=
.
>> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
>=20
> 			^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> SHA ID here just needs first 12 digits not the entire string.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n109


>> Introduce __cleanup() based infrastructure").
>>
>> * Thus use the attribute =E2=80=9C__free(kfree)=E2=80=9D.
>>
>> * Reduce the scopes for the local variables =E2=80=9Cbuf=E2=80=9D and =
=E2=80=9Cpglist=E2=80=9D.
>=20
> What is that required ?

The needed variables should be defined in a succinct way.


>> * Omit four kfree() calls accordingly.
>=20
> Right.
>=20
> The commit message should be re-written with little more
> context from arm_trbe_alloc_buffer(), after describing
> the new scope-based resource management.

Which background information do you miss so far?

Regards,
Markus

