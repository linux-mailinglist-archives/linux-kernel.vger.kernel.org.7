Return-Path: <linux-kernel+bounces-777142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE65B2D5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB510A022F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4602D94B5;
	Wed, 20 Aug 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDttB39v"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC642D94AD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677545; cv=none; b=baDy4nVwdSEve5hIC4DRGtpaZL9td1LX/7cCS3GzkrpTmap7a0iYteVoyIP/1t1ZyEOeYR7O/ULLWjOb74cf3NajduOyFPKewJ53QUe/cSIZ+rvzZuhfMeggrqhISzrz1RxhMKmfI9SEMCZmlBeG1MtZCPE/QO74lsMtNKgB6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677545; c=relaxed/simple;
	bh=haxIZUSQiCuxxydJqegXR7kmgNO/8Jz418zQVwNhZdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4fvSG/8jD2qbDE/UstFhIv+o4BDAKIMXEFLtzhGMYYdGaQsifq8OJv5bhIN4+u69inBr+6ZR0JlFSQ/mDMxCos0ThquMD+tEj8teIHOly04T/pLDBC0eMW4kVJHjJGySE764RTcOBme0QaxaZAFyn4trfeMOfuotxBQc1jVTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDttB39v; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3bb2fb3a48aso2415589f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755677541; x=1756282341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E5mzBsBALiqNSttAJPi9ae9mbcrxgDyj2N9OaXqec04=;
        b=TDttB39vNVgcDXMCRMXQZAUW/dW3b/aSOKOuWiHfEP9caMeZMOHGWFBxYOV8VLkpql
         3jzUn+17e4VwsDQ4cO3Upaemjb9dksdjVTDDBcwmok+Hs6aU1qmFfMDhmDXySqsdBj0A
         v++5HywKPNDRMU6GUMaA41QFD2IFmSfdifuVhQG2tkbraEN+6B0V+qglulxa2oDh78/5
         NRtl9Fk8hIidRXGADTiO6+a5sWfcDXvi/PvUZb9anF++AKsqmUx8o6BThyhCDrQzOj5Z
         YB7vWN2W/DXiWClPPtMrOPZmqE24vik2J1fV74Q2taxaKAkcOlCkUYH+/g4HK1Ov1Eq+
         coRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677541; x=1756282341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5mzBsBALiqNSttAJPi9ae9mbcrxgDyj2N9OaXqec04=;
        b=IBJR+3YuU9r1gvymREMD4B06rG4C3y9Lx0r+cukch8FlIJd/PLc4mHPMcV5nuqP/S1
         EwzHeIcDVGlyttnRWamgNm+MoinlhR42uJ31rccl6QtblPaa82osWkxa6zmHmOmIc58i
         QoAPCBt7BY+6LO+ZHYDJowFe9Jme2mCkzzJXQbifBRQfkYnREP40IxueLJHJxHNU8fwP
         9mw9go/RfpG+yo6s53B1o+sFXZPsaTpmHL0h2Fq7TZWm1zOPM63T61a3QGXyGYaiXlx2
         VaUtCCSN7FL03t8xt1/1KmPOEz+1xSFwPKDZKbxrted1IeZzCDjVmLVYeV626fMwha54
         3vWw==
X-Forwarded-Encrypted: i=1; AJvYcCWqILrDTsI6avA7eTWV8eb2TDFjx5izqEVFIRrz1Wzh8LxNxx9L2csxl2gcZe6JAwwmT8UPnSZlvKoTLpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrXF+L/FCRgODI8yHu4gZ4AC4b6jcdudVa2R0wDIeWpenu3Vk
	vCLQ87m126lIatJqbgOmbjJGtInCHnZ0JaRebEEqTEBUQuQvcuYfqNFHoA1fPRaeJzY=
X-Gm-Gg: ASbGnctmnmgID8NQxh7iySRN16oqKPcMOqYjnMRLsLNrganU3hwnQat12HIQOfscYiw
	CYG70mWCYyTWBeJQsT0JYc/GMK2azumPO53FBB90K+0rPWJprYv2fy2msdBwPO2hFQFP9wwb0od
	9c3qVKwN5zYtyLvfhebWyBgmN3U6f0v7r2G0eMNhEfM2wAcX2o3EW7wTibgyPDLCZG3pF2sadJ6
	trnk7Ikp3JXECgJ5Pk5QwRU/PzuxzhKIqOf618YTzShuQt5d+ti287y9hS8EN2gbPcrO/b+VHxf
	AWpjPJbsv6r4/dKh1chEi45jYpAk9Bf5ypE6WuiyeEJq1eM9Bp2QCYSQcm9AUYEp1tWk74q6Bet
	z/Kv/qnMdDaJLAnWPyBSbAMnS9HT2br9SDno=
X-Google-Smtp-Source: AGHT+IGuQH165HnaQTwksDDzZkNVZOjiFfhmMoSOhDlESgJ7dUKSOkqF1KC3ciNT1El2t1RjmBhg+A==
X-Received: by 2002:a05:6000:2404:b0:3b9:1697:75f0 with SMTP id ffacd0b85a97d-3c32eccda13mr1347315f8f.56.1755677541336;
        Wed, 20 Aug 2025 01:12:21 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:8a2d:c0da:b2f2:1f41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c57aa0sm6687179f8f.66.2025.08.20.01.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:12:20 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:12:15 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <aKWDXySSt57tXHVP@linaro.org>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-7-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819165447.4149674-7-mukesh.ojha@oss.qualcomm.com>

On Tue, Aug 19, 2025 at 10:24:41PM +0530, Mukesh Ojha wrote:
> The resource table data structure has traditionally been associated with
> the remoteproc framework, where the resource table is included as a
> section within the remote processor firmware binary. However, it is also
> possible to obtain the resource table through other means—such as from a
> reserved memory region populated by the boot firmware, statically
> maintained driver data, or via a secure SMC call—when it is not embedded
> in the firmware.
> 
> There are multiple Qualcomm remote processors (e.g., Venus, Iris, GPU,
> etc.) in the upstream kernel that do not use the remoteproc framework to
> manage their lifecycle for various reasons.
> 
> When Linux is running at EL2, similar to the Qualcomm PAS driver
> (qcom_q6v5_pas.c), client drivers for subsystems like video and GPU may
> also want to use the resource table SMC call to retrieve and map
> resources before they are used by the remote processor.
> 

All the examples you give here (Venus/Iris, GPU) have some sort of EL2
support already for older platforms:

 - For GPU, we just skip loading the ZAP shader and access the protected
   registers directly. I would expect the ZAP shader does effectively
   the same, perhaps with some additional handling for secure mode. Is
   this even a real remote processor that has a separate IOMMU domain?

 - For Venus/Iris, there is code upstream similar to your PATCH 11/11
   that maps the firmware with the IOMMU (but invokes reset directly
   using the registers, without using PAS). There is no resource table
   used for that either, so at least all Venus/Iris versions so far
   apparently had no need for any mappings aside from the firmware
   binary.

I understand that you want to continue using PAS for these, but I'm a
bit confused what kind of mappings we would expect to have in the
resource table for video and GPU. Could you give an example?

Thanks,
Stephan

