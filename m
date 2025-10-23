Return-Path: <linux-kernel+bounces-867072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01640C01863
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744E31898BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E0314A70;
	Thu, 23 Oct 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPUQUojb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A64303A1E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227101; cv=none; b=UaRFa/QBSAxOENs1cBPpi1/2VoqZb4g0vtjndhGFWdipwskXrB3mrX+SL7k/OhucU3CF+8RlkI6A0YrMBppkI5hJyQdUwilXasEdqJJDQIy/mUKk7G2TXKhlGY6uPPmIDUUt5tFzcrjLup4tjc8wStAZlb6c2kQRXGoE/esyb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227101; c=relaxed/simple;
	bh=fQGPL2wAp1su4DsErlG30e9PExo6Wj5zg3lLPe3cQYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owRvATkRS/3wJMjRO/A9d37f3fmXAwiVcLD8JprQYVFcSa5R4fYfMXemu6dY2FnAr6Vjrx/vX6rRXzVN8xDpLPsheilWNfvHXO96NY3+yiM1nntd5sc5q/hlC5Skuxzev/AEZ2S9HRkA0an73QePvhv9wahF5mxDiIA7CDegbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPUQUojb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471b80b994bso11803275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761227098; x=1761831898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZkEHZ6BvBqCRscatYxdEEZ9hCJa4XN3mU8tPMYldOM=;
        b=bPUQUojbqNMf+pd7a8jp0Iq5T1YdHmEWH65BHLUcoEKzV/ZEkYDhNCobgUJiVSU8LR
         hgIWgmPhJl4MpavoNKM7F+CxJNMDwpXQM8eZGR54YQAwwagoWvczqahdH/C082JPEZz3
         4Ks3QKiSabs3FPt817A3TtXWuLokBL957krRxWAvhQieiJy57vGWleyQrrfomxoVrVNY
         1cXh0+a7aCH0RPiOByzke4Hi6CFS92NkzDEKufP4YcA4aGFUiOQiNPAC/EyEkJMmILDS
         KOxJnAlhijLvQ/tYql3+eXk8odU6vJsVc/DolSnH0LrnDnRYzQG+J/eTq8SaVd6ojM9S
         2WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227098; x=1761831898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZkEHZ6BvBqCRscatYxdEEZ9hCJa4XN3mU8tPMYldOM=;
        b=I1QbhgiCYM6h4NiCX8bmjd4IiQdTuiLmNZK3h4Th8ACtPTiuWAvsFro5Osv0t/4xfN
         Yn/lYV3pAYmzfH3s23btWDZ4QTjetXAXC1puiH1pYPl0FSHRD7/7npkL1jr1xxI1qRuh
         NnRrKKAOvQovgvT1JAeaFmnWgG2TT8JWhHRlzh4OtaezmcFSgo2wbTz5TfBmCHto9U41
         ooPtttJNpHS3Nxy8czzz6DMHYX+6Ic12lWRbWJObsIZOhWi1jeFCM7mwsCWZ/StsQcH5
         s/Fkrz3cgeZ8m99ipuJIol3hd8XO7Gf/FEFB1/2apCgDgndHvU99KKHfG7+Hm68TTfqc
         u6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXBbnKorSztKPpWwciEJXTv04F1kDqfuEEK0W4U1AU0aTlYXJpm74wEflOolAEUB2pgcBHfNL4Q3cpQHek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02UoOPAPkfzfDj9OLicY+moLEh8HVNO9zFxjeB6KDXaBBJQtc
	hvR6YCFReR3Z29GAAI2XNsLt9cQHUW1br7qzfUfNm6SBbAZCRSn/vz2h87Mod5ml00w=
X-Gm-Gg: ASbGnctG7X+WsB2VxRgvqxKVEEWmFRjBNMrUabEVLHg1XdrSL1TfC8ad+bb4tCRfa8M
	MBuri4Up7DuyUCa2j9RoQdARLyGKSziycwYO32vp52vBL+RsrFCMEo87SMz3944buV3RCsm959I
	4Ww0/t/qZHpXvmEgcCC2emkp3Q7cEP/TAh+Kf5Uk2MUJbzFLUfQ9QC3kfsKGso+CVN6GUtmGCQj
	ChRoUBjYByFl1itAbB1ymhPEuy3foVllpYU9v3ePAj2kYIqPfSbHbghfAVWnjjI9kd5dhloHt2g
	8zdd8LUxgzaUzaI0IwSRGCPnD6jRqIojEulh4k6fP0FNjkQxBIV72emMQKpiUcpYhn8Q/542g0D
	oXbc2RhRX0MbKBLWnKhN90cgd6oUdd/RZRJ/ti0DJyfO26gZOpdP7wvaErkjwQpisJSUQS5FZBu
	S7F5NQtQa6AAuhpgmozEYpjwCUMU4=
X-Google-Smtp-Source: AGHT+IGPd+brTs/tr9uigSHWLaHZFIfinUl3f0FWfAgHyxWRy8RvOdRx08VMDoZTA6McwENXy6a00w==
X-Received: by 2002:a05:600c:458b:b0:46e:39da:1195 with SMTP id 5b1f17b1804b1-471178784d9mr183926935e9.3.1761227098250;
        Thu, 23 Oct 2025 06:44:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475caf152absm46879295e9.9.2025.10.23.06.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:44:57 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:44:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: dan.j.williams@intel.com
Cc: Ally Heev <allyheev@gmail.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hunter <david.hunter.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Message-ID: <aPoxVqxevopRpPu1@stanley.mountain>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch>

On Tue, Oct 21, 2025 at 09:43:28AM -0700, dan.j.williams@intel.com wrote:
> I would go futher and suggest that the pattern of:
> 
> 	type foo __free(free_foo) = NULL;
> 
> ...be made into a warning because that easily leads to situations where
> declaration order is out of sync with allocation order. I.e. can be made
> technically correct, but at a level of cleverness that undermines the
> benefit.

To be honest, I'm not sure what you're saying here...

I have written code like this.  There are 515 places which use this
format.  I think it would be a controversial change.

$ git grep __free | grep "= NULL"  | wc -l
515

regards,
dan carpenter


