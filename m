Return-Path: <linux-kernel+bounces-879183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3834C227A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6B884EF671
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B233556F;
	Thu, 30 Oct 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FS9v5Pfr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MpWH8IO1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5F2F4A06
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861176; cv=fail; b=TiwhrYTNQkl7rRZqbC4rtbSnu/40JE0KLiQv+aXR2v3fWMwsAIolRduiYpV0hehCADOphYNxasYYxXaJvR5j9P0Q8C0AQuCn1N2VlQId2u+ZfCqDGFz/EHEjxeAEpAuH6lXlAJDWX9pvdqfZYxE6q2A7azwLD1u7CC1kPcLwTdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861176; c=relaxed/simple;
	bh=ERvdt2/Trts6B4r4F19QfleGSsE9a8t7DpjVwHlne2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j36t+KADuzU831wqGUVFji6WbaHjEWyP1hVy/p0vWlsp08W9WSsjtharhKnW0wjjjCFpqMvXjNkkM/iBYTIiNJS+YE40SGmUQLmwKvZLSGf1hr1ScrrYBXc2893Fs5ScWPVnIGxErnJ5tLcwfYHEDe0mpVzLrxd4jjpNoDfxTXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FS9v5Pfr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MpWH8IO1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UKeSN1013293;
	Thu, 30 Oct 2025 21:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ERvdt2/Trts6B4r4F19QfleGSsE9a8t7DpjVwHlne2g=; b=
	FS9v5PfrAGYp0FfFzYgQSbefoWpnAIzHa1nBNhHjkvaUHd9PlIRJyhO4WF2l5z3g
	TalAvXnVFk1BhOSg14wQXbyVYIVJVN8TxDRxjWmLJdIyjuesgCbS7TEdbC94eVHk
	uMZysUyba5EaGoSiBRPaXvHVhOoEn9qVEvqZ/Gb1mu6/A60B2icN5VLJ2Q3yG+NK
	khpb+BBxRMZmQlbmaO4rjFHOSggy1Hv01tALFScCyleQqCr9wjIBMtlTlUt8kXTK
	hioZfBiSHRQyBg19Vde/uEcVq8f408kVpeNbXQ8HWeUGfogbavdpwe1DyBzQ1QUJ
	bRLuQGLyUgSmpDc/K+i31g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4f8qr4w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:52:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UJhcxr027515;
	Thu, 30 Oct 2025 21:52:28 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q9papb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+z3GFXse8rUgAdtex2ftda7ncVIN1cGSu082btIWDkb46mSGmi3LSRqbHHwbfzkGB/1HX++LpvCIhyjlDKZbvz2rtAjQK83MctvO0urXIWphuIohTFZqOP1N5CJNWPEldAIlX7jpL/LlzG805fZwlqVruMeQUGjKbmpqq5DhtKjb5eAqNi1SJEh6K371QsJAyzR1XDI4gIGKjulL2206+A6+qpnP3IkHmpHQe7+9/2HcSsjO3DiUS12aRv90LuSofaPlO+Vu/DccZcUYMTLmWaDwSgUsTnamlk9gS0DwpaNQ3jtzWPuTCHl2dnTOEwfumcBU8W1itkdyypzITjGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERvdt2/Trts6B4r4F19QfleGSsE9a8t7DpjVwHlne2g=;
 b=AzJnogLp9ikSWudyY4bAmgULKurjZcdx6PTMANVJBDmkimVmxgXz2ODpC2O21RGIafmnImsva6vLfHOYTgOd+zfugQAg2iiO+WSxFqvZKU3K83FGymZXIGuG9gGnab284cv25UlNVSjH4f+MSVGKYemsGy1UNcbLMhLb0N2zTLVKGYwjMbqTP6/f8JKVTqprx+WFGfKVdMAxTPUGPG/+YqUOpUBJH8kHho4+nK4WdovIWgZEN1YSYJ51jJX3SDzc5lNTniVK6QSznCY4Nh27oCFspxAp2A7TppcKWeDc/6IbwqqUIuB+u8t4k6WvIwd512z89H73AZ9O9A6dR+v1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERvdt2/Trts6B4r4F19QfleGSsE9a8t7DpjVwHlne2g=;
 b=MpWH8IO1mKZsMA3W03vqQvNuz/E6JJWt7zQZgekdMCUKQFY6iJtrp3HbXV8jyRxC+WUkcp63UgAETqbvLoivDPIGFd8LRMzH7M4wEol6ezDBvq0XUJdKp7PZSPlkpQ57WczPgsPjWbhqIDtzSYgUHsDPcXAgapnj6m2wIdIyJ1Q=
Received: from CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Thu, 30 Oct
 2025 21:52:25 +0000
Received: from CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::b5ca:360f:30bd:83f5]) by CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::b5ca:360f:30bd:83f5%6]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 21:52:25 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
        Michael Jeanson
	<mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Sean Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V6 20/31] rseq: Replace the original debug implementation
Thread-Topic: [patch V6 20/31] rseq: Replace the original debug implementation
Thread-Index: AQHcSed6V6WdC7i5EEie7DnVFD0gYQ==
Date: Thu, 30 Oct 2025 21:52:25 +0000
Message-ID: <C1AC58DD-70DC-49C3-A590-2A0198AE974D@oracle.com>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.212510692@linutronix.de>
In-Reply-To: <20251027084307.212510692@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7308:EE_|DS7PR10MB5008:EE_
x-ms-office365-filtering-correlation-id: 99ac9dd7-4e8e-4a03-2d74-08de17fe9d16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVJ0NGg2eGYrMW9NdG5XbFNRNGJFeVQzWjd0ZmVyV0hCZkhpWDUzNWNXV05a?=
 =?utf-8?B?WnBhVjg0T0pUMnU3S01Sdml0UVhBWENpVm9DT1VYSEdpTk0yVVVuZUNDVzY0?=
 =?utf-8?B?Z2x4RnVSZStDN3RWMkcxZGpVdHc4Z2ZqUmhmSU1ZNFNmeHVpczJUdEd4V1Vh?=
 =?utf-8?B?MnphMjlKYWw1NXVSTjJsQUZCc3F5Q0lrVUVXSTg2T2Q0OUVobE1UUkNaUUlD?=
 =?utf-8?B?SGhyQk9EMU9oVDh4VGJhaXdoMEZHeHovbU0vdGc5SGdMczR0VEg1dWorQ1Ro?=
 =?utf-8?B?QjVERTdrd3FSY01hdUhJajFtZ25qQThaWXVyZWIwZEYzYXVDbzJMSytXT1JB?=
 =?utf-8?B?aGpCV3JTMk1xSEovd3VXb3JMbnNackk2OGNaUFI5M2lORzZSYXpMZjZNZTAy?=
 =?utf-8?B?ako0czNCd1FYTm1tZW14UkNtaVh0alZUNlcwL3JIZUw5OVlqcnhPV2lIOFhD?=
 =?utf-8?B?K3QxMG84bThYZzg4WlFXSVcyaXdKbE5LUlF3cWt1bTB6Q1M2ZFg1QnVPT2w5?=
 =?utf-8?B?LzRnbjJ0SHJSbUNJMDJ0R1psRlozb0Nhdmt3Q0lEQS9LYUlJSnp6L1FJaTJO?=
 =?utf-8?B?cUoycXVQNHNYNFkyZlhBYitydURBTEZxVUdhVXNyQ3k0a0NrNTJYb01BWlFh?=
 =?utf-8?B?L3lRTlhtdE5PbXB2cGNnc3h4UUJrazdCbmJlOGdOc2ZFcXM2MTl0eGNHU2Zx?=
 =?utf-8?B?ZnJQWkpFNmc0TDA5MUFRZ1l5ZkxycHJHVDREaDZaMXgydXIyV0MreFRZVmJW?=
 =?utf-8?B?TENQUCtDakFiTDcxY0ZQNkFObHNPUzdwNjN1bWJEL3BTV2o2ZU5qZ0FaQ1JC?=
 =?utf-8?B?MmdtYnUxM3JpRGhNQUdwNDFCdGZESjdSUGZUR1dOQlkxcDBjZFRrd0tSb0FP?=
 =?utf-8?B?NkF5Vm1BOEJoT3k1MnV3UnlUYmpZSUFPeG85SGJxZUhsOG0rZXZrd0xVWG51?=
 =?utf-8?B?WVNnUWVkQmhtQ3lrbHRoME5GYmVZRWhKc1RWdzRBSU1LNWE3M1hyUFRYeHBB?=
 =?utf-8?B?MW9uR3Y0R3AyL3grOTFqdUlKS3pCbEx0ZjVCU1V6dHhYY203QnJidCtsL25P?=
 =?utf-8?B?YjNpNW9sTzdubzhtYTBNNVVUS1VUWmF6emZRZWozL3V5R3JUYzNQWkJoZm82?=
 =?utf-8?B?VjNXQXE1QlBKZ1FqMXQ2clhQb01yVUJRN0YydUtYeVhTWWo1SzR0Vi9qOGZI?=
 =?utf-8?B?S0ZHTXhRZE1BZkw1K0JjaFNuTW5qQ2ZMTnJGMStIUkhRQ0ZFdDlSYm1QR1VE?=
 =?utf-8?B?N1Rhb1krSmxDbzUvSEcxVjN0VXcvZmpSVDhxSk0vb3g4Snd4K0NVb3loZExK?=
 =?utf-8?B?RnhRUW9IcDJqc2ZEd0R3MXRkMlU4Vk0ySkY0QXUwSXcweXpnNS9Scnp3dmVF?=
 =?utf-8?B?dHVVWjRwbHdKUEhxdW1wWnVwdmwrNXF4c0JoVXdlWlA4T3lmcU95d3luazd1?=
 =?utf-8?B?d2RVM1d3UmJrNmJLM3VDaHRZNkwvenYyVVc1MGhNZmFIZnhwc3h6YTFxaWEy?=
 =?utf-8?B?VlpxZE1CNkJpWm5ObnE0QXVzNmxRL293N3lsS0FOV1ZuTVdYeXVvYXBpZHhR?=
 =?utf-8?B?OUlibGdJQU8zS0c3UmlTYlRtSWxFNXNaODR2cXU4TWp5UXpMY2ViVnhPdXQx?=
 =?utf-8?B?Qi96R2NqdlZncC9Yd1FoNUhqUlNndEVOTlFXRzhoeTc4a2dtcFVCenlTbFI5?=
 =?utf-8?B?bXc0c2c2c1NPU1hvand1RW5qNXJKVkpiU1JoK3Rxd2kzMWwvVVZGdko2b1or?=
 =?utf-8?B?bG9GOVZNQ2lPZ2xGTWRqcTNjWWFsMjZ5R3hzRHR6ZTFkTTJCTndpamZUUTNh?=
 =?utf-8?B?bzFiQllBbzdDVEJ1enBWV0pDbWNZOGdRLzJjR3A3aTBlZGI1T01UYnhhaktG?=
 =?utf-8?B?UEVxUjNUb3hqUjdJSERjNHg0ZlpFTjlUclJSK1M5WE9PRElpMVp2TG5KeWpU?=
 =?utf-8?B?MURnTzdlaTY2b29LUjdENW0wOXR2Y1JPMjFCRW8zWVNEN2F3ZUtNVWt0aWFT?=
 =?utf-8?B?R0t1SERDYVVZVHZ0UExHN2NkN1Z2bm5GNkZCSC9vNXRpbUxvdlJNV3dRbUxx?=
 =?utf-8?Q?S8ZWTn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7308.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WENaSDNkbEdNTWtrM1psZ2xrM3NISDBsOW9mSzIxaTFCbG5qODNoelNpSVhY?=
 =?utf-8?B?UlBsOUROKzZiTHFRWk5ueVBvMUY3VGhLNXpRemo4RzY2eHFmeEw3V0RQYUQ1?=
 =?utf-8?B?MXdodDl1cFUzMGJWRWc4ai9zbmg4dVFlcHNjQzAySWkyL0FubUNJbHBtQ3hS?=
 =?utf-8?B?VlZzR0hIMWRtanVyWS9ITW1lZjlLdURrVzFDbVR2NTFwOWxERzQ3R29BWFZ2?=
 =?utf-8?B?VkRMMUNGM0lnTEM2eTY1K1BpeTVYVytSdDRFdXYzR2R0amdtZW9jNXZpcUNI?=
 =?utf-8?B?MHV5dEFZdGhxL29KMmtpZWxlWGpzYmJDdlpGQVFsN0g4Vkk5Sk5lK2xvOU52?=
 =?utf-8?B?YmdWSGc3RUh0QWVHZUNWMVNYQUhyTDdmSlo4STR4SzVFSDdkTW1JUFQ5YzNy?=
 =?utf-8?B?N3NOY2NQMXhxK0prWWJRdWZyaHl1NVZja3ZvNUdKVDQxSHNBL1ZUdStTaFJT?=
 =?utf-8?B?L1M1ei9wdkUwU2k2ZHhtYzRzaEQxZmdTZWF6VTdpaW9QSGVQQTZXME5lSkw4?=
 =?utf-8?B?Ukd4cDVIR3VtTXhUSHVVbDREOFNGVjFtT29ZV1NVaURBSnp2d2ZTdXdUT2t0?=
 =?utf-8?B?QS9lRUhtL3draHc3S0RtZHJpRC9Dc1o5bXE4cUJDQnMvTUtKdzVRelZlM2lh?=
 =?utf-8?B?Lzgwb1RpMk1oUXNtZ1VIRWJ2WHljZ3VaaUVwdGZoMDZsNkt1ZGJpOVQxdnNl?=
 =?utf-8?B?VjlUY3R0S1FPV1lWdktjaWlPQ28wSDFWMEJrT2hOeGhOUSs5dTJvMXZXV2JI?=
 =?utf-8?B?UDBlazZ0ZElLN2wwdmNZNVlwWTdicGd0UDljVmxtTDcrYWVVWlV6aDdFU1VG?=
 =?utf-8?B?Z3NIcmhrVm1RdGhyVUJWNjVrMjJBeTArSTNPR1Aya2xWOE85b21GNi8xOWlw?=
 =?utf-8?B?WnlTY2g0bmV1ZkpWREM1d2FLb2JhSFdtY2ltbW55NFRLZTltQ2pzbWhmZ1lW?=
 =?utf-8?B?R0RFclBMR2E5bkZjbUJxZ014aUcrNUtFNHViOTJ3RlpaRXNLUXgxalpvb3dy?=
 =?utf-8?B?VWxxZDEwY1pFZXJJRlpXSWdONnUyR1RNRmJmeldTUzNzUWdvRFlTM0l4d2dM?=
 =?utf-8?B?M3VOUjd1djJMaW01NFVlZytsOU4xa0thTjFiR2M3S1VsU293Qjd0Y05zYk9u?=
 =?utf-8?B?ZDZZOEhwZkMxSXFoTVhNZkJDbGNjdHlzdEhndWdhaUkxUC9aa2hJWk9xWjY3?=
 =?utf-8?B?WGF4M2xGczR2SFhxMitXUTU1TS9TcjRWUFlXSE5NTjV1V2VKZjRBTzR4ZXRX?=
 =?utf-8?B?RjJLdEJSNk9EOCtEMFJMSFlaVzFwaVM3OWJqaWhQMURRcWxza3RFbFFocTVB?=
 =?utf-8?B?MmtBMEFoeW11bmNQUnY5Z29zUUxqdDliUnFHd1Ftdm1tdzJ0eTJ3TTVXeEQ2?=
 =?utf-8?B?dTE0MG9tK0thalBhNnpuSk9JY2hNYmp5N1EraGtjeEdGbXJrOEN1SkREZ1dN?=
 =?utf-8?B?a3BBL0JLOTdNZUJDbWY4MDFtZjMzanRxQW84UEMrdVh1eXk0VlpYYncxQ0l5?=
 =?utf-8?B?ZGZ1NXZOd2VTUUNweWYzYTlMZXY0azNFMjBvK0Ywc0xlMDZ0Ri9BdzgwZUwx?=
 =?utf-8?B?bHZpMFdRZ0tUN3lOZFhrdXpxSitKbU9oVUppRHA5Njgrc0F6TW9CYzZRSFA5?=
 =?utf-8?B?RHlwYmxsWW55N0VuM2JabXNmdWgzVUp0cHFvV3I0R0k4ZS9TYzd4SXYwZE5I?=
 =?utf-8?B?Y2dEa1ROTUc1T0x0dFFhSjlmVU8xVU5JU0xXRjh2RVlsWlBUdXBaYkllMWFG?=
 =?utf-8?B?eXNEclFiODQrajlCODZuYTVDeG8rYUJzYk1zYVRQcVFoNjVoTWVodk85OERN?=
 =?utf-8?B?dmxmaGFhUVpYckI5MGRnVmRKbGtMb2xrcDhBYmYyRkx1UE5zdi9ZSGg0bDlx?=
 =?utf-8?B?RllOelBoWE8yV2hENUZEZ2c3VXJwYjB1dzlqUnEwd2I2NFZ3UmVtLzcwV09N?=
 =?utf-8?B?QWcwYTlXSERDekVBV1pUYnJQaG1DNzZpWDAvSHVsQWNsOTYyN21hQUMvSHk3?=
 =?utf-8?B?SkRWRG5nN3FIc1BEVzlmSlF4SmZNSEgrR01RL0FkZXM1d1huUEZCa2JJMzhG?=
 =?utf-8?B?dnd2NWgvQVNoZ0NldGd3STMrYjFEU3Z2WlZ4aVc2d1lHNTRsQ1U1RlZBZXkx?=
 =?utf-8?B?UFpwL2xaNmMvT1pUMEE2eGFvaXlHbmZRNFIvRUNlQk1BSVUrckJ3Z2Fma2pv?=
 =?utf-8?Q?suUR1as6SOj0s4yV+jCexyk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A1967A9C21C4E4D9B8F0288C8981D41@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nm0BPwwdoRTtBEwg1NgyJA0kzxS+Ydecw8zTi4JyT0VdvfHNf/iJwIZUnIsxtJr4pE+UpAipZibBAxzay/zrMAX4Uha6g2dMbYR0dmekFCTMf0Rzge6MbgpSVdQ7yjcuU7k8Yma9+ccEOmHJeF1wqnausxfcpFunLm+UqSEbgWTf/29DpChyasHAfaLZ7LjwvU/Wxp640jPaZTyqns1n2xDGmqLMjx122ndG8o/osr/QUl3WzT+AvBfZ0XxkP36YDeyfr3AQ1RVkwEYd8t6UX2ibENAtjZb5KOe4KyshGqKo82V2dwLnj6E3vIr+VIqRGq2cRo7yan0XHlLtfzGdG1ZIOYqA2A7HlhS4pMsOybeuZ/O5lVCYzzaq92F/dQtUOjCcsqVF0tnugjC70cpxLgN+gzeNWn9RavB0EpP+gYSgYP/acikeuii0TdcTjS+/5K+acCVfFeDVFjj/ol/rfwMRQJ9U8TRof2wRGhurHGtmeYHGsKyvZB1CPWhhwGHsjWb0rG10hV5kZz3dB3+HFqV6cvUKWPDTAyBVVJRAFzhOvDyU2YW5pLAZMY1D2dz4BLiO4wEMR8BID0heJpcbtcTKWPYGvQeYfmZqRpyUn+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7308.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ac9dd7-4e8e-4a03-2d74-08de17fe9d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 21:52:25.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZn3FN836gmItRJJYrJhlT+SpiR8gF0UD2Ke2J9IVqNK2o6ZSw8MwxvVDbuZrds9Fg7vhJ4XL/nP2MzjMC5eRAihI5z6Ho6LgU6FF5oHU+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300184
X-Proofpoint-ORIG-GUID: QjY13tTbqzgUZcdY11BarUVVcc3nYqxa
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=6903de1e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7d_E57ReAAAA:8 a=oWieMDs7_rMfLn3Y-QoA:9
 a=QEXdDO2ut3YA:10 a=jhqOcbufqs7Y1TYCrUUU:22 cc=ntf awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE3NCBTYWx0ZWRfX6nwbOsWoMOAO
 FdzO7/D7G3m0RIn0nKryaemTnkPSwhlzr2tx6ArpJk2cgPI6okV/xlw8uEgNqMnkUwe990vSlf+
 OenXe7vX1liITS1mhI4rhTq1arFcJ7asboRXIqnJHO4rEu7Aed8Me8CbankoRUT7g9GsN56+ONw
 0BCQ2hkybaxSINAxFvvorgCUi753bOjAfDxAFrAkAtwnWXhcZkkukPVSCMVYvjfmwWGOy7KqfR3
 vTMKc864Qq9sSf3j/Zo6KKrEDFwKW1eMWJZoHfaTbWcyWyhDuYn9GuJxmVjFh04QmVlcg1bQdOd
 adsT/DEzvI+T0qnPgSKe/9Wz96wx7qVpl22eUgJj7Gd3ba2GfpPvfMYsvvT7XeJH8b1T7C/erOY
 wAVsRqZ5Vp+Nk7NUmFUdp4S6yD/R1+M647BJrjsw0qYvDMDBJws=
X-Proofpoint-GUID: QjY13tTbqzgUZcdY11BarUVVcc3nYqxa

DQoNCj4gT24gT2N0IDI3LCAyMDI1LCBhdCAxOjQ14oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IEp1c3QgdXRpbGl6ZSB0aGUgbmV3IGluZnJh
c3RydWN0dXJlIGFuZCBwdXQgdGhlIG9yaWdpbmFsIG9uZSB0byByZXN0Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IFJldmlld2Vk
LWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPg0K
W+KApl0NCj4gdm9pZCByc2VxX3N5c2NhbGwoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+IHsNCj4g
LSB1bnNpZ25lZCBsb25nIGlwID0gaW5zdHJ1Y3Rpb25fcG9pbnRlcihyZWdzKTsNCj4gc3RydWN0
IHRhc2tfc3RydWN0ICp0ID0gY3VycmVudDsNCj4gLSBzdHJ1Y3QgcnNlcV9jcyByc2VxX2NzOw0K
PiArIHU2NCBjc2FkZHI7DQo+IA0KPiAtIGlmICghdC0+cnNlcS51c3JwdHIpDQo+ICsgaWYgKCF0
LT5yc2VxLmV2ZW50Lmhhc19yc2VxKQ0KPiArIHJldHVybjsNCj4gKyBpZiAoIWdldF91c2VyKGNz
YWRkciwgJnQtPnJzZXEudXNycHRyLT5yc2VxX2NzKSkNCj4gKyBnb3RvIGZhaWw7DQoNCkkgYmVs
aWV2ZSBnZXRfdXNlcigpIHdvdWxkIHJldHVybnMgbm9uIHplcm8oLUVGQVVMVCkgb24gZmFpbHVy
ZS4gIA0KTm90aWNlZCB0ZXN0IHByb2dyYW0gZGllcyB3aXRoIHNlZ3Ygd2hlbiBjb21tYW5kIGxp
bmUgcGFyYW1ldGVyIHJzZXFfZGVidWc9MSBpcyBzZXQuIA0KDQpTbywgSXQgc2hvdWxkIGJlDQog
IGlmIChnZXRfdXNlcihjc2FkZHIsICZ0LT5yc2VxLnVzcnB0ci0+cnNlcV9jcykpDQoJZ290byBm
YWlsOw0KDQotUHJha2FzaA0KPiArIGlmIChsaWtlbHkoIWNzYWRkcikpDQo+IHJldHVybjsNCj4g
LSBpZiAocnNlcV9nZXRfcnNlcV9jcyh0LCAmcnNlcV9jcykgfHwgaW5fcnNlcV9jcyhpcCwgJnJz
ZXFfY3MpKQ0KPiAtIGZvcmNlX3NpZyhTSUdTRUdWKTsNCj4gKyBpZiAodW5saWtlbHkoY3NhZGRy
ID49IFRBU0tfU0laRSkpDQo+ICsgZ290byBmYWlsOw0KPiArIGlmIChyc2VxX2RlYnVnX3VwZGF0
ZV91c2VyX2NzKHQsIHJlZ3MsIGNzYWRkcikpDQo+ICsgcmV0dXJuOw0KPiArZmFpbDoNCj4gKyBm
b3JjZV9zaWcoU0lHU0VHVik7DQo+IH0NCj4gLQ0KPiAjZW5kaWYNCj4gDQo+IC8qDQo+IA0KPiAN
Cg0K

