Return-Path: <linux-kernel+bounces-892447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD51C451D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A48C4E807B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A752E973D;
	Mon, 10 Nov 2025 06:43:31 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022093.outbound.protection.outlook.com [40.107.75.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27234A01;
	Mon, 10 Nov 2025 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757010; cv=fail; b=gUnRJhDvgT0IOk9Sf9e4G1pqxKYqKO4gUoLeKYACZ54WpKc7MT2w8Ra/iy9KIwLuEX9Kqpyz/zbEXqx64YbvmALbaqV2jLsQVYr+v28mHqZgwXNkTHfq6TYmaSX1ioPBBO7i6gzmiZFFCtEX4csgCJkxYK4u6LkSeDBnJqzFJdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757010; c=relaxed/simple;
	bh=dn1QzVSX1RJou+kwhuuwi1qMVDRVe80ILhQPpxTFZ00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U7cI4GvbPbkoJV3FTf/rETX18zTEvHptrikKxXEO5g7AzsnSXpR0rTyfGU2oFEo9nSiA7+JOZUNJCIg2/npUW5yJ6PGvNZm+cju7JrohuWcUG5Nqb+JnG58ObvOi2vm3AbEVoFyG7KgwYcpV3cIHmN4f4cybqBbKYwfFUoy4PhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPZrIziY8a+aK543DzPpYBjZ4neru3My/iAgy//0+PsVI3wJwWA11O8DXsZywP0jdF1KZxndo7XACpv/lAs1Sz3z2BfqyqW6I+RGto9qvkKOFwfKOuP60hNGjU/YHREXa330y9XVFlVZyV7IIzRWlWVLykZCMeLPLHlezk8mJiCVw+x1JZq2psa52yVX1Cfdbw2gwIZSiYEDSRCz7MTa0sqiyUdrphJV3L1y6HotX4mLdppbfIZ1Df6fHrSOfAkFbcnEJLO6FiLXsN/iuV4ywpKPzgbRoYGCGrCQ4pMHGUhBhSqj8cfZ2xv7kcm/f/xLaiMszwl54kYC0ap6QhkSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn1QzVSX1RJou+kwhuuwi1qMVDRVe80ILhQPpxTFZ00=;
 b=j70hzbp2kBavKpmP2DpmLpFDt/7I/1umNO0iObFQwhVB3sooGM9jo/nIEw8iIdUALRyrvN1BM63xv4mlBDvY+Zya655ZeOzEXrAeMcyL5XWQoKGSmJeXqAhDGt4czUdX9WfEwSNvf32SQ72ErSdK3KN3mPbCtYVrl5qtY70REuOIoQNithG+p48iQRHUnk3AwWMhi/ZbztTJH3C192al6OVQm3ohauKqt9VqhXV2q5ZHXZR7LydOsjHbredwv82jBthF91mYX4WYoGKM1RtJyBP8fEGFCofZq6lHepHX6+RVbrIxv681ESgddQni6xkPdySHfPfWaRONUpq6G3y6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from TYUPR06MB5876.apcprd06.prod.outlook.com (2603:1096:400:35e::5)
 by KL1PR0601MB5775.apcprd06.prod.outlook.com (2603:1096:820:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:43:23 +0000
Received: from TYUPR06MB5876.apcprd06.prod.outlook.com
 ([fe80::ce17:7330:b522:e920]) by TYUPR06MB5876.apcprd06.prod.outlook.com
 ([fe80::ce17:7330:b522:e920%6]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 06:43:23 +0000
From: Gary Yang <gary.yang@cixtech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogcmVzZXQ6IGFkZCBz?=
 =?utf-8?Q?ky1_reset_controller?=
Thread-Topic: [PATCH 1/3] dt-bindings: reset: add sky1 reset controller
Thread-Index: AQHcT5f429TQoTcB9UKGzGT7g1ZiKrTnNLeAgAREogA=
Date: Mon, 10 Nov 2025 06:43:23 +0000
Message-ID:
 <TYUPR06MB5876E999BEE87D3F80AF38E6EFCEA@TYUPR06MB5876.apcprd06.prod.outlook.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
	 <20251107033819.587712-2-gary.yang@cixtech.com>
 <2841ae5f1f4ccafcbed6c70866d0237b9abdc338.camel@pengutronix.de>
In-Reply-To: <2841ae5f1f4ccafcbed6c70866d0237b9abdc338.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB5876:EE_|KL1PR0601MB5775:EE_
x-ms-office365-filtering-correlation-id: f3651f50-90bd-4454-7885-08de202471a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEpCVk5GSlMxNkZEck55SGpCN1V1dUw4Q09VSkZGSS9OUGRPb2JIdzBXL2VZ?=
 =?utf-8?B?NXh4Y2hjMWtacmY5TjJjQjFnTmZqdGJsY0tYMm5yN2RwREw0UHZJc2FLSnpt?=
 =?utf-8?B?eGNpbCtRRmkvdFFDdDlweExIbS9UOGRRb2F2SnNaeWVuZ2ZMUkJtWEJwN285?=
 =?utf-8?B?enR4RzdGYkw2SEVLMkdMaVBKWW1XRW9JUEZUUHU0cVNJUzVsKzFYK2JaTGhC?=
 =?utf-8?B?ZEJFQnVCOGY2UjlicUV4MmdudGowYnE1RmdVQnk2ZkRySEZnN3NVTFJMaUc4?=
 =?utf-8?B?cTRSbksvb2RUNy9WN1lUL1lVcVRiZWNZNnZzVU8vMWhaU2ZaeXBGbVZyRDdU?=
 =?utf-8?B?NU1OUHJEZlVDYmtrR0RkalJ0V1VrNllPTHVsSFRMY3lvMFUwVnpUK28yNURa?=
 =?utf-8?B?NHBET0FhZFUyejZhQ1ZabmhZVmgxaGFMS3NkZDhBUHB2anlFV2IvcStXeW5j?=
 =?utf-8?B?NTNWSTV0TEU4aVY1b2JOY1VoMVZBNVJ0NGZpMndrZGoybjNjU1gycGRlQmEw?=
 =?utf-8?B?dWxNWkZhSlBkWkFkTDROai9kU1RFOGpyWllWTkhaaFh5WlRFMXFyRWhOZkhy?=
 =?utf-8?B?R1ZtVHh5VXcvWEtQLzNNaTlPRlY0UitNREp6UXhJWUI3MDFNeGFzemVIeFJV?=
 =?utf-8?B?d2o0VStFSTVybzljbmdiVlA4ck83OVdNVkJOWXptaTZmZWtIVlFyRUZJQ3FD?=
 =?utf-8?B?aTFjTGNIOHVwcWw1OHpidUp3c2xqWEJxUndxRGFqWlRaMEZiTjVpUnduL3Rw?=
 =?utf-8?B?WWV6aG1haCtObGxEZTZwajZVUE5ZSG9mR09MN0Yza09nMXZvMmtnOW1Jd0RE?=
 =?utf-8?B?OHdRYkgrQnVuR3grc0k0NFgweXBMYm0zVmxMVXhiblM3TmRCcDVXVXU0WkZW?=
 =?utf-8?B?MmI3ZEhhU0JmWlVQVUhJc3pCTGt0dDJ6bUVrZldEdnZrVXNPUzVTWFBzZW42?=
 =?utf-8?B?WjdKTG9FNWp4NlJCYUNmQmVHMExDY0pjWUV0cFFPTzBLRUMyRUgxUDFCdHVt?=
 =?utf-8?B?SlltbUY4TktKWW9sWWZQbTVpQmJFVkhEb1A2OWc0WFNRUXh6aWoyWVZjVGUv?=
 =?utf-8?B?bXJxVXRUSkFWbUdNcmZxd0g3RjlKS3RlTkxUWDVzWDY2a2FyYVlLT3VGWkE3?=
 =?utf-8?B?RHZ2anAyVnBaT2VocERsaEloYy9hTVF1cWEvcFU5ZXg2TTg1SUVDcnVXdEpn?=
 =?utf-8?B?MlNNU2R6bGkwNUFkUDVRb1cwd240aTB2Nk5IdHhrdUNVM1FXU1FSUTNTSm1G?=
 =?utf-8?B?SzdJODlIYytZcFVZWTFOOTM1b0c3eS80RHFiVkhJaHVRT2dpTHA3a2JNckpW?=
 =?utf-8?B?aWdlNTVKOVUvSDBCdzllM3FHTFdpUnVxS2FTTkxyNmlBajVhYnpOVVNkMUdH?=
 =?utf-8?B?VVlsRVY5M3FyUENyOE0rcVpCQjBRMjlxNldEYVlpN29oUm9rYzZCL3JxSDFC?=
 =?utf-8?B?UGJydU1CK2FtU1IzeG1qbnY5QXoyUVZudjNaT0pnaHFFUnBldk5hbUVtUjll?=
 =?utf-8?B?MkxDM2MyMGNVMXhyNStpa3hJU3UxZkZDYWg0UXBNdi9VKzhQTXdIRnhGbFNF?=
 =?utf-8?B?OUMxeTYyM0MydEpQSnNZZTMwbjJrYm1CbVdtSHU1Sk9DV0lWTjcxbTJnZFN5?=
 =?utf-8?B?eGdRMk1MWjJBMERXQ2k3ZC9TNUl2Um1YTlNIbXdVeVBSa3pxT1EyajdSeEgy?=
 =?utf-8?B?T04vRkJBT3dBbGpsTitCL1liN29mVkZPVXoxMjFLSno3a0l2MEdtbnJQMXBh?=
 =?utf-8?B?ZDc4cW05UGpabkhuQnJ5QzBqcDM3bTRldmRaNThDVkZJWE9qYkg0blRtaUpn?=
 =?utf-8?B?NFAxOW9MRVY0dDF6Lzl2cW5TOVYyZEdEZyttMDNEUkV5d1ZrMkQvU1BzL2x0?=
 =?utf-8?B?cEEzWkI5eEtRSGxVVTk3STlHSDNzbHhGeG5uRmt1Y2ZyRVRSMmFSektVanp2?=
 =?utf-8?B?Q3MzNGdzVFY3UVRqU3R0M3R5SjNjU2lLTldpK3Z0RUpGSlUrbHRqZzlkL2Jj?=
 =?utf-8?B?TVB2ZDNIczV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB5876.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXB3aHNmZ3NLckVIVkY4MjdPUTBpR3lGekpaOGZoMXRaV1ZZS1htLzY1OWdt?=
 =?utf-8?B?ZE9IL2JjakJUZHcweHdraXRkOThoL2xsc1JoSVFodWt2MFZIQ09wWE1sZXo0?=
 =?utf-8?B?eVl4ZG1ERHRXajlCL01RcWdURkF2bTF4U1QxMlRza3R4MDVKUUpIdXhueVNq?=
 =?utf-8?B?cExTMmFOR21TN2NIdER3N0lQVTdPUGVDUEFtSERDeCtEbkxCQnQ5YStZdTR3?=
 =?utf-8?B?VEFoeUwxZTJzSGFnakc3V0d1SmgzbHpxWWFrNUFrZDBSVHhHanhzVU5zdVlC?=
 =?utf-8?B?MFBMM1NadFVmZSs2cXJ1cFZlRDlOT0VSQ1VrTFMxZEdEZERpMFFENVNGMDJo?=
 =?utf-8?B?K25Ob1NiZHdmVWJjOEZiUTJhQmdwd3JDRDRRc3F6Zkh0OGdSeWtCMGtHaGxC?=
 =?utf-8?B?WFBmMndRRVVLaDRaYUNmSFM3dmYyamRVMUo0c3dDTzhEZ0JiQ25wQUIxdGRz?=
 =?utf-8?B?Yy85SWNTV3A0bFV5TGEyODVPdWFJK3JCWUh4dmw3MG1rVWhsVXR1OUx0dmE0?=
 =?utf-8?B?ZC8zcXBBdG1ZZW1leWFWMVk0R3pVTUVYNG5YampTZW1yZTVYQzVraEdpZEZ0?=
 =?utf-8?B?T0RYclpHeitSSTNiczlBZGxNZmgwSkJwV3hhYjdmcG8vbVhoNkg1cE4xWVJH?=
 =?utf-8?B?S0Q4VURqNHNEZkpvaGxxZk9rRmxWd2ZQZk5GQ2ZGelYrbG9Qb2ZUdzc2MGsw?=
 =?utf-8?B?aGxMbFhZTGtucFdTYUszNzJqdVJKdTJ5eDc3WElNWlBMaGh6WTdIcjB0Nlgy?=
 =?utf-8?B?dHhQUi9TSWhEMmZ1WlJvTExJa2N6bTNBZkwrZVk4eWIzL0oxZEorNmpWdmg1?=
 =?utf-8?B?K0FGQUp1bFg1WDJwdzJDVlY0UW5PZ0FkckJLdVh3bXRJNHVxMmErU0luQlhJ?=
 =?utf-8?B?M0pJYlBxcitQTkdvYnJ3bld3akE3dFE1T1Zwa2QxTmxZVEdiQmwvbFJBKzVt?=
 =?utf-8?B?elY1N0xDUXRObHRxMXVlNWVSS1A2dmV1ZU1pcFhPNlRRajkyYklxbERoRkZk?=
 =?utf-8?B?NkVYbzQwT1YwVDlpVXBXWisyZUlCbG1PYXRxb25wMGhjSTd2bFo2Q1VSQStY?=
 =?utf-8?B?dXYxMnpoNnBYSTNoWWlZSVJTV2JYRW0xMjNIUHVFOVZHYTVRbDMzK3l1WWly?=
 =?utf-8?B?TDJJM1BENTRKVS9HdDVvNTVkb251UlcxOVZzQUdSaS9GblR3VXpoOEVYVG5V?=
 =?utf-8?B?SW9TUUNZVEg0NEd2U2xNUFVGNk4rSTFsYVNPb1FONlhVOVN6Qkg5V3hVVjN1?=
 =?utf-8?B?ZStwUkoyd203V3J1ZnFtbkNYQjJNODZVbUVJOTB5Q2s3aXBqRjRXalRtZ1pW?=
 =?utf-8?B?L0g3Sk1JSkxiRGdVMktnYVllaU02Z1U4YzBjOHNtWlBGRFJrUEluK0N2THhR?=
 =?utf-8?B?eVNrcG5yeVFnTC80ZFMrQnVoemRJdGh5OTBOT1pzU0hXbmVneDNqcHVCMVY5?=
 =?utf-8?B?V0dPL2IyWHlidGxOVVZpOVk3eHlHTWJhYlIxeUxJRWp6eU91UVI5Zng3ZGR1?=
 =?utf-8?B?elRyQTA4YXFMcHgzTXN6NERZc290cEIzRktBejYyOTRILzlNY3JkYXVDUGVZ?=
 =?utf-8?B?clQvUHRxR244MktCbHZNQkYvSUx0V2hPRUJ3RlVuRWdQMVpyUUxVdng5L0Rk?=
 =?utf-8?B?YnI5M3lLd0ZIRXhZZHlhZ2h4OUJlUHFSMC9sVmpTQjlWZk5qTGxQS3VhckY1?=
 =?utf-8?B?eThMSUc4ZXVHd0NJQXp2bUdHVnVQbnRGRUQwcGZ6eFJuYTRKMHJIYW1tbUo1?=
 =?utf-8?B?UUFickNJR3dId1RWcHYyNlVyN3g3R0NkUk1DNStuamozV0IzcDRBRG4rK25k?=
 =?utf-8?B?eXNXUFg3YmVDV0ZLQWlKZkEyTkVoWjdwaGxlY2t2bzRVWExKTTJNOWtvb2hs?=
 =?utf-8?B?YWk0UTV2VlFWUkNuY3p2bk1rSkZHNXV4VDBiTUsrQnBsZk5wZENKaG1JYlpN?=
 =?utf-8?B?T1R1VCtOclhUM2EzUGRCMnRRQkluREF3K0NxditvT1lNcTRoRDM3WXB6Q2NZ?=
 =?utf-8?B?dDNWdjYwRURXNnN6Y0poYXhOUlIxM2Q5N0xTbGJheVVNeFFDOWNWSzMxMmhT?=
 =?utf-8?B?aG5URGtWa0JpS01EdDYxdERQRkJOVzR4ZHl1SEtLRDdHaTZrMWJkTW9kWlZL?=
 =?utf-8?Q?GlrVNI+Tf5yuq4dseRA8hxYG5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB5876.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3651f50-90bd-4454-7885-08de202471a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 06:43:23.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFuI2HtMS7qtIB6Dor6Jz29UItoduaB60rhMwIb3ULQoIZMq/AKV1xYjbbv4htxFcw70mbkyCaqiU7OFE+YwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5775

SGkgUGhpbGlwcDoNCg0KRmlyc3QgdGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzDQoNCj4gLS0tLS3p
gq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVu
Z3V0cm9uaXguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDEx5pyIN+aXpSAyMToyNQ0KPiDm
lLbku7bkuro6IEdhcnkgWWFuZyA8Z2FyeS55YW5nQGNpeHRlY2guY29tPjsgcm9iaEBrZXJuZWwu
b3JnOw0KPiBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmcNCj4g5oqE6YCB
OiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBjaXgta2VybmVsLXVw
c3RyZWFtDQo+IDxjaXgta2VybmVsLXVwc3RyZWFtQGNpeHRlY2guY29tPg0KPiDkuLvpopg6IFJl
OiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogcmVzZXQ6IGFkZCBza3kxIHJlc2V0IGNvbnRyb2xs
ZXINCj4gDQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gcC56YWJlbEBwZW5ndXRy
b25peC5kZS4gTGVhcm4gd2h5IHRoaXMgaXMNCj4gaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTA0K
PiANCj4gQ0FVVElPTjogU3VzcGljaW91cyBFbWFpbCBmcm9tIHVudXN1YWwgZG9tYWluLg0KPiAN
Cj4gT24gRnIsIDIwMjUtMTEtMDcgYXQgMTE6MzggKzA4MDAsIEdhcnkgWWFuZyB3cm90ZToNCj4g
PiBUaGVyZSBhcmUgdHdvIHJlc2V0IGNvbnRyb2xsZXJzIG9uIENpeCBza3kxIFNvYy4NCj4gPiBP
bmUgaXMgbG9jYXRlZCBpbiBTMCBkb21haW4sIGFuZCB0aGUgb3RoZXIgaXMgbG9jYXRlZCBpbiBT
NSBkb21haW4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYXJ5IFlhbmcgPGdhcnkueWFuZ0Bj
aXh0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3Jlc2V0L2NpeCxza3kxLXJz
dC55YW1sICAgICAgICAgIHwgIDQ4ICsrKysrDQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvcmVz
ZXQvY2l4LHNreTEtcnN0LWZjaC5oICB8ICA0NSArKysrKw0KPiA+ICBpbmNsdWRlL2R0LWJpbmRp
bmdzL3Jlc2V0L2NpeCxza3kxLXJzdC5oICAgICAgfCAxNjcNCj4gKysrKysrKysrKysrKysrKysr
DQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjYwIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2Np
eCxza3kxLXJzdC55YW1sDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRp
bmdzL3Jlc2V0L2NpeCxza3kxLXJzdC1mY2guaA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9kdC1iaW5kaW5ncy9yZXNldC9jaXgsc2t5MS1yc3QuaA0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9jaXgsc2t5MS1yc3Qu
eWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2NpeCxz
a3kxLXJzdC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAw
MDAwMDAuLjcyZGU0ODBiMDY0Yw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvY2l4LHNreTEtcnN0LnlhbWwNCj4gPiBA
QCAtMCwwICsxLDQ4IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcmVzZXQvY2l4LHNreTEtcnN0LnlhbWwjDQo+ID4g
KyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0K
PiA+ICsNCj4gPiArdGl0bGU6IENJWCBTa3kxIFJlc2V0IENvbnRyb2xsZXINCj4gPiArDQo+ID4g
K21haW50YWluZXJzOg0KPiA+ICsgIC0gR2FyeSBZYW5nIDxnYXJ5LnlhbmdAY2l4dGVjaC5jb20+
DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIENJWCBTa3kxIHJlc2V0IGNvbnRy
b2xsZXIgY2FuIGJlIHVzZWQgdG8gcmVzZXQgdmFyaW91cyBzZXQgb2YgcGVyaXBoZXJhbHMuDQo+
ID4gKyAgVGhlcmUgYXJlIHR3byByZXNldCBjb250cm9sbGVycywgb25lIGlzIGxvY2F0ZWQgaW4g
UzAgZG9tYWluLCB0aGUNCj4gPiArb3RoZXINCj4gPiArICBpcyBsb2NhdGVkIGluIFM1IGRvbWFp
bi4NCj4gPiArDQo+ID4gKyAgU2VlIGFsc286DQo+ID4gKyAgLSBkdC1iaW5kaW5ncy9yZXNldC9j
aXgsc2t5MS1yc3QuaA0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxl
Og0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgIC0g
Y2l4LHNreTEtcnN0DQo+ID4gKyAgICAgICAgICAtIGNpeCxza3kxLXJzdC1mY2gNCj4gPiArICAg
ICAgLSBjb25zdDogc3lzY29uDQo+IA0KPiBXaHkgaXMgdGhpcyBzeXNjb24/IElzIHRoZXJlIGFu
eXRoaW5nIGJlc2lkZXMgcmVzZXQgY29udHJvbHMgaW4gdGhlIHJlZ2lzdGVyDQo+IHNwYWNlPw0K
PiANCg0KWWVzLCB0aGVyZSBhcmUgc29tZSBjb250cm9sbGVycyBpbiB0aGUgcmVnaXN0ZXIgc3Bh
Y2UsIGZvciBleGFtcGxlLCBhIGNvbnRyb2xsZXIgdXNlZCB0byBtYW5hZ2VyIHdha2UgdXAgc291
cmNlcy4NCg0KQmVzdCB3aXNoZXMNCkdhcnkNCg0KPiByZWdhcmRzDQo+IFBoaWxpcHANCg==

