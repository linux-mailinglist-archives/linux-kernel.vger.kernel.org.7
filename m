Return-Path: <linux-kernel+bounces-863982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 187F2BF9A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E57D19C7904
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9621019C;
	Wed, 22 Oct 2025 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsa0ngDZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904F201113
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097849; cv=none; b=DLGHo6QB2dUsO6PXMiZ/410J7hPBJivIdbSsYBMnm8fIYtVQIC3qQ2X2xCK7TQKKCQ5Uc55FitNic1ZmILunBBiHAM30PUsaBkB0Qs2UR0D4ut1pa68LwXfcTqxVurnzVQEdT1QBKrror41VQzQFeDGgruEan2Tt41mc6lguWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097849; c=relaxed/simple;
	bh=dKGKS0+JDysg3kqdM4BzmAJuhCTKIrjASlQXxIPuPgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z47VRsDYHSs3nqSq9XEeF9+jVV+6uveXdwh3n8OxQtIOvnvVlhC1RxxE66i6WGraxhZdRPz3notjrsqlqYS/VcODsgJVEGnMH4DvOrTMlj8hd8c2UKx7Cd92m5rzUOFDNn0DewVLezYnv2vU1PtE1z8vy9Y61yR0Nfrp6r5gehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsa0ngDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C96EC4CEF1;
	Wed, 22 Oct 2025 01:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097848;
	bh=dKGKS0+JDysg3kqdM4BzmAJuhCTKIrjASlQXxIPuPgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hsa0ngDZKR4G0GcHfwCihv/cvOshIPc1efe1v6DFLnoteAo2esfEIK/YkSkbkpFF8
	 GCNwoqfUmiGrvdoin4oVw6tWjokEcEKzxJ3zm/6DiWdUMb28CK3OL8eJ3eaHsASFAh
	 5yriqTHiDhtLewSV4pHBf1LTH5IvNEO+LpHbMcaTvXg/AJJlBZfWnLRVJbUxWDkB3b
	 w9ChPzxpqEHRBOPVyqTd1FLe2c0m4NcUxIK9Xd2RxLeYaqKsGeMIZJp1xkHnxbbzAm
	 cX9n1Fd2o2/FpQt9F/9ofa7GYHx3EO7HVeb8UOZ9pRbuz+NgnIVnSJY3KBQzY1jymt
	 dGM+seC2uY1cA==
From: SeongJae Park <sj@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-new v2] mm/khugepaged: Factor out common logic in [scan,alloc]_sleep_millisecs_store()
Date: Tue, 21 Oct 2025 18:50:45 -0700
Message-ID: <20251022015045.129146-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021134431.26488-1-leon.hwang@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 21:44:31 +0800 Leon Hwang <leon.hwang@linux.dev> wrote:

> Both scan_sleep_millisecs_store() and alloc_sleep_millisecs_store()
> perform the same operations: parse the input value, update their
> respective sleep interval, reset khugepaged_sleep_expire, and wake up
> the khugepaged thread.
> 
> Factor out this duplicated logic into a helper function
> __sleep_millisecs_store(), and simplify both store functions.
> 
> No functional change intended.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

