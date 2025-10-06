Return-Path: <linux-kernel+bounces-843166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A204BBE8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BDB3BF07B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51562D9493;
	Mon,  6 Oct 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="p+n0/b9F"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022130.outbound.protection.outlook.com [40.107.193.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E4283FDF;
	Mon,  6 Oct 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765865; cv=fail; b=Fd8YCqO4l0Ht47Pv9+kPxuzFvFc6bLTZMsiDfHSx/D8ZIuQRQSeOLNNyCaa6veMPAYgml+n6xUw78Hk7d3wPpBsPD8A0IoF4InJlJZd3Xy4tNGSWltW39g7x6qEZrKuUVQZk5fPFupdZyLjo/MQzPMUdZm1HNBv5kLVsaSI/+L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765865; c=relaxed/simple;
	bh=H1imEMntMkAfEiNppX5LBZDXiAPjXjGi38W4hQSpE9c=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=At0uWHR5D6WWlaqW2rcws22e30pwVVWzo5xCg0ptQr2lFbWrIWIRZ/6w+z+H+g/3n/+34BRsMvVdowGK4LwclkJGFvDeDbhZHxU4BvVKh89oQ+m7WzVP+K6rLSYEdh2wMIkBNapQi9K7+CCw4lzm4j/VVkilbXB+38jcuH1cOxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=p+n0/b9F; arc=fail smtp.client-ip=40.107.193.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qgo5L5/K0qMWYV19tk8TenT/mACQNq8rPaUVpdAaRVun4sBXEoL2PUp8OVeP9J8GBHnqaKt3DBJlwgZZwqIYtiBSiOm5C6BPtCiYCeImF/seC5wrcorXVsSt1JSwhBRYTa5TEoOnFGPswuz0fpCtfjKtkR5zEJJ6Twibo8x0QxwixswmFSHLrdxILcYlR82wp2OLYW8VW55T6WMuVoL3+nGjG0eK/gW0ywTY4CSpAhHv3WeTLXAgC9eCSx0cK+semQaldmXGcZlh/Vmv6sOwRF3jjYJAS55uclpEmVylzkO2vZsaF3CfGI4VFpFrJ6mIJSfDPR4n3r6Jehu8vyxXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7aOsy4eM2Yq7xZ/XAifr4uyuGkXOn1lcHQUzyuMUJg=;
 b=AbQO9DCU1zzbDRz/5zjEG84Bk6qmxeIvnIyvLZiFSWQ9wOlGXoB5cc8KNHc1jHw2m4b7Tnpjyi7UOOD4T45IXEbuOEGe+UDHpmzzacOg9WLzweu01tcXJ5Zm9ocKptLi8MlS48p2WcTWccXhqi/JCIAyIWeP9Zaw3Qag1yzYrUr5EzgkE63IfPu5Uf0C7Y5p6ojL+btadMFYK3cms6uWnNts0btpMn28gv7m9Ndoz7N8k3M5nG3FYdiV3td5ssdb/AvjxzzMwKZtL13u4zgGHdYG4Us2rRAUles0v2kZUuSYvYjMEYpZMUOFDSELvrcB7NfwE5LNXBCyCP/+nMDIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7aOsy4eM2Yq7xZ/XAifr4uyuGkXOn1lcHQUzyuMUJg=;
 b=p+n0/b9Fr5LGaz449r0gTUZHT4wlhPSZwqbpuvInap1ua6SQeLa9rbyjtL1LGr52Cadg5+nertkxIHt7//POo2gIaqzYZRgN2z2Mc0lXSpQ5DXOuU/3PR43gfYYsaw3ZNaGuuH2ogSyqYI9XdYX1CwfNDdcaF0rzULBhKbO74/eNjbBMyCXLWuNOYCCZx2i7rZFnxVEqRPhcUkbP7W74d37+2KmKNO7hAQkrKsmn3U6LYg/9BGuHuhKoYugokEaqBp970otVmul8VrELXWieX1SxJvl7F4LMyVa23d4eem7Zqn9n4qUBGb4A4xj2x7tGm1tgbl4uOQM8+PUcNq+Tug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPFECCD46551.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::6a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 6 Oct
 2025 15:50:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 15:50:57 +0000
Message-ID: <3ca8430a-d2c1-4fc4-8fa7-bc3fa53ee82e@efficios.com>
Date: Mon, 6 Oct 2025 11:50:55 -0400
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.13.21 and 2.14.2 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::48) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPFECCD46551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b406ee9-b5bd-430d-e452-08de04f02385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MS9qdU5tbTR4Z2dkaFFSSDNDREhNMDUzQmxRQjdHNXl0ZExnSDhLOUl0ZjBJ?=
 =?utf-8?B?Y0p4V3l0TGo4TFg3aXBtalVYLzVLK3cvMlNUYXJ5MFlLcGRSWGNVbEpBMERY?=
 =?utf-8?B?NUxSZzBLSnpXbVpBemdON0ZOaHEyeEd5RGR1TzZTRlhOYzdLWEFINU0waFFs?=
 =?utf-8?B?a3N6Tnp3aG5aSUx1bDB4L0x1Ym9sNCs4T1U5enFxem0vMFpVWm9YLzY1R2NJ?=
 =?utf-8?B?eEx5R1U3OTlQM2JNQVdubk1wZGFaTEhpRUNsL0dnSFpPb2JDVk8vbThNd1hM?=
 =?utf-8?B?bUZzeEIzcnZlbVlsYnpHY1gxZzBSeEcrcnI2VlNnQWovcldOTGtrcnBkMG51?=
 =?utf-8?B?WitEVVhhWVBhMHZzRExpWDdvMTByOUNFVDNmOWxGRnZRL3g3L1g1b2h6b2I5?=
 =?utf-8?B?SjlieEpXcVlyQ1JnVm1mV1lKQjB2YnpiNE12eVR2OUxjU3FBV3E3OEdxK2RU?=
 =?utf-8?B?UlV1OEdUWitvMzJZbVdQZEdyWFBxc1lrbVlUSDUxZTVKNWppRjlrNEYxUVlZ?=
 =?utf-8?B?QXo3QWxRRTFDR1lENTJyL05jTTJiTmFENTZUeFZEeW5LaTk0RU9xNjJSemZp?=
 =?utf-8?B?aFVhTGZKZGxLNFAwaTRYU003RHdETEFOeDNoelhBQmNMTDU4NU0zS3Zsa2dC?=
 =?utf-8?B?M2NDZzMyMVUrclNtVCt3V0JpUTJPa1JFMWZXWjg2YWZhYVBSbmRHR242YTdU?=
 =?utf-8?B?bEpUY0hiTXNZU3VMKzhnZytJK2IvWUNnMnRjVjEvTzBoZ0xSVzQxVXRnalVy?=
 =?utf-8?B?QzdqbENHYWlBSlJSTVhPUHUrY2ZvL25vT0JPVzdWSXhhZlBaa3Nod09TejVs?=
 =?utf-8?B?M1NHQUVmQytJRFB1Q0hZeGVra1BVSFJRcWxFUS9mS1pySE9odXM3ZldkVnJi?=
 =?utf-8?B?MGhGS293ZXNwaGxTNSsrZTl3SEE5SFdUQW9ja3Vsc1JxWjBEdXZBaGlkWkd0?=
 =?utf-8?B?NWJCOHN6dCtwVlNpK2ZNTlZ5OWZNN3Z0Sy9MM2RsNmMyb0FRTUtRcGdEK0tn?=
 =?utf-8?B?V1A5MDBNaXRpUHNVWGQvLzhBK2JBQ2VCRWZtam5PZU8wc29KTkRiM3Vaa2dx?=
 =?utf-8?B?SFA2TnRwTVYwcjFsQTdpYWRtUXFBbzExSlpjRWhSWWtIV3ZHQTZFUzVKRDE2?=
 =?utf-8?B?NEtDUjlyK0FtRTMyTUFIMVdkWXJNaHFmcXRncnhmN3VpeXkxeElFdXdBN09P?=
 =?utf-8?B?Zmx1TDRCQzJqZmFFOGJlRGF2T0RROEtoMkYyc0hhaERIZ0t6OHg5T2ZGNERp?=
 =?utf-8?B?dmYvcSt4M211TW51Wk5sYUtBN3hVUFZSV1NVMWs3MXQ5R0tDcHhOazNMOFF0?=
 =?utf-8?B?U05FbVVtSUJaaGIrR1ZwVXhhdmFQQ1ZzT203QXlEVGRvSGhzaUhoamxiYmVE?=
 =?utf-8?B?WUxkMDNTMVgrcFVuTFNlSUY3bHJNSEhCelJDaEZDWEtNWEM0ckdKOEZhNGRY?=
 =?utf-8?B?aTBqSE9PQTVMeVRXbzVGdTZmYWVHYkp4Y0I3eDZDY1JMQVltSGpvSFR3MzJk?=
 =?utf-8?B?VHlyWlpwRVNEOGhueHZJaUpEWW1mdWRXcHQ2SDZOOWpXNUUrRXJ5eCszc216?=
 =?utf-8?B?Q3FmV3JpbGt3UDZNM2JXY2lQOTYvZC9aL3FxTzd1RW5kYXJZVnVzZ1JUczBL?=
 =?utf-8?B?Z2RSWGxxODRRR1JQQzdTbW1GM1JkZ3p2K21tWm1SdU9JUlVtU01vVk5uVjM4?=
 =?utf-8?B?SndQMWhSMTNvZ2FnOUp4MG4rWjJvaGg5ZFR0eW81OWtNbGJpK0xTa3hDbWZ3?=
 =?utf-8?B?ZDY5amtqSjZrWVowL21LMGtMWE92WHA3KytwT0FxeENlc1o5T0xxTFJ1c2l5?=
 =?utf-8?B?Y0lJbzh6eHZMb0xaNmx2dmhMN2xZT0lvZ2pCTC9FZW01M1k2UGJJeTFTWVpo?=
 =?utf-8?B?N3ovS2E3WGNNeHRNWHVLYlRHYTdlQ09McjROQkh1eHp0RGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmh4Mk0wYWkraERkR2cvSGo5bTV1amdzVHUxc0xXcVlXQ2Y0dnVzUytnTGpC?=
 =?utf-8?B?SElpV3VYeEVXZHZPaTl5L0hsQWl0QnRydFRMMzdJenAzQlZybExtTzNwU2Rk?=
 =?utf-8?B?aGVqeVlPV3Z2UUpPZm5ZKzJVb09oZDhORzNTT0ZxcHd1ZEsxWjJwL1B3VUtC?=
 =?utf-8?B?QlRrZFQvU2VvcXpheGlwNlJFU3JyZGxvOFhWSFRYeFk5bktOMURSOEtpLzAx?=
 =?utf-8?B?UnRSMmppcFhjOENKU20wOUk5MGtNZ2RTTmpnbGxSQzFPeWZTMXZqMU9lalA5?=
 =?utf-8?B?MEJlWWFrRTBLS3lJMzBYT1VNWmRkMWoxSldVWDRGU1FvaGhwSm5nbFVwTkJN?=
 =?utf-8?B?bFFoeWJNb0NaTG1JM2ZrcytCa2N1NXp5dzRQSUdVSm00OEdiRE16aURITGtG?=
 =?utf-8?B?eFpTMXArU2Jla2dWSzRVOHlkb0VMejI0eFE5WU1qRiszTmRxajlsOEhoZ0Iz?=
 =?utf-8?B?WWw5RlE5S2ZWZDFKenBtWnBabGtuNUs5dTQxMnJTcTVOeVc3SXFKaUw4TGZH?=
 =?utf-8?B?SHVUbGd6K3ZydHRvL1NmcDUxam85L1pKMG1wWCtSMnErcUlObzk5dHNJd2Zw?=
 =?utf-8?B?N1lTZG5GOGRkazFGS3dxS1pDeHVPMklJS2laQW9sUExkbVNPdmcxaWZBb2VJ?=
 =?utf-8?B?SnBOT1VkcnpaOGdQOVdXZXI3bEZ2dVAvMDd5R0ptb3V3V3lEbmlvWmFIdWZq?=
 =?utf-8?B?NGh5TGlRN3ZWdkwxL0J2dzVweWJ1ZExYWlE3UjFRVHcvNUhybGE5aUlZRnl2?=
 =?utf-8?B?VmVFcHpQYVI3QWVGOGVsaTFLY2J5cTdIZ2g3TzJYZWV2L2RpeDVYVVhxOVNa?=
 =?utf-8?B?aEtjMDZ0ejQzVWQ3aDJYSmY5RDJmbnJBSVEyOVNmaGxMYjFiUkdlTnVKNHJu?=
 =?utf-8?B?b0pINE1PalV1azlHcmhwaGJqb1BSWGFDRlRlbzhGTm9yc1V4VnlhSERoNkZp?=
 =?utf-8?B?bGhzeThYOGFhTlJqZFpxN2pOa2RXN2lkVStsc0ZSNkRhS2c1ZkVaZnp0UmJ1?=
 =?utf-8?B?bU9tQmZvcWVyMnd0UUlMOWg1eTQ5M2VHTkMyRkJFWU5mL0k1QXhnTHpQUTRI?=
 =?utf-8?B?elpWWFlvV3R6cDd2Wk5KVVREUXMxTWRmTHJiSWRoQUFaT2szVU80UDJBcC9h?=
 =?utf-8?B?Y0pxNVNwbGNmYTFmcTZMUUhlYVNWdVF0SjhsUTVzYThYNVY1QlptUFo2d0lh?=
 =?utf-8?B?ZHcrWUdiVVF0cllRMkJVQ216Ulg5Y2R4TE82NktJQVBvRmM1VHVSYzhiNzFj?=
 =?utf-8?B?SkZiZDFkZHFFT0pNSExJUHRkTWpublM5N0I4Uml2Qm4ydlo4YlBLU2Y0OGpB?=
 =?utf-8?B?akttMk9DSnAzZFdwQ0V1UEN6YUF3WDVsSUJ1OE9INnZpa3lmbkhGYzc0Y1Q3?=
 =?utf-8?B?TDRaaWlnMDZOYlovcC83TVBGOHBycExKdFBzMG4wZ2hnNEJzVlN4eUN3dGta?=
 =?utf-8?B?MkR2d202eVVMZ3RENU40RXBzM1E4TW1wWENIVW96djNsZFM4VVhhT3BCeUVo?=
 =?utf-8?B?YjdQYWl6cXlTaVhVbnNjelJWMlBGNHNmQU1Vc0JrMzIvb3NWdFp0VTdDdGFa?=
 =?utf-8?B?dmd5dkIyMEtNRUtJYmZiTFZUUUczclJKNklSQ0JoRUNVNENaZnIvc2RJWTFi?=
 =?utf-8?B?ZUhkdlM3RkFhQjBGQ1c5KzJXb2FwaW5vRUNIRDJLVTRkN3RJM3k5Sk54WnVX?=
 =?utf-8?B?ZjVkQ09LK3Z3T2tMT0RkYjRZbCs4bG02U1UzMWZkSzlPR09DNXJ1WDJoeEgw?=
 =?utf-8?B?dGVtSU8vaUhhRWhkZzF4RkZJd0RPMHJ5M3lGcTFPZk13b2pLa29qUWdiL3Ro?=
 =?utf-8?B?blR0WlhOaS9sbTR2YWxrSnFqNThUTUhQWGEwUE1FMXJXNEZoemdiVEFDeWtJ?=
 =?utf-8?B?czV5dGhlcGpieDkrL3ZPOXd2NnBrdGphWVRSRXM3OExlTWI0YUUvUSt4bFpp?=
 =?utf-8?B?TGs5V0tHT1drUm9hZTE2c2ROZGtPOWxsVkFqdFJFZmwrQXBabHRqdW9ydWUw?=
 =?utf-8?B?MEFxaHJFYUR0NHF2cEhMNkwzOTMzTUlMaEdpMHd0U3lHZ1o1VGNIaVdnZTJu?=
 =?utf-8?B?NzRwbTVzMWZzUjQrYTFERUMrNjdja3g0YTBWTVN0WExTOXNWekVhOHpCODRh?=
 =?utf-8?B?ak5EWTNvY0JMT0JGaFp5ZjRVa3M5OStsSGpSTngxdjNKbVFjd2FyN3I1bjJF?=
 =?utf-8?Q?sYHFS93GTynHgHP8otLtE9g=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b406ee9-b5bd-430d-e452-08de04f02385
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:50:56.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1e84ce18ldN8ts/3495tkSfu4OUPjnn21W5mk2a6K7BDb/JlOz4ekzgkcILkBgUijg6fo/5xPqaw7heirMbFngqxDfpuKemYC7gZjK59Dz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPFECCD46551

Hi,

Those LTTng-modules stable releases mainly fix an missing preemption off
issue with system call instrumentation when using LTTng-modules against
a Linux kernel v6.13 or more recent, with preemptible kernels (PREEMPT
or PREEMPT_LAZY configurations). Users of LTTng-modules with those
configurations should upgrade.

This issue is the result of an upstream kernel change (introduction of
faultable syscall tracepoints), without the introduction of the
corresponding changes in LTTng-modules.

One effect of this bug is corruption of per-cpu linked-lists under
load. It also possible that the ring buffer corrupts itself because
of unexpected producer migration.

The other change in those releases is the introduction of a wrapper for
`get_pfnblock_migatetype` to build against v6.17 kernels.

* New in this release:

2025-10-06 LTTng modules 2.14.2
         * Fix: Add wrapper for `get_pfnblock_migatetype`
         * Fix: Protect syscall probes with preemption disable

2025-10-06 LTTng modules 2.13.21
         * Fix: Add wrapper for `get_pfnblock_migatetype`
         * Fix: Protect syscall probes with preemption disable

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


