Return-Path: <linux-kernel+bounces-786227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD3B356CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E53F17B0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395E2F99A9;
	Tue, 26 Aug 2025 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SR/wCl6v"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250B2F8BF8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196826; cv=none; b=mPRk/fHhDVPSiUx9ukZp+aB+n+0zuqmljCGRdSQkIaeIA8UCGCzkG9ZIqHy1GBTe1F0Sw6Jco0nUwAe0zpalSfCwaqFZNEfGkQBHTUN5sdKtXCJloQWGw7l0iDTlzRH21DPxAg19TfnwtxzaVt4Nt/GXHsiUTuBp3nO8zOsa8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196826; c=relaxed/simple;
	bh=CmOw9MM62MUmPOH9GRufRxbgMIWxnIxG8qJRDX5brlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKXDrXE/+Enl26ECkL3x8K6jy+rpczySzaM043EKahc9DtL8aUhGArucd6wU0KhJNyPqYXMe0WS4PLZSfHWyOyTWYvuNqNkYbBRa+mPYU6BKvCjbsAPMUx8MwzAwtUGigNZF1zdoEF+tmtBMmrlYqkbF3KZ3dQIo7fVC/H69oxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SR/wCl6v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24458272c00so62055985ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756196824; x=1756801624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VltlVNdXca1d/9EeoyeMXnoTiPVWJrYRgV1MAzlI0fQ=;
        b=SR/wCl6v2M7KXdsxchwPb1r6tpsOusoiJk7yPEzIw4pcdR3K/2NdcMpyNyrYgSdSB/
         Hf0j5sHxXtLBwI+4aZqOUqLjv2fKE5WJ6YnUi2Y2aEs/SzzeupKP+eLD2c+Cuz8+ODDb
         EP/Ki4RqhGkzLtBPURANsVXZ3mF1eHN3oVchtlVmJudKiP7yC/JE9IK3aQR7/EbgvSBY
         v5PUnDdVVBtcZQv376MXELz/9LklRqvm1CUK1IfSy2IqnUxQYkbmwaREKns9G6B920G7
         FWyCg1SaTAa7wE4IzctfZadTn8Rap6qGLQ/v4Y6wn5oFsS7k9CChQpUkb5BWe4zQf9Cu
         gb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196824; x=1756801624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VltlVNdXca1d/9EeoyeMXnoTiPVWJrYRgV1MAzlI0fQ=;
        b=XiytLp1kycpWLLqkvh78oANeIMH3i20fpkAJbELO7MGxPYjptsF1R76VfwqU78hYMv
         gN+osbhUM2/m+cQWy6WHN8QYl5V+EeynCjcdABN9Z0Cb84y6Tv7eBlKnMHiNR4ife9AM
         RLvO/ADMbyukP1NZCFf0XwQ7Dx9OTY4BEXwNYeCmBm1DA93Yx5Pz3WnIt/CAgezGSAVW
         8IXrhKCkCSyALOXezHNEpC+EbhfgH1bWwAH+7ZFRXk9MTXgvIkv/Bw8wdLNf/zDacJpW
         1XvEjj72Bo1spCUqRJH0taz14cmL020cKrDhPBvQb0cYmHSoiRxG2iiHka+wc3wK5qVi
         Zt+w==
X-Forwarded-Encrypted: i=1; AJvYcCWcK0dMKDo0kJfr4lJGQ9EBUZHRsyIH+QJ/A7NuRnW0NL+W7stRuBeorn/hr+N/h6LALKZoz2E7sO5ePMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGgTUQROG9YaWZVv5l2IBbxe7YUdLVmk81NutX8wXXuI307Er
	h2vRpvi9VtTEZEeX3euJRoMvschXTIEaAgsnXEFrdnswBqiXFUczzVU61eTnejpIaWc=
X-Gm-Gg: ASbGnctzcNfyiM9tRVb+yOYu2h7H6pmjp58zVVnxvcKpa/JV8QRgnYskU4OgFLz423h
	z7jeXRBi6r5LuR5OjfYxGcugO5+1J3vSHE186St5NZWNRe+WB7ADOhL+q92nkcaC2fIbOnE9lkM
	RWOqz4sjd6HKkWGp5g7vn5R+GjIK4N+zy6KHlI9dZxxZjyGbWwvJYQMcqQ+I2f4x3JmYmqvRcfS
	i1SsbP4v+Tp9Za0sThrXGvhjLPdN1nCVGbAayTxx5YA1JNamwv7kGpA4E2DR4lFPVG5Z1w/+9r/
	txkZrG1vukNf+chqNWwZpSbkycPXdIvigGm//IgWpdfvGjRcjMoBWb+s7pccZBA8pT4AqvcuKYc
	khISFauhqH+F9rvG1e/vVAxUR
X-Google-Smtp-Source: AGHT+IECSU/SDSD+0Cr5TrycnubLdgbitEMB4/KAzano/y2obaZMbKPJEOdIDdWn74RnHNtuJKk8kA==
X-Received: by 2002:a17:903:1b65:b0:246:b1fd:2968 with SMTP id d9443c01a7336-246b1fd2ab8mr81877715ad.9.1756196824113;
        Tue, 26 Aug 2025 01:27:04 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm89224405ad.122.2025.08.26.01.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:27:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:57:01 +0530
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
Message-ID: <20250826082701.tv56zzg2hdavy6lq@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com>
 <20250826052057.lkfvc5njhape56me@vireshk-i7>
 <20250826053606.zktmwgfdwymizv6k@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826053606.zktmwgfdwymizv6k@vireshk-i7>

On 26-08-25, 11:06, Viresh Kumar wrote:
> Can you help me testing this over your failing branch please ?
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 81fb7dd7f323..5b24255733b5 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -554,10 +554,10 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
>         list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
>                 if (temp_opp->available == available) {
>                         if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
> -                               *key = read(opp, index);
> -
> -                               /* Increment the reference count of OPP */
> -                               dev_pm_opp_get(opp);
> +                               if (!IS_ERR(opp)) {
> +                                       *key = read(opp, index);
> +                                       dev_pm_opp_get(opp);
> +                               }

There are other issues too, dropping the patch. Thanks.

-- 
viresh

