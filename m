Return-Path: <linux-kernel+bounces-778220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B8B2E2B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9BE5A2379
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A278033437B;
	Wed, 20 Aug 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRQKINB6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB132A3D5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708826; cv=none; b=M5miFZ0BezFXIhGsrvGla1atsSIcKCR2vtV7SM7Sx6LYUSOtlXwvXijeZBs+Q0SNI3bCXc87usDU/Efz1/M32GJYbvs5j3X++xGByHbBYkacrIP5nJSfidVPggFYAnAG0/o0DXlKuLrd9PN6cbDMimkk/Zr5wLXmCIAinCT91vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708826; c=relaxed/simple;
	bh=YFh9tQlkjzT5yWM+TmV6WOeSwu9NitbNMXsAdBpXl6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCqdnzntd/Rtv56KXtCsA9aNVtGGbvcHbghU5gqb3yK6aP2ils+g/S1e9RdTy624mstgEUBXMJA6KY7TMq73BM25WFI8xHWUGinP9DBR8oET5zWvCZiqbhc3YqSMDtm6kkYeGf8YkZ5ZsIHd5Hydw+edpaoIVz7nu+IUQ9yI2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BRQKINB6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9e414ef53so84051f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755708822; x=1756313622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WpCvOUEy9gt+e1INXVvX+QS4u6BMKssFhZFYzWXcaY4=;
        b=BRQKINB6EYU/nvEofIbXMeVTiAR3hU2Qld1wLO1hHns/hq2ZrF8FDGoXgSg9j8HzDM
         Kh8pmP8NT34Sa3k8O9iyOVN9RRwjwwNR4aJKt7aK/oqcwHNdMpDtC1KUzOJ73rjMnH1P
         cvV5K2zdw6wOEsbnCPqlPm18N4S1mWvCEEn+lRbhM7YKS515xKmkrJrzry5KFGl3Af5X
         T12UcOZi9pGCcIVx0DqeNc4yGkmu3hlDDrjNRCTb4qPKyMSZmpgDre6Oni8E4qXuVCYt
         hazFXzj79iWiGI/lu46k7Cj++DZUsodiiramULzVjCCNP9ABzdGIfuh3OuJQMyPkEB4K
         nq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708822; x=1756313622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpCvOUEy9gt+e1INXVvX+QS4u6BMKssFhZFYzWXcaY4=;
        b=ZyXnksxieO9+24Jh3x4c1GnfX2and5wNPW3FPpRmess7BpYpZ5eEtACqGYDV0gS0iu
         YO2kor0zgOUTd/wgJB1h4u0cbnxFZZcIEZVmVcCi97rCkdW/XpPQAJaX+3VBA8EqXYpZ
         ucKcaCuTn9iGm/8i4GWtimrCgXzVE3Ceres421dmUU6K3fvR6Fx8i02h/fkIh2VeVGQK
         gui/aS1zFhiU9TscSIAf9gH3rJdVdOHzvhP9E1EtXorc2kp9X+3GFIQ+itGzIQWWKXNz
         pwIh6RHrfEfqzLjO2ALJEYw/tAaC+X8NrRNJtEed/Ea8xh3JB2jiyxsGfqRFj8yHu78U
         o5OA==
X-Forwarded-Encrypted: i=1; AJvYcCWqzGz8mwmRWxTuEMesgigTp1V/LKbmGd2yWocskmi73LjwkyNZUongmBuSfNGcxaIPhxo/WmilMpvY45Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdzlXWLVkO/Drimwuck9mSQD04juHLXWAIxkacjGVCxYRPAUJ
	rY4rmtiiGMdYs0XV2h0akwYCMi8VnIIgSEZzYcIPMSw9gW3iVvD/8DGglWrgsO/srEQ=
X-Gm-Gg: ASbGncvhW/QfIMHo1xvIeostEhBTI/cxXJyokGuKxgFgWzWY6fVlOmoSJdrk/cUJ9YI
	61GaBbTDz8e0WxPC/WEHRuBD6hfl3xbN2Lx/GRripQ4Yi8FcYB/0AzCVQrmtZYX4Ywjyad8foCq
	/rJPAHtX9MEuHLsFHnJUH675kh6l9heUmFUxaou0ohNJkO72SQrL1USHgCZCv0s044Q/wKqffvf
	4INDpn4vUbOEqEwQ6VdxOWEyuaiknEVdQ7/rw9yUICzI4PW3v5zjrTeZlk+Y5Dt6hSxh1pdVB6N
	kW7nrPnRpNfFGZL16pW+MfzggVTpoB0fQ4Wey9EDAyOy2LeXNwamw+oI6+ptrOP5sL/7/9D8pwS
	jfN//0Xg5GD6vWec3P4FinFEWawmaBi7yaHQ=
X-Google-Smtp-Source: AGHT+IGB0p+aULag9mfdU8eRn3hjRaFkMxyv9kzuYWAqcbOyx1VfevBG2Noz2dFjBb5RNTesRx0DXg==
X-Received: by 2002:a05:6000:4308:b0:3b7:994b:8438 with SMTP id ffacd0b85a97d-3c32e709bd2mr2518257f8f.46.1755708822180;
        Wed, 20 Aug 2025 09:53:42 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:d9eb:6295:cf25:b839])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788b39sm8447524f8f.47.2025.08.20.09.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:53:41 -0700 (PDT)
Date: Wed, 20 Aug 2025 18:53:36 +0200
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
Message-ID: <aKX9kO5eHUp40oRj@linaro.org>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-7-mukesh.ojha@oss.qualcomm.com>
 <aKWDXySSt57tXHVP@linaro.org>
 <20250820151822.6cmowxfsheqxfrnb@hu-mojha-hyd.qualcomm.com>
 <20250820163250.hszey3i2gtd3o2i6@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820163250.hszey3i2gtd3o2i6@hu-mojha-hyd.qualcomm.com>

On Wed, Aug 20, 2025 at 10:02:50PM +0530, Mukesh Ojha wrote:
> On Wed, Aug 20, 2025 at 08:48:22PM +0530, Mukesh Ojha wrote:
> > On Wed, Aug 20, 2025 at 10:12:15AM +0200, Stephan Gerhold wrote:
> > > On Tue, Aug 19, 2025 at 10:24:41PM +0530, Mukesh Ojha wrote:
> > > > The resource table data structure has traditionally been associated with
> > > > the remoteproc framework, where the resource table is included as a
> > > > section within the remote processor firmware binary. However, it is also
> > > > possible to obtain the resource table through other means—such as from a
> > > > reserved memory region populated by the boot firmware, statically
> > > > maintained driver data, or via a secure SMC call—when it is not embedded
> > > > in the firmware.
> > > > 
> > > > There are multiple Qualcomm remote processors (e.g., Venus, Iris, GPU,
> > > > etc.) in the upstream kernel that do not use the remoteproc framework to
> > > > manage their lifecycle for various reasons.
> > > > 
> > > > When Linux is running at EL2, similar to the Qualcomm PAS driver
> > > > (qcom_q6v5_pas.c), client drivers for subsystems like video and GPU may
> > > > also want to use the resource table SMC call to retrieve and map
> > > > resources before they are used by the remote processor.
> > > > 
> > > 
> > > All the examples you give here (Venus/Iris, GPU) have some sort of EL2
> > > support already for older platforms:
> > 
> > Example was taken from perspective of remote processor life-cycle management.
> > You are right they have worked before in non-secure way for Chrome.
> > 
> > > 
> > >  - For GPU, we just skip loading the ZAP shader and access the protected
> > >    registers directly. I would expect the ZAP shader does effectively
> > >    the same, perhaps with some additional handling for secure mode. Is
> > >    this even a real remote processor that has a separate IOMMU domain?
> > > 
> > 
> > I don't think it is the case and think the same that they can skip
> > loading and Hence, I have not yet added support for it.
> > 
> > Will check internally before doing anything on GPU.
> > 
> > >  - For Venus/Iris, there is code upstream similar to your PATCH 11/11
> > >    that maps the firmware with the IOMMU (but invokes reset directly
> > >    using the registers, without using PAS). There is no resource table
> > >    used for that either, so at least all Venus/Iris versions so far
> > >    apparently had no need for any mappings aside from the firmware
> > >    binary.
> > 
> > You are absolutely right
> > 
> > > 
> > > I understand that you want to continue using PAS for these, but I'm a
> > > bit confused what kind of mappings we would expect to have in the
> > > resource table for video and GPU. Could you give an example?
> > 
> > We have some debug hw tracing available for video for lemans, which is
> > optional However, I believe infra is good to have incase we need some
> > required resources to be map for Video to work for a SoC.
> > 
> > > 
> > > Thanks,
> > > Stephan
> > 
> > -- 
> > -Mukesh Ojha
> 
> Since I am not subscribed to any of the mailing lists to which this
> series was sent, I am not receiving emails from the list. As a result,
> your recent messages did not reach my inbox. Additionally, it seems your
> reply inadvertently removed me from the To-list.
> 
> 
> https://lore.kernel.org/lkml/aKXqSU-487b6Je2B@linaro.org/
> 
> https://lore.kernel.org/lkml/aKXQAoXZyR6SRPAA@linaro.org/
> 

Indeed, but I don't think this is my fault: You have a strange
"Mail-Followup-To:" list in the email header of your reply [1] and my
email client honors it when I press "group reply". Your email client or
server seems to produce this header without including you in the follow
up list, as if you don't want to receive any replies. :-)

I fixed it up manually this time, but perhaps you should look into the
source of this weird header in your replies, I'm probably not the only
person using mutt and just hitting "group reply" all the time ...

Stephan

[1]: https://lore.kernel.org/linux-arm-msm/20250820163250.hszey3i2gtd3o2i6@hu-mojha-hyd.qualcomm.com/raw

