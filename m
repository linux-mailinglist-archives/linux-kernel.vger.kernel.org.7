Return-Path: <linux-kernel+bounces-735461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB12B08FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693E31886F93
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533F2F7CFC;
	Thu, 17 Jul 2025 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="boOvl/mX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13812F5C5E;
	Thu, 17 Jul 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763067; cv=none; b=neaovG4tR5aW5wSv/L9N5zL+mvEabcx3WbadUhYvaR2vF3R+d1bgcxf4/G/MDfcb8sJrGdMXF1l0MSER5cSWSCD1rC4n56gsawKjbUBVLqc8eMU3v5OL1NRay95UjGqt1xi8UDnzcBV8DvD9Omdtano6kB3eZb3U1/aMcmTGZ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763067; c=relaxed/simple;
	bh=qJxnjdYTIWbk7vIyn6SbpFcW6x3VlSKPaEAXEeiaS3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdOO9cLxpgTLXU8M6V2p5TtxsEKbl+RpR9NtySuQixN0EyPvun967kF3o/TxhG48iVsPqrXeLFcb3P4JEoQ0EaQP20lsIom+zIPMSK2LtdjD6hHqlgcTbFZIu5GQk8XkE80o4DU7QtaEH3jAvWd1qTFFYA6yxAIfloRZgqEV1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=boOvl/mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D892C4CEE3;
	Thu, 17 Jul 2025 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752763067;
	bh=qJxnjdYTIWbk7vIyn6SbpFcW6x3VlSKPaEAXEeiaS3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boOvl/mXiA7Ku2q2T47AsOoxuAgnWEBIRqC6j+XyUF97Wtj4QzgrymPczfycV+q0R
	 lakw8nji61P9/gApmQPwM78TPtM/UWn1ViWSD14DxLT6mXONWUH5yMiWWVo5p/v63j
	 SSXtRr2nCXcdmLriG44CjIIVnwnKhMJMvt/zAYwk=
Date: Thu, 17 Jul 2025 16:37:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cen zhang <zzzccc427@gmail.com>
Cc: mathias.nyman@intel.com, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com, r33s3n6@gmail.com,
	linux-usb@vger.kernel.org, gality365@gmail.com
Subject: Re: [BUG] KASAN: slab-use-after-free Read in xhci_hub_control
Message-ID: <2025071748-unlovely-citadel-3dc8@gregkh>
References: <CAFRLqsUZTDm0KAfX_qziTrn6E3+sRksF5ormxhHConqTKWvHBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFRLqsUZTDm0KAfX_qziTrn6E3+sRksF5ormxhHConqTKWvHBQ@mail.gmail.com>

On Thu, Jul 17, 2025 at 08:24:17PM +0800, cen zhang wrote:
> Hi maintainers,
> 
> I've encountered a kernel crash in the xhci driver, which was found by
> Syzkaller on kernel version 6.16.0-rc6 (commit 155a3c003e55).
> 
> The KASAN report points to a slab-use-after-free read within
> xhci_hub_control. What we find puzzling is that the free operation
> occurred in a completely different module, as indicated by the free
> stack trace.
> 
> We suspect this might not be a false positive, but rather a complex
> bug whose root cause is not a simple UAF within the same driver. We've
> tried to trace how this could happen but are struggling to understand
> the connection.
> 
> Could you possibly offer your expertise and help us understand if this
> is a known issue or a new bug? Any insight you could provide would be
> immensely helpful.
> 
> The full crash log and a C reproducer are attached. Please let me know
> if any further information is needed.
> 
> The full KASAN crash report is attached. Below is the C reproducer.

You are talking to a specific USB hub in your system, I guess a xhci
root hub?  Or one that is external?  Can you clean up your reproducer to
be readable so we can try to run it locally with any USB hub as the
option?

thanks,

greg k-h

