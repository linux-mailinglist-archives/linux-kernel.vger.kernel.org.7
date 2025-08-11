Return-Path: <linux-kernel+bounces-761944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F219EB2003A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E52E18971FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3932D94BF;
	Mon, 11 Aug 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4UAMsaU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0E1EDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897104; cv=none; b=WOoiSgNZ4jBZUqYJcnCLRryA73wgC9dOr0wu0V622924OfzHL6BvJHLhZhDZdqD7Plzbex9VKkEiavMbBIuk85A18oTaehcTsYbqXF+iijXZ7r8RLHsY9S9JwdwwwHZ3Hun+QCAXyoHyc5NvauXa+kxWDTMD2Pb85kaNfk/KJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897104; c=relaxed/simple;
	bh=e8CyaEUgWJ4j1JnU5yc37WRJh6h/2cyKWFRw7IVPnNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp7o7Uc6wdegaPNJDjOJ8xOtPmWQ9aXIVTYnSg3L4JktjW3ZJ9uIyFGhAsXOvQEg1Bs1InXcQElN6ikoPwT4cRAlC8S9lp2snaipnj+vPKhV/pmQUwiXIroSD8ysf4+CUKYZF1RRqw13hV9W3zTtJIgi/Xzt24qxmINv808PxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m4UAMsaU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458baf449cbso39350545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754897101; x=1755501901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzGb9ZqG3d+8wQpeXYT28daUSGt2U8W7JC3C7syv45w=;
        b=m4UAMsaULum1vVjIhiI88sEg9sUaepc9CMCsbWYySEAMv+MTiPdDB+BDdHUzZ3tVxv
         bAa5Jy8TzHtS6SXWrqp3yrhJyLEutXXEtJZLF6O+JXuWuy0516KigZ+5ioOvwwfp5xbG
         6hQEOex2Im+N8zKY08yNNr+v/BwrHbLKaWs6YIji5hIQ/jcKnkpm9HGvaWeNDLGe03ba
         3SaR+ODz5XkCbEbWWWBXY0hCttGKYw2b/s4v49qWFfpezd+9+T80Ah8wvtltcAcpbihk
         9OxA9pLePeZiC6KetfWiCp/m5gCMnFCES7PP9dKVeviwPIkz24AQ6Nv6gOJ4gBmLviK8
         3NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897101; x=1755501901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzGb9ZqG3d+8wQpeXYT28daUSGt2U8W7JC3C7syv45w=;
        b=nLvunAxbtSOhl3ZwgFn0hrIr8P2KtTV4tPBpjWAUFabEg4GDKnf+a8mnlT8GuO3yAG
         fQ7DGL21vfuClUh7HBVhFGfZR12DRQLjy9oJpebq8ygj7sxC7Rx/8MGosnWKJ/ABgRrm
         IFTadN+PPTPiWn88ekbCTay945yrZyHc94kJTtI1CT1j36a7T/acksA7c25mDtntz8Fj
         1fayB19CfN1Ms7eCDqLDR1r1xsRZuW0AwHj/4BQgXiKSgIv2JLOJDAxRfdr/5qA/qACa
         VyV7eyvmqFTBAcQwcoImaVFQ//EtP/B3DyE83NRPe38VbdapBQY/Ql2a5Fq/+8e+Jm9u
         UEqw==
X-Forwarded-Encrypted: i=1; AJvYcCXH9UNoZBGmm1qby/hG3qoFOp6xImKQczEfD4OeuIRkhHbTvPtuVsskOQG/pa4Pz6SBTdbmKxoA0mdU1Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMh5IrCtZbidr0evbOjbgcwHVZVLGkGwDH+qBHGO/kk0hvSbq
	0jv2A9NuFSR81Tn6wMC5mHESkQGU67UE6ahZ5m7o8E606d0zbj4adfH6QHrgHJXBT+4=
X-Gm-Gg: ASbGncs4+s9YbyzNZkJnJnPddMZ2KMhBQG1RzG9nauZSKxYr2ZfRyYswbpSQlXlIUwz
	aAuQmK32sYiApo8iBFBklQ8MQKRy8yDj8YkA7EoAGRm7sJuLXP6bOuvFd65w4mvA6T74LlH7Y5m
	PhQce+FZGU1uuYfgkUxod0G1Z4jSCOJOXPcBjzZB3m0pQGTscLmH2uPS5ieD9KAMFvz1DLdKhyT
	csAdT37rqG5byIpeD738NW+86tp/pqW9iXkkGgMhiWmvm5ThblZ4rGKatsaBIgDPHRMBuzrGJL1
	CZavlQYqD5eM3YKHA1FU662JpQT2A5D3SeKibNF7aS0MCM91GFW17MWyum5xWxRw3RpHYs1I/TN
	AbxR1Y3BvBurnratS4SLFGQsJUKM=
X-Google-Smtp-Source: AGHT+IFKQOtE0NygsopZPxVqufiOBC50hCPIgtqtyYeSPnhubJA/tyvIr2QT/4Gq+3noUbEjQTVGGA==
X-Received: by 2002:a05:600c:3508:b0:459:df48:3b19 with SMTP id 5b1f17b1804b1-459f4f9b87dmr108086235e9.18.1754897100694;
        Mon, 11 Aug 2025 00:25:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459eec47306sm180036005e9.28.2025.08.11.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:25:00 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:24:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yao-Wen Chang <changyaowen19980629@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] staging: rtl8723bs: Rename camelCase variables to
 snake_case
Message-ID: <aJmaycoFLHELApC0@stanley.mountain>
References: <20250811062132.102525-1-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811062132.102525-1-changyaowen19980629@gmail.com>

On Mon, Aug 11, 2025 at 02:21:24PM +0800, Yao-Wen Chang wrote:
> @@ -804,14 +804,14 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  {
>  	int ret = _SUCCESS;
>  	u8 *p;
> -	u8 *pHT_caps_ie = NULL;
> -	u8 *pHT_info_ie = NULL;
> +	u8 *p_HT_caps_ie = NULL;
> +	u8 *p_HT_info_ie = NULL;

The letter "p_" stands for pointer here.  We hate that kind of naming
scheme.

regards,
dan carpenter


