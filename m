Return-Path: <linux-kernel+bounces-870928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BDAC0C012
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6E33BC98A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E8C264A86;
	Mon, 27 Oct 2025 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVIBGndc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7C233155
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547965; cv=none; b=FnL/GQLxt9W4ZabQye+ryqPyFmpanFVsB809Y1/OfowbW9kNiCk7O6fncFdS0GQhKs8PN4EFGtLRaiAOL7EJ1mARqdxxwtrWzDQmXmajDANPeJzv7AvqFEQ68ObzqQw4TlQznmBpzghudNCZQ9MXm3DqnsWkGxZ/uGN5w4I6EWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547965; c=relaxed/simple;
	bh=jkXvY/rzdsI9gD+gbwG7VuCZ95vvr+WarH7/oglQXg0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P1UK+rJZIkSiExq45orPOvhlE6Vp9CoTt5pfxRJe5Mz4NmtwaFFLZHQrIk3fg8/XZEV9C2sIroqps3fjQjHMpZG0WeLgxlO7oxzCx/Zi6zlAH/YvUPlPUPgQwpLWKRV91oa51P+uuVH6zy7SX9BTTtYzMyKfUxG6CVon4Hpcx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVIBGndc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A903C4CEF1;
	Mon, 27 Oct 2025 06:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761547965;
	bh=jkXvY/rzdsI9gD+gbwG7VuCZ95vvr+WarH7/oglQXg0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IVIBGndcChwkGK8tmWxLKO4II4sp1e86nYBvFcCoDr+TE5fXbr88oqdM3lgUB9+3A
	 9eM2HMtZSOlNu8yy17DQtOqW+f4XNhZ8ZsFVU98tRZ0ervJdFSyJDP4iWruI3VirSN
	 aMKqgJj3ZF4ZMSlR+2U/g+uvgA9R1vUtw5fuVPGUWArmBgq5uBRNpIfDkeQCuXQZ1B
	 x3L08EKbmJQpMZGg8M6GCbVx0TJHmzssT1wToe3oN1O2zU9FAM+tAuOuvgkI9jjraj
	 YSVqdjE9NS8x1sJQ+wrKIfW3poRWKJnp2wwAEa2/gVysPTXq8sOnQb5Lc6Cr52vDRC
	 icAeRpwQiAM4w==
Message-ID: <7c983f4d-fd20-4b7e-8ae1-d4cbd6f5a6a8@kernel.org>
Date: Mon, 27 Oct 2025 14:52:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com
References: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 10:52, Chunhai Guo wrote:
> In the past two years, I have focused on EROFS and contributed features
> including the reserved buffer pool, configurable global buffer pool, and
> the ongoing direct I/O support for compressed data.
> 
> I would like to continue contributing to EROFS and help with code
> reviews. Please CC me on EROFS-related changes.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

