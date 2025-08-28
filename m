Return-Path: <linux-kernel+bounces-790546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B1B3AA15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA30A1BA7DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A82750E6;
	Thu, 28 Aug 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onUoof8H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8F2773C6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405866; cv=none; b=tiVcE9QR4RIVPV44ZHGE27nXGnUdlI+oL8QGrmvhFmAfVUyjcbq6hVl3fJZ11Snr+O+8YWlkToFI9esDIIDDlnGq+FYYNyBwpTe5tU2zDbmKUbGLBKlMIXrtptDtIbGk+Y8AkrDu8iMhGUKdSYnTy/waMl34JLg7w5iP3hYYUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405866; c=relaxed/simple;
	bh=FZ5RGXDklxLgzUkJXSfLMP9d5Ww28w2TQQWQ42L3pQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pWHI2sGJP+1xqhBa7xwU+WqkBmH9CuDurrNvAWVfwBauhmyJuRv/L5D7IAmnYAQC3VpdEVwwMX6BfAP3m5iQhJSoF00hSS7lPn2/GAkm0ta1BVZQoKaqXel9VgbGQXR6wQSHuMtWy6RH6pWVTLxHAw3ru5k4VrANjkyvh09RSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onUoof8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D04C4CEEB;
	Thu, 28 Aug 2025 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756405866;
	bh=FZ5RGXDklxLgzUkJXSfLMP9d5Ww28w2TQQWQ42L3pQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onUoof8HSzFlocbcS+1NnLHNxjVzmu/jPWcnen3hiRuNWspvB/t/4WijrWa4F1Yat
	 kbK3IOR3uCr4dxQJcH3IyvFNzckqxTHksC1qfEOgcrURhdVSsj7m2zvUSywTSmb8sj
	 IvxNljXTpqyKfPqXnv4ZqiT1SHIQBl7EMRps4dpCM/5JQwBeRIGpvMrqLDBbeko165
	 rH99zm47lwtc6Xo3nlNVQD3YuvukxlxV8ybmKJwfkleJknKQqsRU3BKG2Ha7bgl12S
	 3o6jzgnJlrXXC0aJlePhkPCklPnNOj5WKVfXMylz9KfUh/cfkqiB8Oa2QmPwPKvTJ/
	 cjYgNZcqwaWuQ==
From: SeongJae Park <sj@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pagevec.h: add `const` to pointer parameters of getter functions
Date: Thu, 28 Aug 2025 11:31:04 -0700
Message-Id: <20250828183104.61509-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828130311.772993-1-max.kellermann@ionos.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 Aug 2025 15:03:11 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:

> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

