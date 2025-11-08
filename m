Return-Path: <linux-kernel+bounces-891716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD9C43504
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C2AA4E21FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05B283FFC;
	Sat,  8 Nov 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OU4HVJNb"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CA276020
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762638983; cv=none; b=JjAqHOJo5J+yVumrycqIEAd/4eFonLQczPvqATFAFwTFHEX/Dz2nArBucfCuQl9SC0vsuXAIxnfgOugr9eBJ1YbAkxNwIhkoTJk1Rl9zMOVHvJ1WQs9x9Z515pRO69HVcgbp2TTRSUxS8H5sHu3FBJMeALsYZeeTgAIpp6Q6+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762638983; c=relaxed/simple;
	bh=Fz0kmxQLkKW9u4Y1HMxy/RBQ1f08/NVunjhHzCJOGl0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQa2gBQJ2JLirh69GC4bn6rt9COaRLlIg48ffyw92oN5EVKYUyLo4cxBatBxynlZjVUi7Dn9eTzqUQ7cLsXN2SdlWhAX/Of2fvsW/vhxSLktFP/YrSV6bCWKwNdyesDbqBDQnoRqvg2WEtbzxfiRHqfcBzgr05aeHiW4ZjDIN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OU4HVJNb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A0B114E415D5;
	Sat,  8 Nov 2025 21:56:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 58B1D60710;
	Sat,  8 Nov 2025 21:56:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D0F511853068;
	Sat,  8 Nov 2025 22:56:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762638971;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=5AxV9zAfwzxXLQuYV4SQntDLgupugMLE1UNs9cxOI+o=;
	b=OU4HVJNbfjro2tym801hMPJgd3rXAsv44NyResegH3DkZjcHSK4a0XrNbZ1tqE13y082a+
	fzvlIKQ+JXOcdoyANXlS6ktYJ339sN/dNhrmYfjcspWutuA8ss30zaKxMWZjuSgNYpd8BL
	8H1Z8VL59cCA7tR2iq2FsXY72rQ1kj3LSW47ugy/fJk977f9RI8oswMg9Q8ZDMb75YE8+o
	F8ruPori6PCtW35rWhvyrrkODFYCgpS6Datmo1uxCUGfRmhLLKimuCmSUHDD5prye0mW6e
	hsrvrPPY8LxXXgbo2EmcWmvkJSwHluxZrYHXTCOCMirh7e9Pph2+iKh3OWVAdg==
Date: Sat, 8 Nov 2025 22:56:08 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank.Li@nxp.com, wsa+renesas@sang-engineering.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, adrianhoyin.ng@altera.com
Subject: Re: (subset) [PATCH v5 0/3] i3c: dw: Add Altera Agilex5 runtime PM
 disable quirk
Message-ID: <176263895276.673133.964686520497034769.b4-ty@bootlin.com>
References: <cover.1762237922.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762237922.git.adrianhoyin.ng@altera.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 04 Nov 2025 15:29:05 +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> This patchset adds support for an Altera SoCFPGA-specific quirk
> in the Synopsys DesignWare I3C master driver.
> 
> While running the I3C compliance test suite on the Altera Agilex5 SoCFPGA,
> the I3C bus was observed to hang when a slave device issued an IBI after
> the Dynamic Address Assignment (DAA) process completed.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: i3c: snps: Add Altera SoCFPGA compatible
      https://git.kernel.org/abelloni/c/8d1d2c408cc0
[3/3] i3c: dw: Disable runtime PM on Agilex5 to avoid bus hang on IBI
      https://git.kernel.org/abelloni/c/fba0e56ee752

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

