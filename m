Return-Path: <linux-kernel+bounces-741867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28526B0EA03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3CA1691FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F2238C2A;
	Wed, 23 Jul 2025 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2PyQ4jg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462921D95A3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247937; cv=none; b=n4qhZIt2Ut4P3rvr0REka/uly8PTB4yl6Zqkci8xnUQ+R3U3XW8zeqhSnbS7wXcXw8QQgNKN0C34XrP6okW4//zxvJ8sVaiRwuTg6J9Kr5VRSO4dk6k8uZ0COeRw3U3iAY+BtkJapaHI3lOeG3xVoeRT+VWf20spixJimVujpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247937; c=relaxed/simple;
	bh=nsMPUH293s6jOxlTalukz1fcTlX61DdMXB/NAPO47rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtMzw3E2mFou33ozP6MfCnuudYq17nQpxilRzqQ1P2cNckNCqoLMfhjnwdy3c5JjIZp/wASyPDXQ3xJKxjKfh4bJ3UvZPf295rLvItPBDvBOsmJiPTsCuRUQebymR7RsPc9YnWG9fKPlEaes8Q2AaGl//pWZ+n+pz06X+eWHEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2PyQ4jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692E5C4CEE7;
	Wed, 23 Jul 2025 05:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753247935;
	bh=nsMPUH293s6jOxlTalukz1fcTlX61DdMXB/NAPO47rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2PyQ4jgsFkM9vH2+g0KgTZtJxJkiGkJVXhDN8R9WxfJ1fXsyPZeUklOP/VUJzJ5P
	 rOXvaKWXYjXgdzbwrZOosPgP+W5lVf61NgFvEYYYwBbkVLcpGtTXK8jl0Wd1U0tlKp
	 AkfODj5/NxHZGt8XchBzZp8IX/9Dpj1ryvY2Mm+U=
Date: Wed, 23 Jul 2025 07:18:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] checkpatch: enforce 12-char SHA for Fixes tags
Message-ID: <2025072354-spruce-step-4433@gregkh>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
 <20250723030257.66560-1-ignacio.pena87@gmail.com>
 <20250723030257.66560-2-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723030257.66560-2-ignacio.pena87@gmail.com>

On Tue, Jul 22, 2025 at 11:02:57PM -0400, Ignacio Peña wrote:
> The kernel documentation recommends 12 character SHA-1 hashes
> for Fixes tags. The current code allows 12-40 characters but
> we should enforce exactly 12 for consistency.
> 
> The regex is changed from {12,40} to {12} and the warning
> message updated accordingly.
> 
> Link: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

No list of what changed from v1?

And also, why make this change at all?  12+ is fine, I haven't seen
people use huge values in the past, have you?

thanks,

greg k-h

