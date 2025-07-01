Return-Path: <linux-kernel+bounces-710457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C18AEECA9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 05:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848D61704F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 03:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B401991B2;
	Tue,  1 Jul 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnMYzUIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275E125B9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751338939; cv=none; b=T8440TTJtrmPRL3YKd/L4Ux9ltRkp1tqPkmnPZMAxZz3memuvEUSmehZXcn6B0rO8kxGBsS9rjQ5qRCUwMO0Pg5Xt9jmUTBbMXd4gT3O8tZgWJ+rl1xormuERqBZgDdlAAycw0Nww0kpC650u7x8FgvVqY4jXQF3PVgE6P9wK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751338939; c=relaxed/simple;
	bh=T73PpAtWjzKiK8i7MFRvCRqFPZUJSNtiaV3RngKA+lc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Aw4Iu7SuV7JmHNUUsTznaCpoUhEjHMF679bs/x4zd6KygC4ZudUl+C6/kLnCPXYb/spKhTOiIVpSWmqvojorMJoWTt2mSV0Fb98EsSHR7Qf9PNnbivrqJetKC6Ls6OwaL+xeii9KQUcCZWKBC4L7PBlwOQhKoE0u3p6RKHVCwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnMYzUIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34883C4CEE3;
	Tue,  1 Jul 2025 03:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751338936;
	bh=T73PpAtWjzKiK8i7MFRvCRqFPZUJSNtiaV3RngKA+lc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pnMYzUIsC5fsMLFkQpFiI98eybIxkXXwwklVif26LhcokBMdKQgvgd4FoN1xa8Na0
	 0BeahD9lrMb581q0GTnMfWKGRmyk0INU+0jeKa4+Bx3NxA6TwPvo3k+VHM7XxhDbrK
	 Q0MkDvshe/HPxlz5G2e1uW0wq0zRHbjFatQBEkaEHmF3QXaWKQHjBeN9jd/4WQcnG/
	 EGyX2kwQsIk/UXdWltwmoMjRUX344AU/pguARORE8zMJP+dF179UkL2Iay8IOD4C32
	 eD/XPUxcRtOtixfOH51JC1COr5k1LgQ6Gu0gQ2L0teu+HFW4amnjBVcYFFpc6xoJeb
	 lfJ5GjC0llMzA==
Message-ID: <75e13ced-d82e-4d42-a9c4-5633e18a410c@kernel.org>
Date: Tue, 1 Jul 2025 11:02:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: check the generic conditions first
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250630160839.1142073-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250630160839.1142073-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 00:08, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Let's return errors caught by the generic checks. This fixes generic/494 where
> it expects to see EBUSY by setattr_prepare instead of EINVAL by f2fs for active
> swapfile.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

