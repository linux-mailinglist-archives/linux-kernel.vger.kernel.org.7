Return-Path: <linux-kernel+bounces-882127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127CC29B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 01:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B535F3AC4DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 00:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023C157493;
	Mon,  3 Nov 2025 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KyJfI+xq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D732C187
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762129557; cv=none; b=J6CSUSJGPRTnSLRay4nsHDY2KSO9HNdMACzqeFTjnV2WNorCPk1pW6BwSIwNNRkul3WdxdUSVIZRwF//iYixr5hIijd0Z+DbWRW5aDr0vLo8Grcwy5Nl90N3fv5rffDfxZCkZd+1hFF07JdndXyV9IKIxbFx4LqvSgOWa5FQrs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762129557; c=relaxed/simple;
	bh=k7limerRYI7P30epLI9uBlnb/xDp9fAPN983ra12iYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiUG10KesSDFrVfAZA/2b8DiaYWf8fSA8LkjMWvjfM6yP16zk3u4EF3+uSnpBytWu+6dwB2xf94JF6rspWmdDmAzcoIWJQHX/rHHUydviMAfL99qpT4TxgqsiafshWjJTGBbiA9U8DK6eTlDTsCBkhwgC44Xcat4iFHHZ6jdp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KyJfI+xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C8BC4CEF7;
	Mon,  3 Nov 2025 00:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762129556;
	bh=k7limerRYI7P30epLI9uBlnb/xDp9fAPN983ra12iYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyJfI+xqZOrm4JLjKRPjBNogHvGEXeGWDwyNI+HjaDY4gJGVR5H/084LQ4xjbcHOc
	 NnHqdxKReU8RVqT0HSAkELx5/Xm9i5yZnfsKU6uxvWKtT2htyebERc4Md8dPxjqI/0
	 zbb/9ycYqtcOG114pHVjjQfMUtJ+YPAvaRseXF10=
Date: Mon, 3 Nov 2025 09:25:52 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: alexander.usyskin@intel.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: bus: Add newline to sysfs attribute outputs
Message-ID: <2025110319-activist-register-d119@gregkh>
References: <20251030123000.1701700-1-zhongqiu.han@oss.qualcomm.com>
 <2025103052-taking-shredding-c77a@gregkh>
 <83d8d2bb-767a-4dd6-8e1b-de96164cad4c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83d8d2bb-767a-4dd6-8e1b-de96164cad4c@oss.qualcomm.com>

On Thu, Oct 30, 2025 at 09:11:34PM +0800, Zhongqiu Han wrote:
> On 10/30/2025 8:32 PM, Greg KH wrote:
> > On Thu, Oct 30, 2025 at 08:30:00PM +0800, Zhongqiu Han wrote:
> > > Append newline characters to sysfs_emit() outputs in func max_conn_show(),
> > > fixed_show(), and vtag_show(). This aligns with common kernel conventions
> > > and improves readability for userspace tools that expect
> > > newline-terminated values.
> > 
> > What userspace tool reads these values today?  Will this user/kernel api
> > break them?  How was this tested?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> Thanks for your review~
> 
> Apologies for the confusion in the commit message — there isn't
> actually a userspace tool that depends on the newline in this case. I
> just made the change to follow common sysfs formatting practices and
> improve consistency.

That's fine, but please work with the people that wrote the tools that
depend on these files today to verify it will not break anything, and
then resubmit the patch with that information in the changelog.

thanks,

greg k-h

