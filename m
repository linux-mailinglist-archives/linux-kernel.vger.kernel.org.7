Return-Path: <linux-kernel+bounces-763619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073EB21798
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C183AA596
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F692E3AE6;
	Mon, 11 Aug 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d08hTycy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138E28505F;
	Mon, 11 Aug 2025 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948494; cv=none; b=UT7kKfhw4CwzPB99rU/8Wh5+XdQkFnqjI1LrCMpNOYIsBr1Xb5oJoNNRHHgV9via8RFtZ+QBDntDLLsj17dqQzoGbZ9R9vaRySQpul3PrYiyaXB7jdnfNXbVa5HtdwtE+ibDeGv4cScS2COlSCJFm/Ds/8hzu/DM14HhejMu9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948494; c=relaxed/simple;
	bh=Ungo+NnRAZf/EAq354p5AhwXeye7iWIYrrlXQ1vPjzU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Qa1K+ELEVChrhBghXPrGkktddaQC5Zza74yxCckjzUiRbMf0dSeVI3nLw38AcbU9f2csaod+6Bbh8VAL4ohmUVcAjaAjBYhRh4jCmExFKSf5eMxSEWbU0nCwB+KUjUEM9WAUuDroMXSUvrP+WmG6P+XZ6S1nJ2GHiICBeK9j5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d08hTycy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36F8C4CEED;
	Mon, 11 Aug 2025 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754948493;
	bh=Ungo+NnRAZf/EAq354p5AhwXeye7iWIYrrlXQ1vPjzU=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=d08hTycypJL97e8NpVGgXTMvNC3VrkLHgeoS+9KIC2ZhALavryKMN0jTshf8Sa3s1
	 OAI3QtX/wjPypytDut/oM7kQ93/AzsVbYIy4RvcFb/D9OR5S4Y+V3ciRWy9SxfI6rt
	 lD9ortz8nXXzz5z7gL4J2G2j7f5svAIjfXl5jA6iu2RW+88MzL1PzAvtqtab21NMYC
	 cL8P5nXYenvIPFiN7/idmJz6uyuak3jTljddr1XjpvouzKwIEbbZUyFwaAp1644taT
	 xSeerAcW3yzcXeJPeKQU65DdTf/dU0sv/4UTjzxjavdTp0VWabh4UzzL3UuhQB1/4P
	 e/L1KD0HLZEjg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 23:41:27 +0200
Message-Id: <DBZXBHHHV0LO.3DDZ48G45ZWET@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/4] Alloc and drm::Device fixes
Cc: <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
 <Liam.Howlett@oracle.com>, <urezki@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
References: <20250731154919.4132-1-dakr@kernel.org>
In-Reply-To: <20250731154919.4132-1-dakr@kernel.org>

On Thu Jul 31, 2025 at 5:48 PM CEST, Danilo Krummrich wrote:
> This patch series replaces aligned_size() with Kmalloc::aligned_layout(),=
 which
> is subsequently used to obtain a kmalloc() compatible Layout for
> __drm_dev_alloc() in drm::Device::new().
>
> It also contains two additional drm::Device fixes; the commits are based =
on
> next-20250731.

Applied to drm-misc-fixes, thanks!

