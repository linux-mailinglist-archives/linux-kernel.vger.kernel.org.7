Return-Path: <linux-kernel+bounces-752731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6776B17A46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA18542B66
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364AD28A3EF;
	Thu, 31 Jul 2025 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O84RgDPj"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52942A9D;
	Thu, 31 Jul 2025 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005795; cv=none; b=QuyY7GfekxFv1tEtchMlLSxlEjt0jkAdmKqL2GwXnkSV00Msx5rJUpgLka8LC/v/48JxEh9RJMZTn6QPkiD3i9WChE4T123yE67/MFVK0jNk02S/te7QkaPmil+KwSpKyzVuiwDc+fvxKJVXC8RwFsf/pB7XKWXhXyzqTyYbLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005795; c=relaxed/simple;
	bh=OqxiKHN+tPEleTAaQBmsf91+9WcyYiC4N/xVzrNzxR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0Kt9zz7ISgvsTCJBthmbDR9m4hUwm8d9X2NA6+E4mzY30kcpx8U52czchaQ81EFyQy3gj7APLh+dZtRVHb6kpq/W1lle82AFV7GY/0QfQEo2+AkCMI9KNXiX0TztmCIjMEv2R8W7BjtBNGlwe+nXEyNeyRIFFBGHvH2GSgJEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O84RgDPj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e378ba4fso2087761b3a.1;
        Thu, 31 Jul 2025 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754005793; x=1754610593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLKil7DEsp2ET7S+yrQ8UM326ui6L7I1i5+CZitzHdA=;
        b=O84RgDPjKt/k+xnooPm5r66I/sXSsHKmp2f1xH+NIx1Hb45Yh0V/1miJXRLCrKxWsf
         0DGQHPmw94rnqBjAuhG3CgsCBYSGLbPP3t7sUtn3IPA8Mdz8EGQI/aHQRmwokZHPyATk
         qP/Rry016+tvE5hynYA1CqcPwrH/XM/+8ls2taoERSqi30fSybE7fvn4rGlB+wvA5pWq
         /9TWm7PpEll53LaTnTuO/hCgWoG+0mjeu6O9RV+ljYQZtt2ZYh4f+buHYjdw8DD6CCFL
         wp5ieqfe/XS9KgwtQhGiNHcQoAW9whqRK70Gts9ydv/vtG+75s8hwvMr0jJmVd88FQiq
         +UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005793; x=1754610593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLKil7DEsp2ET7S+yrQ8UM326ui6L7I1i5+CZitzHdA=;
        b=gDCZX6SgWTy0B3Q+aJRlGKbDRiT3ctkJBfE7sCn8nWy/T5ySXs2jRf1is7y+QxBMj/
         ahLN3b4FJBg5AClZib9aRAPUawVvz5/tBe3ZGnymP6L+JvhxYAxjIkrYmYrF9AGvm1yJ
         Ut5tBJyYep32O+UaQOLKZTH+dAZVG97Tp1TLetl4uHsozktCnuaBJqijMHUuUg1xibe5
         lXqEqmKns5S/SNYSAXusGi3aT0vXp1xYWDDEga43wJBWzPPydWGmaDXqBfVpFRzk3W0d
         kmhbczrgSji+QzsdnmMzKIlSnWiA+vdXLawEgYmhcss+ewf6haq0N1OSpc2HKqO8pWtF
         ztVA==
X-Forwarded-Encrypted: i=1; AJvYcCUv82qbYHOnVB3EPlkxL9rpiYxEoQgFt25ZQC5wXEyQ9lfBqJlBBitvQ13MtRQCG/2YVw+dBJAfvIiDQk4=@vger.kernel.org, AJvYcCWMdSYxfYnPhCN/NW0VU2MvcLfxf056oGtEDUgHTv6vgE6asC3uClB7mksqZzcRMxpG7xoiZMQALlj3@vger.kernel.org, AJvYcCWhsglBVlSk9bD6O5lQGqMs7jLRbYazkSTLKBIq1AYaO2LnaRdIDoj2FshLJ1d5B/VLsTSJH9F2NpbZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+A0dRyQm8Bx8G5XNCLVcRfbS+OqtlWdhjK/Z0vqylWkW0Jt1I
	KZn9n2iPyEqZhRnmAUgo0dltcEY0rJNQshMi4b2griKLjisT0q5aR9yf
X-Gm-Gg: ASbGncsiAmGJhGTZYqzx7EPbalzaL+O4X9fD/2PyQJq9iHn1ZusvmtP+wknMsYlUVvm
	pCNolmsq5PL832x/dnPn2vApEAhM0jNgq3smFVHGtW15hCELyirV1Fenf0by5eKSP4ygfnqCCd1
	oRazmcaKHX5gDrUdZ2S8nkAyInJ+eoFrB+EaaJtkU0zMRVHPPQutnEr+/GO/FkhSrOSh2N7iDUU
	pCUcYy7dQKeszUl7vICtWgEtNgXcAVdcTPeQNYNYEsjj7+U//QvLRK/8DUws8OMGaM21MQTbUgz
	3tfj/Y5h7eDmihhZHUVkN83p/I8vqfeIy7hk0mxumxPnhMciY3HnthcBSOerPlZy3N4fS6WnF0x
	u+keEnDz4zrl2rQX2LzIUbhc7mDrbqYxZ2sA=
X-Google-Smtp-Source: AGHT+IE4d5bsDKmh70zMAfXbqhD3vaZmPJYeoR0cw+nGJM8l4TwiI6e/crFZ3cMteXs8sbBaCLoMtg==
X-Received: by 2002:a05:6a00:140f:b0:746:31d1:f7d0 with SMTP id d2e1a72fcca58-76ab112a519mr11176837b3a.9.1754005793522;
        Thu, 31 Jul 2025 16:49:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa92sm2626948b3a.45.2025.07.31.16.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:49:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 31 Jul 2025 16:49:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add binding for NXP
 P3T1750
Message-ID: <fb2efd5f-732d-473b-8a0a-38cda680fd41@roeck-us.net>
References: <20250728041913.3754236-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728041913.3754236-1-lakshay.piplani@nxp.com>

On Mon, Jul 28, 2025 at 09:49:12AM +0530, Lakshay Piplani wrote:
> Add "nxp,p3t1750" to the lm75 compatible list.
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

