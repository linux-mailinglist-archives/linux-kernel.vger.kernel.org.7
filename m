Return-Path: <linux-kernel+bounces-772449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5DB292CB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CB33BE9F2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6BF2882A2;
	Sun, 17 Aug 2025 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rd+JcS+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DA199EAD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755429008; cv=none; b=sJpkMzJaxg3qgnJQ2tQoBEfxZP830wTHGnLiF9E28rpR3ZsfivlCLusSgNqiekhpVfnhKEQ1LGZokHqms2rlcmtcC3d7vUyoC2vU3dXfHUdpS/WL/n0kgYSwDg6GuwfE9T9Jtq4LWkAFkPbAJGepK/oskQomJmtWAgGodfC92DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755429008; c=relaxed/simple;
	bh=X2a1xKTP4JikGaTMQ9G8OPuKoSH4ZC5xHNgfMfGlvGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnbqkEmMPCbHby7gly388uGKStKptTU4kVmVf7aA57zqRupTzj6VohBFKYKvZqS4KmC4Zqan2rUUPbLy87x2uQDxlgHEGRhnjc1gEyJCCIe+aaFSkhsuQmsNskYPGROUrhHj286HZ7Is3oGzAv+5dKunx2wPz8ylra6e4ldgHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rd+JcS+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13B7C4CEEB;
	Sun, 17 Aug 2025 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755429008;
	bh=X2a1xKTP4JikGaTMQ9G8OPuKoSH4ZC5xHNgfMfGlvGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rd+JcS+yBf2fV2G3+o35Z1t/oZxhf2hr6tYPmYii9z/M6ZysvzHKPYHQoLZJ80R1X
	 1uT8YpRKSn7ARmeVQHaW/SFH0VH73DzEvtqTGqaL+8HYiKPQPSHmYUDFthymgGpt2c
	 HGzXIQb9IMBFih3VPrbYkEZgdNeZ+nXPPT/Xf6So=
Date: Sun, 17 Aug 2025 13:10:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: alexander.usyskin@intel.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
	niecheng1@uniontech.com, guanwentao@uniontech.com
Subject: Re: [PATCH] mei: vsc: fix potential array bounds violation in ACE
 address allocation
Message-ID: <2025081712-tweet-repressed-2aee@gregkh>
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

How can that happen?  It's coming directly from a static array in the
code itself that it declared right above these lines?

> - Use of uninitialized fragment data for address calculations

Where will that come from?

> - Silent failures in address allocation

Where?

> Add proper validation before accessing the previous fragment and
> provide clear error messages when validation fails.

But how can any of this really happen?  If it does, it's a bug in the
code that people added.  So why is any of this needed to the code today?

How did you hit any of the above, and how was this patch tested?

thanks,

greg k-h

