Return-Path: <linux-kernel+bounces-864818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E1CBFB9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4791A056B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CAA334C21;
	Wed, 22 Oct 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLQNj5rx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5DE334C3D;
	Wed, 22 Oct 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132114; cv=none; b=BRZwE/52f/O0tPlK1lCGbshddxdrFiOmM1W+JcQh1daAiNj3cqsmgV8npjXzh3g3xJycgAxoqKGCsIqFQLof0ITrDExxO3hm3UoEItrQ9RSi95ncj+hWJlkAygD7px3/SSVgAu9xyb7aYCAHynEa98nqldHG/0WcZxGA90elAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132114; c=relaxed/simple;
	bh=Lcj0Qx0qwyezejD/kADAZyt/GYYKHsvLTfJ3mUiRsyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKfxKkPXUiujm7qZ49JF0AXRG89iMhVZ1vNbKOEvzxKsSC4CiL5OUauDoKba+8jkKfUEhaAvru27Sw3wbTiLQSWu1bmym7eprBK+Za6G8+H6dLgcVzl3IZnZ3MUFigmH2gqAs7RZVnSq7su1T+dOrhdW9sWzan4ziqjg950Q7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLQNj5rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFD7C4CEE7;
	Wed, 22 Oct 2025 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761132114;
	bh=Lcj0Qx0qwyezejD/kADAZyt/GYYKHsvLTfJ3mUiRsyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TLQNj5rxH6xWJubcY2oaJJWc6hmgEY9l1P+EDrmNBr1VBHGMtPjSXmKVVgtVgk7hR
	 oBYTaHFHwfLLls8LRQoMf1ZJ6u2XENcgp31kH3s7d+SgdJYo1czQqASUDZzeyAZ0Wg
	 k2bpKvizmsDv3mAYHYjdpC1Dv8wxrGyWytZq+4Bs9snKiaCTCzgTqhiof1rAnbz0ox
	 VnQbjOKnwHJp8iAQbKdGO51Ey0uWmMwpv9OftNF+sVSyJbAK+ylHDV15n2A2Gv1mMp
	 lSRccoLwFRZV9++4MXJqvlClYXJg16mmiGcGQuGwnrJ5OvQUz+5R+HKGPXLNS7q9dv
	 zWmW2bhGNxYlg==
From: Pratyush Yadav <pratyush@kernel.org>
To: "longwei (I)" <longwei27@huawei.com>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Changyuan Lyu <changyuanl@google.com>,  <linux-doc@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  "hewenliang (C)"
 <hewenliang4@huawei.com>
Subject: Re: [PATCH] kho: debugfs: Fix finalize interface documentation
In-Reply-To: <fe693f4d-80c7-4d1f-9430-3ab9c8165df0@huawei.com> (longwei's
	message of "Fri, 17 Oct 2025 18:21:49 +0800")
References: <fe693f4d-80c7-4d1f-9430-3ab9c8165df0@huawei.com>
Date: Wed, 22 Oct 2025 13:21:52 +0200
Message-ID: <mafs05xc7fagf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 17 2025, longwei (I) wrote:

> From 91c2b24855d55fef0e8919b2d39216d5c9aad558 Mon Sep 17 00:00:00 2001
> From: Long Wei <longwei27@huawei.com>
> Date: Wed, 15 Oct 2025 19:58:39 +0800
> Subject: [PATCH]kho: debugfs: Fix finalize interface documentation
>
> Correct the error in the KHO documentation: 
> when removing the KHO finalization phase, it is necessary 
> to execute echo 0 > /sys/kernel/debug/kho/out/finalize
> instead of echo 0 > /sys/kernel/debug/kho/out/active.
> Fix it.
>
> Signed-off-by: Long Wei <longwei27@huawei.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

