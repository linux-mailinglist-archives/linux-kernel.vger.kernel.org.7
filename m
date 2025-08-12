Return-Path: <linux-kernel+bounces-765051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB91B22ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4B417BE83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D52EBB99;
	Tue, 12 Aug 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QuSktERA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2F2EB5AF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009373; cv=none; b=l3EazMwvFqEcvWxLujoO/RBJkCbTg2qxScu5mmbD1ToVULHNXbr8QmufjyAqVLpu6ja/UtbIp7UrURMaFPkx+ZNjXz65O0GU+qAIQF7c2XOK8q+yMwVgzSKhBUvT0LIo9pFgANnh1sl44QYRHDHRDsr5cUkZtwRLKIwpan4Js1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009373; c=relaxed/simple;
	bh=89n+NywhAeda14CQQltpc+rwkhu0Gb2gZBX8mz89QqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkueqFm6fM/2CJ4U3hM1ognzR10B4kf2ITXK/JifMb6SIK6qPyIG5vw1mrKGBjh3Ft+ofey1pNdjRaepIbMDsfuRZ0NsE/IxRJnJ9DjqerZIMihdLR9C0970sVpSBxx5VwoACVIBysUiOp7pWzQnQbQ4stJbIQTaYwPsKeKQbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QuSktERA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B426C4CEF0;
	Tue, 12 Aug 2025 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755009372;
	bh=89n+NywhAeda14CQQltpc+rwkhu0Gb2gZBX8mz89QqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QuSktERArligiap2NdIuR4n+0LmX501IjNAeolG05q1lS73eaFbCIrL3yKN8LEEWQ
	 5tphpmp/55DqTYUsdMP4uJk3goaHBIZwWLDhJDaiY4UrNCTj3OqObU8mG9nEgGBl3F
	 f5kcza0ZrFEwfxftXZ3SUq71i7YRD5pMHFeuIG74=
Date: Tue, 12 Aug 2025 16:36:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] sysfs: prepare the constification of struct
 attribute
Message-ID: <2025081237-slot-urology-23d6@gregkh>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>

On Mon, Aug 11, 2025 at 11:14:26AM +0200, Thomas Weiﬂschuh wrote:
> The migration of 'struct attribute' and its related structures and
> macros are more complicated than those for 'struct bin_attribute'.
> Mostly because they are all shared by various custom attribute types.
> Introduce some initial utilities to support the migration.
> These are enough to migrate some specialized attributes atomically or
> those which don't use 'struct attribute' in their callbacks stepwise.
> 
> The big outstanding problems are 'struct device_attribute' and
> 'struct kobj_attribute'. These are used everywhere and I'm not yet sure
> about a migration plan.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v3:
> - Rebase von v6.17-rc1
> - Link to v2: https://lore.kernel.org/r/20250629-sysfs-const-attr-prep-v2-0-9ec5fe39083f@weissschuh.net

Sorry about the delay on my side for these, been swamped and then took a
vacation and now am trying to catch up.  Please give me some time to get
to them, they aren't lost and I really want to apply them...

thanks,

greg k-h

