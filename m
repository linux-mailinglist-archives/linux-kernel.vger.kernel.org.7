Return-Path: <linux-kernel+bounces-793587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D2B3D59D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A54177322
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6960624676D;
	Sun, 31 Aug 2025 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJxO+FAe"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD13D81;
	Sun, 31 Aug 2025 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679452; cv=none; b=k5Rf9H4WHxoJyYLTL/3xLvfy39p8a7yKhqPx01yEVMauGuYaqSM0XblOSKuTv0xgJ2jkb1SNn075tGsW3SpEq2bBfrKvoxbGLBVA1nDFv6uzNb/5sGagjiMNy3AAmucgAb3GLZY99HN2NzzlZcvzvwbmfrdz+1BL+9syRFaJmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679452; c=relaxed/simple;
	bh=uYgtguB2fQQeiX49JhGe2r+VHod1rlf9qnutQpQhGic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9XwQkX7ZmbYNoxB/ASlc0saI3H/jFX4JzFUzajEEYxe8e/RTP/suOGFtHIltPODo5i+tOMFZXqfgdeFrGBjjAtU3CJpcjQwa7hCtcPbO8fHhztHL/RI6viMPjCWqj5y+bJgU7p5CEAEUdTObZa65FECDkaQo2h7jRsddJQc6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJxO+FAe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-772301f8ae2so1767605b3a.0;
        Sun, 31 Aug 2025 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679451; x=1757284251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOXrf/fO8R6/nAWnGoM+XU2CQnrLVehXGmCOFXbTcEQ=;
        b=NJxO+FAemiJ3Z6Jf7s/g1QrWlUV86aHX8MT9o4+dnAY9vPNonSIntOjt8Jt6Z0iXgF
         V5+4BkUemLLM+uobqkr89UmFpdk0NdYyT/dTLCQzD7CdAGpVerq1+lsP53VrKUlGCY51
         RlPikRTep0sgqFR2mEKmtsRjJspXrWlAknr2IsZ4maHsyPfV6gwdFCyz6FnzVzkEOl0K
         MMS+bDfFqLImEZA4Cp8awm6slVBrQDkjhL6sQn8m+3LHOBlsz59rX7lEYMuININCGS2y
         sppyMYb8HFk+be91b3UbJdMGdTog8xcu/Y9/RwKGjj5qYGh+RMgLI0hK+f6HQgNqV79a
         DIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679451; x=1757284251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOXrf/fO8R6/nAWnGoM+XU2CQnrLVehXGmCOFXbTcEQ=;
        b=F9OCEJFUU0IxqZ4WihCgy9MsZ/76LKMUTWUYJHyKowABSAIvRNDAnCj65FcBf+Imc6
         YE06WfzaCWIIFv9ei+UnElogMPqIFwy2sHUmEk0JTJ1K5cxQ4BuXKH1C4ezJHZwfwrHW
         s3uXil1siwcenL1i91yEfRgWgTGF/rbnXV7f9j1mrIzD+M4kFaGfFkUwraVJhLx/ljYt
         Mi4QSfff+0KuWe67B1B+BAL2f3VU17i639yZMUqlembKkSdlKPH8v19tvEIBbPhYZ2Bw
         cGIJclypk8Mc6wZOsFVzpwtFBs0pcYviNpXRxAgng9kH4u5VUR5CZCNFL2AFAE+VbnII
         Vx3g==
X-Forwarded-Encrypted: i=1; AJvYcCVBsGjvNcJsFPdLKbdQpDvsbH/pymsJB+cXMLqEU9Gh7YdldujxBPbMDlv3fDK7ZPuZBGv8Q71EG0hS@vger.kernel.org, AJvYcCW2/oR+90acKp6qWPxSJBHcvLmtom6rShPnWZNYV/y4PxJP/G7ndIPqOkwQx9IC/gLjHSDDqAc5aZdVwFNr@vger.kernel.org, AJvYcCWRYs3FX9tOJLfp4ldz/mTFZC/5ZunbDRlcDaOd+Eh+h8I3PxEWLMCJBQ8iMlZn8CY4LkmHpgsDKSMgmn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOFljU+odLPYoTViR4Qe5L909hUf69lvVObIu663nKASit+78
	69IHo26e6OWGoRQ2h4BxQ707TnOf8q6Sd49YIDOaomQyePw4cDv45MyNwhUzxA==
X-Gm-Gg: ASbGncuF0VJaBMpSVW4UqpTar5oVAn9j9xLrIwA5dJdnaxcolGjbjfkR5fsKy9GJ4D2
	AdbeHUtvHkD+raZwN72/A4p0n7NuMMjDbo+SGPyqzVYzFW6Jz6VmjLf9rxsfJmq+k9zwZsOJnCP
	itDP5+tlQOGUFE1AQ6xjPOjHxG4Kh9nKTo9/79kCPbzRFRb1odttw6jnnMhBSvfStAVGInBVDGr
	gxnvYBE3x/vJW0cCFfpe/FpFfQtLq4gIk6w54QH7GhQr5vBGD/S0Xh33CyJbN0Hm98QICCQfijF
	Op2UDhpxhaTRCPHxq9XvOZYqcbZ3P2aBQXbUqAN9i8KLANBnkstLeobKwgf+o6GUJL0hC6fKV/2
	Lqq/m4fAQyJvqxcgWWKYuplxf0eRS8gO+DjisSQCVuyKX2A==
X-Google-Smtp-Source: AGHT+IEJDTNQJEXM61xqhRbx4uxYssScsK16k7XQZneWcGZfHsTQ0ZHaZyoCOfQGFmuuSXtO3bfTOw==
X-Received: by 2002:a05:6a00:2d24:b0:772:31e2:b80b with SMTP id d2e1a72fcca58-7723e235106mr7470125b3a.11.1756679450462;
        Sun, 31 Aug 2025 15:30:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26ac0esm8518424b3a.2.2025.08.31.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 15:30:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Aug 2025 15:30:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: tmp102: Add support for label
Message-ID: <b148ff3e-a5b2-4826-9228-73a1cc6caf5c@roeck-us.net>
References: <20250825180248.1943607-1-flaviu.nistor@gmail.com>
 <20250825180248.1943607-2-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825180248.1943607-2-flaviu.nistor@gmail.com>

On Mon, Aug 25, 2025 at 09:02:44PM +0300, Flaviu Nistor wrote:
> Add support for label sysfs attribute similar to other hwmon devices.
> This is particularly useful for systems with multiple sensors on the
> same board, where identifying individual sensors is much easier since
> labels can be defined via device tree.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>

CHECK: Alignment should match open parenthesis
+static int tmp102_read_string(struct device *dev, enum hwmon_sensor_types type,
+				u32 attr, int channel, const char **str)

Fixed up and applied.

Guenter

