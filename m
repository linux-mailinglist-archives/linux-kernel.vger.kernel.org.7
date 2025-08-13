Return-Path: <linux-kernel+bounces-766458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D722BB246BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E1B169C11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A82F5485;
	Wed, 13 Aug 2025 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nhYc/d25"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DE21255E;
	Wed, 13 Aug 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079640; cv=none; b=oij0zYgl5bMY2R1ADJsO3ABlo4jXH1SVjcqWUt56uXSHgpv8jVztXp3lXtd2/zGVyUszfYF6JLK+O9BEHU7TYLGYzoHNtkrlbCu0N5fD19GcDWJblqm8sOrSk9J48ZK5zyc2FaciPyta0ZUg+jLxLVLOOo+xDucfp9uWsLB1+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079640; c=relaxed/simple;
	bh=yYcP5a1ehQTHlG1oP5t1L9Q7WkK94JZHMwZD0jDRjBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBdjonhp9P7IruBja7aiSXrY6AWgkK6Fs/PQnai/GGMWI1kJyJ7bgdbp/+id6Yn0oLz7Z7F69Sgxbj3bdJJeai9hZFz/GlUTEFFqagKePHJmBrZDzcxwq/K5qTEtxu+BeO+6MdGdEPPrxZrWadYk/M9RB2GT+xLbuXyAGPFW3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nhYc/d25; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53C3243AEB;
	Wed, 13 Aug 2025 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755079631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7UbX7wwdujFeV96LuYWTurrjLvi+YelqhVDF3Pcf00=;
	b=nhYc/d25atOCsZxnP1BEo73b0xDSNGkU898413PEZDQFCUgi/jl+A+7JH7vH20jh8/YOjs
	LdM1LNR+kiCqf0IvpJqxUZkxJACTkn9jRgelrng9Z4lSbWhOhBT8M9hiX/rzjkFWTDgb/X
	4N1EBLUBy8awRI84adTQSYNt+C2WnIZK7j+Ke50aNfBW4B8fjN0fTC6G4nyqAs+OgPZBht
	jywA83eeqdf2xFxU+Uyb3XGkSHC6HfhyiVBgbI6EQ/dZSN9G2DnURreLuaGIYlMGkmjcXi
	a0GWFTA2Ud24urjwlyzV/l78wWOVNxtF+xNzE+mQIwSIxEyqgK0CM1ArFj2qFg==
Date: Wed, 13 Aug 2025 12:07:08 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ASoc: fsl: fsl_qmc_audio: Drop struct
 qmc_dai_chan
Message-ID: <20250813120708.7d0303b7@bootlin.com>
In-Reply-To: <0e73d47d15cf38ad5c4c35fbab545153829dde75.1754993232.git.christophe.leroy@csgroup.eu>
References: <cover.1754993232.git.christophe.leroy@csgroup.eu>
 <0e73d47d15cf38ad5c4c35fbab545153829dde75.1754993232.git.christophe.leroy@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiffefgeeitdelleeigefhjeelueeuveekveetgeffheeltdekgeduiefggfdvnecukfhppedvrgdtudemtggstdekmeelkeeltgemkedttddtmehfugekudemleehgegvmedvudehrgemfeeluddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtkeemleeklegtmeektddttdemfhgukedumeelheegvgemvdduhegrmeefledutddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohepqhhirghnghdriihhrghosehngihprdgtohhmpdhrtghpthhtohepshhhvghnghhjihhurdifrghnghesghhmrghilhdrtghomhdprhgtphhtthhop
 egiihhusghordfnvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhitgholhgvohhtshhukhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

Hi Christophe,

On Tue, 12 Aug 2025 12:50:58 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> prtd_tx and prtd_rx members are not used anymore and only qmc_chan
> member remains so struct qmc_dai_chan has become pointless.
> 
> Use qmc_chan directly and drop struct qmc_dai_chan.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: New
> ---
>  sound/soc/fsl/fsl_qmc_audio.c | 50 +++++++++++++----------------------
>  1 file changed, 19 insertions(+), 31 deletions(-)

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

