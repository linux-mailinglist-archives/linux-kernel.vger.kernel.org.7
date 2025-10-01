Return-Path: <linux-kernel+bounces-838915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B78BBB06AA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9CA2A192E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F92EC0A9;
	Wed,  1 Oct 2025 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ml5FWrz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877C22EC08B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324083; cv=none; b=UBA6L78lBsgSKEVEfv4rXDwPqFlrk3Qcf6CqPiSeyjw+0mKoQIMWx7E++nICVIdEH8Kb9NIq2tXrTuWwwwNAyPz/5GpEGltBZjKbhU3dGdj5dttuVp1JXJSzrMIa43CKQhEqT+UbiIYp2yXnu6YiNRsAe27pXmFKnE7zs1wPTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324083; c=relaxed/simple;
	bh=MMFEH8eHeKKYvu9uAHBZzj7EPGd+vDERwF5xlrxSKMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL6pb0wtQK7xJgDJopS0uuOrgD+KXdzhXuDAvOz1grmwkMBcYLfW3BiB72jgV0ilmV7V/gRHP5VrDdjbmeHaGIRhf9UPOEQ2FK1k2vYvorT8kdLZ1eQJI7Mxlqt5Z+hEOCjDMPxVxySdydb2n8X24ps/8WwL2kNSy/42Ii3guZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ml5FWrz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC32C4CEF4;
	Wed,  1 Oct 2025 13:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759324083;
	bh=MMFEH8eHeKKYvu9uAHBZzj7EPGd+vDERwF5xlrxSKMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ml5FWrz3KeTYvBu0uMylH5V635XIsdLcN3Ifq3sW1awYpKFF24tymHh/fQesXbxjh
	 VapwN9gnkSarDLSGFppxIeHwzKM3lcAgdgp3WisUNEHFtFTEkiZg0OWiI44ghOLIFz
	 ve3SrwzemNj+GE8bFYQffLHPyZQmfnh4MmXBoHi0=
Date: Wed, 1 Oct 2025 15:07:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-53502: xen/netback: Fix buffer overrun triggered by
 unusual packet
Message-ID: <2025100103-helpline-finishing-055f@gregkh>
References: <2025100127-CVE-2023-53502-aa6a@gregkh>
 <bca10ff3-75d2-4063-a323-8881d8baa3c1@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bca10ff3-75d2-4063-a323-8881d8baa3c1@suse.com>

On Wed, Oct 01, 2025 at 02:05:47PM +0200, Juergen Gross wrote:
> On 01.10.25 13:45, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > xen/netback: Fix buffer overrun triggered by unusual packet
> > 
> > It is possible that a guest can send a packet that contains a head + 18
> > slots and yet has a len <= XEN_NETBACK_TX_COPY_LEN. This causes nr_slots
> > to underflow in xenvif_get_requests() which then causes the subsequent
> > loop's termination condition to be wrong, causing a buffer overrun of
> > queue->tx_map_ops.
> > 
> > Rework the code to account for the extra frag_overflow slots.
> > 
> > This is CVE-2023-34319 / XSA-432.
> > 
> > The Linux kernel CVE team has assigned CVE-2023-53502 to this issue.
> 
> As can be seen right above your line "The Linux kernel CVE team ..."
> this issue has been handled by the Xen security team already and a
> CVE is assigned since then.

Ugh, then why doesn't that CVE reference this commit properly?  I do
sweep all old CVE assignments when doing this old-rereview.  Any chance
you can go and update these CVE entries with the proper git ids?

> Please revoke your CVE assignment.

Will go do so now, thanks for catching this.

greg k-h

