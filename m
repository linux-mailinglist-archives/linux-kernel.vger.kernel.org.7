Return-Path: <linux-kernel+bounces-882313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE2DC2A292
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD73ABACD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68E34D3A5;
	Mon,  3 Nov 2025 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FES7Ohcu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A22296159;
	Mon,  3 Nov 2025 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150863; cv=none; b=pLsdhuTvSE9CSERTs87gakXVpTzi9dH2c30tOrLcDHcIaShFhKSCYxwZOf/43S2ywXxCoH9NXXXxPHjj+q6QMCtYJ8XD4rfpRGt+Dyu2FIJsN3T9PKmT8hJh+BXBDCBhuT4u4r+Yt/svqV2hoheEcN0+6C+/HCfk0qi9od0ZKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150863; c=relaxed/simple;
	bh=BROtHk15VmMYYPXI1zzaTkxkj3nQNT81u4d3keAB8QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAQrwuvHok86U4IHZ45EuepIyT7Gm/77U4JSbVWbXl2i5BfjPP2SLD8kqsjIhhwWcZssdsTRMEKyWPcOsLgU8RiPcHJ99hZb7/7mhms+RA5Wf6b9wcHWZy74LoSTi5aUpKbrtpV5Kujt6TBGZXQT8oSuuJ/fqN1xemIqHNZYc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FES7Ohcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F6FC4CEE7;
	Mon,  3 Nov 2025 06:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762150861;
	bh=BROtHk15VmMYYPXI1zzaTkxkj3nQNT81u4d3keAB8QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FES7Ohcu/6KzEri9GkCElo8HkPm6Cb/eJLOO7asrj0oGj7VL2/Uph1xr2Lj1T5WWW
	 em/rA3nyJ+jEjSJnOvDUG6BSqYUlb1AnmQ/V5I4VNF5JElQEd2KI1WWQ/TugAogbrK
	 8bwaV5nIeSTAEHP3WPqTMyfyldbOhwBYtOfSLSHw=
Date: Mon, 3 Nov 2025 14:27:37 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: heikki.krogerus@linux.intel.com, amitsd@google.com, kyletso@google.com,
	rdbabiera@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/1] TCPM logbuffer wraparound
Message-ID: <2025110336-hummus-stank-e5ff@gregkh>
References: <20251103052450.1028813-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103052450.1028813-1-badhri@google.com>

On Mon, Nov 03, 2025 at 05:24:49AM +0000, Badhri Jagan Sridharan wrote:
> This is a follow up on a previous discussion:
> https://lore.kernel.org/lkml/20230410073134.488762-1-badhri@google.com/.
> 
> With this change, TCPM log buffer will now wrap around when full and
> will not self-clear upon being read (dumped). A Kconfig option and a
> corresponding debugfs file node are introduced to allow opt-in back to
> the previous, non-wrapping, self-clearing behavior if required.
> This is an interim step while TCPM logging infrastructure is migrated
> to the standard event trace system. 

Ick, no, let's just move to the standard trace format instead.  That
should be much simpler and get rid of custom user/kernel apis and
Kconfig options.  Overall you should end up removing a bunch of code
instead of adding new complexity like this.

thanks,

greg k-h

