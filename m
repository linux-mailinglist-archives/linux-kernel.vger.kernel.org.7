Return-Path: <linux-kernel+bounces-784540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B708B33D24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9A03B7A90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B82C3756;
	Mon, 25 Aug 2025 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bjFU0Vmz"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020C2D979B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118924; cv=none; b=uEPyeH5SKIlC8hapBpP6a3NvSmaholiLbzhsWKndO5y+637WM52HTaIvxcp4suNyBvFBk2nRSdWACyPgnr56M+zri9MWt+L98nEw/HftrT0nSvnl2fiSPSoppVjDQryATkCT4NkScV6TBbR5z+ZpovkhkvroWtjQouE6sh4dSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118924; c=relaxed/simple;
	bh=wabKQd4DE41XkR0sN/uAtt6QH6z+U/z7ulwnz6qzfIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3TYdFE7n9L1o4XPn7ESbA+TBLtV1WzX1RkseLAI0EZCFQF93udJ1CBd0OWC5XVl5ajikEnbiWBnWOAxpMniBaAo4C/yScrD8oQxS8YGY4jIIIrrdO3vOoxY+9ylKNF8FVpRj4A2DkQQV20AI4jI/RLezIiWZCoZZChbpBlKZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bjFU0Vmz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756118914; x=1756723714; i=markus.elfring@web.de;
	bh=wabKQd4DE41XkR0sN/uAtt6QH6z+U/z7ulwnz6qzfIo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bjFU0VmzSegoytbc96sJ7XBUvcdMuOTnXPNI3GTm7j/u2wAmw5zKMV4noG6pA4fd
	 RURdfO29OPVrcVwfst7DjZd2Uu0rugL27RFEvAGpGIMmm1T92Aq0jW3pBaH4Liqgj
	 Lg+AtnX1b0S+y408ZRwAF2YcUKanYSeESpXsbp3TyZhjjLTeSNUqZRZRYa/RBMzpA
	 CZcgWvSdAZoooyqrLqQqSY0cPJjtV1iEVktVq9HsdKOdPb5BXa8r9CKxyYr1ooPe5
	 1+1+RXT/pnMc3lViRHALtqIZcrLvKbtq6MUjwLB2QXliKIzAe9wlT4wjpxFfMEn8D
	 n9d7siFCsxy0nZ3hPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CQh-1uPRDw3vTJ-011XI1; Mon, 25
 Aug 2025 12:48:34 +0200
Message-ID: <697bb91b-24ea-4830-8794-373f709aa37e@web.de>
Date: Mon, 25 Aug 2025 12:48:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/sched/tests: Remove redundant header files
To: Philipp Stanner <phasta@kernel.org>, Liao Yuanhong
 <liaoyuanhong@vivo.com>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20250819142630.368796-1-liaoyuanhong@vivo.com>
 <acb4e709-a42f-4591-a406-7745bcd0422f@web.de>
 <119cb44579d745ad3e47d649e6ee6fea9fd9d146.camel@mailbox.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <119cb44579d745ad3e47d649e6ee6fea9fd9d146.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6gKGYGUplaIJxBQreSyssaIBngSiTzFnHMt7//DE487Rg2cg3hM
 PHlE4hJbLIVxieWnFZJM51OkEYALP9gjSZ7nlLz8aJ8pP5ZAKgEWiD/EJ5Awh+nLL1Lt+en
 6Q2zHPBlv95NeQZcwQoU2Hg7mvgQ34+Mka3m8ZNOCsqRw0os9+PT+s23Ao5NVzIGDTWO0Fj
 WwTc4UV16wD3IdFeuh94g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+6iI7sVEhkM=;2w5MutURVU5tuXV3NU+64bWVI21
 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
 lsb7rks7E+lslJaITCdnGx9MBO6UkyjAZt1By

>>> The header file <linux/atomic.h> is already included on line 8. Remove=
 the
>>> redundant include.
>>
>> You would like to omit a duplicate #include directive, don't you?

The change intention is probably clear.


>> Will a corresponding refinement become helpful for the summary phrase
>> and change description?
>=20
> I don't understand what you mean. Can you elaborate?
>=20
> Both patch content and description are completely fine as far as I'm con=
cerned.

How do you think about to distinguish better between the deletion of heade=
r files
and an adjustment for a repeated preprocessor directive?

Regards,
Markus

