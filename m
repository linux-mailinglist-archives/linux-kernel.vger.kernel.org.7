Return-Path: <linux-kernel+bounces-600691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EF2A86361
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A751BA72A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44621ABD7;
	Fri, 11 Apr 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4zFdC7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A791D86F7;
	Fri, 11 Apr 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389331; cv=none; b=ixMHmtrOvF6gyoA2BalzhcFGXR7lTz0xgMJlfBPvRP3gYDezId5npMWNN2/njCWSBDt9bxWB0wk+Rxc5lVqsz9m2Aimff+rjHJCGtAzKFbTvzUbkQTs6SV3FJEU6mfWDzj5QVyrqnfxuR+hzXOfdi8sjrvV3uw4vWpCFUHiwNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389331; c=relaxed/simple;
	bh=kY+WBu+6JBoOObPVQnEfpnDEm5uBxPq3axWA9+iB2HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC1kXqgvYieLx4dC5DLns2Km5aCKyPx6Aq9OF3kMd8sKcNEjIka1OMR2jp9H/2+zLzIYhfe2zG1SB6yoN247RpOccae6V+uPrWBXVBRTZ/Rk7YnoJSDjvW0cTINNzV2PNgMNHerIQ2S1vuorMFSWH0xS6XsphpFGBIQZpSo0uM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4zFdC7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926DAC4CEE2;
	Fri, 11 Apr 2025 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744389330;
	bh=kY+WBu+6JBoOObPVQnEfpnDEm5uBxPq3axWA9+iB2HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4zFdC7BjC3ZqWyPX/a9DCkhsn57/2BDY3PDvmVoUa3IUEEyng4+jk6oV2YkaGWvc
	 ZglAlde2YRvLyCQ9lEbaNTwAGrvecZiRNWHEeVG4pDjVIoc5ixH4/yTMSAnrBfztBn
	 mqlcz0eOv0TLoQ387i3qTIepSoXHlYKgvwHikZBSgecXB1u/t0LtQ3YA2HYR3Wi7r1
	 1l9kQGcN53Yk0n2xCNvjIfC0gDcHfu4kY00dh+BsJT2j7/kYOWPngvHs6bl2SnuCN4
	 BpkSghBno9WBRUIljRTM9fWWJede5MG1Wot+4Z7RDeQT4G6O6A7d63G3MvsSgPH3YN
	 /F89DJRPw5oEA==
From: SeongJae Park <sj@kernel.org>
To: zuoze <zuoze1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Fri, 11 Apr 2025 09:35:28 -0700
Message-Id: <20250411163528.65021-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <b937014a-66ef-4648-a61d-87c61dcdb836@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 14:30:40 +0800 zuoze <zuoze1@huawei.com> wrote:

> 在 2025/4/11 6:25, SeongJae Park 写道:
[...]
> > So I still don't anticipate big problems with my proposed approach.  But only
> > prototyping and testing would let us know more truth.  If you don't mind, I
> > will quickly write and share a prototype of my idea so that you could test.
> > 
> 
> Sounds good! Please share the prototype when ready - happy to test and
> help improve it.

Thanks, I will share the prototype as soon as be ready. I expect up to a few
weeks.


Thanks,
SJ

[...]

