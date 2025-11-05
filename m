Return-Path: <linux-kernel+bounces-886153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7813C34DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BE82500319
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BCD2FD7A4;
	Wed,  5 Nov 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ApAZjjA2"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023075.outbound.protection.outlook.com [40.107.44.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370D2FC007;
	Wed,  5 Nov 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334777; cv=fail; b=RNKNPaLnU/MmpGdn95vxqSrz1w2QDWITTFZyoZpXSMgtARvYojoc7ueh6uHSAjik5h6TgYmqvhZqEqzpzB4CwDJh54B87xUWzT4OGEM2hA671Vj5fG2uJ7QRLL50hHgszIn2OvAxKP1C9WltEEeQJyyPrqowu3gMeFAyfCs1Ux0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334777; c=relaxed/simple;
	bh=x8Zizo5gG8SIRzqtfiKfJObQJaTDUID1phveQgdsGiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IWR6I+HMuLGeBcN2I4vs3GB1ac5sy0ese2aj9Yx91u/CK4L7rOU6szUgtp8+b50Kl2DwubzWeF7EzGwt2H9p8qKqOxPl6mACToY19IB9eWIjeLmiq9sYvZ/4dIn5E/1o5E8ZZde48r4rpzmtyye0UI9R/aKosikOYKDOXYeznQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ApAZjjA2; arc=fail smtp.client-ip=40.107.44.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEHtjjAf5g6WPt/D59bDw32Ng2RDHgHQApufFoYEQhjGRgPEeSl8or14Mgl6jAE19PEx7ejSVsmyq1pzHTm8eymDrPMWftgDX1XZ7P6tW4CGiC/HgnecT4VJSmsMkhFH8x+bnQs1r1u6Pl1/tFeciHoGa4gM5XtLNFWOoURIcs7kYmpRK/fy309uwIRTOXk9lV8rdTFu+DgRKUmzzE8aI6xjl077vA2GuxGUNRiz3L1S4hOf2Z31U7NQu4RrUwKpRIc9y0uU+YoikHiVvu9MV+9paBVWqsXFCiuGDXQe+5/FUT2WqmWbC6itBhSWQBDK/w8zCed9KKPzMSjGqACUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCOIusfW4eBBhI5DgDccjNf17qwsHfov9EqF6ae+dGI=;
 b=EcKtC7AXTrfJWz106EtUClE/A2IBt8I4af4KdFYKCmc8+08zxc8neekneRoo9aRuZmskctQbl9d3CHxX6NKMgzShRmSqrELcy8Je10dWRkwajpIXY3KwMjbg0dncqdlsIGZdUr41CC54Wt7s1DTyFR56Dzqv89JlRzcD2u2qxZ/0j420zVbpkw3qJ7s29kOE9JedqurAuDz9yvA6bp6NrOLzNR7pHZUEaviKEdO1gkKb808vfs5zCRu1tpmZxXRZ9+6JVqYnVIYYqEeAkm7QKpS/jnN7o7dyoF6lGZYdjudLygYofgPavwho3HVtNTF51lwKl3ttOmkgNrXC6VN+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCOIusfW4eBBhI5DgDccjNf17qwsHfov9EqF6ae+dGI=;
 b=ApAZjjA2FhUsFEiOHE1VgNss4gpX/qrd+KcHKLd6lyQEkNg+wt1Ii6AgufRtVxGWSj0CH5ws62JE7vDZk1bMAplgMT6Fe8e2Oy2ffEeoNw0a0nmnnOmagRbdp+kqZA/yzqgnVrB8swD5/kPrHhhJWjAtCuWcEZQQtocrrJrFdC/CWkr1DVy1EjogtzT+WaqweV3+QAqQmMFkSN0L0gpjq9BhDEJ/+7+yo0vSlOWHYvGuF+V9O2d6BLPzITRjlJ+wxskmSJdkmwLcvlPXAq1OMtdGjKAmR5HS4+6UVhm+ezkUyyPV29J9ecypuotS7mN75tJcPi0iDbZuwmT0tB/5iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5521.apcprd03.prod.outlook.com (2603:1096:820:51::12)
 by SEYPR03MB8531.apcprd03.prod.outlook.com (2603:1096:101:201::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 09:26:11 +0000
Received: from KL1PR03MB5521.apcprd03.prod.outlook.com
 ([fe80::f12b:85e:f95c:191e]) by KL1PR03MB5521.apcprd03.prod.outlook.com
 ([fe80::f12b:85e:f95c:191e%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 09:26:11 +0000
Message-ID: <174ef722-99f0-440d-8eee-5dca086e13f0@amlogic.com>
Date: Wed, 5 Nov 2025 17:26:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add Amlogic stateless H.264 video decoder for S4
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
 <b976b442-7d07-4fef-b851-ccd14661a233@linaro.org>
 <540d98ea-114c-43bc-94c0-e944b5613d74@amlogic.com>
 <b6e6881197dc4c83e43ef5eb1f20c2bf1887d395.camel@ndufresne.ca>
From: Zhentao Guo <zhentao.guo@amlogic.com>
In-Reply-To: <b6e6881197dc4c83e43ef5eb1f20c2bf1887d395.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To KL1PR03MB5521.apcprd03.prod.outlook.com
 (2603:1096:820:51::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5521:EE_|SEYPR03MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: d8360160-7f58-42ce-60e9-08de1c4d5bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlWMTlCb0p6bVVkMVlxczd3K3AzbTlnakxhZWIzNitEOWZ3TlpCN2ZQMmla?=
 =?utf-8?B?T3k5ZU1nZHBieEh2Umx1dnM0bFlYYXJIeVp3ZWV0TmYvdDh4VmtlZGovcVoy?=
 =?utf-8?B?YlNhV3ZwKzI5VjVjcS9oQVRZdWRXTXRYUFBsRGg2VFhDQXdmVW9yZ0F5ditH?=
 =?utf-8?B?a1UzVXFJZlljandXRzRlR2JPV24wYUV0LzlnWGlEbllaL1ZSb2ROZkVlMHM2?=
 =?utf-8?B?U29WVldrb2MzRWIycG95U09JaFgvcFhNMEhlaXRlOWVSOW9tSTlWTmN6MDll?=
 =?utf-8?B?cEh3M1UwajFIbVQvSzRRbHBkVUpFU1VTRzR0YUFpSzUzenFER2NCcDYzbXo3?=
 =?utf-8?B?NU5FTzZUSUhUOEZHMDVKNHlDRnBEbmRtU0FERDRxcGpDU2o3dGJ0WUZkdm5a?=
 =?utf-8?B?MS9ubFU3bVlCT0tZSWpXRDg3SW5GWjEvUVpHY3ZocU1EZGlTYnpKc3I0bUlB?=
 =?utf-8?B?a2toZTZNZzBQbk0wQzJZd2Y1M3h4U2g3MU1EeDEvUWlPdFpkU1BhSThDenpJ?=
 =?utf-8?B?QkxsVkIrOGJOdVNaTUxoTnpJVkYxYkpWbkhxa0pBVkc2SGtZVTdwSlpTMVpt?=
 =?utf-8?B?R2VFQzI0VmNWbkJpZkk1NG5jNzVicVg4bjBFOUMvbUgvdlZiNkpZWlBDKzZ2?=
 =?utf-8?B?amxDU0xLY0RnVWxka2pTc1h3U2l1U0Z3TFBXZ1hleXFhci9lNTY3dzRFb01v?=
 =?utf-8?B?M29ZdUtSV0tPcE1oVW9rRGFmVjFOVzUrRXFsY2dUZ0VoNytPb01FZ3JlVFFY?=
 =?utf-8?B?WFFyV2pZNThJRWppS2hxWFFPdERtWlIvdHlYL2hJUHFxTlpqQ2NMTXp6c2hO?=
 =?utf-8?B?N0VWYnEzNHBTYU1QRSt6SzJVMUhoSlc4NEZtczZDeXJsblRXdzM0VVZKaUs4?=
 =?utf-8?B?dFFLYTg5ZjBrYVRUbXpyeU0reFh4dWNLS2hGSWdKaE9sb0Fod3JQZXJPUGdy?=
 =?utf-8?B?TXgwalpRUlF6VGd2STBleXRISVkzcXdTUHY2cVBKb2FXakljbEVnUlZIVFA2?=
 =?utf-8?B?WitWQkdGQXcwclpYYjRFczRQVnc2cnVzOW5XNWtBM0d1UzJPVEhURC9QS1hC?=
 =?utf-8?B?S1B3ZU5iaWpuQ3R1VFNjQ3N6S1RvYkNYQ0J0cXpEbFd1bTRoRVIyZ3QzMExQ?=
 =?utf-8?B?VHJYb2F3amVIVDVLemhsSk8yMXVmQUVGL2pUdnNMSC93MTE5UWNkTDVSMjg5?=
 =?utf-8?B?bFphYmVBMVU0WVpidW5EOUk1d2VTSlZ6WTdQa1VXekRjNVphU1E0NEwzWTdW?=
 =?utf-8?B?d0xKcWVCL1d6RDZyNXNNWThxS3l5MXc4bmVGWnBOajZVd213bi9JNHhxWGFh?=
 =?utf-8?B?UVRuMFcxQlg1ZDZXTmxQUFVXUkh1eHRMMVFkakx3c3d5eEw1WHZFZW5QSDg3?=
 =?utf-8?B?REJNWkpGYlpYS3NTeFhVSmNqMHZaaWJmNzIvVzYzVnlYZkVxS2pvczcyQStB?=
 =?utf-8?B?U3VaOTRpNWRGOEtFbFZDblJDWlg0akpoSlhkS1R2a2NTd25PVXAvRWg2RjBQ?=
 =?utf-8?B?dDBlMHQvaDFrRk1Sd1dOc0lzUHQ1RTlFOUJYYnl0VlBXNDZ2amY1b05RTVF6?=
 =?utf-8?B?NTgxeVk5K3l5QWhEU3Ntblg3VDlwakNaSlNqSzliSENxTitNcEZhcC9lbFZR?=
 =?utf-8?B?VStseXNLUVg2SXpaZ1JZS21XK3Y1Ujl1Rzh2TyswV2VIYmZyajdydFVkVU8r?=
 =?utf-8?B?VmlYNWc5WmNLTWRjTTBoMjN6QjJyUDRGWVpYZ1F5TEVRTmUycHhlT3ZiT29t?=
 =?utf-8?B?dm1McldBeXVyMWFrMDU5alJDN0RKSk42SHVoOUUvWVo0QXZubm9vZ0tXQzY5?=
 =?utf-8?B?TmFJTjg5L0RPMytOMnpyb0R0US9xdEtnUnhGSDZHcG5seXdHTit1VUh2bCsv?=
 =?utf-8?B?YkY0Ym9oeDRFRGpBVUpySVV2d1Zla3BtNlBvWXF4c1l6QjE3SUdVbTZ5SkZn?=
 =?utf-8?Q?xgh34qMqEyziilbYh/sxqkoLjU/x6oGY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5521.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVdtMFgyNG1TMVpJT0JPMENFL1BNZDJ6YnFSdW1kZE5oLyt0REdtZFd0MCtn?=
 =?utf-8?B?QkdJNmVQcUhCbUYrVHNlNzZjakwvdmRXeFllNUQ3MGYrRjlKcEFmTHNEVjg5?=
 =?utf-8?B?SVN5QjR4ZmswRE1CeDNXY0xoQ2hyQ3ErS3Y5ZjhGdGhTZUhkT1ZLQnk1Z0o3?=
 =?utf-8?B?dW5FY3dhWmQ1emdtYU1vSVJsckZ4OVhhTVhQaGY4WTM2c0RncDhWUmRmaHNX?=
 =?utf-8?B?cE9LZXl4NE1TTjEySmdZTGNoU1BPcFZjQ3k4eGhwNloydlYrQithMk5OYlZj?=
 =?utf-8?B?cW0yeTl2bXhMTG4xSCtrL2krSkFlKy9kTndxRnVOaWtaTDI2bSs5U3J3VmNy?=
 =?utf-8?B?c05ZKzB0R3B5Y0ZTZkVUYzJLblBlMy93STI1aDdSS24xWVBNOHd3UGFhQU11?=
 =?utf-8?B?UVdqS0tlSml3SDZicTRnVmg3ejU1Ym1XWGtVWG1lU2E3WUtMUzAweGZ5dmZi?=
 =?utf-8?B?OVg2cmYvWjBKYkNrSUNmTm1jdXZaeHlCWDVSMFFzd244dnR1Mld5MTBaSEdi?=
 =?utf-8?B?eU5oVmVwSXM0NTZYSkIvdWhwYkVsejlGOXhzZ3F5OTJzZTRJQjdRRmkzVjVM?=
 =?utf-8?B?SHlqYi9ZWStjbUg3ZENZTXFVU1hQU0VraVViWTI3RUpQVStLN3NUTlQ1UXp3?=
 =?utf-8?B?RmY3aTRMWUJvRVgyRTRqU1pmM2FsV0NIMnBnWkN0V1BwTlBDWXJHZ1J1bm5L?=
 =?utf-8?B?Y0ZqNDNZWUFZVzNRdFRVUndxZG9JQy9iYW9hRzM0WXgwQ1VoVzFWOU5Ycmcv?=
 =?utf-8?B?aW1XUUFqY1g3eVlaMFhqVGdXTXp3RWlGUkYwTTA4cVFVZVJGRHdKL0kyZ3JF?=
 =?utf-8?B?NHJYTlhnUkpoa0ZJejJOdkFHVlQ0anhQSWsrSlZkWTVxZUw2UGtQTHk0RnB3?=
 =?utf-8?B?K1o5R3NuRmQ4Mm1JNlczbXFHcEhvQ2NlUzd0UnJWMFNONmFSSUJ3bXJ1R29y?=
 =?utf-8?B?QU5McXBrQVh2WmsxTGl5TDAvNGlRT1Q5UzdSTTdKdFJ4RlY2NFduRXlnbFZw?=
 =?utf-8?B?NmEwSXp2L3RFUkk2RStLQ1ZTSk1VdUNSMk5DZ2tQdGh1L1JPQWFSU1hHaTZw?=
 =?utf-8?B?bnZ6ZlNpci9kY1dnTklGQnFyeFQ5aUdtTlh5bHpOUUV0WGtFZVcyY0ZxT21o?=
 =?utf-8?B?bm5uRzJhSTNmeHRUaEVzbmVjejNpVWQxa0RjZ0RiNkF0VldXeUVKSCtLZkRG?=
 =?utf-8?B?MjFybUg4WkVwbUNIeTZJRFdybUE2ZEpKbmpoWjhRdmhvc1dHcUZFMmVISnM5?=
 =?utf-8?B?VTQ3dVQzMlU4SVNFKzBHMEp6MUJBVGU2QTlDc0wybnI3c1Nhc0lKT0l1WXFk?=
 =?utf-8?B?YmVHcDdLNzNKcXRjSDFINWRCZklNdGJpdGpma3ZObGhuWkU4dGpJZkZ1Zlk0?=
 =?utf-8?B?UjhzZFVOWWJHV2xHWjNpRmN4QzZTaDdJNWkyQ0pYUjM1UEgxUFpWcnUyTSs1?=
 =?utf-8?B?am1BeUVBRVdvZllFL3BXSXZEVFA3bjBuK0ExQjZvZkh2aitrS1ZuWVQ3cmVU?=
 =?utf-8?B?bVBJTytHS01FVi9sRmM4cEFNQkJGRUdyZEYvNzFNWTNsODlOOVVHOXo0cndB?=
 =?utf-8?B?bW84TkZVTjBiZSswT2Jkdk5zZzI2UXlrV2VSOXpJOUNqbDBnZFVqSmJTcXJT?=
 =?utf-8?B?VTZ6azF5bUllNzBKWFpqN0R4RytZUjFhaW4xOUhGRlB0M2NVbUhrMjhvajA2?=
 =?utf-8?B?VHFROCthaXhpbFBBUFBUb0ZDWjU5S1huZUtub2dNTlV0aDZBY3BBMlVkYnRZ?=
 =?utf-8?B?dnY0cm1MSks2akNsMU5RdjVQMlRUcEFuYUQvNEc3cFBVNWduQTJqWHJIaDF0?=
 =?utf-8?B?WHlDQ29kNFNCODBGMG9BRmd1S2FNMXlFZmszRWRWZitsNjNHeUdWazNzSXZE?=
 =?utf-8?B?VEZXWDVtMXFHdElJd2NDRmFGZHp0VzkvU25GWFlnUEI4STJiSlZvTU95RXAx?=
 =?utf-8?B?MHM0dUNPZDFkZDYvdmFGS01KZ3BUQkV5RHJGWjRtdlpWRmsxOXRxcjhwMkl2?=
 =?utf-8?B?NHhFcVZLd0FkeFY0YWxkUEc1YmhkcmdmMkNTVzlmVGxNS2pqOG1KOFN0K2tL?=
 =?utf-8?B?eldzS09QZzVWL0RTa3k2ZFVkQ3VKM0pHbHFlS3l5NDM1TkFvVHBqU01mWnZY?=
 =?utf-8?B?SEo0T25PcFV6Y0g3ejJWL2UrNXA4MlhFOEorVGtZeVFxV1NDOFlVeUV0WWQ4?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8360160-7f58-42ce-60e9-08de1c4d5bbe
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5521.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 09:26:11.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCd9xkgyetnLkvoGazDo6WpcEDnnT4TTgquCdNaSrev4ncWqSfwhgXl3QAQdH5eiONeJLd05RUoWKfJXfhKbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8531


在 2025/11/5 0:13, Nicolas Dufresne 写道:
> [You don't often get email from nicolas@ndufresne.ca. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> [ EXTERNAL EMAIL ]

Yes, we plan to support the interlaced and mbaff streams in the 
following stages. The decoder hardware can support interlaced/mbaff.

BRs

Zhentao


