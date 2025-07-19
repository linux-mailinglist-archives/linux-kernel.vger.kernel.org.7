Return-Path: <linux-kernel+bounces-737828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C46B0B105
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A30562FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB3E288C2F;
	Sat, 19 Jul 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="NTEPsdt1"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3242AE8D;
	Sat, 19 Jul 2025 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752945075; cv=none; b=qmHOZmpWFZlN0yXHmoGAsKhGUfhFtegCT5IY5sE2jAAFQm/n6aWGM3Pivk9qHScNBejTEanF2LEFndYILJXrB9hJGyteOPyo2BI6+tmRSb9rMz3WsJUxUSdx/EzTrxaOwFIqBDBaCFVJ1TrxxVG2Yy2GDIPo6WHETRVjC+MORMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752945075; c=relaxed/simple;
	bh=HHI4KQQvL86pW+ZxX2BSyPge5WGmclIv3uvMc0vhnsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaythhbDEpRKhboRKZ4+Fd3RAfCBqxR54YyToGYweXMtURY/TyOnU0ZOR4d0LiOsLNEQnK53r8CkugGATQ9x25CXLGqbeeBiLFaXX6Zj/WNfsxmGHFME5T9MGW0PnoqudgVK9TO2NFpp0MO59Wa25bfI4iRLwg+fAGKY1Jf859k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=NTEPsdt1; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id A7B3E600024E;
	Sat, 19 Jul 2025 18:11:03 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id dI7br0q4lzoc; Sat, 19 Jul 2025 18:11:01 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 999C16000856;
	Sat, 19 Jul 2025 18:11:00 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1752945061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Axx8W/LgHbcgJOf+Y3oMCoiRVKx3F5TuqXbiAOTJQDY=;
	b=NTEPsdt16juAzkU6lfdFAbXw0xKjy4z6gSs+ruNyEqSf4uUkCz9dDA0fcebsfrE6nKbVJP
	EO8mRC3NuN3ea2WeDj2UGWVDy2RdYTXAc2rf5P7M3TAHd1RHrTsmjCDfz7QoJ4Fcdqgd7X
	hkCVffxRLKdRykpUulo474TPr+iK3KA=
Received: from [IPV6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde] (unknown [IPv6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id E7489360083;
	Sat, 19 Jul 2025 18:10:58 +0100 (WEST)
Message-ID: <f0d300fc-0141-4eab-a888-d1d32778f5de@tecnico.ulisboa.pt>
Date: Sat, 19 Jul 2025 18:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up
 driver
To: Doug Anderson <dianders@chromium.org>,
 Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250717164053.284969-1-me@brighamcampbell.com>
 <20250717164053.284969-3-me@brighamcampbell.com>
 <CAD=FV=Vrp9MM_5de10sV-TC_mp-D7en9gjU8DBoD6mBrRvF2eg@mail.gmail.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <CAD=FV=Vrp9MM_5de10sV-TC_mp-D7en9gjU8DBoD6mBrRvF2eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/18/25 5:11 PM, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 17, 2025 at 9:41 AM Brigham Campbell <me@brighamcampbell.com> wrote:
>>
>>   static int jdi_panel_prepare(struct drm_panel *panel)
>>   {
>>          struct jdi_panel *jdi = to_panel_jdi(panel);
>> +       struct mipi_dsi_multi_context dsi_ctx = { .accum_err = 0 };
> 
> nit: can just be this:
> 
> struct mipi_dsi_multi_context dsi_ctx = {};

I am not an expert here but I was under the impression that this is only
valid with C23 while the kernel is written in C11. Is there something I
am missing?

Diogo

