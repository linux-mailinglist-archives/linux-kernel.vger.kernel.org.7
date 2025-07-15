Return-Path: <linux-kernel+bounces-731138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0685EB04FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559071AA474D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86282D192B;
	Tue, 15 Jul 2025 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsX97MIc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC8946A;
	Tue, 15 Jul 2025 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552177; cv=none; b=DVZu67WpmvGBYQAEMHbJr21aeBn2i8CGfhiMlccMqI3dS4xqNX80aIrUBHMki+kvM862TSWAzhCv0X0E8CDFuF6/aC4eBoEvE0u32jE5dBcEi5w1gUaIkZnxdE4xH5RuyxDa/lClJG8ItFBYJq5berDa08/wXBO67TSd7AqOOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552177; c=relaxed/simple;
	bh=2UGiN6zW5O4q0oWpGhmgtuQBTPCLQxSYx40hiYynJ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxQOyaTHG+tbQySvZSRqKh0DTNQMvKMM02cQBuYwpCltv5M5YZj5rut7MfHaorSobuyFvxvApj3k84/IscD2sjGPgiilrAd/FAjnJb2SY1UTlShpmJYKtvCIDHkaM+f0muU0wxiXHrSH/aeKikeOl6YFDDEyu0grZ5p6diHAfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsX97MIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93614C4CEF1;
	Tue, 15 Jul 2025 04:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552176;
	bh=2UGiN6zW5O4q0oWpGhmgtuQBTPCLQxSYx40hiYynJ4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lsX97MIcclRndAAs44TUN1hYIi6ddUaZcsyFAuXClWuXLRnl9Xyys1K/xd+PDGXe+
	 kt+hOFLyiQ9ruCxNjDg8eQ6MlMbIjsyFxwpsoK0v9ZR5/iGS2X52kIiwXeQ9ewF5G0
	 xdSWJaLQOYcXvTa8tJzd6oMxwG16wNCBQm7a15AUrwfr4T9HLT7dDyHC0H/s6K7Q8P
	 P+rKc9nJQAvgSwf52zESiquJEU+1Afx9nmZUd5E3cZc063pSlahbl0eDrI0zsq0dAg
	 WkoGxGAUZKM0IseiDmqyEw3SB5ITLeB/qhp6NmYiKJWVmZWH0iH+5y3spiEEvgN0Cx
	 nmJHlzpUlStvA==
Date: Mon, 14 Jul 2025 23:02:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Yao <richard@scandent.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Akshay Athalye <akshay@scandent.com>, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Tianxinwei name
Message-ID: <175255217503.27396.17909209264231260319.robh@kernel.org>
References: <20250714191729.2416-1-richard@scandent.com>
 <20250714191729.2416-2-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714191729.2416-2-richard@scandent.com>


On Mon, 14 Jul 2025 15:17:21 -0400, Richard Yao wrote:
> Tianxinwei is a company based in Shenzen, China, making LCD screens.
> 
> Add their name to the list of vendors.
> 
> Signed-off-by: Richard Yao <richard@scandent.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


