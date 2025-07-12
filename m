Return-Path: <linux-kernel+bounces-728711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE565B02C26
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE802178358
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C36F073;
	Sat, 12 Jul 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MbLRDx1E"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D91A08DB;
	Sat, 12 Jul 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752341636; cv=none; b=EMfLEayHuzaGzE1/5aWezQ9x+Z2+HK+KgGC+8pjQLmks4Rtc3q3VkCqOCexpFxSnKkU9SnZqjBbrTLPDg0Bqol++ckDyEpE5OhX2anrD7CBzlKoqIrmiXgpberfHpTWYbWe/vJxhDnjup/shYLdfRMs2vLE/4+9bxW710AfXpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752341636; c=relaxed/simple;
	bh=EThqgNr6iAXAwuxksWSrX8Z1sKtuy/1+pm6zZjqgVJw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mHG8rnE/6uIj9tcyJB8GNUfbrVNuwljosK4CHgteq8AgWduMVVd6ubGTk387oP47B2zqFIB1/0Bh1v8uxaIy/p25WvkpnA32B1DJOG0vVwwf14rnBm45RQD7aMFXp+VC4sJP04aZJuJxiwxYhn11xePK/GmBu+mPR+++k8MCvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MbLRDx1E; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752341615; x=1752946415; i=markus.elfring@web.de;
	bh=4NS8mZYzapG+D/l/cE2ID034f4faZq402mLTgvgAX/g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MbLRDx1EcGnOVgdq7Ud5R+X1X/sbAlrpgOS+9Bsw942YtaUAT5b38F3P/DZ8034E
	 DKimv6M6EXziM7ze3wx6GQILoSgF5+HxUn4xU0A7Izks6XxtZXb+JT4e37RzVReld
	 V+Wq3ICNSw7evl1y5FYac8lTyiwl/OXoum/00Vfr6Yk7E2xM6eTBGCPShLXJ6w5iO
	 w+xVUB1YDZXQigMJ664tUKNduJERueCGEt79wYrPxOwbH0ZVtlLKhG+SYiJl9N2jb
	 tccPDAX4wHdMBpel54eBV+CSB1zo5bHaSGnwVhSpVi2zWjd5rUTQMlr1N4bskvAM9
	 kaRzTtV7J+micDPi6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.234]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJP4-1utosX0mfS-015Tqt; Sat, 12
 Jul 2025 19:33:35 +0200
Message-ID: <6a4de937-f433-41c9-9c28-2f46070a3cbe@web.de>
Date: Sat, 12 Jul 2025 19:33:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Fan Yu <fan.yu9@zte.com.cn>, Jiang Kun <jiang.kun2@zte.com.cn>,
 Wang Yaxin <wang.yaxin@zte.com.cn>, linux-mm@kvack.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>, David Hildenbrand <david@redhat.com>,
 Peilin He <he.peilin@zte.com.cn>, tu.qiang35@zte.com.cn,
 Wang Yong <wang.yong12@zte.com.cn>, xu xin <xu.xin16@zte.com.cn>,
 Yang Yang <yang.yang29@zte.com.cn>, Yunkai Zhang <zhang.yunkai@zte.com.cn>,
 Yutan Qiu <qiu.yutan@zte.com.cn>
References: <20250710135451340_5pOgpIFi0M5AE7H44W1D@zte.com.cn>
Subject: Re: [PATCH linux next] delaytop: add psi info to show system delay
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250710135451340_5pOgpIFi0M5AE7H44W1D@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hfviwZXy/62jRnzPYjaJrWzLtmoVU71wF2tSJwXkRzXJ45pXmiJ
 2BpaPBdyq33CzA4+OUVykj3mXbiT1CYOGsZUUOGqRTYAkWw0gIx1wH595cR3Fk9FubHgsd7
 t3MTE9qYcDg7+fbb81NvANnXB3dQtxpzy3il6cpiQtWkWcxvWBPgmIEsE/mTIVHV0aAfKPM
 zGPLKMp8QF+QjwCtrna9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rLKLs9MnSUM=;giyA5HYZoVWPKAhdPKG4m4pDEnr
 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

> support showing whole delay of system by reading PSI,
> just like the first few lines of information output
> by the top command. the output of delaytop includes
=E2=80=A6

You may occasionally put more than 53 characters into text lines
of such a change description.


=E2=80=A6
> +++ b/tools/accounting/delaytop.c
=E2=80=A6
> @@ -549,7 +659,29 @@ static void display_results(void)
>  	FILE *out =3D stdout;
>=20
>  	fprintf(out, "\033[H\033[J");
> -
> +	/* PSI output (one-line, no cat style) */
> +	fprintf(out, "System Pressure Information: ");
> +	fprintf(out, "(avg10/avg60/avg300/total)\n");
> +	fprintf(out, "CPU:");
=E2=80=A6

Under which circumstances would you care more also for file output failure=
s?
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus

