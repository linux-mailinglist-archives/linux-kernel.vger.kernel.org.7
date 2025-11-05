Return-Path: <linux-kernel+bounces-885804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3067AC33F18
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 05:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC594257D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 04:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE5D22154F;
	Wed,  5 Nov 2025 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gchhi4QR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590FB1DFF0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318040; cv=none; b=UA3xfwkp7c0B/hIyz0BYfGlg0UGZhtk/Msrex9ILtX2kFm5qvO9Ow+98w0NLawrW8I045k2hvDK/PXkyh2lnya1rBaSj2+BpLDCUskjFOzoQ2Oq1l8mQn6gZQduLanCpX7MbtdY6sy5u4ZwpHsLoeArzmdQqp9eBw3038lFA9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318040; c=relaxed/simple;
	bh=ZZ99cejwp4rpi6lQWuniGgjbQ8xV7HQM8mDIn0ioGLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr+UnkhyHAKwlZ06zlWUh6ctlnCdpA6QqfFAainmfX6OG8ozs1gecBWBEnbEyyx1tPhgfyn0s80soZypHtHhOmALtrkaV4KDDmYHfFhfTSe5bjAty/RFqmxERaR0BA1d6uKIKkVxnMUdEhLoVFzgcufnbRfNNVPEsxgHGCURuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gchhi4QR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3EDC4CEFB;
	Wed,  5 Nov 2025 04:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762318039;
	bh=ZZ99cejwp4rpi6lQWuniGgjbQ8xV7HQM8mDIn0ioGLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gchhi4QRF5x5dQQCr5QEVmyfZiLJku4SKlv3p7cJCPx+AToJsZUtjwseitC+Jl/X3
	 pgy9SCkimdjZtZ6XuV1RVG9uEFmnO+gSd7m81JkRSpNxJiGbkf6rYGG1N9ou83voIP
	 Tunugv/CixPlNRu4ak/Gy24LjM/VOjZNZP36stEPxZAGaHANBWayezW5chuidJ5Eiu
	 TEovjqjGO57oN3AN+VwJMf7mYzUG376plcLvyd3VqGc0UjoZ2z5dlHTQ8tqSen/zL9
	 VRZrWF6gIV/zLgXi99GCU1bViPfDGpbAfiXBzLfR/VTZixDsMU3KqoFVpczyitvz+F
	 j0iqGWbO8U+Bg==
From: SeongJae Park <sj@kernel.org>
To: zeng_chi911@163.com
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	surenb@google.com,
	kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	zengchi@kylinos.cn
Subject: Re: [PATCH] alloc_tag: Use %pe format specifier
Date: Tue,  4 Nov 2025 20:47:14 -0800
Message-ID: <20251105044715.71861-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105023925.1447482-1-zeng_chi911@163.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  5 Nov 2025 10:39:25 +0800 zeng_chi911@163.com wrote:

> From: Zeng Chi <zengchi@kylinos.cn>
> 
> The %pe format specifier is designed to print error pointers. It prints
> a symbolic error name (eg. -EINVAL) and it makes the code simpler by
> omitting PTR_ERR();
> 
> This patch fixes this cocci report:
> lib/alloc_tag.c:776:63-70: WARNING: Consider using %pe to print PTR_ERR()
> 
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

