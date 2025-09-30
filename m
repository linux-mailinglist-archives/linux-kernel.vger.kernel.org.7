Return-Path: <linux-kernel+bounces-837602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C06BEBACB84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6561924372
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B02261B65;
	Tue, 30 Sep 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HD2Ynl6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DB34BA29
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232476; cv=none; b=mPNELy1xpGzggD9eYa03XLCLVk8V0n1mI0BrNt26tfnIzc/jU/GVOMJUlCikNRMeBzhWKzC/OVjVHaEmX6IgtUnc8ZjmCmuYenQqWh7vWnXMEi7xTiUAzYGSKxG1EgeB7g8zYHJr5NFjuBKwR8cAnXwlNBLHOQGAERp9OUt+we8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232476; c=relaxed/simple;
	bh=x81P//nVG7ffHaEuNhv5A3f4Koi+8po977JxNYCvkp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDYrNxPUFy6A9Hmj/Hc7WVrj3lXbOrthWtAKPR7V6Zuts1UKo022qUGCZpB18RkW/9mVF4qxjaGY9bNstdRC5qSS+oIOxeiunLtJ3G1VAkJc55Kd+HyBrsi018dQr1NTCblrlWkSVLjD41CiBlaIKNoIj852GTZi7IJDMvuXZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HD2Ynl6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D828C4CEF0;
	Tue, 30 Sep 2025 11:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759232475;
	bh=x81P//nVG7ffHaEuNhv5A3f4Koi+8po977JxNYCvkp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HD2Ynl6mep0P5hAMhxfbPqthLoNfMl7RbuTav1GGrmkTPOmqzh9jQ9x4RbXqwrnTB
	 VcOiTInpIB/8RDbqjRXgNhZv12V8xDCR59jA0L7QauoFoZCpGa3v6RmeidNE/4bvQK
	 A90bvzbNxTudYvwGY/SQidVha3g6Ou4tiZGMHaRM=
Date: Tue, 30 Sep 2025 13:41:12 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-38495: HID: core: ensure the allocated report buffer
 can contain the reserved report ID
Message-ID: <2025093057-bogged-rasping-0deb@gregkh>
References: <2025072818-CVE-2025-38495-3b28@gregkh>
 <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>
 <2025093000-shrank-vending-2bd1@gregkh>
 <552d5ba4368ce43b12b4aa8b01852a4d8af1bdbc.camel@oracle.com>
 <2025093001-petted-boney-29c2@gregkh>
 <883ad6064549f85dc56b2669bc3f395191b3da9b.camel@oracle.com>
 <2025093058-iciness-talisman-8a9f@gregkh>
 <c0d698cbcea6f46e6959ab1db07735cea76f3770.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d698cbcea6f46e6959ab1db07735cea76f3770.camel@oracle.com>

On Tue, Sep 30, 2025 at 11:32:25AM +0000, Siddh Raman Pant wrote:
> On Tue, Sep 30 2025 at 16:52:30 +0530, gregkh@linuxfoundation.org
> wrote:
> > Is the CVE referenced here in the Subject line, and the git id it
> > references not valid?
> 
> It is valid.

Great!

> > Is there some other commit that also fixes a vulnerability
> > that should also be assigned to a new CVE?
> 
> Yes: 0d0777ccaa2d46609d05b66ba0096802a2746193 which is immediately
> after the commit in title, and fixes the underflow reported by
> syzkaller (see [1] and the commit message for the tested-by), which is
> the main bug, for which there is also a public exploit (see [2]).
> 
> [1] https://lore.kernel.org/all/686bb229.a00a0220.c7b3.0081.GAE@google.com/t/#u
> 
> [2] https://github.com/xairy/kernel-exploits/tree/master/CVE-2025-38494

That is assigned to, and stopped by commit c2ca42f190b6 ("HID: core: do
not bypass hid_hw_raw_request"), so that should be fine.  And yes, you
do need to have commit 0d0777ccaa2d ("HID: core: ensure __hid_request
reserves the report ID as the first byte") applied in order to be able
to apply c2ca42f190b6 ("HID: core: do not bypass hid_hw_raw_request"),
but that's the case for MANY CVE ids that we call out, right?

Again, never cherry-pick :)

thanks,

greg k-h

