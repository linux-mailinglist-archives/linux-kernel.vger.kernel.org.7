Return-Path: <linux-kernel+bounces-753155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC336B17F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F12B5877F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06444225793;
	Fri,  1 Aug 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMcBTEn2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8F222582
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040578; cv=none; b=T4IAGCa4cjKIptOxxUMSRjqXhrvhF5uoNL/wp8tAKnFhyQ2vTy/00vw25eJU5LQft7wYV7qgAhbO8CNR5ArNf71BDUH++w58Krg4VhJHV0uhJzN8Et5Sd6U5OE6U04AsqffoJhmTxQM9cyFdAlH14k2zp8oxcX0YuWCZuCAhOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040578; c=relaxed/simple;
	bh=bfaiaPcNaXDzcQAotjUypFK2DTSXDKuwacItKskBqzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLM5d4tqSr4TqHvevMQxUCJ3De4VJvXfsHiDh2aBJEM+sze4f0Fqf+LPZe8Lh7pmIJcLSlo+4qtmxU4X9rlaQytlpO4lWPkInkaYZ9tHw0qUYY2iw2EUEqHySzPX+uIrTkBqeau3sGUiAZDxogKjIcCxCUCd5bLUnVbxiQn9mOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eMcBTEn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402BDC4CEE7;
	Fri,  1 Aug 2025 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754040576;
	bh=bfaiaPcNaXDzcQAotjUypFK2DTSXDKuwacItKskBqzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMcBTEn2gZhuIaYVvObPA4K+Qsj2EQWRbdN2UNZEe0/kw3NoOQppfHXyT95/hYJMx
	 gSwlyst1yjCtMwEEF6r8YKMDOE//9vRaPEf/wcMcJ+vZfN8zTrSbqlJ0rSgj8JlO6Y
	 Hllyxes0l6xG+MRki9eVXV00H3AUD3mGYlUq+NWI=
Date: Fri, 1 Aug 2025 10:29:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: alexander.usyskin@intel.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
	niecheng1@uniontech.com, guanwentao@uniontech.com
Subject: Re: [PATCH] mei: vsc: fix potential array bounds violation in ACE
 address allocation
Message-ID: <2025080118-murky-morbidity-97d1@gregkh>
References: <78151482AFE8973A+20250801090600.544000-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78151482AFE8973A+20250801090600.544000-1-wangyuli@uniontech.com>

On Fri, Aug 01, 2025 at 05:06:00PM +0800, WangYuli wrote:
> When ACE images require dynamic address allocation, the code accesses
> frags[frag_index - 1] without bounds checking. This could lead to:
> 
> - Array underflow if frag_index is 0

How can that happen?  Does this value come from the kernel or from the
hardware?

> - Use of uninitialized fragment data for address calculations
> - Silent failures in address allocation
> 
> Add proper validation before accessing the previous fragment and
> provide clear error messages when validation fails.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

What commit id does this fix?

How was this tested?

thanks,

greg k-h

