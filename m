Return-Path: <linux-kernel+bounces-791724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A5B3BADA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1798716B287
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960E314A72;
	Fri, 29 Aug 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="p/ETy4Ez"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013084.outbound.protection.outlook.com [52.103.33.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391E229B1F;
	Fri, 29 Aug 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469370; cv=fail; b=sIouC7zGNXIUo/e5hYPbi5Uk/oylUkqflMNY/UuUuYGWlh3KQ18kuJMktxl9/1Wv3FUC6PzzQgAPWjLmCQJJzuFdKdOJcL8lhAYyIaeLdacFWPsj1n0luPrRancSd51JY4M0qRBoL0aPsNEgJd0016NOkbz6jPFQcJx5yg2EeJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469370; c=relaxed/simple;
	bh=vlkLvTZDZZPJJtSGChDIpbplBmleTgofPJJ5kGtDm9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sz9D9pbE/CA+0JhKkeWvqYoHXZOFZPoKz03+eVId4lHDbrKW46v50EAk0RxV24ojYzYea2mGQpEwt2p4Cu2c1MDNl+qtbofwl+yN2PN3/JDtvecOqV0QUFWgiIbD2IvFOn9i+3cw5Ks1Ym1uEeYrs/3DGxJBefI8TFSbZqRCRzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=p/ETy4Ez; arc=fail smtp.client-ip=52.103.33.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYTdUfMDS6s80zAdr6lKzzMb9VQ2OkAarm+f+BmuqP0r6AkT46Qa/6kgJUweejc4mM7CufuTie7Rz84fTrtO8kLzkfv1U6G7wTMshqYVCZPk6+psceN2LJlf4crFQkituJY8YPNSAF15jRfR6yWA/zBGPrEOT3vsLcK02EAoKqvtawi6v3Rq4RYkbZfLn8XsqBd6kBH7qC5RQLscdlERGw/HCPSYXom33CIdHrcVxkBURPole/iNHBxM4MxIeVl1pkZWblMhwhh78dYHe3s8C5CsQaURiBatjv1/kQMW2UgDyr+sBxHxagUsJz32RX0vwwLDLPUdcHHwj3qVDB4UcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h57HBxcSiY0SG6v7wxAj9+QmyN+laDhOcbRw/aQ9mZM=;
 b=y87UnarHEzDkRS9YBfHubnPWBi1ja/V+57tyCU55qrsilSZgKDvjeINdW59xIMj5K9S6YledOG/2T4iTcwDTFh3Qml37xxGtxOKrdsABEUH8TcmeaVuqfne5ONEO0xdlr466BO1TYZUzej6XN8JeOH1+w7U1o1KrETY02SMx5xoxdTsbJwWPq6/QRCMkT+QxDhKzcC9GJ3qKOrIiMg/ovPGdlw8Agw76r2xaMJMCYkPISKF4IJNQi9eXFQgKTAj1pDoX3lv42fDC5bXRkyq0QixZOEv3G7aQ3WcYsmJ+DKvYYtNqsTdcdTCIdyIBwC5W7WXGDkZcJY3R0xsbrSCSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h57HBxcSiY0SG6v7wxAj9+QmyN+laDhOcbRw/aQ9mZM=;
 b=p/ETy4EzmMEMzglNh+Ce3gm6cHW+qKqjaiiNy3mN2ahrHm4vJrlKQG0IgjCdK4+v1dfoyABGf8z7lmGoSTtUvwITrarHxRSeTxC+pWNDbFmaj2Hr+dxAN6RtxBQtNobi2B47JTj3VbbNkZ0nE8F6iV22wyeHJ8CigFZen2+VC8j8rEvvxzUxND5NfLoIx4MhWo8BIrUjrkN3xz5XZ9xG9u5UjfiwjeNyNmiZlWKuYdO1t48TGNNPWsHCXO39VLvyUQ+TrDhPmgWFvhPr+ENzyi9lGMd9D6qiX9fMkXP/rG1xvosOfjdczbo9VvaktFwIwo2jOF5eoNv9a+qNxrNHUQ==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by DU0P189MB3268.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 12:09:25 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13%4]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 12:09:25 +0000
Message-ID:
 <AM7P189MB1009CB3632FAAEEE43D9CED5E33AA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Fri, 29 Aug 2025 14:09:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enables sound output from the
 audio jack on OrangePI5 Plus
To: Hide Hako <opi5plus@bcc.bai.ne.jp>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org, robh@kernel.org
References: <20250826134456.9636-2-opi5plus@bcc.bai.ne.jp>
 <AM7P189MB1009A67370CA029038DF2A69E33BA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <0b061e42-0a01-4839-871c-a5d760dbddeb@bcc.bai.ne.jp>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <0b061e42-0a01-4839-871c-a5d760dbddeb@bcc.bai.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0065.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::8) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <ffff1abf-2427-444a-8934-045ea6e3f6f2@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|DU0P189MB3268:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0efa7f-3218-4105-6e88-08dde6f4e552
X-MS-Exchange-SLBlob-MailProps:
	/UmSaZDmfYBk0OqXWkGcw9KFcS+e1k4i74Lcb+KFj/kRsLKDsOin6Li1a561l+xBHJIGGuHqNNF6hBfGn7RxVVSrFYp20O9LWjTbaUNCwaaBQXRZngHA1Ix12ZtjI8Ukc2i6+w3LqJGkxUhyUbiOnSGC7Kx/OcessFqOIjBbUcZeK5ZiqH4xxihjOnzunpiuRKeaPT+pY1rd0WI/Bre2mpfNltuep1CbXCaic7LMdVG9KKLQC6AU89ANRioGPdzJIz1RWMyaBTmbXmk3phrWNQJggvb2NV+PNIaRxNJKWkhzqOQvIZkrr9BN2JhoD9aGTxGpURXaxh/sIAKrTYh9jIboRrgN1PkEBPqtRZStCypNfothdKVRNB0RtfUqdK3cppjZhoO3Jqze9aH/0dDK+nJzJHgrJJ5Fjhrw0eWrp++C+lVi+zI6q+diPif1/Z5teHPGJG/KsEQ+SeqEA98qQjPZPBlAeShItxMqufvZTcZM4MVgAuZEGPkT87Lk44LzzOHEZ2YsjM1PZdU3vB46nT1XfUq68y3KndFF5dGyZHmwLEkvxA5owfB4RG9k1PDS20J2g+8O89PWfYBo+dY9zoAkwzRQm6Ud53dFrVTQSYKh1apn2Oxpbp2m8W4KSkF7BN/sXxEK7jXjQHc77Qdr4LRyzpa+nBM1nO2Wd2Ljl7ho8eVAYP/HOnFjeLsDa/71p9vkz81hcChPbsLsIt4JYXT3wI/vO5t2hblbO6qZ4uEkeYVHsbedM2rGi0US+uFASceXpfNro6KEUTt9UrZm8iKSN47y1lc3kWTWFFBmRYrLNpsZdEoOiu0PZ1REexUjDsJ06G7hpYrqewEKn3zQ0g==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|461199028|6090799003|19110799012|8060799015|1602099012|4302099013|40105399003|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXA4akNwRmNUVTE4YzlJbGpCZ0VKV0tkUlVSUENjaStSdE83eFE0VmNNcXBw?=
 =?utf-8?B?V1hmNTZxSmsyZytYK1dYNGZsK2RGeW90VExIbll5d2VQOG1sOHJ2RHM5Um1J?=
 =?utf-8?B?alVuNy9qNDllNCt3ZDV1TFRtMXl1d0lLZytmWUg5aWNaU1hrbjYxV0ZBQXNC?=
 =?utf-8?B?eWx0c3QyTU1idkQ4cVQ1dGZ4dzVvQ01tUlhOenBCbklFd1ljN1N1Mm1STWp6?=
 =?utf-8?B?SG5zQ0xjL0k2UVI4YUFUdWxHU3hmT1VOOFA4NkltK3RXSmdSdmhEblFiNjdP?=
 =?utf-8?B?aDNnZEVYc1BiTmZjMEczS2lPRzdYQ0FjN1JwTk52WTF4L3owQVNYK3FQeGNX?=
 =?utf-8?B?b2FJeHQ4OEYvb0dnUnR3VDdpNlA5bzJMZnZRaFI1bWY4QVAwSzlVcXpVR1ly?=
 =?utf-8?B?Q2xkU1BuekF0ajR3cDFHYXREL1lOTXVQc3UxYldROWVMK2JjQkJGMFlkTm1u?=
 =?utf-8?B?ZFVXdDVJY1R0N3V3dTdkcm1kZFZEUmdjZW5WM2pBZG1mWXVKM1pheUM0dUZW?=
 =?utf-8?B?VytPZUpqVEdqRURvMGJmRlVuVTZJZjZ5UHJtU3RZR29TZU1NRGRMZ0I4MzVG?=
 =?utf-8?B?ZmhXcXV1VnVjWHduTXk5c2NtQ3M2UUtKUkNWLzhBQ1JpZk9ERzRGVis2QzNy?=
 =?utf-8?B?WkZFcE13Sm9CYVIvcW9pcDRGU05leFcxMjhpNnZ2dUlFQ3ZCSjJNRXVRZmhQ?=
 =?utf-8?B?VFV0R0VLTjY5dEVkK3JweWZyaXNiWE15K2VJdkpidHRKNG1hNFZDb1Z6Ujl1?=
 =?utf-8?B?QkNWeWFLZGVWdEo3bXNTV2czbEJiMi9RLzhlWTJGeTFxMlVqYXA0cW9LSjAr?=
 =?utf-8?B?dWFaN0xuWmZCSzFLdS9Xa0Z4NldaV3VoQTdmK3A3QzByMWhvS1FCUXNBRWZW?=
 =?utf-8?B?eG8wNTZUdUxxdi91MTNaRjhGSW5wUUxldkFyVDI2dHZpdi9CVmhxQ2hEb29J?=
 =?utf-8?B?SG0rRGlQZ252ZkpjVGxPWS8vT0I4amRleUNZeU54OG1FSThUNzZRU1BYSlh5?=
 =?utf-8?B?by9hUnNKZDlyS2E2RzJGSDQ3U05CbXpxUjlxbkk1QkZzK0g4VFU4V21EZzFG?=
 =?utf-8?B?d3ZIckhtS2JZMStpc25wYUh2K2ZUT1ptMm9NaGd5aitpNHZ0SGtTRDJKZXZF?=
 =?utf-8?B?dGM2UVU2RW40U0tNQmE4M0lUVTQreXNKQ3pWa3Myb1VsbmJJdS9jMDk2NnZT?=
 =?utf-8?B?OVhuSVMrSXlaNTZTRTJtL2ljdEV6SlBDUnpLTjBscDRYUDExRHFIN0NNY2dL?=
 =?utf-8?B?WkZDRmhLMy94cG0yS1FkSVVQbG13YjI2ek1CWWtldDlEUTZuM1ErdytJa3M0?=
 =?utf-8?B?Skl1NlUzb0VraXJ4enVJQVQ2cXZCWHdySWZrSmM4SWdDRHEvUFpqN01FRXRk?=
 =?utf-8?B?d2VrL1RqajNGN0sraG8vTnFXTHFLSER6ZGowcHZtNTBFaDAweDFZcVNRMlZE?=
 =?utf-8?B?TThhQldwOWRhakU4RGxFa0RzenZ5RVJEM1JselRXK1RtMXgvSE5CYWJhUE9C?=
 =?utf-8?B?ckRvcHRDQkFzMjJYUFYvcitrblN0NkNJY2FCNGxaOTFUOUU5RGxYUGdWTHJX?=
 =?utf-8?B?aFpMWGF4QjRxanJmem1TSkEvWnhvUWxtaExPTjFVNnEzeUpieWNIa2Q4N1pu?=
 =?utf-8?B?a2hQNWFLNmU5RktTODJtMEE3RW12TURvSm5US3VISjN6L3pJL0o5UDdCR3I1?=
 =?utf-8?B?aVRiaTAzYmw5dVZRYVZqNTMzaXdYczR5QTdZWU1heU5VQi9lVFlnM1BVVkhk?=
 =?utf-8?Q?XJ0ciTD0SP/V75okQp3DUoQIO1CNsVVhpdoJj17?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdla1R6cG5UTUZiL09wUC9WYTMvTDAzcGpiV3dORlpYazIwSTRSM3J6MSt5?=
 =?utf-8?B?alFpZEZPQTIxaVpuQXRwUklpblFTdGx6eE9XbldKb2x3b3kzWVRTeHNpZk0y?=
 =?utf-8?B?Y0JweDNHM2hvT1pwL1pya245ZExjNGZqeGpBZ1lGNTBCcVVUOHBaN04zMmVH?=
 =?utf-8?B?eGZWRzNRUzF5VWVwZW0xZHd6VEs0bFJyU2JmVlhrWmdTVU9kMGpVViswRXYy?=
 =?utf-8?B?S05ESkxBd2xTQlg1NmlUQzNWWU5UMUxZT1ZkdWQwWGZKOW9rU0FmV3ZJbG5C?=
 =?utf-8?B?OUl1VkFNa1FPc1NDWm1qQmNjckFUWGZpeWxoYU0veHArV2hIV3JWM1BDVFR5?=
 =?utf-8?B?RlVEQXB3QWFMOTk3UGkrQlFmMDQ5UVQ2THZNMVRHZGEzRjNkeElmWXJYNEo4?=
 =?utf-8?B?enFpUGVtSWRRemdiYzYvL0cwVjhqTitVeldVWDdpdFBtak5KREEvcWdOUG9m?=
 =?utf-8?B?ODR3M2xROUROMVJYQWhka04wV1RnMXJOREY5L0FZa3pVYzYyVVM3WGpWQ1BP?=
 =?utf-8?B?UzVyRHVlam91bS9ZZFQ5TjQ3bUZZTTRYM3ZPcTJIbERWQk94RGZCRFhzaWEx?=
 =?utf-8?B?VnovaUdyOTdaTm93RTMwdXAwb212T3NYNzJFeW53OUpwNUNwbjNHck9rbGVV?=
 =?utf-8?B?Vm56MFVKOGIxNERGaGRuR1ZjQWc4Q2h2ZFNCRVlocXpVQ3dVeE5seUlmZmRa?=
 =?utf-8?B?OUV6YiszQ2JUMzBFTndhMjRBVTVRR2ZzVno2MG83eVlONHI4VU5oMDAvSVNx?=
 =?utf-8?B?cFFBaVN6Um93WWt1Y0Y3SW1wZmdjZ0J6WUhyWXV4TWZUSVFxUCthOEdDL3dX?=
 =?utf-8?B?U250NlJUR1ArRjBVMk92L0xJY3JHeGhCVDhESmZrVGhESTNHUmlFa2czZHg1?=
 =?utf-8?B?M3Y0dldqZXpmZGZaUUwyMERUbTlIZWpqT0FEM1BCOWFjdUZkNzB6dldoc2dv?=
 =?utf-8?B?SFlmb0FvaHlxemdWUzcxSkV5bVVaOVFSTEMycy9zSERhM0lzTlVMM3h6TENw?=
 =?utf-8?B?Z2kvNmV2dnphTU1KNm1nTzhXZDB2bkYyTEZlQTlsc0FSZk9uZVJSbzVMZmxi?=
 =?utf-8?B?RDBUb3p0UWJoWm11dFBmeldlMXcyS3hMcWNqWjhkUUFLanc0bnN4VTZ1SjFC?=
 =?utf-8?B?RytlZjE4WUZlZWNCV1JpRDU0NEZTL3F3THlkYlIvRWFBUnlVU01IQTNtK0cr?=
 =?utf-8?B?d0JnTVB0QU5vNGU5d2NkeENCU0ZUdXFwL2pzYVdES3crT3JsME5Vck8yUkhr?=
 =?utf-8?B?emcrQ0RLSHNOaGQ3amlSOWV3YW0yQjBqSnUxbHlDOGtjQ2ZqUlVGaWJ3d2pV?=
 =?utf-8?B?bWNzZXZpTlZTcFlSdmtQeFBNaDVrTmVIVUFiS2laa05NMDV4VU5SMHp2ME9i?=
 =?utf-8?B?RVJVenhPeS9OeWNhRnkvRGVkRnFjWWpZM0ZoSk1hOXhSYlBUaGlrczQyK2hZ?=
 =?utf-8?B?cDJuMklzTVNtalJ0bWgwWkJRYlpjanlja0tmbkY2ZUlTWTgydDB4VEtabDdG?=
 =?utf-8?B?Y3l3Z3d0aUFwdDFTMzRJcmlFN09Jd1VmWDE4eXJqSjZCQmdZTjVYSWE2QThT?=
 =?utf-8?B?UE1wdVB0YmZnSXJVdnFWeTdWYjNWQjNETVp2NmY2blZFZys4RVdxNWhNSytE?=
 =?utf-8?B?Tzh3VjhMS2VLZW45YzlzMEM5QU8wMFB4cE5pUXZSWWlYV3NlQnEzUGVuRVo3?=
 =?utf-8?B?N1NwNWcxYlBRSFhTRjcxM3ZqRTJiZVg3TzgwNkdWbmhJZTBQUkZ2V2t0ZE9z?=
 =?utf-8?Q?5LpPjatf9bkL7ilEKwvAQyP3HEc4W19E5Nyoek3?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0efa7f-3218-4105-6e88-08dde6f4e552
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 12:09:25.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB3268

On 8/29/25 13:59, Hide Hako wrote:
> Hello Maud,
> 
> On 2025/08/28 17:47, Maud Spierings wrote:
>> I recommend rebasing on the latest next since my fix [1] was applied.
>> I also recommend testing it with that patch, for me that fixed the 
>> headphone detection and enabled audio playback. The microphone is not 
>> working yet though.
>>
>> Link: https://lore.kernel.org/all/20250823-orangepi5-v1-1- 
>> ae77dd0e06d7@hotmail.com/ [1]
>>
> Today, i build linux-next.
> But sound not come out from headphone.

Is that with your patch applied ontop or unchanged linux-next? The audio 
was very quiet for me, even at 100%.

> If you test the 6.17 kernel after using the 6.16 kernel, sound will be 
> output. Try building and testing in an environment with only the 6.17 
> kernel.
> 
> Or is it okay to use the JMB582 "M.2" nvme-sata 3.0 expansion card to 
> connect a 2.5-inch SSD?
> This makes disk swapping easy and convenient.

I am not quite sure what you mean here.


