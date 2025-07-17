Return-Path: <linux-kernel+bounces-735496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D704B09024
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E541889F31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09322F7D10;
	Thu, 17 Jul 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Y5BO4wZ3"
Received: from sonic312-50.consmr.mail.gq1.yahoo.com (sonic312-50.consmr.mail.gq1.yahoo.com [98.137.69.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46F29C33A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764675; cv=none; b=qWX2DCZyWMYoTXNHfsqZsd7Ntv55nP8ZN8BNLu9Kuze90/CZ4QJx4uKpja88P/GOl8XwQ5oM2Sg8QQxFxttbFxmLq6Oio2fBAAdSYIr1kYucYMM8fZpdbvZjiTbtxzPmTzMF3pJdOU+STi5EonG3Mw4mCPXVnQzyJYIKOZkaCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764675; c=relaxed/simple;
	bh=qph9+q1rOcSsRaYShqgMocS+6FgNwJq9ZDYiIPJt+YY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version:
	 References; b=CliEKzl4g9Ub/eN23weekhikAA7eSQrHt08xOFV1L6bV4aChfNDw90Lh9Jseh/f5fVdoXhCrr9vym/H6A9CzxsfYDS7SUNQxWwRhBmQBe85t+je4pHW5ecHnF4XBICk2WFGl4FFA5D8QtXtqLdERVtgO8I5fx6AmA0+ys4yCUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=Y5BO4wZ3; arc=none smtp.client-ip=98.137.69.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1752764667; bh=D9iUuabqF0YH5VxUkmcyijJUylhadetT2e0qPHlIxFM=; h=Subject:From:To:Cc:Date:References:From:Subject:Reply-To; b=Y5BO4wZ3D9j+HvUhl0HWelZ6lxmNkjrprggVakkYf3MNs4U+ew5LfoomRhA9QQkyZMBggxVDOV97Mouy9Fa2fmQohnji04+5pWlA5Xrf4NI6c9XUZlRBxDkRoAIGTs1tqxwnSROHtfF812RltInw5p8c19s+jcgOIhUI8IWwnL2AwiTXqZoKQEIAVNokMnJ1+dlQMsgiW+B8pJcZilzG7ZLNfUdIV+ucAc1gEfEPsCkRcJuGTlwft9Y6AmAukhT+bwKo66hbKGq6PxK55Amtd/IJte2Fv5vXU4ec5z494TPBBYpfypKdWVMmB5Z8fOULacAUl6qeENcCIMsxVjuQuw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752764667; bh=5KC/HpFzulTmfsKz+UTOw9DGS7ufB4r1a5dg+UTIQDQ=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=AUczxSIrF7x3E9wF9t1qhCsyNBZNAAXMmTfyhdke1Yq/zOsle1ckeFXp4L8hdlgKZ/ttx3bV+bchVlhs6TJS+ipy5mNemw7Ms7pVfNtRXt+RUokNlTB2VbroY7waOAbNvxTtNnzAZ4xMCNYMURMFcetK/4gDF4BTilOhpJxIyr4CJq8ZR6yv2c0w7PwBbSthpMVb4CD82AziMys9KT3CM1ukkoSOx8Vy9Gbau6Aw9cVddIZxa1Q83hDZanvK4n+tobpfjZBv8ep8pPmNtjIdpuRcHVodmkyFCW2+CAI+kuyF2cazGmP5XKSKKZ3RSl7q4ijTZZJEhDwrB03Z5jWkog==
X-YMail-OSG: jzuBMS0VM1lZLT0M2x4c5R7WDWpyfZSyppHK7x7w5NINkNJbefb_AVOhmTe9WF5
 QOJi.smccwIcfB.B0OMlzEPtw._EHpWjurY15.jWZacMsbSsSpDxU6EO6k.FPabjUK3VZNXuDTXH
 rINTBoSE1NgWSFRIZ74tt.Ncdsh2k385iNGH7NAoAjkzOqu7l5Qr7ZJsvImRFTHZM_i6wjSDgtDa
 e93SWjkTXEcLSzsL5w_OTXP.Mo68rjZuMH2EPl1zzTLeshi23UxzGnwOwEjfA4JHjiq2RIXMKK2H
 .__aQEAkUbZYwnrxRNEQiYi8F2kQZq8PbbXqfL8kQfqZJttcqtOybvCsyNURbBlkr2xl9zq2Ou_.
 u_80QPqLOF6JqA8UmCHR.Grth313MCMGdrz1e37Hhlw2hCSvP8XlwV897d3huuwBfQmcVOq3U4EC
 bDJnpg0WDy4HMSW_AAkemTFIwRQ07P3k.ph_TQvT4Ar2OrZiqYtVHdJtEs7UdI2TG7910KAAr9VS
 vXd4RrEAM4MZuI2hbODWMeCUYpOX3TieCyGdbzclsg92EdElMNsOasrQEC3BP7k4S4WwX_62Rich
 AbNruzHl6clXPul.q0NxA0Ph8nKImKN.6esy1quSCGSkvX3knBFsv3D1picP9qCyTeaR3CcNw9Z8
 qrB71L.ts.TPO6WGuhlSOk682lYipO_rYP7nmg2QZBWAHZWhZwjmqlvNCjeu9m.CAQmTKiVFhXl_
 Xn7BUJp8JE9qz9vuz9gcvvhWWTcd2BN1kuoeZ.oqCwBQ5krs3klYbOyRhwWc8M9WKpdIzQbDWSbR
 wrn6iaRo8g8ObIe.mQJ4MYxVldHUXFIeeskQryVvFyf9VFxabwwTBkW21XLkFJR6BIIiSx69.72S
 08yBOoBypZWuPonyfoyWCsJC4WQ.xJQptIX9kyNmGP48pmZdGdR5tkldESuj3Ygf1f08aJtzMlXA
 Zl8PQdq.03D8Ye1ahImH6iiBa5EcSMS_vAOnJcHB25InO.ukq1qLW5QrDu72aBUV7Kbbj6Pc6q_d
 02phUQ8I2QD7NROjRrQBccxIlPFNwSdFw4q5p5laZhN99w.AHc1B4t9boX5W3vkymg6UgGAOmMjS
 3wk9heY8hzgKjZU4qhDLdp00eqgsg7WlVXn_TVDneEKUSMMD9WkqOIYd8fYEjKJpooxfeq406IbV
 j0y5qxt2OWHPF0J54NDkzq9hw_poyfrFPbloyAG_7Asj1I4YBvtZy6koRvwI9gII.OyE3VeGhJGF
 CFTgQrQab5G2PPH88C1cl.62V.PxSIgYXCj6A.9_nqgB4uf1GJ1Y19URrPTvzvQikOt4JKeuQF_U
 wcLHv97gRw7TtUxKsoy4vhVOhFm9MoouzoidWlNPXjrMB93dKFZbBb8sV5CE1Zpc.FrhXR42xgaw
 VjTrtlKv3fpA0ESzzx0RWuU93Tgltc05c99Zze2bx0Uw4B8BEaICKevO6ygJSNW7XDYfoWIiKGIk
 17_XGpHGvtMSKbmZccTW4ynIWcbjvp6GDMER2Gm0t6.YX8RXT6Nqw73rZQ307bkbdFLWxhkIwCar
 fcPRYwhtz2tMJl3uFQY2U_A.5eDN43qq6WzzXbDHcJoeIivEgEONXlBaqczRbKmb0Y.70pa9FZUV
 ykTz0_XvAk0uXvhF.XoPd6.VzPWO385Y.4urcdLltu1IdyieqaQ6qmZKQyopffRerjYH6f0ujwHN
 sIgtro6.bolv3VsdahQHF7es.q4cdWMrLKFj6M66PwCEkGIr9jFe72JjHcfCNVCN9iNhZ3Hegx4Q
 SFV.kS_C46kdQswTO3snA2BGbgsytZPrXCXraHHvKaAqNyvioKKPf5b.8lkATsVnx85oQikQRqGJ
 SLsx6d7pUYEkySaqpFej0UlArGt_PydepVT.DXueRaDdlI8wd7qAkWtGKjcrhKAMKDs2b.neqLZw
 7gjEWWmnvVg4Ju0_bH7ho1IjNHrsGHVnz1c4zSspbCxwQcSFM4lwtMFp77n2O1roTzh79eWxWnMT
 rHDhLB5BHeF02eEcMV3fImqX7wtRCLL.vhUuijj1DgHUutmJoi9VkrP5wsgCOdMaXNyhmrKkz2QD
 IuvWO1r3Mt_an7p9WK35PtBblSdusKQTgkEcfo3uEK2i2.W_b7ThT8ZWw_DUnKQOHrvPaExlxt82
 xoatbZzmMBbQVZPikXZTMdoaELLjHvkcWvwIWMSWWNMh0hHsyrasTMfbBMgGaYWeYOadRq5J12kM
 eHZ1TW8rZ7WwO5zLSe9M_DA--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: a3ee4bf8-e3f2-483f-bc3d-4080f96275fb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Jul 2025 15:04:27 +0000
Received: by hermes--production-ir2-858bd4ff7b-rsjdf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4d525182e20f6561a12343f19593cf10;
          Thu, 17 Jul 2025 15:02:24 +0000 (UTC)
Message-ID: <2a6afe3532235c7b76758163e2439e55c93df241.camel@aol.com>
Subject: DRM GUD driver debug logging
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Jul 2025 16:02:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a6afe3532235c7b76758163e2439e55c93df241.camel.ref@aol.com>
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

Hello

I was taking a look at the code for the gud driver. I am aware this
driver was recently orphaned and I wish to get up to speed on it, and
maybe with enough learning and work I can take over maintainance of it
in the future.

I noticed that in the function gud_disconnect in gud_driv.c on like 623
there is the following code

	drm_dbg(drm, "%s:\n", __func__);

checkpatch.pl marks this as unnecessary ftrace like logging, and
suggests to use ftrace instead. Since (as far as I can tell) this
effectively just prints the function name, would it not be better to
just use ftrace for debugging and remove this call all together?

While it isn't actively *harming* the code as such, it does seem a bit
unnecessary.

I'd like to know the DRM maintainers opinions. I know this particular
driver does not have a maintainer dedicated to it, so I'd like to know
the opinion of those that maintain the subsystem, and anyone else that
has any opinion.

Thank you

Ruben Wauters

