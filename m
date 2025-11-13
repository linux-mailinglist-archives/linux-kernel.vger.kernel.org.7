Return-Path: <linux-kernel+bounces-900096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C77EC59991
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A638A4EB6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F4B3161B8;
	Thu, 13 Nov 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub15V7pU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15D2C3245
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060372; cv=none; b=WaCSv/SIuQS0DRoW2IXJN6HiKmNFVrosL0ji+E7vgqDoknSkVdCzOkGL2zKs+mGjSXaseaIMAXcfJqodEDgjOFLNdA41cF6/z32NaUzFo87RPmETRoiYEFhQTugJufBoVQpuDJoKkdR9PHx4kZkk6L/wfaFYeMLWgkZ16cnxvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060372; c=relaxed/simple;
	bh=F2bQ+XQbUaZUjs1Xt96NSZK8kaysy6fQf97pHBE+eg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWGNIeT7O7AbKgBTckJ7KI36kZwdnMX/qW4h3VdMWo6ckwg5BFF3vtXM8GdKfzx3sQ9zOOP5yyKFkJfJ/HmhesODQiMJZU7X8sCYcB1jcjaLvA5MR+RKtNToXOpLZho+2A+UYSBBhRrNQUxZXsUmxT/mbhIEGWhT3EwIK2DmvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ub15V7pU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B540C19422;
	Thu, 13 Nov 2025 18:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763060372;
	bh=F2bQ+XQbUaZUjs1Xt96NSZK8kaysy6fQf97pHBE+eg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ub15V7pUcvO+3uAssuTCicljpioc/2ci0kxHfB9FgcYYG8Vr/O6nTlKxyn4uBMj5h
	 pqwHRcg5K1ErpGqAfarnqGEpibqHA0VShpwAzzJoPO3MozNBY3MAaeA3CzqzX5zSFG
	 XsrC87Cgn6++MUBpOVKNDEI6TfzlTOqscs8S06s8faeFtVrDbCgRLjXoPm1pVekpG9
	 YcQBbUpIMIkKeqEzn0ndVi1eAR3yzFmd4pEOLZBooFXmEiAzILGII3uvqb5uWlywD3
	 byeR88k1p4iH9Fi806zQyfSdkGt7QfNc7x/QKkD9imOOk6+S1C1+aBmeU3OozArAUg
	 ZWod8/0AHdD3g==
From: Catalin Marinas <cmarinas@kernel.org>
To: ryan.roberts@arm.com,
	dev.jain@arm.com,
	cl@gentwo.org,
	will@kernel.org,
	Yang Shi <yang@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: mm: make linear mapping permission update more robust for patial range
Date: Thu, 13 Nov 2025 18:59:18 +0000
Message-ID: <176306032241.2459767.8275191874359460210.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023204428.477531-1-yang@os.amperecomputing.com>
References: <20251023204428.477531-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

On Thu, 23 Oct 2025 13:44:28 -0700, Yang Shi wrote:
> The commit fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing
> permissions for vmalloc_huge mappings") made permission update for
> partial range more robust. But the linear mapping permission update
> still assumes update the whole range by iterating from the first page
> all the way to the last page of the area.
> 
> Make it more robust by updating the linear mapping permission from the
> page mapped by start address, and update the number of numpages.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: mm: make linear mapping permission update more robust for patial range
      https://git.kernel.org/arm64/c/37cb0aab9068

-- 
Catalin


