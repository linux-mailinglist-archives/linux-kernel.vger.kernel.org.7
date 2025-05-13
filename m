Return-Path: <linux-kernel+bounces-645600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13697AB503D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 11:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA91B4116C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D823C4EA;
	Tue, 13 May 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj8TEJcw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BA150997;
	Tue, 13 May 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129736; cv=none; b=kODdceMpIR60N4q+dNG4HJD1AYouTEN+hZRujWmKrdk1qGI2H28kcTLB0E8QQ9ZLxNVQJahSAJd6r+t/C5jTnr51apkTu1xUrb0xX34AeuLAVbvQ2bi5jZPQXrBtm0JzekHvygaEtLtfnNtpKl/G8EgNvIL30uSgBKc+LVbZ+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129736; c=relaxed/simple;
	bh=sqtaejMIM6MTpLkXqxPA0noJWsMwRfIDXs1fL1oC2YU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VONerdWVyqqlqQZosBDs584rdIptvltMpj1AMJf20GEfhOFmVJkIo09x6+X4ro71d1cj35CUeJjmYcHxrc42nPaIWf1l0Iv45koWPE6SDodWBubZtHdnBiteo2C/eKYCwkn9sXnauYawNELrgllEBj1+cEyn6NADCL6H+Es46pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj8TEJcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245C4C4CEF3;
	Tue, 13 May 2025 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747129736;
	bh=sqtaejMIM6MTpLkXqxPA0noJWsMwRfIDXs1fL1oC2YU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jj8TEJcwRp8wjORrwvuZuLZJ8T8BmiwfjDYU/yeymUy5hCQtd5RZDezS/rFAeKOTr
	 mhT06zGq/CmEdE9daYesfarLZzPM7DqeWfRmjSu7jTvJKME5zqLbUI68aJX6SE1wOH
	 j+bu4i/bIy32xo4ttO1VIckNTMSjUY32uvC9dskIcoyYEpVAG5SD8x80u5mThVnEUo
	 siQyd4zvnt4MeFSBthvJhEkrtOS+e+7M4xQOoVICvH0O7A4gOnNA98iJ3QkQ/4HvGQ
	 wx+wta822eDjM98WguqnZf/6cHdkJIExLb5ABPcIZFgkleAMVj5wvgMaYUMaqzX7wM
	 0x6mmGoJWaM2w==
From: Lee Jones <lee@kernel.org>
To: Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <1681629840761e30494cb8920668710df60a81b8.1746996137.git.christophe.jaillet@wanadoo.fr>
References: <1681629840761e30494cb8920668710df60a81b8.1746996137.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH] mfd: 88pm886: Constify struct regmap_irq_chip
 and some other structures
Message-Id: <174712973489.4137268.11025670503808992494.b4-ty@kernel.org>
Date: Tue, 13 May 2025 10:48:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-b75d9

On Sun, 11 May 2025 22:42:30 +0200, Christophe JAILLET wrote:
> 'struct regmap_irq_chip' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> While at it, also constify some other structures.
> 
> [...]

Applied, thanks!

[1/1] mfd: 88pm886: Constify struct regmap_irq_chip and some other structures
      commit: 960391e115f535f631d558784d70e8e33ad0a30e

--
Lee Jones [李琼斯]


