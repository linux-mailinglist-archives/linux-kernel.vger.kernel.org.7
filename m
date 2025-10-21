Return-Path: <linux-kernel+bounces-863507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CDBF802D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E1264F135F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFA34F26C;
	Tue, 21 Oct 2025 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYhA2PzR"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0134F246
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069889; cv=none; b=l2aWC81MPg+kiAXQ+oycr8+Fcn34vn+6lbhNY2MOxvViIhtoEx0U2kNIsya1HHPoVGm4RbCjq+sicu8C9QxR76q4VPO+mt0wTOI3KBnXJWmXyphCQcmIQvCLeuQCny87qklQ6G2zgRHCG+Jajk9s46g0zAPWpQIHg8BMIbxBATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069889; c=relaxed/simple;
	bh=jhCcagVML83e1HP4dBy858O3DExVw2BUwBiMlSzW8y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH2FqBwX8FJoEGuYnMehMBo0dhWv0Q2di1nDKE+OBELSI37Gp5zoCKxZRcwYfj8Ka4yFaYaEE0x2qgerqqGahP+kI98fca5E6ZAiLP2EwnaHP64Vg1me2+ksyoxzXNc5pEGgE3t6/wYv4YJxsEotAfcSMHw4Tt8GpejF6C4Dh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYhA2PzR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so3851470a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761069885; x=1761674685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QNqcW6c5+Npg9ifV37H2IqLMfiz3SDiycbkwes6nzA=;
        b=LYhA2PzR+Lx/QDrWtxPO56QuwNJn+aLLvSOeHBnK6HFKKGGQXeAvbGQu+QrfKZ2jcn
         gygoxIjflkzoS2PBiLESu4pQQse5rejUTJDjGfSaOjRESiI+mhEmQRPX8I1jjYPPx2fq
         rph8E1mGrkRA9GRgudff7OYkew91qLp/LKTd2GlysSd9cFP25PN5dVQ4Byp33FN/I14C
         mLm16eun2tLASFYIhDlnC9AXewoIEvbj5yT3H4Lszjl8Z+ALkE+B4U1FPkLjtR29vWnx
         B/Xnm2UBDnCn3Pa74rGq05crYIi258g9UemIR9v+HZz0UIdN7opRd+KJHwPEKh10dcqv
         aU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069885; x=1761674685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QNqcW6c5+Npg9ifV37H2IqLMfiz3SDiycbkwes6nzA=;
        b=GL5Jr3BMzowilEzGlH7ZaLKdcqxfDX/IaHUEoz7Sgl7dKoP11ebGOuBaiU1nDAHnOY
         kj6FMvAWRhOiKOz2C6FYs9xCniMcB0+iZYeAnvmPOT7VOmy/scj8mXwvTpna/E1PPT7y
         DZPTPlYe65mNWn+9zX3dbvieA3TOphQxyiPEWceUQTg1bZz3IXAGYW8RrMhmTR9rvyHR
         OshVvpIMGkHHhoaGdsMy19SNStf3KGTOItvWz9TdLxyFj7Kzbzl+UUhlE1X6CcjOgqa4
         whNj0SZO6IvHSDOer7sxjRpDKU4CK6XcD6sFns2zaKYzbdrTaNB6mUrRpDRSYpjvH95R
         9BaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTD92TvTLkVt0SWei8yghazCuJU9nGxfy+cTA8xrapxj0femD8vjq5PsUCmym2bq7hY40sjYvzzwLU3Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDqokdmTZm9x9fPDeFLIEDlAekFLIVtRfaBOG7pp0Oeqqq183o
	XK89ujHQFR5Zo3VyLobRy+SgwANNDcj4yn1dqK7FeMTkUcMf3V82VjPC
X-Gm-Gg: ASbGncsoEZv55tLTWot803oBZRBpBIJKOTaCTssbeMaxLSFdbTSCeH4zvhJt1ir5cQo
	bb/LEJWvmfC7SExyMOKMZ6TXksYGrloB/OVvx5EzCX8Wm8/dFdKi0FgSQ3BW+YtR8Sg0q0s1Isr
	EEnGpT1yoFFY5jimsY9N3KZRNlR14Fy0C6VAG31gItS1nrAnwIYc+wAUPUxrb6gZmbC1h4ZS5xb
	sLx+Nj0lG1gnfqTma/jmc4FTKaH7DRRZIBBmr0Ul880TRqv2ABNXzcUb2IpRGtKNtbVR6NNEx7V
	sgRAJ2vHmpRDG1Uq54N3B3sKh9Pwrb+JNVlKA7EdDT3SaU5ljv5HTbNp1XCMSMVGN4ZakbyC5Nv
	PywXkA4JUSQKA8niAVA/mQmpIMV65hSRnXVMRdPqRqBV0TX1b8+zZmNnw07ba5+FlGzwhMle6Yw
	UaFPeuXwiXbF+q8fBdmDTt0AT4Lu94WTM/MMrLAtkTK1iWhs1OzTI=
X-Google-Smtp-Source: AGHT+IFHxNyo0lIoDCYjMil0Lo93Z0LIGv1u7aWlc4Ygd62ZjbFDY0Z4GIqoMlga/4TZ2FuxfJzz1A==
X-Received: by 2002:a17:902:e549:b0:28e:756c:707e with SMTP id d9443c01a7336-290caf846e1mr241889355ad.33.1761069885196;
        Tue, 21 Oct 2025 11:04:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf44:8af2:4f63:3654])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc2bcsm115555635ad.33.2025.10.21.11.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:04:44 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:04:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/2] dt-bindings: touchscreen: rename
 maxim,max11801.yaml to trivial-touch.yaml
Message-ID: <opdzievwmkkos5wyohrl3gydfmllcrw35bhzqa2gfi4kj3573j@ghlb4nndm6id>
References: <20251002164413.1112136-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002164413.1112136-1-Frank.Li@nxp.com>

Hi Frank,

On Thu, Oct 02, 2025 at 12:44:04PM -0400, Frank Li wrote:
> Rename maxim,max11801.yaml to trivial-touch.yaml for simple i2c touch
> controller with one interrupt and common touch properties.
> 
> Add optional reset-gpios and wakeup-source properties.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v3
> - add wakeup-source and reset-gpios optional properties

Sorry I already applied v2. Could you please rebase on top of the
linux-next (or my next branch)?

Thanks.

-- 
Dmitry

