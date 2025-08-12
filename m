Return-Path: <linux-kernel+bounces-764008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25A8B21CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730B2624DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9D1A9FA0;
	Tue, 12 Aug 2025 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pULdnoiX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F07311C34;
	Tue, 12 Aug 2025 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754976054; cv=none; b=PzX+k17XMKWYGjIF9n+JsFQG9mDVWZOYeVRi4k560VAA9+ZuLaxS1pw4PFhG36P8f3jbWHDH0hciCLi3D3nkMZedznH8x1aznI/y3aXvu72mwvDLcurpdh1clyJkX63/YQRj65jFE3UxDrbi2YpdMa94x2SO+S8TICP+h3ZtvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754976054; c=relaxed/simple;
	bh=WZVYBpNUSw63gowYkuhuLjFBfjvRv2/9jyEQN+4O9XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpeQkzjuMWK8wRCkj6AwfOei1CEE3+2VvO/eNNkeTv6Ng+16vPu1F4o7hjxYZYuFxLL80ztvfhPmQ+lx3iHRwg7hdn+I6qagGmWJvCfPi0KcCxl2xixI5QjVJejqtai+k7SDK2g6e2uoJEA+4FT7u+hpJp5uI1ntEU3zc5C9dgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pULdnoiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB199C4CEF0;
	Tue, 12 Aug 2025 05:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754976052;
	bh=WZVYBpNUSw63gowYkuhuLjFBfjvRv2/9jyEQN+4O9XY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pULdnoiXLwpyJVeJ1Z8VoEjX82V6hPY9KZBJ2PrmgxFJloFvq6Cq+YaR4R9CLseux
	 9SrXxDjMVy+2SL+YBzvfMxzA6wp8pDp8vdyoBbi8Bx/aIZgoDFZ+U93L+uHsYwpjZ9
	 kuPiFLbV8Lc7vTCUfuaYqgGEkRhM9W80HhNcxhzrnsp/7fZjGesM7I8w3VLHUDNBQZ
	 p0pUJHRJErTpQxTAPZ5bU+6CeAsSSdm8oSA/wzsG/wU/SxtxG913VpFSRqr03YvLLD
	 kU3R4MoJAStKBFUvVPq14pbGuEAn8nv32OHfPRj5BbGUd/L7iJwsyPRbUF/abeMnRy
	 39pXS0a0eTbdg==
Message-ID: <957da531-4e48-4b18-9689-7e16b32b7970@kernel.org>
Date: Tue, 12 Aug 2025 14:18:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zonefs: correct some spelling mistakes
To: Xichao Zhao <zhao.xichao@vivo.com>, naohiro.aota@wdc.com
Cc: jth@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250808083701.229364-1-zhao.xichao@vivo.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250808083701.229364-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 5:37 PM, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> (1) fix "unwriten"->"unwritten"
> (2) fix "writen"->"written"
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Applied to for-6.18. Thanks !

-- 
Damien Le Moal
Western Digital Research

