Return-Path: <linux-kernel+bounces-733252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CAEB07222
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DC0189AD53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC028D845;
	Wed, 16 Jul 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eC45XgNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD0225390
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659232; cv=none; b=NkWzEsvh3EPQ/GNcRad28Jo1DkYX9Qmkw1Tw/p9678Ov7YehKmQYXW9RWY0wC2ubpxDwsf4YsmZ7yl1zLf4j4vDsSI6i0/xLR3/5hI6jzGYug9tNTd8LJSoHCPnxNpdv/I75eov5VgoCkAgKx+FiULUNMDxxMfhp+hwkWWFOI6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659232; c=relaxed/simple;
	bh=c3pa/CHun9Jtv8B9oIp1e9+zJKQTCgMLxojJTTAfdeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+k5xkZ7buWJHUmQTHgqz62MueAxPt7PCVr8nq4NfH+1AmXosb+MsPtIbQHr7tqU0/GvVqMBW3uf4Tphau2VYv9dJwrw/tn6qPwdpF+2I6DqIBX6TdshOq3OvtKi9W5ZU+UXqtRZAx9XLCjSp2tLLjGipCU91+WETIFbDZ/hv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eC45XgNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464CCC4CEF0;
	Wed, 16 Jul 2025 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752659231;
	bh=c3pa/CHun9Jtv8B9oIp1e9+zJKQTCgMLxojJTTAfdeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eC45XgNN9IB6+Di0gsDHYyh2guHiaoeRj3shRI4wU40kudWG6OpX2HTp8+n8oy1JT
	 1t0lNynSVPNt1YtpDa1U3cZ6gMB7tB6OCbRJxa7MAjKh56FcMmgG5SORmThnJ4VXx8
	 fmIorFxzEXXIwJoys3g9P4ZEdN/wAA0xE6qcST0U=
Date: Wed, 16 Jul 2025 11:47:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v3 1/5] mei: set parent for char device
Message-ID: <2025071614-approach-snarl-90d7@gregkh>
References: <20250709151344.104942-1-alexander.usyskin@intel.com>
 <20250709151344.104942-2-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709151344.104942-2-alexander.usyskin@intel.com>

On Wed, Jul 09, 2025 at 06:13:40PM +0300, Alexander Usyskin wrote:
> Connect char device to parent device to avoid
> parent device unload while char device is
> still held open by user-space.

Again, this changelog text is not right.  The parent pointer has nothing
to do with "unloading" anything.  It has everything to do with placing
the device in the proper place in sysfs.  So please show a before/after
location of what happens when this patch is applied to make it more
obvious what is happening here.

thanks,

greg k-h

