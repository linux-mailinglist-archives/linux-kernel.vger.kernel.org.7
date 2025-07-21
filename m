Return-Path: <linux-kernel+bounces-738707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253ACB0BC24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835A73B9079
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF1142E67;
	Mon, 21 Jul 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sHtWEIJk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342CB21D3C6;
	Mon, 21 Jul 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077287; cv=none; b=SSeUN8WKuu1LTpsOVG6+P2yuGA9pE8mcTa8BxZ+fy+DjrFSqQewdddlrltv0Vzv6rT7NvKBtuQibCMMS7Q/9DAiC/e2ywlGyQT55/CRyzEIf/Qoz3SwA6oBriEZn6RVfbotqxsqj0URpBNaaUsLWIVztd91YaNCuToZ0xFk/jr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077287; c=relaxed/simple;
	bh=SUULNyTCNALIn6oLSmZ75wjYeS11qULeoQU0kY83iE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4/N+8w6LMMFQROYbDohNInvS9AoMKYNBinO1hSuBI95FDRIMn433f0RED7YdbJfzt++IuTxY/TPgI8z46514NtgHIB8GQZFRrgl/sePKfh3NGj1iGBGi9DMGO5WZxbaez9qSbtfQFaoQ58gwxIP3hnEce8LXhKmGghG2RlCaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sHtWEIJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4A3C4CEFB;
	Mon, 21 Jul 2025 05:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753077286;
	bh=SUULNyTCNALIn6oLSmZ75wjYeS11qULeoQU0kY83iE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHtWEIJkHlZNRf7X0DXm/L8XXbmM90WDjIBXl8X8dDvQooQMZrXD3Tzq+uLuSUN1u
	 sfArL9I0w3Lcidl6LlX9/kbvdZ35wn2/4XaXEQkbBkHdYC+cbFw4n2JibKXxatenqA
	 h8UGcJ5O4ey2ORc3lU+5yH64EW6XxmnCTTj0xwhA=
Date: Mon, 21 Jul 2025 07:54:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ali Nasrolahi <a.nasrolahi01@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/3] staging: rtl8723bs: fix comment formatting in
 basic_types.h
Message-ID: <2025072133-aspirin-backlash-2084@gregkh>
References: <20250720145524.9733-1-A.Nasrolahi01@gmail.com>
 <20250720145524.9733-3-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720145524.9733-3-A.Nasrolahi01@gmail.com>

On Sun, Jul 20, 2025 at 06:25:23PM +0330, Ali Nasrolahi wrote:
> Fix coding style issues reported by checkpatch.pl:
> - Adjusted block comment trailing markers
> - Unified comment spacing and indentation

These two are fine, but:

> - Removed redundant semicolon from macro definition

This needs to be a separate patch.

Again, each patch needs to do only one "logical" thing.  And that
logical thing can not be "fix a bunch of coding style issues that are of
different types", sorry.

Please fix up for this patch, and the 3/3 patch and submit an updated
series.

thanks,

greg k-h

