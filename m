Return-Path: <linux-kernel+bounces-867195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E889C01D93
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4488E3B9898
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F432E137;
	Thu, 23 Oct 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxf/SOFG"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C91DFDA1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230059; cv=none; b=PuFtQkJAQZBVvk9m82OVPwbvadsbp0Ub4XR0GbcP2lbva4h4w/uT9VuJBXyc+RmIBKughjWOEuTSUIH7DdJy40s3WpHOD7qNX30h2DVzI+Bk40FQqP1Ws+fMj0KSrSjTNJfdIZOpH6H2YyB7F/vbgxrtd7JeRZyNxUJ6ht0q5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230059; c=relaxed/simple;
	bh=/QeC+4KBQYT3wohYuPFOfqIAJyHO1wZV9UiHSECbF+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rgi68rbwUDeOl0Z0IWNNYGfltPT2cMYjRSqiPnhrqfySqgKMBWrDl2cuzBE1Wj84FChwYuqdsetvz1ii3TgvUIK/CsrRp8wfbbgcWBYdBui5HFRTnGkNnQuaKYv/tbhkcJCpHN0Vha9x/OkVuEaemGWm8uuN0w3zNvPCEtNoHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxf/SOFG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88e525f912fso96261885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230057; x=1761834857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ty8jqgEMWrkU/Nsac/whYt2eOAER5E6EFOQ1MIoYtJs=;
        b=Lxf/SOFGFAM7eVPDXAQhd1Enwft6Uq3rhsdzAfPR5okP8jkVsZfuBXe/cr2XbnZwI2
         0OIjUp+cHoHPceboKQtp3MgNMDgRa70y4km1HSv/HWELXd/yVrxVE7IxJMmc7zhhUmav
         FI7QjjX5odF40uyiNDRAmwSgAc3QQAt5A8io/k/X/UcfCGqtjH1xTu3W3JDeMoxsrhlV
         btWTclQZOrY64E6aC2jPzN8GE9QAsZdmcc3X0762pr1n3ohbAizhYbEcG2D6e+jX2YZ8
         a6yhxUJTzF/Wfsdr1DWU6HHf3VpVeXqQMnsOOqnILq1cL7o4eIF/WDhbAm49NCuQ7DiH
         6jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230057; x=1761834857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty8jqgEMWrkU/Nsac/whYt2eOAER5E6EFOQ1MIoYtJs=;
        b=oqtew7oqXmi+R/xtFOyRg8fyNGHRDRUm0Pxf4NVZYv+bqnDNi8BiFDdJhrnSBw2c0i
         1S+KtNn1E2lso8TcFMT5mMyjzPANDbvIYzXrWrtppfKtuWuTepSNLz1aRvp4ohuu+hx8
         mi7Cdpaqag0N3q8Nl5j72Vr6SvB1zP26BzbcIYRPnAOidqzkhTkvRIvfWBCXrPrO3VW1
         zHyTD8O3J4vL4GVWF5rMA01H1u9edfEtmq+LJPp9dSQp2a9JYfGTt2iNU7MQAgz3jVgS
         3xtv7mAnIhAarFKNOsIn56PjhZYZkjmpGV66WWPuW27cTo/uQltoPnW3k0gSxamQ10j+
         pWVg==
X-Forwarded-Encrypted: i=1; AJvYcCW2pHu8WGuapXmcFWYXURfjrrtBMeicxcnaRR26FknrKGEnNcWneIRpxi+vZ4seepuB+hsf4f/24TmoTyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtasu2+IUJg+19/4Q/LP3op5I80aNgDjA/7Fs9xec0xaNKRj8
	wSEjHUvy5SDoBRAiLemqODJeE31vC8PSUA7RJ+zYxN+pSaXTdcY7squP
X-Gm-Gg: ASbGnctsvRDtOVJSHrCNsqcRcSVAktYrYv3F1m9JKPZPFvwcjL0kJzTAWesnAyPnnLT
	FGSrGwvuAHvm9pDtRZ+CMNmcbe2qyU7OHq40bRsA3bbeOvMwVhn0fRKEKQ4cd2Nbs8dG11aOjgs
	rrpPe1rtDEziNORVCQkovcWjIp2wEHJ0VCmLieT7+vP8t6EuPoepDkiFrsafkN15qSFSgpn50Ca
	8wxi/0lfYgZeKpwBLAjRf/O8tgxXJZqsuKWx1WNXyIda3ZPV4K+bRWVqIUEtunVcNOXZZveRROu
	lWbf0XNv7fHE/c8Rb58dHdYAuBmKQSkpF+MxnZpwe99Oxpq/2kOMII+vCUOWl24oyHYdrOLKhRG
	lcgjJ+fTMXPpJqQw7had/PuJSie8UnDSDtBZtcsQiaHZUpvFFZtg14uwNi/E6x7XA1BLfC2zLOi
	gbg7x0gTObMVX1yxksTxEiN8cCzRKMzm8WQ5ZqdweAqg==
X-Google-Smtp-Source: AGHT+IFk6zsFnw4L+tiI4iBc7mZ7I1pnhPccFZ233koLT7AqMhpvx2+P+Rp5WpaB7Fl/vtbeBra1Bg==
X-Received: by 2002:a05:620a:4512:b0:892:5412:b742 with SMTP id af79cd13be357-89c11e630d8mr327291585a.55.1761230056821;
        Thu, 23 Oct 2025 07:34:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:6893:5f51:a77:210a? ([2620:10d:c091:500::5:8f1b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11698b74sm171117185a.30.2025.10.23.07.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:34:16 -0700 (PDT)
Message-ID: <ae217501-b1e0-4f85-a965-a99d1c44a55b@gmail.com>
Date: Thu, 23 Oct 2025 10:34:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via devlink
 params
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
 <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/23/25 8:18 AM, Jiri Pirko wrote:
> Wed, Oct 22, 2025 at 09:09:31PM +0200, daniel.zahka@gmail.com wrote:
>> swp_l4_csum_mode controls how L4 transmit checksums are computed when
>> using Software Parser (SWP) hints for header locations.
>>
>> Supported values:
>>   1. device_default: use device default setting.
> Is this different between devices/fw_versions?

That is what I presume. I believe the current setting for 
swp_l4_csum_mode is ultimately encoded in the capabilities advertised to 
the driver during initialization. For example, I am mostly interested in 
mlx5e_psp_init(), which depends on:

     if (!MLX5_CAP_ETH(mdev, swp_csum_l4_partial)) {
         mlx5_core_dbg(mdev, "SWP L4 partial checksum not supported\n");
         return 0;
     }

My guess is that "device_default" means that this bit would depend on 
the device/fw_version.

