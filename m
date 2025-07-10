Return-Path: <linux-kernel+bounces-726005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136CB00690
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63ACD1C26759
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E68275854;
	Thu, 10 Jul 2025 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cp4hFaKD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D496274664
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160931; cv=fail; b=e9qXdvYMd0eutYIWkz1Uj1MDRfa2fSOzAGc3Ek6GGTZG2Pirmz6PfOSfD9WOZJ+AYJunUYk0pXU9dpLjPrwZNJ+eGNm/7CQak5JSF4KK4RFKR1Jq2qpWqfEn+wsDa/w28HS84j7za7Fpy/Xq7M/5TGx4NzqOHXoRlgQ21C+CYjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160931; c=relaxed/simple;
	bh=I50biPEAbL/MW7KhD+MLBtHv51uPLwXhZjt/gl+/bnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X6QxfaZmN3jy+nj7i/f7bXOtFB9OS3Zfyu1I5jB3HERJgocXgoB1KzD8kbE/rXpiO+DNNprARmx289QIbw35fDP+cTjDb23i2cZCCgY8paqZqrWNCijP3I5UVZrIOS1x1DwrYvTu+NVkFtDwP/rjeoxd6gXAlXOYCn3PONNqdzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cp4hFaKD; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGfjh1rO34s485YYA3jJ7P92gmYf+0KXhwCdMSyMgVTJClax0C/gBdreRX5bK8WnxfrkzFlCPsDFlm2ynnNTSE/52XqYG7pLWIHqwGtUw1XDqAfHHBtmOasQIjURGLZKi9qTg/wGH07CZFVLbuV7QfSVwwQnoPno2DkuGHbBoq43o9IdlYTbkKexmVT0LUca4aYd2JbKJu2liggtLZ+w2DB9JVVt/FTTrKOyWtIBDrx+DIeWbgIaxEFNNfPijHwyPtdiPLjWqII0Pam7vDMs/6ddAjhtoSRBSkAjdjjs7BBBZxNLANRxTSeO+y7JTGVAoaC3Pag11deOceKQvN/muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I50biPEAbL/MW7KhD+MLBtHv51uPLwXhZjt/gl+/bnc=;
 b=V3YxC82tjru7KFlDsO7PSMHqOzY7WZf1TNTz9i6ZHlZQwxEBH1sAnDEANFqHazJQNBPHkT+z7ArEo4A2scu6B5BLFcdZqcDVgOrWkFvI8gO+U3WLKesaXARRyGGLJfW2h+XuBs9ma4MYXgiX45L+k0sQ5etFBialvcfxn+2Sl/Ykc2WUUSXobF58Qa3r8SmbdSo9WoaxB8H/i2F68y/CUcBK5zk7oIeB4Jo+f/9OW/o61Sc6p4HSbS6KEixdoWtjTf4p+ce+2+jync1V7bRj2l2gpyDZaR3vAyhuSvTp3RE4RU5H8q4kN2zZGHodvdyidImyjNzI5p0W+jK7FwRwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I50biPEAbL/MW7KhD+MLBtHv51uPLwXhZjt/gl+/bnc=;
 b=Cp4hFaKDPauPts+Pv0q/HCsqYZBXs4+XTZXy9ssEFuK7kwGZB+yPre24BhsMhgDhCOv7bm6uks9TSq7iCOPdzutZlcHwXKzG8/N7iC6khdpkfE1O0NsMC0L3nO81rqBUqm+vl/ZJpFfmeoJexHpy6Leypb5V1b0v48B0VjjHJ5U=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 15:22:06 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:22:06 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 02/21] cpu: Define attack vectors
Thread-Topic: [PATCH v6 02/21] cpu: Define attack vectors
Thread-Index: AQHb8Yd0Aa2smvaeMkOjZr6TRuOzMLQrYrkwgAAVlwCAAAFAgA==
Date: Thu, 10 Jul 2025 15:22:06 +0000
Message-ID:
 <LV3PR12MB92650AA0AC64C97BBE812CA89448A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
 <20250707183316.1349127-3-david.kaplan@amd.com>
 <20250710104252.GBaG-ZLG7p_LsNCjBm@fat_crate.local>
 <LV3PR12MB9265E7C013D6BBA5E6FB586C9448A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250710151702.GCaG_Zbjo1sqZ6NB2g@fat_crate.local>
In-Reply-To: <20250710151702.GCaG_Zbjo1sqZ6NB2g@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-10T15:21:29.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CY5PR12MB6526:EE_
x-ms-office365-filtering-correlation-id: 668388e8-e890-42a9-aaaf-08ddbfc587ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFV2UHVJZEF1dFdpWHNhWVI4UW9HQkdjenovUitmOUpaeEhGc1FkMWh3dUVl?=
 =?utf-8?B?ZVI2cG9rd1hxd2FiaU03eFJxbm9weFFGTks5RHBNQzRIQTZ4MDc2anFkZGhT?=
 =?utf-8?B?eitXUDRMblJsMUhlWWN4cElzeGNYWUFUamhjSmg5VjNvU2xGcGNzbGFLR011?=
 =?utf-8?B?Skkxd3BtRkwyUkZ3UGExLzNFOVpQTkhMY2lkWXorYlNISk9JUWYzTU5EbVE3?=
 =?utf-8?B?R203OGc5MXNRcWt2aVNSWGdyd0ZIdDJtRTNQRDB0NjBCOWJRTmd5RzM0ajdr?=
 =?utf-8?B?c3pYSnJGYnArM0c5b25oaDRDL09BNDFUZEpDTFB1OHhJUkNQSURPK3dKejRl?=
 =?utf-8?B?TGwwUmJjNzBvZnZ4eHEveTRKR0UwZFRHa3VjU3E5ZUdrZnNhS2RzU3ZNRERa?=
 =?utf-8?B?SEVSTlhPNjJzaHI5a0ZFMEJ0V085WitvSjBCVkU0NnZua2Q5MEpXaTFGMDZO?=
 =?utf-8?B?MkxJVDMvU0xWZUluU2NySmdkU1F0QS9KdGJ3aDRZUFhhdGgwRjRzRlRVcVYy?=
 =?utf-8?B?Mjk4amROQk84OCtwZUZEa0d3MmlzYVJGOUFmdkVJdXNQZjB0V3c3NSswM0dL?=
 =?utf-8?B?V0JXQnY4ZWZIaUtNK0taajNLNmFOWHo4OGdjVTB0QTgxT2xoL3lEQUhRNEJ5?=
 =?utf-8?B?ZjJSN0hvYmNra2NsSEFDREFaMHlPNTNzdkVDWVlUaDU4ZlRkRmZwcXE4dVkz?=
 =?utf-8?B?WlVBK0VmMXE5ck1GOEZ0MHpPZkU3MGxFTFpoV3Zza2tpdFFMaUNZSFVJK1cr?=
 =?utf-8?B?U1Q1bk9HcDMwWVJXbjUrck5tS3pLdHYxMHNJMFpLYmh4SVFqS1JEWGhGWHp4?=
 =?utf-8?B?OWhGTkZWdGdZRU9uUEpMbFlyeTgzaXhXbEhvR1lsSEo5emtHSFpxbW9kdXhv?=
 =?utf-8?B?MHBPdC8zU2JNNzdWVTR2ZGVNZmRQbHZlRWJka1VEQ3J1TGI1NWduZ2FHSGlh?=
 =?utf-8?B?YnpZdTQ5OEQ3VWcwZituVmFNRHFZbys5NTVscnhUSFh5eDZRK3duK0Q4RVo0?=
 =?utf-8?B?YVNnSlVMck5BRndkc3Z3alpybXBTMENkM2IwUkN1c0F3NWU4WFo1dzBsSVNu?=
 =?utf-8?B?WmtaNkxTUlc1L0k0NUFsZWk5M1l0K1lKL2tYYkZWbEI1V1hOcWlUWmlzbStj?=
 =?utf-8?B?SEc1dkFTV0JvSVkzVWk5NUhuN3hUY2ttN2QreVNsNnZhQlBtMm54R3RlSVA0?=
 =?utf-8?B?WGYwV0UzYW5WQzZOdE9JbFZNY1lkWHZDbjBWUEhiVXp3UDZoNEJBUm02S2No?=
 =?utf-8?B?UmVBeE1tZDNCd0JGNk9ER1lVblVSZmJhekhQKzA1K3RRbjJ4MTFJMVQzUWZO?=
 =?utf-8?B?L3plbDBMMXl5WTBncFNPYWxmNlU4NWM2NXdJc2JJRFYvaDZyc3NwbnNIT0Fl?=
 =?utf-8?B?b2dxbUdsVndkV3BzUGFnbnJxZS85VjNxZTd5RlVJblFNTjFLTEFLb0pPc3hD?=
 =?utf-8?B?UDV4SDFseUk0SlNqMmpDUUNRS3JsMUVIVkFoSjd6TTNHMDF2N2FYTXNpTHpt?=
 =?utf-8?B?OFVZQ2s5NXR5Q29URDV5S2VvakU2aGJBSlErZnQzTHcxelV0VC9GZFNFNWxL?=
 =?utf-8?B?YnAxaEJoNE5IV2lENlE3RVR6bjBXZlBHZkZySXF6MWlFSU5JbDNyZTBxWTJV?=
 =?utf-8?B?Q0E2Zm1jRnlvMGpxM0dTWS9GYnBTTXF4akRTTDJuMm1WZTBjL2FZa1FnSHh5?=
 =?utf-8?B?NE82M3JBWGZkcTRxRERJb3dkWmtJdHczNXVTNmtCc3NOVGMyL25vcFhTOXBh?=
 =?utf-8?B?Nm5SNjlYY3pkZ3Vxam5DRy8rUitBeWRHYlh5TDRZWjFKcGtVN1RNWFozYU1q?=
 =?utf-8?B?ZTFTSnlUYkpFWUw2WnUzdDRWbldSTk4vZDMrQXF6RXd0bEtHbkk0bGdiOVJi?=
 =?utf-8?B?c3YzN3BRYWQ1SGt5T0RGTmdMUDIxNVI2aTlib2FXVjVySURNdW95YTRnSlAw?=
 =?utf-8?B?WCtLSGIwRDdwbXRaSGoyYWhMMHpzR3Y3VnJmT2sxZlZNRGx0OGpZbnZZWnVw?=
 =?utf-8?B?YUZwek4ramx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWY4eHJWbm5LdFIvS0htbnFqeVFrKzVpWUJwS0ZjOWdpdmU1Z0loL0hFWUU0?=
 =?utf-8?B?NzU4V2VYWVdXbHBZamZFQkgvY2dubzUwYlptckp5TUh1OFZmQ3pWbk9JdnUv?=
 =?utf-8?B?RXlzRkdnRWdTT1p0ZE5tQWtHU2x0ekhWUzY5OVMzcWNDYUxBV29Cd2xPNUhJ?=
 =?utf-8?B?cGtvc1I3SVFPYWNwVDU1ZmliYjVmRVRLNS9kTUpVNDBaaUtEQy9FalYvOXZP?=
 =?utf-8?B?R2J3bEh0WE94dmF3Q1VvOEdQbjAyM3ZlTFdINnZpWmN1VXg2OHRmakNESE9p?=
 =?utf-8?B?cWtydHNBbVE4Y3ltdVNRcWVzUDhrUElBZTdPai9jdEllalBkVXI3T3JiQkNy?=
 =?utf-8?B?clI3c1ZndDFmZTVDa2M0cWVIWTBHZzFGNllKODIrWU5jbmFkVHFleW01bzdX?=
 =?utf-8?B?Sm1lOWUvNmFBUmtNUEVEZ29iZlM1MDc1Ui80Tzh4UHBwSFZPejhsZE1Uck9p?=
 =?utf-8?B?enVKUUdsSTlUdEJGWmlxd0FPS056NWpMSi9NbnowUWtnZUVieWdqejBLbDVG?=
 =?utf-8?B?QzhQMlp3SFFZanR4MGhmazFPdDBJZ3hhSTFzbjlBMC9kVW51cHBXSFNadDA3?=
 =?utf-8?B?K2lYY3hrcHQzNUxiYzlwYnJzeFNhUHlHdUlQNWYzL1F2ZktoVUNhU0VrNU0x?=
 =?utf-8?B?WUluZVBCam1WdGFBQkZ0VmJlVTRwRERtUkFqRXZmKzIvRzBmY2pSYXo4RDc1?=
 =?utf-8?B?VmdOWUFyWWxtS1BmTllUaldHSkZsY0MvcTdmd1FCTk1ueEgraE1QSnpYbXNS?=
 =?utf-8?B?RVJWUExycFljTHpYc2lGMFhQbkpLaHNOVnViUGZ1MGdlU3hMMFdCaEUxSmpx?=
 =?utf-8?B?ZlRnN01UTS9QRENiRTdDUWtjQTNRS25IWmxYVWZ0RSt4MW1CTTdmRVFqVEF6?=
 =?utf-8?B?VlJBdDBvVVdjSWtZaUgxd2IyUTNTNUxyQkJ3YjdxQ0szS3lodTlzWkd6Uit0?=
 =?utf-8?B?Y3NGc013aFZ0bzRPN2hXSDBxbUpLNGhpSVl1Q05pTXM0UHhIZWdDaHhiS1lw?=
 =?utf-8?B?bHBwSWVEcW1kemcvR1R2ZXdyU2Y4Q0ZxU0Npb3JTV2FNSGsyMmU1ZDJlY05q?=
 =?utf-8?B?QWRXcFRmME5ZWVFYNStJV2o4Ty9KQnI5NWRFZDA5VUR5UVl6N2p3VVNhdk0z?=
 =?utf-8?B?K1JtZFJ5Wks0VG5aMW5JT3dDY3J1dGwwR2tLdlRkVnNNd0VYOFc5Y21leDA4?=
 =?utf-8?B?QTVZZ3FINDBsRkh4N3pwN3pXQlh4UW1OTXFOSG9qZ1VpaUorajZuWlNSS3BP?=
 =?utf-8?B?OUZ6SXdqNEpYazQxNzBsd3lBbnFyKzV4REFwdVA4Y29SREpCK0NJRktoRXJv?=
 =?utf-8?B?MC9GT3J0M2N1WTZrOW04OFllajFaS3dpaUpEUzRMdVQ2ZUVmY1VoN3ZLdHds?=
 =?utf-8?B?WEhOVHlsT2MrR0ZuMm9YRTBIT1VyTFQyVnFuK3Zua29NcFY3eFU0Z2R0WUxP?=
 =?utf-8?B?bjFRd0JOUDJqMFZITTg4dVZHK3JtTFhVazZzakVWYmU1T0Y5UDlEWURmWkxK?=
 =?utf-8?B?a3hpSzlFRU91TkpoTkhOWEJKTXlrb1hRaGNvOTNkSkdWOGV6RHFVV2dxU0pn?=
 =?utf-8?B?b05VK2ZVbUVLamdrTlpBTGZXaXlZd3NNOEdkdUh3TER0ejNSdzloaE5PSmpY?=
 =?utf-8?B?THFqbFV3VWhzSTFlUUJoK0JWRTNJdjROTzNEYlN0VGlBT0tWdld6dmJwbVA1?=
 =?utf-8?B?V1pCUjJSc092V0tnRWMyVGxoYTdRNisyblAzY1o4WU5sUWEramR3MVArc2ln?=
 =?utf-8?B?V2JCN2pRYk9wZy9vMVlmdkxzb2ovSE1GNGVZSkFwaU9Ta1pLYmJnL1NKTlZx?=
 =?utf-8?B?cWFoUWdTWFdVUEJ6bklMd2grVkJiN2luVEFjbWVacTduVmZQK01kajcvZlAz?=
 =?utf-8?B?ZThoZFdWTEd0ekcxUFZraHZhQmpHdXhIdHdpbXZWTjYybmlmcjdXS2tGWitC?=
 =?utf-8?B?VVBIYm5PWkJDYmdwU2hBVTVXeEt2bkVQUUNWdEpjcU41eVhQUkVLQzJpQm0v?=
 =?utf-8?B?WXNsRkpjSWJvMXBJL1F6byt1a0dCa1RvaGovbFBVcXN4WW5KaFIzci9Ld2JN?=
 =?utf-8?B?K0JBSEt3eUxXYUszVXRLcWpGc0dDamtGVFRhL1k5SkhtSTRiTXpnOTNFMVVn?=
 =?utf-8?Q?i9fw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668388e8-e890-42a9-aaaf-08ddbfc587ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 15:22:06.6145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: it0+cby95UNBy1YOxCoJWkqJBgCQlLe1y1qAViU/798CeWlru6j5v3sHA7PreXSZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTAsIDIwMjUgMTA6MTcgQU0N
Cj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+Ow0KPiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz47IFBh
d2FuIEd1cHRhDQo+IDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBJbmdvIE1v
bG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUNCj4gSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51
eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFAenl0
b3IuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY2IDAyLzIxXSBjcHU6IERlZmluZSBhdHRhY2sgdmVjdG9ycw0KPg0KPiBDYXV0aW9uOiBU
aGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Bl
ciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9y
IHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFRodSwgSnVsIDEwLCAyMDI1IGF0IDAyOjAyOjU2UE0g
KzAwMDAsIEthcGxhbiwgRGF2aWQgd3JvdGU6DQo+ID4gSW50ZXJlc3RpbmcuICBJIHdvdWxkIHN1
Z2dlc3QgYSBjb21tYSBpbnN0ZWFkLCBzbyB5b3UgaGF2ZSB0aGluZ3MgbGlrZQ0KPiA+ICJtaXRp
Z2F0aW9ucz1hdXRvLG5vX3VzZXJfa2VybmVsIi4gIFRoYXQncyBzb21ld2hhdCBjb25zaXN0ZW50
IHdpdGggdGhlDQo+ID4gZXhpc3RpbmcgJ2F1dG8sbm9zbXQnIG9wdGlvbiBhcyB3ZWxsLg0KPg0K
PiBBY2ssIHNlZSBiZWxvdy4NCj4NCj4gPiBTdGlsbCB5b3Ugd291bGQgaGF2ZSBnbG9iYWwgb3B0
aW9ucyBjb21lIGZpcnN0LCBhbmQgdGhlbiB0aGUgYXR0YWNrIHZlY3Rvcg0KPiA+IG9wdGlvbnMu
ICBCdXQgc2luY2UgY29tbWFzIGFyZSBhbHJlYWR5IHVzZWQgdG8gc2VwYXJhdGUgdG9rZW5zLCB0
aGF0IHNlZW1zDQo+ID4gY2xlYW5lciB0byBtZS4NCj4gPg0KPiA+IElmIHlvdSdyZSBnb2luZyB0
byBlZGl0IHRoZSBwYXRjaCBkaXJlY3RseSwganVzdCBwbGVhc2UgcmVtZW1iZXIgdG8gdXBkYXRl
DQo+ID4gdGhlIGRvY3VtZW50YXRpb24gZmlsZSBhY2NvcmRpbmdseSB0b28uDQo+DQo+IFllYWgs
IGFuZCB0aGUgY29tbWl0IG1lc3NhZ2VzLg0KPg0KPiBUaGlzIGlzIGp1c3QgdGhlIHBhdGNoZShl
cyksIEknbGwgZ28gb3ZlciB0aGUgY29tbWl0IG1lc3NhZ2VzIHRvby4NCj4NCj4gLS0tDQo+DQo+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1bG4vYXR0YWNrX3Zl
Y3Rvcl9jb250cm9scy5yc3QNCj4gYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1bG4v
YXR0YWNrX3ZlY3Rvcl9jb250cm9scy5yc3QNCj4gaW5kZXggZWU1NmU4NDk2MTZmLi5iNGRlMTZm
NWVjNDQgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaHctdnVsbi9h
dHRhY2tfdmVjdG9yX2NvbnRyb2xzLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2h3LXZ1bG4vYXR0YWNrX3ZlY3Rvcl9jb250cm9scy5yc3QNCj4gQEAgLTEzNyw3ICsxMzcs
NyBAQCBvciBtb3JlIG9wdGlvbnMgdG8gZGlzYWJsZSB2YXJpb3VzIGF0dGFjayB2ZWN0b3JzLg0K
Pg0KPiAgRm9ybWF0Og0KPiAgICAgICAgIHwgYGBtaXRpZ2F0aW9ucz1bZ2xvYmFsXWBgDQo+IC0g
ICAgICAgfCBgYG1pdGlnYXRpb25zPVtnbG9iYWxdO1thdHRhY2sgdmVjdG9yc11gYA0KPiArICAg
ICAgIHwgYGBtaXRpZ2F0aW9ucz1bZ2xvYmFsXSxbYXR0YWNrIHZlY3RvcnNdYGANCj4NCj4gIEds
b2JhbCBvcHRpb25zOg0KPg0KPiBAQCAtMTY2LDE3ICsxNjYsMTcgQEAgdGhlIGdsb2JhbCBvcHRp
b24gaXMgbm90IHNwZWNpZmllZCwgaXQgZGVmYXVsdHMgdG8gJ2F1dG8nLg0KPiBUaGUgZ2xvYmFs
IG9wdGlvbg0KPiAgJ29mZicgaXMgZXF1aXZhbGVudCB0byBkaXNhYmxpbmcgYWxsIGF0dGFjayB2
ZWN0b3JzLg0KPg0KPiAgRXhhbXBsZXM6DQo+IC0gICAgICAgfCBgYG1pdGlnYXRpb25zPWF1dG87
bm9fdXNlcl9rZXJuZWxgYA0KPiArICAgICAgIHwgYGBtaXRpZ2F0aW9ucz1hdXRvLG5vX3VzZXJf
a2VybmVsYGANCj4NCj4gICAgICAgICBFbmFibGUgYWxsIGF0dGFjayB2ZWN0b3JzIGV4Y2VwdCB1
c2VyLXRvLWtlcm5lbC4gIFBhcnRpYWwgY3Jvc3MtdGhyZWFkDQo+ICAgICAgICAgbWl0aWdhdGlv
bnMuDQo+DQo+IC0gICAgICAgfCBgYG1pdGlnYXRpb25zPWF1dG8sbm9zbXQ7bm9fZ3Vlc3RfaG9z
dCxub19ndWVzdF9ndWVzdGBgDQo+ICsgICAgICAgfCBgYG1pdGlnYXRpb25zPWF1dG8sbm9zbXQs
bm9fZ3Vlc3RfaG9zdCxub19ndWVzdF9ndWVzdGBgDQo+DQo+ICAgICAgICAgRW5hYmxlIGFsbCBh
dHRhY2sgdmVjdG9ycyBhbmQgY3Jvc3MtdGhyZWFkIG1pdGlnYXRpb25zIGV4Y2VwdCBmb3INCj4g
ICAgICAgICBndWVzdC10by1ob3N0IGFuZCBndWVzdC10by1ndWVzdCBtaXRpZ2F0aW9ucy4NCj4N
Cj4gLSAgICAgICB8IGBgbWl0aWdhdGlvbnM9O25vX2Nyb3NzX3RocmVhZGBgDQo+ICsgICAgICAg
fCBgYG1pdGlnYXRpb25zPSxub19jcm9zc190aHJlYWRgYA0KPg0KPiAgICAgICAgIEVuYWJsZSBh
bGwgYXR0YWNrIHZlY3RvcnMgYnV0IG5vdCBjcm9zcy10aHJlYWQgbWl0aWdhdGlvbnMuDQo+DQo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvY3B1LmMgYi9rZXJuZWwvY3B1LmMNCj4gaW5kZXggYmUyNTU0
MzU2N2MwLi5jOTc2YTY2ODZkOGIgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9jcHUuYw0KPiArKysg
Yi9rZXJuZWwvY3B1LmMNCj4gQEAgLTMyNzYsOCArMzI3Niw4IEBAIHN0YXRpYyBpbnQgX19pbml0
IG1pdGlnYXRpb25zX3BhcnNlX2NtZGxpbmUoY2hhciAqYXJnKQ0KPiAgICAgICAgIGlmICghKnAp
DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4gLSAgICAgICAvKiBBdHRhY2sgdmVj
dG9yIGNvbnRyb2xzIG1heSBjb21lIGFmdGVyIGEgJzsnICovDQo+IC0gICAgICAgaWYgKCpwKysg
IT0gJzsnIHx8DQo+ICFJU19FTkFCTEVEKENPTkZJR19BUkNIX0hBU19DUFVfQVRUQUNLX1ZFQ1RP
UlMpKSB7DQo+ICsgICAgICAgLyogQXR0YWNrIHZlY3RvciBjb250cm9scyBtYXkgY29tZSBhZnRl
ciB0aGUgJywnICovDQo+ICsgICAgICAgaWYgKCpwKysgIT0gJywnIHx8DQo+ICFJU19FTkFCTEVE
KENPTkZJR19BUkNIX0hBU19DUFVfQVRUQUNLX1ZFQ1RPUlMpKSB7DQo+ICAgICAgICAgICAgICAg
ICBwcl9jcml0KCJVbnN1cHBvcnRlZCBtaXRpZ2F0aW9ucz0lcywgc3lzdGVtIG1heSBzdGlsbCBi
ZSB2dWxuZXJhYmxlXG4iLA0KPiBhcmcpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
ICAgICAgICAgfQ0KPg0KDQpZZWFoIHRoYXQgbG9va3MgZ29vZCB0byBtZS4gIEkgZGlkIHRlc3Rp
bmcgb24gdGhpcyBsb2NhbGx5IGFuZCBpdCBzZWVtZWQgdG8gd29yayBmaW5lLg0KDQpUaGFua3MN
Ci0tRGF2aWQgS2FwbGFuDQo=

