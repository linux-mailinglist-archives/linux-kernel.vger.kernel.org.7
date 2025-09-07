Return-Path: <linux-kernel+bounces-804715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64EB47BFB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE43189E9DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E764127E05B;
	Sun,  7 Sep 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqH64FWO"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011D2F84F;
	Sun,  7 Sep 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757258321; cv=none; b=Bhb5H/xxur0Q37LHTK/Yr722oCeTtwGb5mKVFTPKVsXf1FfI/L7MRriQgiJBORkrjEL3hfcWfp91D6TEk51nNfrDb/NsijXlOvlski7bixvm4iSIGbDyPwBNs/SJlFCsQ6xZtX5/0B4cOFw5wA+iRCN1jw4oCBuR6/fOeKJIG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757258321; c=relaxed/simple;
	bh=LYyDvq0GXrH2DKyUhF07XevDxFGTDVdVeG14S4KHIUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZky+y1OPcjq+Y6MZl0uUHXsEYZUY4/Y+kgpdgmdK/DKIuZWTA2sGBdJoxB+GmW79mjAzCogaPdp2GZOhBHo5djlegvKUaONGaNn0v2O2QPKTGeZfklza1OyMKFlhhmKB6QcJfDG566mx9Yq28pXX3M+16Y1Cf9DmA6rNwMm+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqH64FWO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso2241426a91.0;
        Sun, 07 Sep 2025 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757258319; x=1757863119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/E8J0+UDrFZVPW+XIBVI88qGmovgkSzjMGwttvN0GQ=;
        b=UqH64FWOKzJXmEjSeIRpwwPCMkRPeKZknUgZkisk1yllWV8UygD5PTDeCrE+uAAMRy
         sRxQZf/wixYUS6Jcj3JISvk5JRZZnHc5s4nWcXq7tY8xosr2mn8ihYT5YxFXm/vWk8m5
         RXuh/ApK1CwSHAOPv5jGcoffongqyvZhd670OnXl8ktksC/mQbLz830MWPzM1xeps6Qg
         dp+n9QiX9ae0I1eg/B6sTSiW5PjjCOqyhrgdygFXEiL8NkZaTBwlHHsOiZoYN8JEbDxT
         IWGYM57FBBQNBwRdDtdma2PwPdYbopqzs4zMvYmp+PYqHhv+5iddwWe7xBQH+beCCQ0c
         0C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757258319; x=1757863119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/E8J0+UDrFZVPW+XIBVI88qGmovgkSzjMGwttvN0GQ=;
        b=mPAHG1dH3CLGuwyu+tqpz3KN992Y3fTj2XJ6abZ8Vq6jylGs4mRmBeUN0uORcnn7C+
         SG9LhUKVsiSB9F2J1dmT0aoHUGVE0K4oRcAHblCK8S0xGv2ctZwqm1iJVX6q74a8pdQx
         blSCyxeClMIQWXqAgoIl3qH0y3eEvY6+c6uhPep5fNB1NIbnyeVPATs4nLbqfRFb8DRX
         z4FoQlVE5w7aQK8IhnQqkhezzSgjzjAc5N3OO85m8pxWg71+D2fWIl/6HZAPXrsNWI6+
         G7PfZNAZsTNJl9/WaXAvnKnMnwAyEsymynY2eN+zeX14ing8TUYAmKJzBYaQPSAvVnCW
         U2VA==
X-Forwarded-Encrypted: i=1; AJvYcCUIhwPN6hafI1bGXCYYeDiETG8b94qVFDuqOsfuYLimK08pdG8meFPlLuo1S7Vkrk/UcdBnjG61OlI0@vger.kernel.org, AJvYcCWUBAssIDTRlMHsFi+pjb3PRxfcEIVH3n3PRTqpb2z6oO7RtA/DW3mnS/nv4NFX0+xmrVR2GghCgOL3@vger.kernel.org, AJvYcCX7wisNEFjL8SwICpBfSMFDCgEhUnIb/JSTHuFpNTLcRQ8LMohT+oTkzdeMyI15aMq6SUPy/NHQSWhYOfMT@vger.kernel.org, AJvYcCXbAdagOnppR48kr/rYw5JAynN+EmOMqZIFfLSw03KsL0j0gbwNztLP+pc1klTChPaWImFEzkBFNDqtIGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYE5Uot5SmNDkyYSZN0wTKYXFc8uscaYM9guLcUWXuwZXzchIH
	rZV8EMkMBun5svmir2l6xbNnRzeCDZ5f2CVP1pgObhbFwuaF7VqQnNe6
X-Gm-Gg: ASbGnctZlmpPuN2joEAk7/lhnPyog+4VBoNHZXd+NCOjD0CYKf2BSi9kVFVftlq5iR4
	SFg2R3haSqjiD0m2y77FWyyC07DoFKH0G0/BAmOo4imgcCQZur2u//ypPoDyNOoS0DYDJXP+sAm
	L3xbjvr0X0obbSYVALehn9HVDvzMkE199+jMWVVNh7+xB1rIDH6LMBpMz5r60G13Qwjak9P5P1S
	/oLuJIXsbwAC4CX8qU7XFMzXAKbb0t+uNi65jU3C5450wPyxoV6rCCJwanmfBLPih0a+m6c1iRr
	aRPb6LeyodcHnn6LYOJf+qX2bI+1om5leGuNkx+JAfWic0QxTIN3kr851S2U7TXGlvoTAPnfEEl
	dqfNc/f7Ee/Qy7uHcKSZSjF3aXqvPrZZztRE=
X-Google-Smtp-Source: AGHT+IH0NRfIjdXGmDg+4fUORjKshyxGPbn3RDkWC6+6ULZI5bE10kWEcroIGsW4+gnsEJgl1rqeig==
X-Received: by 2002:a17:90b:3c0f:b0:329:f408:1070 with SMTP id 98e67ed59e1d1-32d43fcfd9emr7886971a91.33.1757258318677;
        Sun, 07 Sep 2025 08:18:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57b232sm33761531a91.2.2025.09.07.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 08:18:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 7 Sep 2025 08:18:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add MPS
 mp2869,mp29608,mp29612,mp29816 and mp29502
Message-ID: <28e779b7-43aa-4e82-87b4-e56c6cb0b7f1@roeck-us.net>
References: <20250805101754.749492-1-wenswang@yeah.net>
 <20250805102020.749850-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805102020.749850-1-wenswang@yeah.net>

On Tue, Aug 05, 2025 at 06:20:18PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS mp2869/mp2869a,mp29608/mp29608a,mp29612/mp29612a,
> mp29816/mp29816a/mp29816b/mp29816c and mp29502 controller.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>

Applied.

Guenter

