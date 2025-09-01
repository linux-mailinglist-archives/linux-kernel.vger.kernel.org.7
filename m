Return-Path: <linux-kernel+bounces-795311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F5B3EFBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DB1890CE4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84926A1B5;
	Mon,  1 Sep 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjGAh4L0"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175131F03F3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758942; cv=none; b=csbTRwHgNon32CQ7GEmRAhRxl4Ie/DiTtYKniuognVb6RKnrVE7lZd5VhLfxm2riZ76/NTOh7caDR8Oa2U5J4SvD2OgFafdmCp6VyygYPQhIbE8Ssqdo6qwCGzZ9t5lwJAXkqykux4gNxog3Rdu3W7pjR2TqNNrHLxqfyHohnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758942; c=relaxed/simple;
	bh=TuJvWNPuFb8lhmmXMF8/eGqneXv2KRW8zNWdF6sbSgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwjiGKL9nKRCQGix3A1qDMGhBLpeNCVlYcPDkInNEVXpKqgFuRcMrVMVAKEEQgCgOzdyetAxYq5MEOqeIgmHTjFBFrir7NoBHGI4cFZJwSbc41bjuz/jqHjPVH9kXnJwKXReadeBWxpaYZNDaSaSLvAMa8IPqVWRLRm2JGT5qlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QjGAh4L0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d0dd9c9229so2484480f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756758939; x=1757363739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1eRTCsMTXICAfQlpSFpTCIMhVcisOybnqf4kz8sPero=;
        b=QjGAh4L013iDZeVgKz7k0mo6pdnGLR1Hylp92qleYkjXuhFrFIVR3kTKwqegruXgsP
         JznVT3zZX9+QC1U50NVdjx/zUOv+CBOTUNIu0JKvjFxqs6XHhCNFhNPcKziTZzqcnFeA
         D2FGLPXOIC9o2dhrRzonRyVHmxErbxQat2xPFra/9FUxmRPfTc5ZRVfuOzerYs4K+fkT
         +QuRn4knZ7x3SvV/meb9zkJCvFLm9ZbsYlkOpuMnUVGrmBtIMKEzngp4F1NJSERHb5H6
         aPP4R30pfHt4gg5MsTEgwi4DmtM11Wz+0pOt467N1quvLIqJDcjjImcn4zAQET3nTax/
         pvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756758939; x=1757363739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eRTCsMTXICAfQlpSFpTCIMhVcisOybnqf4kz8sPero=;
        b=GD/qcLVahL5B0ii977QH+V03ED2Ao5/q/Epax8VJKTZm6tEZUXXxcG/iShZXYhC1+6
         cMih4sXaYcgbM/R7IQ7BhpbPNasZB4m6qx8DQ7I1H4on0uz162N0ImzKIaZVfc4DsTGf
         Xwc+qexhQn81NkSMqonuCZlYESjfqhQMXkexj6H1f9CYlbyfb7bY6lUiWErrtx0cG7WA
         1O91padD3A/puhH83QrkE3Qnso3XkfrRTrnPjFOsJgyn9UEEG2jKZIDF2bhy8iXhijKc
         QZDdgbe8LoxLNZjNViQIY/r9/KqFJumDWlbWvg4eqepYSI9UpdEciIB51QUcMmdiU4iV
         KMLg==
X-Forwarded-Encrypted: i=1; AJvYcCVCMzRB2a73NzC4/zh1pvgIP6KR6b6wgg3+DX+XusS+0wEzDPo6DH0ms1eWsubPNX/TDqNZ/f3xis31JPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUd/kxZRogmW0UwtANAVHOjyc9CLTbpOodbH0NyY3H+5LD6kaB
	a1zl7gRiQF77U2rk6Bgm5GUD3E6NprLADfFqxyac458Wn2DgFIBU4QqX5AiP80vDJ6k=
X-Gm-Gg: ASbGncvgu5YGw5zNbtfT/1z7o63GZzgJagGQ6dOu5huV0ywRdYtkZP7WoQIAgBJmtCp
	SjrRz55jyjaVRGVR+vbOGF08ouHJ7Nf681cjH6y/qctS/trUtPJoPhWeo2TpsVFsw38ljDUdfLN
	TJIdh+NhrhktDoGtDSpw+LkSp9yL5g7bhhGZYDOu4jeHuJFL86yD9qn7pckRlCG2noxpJGiXMLA
	TTbmjTAr6pPfAb4KWGTJAf5BHftLRsl3rnhN83P3Z+eKmzdQk1x3c2ip8jZjMCzqkU7Ji0ON8wL
	KEs9u5+M/UbFIylINUKjL0a3XiPXuxU8yrOLPLtE2rZYaYx9kbyeenVemGNFbFR/h0QBOvQTwIa
	z9fLQBavixb1kzHyATIsVPp53U2DClOqnrsSogQ==
X-Google-Smtp-Source: AGHT+IGfts6LL/oOVZ6w177Mz5mBwqX4/XJO+R28DlBKpdEu9bUq+cutbj9eTfqXRRa/A5cAGRZhgA==
X-Received: by 2002:a05:6000:402c:b0:3ce:e5fc:620c with SMTP id ffacd0b85a97d-3d1dfc06df7mr6497919f8f.30.1756758939287;
        Mon, 01 Sep 2025 13:35:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm251756355e9.1.2025.09.01.13.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:35:38 -0700 (PDT)
Date: Mon, 1 Sep 2025 23:35:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	NXP S32 Linux Team <s32@nxp.com>, linaro-s32@linaro.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V2 2/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
Message-ID: <aLYDl1lyL1jLMw8c@stanley.mountain>
References: <cover.1756219848.git.dan.carpenter@linaro.org>
 <dce51c4706ca4961a2ade23756aab750803b12ec.1756219848.git.dan.carpenter@linaro.org>
 <aK8zg3sA4csHwAHU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK8zg3sA4csHwAHU@lizhi-Precision-Tower-5810>

On Wed, Aug 27, 2025 at 12:34:11PM -0400, Frank Li wrote:
> > +static int s32g_ocotp_read(void *context, unsigned int offset,
> > +			    void *val, size_t bytes)
> > +{
> > +	struct s32g_ocotp_priv *s32g_data = context;
> > +	u32 *dst = val;
> > +
> > +	while (bytes >= sizeof(u32)) {
> > +		*dst++ = ioread32(s32g_data->base + offset);
> > +
> > +		bytes -= sizeof(u32);
> > +		offset += sizeof(u32);
> > +	}
> 
> readsw() ?
> 

Hi Frank,

I've learned a lot from your reviews.  Thanks.  :)  It would be readsl()
since it's a u32.  But readsl() doesn't increment the offset, it just
reads from the same memory address over and over.

I've made all the other changes.

regards,
dan carpenter


