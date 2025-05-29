Return-Path: <linux-kernel+bounces-666243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E8AC7424
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 00:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C231C021C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07924221561;
	Wed, 28 May 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmQ3+q7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C18634A;
	Wed, 28 May 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471960; cv=none; b=IW634s2q59v0T39eWU+kJSKqGmujgGU5PevDv+qLG1qGYB9IjrftRLprGjsdAY/AV9pGyDSsDRacAMPQlORmZRv8w7VfuBJ7XHO9hi5qLCwvFW/6+YM6NXTtQX2oaT9UYXP8QQj5hoKmQrM/geJ1FY4nPUi5rnN0B82rxxZu6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471960; c=relaxed/simple;
	bh=H6sNMIHXeTr/9xzRzueBp5o1yGTA9o+s7DYHLjD3t1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAnXPEFphNXejAllYAPSiZB3BiT60AVloXqps62ey+O5+CPShKTZ3pp5iU3mrMxVclJHfFObR7Zd8yn2kluSitpOa2u4Ua/K5rnaOSCmL+oCsIfEKuT0PL+DA4MP76wzhgfJln6cKR2LdJyu7RZo431Tjc45u+v0KHuxVxvx5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmQ3+q7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9661DC4CEE3;
	Wed, 28 May 2025 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471957;
	bh=H6sNMIHXeTr/9xzRzueBp5o1yGTA9o+s7DYHLjD3t1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmQ3+q7CpSp7N2CadSmUinswYYLasIFN0UUEyKWKcltxv1tqZ3aXksmAJU1YOjQup
	 wBJoGc4xNws/q4MosvdovkeTO7WwyImMLymtpuwMFfhwSK0DrPQWsfBUhQ0d/200MM
	 oliBdvRjad8eAN34ov3xikN/vxiTMNy2FLXKoO/h7cBdcVKRUgqnI+XMH2A3CdZVt0
	 Oj1SQcaFI7wyD02s2ZM8x49EeoCl3MgQ8QrL2zf+7hUFawjBv6ZQ4vrGpALFZpxTSk
	 Ju4Au41D5f/jaNwnA8+7fDSnP1qPtq0QuXoqM28bt1zpqilY4bam2MwRLqDyIh50Et
	 usOOBYY+uzKDw==
From: SeongJae Park <sj@kernel.org>
To: wangchuanguo <wangchuanguo@inspur.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 0/2] add a knob to control whether to use other nodes at the same tier of the target node in DAMON
Date: Wed, 28 May 2025 15:39:15 -0700
Message-Id: <20250528223915.55694-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528111038.18378-1-wangchuanguo@inspur.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi wangchuanguo,


Thank you for sending this patch series!

On Wed, 28 May 2025 19:10:36 +0800 wangchuanguo <wangchuanguo@inspur.com> wrote:

> In DAMON's migrate_hot and migrate_cold features, the code was
> intended to migrate pages ​​only to the node specified by target_nid​​.
> However, during testing, it was observed that memory allocation
> and migration could occur on ​​any nodes​​, which is a BUG.
> The first patch in this PR fix this issue.
> 
> A use_nodes_of_tier file has been added under the directory /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/
> to control whether to ​​use other nodes in the same tier as
> the target node​​ for migration.

I left a few comments on the patches.  Looking forward to discussions on each
sub-thread :)

> 
> wangchuanguo (2):

I believe your name is Wang Chuanguo?  Sorry if I read/wrote it wrongly.  But
we disallow[1] anonymous contributions, and prefer more formal Signed-off-by:
if possible.  Could you please use such formal Signed-off-by: identity, say,
"Wang Chuanguo <wangchuanguo@inspur.com>" from next time?

[1] https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1


Thanks,
SJ

[...]

