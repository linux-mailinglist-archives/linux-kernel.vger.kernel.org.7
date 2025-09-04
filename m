Return-Path: <linux-kernel+bounces-801153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F033FB4408E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA0B7BB739
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBBA2550CD;
	Thu,  4 Sep 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cybdKSYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039D18DF80;
	Thu,  4 Sep 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999589; cv=none; b=Xf3K9uAjfeIOIKX26iw6e2mv16lNcWoTsY/arjWnvoeFMhFbxyF6yYXGc2kDwApPpIR8OTw8bcwKUT9gunrZiCJ+qYNfgx0bzIBF29HRdSN5f0z48NGXESljUH/1FhcxhdtD7xu4QGVZ2DoHkX9Yr3nA2IvKqsEYZ91GnHASIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999589; c=relaxed/simple;
	bh=PSc5DK1B9G+iAjYe0HflYSjg6jgkmR4XOYpbOFtdYUo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XqlJ8ss5OtsZ9gvFGxs4GHBKdCJToL6x0Yg5AXbC3lCLHh+10Oj3MhcPqGI0ssgPgjBiJ3Q2D0PN+1OUvdfw76e9zJg5dgS32gQYOJQVu7v6Ld5nAozYo2/a/hwLVuhPXqWLp7KHgcr2Erc24NYvqV5pgoI9JJYNsjve9C5iKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cybdKSYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7D9C4CEF0;
	Thu,  4 Sep 2025 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756999588;
	bh=PSc5DK1B9G+iAjYe0HflYSjg6jgkmR4XOYpbOFtdYUo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cybdKSYtVxA8b3G46WsjOfw8b98/Wj3ymFs9XAK9lCsTwRklq2550wFfYW0lpAcot
	 5M8KmCpkTHhUeacCNX/XocfMua5Sl8nFgeOukC2phqbnSxOjWvmjgMRU2Mtb0pO/lc
	 /kApV2wDSBmEmZ8ot670x238hdw8kIhJfbuPbq1z91KzlTWGm8k6TdJ0sWRtglZfx6
	 f6EbSem9y4O4db9B+D23j/1cOgyYrWy4/eHg+iI42IZxufsVzRTiYwbTUxkdimw7Hh
	 QYfzOQ8DTmk9k+eZVe6iG2TKKCqrjr9ItKjgU9QIBfkBL6xUNBBai3b1gsjfvii1pI
	 yxlJkck0LGHJg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Sep 2025 17:26:24 +0200
Message-Id: <DCK4DE2L5AM3.37W6EMRHC4RES@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
Cc: <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <acourbot@nvidia.com>,
 <daniel.almeida@collabora.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jani Nikula" <jani.nikula@linux.intel.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250901202850.208116-1-dakr@kernel.org>
 <aLlsmNzp_KardLUt@google.com>
 <08632fbd-1984-44ff-a6e1-bd9e39bbea97@kernel.org>
In-Reply-To: <08632fbd-1984-44ff-a6e1-bd9e39bbea97@kernel.org>

On Thu Sep 4, 2025 at 1:09 PM CEST, Danilo Krummrich wrote:
> I think we should get the same redirect, so the links in MAINTAINERS are
> consistent with each other.

https://gitlab.freedesktop.org/drm/maintainer-tools/-/merge_requests/89

