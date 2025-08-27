Return-Path: <linux-kernel+bounces-788771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2204BB38A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F7B1B28476
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25F22D97A1;
	Wed, 27 Aug 2025 19:18:34 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2A2798FB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322314; cv=none; b=iMssTPcPvKQo+kQy+g3H82+gX8EtWaulWjwa0gGRMcmn9iXKLUB22o7qXAvRs+IIZo4G9ulZ/PuKav85l8DYziVmmd1uuFFSQMIYUAg2VA1vk4suZ2vKi3NAaYezGzFTMSiUwLaCR8qM0MWygKhLz0VrkvMQk9iWCv5CZ2eO/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322314; c=relaxed/simple;
	bh=zDH6u+RWXXPp2FGKTHji8ygz+V6812kSW0oVZm2iqfM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWQJH9AZma739teXozLuIlPB0BAXsIE9JC5OJiGq3YNFZeWBjYw3RAI4nL2yjV5w4OxAT+jKbK8mmDNC7eVBhYxNlrFcfkwpb/bLwWGb73Gc3DYoodqiMbeX0mtAYF6oh6lpFKyU2fjdQvj61zviAZGaAT/Df95aS1xtoMv5n9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b694d5.dsl.pool.telekom.hu [::ffff:81.182.148.213])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088D3B.0000000068AF5A06.00235C4C; Wed, 27 Aug 2025 21:18:30 +0200
Message-ID: <6079552e9c2e62ef84c835cdf81d7d70d8987031.camel@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v2] ALSA: hda/tas2781: Fix EFI name for
 calibration beginning with 1 instead of 0
From: Gergo Koteles <soyer@irl.hu>
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
  "tiwai@suse.de" <tiwai@suse.de>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
  "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
  "13564923607@139.com" <13564923607@139.com>,
  "13916275206@139.com" <13916275206@139.com>,
  "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "Xu, Baojun" <baojun.xu@ti.com>,
  "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
  "Ji, Jesse" <jesse-ji@ti.com>
Date: Wed, 27 Aug 2025 21:18:29 +0200
In-Reply-To: <3917a54f72134949a4baadd706463fa7@ti.com>
References: <20250826094105.1325-1-shenghao-ding@ti.com>
	 <8187d109eb70f6d459df63f3507a0be79efd9aa9.camel@irl.hu>
	 <3917a54f72134949a4baadd706463fa7@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Shenghao,

On Wed, 2025-08-27 at 14:15 +0000, Ding, Shenghao wrote:
> Long time no see. Thanks for pointing that=C2=A0out.
> I'm preparing a new patch to correct it.
>=20
>=20

Yeah, the amps worked well, so no need to write :)

Rolling distros are moving to kernel 6.16 soon, so I'm worried about
the speakers.

Can the amplifier protect the speaker even with completely wrong
calibration values?

Thanks,
Gergo

