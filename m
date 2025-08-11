Return-Path: <linux-kernel+bounces-762333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1627EB20503
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0975B4E1066
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B6223DFF;
	Mon, 11 Aug 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5dC8xkT"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F301E3DD7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907385; cv=none; b=hT4bkgC1LnM004nPvKTrxmBUgr30cSdha+9r4yh7YOHWjwxBJkcMzFI0tB2mptLxZaMBjFGbcw45D8jSfVhwefWsJRyTTJ0xua+x3hUJnUPuhy516/JUXzotEUykJ3/+d1fefryKDahDaf1Iknh7YkanZrTzlvH2Q/4CmmXo9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907385; c=relaxed/simple;
	bh=lhpccEjV4JvXC3iJXVnLG/g4BG5pKPBfPXPY7b7oLTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrkPFsWJzu4wpUqSV5DHMwqFaP+/pHSL9m8wSQ1q6dyvQ+gxWnu0MJupo0shJ/kFvr4eU5x30Arrf0KPgj+s306p5uUSJ1RQtNTObKsypyZcsHCYja8Z31w5s6AIYKcfoWqvLFnve+riAmaAx1pcABUehh6unltqAHQLzChjDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5dC8xkT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7910123a0so3884409f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754907382; x=1755512182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSpiiISpNVr4gQnCfkPUN2zjFrHk7VxPQMyKo4/lvmI=;
        b=D5dC8xkTcp3nFS538JH/hhv3krHlFCGwSBKAPtiByLb0kp+h8+Ll+BSqGkQbb0kEhu
         N9DpzYFtK94ABxbbbVGGw+jYDO2zgDpZhyA38ocwDE9mqk6PNoC6DOZ8SLnIu8U3MVfq
         kDb/qP7Y1SiPm581VJypfLvf07WKiqVafH5qjDTh50jZAqo0JGsidTpWi72V58sPlIjv
         dWUkjqUnQI8dGD2nFNYinpn28TfrvR/QRwlEq2ZQ2dt0ywi/eax/Pe6W1HyyIKYIGGy3
         crHLykKA6MfN7NCckrcv/M+B/HjsIGOP8nFtDGXqtS37k2o8mhyz2MSjp1C7qoq6tOig
         d4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907382; x=1755512182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSpiiISpNVr4gQnCfkPUN2zjFrHk7VxPQMyKo4/lvmI=;
        b=WYpDXWz7O8Djh6jnizSxvmIy8HJs8PT3bUBpuDMzsXnGlcHQUvZOBOC+elKI3Lt0/j
         EoeGfvgatNbbg4MmPh6AOJ0al5YbEdGJSqIBPoMXajApG8oWQJFR5dIhmQDEasZEOUqG
         uxjLHGiidpts9/jTQlgc+ZWlQiZS+aLF1hn8a0g2eu8Put+S71FValGqYfNuIO8DKXxu
         lae+o449K219YIGiPA+CsgvEslKaAEShaBpkIVupIcXOtaWva1d0J/oBVayPtUIAOhxV
         1L5EjlP+OtJoOE1VW9K/V6TmpdalmGcOzMF540lY90TG/Uw2ukgM+T/Y4tW3/2C8XKAI
         krLw==
X-Forwarded-Encrypted: i=1; AJvYcCUiXP8/eTeLcDyMMJgQxlWUGrcr8Xpkc37fmaYF8GEJ58xGBonb8csyiBhMcgO0WddGDrFzlti3R6XvHpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvyJDMtCIQgL9X0kNXzfWWopjJVGCBwS80HQwtahPqcOST+ejG
	FvyNpxrlQssNgv662iaLBxofMaNMMeTvh3K2Dy/zxtXJjbvTFtSC8ClnDgTHEm9QZwY=
X-Gm-Gg: ASbGncsRFwfzDQnER46/Fr8KsdVMNBYMj8v95zUGMptEvwBpe8fLA+ygwydYf+0CnNp
	Wpoj1qF0PSvzJ7Y9vKiuY/tk0kiItnB/KdH0aa8s2K99GyoMQWP446i2r8h+p6d39OvS50vj9Es
	9F6bSqt8Tr69lNE+j2tkiVMrNnjPk3Y8mTSNrKcr9UpJvRc0dbyAkoABHBATQXR9H89Vbcql8ZO
	N8wtL5InvfLTVJMu7XIqvgZTQqUKNoNorIF6xmbFYtF3dGrRtqt9p+iWD3YDodBItgN8qA//ZV8
	8Z1h2tul0shEhh9Sdk1/ltko9sWHOn3KWuFRXt+wG4GjfPVpcp72s9O7703o11ZwIDbvXnaVOEe
	fumrgpzwiuQC+lMLS4XfYZJ6x8YQ4baSg
X-Google-Smtp-Source: AGHT+IG9ux2smHHV5RyT3jUtDRzIFajNvscvOmDcbzXkqY+4Xp89HRJqljXFsBnzKFxpMyuKABzgxQ==
X-Received: by 2002:a05:6000:18a9:b0:3b7:e3c3:fbb6 with SMTP id ffacd0b85a97d-3b900b7b012mr9878088f8f.31.1754907381530;
        Mon, 11 Aug 2025 03:16:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458b8aab8c0sm382668595e9.19.2025.08.11.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:16:21 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:16:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix dereference on uninitialized
 pointer conf_dev
Message-ID: <aJnC8CLkQLnY-ZPr@stanley.mountain>
References: <20250811095836.1642093-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811095836.1642093-1-colin.i.king@gmail.com>

On Mon, Aug 11, 2025 at 10:58:36AM +0100, Colin Ian King wrote:
> Currently if the allocation for wq fails on the initial iteration in
> the setup loop the error exit path to err will call put_device on
> an uninitialized pointer conf_dev. Fix this by initializing conf_dev
> to NULL, note that put_device will ignore a NULL device pointer so no
> null pointer dereference issues occur on this call.
> 
> Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

No.  This isn't the right fix.  I basically wrote out the correct fix
in my bug report:
https://lore.kernel.org/all/aDQt3_rZjX-VuHJW@stanley.mountain/
Shuai Xue sent a fix as well but that patch wasn't right either but I
didn't review it until now.

It's easiest if I send the fix and give you Reported-by credit.

regards,
dan carpenter


