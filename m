Return-Path: <linux-kernel+bounces-889911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F976C3ED01
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 608264E8F53
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E363093AA;
	Fri,  7 Nov 2025 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="mT81Ln1q"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311C171C9;
	Fri,  7 Nov 2025 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501746; cv=fail; b=ihKyJ5h6IeG+b0WL91PwDutqm/ScUfe19bUvHgF0RhaTP31OIjhGoBss2HY9vwGoaacwM8ZOiCPBtu+aAlm/xu9BZp1rtOA7zZDbYDcaniej4QTK2qmpFexzSDjKhZ1imCSvlhk8O6qir8gkQS6Q+xQzDUrAfHLYu8mruBlXDUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501746; c=relaxed/simple;
	bh=s9yftnDcT1O8mcri5DA9l2tmM5q7mK4mtta4jEiGx2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=grmQPUfZ3NkK4RSFU8mk6tsYEsOCwkSI2eWbrWRZR+YXXjvxr/6g0+6z4XIHbuUebirfJIxnao7y7PeIKauamZKYgDIY4mkYKtjWDfaQKooDZoWuPJpg6kcvrVPQlj6nZYR1MIU/ZCFPa08ieavAlaLr8zsi8AL+zRoJmwYCMTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=mT81Ln1q; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJrcj1MZ6T+CvJf0HVC/cwONBuV++jYKMTfsa+ylxB/btfYRqVhZJkVROjf1j42UUL4q9lMnj+aU0+4wr6R2kQ6WGkQoGqNDdylVqsyJanBhajNNfDqNFcjJvFS9ZG6LuX8IuID+liGD6uJqTKQSEleOVbqA/6Pab5l/abXltUPryUCe6JKU75hzgzlHp323AwuZlKv9scqBYVcq2y22lgJ32ek51W0sZpqwfeXv7X9I36nwQJVJeH+86dro/TC8MObqPXAmwj8tueXmQ9sHUIqwO7fhR26x7/bS2mIpXQaDYTK0tWA0RcHBUTFzFG3TWJ29P1t0Opwm5M4uJX18KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9yftnDcT1O8mcri5DA9l2tmM5q7mK4mtta4jEiGx2s=;
 b=UQ4hi1lSXXjYJ0QxaX/E/41kHSEJStpNdWEonReSSQC3v5m8b17yID60BvGCte3nvBlcrc0t8Rwiw7B14xSqejCFabxwOAWunL8hF6s9Y1jd6ipvrkjK2+a88uTb1yNaq9Dpo0tS8BiJ5mPbMmfg8p0LiZdG+jTB9Fk2wxpEtTUdjGy/y4jWzYGZPXPLryu4Fk1dT+uiED/rUusBiZp3ygUTy2Xp8KTZr/RYd3rTvUTuGXhBo+ebaVDB2FKwFWTnNv7JuJNTrvYxiQNCd2m3y0X8yf+SKG0rY++Jp2lvGE5RR0EtK5gdZvsGTzBybqSkNFcRqIt/pcKQKVaehLMKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9yftnDcT1O8mcri5DA9l2tmM5q7mK4mtta4jEiGx2s=;
 b=mT81Ln1qscadsfFU11S89rbMZYMwgKRcuIVIkcM0mq+Qj0WtsVeGeMTP2uW8+3+Ed60/cMAm8UtmWzhCiT0RUZvW/N7+KYnOF1dAQdSQuydoupzVs+mGpF5584YyeFp/Xbu2uXtSllKCVnlIRM+78wXP91GZpX/7gc/icrDhAYxM8IG19vT1GrCNU9jxdolzM7Zqa5onWT5sR1s0Q67WNy4HRrNvdUv/eXYcC0kEJAQZ3ipSIqXPfJyHjVlBp7a7ljAolulhbEZOaB3adCvkTpRrjTO8y1mRz0auly7L1k5I3oOCjbi7dykh3sOqL91iZ4+dxeil9H7bpsLEpyLucQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DM6PR03MB5276.namprd03.prod.outlook.com (2603:10b6:5:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 07:49:01 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 07:49:00 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Thread-Topic: [PATCH v6 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Thread-Index: AQHcT3YOxUAUbPtPukipz9DT8PAT77Tm01WAgAADsoA=
Date: Fri, 7 Nov 2025 07:49:00 +0000
Message-ID: <14b69e02-106f-4f9c-a43e-16218b07f3a8@altera.com>
References: <cover.1762387665.git.khairul.anuar.romli@altera.com>
 <dc40029c970d33b433e763202e6622a0a2f12d72.1762387665.git.khairul.anuar.romli@altera.com>
 <20251107-enthusiastic-mouflon-of-experience-5aea2f@kuoka>
In-Reply-To: <20251107-enthusiastic-mouflon-of-experience-5aea2f@kuoka>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|DM6PR03MB5276:EE_
x-ms-office365-filtering-correlation-id: 4875bf8a-abd9-40b1-5bcc-08de1dd21d81
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGxhdzNBK1RsRm1ObE8wUmluV2M0QXZZaUZUMCtSMnZwVkZpRlQ0eDVhTEs2?=
 =?utf-8?B?TkJqcWhQSFdKMFdpSUYycS8rVFpqN3RRKzZ5LzN1eERZd3RqUTUrYklwblNK?=
 =?utf-8?B?cjljbDVhWnlabkN2ZDBBV1dWM1JJYXpDR2tIRzJsdTUyR2tsY2xucmo1VUM5?=
 =?utf-8?B?bVV0cm9oZm9BaVBlZVRYeUxTQXNyVVQvcFhpRWZMaGFlRTVnYXIvQVBBMDJO?=
 =?utf-8?B?YjliSEFQYmR1QklxUXN6ZS9vSnIyOHN0S0ovVGt0UUc1bExHbnc0SHV2Mkd4?=
 =?utf-8?B?eTkySnFjNGp3NUhZWmZpdmpNMVMvUHJjcjNVUW5FZS9kSG1GNUtOSzBGOTRG?=
 =?utf-8?B?aEk0MlZMK0xtYkhoUVZ6YXJ1S2JUR04rajVjOC83OGYvTmJ0RGVvUzJsVUt6?=
 =?utf-8?B?dDZxMVZmYXFSNHJIRjhPckJybHpTd2IxYmRFTFR4bkQrRnQ2RW1ndFZ4WVIr?=
 =?utf-8?B?V0gzMEdXZGZJTEdMTVE2Skk1ZHEzcFlHM1VzdllCTTJqRFNyclp3UzJuRUtN?=
 =?utf-8?B?OGc5TmhqSjA4Wit3cjV3Z29SUnZaRGZWektEZXo1ZDZyTTcrS2xTVjhLVTNU?=
 =?utf-8?B?WWlPNGFyNGFISkEvSU12YWxoWlVqWk1JUGEyVTVqcjhPdHFnRTFYMDY3QzlE?=
 =?utf-8?B?a01qWjBxV0JTVWJYL084dVpUU3pkRnBOV2h6SGdnMExYMWxlbW9VYy9yelVs?=
 =?utf-8?B?eWlpbkNzcmRrRWI4N2JLSVNXOUVteDUzOUNXeHk5K3E2dDVIQktrR3ZsZVA5?=
 =?utf-8?B?Wkh0Z2xEVENpQjFkSmlnRTFSWkRxTEozNVUrNUMwUGVQN0I3ZUEvaWxYd2c2?=
 =?utf-8?B?Q1VJdHFvOUxsMHVaTlF5S0NqWXYxSFdlZVB3UkhxYmxkWm1tQkxXN2xmT3Bt?=
 =?utf-8?B?NlJWbmltWUpqQ21ZTmJBdW9zSDk4VDdwK2M1OTZNdVFPVGl6UXpUQTJJeU80?=
 =?utf-8?B?dklsdDJ6OC9tNmJLUXZLcXdzSFRKQWNrWXQwNmRHdTV1TEtjZVd4enZFVW1z?=
 =?utf-8?B?eEdnQVprSzRKa0NRckhJNkxhTXpudSsvYU1rdUhQV3VaQWgxUlltTXdKREx1?=
 =?utf-8?B?M0E1cnROc25lcExudEszMlJ0SDZTcUwrSVhsejFpcHFsYlViQVB6VklURXR3?=
 =?utf-8?B?eVhSUTQrVFZoSVdHYWtzR2haY1dsZ2Z6NXBIV2lDL21DU3lIRHhHZ1VNTkZr?=
 =?utf-8?B?aHZPSktjN2xXZ3piZjNOMktCcjc0enlHTitkWTFNcjA2NlllNi9GVEtSUnM0?=
 =?utf-8?B?TGJZUTgwaWtTTWttamR5eDBMVnJ2VDBiaExaQzJ0R2FXMGFON2wxV3V1ZFdW?=
 =?utf-8?B?ZnBya0cvbGNYd3U2U2ZLak5pNnRsSy9qNTJDZTJmdDJiU2JCa1FHQzZVU2NF?=
 =?utf-8?B?TEJhbGo4bW5NVVd5YWpJYlpMRHZQZG53WlE4RmRremttNGJCaUJxaTBjeEpi?=
 =?utf-8?B?YWFWNEgyRGo2MDcvREtCMWJiakk5dlVyYzA1dnlyL3BvKzhnOGYvMlpGcERO?=
 =?utf-8?B?bUREaFVxaHE5Um9ZT2FoUnFEekFLeC80L3ZZbkl0L0hwWXZQSTlNd0t1VHRp?=
 =?utf-8?B?eitURDdJc0VSZGdBc3lTYlZkVkdGY0trTTJpNTZJcVdYZ3dSUStid0xhTVNN?=
 =?utf-8?B?SXFtY3FGbUF1T0xrVUJHa3AwVzJBdVYzUC9oVkN3RU5jQkZvSVhXK09xd1d4?=
 =?utf-8?B?cTFOOWw5S1Y5NnAyWkdqNFZMWENLYkpXN0t6d2Zia1UveEpaclV0ZklDcER0?=
 =?utf-8?B?QVFGL2YrZzVicWt3WlJuYVJkQUZDWjhVUjlqQ0IwTDA4TlEzczFLRkNSM1NL?=
 =?utf-8?B?Y013N2ZPaXNBN2VKS0lKS1YrWExCOG5laytOVi9QclVlb05nMVdidHB0RFVn?=
 =?utf-8?B?V2kyS1JGL3NYcEFhZGkzeE5NcENDV1p1eU5xeEpyMk9JUmVkQ01lYVYvQ3Vh?=
 =?utf-8?B?R0x1NlZqV1g4UHVYUk51WTh0MXV3amxDa00vUkI3QXlVamk4TEN3U1cyU09u?=
 =?utf-8?B?dGlQT2RwZ0pRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ukp1Y3E5R2hCRkFDbXNGUmlqcThCU0hmV0M4UEVLdkN1L2xWeHBFZDR4bEg1?=
 =?utf-8?B?Rk9SN2lyNTVTYmNieTg1SzBkcVIvQmFtMHpENnRDa0RKVDdwZWZEUFhRc2I0?=
 =?utf-8?B?MUNBYTdYQzYrbEpJRlFSMHRCS2JHTzNoRUgzZ21xMmFGSTlwN0JvTWdpdC9v?=
 =?utf-8?B?OXA1WVkyZFA4a2ZPL0Z1TzRJU0F4TVJjMEhnNEJrOVpPMVhNM2QrMzMwcVU1?=
 =?utf-8?B?cUdHU1BGKzZTeWxNSkZBMTRUeEhDTlBZNCt6S3pWNUhlaHBsWm9KekxSOStj?=
 =?utf-8?B?MTZzTVB3RFJDWVBxeU1VejlOM3UvdFNIcVhQMDhnNFd3ZWhXbGV4VjFNQ3cv?=
 =?utf-8?B?VkQ4c2pxUlIvcjB4cFBvcW5INHNQQ203WlZXQ1ZoSDMySEE0WGZBK3VldFFJ?=
 =?utf-8?B?ZlNGNmg1WEZzNDgvMGp2eEx1SitsUEVhTWxtRDFpWGRZVklZaGIydnUySlVT?=
 =?utf-8?B?RkFINTFBQUplUzM4dFhpZi91K0lqckNXcTZmcnZRTXBNekxNb2ZnalZ3Mzdw?=
 =?utf-8?B?ZE1LVmx2T0kyQThtalJNdWY2Ry9hMzlMN3pSeW0xT0ZzY2M3MUNrRjlqRHI2?=
 =?utf-8?B?Sm1PK3pETmpZTlQweFBFTzBLeW9sWHhmaDRhLzhlYmw5bXhVWkJrTDZMUVI1?=
 =?utf-8?B?dTFDM1NlSi9MYUQxTjJ2Nk5DcjZLbkx2WWVMM1R0dlhST04zV2MyTjVwdHVU?=
 =?utf-8?B?eGdsWXV1Y0t0WVEzZ094WjdoRkpNOG1NUDhFK2NNQXpFVldJS0ppc2V3emxU?=
 =?utf-8?B?Zm44a3N5N2lBcGxZVWdWUkdaZHZYN29XY3JxZ2hVMjJuZDNtbDRCN3krVzFa?=
 =?utf-8?B?RHZWWkk2RzJHOC9UK1FEdUlJeTM5OFR6bEhFai9SMkt2ZmpWOHc5cjl3YkxR?=
 =?utf-8?B?cXNBU3dPRSsyR3FYcmsyR1VMMG5HOTdzVW0xK1BRNUYzYnJ1Z0QwVnR4dzV4?=
 =?utf-8?B?OThLVDJCNXA1WUtqWVRZUGNWMnNMZHlmSVVwK2Nrc3I2ZWNpUmRzTFNtOGVh?=
 =?utf-8?B?VWlmMFhrRVc0eTl5dWFpYUVrRmtFZ3lRbDRUOHh3OC9DeDVVbkhpN1RsUzZO?=
 =?utf-8?B?WmNSY1hCa0x3Z1RVS2FYbHFWMkxqZHc0TUNPazBNVDVEQUluQW15K25tejZp?=
 =?utf-8?B?R3F3RmRBa1QvR2FMaDRuVUExM2ZKR2FFRFJLVmdUYmhiY3h3dEp4QVVPbnBy?=
 =?utf-8?B?c0NoQ1FYQWJ6b2lpUExGaW9MeDlxRSt3NWtXb0F2U01EVlpLamFPWm1Fd0dp?=
 =?utf-8?B?RytKeDIyVWtoQTBkMDc5ZlVHMDhENWxJTkJCNnM5dEhKS0hVSG1TZndGSkNB?=
 =?utf-8?B?a2JvVTlIdzIvQ3RmVCszUkd5QUgwbXFzR3pMMXlhcDd6aU1wRjliTzN2eVpN?=
 =?utf-8?B?NkpoOHBXS1gvbEh5ZnFQUVNMdVUyVUZTR2FBckpCQlVVSTArMXpxL2VXWGlN?=
 =?utf-8?B?QnVaMUNxSStuRVZENjA3RlNHY2hrcHRnWGRQd0dUMUFRVlpGVUE2VS92N2hP?=
 =?utf-8?B?bDdNU1QzTDU1YUlyVWVYTDRpZ1RnUXFsbDRGWlY4aXBtTHoxai9XMHFYZXlW?=
 =?utf-8?B?bkNpakppR3BDdkk4VHFRSmJ0NVp3b0VtampNQ2xtZldxRTlhN2NPN2tIekx6?=
 =?utf-8?B?U1BrSkZlUG51WjdHZDNGWmRSYnJnRlIxU3ZqcDZaR20xaWlBNmRUSE1mQWFS?=
 =?utf-8?B?b2srWEw4K2s4Wkl6RVpLbXM1Tk9aNmplZDR5ZkQwbVVqK1d6bGNqRVVBejFS?=
 =?utf-8?B?clZ4TCtNdUZrZ3RjcUlYQUdTM1ozRWgyaXY3VGpETnUyME5iTjQwLzZCRFNq?=
 =?utf-8?B?U0d5TDhqTFErcXVzdkVOaDVrME5MNnBkbGVVV05JQ2o5eEt0NnVOOThYVWxt?=
 =?utf-8?B?QTZnUG16NThOOEoxZWo1bEh5VWxQZHJSREp6NldDV2N1R1B1OFl1OGMxdVo1?=
 =?utf-8?B?Q3M3dytLa1dXYzJ4b1pqT0MrQ21YNDloTUN0SVZ3Z1lFRnA4Y0JzNi94SkEz?=
 =?utf-8?B?bXVCQmFVMEYwSG9oSFFQUi9KL0FicEZ3b2ViUUZRbEZ0cVc3TExKQ1VmZUI0?=
 =?utf-8?B?ZzRKRjF6VW9HbXR2ckI2aitES3ZhVU15M3FlTFRXTWpXNmFWazJXT2JMN1Uw?=
 =?utf-8?B?azhXYk1XRVQxVWF0ekpiVWFoaXJvN0ZMcHZpVEc1ZGJoTFJwZlduVmNGV1Bs?=
 =?utf-8?Q?ceoaRZY0z3kY+bbRCX15kIE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DDFA3414B863E4992CB784B887009CC@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4875bf8a-abd9-40b1-5bcc-08de1dd21d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 07:49:00.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9P5Y3Qz/GVkuF3AHSUuc2KQtZP8fHZfx478Q5ad3jPOqfJRvIviuYMnhQYfkD6ETGvLMaSEaqOUsP0uEQMzcQvjsBv8nqm85d3XkLprtZqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5276

T24gNy8xMS8yMDI1IDM6MzUgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIEZy
aSwgTm92IDA3LCAyMDI1IGF0IDA3OjM1OjI1QU0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkg
d3JvdGU6DQo+PiBJbiBBZ2lsZXg1LCB0aGUgVEJVIChUcmFuc2xhdGlvbiBCdWZmZXIgVW5pdCkg
Y2FuIG5vdyBvcGVyYXRlIGluIG5vbi1zZWN1cmUNCj4+IG1vZGUsIGVuYWJsaW5nIExpbnV4IHRv
IHV0aWxpemUgaXQgdGhyb3VnaCB0aGUgSU9NTVUgZnJhbWV3b3JrLiBUaGlzIGFsbG93cw0KPj4g
aW1wcm92ZWQgbWVtb3J5IG1hbmFnZW1lbnQgY2FwYWJpbGl0aWVzIGluIG5vbi1zZWN1cmUgZW52
aXJvbm1lbnRzLiBXaXRoDQo+PiBBZ2lsZXg1IGxpZnRpbmcgdGhpcyByZXN0cmljdGlvbiwgd2Ug
YXJlIG5vdyBleHRlbmRpbmcgdGhlIGRldmljZSB0cmVlDQo+PiBiaW5kaW5ncyB0byBzdXBwb3J0
IElPTU1VIGZvciB0aGUgQWdpbGV4NSBTVkMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1
bCBBbnVhciBSb21saSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4gLS0tDQo+
DQo+IDxmb3JtIGxldHRlcj4NCj4gVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVyIGR1cmluZyB0
aGUgcmV2aWV3IHByb2Nlc3MuDQo+DQo+IEl0IGxvb2tzIGxpa2UgeW91IHJlY2VpdmVkIGEgdGFn
IGFuZCBmb3Jnb3QgdG8gYWRkIGl0Lg0KPg0KPiBJZiB5b3UgZG8gbm90IGtub3cgdGhlIHByb2Nl
c3MsIGhlcmUgaXMgYSBzaG9ydCBleHBsYW5hdGlvbjoNCj4gUGxlYXNlIGFkZCBBY2tlZC1ieS9S
ZXZpZXdlZC1ieS9UZXN0ZWQtYnkgdGFncyB3aGVuIHBvc3RpbmcgbmV3DQo+IHZlcnNpb25zIG9m
IHBhdGNoc2V0LCB1bmRlciBvciBhYm92ZSB5b3VyIFNpZ25lZC1vZmYtYnkgdGFnLCB1bmxlc3MN
Cj4gcGF0Y2ggY2hhbmdlZCBzaWduaWZpY2FudGx5IChlLmcuIG5ldyBwcm9wZXJ0aWVzIGFkZGVk
IHRvIHRoZSBEVA0KPiBiaW5kaW5ncykuIFRhZyBpcyAicmVjZWl2ZWQiLCB3aGVuIHByb3ZpZGVk
IGluIGEgbWVzc2FnZSByZXBsaWVkIHRvIHlvdQ0KPiBvbiB0aGUgbWFpbGluZyBsaXN0LiBUb29s
cyBsaWtlIGI0IGNhbiBoZWxwIGhlcmUuIEhvd2V2ZXIsIHRoZXJlJ3Mgbm8NCj4gbmVlZCB0byBy
ZXBvc3QgcGF0Y2hlcyAqb25seSogdG8gYWRkIHRoZSB0YWdzLiBUaGUgdXBzdHJlYW0gbWFpbnRh
aW5lcg0KPiB3aWxsIGRvIHRoYXQgZm9yIHRhZ3MgcmVjZWl2ZWQgb24gdGhlIHZlcnNpb24gdGhl
eSBhcHBseS4NCj4NCj4gUGxlYXNlIHJlYWQ6DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y2LjEyLXJjMy9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmct
cGF0Y2hlcy5yc3QjTDU3Nw0KPg0KPiBJZiBhIHRhZyB3YXMgbm90IGFkZGVkIG9uIHB1cnBvc2Us
IHBsZWFzZSBzdGF0ZSB3aHkgYW5kIHdoYXQgY2hhbmdlZC4NCj4gPC9mb3JtIGxldHRlcj4NCj4N
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4NCg0KVGhlIHJldmlld2VkLWJ5IHRhZyB3
YXMgbm90IGFkZGVkIG9uIHB1cnBvc2UgYmVjYXVzZSBJIHJlLWFkZGVkIHRoZQ0KImFsbE9mIiBh
bmQgYWRkIGluZGVudGF0aW9ucyB0byB0aGUgcmVzdCBvZiB0aGUgb2YgbG9naWNhbCBibG9jayB2
ZXJzdXMNCnRoZSBwcmV2aW91cyB2ZXJzaW9uLg0KDQpUaGFua3MuDQoNClJlZ2FyZHMsDQpLaGFp
cnVsDQo=

