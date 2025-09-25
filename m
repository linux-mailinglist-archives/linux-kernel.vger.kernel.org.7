Return-Path: <linux-kernel+bounces-832794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06923BA0610
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8601C24393
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B203054CB;
	Thu, 25 Sep 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emLiPHCn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC712F6180
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814337; cv=none; b=Rwv1BfKWzx7tTpX78TgnAyAVCmzUvoZcSebKmi6LXdosSsYSx3aq4lLIpsfD3UMjnlAz/59HSedYAJxHgF6AwX8z7bJYtBGagjCv2WZRD7rV/+0MYF3WprEOn+/PtG3jkOEGVQQFjySvkLzjxs7Kad9mz02llsHoDaGp6BuGi7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814337; c=relaxed/simple;
	bh=lOn+sMnUt7bIPp7bcc5ObRMjOMjVuljGt0F5zR+sAQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFys8NzQLd9668PCbdUjyrP+OFnagANAQyGmANbU16lheZxvoIveoqdH8d6XTflcMd7zew9fbmxYpO9OuJdJTX0HltCBPqLA0IV8k3Eb+tVS+MsrvuSD2+2mv9gi9J9Y9LrcyH4oAIzMr3hjVr0k9AdbddE7uIABohOJ9lCKXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emLiPHCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F7AC4CEF5;
	Thu, 25 Sep 2025 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758814337;
	bh=lOn+sMnUt7bIPp7bcc5ObRMjOMjVuljGt0F5zR+sAQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emLiPHCnSA5Cs7xjZUozLm9BjPLfe8KcKq6xpZlQjtIQpI4PrhCJCOMWCK8rUYLAC
	 /nK0eNvRQ4LzvMGt1WTaHOR/dJ1i9cwJasfhfUF8T+IJ0pLCOC5tfwCwxdMn7oC4/o
	 AIbUByDpAjl4kegFbETjHoHvitIpX5JHtrK+8OJ47Js2z4OnCKTRQOOrkntoRMJrXD
	 vfpHFc5WFjq0wkjQBLEn4xtPkQnB6w+PT84AZ3n7/ecdWcWwb9QVqqxjMwHATGjjC4
	 02MkHR+n17hA8t8YkZof0+0pn1Xkfbe9Z3g6+clraom3d8Kp4jRafNB3wZ/gNsJKBu
	 /lEgxl+xygLug==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com,
	linuxarm@huawei.com,
	yangyicong@hisilicon.com,
	wangyushan12@huawei.com,
	hejunhao3@h-partners.com,
	yangyccccc@gmail.com
Subject: Re: [PATCH] drivers/perf: hisi: Add tt_core_deprecated for compatibility
Date: Thu, 25 Sep 2025 16:32:03 +0100
Message-Id: <175880472273.3260342.8602469761490497790.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250925033123.5836-1-yangyicong@huawei.com>
References: <20250925033123.5836-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 25 Sep 2025 11:31:23 +0800, Yicong Yang wrote:
> Previously tt_core is defined as config1:0-7 which may not cover all
> the CPUs sharing L3C on platforms with more than 8 CPUs in a L3C. In
> order to support such platforms extend tt_core to 16 bits, since no
> spare space in config1, tt_core was moved to config2:0-15.
> 
> Though linux expects the users to retrieve the control encoding from
> sysfs first for each option, it's possible if user doesn't follow
> this and hardcoded tt_core in config1. So add an option
> tt_core_deprecated for config1:0-7 for backward compatibility.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] drivers/perf: hisi: Add tt_core_deprecated for compatibility
      https://git.kernel.org/arm64/c/a084c3c4a267

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

