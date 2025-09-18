Return-Path: <linux-kernel+bounces-794142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15802B3DD7D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A266189FF57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D123009ED;
	Mon,  1 Sep 2025 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="YTSt3vbN"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0A3009E9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717161; cv=fail; b=SZaow0R+GHPdbb4yaEtmtqakofHzw3KKSxRa1y27VJ+3kLygIb2D9nVeqeQTcKOm1cIiOkL9QiGFDaisjARGhAffVIZIl+7pLN68MyjBQEQL0rqhgdsOoDe2Bft2zFHhQjX8RiPu8G/KhrEx/l9k20Jyp59zlRtHjge4+6VsUzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717161; c=relaxed/simple;
	bh=1e7dQLDBO+4C23NIuGVNSL1pvczBzm9B1/VZKGteIvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eFsoPUglUhajUEOhiTXwViSzNimDrEoiBhazqKyxbI8433NBVgA6+VU1Vc30ELTnDy8T9RJd25Eclt8gepfNbChGNUinaxV2HyQ1Szshzbcjk2kFU/Bkv/fcSWs0jmJ9YhG3ARkdh3/KAu012bZ3K8aGg61yNG+EluiAsnhNdu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=YTSt3vbN; arc=fail smtp.client-ip=52.101.72.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIUp827h/Nd3JK6sS7lB4DUtfnuo8x5GgJbkrmwnjKjABh1VUVdeTvB4xa+jb5WiDpP43ZsbK4WnKq/RKWEJH+FEMXGXg8fyabGVPbbWC1ShFkf81bCUwLenUoSz7VTtAwxJTf6OgsDGio3LcaogWOxkzivx2ex0pxMAaemQxE2waqKcs65NNPiJf2bBFgIxtTrkbMSDD5rxjXm115iNOC5YVrkun5HDuTdQAzSQowS4kR5ZgFfvMcfQKdpl1pCkF2KWFpb5zwsSVVxKvniqd3jioQR0Tx2NVXAdHGqBhBqgaAO3cH25w9lHtBuDt2JOvAwlLKuXUaQUsVKW+yhpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e7dQLDBO+4C23NIuGVNSL1pvczBzm9B1/VZKGteIvE=;
 b=OMBTEVrrOlC1Cdc62YLBlGn4LVo46wJZoj61mVhmDwiyLk3ahLPHR8yIUmh0J4ihyd9mZ9LOyfZ/dEL89pA/b52pPqgMOQbK3fPbMKUvQxkYz8discL6u0DjcdCO3eWD0zrWNyXVHk38LJ+WNm8QjYucqhS2vCdtfEDK8Q3xO+l6CtAAWoD4sr7XcM/p17SqHsww1+z258WZFj/rbA0TlEimAq7hoLL9bNZivyTYL6ZquDWOWKighXWkI5yMrNyx5wPI57F7GSXji3dZHOa2QxBpPDnoy3pX56WRApqQVg20/MM1yz1y3hFLA+bhZP+o3h759zAYjvlgmcM06ZQ8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e7dQLDBO+4C23NIuGVNSL1pvczBzm9B1/VZKGteIvE=;
 b=YTSt3vbNzxugn3Mj0bLpmAiHrz+WIlfa4woi+h9GFmOGtx30nMtr2Thp1v0MmnX8Tt1Nns6GDWpo8lKWCi3XVahV1RQYIMZsuTguMMcWWnkylWmnHiIMoUiYcFADsLV1dY0Q39fbrqqc0MciJM0+ULVeGJHEUJwOQJxa++BBs6A49FC6mex3ux3gNVr5932Z6Tn8vSIYFrMOgeThwPyejBaI0PLUI7WqE8U2RbslT7il8CVoh3EvVcGNTB397KpMqLieKFTIfASamAjKv7i6OQ368VXLVYbz8zQXDweyEr8GjB48riS/HwXaHwQrHrIqAW3aYHyzIVNIWEVSKz4ROg==
Received: from AM0PR07MB6196.eurprd07.prod.outlook.com (2603:10a6:208:ed::33)
 by AMBPR07MB10620.eurprd07.prod.outlook.com (2603:10a6:20b:6b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 1 Sep
 2025 08:59:16 +0000
Received: from AM0PR07MB6196.eurprd07.prod.outlook.com
 ([fe80::7cb7:ff63:d358:1a]) by AM0PR07MB6196.eurprd07.prod.outlook.com
 ([fe80::7cb7:ff63:d358:1a%5]) with mapi id 15.20.9009.018; Mon, 1 Sep 2025
 08:59:16 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Kunwu Chan <chentao@kylinos.cn>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"maddy@linux.ibm.com" <maddy@linux.ibm.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kunwu Chan
	<kunwu.chan@hotmail.com>
Subject: Re: [PATCH] powerpc/83xx: Add a null pointer check to
 mcu_gpiochip_add
Thread-Topic: [PATCH] powerpc/83xx: Add a null pointer check to
 mcu_gpiochip_add
Thread-Index: AQHcGx6ysyRqEE1m6EGNziO7XdPyhg==
Date: Mon, 1 Sep 2025 08:59:16 +0000
Message-ID: <23d79af2-8509-4037-80fd-34ef1ce507d2@cs-soprasteria.com>
References: <20240115094330.33014-1-chentao@kylinos.cn>
In-Reply-To: <20240115094330.33014-1-chentao@kylinos.cn>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB6196:EE_|AMBPR07MB10620:EE_
x-ms-office365-filtering-correlation-id: d26e1d15-b9ed-46f9-9647-08dde935d4a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmtDRzVtUFo1RnAxQ01BZTd0bUxTQzI1Q2lJSk5qSkdMaHk5bWZJUE56dDJC?=
 =?utf-8?B?WlBHd2ZVTVF4N1JPUmRqcjNaUW5pN01hbUVTbld0MnFJS2VPVjdaT3JvOGJU?=
 =?utf-8?B?MDFDdVN6OWxGVlNWaGFoL01LZmk1S2Iwdjh6eTEzRDNXV2owTDVzdURpK3V3?=
 =?utf-8?B?QXVQVWliNlpGTUZtSy9ubC9Vd1VVRzJpcjh6a0pCWkxWQ1VzNXY1ZGsxMXR5?=
 =?utf-8?B?M3pIbWlQcDFpdXl5TzZkT01aWTN0TlFjQmtYcDBTVTBJNm54cThOODhYRHBM?=
 =?utf-8?B?SGFmZE41L2h5b21oOFl1dVVQaWxxSHEwWWN5NWFyYk9Lbitaa3VYeGRkRkRl?=
 =?utf-8?B?OXFBbEFHRzhYSlhLcjRJWXF5Mm4rdHd5czgrWlIwT1RBb1ZVendFclVpYVhz?=
 =?utf-8?B?MWFweExGWmErRTRVS20xSGJnZFh4L1VYVjhmdkUvendPVHRwWWw1aGdWK204?=
 =?utf-8?B?bXhUYXMxUEtmVlhqQ1BjRW5PdDNzT08waVduZFd3Z3ppbjRFbkc5dGZaWkMx?=
 =?utf-8?B?S2s2b2VhSlFrb3pGTytSK29jekJURjRLZTVDN2Nod3dLWUlPdU9iN3IvMHpU?=
 =?utf-8?B?MDFDVFRmeVZKeXQ0dndxYU13ZysxYUNMM3hrNXpSRXc4Zk95VFp4V0pkL3Jx?=
 =?utf-8?B?TEdlUGJDUU1Mb0VIbVZGM0xiQithalVsSjgrVnFXUWJCWlNsZUU2dkNCUzkv?=
 =?utf-8?B?b3dLSVh6TE5OVzdtZ3UzUytROEMrQ0F1bU9yb282bi9VdmhwM1Q4dFZyR0tw?=
 =?utf-8?B?NThKTEU0d2xrMVc4UUloV0RZRGsya1dYalJTRnJBdHljMEN1TGMvOTY2V2RO?=
 =?utf-8?B?YlJsbkw1dTluQkZFb0ZPMFhIcldyNGwrbytJc2FlK1VWYW1lN1hBV1BjSC9P?=
 =?utf-8?B?VFdLNENCcG8zVy82eDNJZjdzUVk4WFdYK29QbGpDbXZaQUorckExc1Iva0c4?=
 =?utf-8?B?RVJUMU0vRE4vMDJVWVZ5bFZCbCtQdjJDZWZ2eXBUUCtWQ0VHV21Ua3NldGU0?=
 =?utf-8?B?bURwMFFldndUNnJHV29pS1ptYmdmSW0zbTQrejg3OC9JWmxjaXlOQ3VEYS84?=
 =?utf-8?B?eGFkVkVnTUU4S1pyWS9jTisxRUg3dFlSSEZjSlBmb0JhMkNrS3llSk5PaUoy?=
 =?utf-8?B?dDN3bExZM0RObDAwUDA5TUsvOHBJTFJrcmdRSm5mRHY0TzZQOUllWEQ2d1l6?=
 =?utf-8?B?RUhqL3E2bStEcUZmV1FBdU8yaEY5SUNlVFVTdkt1WVR5U3dUSTVJUG82V2RZ?=
 =?utf-8?B?TGJUenhhYTNlcjFhc2d1aVkzYzVpUGg1R2F5THNCR3hxOXIyMlRFVUZJRCtU?=
 =?utf-8?B?eDNJU1pGdWxubXVHa2oxU0Irb2hVaDZZTGRHMEhxK2tKREJTNzhKdWhSb3da?=
 =?utf-8?B?QVVzT2M2S2pseUR2T1hrcURvZUt0NUJFekV2RmNSa1ZqTVBsTVV5Q0FSWG9j?=
 =?utf-8?B?SzhHTlpMbm9zbmJVNGhHTXcrY2NBQlk4dmVJRnhseDZGRFJnejdSYzZXYWN1?=
 =?utf-8?B?Nm5uN3diZC94bFdGZDgvSjhVVHhVZTdpcE81ekFYaXpha015UFp3M3FkcEl0?=
 =?utf-8?B?R3lWSldmb3lWczRMOVpaNVpmNmt3YXo0enN5KytzRkVHZlQzSEtHVjluWVlB?=
 =?utf-8?B?cURrUit6SHkzeEZoZlphemRMRTFUajRteVhCK1BsNE5XSEVJVm1YZlgydHo5?=
 =?utf-8?B?K2dzUGlFTlZPQkE2R0FjQTE1cFFKSGFPbTd5S3RSMHdSaFB4Y3NLdGdWcmV3?=
 =?utf-8?B?akpXdmt5NDdLekQ3WUl5cDhHQ1krOE1rTVlZTEowUHFoekdVS0VPY0RFemVN?=
 =?utf-8?B?UUZuM2tSZWg0cDRPTWcxTUo1S01ubVdBWGhPN0hyY3pQT0VKU0ZScHROd1Qr?=
 =?utf-8?B?V3d0VGxhRTROZ0dwaWFlK01pYjdHVW5tVmx1em1CcnRocUEvclB5L0wyeERV?=
 =?utf-8?B?c2pnSVJTaHErV3RvUjN2OVdNaHZqL2JZVUg2Y1ZoUmFmTm1ya2NrYjBNOG41?=
 =?utf-8?B?RForRm1qdWFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB6196.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlFlTEVaQ1Y3L2NnVTNYaWhvUy9HdHo4dDZLUEs4aDlVKzd3NS9UQ3A3MVNW?=
 =?utf-8?B?ZWVlR3QxVmxjN2JDN0xFN1p4ZVpaSVg0cDdFMmZFY1hOeHQvSzBqVE5YNk5S?=
 =?utf-8?B?cEFadzNOWEhPV2ZyZ0pRdjRGcWptYkV1RU1KWlVZcy9kZXVPd3k3VXJaemdB?=
 =?utf-8?B?Q0owbHIzelhtQU5kL2pmNEwyb3VPRWlxcXFtenlLVkJkSytKdXo2Uk1MRW9v?=
 =?utf-8?B?N0JWd09WQkxXQmZBVDlwbTB2RzF5ay9ZSWV3WHkxUmM3UnF2N1lwVlVuMGpi?=
 =?utf-8?B?MG82KzBkZ3ppSEsxSDFKRVV6WXhCK1ZkeWNvOUs5NjZXRk15WkJQMElVWkFO?=
 =?utf-8?B?cVVGaFE5cGlFWjM2a1A5bnA2N2wrK3c5ZnliUHQvYnJEREEySWIvWWVxNHlE?=
 =?utf-8?B?YmJpeFJkTTd2eXl1ZFF6QkhiRm9LQ1kvQ1Jzc3RQVVpycWRZb2w4M2huME5I?=
 =?utf-8?B?ZzM4R0JmT25KdFdHU09oWXV1OXlOQnhjSWhsa1gwOXFsMkpRY1B5UjVJbWw2?=
 =?utf-8?B?MDUvRGgvay95ZTQxWmlrZmIxejJlc0s1MkhFcW5hWmdadE1PVm5MeS9FcWYr?=
 =?utf-8?B?aVRDQnllRUVRNlUrT3J2OEFpSVhmNHdxaWJLeC9vc2FMWjBBeklsbGFETEtL?=
 =?utf-8?B?U3VjYm9rb1NqcGdwL0FibTlibnZSMy9ZSmdENmZCQlUyQUdVdndYckZORk1o?=
 =?utf-8?B?RzVYSE1QKzhwc2FCM1dzY1VzZEQ5K2JmbmJaUHByVTJkbXVjdmlRV3dCLzBB?=
 =?utf-8?B?aUVFcWhmMGRtdW11L3NhZDBnTjUxNTBlTDdHZDREQy9oTWlCWFh2Ti9qZ1F3?=
 =?utf-8?B?eC9oNmNsU0JSNm9zeE5oaSsvN1FVZE44RXduYnppSEEwSmdlZ2V6K3lkaUlm?=
 =?utf-8?B?dGU3cTNTV2RzYmlXbFBuc0o3d0NDVW12SUtjd1NGUlhMME9DQjRucVN0QkV5?=
 =?utf-8?B?TDZ0blFLbG5JbW51UUc3RlVtNDdsWFZ2YzlSelRCaVE4MnkwMGRGZGdpenpV?=
 =?utf-8?B?WUl1NitKT2hSNFBkYXI2SWkrWVFadnVueGFBVk9BS0lYZG1IeXlqcFZoOHdW?=
 =?utf-8?B?YitjSGZMNnk0aW5aaTlpdlExUGpIczlqTys0VHR2WC9NbmM4MzVLU08xZTBi?=
 =?utf-8?B?enFMLzFhbytqd21aZTRnZTdBKzNIWi9lZDFhNXBGNmh1QUJWTWZlWnZTZEQ1?=
 =?utf-8?B?WjhWOGJ5YmpTY1lFbW9ZTXhQbDRocVRkM0NVM25OTEN1QnI4amxKTlljNndl?=
 =?utf-8?B?U1A5eG5DQmtoL1MzV1FKWE1QQ0ZSelBpa1lkVEN0MTZrQ05WalprKzhiYlJX?=
 =?utf-8?B?N2g1c1ZCRm96K2doQnlSdTlPd0x6UnpjVVgzZ1Q1aEl4NHRnZ3RmdnVCUm1L?=
 =?utf-8?B?ekRsMnB2dkF5U1lUMGNXQjRDOStpRHBiQTduTHFJdWpYTW5VVjB1VDNMMDVk?=
 =?utf-8?B?OEtFckp2aHN6Z2xvQmdlWmFTN05aV29Wa05ydm14SWxNSFdpUUhaVVcvRkZn?=
 =?utf-8?B?L2FjMUh1WFFwTEZSb3dtVWVSRTNlRnZicDdsRkFoYmR5Q0NBSUV3UzZ2MjAr?=
 =?utf-8?B?OFZwNmNrektaTEhNMERxRDdXWlRjcHpVMkRGUkFLclQ4S0xHMmNnTXlKOUhM?=
 =?utf-8?B?c1JINERUQ1ZTNEJ4NlNuN09CLzhYQ1ljdTFSMUZaQUdSUkMwemJFbEg5a3Zn?=
 =?utf-8?B?Njd1WXdvSjN1RW10eXk4Z01kZFBrbHUrRzFhdU5qSlFYcTdHMkNKTE9Rd1hI?=
 =?utf-8?B?aGZnY24yRTZmMU9JZVliK3FzVmRueHdyR0VTZjdzTzJ2SmRDWW9GRy9sdXox?=
 =?utf-8?B?V1pUbWY1QW41UWgzNnZlUE91QW5odVd2cjVjQUowQWwvVldaU0VNSWxDVlg5?=
 =?utf-8?B?cGx3VEdyWjlsdGs4a1FEaXUra0dtQnZUTWhaQkRBY25XOGNHT3FsOHNDOFZV?=
 =?utf-8?B?ZXBSRGIzK3A1bm53dzdVZTVYZXAvY1UySGR0dS9QdTQ5SzJlQVY5cUdxcHNO?=
 =?utf-8?B?MXRqanQ3WVZ6UzZIZUZCbFYydnkxNDF0NHhKZFhPdVhOZVAxWkphT2ZLa1Jp?=
 =?utf-8?B?azJaT3kvakJQMjY4S21CT0dOWS8xYXhhSmtBR0ZhbHBuTzdWcFY4dkhlMzBp?=
 =?utf-8?B?Ujd5emlJbTZXazZUcWd0Zmp2SWF6dUpXSWFhZkdWUm45cTc5M0NnNXQydjdw?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B598E292F31B0548BA8F7845F0B61E8C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB6196.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26e1d15-b9ed-46f9-9647-08dde935d4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:59:16.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ge/esDnNkndovkNJzHiUo3UPDepV/0GaDtI38yPvDF8MhFqPnnYigE7BPybZnD+Dn1CVatRa5Hk9qB4LVySXyokZqHZIxb8/OnPwUNMXPSqF/ewmlXI5//QjDfBBYZDW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB10620
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB6196.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AMBPR07MB10620.eurprd07.prod.outlook.com

DQoNCkxlIDE1LzAxLzIwMjQgw6AgMTA6NDMsIEt1bnd1IENoYW4gYSDDqWNyaXTCoDoNCj4ga2Fz
cHJpbnRmKCkgcmV0dXJucyBhIHBvaW50ZXIgdG8gZHluYW1pY2FsbHkgYWxsb2NhdGVkIG1lbW9y
eQ0KPiB3aGljaCBjYW4gYmUgTlVMTCB1cG9uIGZhaWx1cmUuIEVuc3VyZSB0aGUgYWxsb2NhdGlv
biB3YXMgc3VjY2Vzc2Z1bA0KPiBieSBjaGVja2luZyB0aGUgcG9pbnRlciB2YWxpZGl0eS4NCj4g
DQo+IENjOiBLdW53dSBDaGFuIDxrdW53dS5jaGFuQGhvdG1haWwuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBLdW53dSBDaGFuIDxjaGVudGFvQGt5bGlub3MuY24+DQoNClJldmlld2VkLWJ5OiBDaHJp
c3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCj4gLS0tDQo+ICAg
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84M3h4L21jdV9tcGM4MzQ5ZW1pdHguYyB8IDIgKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9wb3dlcnBjL3BsYXRmb3Jtcy84M3h4L21jdV9tcGM4MzQ5ZW1pdHguYyBiL2FyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvODN4eC9tY3VfbXBjODM0OWVtaXR4LmMNCj4gaW5kZXggNGQ4ZmE5ZWQxYTY3
Li5kMWFlNjZlYWE2ODcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODN4
eC9tY3VfbXBjODM0OWVtaXR4LmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84M3h4
L21jdV9tcGM4MzQ5ZW1pdHguYw0KPiBAQCAtMTIwLDYgKzEyMCw4IEBAIHN0YXRpYyBpbnQgbWN1
X2dwaW9jaGlwX2FkZChzdHJ1Y3QgbWN1ICptY3UpDQo+ICAgDQo+ICAgCWdjLT5vd25lciA9IFRI
SVNfTU9EVUxFOw0KPiAgIAlnYy0+bGFiZWwgPSBrYXNwcmludGYoR0ZQX0tFUk5FTCwgIiVwZnci
LCBkZXZfZndub2RlKGRldikpOw0KPiArCWlmICghZ2MtPmxhYmVsKQ0KPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gICAJZ2MtPmNhbl9zbGVlcCA9IDE7DQo+ICAgCWdjLT5uZ3BpbyA9IE1DVV9OVU1f
R1BJTzsNCj4gICAJZ2MtPmJhc2UgPSAtMTsNCg0K

