Return-Path: <linux-kernel+bounces-780350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED67B300C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799FE5E851C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9112FB632;
	Thu, 21 Aug 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exGElCHi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766F62FB62B;
	Thu, 21 Aug 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796216; cv=none; b=o5dNKIX2Bg1HpHSMXhgG22rLXtWcnOUQhdU6Fuf+pka+4TT6c5EQO387i6xN5WYVVX8VCsPkWHzxo27q9pF+iym4RblE9+ROpJXOI828W49M18GsITSmf7H1b9oqQjjt6ZqVJymJK8WvcPhGq11KqIOFCmyfQFrfpGsEuRIhUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796216; c=relaxed/simple;
	bh=iI8uK540bgopoq0pOE9qeewmZlSP/Z8gE7wwo6c/en8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSAAeawG7+y00YbFT1KXC1w4sQkncR9Mbegk2OIsOcVU0x+8assk2uQAUS/7O1bSNIg/QXWzZSaxywuZ7RAqCmxc1a0Uc2hxAhT4SkiwI1Zp1c6z2dZpskR6nD9oF6890L2V0dnU5pslXdR+7yUyVOxrJVbtqAdeYeRWKOFAf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exGElCHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C9BC4CEEB;
	Thu, 21 Aug 2025 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796215;
	bh=iI8uK540bgopoq0pOE9qeewmZlSP/Z8gE7wwo6c/en8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exGElCHiv1aDaMOYVKOe5UvmhtQYYptdFQG8s76oU2GVNQnRQGLLnBevGW41uja9Q
	 TEbxmCx6gKNBjjLv3OEa5RD+pnJHfYG5xv+go8Mbe1OKOWq7fVAJt9hUQmkIM4+IBh
	 krEaKKkeUKCAfPmxQgykRtTu9lE7plOLxQuL8hKviEXvAPp/mwMW9bEKmsZeLMexDu
	 z7TYbipA/1tzu4p0OAyPE91WsTaMJy5z9xL19fEiw7ccBFFHFhrRj9LgaHSFHj51VP
	 RaS5pd/0K96+KYagyRoRXEbqlDWZRGm86uJAd2wfQFQGpyo2KrYpEbiGYlhjPTAX1e
	 ksKIjwy1kjDbg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 01/11] mm/damon/core: add damon_ctx->addr_unit
Date: Thu, 21 Aug 2025 10:10:13 -0700
Message-Id: <20250821171013.79499-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-2-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:49 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> In some cases, some of the real address that handled by the underlying
> operations set cannot be handled by DAMON since it uses only 'unsinged
> long' as the address type.  Using DAMON for physical address space
> monitoring of 32 bit ARM devices with large physical address extension
> (LPAE) is one example[1].
> 
> Add a parameter name 'addr_unit' to core layer to help such cases.
> DAMON core API callers can set it as the scale factor that will be used
> by the operations set for translating the core layer's addresses to the
> real address by multiplying the parameter value to the core layer
> address.  Support of the parameter is up to each operations set layer.
> The support from the physical address space operations set (paddr) will
> be added with following commits.
> 
> [1] https://lore.kernel.org/20250408075553.959388-1-zuoze1@huawei.com
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

