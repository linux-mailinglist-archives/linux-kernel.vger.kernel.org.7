Return-Path: <linux-kernel+bounces-837560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FEBBAC93B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DBD1772A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB9220687;
	Tue, 30 Sep 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g70O6Bvy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250A275AF6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229947; cv=none; b=pctc/MzGDkZl3zNhv85rvdiu9Vz6ZqfegAlSN+gtNs7SBKgOTI6A3NvBAxMe7/3QNBVJQenluw2JPxvn9OrvNbbQa62vi/tMxtVtx9sys/Ye0bqaeVoKqVChYm0sSFAIJm1q+0EtD+fw86SODXG+c2gSRHNMxf7/mVkuKiTaBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229947; c=relaxed/simple;
	bh=E65b9ymcnTdSD4pamzT3gF+RUMteaI+g9HTiFo9vdI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6pJDt/uI23CtPuIZtvwh+pp1cTW49U/Z2BKrZ1vOeO4POFvudl7rBkwBZC4zJEWaWmFaveUYphw2thmyvFrxKnFDauxc9Qheo08APSVJli+coWpbwX09c4hICuqQcGJjvJu1FooakoThuQTxqufWYEm+4womJjV7EFqlhNaICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g70O6Bvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444D3C4CEF0;
	Tue, 30 Sep 2025 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759229946;
	bh=E65b9ymcnTdSD4pamzT3gF+RUMteaI+g9HTiFo9vdI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g70O6BvydSTc5pU3kf0bNSSRs9YBaswCFWpmHL4FMKEzfUOylzr3R+4QrmUFIO2MU
	 GW1xohsDo+bN4lUBsdKRrs02QWqyA80kAB0g12ge6Z+5m0/50IE2IjOB12zJ5SEZdI
	 Rx3hEDHVsxIU8iTMxjowOiAKmiI2GpbTlCda8JJs=
Date: Tue, 30 Sep 2025 12:59:03 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-38495: HID: core: ensure the allocated report buffer
 can contain the reserved report ID
Message-ID: <2025093001-petted-boney-29c2@gregkh>
References: <2025072818-CVE-2025-38495-3b28@gregkh>
 <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>
 <2025093000-shrank-vending-2bd1@gregkh>
 <552d5ba4368ce43b12b4aa8b01852a4d8af1bdbc.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552d5ba4368ce43b12b4aa8b01852a4d8af1bdbc.camel@oracle.com>

On Tue, Sep 30, 2025 at 10:54:06AM +0000, Siddh Raman Pant wrote:
> On Tue, Sep 30 2025 at 16:19:44 +0530, gregkh@linuxfoundation.org
> wrote:
> > What git id is that?
> 
> 0d0777ccaa2d46609d05b66ba0096802a2746193

That commit id on its own does not "fix" anything that we can see, which
is why it was not given a CVE.

> > And this commit on its own fixes a problem, so it should be a separate
> > CVE, right?
> 
> The reservation of 1st byte happens in the next commit.
> 
> Not sure why the change was broken up into two.

Then the second change is the one that gets the CVE.  Any "previous"
commits in a series that were preparing for the real fix are not called
out.  As each CVE entry says, do NOT cherry-pick, but rather always take
all of the commits in the stable release.

thanks,

greg k-h

