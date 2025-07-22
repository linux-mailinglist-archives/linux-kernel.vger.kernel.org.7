Return-Path: <linux-kernel+bounces-740752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF4FB0D89D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D4169E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637812E4259;
	Tue, 22 Jul 2025 11:54:53 +0000 (UTC)
Received: from hs01.dakr.org (hs01.dakr.org [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A72E4270
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185293; cv=none; b=DXueovdSmRN6zhkBbaLh/8ffKC9+u+efinkw68AuU0Z+zqXe9L0wkd9mOGT7AlRMz8bXMX/TISGJFyqm/rDSmKNOwQO85B0jV+hPzNe+3ywrhX770KQIdPBlOrDIszVM/YDs7EN1yovTKrgpYVkXGrGUA9Non5I9cfkBmYQu+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185293; c=relaxed/simple;
	bh=xEqdm+sQv2ZkI+2l9UOdpVbsMDF2QWzk37cj/CM6EZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/FY1dDktAbLORUlgvBNaYr4w7N+BA0ZEOt5vp0JM9RBT8ikbNpVMe7CJAyrEVYcBPW5+FLwTXubGA/WCM88jBRMSq1bDh1fgpv3Nv0KhO60Nbpoivjx8kVPyzED5auSw2BEhLYyevk/m9DoOsxyQWA2wfooGp+UKsMBmCyzRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Message-ID: <2e94329d-04c7-4cd5-bce4-235a81db214b@dakr.org>
Date: Tue, 22 Jul 2025 13:45:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
To: Arnd Bergmann <arnd@arndb.de>, Satadru Pramanik <satadru@gmail.com>
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Arnd Bergmann <arnd@kernel.org>, Dave Airlie <airlied@gmail.com>,
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@nvidia.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 Simona Vetter <simona@ffwll.ch>, Timur Tabi <ttabi@nvidia.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev
References: <CAFrh3J85tsZRpOHQtKgNHUVnn=EG=QKBnZTRtWS8eWSc1K1xkA@mail.gmail.com>
 <aH9n_QGMFx2ZbKlw@debian.local>
 <d5010230-b718-4770-b731-f62225f1f808@app.fastmail.com>
From: Danilo Krummrich <kernel@dakr.org>
Content-Language: en-US
In-Reply-To: <d5010230-b718-4770-b731-f62225f1f808@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 12:52 PM, Arnd Bergmann wrote:
> On Tue, Jul 22, 2025, at 12:29, Chris Bainbridge wrote:
>> On Mon, Jul 21, 2025 at 08:22:48AM -0400, Satadru Pramanik wrote:
>>> Hello all,
>>>
>>> I suspect this commit in 6.16-rc7 has broken acceleration with Mesa's
>>> nouveau drivers on my machine.

Thanks for the report!

Please make sure to keep maintainers in the loop, for some reason I was removed
from the recipient list for this regression report.

>>>
>>> glxinfo -B reports that I'm using llvmpipe.
>>>
>>> Reverting this in 6.16-rc7 restores nouveau acceleration, and glxinfo
>>> then reports: "OpenGL renderer string: NVE7"
>>
>> I also bisected an issue to this commit. On my laptop, this commit
>> results in an intermittent desktop crash (Xorg segfault) when changing
>> display scale, which can be more reliably reproduced with:
>>
>> for x in {1..100}; do
>>    xrandr --output eDP-1 --mode 2560x1600 --scale 0.5 --filter nearest
>>    xrandr --output eDP-1 --mode 2560x1600 --scale 1 --filter nearest
>> done
>>
> 
> I won't have time to work on fixing my patch before the merge window,
> let's just revert it.

@Arnd: Yes, given the short timeframe I think that's the best. Can you please 
send the revert?

