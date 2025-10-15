Return-Path: <linux-kernel+bounces-854949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA48BDFD01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A093B7D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545A82DFF18;
	Wed, 15 Oct 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtOrVBG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D486342
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548254; cv=none; b=YYYaaU8KWYB6usjLfgTynwRKJFWbYNLqN+V1fWUYbuBLwd6O3tOa0tJWlJ5cRgfAL0frzU41+KBCEummtMfzYeA08UvwIvSl2VDFlnEHRu0MtZY6dQSt9a+1ezAbqdZlah4+nWX5q62a7MhpA1fDrX++Cn90T1W4DUnwEib/iHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548254; c=relaxed/simple;
	bh=6lrvUB045PTLgH5UIyEfsTNuiOjA8cUHNctXDeAItWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0nmMbVwFraqy2U0edAHaCiqFUUIUTHMlPdZ9bADPEBnvHs/e5Qgl5gWTouPVupNkh4traV3lXgg/K+dtKVNBYsxdL+O1MJJ/ttB7ki3RefghOnnBIzjYr+n+W0gMdwNMCV41dsTRw0x3Vz7/XrenrHhLvetABbol6IVQeYXgzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtOrVBG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A15C4CEF8;
	Wed, 15 Oct 2025 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760548254;
	bh=6lrvUB045PTLgH5UIyEfsTNuiOjA8cUHNctXDeAItWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtOrVBG6Z0sgCRlPwkTylhWK1IZrJ69hezqzmetoSw+Bo0WqRWiXFRnjbG4BaydR8
	 UL3HFvVQmEcq1pfCyWkOOwYe+Bf5Iss+TycMJ5IIO9ceBDHE7s4IPpOFvELoYBAToj
	 bdFZUSqe7IbB10cH9GxKOzBt+Dgw8rijQh/84Z+irup1T7poBO33mi4u6BEHag0omX
	 krdEJ+yL4cTe01H/pinOfA3xCpvic9vBqdqExQIt/ctpnOhZeyKnrlKLKVZE8RtYKC
	 veXTGgrB2iCY3V+etcCoYUYxjk//dwqVfHSIplviO+UhX8nludNyGtd7IQ9IpsOTdT
	 jVvz6ad3Bls8g==
From: SeongJae Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ye Liu <liuye@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/mm: use <stdbool.h> in page_owner_sort.c
Date: Wed, 15 Oct 2025 10:10:46 -0700
Message-ID: <20251015171046.69535-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015093851.109663-1-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Oct 2025 17:38:50 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Use standard <stdbool.h> instead of manually defining bool, true and false.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

