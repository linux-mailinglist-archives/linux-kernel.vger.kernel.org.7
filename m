Return-Path: <linux-kernel+bounces-891705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496ABC434A1
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 21:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725E13AFF5A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 20:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2F27E04C;
	Sat,  8 Nov 2025 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rg3UQ1Np"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F026F289
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762634382; cv=none; b=AKNMH4SP8W0C31hm/EV//7pNQ3UQ8fyoBP1n1RaFsf5PpnPQjbb69E3xeFH2cGKjy+4OUYcd8uIzGRMbqdruv8Tlxif4TKl2BYVV5AMh4DAu5IybQzshS2eQHm/aLLAIgME5sBXYcvSa1nNVy+3uIBDZ/z8tcYMHlK1Tfv+9Q7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762634382; c=relaxed/simple;
	bh=Wtom4ms3ayhPd07f+WUTBRJueh7Rxplgb7XGluaZcfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj8ltoMLW59YsvjxzTtqmbPJQqv66fk3xT71Z9nArU8GxBI81qtlmMHW8a7s9oPPMOvlFZB4VUhD/irBV3NOeZnCuhfz1LszoCnfWk98YO2qAGJSxzvXxgWfZkftnnPR/Uw6cG75Bs9nw6rjreckWKJq0kyIZzsn4hFhc4wqvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rg3UQ1Np; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D3B99C0D78F;
	Sat,  8 Nov 2025 20:39:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EBBCF60710;
	Sat,  8 Nov 2025 20:39:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6722811852DEF;
	Sat,  8 Nov 2025 21:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762634371; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qnEtlv3/2aLr45cGMsovwfuoJ2gTycSfcv8Q2vdFF38=;
	b=Rg3UQ1NpjPBrRh0JjILrj8Utk7uo6HMAMDXxvfwb4ZuCFC0R5F+sYn0csI49oEQkR2HfQe
	F+7ewNWhOwOeizUXIIBDHF5LuCPy7ypZV8E2KCH+qDz15WiyG6EuGQ9mGBwz5Kfucla97D
	N5hqpHttr9GO/hpZ2S96Ww96H3beS+X1+KxCuGLV0ezMIZJb7T/n/3HcEIHm6WeUN6K3EI
	yxj+mo4YPfeSxvCc7EH3OKxO+aH+sEhIgDX0iqLv59+WzqBnrkEHMBAH6le19EdYjZ2h21
	KAwIlL7Vl2WodjOvCj+H7N8stnJovJMIhZnjTwyYPwi06sLqQ9N+qM0VjqkaiA==
Date: Sat, 8 Nov 2025 21:39:29 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuta Hayama <hayama@lineo.co.jp>
Cc: Takao Miyasaka <miyasaka@lineo.co.jp>,
	Naokado OGISO <ogiso@lineo.co.jp>
Subject: Re: [PATCH] rtc: rx8025: fix incorrect register reference
Message-ID: <176263436115.653571.1364095494838419633.b4-ty@bootlin.com>
References: <eae5f479-5d28-4a37-859d-d54794e7628c@lineo.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae5f479-5d28-4a37-859d-d54794e7628c@lineo.co.jp>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 15 Oct 2025 12:07:05 +0900, Yuta Hayama wrote:
> This code is intended to operate on the CTRL1 register, but ctrl[1] is
> actually CTRL2. Correctly, ctrl[0] is CTRL1.
> 
> 

Applied, thanks!

[1/1] rtc: rx8025: fix incorrect register reference
      https://git.kernel.org/abelloni/c/162f24cbb0f6

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

