Return-Path: <linux-kernel+bounces-898735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E06C55E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C78834E168
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C53164B5;
	Thu, 13 Nov 2025 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BlMOjLhH"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23C253B73
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014131; cv=none; b=ecYIjBtqDgxPnb9X60jlTM7+lK7eEhiV8sOCeL4W44rMGN7Gv7N4bMXTEWRZ4HMuVw/8pMSAFBgB6CaH3dpjJ+eFkMtcPmjaq35/Kj9QBD0DWAuA5h7Bjdf5ThM1xJaM1cPQ75IqBd0vA8kytuhEa3OmRpE8Lqxc1InucarTy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014131; c=relaxed/simple;
	bh=deLgONR1W7cbFg3Z0GUolTT/I3CXisjAflanAAnCAF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN4b7F8d2k1UJL9ZNoCqYse15I3EkF2Yw1oxMSnaHZPrCJFy8Fzb5rau3I/qwrNx0xOnJCRpxDR8ziahqGzTryrw7mLS2YuGeDSBhmJDcv89xl+dyD2k2ZFH3MRtx7hGUud1jt/XBaEDBzYA+BbN8gs32VE2vEpeAFketQYxUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BlMOjLhH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso331182b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763014130; x=1763618930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gw80Q3rADiMFZJQ1jC3X078+JYTq1Rdist1GKyxgI/A=;
        b=BlMOjLhHJ09veowAjajEZSwhdj5+KdOugbuAOJ0o0Uf8KdU6W62jMwfY7X405TPDJd
         wLI8UlZDt2EyMaEwkOV94dPd7D5Wu4W4k0nD55VKqhA7dCfcQm5aT7V1qs1LKLTRGe0U
         DywSO6u2hFp24frfz/YZ30vLTIxFW0glqjZNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763014130; x=1763618930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw80Q3rADiMFZJQ1jC3X078+JYTq1Rdist1GKyxgI/A=;
        b=ANlNmvTxR+xvyzSLZl6iZ67S66Z3d30crruwJH2jcjsMJAZZ8EWALqBPYnAG7TG3RA
         taeeq9sNbxZKu5hWBZmoDtILGWma/VEPfCNCOGaudhgIZtmHElXerZVjAkmcRLPsZgSo
         PChyLlW/Zxqp7dQi8rnI84IIYV2VcyxbhHGK4kXysu1umy5d93EHAEZ0UUWDqVFG/zlg
         3SPnlfqNbyhzniMkpP+3WM/Vu+Wcq6f02/RbvlO/6jd2HFpl8vZQbiSEM8wv58ObpN+u
         WNYLM3PcoipR8cbgZnAMTyr2rRpkAKfwUcHQRx26+hJS+b2FAPZ3XwDwuTGURSmfcnwd
         SpQg==
X-Forwarded-Encrypted: i=1; AJvYcCX0Bu4advO5+pteeO6NhGNB8ctTmLXP2shgivt0CDmWRsc6zPK1q7WerJu5RCG1jLIv6Rf+1s0vvkwMgt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRrlh2+nEY0L0HnaV9LdQFd9Iz+hCs4//IujwCuZOLOdH4CXJ
	Ijhnr6FmQtI2Z7hcHCSlmJ2tITImq1lHnGQf4OAbX9JuNuA4v5PRRUmInQUt3Vofhg==
X-Gm-Gg: ASbGnct+ZiJr+s2rz5ZEmssKoybvfIon12rq8eQD8gD8cJDVjJbxCyh4aFIUIp679v2
	oG6QfHfMrCF0S8lPcm9li/3Ft4rVKGubyafgsoTZ2sv4UVQxdzZ5V+ePgcRJNXVJsLNjGqULWOO
	a1jpTfpdEEH3lFcelVoauTHDceS8hjqMNZmnalL7Ul0XUf8/J0IiW91SLaPkHPU2cNXE7VNroXP
	yFwL01O7mDg8H+1fwY66vj8HQtS28KfLWR748jtnjec/EbO0IQazXzgIqRHX+cHI52eJyKyx2xy
	TZu8XmtSDffrJ5+ojLcRuYXMqdgJm2a2RIe89U6578QBGMbFA2+fXKS8FfI0QxJ1i4h768NMbRd
	+qs3cMVCy5v6kI/vtpL0C6KXssbiqiukSmGfLlbAzkiUREe0OnrSgfnfkqc4yJvHPAPKfZ3m18Z
	JtRwwd
X-Google-Smtp-Source: AGHT+IGowM4k2KBhCbph1UBTZNDjTuE4Z+T0S2CNV/KUAFRo/MaW4AiJx6RQgvWm445j+0v0k5/emw==
X-Received: by 2002:a05:6a20:3c8e:b0:340:aead:3c with SMTP id adf61e73a8af0-3590b02ae4fmr7840094637.37.1763014129699;
        Wed, 12 Nov 2025 22:08:49 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aea0f8sm1003329b3a.5.2025.11.12.22.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:08:49 -0800 (PST)
Date: Thu, 13 Nov 2025 15:08:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: introduce bio batching support for faster
 writeback
Message-ID: <azppxi725gcsjgbmcy6c2zvjwgevzt2ci6ri2bwsdc7x3zrk2r@w5yiry3cy2kc>
References: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>

On (25/11/13 14:59), Sergey Senozhatsky wrote:
[..]
>  		if (!blk_idx) {
>  			blk_idx = alloc_block_bdev(zram);
> -			if (!blk_idx) {
> +			if (blk_idx) {
>  				ret = -ENOSPC;
>  				break;

This really was not supposed to happen.  Will fix in the next iteration.

