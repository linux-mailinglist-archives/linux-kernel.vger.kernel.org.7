Return-Path: <linux-kernel+bounces-778094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88751B2E141
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B0F176E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FEC223322;
	Wed, 20 Aug 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfmCwaWy"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572BA36CDED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703890; cv=none; b=L1DNFZD6Kfy/IdHEkluP+ch436vXVbVYLX5KDI9+PCnAkRRgsC5tMJh0B3H1gbtaiEgZ4cdXrJqpHChUQKt8NIRb0G+S0/gBCqa7lc+Urri7WqyhQfJwxjRMjVbOXyJlRHXRQISOjANNG8QM0ji19s78enXV41TWQsOjt9bg2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703890; c=relaxed/simple;
	bh=qJmN7kIaBiDpEn9+ld3jsBe/j1DtCdZXbIRHnPsu52U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz6REE3lVbLn3hH9P0Vvtms/lQTdmuZHxn4S/fQY/DJ/2dyoQ6MDRWCe2qQ5TRgZbJM478kQPDwMaNOAn6yBYUrITxSTMBfI3+6RAnMaDr9mX8Fd2vItL/esqn9E6JK0lxj+aGRe01VjK0uL4ngjYPVpJCmXv3BcfFnAsO0f8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AfmCwaWy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e414252dso22600f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755703886; x=1756308686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzqjecvcjM5mA1QnPXvB2YqRcxPwKlC0jZ1qJk3Y19E=;
        b=AfmCwaWyZ+R0XgZj2+N8/A/xtLh6FjP6f4WvVwBhEcdP8KC+2nIqXEkWmisYor7H0Z
         P6XAP3+0ydWfLEd+O8Ys/muhJLdsb0ckmD2HdM6MKfeV0cW+/jlaUepX84IF+Rg3PyxG
         dKrdhhBE01EezdMNEUMK0yYrhmKvgUvMRddwgg5SQtcCoA9MZAU+M5naXQrkxjR0PvE4
         z6O2GIIBqw08ExzS9sBVPsYKxm5G9+uRnSTn/Sb3D1W8SPRZakcK+9DJDjypPH8mBdmW
         sIaI0DtHutC5G3mPQxQOg0zQWVf0fpQFagF4WIVEuXZed+jUavI6KtCir6Vv56FmoSVa
         imHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703886; x=1756308686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzqjecvcjM5mA1QnPXvB2YqRcxPwKlC0jZ1qJk3Y19E=;
        b=Fxr+Po1zUscyIcvuoMxbAXphpj+nQr95k+EHcgenOG0VuHNNgwCOrGvijc+qHq6OZn
         WoQ29Pn7OTrOd3BvROY+JNa/WP2u+eNVw5lF3d3CUWMnQslVyZF0Ut41FoVtZJ+YbwOQ
         yuzgAVYI+hWnLWcCWhbQwS/5Bn/j8S5E2SzjgNJ0DIua5cjP6aoDNpiT5cUulpNWtejw
         EQZeijOk0CkmnHXhhjFjlJdtsn0flg4MZsyRUAiLap3BUVnBpxC8iwN4LIbpN9vx9Dkd
         WhG2hGfbOz3oF9DMuR6d0cX3DePHXpxmqHHvgGfOkAfM3qw3qDRfI6o5BY7quyRnQABI
         4AKw==
X-Forwarded-Encrypted: i=1; AJvYcCXZRx23RdfeAjuZsSqzXVxeKN6zDFVmMOkKIIVSohLgmyLQ4ja7kvSOGK7Sa3mgptykyC2bTkjv0ehmb/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDebNtvsN66gZZ9/2iIO637K9/GbV05YTaFXSrwQifdzA4c0C8
	6QpwWRPmHhuzEECTKHCLybl9SBptdWio2VFvWQn+ePnFqjGtYv9GNE0eG7bVoUKClxo=
X-Gm-Gg: ASbGncvNv8WXV+NfmR6DTxSU0Sl31owWmHULjE310IWvw1aFY8XcOjW2iHGe0yJXrAP
	l7jOPVPr3IkuUPQeNjZaSlPcD3S0BYroxcBBZYO2MSWi3KhtsMIvXz9q/pHZOm1sC8f07PdUfQY
	T70ndCqFimd03qCO0V1L0mKE10S2T43npH60CDrbqHnV+e8SC0KfOQpzsRKTbbgTIwvF2a4UUN6
	edVa9byz5iLak/oBEoXTdkqA5Tju8r8S387JpzzLhmWHlFHlkqS9vSRlJfE9Kcgyf8CvRpOFbFZ
	QYs+IBxPh0E1ceo1vKrAEM0V3GFVZdbPlRIReAQZqkHl20tbceT9P+yBtPOpeH8I2KNmf7QSVIV
	XwJZ532MPi1YX6e79LDC1hbKOJgT/jZMpuOwM7RixtLpi7A==
X-Google-Smtp-Source: AGHT+IE4T3vY+puKqxGjG4X7XDJYT7z1Ltxe4/gOKPnjv/zWlcl1JE04RbAJZfYJjhbRaovEv1kUCg==
X-Received: by 2002:a05:6000:2c07:b0:3b9:2960:bf92 with SMTP id ffacd0b85a97d-3c328efe064mr2441811f8f.0.1755703886390;
        Wed, 20 Aug 2025 08:31:26 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:d9eb:6295:cf25:b839])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c49fe4b6sm2083836f8f.65.2025.08.20.08.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:31:25 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:31:21 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 06/11] remoteproc: Move resource table data structure
 to its own header
Message-ID: <aKXqSU-487b6Je2B@linaro.org>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-7-mukesh.ojha@oss.qualcomm.com>
 <aKWDXySSt57tXHVP@linaro.org>
 <20250820151822.6cmowxfsheqxfrnb@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820151822.6cmowxfsheqxfrnb@hu-mojha-hyd.qualcomm.com>

On Wed, Aug 20, 2025 at 08:48:22PM +0530, Mukesh Ojha wrote:
> On Wed, Aug 20, 2025 at 10:12:15AM +0200, Stephan Gerhold wrote:
> > On Tue, Aug 19, 2025 at 10:24:41PM +0530, Mukesh Ojha wrote:
> > > The resource table data structure has traditionally been associated with
> > > the remoteproc framework, where the resource table is included as a
> > > section within the remote processor firmware binary. However, it is also
> > > possible to obtain the resource table through other means—such as from a
> > > reserved memory region populated by the boot firmware, statically
> > > maintained driver data, or via a secure SMC call—when it is not embedded
> > > in the firmware.
> > > 
> > > There are multiple Qualcomm remote processors (e.g., Venus, Iris, GPU,
> > > etc.) in the upstream kernel that do not use the remoteproc framework to
> > > manage their lifecycle for various reasons.
> > > 
> > > When Linux is running at EL2, similar to the Qualcomm PAS driver
> > > (qcom_q6v5_pas.c), client drivers for subsystems like video and GPU may
> > > also want to use the resource table SMC call to retrieve and map
> > > resources before they are used by the remote processor.
> > > 
> > 
> > All the examples you give here (Venus/Iris, GPU) have some sort of EL2
> > support already for older platforms:
> 
> Example was taken from perspective of remote processor life-cycle management.
> You are right they have worked before in non-secure way for Chrome.
> 
> > 
> >  - For GPU, we just skip loading the ZAP shader and access the protected
> >    registers directly. I would expect the ZAP shader does effectively
> >    the same, perhaps with some additional handling for secure mode. Is
> >    this even a real remote processor that has a separate IOMMU domain?
> > 
> 
> I don't think it is the case and think the same that they can skip
> loading and Hence, I have not yet added support for it.
> 
> Will check internally before doing anything on GPU.
> 
> >  - For Venus/Iris, there is code upstream similar to your PATCH 11/11
> >    that maps the firmware with the IOMMU (but invokes reset directly
> >    using the registers, without using PAS). There is no resource table
> >    used for that either, so at least all Venus/Iris versions so far
> >    apparently had no need for any mappings aside from the firmware
> >    binary.
> 
> You are absolutely right
> 
> > 
> > I understand that you want to continue using PAS for these, but I'm a
> > bit confused what kind of mappings we would expect to have in the
> > resource table for video and GPU. Could you give an example?
> 
> We have some debug hw tracing available for video for lemans, which is
> optional However, I believe infra is good to have incase we need some
> required resources to be map for Video to work for a SoC.
> 

Thanks for the clarification.

Personally, I'm a bit concerned about the code duplication in PATCH
08/11, I think parsing the resource table should ideally be code shared
between the remoteproc subsystem and whereever else you need it. The way
you parse it and handle the IOMMU mappings is largely the same, you just
don't support all of the resource table functionality. Have you checked
if sharing the code would be feasible?

If there is no upstream requirement for this right now, you might want
to consider handling this in a follow up series, after you get the
required functionality in. This would reduce the amount of changes in
your series quite a bit.

Thanks,
Stephan

