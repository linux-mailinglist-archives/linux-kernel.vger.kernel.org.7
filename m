Return-Path: <linux-kernel+bounces-722375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D9AFD90F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BBB1C263B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CD21B9CD;
	Tue,  8 Jul 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5vztqGr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF33BE6C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008458; cv=none; b=YtR34Ri20QCHOLSKPGBBDAnV0CNDaXFdkMOYcHw3oU2JRI8+N4Mmf4l8KvUU6doqcZEukEI1qflIYHcAfGcPwKZKq3Yqqu9G5IinDLGqb4A2tkWWECkYLA9v9/Tj4fpgqpfDSKBSQrHMYrPKJ3y03sYfH91UxeLrXXN4WxJN1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008458; c=relaxed/simple;
	bh=+utdZVyKZLz1RzFzGqhxhxa5SriOQ6iWAbEtY94Kmrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4jxSHU/trAzBL0PvijIkiOMxg2D0HObTuyrkdbLP81/LiLH0w6WKHQiFOAydFEijKmvRPkB/OfsSpIDWpD1HszdsiKqpuiWo//JNdoaE+YWe/kaM3JndVu3A/b/BWHi21z+94yHN1boxVHe1MpYnIw7F7zvpyz3d4k0kbLFr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5vztqGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E41BC4CEF1;
	Tue,  8 Jul 2025 21:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752008457;
	bh=+utdZVyKZLz1RzFzGqhxhxa5SriOQ6iWAbEtY94Kmrw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=r5vztqGrxSFwLrWerrM/zX+kYz6P8GFBEGVVZFdPg+bgG6rZqoVkPB1wB1BEt1wXb
	 V4nl1LgeyRn8o2DYYOvKaz6ZUFTuC80v1eVk75up1nu32WTfHZAtSEDyZ9SCy4ucNc
	 v1hdEdqkksIOgxvT3KYoWtw9FleN+Uj0hdBKlxSblS5/ahU1TEeHSj6bAaXjDrBZd9
	 E+4C6JPND5zN2ZFf/ComyI6hhWCHv6Wp7eQju/Wr0aBEz1KebHpZ2+Ok/p/legJSz+
	 9+P1wIBCnuFg1GyUyjI15Ri3LNh2RjTVHdC3LwgrvOy+jUP6vdM7rkpIh2HrE7rA8D
	 yiyLryLr1d58Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 307EECE0856; Tue,  8 Jul 2025 14:00:57 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:00:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Petr Malat <oss@malat.biz>
Cc: linux-kernel@vger.kernel.org, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 0/2] bootconfig: Support early options in embedded config
Message-ID: <f6b541a7-0eb1-43da-9ffe-d9b628aae29b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121231342.193646-1-oss@malat.biz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121231342.193646-1-oss@malat.biz>

On Wed, Nov 22, 2023 at 12:13:40AM +0100, Petr Malat wrote:
> These 2 patches add a support for specifying early options in embedded
> bootconfig and merging embedded and initrd bootconfig into one.
> 
> To allow handling of early options, it's necessary to eliminate allocations
> from embedded bootconfig handling, which can be done by parsing the config
> data in place and allocating xbc_nodes array statically.
> 
> Later, when initrd is available, it either replaces embedded data or is
> appended to them. To append initrd data, it's necessary to relocate already
> parsed data to a bigger memory chunk, but that's not a problem, because
> xbc_node structure uses offsets and not absolute pointers.
> 
> Also, update the documentation to make users aware early options can't be
> configured in the initrd.

Hello, Petr, and just following up.  Are you still persuing this?

							Thanx, Paul

