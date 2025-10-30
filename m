Return-Path: <linux-kernel+bounces-879255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8CC22A67
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD3A188C9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B733B96C;
	Thu, 30 Oct 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="SM1nK793"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4526FD9A;
	Thu, 30 Oct 2025 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865709; cv=fail; b=IODUz19P4Hz2kyGyu2Di4VdN89/oC/6WBkgZVqQFOQxmeVZ0s+UovAzotoq8VoJRh59TmnfI4zRxY4TSiOhIDP0w8wWKmama87Orp8NT24V7rWfzkDq22UwsSXR1XUD/hQFKCs6Y4gysa0u8dpX/Xkbb/A3Gkm36ge1FxrM5lKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865709; c=relaxed/simple;
	bh=pRyyu1gt55cf0tgPxk5PzoDdFcEVs9PTw6V1y2cil84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWOO+euhHyPLb8WHjjOy4pBT5sU+VAAGNRRybbg6kp2ZTt+3+zclmHoaxN6bwUxTHaIwVVssxsJPwhOXrRnW13j/pMStlwe3k9GfGW1jS2Aka6ilGriC3aDVIWlLf1WQS2qLhQwjylCmWKItWHYbmA+L3aCvwb6y/Q6fNI2aDo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=SM1nK793; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiR//RD0czlvJhgt862vn25PKzBhvo7jSygLg1Xlx89lw1s2VX3urrFbLU3WjHREXvuCN5OfW7NH5sDpyfMPZSIebbyehxecVYlBvrgnevoLK9Kkqud7JhP0FIekkVart8916ormoDyYX1i4TdjjUEvTYLhMrqqtxH0A+XgBH2yaenakG0JygzLQg/PhjDGRElsOuEUwbWMUnKNXZmrsMEDkxkN9YqGpjEGbGUserm/NP4VNOGU3+QAJZ8sSXkIxvoans/OQqa3xR7s+I8+xsjGAVwFb93jgTmcAWYztqjWSkSUkKuAM7c5LlR7dvMxFk9o0rCLXq0L/OIRqLd6DHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRyyu1gt55cf0tgPxk5PzoDdFcEVs9PTw6V1y2cil84=;
 b=AdflQX37/7BTJDzIcNI1LKMhkLw8JENB3afcONzBN8QN3HTGeJa+7btDDEqmpKi2zZk635cRUNDva+O5xK7McDN08mqqFF22JCDnAYLxmlH50pFSEqOtZoD0DHv684OTuQncEHwBnB5GIVXBFznbiA89yzk7XVMxHOK5uY+xwzSuttdZQT7c7PojdrbaAPm3gRrlqREScJNJunXLD8iD96hxJ9/JmvXfeddUk4Ic7wSCcrPi2T8+rDDOwjsuin7W+gLvKg0/ZzfJ7guy/SH02BWX7G6d8R4sold++JQ4Rv728owBjXa6yKbSsdVcP3rtH1/q3EoEUZpSQ/3ztJgsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRyyu1gt55cf0tgPxk5PzoDdFcEVs9PTw6V1y2cil84=;
 b=SM1nK793JNjD56js7GEDugq4G7AUrx0dBbElnv7obc/ZDZMK2XqyemAGaHYggvFUk4Y+9W3kEW3V6sfym27Ni4hoT8S69ro6+l61a0ymtQi4C9PeM8/fl9wNULjK5BmjT1nqykpxZ7GiP9oo8c2iIhEhh0C+BVzJXo7lOmB1hn5eNEJpIWfp1DGMhzC0lybZXMHQkKS25ecI5ZSHpKRf9qcgKei3oO5mXyGXDoAiOmmS6ZQvzyAWHumNSTQpcrjuGqCPU4SV1AtLutaY2JqI+XhWd8kJHLZjsYt+8P33KD3aHMRHUl2DIJUAWtcy/hYAJ8C0c0pq1onPXswJZjh4RA==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ2PR03MB7042.namprd03.prod.outlook.com (2603:10b6:a03:4af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 23:08:25 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 23:08:25 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value
 for Agilex5
Thread-Topic: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value
 for Agilex5
Thread-Index: AQHcSU2Jtha/h7K0JUijtynbkn4VWLTaU1KAgAA8rACAAFMugIAAbmaA
Date: Thu, 30 Oct 2025 23:08:25 +0000
Message-ID: <eef97a92-40ea-429d-8bc4-6fb22f05d2a7@altera.com>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
 <08cacb9328c338edb6a6f291c56c6d2c32a9e0cb.1761648711.git.khairul.anuar.romli@altera.com>
 <20251030-wakeful-hospitable-eagle-9dfca1@kuoka>
 <6b3cb11d-afbd-4242-b215-a3a0230cffb8@altera.com>
 <32c35bd4-fc49-428c-9204-a39bda7cef19@kernel.org>
In-Reply-To: <32c35bd4-fc49-428c-9204-a39bda7cef19@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SJ2PR03MB7042:EE_
x-ms-office365-filtering-correlation-id: abc23186-d183-443a-1adb-08de18093aac
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R05NWTNVamJmUThKYjBWeW5ER3Y4VDIxYnB4b3FOQ3RDTmMxQ3hnRkZOTkdD?=
 =?utf-8?B?WkxXTUJMN2hUSzlDUjFndG81elVGNUlES2dxRFhxTEU4Lzk0N1BtUC9UYkln?=
 =?utf-8?B?SVlCK3lSN2t1eDJvVW12cmVzZWpaajdUWGRLRkZZSzV0QnRuU0ZKdEpWaVBn?=
 =?utf-8?B?dUFCUDR2NWJUZ3R1VjU4eWR1SGRLdFBSekFXY05KNXcwYk8xeDdBYUJxbXA2?=
 =?utf-8?B?NXd2UFZrNzltK2lDT3UrZUgweXV1L3djZXIweHQ3K1ZxcVQxeThoRzZ2bUhs?=
 =?utf-8?B?dkkrMlFSc2lSMElDWGlWQWd2emVTeDdiUE1FOWZTZ2w4dUt2QmhGQWsvNmNZ?=
 =?utf-8?B?SC9pMU1BbmFrMmkreVZOY2x5Sng0Y21CUEVobXlrZWdjaG1TU2tNS2YrajlE?=
 =?utf-8?B?YW5HVm1PNERjL3hXMmNUWStCZFNvSmxzVnNKMVZXZW0xbExtOTRQYzJNSGQx?=
 =?utf-8?B?RjZadnl6am1EdFduVVpwYWJMQnVZNHN1YTFKNUZwd0Rkc1A1bjlSSlBFZk8v?=
 =?utf-8?B?d0RLYkM0bHNGZ21MWHhLZDJ2Y21RNlNXaitTQlhTdTBHRkRMYzZTcWdlUmxm?=
 =?utf-8?B?ejB6cUYybGhWejRaenN2aGVrMmVGVFJBQ011ZEsxR21GQmRMbmxwdTV2THp5?=
 =?utf-8?B?THJrNndDSFVkWWVSR2Q3T05KQlBOcUFER09yK1pZWmxaL3lCTkFoNWk1dzhB?=
 =?utf-8?B?WUtzUjB0eU8yVlV3WHBLdCt3cmhBMzQ1UzdIMkVjc2YraVZrV1BWQ0k5NjNC?=
 =?utf-8?B?M1o4SDMvWGhqZ3Vid205V1o4MHBaUWtka2FkTWRNOGttbk5pWm5aRmx0QUdL?=
 =?utf-8?B?cDJkUnBseHNGMDg3cElobEJ0SGVVbHR5N0tpZzhrVUFIWlcwM1hLZzZaMVBS?=
 =?utf-8?B?WE5aS2lpZzBGR3pjT1Mzd1R2bU5RUnVOVW5MRGlTaG15RlRDVXJ1ZmJuODFM?=
 =?utf-8?B?RnlqMDdNWkwrSXRVRVgwbWREeW5qVkhTM05Ba0Y3eU8vazhsNi9UYzN3bFVE?=
 =?utf-8?B?RVpqMXUrZndJdll3d1RqUW9yeEl2cDRJYmo3QzF2TEU2d1BTdFRyRVh2SkR0?=
 =?utf-8?B?NytkbGd0Y0w5ZXhJVlNBREhGUmZObmVyak5mZ0pGeC9Wd09zNHFQNktpU3BB?=
 =?utf-8?B?N2RZcDJHVGpOeWcra0FVbnFqZDZMN3B1aHpFWlVVcFBWNzIzbkdHdEx0cE15?=
 =?utf-8?B?bmV3eGxFREo5TC9DbUk5N3dYT3R4YkdhVWJkbEdtVFVROUlVSEZ4Uy9odDd1?=
 =?utf-8?B?M1BLRGMxZm9JMXZKOVVhMzFVdlRyWVh3MjdXbTJSc2cwMFBtSmMzaEFxR3M5?=
 =?utf-8?B?WGZZdDBWNU16cXhiZHgvUVF6Zm5hamRGREVPL20vZFZ3VmhrMC9kTDA3SHpz?=
 =?utf-8?B?NGpZK0swMkNoUVhxOHEwQURsMFhjbnViMDlFYTlUZG5SVUYyZEtKblNUTCto?=
 =?utf-8?B?SUdDZzhSWjVkU1JBUGY4dzZOT3BXUzNjUW0rUE1BL0loNHVOZlNyMjg4dVU1?=
 =?utf-8?B?d1o3UG04TW53Z3cxK2l1RWk3dnFqT3VlN1BLajZlUU1tUndHSDY3c01WR3g1?=
 =?utf-8?B?UloraEtqMGQvREQvQWJ2clV5eEV2OXJpN2FJWTROdHVYcm4wQndJMFJUR0NQ?=
 =?utf-8?B?SHozMVM4RVZHaVYrQksvS2FWMnh3QllSMmpQUDJ1ZUZySVNxNE9IdWF1Wnk0?=
 =?utf-8?B?OGgySXg2cHhkNHhFODVhcU9RQWtacVY0Y2YyU0gzNmR5ckNMK1BGb1VMMk8x?=
 =?utf-8?B?MmdGSFkxSnh4Z2VDT1hoLzUzUkRTMTgyUnNCVEVCYmt4djk1ZG1yWnVKVFRz?=
 =?utf-8?B?dkxJaHZVeDE1NzQ2UVYxdis2dXFtcjlLWEgxUHpldEU2M1BScWp0TExOOWQx?=
 =?utf-8?B?eUtJeFpPVEcvV0dSQnNPbk9tMW1oVVlpaURtUWN5c09HZG1HMHR6VzYrT3Vn?=
 =?utf-8?B?ZlhaaHorVWxaa1pyNUhFWFhrbzkvWHRaa0xFVkFZejkxZGJ4ZW0vY2t0VG8x?=
 =?utf-8?B?TS94Vm5pc1BRVVUySlA3TjZYQy95ZFlxZGF4RCtaZ0VCQ3I0UUFBcDFLK1Yr?=
 =?utf-8?Q?wysfFN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckhuaXRiQm1GNmpDZDRScHV4ZVRYZHdqdE5qY0JERW1KQlZvOEdBdEpWWmZq?=
 =?utf-8?B?NEFkL3hCY3dJZmdFZy9PK2RpeVVrcUpURVFYenowaFJnMW1SNitsMWJLVHNI?=
 =?utf-8?B?djlqV0lpd3oxQXFoL1B6Zk9Ia29UcXI4aXhsNWNJcHA2SlovVDBhaTd1Nzgw?=
 =?utf-8?B?U1BKemlGbkh0L29DVEdsUTVJVytMa1ZnVC9mSitZazJzZEc0Rm5EVWk2Z2Jw?=
 =?utf-8?B?eldVNDZ4bGJjSzFic1hlL3JqdnlqZ2wyNFFIQ1A1SDVwYzY2TTNHNWlLMXdM?=
 =?utf-8?B?MXNWb1o4Tkxydkx3N3dqVnN4ekhYRTJMQUV5SGVUa01RMGtHWmV3d240U2Mw?=
 =?utf-8?B?NWVERFc4bm5lUW13a1p5YXovNXVsTHpmVGxQL0RmN1lnN1ZGQjRKZ3JJNnVm?=
 =?utf-8?B?S1F4Y2kxZzB3a0JWTUtXeTYyMFNzUElCbXZubS95VW9OTU1EeTBhV0gxbHZq?=
 =?utf-8?B?d0pQbGRLU2dzT0M4WFg2M0tFN2hGcVV1MExyT3ZocVlCZ3pBL1lyb1NMUG5a?=
 =?utf-8?B?QXNXN0U4Q2p0OEpMUDNLelVWVzZEY2pMRElZdTBCMzRmdURoOVU0MHR4aGRE?=
 =?utf-8?B?TkkyVmI3MVg5cVM3M3d5cjRsS0lPTjVPSnlEejFyZHNzUEZFSTZTUm5ua2ZJ?=
 =?utf-8?B?SEtjN25DN285Z0tyaXMvenlhT0hDbmZaK2ZXbGRNc29CM05ZdE5reElybEN1?=
 =?utf-8?B?dHhjeVpPc3EzcVQ0TC9WMmh4OVhtaHJjNlJNUzJmeU1Ock9xZlUycWdUa2RE?=
 =?utf-8?B?ZmoydFZ0eG56RVY5VDBOSlEvMi9tZVlwNGpiUVo3L2xQSWszNHBPT21XN1k4?=
 =?utf-8?B?RlMyZDl6RDZmQVd0ZEViQjlMOUNSbEMwamZKbjNVSEhLZXcrVCtBR1gwcmp0?=
 =?utf-8?B?cm5oZHhzUFlDOXdac1lYK0sxREdJWEduZ1M3YSs5Y1QvWjhIRmdQSmRDZDF0?=
 =?utf-8?B?NGV0ZXh3Wm9sNGZwRmkzOVVBYjFnWmJKeXpvZTM3VlFhUnV2WGUyUmszRHlT?=
 =?utf-8?B?bVo3K3p5eUgxWkVHamVrUlBONjJHSVZCWk1QY2hDTTF2SDdEYWFSNm9iRDRT?=
 =?utf-8?B?YXdPSXRabWJJRjVYSm5XUmMwVkJDdnlPQ0txemV3bTdKcjBkMk45ZVpvdkZr?=
 =?utf-8?B?SmQ4SE1FL1R5ZkNRSEdSQ24zNUczTjFzWjY0TFJ2SGpLT2hMcE1VYjV2TkZE?=
 =?utf-8?B?cWVjaFRPUGtXYVZNY3BrNlg1Nkp3d3Z1YWpvSUthRTZwV2R5czR5ckpjcnhm?=
 =?utf-8?B?MlNRRjdJMmcvYkNQRWd4Sy9XdmJNTFJ0a3FMSkc0Nm1LK2ZwQkhhN2k0U2hi?=
 =?utf-8?B?MnlpREl4UWNWalNkc3JxNFlQU2MrU0g1REpXWFh5TFpaMEs5b2cvdEpxRDFt?=
 =?utf-8?B?SmxNbWhtSEh3RXlLZzczZ3dvdVczdXhoWW51OHR0RG9hMXU1eEtzNVRyY0RC?=
 =?utf-8?B?b09FdU5NL2FVR2R3dDR1MVRxWW9KMGNPZU9oNG1TNXBMYTF3Wm1LdWYxOWRR?=
 =?utf-8?B?Y05FZE10WTcwSUUxWjlJTEJUbVZSOE44MzdHdkp3YVN4OEMvRkJ2aytNeHFn?=
 =?utf-8?B?R2JkNk0vNUxHeHpQaXAzb3pjOHltOWR0KzlnUXY1TnhYNHdjc3ZUSy9ETEly?=
 =?utf-8?B?cW1rUDdNdjhHU0ZHMStQbm9va0JTVUdZdkwveGdDNHIzdWc1V0ZKVStEZE5y?=
 =?utf-8?B?OEVwNTYvOUhwV294ZWJFUTAxMENKWk9oYW1YUTA2WUFPRkhrYmFDZFUyT0Mz?=
 =?utf-8?B?MWNXOXdhOGx1UE5aUU0rS1BjblgyVlR3WStlNHhLNldHU2Jia2FsY01rMXkr?=
 =?utf-8?B?R0dXOHQ5dEZJcEtnNXhYdlptMnZoVDYrR2JOM1BhYzhHZThLNzhOQnZ4ay9N?=
 =?utf-8?B?OGJWc0NTb3RpblFlbURRZ0w5ZmJUY2IrelFSMUNBNGMyZS8yZXFQN0kwWndz?=
 =?utf-8?B?eXhzdGFuc05WMFlWZHNxQWRpTXg3VW9xbHpqRzJQQ2FGTHVQRUdoUFZvdGZC?=
 =?utf-8?B?UmplOUVBc3lXTjh6SUZtSHdJV2NET3o3VUNhclZ5dmVHbzkzYnkyT3dFMlg1?=
 =?utf-8?B?REhKT0l6aWxFeHVDdzJYaXJjN1NuWDFrODZ5Nk5pd3U2bnBPZE9qWjYvRG5R?=
 =?utf-8?B?UUU0ZEhPWWZPTTdqZGk5c3RQV0oxVmtDZE51MmVPcXRSUGVFRUZtZjA5TFJo?=
 =?utf-8?Q?IKyqKpBna5QNN4mLxExwxGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADBA574555222F43AB7D59632E1869A3@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abc23186-d183-443a-1adb-08de18093aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 23:08:25.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7M8uTJ7ZuoNYcfXxgIAjzhIoRReTopZwPq+4C+Z0ywSwlpr/PBOPN8XBTX9cwubz/K9zI0uIPFHQFyYLlo7bxgY/Qhc4K4Zgr61Wl/Fh6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7042

T24gMzEvMTAvMjAyNSAxMjozMyBhbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24g
MzAvMTAvMjAyNSAxMjozNSwgUm9tbGksIEtoYWlydWwgQW51YXIgd3JvdGU6DQo+PiBPbiAzMC8x
MC8yMDI1IDM6NTggcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gT24gVGh1LCBP
Y3QgMzAsIDIwMjUgYXQgMTE6MzA6MDlBTSArMDgwMCwgS2hhaXJ1bCBBbnVhciBSb21saSB3cm90
ZToNCj4+Pj4gQWRkIHRoZSBjb21wYXRpYmxlIHByb3BlcnR5IHZhbHVlIHNvIHdlIGNhbiByZXVz
ZSBJbnRlbCBTdHJhdGl4MTANCj4+Pj4gU2VydmljZSBMYXllciBkcml2ZXIgb24gSW50ZWwgQWdp
bGV4NSBTb0MgcGxhdGZvcm0uDQo+Pj4+DQo+Pj4+IFRoaXMgYWRkaXRpb24gaXMgYW4gaW5pdGlh
bCBBZ2lsZXg1IHNlcnZpY2UgbGF5ZXIgZHJpdmVyIGVuYWJsZW1lbnQgdGhhdA0KPj4+PiB3aWxs
IGludm9sdmUgYWRkaW5nIElPTU1VIGNoYW5nZXMgaW4gdGhlIGZ1dHVyZS4NCj4+Pg0KPj4+IEhl
aCwgeW91ciBiaW5kaW5ncyBzYWlkIG5vdyB0aGVyZSBpcyBubyBpb21tdS4gQ2FuIHlvdSBwbGVh
c2UgcmVhZA0KPj4+IHdyaXRpbmcgYmluZGluZ3MgYmVmb3JlIHlvdSBwb3N0IG5leHQgdmVyc2lv
bj8NCj4+Pg0KPj4+IEJlc3QgcmVnYXJkcywNCj4+PiBLcnp5c3p0b2YNCj4+Pg0KPj4gSSB3YXMg
ZXhjbHVkaW5nIHRoZSBpb21tdSBpbiB0aGUgY3VycmVudCBwYXRjaCBzZXJpZXMsIG5vdCB0aGF0
IEkgbWVhbnQNCj4+IHRoZXJlIGlzIG5vIGlvbW11LiBJdCB3YXMgbWVhbnQgZm9yIHRoZSBmdXR1
cmUgcGF0Y2hlcyB0aGF0IHdpbGwgaW5jbHVkZQ0KPiANCj4gUmVhZCB5b3VyIGJpbmRpbmdzIGFn
YWluLiBUaGV5IGNsZWFybHkgZG8gbm90IGxpc3QgSU9NTVUsIG1lYW5pbmcgdGhlcmUNCj4gaXMg
bm8gSU9NTVUuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpJIHdpbGwgYWRk
IHRoYXQgaW4gdGhlIG5leHQgcmV2aXNpb24gYWxzbyBhZnRlciBnb2luZyB0aHJvdWdoIA0KaHR0
cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3dyaXRpbmctYmluZGluZ3MucnN0DQoNCk9uZSBxdWVzdGlvbiwgaWYgdGhlIHByb3BlcnR5IG9u
bHkgbWVhbnQgZm9yIGEgc3BlY2lmaWMgY29tcGF0aWJsZSwgZG8gDQp5b3UgYWNjZXB0IHRoZSBs
b2dpY2FsICJpZiIgc3RhdGVtZW50IHRvIGVuc3VyZSB0aGF0IHRoZSBwcm9wZXJ0eSBvbmx5IA0K
Zm9yIHNwZWNpZmljIGRldmljZSBidXQgbm90IG90aGVycz8NCg0KVGhhbmtzLg0KDQpCZXN0IFJl
Z2FyZHMsDQpLaGFpcnVsDQo=

