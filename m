Return-Path: <linux-kernel+bounces-779227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9536DB2F0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4266020CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295012EA146;
	Thu, 21 Aug 2025 08:09:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB924DCF9;
	Thu, 21 Aug 2025 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763746; cv=none; b=s4FOO6tgVYk7PjB2O5fHaI72PuVifK6ZevLX7EQcyZY7nAWvWORLRYD14Xyeu4H42pwLxkAHK4fwupuQco9ABUZmqmB/+GqhKuafWFWBDO4DMamYy5TN3kOzeDb3UVChLH++OEWrcezQ5iEdl+NfgcwPjrMx4kvc5CGu5cJ3Jzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763746; c=relaxed/simple;
	bh=F3v63+I0hd73lIWZLN9GxyqhVy+79L+cjSGnrP/5U5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGQqFWUs+tP6AvaAH7RZW2Ak8naHiF9uVeaTdII+4yMroQUonWVO98NxrzAmdX++MorbmbYxYJuhAPABBdBi1OFZ81NQc8itvk0KxMFpordVFU0u37e3l2gb+Y1prUNDtWRAmzSk2HLjCV/jw2mjTdQ2b5tiTrc03rxAFyj9EU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7C9F1515;
	Thu, 21 Aug 2025 01:08:55 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C97A83F63F;
	Thu, 21 Aug 2025 01:09:02 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:09:00 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/7] firmware: arm_scmi: move boiler plate code
 into the get info functions
Message-ID: <aKbUHFQhhmrKCgZ8@pluto>
References: <cover.1753039612.git.dan.carpenter@linaro.org>
 <7a47cf3d-05e1-4702-87ef-cb7f36f03149@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a47cf3d-05e1-4702-87ef-cb7f36f03149@sabinyo.mountain>

On Sun, Jul 20, 2025 at 02:38:35PM -0500, Dan Carpenter wrote:
> This code to check whether the selector is valid and if the item has
> already been recorded in the array can be moved to the
> scmi_pinctrl_get_function_info() type functions.  That way it's in
> one place instead of duplicated in each of the callers.
> 

Hi,

> I removed the check for if "pi->nr_groups == 0" because if that were the
> case then "selector >= pi->nr_groups" would already be true.  It already
> was not checked for pins so this makes things a bit more uniform.
> 
> I also removed the check for if (!pin) since pin is an offset into the
> middle of an array and can't be NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

...has anything change in this commit from V1 ?

Asking because there is no version-diff and you did not pick up my
Reviewed-by tag from V1, so I am wondering if there is anything to
review or not..

Thanks,
Cristian


