Return-Path: <linux-kernel+bounces-785067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6030AB3456C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91AA67ACD61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DE2FC87A;
	Mon, 25 Aug 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WtclVWaO"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A850145FE0;
	Mon, 25 Aug 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135061; cv=none; b=G08j9m4cmL2BF3XuyLo2ZW9AXs2X//nRXVjciHKLJOw0YVyQYissHj5lPDb17nn1uYCraSYAdzWPQHsNLU8TumBm0DY5N5GhJ8hzwD6YcS3b84fpV4yCRzWd4a1RZTIHMTA90nsNU8vcv9a7klaFxatPF42U6zYk6Ra8PcUKvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135061; c=relaxed/simple;
	bh=QINt26ELSmjV+ipUmyMAohhzNKqcYYp4NAX/WUIbR/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+kbmZC6WidMNiFR01bb5XhQj3WhWChXZ4bZBXXm3xNylVxZg115Ed9WapU5984TWKdbtJgLs7KhVvA9DrcfM/5Gf/ntXr36+KpFt21Ra8EYasw5GCfVq+MZhN7kHPRNJts9afG/Jn9r7Rgph1P8G2czgBeVpWcmwDeYDA9fb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WtclVWaO; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756135047; x=1756739847; i=markus.elfring@web.de;
	bh=fwtLws69isXqp5SL/nA3F4E6kex7z0gVjjRgxfCi2wI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WtclVWaO3uWGfBxp0CtWoMP2HU9dns243t4/NC64BpTl6DQ+O2FBz0gacqBDiRJB
	 U7myIvGV+bkQhMML3Lu0tTmXx3Bl7svQRIU2valZxfYG6lJmiyY7jnkBi+phAtsQ7
	 o7I0HzMXpbsFkLRXV0mk2dwa5GqGD+XYo8pLLccLKESYNkN6iRHsAcRQB0DuxyRHG
	 worjk6sJcUAtaQuL25LE8vxUS2Gvbg7Q5bk+OzTJZcPD7AXB2VN9KEKwyyXS8bKt0
	 QCpfLUtI7j2iQTflXseFAM6bsjmj8+6ks2Qo6i6E7vRRLHgQCyySyXtnuGi+pYzp5
	 j+/9P1wgtYWOa05dEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1vBeCo30Uf-00TYQR; Mon, 25
 Aug 2025 17:17:27 +0200
Message-ID: <a507ebb3-d87e-46eb-ba58-b9a872fcfeef@web.de>
Date: Mon, 25 Aug 2025 17:17:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtjb2NjaV0gW1JGQ10gQ2hvb3Npbmcg4oCcc2VtYW50aWNz4oCd?=
 =?UTF-8?Q?_better_for_SmPL_script_parts=3F?=
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
 <eb3e0445-39fa-4f4a-aeed-96eadc94657d@web.de>
 <alpine.DEB.2.22.394.2508251521570.3563@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508251521570.3563@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:x4AyKl9hl80Vc8sjRkVgvksE4klmJTD4j9kf2Xh9bOZwYXjEXCD
 5oaJxSAxT99/36eCJi3mUdVkP0W+ypelZV5sBUiX26cQI67WdSB2SOvdQlV1PIwCmSA2WYR
 xgChfC7HqTwumU6HS9BECxiN88GyTTh6O8KCIqX6D40juSM1ca6pfGfXcGias8EncvKwbTS
 HACngJmZElcx9aAx8AKsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:krr6pKgfMGE=;glvh6vJtUy+VKZ563OK2qMubdHi
 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
 mz5y6y2V9m1SBV7jCqchwIb2zn6W

> The default is exists for use with * and forall with transformation, with
> the reasoning for the latter being that when transformation occurs the
> trasformed code should be consistent.  But there are cases where something
> else is desired, so this is controlled by the user.

Can SmPL script developers occasionally get any indications that they would expect
an opposite system setting?

Will the usage incidence become more interesting for the mentioned source code
search parameter?

Regards,
Markus

