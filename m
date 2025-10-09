Return-Path: <linux-kernel+bounces-846210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7EEBC7492
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9923B3C7F80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580F235045;
	Thu,  9 Oct 2025 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcfq93gd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C5230D0F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980201; cv=none; b=InlN5rdOu+j1ceJG3cxRFBBVlQ08QNWlKTAXV261hq55aW+VJ5teMjP/Etyr8LdHWSbybubKy4OwN5B76oLlM8c3oGcBydUEQl6YW6YwZIBTiHz26tt4O/A9tPcBfbyN69tkUVin5iUR7bDh8jv1M+DNGoSkhpTAFUR33rt88xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980201; c=relaxed/simple;
	bh=7YP1TE8V5KIYpHRIn3iOxTAomS3iNv19gWr2R/JsuzI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QbTpkevaPlRKPhvVZYvjk4CON/WdDfLHixvZFyyBWkOMZEOKiP4LDfu8StsWo8xQnEiEl2HhDgqakA8yNQR5meTEPW/kNoQDjyQxWn1FLNGKW5KlqVm2s0qKbqmF5f1hO73PWagHS2VECEOd5CcLkU5GJCzzsCrMiL8Pr2avpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcfq93gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F8EC4CEE7;
	Thu,  9 Oct 2025 03:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759980201;
	bh=7YP1TE8V5KIYpHRIn3iOxTAomS3iNv19gWr2R/JsuzI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tcfq93gdNXbbRkXqzTD1VKV0xpOQW4CULFttCvq/6SBSGWHc2ooKFWhXQXhswf4bG
	 UxU2GBFUmp68OKaaTTwzOoO58DIJkfcHjkZLDdVcnY6AcvvlQqICOfHXjRQCNQRCHs
	 US9lDkcemRroRWsLgf8wPrZW+00WLgVWnFAaVxVE8+Golo+upW2nGwzh6UUFc4Je1O
	 jCM9so6N+REY4Fsk+fA84T6A0ip8PDQUipOPQQPB5Oo5uQHqDtFCXr/9/U2vzxiYPA
	 BZkDhNQZbAGqIZ0YEDHrkDoC+pZIibBU2xoL4jy2DEUsUSUGZbF0zqOK7TXspI+8Ei
	 WHm5xG22kZaLA==
Message-ID: <94f6a9af-e768-4380-bec6-096fca5e94fa@kernel.org>
Date: Thu, 9 Oct 2025 11:23:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: use folio_nr_pages() instead of shift operation
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20251004031217.50242-1-pedrodemargomes@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251004031217.50242-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/2025 11:12 AM, Pedro Demarchi Gomes wrote:
> folio_nr_pages() is a faster helper function to get the number of pages when
> NR_PAGES_IN_LARGE_FOLIO is enabled.
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

