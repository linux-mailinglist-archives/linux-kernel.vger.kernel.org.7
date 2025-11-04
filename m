Return-Path: <linux-kernel+bounces-885485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CC9C331AB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 219E34E5D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79621346799;
	Tue,  4 Nov 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqku7Np4"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA22BDC29
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293048; cv=none; b=dnVfi1ir4lagpMEAZRoNf4xo/fOrWNN/nT9oWnsQnlK1DjTZm2jTQjZucX7X9/b8FCJ9+URBOtYlF4sNxDhc4/mti4U4L1euN0n7ePbqUQoH4R6MNayAblq56Nizx/ZQspU2IQp+pZVEQ2wum7BuB60nWvOsCpbFA4nWy9a9j4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293048; c=relaxed/simple;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4DlT9wIn4/xl85EEBhjt1yP7y4vgYKfS76gy2yr0rtPiEVZytvT17QZ3x+Zt8MMx1q80Q5mX52b/WFvCq+7M8ccPcsgBFG9isukhujsRaz0KZQV1MP9C3UF1dV6lM3eKclHUZN09z1B5r7aguabqllaInGu37MXEGD46EOTuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqku7Np4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7817c2d909cso65292567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762293046; x=1762897846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=Aqku7Np4M3GiYMEVC6/y1m3DaYqoC9sjBswx/R9tyJyhGCCR4PJrwXe7ZNdEnQmsmJ
         RPyjyus2Sn+U0wza4DUmm0gbvclkOTXjTHOdrdJ93l2brwXzCiGqjFGsl80/0KKbaSBB
         K3UErB7SC/UcOeUphqdQtj4oTn74fD8gBlJvKNWSZx1vj5RjCel+1TgNIrqesb+6rjKL
         HbQ/fZHHoW/2dV3B7V3a42dN0wDxQMk5cDMr2ySyv23HUw0JGy1RRACZRGBgjU0OxnDn
         rG1WFHP+spZ/XmHICfuZwYh1z4cEmKOHUglYUQu3bNzRXe0J3gRb6gWg42GiMul246BK
         nB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762293046; x=1762897846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=EcuTw9UD3U9dGm8na/x+OaQcuh13tuoCbH1nm8S7GxlftLY164JMAtJuJEfs+TRlrL
         US1KAWgR8QvPmjoS8ncv87T+3ReoRkRXieavsHwgQnWOtHO7+Z0D0g1af/leRw0eRiB1
         FxBYGw431CgWToEm0LKfZDPreCNyFoDsrie0ma5vQkU1Pim5UboQXYt2PA8onFYRZ4ZM
         ftqK7u+FNQ799mH6Bmzj0m9X3sbUt4f8F3oGOz+QI6x5kpJho78syRtaoEGYWPIpTL1W
         +F8GAb9DsTivSDv0pWe+zBVwL2DEx9OTPjcLV3VKcEbEHP8f4QX8AKiK9PCq4gr3W3LD
         2vxg==
X-Gm-Message-State: AOJu0YxGw2kOaZIhfB9Iu9UVp/4jJtfgxQKGBw+lksxy2gJ8cml9NAhc
	lk6EDksR/6FK45L5HELVQg5vLtr07YnElmvnzF5J2Dk74BeG+ki4Bpcp3gu4rUDCAzu/EHO96MG
	en2Zr+SxLIE9RieMSln4yFbFW8Z5Ki6c=
X-Gm-Gg: ASbGnctohLdeHTa9guVidE4OI2jGGziETuiVzjx2M+ZYeNIWhVEXuUD1irvqeJe3xQ7
	TTnLtbfYmmWH84ubbyJY8PBHZ8WiHL30racbBoRcNUSh0OFACzX8MdtJgW12iV7OmQj2PGHeQXO
	tAYKQK0Ts9HUT5c0GiK3tbIzkEk4JR8yRDE2rv/AxjqJbDkd11H7w4P5uM430TJv6zMGCiyBwDT
	ejdUD+2q0blbp8cmj+J8KU2nfnAwdRIymxdDavKspmKPeCcuixbCdgqi68nnRrKm659jeey
X-Google-Smtp-Source: AGHT+IGwrCR42QpeR2puNr1W5Tg6xpSaXX9MpLLT1hLA5gGCvV8cPaCSd6GzVdih3PKpCjPk3q4qGVBL+HJPezITVLw=
X-Received: by 2002:a05:690c:450c:b0:786:5712:46c7 with SMTP id
 00721157ae682-786a41be642mr17351537b3.41.1762293046371; Tue, 04 Nov 2025
 13:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104110808.123424-1-marco.crivellari@suse.com>
In-Reply-To: <20251104110808.123424-1-marco.crivellari@suse.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 4 Nov 2025 13:50:12 -0800
X-Gm-Features: AWmQ_bm4LGXLMupMb2JCG7NJtJn3WxRnqaeQ-uUMsKRu2aQf8-o0ROQVFl7R8uU
Message-ID: <CABPRKS9Sy6MQrzZoKFaw9P08pgyYnc_=obX-4C_hrARXoe7j-w@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: WQ_PERCPU added to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Justin Tee <justin.tee@broadcom.com>, 
	Paul Ely <paul.ely@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

