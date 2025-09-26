Return-Path: <linux-kernel+bounces-833607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91650BA266E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8811BC39BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B6C2737EA;
	Fri, 26 Sep 2025 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Y1GhiU/F"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95F17597;
	Fri, 26 Sep 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862144; cv=none; b=pBFnnIxOjq6VfnDIQ83ozTeteAy1oLOoaGRJ1vJvcu/D5YVZBLUsLR6G2dmceXo5n2M95kixFtxUebnEHgGpqDPi51h9OTdAKo5brJ+F0cvhDCG+vE5gFvDpeVkLZ8pDR1S/0+AzxNsepIB3W39Rz1U1tM3x0HJhRzixmXRvnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862144; c=relaxed/simple;
	bh=9CJr5CRkVOsz/LVbkw/6FHQYdZULbd6hZ3WHbVOmXnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nghzTiwxjQ+abDG1PzzetbBSX3EQYcFL42vMvfdd8YvJeYEr3UuS1e0bAKgFpV+EphoTTihm6QamUIYXjSZ6Z7RQE3tWdfV7ZYRyzCyK7xL4Cao6c5ulZ+VJcTWUHMv+jKT5tAJKg7ZwuAdOX5eGDMAr3EyMc4xxfiHIMj+GTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Y1GhiU/F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ci/b6XKUo+LzQzMqqgYYAPdWLcGExzBQevF8norEXGk=; b=Y1GhiU/FexI7JJO8JHwshq4jHy
	eAWNiNl9wG2BENqPPgxDMPNcP6ZUr7yFYfRVOF3gaJUMC0oLW31u3ynGj3giz0N2Nv6i1mGlLXqCi
	wuVNkOsUvSvgNRC5uzYrrvy6v1uBipiIl0k7YxPcXUbZMvUFBMububzOCoKnT5fxhcZFpexDeg1Ta
	WA1afBhNCGahEA7PgJ4VQVW3ECvI4dPtnru5A1fGKhlmzkyTxefuhUoA7h6gU/LiFHh2ettzlcHfh
	t3UoiaPtxFZ+VnMUR5W3LlXGP7IpWukpKBwuCohqcHbHOx+u50h9j8N3zdmvfZo0SqSz/TpDb9wYE
	xYCNz5yA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v20O6-0000000H0dm-2rsL;
	Fri, 26 Sep 2025 04:48:54 +0000
Date: Fri, 26 Sep 2025 05:48:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Youling Tang <youling.tang@linux.dev>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] gfs2: Move i_nlink checks from gfs2_{link,rename,mkdir}
 to VFS layer
Message-ID: <20250926044854.GD39973@ZenIV>
References: <20250926025604.500713-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926025604.500713-1-youling.tang@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 26, 2025 at 10:56:04AM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> vfs_{link, rename, mkdir} will check i_nlink. When sb->s_max_links is set,
> set sb->s_max_links in gfs2 to simplify the code.

For gfs2 you are going to run into a problem - link count is not stable until
you take gfs2 locks; checks in vfs_link() et.al. will be inevitably racy for
cluster filesystems.

