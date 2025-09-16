Return-Path: <linux-kernel+bounces-819533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8BB5A239
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469BF1C013A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41132284678;
	Tue, 16 Sep 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmGBTPBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A41FDA61;
	Tue, 16 Sep 2025 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053784; cv=none; b=B0qR06hprQRYq8YWwjXUuXG/WK/yiB81SuoBIWvEjv9znMD62ZCS5mFcMC5YE+1YwJbdMzgH34h6ru2YnXCzf20bZz0ithxNFW32ku1p0I9/6KlY8WW1tPgIMYAdyTRINNy2pnDfp9iAGlIbtOrJNwrrU25q54fR5TWuGQWqx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053784; c=relaxed/simple;
	bh=kEYCDM8Ylcs38Awp6V8kAb6nDG7pWlr8e2KRgZNrIfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIM24cncJVXlLofkTxvmRoKAyEQYvPQetP5VzoZfw58zUe+eicyizb/8vTxduDeYAVwjp58uMdhZnsjxhuH3aGCX656DhFuB1cwMDov/2fFgr8L8xYCMorMFResJ+2ouJNnrEI73wM8OXtVFKCmtzdL8y4jEewgzB8p/2IhPUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmGBTPBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A04C4CEEB;
	Tue, 16 Sep 2025 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758053784;
	bh=kEYCDM8Ylcs38Awp6V8kAb6nDG7pWlr8e2KRgZNrIfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmGBTPBRu78phExPphVtBkUoFO/aQZinPd0TKZXuOIECEHCgj2j+Pd8BfxD+SpzoU
	 T+4SNZ8gIeCueVul0LQn9UkSFD2ZzTHaPdvXpXsSC+sMg1OLj98W3c/GTqqtOCRwnv
	 VJDlU2DX8R0hPxnJLv6eMkN9DpCMFedj+qXqAnyoEqwxJujzMN/uiJJqxl2WfZIj8M
	 ZaUrZUnzl0rrCvjj9ajpOkv1Va1XCuou4ZdQdKUWU0/B4SR1LocOBNw3Gklo9fEx6T
	 cUn5+b0oKSwcHxQBGFS2oxuukkqSq7Ff49YaOP2GJva5WsoYVITaliaj54qMbjdsbS
	 bxPZYIc23bZ2g==
Date: Tue, 16 Sep 2025 10:16:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "sched_ext: Skip per-CPU tasks in
 scx_bpf_reenqueue_local()"
Message-ID: <aMnFlhYUD-Cb4Qgd@slm.duckdns.org>
References: <20250912161438.529446-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912161438.529446-1-arighi@nvidia.com>

Applied to sched_ext/for-6.17-fixes.

Thanks.

-- 
tejun

