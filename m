Return-Path: <linux-kernel+bounces-766835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDEB24BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA86858FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C165E2EE29F;
	Wed, 13 Aug 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHlZ6nh3"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A2140E5F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094644; cv=none; b=msGixZ3KS5eaF2If0/i95/vmyivi4DPf6YZNix8MwsRRBYfSUtYm1bpcsSEZGwDEs3mEX/BcTxwXgOQnoPLkTlAZoU+7I6J43Gz65ynFLp4X3N2eMVNTrhlUvoYTzGX18008pPcMH9Bfg6p5/PjK0uI1HpmaO7OzWwyaWc8dtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094644; c=relaxed/simple;
	bh=gDv6k/cnVGC+5pFIfduOvzEvsIzZnvrVOea6R+TSr5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA71ioi0CqyiqKlUhLuvlbMrayLyeVFklAJW+X+XtcoSpaYJsjlS2v+PC9UJ3u6oEuaNkb1fhndsk4UqT1b63f+DGWEKC86AgGBxpAi7482CHi7GZc+w0aOZiPzjjwFtq9OxkJ81QGNCNQx1rYl4PhBejM+p+7gKzwNfuIjWPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHlZ6nh3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b79bddd604so3909693f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755094641; x=1755699441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gxZeZj9Dcst0lTsMevYg/T988h0HVKmw8rmMSy1LdM=;
        b=EHlZ6nh3CsWx+3VQQeijLdRwIIK6Dguvs/Vsvpslqo2bWFQnr1gc/dbKBrgYIw7PPK
         1Te+kNcVBDt8MbRlP4hyxTQNX5KJD8iwI63WXp5+xNvpJ2sOiyclQnyUAJnwe2KQ4vRe
         h8dfR6nKbnkbTY2WF6L0zORdPb5syjdCUb9RPJhgQrLsMACDAbhHQuwOWidtER3nB0oA
         YAzALgTWLDIn4N0o5Ud6EESfn9gQ86/1AateuipbLTlJkbIHykbQb4okwR4UEawmgdCk
         F2Zk0asAPhTmzEWUa4bb6232SJ4+pxFTd178QDArnf3LrxUl9Dk8/1xOdb/5lCgL0G7J
         Qgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094641; x=1755699441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gxZeZj9Dcst0lTsMevYg/T988h0HVKmw8rmMSy1LdM=;
        b=BeROMB9pyds5gROyiC9H8zBd2JRcVpd5c/rir7EwqELL/DOIqgNpy8mfKLqaK+Gwxl
         3sOuJKK70oGaiTgKwRWNNuzk4EoyPWHc74gac5CF7AijrQHkmdf6ohZGFkuqVFX0oADK
         xo54zqW+bdTkDdY6COfmqKPZx3Wvu3cLpdD49sWmLpZVNGhjIMZXfoFJyFLldg1AQxNo
         DHXMlUeE12zXdKL/Ghy4Ck9os0WsNmH7Lb5fjKd4HLHIiYN9MHA/3iQw5o9cnLDqN/Tp
         gDzy9nF9nedbULJFyNtRe5baLvhKOd7ER9zpfdBaJ7hsMsTEzii7Wcma9YUHl4MOJTDi
         HLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxFzxH+gQ2nwWYIfRvYeU+1CZLIFtS1vVHFRMGXhEHOLZeAkXA9MDO2iT4u4cz5lKyva+Ng7ZKM2A1S8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSJisYqoFksh0HjQbtZ6gP82YxJ6sjOKy6k2JP3s/HO4Unr1F
	k628eH7Z+gQRU4C/c7QxQFQFHVS5Zj4MAA/Ox+WzTy5prKA+IhTIm0iIZDpQ41l+Tv4=
X-Gm-Gg: ASbGncslK1jGnUZHL4ZaShvtzAZnWHpcOfYE61KWt6XO7BNZxjqh5MgYEaAvACWfGTP
	CkWQRowRrJdQP1YDsbVFULEy5N1t9H3mEoIKYNsjjUowD0xNdZGL00wGlJGyW+4M7aBoiz5sLwA
	+XFMB5suCVLRxD3HELKSKtjOjxA8tD6o7Us+17EHty3wKfOC5o+OVPGj+hpSM0DREaU0psOyCDp
	BhpqE1ZH/wglQ2ai4YWxfQ0GhL/LN3TP7vpD6FpmyUTn/Le9mbm2usH4IuymuSNB4hsLwB9T85z
	UyoKU7Q0rwvmXL41rXGtkrzF2hM6yXu3ewb4RU+fNdxUSC3LnY/YL6uNCjEH5yhFxRxStkX5Rqi
	r7CYNtZ0xc2B0Epp1QVxf1zY+nPm+zSlFNzNx0m4sNJL4MrBXuNSUxA==
X-Google-Smtp-Source: AGHT+IFFIHDxH0gsvcBbrdg0jzQCZ8KJ5WFgRavMcUV7EUAlo72yyL5x+kSMwqYLcMH3lxjUWM8oPA==
X-Received: by 2002:a05:6000:4305:b0:3b7:7cb3:1124 with SMTP id ffacd0b85a97d-3b917d2af6dmr3043536f8f.11.1755094640701;
        Wed, 13 Aug 2025 07:17:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3ac158sm48762592f8f.4.2025.08.13.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:17:20 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:25:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	"open list:MARVELL MWIFIEX WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Message-ID: <aJxaBzZYr4d5-XUv@stanley.mountain>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
 <aJtGSxkRztAsy92h@stanley.mountain>
 <e66eb22f-5565-4f33-b523-f93dc81a1210@vivo.com>
 <aJtQS-Tpzw90Hqtl@stanley.mountain>
 <c330d0f3-d3cd-4981-8bb5-3ff5761647dc@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c330d0f3-d3cd-4981-8bb5-3ff5761647dc@vivo.com>

On Wed, Aug 13, 2025 at 02:52:51PM +0800, Qianfeng Rong wrote:
> > 
> > I really think we should zero this memory, so lets allocate it
> > with kcalloc().
> I agree with you, I will try to do this in the next version.

Thanks.  When you resend it make sure to add a Fixes tag and CC stable.
Forgetting to zero the memory is a sort of security issue.

regards,
dan carpenter


