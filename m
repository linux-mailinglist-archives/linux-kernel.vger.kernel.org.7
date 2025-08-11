Return-Path: <linux-kernel+bounces-763730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6504B21974
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C533D3B84C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F77D22FE0F;
	Mon, 11 Aug 2025 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Cin9Rvwk"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311F1D61BC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955440; cv=none; b=jI0u4DHeKWftYpZLwLrPssN5ZHeCbqY4WtV4XPjxWNhD0SCflDdv80uajwPXB4iYHy9Lc3O9G8OWtQWBLHi9CE1xOYHgFfVYY5GnDggCAlnnzfMoOEhHHKzWMuOQ3hMImSEv12WW+VxUqQsVLbFEBBil0h2nYws0kd4MRR5oGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955440; c=relaxed/simple;
	bh=t+BKRCWZsKqgAOgvdI/IQS5v4/7HhWU8/k4yGH4GnXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZSN23eauNGy3coV9ljJEZg0lU2p1Gr8P2x7wHxZKIb6hU7p+W89DHgBUXlRPtRu3FWRDfSRd5NA+x3/TH7X2D3sMCWZkmOv4S8UdFuC8u5Rvm+cUQSxc88Bbzi6nvm2VE1Cas+tQcW6pNBZ51yYcGatuWdED3gt3IdvXDZav7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Cin9Rvwk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so5769086a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754955437; x=1755560237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfmfLdS2dFzqX+Fr78BWjugD3hNZ34Ysqu9SesKrFGM=;
        b=Cin9RvwkrG6S6OfPjBvnjljsQTyOTT2sBlE1XMiP5BISl7Pu8bmZcrjX9zM0lwHuWT
         PyGQdHvJ7S3T7SFxk/75s0j+YYf39OlKmVa0r5azkdgZWKFSsVVFYIXxjrIzCy8o8+Kj
         r3yg3up0qws4L0XQwaDhkalLWcV0ZFGoqXFBOqkXOkKvVmIKQlgd7xwlSapvHeyCzH1P
         yM5I9IxxadMYB131/DuZcUln1gc1rmaQCDM86T6xbBcMDPgac8MWBHwiEicmsUthRTD9
         UsRr7FETRTTSHhJe2vwXKQ1XlTL1SziBPdlZRI9j6OIibxfgXILA29hlIbYXIVj1oDli
         rK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754955437; x=1755560237;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfmfLdS2dFzqX+Fr78BWjugD3hNZ34Ysqu9SesKrFGM=;
        b=Pk2m43sBTlIt/G0D9nidE8W2hvtoq02f3T0oYhrUfR6KkeGvFdgMpL5YyJdLTMZrni
         T+AXqMpD2vYrjCrtTEDpi1GYeocLMgpxzwX0tVDLs1Raew4NaI1zFPA8onL6kTn/WeXS
         43NwNciHIstt7LN762r6U0Kc8VTwZezH822yBAgyAaub+97g4fYX40Z8cgFitPh/mx9Y
         vGcQi7kojS1ym0poby+j+Q2Xx9WdT2sfzHxuZecuUjTmedAPQ4Ue9MuUDeitfP3blHwP
         fQrk2AKB2BPOgU9/O6tFGUal32gaQz0f3FGA4B67FE0NN8lHLq084FYbKzwvUSoG5YLX
         bi9A==
X-Forwarded-Encrypted: i=1; AJvYcCWi1qrdQXXGsE7OOVFg3h590dRlcZxrDTDt5PG0wWsiLXJ52PWQ6CSfKd7eWjnI1trplLY8KXQ9GvGKu0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2WTT69cQR0CHR+EJ3JbaRwKFmTXXlXaOmtUhfF1/FJFEbs/C
	34kL7CM4ZsFOpWj8KtQw1jafP6BWrEcH82snK9GrhyVWSSRZtEyIAgryT6IIKSDwaEk=
X-Gm-Gg: ASbGncvu0vQYq62pcV0XELFMVk6Wirrr9a4kZRC9EImra+N3dfRIrgGOnsnO2jA4VF9
	haqSNu4ixFqBK2DNKO1LMaLSiDurGaFot6Z98hWCCskJt221o8D2konFV43XOvYJb5NqYM0ru+E
	jY3p890R9OWgcsY1SmRMUhIZwFySzlsGkhClUlRXd85vymDm00UKHsNbq/afzsZV41psf2480fq
	COBu100qzWupQnylX+iwcdXGaT/Wdbc4Ju98ZnPw4LcgmgnHjYoWShDiFnpX7tK907USf1nBtkI
	GxrPKcV9s3cGlOYVBhp77lk+NI8BpKhPjJZKedK4puUTjY/dNAfmvgjWLyywH8ZL1uP/HQX9wY3
	A7rawYNJ/MuBJb/Xq6xIh3vl1stb5jkWTplbeNb9dyo3Xm7KkTh6ALE104tqZkn/8I1o=
X-Google-Smtp-Source: AGHT+IE+UBYandDx5z87lM/XbpF62WzKz4U6tb9Qgmd4oPQwzpn33MGHYW9itmHr3TzEusfdJbbs5g==
X-Received: by 2002:a17:90b:54c4:b0:321:156f:5c00 with SMTP id 98e67ed59e1d1-321839d5850mr19572692a91.1.1754955437052;
        Mon, 11 Aug 2025 16:37:17 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161282b5esm15905398a91.27.2025.08.11.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:37:16 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:37:14 -0700
From: Joe Damato <joe@dama.to>
To: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net] Octeontx2-af: Fix negative array index read warning
Message-ID: <aJp-qm55O_ka7vSv@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
References: <20250810180339.228231-1-chandramohan.explore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810180339.228231-1-chandramohan.explore@gmail.com>

On Sun, Aug 10, 2025 at 11:33:27PM +0530, Chandra Mohan Sundar wrote:
> The cgx_get_cgxid function may return a negative value.
> Using this value directly as an array index triggers Coverity warnings.
> 
> Validate the returned value and handle the case gracefully.
> 
> Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 8375f18c8e07..b14de93a2481 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -3005,6 +3005,8 @@ static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
>  		return -EAGAIN;
>  
>  	cgx_id = cgx_get_cgxid(cgxd);
> +	if (cgx_id < 0)
> +		return -EINVAL;
>  
>  	if (rvu->hw->lmac_per_cgx == CGX_LMACS_USX)
>  		fwdata =  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];

A couple pieces of feedback for you:

1. Since this is a fixes it needs a Fixes tag and a commit SHA that it is fixing.
2. cgx_get_cgxid is called in 3 places, so your patch would probably need to
   be expanded to fix all uses?

Overall though, did you somehow trigger this issue?

It seems like all cases where cgx_get_cgxid is used it would be extremely
difficult (maybe impossible?) for cgxd to be NULL and for it to return a
negative value.

