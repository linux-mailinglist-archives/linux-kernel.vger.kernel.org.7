Return-Path: <linux-kernel+bounces-680283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A61AD42F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 21:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C697A71CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 19:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140DF264626;
	Tue, 10 Jun 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdR49Bw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BEB218AC7;
	Tue, 10 Jun 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584049; cv=none; b=ZTfNyXXMDycbSeuc46upwy5+rFVimgs+44+6+I1eFD7L5uKbLHo4sZBAr4nHWN8vt0IZyosjwy+HgbspkeUx7QbfeZhe/kygO266Lab6UEhGRW/1huxUvhp62K+xn/ozIAqhI44wILvUPTZgsS6QxlCWUM7K0Wy/H4zPiGDMpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584049; c=relaxed/simple;
	bh=SjVdrE73WgGFFSdF0ax7uWZl3xbZDiiwvJc1Pv0mXSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgNqzOz1rpGqn7CgJ/0c8uRxv6PALKGvMP11C30rVZgwBb2KL8PbfIFrjaJqkm4B+b4OjwBw5/bXbQKuPfz8FFL2gdRQRBetzx66i431K9RPWY5pNyYOBBFFhziID/86LU+AMmaHDua2P2B+A33f8VnNS82KZmeoWLfXdBF8O3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdR49Bw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8D8C4CEED;
	Tue, 10 Jun 2025 19:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749584048;
	bh=SjVdrE73WgGFFSdF0ax7uWZl3xbZDiiwvJc1Pv0mXSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BdR49Bw2Mgc8EB7FE2MOAiM9LRgyRd/Kr1WDUAOyU0FmYkR22dN1IPmkuUKZwQnRv
	 nfaheV+h0WKGR+oDE4zgbkDojCzCKu+Rn1C6xVXgAVNmSgsBk/KsAT8TiIvXAruPsd
	 ZGJ5q6EfxLnGCDR3cJnX+3hNWBMIz8GR8OGbh4U1VS5NlLo11UUz0KFFiWaLMdCYeh
	 wW/6vP11FdLIPgUxOIvhkP9Zuv+R3nXsyYH/wURMDzaIEWQF0m+xf7D5YnkXQIM5d5
	 xaup4bI1VZeTW7xQ8YvRy4awoJYD+BGToCaMl+cGci+c+V8Dv++Se0nIe/ZygbhGEO
	 nN9XuZ8llkpkQ==
Date: Tue, 10 Jun 2025 12:34:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, akpm@linux-foundation.org,
 lumag@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] MAINTAINERS: add myself as bpf networking reviewer
Message-ID: <20250610123407.647005db@kernel.org>
In-Reply-To: <20250610175442.2138504-1-stfomichev@gmail.com>
References: <20250610175442.2138504-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 10:54:37 -0700 Stanislav Fomichev wrote:
> I've been focusing on networking BPF bits lately, add myself as a
> reviewer.

FWIW

Acked-by: Jakub Kicinski <kuba@kernel.org>

