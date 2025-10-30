Return-Path: <linux-kernel+bounces-878211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE321C20098
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D061886BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A219E7F7;
	Thu, 30 Oct 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="geZPbwRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9601524F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827544; cv=none; b=Xeyvr5GJPsHsJMEl+4K9W23BLA4Pk8JoJMFG7f6hHjiPHpns+C/HGeUiaUMhWJKI1mgyq+iXeoaLIvH0IqT0N2mFwuzHdlNBP/OMtaXshmwYkdrRAXKwY/IbLfcdCI+veng7LUwwMp0UGngMCC/bMIhWF7GoD9e7crO9hYUwJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827544; c=relaxed/simple;
	bh=NtnSt4r3ttnfkOJ9gQUexqJoRHp9yMcifK1PToiCUF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNBpjtbPaEwIyTsj2UvC8k4r7q9SM4O2kzEzujUlG3RIY/L+OavVvi43nDhPy+xTo85ILtpruv44b1U2gw/2i5vCZBIoWs16LrZmdxogjzNY4SWnWAS8asxzi7dCihLxzoGGqgc5aqHC2uo7+wE0TntcAhwdP2CVKVTatruFl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=geZPbwRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BBBC4CEF1;
	Thu, 30 Oct 2025 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761827544;
	bh=NtnSt4r3ttnfkOJ9gQUexqJoRHp9yMcifK1PToiCUF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geZPbwRy4tpy8v1qJfUhqS9aez5KxKO53JDHglrtt3qBIl7+9gGPoxdtdk7JrFIlE
	 GQaWxKu5wbs7jOvigsGYjISk0/eN8SOBAKlr7sOPON7OJHx8+u+xJI1Fo0lRfwepmw
	 61UHv8udk4kuqcFJVBybmZEWQ2Kb+6Bw2+9CwwS4=
Date: Thu, 30 Oct 2025 13:32:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: alexander.usyskin@intel.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: bus: Add newline to sysfs attribute outputs
Message-ID: <2025103052-taking-shredding-c77a@gregkh>
References: <20251030123000.1701700-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030123000.1701700-1-zhongqiu.han@oss.qualcomm.com>

On Thu, Oct 30, 2025 at 08:30:00PM +0800, Zhongqiu Han wrote:
> Append newline characters to sysfs_emit() outputs in func max_conn_show(),
> fixed_show(), and vtag_show(). This aligns with common kernel conventions
> and improves readability for userspace tools that expect
> newline-terminated values.

What userspace tool reads these values today?  Will this user/kernel api
break them?  How was this tested?

thanks,

greg k-h

