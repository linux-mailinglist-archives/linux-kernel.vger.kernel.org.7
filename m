Return-Path: <linux-kernel+bounces-753007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECB1B17DAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEDA5675B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5AC1DF270;
	Fri,  1 Aug 2025 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lLTxt9/t"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057E78F58
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033789; cv=fail; b=JIPtTuOU3NbaX00mVQ4qVJGR3IyQ7udMsedoNRGlaVma5+ztJyQIl2DkgneoROYCA1LABF1OAWmpfK5SRsnuz+hQcAT6Q5IVAlTrAggpElhXCbXWrD3IzmAImx//PE0pAkQZo/JUEHFGeMFeSaEULKHuE6JQZ5nMOhm2L0fXkSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033789; c=relaxed/simple;
	bh=G4t1pIfwTGGS3wFD3du2tzlV0F801R1bVMsx89BbICk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWH4zTAYgHMqFgd5Xtc/F+XqXnYld4pb/xo6Ae1AU6ksBzq8tl5nNU9sUo8mEH2PjcBSDqsUnBJgTPR7RCW/vqqq25pcb5CLQQrKYpbShyFX3g6svnwidzn5e6eVVCgUcg4U/fEAxR+Ua9TJuQrX4Z9z1SsPe6Uf+oGsmeh7QfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lLTxt9/t; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DewRz3TnMotXuzw/7iKNf3F3Dzn2hC2wwr3abUFqU00Sy4oeo2/Wd7PtrUjm71xZIfxrKm/riwpmrVetVZZHVVgi5ht/qAvdBRBcGLCO8j++TYNm/XjDVwvvExX+vHCuV/pdeyuTpEEB0C6tvBScZTGBLiNAgJTrb1+2H+yhBOi2D4JPifHCxt9ZB9aSKrw36swxXlpQm1txml6I7UK3aei8Wfuie1vgD4G3W6JQLmTvvgug9rjU1GiyPF8L7X3b88T4xoEmaNJH6qGs+lK9lkdMTf0UztocGWOt17rqyYKHfX/S52Y3iGg/MnrS33BkASxliv9v4i0a2GiUMrDmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XevVesc5wLRPbXYgRZ0WGs2XhZPUGLOPjmLAA5adRPs=;
 b=L3UeuECmBMUyNRLqLKk8b+u9FuFk8to27umrGQggWRYX7fmZSSw2d0ivFN7/PCbhNjkrJejK+s30i507ssRNlpaE95rodKcsApmeS8FiUNSQJ+izlM5ErGNBrBp3Y1iw31dE6/nyC0XYb9IvZgreNytH8j2vWobiYTU2fNQg4VHKxDj2/P4Wi0KbgI30Z+ZthyEAeP3HzdRqxmMmLCsl3yMOmi0FPNO6LAfyGzCajp9B4/pHGrLxdBsX5fKw1seQoi/SkgwLkVs6GLCoD0sn42rXnNoRpAlF4qKD2z/vvfk3/shJVBAXW5xNqOJv/MsQqWT2+nzAP4CxpvFieoe4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XevVesc5wLRPbXYgRZ0WGs2XhZPUGLOPjmLAA5adRPs=;
 b=lLTxt9/tZtMkgsp5GEXXjon1oqTRFUBKPR+Wsmmv1tZQZtm86W3mE1n2uHo5TQ+m70EHf6TtNnq5csJdAoI9xdQ6NV2DFVRmtFHPAtDGLr44+8b2wZAEogPKxWYqtc43/EnuvTcbtXk6o4+v20RFFmFS7OcoJjMD84CKwKxNDejpH80aaXKzS8Rc7c1FMlAEB2IWx23RvckiwBOM6rzvALzysO+vW9AFQFbVvePhlODr4gzjd+ydsZPd/N/SjAAHlGKiEDtlhvP9Bv0dMAdWwHx3c3UPsGA4iA/EIoZ9IbmM0EDYMUFP9bpAZkQiY5Haxdow+AWnjHwF47CFnQDpiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10)
 by PAXPR04MB8127.eurprd04.prod.outlook.com (2603:10a6:102:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 1 Aug
 2025 07:36:24 +0000
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18]) by PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 07:36:24 +0000
Message-ID: <bc268247-b081-463b-93eb-ea8eca7de75b@oss.nxp.com>
Date: Fri, 1 Aug 2025 10:36:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/20] clocksource/drivers/nxp-pit: Add NXP Automotive
 s32g2 / s32g3 support
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-21-daniel.lezcano@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20250730082725.183133-21-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::6) To PAXPR04MB8590.eurprd04.prod.outlook.com
 (2603:10a6:102:219::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8590:EE_|PAXPR04MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e53388d-8262-4a75-e433-08ddd0ce1df7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2dTTWhqdnFPaXp6TkZ1aVZ4UmJPQnYrdGtwWFk4VzBXMmVLUUQ2Z0xHd2lk?=
 =?utf-8?B?cnhLR29KRDFUZE9VQmd0WnBPVXQ5WXlLRXVscDFwTHdycDJzSzNOa2xtMGdJ?=
 =?utf-8?B?Qm4vT1lEYU1udS90K1VTLzNSZSsvTnZ4d1BYWjZ3dFRaZkxvQnlvN3RtYk4v?=
 =?utf-8?B?SEpZaXgwZnlvV0NIeXNlbWYyblNGTnhETk5SeitwQ2xHcXNjUXVKN3NpaHhn?=
 =?utf-8?B?UTI1cEp6R3ZQZjQyMWQ1WmZ1WS9JcGtPL3hqZEVtTEkxbFo2dHBuNnFJRGhu?=
 =?utf-8?B?eUgzSjRGc3V2bWFUZ2I4NFVQSTV5ejd0YlFrOXNpVXdpaG0xYjlvelFOeTlS?=
 =?utf-8?B?ekk4V2xZMUZaeGVTN0ZnUTRUckJ0akNESHV3OWVwS0xuVnRlVmN0dmZ6dkJm?=
 =?utf-8?B?RWNIbXRtY0w5cXpESGdjTXk1ODh6UzV1eEhQcXNsMnhNRSt3RWI3RFRnbjRJ?=
 =?utf-8?B?UThJOXprZHo0alpPblY4RVZ3R3l3YXByME9rbE9lcWNWZFg1RzV6VlJTdHpu?=
 =?utf-8?B?eGI1UWZ3SEdYWDd4TFZ4NlBYaSt4M0l5YlFBK0dWSGZrb3p2bHFKVW5TamR6?=
 =?utf-8?B?MXU1SHRvbkZKdWlUYVA1ME1TMmZQVW1qb1huY2VWbmRVb1FiUUN2bDZmZGZp?=
 =?utf-8?B?WjFhdy9jQ0pBQi8vMzU1b2krRUZwVWZuRzdvRTZ5SmdkWTRjTTdMeG5EVVZq?=
 =?utf-8?B?amtBd0FVTGRUNm53R3ZwVG5JNVlOM0hkeXZSWTNNSFRNZjdKUWErditlQnNI?=
 =?utf-8?B?RXFNNEZDME9GaHUxdnQ1Yi92ckZzVXFWZ2dkNWRRZW9BaHlNNGkxcnY0SFcv?=
 =?utf-8?B?UXV1K1VLcHBsWVplS05mSFBGTFpTVnhOekxWOU92TmVVM3JabDF4YTFseFBS?=
 =?utf-8?B?dXE5d2hIQlZMaGRDRDVZOXBIS1YvY1FyV1Yxdmg2a0NPUGZSbEVkZDBDNVp1?=
 =?utf-8?B?Q3lxdnpQRXY5bEY0Mjd1MUdFN09Va3A3WjVnclRqak5kWWgrVUExNUxNa2Mz?=
 =?utf-8?B?cSszUmpob0ZBb3Z6MHNOUFkzTjYvL0xSTnpFSE0zUjNOR0tWMVUyQzdUcEtE?=
 =?utf-8?B?OE80QU5pZHl0aXJXY1RhL09oanc5U242N0VqU1dXTllkM2RRNTcvMkRSY3Nm?=
 =?utf-8?B?dWZDZjV3amJiL0xxT3hDK0pxN2hBdTFBSG5idzNhaktwaU1yK3Fldnk3WFl0?=
 =?utf-8?B?emVkUEw5cC85RHY1NjVsV0NsZTJxODY5SEx5Qzc3THBNd3Z2VCtGQ0R2OEJq?=
 =?utf-8?B?RGkwSmVsai9MRnZTZDZuNTNCUUJ2emlHQ0d6UWxTT3NSUlEzbEtKR040OXRw?=
 =?utf-8?B?SU1GZWlRRlJPUWNVNGVaOURyOUdTMFlWajhNK2dleHpmWWR4NEl2NDdnVTV6?=
 =?utf-8?B?ZXNKNkx2RWlLWnRGZmFWaWkrN0d5dHRqQjhPbGZpeDl2WitnQ00wek1nWlR0?=
 =?utf-8?B?OVJZc2t1aEdiaUdXdlFWcGpQTTVGT2Z6RVVlM0l6d3F4SEY4eTNkbUFNRWVv?=
 =?utf-8?B?bzl2Yk5EMnFhOTh0NjQ2Y3Y3VVBaaFVTR1J4Z3ZtVHFZQjRhTWxBSDlmWXhC?=
 =?utf-8?B?SE5LMHZDRmlMK3JFajAvZ3REd0R1OVJydHBkQzNoYWJWMVhpd2ZBcWIyMWlV?=
 =?utf-8?B?QXZTbmFoL04zYndUdDlGako4QkkrN3lFeUxHZ25heWtXa29RT1JiejBkaUw2?=
 =?utf-8?B?Q1JrcFd0ZWhabENBOXY5N05vUW01VHBFKzlzMk1YWnhPZC9kdG9RaU9UUFEx?=
 =?utf-8?B?UGkrd1VCaE9sSXRIOVJkSVkrMlVpNk1rN25XaGYrM2xTM2R6bStNR1hEMDNa?=
 =?utf-8?B?UFp2bzFJOS9kOHdPdXBFMitsVmFQWUIvc2pXcHNlMU1aeUhqTWloSjB5Tjlp?=
 =?utf-8?B?Qk1iZndBMlkza2lsaDBMUHp1bzFVTFpYaW9pMnFOZFRuck95YVlOVmU3akxB?=
 =?utf-8?Q?6tRApvUrVaU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTlHWnl5WkxZL0hQK1hqZ01mWFE5eCtuS0RXTHJCM2ZvaERLbEdlZWN6UmF2?=
 =?utf-8?B?eFZ3TTljbjAyNmtHOFM3UWRBT2tIT01XV0lxK0lJcStlZ1VnNWJzS3dwMGZT?=
 =?utf-8?B?djVjUmNjZjVKeW1qdGkyWVhaNUlMNmQ0YlhLck5EL3M5cC9iUkhEV0tYbWVz?=
 =?utf-8?B?Nmo3eTZ4ZFdZc2pZQkVVK3BxU0lON2hVOWFEZUJVZmRVTGtTdUkzbTBhR3NH?=
 =?utf-8?B?bUxtN1RnWEdvQmRrem85STI1cytjalg5RXVhY2ZhdVdKY0sybFd0aHVSMWha?=
 =?utf-8?B?UXV0ZU1KeWZyZ0ZUa21iM29HMS92T1pMZjVPd2hpWUlmM0JydHZ3U0lZWXov?=
 =?utf-8?B?eGV2dlB6NXQ4eWlCb084K2ZxNUJSL29oMmszTVYzNnJFYnRZVVdPZEFzTDBl?=
 =?utf-8?B?cUdZL0pvN0x0NGxuVFg4Yml6UXc2S2N0ZWJ6eS80bDFEOVBCcGZCTlFUeDVw?=
 =?utf-8?B?N2ZoMWlNZmY4c1RxcUNCdXd5YWkySmcyNGUwMmFlRWljemV4dVFlYzFGQjFy?=
 =?utf-8?B?bDhLK2RobEJ0ODRpcEE0VWJyd0tOSUplNDd3VHNNbmZnQWFRQkduUE5Ddll6?=
 =?utf-8?B?Y2RrbUFHK2ZkeHBqSTVibnVZTTdTdFdXS1Q3cXMxRVQ1bEROOWtrd1o3RWFO?=
 =?utf-8?B?S0doQXF2MjdCUVg2RHlEWUdkZHRmM3RGblc5U2Nqa3U5TU9RaUVlRFNyOWt0?=
 =?utf-8?B?TGtsVnllSUpVOHA2N3gxMXE3RGUwU2FlS21sODZSSzRJL2phUXUyYUErb2U2?=
 =?utf-8?B?REVHaWNwZkhoRUtxVkpNbGFVYTNFZG9DcmJBZ2VkM1ZRMllkV1g4VWpDVW9S?=
 =?utf-8?B?bWhkZ0NPRHFiK1A5RWpqTzl6N0tMdjBUZUdlQnlTZktEMStEMEY4WUtPVnZr?=
 =?utf-8?B?TzFZOHZnRmtad3FsQ1owMFhpUmlHR0ZIdGRXYUZiVzBIV0J1TDJwOHZpQ1hv?=
 =?utf-8?B?a3NNZWRyeGQvVWlHNEtURXpRRjZkZTZFODBsZ3cyN2JhK1VMaUVrM2NXVUF2?=
 =?utf-8?B?QXpoZFlYNEFIUXVmRk51dVMxZ05NUEhUOXFYNVRDbnNXRXZpem5Yd0R0RFZj?=
 =?utf-8?B?N1VlN0F1THZqL0JUUXd1TTl1VzkwbXAwaytlMjNRUG1IbXJpYnAyeE1BYnRl?=
 =?utf-8?B?bURBZ1ZVN1g5TDR0dDE1VXYyY2RFR3VhMHhYUTFhRzZpcHk3cGQzZmFnVWFi?=
 =?utf-8?B?dURpOEtMNGU3MFNYZXVSb0NTNkVjMWMwQUUrNVZFTmhHNWNZSUtIR0FsSkQ4?=
 =?utf-8?B?ZmlXcVpjOTdrcVhSTFpDeG96UWRvem52OVhpckpjT3BiZm9wUnJxVHZTODBw?=
 =?utf-8?B?MUZVSWhrOXc0T0RBdUhUeVRGS1FMVVRocTlBRDFic3JPSG52dDQrTFQrc0N4?=
 =?utf-8?B?UCs0WXRsb005YmFUQ1RLVkNYcHhaYnhzVElsUTFGOWNyZ1JwZFFtMjI1alZ5?=
 =?utf-8?B?V29sYzZaUjJQQ0xLa292NWE3VkZYeGNWMjV0cHdhVk1NcjZNNEcxQ1hSSjhZ?=
 =?utf-8?B?R3BseHRRdGpuSnBkSGhDSkQ5blJNS3JTUEMxUlVvaGcya2hWWGJGNlYrMW02?=
 =?utf-8?B?UE56ZTJmYTF0ajRmbTFMR1NIWEFMMjludTVKMXBzbXJhR080eG9IN1E3ajRB?=
 =?utf-8?B?LzJaQ2R6czczdkgyRjVCL1kvdmt2dFBra3pKL3dCZW5VTnRSc2RXM0tISHhy?=
 =?utf-8?B?cDVDeUdnWmg3NkttaXRaQnhiZGJOd3VCRmZjaFozNWphUWlINEp3cVFvT3RW?=
 =?utf-8?B?TXQ2UGJsL0FZd1JQazBwNEFzYlhFRlAyb0lBODRIOEcxaHBsTU1jZk1GTWJa?=
 =?utf-8?B?QTFKK0NXLzFaV1FyT1BObWhicEpKZEZVS2xOMHYrQTdJSndxZE5tV05ud0ZW?=
 =?utf-8?B?RWk4L2FwdFRITlI0eGlyb2gwOEFLd3hDRXQyVmJ4R0F3QkFPdFJxOVNOSHd1?=
 =?utf-8?B?OUVoK00rbnpTVUJVTXlOUWRQdlNIbTE3dlFaYnZwZFd0MEozdXpndVgydlcy?=
 =?utf-8?B?a0Q1V28rbmkxc01hWnc2aitUeURhK0ZYUHdTbjAyb0pQaHBBbERaZDhCK0dE?=
 =?utf-8?B?alZZdjNnMC9TYmd6eVM2clIzRlM2YkU0TENFWDU0ZXBQTzR3eG93WW41QVFQ?=
 =?utf-8?B?RWJheEVWVEppSzRLRjEwMWlndmhOSHRxTjJ6OXptb3VtYmRpazhPRm0yVHhx?=
 =?utf-8?Q?xgY/ZfdYd3jBteznMi7Djzc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e53388d-8262-4a75-e433-08ddd0ce1df7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:36:24.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdMRcyzDNnFoBCDNpGp7qNRpiXvseNGOlRN/ZD4WSjijd/ftgQKEl+yUa9axeH7NExJVS8bQLiRVckUg8LFKY2/o5zlMJrJT8pb9UgnyTJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8127

On 7/30/2025 11:27 AM, Daniel Lezcano wrote:
[...]

> -static int __init pit_timer_init(struct device_node *np)
> +static int pit_timer_init(struct device_node *np)
>  {
>  	struct pit_timer *pit;
>  	struct clk *pit_clk;
> @@ -262,16 +297,31 @@ static int __init pit_timer_init(struct device_node *np)
>  
>  	clk_rate = clk_get_rate(pit_clk);
>  
> -	/* enable the pit module */
> -	pit_module_enable(timer_base);
> +	pit_module_disable(timer_base);
>  
>  	ret = pit_clocksource_init(pit, name, timer_base, clk_rate);
> -	if (ret)
> +	if (ret) {
> +		pr_err("Failed to initialize clocksource '%pOF'\n", np);
>  		goto out_pit_module_disable;
> +	}
>  
> -	ret = pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
> -	if (ret)
> +	ret = pit_clockevent_per_cpu_init(pit, name, timer_base, clk_rate, irq, pit_instances);
> +	if (ret) {
> +		pr_err("Failed to initialize clockevent '%pOF'\n", np);
>  		goto out_pit_clocksource_unregister;
> +	}
> +
> +	/* enable the pit module */
> +	pit_module_enable(timer_base);
> +
> +	pit_instances++;
> +
> +	if (pit_instances == max_pit_instances) {
> +		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "PIT timer:starting",
> +					pit_clockevent_starting_cpu, NULL);
> +		if (ret < 0)
> +			goto out_pit_clocksource_unregister;

The function 'pit_clockevent_per_cpu_init' invokes 'request_irq', but
the corresponding 'free_irq' call is missing in the cleanup path.

> +	}
>  
>  	return 0;
>  
> @@ -289,4 +339,33 @@ static int __init pit_timer_init(struct device_node *np)
>  
>  	return ret;
>  }
-- 
Regards,
Ghennadi

