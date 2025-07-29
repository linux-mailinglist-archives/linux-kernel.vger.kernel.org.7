Return-Path: <linux-kernel+bounces-749777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F1FB152D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CD8174B64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3A23535A;
	Tue, 29 Jul 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mnuquosk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10ABE4E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813631; cv=none; b=hh0TPExzPpWGIhzTsKEyIkc8alnUvRSy/lPZCUiv5aVk8csaFuJZlhMLR8pd4MXZblr0VO4N5L6Xum7gf1zVKBkIovuge6IGmxCNuRfJjVwpS+QD0AFpyeSq6mPFr4t9DzK5PWILKkAW8A5KQlWGwennERBAIqM6lz1hVxSU4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813631; c=relaxed/simple;
	bh=OpC3U1ui4u2pN/vVlaKNfysBlgMgba8CS86dMYuW20Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMWr6s6OHp/FlTwM7QXhkzdNw7Z8bp1VCQZfz65aCA6BOMD3+k0euhvhUPpaUZEOxRGmdQjBppBd7BWmR5Szgi1KMCturlR8WvQxvlAQsIfvXbzErZU8RQ9Ceb66G+pDizKc/zMwxU61cIvEzeq7VwlDc2OcF8jZkdGMS0u81lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mnuquosk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F4C4CEEF;
	Tue, 29 Jul 2025 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753813629;
	bh=OpC3U1ui4u2pN/vVlaKNfysBlgMgba8CS86dMYuW20Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnuquoskjAZkdQATAFvsI6MxmGKQYI8vAYf3/aE90HYmkk/b1ihES/ZUBurWQASNn
	 rpE2Ympe/IlDE2kWFeGrLhQJMWpRE1MURHup6bvg19gSjtjwZcydEah5Wghl1oTpoR
	 JHAY4gnwnAlMpGrP+mlL5sYGFG5QCOVVWYcSRxmo=
Date: Tue, 29 Jul 2025 20:27:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Driver core changes for 6.17-rc1
Message-ID: <2025072951-cadillac-relapse-4978@gregkh>
References: <DBOQ1PS4Z00Q.ARCY8VPIY909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBOQ1PS4Z00Q.ARCY8VPIY909@kernel.org>

On Tue, Jul 29, 2025 at 07:40:15PM +0200, Danilo Krummrich wrote:
> Hi Linus,
> 
> Please pull these driver-core changes.

FYI, Danilo and I coordinated on this, he wanted to do the main pull
request this release cycle due to all of the rust stuff in here.

thanks,

greg k-h

