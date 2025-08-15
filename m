Return-Path: <linux-kernel+bounces-770918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF44CB2806F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572931CC4357
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD63019DB;
	Fri, 15 Aug 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFRTSx5v"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA3221FBB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263646; cv=none; b=hKsN0424zRwWESck2LamJOMj+47/vbJbkSa2hCZ8bgK6FdSyZm+RIXJrpoeUWk5AxsjZFFi+WBYXveTYly80xNTlVxJVOgD9ftOTs01hT6he5jUXhYF6x/lQ5ToK68Q5b9xaBL7kgVwTzLiFZS5sgo1VkSvlnbSS2pYDXqvstgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263646; c=relaxed/simple;
	bh=aDTuk3M3dnlTn+CYUcvmx4uCcGqPjuQSOHcwS0mGbYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRjuTen7KxzUy3BmgGX1N1H87ZEjc+ABkkhCLLH596vcCzQVbkLaLHER6EvQvaChPVfhvnag7vrepmD6VTj7TM/tIxmzgOeMTj+C0g5zof3nFZWwIH7XA5+ITp297yngFoMuJkUaXYcXySspthZdHRVQvc0wFnGa6n8XTUee5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFRTSx5v; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a2534aecdso329315e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755263641; x=1755868441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWVd3a6QjlDIBu/GZcAsaGjfMi/nlIyITb4lz5jcIMk=;
        b=VFRTSx5vOjyiiu/sX3teVTJsO96X0avxm0h1/PiV6emeK31o9GKq3EJtJqURzYNkl4
         qOqUWT1og4tF9Q+XeKtvzBBT+kgQz/78/pFNDrSZvgNUQT7XuQib6zd76mKGE1Cck0IB
         /C42bIk6GyrE2Y54193qvnmbAc79hcHv+9GGBZUB4KQZrE9vIA+mCtHj9GoO+6gt2MRn
         adsHHQXl9h2xFuSsa3qv4WKoNEAJLAAdpk4xmiBmxQfamJLvImdwOUaDXE1Y60XYm0v9
         e329cM8Azc2gEqZVKzW+73gTKZ9J/IrcpdOOxyidAfFX3W02MSZLLHx3avUy1XKoKB4t
         brgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755263641; x=1755868441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWVd3a6QjlDIBu/GZcAsaGjfMi/nlIyITb4lz5jcIMk=;
        b=XanVNP82wFmLqrS4OCndsgglTYixmnYliN8xrD7gpPKf2/8SZWa4aDBsple5CAzlPh
         aH960oMiJi7IePu+vqCVbWMDeKdj1Plqq8i6GBHLBvD+oQnu4bxWMK5s0zVYIIHM7Er9
         4CYc222HBQ+uESMegt/ir9gukzA5lMD2YdfBuXFgoI8Gj4BKCXxPs0ASByZb9oU1mvvf
         +XsetExSHTbO2hdw64Srd1fJCPhuVZt3j7DunEwrP5F5Wq676Y4H8tlZ9HryKkrDG83j
         KxLGzaLCHd5wUE102a0AIh/oV47JnGjgz5D5SsDarwoqxrgbAOadCOJZXef11VZDEvcO
         lSpg==
X-Gm-Message-State: AOJu0Yzi5KVfhVN1QrLuWlMMvaLIzqHxHS/tkMXmMxbti/FNtCKmDgpf
	T3u8zfwRTbWw7iOD2dX+Zx2MzPCXYfkD5tdayiOttKsnJJQR+ksF0VaK8YKzybfrnQ4=
X-Gm-Gg: ASbGncv6EoKR/asB9z1B5R+XNdquIsOgXyRX9jef1Cra0ZJTOAbh6ICxECnKYFY2w1b
	CXozN3oEVabaplfPTytjZRvBBz8dYpuCd7K0KYLgiQT5MReFF6JeEtGaWAl5wILUxemlC55rHt+
	BCKM1QV3ip5tzYqKq9wIqKZ3hEB3sgh+kdgu6DULb1Dobv+jJ2b3nFMV5Hh+0PCN35WygG86hV/
	FKH9MTtG8t2T3XAGigf5LBrmlapkuMizubH1yzyF9jcecgls1+fLkHrzQPzjbi4M7ymrjNuFpSH
	y8TqeRfhe1p/yHhDFhp2dWRvcA6bKT6KiLo2qmql7Ie3Jyq0EPM0mKGhCFEqUfLlPp6yPoaJOoB
	DFv4nxBNmH53z673OTpt3UpY8uVk=
X-Google-Smtp-Source: AGHT+IEGkzA5H/8XCgBmKZzZLui8cTS/0lu1L381PDJX0bf2RM2IKP9iCXo6EURHpv4ew13E3k7NJA==
X-Received: by 2002:a05:600c:3502:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45a21859687mr19402065e9.14.1755263641313;
        Fri, 15 Aug 2025 06:14:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1b1d4212sm37507125e9.0.2025.08.15.06.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:14:00 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:13:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 3/8] firmware: arm_scmi: Refactor powercap domain layout
Message-ID: <aJ8ylY6jjS70z8lL@stanley.mountain>
References: <20250813114609.1305571-1-cristian.marussi@arm.com>
 <20250813114609.1305571-4-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813114609.1305571-4-cristian.marussi@arm.com>

On Wed, Aug 13, 2025 at 12:46:04PM +0100, Cristian Marussi wrote:
> @@ -486,7 +514,7 @@ static int scmi_powercap_xfer_pai_get(const struct scmi_protocol_handle *ph,
>  }
>  
>  static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
> -				 u32 domain_id, u32 *pai)
> +				 u32 domain_id, u32 cpl_id, u32 *pai)
>  {
>  	struct scmi_powercap_info *dom;
>  	struct powercap_info *pi = ph->get_priv(ph);
> @@ -495,8 +523,11 @@ static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
>  		return -EINVAL;
>  
>  	dom = pi->powercaps + domain_id;
> -	if (dom->fc_info && dom->fc_info[POWERCAP_FC_PAI].get_addr) {
> -		*pai = ioread32(dom->fc_info[POWERCAP_FC_PAI].get_addr);
> +	if (cpl_id > dom->num_cpli)

This gets fixed later in the series but it should be >=.

regards,
dan carpenter

> +		return -EINVAL;
> +
> +	if (dom->cpli[cpl_id].fc_info && dom->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].get_addr) {
> +		*pai = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].get_addr);
>  		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_PAI_GET,
>  				   domain_id, *pai, 0);
>  		return 0;


