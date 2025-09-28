Return-Path: <linux-kernel+bounces-835562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B1BA7757
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA332173649
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7D27145F;
	Sun, 28 Sep 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt48dHd7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24C34BA3B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759089534; cv=none; b=I4mfRHx186oNqSZxetY7bIC+Laba7Eyct66H3zm08sTJzQ0q54z4mwq3Mm/X+fkf/faEYSz7WQzvpYKNGhro8Txz4doQcALgDmhj4B/54yc91xfF+vGYs6Bj7/3B5Fq/muxgF+c8ipcIHxeevCn64BdVHYIT8lWWRoGOHvP2oFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759089534; c=relaxed/simple;
	bh=BSaNDAJ2DXajilDe8utcY5o/kSH59Yaye0rmVkRFg58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+KY2MKquza5yyChXJNx54wy6aRVrUvidEyzhPxTpeqONie8NzOwbwtGIC3sdoYflssTY/jSTO4Fy7b9BlI+JGEwFVN21Awmscxaa1XZBr0Ld+cjt9OSnoOk8l66ZGn2w2gFoYLkVUknahVrHadL2ZQ0moHYHHOTT+KshRRPLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt48dHd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76430C4CEF0;
	Sun, 28 Sep 2025 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759089533;
	bh=BSaNDAJ2DXajilDe8utcY5o/kSH59Yaye0rmVkRFg58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qt48dHd73hR8qF0yh1mbzrZSmoewZpeuZPnrWBLTLsFCYQpZAbxRiDujDVqg9MEgQ
	 LUobkOYPI9359vDSTv2L0OrwmaUFqzTQdFb6hC8/v4D/MOQBFXGfKgVxIiCZYfoqKB
	 nmQWlvt1id9J+6D8snN3NprwoK6x7IGBoM9byxgFfPSDLEXgJz/3QvhwTwbuWayiCm
	 yu/TsDq8UCoHhG9sczkk4INEHHfXyLI18CZjTbnQM8kzQMTamKsgs7+qGOHcckL+lz
	 FIDr+OrLO+wF5u+hKvBGYKp6QNyA7EJTKluVP6hZLebBivWUuwcrnE1enVrR7NPVSL
	 JTGHIA6vYUo5g==
Date: Sun, 28 Sep 2025 19:58:51 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs-tools: remove unnecessary alignment for
 blocks_for_ssa
Message-ID: <aNmTex1lM2qGi_hf@google.com>
References: <20250924185423.1305104-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924185423.1305104-1-daeho43@gmail.com>

On 09/24, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> total_valid_blks_available is already a multiple of c.blks_per_seg.
> So, we don't need an additional alignment adjustment.

Can we add ASSERT?

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  mkfs/f2fs_format.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index b98976c..55a7505 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -500,8 +500,7 @@ static int f2fs_prepare_super_block(void)
>  	if (c.feature & F2FS_FEATURE_RO)
>  		blocks_for_ssa = 0;
>  	else
> -		blocks_for_ssa = total_valid_blks_available /
> -				c.blks_per_seg + 1;
> +		blocks_for_ssa = total_valid_blks_available / c.blks_per_seg;
>  
>  	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
>  
> -- 
> 2.51.0.536.g15c5d4f767-goog
> 

