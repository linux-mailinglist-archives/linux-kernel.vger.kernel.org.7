Return-Path: <linux-kernel+bounces-807099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4924B4A031
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB8F1BC5691
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064427602B;
	Tue,  9 Sep 2025 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSLN7TPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF85272E7B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389438; cv=none; b=iz2lAP39uiP70pkWEY+njje3bhmtXsG71314SbG7kTB0ZlyFBgE9YPICzy61K8WLZec0J/Kblu3dGWShPr265QRbUcsnqTiDuVt+2rIUAnGoPOMnO0DmxJo+AWDhcIufrL4GdtVAhk41toDby9skiadn8w1Kk3fN9TDZSLFTmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389438; c=relaxed/simple;
	bh=XnNTeZJeJVCkIGkBxwan1qyQTZSdfU+eF5WhtD7p8xs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uvVBl6ANgEjpzWM4jzXMWNKRgk1my3gT3OW2Qgm62YOWJCnyGIiOUseE6OmFh+KOWgxqNC6wGqisf7VBkLZGKPKYZT1TWjhCSmoRZ9VCGEuD2rO1cRRW1QsYIW35bUviulSw57Y7xzDKexd5klekN2WX9RRC9EHWCWvkKi36Fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSLN7TPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91BC4CEF4;
	Tue,  9 Sep 2025 03:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757389437;
	bh=XnNTeZJeJVCkIGkBxwan1qyQTZSdfU+eF5WhtD7p8xs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eSLN7TPJPD01w/uQckPv5DdswYgYLUBQGA7rkxe+1B0aLHNsQx/LzxWj0f2Shq7t+
	 hGu3Sp1hxrbABpnxOsO4y7Ham1HUbamA8GLOtlfUvSIs1rzJSAsGalqsbnBkfCbkEu
	 r1VQgWk8eMAyBu3AeMqaj+3/FWMmUHUrQrUIH5V4OJjzIX9EZarF+BeSNqvBt5EWXy
	 08+aVKGwDB6rAkMn3EAdLK4DDcVHIi7Ywdfm1KJ8W2hLbRJkF1+P0vtMd9p62fLDaY
	 jeWqUzSZ3aES4YtF+oql24AdtM9fnq7T6Bkf2jMtC8dz1cB38tXxJSAZXp6uDu3pS2
	 IxnwRc5ztJ41g==
Message-ID: <1a99407c-053f-4404-b47f-878b241ce07c@kernel.org>
Date: Tue, 9 Sep 2025 11:43:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong layout information on 16KB
 page
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250909002717.829981-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250909002717.829981-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 08:27, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch fixes to support different block size.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

