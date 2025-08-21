Return-Path: <linux-kernel+bounces-779495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB08B2F4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9361BC5D85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BA2E424F;
	Thu, 21 Aug 2025 10:00:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28F1D88D7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770458; cv=none; b=cNZ+ZvDwwUqpt3G38zOi83iC8Gn7iNqiu96MSIkaRPe0Lzfvt9TbIGywp6vep5iVl911xHNOjJEx5vtyVHe5K7IzL8Byf340hlfil/PSDR81IzMdod2JoYQ5soOzMT4mW6WhFiFcd+z1ZfFbpFOEf3qvUc+//SoYtRnqBjnhyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770458; c=relaxed/simple;
	bh=G1hOLj9ixQvrvo5cZnWx6Zb9hkj/XcPBmUuYk9Qnf/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4F64gPrfyi0EJ/lj5XKZowabPQGtnn0s5deIBRAKcA/ui/bcdpCi/NM7BIsSx4MQSRcpjfw1zf9qYRIw9ny+2wWo94oX7FeI3d2GAC1xYMTddyuPJ5YZfQUkr+dtyfAYg+xdJv5BMlLTUtE10mtLATXs0Yv0YHxUBPnZToxZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9D1A152B;
	Thu, 21 Aug 2025 03:00:47 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 493C03F63F;
	Thu, 21 Aug 2025 03:00:55 -0700 (PDT)
Date: Thu, 21 Aug 2025 11:00:48 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, cristian.marussi@arm.com,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: arm_mhuv3: Remove dev_err_probe() if error is
 -ENOMEM
Message-ID: <aKbuUC_sQbRjs_iv@pluto>
References: <20250821093253.559809-1-zhao.xichao@vivo.com>
 <aKbsjmEnXIOka7QM@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKbsjmEnXIOka7QM@bogus>

On Thu, Aug 21, 2025 at 10:53:18AM +0100, Sudeep Holla wrote:
> On Thu, Aug 21, 2025 at 05:32:53PM +0800, Xichao Zhao wrote:

Hi,

> > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> > Therefore, remove the useless call to dev_err_probe(), and just
> > return the value instead.
> > 
> 

Looking at dev_err_probe() comments...

/**
 * dev_err_probe - probe error check and log helper
 * @dev: the pointer to the struct device
 * @err: error value to test
 * @fmt: printf-style format string
 * @...: arguments as specified in the format string

[snip]

 * Using this helper in your probe function is totally fine even if @err        <<<<
 * is known to never be -EPROBE_DEFER.
 * The benefit compared to a normal dev_err() is the standardized format
 * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
 * instead of "-35"), and having the error code returned allows more
 * compact error paths.
 *
 * Returns @err.

I have not a strong opinion but it seems to me un-needed and potentially
impacting future backporting...IOW for me, as the mailbox maintaner prefers.

Thanks,
Cristian

