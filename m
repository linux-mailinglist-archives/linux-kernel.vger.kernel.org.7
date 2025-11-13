Return-Path: <linux-kernel+bounces-899976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C37DC5945B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD9194EC531
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8930AAB3;
	Thu, 13 Nov 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RskdFXwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8244D2FBE03;
	Thu, 13 Nov 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055475; cv=none; b=GAQGcqlDGvZ7R/7KJshr9mMXeZyLCrkA1emceM1wgMEojOAVmJQ6kbd3XVn46lXQ9qPZ8Y6v5gw0YNIxkzVoGfp1tGe6douLHh13kGeJVT/VPOTVEOQeHiO7VxM60xje2lxVZTmd4CQgQgs+0jM517E4I3oI7xbIrqRUM94rHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055475; c=relaxed/simple;
	bh=7NoJsLrTm7q393HteHKSsPD9r5KzwyUm+Fi+IaGWKfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVMid6PpDLDovkWIpzL+/+a4snujXQad8CJfgbrTKo9hXApLioJADpfxxg+Q28oO63yctP7oIdtgjNkJTHJaEFjxn1I1uy7npyxk5REQGF2AYB72NmoPSx5csrCblkRt79eAtBSgJwe6VS1jQQXWq1zEt0QTIBWm91odVhKCrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RskdFXwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14636C19421;
	Thu, 13 Nov 2025 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763055475;
	bh=7NoJsLrTm7q393HteHKSsPD9r5KzwyUm+Fi+IaGWKfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RskdFXwNKpKbQCN7US841dmtrVnR8BdCN/9u+RAW3SUnK2ig9FlmSSidYyktV8XXu
	 TiMpaqNmMKMdXUQ53qlNU7Klyhuge2C5Zo/RkBb10HnpITgoNQtAhCO/3Fs7nn6mu5
	 zOZnQE1d2AZLQiqfwta3dDg3DN0lKZ0mpBpVcJUySKL/IMuGZspTKVeApwkJyYKqxi
	 Y5f5/W86IwS447VSLNpGXfUr/xwINU8FYvYOnoMRM6/zQY49amLFDSZ9B5xGfNqiJQ
	 wcxMhZbBMvjWJUEZNihkabgTL/ywOtDUwuMLzy/K6wXAlQAS6W/JZ4RFOfH9pU21Sd
	 5a+wy5/YXjvsw==
Date: Thu, 13 Nov 2025 12:37:53 -0500
From: Greg Kroah-Hartman <gregkh@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2025-40128: btrfs: fix symbolic link reading when bs > ps
Message-ID: <2025111342-maroon-untouched-02a8@gregkh>
References: <2025111253-CVE-2025-40128-2dd9@gregkh>
 <20251113104008.GM13846@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113104008.GM13846@twin.jikos.cz>

On Thu, Nov 13, 2025 at 11:40:08AM +0100, David Sterba wrote:
> On Wed, Nov 12, 2025 at 07:24:04PM +0900, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > btrfs: fix symbolic link reading when bs > ps
> > 
> > [BUG DURING BS > PS TEST]
> > When running the following script on a btrfs whose block size is larger
> > than page size, e.g. 8K block size and 4K page size, it will trigger a
> > kernel BUG:
> > 
> >   # mkfs.btrfs -s 8k $dev
> >   # mount $dev $mnt
> >   # mkdir $mnt/dir
> >   # ln -s dir $mnt/link
> >   # ls $mnt/link
> 
> Please drop the CVE status from this patch, the bs > ps (block size
> bigger than page size) feature requires CONFIG_BTRFS_EXPERIMENTAL and is
> unfinished and possibly unstable in other use cases. It does not make
> sense to improve security where none should be expected.

Oops, good catch, now rejected, thanks for the review!

greg k-h

