Return-Path: <linux-kernel+bounces-749765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED82B1529D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00BA7B0561
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14506238152;
	Tue, 29 Jul 2025 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcqezsrF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF02236F2;
	Tue, 29 Jul 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813292; cv=none; b=ab0OL9uzfpTccJbppfXuiDyer00yYqt+HasVbklFH8tfjkn0QGrMFwS2dTpnGTHHrtZx0gGKkTaqYW6nlybCsXsqJOxf0wmIjK975kpbc8RlmJa+yVJNPWqkJNk2A94eZaNjFwok+ID26LPXy9ZTqDatP9n6XbeGgMhvGHNMaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813292; c=relaxed/simple;
	bh=PYpcpT7h3xRaIjw9UV9V8F02zuO84IEvLaQsNkR2ofY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GyM5OnYWUu9S4I7O20LLzh4XQh75nidMJrM1Q1p6GTWX6qg1u9um45MSvvoxRLqzlb22iyA9L8tgxwXp1RlehFDZWA54HvBGFtI/Mh+8pB/Rs3iBpKSJVbhjoGk99zKorjxTCO2R31nYA5Z1N+BjGF3qqyQMTdnZVJW3LC762ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcqezsrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6995C4CEEF;
	Tue, 29 Jul 2025 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753813291;
	bh=PYpcpT7h3xRaIjw9UV9V8F02zuO84IEvLaQsNkR2ofY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcqezsrFw4yybHEuuviYDwQMdSxACzIzTQ7rf5pEaYsg288n21nP9RRMLb/XIuiWl
	 Of09XVzMh7VcSmefeVBQcqQUIQaItvKQEcShG+vkwe9r5p81HoxOm68p5EnJZqF4yF
	 ECwE2tcKHrj5ssPdnc1W/PBEik+oOWNrgBuSM6DwkMIlVMMPf++qHOOBOGGHbBx/Xv
	 MDx9feTpaHmXXDmQ3ZKSmqIL91LNtG2pFO66Jn/9FzhU2bweqaYhZyX1AcF8hTjBmS
	 NButTXHtt3iSOH+Nst4TvHLlFpoKX9kSHt54I5LevuXhrdFZ9qDpZhOwaYztvmLlEv
	 e9zwjVEuL8+5Q==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon: Add damos_stat support for vaddr
Date: Tue, 29 Jul 2025 11:21:29 -0700
Message-Id: <20250729182129.56268-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <44a30f700fdcf4470318ef5cd248ba98c59b77a2.1753794408.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 06:53:30 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> From: PanJason <pyyjason@gmail.com>
> 
> This patch adds support for damos_stat in virtual address space.
> It leverages the walk_page_range to walk the page table and gets
> the folio from page table. The last folio scanned is stored in
> damos->last_applied to prevent double counting.

Please add your Singed-off-by: tag[1] here.

[1] https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1


Thanks,
SJ

[...]

