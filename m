Return-Path: <linux-kernel+bounces-805375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414CDB487C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AFA188434C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF92F067A;
	Mon,  8 Sep 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xj6nrIel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BC29AAFD;
	Mon,  8 Sep 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322262; cv=none; b=BNUZGqmJz5sqYpqKk049IIeFDZHRMZ08RnJbJimq7F90J/wRHFJrkRp0gr7fsptfmG/abPYvA/Yy4kuOC+Di8HZ8eNfsXXuUsb0gmkiz/lIX9Ww3+2s4mbwcbSIwfJz0DW4TO4OykJauAasMn1TOntM33ls52D+LCbiAJCKkM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322262; c=relaxed/simple;
	bh=biPwnVE8rPeb8vXIlhFxcfJKGGEMvu2bej1LtlQcazE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRexqudb1VP5IJyebuvRh+QF5PPN7IJzPs0jY3VCKxOX83Bj0Hh8ltognFrWOCXwuFlZbP7dirKUaBU7o5/5YjIPYn4AGdxbkEdF/oRVJWySbTaQImQi7+uTSATGQqWczKof//gmfl4N58ohfhzD1DwUOh7Mqg0Wm9XuSJyVb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xj6nrIel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5067C4CEF1;
	Mon,  8 Sep 2025 09:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757322262;
	bh=biPwnVE8rPeb8vXIlhFxcfJKGGEMvu2bej1LtlQcazE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xj6nrIel17cWmR8NI2nyh9umX3Ez5ESJhTetNNULDLm5ed6t7y99MSItoDh4Aoc+d
	 ZYAYhGICRNeXPhbLNZhAFh1TeJmLWZh5YGZMikqMctgkob2TasfSovpJjIPAWc0Agm
	 1irHf3056jZDtWvUnKPXvBDzrfkCT3AOOAPwfPqk=
Date: Mon, 8 Sep 2025 11:04:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Akshay Gujar <Akshay.Gujar@harman.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, naveen.v@harman.com,
	sankarkumar.krishnasamy@harman.com
Subject: Re: [PATCH] usb: core: notify unrecognized usb device
Message-ID: <2025090850-quotation-corned-13bf@gregkh>
References: <2025022131-silo-impeach-3f24@gregkh>
 <20250826165244.22283-1-Akshay.Gujar@harman.com>
 <2025090610-donation-sprawl-f6f7@gregkh>
 <fb8c0ad4-0626-4d03-a7f9-a03629566b99@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8c0ad4-0626-4d03-a7f9-a03629566b99@suse.com>

On Mon, Sep 08, 2025 at 10:58:35AM +0200, Oliver Neukum wrote:
> Hi,
> 
> On 9/6/25 14:28, Greg KH wrote:
> > That's a very big difference.  Enumeration failures happen all the time
> > due to horrible cables and other hardware issues.  If you are now going
> > to flood userspace with this information, it better be ready to handle
> > it and do something with it.
> > 
> > But, for an enumeration failure, you can't do anything with it, so why
> > report it at all?
> 
> that is probably not true. For once you can try another cable in many cases.
> Currently we'd log this information. That is a worse way to handle this kind
> of failure.
> If there is an unrecoverable IO error, user space ought to be notified.
> Syslog is not the best way to do so. There ought to be a standardized way
> of doing this. However, this makes me say that this issue is not really
> confined to USB. Other hotpluggable busses have the same issue.

Yes, all busses have this type of issue for when devices can not be
enumerated or fail.  We shouldn't make something that only works for
USB.  I think PCI reports this type of thing somehow, so maybe
generalize that api?

thanks,

greg k-h

