Return-Path: <linux-kernel+bounces-880207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F4C251C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82A234F6AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F51E9B0D;
	Fri, 31 Oct 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e+lt+9t/"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA434C12D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915075; cv=none; b=oEgQ70x2abS31/jvrse4dqMUmN6sdQdVe9qUxGh/3HocLPK7GEluMaCeJYCVGFMahSX7aEh+4K3/xICtRClEX3DeW5EmVxnyB2ejHt89zKrpIHaH4InPHYv+/Oebo8JGx+et7BWAGFJlixOnovhcY0RcY9AZj+e73iWxh8YBI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915075; c=relaxed/simple;
	bh=VjOeT4bzitG9cHTP1kuLqVSJbPFRmkPoxBQOK0kkMCw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZmR+CDE/ayW0UKYSDpRvEEuVmDjZSrwfdS52T+/f58+bICO8k7Ma/8jgXbGB3Hv6c77K1DMpKLvwTstDbUZH1IwpT05FBJBU8vomUlloU4r3JGBrw6NE/LByzllYiRtHI4jelOZasWLEzs+I4WE7IgxjFuBwaIqbjfgMc1jI/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e+lt+9t/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761915061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1OzYz6jsSqyMk2PXMcRsst8hSVBzHs5N4nuDrzstmU=;
	b=e+lt+9t/4XU2Sro/bZjWuQl8IH/FmbYDwvgezwSq24jjqZ2FxKZAdBtpQ8WjZTwxWs326h
	mplkcSxTZswJGq+7fbE3F4CV9q6H7AmjjBf1HJeEtxtFy+t3u0fvJwuUiMeaCfwRSimyGQ
	rQzBJHipO99neIibUZhBmcmXpIiGdJ8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] platform: Replace deprecated strcpy in
 platform_device_alloc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2025103140-plant-sprig-bdda@gregkh>
Date: Fri, 31 Oct 2025 13:50:28 +0100
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4AB5FFA3-EFF9-41FA-8204-FA66FA9D33FF@linux.dev>
References: <20251031121858.156686-2-thorsten.blum@linux.dev>
 <2025103140-plant-sprig-bdda@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 31. Oct 2025, at 13:24, Greg Kroah-Hartman wrote:
> On Fri, Oct 31, 2025 at 01:18:58PM +0100, Thorsten Blum wrote:
>> First, use struct_size(), which provides additional compile-time checks
>> for structures with flexible array members (e.g., __must_be_array()), to
>> calculate the number of bytes to allocate for a new 'platform_object'.
>> 
>> Then, since we know the length of 'name' and that it is guaranteed to be
>> NUL-terminated, replace the deprecated strcpy() with a simple memcpy().
> 
> This makes no sense.  You are saying we know the length, and we know it
> is NULL terminated, so let's be complex and do a strlen() and memcpy()
> instead of a normal strcpy().

The current version already calculates strlen(name), and then strcpy()
does another strlen() internally, which we can safely skip by using
memcpy() directly.

The current code is correct, but by removing the deprecated strcpy(), we
also remove a redundant call to strlen() without any functional changes.


