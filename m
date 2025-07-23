Return-Path: <linux-kernel+bounces-741764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE180B0E8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6B416D962
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F271DDC0B;
	Wed, 23 Jul 2025 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="J8JkLZD9";
	dkim=pass (1024-bit key) header.d=richtekkim.onmicrosoft.com header.i=@richtekkim.onmicrosoft.com header.b="Q4Ra1k9P"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D814F125;
	Wed, 23 Jul 2025 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=220.130.44.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237996; cv=fail; b=PCIDR6e0EoW+anopP7Q6XYXbVvK2iPPwH66t8F7gXO27OEMEGWWnuPuCfZWlm7e0RzKrXTMO58BgYG55daRFNy2orD4XuR2YMXIVOH4HcT8HykbarBdAnCYQ8mDlUD2JytH8YAr6NyTiYdyFvXT4FCrBLH98DvzKDAQe9yFp8eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237996; c=relaxed/simple;
	bh=fUsJYzDzNNXBtTev6tr/bdGbsUEkmLwverTJpQDNAbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XyQ2D7JjbHkNIKCWcfMSN5Zp5AykKoCSaXv9w4xpX9YWNvIS7BoBIUHWtFm0Lk3E3kUSDl89j37TMFTWx4JvCE4tpos5UyTUeuEQ4B3mHTEOfvifJUKqy+0q3qaOK2QskjdyKGf9ENkMIbAK7c1i35MKyTABv0k3RQwkdmrjF4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=J8JkLZD9; dkim=pass (1024-bit key) header.d=richtekkim.onmicrosoft.com header.i=@richtekkim.onmicrosoft.com header.b=Q4Ra1k9P; arc=fail smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753237990;
	bh=fUsJYzDzNNXBtTev6tr/bdGbsUEkmLwverTJpQDNAbY=; l=10502;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=J8JkLZD9e5eSepsvOeihdhO2YCTfoPOyGdczOJy5H1G6R1bQ8x5mIf79F+rFSBLXh
	 wWjon5IFz1lgVaNK1sMytJflEIo17KJFcQek3y1JAhPpW52PZOgnuCawnXc8eLNAZ6
	 Mg2E9pelljlDYj7O5Doza0ou/m4F/jYTrYzecHY+Djw8f3afeRZVaU+JnTNdKNe02e
	 iBN8v26UAcgm34EK3dpT6+wZVCOfJ1tn1SSif69q1QgUjTKf2i7qxSoKJ7g98td0fk
	 6Ray+vVtMPOPBPVn7X1gWivS+7ZnB9n0GRQzNG9gVVUggeQ7buUdFWC7chEJ5UCloV
	 WentgLv0DhvQw==
Received: from 192.168.8.14
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244593:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Wed, 23 Jul 2025 10:32:58 +0800 (CST)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp17013076.outbound.protection.outlook.com [40.93.138.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by 365smtp.richtek.com (Postfix) with ESMTPS id 4FA3B20D2C68;
	Wed, 23 Jul 2025 10:32:58 +0800 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpPUehQACWLbdxGUR9gkv3bnZe+J9zGyTi7a1gqQxBZTa6M3IfeUxRWSrPmxZ8UriAJx5EHC4mUOrl7MjLQhcOh/6sn1Z2Yu673XbLLAgMQSqDLY5CdlceETxQ0/NiAMn6WRk/F6fLb8+1qLGxF9XAzuOXRb22G6FBvbidtp5oVXPyT9F1ZKUQpg35J4pq7N068MA3ne+e1zCrmJZk9nwchWaSMHFHGe5Gqu3R0ZX8IJEx9BfQeH1NFrFgE/lQGUNCevjXF2YFfJ8uEnJSMY6CXTsrNYJxtR/4XoxrJOdoDX/qzR0UwJhneqmIm5e+Af3q3Vj7jIXisp1aSzp+A1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUsJYzDzNNXBtTev6tr/bdGbsUEkmLwverTJpQDNAbY=;
 b=y0oHNu9q/q/XFtGC1Fc8aHE9r5+I1FwPNO/eughdKU1CnA5Hnv+Kay+tYih2Z3IDZLO/K5VV+nSN3zuzQLuqg85+n6ZKRo5R2mgRvBHiVyn8nFmJEdRYq6LYnfbrpTldFpKX0VPZihKHohXw1rezicov0K8vterg0TDM2MHjWnjE6+Zp/mKzDBUSI7Hbq/lh6MYOMZg41vLB47uppjHYv/OPK4wHOWparZ94Ip/T/Pcj0+8Ad3X+uwTnNDeLlyKJvKLeHvR1I8HdNEk/76K+azTal3RQ2JujpMQj28fU6XgWMd808muJouh9peox6qc2rBQcZvdrJnGF449wDjIUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=richtek.com; dmarc=pass action=none header.from=richtek.com;
 dkim=pass header.d=richtek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=richtekkim.onmicrosoft.com; s=selector1-richtekkim-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUsJYzDzNNXBtTev6tr/bdGbsUEkmLwverTJpQDNAbY=;
 b=Q4Ra1k9PnrTGXFcsiccU+RW82HpadHFSHej+MKXID0+BXd2PRaS9z+bCLGIEnb5S4FlgJNxIHQ7iuzk/3xHKyzT/7fsNSGG11G92+qyLWNZ82td9T2B+w9l+E9C0E6Fxard+vSTX15fZBZ/sEQunTlmCvveguwqPAswD+cdRRDk=
Received: from TY1PPFAEA8AB8B7.apcprd03.prod.outlook.com (2603:1096:408::a66)
 by TYZPR03MB7409.apcprd03.prod.outlook.com (2603:1096:400:41e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 02:32:56 +0000
Received: from TY1PPFAEA8AB8B7.apcprd03.prod.outlook.com
 ([fe80::9333:abb0:6706:122]) by TY1PPFAEA8AB8B7.apcprd03.prod.outlook.com
 ([fe80::9333:abb0:6706:122%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 02:32:55 +0000
From: =?utf-8?B?amVmZl9jaGFuZyjlvLXkuJbkvbMp?= <jeff_chang@richtek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] dt-bindings: regulator: Add Richtek RTR5133
 Support
Thread-Topic: [PATCH v4 1/2] dt-bindings: regulator: Add Richtek RTR5133
 Support
Thread-Index: AQHb+uOHZ5CG/6xC4EOMYoPgyBmYXbQ92ZWAgAACWrA=
Date: Wed, 23 Jul 2025 02:32:55 +0000
Message-ID:
 <TY1PPFAEA8AB8B70D7016E46DD1E5C1F9B4EC5FA@TY1PPFAEA8AB8B7.apcprd03.prod.outlook.com>
References: <20250722083543.2730796-1-jeff_chang@richtek.com>
 <f4505b19-3496-4fab-ad74-d190d847eb17@kernel.org>
In-Reply-To: <f4505b19-3496-4fab-ad74-d190d847eb17@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4bbea29-2841-4491-84bd-cd9def53ed3c_Enabled=True;MSIP_Label_d4bbea29-2841-4491-84bd-cd9def53ed3c_SiteId=d08c63e8-86ee-4e34-a1e5-44338373f4b1;MSIP_Label_d4bbea29-2841-4491-84bd-cd9def53ed3c_SetDate=2025-07-22T09:13:15.0000000Z;MSIP_Label_d4bbea29-2841-4491-84bd-cd9def53ed3c_Name=Internal
 Use -
 Share;MSIP_Label_d4bbea29-2841-4491-84bd-cd9def53ed3c_ContentBits=3;MSIP_Label_d4bbea29-2841-4491-84bd-cd9def53ed3c_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=richtek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PPFAEA8AB8B7:EE_|TYZPR03MB7409:EE_
x-ms-office365-filtering-correlation-id: 83055dbc-50b1-4361-2c47-08ddc9913b53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aktpSnZVL0N5aVpwWHZGaTF2MXlwbXIwSU4rbFc5THR6MkpBSHptaUpzdlhU?=
 =?utf-8?B?UVhaTWVGMHhQVWZ0WWE1aFU1WVgxbWRpckNvRTBqeVJqSFNMV05zNzl6T1FG?=
 =?utf-8?B?T1VhVk5FTWx1YktYYlR2N2RqR1FJMERLUXRTUXNjOFJHNWdkMHdQM3JwZWlE?=
 =?utf-8?B?ZU5ReW9ycHRSVDRyMnRkVWI5SzgwMnR0cUZRWkNhWVRBZWptM3dFZkRiaE9W?=
 =?utf-8?B?L0hMT3k1bFo3bUpYM3E1ZW1YKzhUd0FraCtzS2QyVGtaSmNTRm9zRWZkWEN0?=
 =?utf-8?B?UW1sNzlCK3c0ZkZHU3FhaWVta3k4MmR1WWtVM2NNNHovZkJUcy9OM0h1U1l6?=
 =?utf-8?B?UCtiMEZ3cUIwOEowbWV1WU9CczRqeTRFTXRxSC9kQWlXMExHakNGbnJ4RXRG?=
 =?utf-8?B?TC9ZM0FRS3FWV3JOeGZJelJPR1k1RmZiY3FsY2pxaFFhQU5STFAxdUtGQXl0?=
 =?utf-8?B?c2dzTEZqWGNIbmlCNmlyRTkzTUNwMjRCZEpQT2tHV2JrNkFLTmNmaWdmRThN?=
 =?utf-8?B?ZExkWjQ5WHNoM0JCRUgvR3NDMHJCVEYxSjB6Skcxd2owTzRKbVdjWmx3UzFS?=
 =?utf-8?B?cUpZNDh5a1hxS09qS3BDdTduL0RpUkQxcE1hK0g3RXkraUlzb3pleGgrSW5u?=
 =?utf-8?B?WWh5M0VTWnNRS0xsd2FsTURlYkxQYkZ6bWFxTWpyUVdSL3g4WlJJQkdUbmRz?=
 =?utf-8?B?WnQ5VVc4bnowdzM2aGc2aFFOVUtmZGoxYmFVTGRMb25WazVmc3Jib3RSbmlO?=
 =?utf-8?B?VmZQb0tNMHFocmNRNE8xYmtweGplek9WSG9oYUt5TkJ0TXhuTjBEYU8rVEdF?=
 =?utf-8?B?NFJtQTZPVmxvWmJvbXY3VlB0OTlWMGZiM202SjNLaHp6ZThGM2pvK0pIWDVz?=
 =?utf-8?B?aDZZdE9iOCtobkFuSzFWbDVJRnlSdGcrOUZJUk92UlFScGxENzF1QTdxcEdM?=
 =?utf-8?B?b1ZIVEYwc3BmTktzaXBZWkNwQ2E4VEhFUmY4QnpwOU50UzhHK0M4YXVlUE1J?=
 =?utf-8?B?NFhCaGFqNVQ3N3ljaWJNZWk0YkpzM0Npa0FkcnZSZXByeEVhcVp4YjlickFP?=
 =?utf-8?B?L2lKZG42cEp1N1pKSEJLaTI1WVNYTHppK0RrbG41aFZUOWx0TzBEK2hQeE1F?=
 =?utf-8?B?R255RmltUUhVODNUUGdhRFNaM0dOTVM4UlBJWWYySWgya2xkZkJLa2l4Um5Q?=
 =?utf-8?B?YWhaWjZadkF4VlZ0TWFNV2RrRDlQRkNmZGVQMXVkbm8waVJzVXgya2NaaGpT?=
 =?utf-8?B?OGR6amRaeUZZTjFHTHEvWVVoWVlYRFlMRlY3TmRQdElvN3B2WUswNGw4bGZW?=
 =?utf-8?B?UzVXd2JwQ2lrbE1VYXRRZVZ3bjNsUnRqVDVSLzhJNDM1d3dETzVobisvZUR6?=
 =?utf-8?B?V2t1U1NaTFpPUkpHanRFdVZUNkI2RG02U256Qnc4KzM3RVFsOXhSNkhzZ0VL?=
 =?utf-8?B?L0lNZGo5NGdhV1FPSmt6QnVnc1ZUT1FiZjBUZ1k2NEo5YjZIWDI1djZGSUJL?=
 =?utf-8?B?YVlDQVBmQUhZNWxrQ0lHaEcvdlEwWllZcEtvcy9ISGtTckM2blh0U1owTm1U?=
 =?utf-8?B?M1QvVUlCS08zUmRrK01DMnY4dWF4bzBWMkJ3SGppNENJcG1kY3FNMWhTVlJ1?=
 =?utf-8?B?TnpENHR0YnJ0a0ZSMkt2Ti95UG9Oc2hWQVgrZUl4eE1PdnFHdHJtRjk2NVFq?=
 =?utf-8?B?ZHM1cUd4ZFVtcy91VU9INjcrVlFCU3M0KzY4TnNxVGlKVmVXTDgwVmE0cFhP?=
 =?utf-8?B?eGloTWE3RHhxaFRkT1JEVEgrSVQwWkxOOWI3ZFZvV1c2MHUwWCs2aEZLRzFI?=
 =?utf-8?B?WVJaU0RjeXhRK29td3kwY0U3TVllRkpmRjVZUThhWEt2RkFKUGFpMkUxRUFp?=
 =?utf-8?B?SlJIK25YL0wwR3ZhbWdabFhTODhBekxOVFRzdDZLamROUVkzTFJWblljTkNk?=
 =?utf-8?Q?6QRT3tUeEyg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PPFAEA8AB8B7.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elh2NVBZbFE4NzJxbElic2ZNSW9yUmF5VDkrY3RuQnBrcVlWOWViYkhUVEtq?=
 =?utf-8?B?REQ1bnNqeWdEWXFxdzV2cnN2VlBLNDBDWDh6S3RtdTZ0OXgrcGxsdGxsV2pR?=
 =?utf-8?B?elFBVW1VZ2pJYlRreTd5L1oraFRGMmVJL1R6ampRci8wV2VCaFZYVjBhcENw?=
 =?utf-8?B?d3hPSnpBZkxUYUhPVzlFUkJDK01WWlpzSkV5WTV3Q2o2cDZjSUlpMVhKZWxu?=
 =?utf-8?B?UTdWWmtxWi9Cd3VNMU5KOFkxYXRjcGpGUjFrMjFpZ3VSU2tLVFVUY3ozQW9X?=
 =?utf-8?B?TGFDS2V0bHZRRFlTMms4RURrVlpyVEplMkRFQlU1MmpIMDJLMjJoQmxEU1Bl?=
 =?utf-8?B?a2xCNjIyWFRRMkJIT3FjRDZLamVDY09KWGJ3LzU5N3JXYlVRMU9wNDJBL2dO?=
 =?utf-8?B?UlUrbjFPelI3ajZma1RFNzU1RnlxRmpqbU03aCt1eUJlMlk1eGlFQ3diR1NY?=
 =?utf-8?B?NGQxVDZ1UnZ2THR1aS9VVXE1MzY3M2I5Y3N0UjhTdXRHdmNYcUFYRUNrbnVL?=
 =?utf-8?B?UjBNTVFPZzBpL1R2L1F2dmdNdGZZWGVFbkVNeCsyZkFybTVwSHdEditWMHRp?=
 =?utf-8?B?S1FTWnE4NHZlMUM5bTE3czZjaGdObEQ5djNFNjJGejlSdFZadW5scUF4MmRm?=
 =?utf-8?B?N0VnNUVKMDVhNnRNc0NQRlZBUUZaVDgzZmVPMEZjNmFXcmhQTVlyT2RhL04r?=
 =?utf-8?B?N0hCMmVrK2dIS3VzQUV1dXcrUmNiaW1sTjAxWFNXVENzWElCYUgvZk5jc3lk?=
 =?utf-8?B?WVAxVzR0WXBOMy9pZ2t3VlRqMGg1d2xpdk8ra3Y2bVc5NDZ0Vk0wV0hNblZi?=
 =?utf-8?B?cTJWRUpXRHJyOFkwb0NBQlRKZjFaN2I5eTZKUlltVHkvRktad1Btbnh4YlIz?=
 =?utf-8?B?TWc1bFB5T0RqbmNWbEswaEJvNzN6UXo4bHlwcUJmQWpZbjNQMisxSE1QN1I3?=
 =?utf-8?B?aUtrM1BJWkltcjREZ1FRdXJqazl0WC9BTS9IMzBxNW1qTnFYZEFkL1JWQ2g3?=
 =?utf-8?B?SStqbDY3SStqUkxmYnBNejNLbmtxODRzMTdVOVBZcHEwZm9wa3lQQlJTUmZ5?=
 =?utf-8?B?UVMzaWdnSno2SlNVcWJ5L3JEMUJKTlBxTmdnVWYzVjhDbGtPZ0ZiaFJRNmZ6?=
 =?utf-8?B?aE8yZDdjUEQzV2dGRnVFVlhWK1NydncyejlTQXJ0N1JsenZTYmx1dUxwd3ZO?=
 =?utf-8?B?RTFqU0cvZittWTBwRkExb3lTK1dQVWdVYlFaT0p3OVFqWTk0SVhCc3pMSGUy?=
 =?utf-8?B?Vll6eEM4RnUzVkZQY1NhdmtxVzl6OXFrRks3QWFKenhBUDBLY3V6elM0Zi9Q?=
 =?utf-8?B?VWRxbCt4dTkyRHVISXJuVWlOOGUrREF2R0VoN1BmVVZHQ1VpQU9BNVRNTXE2?=
 =?utf-8?B?b1FWYm52YkZHOUlzQ1JzWEZyNEtFa0duTnRxSkpBRmEyN2pzVzNpSUFkOUs4?=
 =?utf-8?B?SEJ4V2tVTzFkeGhFSXB4b0lsSmhHREtzUjNPMzJLRE9RUzRWL2NJZGNjdk9G?=
 =?utf-8?B?UitVSGZpeFNYQ2daL3NVa0psSGRmeDVsUFJ1OG9OUHh5czBsOFVHNlZnT01y?=
 =?utf-8?B?N0doSjF2dXdKSHJmSmVYVjhIZ05RSTNIWjdLNDIybGZlQVkvSU4vMk1DWTJh?=
 =?utf-8?B?MHdJK0ROYjdCdWppNzhmTy9ZQjRBSDRKSCsxa1l4bHdlRXJxdE0xY1l2VlRZ?=
 =?utf-8?B?T0x6enNEbzArSEZ6N090MHNjWHVLT09uYkUvSi94SFdCbkg3ZXRybDFJNTR3?=
 =?utf-8?B?bXRERmFrK3dLMzV2eUJpUzJTUjgwdG9IenBRYi9jQjdtZnc2VnlaNVRRbU9V?=
 =?utf-8?B?eVZsTmpmSE1RN3cwS0ozcXZvcUZDbGhxUHJRczNncE9Ra1dPVDF5eXN4WDVr?=
 =?utf-8?B?a1NUZGpyc1MxT3VCVHB3Z3dSdGRNalluREZpWWNEeWNjeXlnS2RjRjMyWEgz?=
 =?utf-8?B?VGJMVFg3UlpQbDlLUEF3UGtFNFV5TCs1eWlzQVJmQ2owMlUrbVlvY3VKa3lJ?=
 =?utf-8?B?TmYvU0xGd2hSM2RjRi9YYUh6TFBJQVVaTGEwQkJ4SlhUSURKcjB0bWRmRUZJ?=
 =?utf-8?B?ZFRHWGxITE5DUCs3ci9VSXlMb1hyMkZGcnc2cFJSbHJGOFdkVVJwSmttWFpi?=
 =?utf-8?Q?QOCYcpJTji8dS/YXRxGYTlTUk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: richtek.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFAEA8AB8B7.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83055dbc-50b1-4361-2c47-08ddc9913b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 02:32:55.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d08c63e8-86ee-4e34-a1e5-44338373f4b1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+z2zEFiUFqNvRLdvMv2qAlaB70voJGPtKdPHLeO5BBIf3f4N8uPyTza5kyz6pfQKHiHQ3LQpXWE7VqOiiYAmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7409

Q29uZmlkZW50aWFsIEMgLSBSaWNodGVrDQoNCkRlYXIgS3J6eXN6dG9mIEtvemxvd3NraToNCg0K
ICAgICAgICBUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQoNCiAgICAgICAgUGxlYXNlIHJldmlldyBt
eSBleHBsYW5hdGlvbiBmb3IgeW91ciBxdWVzdGlvbnMuDQoNCiAgICAgICAgSWYgSSBoYXZlIG1p
c3VuZGVyc3Rvb2Qgb3IgaWYgdGhlcmUgYXJlIGFueSBwYXJ0cyB0aGF0IG5lZWQgY29ycmVjdGlv
biwgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQpUaGFua3MNCkplZmYNCg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3Jn
Pg0KU2VudDogVHVlc2RheSwgSnVseSAyMiwgMjAyNSA1OjA1IFBNDQpUbzogamVmZl9jaGFuZyjl
vLXkuJbkvbMpIDxqZWZmX2NoYW5nQHJpY2h0ZWsuY29tPjsgbGdpcmR3b29kQGdtYWlsLmNvbTsg
YnJvb25pZUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsg
Y29ub3IrZHRAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS8yXSBkdC1iaW5k
aW5nczogcmVndWxhdG9yOiBBZGQgUmljaHRlayBSVFI1MTMzIFN1cHBvcnQNCg0KT24gMjIvMDcv
MjAyNSAxMDozNCwgamVmZl9jaGFuZ0ByaWNodGVrLmNvbSB3cm90ZToNCj4gRnJvbTogSmVmZiBD
aGFuZyA8amVmZl9jaGFuZ0ByaWNodGVrLmNvbT4NCj4NCj4gQWRkIGJpbmRpbmdzIGZvciBSaWNo
dGVrIFJUNTEzMyBJQyBDb250cm9sbGVkIFBNSUMNCg0KU3ViamVjdCAtIFJUUiBvciBSVD8gR29v
Z2xlIHRlbGxzIG1lIG5vdGhpbmcgYWJvdXQgUlRSLg0KDQotLT4gSSB3aWxsIGZpeCBpdCB0byBS
VDUxMzMgaW4gbmV4dCBwYXRjaC4NCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIENoYW5nIDxq
ZWZmX2NoYW5nQHJpY2h0ZWsuY29tPg0KPiAtLS0NCj4NCj4gUEFUQ0ggdjQNCj4gMS4gQWRkIGNv
bW1pdCBtZXNzYWdlIGFuZCBhbHNvIC9zY3JpcHQvY2hlY2twYXRjaCAtLXN0cmljdCB0byBmaXgg
d2FybmluZy4NCj4gMi4gVXNpbmcgc3ViamVjdCBwcmVmaXhlcyBtYXRjaGluZyBkdC1iaW5kaW5n
IHN1YnN5c3RlbS4NCj4gMy4gUmUtb3JkZXIgcGF0Y2hlcy4gRFQgcGF0Y2ggYmVmb3JlIGRyaXZl
ciBwYXRjaC4NCj4gNC4gRml4IGRlc2NyaXB0aW9uIG9mIHlhbWwuDQo+IDUuIEFkZCBtb3JlIGRl
c2NyaXB0aW9uIGZvciBiYXNlIHJlZ3VsYXRvci4NCj4gNi4gRHJvcCByZWd1bGF0b3ItY29tcGF0
aWJsZSBwcm9lcHJ0eS4NCj4gNy4gQWRkIHByZWZpeCBmb3IgdmVuZG9yIHByb3BlcnR5IHJpY2h0
ZWssb2Mtc2h1dGRvd24tYWxsIGFuZCByaWNodGVrLHBnYi1zaHV0ZG93bi1hbGwuDQo+IDguIEFk
ZCBtb3JlIGRlc2NyaXB0aW9uIGZvciBzaHV0ZG93bi1hbGwgcHJvcGVydHkuDQo+IDkuIEludGVy
cnVwdHMtZXh0ZW5kZWQgLT4gaW50ZXJydXB0cy4NCj4gMTAuIHBpby0+Z3BpbyBmb3IgcHJvcGVy
IGRlZmluZXMuDQo+IDExLiBEcm9wIHVudXNlZCBsYWJlbHMuIEtlZXAgcnQ1MTMzX2xkbzEgbGFi
ZWwgZm9yIGxkbzcgYW5kIGxkbzguDQo+DQo+ICAuLi4vYmluZGluZ3MvcmVndWxhdG9yL3JpY2h0
ZWsscnQ1MTMzLnlhbWwgICAgfCAxNzUgKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTc1IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3JpY2h0ZWsscnQ1MTMzLnlhbWwN
Cj4NCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
ZWd1bGF0b3IvcmljaHRlayxydDUxMzMueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yZWd1bGF0b3IvcmljaHRlayxydDUxMzMueWFtbA0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjBkYTcyNTU5NmE4Nw0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3Iv
cmljaHRlayxydDUxMzMueWFtbA0KPiBAQCAtMCwwICsxLDE3NSBAQA0KPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSAlWUFNTCAxLjINCj4g
Ky0tLQ0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9yZWd1bGF0b3Ivcmlj
aHRlayxydDUxMzMueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRsZTogUmljaHRlayBSVDUxMzMgUE1JQyBS
ZWd1bGF0b3INCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gU2hpaENoaWEgQ2hhbmcgPGpl
ZmZfY2hhbmdAcmljaHRlay5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOg0KPiArICBUaGUgUlQ1
MTMzIGlzIGFuIGludGVncmF0ZWQgUG93ZXIgTWFuYWdlbWVudCBJQyBmb3IgcG9ydGFibGUNCj4g
K2RldmljZXMsIGZlYXR1cmluZw0KPiArICA4IExET3MgYW5kIDMgR1BPcy4gSXQgYWxsb3dzIHBy
b2dyYW1tYWJsZSBvdXRwdXQgdm9sdGFnZXMsDQo+ICtzb2Z0LXN0YXJ0IHRpbWVzLA0KPiArICBh
bmQgcHJvdGVjdGlvbnMgdmlhIEkyQy4gR1BPIG9wZXJhdGlvbiBkZXBlbmRzIG9uIExETzEgdm9s
dGFnZS4NCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBlbnVt
Og0KPiArICAgICAgLSByaWNodGVrLHJ0NTEzMw0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJ
dGVtczogMQ0KPiArDQo+ICsgIGVuYWJsZS1ncGlvczoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiAr
DQo+ICsgIHdha2V1cC1zb3VyY2U6IHRydWUNCj4gKw0KPiArICBpbnRlcnJ1cHRzOg0KPiArICAg
IG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgZ3Bpby1jb250cm9sbGVyOiB0cnVlDQo+ICsNCj4gKyAg
IiNncGlvLWNlbGxzIjoNCj4gKyAgICBjb25zdDogMg0KPiArDQo+ICsgIHJlZ3VsYXRvcnM6DQo+
ICsgICAgdHlwZTogb2JqZWN0DQo+ICsgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+
ICsNCj4gKyAgICBwcm9wZXJ0aWVzOg0KPiArICAgICAgYmFzZToNCj4gKyAgICAgICAgdHlwZTog
b2JqZWN0DQo+ICsgICAgICAgICRyZWY6IHJlZ3VsYXRvci55YW1sIw0KPiArICAgICAgICB1bmV2
YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ICsgICAgICAgIGRlc2NyaXB0aW9uOg0KPiArICAg
ICAgICAgIFByb3BlcnRpZXMgZm9yIGJhc2UgcmVndWxhdG9yIHdoaWNoIGNvbnRyb2wgZm9yY2Ut
b2ZmIGJhc2UgY2lyY3VpdC4NCj4gKyAgICAgICAgICBCYXNlIGNpcmN1aXQgaXMgdGhlIHBvd2Vy
IHNvdXJjZSBmb3IgTERPMX5MRE82LiBEaXNhYmxpbmcgaXQgd2lsbA0KPiArICAgICAgICAgIHJl
ZHVjZSBJUSBmb3IgQ2hpcC4NCg0KSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgdGhpcyByZWd1bGF0
b3IgaXMgZm9yLiBZb3VyIGV4YW1wbGUgaXMgYWxzbyBpbmNvbXBsZXRlIC0gbWlzc2luZyBtaW4v
bWF4IGNvbnN0cmFpbnRzIGxpa2Ugdm9sdGFnZS4NCg0KRXhwbGFpbiwgd2hhdCBpcyB0aGlzIG91
dHB1dCBwaW4/IEkgYWxyZWFkeSBhc2tlZCBmb3IgZXhwbGFuYXRpb25zLiBJIGhhdmUgZGlhZ3Jh
bSBpbiBmcm9udCBvZiBtZSwgc28gZXhwbGFpbiBwcmVjaXNlbHkgaW5zdGVhZCBvZiBzZW5kaW5n
IFRIRSBTQU1FIGFnYWluIC0gd2hpY2ggcGluIGlzIGl0Pw0KDQpBbHNvLCB3aGF0IGlzIElRPyBF
eGNlcHQgSW50ZWxsaWdlbmNlIFF1b3RpZW50Pw0KDQotLT4gVGhhbmtzIHRvIE1hcmsncyBTdWdn
ZXN0aW9uLiBJdCdzIHRoZSB0b3AtbGV2ZWwgc3VwcGx5IGZvciBMRE8xIHRvIExETzYuIEl0IGlz
IG5vdCBleHRlcm5hbGx5IHZpc2libGUgYW5kIGZ1bmN0aW9ucyBtZXJlbHkgYXMgYW4gb24vb2Zm
IHN3aXRjaCByYXRoZXIgdGhhbiByZWd1bGF0aW5nIHZvbHRhZ2VzLg0KICAgSSB3aWxsIHVwZGF0
ZSB0aGUgZGVzY3JpcHRpb24gYXMgZm9sbG93cy4NCg0KICAgUHJvcGVydGllcyBmb3IgdGhlIGJh
c2UgcmVndWxhdG9yLCB3aGljaCBpcyB0aGUgdG9wLWxldmVsIHN1cHBseSBmb3IgTERPMSB0byBM
RE82LiBJdCBmdW5jdGlvbnMgbWVyZWx5IGFzIGFuIG9uL29mZiBzd2l0Y2ggcmF0aGVyIHRoYW4g
cmVndWxhdGluZyB2b2x0YWdlcy4NCiAgIElmIG5vbmUgb2YgTERPMSB0byBMRE82IGFyZSBpbiB1
c2UsIHN3aXRjaGluZyBvZmYgdGhlIGJhc2Ugd2lsbCByZWR1Y2UgdGhlIHF1aWVzY2VudCBjdXJy
ZW50Lg0KDQo+ICsNCj4gKyAgICAgICAgcHJvcGVydGllczoNCj4gKyAgICAgICAgICByaWNodGVr
LG9jLXNodXRkb3duLWFsbDoNCj4gKyAgICAgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gKyAgICAg
ICAgICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgICAgICAgICBBbnlvbmUgb2YgTERPIGlzIGlu
IE9DIHN0YXRlLCBzaHV0IGRvd24gYWxsIGNoYW5uZWxzIHRvIHByb3RlY3QgQ0hJUC4NCj4gKyAg
ICAgICAgICAgICAgV2l0aG91dCB0aGlzIHByb3BlcnR5LCBvbmx5IHNodXQgZG93biB0aGUgT0Mg
TERPIGNoYW5uZWwuDQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzLiBJIGFsc28gZG8gbm90IHVu
ZGVyc3RhbmQgd2h5IHRoaXMgaXMgcHJvcGVydHkgb2YgImJhc2UiIG5vdCB0aGUgY2hpcCBpdHNl
bGYuLi4NCg0KU28gZG9uJ3Qgc2VuZCBuZXh0IHZlcnNpb24gd2l0aCB0aGUgc2FtZS4NCg0KLS0+
IEl0IGlzIGEgcHJvdGVjdGlvbiBmb3IgTERPIE92ZXIgQ3VycmVudCAuIFRoZSBEZXNjcmlwdGlv
biBpbiBkYXRhc2hlZXQgbGlrZSBiZWxvdy4NCg0KQW55b25lIG9mIExETyBPQyBzdGF0ZSwgc2h1
dCBkb3duIGFsbCBMRE8gY2hhbm5lbHMNCjAgOiBMRE8gT0Mgb25seSBzaHV0IGRvd24gaXRzZWxm
IChkZWZhdWx0KQ0KMSA6IExETyBPQyBzaHV0IGRvd24gYWxsIGNoYW5uZWxzDQpXZSBzZXQgaXQg
YXMgYSBwcm9wZXJ0eSBvZiAiYmFzZSIgZm9yIHVzaW5nIHJlZ3VsYXRvcl9kZXNjIC0+IG9mX3Bh
cnNlX2NiLg0KU2hvdWxkIEkgbW92ZSB0aGVtIHRvIGNoaXAgcHJvcGVydHk/IFdlIGJpbmQgaXQg
dG8gYmFzZSByZWd1bGF0b3IgZm9yIGVhc2lseSBwcm9ncmFtbWluZy4NCg0KPiArDQo+ICsgICAg
ICAgICAgcmljaHRlayxwZ2Itc2h1dGRvd24tYWxsOg0KPiArICAgICAgICAgICAgdHlwZTogYm9v
bGVhbg0KPiArICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAgICAgIEFueW9u
ZSBvZiBMRE8gaXMgaW4gUEdCIHN0YXRlLCBzaHV0IGRvd24gYWxsIGNoYW5uZWxzIHRvIHByb3Rl
Y3QgQ0hJUC4NCg0KQ0hJUCBpcyBhbiBhY3JvbnltPyBPciBjaGlwPw0KLS0+IGNoaXAhIEkgd2ls
bCB1c2UgImNoaXAiIGluIG5leHQgcGF0Y2guDQoNCj4gKyAgICAgICAgICAgICAgV2l0aG91dCB0
aGlzIHByb3BlcnR5LCBvbmx5IHNodXQgZG93biB0aGUgUEdCIExETyBjaGFubmVsLg0KPiArDQo+
ICsgICAgICAgIHJlcXVpcmVkOg0KPiArICAgICAgICAgIC0gcmVndWxhdG9yLW5hbWUNCj4gKw0K
PiArICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiArICAgICAgIl5sZG8oWzEtNl0pJCI6DQo+ICsg
ICAgICAgIHR5cGU6IG9iamVjdA0KPiArICAgICAgICAkcmVmOiByZWd1bGF0b3IueWFtbCMNCj4g
KyAgICAgICAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArICAgICAgICBkZXNjcmlw
dGlvbjoNCj4gKyAgICAgICAgICBQcm9wZXJ0aWVzIGZvciBzaW5nbGUgTERPIHJlZ3VsYXRvcg0K
PiArDQo+ICsgICAgICAgIHJlcXVpcmVkOg0KPiArICAgICAgICAgIC0gcmVndWxhdG9yLW5hbWUN
Cj4gKw0KPiArICAgICAgIl5sZG8oWzctOF0pJCI6DQo+ICsgICAgICAgIHR5cGU6IG9iamVjdA0K
PiArICAgICAgICAkcmVmOiByZWd1bGF0b3IueWFtbCMNCj4gKyAgICAgICAgdW5ldmFsdWF0ZWRQ
cm9wZXJ0aWVzOiBmYWxzZQ0KPiArICAgICAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgICAgICBQ
cm9wZXJ0aWVzIGZvciBzaW5nbGUgTERPIHJlZ3VsYXRvcg0KPiArDQo+ICsgICAgICAgIHByb3Bl
cnRpZXM6DQo+ICsgICAgICAgICAgcnQ1MTMzLWxkbzEtc3VwcGx5Og0KDQpzdXBwbGllcyBkbyBu
b3QgaGF2ZSB2ZW5kb3IgcHJlZml4ZXMuDQoNCj4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiB8
DQo+ICsgICAgICAgICAgICAgIE9ubHkgZm9yIGxkbzcgbGRvOCwgcHZpbjcgYW5kIHB2aW44IHJl
ZmVyZW5jZSBkZXNpZ24gYXJlIFJUNTEzMyBsZG8xLg0KPiArICAgICAgICAgICAgICBJZiBub3Qg
Y29ubmVjdCB0byBsZG8xIHZvdXQsIHRoaXMgcHJvcGVydHkgZm9yIHB2aW43IGFuZCBwdmluOCBp
cyBuZWNlc3NhcnkuDQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgTERPMSBzdXBwbHkgaXMgaGVy
ZS4NCg0KQWdhaW4sIHdoaWNoIHBpbiBpcyBpdD8NCg0KDQotLT4gUGxlYXNlIHJlZmVyIHRvIFBW
SU43IGFuZCBQVklOOCBpbiB0aGUgZGlhZ3JhbS4gVGhleSBhcmUgdGhlIHBvd2VyIHN1cHBsaWVz
IGZvciBMRE83IGFuZCBMRE84LCByZXNwZWN0aXZlbHkuIFRoZSByZWZlcmVuY2UgZm9yIFBWSU43
IGFuZCBQVklOOCBpcyB0aGUgVk9VVCBvZiBMRE8xIChWT1VUMSkuDQogICBJbiB0aGUgZHJpdmVy
LCB3ZSBzZXQgInJ0NTEzMy1sZG8xIiBhcyB0aGUgc3VwcGx5X25hbWUgaW4gdGhlIHJlZ3VsYXRv
cl9kZXNjIGZvciBMRE83IGFuZCBMRE84LiBVc2VycyBjYW4gb3ZlcndyaXRlIHRoZSBydDUxMzMt
bGRvMS1zdXBwbHkgcHJvcGVydHkgYWNjb3JkaW5nIHRvIHRoZWlyIG93biBsYXlvdXQuDQogICBJ
IHdpbGwganVzdCB1c2UgdmluLXN1cHBseSBhbmQgSSB3aWxsIHJlbW92ZSB2ZW5kb3IgcHJlZml4
ZXMgb2Ygc3VwcGxpZXMgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+ICsNCj4gKyAgICAgICAgcmVxdWly
ZWQ6DQo+ICsgICAgICAgICAgLSByZWd1bGF0b3ItbmFtZQ0KPiArDQo+ICtyZXF1aXJlZDoNCj4g
KyAgLSBjb21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gaW50ZXJydXB0cw0KPiArICAtIHdh
a2V1cC1zb3VyY2UNCj4gKw0KPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArDQo+
ICtleGFtcGxlczoNCj4gKyAgLSB8DQo+ICsgICAgaTJjIHsNCj4gKyAgICAgICNhZGRyZXNzLWNl
bGxzID0gPDE+Ow0KPiArICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ICsNCj4gKyAgICAgIHJ0
NTEzM0AxOCB7DQoNCk5vdGhpbmcgaW1wcm92ZWQuDQoNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9
ICJyaWNodGVrLHJ0NTEzMyI7DQo+ICsgICAgICAgIHJlZyA9IDwweDE4PjsNCj4gKyAgICAgICAg
d2FrZXVwLXNvdXJjZTsNCj4gKyAgICAgICAgaW50ZXJydXB0cy1leHRlbmRlZCA9IDwmZ3BpbyAx
ODcgMHgwPjsNCg0KTm90aGluZyBpbXByb3ZlZA0KDQotLT4gSSB3aWxsIHVwZGF0ZSB0aGVtIGxp
a2UgYmVsb3cuDQpwbWljQDE4IHsNCmludGVycnVwdHMtZXh0ZW5kZWQgPSA8JmdwaW8gMTg3IElS
UV9UWVBFX0xFVkVMX0xPVz47DQoNCg0KSW1wbGVtZW50IHByZXZpb3VzIGNvbW1lbnRzIGFuZCBy
ZXNwb25kIHRvIGVhY2ggb2YgdGhlbSB0byBjb25maXJtIHlvdSB1bmRlcnN0b29kIHRoZW0uDQoN
Cj4NCg0KDQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg==

