Return-Path: <linux-kernel+bounces-882729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2290C2B41C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DA23A4CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A030103F;
	Mon,  3 Nov 2025 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0aIypJpo"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF13002D1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168165; cv=fail; b=fCeC8QxElQ0nQ9oNuqatke763FTDEAXxgYFo6Apx787ei81XDIwaUISuIhrYsuT4KK7X9uwa5vJJpSwar8kudC8e2ePyv+hscWu53ZYMjelbtLCSCQvsEMWl60dLU2V7gW8oa2ue6Ev7RZDQDkQBXZm+gyiSKA2O5LhRb8bYl/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168165; c=relaxed/simple;
	bh=JjS82cSS8jf1HupxxYZIruLjwIi9363U/oVDwgi8uko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BFlnCKTiWKlrWISXFPfzb9rYwpKaZqahL44Pjnw52Vt71SaNwuzZTp8B7gf3JXbzeXwjvqqMG4E5ENvHDZ1ioLBnFu19PBcmAOStWCuDolxAER5KqbNvjWjgKVbcUarJfvL954fpn1ZiLuEOrKv+qDVVsw01gGWxMB+k6+0qXLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0aIypJpo; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddJwhaHkienuPB727rR1nFCx6VXt5y/cbsiEYikZGnZo7Nyp3tlhtPopY+VNBCoEazupoLZVoX6/1ASttnOxSBYevNEZ08geuo1IkScmP8S/QhaQr5SdCRBpbyazPwXD0z+i4wjcCti8E26cHRYRo+8rvHEXBaZf/ZK/aURrocSNh00uITJ31GaDvX/+1CY8da91L9TYTITTgtAgz/fgC1Jjos/CCcdyzYxY+CjYabDqGaXrcZpYTcgAwqka7xV0lYOLxGIYfazEN15l+pzMMOAcZRUh9dWh866khFEmrKA2B7UdvnpIT9Rju7G608HXce1KUcZIEHhFYxvcm/KYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxdIE9R9kQZef5YHv0MBS1T2g9WP4Ankv+dLZ24BPaw=;
 b=FCSDpk8SBxMZfNQeaPIDImVXIT9Caq89BnFy53k0g33CF5EdL9Oumakj25qX+o3ojDo7Ps2wM7KI6dy0msUU71cU7lC9Q3wjivo1XPupb8bRX/p8aPN73tplWNA/87ErfGnxanZtaI+lpN0WH9gMtog9Oua16TEwCLqQZcvL78yV9fpfB8fvtJ5K6aw+vDHCGh1R5Ej4dNJqBQc7w683/vGXUJ50uqNdVszemYnSgT/puTDK2cWtZDE2XoS7KJ+Y1JARpYANWE067DrciOMCKIHG0k00KvX0v2huBQt5qsyq0DeenFCjbvpzud19/UZJqx8W7Ag7Mn8Vr2H4EMmMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxdIE9R9kQZef5YHv0MBS1T2g9WP4Ankv+dLZ24BPaw=;
 b=0aIypJpokDPo1zv0TsVGd+x2YmsgA49cg1lll713PAoKzjBKE9/ucRk1VRbMpMN6ETYNgfvsAS2mu9i9m9W+hhUPZAnrrJpyl39X6EGjQUAYYrHlJRYx9NpHw+hEqIHypfbvkv+ZSdG6h9hMRmc8rmKzH6ye0i8v23FE6lquOTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 11:09:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 11:09:21 +0000
Message-ID: <e3b8e670-313d-44b0-b026-f92252d71662@amd.com>
Date: Mon, 3 Nov 2025 12:09:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] platform/raspberrypi: vchiq-mmal: Avoid use of bool
 in structures
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
 <20251031-b4-vc-sm-cma-v1-1-0dd5c0ec3f5c@ideasonboard.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251031-b4-vc-sm-cma-v1-1-0dd5c0ec3f5c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0799.namprd03.prod.outlook.com
 (2603:10b6:408:13f::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: f1df520d-daa1-48d9-9f94-08de1ac9704a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2R6Umh2WU5HM3hrVE5QQkJYcnVVOHludUg1M3Rva3ZHc0gvQU1HbXNJMHFn?=
 =?utf-8?B?UFJWRHpCdHNNVDJwUjd3TEpPejhEOXdvYjNTQURkRXo4NGVVQ3E0ZGlIZDM0?=
 =?utf-8?B?cVR2NG1LajlKQldZSEtaWmNPcVlFclVRZzh5NUxFU0dhSkllQm9IRGxNTE9s?=
 =?utf-8?B?aXMwdnRqZTI1SUVHS2NyZVBDMCtzTlEyeGczZm8ydDRDV0ZWQUlFTUorcmp5?=
 =?utf-8?B?VmJOdWtrazFtQ3doVmRlTGZ2U0JEb3Nrd0dabmxJL1pmQldjdzFOOGpqaks5?=
 =?utf-8?B?VzhwemMrWjZvaHNJTU44WGJyUmtJdGY4Y0FMQXQxZ0NldWdoNzF0ZGZwcHF4?=
 =?utf-8?B?S0FoaG1EWFdWSXpiNzJyTEJnOWxEcjFEY1JpbWRNZjEwc0l3Z3lzNW1sZXJS?=
 =?utf-8?B?ZndpYWt2RjcyQ29JckZDcnhhRmZXWDRBWW93VFozYkVKaFlwc1ZWNkFhQ1h1?=
 =?utf-8?B?bE5KZmZrM01uYTh2U3gySGdobHB6aFNtZmc3ZFdqblF6WEdFOEV0SzJRMUdV?=
 =?utf-8?B?WnV6ZStiNnBWeHM1ekM1R0xEZDBRc3JPSW90R0lHdFNSOWRmeGttY1NPMkVm?=
 =?utf-8?B?Z2lYSmd2NGgxempjZ05HNkdNRHlOc0dhRlVFNVJtT1F6VnhPT2h2QjRUWEFh?=
 =?utf-8?B?WkVvMFlJVlh4OVQ3TkdJTmU3SjZjdFVETGlVS0lXY0ZqT0Z5ZWt5KzUrc3N6?=
 =?utf-8?B?cHdXb1JhUmNCazFYVlVpbndWaFdzUENtd1o5Y2ExOVlXWnh5cWd4RTNSUThv?=
 =?utf-8?B?VEIxNE1FZThTK3lPd3dET2lFNHhtL25QTHhWYmNzeHIwZWg5VzNGRE4raE9q?=
 =?utf-8?B?WVFmZnFUV2V4QzZwMDNhS2xHTkRUbW1RcU5Dci9rY2FXR3dqY3dqYlF0eFlv?=
 =?utf-8?B?a2E1eGJ3cFhydXRsdThEdGgrRVprOGhBc1o5cCtsZEFoQnJMSkpGN1c1Wmhn?=
 =?utf-8?B?NXl4eG1kMXB3NTdXeTVXZUtEWlNTdmNScXhOOEZOcXdGU2FSS2xGakQwK3Jq?=
 =?utf-8?B?ZXB0ZmY4RDl2TGhsSUY4Rm1uZmRDTDBVKzZpa1k1Wm9nUkJ4ZEpyVmFSKzB3?=
 =?utf-8?B?VmJNNHJlQnAzNUtwWnA0TXBybFhUK0ZJWk5QUVluN3V2K1BvbHJIYWdyQ1hq?=
 =?utf-8?B?S2kyemZTblhkVnd4THQ0b2wzaEk0WXhlNnhPdFdsT0EzakZJZDE4d2NHQmFC?=
 =?utf-8?B?eERVdDZDbjBNMXYrdk1lYVNpbm1EWk5pVlMzek5FcmtieVRPY0lveW83ZXpO?=
 =?utf-8?B?SGtuR2hYS0VNUTYwa2pZeEJxN3d0VDRZSktlY1hxa3ArdUdzdkJ5cUljSkNT?=
 =?utf-8?B?alZ3eXBSbStVYUFnajFmYlQrcUNqYmhHL0FCbWhRZzQ2TTVPNkYwM2JXZ1dm?=
 =?utf-8?B?amtFSTZMSC9XbkExWFRaMUMwdUtJcVhKVERNWkJvdENDQmNJTm5qNDhuSC9l?=
 =?utf-8?B?SzZTaG03dU5EUER6QkpVSjY3YXdvblVqODdjUUs3MlFuRWdSQTNBY3A4clJ0?=
 =?utf-8?B?cGE2cnhSWjQvVjMzK3JqNzlXbGpEcjR6ZW1uQ0JqWkxkVGd2azVNekI0cFUx?=
 =?utf-8?B?ZXU2eEViRGh5aFlDYkN0SXloNS9FeDBiMHhwUVMvR0s1dlkweEhtTzBLUmlk?=
 =?utf-8?B?c1dxUUpMbjluVUFMYkJCcGdOMDJnVERlQ2hIeTV3M01MRlJaUG9iNmdUWlFU?=
 =?utf-8?B?aFBDUGFRMVloV0RLemMrSzdqQUcxcjVXdkEzU3VBNS9WNTNUTkdEejRZa1V6?=
 =?utf-8?B?dG9oYWtvRU84aTlWalQvbjZUa0hKeTRBejIvSDgyaTAxdk5jQ25Ta3g2cmVV?=
 =?utf-8?B?bCtjS3pOMGJ5bnB3WjNadjZ4QnhHaHF6WmRvcmloaEgrc1M3MC94SlB3YXhQ?=
 =?utf-8?B?bDlWQ3pMZzR6cTl1TkZBczVwM1BOZ3VTaHlCSkdybmdqM091YkxZVnJnYUpt?=
 =?utf-8?Q?S73CLfcULd6Vl8SR0ahrdULcm9qqCz97?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJobkltY2t2bXZkMXE3djNwbENvZWVxSGtLTWorckVSSGxZUzlzNlFtdWVM?=
 =?utf-8?B?MmxHa3QvTldtd2hCMmNZaUUzb3hKNWNCWk9SVU9ueW54a1oya2hzcC9kYmov?=
 =?utf-8?B?UDQ1b2NzQTBEc2EvbEVaV3VDV1FjZWRrMDQ3QXhaeHZrWTQwRk5BQnVHMng1?=
 =?utf-8?B?eEgremVEZ0ZZdW1XK3R1dE1mSlpGQ3c3Rm9XeHorTjdlRWxvR0dsVDR5cnFH?=
 =?utf-8?B?dnJyc1BCb2Yyb0tUL21aTitDejhLSnJ6bnVIczdtWlBkTWF5bitSemF5aW8w?=
 =?utf-8?B?cVVtNTg0dFVDZ3lHQzVxN0hSc21zYW9ZKzFDNkF5T0dsZTh3S2hsOVpUMUlY?=
 =?utf-8?B?YkRDNnBXbDBTTEVlUWhmSjlMWWQraTFTZ0FhK2pSejZpdEduN2hCRy9xdEZL?=
 =?utf-8?B?Ui9CQTErcjgwS2J2NFlzUHdvYWUvSUg2YTVrdkpsVCsvN0RtNDVEVjFVbWUz?=
 =?utf-8?B?OGpJWS9wUUpSTU5jVWJHMnY0YzhoRXpIemRETnZhTlhqUGRNcW0rZzZURXYy?=
 =?utf-8?B?VFo3NGthM1VkdFVhbFMvTUhlV0ZPVnd5bVNrR1daTnNhbGh4UVZOYStJeHlB?=
 =?utf-8?B?RndpNGZTTmwyWUtQc0s0T0FQb3RXVVZmUVhyd0tHTzRZQkVGT1Z3TXY0a2RB?=
 =?utf-8?B?R3UxOTZoNlVJZzlmNWRxL3N4b21sNzlnM2hMbVFUYU1URTlFakpUbXEwdjRB?=
 =?utf-8?B?SWdEeUVNb3dIT25LWGtQNDVHV0dCUk0wQlVaLzlyUlY1SWFBK050M2RRU2Zy?=
 =?utf-8?B?WlpnOXlPVnE2aUhSbitmMFVVZEdoWWpTQW9GWW5OQ1hvcWxqQlFLeHlDSks1?=
 =?utf-8?B?bjRCaUprdklwYjNhUVNtWmJMSzdyWTVxZXJmdTh3NFFjL0k3OXVMcHVKS3Jq?=
 =?utf-8?B?UU5wNnNsMzl4RnhNcCtLRGJIK283dVA1Sjl0ZE9leUtmdTVZNXRDZlRqc3lp?=
 =?utf-8?B?N0EvQ3JVZ1VQSENwREJ3T0tKdE84aW5WR2JZZldTVDNSbFVMczM5cVcrb3pM?=
 =?utf-8?B?YjJHYlJ4SzJkTDBFeVZhVzgrS1R6R3BRY3BKek85dk5nazdEMUlSR1hSL3kz?=
 =?utf-8?B?VjV4R0xXWlMwajBDUXYrelNRdS9nSkJ3TTlKMHR1RmxBQkt5STA1emYvMjZD?=
 =?utf-8?B?U0xWV1VnYUJBVWU2SURSd01IampCeWJtYkZTcFA2MzllM043WU1Vd2NFSllk?=
 =?utf-8?B?bkN2eisySWd4L1c3UVJzSFE3RVlWWGF4QmFnOFpXUWtPMWhIcE5lenNScyty?=
 =?utf-8?B?c0gwM2dnNXdXcitKa2xib3lNK29USHhJaXUwUlhMcnNrV2YyeXdxRGY4eDN6?=
 =?utf-8?B?bGx3REJ6YlFqOWtPRWRPZUdCQ1hrR2IyU3NFRHduQUpQLzlqaWVZYjRmRUZN?=
 =?utf-8?B?TVd6b2Y5b0NZMUs0YlVleGFGNmV5anNHVmdmNXFoYWtST3I3cVE3SlFpZzl6?=
 =?utf-8?B?SXFkaUl4QkhRL2dUWXNwWjhueXZPcE43QjJoS29pVktWc3ppdHB5RCtsL05K?=
 =?utf-8?B?ak1SbHFJa2hPRUNYWisvU1F4SlpmRVVSVkFaZ2l4TFhYekZSeW5ncjY5UkdL?=
 =?utf-8?B?WiswR2RDUFM3L242bTgwUy92OFRXWUlKeGcydjJXZGlTQnlaT1RQeFJQQkJp?=
 =?utf-8?B?cEIxK0YySlVJK2FNQkV1VDVmQTMrcFVwc2YyYWhPTituUStjWVB6dnlmalBS?=
 =?utf-8?B?NjNOcldzR3pKdnhsNzhhQ3U3Y2UwSWtERXVGTWhXMDR1RWdhNWUvclpYN0tt?=
 =?utf-8?B?SmczSW5EaUZnUENYWjJxdmFNbzRhRWM0Qk9BQy9UQ2hxVGtRbE9xZDRrZkRx?=
 =?utf-8?B?YUdNV0drTGVFM0k2eEVyNXg2SzRya3plcXl3OG5xNThCRlV2cWJRNW5ka3N0?=
 =?utf-8?B?QzJQeWtEQlhwelNsN0Y2S0cwb0VBVmNwRS9RQzIzQ0dOY0dJZVFEWVpOakVp?=
 =?utf-8?B?YmxscTIxK1FsOEh3VTB1dDdwTVFJWS9DQ0RYSEZuVDFIdUNEQStRMWFpb2dB?=
 =?utf-8?B?Q0lvVlRkWGlZNDZ6blYvSEVxeld4cG94cG1SSTEvUU9JbkUyUkhwdE80aHZG?=
 =?utf-8?B?dm04QXJkME5rbEdhOWNmT0FWNFUxUzlMLy9yaFJZV1M5T1VIbGFBT1lUd05q?=
 =?utf-8?Q?vs8nImAqsdL6aFCv2AkhPBHpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1df520d-daa1-48d9-9f94-08de1ac9704a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 11:09:21.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RCTGsDa1zhxw6wDaZa1BPp9Mr+gh6Bg9lDBR7468NrXSpPLlMm3ljDy7flR1P0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

On 10/31/25 18:27, Jai Luthra wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> 
> Fixes up a checkpatch error "Avoid using bool structure members
> because of possible alignment issues".

Mhm, at least of hand that doesn't looks correct to me.

What exactly is the checkpatch.pl error or warning message you get?

Regards,
Christian.

> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
>  drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> index cd073ed3ea2dd9c45b137f1a32e236e520b7b320..82c2c261fd9cf0669cbd2ca7c814e0703317885a 100644
> --- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> @@ -1776,7 +1776,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
>  
>  	ret = enable_component(instance, component);
>  	if (ret == 0)
> -		component->enabled = true;
> +		component->enabled = 1;
>  
>  	mutex_unlock(&instance->vchiq_mutex);
>  
> 


