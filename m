Return-Path: <linux-kernel+bounces-879529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC95BC23501
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D0A4036F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2112E0905;
	Fri, 31 Oct 2025 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DN475Zlf"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907741AAC;
	Fri, 31 Oct 2025 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761890483; cv=none; b=QUPAaTIKvE3jokl5+jS9dllJeDzyYUNyW7wFbYAUUPHE52uqp2mP1jTm5RukwSmvL9IBV/EX6uUNfHFeCRKtEXw1gCx/3CsIKg9N383Q65l4QNcSRND5UUNaBdIaEDoE8q/OI4ryNo5ns9K7gcisaC3fGTLDBi+mNz0bEDXo6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761890483; c=relaxed/simple;
	bh=IVAXgf/4c1In86Y46ZsZTrIlCA0GDCamQnuYiJZpFrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9UbsXW2BrY/xGlrJ0HfmO8Kls/IWSZSMHdVSFZb79rwZeiWZIVNs8W+WqXBeRZBkbzUjp+Ia7Fd3cQeB8LSiau9JnusigFh0Sqaf2+7NbuX2gjMnVC0DSb0kgJExPnKziRyziD+M+/yWE5Jx3LgHs8sfLbbiY0Bt5ApTnD2VjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DN475Zlf; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761890477; x=1762495277; i=markus.elfring@web.de;
	bh=aaD7SmVvNirUVU1SyVtpmfmSup17ggQJA0B2lH9gy/M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DN475Zlfb9OrFlz7lv+MyO1yfTlWnIKHzLps+hJgH75od+001EC4WrldK6VUzT0+
	 Wc0yQ1A42/90cJGfbli1KkiuhLYDj3NdDUbOQPcObO3kfX0YUom38/5KI5kbMeRc5
	 5KZmRMuOGXLpe96u0uWNnS9Bl/u1L/aglW+7l2Foy176ILaHIOV361TFEloSF3CeN
	 bcD2Dz9pjv80K3k2hk6fbEpFaqZtMccu8lKIJ32khW1gBb7rp6jVAASV2MHO8m5fW
	 n1lNmlhfIAHHF2ml5mJA9yvb18hdayd0Tkh4sM/h4u+bupl2e6B4Dz0cM71Slxcct
	 DnV3BM9rK5eIph5N1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODmV-1vd6qC2wET-00YaqS; Fri, 31
 Oct 2025 07:01:17 +0100
Message-ID: <8c401643-3fe6-4511-b55f-5d7643ad4fa3@web.de>
Date: Fri, 31 Oct 2025 07:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments from
 memcpy() calls with SmPL?
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
 <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
 <aQNsecHJSO2U68Fc@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aQNsecHJSO2U68Fc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fJSFIDjBuqyXf5xK4j0b9RLZt+tcFKODlrlL/6uCZwrrZcr8ki7
 OxyYJ6KZ+XB1UoZepXahZTmCxJyoAm+A3SaVlzDjCUBfG/v9veAIPVpn23AURgFHbSX0okh
 MWUkwbg/txF7RnFxT00A/hvl1mEVVQ20+00wNtKcR5KM6uefHsv2aEFVxRcJ4TrNTAQoR4V
 7pQ2IH1z5gS2H51HMUvNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5G+lWctbkEQ=;cAEhZezXAH8VvydVLnyZlocFqni
 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

> No one will thank you for making these changes...  :(  Please don't do i=
t.

I am curious if further developers would dare to try another source code s=
earch pattern out.

@display@
expression destination, size, source, target;
@@
*target =3D memcpy(destination, source, size);


I would like to point out that return values from memcpy() calls are assig=
ned
to variables in 16 source files of the software =E2=80=9CLinux next-202510=
30=E2=80=9D.

Under which circumstances can development interests grow to reduce =E2=80=
=9Cunused=E2=80=9D
return values also for this kind of function?
https://wiki.sei.cmu.edu/confluence/display/c/MSC13-C.+Detect+and+remove+u=
nused+values

Regards,
Markus

