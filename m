Return-Path: <linux-kernel+bounces-816983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3B6B57BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BC1482B74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAA830AAB4;
	Mon, 15 Sep 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mMoPOI8X"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A730C353;
	Mon, 15 Sep 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940785; cv=none; b=Cxi0Sqy5VAVzi9I/xCYqTC/trAp8W7+Yvnh6PVQ7ZSlN0R64wYJa3DFZFxSEfYHpdlOMZxJe6syoerTNlelYtZi5N5sYL7+BI3boDv9CC9PIEvZaA2PO4UwtTcWjYbn5ExiqyfK9adpTKvHq48r2Ee5iVy/wQlRHSdaV8gD44UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940785; c=relaxed/simple;
	bh=aL4Qgd/f/cCSS0Jr6BRzw0CqiHGgeWrjUaS3xP+EKz0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gh2wsbbndVGBdAWop1gOiGZFWHEacMJyiy4AN94WgE+vJ5ZrZYbKIrjkSZqHC4LRxp+VVkv3LNtMbroZyrIOtblcmwOqNf598SPYH84M6Lan0hEMTp1bDFee148VohlljKZlqSwCBK+CAJMjhplkkpxSl0YNVszaVC3yiQbqDF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mMoPOI8X; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757940779; x=1758545579; i=markus.elfring@web.de;
	bh=NhtemnjAxvA/8fLmGMmQnGfrrMMgLd4Wke3MQ3tQQMs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mMoPOI8Xh++OUt8eTfhiOluSnH5J0jbCut77qsptn0RgtNczA+ZicUg7iLBqNDmt
	 N/4CxbfmfG7ImBl9C7H6DwHEEX6pvDwsjoJykN87LNJAbPekCkczbss5slqbtxZYA
	 CAC31eQs2LkHaAyEBsZZa6owEZBJmYmMfw+AIpN22au/teBtG9AKa4pjOuaMyWTqj
	 gXxfxPc8RegMbsAhSquHUgzAehCRcZPNVJ3BfxYXjDd2YRUF7JoBwsa+Kw42ufT65
	 Q6cMSGL6u9jDWnS2G1F9WmChom8yWsDthqi9MOW4W/K0oZleW9FMUEo3XNx9BXNiA
	 5Lk3rFc8NJqGqJ/Xpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.188]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFrxl-1vB6ai2Sit-00Di0i; Mon, 15
 Sep 2025 14:52:59 +0200
Message-ID: <80453b77-01ca-4fff-8a5a-deed4203be0f@web.de>
Date: Mon, 15 Sep 2025 14:52:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jin Qing <b24347@freescale.com>, Li Yang <leoli@freescale.com>,
 Liu Gang <Gang.Liu@freescale.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [bug report] powerpc/fsl_rio: Missing of_node_put() calls in
 fsl_rio_setup()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZWxN3Ysz7mZYnylO6nqSUzTVLku6/7Sr4VvsnGOn1UNtzXXh8lq
 hhbS/eTW8oiqPNDG6Rrum+DkZxXhTWbACybnryoGioY493DKc0cxvv+f/T+8NAfphMIooIJ
 bt4FVnEl1EeM0XnFaD6knIrF01eFQgd8gzV7EUdwxKtcUzRHcnaytQt6LeThujLQHNA3CnQ
 vs3bFkT34/0HDwOLURgjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fdo2v1V6qYQ=;RVEu5bZXXdqN+ry6Z6wTdymA4oZ
 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
 UBiiGgQfTPljXsGrE1O

Hello,

Another script for the semantic patch language (Coocinelle software) point=
ed
details out also according to the implementation of the function =E2=80=9C=
fsl_rio_setup=E2=80=9D
for further development considerations.
https://elixir.bootlin.com/linux/v6.17-rc5/source/arch/powerpc/sysdev/fsl_=
rio.c#L439-L731
https://lore.kernel.org/cocci/504107f9-09eb-47fe-96ea-53e375b17eac@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-09/msg00023.html

* I got the impression then that the function =E2=80=9Cof_node_put=E2=80=
=9D should be called
  in more cases here.

* How do you think about to avoid a bit of duplicate source code
  by another update step?

* Further implementation details can be improved.


Regards,
Markus

