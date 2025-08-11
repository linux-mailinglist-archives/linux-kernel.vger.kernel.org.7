Return-Path: <linux-kernel+bounces-762403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E7B2060B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235233A2FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47A256C8D;
	Mon, 11 Aug 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4gIi4V/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D112253E9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909214; cv=none; b=t3rK5ocNsJXIHA3ADDfZwH888C7TFz8IIbyPcIHNzxFE6jPMHxUF6Z97wk+bcrux5XUnrrreBrhMko0+gyx1szwj8x9QfZvOUZAXiMgev10xFuAPEaSlN8TY6s1gOpAXUf4bx1Sh8FUvlvQnnMEQ4O4sCo3YrHR/b+dSxVkJWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909214; c=relaxed/simple;
	bh=KQjwCDSr5jTF/NVTREyzCmEWp0l/PPEJli2cAxTuyEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcLrhr6r+Xab7/SASl30kaXUONSfJwTaWGJ8lwO/vXVwtkYgTU2m1eqaqLxSGs7MIP7+4Mhi6X7s5TvsD8H/Ls+n4rFifqnE6vPFws7qL3RN5+PFXU0426AspaaZMS1SstHNjjlkTe2tQWxoVThkgUYpYgWqIbNAJPCLGNMYEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4gIi4V/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b90ab438edso930899f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754909211; x=1755514011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtlLyamwVwRjM02auBJdL15wK1iRYbhmPTYPeAKkJwI=;
        b=P4gIi4V//S7bTvnrSDnZHHsdev+ZeWw6XeLLEqrznSy03dNjB0KQNo8hERHpw0bXGq
         ot/cG//W615H9nwmjMZB7LoExvo66ppVyFkyDX/fq61akCdcahmLVFeLw3yMHVn+aGyJ
         rFgnlGS+eDr9XHFst/WVZVh5rxCQp28qBRuwiWER7bjqSMF151l8gULW79DpAcAzh97n
         0PsIGKpZC8un+jt/MhDWTPOsBEiE5uiRa6iktpRFmHrxwX+d6VRkbcoMGl62kXWtR4gZ
         luY9iKHHPtufetwe593vvO2ZygEZboCx42QyEQgoS99oUrIxyj+BXCWx8SQDJbfhI5Zk
         eLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909211; x=1755514011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtlLyamwVwRjM02auBJdL15wK1iRYbhmPTYPeAKkJwI=;
        b=q3AkfSiL15qlv8rV5Tg2w25hoX4C7/olyTmqOra7DhHr6OumbgIqi0vuGFXLFvh4Sq
         Tfqiv6vKA1tgnwpGXz9gI5/CVohDQjfc1gyWAJbbuqxMEWcbEyPuY9vCtn4DKPbhD8my
         WPcQwKmm8K9qmkcw7qDJlHhV3TqOWjsC0Kq4UYOhW26f0QXEP0i8e1HIPyA5usRjJwys
         2FEpHuaBY7KtYkncD06teW2anDr/UO8cK14rAtSBEwk3WXaT+nPgpzToMCW+XeDgYa3o
         dcLhaTe2udbQW/3pBrmeOshcUWSfd2LV8wPrHFiJBzkzgqxayRpMCsHKbZUr8nvWqiFK
         X9UA==
X-Forwarded-Encrypted: i=1; AJvYcCXiEXVZCG4gDBu3iq9QumFxkVNMOQ9H6NirqIgngi75DbQclDMbs+NhGBvL3pw8nc4ZCziLc+kJ9OFxsHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsb85o/bxCaHpSdUScMlEV3DpQBQFkcUKeSKM3cp9u8ZUvLUQ
	T82UzXriPQZG3yrVKWmwYayPOqSH1BMCblx+ES6mIuaJtBK6TEA65zwxzZAL+UkVElw=
X-Gm-Gg: ASbGncu+JyBBdaQMw5RxHVBmgCXZOjrB8ehifAMt0LKK4ht8VpvnFl/60OWpP+ckKnk
	ufN0sNhk+s5dNPHd45bAE637QKeBcQN+B5cmaSVPUDgg9v04yYGAGmFwcX7Ib+kUgaveBfLbaIB
	ADByG013EfVILoQf50zHZv3FvB72wksSYS0HRaEwRiZtUPVfo5pfgTYkeHf+QuHrQ5M9lamrYvo
	YIOCs8QT0wuRHeO1qYNyh9Y65bXkTRYNVfOfBZiGeLaoWXGA4oEsXdIBzvWRTq2ObsJix6P8zBI
	pbvtdjbFHFcCgKCNqhHOfi9T2KO2tgrRhbGndtKHcQDSdVkE4QNZHO4kys7G/v1+AtBnrJ1ItmJ
	W1Rx2B509JJq3Z7RYuHuglai6VEM=
X-Google-Smtp-Source: AGHT+IEqVTwXhwTo7wvqPa+EmRjt/aKNN/yf02N51BBRSP3bPmO4761RJTTOJAX9B9e1QYT6x1ySSg==
X-Received: by 2002:a05:6000:4305:b0:3b7:76e8:ba1e with SMTP id ffacd0b85a97d-3b900b4bf24mr10266286f8f.11.1754909210556;
        Mon, 11 Aug 2025 03:46:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b90fdc85a4sm898125f8f.60.2025.08.11.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:46:49 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:46:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix dereference on uninitialized
 pointer conf_dev
Message-ID: <aJnKFa9YHc-pYori@stanley.mountain>
References: <20250811095836.1642093-1-colin.i.king@gmail.com>
 <aJnC8CLkQLnY-ZPr@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnC8CLkQLnY-ZPr@stanley.mountain>

Actually the error handling wasn't so bad.  It's just that one error path
which is buggy.  The idxd->max_wqs variable probably can't be <= 0 (I
haven't checked, but I assume it can't).  Anyway, I've sent my prefered
fix but an alternative would be to do the below.

regards,
dan carpenter

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 35bdefd3728b..b603d7dacf3a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -195,6 +195,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_wqs; i++) {
 		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
 		if (!wq) {
+			conf_dev = NULL;
 			rc = -ENOMEM;
 			goto err;
 		}

