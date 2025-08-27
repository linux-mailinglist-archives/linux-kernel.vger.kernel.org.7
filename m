Return-Path: <linux-kernel+bounces-787614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B47B3789B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC02365D66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21932192E3;
	Wed, 27 Aug 2025 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I/bLRoD/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA021991CB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265754; cv=none; b=lQ0cFLCqk+Wg/eUL7E7pYuHD9E8o+MAyYh2oi1eKuXFyhK+xJf84k2DW+unM5qJRtfWjJ5ToaTNmu04kJfhGAu/BeTOv4fTAsOWVFN88DCRUiJ3EaAH++piUoa4+hz5SPzHa0ufpJ+Qr43wdSdb19dqSLC+j6asD3SUEbdIXLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265754; c=relaxed/simple;
	bh=SM4xb832pE5rvEBqKKRa+/0EhP96sXD1OR2lz67r2k0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PmXrHdCxCsP52u3b11jrx5xO4e6JDStPhqZyHprA321zCXhOHW5f8oC2CSN1bHv9K6dEREI5EbsjQAymmd1WxjtAU1M4tqqakbTSdXAP014jHe/HO0dmS6UXqEFJw6lJA14MEIztUUg8E6ArCsGpocjx6z2c5liW8M24G1Wtt7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I/bLRoD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706B8C4CEEB;
	Wed, 27 Aug 2025 03:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756265753;
	bh=SM4xb832pE5rvEBqKKRa+/0EhP96sXD1OR2lz67r2k0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/bLRoD/8nIla49/f1C7uUseCKIzQcE0Pyq0JXmCakfN4IycnEKNIWTFvMotNyyy2
	 aUiy4sltWllRxRJA26414bEgzCKpzRWepEmynuRP52ORskRAI55JzXbxcOogXnIKit
	 4DxN9YwsfKrbzHKVK92wmbaUC8OaQhLhB2HB0UiE=
Date: Tue, 26 Aug 2025 20:35:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert
 "hugetlb: make hugetlb depends on SYSFS or SYSCTL"
Message-Id: <20250826203552.b4340b12b16a374396f49343@linux-foundation.org>
In-Reply-To: <20250826030955.2898709-1-linmiaohe@huawei.com>
References: <20250826030955.2898709-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 11:09:55 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Commit f8142cf94d47 ("hugetlb: make hugetlb depends on SYSFS or SYSCTL")
> added dependency on SYSFS or SYSCTL but hugetlb can be used without SYSFS
> or SYSCTL. So this dependency is wrong and should be removed.
> 
> This reverts commit f8142cf94d4737ea0c3baffb3b9bad8addcb9b6b.

f8142cf94d47 said:

    If CONFIG_SYSFS and CONFIG_SYSCTL are both undefined, hugetlb
    doesn't work now as there's no way to set max huge pages.  Make
    sure at least one of the above configs is defined to make hugetlb
    works as expected.

So there is now a way to set max huge pages?  A reference tot he
commit which made f8142cf94d47 unneeded might be helpful?

