Return-Path: <linux-kernel+bounces-776854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF51B2D22A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACED1C22984
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6E2185AA;
	Wed, 20 Aug 2025 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL7h+52J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46826239E61
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658729; cv=none; b=VZZyivAMv0MRp15QevxruENUjxppxzfOqniMumEMNDWDEPB1OywhfGsBZCRIiMl9uv6Kzs822GxB+Bgw0v3mMofzSzYbvmvWxeKHTltHQLxrE2tjm+k63Mmw+Q2/mnaPIzf4F/eTlpG2pSk3I5FOcI/huqATZ6VnZDaGW6naIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658729; c=relaxed/simple;
	bh=2Zi9h4GXmdMyUs8RyLnCYmlY8a0oIBkL4KA959j2gjo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gFMET+AtVXyCettnV9y/DgNyNBM9bjTbCEWuzMKcehkDD+jRVhTZW68fm4E4Wk8M67rRRPhJ7+LCidR1PhMEFfF1jFMjJO8ac2PfvmDzgubcEC3hhPB2DMccasb6Xwuqi8XwOyPrT0zK1ZZLJRYRGdoChFBMtLbaJsL9cBZ8S5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL7h+52J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A55C4CEF1;
	Wed, 20 Aug 2025 02:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658729;
	bh=2Zi9h4GXmdMyUs8RyLnCYmlY8a0oIBkL4KA959j2gjo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FL7h+52JMJbqB1HctPVzM90ZX4dyBeRKSrm5HyNlhiMlx7IkLEMx5tU8fYNFdzweI
	 lOxPeS7ncH2vLnr3Qj11YVDetYkoChvw9H4ih+Cqwv3frQoBof2zZdI7xmspsT1GI+
	 aBLbgtIE6Fuhyh9tahOy/BgoiraQh4YxKENV1AL81rT7VH+pyHwKLu2vIUz0lTOhT0
	 W6JTmP3L9apxoIoE2qXdaDfOFsE4zyZoAiXYi+LT6gpCYlNVTEPx+8RLzx5HTtd2Mn
	 FYxAMFilbrtmB/MUWbkUBKB9FbopHdNEO5OUp2Yr6dvtk/cdiG1Twf1IEgdXEUctQa
	 iKj4Sbv/FHskA==
Message-ID: <cd82a673-aa43-46bc-be67-6924500376ef@kernel.org>
Date: Wed, 20 Aug 2025 10:58:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 20:32, mason.zhang wrote:
> This fix combines the space check for data_blocks and dent_blocks when
> verifying HOT_DATA segment capacity, preventing potential insufficient
> space issues during checkpoint.
> 
> Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>

It breaks f2fs/005 of xfstests, can you please take a look?

Thanks,

> ---
>  fs/f2fs/segment.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index db619fd2f51a..d8dae0049b6a 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -649,7 +649,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>  				get_ckpt_valid_blocks(sbi, segno, true);
>  	}
>  
> -	if (dent_blocks > left_blocks)
> +	if (dent_blocks + data_blocks > left_blocks)
>  		return false;
>  	return true;
>  }


