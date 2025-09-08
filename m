Return-Path: <linux-kernel+bounces-806767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737E5B49B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0019E7A1A53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333E2DAFB4;
	Mon,  8 Sep 2025 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Dy7o3lJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xhk5h8wW"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D21E500C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365739; cv=none; b=b9gXMe5ZB9lRLCq3/8bwD1lAiaWpZgTvtK/YZxS2Ud87J0OEwB/oCf5iCffqaCjCqBwYXrTwjX3+fh8tjVduYKUfXQJwnZPVq3Xh0grhPpdp96cHFyGkYcVA6xecWQp3lpItQmqUWPSJ6zcobUvSUoi6004f0poxM+wh3vFpjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365739; c=relaxed/simple;
	bh=Wzkdzpyye2Z+Ll/Uqh02/Fln0jrXkaTaxwRMhQg+hgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAk1r6wr4lNmj2QQYIv/vvypMg66apHHUap7fXDI9VlIGjV47fPvBdXqEbHr7qEEjK2Mby9LaPBcZEfShClm9b5nXSEyFYZJYAeRLqeE7K7CifJVdsEIpdYvtv3XMhQv3+x7F2m3j5BIufTOnbpA7JDrRTNO+pvvY4ioe1QXlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Dy7o3lJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xhk5h8wW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F9751D0013C;
	Mon,  8 Sep 2025 17:08:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 17:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757365735; x=
	1757452135; bh=nBkbY1qcj0HA7LBP8jJssHE5X/t4NAA4S/lftxMIcBg=; b=D
	y7o3lJc4kHiqlYqrFXSHjkFdXUz/8kOdQI6P4tG6vHQ/yEDfs7M4Ayp8li3tMkN9
	E4J7N0EEHD1+xd56GzXjeh9hv1sYuXZ4xzSS6qSqJ2bHCqDnAelm8SP72SO9nN0+
	QN06nFefohmmO5zXny9ctISl30eZPSy+QLGsVlfmnw/bzsQ4OzZNjh6bkCvX6l8s
	ZfUEuN75QK2zfEepK86oWUrPCB0p6DPIN0RCrfms/a5N/VutpfAV4/7FYs3rrIQI
	Q4zuw3UOrCz4shNKcQUSDU2AJ5HuTRuR7RR2E5vXuHp2UyFU51IOkeiq5sZNxkLe
	LhbvekOONnEJqY2/Uxw1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757365735; x=1757452135; bh=nBkbY1qcj0HA7LBP8jJssHE5X/t4NAA4S/l
	ftxMIcBg=; b=Xhk5h8wWnnflhORqha9eB79ydUGrcH0gSTV9x0gCoSsiC43wY92
	bVDyE5gIWb8Dq7rXArOITwfEao/KaH+HpLMZ9/Bec6ClBGkze6Fvz3ljMGpyKJFw
	6fKeJty/BWiFOMG8zMXkhCgxat7alroFxNXds6UFbmpJvy4khtU1WPTyGjXroWyB
	FDo6kht8tAxVcOTGMfpDZSEZL9XDusqVN5+GEMYZnK4Dv+VQX3bAuazCmKb6AoEW
	ZLLZ7a3NhyqfoDhOYDJQNqJQXqzhmwIH19YpAHgC6dEZHGSQx1oKL51LVGz+gAv/
	UkB5h1fw7Ipd/L9UI7f0BJvmvJPxPQkl4Qg==
X-ME-Sender: <xms:5kW_aBy_BjD2UmDvN-oqHKxX99-8-iFVlGzpShttmL0l_Uq8l7ei-A>
    <xme:5kW_aKMEKeI2F3yz49mBonvC-Ifjs3nD2zc6bJGVEVkWp-fzZ5gihU83cXRE4LRKM
    NEoFW9Wglsz_cz7JCU>
X-ME-Received: <xmr:5kW_aNRWfWMGQ9lJwDNPigv1lgRE9VjNVUeIBfWAXJmtOwDHtE-9A44HcMXcblxbiiCUSmTUv_vTuyq6oQrbU7rVyg1_edjOTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgke
    dvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:50W_aAYjZbfGjcrabn95ktUa-YLYHfTN3HL3YT2hZpcvzsOxU1EIkg>
    <xmx:50W_aC1F4SL98sUbB_Ud6FgYtxaHf_aV9A_3HkQMiSo763-VP89N_Q>
    <xmx:50W_aIXqCj7LLRIPW6sDkGgdHWIVzJaIMBS4RaE8QCXK2Tl_C1T48A>
    <xmx:50W_aEXcv6ol5cbSwJOZ7xtispDfXYhAiexpn-XZPYPydQM1UUr6JA>
    <xmx:50W_aC0ojIc53-wY2fSwEJhbG9JmI6tqHjtRejxHWcn1qETZHKxtqjAA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:08:54 -0400 (EDT)
Date: Tue, 9 Sep 2025 06:08:51 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] firewire: code refactoring mainly for bm_work
Message-ID: <20250908210851.GA586497@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908012108.514698-1-o-takashi@sakamocchi.jp>

On Mon, Sep 08, 2025 at 10:20:57AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> The core function in this subsystem have bm_work work item. The
> corresponding function has many lines with comments. It is a sign
> that it is time to be refactored, in my experience.
> 
> This series includes the first take for the purpose, as well as the
> other code improvements of 1394 OHCI PCI driver and the other core
> functions.
> 
> Takashi Sakamoto (11):
>   firewire: ohci: use kcalloc() variant for array allocation
>   firewire: core: utilize cleanup function to release workqueue in error
>     path
>   firewire: ohci: use return value from fw_node_get()
>   firewire: core: add helper functions to access to fw_device data in
>     fw_node structure
>   firewire: core: use cleanup function in bm_work
>   firewire: ohci: localize transaction data and rcode per condition
>     branch
>   firewire: core: code refactoring to evaluate transaction result to
>     CSR_BUS_MANAGER_ID
>   firewire: core: refer fw_card member to initiate bus reset under
>     acquiring lock
>   firewire: core: code refactoring to detect both IEEE 1394:1995 IRM and
>     Canon MV5i
>   firewire: core: code refactoring to investigate root node for bus
>     manager
>   firewire: core: code refactoring whether root node is cycle master
>     capable
> 
>  drivers/firewire/core-card.c   | 239 +++++++++++++++++----------------
>  drivers/firewire/core-device.c |  18 +--
>  drivers/firewire/core.h        |  14 +-
>  drivers/firewire/ohci.c        |   7 +-
>  4 files changed, 143 insertions(+), 135 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

