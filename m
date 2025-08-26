Return-Path: <linux-kernel+bounces-785991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E4B35340
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19F417CF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D62ECE95;
	Tue, 26 Aug 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFrwg4aT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CF2EA163
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185662; cv=none; b=mz9p+ZMvKUHYON6BPxD4gZE5c5lAJSXyfMl+3TjJ3nhIUonMX9tnyTuKy4pPPii9h2DFr7Ry9vTWlP7H1UZtr7yMUSUGpnwLAAd66Nc0S/fvacMxZ9m0+ym+6LETlOjjK5Sm29j32qryiHg5XRKA9rR/1jSlbZpVIzMurvcAQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185662; c=relaxed/simple;
	bh=aIPBcehRTHMhS7LOo60VzOIm/87AhQ2tPcpYJepNTtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZF7ebi7ptWRmgZDngs58oQrXwG04aIOkeOmC+nLTX8lTXWQirS12KXBg37tgsYT420rga0aMkH5jRsEuEl6Oq0jH27jxiDRBi9rESqdGACNyuXyhnA6OSmAtpf8FO3qwbrUHUhh+nKBsm/hRHG2rYJvFbK742m0WyGVvYEGc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xFrwg4aT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458272c00so60471495ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756185660; x=1756790460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQkGqssK21pQr0XMzzCAObXVWJZEVAYglXp51ZgH4lk=;
        b=xFrwg4aTcXQXaEzsr4tHJrjJ+j91Pi77+H/C1zcA/SIthiaWoj85wZEVqgDMbwHgmJ
         IppXzB4DBR1JbQmww+nNvvIWEDvBrIUTQAW3Wj9u6mAa8f7omodTPmOGQXLx16ZgiGht
         /PxJj6mqrT8TQRQBmeMnIH/id7IMrBiKFuvV4LS9Ps0GvPt5mGWWWXXIyJRoMtDrcP6M
         dKSvQ3c+1Vj4qNJBze0VMAZVZBL01Hf0UjfK6E97XTAtVk7YVq/a4dJL3NptTA+zQcuK
         payJpvAB4Z3MKLaAKnxlUqcqLrAB1kk+FDuAFC3VjGft/wO1IvTe9SLzUyyUaA3IyhM8
         JHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756185660; x=1756790460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQkGqssK21pQr0XMzzCAObXVWJZEVAYglXp51ZgH4lk=;
        b=KEfYpkCox4neLtD9xnMu0/dW2nl3OKj7BXAOv+BV/lVrDmeyG1Repdf4OQnnJMCrXF
         ofoWF5p2m9QIKijsFz99WjgpQhQ3ZBwouxRVfybyt8k6x6rbc63uPy0rfwtfIle40k6K
         n/qCpmMpdypBNth+EReoFoPOdeXI5go8obDvg+AKkKP92dExx0ThVDnPyTXsMPsFwg/v
         vKn72UI+5nzaIa6eeEz9RMPJPcjsZkgXhA41Bxnhe03RqtZ4Bmuf5RC+g9/zPiKiFrDp
         830Pt0Wsh2EN7elv4NDFJWK7eotB2IyhW6SYMJIm7wTy1QH/h89Skh5sUdAaKJ4wEtqu
         qE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUp+0DCXOp8dAFZG15P6gpkh3alyelhUMPJIMkpc71a2n8otHTAjQJsBH+3rMNkwRPrLs3wECLIGdKyaxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFRrtkNCSOI7nkz5Go+xADUpJlzl18z8ZnWgswjNlKKJ+poxA
	V/cLzcqTWDzeeQH28FHUTGGIJRlcIt8f2hLoJMp1y5IO8LRZT8Pj8b2/bjvcgUuWqg4=
X-Gm-Gg: ASbGncsMWB7IYqFiurRveIgrSlIPdgzCi+WUXDGClr8TIjPT0mrCAdWrv8mgI5FP/TE
	c/pqpX1sL3dr+BpTUOPQnY7JqoYIq8ss+AgKdcL2NPnKcXDNCTWa6q6QAZh1YvaVskaW3Rs/SPg
	LMtWIKuaGMvK4v3p7M5sV3RQdju5Hl+TcvfKxeNCdVOdUR1LCTF+ZSyjEClO/peabJy5Hp89UU8
	/ezm4pmpW+l2bDsqLljYJffiYolcmb4DbbJbfQYZdZQ24hNI6VIJTQM9xCwrMGhPv1BCY7d3DuD
	70KMx0BvbfSs/TqyhnFyDfl+y4riW8mQsIheMXZ6AiFBRX0H4dN4RLSi1fIT+WTobi16faoo2Cf
	Dhs4uqARKO6ZovZNEbtGsUcjo
X-Google-Smtp-Source: AGHT+IHe5l009rsfaROaNNzxh1bua4+CVjBZVITdGInBHZIhPXAoVt/QHjtqxorzaIQf91LXagZQuQ==
X-Received: by 2002:a17:903:41cc:b0:246:b351:36a3 with SMTP id d9443c01a7336-246b3513841mr85148925ad.48.1756185660468;
        Mon, 25 Aug 2025 22:21:00 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779feesm84022375ad.34.2025.08.25.22.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 22:20:59 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:50:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] OPP: Add support to find OPP for a set of keys
Message-ID: <20250826052057.lkfvc5njhape56me@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com>

On 25-08-25, 22:14, Wasim Nazir wrote:
> Patch 2/7 is applied in linux-next (20250825) as commit
> b5323835f050 (OPP: Reorganize _opp_table_find_key()) which is causing
> regression on my board (lemans-evk (arm64)).
> Reverting the change is resolving the issue.
> 
> Kernel log:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000016
> ...
> Call trace:
>  _read_bw+0x0/0x10 (P)
>  _find_key+0xb8/0x194
>  dev_pm_opp_find_bw_floor+0x54/0x8c
>  bwmon_intr_thread+0x84/0x284 [icc_bwmon]
>  irq_thread_fn+0x2c/0xa8
>  irq_thread+0x174/0x334
>  kthread+0x134/0x208
>  ret_from_fork+0x10/0x20

Hmm, this happened because it is possible for the `opp` to be invalid
(error) even if `_compare_floor()` returned true, if the target key is
lower than the lowest freq of the table.

Dropped the patch for now anyway.

-- 
viresh

