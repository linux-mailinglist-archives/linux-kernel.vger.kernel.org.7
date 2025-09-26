Return-Path: <linux-kernel+bounces-833646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BDFBA28B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538A2626AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D327C150;
	Fri, 26 Sep 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPuJnlhX"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308BE1DC1AB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758868885; cv=none; b=Ue7mzcNXaNV05ELu8qUk0kZvSKGvaeWaHc7Wzw+odGQPMoTb4eYfCgqr9LNTLVbM0KDvzSmTaEP9sMnq3gIl/Kqz7TNU+767iHmgHRJqJs/vS/K02xizAmqF6hBZXCT9QhvvhozBJcvyzCEUNqKqXf9eE4157fFjorI4sn7lDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758868885; c=relaxed/simple;
	bh=uUAMECIXNIvOv86QPecXlecTiTn1dP75K3fLk2BLhWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDy7hiU0YMLWlikksY62mD0Bs/SXk8I+qFY3ksZDAMFBHPtthUq3fZr5WnMVl/EShj8YYv4F6uUY9fqwv4NyaF/jfycFdWKWCqx2lByApOZ9j5sO4FHVPMLgNEb6nXfoW61B9aERRN5mOpHGHYyTskBAEnVCTr06vnIgxjoRY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YPuJnlhX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so12001155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758868881; x=1759473681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eAXEhH9mCSkyuGynwGFcg/vSjwNz5p5yU5r7l9pKHs0=;
        b=YPuJnlhX7yIjxgjiogwF+jukcbvUHirAZzvNF6i6AHLGNu1+H2M/fFq8U54W1CQyKO
         77wFmffT1/brnGjxDbI+IpQgErvQ5X1m0a3z5Kb+5iSqKcl4NU0Dly4njLvyQ/GdITF/
         56iipAyNa3Z5Sowlbcv3M20ybusGGqzmnvfd165H43OIVjbN2KUuWfrCkvuhO+BnnsDm
         iFXmRFyfD6n59sEd8HpRJGCw/fzvlgW5G9qDVSWscyJ8PwjXXpwAK6IkI8xHanLcNtGr
         v0YhXL6pUJi9+Wa2ukgEX7kxLJ1Bu54p6AEPu3PXbrYntMlTJpjO9Xy2WKNSoWb83dFX
         rvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758868881; x=1759473681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAXEhH9mCSkyuGynwGFcg/vSjwNz5p5yU5r7l9pKHs0=;
        b=OkN+ll0tMtwj5KVGxjoOFW/1UIGIiOs1On/heM0hDpv6xJPZJ9vSFgFV7L5nzGJV1A
         DRakxm0FacarmxdvmTYbaVB4U+ZiuXRS1iEurehZNb58fn1j8e0d1iVF6oRIaq13VGgw
         fcFTOWLiUSUOL1/v4J5TeRKjJRYoHvCNgqdUkumzkkl08dBa7MKOVhaqfmKuRWGdsyrh
         VWEWOpG0Rlnc7y9jN7ZjE0t8EtjZdXR+fmL9bbWEpaA/o1mApOY1BYYQCsUfpyqMxKIa
         Bx/3enr8cZlVUcGuWy7GUns8qGSvZGUd2Luv81jc36jD9cJK02vMszEkKpko+NFlS8kL
         qYNA==
X-Forwarded-Encrypted: i=1; AJvYcCWQQ7sRkivcUUjvauBo7NvOhRP6Z9P6KAHLN7yeZYwEOtn0HC8S58xNJvvk0KthX1WqJWCoNmPQs2lSk94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEGJwfxreZ1V5YDKhoL0JqYmfGBe8zpntwMXwC1+waQDN/cDi
	qa7oefaqL6Qz3cy0H7xRtJHjTHNezuqMpFZCsO+psFvxmeM83DN0ML/4RbaI+T8+xiA=
X-Gm-Gg: ASbGnctptwglNuZkAoVMP2upkzv0I8oASMfP8d49X6tT8HdT9qBRDWeBx18W72IVbxd
	Fd/l5nR3DWGPM8OU3q1jTf5k6zVKqqHvHVu0H6FrGuzAgG25iOhSjvJALHsBI/pj+/PrgelDCJQ
	sl1niqEucaesm/bkTPV0Iyqy991bAAXr9jmnkDloQJJJmp1oCuT55/+mtOeXPaBGTWq6h6q6Q2K
	iCUKpKrzRXO/xE2CrDjJ2a1ljTnl86eOjKliEzeYoZnC3vc51ziUOTXyYR58S2B/2El4HpDCvoW
	DeJjNKXKFTeTq1W5JlVUPTNZnKpDkLdboBZxd7DZ7RMip+lHlO5HPVwh3bwDjtDgcTjEN9lB2EP
	KAurscyhAVY1ytkH3ukkXh2I/MGmBYx76
X-Google-Smtp-Source: AGHT+IEC51Z3oUc6PBQE26U0pANRwet5KzFeYNOAHSrBB1u4TiB+919unwkMAvmSkArm1PJoNLlhdA==
X-Received: by 2002:a05:600c:8418:b0:46e:39e1:fc27 with SMTP id 5b1f17b1804b1-46e39e1fd05mr21856915e9.5.1758868881334;
        Thu, 25 Sep 2025 23:41:21 -0700 (PDT)
Received: from linaro.org ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be359dsm59755235e9.13.2025.09.25.23.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:41:20 -0700 (PDT)
Date: Fri, 26 Sep 2025 09:41:19 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, 
	robh@kernel.org, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Message-ID: <27lkxf65evdhfdqzs3w6sfura6r3sewqsm6dr6qapvsjuwrirk@lwqs46vppei3>
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
 <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>

On 25-09-24 19:28:47, Wesley Cheng wrote:
> For SuperSpeed USB to work properly, there is a set of HW settings that
> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
> these settings follow the latest settings mentioned in the HW programming
> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
> new ways to define certain registers, such as the replacement of TXA/RXA
> and TXB/RXB register sets.  This was replaced with the LALB register set.
> 
> There are also some PHY init updates to modify the PCS MISC register space.
> Without these, the QMP PHY PLL locking fails.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 311 +++++++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.h       |   4 +

I think you dropped the v8 headers since v2.

Please make sure you add them back (maybe separate patches) in v4.

