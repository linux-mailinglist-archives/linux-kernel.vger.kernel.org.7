Return-Path: <linux-kernel+bounces-750314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA19B159EC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0983818C0E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362A91624EA;
	Wed, 30 Jul 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="IPdJkFb/"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18876242D9B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861581; cv=fail; b=qWKF0TVtOC64I4pl7FnqsoCnuKosIpKQH/14hKxJ2Zl+vi6ktCR3gIdyo4ETm5ZgahTbMHlz6ns8R4to5Je40o4fhnIh8wo0ym+rBJUGA5nrGemHRLVyZ3NzH3HWAaYM18enJcWocXCGg2QAUkxv9xhaaKqsKEuzT4O2Uqgf9xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861581; c=relaxed/simple;
	bh=uY+oFBN1WGjgD+E0UghNqg3oVMr2saLeWUpdwchdEoI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mlLxrVye+k9Bxv3/YVGofPuZwiQ2L6KNd9LTc2YCzuDdNs/PorkkSOT/x8iEu5lV1rUnZ3yXmXD9+CjAC/+Hhy6BhX6Vp1Zy8bO3IJmeq171tDN53mAVymgF45onAPD4ahUQjHXj/KNYBEP56dCR39G9RuL4qUNafHwpfLn5pyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IPdJkFb/; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrPosiHqrXq8CFpZbKsld25IounkdB+0Ob1rae/i4xLI2QXj9Bz07tS+t4lKvPo/ocZcJZSf0Zq9CGEI4WCbej8jPe1UDTgScN1OwW4DAk9QANK6TNy6pRwcSlz8RA7l2njR6dXyxArvoeAnbVPrFDujtysSokXPUk0WO5WMdxANDPTzBtd1kmR2MlQL4yc2ggGRGVQ5jea5FK7fOd7btOAuS1MmrwZ2oUcuQ+2rhG1ACC5yBmctde0hmAPLmj532l0yu0jBoEtFzneM+USh9EGEaXDHsct33o0AgW+xNtaq2MAXkwYjK4udU13FA0U/rerJpDtigt0HDbORbLUoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY+oFBN1WGjgD+E0UghNqg3oVMr2saLeWUpdwchdEoI=;
 b=NOoyefGlbICv8VmxRyipucC94sRq+DnF3qSsqdbYKf+Va+aGeFMrV28wtJ7kFeSGXtpy9X0x5sxjTx1bumePMDQEKdQW10JfXEirsTtWZRtMBlEnLzX6zYh307iR0FyjcN8IjV8loW4GCIZOkxJ689Vmho/I5MDWzKs0Gu0rDcmm4yxMvxfYmwlxqBe3RL2j3XYKZFwMnrjbZzekW3t5uII9hPqRjstQYLw92coxV+q5MGq6CMtzJKfavoVNH5Ggm9NdB6ZGD60MR+YJII7yPCLd6XEKWNLJ8rXk4iK1PbNKKHE9cveWP+KmxIiKwtkvd7FP1NHOCXg73502DTs3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY+oFBN1WGjgD+E0UghNqg3oVMr2saLeWUpdwchdEoI=;
 b=IPdJkFb/ejAh7n5jPrULtpo79rD3DzdDOYzfyrAhs8rOMZ0qZ4FJ+qn1Phk60I5rxLpUcWhd3diZSgfAWA03BTCD0vo2FT7ljb42gmtqSe27D0SgG89zHegJBq1udT7WrvuX7jR/A4aNKHLTrezDwQPxSY82RwOnEs3hq9DYKMX1esId6huneHh8Z+h7i2xhJoKE/LNVoUtgAxZZL//xrc1OmeKEni/CQvavdAw9tWTd3AxSVciVh4eGM39QLh/Mcb0WSqeH9LSvONYGmRDAr46I7tV2yMW/8aKHw7pNoxWLdKe5YDoFs3bnxK5APunzlR7yEnS9tKwGu3SW8dGf6g==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DS0PR03MB7278.namprd03.prod.outlook.com (2603:10b6:8:12e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 07:46:15 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 07:46:14 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Michael Walle <mwalle@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, "open list:SPI NOR SUBSYSTEM"
	<linux-mtd@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>,
	"Gerlach, Matthew" <matthew.gerlach@altera.com>
Subject: RE: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Thread-Topic: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Thread-Index: AQHcAPLLJpnSjUK3G0+J/n9y4LRWFbRKRaUAgAAAp3A=
Date: Wed, 30 Jul 2025 07:46:14 +0000
Message-ID:
 <MN2PR03MB49271E2D022D305BC149BA4FC624A@MN2PR03MB4927.namprd03.prod.outlook.com>
References: <cover.1753839339.git.khairul.anuar.romli@altera.com>
 <566fc1168db723672ab0bc6482ec7b72b4b8fe2b.1753839339.git.khairul.anuar.romli@altera.com>
 <DBP7P3RWX17B.14Q27IBS3T3FL@kernel.org>
In-Reply-To: <DBP7P3RWX17B.14Q27IBS3T3FL@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|DS0PR03MB7278:EE_
x-ms-office365-filtering-correlation-id: aad2c316-7f36-460b-dc21-08ddcf3d2939
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1pnUkdneHhoSlpXbGo0dlkzYTJZZjh6ZWdWalRzY1YyOFFQcXdTMys0MlEw?=
 =?utf-8?B?NDlNbjNvSjBDMzcwdUlteE0xQUJRS091WHhqRC9CWmw1UVVtejBEY2c4dnZx?=
 =?utf-8?B?SFZ1NXM3VHo5WGJHMjdPVU1IaUkrRmxVUXU4dGoxcmhrMkh0WkEvbVVPWDkx?=
 =?utf-8?B?VitvNklZUG43KzE3RUI5ejdKcDJRbDVXK2FhVklONlh5SUtYYUo2cXZvU054?=
 =?utf-8?B?Z2N4aUdIaWxNNXZTd0dxQzEzTjhOSlBtRkQyeFVBUk91SEk2eG5HZ2ZOSElQ?=
 =?utf-8?B?Zjk0UndYbWU1QnNkOVBFRzVSdGNTdytJK3ZQMFFBUHNSQTUyWWo5aEQyYnU0?=
 =?utf-8?B?SmV5QTRhc3dEUzFDcTdYM2xGNUxHR1VEVFBtWW01cWtZcDhtOHpzL1hQd1ZH?=
 =?utf-8?B?WFNQZTVQWVAxbHRCR2ZwNWZSQjQ2QllRRnZSb2RDR0YvVXBTdjM4MjlBUTlk?=
 =?utf-8?B?a280TURDbXlrelFUS1RyazJ3aXRWbnpEOUpReEd5Zy9lMVVUbUtLaFhCUzdm?=
 =?utf-8?B?RWdNeldUeUptT1FjclJKMmlwRGl4cXNFZUpMb2FuQktMY01FR2tiSzBnWERj?=
 =?utf-8?B?cVB3Zy95Q2pmbVFYOFpGTDNYQUJ2UVQvQXdmd0l6UmYxMEowR0l1YXFRUHd3?=
 =?utf-8?B?YUdsZmlCQWE0bjlPRGJMUFZrazdUcWEvWk9Qc3I1RUQ0aHU0aFpscUttWXFQ?=
 =?utf-8?B?Tlg4RzhVS3IxUzZELzNRYzkzL1ErWHV4SnNvb2dLMjBDMTJickZXR0dEeEpN?=
 =?utf-8?B?TnJnTmtVQ3ZJcUJZQTZMUlRoMStUWXFsVUM4WVFSNVRCZDJkRmYyRnNqVkcr?=
 =?utf-8?B?bjF4b0ExcG5xaHBTeCtDWjY3M01UY3FkZE9EVkt5MmFlV2VtVWk3dnJuRytD?=
 =?utf-8?B?cGtpeFptb2lCbHdzc3pWK0kzR0VPRmJzV3lRMjFVamlzdnF5QXViSXJYa1RH?=
 =?utf-8?B?ZEdnL3VnZHB0YzZXaG50cjJWWGE4endrcTZOY3NmN1ZGKzlhcjZkWnZSbWl1?=
 =?utf-8?B?NERBUnhWVHpzNzRMWXg5SFNpc3BUTGw2ZUIyeHlhSmtybUZpblJDaVdLcVVD?=
 =?utf-8?B?b05EUVlkYjA2azcrWEVuYmlTQktkRzY2TGpkMDFvVVF6aFZhbTNYVCt5WCsy?=
 =?utf-8?B?azdueXNaZW4yWnloaWtiTU1xc1l5RzJrMmJtTFQ3N0t4N2xDdVdLMVBNa2E3?=
 =?utf-8?B?aStKMllVT2UrWWdjdUlMTGxmamQ5a1pybmREcnBBRnFQSDRwVjZ4ZXNpVkdp?=
 =?utf-8?B?cWd4ZjZMUFZvaTZ6T2VremhML3dBSXhUakE4RnpQRWZ6WE1IUnRJdGZvNkx1?=
 =?utf-8?B?Y0tVN2NhVk9Da2JtVjBFK3ZMWXNxRUM4eXc5bENLT1doZjdGblU3YzJFZmdW?=
 =?utf-8?B?VTN4QkN0bTZ3cHhybjRDWVlhZ09OeE15NEpuVlF5Z2JRUlk5U2xxaEs4bTlj?=
 =?utf-8?B?YlZDanhLaW8yR3pSalFQVUU0dHIreDdaUWFySVJ2OHpBaTVEZmQ4c2F3TWI2?=
 =?utf-8?B?NUg1dXM3ZEZHSmg4N3VhdkwvZ0JEZTNTV091Q2tBWUt1RkI2OW5RZUVvQ25L?=
 =?utf-8?B?WW9VUzFSd2oxd1o3dUJsRVhWZjdtWEdkcmRlOUhCUlVlQjMyU2hvak9WMnlo?=
 =?utf-8?B?S1VXa1ROMWR4c1BDbTRhU242UXlCQk9oaStiTFhYK1JkaVhKTWRONzJIeEk3?=
 =?utf-8?B?Ym5oVXRaaFBQZWIxUTBSS05lMzNSMmpMRWRrS2NtQ0R1VUhCTUNxbXZ3c1M4?=
 =?utf-8?B?TGRKQzA4SE1WeWtXTkhVOFRiYXhYZ2VmbEdSK1FCMXV3VXdoS2ZYaHI5eWR3?=
 =?utf-8?B?SlBRS2FEU3NKOE5JNm5ZZ0dmWGp6VWF4N2dzOTlGaFdLN1BicFBzb2ZSa3RX?=
 =?utf-8?B?R2wxQXNPTUNUMGVseXA2eWlDdGJ1aSs4bmVUd09kcGJhM0JHN3Z4cUsyRVRO?=
 =?utf-8?B?UnBCNHNCWjJjWVlIQUNNbCtIelVGUWpjTHUzNGNNV2pkRFRZUnhYbkdKM25l?=
 =?utf-8?Q?1QpO3WajCZ1QVs1XJiAXbrBSKaeNsw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2pKWTF6eG93WThXbjZUWnlWRWRnY2NQZmsrRkkxV2JGc1Y0SDJQZldpbnlS?=
 =?utf-8?B?THhVL1RrVm5yUEJ5ZGxQczBhM3RqVjl3ZjQrN2FmalBVNHkzTUg5WGVUaElv?=
 =?utf-8?B?MG1XalFHcDdreG1CT1U3aSs1djRzS3hrVlJvUU8rUmlEOTNEc3F1djZ4WXNv?=
 =?utf-8?B?YWFOT1pjU05GNElFbUF2a0pad2pUaU1tbjFQckE2akZWaXlRMXlFUUxGRGVR?=
 =?utf-8?B?SjFDMWFKcTFiMmVmMkovZGczVUVHRlBGSmx2UDdKQ0pMSEJGT1hiNW1hcXJX?=
 =?utf-8?B?bmkxaE91RWM5KzhDaXBoL1NwUm1DQzIxU3RRdHBDQzhPc0xlUDcvZ3U4VUdR?=
 =?utf-8?B?cVpDNnAzLzZxMUpvSGd3YVFQRTBKK1NtU2JPcWV1eVhMY2ZMQTVzRElDdGFp?=
 =?utf-8?B?VytFN1RmeTYzYkZIbUIwZlBVR2I1NzBMZEtEcVE2dWV2QjZaTXR1WWJQdGxO?=
 =?utf-8?B?WFZKSklUSmkzSFVWclZHNE5ma0hTYUFtMDFFTnJKTjZUbVkyVXRBTEFCVFhw?=
 =?utf-8?B?ZC9VbjdXak83YkVteXJIVHVTQTBKUWp0S0NtTEpuMHlvdWlRSVFUTGVyQ2tU?=
 =?utf-8?B?RE9IUGpRWXVuSDVXU1BPWWVRMW54NlhpbFovQ2s4MXczaUY3Z0ltNUlGajhj?=
 =?utf-8?B?NGkwb2RyVUpiVUVMNEhGUFFaRUZ5bGkwbUFOTHl0KzQ4WHoyb3NNM241WU9D?=
 =?utf-8?B?UTFLUlhadEd3blFNeWI0TDA1MXRES3crOVdQTW10KzlvQ1BuQ21FMFp3WEdS?=
 =?utf-8?B?Z0FZcU1nYUd1WGVqM29ORXdJRGxaVlcwSVVFa2Z0S1FhUkplVTJQSncvVFEx?=
 =?utf-8?B?Tk9IQ1lUQVpjcmVPQjJ5c0RJNm1ianJ2Z2pvU3RZSUlMa2hOaGRuQk9zZHBR?=
 =?utf-8?B?czZBSnlXZHp2aDFRRU00S3JCTG1oNmpxc0hvandyU0RONzNVTUM2Y25jb2Nt?=
 =?utf-8?B?c0FMcTlwQk12VWgzcmVDKzZEQXRmbVo2Rm5EZHBOMlpmTElRQkgybVFIdUhL?=
 =?utf-8?B?KzFGbkpya2NZS2ZYNTJ0QVowbXRNWEJ5Z0ozV3BQY1FLTXNOUnRtaVYzMU1C?=
 =?utf-8?B?VkJXR0pjL21jbHZiSk9ESVMvZWpiNkF5czNZVFNsQ25ROElkUE9QdExReUZz?=
 =?utf-8?B?cnhhT3BRS056b3ZoNHAzT05xWksrK1YvVHgrTzRyTXJnRnNYUE9OdFlJZ3dD?=
 =?utf-8?B?YUNIYUl5ckZQV2FXQ2ZCcDRaL0kzeUlkZ3dabWhoU3dtZE1RNU1xMHVzdWlG?=
 =?utf-8?B?aVRSV2oyUStzOUdyemJ6Nm56OHRNWFRWVEdGMUlKa0ZTWFp0RFFjc2NsOHp4?=
 =?utf-8?B?YzNjZHQ1VHJsTER5dEtxYklwT0lYdGN2ZS91MEFoYTk1Nit2bUdPYzFZbjdh?=
 =?utf-8?B?eW1HcmxBb3FwTkFJcFB6VDdkNmhXT1BFN2FKelI0clg5amZUVktJeDYyejBC?=
 =?utf-8?B?Rm5uMW54akg0S2ZGTUxBY2dXcHZETFhIVTZCOXdEK1p4M29ITjdTbzIzWTd5?=
 =?utf-8?B?VkxPNHBlNTEwZHVtM1pOK21pOW4wM3hCQ0xydlg2VXl1aURwYS94bE1sMms4?=
 =?utf-8?B?Uk84aXhqalNkeGltQ3pYakxhM1dTbStrei9UVXI5dkVYUlFOUlNYbWs3VDd6?=
 =?utf-8?B?bm9DVUtPcEs2SlgyME1YNTlUTzlpRWszaUcvRkdBTzB5c1FsNUxhMGJqVGg4?=
 =?utf-8?B?UittRi9nWDNZQ0RKL1RFNUllbXBxNFFEVDI4bnp0T3JwZ3RpSks2VEM4bTlF?=
 =?utf-8?B?VXh4VUdzYTJVNTczSkV2NUN6cDBRWXZzMC9nTURyeE12S1lKdTVNLzNBVTZh?=
 =?utf-8?B?SUMzV3hINHMrQzVMSFc2aW5RcXd0bENFc2dZRXozdDhaQlh6ckZwQlpCL3Mz?=
 =?utf-8?B?WE80OEp4a1JLb1RkdGQrelpwOGZqTlJYYkwvVXludkZyVzY5V1lFaTZ0Y1d4?=
 =?utf-8?B?aHJEN0xjWDFtNUh4VURER3FYQkYwd3Q5T0QySmx1M0VpSFVFZUxpRzArWG5E?=
 =?utf-8?B?cUI3KzRFWG92SmNwdG4rdXJnNUlaRGY5QUEyQkRqSzFvaXJqZXlSUUxyeEJh?=
 =?utf-8?B?SnlGUkJnRzVqTEdVb0dzRVhRMkw5alpPVXpTdGd0N084elRJZnNQVzRNb292?=
 =?utf-8?Q?q1Uraki+Y7tAl5d/norsL0X8a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad2c316-7f36-460b-dc21-08ddcf3d2939
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 07:46:14.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HwC7TNEiB4eMal61hSKSN6lIIeGc1YsSW5bAUf76FXkI7HCI7sUOKftlpcNEV83SDh+a2XoUzt6AxpWrck86ZtFYmrYKItGQlJ6nWPPAB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7278

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBXYWxsZSA8
bXdhbGxlQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMzAgSnVseSwgMjAyNSAzOjMw
IFBNDQo+IFRvOiBSb21saSwgS2hhaXJ1bCBBbnVhciA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRl
cmEuY29tPjsgVHVkb3IgQW1iYXJ1cw0KPiA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPjsgUHJh
dHl1c2ggWWFkYXYgPHByYXR5dXNoQGtlcm5lbC5vcmc+OyBNaXF1ZWwNCj4gUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPjsgUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5h
dD47DQo+IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT47IG9wZW4gbGlzdDpT
UEkgTk9SIFNVQlNZU1RFTQ0KPiA8bGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBvcGVu
IGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBHZXJsYWNoLCBNYXR0aGV3
IDxtYXR0aGV3LmdlcmxhY2hAYWx0ZXJhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAx
LzFdIG10ZDogc3BpLW5vcjogY29yZTogUHJldmVudCBvb3BzIGR1cmluZyBkcml2ZXINCj4gcmVt
b3ZhbCB3aXRoIGFjdGl2ZSByZWFkIG9yIHdyaXRlIG9wZXJhdGlvbnMNCj4gDQo+IEhpLA0KPiAN
Cj4gT24gV2VkIEp1bCAzMCwgMjAyNSBhdCAzOjM5IEFNIENFU1QsIEtoYWlydWwgQW51YXIgUm9t
bGkgd3JvdGU6DQo+ID4gRnJvbToga3JvbWxpIDxraGFpcnVsLmFudWFyLnJvbWxpQGFsdGVyYS5j
b20+DQo+ID4NCj4gPiBFbnN1cmUgdGhhdCB0aGUgcG9pbnRlciBwYXNzZWQgdG8gbW9kdWxlX3B1
dCgpIGluIHNwaV9ub3JfcHV0X2RldmljZSgpDQo+ID4gaXMgbm90IE5VTEwgYmVmb3JlIHVzZS4g
VGhpcyBjaGFuZ2UgYWRkcyBhIGd1YXJkIGNsYXVzZSB0byByZXR1cm4NCj4gPiBlYXJseSwgcHJl
dmVudGluZyB0aGUga2VybmVsIGNyYXNoIGJlbG93IHdoZW4gdGhlIGNhZGVuY2UtcXNwaSBkcml2
ZXINCj4gPiBpcyByZW1vdmVkIGR1cmluZyBhIGRkIG9wZXJhdGlvbjoNCj4gDQo+IEFzIGFscmVh
ZHkgYXNrZWQgaW4gdjIuIFRoaXMgbmVlZHMgYSAobW9yZSBkZXRhaWxlZCkgZGVzY3JpcHRpb24g
d2hhdCBpcyBnb2luZw0KPiBvbiBhbmQgd2hhdCBpcyBnb2luZyB3cm9uZy4NCj4gDQo+IC1taWNo
YWVsDQoNCkhpLA0KDQpXZSBqdXN0IHJ1biB0aGUgZm9sbG93aW5nIHRlc3Qgd2Ugb2JzZXJ2ZSB0
aGUgY3Jhc2guIA0KDQp0aW1lIGRkIGlmPS9kZXYvbXRkMSBvZj1vdXQuaW1nIGJzPTFNQiBjb3Vu
dD0xMDAwICYNCmVjaG8gc3BpMC4wID4gL3N5cy9idXMvc3BpL2RyaXZlcnMvc3BpLW5vci91bmJp
bmQNCmVjaG8gc3BpMC4wID4gL3N5cy9idXMvc3BpL2RyaXZlcnMvc3BpLW5vci9iaW5kDQoNCkZy
b20gdGhlIG9ic2VydmF0aW9uLCB0aGUgZGQgaXMgbm90IGVudGlyZWx5IHRlcm1pbmF0ZWQgd2hl
biB0aGUgdW5iaW5kIHRvb2sgcGxhY2UuDQpNYXliZSB0aGVyZSBpcyBvdGhlciBjaGFuZ2VzIHJl
cXVpcmUgdG8gZW5zdXJlIHRoZSBkZCBvcGVyYXRpb24gZ2V0cyB0ZXJtaW5hdGVkIA0Kd2hlbiBk
cml2ZXIgdW5iaW5kL3JlbW92ZS4NCg0KPiA+IFsgIDIwMC40NDg3MzJdIFVuYWJsZSB0byBoYW5k
bGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZiBlcmVuY2UgYXQNCj4gPiB2aXJ0dWFsIGFkZHJl
c3MgMDAwMDAwMDAwMDAwMDAxMCBbICAyMDAuNDU3NTc2XSBNZW0gYWJvcnQgaW5mbzoNCj4gPiBb
ICAyMDAuNDYwMzcwXSAgIEVTUiA9IDB4MDAwMDAwMDA5NjAwMDAwNA0KPiA+IFsgIDIwMC40NjQx
MzZdICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+ID4gWyAg
MjAwLjQ2OTUyN10gICBTRVQgPSAwLCBGblYgPSAwDQo+ID4gWyAgMjAwLjQ3MjYwOV0gICBFQSA9
IDAsIFMxUFRXID0gMA0KPiA+IFsgIDIwMC40NzU5MDRdICAgRlNDID0gMHgwNDogbGV2ZWwgMCB0
cmFuc2xhdGlvbiBmYXVsdA0KPiA+IFsgIDIwMC40ODA3ODZdIERhdGEgYWJvcnQgaW5mbzoNCj4g
PiBbICAyMDAuNDgzNjU5XSAgIElTViA9IDAsIElTUyA9IDB4MDAwMDAwMDQsIElTUzIgPSAweDAw
MDAwMDAwDQo+ID4gWyAgMjAwLjQ4OTE0MV0gICBDTSA9IDAsIFduUiA9IDAsIFRuRCA9IDAsIFRh
Z0FjY2VzcyA9IDANCj4gPiBbICAyMDAuNDk0MTg5XSAgIEdDUyA9IDAsIE92ZXJsYXkgPSAwLCBE
aXJ0eUJpdCA9IDAsIFhzID0gMA0KPiA+IFsgIDIwMC40OTk1MDBdIHVzZXIgcGd0YWJsZTogNGsg
cGFnZXMsIDQ4LWJpdCBWQXMsDQo+ID4gcGdkcD0wMDAwMDAwMTg1ZGY4MDAwIFsgIDIwMC41MDU5
MzJdIFswMDAwMDAwMDAwMDAwMDEwXQ0KPiA+IHBnZD0wMDAwMDAwMDAwMDAwMDAwLCBwNGQ9MDAw
MDAwMDAwMDAwMDAwMCBbICAyMDAuNTEyNzIwXQ0KPiBJbnRlcm5hbA0KPiA+IGVycm9yOiBPb3Bz
OiAwMDAwMDAwMDk2MDAwMDA0IFsjMV0gUFJFRU1QVCBTTVAgWyAgMjAwLjUxODk2OF0NCj4gTW9k
dWxlcw0KPiA+IGxpbmtlZCBpbjogODAyMXEgZ2FycCBtcnAgc3RwIGxsYyBibHVldG9vdGggZWNk
aF9nZW5lcmljIGVjYyByZmtpbGwNCj4gPiBjcmN0MTBkaWZfY2UgcnRjX2RzMTMwNyBhdDI0IHN0
cmF0aXgxMF9zb2Mgc29jNjRfaHdtb24gZ3Bpb19hbHRlcmEgb2YNCj4gPiBfZnBnYV9yZWdpb24g
ZnBnYV9yZWdpb24gZnBnYV9icmlkZ2UgdWlvX3BkcnZfZ2VuaXJxIHVpbyBmdXNlIGRybQ0KPiA+
IGJhY2tsaWdodCBpcHY2IFsgIDIwMC41NDAwMTZdIENQVTogMCBVSUQ6IDAgUElEOiAzNzIgQ29t
bTogZGQgTm90DQo+ID4gdGFpbnRlZCA2LjEyLjE5LWFsdGVyYS1nYjZiMjYNCj4gPiBjNDE3OWE2
ICMxDQo+ID4gWyAgMjAwLjU0Nzk5Nl0gSGFyZHdhcmUgbmFtZTogU29DRlBHQSBTdHJhdGl4IDEw
IFNvQ0RLIChEVCkgWw0KPiA+IDIwMC41NTMyOTJdIHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFp
ZiAtUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTDQo+ID4gQlRZUEU9LS0pIFsgIDIwMC41NjAyMzRd
IHBjIDogc3BpX25vcl9wdXRfZGV2aWNlKzB4MzAvMHg2MCBbDQo+ID4gMjAwLjU2NDU5NF0gbHIg
OiBfX3B1dF9tdGRfZGV2aWNlKzB4OGMvMHgxMjAgWyAgMjAwLjU2ODg1Nl0gc3AgOg0KPiA+IGZm
ZmY4MDAwODQxMWJjMjAgWyAgMjAwLjU3MjE2MV0geDI5OiBmZmZmODAwMDg0MTFiYzIwIHgyODoN
Cj4gPiBmZmZmMDAwMTg1ZTJjNTAwIHgyNzogMDAwMDAwMDAwMDAwMDAwMCBbICAyMDAuNTc5Mjgy
XSB4MjY6DQo+ID4gMDAwMDAwMDAwMDAwMDAwMCB4MjU6IGZmZmYwMDAxODVlMmNiMDAgeDI0OiBm
ZmZmMDAwMTg1ZTJjYzg4IFsNCj4gPiAyMDAuNTg2NDA0XSB4MjM6IGZmZmYwMDAxODAzNGM2MjAg
eDIyOiAwMDAwMDAwMDAwMDAwMDAxIHgyMToNCj4gPiBmZmZmMDAwMTg4NzNlMDgwIFsgIDIwMC41
OTM1MjRdIHgyMDogMDAwMDAwMDAwMDAwMDAwMCB4MTk6DQo+ID4gZmZmZjAwMDE4ODczZTA4MCB4
MTg6IGZmZmZmZmZmZmZmZmZmZmYgWyAgMjAwLjYwMDY0NV0geDE3Og0KPiA+IDAwMzAzOTNkNTI0
ZjRhNDEgeDE2OiA0ZDAwNjQ3NDZkM2Q0ZDQ1IHgxNTogZmZmZjAwMDE4NTc1NzcwMCBbDQo+ID4g
MjAwLjYwNzc2N10geDE0OiAwMDAwMDAwMDAwMDAwMDAwIHgxMzogZmZmZjAwMDE4MDA0NTAxMCB4
MTI6DQo+ID4gZmZmZjAwMDE4NTc1NzZjMCBbICAyMDAuNjE0ODg4XSB4MTE6IDAwMDAwMDAwMDAw
MDAwM2EgeDEwOg0KPiA+IGZmZmYwMDAxODAwNDUwMTggeDkgOiBmZmZmMDAwMTgwMDQ1MDEwIFsg
IDIwMC42MjIwMDldIHg4IDoNCj4gPiBmZmZmODAwMDg0MTFiYjcwIHg3IDogMDAwMDAwMDAwMDAw
MDAwMCB4NiA6IGZmZmYwMDAxODEzMjUwNDggWw0KPiA+IDIwMC42MjkxMjldIHg1IDogMDAwMDAw
MDA4MjAwMDFjZiB4NCA6IGZmZmZmZGZmYzYwMDk1ZTAgeDMgOg0KPiAwMDAwMDAwMDAwMDAwMDAw
IFsgIDIwMC42MzYyNTBdIHgyIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6DQo+IGZmZmYwMDAxODg3
M2UwODAgeDAgOiAwMDAwMDAwMDAwMDAwMDAwIFsgIDIwMC42NDMzNzFdIENhbGwgdHJhY2U6DQo+
ID4gWyAgMjAwLjY0NTgxMV0gIHNwaV9ub3JfcHV0X2RldmljZSsweDMwLzB4NjAgWyAgMjAwLjY0
OTgxNl0NCj4gPiBfX3B1dF9tdGRfZGV2aWNlKzB4OGMvMHgxMjAgWyAgMjAwLjY1MzczMV0NCj4g
cHV0X210ZF9kZXZpY2UrMHgzMC8weDQ4IFsNCj4gPiAyMDAuNjU3Mzg3XSAgbXRkY2hhcl9jbG9z
ZSsweDMwLzB4NzggWyAgMjAwLjY2MDk1OF0NCj4gX19mcHV0KzB4YzgvMHgyZDANCj4gPiBbICAy
MDAuNjY0MDExXSAgX19fX2ZwdXQrMHgxNC8weDIwIFsgIDIwMC42NjcxNDZdDQo+ID4gdGFza193
b3JrX3J1bisweDcwLzB4ZGMgWyAgMjAwLjY3MDcxOF0gIGRvX2V4aXQrMHgyYjQvMHg4ZTQgWw0K
PiA+IDIwMC42NzM5NDRdICBkb19ncm91cF9leGl0KzB4MzQvMHg5MCBbICAyMDAuNjc3NTEyXQ0K
PiA+IHBpZF9jaGlsZF9zaG91bGRfd2FrZSsweDAvMHg2MCBbICAyMDAuNjgxNjg2XQ0KPiA+IGlu
dm9rZV9zeXNjYWxsKzB4NDgvMHgxMDQgWyAgMjAwLjY4NTQzMl0NCj4gPiBlbDBfc3ZjX2NvbW1v
bi5jb25zdHByb3AuMCsweGMwLzB4ZTANCj4gPiBbICAyMDAuNjkwMTI4XSAgZG9fZWwwX3N2Yysw
eDFjLzB4MjgNCj4gPiBbICAyMDAuNjkzNDM5XSAgZWwwX3N2YysweDMwLzB4Y2MNCj4gPiBbICAy
MDAuNjk2NDU0XSBkd19tbWMgZmY4MDgwMDAubW1jOiBVbmV4cGVjdGVkIGludGVycnVwdCBsYXRl
bmN5IFsNCj4gPiAyMDAuNjk2NDg1XSAgZWwwdF82NF9zeW5jX2hhbmRsZXIrMHgxMjAvMHgxMmMg
WyAgMjAwLjcwNjU1Ml0NCj4gPiBlbDB0XzY0X3N5bmMrMHgxOTAvMHgxOTQgWyAgMjAwLjcxMDIx
M10gQ29kZTogZjk0MDAwMDAgZjk0MTdjMDANCj4gPiBmOTQwMjAwMCBmOTQwMzQwMCAoZjk0MDA4
MDApIFsgIDIwMC43MTYyOTBdIC0tLVsgZW5kIHRyYWNlDQo+ID4gMDAwMDAwMDAwMDAwMDAwMCBd
LS0tIFsgIDIwMC43MjA5NDhdIEZpeGluZyByZWN1cnNpdmUgZmF1bHQgYnV0IHJlYm9vdA0KPiA+
IGlzIG5lZWRlZCENCj4gPg0KPiA+IEZpeGVzOiBiZTk0MjE1YmUxYWIgKCJtdGQ6IHNwaS1ub3I6
IGNvcmU6IEZpeCBhbiBpc3N1ZSBvZiByZWxlYXNpbmcNCj4gPiByZXNvdXJjZXMgZHVyaW5nIHJl
YWQvd3JpdGUiKQ0KPiA+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNi4xMisNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBLaGFpcnVsIEFudWFyIFJvbWxpIDxraGFpcnVsLmFudWFyLnJvbWxpQGFs
dGVyYS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJs
YWNoQGFsdGVyYS5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAgICAgLSBl
eGNsdWRlICFkZXYgJiYgIWRldi0+ZHJpdmVyIGNoZWNrIGluIHNwaV9ub3JfZ2V0X2RldmljZSB0
bw0KPiA+ICAgICAgIHJlc29sdmUga2VybmVsIHRlc3Qgcm9ib3Qgc21hdGNod2FybmluZ3MuDQo+
ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAgICAgLSBNb3ZlIHRoZSBudWxsIGNoZWNrIHByaW9yIHRv
IHRyeV9tb2R1bGVfZ2V0KCkuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5jIHwgNiArKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gPiBpbmRleCBhYzRiOTYwMTAxY2Mu
LmViMjFkNjYwMDM2YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4gQEAgLTMyMTAsNiAr
MzIxMCw5IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9nZXRfZGV2aWNlKHN0cnVjdCBtdGRfaW5mbw0K
PiAqbXRkKQ0KPiA+ICAJZWxzZQ0KPiA+ICAJCWRldiA9IG5vci0+ZGV2Ow0KPiA+DQo+ID4gKwlp
ZiAoIWRldi0+ZHJpdmVyLT5vd25lcikNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+
ID4gIAlpZiAoIXRyeV9tb2R1bGVfZ2V0KGRldi0+ZHJpdmVyLT5vd25lcikpDQo+ID4gIAkJcmV0
dXJuIC1FTk9ERVY7DQo+ID4NCj4gPiBAQCAtMzIyNyw3ICszMjMwLDggQEAgc3RhdGljIHZvaWQg
c3BpX25vcl9wdXRfZGV2aWNlKHN0cnVjdCBtdGRfaW5mbw0KPiAqbXRkKQ0KPiA+ICAJZWxzZQ0K
PiA+ICAJCWRldiA9IG5vci0+ZGV2Ow0KPiA+DQo+ID4gLQltb2R1bGVfcHV0KGRldi0+ZHJpdmVy
LT5vd25lcik7DQo+ID4gKwlpZiAoZGV2ICYmIGRldi0+ZHJpdmVyICYmIGRldi0+ZHJpdmVyLT5v
d25lcikNCj4gPiArCQltb2R1bGVfcHV0KGRldi0+ZHJpdmVyLT5vd25lcik7DQo+ID4gIH0NCj4g
Pg0KPiA+ICBzdGF0aWMgdm9pZCBzcGlfbm9yX3Jlc3RvcmUoc3RydWN0IHNwaV9ub3IgKm5vcikN
Cg0K

