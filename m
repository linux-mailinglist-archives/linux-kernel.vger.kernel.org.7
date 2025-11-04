Return-Path: <linux-kernel+bounces-884077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1EC2F4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0984E1898234
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008B285CB3;
	Tue,  4 Nov 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO018gDQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8617C211
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762231440; cv=none; b=me4F2jewMvb9/HilVBzI2jxlTE108aWJ+ywlQtkpYvitlmBu4doyhtJpPECF98ffAIjKctHTGJrMVzxvfygmFgxSAePDAG1ONrwhphDjY4ndWa1GV2iLuja7jlvCKZf6EnSeeHKHM5UNpZecnmQ8NgKyx9dG63n7cT8tnHVhM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762231440; c=relaxed/simple;
	bh=Z7KhNXOenut48lwUMNJxE28x5klL4Yn07BEFFcrZ6AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLvx1lqC01Js89kEavwHB128jdkFpOlAwdOaWYdQEBdFAG/ecCxRoECBR2WMPKv9i8lb8Wb+sujlmtImvNv9v/hynpXbPgz++vz0rubpIoHZL/Ltjax8JehRgYa+JxlAXKmbM4dKOMkNUJpN5mhAbmp4OVmOpDNywaKrLCHKnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO018gDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBA8C4CEF7;
	Tue,  4 Nov 2025 04:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762231439;
	bh=Z7KhNXOenut48lwUMNJxE28x5klL4Yn07BEFFcrZ6AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FO018gDQgELbLAGDo3eqXtRjD92b3sr3PGSg9THQONsaFkmA6Tlue5rZ9mf3aVHBT
	 w1O368gkXxt0RGr7MA/9k8PVxLl42w0K+DD+N+J5VoBTEdZ8bKKUu8QZ8FurUkGtJG
	 FQijL5pRksGIkEazCCzagCL58q4t2Uir0NZ2QC2bRJUV4o44ioLppqGP3xosrhX+sh
	 JEB2N+hO4w070VnyT4C6izrBDapDMgctzE383IaWLTDMye6cbJlc+Hn5gRh4ZHdAWf
	 mQm28XaZIoo+5ZJkRPqOjTRCz/GbuxI5IWAS6e5mxzYAaGAB/2iNxq8EN1EdPQFqd/
	 B4tnO9qrUdpBw==
From: SeongJae Park <sj@kernel.org>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
Date: Mon,  3 Nov 2025 20:43:54 -0800
Message-ID: <20251104044355.94885-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1762156954.git.zhuhui@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  3 Nov 2025 16:22:07 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:

> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> The hugetlb.c file has grown significantly and become difficult to
> maintain. This patch series extracts the sysfs and sysctl interface
> code into separate dedicated files to improve code organization.
> 
> The refactoring includes:
> - Patch 1: Extract sysfs interface into mm/hugetlb_sysfs.c
> - Patch 2: Extract sysctl interface into mm/hugetlb_sysctl.c
> 
> No functional changes are introduced in this series. The code is moved
> as-is, with only minor formatting adjustments for code style
> consistency. This should make future maintenance and enhancements to
> the hugetlb subsystem easier.
> 
> Testing: The patch series has been compile-tested and maintains the
> same functionality as the original code.
> 
> Geliang Tang (1):
>   mm/hugetlb: extract sysfs into hugetlb_sysfs.c
> 
> Hui Zhu (1):
>   mm/hugetlb: extract sysctl into hugetlb_sysctl.c
> 
>  mm/Makefile           |   2 +-
>  mm/hugetlb.c          | 852 +-----------------------------------------
>  mm/hugetlb_internal.h | 116 ++++++
>  mm/hugetlb_sysctl.c   | 136 +++++++
>  mm/hugetlb_sysfs.c    | 632 +++++++++++++++++++++++++++++++
>  5 files changed, 894 insertions(+), 844 deletions(-)
>  create mode 100644 mm/hugetlb_internal.h
>  create mode 100644 mm/hugetlb_sysctl.c
>  create mode 100644 mm/hugetlb_sysfs.c

I think MAINTAINERS file should also be updated for the newly added files.


Thanks,
SJ

[...]

