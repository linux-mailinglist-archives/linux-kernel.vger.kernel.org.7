Return-Path: <linux-kernel+bounces-898487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB114C55638
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0473B9D29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998982BCF41;
	Thu, 13 Nov 2025 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GUF/BHXk"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118829B775
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999452; cv=none; b=D4hMmPXdZ7TOFV2et3iH716swiVuvWQH4k4BqsFYrs8VLJNtCHgWNfgBj6yzokIH5jroaL69Ljalpabo3wVpIHnRaxfPdQ9iOgZQwKxpFcCflyYWfUVvQJ63A3KfJV8bq+EiS4m+H5rR79xq2/PUIMGFUyYvXFz26PdlS75/2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999452; c=relaxed/simple;
	bh=yHn8jywJbOIgoXMrWJ5culve++aKWfOdLzK27DJRUY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqDAt06U4dBpLl+Yi9UgQ5un3zHD8ymjnKX76vCKP3FWoW3MlPaCzeCgOBFT0nzKtk5FXlqhCbM+Zh2RnNyxEwaHvxXjo/JSSAEu533LeyxPhA53ln7Y5N2NVOhwpRc1/3DxFGnD7bp2U2nTZJVOMozaY7DF5OsNhY+ki8ZdXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GUF/BHXk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so213607b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762999450; x=1763604250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CoWXrd8JO+QikmbPgskO6RB2/Wy00bhO0gKhHUyvMV8=;
        b=GUF/BHXkZ7guE5ciq+sK4dqZ1iAajFMKHf6+Rc2jDxe11mDz7CBWpWKfhYDis6iAVv
         uqSEIjtTcmtUWxFC3n6u/5ZNph8/zDiODhvuTRvFnyEIkacZz2dFe4Mw6sxNWGTseupd
         LSCu3qJzENlPZYXQij7a5S2k2YUyg+mQM/CoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999450; x=1763604250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoWXrd8JO+QikmbPgskO6RB2/Wy00bhO0gKhHUyvMV8=;
        b=Tf5lnzMaD9VlgO5Dj/fkybuBDMQxdFbJUvNvDEuLLnf0Jo/DRm6FbbsFzwB7yhcHDp
         dsfnuAUEwJW9qQaS8v8Jmqzi5dVr1B8/SWPvhwaEq1xQ3uLfi5OMimZ160FIDI9wmo3G
         EOTGpeG9guV0YAeBDVXEH0HFBqNuvFRRr130B+YqVUhl6YErWQ8FxnLMdDteiQnRa549
         sygwsYDWfh/FBCGHXjEVVVi6jPSkzwRua8XEbYkY1YS7bycyw/OhDOYnp2SebalZtwDE
         uKHIOcOCOoXwwsFND+OjSlYCsuvCon+ooue+++3e6JVf8+cJyfdFvixssmh5E83uGzro
         J0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCU96vMUm9u/yoeZcm0qvXa5pyN6CebEM1cV9A6US+uMMcICPjlQoCHReaOA6Ghuq+wqE7Dfc8lNTuhpYLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2VSUhVFzUJcTfO0owoJ9GRGDBAh1IzyGDRxlEEYNsQGG7BYL
	E26oMUlaB9XZdGXtQc94JTxwr6t/gkflpzRgdu4uUtoHm96rkxjhKVSu0NhxS/Rs0w==
X-Gm-Gg: ASbGnctA8Y8Ph5r+2flkbsuQqbyCYAa0rLLx1D9S17DsZBoihFlIp8gw632vI9wcUzg
	IZviPQGoKNwNR7rbUpcwDVFSLMSXiFrpCLRSte9aIKDAse3V7ZXuOB+SYCCzn3OPcz7/doyeX6D
	zBMWKdrBIlGSJRTvfZ0iZHECkulB6wmloorqWxWICuPE06aLMJAITU8d4b4LR6s6+HyQSByqAld
	hXAZZssKpX1r5CfEorV2ZmpKqSTK+eC4BuDaPNK4VS/E3C5Uuy8pc4c1CTO7U+aioH/mV8K3DxG
	PQ+lSK7MbYtVJ1qj4E/BxdTh8ZCQvB7k0RldUwh0bAbhlws5pzvPWV3WzrkQNswBWpeG8I8Tt+8
	Y8rXoOFvoPlKsVBfeeLnz6qkRPQvnQIXuoj91waj1OY/GVZDB3DjitJ5ZbNe7O5xocnR8Y02OXH
	QRXgsn
X-Google-Smtp-Source: AGHT+IHfZ2N/MAyyzHG3SVOhKMI92QJpBdZOkjEdKOIsG/60o7oByCcoSoeNxaOzOVUQsWD6YUa5pw==
X-Received: by 2002:a05:6a20:e211:b0:342:5901:fd94 with SMTP id adf61e73a8af0-35909690c20mr6753978637.13.1762999449895;
        Wed, 12 Nov 2025 18:04:09 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:f9c3:243d:2a7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927731a72sm389619b3a.50.2025.11.12.18.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 18:04:09 -0800 (PST)
Date: Thu, 13 Nov 2025 11:04:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <rjwycg4sfzuroi3yzsovtebwocabyoq4vq4fuc2cbh3w4n3uo3@o7dpmtvqr7fe>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

On (25/11/06 09:49), Yuwen Chen wrote:
> +
> +#define ZRAM_WB_REQ_CNT (32)
> +

How was this number chosen?  Did you try lower/higher values?
I think we might want this to be runtime tunable via sysfs, e.g.
writeback_batch_size attr, with min value of 1.

