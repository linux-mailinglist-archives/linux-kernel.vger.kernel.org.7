Return-Path: <linux-kernel+bounces-763410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DEB2143E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9279E6258E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E12E11D1;
	Mon, 11 Aug 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYYuyrKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6152D6E42
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936542; cv=none; b=Z4331Ziwl4UdKIgMoqxumUDOLobYXJYYu/SjHOKQUA0AOcVVP5uG2stm1dQz8TwxjpmRZOWHB0xsMRvs/5r1UkCAB0+qjtqqOxl48HBXOJg7uTuU1V8zVrp4s0b4DVNF2Ue4dkGdVqah6dKlg6Qf8sn0YJGK0kfZOBShJrW3uC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936542; c=relaxed/simple;
	bh=q5dJdsjoxy9j2Cp/MIOSZiiCzeToApX8+0RvK+BN4CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+KcLnEN5FmbU/I1nrKLiOgezoBtJ7ppfYOdal5jX/nqHgmE9K7GSxbTp9tdyAfKllA/Dg+3zEyEy5ytT+9z7/jb9p+L8KeZLn2RbiCW6nqPP4QYVF92ck9Xz4BqbnR7LW60gHxUfNMlr6RNHxAkOhSW0i83UXk/hlfiRQtRk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYYuyrKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D952C4CEED;
	Mon, 11 Aug 2025 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754936542;
	bh=q5dJdsjoxy9j2Cp/MIOSZiiCzeToApX8+0RvK+BN4CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYYuyrKzNfMluo4aYmD7/Co+9Tiz1yXSYZjqwNehA4208Vlvo0wm0H4jinnm3Pv5y
	 AznQLR30t5clv8QDmZYlgb7QiL0N/F2RLETkOy19mP6CTNg6tt9WcmKXCC+/ZwvWxn
	 auS2UjWvhVhQl/2KRRE0q2/EdEPkyhJ6d6Na1V3h9YgFdZRXwMZpCBnN3VHiXbq0Ua
	 Vae5E4HU779SRjhvRj/m6SVTy5hDDha4PWE8CF32SZw0JMst7mA++a9WsM1Yqtfhf+
	 ARlr0/c4rcl7UeDD9N8cxjtV9nvsVLdlCj1LAykaL9njF0epEIxrXDLgMStVOQoE+s
	 yH2rxNSXKX8IA==
Date: Mon, 11 Aug 2025 08:22:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Receive updates from SCX repo
Message-ID: <aJo02GwCco0ToB9B@slm.duckdns.org>
References: <20250804110449.696135-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804110449.696135-1-arighi@nvidia.com>

On Mon, Aug 04, 2025 at 01:04:49PM +0200, Andrea Righi wrote:
> Receive tools/sched_ext updates form https://github.com/sched-ext/scx to
> sync userspace bits:
> 
>  - basic BPF arena allocator abstractions,
> 
>  - additional process flags definitions,
> 
>  - fixed is_migration_disabled() helper,
> 
>  - separate out user_exit_info BPF and user space code.
> 
> This also fixes the following warning when building the selftests:
> 
>  tools/sched_ext/include/scx/common.bpf.h:550:9: warning: 'likely' macro redefined [-Wmacro-redefined]
>   550 | #define likely(x) __builtin_expect(!!(x), 1)
>       |         ^
> 
> Co-developed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.18.

Thanks.

-- 
tejun

