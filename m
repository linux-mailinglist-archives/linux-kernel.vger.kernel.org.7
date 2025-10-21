Return-Path: <linux-kernel+bounces-862021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E7BF4427
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A72461E89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CDB223708;
	Tue, 21 Oct 2025 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTfRwRbL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870715D1;
	Tue, 21 Oct 2025 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010439; cv=none; b=CPseynI/UJuqlxF28ONFFezHEXofM5Dt8HZlCiVvXjtmwAHH+afypB1ael/D8YHcBFw7VaWjHajEG972FBa+SnOzsF9dhmhvNx1pIoywcXcsX+NA/+9rQav+AhMGOZVRVfAbfHqlh/YUylOW1y+Gg3SOV30EsQu0NdAFaI24IRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010439; c=relaxed/simple;
	bh=HcEB8hIYWGlYBg2guh8TguuPoMPEVraqIiDEkZJsypE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOPFdXcBDq1aWuBcuz5zzt5D2090GbidncBO+s45waIv5Qfw7P8LSENCJ7TqbZRTHDY1HplF0jI7lU0rzuN6sUckktq4H89F1Vt8qvrIpBa5TcwA2mXEeJCrN9+7cpg4Ki4FCFV/iLDVBdR0yLZEJdDnComteZxIR5Cdu+vCbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTfRwRbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A2BC4CEFB;
	Tue, 21 Oct 2025 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761010439;
	bh=HcEB8hIYWGlYBg2guh8TguuPoMPEVraqIiDEkZJsypE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTfRwRbLONPjavtAGF8VDPKzwcLDLMtrCPxckLgi7ddBklWHv4jlU0PvpGRT4VJva
	 Sh21KuNFlIhcBMIkTN7sPq9BytaSFMfhrzFajN6XevVnD/MjCiU6XgBpmyhmmy70AK
	 Val9CAVx7UVr0lhYiXY61ILAhdsDQSHziB+YDAMHvcknsyR1QS5wGvhE90OBBjhgUE
	 CvBe7le20wCcbJk5e7ibFolQj316GyAvizb2CiUBs9w9TB8ddairsd92sBUa9j2HVl
	 Zi+A8lIR9ds22Uo9afSqCSgMeE0NvzfUgTCP2eCSr3v8krGgHJ0GXbFVJgf7osktyN
	 mNZOiEorfq9eg==
Date: Mon, 20 Oct 2025 18:33:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mohammad Heib
 <mheib@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>, Dan Nowlin
 <dan.nowlin@intel.com>, Junfeng Guo <junfeng.guo@intel.com>, Ting Xu
 <ting.xu@intel.com>, Jie Wang <jie1x.wang@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>, Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Marcin Szycik <marcin.szycik@linux.intel.com>,
 Rinitha S <sx.rinitha@intel.com>, Hariprasad Kelam <hkelam@marvell.com>,
 Kohei Enju <enjuk@amazon.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Timo =?UTF-8?B?VGVyw6Rz?= <timo.teras@iki.fi>, Dima Ruinskiy
 <dima.ruinskiy@intel.com>, Avraham Koren <Avrahamx.koren@intel.com>,
 jbrandeburg@cloudflare.com
Subject: Re: [PATCH net-next v2 00/14] Intel Wired LAN Driver Updates
 2025-10-15 (ice, iavf, ixgbe, i40e, e1000e)
Message-ID: <20251020183356.38eeb1fd@kernel.org>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 23:08:29 -0700 Jacob Keller wrote:
> Jesse Brandeburg (5):
>       net: docs: add missing features that can have stats
>       ice: implement ethtool standard stats
>       ice: add tracking of good transmit timestamps
>       ice: implement transmit hardware timestamp statistics
>       ice: refactor to use helpers

I've tried to apply only Jesse's patches (and the e1000). 
Hopefully I don't regret this :)

