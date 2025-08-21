Return-Path: <linux-kernel+bounces-780362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA6DB300D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FE3189872A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6212FB63E;
	Thu, 21 Aug 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUT8jbA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351392D0638;
	Thu, 21 Aug 2025 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796711; cv=none; b=c8jwDnWUWM+wMUtJQkkNg7AsF8TyB1xjZla9+6i+ce1O2tlsRm6iz67W7PsGRA3dArnL5Lkfs23kh3kYysspyayfh0HNcN/HC5gagdh6RoDI+1B9rxpTieceFIwN4y7eWL5hY8TGutwewqx4AmrlCrgj7rr75rI8260PKBHP3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796711; c=relaxed/simple;
	bh=GmBT5KRpg58kaKAnaoXx0aJiwi9SIUnxrOyht6yCL7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6rc7piwpSHHh+Sf+A1JdcYzedhez9HogVO++erCf+PCXqsZ7SVOi+sY+mMONXY3lHuLDLIwdUHWwGBbzAPUWJ2L5wc++bvWKpULKDXs7Oblt702kmQXanpTzM9SwN3+9W1l+oX1N2YwkbQ9gp5BYa+qGhCOaW5lo7QBE3jCsXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUT8jbA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48C9C4CEEB;
	Thu, 21 Aug 2025 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796710;
	bh=GmBT5KRpg58kaKAnaoXx0aJiwi9SIUnxrOyht6yCL7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUT8jbA+133Fd8JH5x0vCeXig1RV+9vpZgVO8PkkgxrE9zj++RHvnTvro1KqLsKtD
	 WCn4Fi5ZiHhnRTMbevTS2MFB6QrAIdF3hOE0vs/n5OmTnOmmIaNsYsj5daUy0DS+KZ
	 BqWm7BCcHo4NfF6olWackzf5BkY/tXke4qfTCTl/5cQsV7J0Un0Ny2W5opt9h2XBms
	 dAXWdT+gSA++3A9kozufV3io5VNKbuItoCqhyzF/XhiHndp6aNXEgzQTEweYjIcfZN
	 Q9pB1E1YIHl+0yd47Vph5kPrAysWQ+R/8iPI5Xz617FNXGM6IfOButiohATQvnEidn
	 5xCjkFto1k46Q==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 05/11] mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
Date: Thu, 21 Aug 2025 10:18:28 -0700
Message-Id: <20250821171828.81974-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-6-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:53 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD
> action handling from the DAMOS operation implementation for the physical
> address space.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

