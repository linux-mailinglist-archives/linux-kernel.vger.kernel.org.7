Return-Path: <linux-kernel+bounces-721270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF416AFC6E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABE3169AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4D21CA0D;
	Tue,  8 Jul 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYcjN318"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F23221555
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966421; cv=none; b=e1gl/gdQFRgAB/iBEJd6uP5T+TtD5BtM75jspwPy7EqqFfxISI184BbM5amPulOxAyqHhxcNhNPVQDmsCvQh4acpuWidcu4DPT8OfOJ0HdNKAnlcRBmVJ0Kq7582RbbwlhjJ313lkFxGtOXhVWEY6LOAAFxTkUWLc7yD2NBe9Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966421; c=relaxed/simple;
	bh=tTnkj9/iMWnXfZ8wbeIpbX5DCcf2AwFFVw7LzOLB13I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lrysr2qi7lyhNHxIt47gGfucXF3BGkOpc07iUuuw9JBME6OGSrzfORWhnKHRJlRgw65PIUREh+U6lSf9ei8YCkmMTy74iPrjP88eOaPQwWGR2HIiSLq6owDdsVoR/+zuW2L20A+x9XA0At/WoJ1tZwgU1DUeX8oeUJUcrXGOyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jYcjN318; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0e0271d82so837505966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751966418; x=1752571218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qde20GPEW8GrZb6i2zWlEkGphLDMaxaujFgrrC5mKsw=;
        b=jYcjN318UWLukEq+Tw/dua6v6SbK1nnVglvm2qlUiFOXDm27AEdaLiEIbGj06Onkki
         JbYiFGDyNo8aKeDxsgX73Dd3n6Mjf/O7EdJg8ia3QkBi7xYmxW/FDAdffiQIhvMPdZ4/
         3SsbywE3oFFpVGPERGa5LZCIAgPCB63VRFVN2vnlLmtSQmEYe1BcR72icn8TFFS5WC1S
         tUEAz8bC20cEn68IymUXoMW7d5jyMfECUAEs27NfKW+5TyrjQsjoKyrTJc1VA/ZeE41x
         9mfICm18TjcFbm8gA8amMGDvEGb8vlPLOlW/g0rfd3VsYVMPIesX+2iLiKY5JfUzSw6m
         407w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966418; x=1752571218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qde20GPEW8GrZb6i2zWlEkGphLDMaxaujFgrrC5mKsw=;
        b=fWdypfadmyLUO7C+k60Ash7ypAoFz9xTU4xlkYClD52WZ/2bhK6SgWevucAy+Yk3Mg
         y59fx4u28IlEw2fl4m/0R4XZElODBHcMPpzDEQmKtaPBDoiAPLmCXBeLzWMhKRdHwByg
         vOnJCYL4dOyQT3/94Rdp9ZIECbObdNV3wh2cjVbhX8Y2D7LMqxJnrnZcuM//WsQjWaMP
         0TrVD3INiJSirjFe974FM9/hEyeBsTD52LrZO0mh3poOrCiTc7r3wtwsLeEM3LhtqNxG
         yNTB7MLkBRUEgV85hoaa55O7oEZJDF8JoRXKv+xzIg4KJJ8o1qrT1nYelR0VQ9p/Hx/v
         W1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Fie+3vuLFTq7zsbR3S+brKBEu/g0LKbEBSpPzNTKM8WWaCeN4zCH4dWBZ/ie+RnyVRtsD/bEVHLzfkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27z3F3yPTgLqecAjzcB2noqrkqeGh6yHdqJbBJ2LgIQmD5qZy
	+hofQgjXc/kG2z8gKtByNmf6SDT9tgs9E7rKV+Pgsvkt3/+G1dezPxnm7HplBh8/HWM=
X-Gm-Gg: ASbGnctJ3XNC1SYMpkKdEO/nV6T7tI3xDQkw4tpaT9rqDA41BdGsQQhGyegInXcF3Sg
	gEoO2YLGTc901lXlgF8WhCbV7B6QKO78sW0TJE3iZorHVMMG8VyXefXOebiF4gTr0kOtye3WM9S
	Dp+B2CyP2Ll9DWAvGiKHXfFZx3uWrwpQrSHiscKOG4w4WG7LMyh5Sf99FqVkwkk028t3ViJKoAj
	FSdHxjUYaW2uu6eP8SSh+woMEaYAyQ/lzwfsG384l0BOmfGYXEveySCdtdig9+gZmjbzTUpMmsq
	RVCq61HOF44CpxuJrjSg4nkaSk8+F2rg9IDM4STXCFkLUOa566bmhAG2cGg=
X-Google-Smtp-Source: AGHT+IHP/+5wQx+82Xsq93Q+p1ivWxiCeoN5FhCTp6b5wZJQBNJcP3y1aTVdV3ogaf3T1uMqF+NcPg==
X-Received: by 2002:a17:906:f592:b0:ae0:a351:49b with SMTP id a640c23a62f3a-ae6b06f2722mr201059366b.34.1751966417914;
        Tue, 08 Jul 2025 02:20:17 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e7d4asm840670366b.23.2025.07.08.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:20:16 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:20:15 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Sandor Yu <Sandor.yu@nxp.com>
Subject: Re: [PATCH v3 0/6] clock: imx95: Add LVDS/DISPLAY CSR for i.MX94
Message-ID: <aGzizyLX8HDWsWWm@linaro.org>
References: <20250707-imx95-blk-ctl-7-1-v3-0-c1b676ec13be@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-imx95-blk-ctl-7-1-v3-0-c1b676ec13be@nxp.com>

On 25-07-07 10:24:36, Peng Fan wrote:
> Similar to i.MX95, i.MX94 also has LVDS/DISPLAY CSR to provide
> clock gate for LVDS and DISPLAY Controller. So following same approach
> to add the support, as what have been done for i.MX95.
> 
> Patch 1 is to add the binding doc.
> Patch 2 is fixes when supporting i.MX94, but the issues are
> also exposed to i.MX95 even not triggered. No need to rush the
> two patches for 6.16.
> Patch 3 and 4 is to add the clk driver. Patch 3 is almost picked from
> NXP downstream with a minor update. Patch 4 is modified from NXP
> downstream with a few minor patches merged and updated.
> Patch 5 is the dts part to give reviewer a whole view on how it is used.
> 
> Thanks for Frank Li helping do NXP internal review for the patchset.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

For some reason, this doesn't apply cleanly.

Can you rebase on 6.16-rc1 and resend?

Thanks,
Abel


