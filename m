Return-Path: <linux-kernel+bounces-749610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5737B15081
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F95E1888E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CB296153;
	Tue, 29 Jul 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLOCuTCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA6293C72;
	Tue, 29 Jul 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804408; cv=none; b=Fx45/LN6STenLDktb3xnNlfU2pLsztzsYL9sca9ImX8P1801hv2WX9h7DPGAUwq4xlvlkGPbWqI9zqE6jdX25qQCU2eh0CnlPz+QHeHInA8TgC9LGEiQqM8L+hStgMKtrsorsFYn50Vue/zd6WCW9mVf19ggz16eVtNSRnvvBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804408; c=relaxed/simple;
	bh=qCaSWpcCNxthcnOr8otvX0oM7+4N3H0wfT8jaHma2EA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTsxmgZzERASeQmb8l1FMwW1j/wI9zi8ugjNiAbEb2SoZQA3PV/QxKhLWXI+F7sN0C/ssSQhlPyWQI3HF/hJrG+JqaO0SY1N+Hqiiz/JmtA6U6Jb/OzeudyTIQEe4WXsCA4MfFcopfvz6UcZyOxcU6u4c7hoI0iBezHu6jqjybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLOCuTCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004F1C4CEEF;
	Tue, 29 Jul 2025 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753804408;
	bh=qCaSWpcCNxthcnOr8otvX0oM7+4N3H0wfT8jaHma2EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLOCuTCo0W2RHZPICvStNngLqFazt1jjiCudVke/Onxj7NiDJ2dt5JY/FqitId6y1
	 MwpnXx4KIHCEj192zsEl0UkZldtmxT1htBfRjvr+u+0s8xudcIebCKZg6z2SGqTDaP
	 1a6DQvLy3vR/aG/mgMyHPKm+5JLK1RJZ4cfcY0agKFt0h2Z8VXTQxcj3fxJ8buDQ+1
	 7TlKjuEJRk5d9fEm3M4WzdNCRUuod4qmtzpZAe9wyK7YRKBvIE2J2Ux8D6DJ8SRJ/0
	 FClFgiNrQjI5jY824pcrMw3kD6ngBb63xi4KVer2FAgQeM1P/cSz1YU/bVEoswbWxO
	 BrSXRnPLL2gkA==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	zuoze <zuoze1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Tue, 29 Jul 2025 08:53:25 -0700
Message-Id: <20250729155325.53726-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ab6b06d6-d2e8-4695-9eda-5bfaf507c2f1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 21:52:18 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

[...]
> Hi SJ,
> 
> Apologies for the delayed response to this email.

No worry, take your time :)

> Following your suggested method,
> I added implementation damon_ctx->min_region, and also uncovered additional
> issues specific to 32-bit platforms.

I'm so glad to hear this, thank you for confirming!

> I've prepared a patch series, which is
> currently under testing. I'll get back to you as soon as the verification is complete.


Looking forward!


Thanks,
SJ

[...]

