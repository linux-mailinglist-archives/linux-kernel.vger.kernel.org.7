Return-Path: <linux-kernel+bounces-854958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B808BBDFD72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390AE486D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1328D338F39;
	Wed, 15 Oct 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA5+vBqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658742F99AD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549174; cv=none; b=G4x7RM0gK+o1pMpcN0DLCRX4wuq/m7R8o2nrvkLY2DhyoENV2zI+wwYyYpfBCf+eIb2RQhuGi7jozvoQCxFhezJpsbBUf57wXMlEZEI7a0N8qafMlR6EA590fcJGqGR1FlA1S1Cb9qzCrg0h/6tNCPJPYd2nz1BePY68a/cxg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549174; c=relaxed/simple;
	bh=EBPP//KAlBskb9pMhxaBL7Kga+U6vtFga53T2SeQa9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiluaaJ5rHfdUQ+o8/PuJJ1iEXrIl/xBz35oVrRSv5In5yQx8RXDTFQ2quVdILc+7LUPU6IyxEeZbw27JDKOIjYd4LiP3lhf0iWAwQghaRI5XLInFG+v0CXfIHOXRPlTuEITF2eW8yEI/YLpFNGYEb9zSszxNZ2JtJ1qaiT/TAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA5+vBqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3FC4CEF8;
	Wed, 15 Oct 2025 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760549170;
	bh=EBPP//KAlBskb9pMhxaBL7Kga+U6vtFga53T2SeQa9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hA5+vBqM9+KAbQ2ZLh7xQyiaPk15CQAjVlTcxPL7on3gUbUnV5A9Zz4mGOXglD3qf
	 kC54OsUK04mRPIzbcfAB2XY0uYmS1yrt3fKFMOn3J3rRnP9gKLoVN7ahh0rKEOZlLz
	 Mg+hR1OoHGMmWrFZfURy66L9UrkbTAoX/JjzMFPGSSpyhoeLM2GjmMFJnNfsjgnqkp
	 YlKLClzCBN9+FfBQdc8eIsjh19j+C53f6pBwkHcZ+XMa9sA958ZqqaeJFvrD4ZRgDh
	 EPt+SUwO5Wif8Qh1Eoq7XKuEX2DfGOu0WsDI7vvhyH+1qVgK3NK+eOF3zbctTZQ9gQ
	 V0LVOVJeJklDQ==
From: SeongJae Park <sj@kernel.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 1/2] drivers/base/node: Fold register_node() into register_one_node()
Date: Wed, 15 Oct 2025 10:26:00 -0700
Message-ID: <20251015172601.69756-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 21:09:16 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> The function register_node() is only called from register_one_node().
> This patch folds register_node() into its only caller and renames
> register_one_node() to register_node().
> 
> This reduces unnecessary indirection and simplifies the code structure.
> No functional changes are introduced.
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

