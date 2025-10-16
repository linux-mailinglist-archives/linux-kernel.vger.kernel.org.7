Return-Path: <linux-kernel+bounces-856319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EBBE3DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C293357286
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA833438C;
	Thu, 16 Oct 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s9PSdaYU"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B1186284
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623592; cv=fail; b=OTT7YkUaS64rxRGjwsu1lGz1rOSU2dtteA7demgGKj2uoDu1tx8N7EwrS3eYxauekSp6v9LzZuFWRZQZvloFe+z07mX67SxAUEz+DS6/AOK/yqNwygcuwkzVUV/5ASBS5Y85GvWTjrBpEAIctrxZVa+O/wLWhJ9yZop5TMR3xJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623592; c=relaxed/simple;
	bh=+J5xNoxTXcyn5BZP2xlDiPCL+Um4WexE6pZIBMuCz1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EdNzttX7zvMB0Xsp25BwRxwI/MaYGcgz6bQusd6Voq1zoXLAylWbTchRMdZv2GxVatY2VIbO8v+yF7HH1yGU40EG+gHDrCEDWKUXs5UTIA0k4O1pIxmJ4va/+DDm1iduLzzW2mOZ8Qgljs2cSfyZ5KpXAyNFn93LEbPrdGUSqu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s9PSdaYU; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzwwjMDlrH3Y/CDplb5++hiShho/FDXAvIJpCad5mxntatrfNaxCfiCWMH5bb4Lwsz96hJpqER2tFpGO2Th4KD27oOok927skVeE+HBS7zYfd311uXGdceg6a5OXIJv5o6yvn+ZK+GLByNb5OwEVJRId2UVsKZmOwlNjK+9iuVxfvVmNMGYPxUFfuqCM/xS7vLkfVQkNzW2BWFtHkThsPiI2jtgH/Ss7QKFIEc766uv1nTcsmzesVPTJe4GIBV/J6Y67Hp7BdpqNdmNRNNhwAALNWrjo0ZH5m1U/7rHg/ay9ljytW+xDwHstrZIWpfrBMAwPjjTPZJrIM/Kr1BG4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+J5xNoxTXcyn5BZP2xlDiPCL+Um4WexE6pZIBMuCz1k=;
 b=miGQJCPT0L1YQpUH8a+iPhxgJZRhPIHBD2Y5+6cnuwnAAvOQvwyI2yPwk73YaFVmjWmW8UOf34ciWd2Xwr1XhsxYBqGu1ocQkM9Xx/MXe0uB2gmHBEEWL7zg4uZIGlAgIPRb9wAB3a7H1MZ54iuoShbJJCgv51BGCdNXAN1+oVLYTb0LIvF9YMSsCoc3wDLGPlcas7r9a2bastxFavusVxZWYRwgvUgPfbFyvBWg7MYOqAF9bhZbJbZ6PXSwISALGz6AssS2ujAUhNpVYQJBNarYOXDpxg036L8YNonvsOBfaIVnnDUYQZGzplkq2RXWdYzUCAdDb3Z3CbwIAx3zxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J5xNoxTXcyn5BZP2xlDiPCL+Um4WexE6pZIBMuCz1k=;
 b=s9PSdaYUkKFa3XHYcRgldDAH5i3KyTWWlVKSwGepDLd1FOzi2lmOvyEcVPGHexOVhrYCGbcQwEqxWyItDosyCjg/GAHNaZMwIh4Aed1T0dlc/1IwzihhnnxoEfMU6gCtfo+2Gs8+8FNx5loUnPBfD7barMBiKCSFtuYy4wLXBQQ=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 14:06:26 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 14:06:26 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Brendan Jackman <jackmanb@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
Thread-Topic: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
Thread-Index: AQHcPpv1amtigeO6Tki9uQ+/RJo2ULTEybtQ
Date: Thu, 16 Oct 2025 14:06:26 +0000
Message-ID:
 <DS0PR12MB92739B4BF6D4F35250F1B44994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-8-david.kaplan@amd.com>
 <DDJRFMTS5HX9.3MT8W88VM4U2I@google.com>
In-Reply-To: <DDJRFMTS5HX9.3MT8W88VM4U2I@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T13:47:55.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|CY8PR12MB7659:EE_
x-ms-office365-filtering-correlation-id: 74321a94-fe9e-471c-c560-08de0cbd3243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHQyVDB1YTJPSGlHTC91S1hkNlJ1UGozR1ZFYWY1OHMyRXBDWitZQVNsL2Z3?=
 =?utf-8?B?UFcrd1EwQjNKNGhMWWp0TmZoSk1XV0tFOEV1dk5wTHR3TmlzZkp3NHJkc1VT?=
 =?utf-8?B?aVV0T2lIM1VTVnJHZUo1SldlTzZWUnJjRDJwWWx6YlQ2UStGQ0ZWaUROK2Nr?=
 =?utf-8?B?TG0rWFQ2cDZnL1Q4cG9DY2hlM29wbDFCWGU1dW5vSWYrNXg1SXUrb0dVUVYx?=
 =?utf-8?B?Q0taS1g4SUNkVy9icWdGcitycnUzT0FTanVKc2ZBYkJGb3FZMWlSRUx0QW4z?=
 =?utf-8?B?a1Urb0k5NUhsVkZyaGhqTEx4YTdrWUZTcklQbFl2NytibDFaalhqOUFGWHBn?=
 =?utf-8?B?RFdabGhhNG9oOHRONllEZlZqZUJ2YlB6b1hCNEJFUTBmb2NEZFZuMktPUnRW?=
 =?utf-8?B?bmhYYk1YUFhhZWlzVXMrYmI4dlhYSWZneFMxTjBIY3BPcXJiSzNFN3BlbEFa?=
 =?utf-8?B?eFEyblE3bUQvb1JMTjdNWlI5YnJ4Z3lEUCtFRnh1UGszeDI0ejAyckd1MWor?=
 =?utf-8?B?UWVXSjdBWW15bmJ4WGRGQ08rY21wc00rUXJnOGFaeWVMMzlkTzNLUW5UM3cr?=
 =?utf-8?B?THdlcE4wTGo0YWludzBQZWozcHRQc0M0ZGdwdGZWZlZqQnNpdXZIaE00TUdj?=
 =?utf-8?B?bnp4bzB6YVUyUUVlZHFIOEJZeEYwbzYwc2ZxdVZFbXJKNTFEdmllSkdmVDJl?=
 =?utf-8?B?WHg2RVM3Z015V1A2M3F3SE5pQzFvdi82bFRiWlA3MmlEZS94endWcytkbk9j?=
 =?utf-8?B?eG9xUk92NGRmMkVCS0xudk9MVHl2OWdBZTF6cXFzVTVaYzJrN1JhRENNdTB3?=
 =?utf-8?B?c3hSRlF6NE9NdlRmZyt3S0EvT3ZQQkFja2MrUytNbHYrM25VZDQwS2xHcSt2?=
 =?utf-8?B?SWdsbFJyR215bEhiakcwTXpvSXNHQUpTZUNFZ2Z4NFRLVFI0S0pCVDR3V3JR?=
 =?utf-8?B?R24rZU5uU1lNaFh1c09ZQ1RtdjI4SnJCZVZsTmQ2bmQvZUJ2TExNeTJxdWxa?=
 =?utf-8?B?TWZEb0EwNVpkOFRzbjZRTXlOU0lYQlJ5WHlFVTMvMUQ3MDNZZW92WDdpWXF0?=
 =?utf-8?B?SUI2bmIxSllDT05tOG1LR3FWbHZrcVpQWFlFSW5qR3hiMFdyelM2V2RGM0hH?=
 =?utf-8?B?cXU5ZkliOFYybmdOM1RRODcrcG12bHNiQ2FSOFY1WTdSdDJxSzFvYm04Skk2?=
 =?utf-8?B?bUpnNkFLMXNmVUZkZ1g0NllVQnM3NXpHL1F0Zi9qaVZtcFA5VDRjTUxZODMy?=
 =?utf-8?B?WmczVTN3bG15dVJDdGJpNzdvMFF0YU9GQUhJYkVLU1p5WlpRZng2WEpiZEhY?=
 =?utf-8?B?OU4zRGJjVFBSa1ZXdzBBNUU0alB2K1Zvd01UOGJjbndYUjlyeFluRE1aRkVC?=
 =?utf-8?B?aS9BcGh6c0Ewclpna3Jhd2Y5S0E4dFI4T3VYZlhHOXFMZExjL2dMdWZaWVFz?=
 =?utf-8?B?bThxNlFtTGhDUW93N1dEU1JkRmo0bmZwY2pYNzJRSzlKRGJFT1dMTEI2QXdM?=
 =?utf-8?B?bFo4bWxTdmZTVnpqaUhNWmMxbmtqeUlIVkhhY2Ryb0tPNGVpcHdMYTR2bWxI?=
 =?utf-8?B?bHMrOXRya3NqR3FMTkV6MzMrTTFQSExEbmUvclBDQ0tJcG14MzVjbVV3RWdZ?=
 =?utf-8?B?TjNwMXZ5Y0NHTFRLSzVEY1hKVXF5cVY4SUowTTFGMkcrcHZqeVhSSkdVZzJw?=
 =?utf-8?B?WUtFaVJNdHB4RU9YUmRsQktvTFdNeG9RcFN0eDFtUTJCWEhHZWhnTi9vTkZ0?=
 =?utf-8?B?czBRbCtrdFRnR3ZqdTlDMGh5TjZWWGEwZWs4ckxPNk5rdC9wdjEvN1Fzb25Z?=
 =?utf-8?B?L0tMTzBlM0NienhJenBjRVRMU09MNzZEQjVud2Fwc0RjamFEV1lSaHVHWDVE?=
 =?utf-8?B?TEJENlo3ekhKWEZNcFBzOURSRTlIZytGOXBxSDZiOUlvRG0vcGlob011MnVX?=
 =?utf-8?B?Wjk4bGhtK0w1K0dNajI4dCtQK2hZTlNGUkV0eGwvWDJjU3hWQldERHVVcmhR?=
 =?utf-8?B?OTFYQ1JaMy9TaE41SUFNN3orWFI2QjBqTTdoNVgwNzZQN2M5MU1SVk1ENkxI?=
 =?utf-8?B?RFkxRXVLc040aUZRT3lqZG84NGJNa01FWEtSdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjF4WEtrenE3WlFQZWFRTGFyTFBuejM3NnU5dlI5NDJWenNQaW8xMTFlejJZ?=
 =?utf-8?B?T2FNUFFKOG9RZysxd1FOUzR4U2ZhTzIxNDVLclNUVi94UVl5elQxV2RPRjdj?=
 =?utf-8?B?aWR5Z2h4S3JYWWIvY3FrY3FDK3J1SURSUkpYczlxZTlZc3JiUng2YmJYTCtH?=
 =?utf-8?B?WHpTZjBYaVBIWkVTMkV0OHpWK1ZKSGpoRXJSdmdPdHJ2UWRNSlBIWndpZ3BQ?=
 =?utf-8?B?VWZBaHZ6VnpOa2lPZTI3YW5vVzA3amNVd3gwZFVLY3I1TDlsMFhob0JNZHEy?=
 =?utf-8?B?Z2lXWHJla0J2YStHMFVQNVFacldFZUpIL0VGS3licnZhU3VGWWo4QldNaGZx?=
 =?utf-8?B?UE9tb3Nqd1NuTkpPV3NlMEZ2ZEZ2TE5oQllVMGlJSEc5aE1NS3oyaWpTR3I0?=
 =?utf-8?B?ZjFuQ1J6NDYzR0t1dWV6TUNuK0dwMzBQNDd4OXJVQnlkUk1PdE4zM2luODNr?=
 =?utf-8?B?bTVyWDdQNmI0U2hnVTFDdStaN2NoOTFURU9mMTFKNXpCbndKaGYxUGdwa0JN?=
 =?utf-8?B?cVRyR1o3NDNRcGxLcTdKQnBoZG94clp2bnFNeW8zVW55bHJlc0N4aEFwNWtj?=
 =?utf-8?B?RE1taytFRWVqQ2J0dndXYmdKa3hpWWdVWkw2M3JMVXNvUnFXdHdseWp3RGtk?=
 =?utf-8?B?a0dMa1lMLzRUU3AvSDdKTzdjK1I3UVNMeUR5dnpSdm1UN0VKUmYzYjZaT2Uy?=
 =?utf-8?B?VVY4MkxSY2locmVvWFI5NFFCSmZjenhBTXNWN29aQndBNnloUW5uNGdSSzFP?=
 =?utf-8?B?N01BdnJ0ZFRvWlNNSVJoRG82UU9aNEpGVE1ROGdtd3dxcGFYVElCT2xFNDNy?=
 =?utf-8?B?akhvdW1oaFV2bkNhTjVxU2g4THB5ajhKdnZoVTliR2pJUGpSUXkybk40bXov?=
 =?utf-8?B?V3VESVVNai9PMnFYLzA2YW9udkJEMWZSUGFPcmxPTWdHd2F5SkNKVjVlM1By?=
 =?utf-8?B?WThZOVU5bzU4RGoyYkwyTjV0STRsdTFpVXNQRzNSbyt0SGNFdlpFNEhaRVVZ?=
 =?utf-8?B?RHdYTGhKWW00Z1ovVEVNN2VxNTlZckE1TENnakRGSHBiVmRCdFZGQXZDNHZY?=
 =?utf-8?B?Q3hWek5KQTh3bDhnSVlYU2RRQlI5WUc3Y0hweS9pZ05wUXNUNlZMSS9vQ2Iz?=
 =?utf-8?B?aGNFaWhNRTd1L1pHMU04ZGJMTk53bFFlSi9NQ0lXUlk4Nm1IUmJJYndtczIy?=
 =?utf-8?B?MjQrOHNyZC9IdUpGbVB4UjBERjRGVUowQUQ0TlpKSUNsZGRBbVAyUldFR1hK?=
 =?utf-8?B?NWxlcmVzU0dlS09XejZJT2cyNFExZXpXY1NoUWRTQVFYb2JYbkZMQlMxL0hH?=
 =?utf-8?B?cGlyQ25YVkM3OFpob0xVeXVIUk40dy9lakU0SzhHdTJGZ3lpWkZUdmdHMDVB?=
 =?utf-8?B?ejVNYVNJSWpDNlJBTFdPb2F6N3BQbHRKcjN0NE90N2kvZlhSd2RXWmdPWEx5?=
 =?utf-8?B?ZTBCTTg5Yi9LRzIvMUUzbDgzbVB3L2djeUdPK3N5eGNPWnF6YW9xaGxIV05D?=
 =?utf-8?B?cWpXMW5zc2FJaGppVHRabkdOUnB2YUtSdXdJTWEweDV3VXBpQnR5OVpCUlNS?=
 =?utf-8?B?MXMyTThNK3VIdVUxbGROeW5waFNjV2Jva1RNOE1aZDZSN0U1akl2Y2xxSjd1?=
 =?utf-8?B?OXNBdWFSYnhacE53dGZTQ3U2S0FVSFpxWE4wR1RqRitXVXNJRGFzenB4N0Fl?=
 =?utf-8?B?Q2xqZW1XdHZxdkx5ZmtmZlhGS1F1aThMOUd2MVN1YjhkSlkzQ2lvMkJhRWVY?=
 =?utf-8?B?NU5FM2l6a3h6SVpGTldtdEgrYUtUZE9VeTJydTlmcmhONFRYam5FKzMzdTEv?=
 =?utf-8?B?T0lmZ0xUNEsrZXh5bEttZjB3MkRpYkdRUmJaQ3haT2ZMUE5mS1VtRUxLOGxE?=
 =?utf-8?B?c1AxdG9Yb3ZieUFObDd6OFhUZWZvTnVaSjM3dUtuQXJ0TzIxTU5zbmlNZlRQ?=
 =?utf-8?B?QXFDS1JzdWJxRGRYL0hpdWRVZTczazVReCtBWS8yVEMvTTNGdjFaTTgrVlNv?=
 =?utf-8?B?OUN1MlFiUDNFMEpoZjd6Mko2bHlYY1dIKzVRUmYzRlpyd29nT0hnMjl2dFlT?=
 =?utf-8?B?REllKzRQQkc3N3R3VUFwN24xb0MvcnE3ZFVWVXpFWXEvNTBISVUrVTIrSzhq?=
 =?utf-8?Q?VqBo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74321a94-fe9e-471c-c560-08de0cbd3243
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 14:06:26.4806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdFCd2OfoEKsaIuU5Mn+oxlxcenRG0ME18J7ck1L6YmePJlconvQFbiACJIf65kE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEphY2ttYW4g
PGphY2ttYW5iQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1
IDc6NTQgQU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgVGhv
bWFzIEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT47IFBldGVyIFppamxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpv
c2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3YW4gR3VwdGENCj4gPHBhd2Fu
Lmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQu
Y29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IHg4NkBr
ZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRvci5jb20+DQo+IENjOiBBbGV4
YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5v
c3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtSRkMgUEFUQ0ggMDcvNTZdIHg4Ni9idWdzOiBSZXNldCBzcGVjdHJlX3YyX3Vz
ZXIgbWl0aWdhdGlvbnMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJv
bSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcg
YXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBN
b24gT2N0IDEzLCAyMDI1IGF0IDI6MzMgUE0gVVRDLCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4g
QWRkIGZ1bmN0aW9uIHRvIHJlc2V0IHNwZWN0cmVfdjJfdXNlciBtaXRpZ2F0aW9ucyBiYWNrIHRv
IHRoZWlyIGJvb3QtdGltZQ0KPiA+IGRlZmF1bHRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBsYW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94
ODYva2VybmVsL2NwdS9idWdzLmMgfCAxMyArKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2Vy
bmVsL2NwdS9idWdzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYw0KPiA+IGluZGV4IDFm
NTZjY2I1ZjY0MS4uNGNhNDZmNThlMzg0IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvYnVncy5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gPiBA
QCAtMjA1Niw2ICsyMDU2LDE4IEBAIHN0YXRpYyB2b2lkIF9faW5pdA0KPiBzcGVjdHJlX3YyX3Vz
ZXJfYXBwbHlfbWl0aWdhdGlvbih2b2lkKQ0KPiA+ICAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4g
KyNpZmRlZiBDT05GSUdfRFlOQU1JQ19NSVRJR0FUSU9OUw0KPiA+ICtzdGF0aWMgdm9pZCBzcGVj
dHJlX3YyX3VzZXJfcmVzZXRfbWl0aWdhdGlvbih2b2lkKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3Rh
dGljX2JyYW5jaF9kaXNhYmxlKCZzd2l0Y2hfdmNwdV9pYnBiKTsNCj4gPiArICAgICBzdGF0aWNf
YnJhbmNoX2Rpc2FibGUoJnN3aXRjaF9tbV9hbHdheXNfaWJwYik7DQo+ID4gKyAgICAgc3RhdGlj
X2JyYW5jaF9kaXNhYmxlKCZzd2l0Y2hfbW1fY29uZF9pYnBiKTsNCj4gPiArICAgICBzcGVjdHJl
X3YyX3VzZXJfc3RpYnAgPSBTUEVDVFJFX1YyX1VTRVJfTk9ORTsNCj4gPiArICAgICBzcGVjdHJl
X3YyX3VzZXJfaWJwYiA9IFNQRUNUUkVfVjJfVVNFUl9OT05FOw0KPiA+ICsgICAgIHNwZWN0cmVf
djJfdXNlcl9jbWQgPSBTUEVDVFJFX1YyX1VTRVJfQ01EX0FVVE87DQo+ID4gK30NCj4gPiArI2Vu
ZGlmDQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHNwZWN0cmVfdjJfc3Ry
aW5nc1tdID0gew0KPiA+ICAgICAgIFtTUEVDVFJFX1YyX05PTkVdICAgICAgICAgICAgICAgICAg
ICAgICA9ICJWdWxuZXJhYmxlIiwNCj4gPiAgICAgICBbU1BFQ1RSRV9WMl9SRVRQT0xJTkVdICAg
ICAgICAgICAgICAgICAgPSAiTWl0aWdhdGlvbjogUmV0cG9saW5lcyIsDQo+ID4gQEAgLTM4NDQs
NSArMzg1Niw2IEBAIHZvaWQgYXJjaF9jcHVfcmVzZXRfbWl0aWdhdGlvbnModm9pZCkNCj4gPiAg
ICAgICBzcGVjdHJlX3YxX3Jlc2V0X21pdGlnYXRpb24oKTsNCj4gPiAgICAgICBzcGVjdHJlX3Yy
X3Jlc2V0X21pdGlnYXRpb24oKTsNCj4gPiAgICAgICByZXRibGVlZF9yZXNldF9taXRpZ2F0aW9u
KCk7DQo+ID4gKyAgICAgc3BlY3RyZV92Ml91c2VyX3Jlc2V0X21pdGlnYXRpb24oKTsNCj4gPiAg
fQ0KPiA+ICAjZW5kaWYNCj4NCj4gSSB0aGluayB0aGlzIG1pZ2h0IGJlIGZhaWxpbmcgdG8gYWNj
b3VudCBmb3IgdGFzayBzdGF0ZT8gRS5nLiBpZiBhDQo+IHVzZXIgYm9vdHMgd2l0aCBzcGVjdHJl
X3YyPW9mZiB0aGVuIHdlIGlnbm9yZSB0aGUgUFJfU1BFQ19ESVNBQkxFIGNhbGxzDQo+IHRoYXQg
d291bGQgZW5hYmxlIElCUEItb24tY29udGV4dC1zd2l0Y2ggZm9yIHRoYXQgdGFzay4gVGhlbiBp
ZiB0aGV5DQo+IGVuYWJsZSBpdCB2aWEgdGhpcyBkeW5hbWljIGludGVyZmFjZSB0aGV5IHByb2Jh
Ymx5IGV4cGVjdCB0aGVpcg0KPiBQUl9TUEVDX0RJU0FCTEUgdG8gdGFrZSBlZmZlY3QgcmV0cm9h
Y3RpdmVseS4gSSBkb24ndCB0aGluayBpdCB3aWxsIHdpdGgNCj4gdGhlIGN1cnJlbnQgY29kZSwg
ZG8gSSBoYXZlIHRoYXQgcmlnaHQ/DQoNCklmIEknbSByZWFkaW5nIHRoZSBsb2dpYyBjb3JyZWN0
LCBpZiBhIHByb2Nlc3MgdHJpZXMgdG8gZG8gUFJfU1BFQ19ESVNBQkxFIHNheSBmb3IgaW5kaXJl
Y3RzIGJ1dCBzcGVjdHJlX3YyX3VzZXI9b2ZmIHRoZW4gdGhleSdsbCBnZXQgLUVQRVJNLCBzbyB3
ZSBkb24ndCBpZ25vcmUgaXQuDQoNCkJ1dCB0aGVyZSBjb3VsZCBiZSBhIGNhc2Ugd2hlcmUgc3Bl
Y3RyZV92Mj1vbiAoYWthIGZvcmNlKSwgd2hlbiBQUl9TUEVDX0RJU0FCTEUgZG9lcyBnZXQgaWdu
b3JlZC4gIEFuZCB0aGVuIGlmIHNwZWN0cmVfdjIgaXMgY2hhbmdlZCB0byBzb21ldGhpbmcgZWxz
ZSBsaWtlIHByY3RsIHRoZW4gdGhlIHJlbGV2YW50IHRhc2sgZmxhZ3Mgd2VyZW4ndCBzZXQuDQoN
Ck5vdCBzdXJlIHRoZSBiZXN0IHdheSB0byBoYW5kbGUgdGhpcy4uLmV2ZW4gaWYgd2Ugd2VyZSB0
byBhbHdheXMgc2V0IHRoZSB0YXNrIGZsYWdzIGluIHRoaXMgY2FzZSwgdGhlcmUgY291bGQgYmUg
b3RoZXIgY2FzZXMgd2hlcmUgdGhlIHByb2Nlc3MgbWlnaHQgdGhpbmsgaXQgY291bGQgc2V0IHRo
aXMgZmxhZyBhbmQgdGhlbiBnZXQgc3VycHJpc2VkIHdpdGggYW4gLUVQRVJNLiAgT3BlbiB0byBp
ZGVhcyBoZXJlLg0KDQotLURhdmlkIEthcGxhbg0K

