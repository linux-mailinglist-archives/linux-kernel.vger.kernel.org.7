Return-Path: <linux-kernel+bounces-767766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D04B258D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816705A0DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8533B175D53;
	Thu, 14 Aug 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c/72uRa8"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19D1487F4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134144; cv=none; b=jWL9SlaG/6piuJPJWyuMEyJ5gp8uwhNolTKxi4MXP9LvBBUjQcH/9RpNoYhkAZI7X72KJ8tOoA9pPhCxZk6fssUuy/xZ8fYvEE26S6vcPhNEGwMBLSacyi0tjR4jqNUAKx7LmP5syXXWvVkJquxQJtovhG/bBWMFf8Pgf3PYSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134144; c=relaxed/simple;
	bh=d5BLvqLX09urzN2uAU0YVQ0bDClV0GcGpl2S5bSzuvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCN5k8ipqoYQFdprbajvr6bXtooOeTJMNJD0nerdEFLsIsHBGQwfnn59qxKcn98jLZT4JgcLGTJOnjiJN/V+vmCXWq0F5KaaX6ah2agVC59uyK6P/Kd1thykggqYXRgr4yfwq0u4ASJ/9NgPhed7tjX2QQ5WoB4YTTJs2xswvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c/72uRa8; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755134140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSvSvM4+2zysM7Te3VGN2ddfsfP4tfKOXYOL21jw4Tk=;
	b=c/72uRa8U+SGtBAIzpSF+4uvT4rWbTWt7uyNK9ugtT8L8Ly4eYXOq0D5JQ+laqSPW8rNhc
	6HpqT+lTfXdGQ/vYWPAqO0ggScHvkGNlph1zVAYvrTHSYKf3OqilkEJnvCESTrRT7qOPaV
	Gf4gjW2PzmRyjJLUzQ2vysAw+X0YtQo=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	yuntao.wang@linux.dev
Subject: Re: [PATCH] fs: fix incorrect lflags value in the move_mount syscall
Date: Thu, 14 Aug 2025 09:14:59 +0800
Message-ID: <20250814011459.270835-1-yuntao.wang@linux.dev>
In-Reply-To: <20250811-zitat-diebe-3acc89b8c971@brauner>
References: <20250811-zitat-diebe-3acc89b8c971@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 11 Aug 2025 16:06:59 +0200, Christian Brauner <brauner@kernel.org> wrote:

> On Mon, 11 Aug 2025 13:24:26 +0800, Yuntao Wang wrote:
> > The lflags value used to look up from_path was overwritten by the one used
> > to look up to_path.
> > 
> > In other words, from_path was looked up with the wrong lflags value. Fix it.
> > 
> > 
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [1/1] fs: fix incorrect lflags value in the move_mount syscall
>       https://git.kernel.org/vfs/vfs/c/593d9e4c3d63

Hi Christian,

It seems the patch hasn't been applied to the vfs.fixes branch, the relevant
code there appears unchanged.

Thanks,
Yuntao

