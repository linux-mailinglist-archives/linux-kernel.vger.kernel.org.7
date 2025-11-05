Return-Path: <linux-kernel+bounces-886024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFCCC3485F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48ACC189E4DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49F2D8362;
	Wed,  5 Nov 2025 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="T35NmjqS"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046A2C11CB;
	Wed,  5 Nov 2025 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332225; cv=none; b=g5iGKPsKCnmR/vPe4yeqR28DIxU5GFxJudT1F4myqYLKYGehIgv9EaXAVx3i9xe7NNuxZFTmDaPC5D+mSfHzutselWruUvKpTWJ3mgtxF/XVVWho/CFpZajGtq4OjjRmdFKROJqhMx+8kFoDKoiH0GEEo8cdAogxIoyTQlpvj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332225; c=relaxed/simple;
	bh=kyvmScF1q46X0xETLtdOfR7f1firs4um4U3fpCPBj8c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XH9/YTbM0NTqs+Ht9I72uzD8XDdhR7NmK/ZpA5UxvDfzLFqVB9vD2OrNVOO7osE6HeEd6iHYtsEdc9dX4O0kVO5ps5ec60oBIb9Xq24ewacT3ohxFdfZXAACNqVyrDHLaXyVsmfUYCnv8CnZujJa16KzPeDGIkvgdt/B/dNthaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=T35NmjqS; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762332213; x=1762937013; i=markus.elfring@web.de;
	bh=kyvmScF1q46X0xETLtdOfR7f1firs4um4U3fpCPBj8c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T35NmjqS3LQqr22sh9MCvsM/MMLa2J8cWC2RfEeQOFFyzE5agd9UYe75Y4JC5q77
	 2I3ucw/kvrwbAgj/OPgVreVLb5dMlK1rpVAVGsQ4RgaR5SyF1TRHT1UsKrMHSBK2+
	 3wORChDbTGkw3VaLI5+4+dbdRBWkIBhDy/DvjNGkXDqycmx9uVskz28ZSRback4oW
	 U04AZvS+aLOMFnhUqP+uMS+Vi6hROYNL2mK8ko8EZl9vaOqXe06EaQCey3XQKlQ0f
	 JfFTXuJ6sBdKy2b4zpWrS1Ubj8bcPTZbg5zL7Q/37oNzNXfITsAbaQZ5wdY2qvDiZ
	 W/re9V8ANFO8s6J+UQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLifk-1vYEWT2OWm-00Rf9Y; Wed, 05
 Nov 2025 09:43:33 +0100
Message-ID: <2f31c494-b655-43e3-aa6b-90c4594d1d44@web.de>
Date: Wed, 5 Nov 2025 09:43:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com
Cc: LKML <linux-kernel@vger.kernel.org>,
 David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>
References: <20251105062246.1955-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: cs4271: Fix regulator leak on probe failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251105062246.1955-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TQBoP9qA5kdAGSPCPwhK/LP4jZ8DcntHNXKhX5GMvTNUw7gp219
 cbbg8k5QmGoPGI5iVjDc+DoYMbh7Q5S09GlYJsMwiRJcB4z9Jh8EmktNcgl16KrQMBazRjw
 3d3g9bAUANATsWvAoJmMm1HQJy1PINr0MSAR5c58WSD1a7v73JmKVtToH74qM9gFMz3wMZ3
 CXz388XDwUQ0rrpwy/E9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rc0ms5IoPS8=;2De6hPNDgOZyDVBN4pt7Mf+2f4O
 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

> The probe function enables regulators at the beginning
> but fails to disable them in its error handling path.
=E2=80=A6

Would an other word wrapping be a bit nicer for such a change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n658

Regards,
Markus

