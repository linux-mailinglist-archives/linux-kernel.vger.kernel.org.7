Return-Path: <linux-kernel+bounces-744094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F00B107EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2FB1CE3932
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99EB268FF1;
	Thu, 24 Jul 2025 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZHlCTODV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDF267732;
	Thu, 24 Jul 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353646; cv=none; b=GZtgtLmBBkJ/xnrA8XnCd/R4a4XL+tFxbxk1ar8762XS59WGBHdU5wlR+fyKm3EhKobPK+BVKLNqtLwP+UPR3qZsW67prlGQYoEDwNPMkie0NRss2oX0mgjDCG9SLzLygG6Eb9gJTz3z3e967gzwSBNALcQpXf7Q5Q98yC24o1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353646; c=relaxed/simple;
	bh=NEZ8Kto9XEQyh3umMbwYgb2oXZMaSqk6D1v810u6CPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdtojKjyRs6aKEf2TC3gXpAISs62x5yqpr5U4LDtthVo6bjOsznpb9zM6O1AgooJqrho+m2agaiLCeYP/WuAMvbbS4ZD+J+pwZtLbYRhoDdxpzxqUJxya9S9Ep32oGqQ3i5GnNAE3mE5lLAph1NJ1sJsrwPBPhYl2LjJHiax8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZHlCTODV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31484C4CEED;
	Thu, 24 Jul 2025 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753353645;
	bh=NEZ8Kto9XEQyh3umMbwYgb2oXZMaSqk6D1v810u6CPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHlCTODV3Qa0Ptwxy7N4/tWcgzPACyiUNwRgW9K3AOr/gstAkqlrdCix/gTJnFnUK
	 vZdrmAgkXDmWrZa3HzcFfN2yd9FtjSDTB1ioaGBkkvYycOMcjCImnBvLKk3gxGKbki
	 JEWBIovq+OPAKfsuRJdYEztAOadsLyOIs6E2WSiI=
Date: Thu, 24 Jul 2025 12:40:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB serial updates for 6.17-rc1
Message-ID: <2025072433-debatable-drum-c4b7@gregkh>
References: <aIIC4H7MzIlTH6IE@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIIC4H7MzIlTH6IE@hovoldconsulting.com>

On Thu, Jul 24, 2025 at 11:54:40AM +0200, Johan Hovold wrote:
> The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:
> 
>   Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.17-rc1

Pulled and pushed out, thanks.

greg k-h

