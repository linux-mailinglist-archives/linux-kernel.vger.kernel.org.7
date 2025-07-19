Return-Path: <linux-kernel+bounces-737933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6BDB0B217
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89963BF7B8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C8C235071;
	Sat, 19 Jul 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1tYXiEN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D61422DD;
	Sat, 19 Jul 2025 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962425; cv=none; b=o3MLYzlt35bN86AET4+0WETc6vHb/OT6qZqORn3q+XunP0fTCY6x5HE/5CZ62jXLT6G41LqNRNHt7UvUqfM2I0OKVpxFphu5+aRLiBWRMo2fSJCEeGl6ON9yjTh9LBFKVyYzh15R4fMG7gPIjGtRDk/7d8oDftpxb49+2h78PEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962425; c=relaxed/simple;
	bh=eERVWuxEVgHTuvmH38Tf+BxvOATYStDpZFR20ntxtAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7HRs/wxO3MnXBK4Q4dRbhKDPID/aWjy1spw2xa7Ntes6ut0oep83HZp/5dgbe0tjdvQvMZ9T1xNFbi2BJcb838Dw43cNGYI/uxRmbzK/oL1SD933a4oAT9RdCvj3os2y8/XU4QXO0yDLF7pBll0bIIxCo55xOj004769KzfU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1tYXiEN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23aeac7d77aso26411115ad.3;
        Sat, 19 Jul 2025 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962424; x=1753567224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UsWUd7LnGZbEjHjTAdHhvU0ZZ52uRP6Ycpj+Tjj+9s=;
        b=i1tYXiENNGqDXVLlBFUeG8KOSP4yh6C1x/VO3orGUpgkaiPybGJycuJ2qFm26Q5fWs
         mZ4+rhHiRv/jI7Cj+v5MmJCOrKFjXQyeo2u1ChaCCR7sAFuEfzlzHfgkDEB9yzAn+ZPY
         jQEAzL5Gq9CqNUE1uQrtgpDZSA+3q3iGOayJE4k/tMpYo7MWtTMrhlBO8QUwoRlgd7c+
         JM0+3DUx4ZYafD2LhbIMlu7ML1wghaJtrhJ2SCo8NC7yNuLLp1r38UDpve4/ks+bnIL3
         JrBBrWMkHilKkcx+k+BG9qzn7f+LoPvhKPqt5lKa1NAGn4wpKOiHsEjI0EUahL1nOvh9
         z/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962424; x=1753567224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UsWUd7LnGZbEjHjTAdHhvU0ZZ52uRP6Ycpj+Tjj+9s=;
        b=mNciwaEnJbS8lsIc7jSNjGR1akEGoYB/sNcoXwAJnpleS6n4sp5YoryHtjSE2ExDmF
         dBOs9Zmx2cAmWCLoNt6W84k2nrLax2ad7kf63NN7Ingi5X480nFPWfbO+NhFMtbeab4O
         SCKAfMqNjn/2R7G7eK/UT39KJqN1RPgPl4YjeMKEeVnQ3JG4lkUpUCcAExWZ8G+IpLoi
         exeoQmttGWgRr4Mi/9OcYio8X+Ikj7kIEMxSmSud2s4ETBySL8X5O6CTTOFhF+8GUKm9
         jyjsFbtVVILHwdPobpiLLTkcZFnegkysfcCjNeGokU1mF3P6qCFx5iEOmpupo+LFNBj2
         KyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4WobgR+BjfFyBH2lfHCKT/udUnrI8/PB9POioUZrVouSzh6DgNdbD5vGhzLR12FvUA0/job1RO3haMWg=@vger.kernel.org, AJvYcCUUVTJeNKgt0d0CuTbLdc0qFOKRASUnEdBt1lSPOGHs60BYylfDXld0iAJw/8fSe6woCV4kBRIWo0zt@vger.kernel.org, AJvYcCVbFq7ybkGEb2EqXz7Y/UTYAPiA3yfPoA9xLCCv+19OIN1wLOsgVhLK9IGNQ2Af1S1ZICh6aFEqrzvifovm@vger.kernel.org
X-Gm-Message-State: AOJu0YxDjG+qubFgCUGsAw51TUEWh87/q0X1Yh+durMvvNkUk1cQJpEp
	MnYCJJizzz5Y9F4pVKa8r6V9t8pRkxPYDz3uqXSdO1Ir4haqjyVk/kZh
X-Gm-Gg: ASbGncuUyeYkd+mYnh0z8e19FIf6U6pgCw1ha50Zj4R+7WJzZ+SgAPPw6PXbJQ75iF3
	58YlKh/IAmfpBLNJYQrd57IetJSdM/TxFXnD9+MYJHC2lyulQgml5vxsIf22EZafXD9ExkJ2rAf
	9ZtcQdvBaQFlQlKt703aC8O26mLh1CqxmpIIgDTOL9POQfTrtLoySGaE3SWU10leKYlF9aojIm1
	jFkSOVsZV/bhvusfC1w7DH4IQ73L+laOleHmbuv1ksrzQdtts6AQZ2mR9v8sRz5UK9d7UvQdzCm
	F1ojQZT5HfAPs/gyeSYIaicpI9osh13da8aw6WpHi6OLyrYnkRqQID/AXG0pXc5a/I4bF+L/Vs7
	4mVHBbWD0wDV2bhbZHb4PDYl7CCx2ee64Vn8=
X-Google-Smtp-Source: AGHT+IE+JOITtZDcUGePpKAvJEC+kFhGytF6zyuiD8/8oHzL3LQu8GMFI9BO3soyL8kFe15q/ehzsw==
X-Received: by 2002:a17:903:1a0c:b0:235:f3b0:ae81 with SMTP id d9443c01a7336-23e24fbf7a5mr207823885ad.27.1752962423662;
        Sat, 19 Jul 2025 15:00:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b70868csm33248035ad.229.2025.07.19.15.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:00:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 19 Jul 2025 15:00:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: Add INA228 to ina2xx devicetree
 bindings
Message-ID: <916b6f28-1ee8-4a02-9c05-efd8f3511558@roeck-us.net>
References: <20250718-ina228-v2-0-227feb62f709@pengutronix.de>
 <20250718-ina228-v2-2-227feb62f709@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-ina228-v2-2-227feb62f709@pengutronix.de>

On Fri, Jul 18, 2025 at 04:12:49PM +0200, Jonas Rebmann wrote:
> Add the ina228 to ina2xx bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>

Applied.

Thanks,
Guenter

