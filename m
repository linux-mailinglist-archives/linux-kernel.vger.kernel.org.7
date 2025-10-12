Return-Path: <linux-kernel+bounces-849620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79735BD0832
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5F54E4A34
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BA2EC0BC;
	Sun, 12 Oct 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="q6JlTvvU"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC4185B48;
	Sun, 12 Oct 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288777; cv=none; b=rdskXYEiHh+StmT+lVBm0Fq5FO21KDrxptqUYt7m3crzZirAHxFGCfMkzIxzsqTKoP7azabhgKY94z7EdDMw0BZIUWpVeQ8Je5cWxr0NeSu19HeT2L3jBGJPUM5fO4NIb9RwK23FkHewGItPFbK1EM92ZaDzyhAPHLuxORZ8n04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288777; c=relaxed/simple;
	bh=iYgYChyaz/KPjA19EW7rulE5HR6pzrhDIHkATM0AFzw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CN38vSDcWXQGwPMmE4XJBFh3bS2vnY9c0UTByhegig/RKyzaHZg3t/7zNbvdgtNKjl6eiXLY6FJMfT7C1ltxEJF7hfJBYbw0372AvEJXmmW6qemAMyKRlTv0uJ7FhK6YitmZS1HovfOj+S73agP6WwaqkeJuKToQoRBjnuqmR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=q6JlTvvU; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760288773; x=1760893573; i=markus.elfring@web.de;
	bh=iYgYChyaz/KPjA19EW7rulE5HR6pzrhDIHkATM0AFzw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q6JlTvvUFwiBfnVaMFiNs52mgA5i49Tb9cCZhtILRKV15aoDhc++bQZTBO4u1ZR6
	 otSGv4lzcvDrIz2OniFMijsblqWu4GnUyizMHItdo4ewtdf6FlH2aQD1KZY4RXYtk
	 87fWmmRJuBuneKGB7oQetVANJsIkr75XlG/NagUcJJOOhoY/zjuyOGfVpOJu0vwtx
	 7V2cw7hQ9/MHAiIe1/rZUNkAShpQHOPg9NouoM8AxvUQWrFNbYVQg8PhTbR+aDCX6
	 y4zBQ0CHQwY8prbQFYIYrNOFSy9m8SO1yRdee1shcAO9fEP1pAjaQ2I32FbikW368
	 DhHdg/3byCnNOqbXQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1u9Ykx3ocN-00wEZA; Sun, 12
 Oct 2025 19:06:12 +0200
Message-ID: <c39d3a3d-0476-47f1-93f6-7d26b5793ee5@web.de>
Date: Sun, 12 Oct 2025 19:06:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Wu <michael@allwinnertech.com>, kernel-janitors@vger.kernel.org,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251011053719.87055-1-michael@allwinnertech.com>
Subject: Re: [PATCH] extcon: Fixed extcon duplicate issue
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251011053719.87055-1-michael@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5GBGw1kGWSaigzSz+aJ3Ee2wIAmahXLBCiF81pstipavJYJHv6N
 Ra8liLyHRUZ8iG5Qnk28n+xd1EpZc98nNZdREAsO2CmUHPZ3uZArpWT7BmuUeu9d1W94+K8
 GpmdZH+QRR50dJ6bJkY2Q1rbq0+j4qz/GEcPwiUkKiMkrWTBYY4R0/3LRk9JnWLFnBsO0HC
 1L4unBOKvNJtJYg+2nRFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mUtsa//cXK8=;hkHm14tnnGd5MCHmAuBbxQ8TEv1
 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
 wahpnc1V3kKk4w==

> extcon_dev_ids may re-alloc to another while this device unregister not =
complete
=E2=80=A6

Will another imperative wording approach become more helpful for an improv=
ed
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n94


How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n145

Regards,
Markus

