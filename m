Return-Path: <linux-kernel+bounces-873235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51069C136FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7AA1A23D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE12D6E66;
	Tue, 28 Oct 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GY/zisSt"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141112AE8E;
	Tue, 28 Oct 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638762; cv=none; b=P/BX0wnasKtvi+MdpR1Q+PJBd93DgCLLXA8rAEGplQWDrhjhscEwwHV1QcDGVg0BJ3LKlRj66eh+vEt/TTx77mcKjqo9HxEHr/jY5L1sLqICMxQ+RLDpRKxqRKdB+5p8ifU9W12BSiuonVMYGoaONCtuz53ETnXpGsLzPp1PPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638762; c=relaxed/simple;
	bh=wukHgSJEsIfLqQNCLz8DHKUrsiZCB9S/XmD1bR/72d0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=G9LjUrxQod6M00OJ5p+yB8tXqCm+DhTd+4WOVzD4dCEO4cVaD7GKZfaUqpWkyIzCB+mg1hJOtAFu3cGPZ/gnPGmmIOlv7scpbrjf9I9q4KtgKUCuIpX1YicNSJe03cQ6UAftj39qHTTOuszm+8ynVVsjsW6Daoa//rhUCylmSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GY/zisSt; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761638740; x=1762243540; i=markus.elfring@web.de;
	bh=wukHgSJEsIfLqQNCLz8DHKUrsiZCB9S/XmD1bR/72d0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GY/zisStLplILsP8TJSLH0qYdT1Qc1ztiyPADCv16nrr2dtGl0kEYuUWi66YS1fQ
	 lFUp77dQDD6kQzjI1mUeaDe56dgDLGoOJW2FQYcJo8EdDeZsTuVWDDCmcwpaD0OmW
	 POwSSD55GVqwi9KYoRJrF8O4leXfBbVSsdqXSc1wdCR+IorekLeRzEXFjNg8F5GSC
	 7q+TsY14D66qq2eB+nWOZphpHjd7h3kJE7hhA4/2YoXwT8GA2FAFxiw+R63YTkmFJ
	 cbT5HN100E0Bqc+Gp4wvJRXee1Tn4IgVLHQ37BHwue0oOb7tel895c5lfOmVHrTvR
	 SMOCs9f3hlpoDyo0cg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8ai-1vZZH20iVU-00SQtV; Tue, 28
 Oct 2025 09:05:40 +0100
Message-ID: <10746054-4f16-4e02-baf8-159b03926333@web.de>
Date: Tue, 28 Oct 2025 09:05:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20251027093818.1806010-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/1] checkpatch: Don't warn on "orhapned" DT schema
 file
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251027093818.1806010-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JwQ/gMlUx551jwtC2xcmfcWhs887HAScw4lOZs1iiUFEGWdeJGE
 FMpVnp7VZu4Qnx1UaTE5gJuGmPCdcQMvCk0KTtYUaS4Sri0v3mKG6mjYyGGgXFyOAeKABBv
 8VwdSElOHbW0HJFq3pt4fhv9QOxA6qc4QvEM+wnlfonX87/D0VC1eG8R7cq0h/kNqMagdBl
 /c+dNNomFwnERoa/UUwBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pr9pD8U074M=;bnm8C40kepONA+jVfPNMDejhl4z
 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
 +y5nUb3KefMoCA==

=E2=80=A6
> Hence, avoid checkpatch warning about it.

Do you try to influence software evolution any further for =E2=80=9Corphan=
ed=E2=80=9D information?

Regards,
Markus

