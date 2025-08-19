Return-Path: <linux-kernel+bounces-776038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 598E1B2C80C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C67C7B5528
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7B27FB25;
	Tue, 19 Aug 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gC+iDL6s"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147327F747
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615318; cv=none; b=IqkrpZB+T+hC1JK8/WuD3ltnypj+fKNjubHwcSLsx/jr9EXhf5HgU/tG/LMdy07sGlGCWqEpcAc+xzu92DrM0Tn4HV6ma42TaMm0CtshXhGamqauJHFMzFWMjMnzO0Ta6duv4GwvFsFpCQXk0dnOyH13g/WKXuo0f2Hj/KkCQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615318; c=relaxed/simple;
	bh=JSgFReGmJrpsECohN/zB+vEQB99t0iIxycbYjj3gxhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pdik8dO30qA6XGBw8k83Dr/QqibwRXR3ngaxE7WnGPR5EaH7NveeC8XHrU2i9x9CJ0HF7KQw0vsy3mZbve42QvvZmiC/2Yj7V+M1fG/Wuf+sqeAXNerDm0wO+JvlqjZeSDWUF6Gtgl3aCIsbiquKklr2szOgjL05iP3TsEFJLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gC+iDL6s; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so6151901a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755615314; x=1756220114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6q1VFKJc6RwiYJWPiwiME4ulyKyXCWSmhPscu25fEio=;
        b=gC+iDL6sQDl/2TwG5l13sEF1ye2gBaOnguKNDAFMonmSlsmmIXevZ2Vq0m0lkUpdA/
         fRQfz3VnrVn7U6h5jHiwNsOQQYY3DSYGUgwEitimagb9sXNmzENeYGeWseltorBm/r2B
         Roqm7XgGp0EVZpBawzAEQl1+4Nqa/4IEKSgB2qDIiUccRx0weG8YVLsQd7xJAu/cbnYn
         qxNfQFKSoomNKQLlyJA5hHasQO2+JbhSWUhlVQFE6GdHZa2eC33qgs+sIWd3tXwbdAvf
         BXPqmkQtl+/G/RO0MDT64CubwVuWUDkbWyJ5F9LSowvCJHTugMI0gBqsjGTW6bOEEluK
         fIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615314; x=1756220114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q1VFKJc6RwiYJWPiwiME4ulyKyXCWSmhPscu25fEio=;
        b=Bxxo7VnQHQ75T/subGgKmt19EhItAtvOlkMT7b1+d1aH2Yvlrh+JrWkJloNx8v7jWq
         OVFyjiA9WcNJlNQc/5OBfPyIbG1941GBa1KQBsWn9xQc5taVzpxlp9MYA/gjrEyGoPt9
         U8IM14F11H0PkLRuA8Bt98h1sxRHkEVORmkzb/vmSLN9AzBRrRX72fj9h2GhkF6LRPbr
         Vy07kz251OCf9AZQ/0tpH5gjLu1BUv2juAKmn1mp+RPSM3Ynqtg1+7Ag1/bRd/wiBnUr
         KKHVxAne8/VNV8pEIiBQykgaa7kKpRY59NYOQtF47/ujM9Qfi+aC+GJM4x2C0894IO/r
         zRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVWuMngl6sFtiQfyqzZvLpZzgxG1Vt5trw+2xAZI3myNfPTUyR0+MNv1lrmKQuOp4vw7N9Ks71XgyPgP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVlY1M1jgXPTCNGK4ELZZ3vwH/D5sFtxaA9F6WQqpW6y+DH2j
	GG4ZDxPLpDfoft7jIs7p+dZbnaO6Dd/QUXkFb15APuyHjfK4bYblBECrfAdJ79PlpPc=
X-Gm-Gg: ASbGnctVfpEZApi4OfxRl/9HH7hrdOoDvBQ3gOm0MbjekkV8Qf8NNj2uP8zPtwFa07T
	bgqQhs4SZibPPk5PJq5f9bg9arDYYC42MPEHQXvyetlvj0GFK97mo6M+7Qw9swIy20lz2uCfjQF
	g5i3zyfPAre52ondzDSoMko2N/DKoAz5hn65TKKk8RHoFbohtcunlrKxnv7v7VVa1kuDaSgPrCX
	ERrZZsAOKYrqdtSk0XPczVoy4sPipyrkGuylMRaYmcl5hlQSVGVnOn6nswXdyrsu7jKtoAf+P+F
	yNBmDEuVznEg9HFialvU9hW1xjXGBB4sCyL685O7IbRJPALKkeEOigtCtYt6ocO/ucfsmXhB0IN
	4NirzEYmvAHbWcrJ3OozxkgzvANnZcXAi6IQ=
X-Google-Smtp-Source: AGHT+IHNXoZ8D6hcxitye6J8bRF474YdeJVlKpCXwByDHr/6U1kxp1SPdwBXlJC/jHhgrW329Z5ICQ==
X-Received: by 2002:a17:907:9486:b0:af9:8c20:145b with SMTP id a640c23a62f3a-afddc96119cmr295145666b.10.1755615313778;
        Tue, 19 Aug 2025 07:55:13 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:3ab9:939f:d84a:b5f0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce54021sm1009078766b.10.2025.08.19.07.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:55:13 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:55:09 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 1/3] remoteproc: qcom_q6v5: Avoid disabling handover IRQ
 twice
Message-ID: <aKSQTc5u5AePWVwj@linaro.org>
References: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
 <20250819-rproc-qcom-q6v5-fixes-v1-1-de92198f23c7@linaro.org>
 <czaabkgp3aerp7fntqnpwgilipnum5vmdwwrkem5mugcs7vvd3@q2mwq6ijfbmt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <czaabkgp3aerp7fntqnpwgilipnum5vmdwwrkem5mugcs7vvd3@q2mwq6ijfbmt>

On Tue, Aug 19, 2025 at 02:44:26PM +0300, Dmitry Baryshkov wrote:
> On Tue, Aug 19, 2025 at 01:08:02PM +0200, Stephan Gerhold wrote:
> > enable_irq() and disable_irq() are reference counted, so we must make sure
> > that each enable_irq() is always paired with a single disable_irq(). If we
> > call disable_irq() twice followed by just a single enable_irq(), the IRQ
> > will remain disabled forever.
> > 
> > For the error handling path in qcom_q6v5_wait_for_start(), disable_irq()
> > will end up being called twice, because disable_irq() also happens in
> > qcom_q6v5_unprepare() when rolling back the call to qcom_q6v5_prepare().
> > 
> > Fix this by dropping disable_irq() in qcom_q6v5_wait_for_start(). Since
> > qcom_q6v5_prepare() is the function that calls enable_irq(), it makes more
> > sense to have the rollback handled always by qcom_q6v5_unprepare().
> > 
> > Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
> 
> Didn't earlier versions also have the same behaviour?
> 

I don't think so. The "extracted common resource handling" came from
qcom_q6v5_pil.c, but q6v5_start() just had most of this code inline in a
single function [1]. The handling of enable_irq()/disable_irq() through
the goto labels looks correct there.

Thanks,
Stephan

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/remoteproc/qcom_q6v5_pil.c?id=0e622e80191e75c99b6ecc265c140a37d81e7a63#n795

