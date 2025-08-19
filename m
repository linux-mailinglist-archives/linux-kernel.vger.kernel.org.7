Return-Path: <linux-kernel+bounces-775506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A9EB2BFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC867B0CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908C24E4C6;
	Tue, 19 Aug 2025 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EU/dnjV+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7389131CA57
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601970; cv=none; b=npJAVwqdwOrVZvGpqAqU5E28nwPYjwEm376QYwATZTaFU3xdg37FtHlNrsf4ARWTZoX0etwVfX+CAG+7YfGz0WUu7s3MjGv7qdwyK4x9TyjgIfjSmDOKHHXnKnObVKW6/iK1eofANXWDDgnbpYp3NVB+3JErZ5AAFz+Z15I0Muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601970; c=relaxed/simple;
	bh=gYwPljPGMmj28uRMgGu3PnFO1RAp6ZlpkME6j129F8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2H2zzec5WnHlzPkKS4RUMa+dh/eU39hPZJzEauuiHBIW426qQm+dXPrjQs7T+w/WFAY6NRRQUOgOHnoX0mM3FNX8dU19xT0cvSo0OinL560eGpDvJvRjNBslCCZeOWIbTSxiKtypWaXbfvuwrr5gCd6fLUFftaP17Z+KkOVSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EU/dnjV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D143C4CEF1;
	Tue, 19 Aug 2025 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755601969;
	bh=gYwPljPGMmj28uRMgGu3PnFO1RAp6ZlpkME6j129F8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EU/dnjV+gZfrkjoyKV44CIFN5qGYeJJBLfNa3fyL15Or8HC6Lq13ssw49PKqbrFvk
	 cozaBwc2d+A6V/Oo23Or1uk5w9I30OG1IHzGdrgXQOmXICx5HFEVUyEhMRToz1z2Rn
	 wxhYWCBIFoj+/jxkZti3wzmURzyB8LCO+TseLQQE=
Date: Tue, 19 Aug 2025 13:12:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] sysfs: finalize the constification of 'struct
 bin_attribute'
Message-ID: <2025081934-math-lavish-c7ec@gregkh>
References: <20250811-sysfs-const-bin_attr-final-v4-0-7b6053fd58bb@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-sysfs-const-bin_attr-final-v4-0-7b6053fd58bb@weissschuh.net>

On Mon, Aug 11, 2025 at 11:13:34AM +0200, Thomas Weißschuh wrote:
> All users have been migrated to the new const types and variables.
> Get rid of the transition machinery.
> 
> After applying, make sure no leftovers are left:
> $ git grep bin_attrs_new
> $ git grep read_new ':!drivers/block/swim_asm.S'
> $ git grep write_new ':!drivers/cpufreq/powernow-k8.c' ':!drivers/s390/char/monwriter.c'

Looks good, thanks!

Finally queued up, sorry for the delay.

greg k-h

