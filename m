Return-Path: <linux-kernel+bounces-898789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64664C56071
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C624F4E3870
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873432277B;
	Thu, 13 Nov 2025 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S5imVyNG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D24277C9D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018196; cv=none; b=bdMCPBs4YEwgmLinSYvGamS+PdVb7++RagH0E/5LoO3rz9cLI7cC4V38p9t9HFJRNQUYfJh3YX3KklHuRejTBgdjkhecuJdtlPpOitTm8H53Onx7DWegsPS9N1WXCjdfBJHlhNv7etQ3lWKGqpo1fMgRRTi4aMqYskOyIoHmRcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018196; c=relaxed/simple;
	bh=c4zHcCtmZMeGsh/6boUVLJrPUNnv93qIJfOwOLJ0aqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QECaQe+aE+ihTS5thivaCueCnp0p1Ji2O1CGnNctxQmeX3ZUeFz7xtF1NXcVQHza6mTi+DpaFXeAiy4l0uUi2CG1IDoKzCqhS8sA1zaX8EGSyYd1Z1NrdIOZIU0Ab1xJ9+BHmYdOf1aovCDSDUF59yATFTWmU/Wv1WVPxd8WuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S5imVyNG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2953e415b27so4480165ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763018194; x=1763622994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wrlB1q7/ZOkA42YS9v1roGaOvVL8ukdy93xk+fDJ2o=;
        b=S5imVyNGzSOJa/HyEgNrXmiA878QdPuoTIvAOXe8KFRNFcTOqn4tT5MN41u6O6u+1T
         EUC1phlWUxa+6Nu9IXjdjDBMMAwbdkjQk20zfxVHVecXerk7HrPWDTgRd/3YMWmCsYk2
         qydfMjRO0w92QRFI1yzLywffLBQN17v9GVwe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763018194; x=1763622994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wrlB1q7/ZOkA42YS9v1roGaOvVL8ukdy93xk+fDJ2o=;
        b=fzdFBX2OQABh+gpq4Ol5c8kH3uipWbzV+SYKmPl9MFp3rGK23dU9vxkuTTnV9/SJWm
         lZ2sedqsR9AoJTiFmbbYrv1OEa82SEIbIi5izo1AuWn1p4AHOGzJo4/CSxX3P5u2i0tF
         6Bqc5YYKPKZTMhXEZQ71LVbLpssdhxAbOetsCeEXYCpdwt3VzRGHIDyxeNVfFOzcOcAf
         1BF9fIOGqQg4zbfa9Ybm9v+2zei8fdI3J31aQhCewXnl4qml9VlUif7HgV/lv9L12bI/
         96OgX6PCaI80i7q67d7Sa/QRyre8G58Eu+ZYPSW8H4/C8DTNXyPqSsC7m5aX0QVxkJsl
         3T2A==
X-Forwarded-Encrypted: i=1; AJvYcCVpBoNd0tZMYgWGsnoVAiZTUqLtMEXWJUQ2LSl/qgAl1rqPIYclmYaHQs99Bt+XwBSVnNgiEOQHqV4oOM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVAy/9deJxMULtpOO8Y5xGqBU8kysvt8PqfMPlS5TxvQXi0BC
	I3jHvk/YJM2G6hdRqSuDnQa7ktWt7aYxW3Wd0XtzCQhW31R6GNfZsEkPJ8XHHINt6g==
X-Gm-Gg: ASbGncuCZajcL6jp1Pto/d98WX5PGdzKdeSXOQRAJbO+moR8hI40hDxI2YJf2prVs9T
	Ez9sovxN7ZEPUhJN4yJfy2S7PHv6sBMv3ZCLc0y2YqACYNb+4Z8phDM0k9Sr8q6eZG36ztoOqOa
	eUWXmUkS+6SrLIlkIKIBIWCY50/9IQdaKy+hihHOzvLdEyisyuZGihqZU6Vj0QIl9vxPBoXFH1X
	47sgJUNltp/89wY+V9NASkUsZpuk6GdnC5ZcCe6QOfhWKp3FaXsPZo+p4qODbRq/ZBkTyrEH5Ru
	Mu6askjAFv92qoFARdrkvW43LkGXRGh30XQLnHts3zrBucNRTKNIo1w2SFJnvZnQoOYP/SoBsFY
	iUCP46Z5P6Ga0g6IXtYkestQ1nqk6stxsNX0LT4+nBLjbM79/NiXaParwRqldDSU9FLLc2A1fYd
	Kf43L5
X-Google-Smtp-Source: AGHT+IECRPkJaf4oGfrwi1MX+s8z5xbRJJ9Jk4VfQe26C35pT5SliM8hefU6QaId+JYNDJAkFupzCA==
X-Received: by 2002:a17:902:f707:b0:295:50f5:c0e1 with SMTP id d9443c01a7336-2984ed48facmr73094665ad.15.1763018194389;
        Wed, 12 Nov 2025 23:16:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed39sm14278045ad.77.2025.11.12.23.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:16:33 -0800 (PST)
Date: Thu, 13 Nov 2025 16:16:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: introduce bio batching support for faster
 writeback
Message-ID: <txgn6y47vwxb2d537374lklpbwwxy4r46okqgbvqxwxppjfwhj@wttkbv2pjjpx>
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
> @@ -775,67 +980,41 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  		 */
>  		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
>  			goto next;
> -		if (zram_read_from_zspool(zram, page, index))
> +		if (zram_read_from_zspool(zram, req->page, index))
>  			goto next;
>  		zram_slot_unlock(zram, index);
>  
> -		bio_init(&bio, zram->bdev, &bio_vec, 1,
> +		req->blk_idx = blk_idx;
> +		req->pps = pps;

This should move ownership of pps from pps_ctl to req.  Will fix in the next
iteration (apparently compile-testing is not the same as testing).

