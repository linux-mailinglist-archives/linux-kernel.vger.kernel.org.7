Return-Path: <linux-kernel+bounces-800934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D3B43DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72887188B0D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3E2FE05D;
	Thu,  4 Sep 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carnegierobotics.com header.i=@carnegierobotics.com header.b="I7F26DmQ"
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07EC80B;
	Thu,  4 Sep 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994299; cv=none; b=d2A30Ar8bHH3CM8cJo/UtQT1nrrr2zoV8osd2KlEA2uJcxMVOrDv8Kn9oIxeFz/Yijf6VJtMLxG6Yt3EQ99Jl8bKF9R6tiyZQ9r68F/N7JlgSdFPZGcQ7vHTfzspbEMoHUh3TLK48tmUVXYzCgrdfhY/hCQd6ap/raR5R1OYgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994299; c=relaxed/simple;
	bh=FyQVmPKdaT/PkJs991N1QlbU0kzmR4Goz8EZy4SUIfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=alddWk7X7p3ICjj9lrpUntz0OI+s1H1yJp9z8AufA5VN9YHLMIgCjKulXIdpJqXEVKCV5PjlJuElwyh/9GF2mEO5bgrUdbNiWhBOFT3TONJMvE4AFkjL5qnavo0TJv8ut679DotQJlsAPc3xGA4tley2u4SOLcw5iEbIDGOO1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=carnegierobotics.com; dkim=pass (2048-bit key) header.d=carnegierobotics.com header.i=@carnegierobotics.com header.b=I7F26DmQ; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carnegierobotics.com
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cHgzq4bhVzN6mZQ;
	Thu,  4 Sep 2025 13:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	carnegierobotics.com; h=mime-version:content-transfer-encoding
	:content-id:content-type:content-type:user-agent
	:content-language:accept-language:in-reply-to:references
	:message-id:date:date:subject:subject:from:from:received
	:received:received:received; s=mr01; t=1756994292; x=1759586293;
	 bh=FyQVmPKdaT/PkJs991N1QlbU0kzmR4Goz8EZy4SUIfc=; b=I7F26DmQGMGN
	qcUlbaTOfTGGTb7WTY0C2mX/XcXYhXxmHcgpG2wqtLwOMs5NzTSigVSV9DngDhaM
	fppQyQ56DT714bZybEiFTeoJ4F7B9MESGB/mXwDhTF4WbDntcIlHuPclLhp51c6z
	UuV9bhCnYD08rzJrIqZ5VCsppuH+AFkWlefWMlRsg9/mQY5PgczYn4xFT7T3022h
	68Nl57eMcZeK2MV4UDxe4jSp5/npsDS8IYH7Aic+jBm9JeWwYnmQ57ouzqYa5UNB
	+GsdAbGJYxt+gmulPyJEN7mqVjKwgNenUovyx0Mgk6QVKZAXMnTvqBJKPiEtB/MO
	4MZYfjIxJw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10026) with LMTP
 id I6mZOXEt8Ygy; Thu,  4 Sep 2025 13:58:12 +0000 (UTC)
Received: from mail.carnegierobotics.com (static-108-39-229-99.pitbpa.fios.verizon.net [108.39.229.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by 004.mia.mailroute.net (Postfix) with ESMTPS id 4cHgzW0GdJzN6tLD;
	Thu,  4 Sep 2025 13:57:57 +0000 (UTC)
Received: from CRL-PGH-EX19-1.crl.local (10.1.7.176) by
 CRL-PGH-EX19-1.crl.local (10.1.7.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Thu, 4 Sep 2025 09:57:56 -0400
Received: from CRL-PGH-EX19-1.crl.local ([fe80::81d6:ea84:15d9:67d4]) by
 CRL-PGH-EX19-1.crl.local ([fe80::81d6:ea84:15d9:67d4%7]) with mapi id
 15.02.1544.033; Thu, 4 Sep 2025 09:57:56 -0400
From: Woody Douglass <wdouglass@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] regulator: pf530x: NXP PF530x regulator driver
Thread-Topic: [PATCH v5 0/2] regulator: pf530x: NXP PF530x regulator driver
Thread-Index: AQHcHaPqZda73QNCTk6YbkyJSCwBkA==
Date: Thu, 4 Sep 2025 13:57:56 +0000
Message-ID: <3c45fe88-c9f4-4606-87bc-726f262998cc@carnegierobotics.com>
References: <20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com>
In-Reply-To: <20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
Content-Type: text/plain; charset="utf-8"
Content-ID: <16527651E44B1D40B1FE0E60E4D730F8@crl.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

QWxsLA0KDQpXaGVuIGkgc3VibWl0dGVkIHRoaXMgcGF0Y2gsIEkgZ290IGEgYnVuY2ggb2YgInVu
c29saWNpdGVkIG1haWwiIGJvdW5jZXMgZnJvbSBnbWFpbC4gTXkgDQpAY2FybmVnaWVyb2JvdGlj
cy5jb20gYWRkcmVzcyBpcyBhbiBleGNoYW5nZSBzZXJ2ZXIgd2l0aCBubyBleHBvc2VkIHNtdHAs
IHNvIGkgaGF2ZSB0bw0Kc2VuZCBwYXRjaGVzIHdpdGggYGdpdCBzZW5kLWVtYWlsYCB2aWEgYW4g
ZW52ZWxvcGUgc2VuZGVyIChnaXRAZG91Z2xhc3MuZGV2KS4gSSBzdXNwZWN0IA0KdGhpcyBpcyB3
aGF0IGNhdXNlZCB0aGlzLiBJJ20gc29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlOyBwYXRjaCB2
NSBzdGlsbCBzZWVtcyB0byBiZSANCm9uIHRoZSBsa21sIGFyY2hpdmUuDQoNClRoYW5rIHlvdSwN
Cldvb2Ryb3cgRG91Z2xhc3MNCg0K

