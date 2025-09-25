Return-Path: <linux-kernel+bounces-832553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557CBB9FA85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EACD189082B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1C283151;
	Thu, 25 Sep 2025 13:48:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932C281368
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808118; cv=none; b=Jb2Zyg9ZMCGHLJZP8j0oXtECqk/cBaXRWxeGqGD3wOlyR2n9T58xAMZ3F2NlVOGm69oIywvWcOhSh3sTz98gLv3/v5cUub1UisO9CQz5t+U5u9L613d7hgN0jcZV/sSvIrYTggg80q+dg3ydyJVDbzX/ieznKQFCtOzYXl57zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808118; c=relaxed/simple;
	bh=JH1+z7mYLzPlYMJOcYTg8WyIAB6Q34CyR+4RDtd7KWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6Kkc93wjKlzNDnU7dKxrFyeo9A7xAK2O6zmWkziDH7bpJ+D/dMCFGrfBF6ueu4sc4MZDuTINCtY2Rl/gbu2eFICHRkTtjfqIhmLfvI9UtPzp0XZjzPj4ag3xNMgtVcxJW658pzn6CYkJgnIJaaNRGR92u0xW5kqW0Y56074W5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE95EC4CEF0;
	Thu, 25 Sep 2025 13:48:36 +0000 (UTC)
Date: Thu, 25 Sep 2025 14:48:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: shechenglong <shechenglong@xfusion.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com,
	chenjialong@xfusion.com, yuxiating@xfusion.com,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] cpu: fix hard lockup triggered by printk calls within
 scheduling context
Message-ID: <aNVIMhQKlBp43iHs@arm.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <20250924123247.807-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924123247.807-1-shechenglong@xfusion.com>

On Wed, Sep 24, 2025 at 08:32:47PM +0800, shechenglong wrote:
> relocate the printk() calls from spectre_v4_mitigations_off() and
> spectre_v2_mitigations_off() into setup_system_capabilities() function,
> preventing hard lockups that occur when printk() is invoked from scheduler context.
> 
> Link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250918064907.1832-1-shechenglong@xfusion.com/
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: shechenglong <shechenglong@xfusion.com>

It looks fine to me. Thanks.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Will, do you want to take this for 6.18? It might be worth a cc stable.
In general it's unlikely to happen unless you keep writing to
/sys/kernel/debug/clear_warn_once.

-- 
Catalin

