Return-Path: <linux-kernel+bounces-860834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B99DBF11B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F79B4F3AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C323F413;
	Mon, 20 Oct 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qYeqXXYY"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731802B9A8;
	Mon, 20 Oct 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962526; cv=none; b=GHzbviooNTvNnGlszLf5uhJ4D3o2ZgXzCEpZYqT/V7pZBYqPz/R3U32tq8BLFCN4C+KodSIhU5P/QpdoicMnd1/Pvynqn+YdreolV1AmJP4hQqyGmRFjVBlRypcXQ1PpH0c24E+i20ePKdHNkrZu3qPs9QL+1Fl6fVWSotqxnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962526; c=relaxed/simple;
	bh=A2PSBI9x4CIXLc0aeEqEAZ/iINPPAExtIVufP3XOUAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekR/+74jXLeYV+tSr80ie37tM3anmebSe9PIMz7FXeEYkn0Cdif1FMXRLN1Jsp6RHIM9Jr3BOGlBUzsEQyqbEM2oPu8hElmumTFBb0WYc9TQCyF6CJu3mpKi4lG0AR1hAf0ZJZi/JF1NBrj9zT/pcJa98NoNkfpqlBKtLA2TJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qYeqXXYY; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/N8g8/qVoPBEKBIfIm1v+a1Lcy8fJnT8su5q5VehsW4=;
	b=qYeqXXYYQ9oyJygq2euQbXLOD/A0TPfRtmR4ttWfL/y2fZtY7PUiRqjv2a2a3p
	Kifv0uKPajfBm9T+nNHuLlJ56SODiMahQwuta3bRIyfs7eOSKrdPJrtxuE9dbpLx
	L58Bki9UhcSF4x9xYkQSJg2AlC8UPGLGt3eLrPgeQ4pNk=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDn16CoJ_ZozapTAA--.27231S3;
	Mon, 20 Oct 2025 20:14:34 +0800 (CST)
Date: Mon, 20 Oct 2025 20:14:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, kernel@pengutronix.de,
	festevam@gmail.com, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: Fix audmux node names
Message-ID: <aPYnqLvUt9672wYb@dragon>
References: <20250915220655.143861-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915220655.143861-1-jihed.chaibi.dev@gmail.com>
X-CM-TRANSID:Mc8vCgDn16CoJ_ZozapTAA--.27231S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcGNtUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNwrLMWj2J6pTqgAA3t

On Tue, Sep 16, 2025 at 12:06:55AM +0200, Jihed Chaibi wrote:
> Rename the 'ssi2' and 'aud3' nodes to 'mux-ssi2' and 'mux-aud3' in the
> audmux configuration of imx51-zii-rdu1.dts to comply with the naming
> convention in imx-audmux.yaml.
> 
> This fixes the following dt-schema warning:
> 
>   imx51-zii-rdu1.dtb: audmux@83fd0000 (fsl,imx51-audmux): 'aud3', 'ssi2'
>   do not match any of the regexes: '^mux-[0-9a-z]*$', '^pinctrl-[0-9]+$'
> 
> Fixes: ceef0396f367f ("ARM: dts: imx: add ZII RDU1 board")
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

Applied, thanks!


