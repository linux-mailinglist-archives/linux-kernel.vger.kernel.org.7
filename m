Return-Path: <linux-kernel+bounces-605836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CABBA8A6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 20:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E9D442832
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A92226CF6;
	Tue, 15 Apr 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNjwi8Ce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2376220687;
	Tue, 15 Apr 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741931; cv=none; b=DNAr1Dpvo7bXVsmxeOrSkVyUnKeY5kP8MEnB9NszT1BYiImCwL7X1SklSVZXiNOD/njuLG0cSrU7RrZf390aHiQqix07vrP/MLADC02dfFMM1CyJY8UPt9onmyLnlr1RWZe9QpmbIAO6Ld6ryolh6OqGx7tNpOVL+k4XH/XfZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741931; c=relaxed/simple;
	bh=nob3/kZbXDir2O8CsW9edGgoPBsCwqU240ITFoCb2v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL/m6Jy1gcfBlfnO6E9IUa2RVlnkKrqOvBkUZ5L5Pmcd7j1pv6GbetbdZ36nYMW/XUR2yp7K4jz86/YthWolr2M5hJBpo1wCf/Ovch1KRhjCAowIOO3fN/R3NqauaELZowmhOEi3Ja3oCOASQKIcxmoDhbp3j6P3UuUxSdy0taw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNjwi8Ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DD6C4CEEE;
	Tue, 15 Apr 2025 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744741931;
	bh=nob3/kZbXDir2O8CsW9edGgoPBsCwqU240ITFoCb2v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNjwi8Cen9zH/ifXmmgpn9sGlBhBoJ+abSvu0PESeK7Yn3KOQ/NuS8IpicHZKw/8U
	 3TvSMwrp693w8SakNEzogIlPUeVqymM1Be/XY2/Qz/y7cplWauzqD43UhcbL4DSZRg
	 mawSHMLdGdp6lSmNKSQxJ6QxhIiQPnXFSzFpWAs1AwLkQYm8iQsIzTWvtfV5hMAa+X
	 OYwPWItfRBcBbm0z1pd4csybIp8oqQtU4+90YONAdgda0y0ztH/Al7y0uuF71VHNRF
	 /tkBVHCTq/5uYvAWPmtoc2vdAKDfdXRcnUOJrVNYeV2l4VtvQT7EZgT3JxOsDcuTri
	 OKyNqZAee5t9g==
Date: Tue, 15 Apr 2025 19:32:06 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix port_np reference
 counting
Message-ID: <20250415183206.GD395307@horms.kernel.org>
References: <20250414083942.4015060-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414083942.4015060-1-mwalle@kernel.org>

On Mon, Apr 14, 2025 at 10:39:42AM +0200, Michael Walle wrote:
> A reference to the device tree node is stored in a private struct, thus
> the reference count has to be incremented. Also, decrement the count on
> device removal and in the error path.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

