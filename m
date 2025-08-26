Return-Path: <linux-kernel+bounces-786150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC3B355AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8129920065A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B342F49EF;
	Tue, 26 Aug 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AzYzVGaa"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793D11713;
	Tue, 26 Aug 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193424; cv=none; b=hJqDxrKHYoXYPc8+O6/U1VwFS6eJguHPIOWzK/3Yzn8CNK/o2qDgWa1JOCj8Pe2zpe++LSYwKc1Mf7zcP+91cfU6WmjSejw9AeFrSTq1XgaIlTun3asSNy26YxlVESLyu8Asi1n7nAqYuAO0RmAf3D7FX29D3b2jwuMQUgwg0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193424; c=relaxed/simple;
	bh=gUz2UNny8CRb9FjWqKSsSistC+xIL9A8tJaC39E5Afo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQtU/6RrsVw5H/p7sUfFNt5lPaKjpxyfDNfquvrDfDYJ/jJqB9MbVioLIP15Ig0ywotHjmqLICkz0HMYoWwUt17xCoVVPLAO9qjMaILV2GHZ44CMfOODiwBc9mqF14corAE83cOUPKK3N6eqJ6j+mA2hfZtuZ4nQ774YbXLPJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AzYzVGaa; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756193418; x=1756798218; i=markus.elfring@web.de;
	bh=gUz2UNny8CRb9FjWqKSsSistC+xIL9A8tJaC39E5Afo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AzYzVGaaEXw+WyKb3Wmg5UL2BQXmLalWHeiFT/myqlUBu+EAIduZ78lqjvP9fgIE
	 yY/JtJ0qZ7BHixkVX5NzOYEf4Cww/GObKzEhmJToc6uBVktAS1FB3pzfYsvZop4C1
	 nWwLWTucRZo606B8v8BgvHLOF1WL22ZfpzIQ6CyDMaXaPniLSOc2/0f7z8mZQSQRJ
	 Aroe8ED7E87U4IFIXUuxCSeRqeSd7BhpuxItFgb+BFtchrdE29K/F0QGr0opgqo0U
	 yMTBXYlAm5SXdXNP5jvk+CpYDxPgUnX6TOw7pUDodvAkEL9MpwoZh9CoCaVnnd8ea
	 UtfScRbbNMf8NFaGCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.219]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi53D-1uLtEZ1djN-00mKI2; Tue, 26
 Aug 2025 09:30:18 +0200
Message-ID: <f24b6e34-a9ae-4bfa-97f3-95503a732a88@web.de>
Date: Tue, 26 Aug 2025 09:30:17 +0200
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
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uiTJj3M/UJOp3I+pqk4oCQE5TXqwBqOcS6PbYOsgP3NgBa/NZOh
 oQFXlRrT2mGmo0L1JfgYP9rQZZ/qpCOmNaAYkY3vDyJjzFtFRDyzyournqjVtC6diVfUclS
 Lxqr9Y5M9LwYDnlVUgsR7dNsw07Yc7eOOAqxVmDcITzkiwKboW6d1kP8UX8AQkxZAtHDr38
 yML8IdGVNW7UdJm/HUPGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8LYUcq8mQO4=;GBU0CG0fXpyUCGgV864gQlmkFVr
 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
 HW/UaY24gWp5WYhQGQUTP4fEIqte

> The default is exists for use with * and forall with transformation, wit=
h
> the reasoning for the latter being that when transformation occurs the
> trasformed code should be consistent.

Will corresponding development concerns be reconsidered in more detail?

Would you understand the source code search parameter =E2=80=9Cforall=E2=
=80=9D in the way
that it expresses a stronger data processing requirement (than the setting
alternative =E2=80=9Cexists=E2=80=9D)?
https://en.wikipedia.org/wiki/Universal_quantification

Is it known if such a quantification difference would influence software
run time characteristics in significant ways?

Regards,
Markus

