Return-Path: <linux-kernel+bounces-752832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42195B17B69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB466626933
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF81156C40;
	Fri,  1 Aug 2025 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9qed3Wo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0D2E3702
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019059; cv=none; b=ST+jtOCwwIeWRXyIsN3XMj1ldTtQdgSuXpzGkX6tkBhwRXoJoMw6nUXN3OwFZmQS4rgXLYn6V63QwwO8OPVPcSycLnrep2xmq3oQLJlOf94XY2TdQtz7Wu/n9IxmHpkW7mhPm5fq2s/tK+3xEWjLDnNgI8Ur6+n/vz54Hh5J44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019059; c=relaxed/simple;
	bh=rfHdzfNIx4FFOhlSKWxr5XWDxi7eS6+o/gMrmLuRlD4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VMVGoBmmh/f7CxFXcO47pY0POumetOH7FTmDaDHf+y9PI7WRixirWoD+QaA82Ody0voU1Jg0vhnkaX8xkIoSQtux9YeGc/LXiVeYg6ylHCt+t6PhfexJXYzVzDjfRAn/sN2UxFq/v5u0OB0J+QSXQoGkDnBYommFpQigY55lWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9qed3Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DB8C4CEEB;
	Fri,  1 Aug 2025 03:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754019059;
	bh=rfHdzfNIx4FFOhlSKWxr5XWDxi7eS6+o/gMrmLuRlD4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=I9qed3Wo1+e/qJXZx6vNF26XjXunTywh6DJ2z61hqnDy+tTQ+4PGlGDsEYbc+Vsce
	 Jr5MjOkWDFAiF3mCKn+vZmX+igAqJeGSyWFXk9aJ56d/W/d8qG/LGmrUrw3LKuwKvL
	 d1GmUtiIXYTa4nikkAt7dfTb3U/jMRP4HMnzRsCqIdjYlEsO9WQBk6s3D8/Si+8rLj
	 G/aDyJ3mDAX0qTNryCeL5PS0FYddua5eXO123MmEOynfsVU2Wst+6wgDn6Dcmv/g7e
	 XvMqfJQh882Cffn2SlrKW64op1LYVe1vrhqvBLxqZ+h3TqzenmaUgEwEqFBvBlDCkN
	 ecSqRS17MoL3A==
Message-ID: <38f94640-64be-4ec3-b077-1fbef31af184@kernel.org>
Date: Fri, 1 Aug 2025 11:30:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: add error checking in do_write_page()
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250731151917.24800-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250731151917.24800-1-masonzhang.linuxer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/25 23:19, mason.zhang wrote:
> Otherwise, the filesystem may unaware of potential file corruption.
> 
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

