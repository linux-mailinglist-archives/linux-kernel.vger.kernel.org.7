Return-Path: <linux-kernel+bounces-876992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB4C1CEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9C405E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD292EAD15;
	Wed, 29 Oct 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKbiHL23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DD37A3C7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764976; cv=none; b=XBs4y6gTtngjtnsxvC4rf1L5Y0qegPNTV8XiPyCO96LdmjI5lKK0jRr9u+jyYDTphuN0f/IYL7GeEaY0GFcDNApe5PAInbN/+l7KCIaL0P3ENGQiugHysg8suUcI0m7dDZcYmeVh764xytowQh7X2skauBjqe2+SzKF+lpgf+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764976; c=relaxed/simple;
	bh=pddlYHbXyxvJ+sUApRo5BWMGEDNsVZD5JUsrd2Csd5U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=osddJ614vIT5iy31i3ZavyroJmDbY2af9fmmeGbo+iFKPlB1xL80p3mQ5nIpuBKqnh6aoPTdAVQ7rBLGCVN2ivwBB9AYoLrJPk7PifXPl4nGBHNZS0YEJMcBV8Q8aLAsY4UtTFGZk9J+D14oFIU8lE6EfRImJA0m6OPdl+YJqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKbiHL23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB87C4CEF7;
	Wed, 29 Oct 2025 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764975;
	bh=pddlYHbXyxvJ+sUApRo5BWMGEDNsVZD5JUsrd2Csd5U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RKbiHL23l0qCb4nwGP/5qMwMah4pg1Letgr7ec8WjfOvoVfGe3Bk2G9ovs/tzEEhj
	 oPbpXTZDgDrInuMnfuwfkOgsd2pQFDbffaE0aUsTEMoqM4Z+6xmLMG04a5QcLKlnLf
	 7jOB4hgPmfrAJsU5kk5lM+hefy8VI9uZbNlmyzyoQdF19MET8Lh6lRRJsCKoDeHQ+s
	 k6pDOBrEFac9Khwd6+xQeRAAqH5PVcwIm65uFMxKpy8W7AlTMnrTfvX77NxvCdtTUr
	 wNc9eEsew2mcAFJsLvK/KqtJyviWTMPr/xj71+LCaC+yyNOrxZDts6FDmeOMKpCJEC
	 QtFhxZj+p35TQ==
Date: Wed, 29 Oct 2025 13:09:33 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    emil.renner.berthing@canonical.com, nicolas.schier@linux.dev, 
    masahiroy@kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Remove redundant judgment for the default
 build target
In-Reply-To: <20251029094429.553842-2-jiangfeng@kylinos.cn>
Message-ID: <84a130c3-4a06-44f0-2282-6b05f38fe661@kernel.org>
References: <20251029094429.553842-1-jiangfeng@kylinos.cn> <20251029094429.553842-2-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, Feng Jiang wrote:

> The value of KBUILD_IMAGE is derived from $(boot-image-y),
> so there's no need for redundant checks before this.
> 
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Thanks, queued for v6.18-rc fixes.


- Paul

