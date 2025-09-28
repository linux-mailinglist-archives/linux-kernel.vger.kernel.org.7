Return-Path: <linux-kernel+bounces-835210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2998BA6820
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F0C64E080B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79221D5B0;
	Sun, 28 Sep 2025 05:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdRHcTbb"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCCE2848A5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759035797; cv=none; b=bPtvZtj6Ftc81+mQyJk6RQoO8ir5raosTU/OHgj7TpmyNg/DfjORsyHv1DqChS7saGMzGuhpBu4FeYOMjki4n5OhoTrYA9kZRjXsMVwBPP+45/A4E0VSSbcraqEa+L6tdgdybblEMVAn9+4N7msI7mJbvHxnGL3Ac/7Fezkj5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759035797; c=relaxed/simple;
	bh=QMtV6OGFQw4H+Fr4qxLekLxCa2Qt7VL//D+5G2Q4PA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0sFgZP2+UxIY6TEsZ+dpYHQwGitDoiCdFCnK0CY7V4HoL2Fg7pfjvU94i268Otx7UcV3itLoewBzEIPP+QzxVaV81OJhOpOLHIpZGm18ksMw87RpXGJzYHiFrLMcKwWGXUltoFBRFTweQgxPB+Ha9ECLBgORNLhM+/WwwaOXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdRHcTbb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26a0a694ea8so30242795ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759035795; x=1759640595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm/OUWyFAO6MekzNliwFbpLwUdv2bsJ5HXnGJgKstlA=;
        b=TdRHcTbb5LaW1+g2m1lt9ldBrNDJGsGIymDK4SnGNBrNSMjpTzwyl+fx6PFd196tda
         vzJRSJ4i6MxfNzSh28mi6NeQ7pTD+4MxOKiqMZdi8ohM6hw/esAlq47ZwMK10Nkva2bK
         /jN905kgffqE2BYeitRKEz7O0StMJ3enIxwZgmHEDfPAGUQKJ/tUjBQzQwqkRMGUYPZW
         o0cSdm9w4dgHZ88NNWDgWFaDmjeCVbAk/GrjhR/l6cHQ37Ve2vp4jb9UXey9YVeP4OTG
         TT2MMy5nLjyYjpgD/w8KjNNg8euIYhVrTYODvswpaNvsPyyNPiJGGziGzPVWAn3z/LXK
         MTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759035795; x=1759640595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm/OUWyFAO6MekzNliwFbpLwUdv2bsJ5HXnGJgKstlA=;
        b=iXY2CdjxFij3CUqtJqcPNsOqw8v2OjVq1QKpAamKP3M9r1CUYARJIzGON1PCE20XA+
         reSTxJtB75M8sQYuBXiXqlDosb4e1Chvu5thKLgJHaQOJxHtO4sEulR5fOxnGX7wb28k
         GWh4+NfK7BBR9x74uM6MOLn5sittel/feF+j5wEz2quHQ0Ii2RPB5O28PD4r+cWD0mzx
         mZGSlnraPFTbft3H9j9uSb7NbwjQJh9bssnHhCr/cSxUQ8I3gvP0w+4P44d6JtDDhM8i
         cXzs4AG2z5e7foaEcchvM8mVkxP2e0+1REWs9ulQ9yIBiIznnTrduDMJFNXMjuWLRw6B
         56zg==
X-Forwarded-Encrypted: i=1; AJvYcCWj8jogx6Nmk+mYGd5MrfGoAw6Qts4h3Zi+PLlolEotrF84VvrYLjuvqh2nejKHGIF2kFXBJjaXzOSU1NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGj3A9nIeXefN8Vpqk+PdEMLPVoQYzq3Knf2ngJtPKlABtGmMA
	yXeA9dRz8CsM9L6iqVY0kFI6A+r2yGZUnLJxoDm4Nl5iGfqPx67HFD9l
X-Gm-Gg: ASbGncuajdTlIxgKIIy4iP24P23Ht/F4278QvaiqjkCmoJtX1sblT6FOsEx57s9jKIf
	LyJirwIJKKTBCgNPJe+FaKja8rcmjBzS9+IEG2MsUtumaxkPn9fW5tqTTtVrx6tLGGQUr8SjMAa
	WnHqhLBq8nuBvschncDrrJmEsV0J2J4KkhzkhGgZgftl/9uR0aegVoxOA2EsEMTq9jwVxDhZ2TW
	hc+VNS8SfBuuLUe9LfHAfzPs00f/tPqKb5ACFja5obJGi6M/mBAwo1u5KB3LeZ/HG0W9lITI5Pe
	/n91iU4lmUjfyjGWsV9oM0g5iDcRvDDsEFpCvgIDQtgbXWaLHMoA89O5aOVkgMazxl1KvPPEVcY
	DICIrJJAykgL/XfkHm72mubtTAw5M76BhcFcVjjSbCLt8Nu62IL+fLMN93U17uWWBMO5M5x0ChA
	==
X-Google-Smtp-Source: AGHT+IGM7HTl+rp2pt0cDMfA3KNGD3nZVxhzYLkjSlK2EgGIN6LujG//pIftIad7lmbGXj0A54imuQ==
X-Received: by 2002:a17:902:e805:b0:267:b6f9:2ce with SMTP id d9443c01a7336-27ed4a465cbmr132772135ad.41.1759035794491;
        Sat, 27 Sep 2025 22:03:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:22dc:7b49:8c5d:38f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bf9bdsm95854355ad.127.2025.09.27.22.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 22:03:14 -0700 (PDT)
Date: Sat, 27 Sep 2025 22:03:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v3 2/3] Input: aw86927 - add driver for Awinic
 AW86927
Message-ID: <gswz6zhukprs6q6mrv6pmzcitxrvzktubylhan7knjcs7tjbxf@325gvpk5cyt7>
References: <20250925-aw86927-v3-0-1fc6265b42de@fairphone.com>
 <20250925-aw86927-v3-2-1fc6265b42de@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-aw86927-v3-2-1fc6265b42de@fairphone.com>

On Thu, Sep 25, 2025 at 12:07:29PM +0200, Griffin Kroah-Hartman wrote:
> Add support for the I2C-connected Awinic AW86927 LRA haptic driver.
> 
> This driver includes a hardcoded sine waveform to be uploaded to the
> AW86927's SRAM for haptic playback.
> This driver does not currently support all the capabilities of the
> AW86927, such as F0 calibration, RTP mode, and CONT mode.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

Added missing header, changed uint8_t to u8, changed some formatting and
applied, thank you.

Thanks.

-- 
Dmitry

