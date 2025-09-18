Return-Path: <linux-kernel+bounces-822562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D14B84225
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9CC163F98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448C227EA8;
	Thu, 18 Sep 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz/6zZL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4A23B62C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191767; cv=none; b=a1BTCSrFcmWyII6zmW6NCsY1XTHeSYSIOUuywQvisKBZ8crbecd51Fj9jA8EOeB1KF5oKUX/Z0CrWX8/MNfOTiO/pCJbHquuq53TLzqsTMRxt1iHEFS6/EeD0dEApHbtU2QK69WEEhv08wQQXueBq6/j80iDI8tTNzDsUZgSTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191767; c=relaxed/simple;
	bh=mZX5B1t7YSBW9QkRnh+ZDz1Rd/PMlNLLBRIAPafjyqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FI0TL3jYnYlcszU0KiuPVlO6YnCj1SWoJDNKAeUL+rYCkpeIUsfZI/J6CdcmdF9klhTOmmG5Go5gZfBUC1UXJrQwrY4kDi7iJQYfiAfHnhqy3H7homBT16yXLtDJ2wjRTRnx0jD1hAEkInXGbz1VBrohOykoWvKgKoQmyi5W4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz/6zZL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64085C4CEE7;
	Thu, 18 Sep 2025 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191767;
	bh=mZX5B1t7YSBW9QkRnh+ZDz1Rd/PMlNLLBRIAPafjyqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fz/6zZL0PAGE1z0p2ms1Dh2wy28tKMl7oNKY8JwicGiteN5NCKn0g689nlEuCrbzb
	 NaKK560c/yH7EgZ7p5MM1Tr4LngKm2VDM0u8P36cmot9SSElPNKEf1K3sC5f0C6XUP
	 4SZ+RDR6NpLCbIAMdogqTjWvzm/XM9yY0k8hgLrGrx4gLYXe4X+tUq5TH324GFCPWT
	 /KfIS8vbv/qopXT9nsg+YSvPwJPkgJga3b6YKXSjcrvb6tdjvW5mEn7yG7CWPCWqIC
	 A/1eyl51xk4hfh9iJ0mRVLO3Zdbd9mSPn4gbJnga534wRGJpBuV3ic6sPSeACCNtNM
	 SIL79ex3q3z4w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] lib/test_kho: use kho_preserve_vmalloc instead
 of storing addresses in fdt
In-Reply-To: <20250917174033.3810435-5-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-5-rppt@kernel.org>
Date: Thu, 18 Sep 2025 12:36:04 +0200
Message-ID: <mafs0wm5wf3or.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 17 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> KHO test stores physical addresses of the preserved folios directly in
> fdt.
> Use kho_preserve_vmalloc() instead of it and kho_restore_vmalloc() to
> retrieve the addresses after kexec.
>
> This makes the test more scalable from one side and adds tests coverage
> for kho_preserve_vmalloc() from the other.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

