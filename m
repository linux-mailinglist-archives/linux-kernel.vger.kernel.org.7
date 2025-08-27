Return-Path: <linux-kernel+bounces-788667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7313B3886C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1EB1898273
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1862C0F96;
	Wed, 27 Aug 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckewAgd3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69028D831
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315098; cv=none; b=DHOFNaZte4iLOfW37YVdNp+3a0umtENV8/3g5bY60zisoBBISe6bvn0o5ASdK6nnYNZ2x/qoRNJe2hnOu8emLmaGLg4ebU84arUGRzAcmOOa1sqITbiaXydwz4udHcDmnzdc569qgdKUZQOo3o0s11vHKHpcvKQ25wx7po6cAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315098; c=relaxed/simple;
	bh=Ui4V3hxIx9PmVgXH7P/YiJsiwGKYbyHah/yk5X6Nt20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fr2aCbU5XWXIkmRIYzts1AAeHYjv0/8Vkp+Y+Cuz+2xpvxDo4lqQwb0ntOzDnEwlZIZpsJlGMppBj7CjOihfoANYx1feO3OoLX8gbk9UMFlRAP6Br/7fXq5CEhuArOShvtVaWmhhCrbImm2fZjeR1REx1Hi1p61oNN6OImuxa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckewAgd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC655C4CEEB;
	Wed, 27 Aug 2025 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315095;
	bh=Ui4V3hxIx9PmVgXH7P/YiJsiwGKYbyHah/yk5X6Nt20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckewAgd3dZpk7AKQbNZ9/qILFvCij1WeTGfXLZsmki7raWOD3pD71bc0TNpim0Jcv
	 ubtNOFHtwKdJuTaDu7EhtpngONx1gS4qB9O6vRBTiArDfz/eqD3TAGUV3WSyRuUa9j
	 v0N7EfigGNCblvk0VdWdl/UWttwq2+hED4yb78VEsGJbXKtbklrIrzHGGSWlX/9i2m
	 Ozox756sHncD/gJysmlU98NC3z1IuAZVGn1MkWU/wdrWIhNHhd/uMLMiQagJ6yEhOv
	 9/iXBa5t55Lyp2FM7UvsR/orF9CwOjbMy9A3TPHb6vk7BzwjjDzo67C54pz8IFf0Ne
	 WO5T6UbV8K71Q==
From: SeongJae Park <sj@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 1/7] mm/page_alloc: Add kernel-docs for free_pages()
Date: Wed, 27 Aug 2025 10:18:13 -0700
Message-Id: <20250827171813.104592-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250826205617.1032945-2-vishal.moola@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 13:56:11 -0700 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> Add kernel-docs to free_pages(). This will help callers understand when
> to use it instead of __free_pages().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

