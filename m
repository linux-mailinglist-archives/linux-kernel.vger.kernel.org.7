Return-Path: <linux-kernel+bounces-855358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA59BE0FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75F019C7BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8C3164AF;
	Wed, 15 Oct 2025 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UjLzXnNx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KdLqUvaw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C353164A9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569663; cv=fail; b=an5Hh7S5U66GnyjFfuS/YMD/nYo0dQ/+fS+bfq/dfGUn8xuqaywvdy39TsvxQeHXy6ejN/QMAPsqLz3RyvJwxK+MiH0J2pwe0LZ9D4/0XpF0hOQA3FBRdB0LyNfNb230fFsTAd7Nkkc3ttOrOk+ldSIf77OsGmlJSzWAs7880c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569663; c=relaxed/simple;
	bh=70XbP2gEUdHtDgbjYITa0dka8ykDfBaUvJQ9sFT1bIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WoDM7MWq0hqLi52s7NtmKQ2nuIkvBBk8psT3gwAjM71MOAk3UwXi0cc7DnyfVWlv3EV3QKA+VtcGyz2c5e3DChy+17+jrsxoWwCKYm9ZlfzJGEOVKNO7F3ecN4ODlWRGK7VB9tuI+9y0JsliyR1VrOO8FC1nsJruzlNN9PH8f10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UjLzXnNx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KdLqUvaw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJxI0Q020105;
	Wed, 15 Oct 2025 23:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lnLXYgA6AlFLJdksKLSKP7tIH3xo35stjhFDJX9/7T0=; b=
	UjLzXnNxTT4Fsek3+FTX8VORBIwtJRTotIhqiX36NWnYUqNMG+RmHvXkGnx8h0mc
	hrkd4bDRJdrmKEGIgAF/ydMwfHg4KDBXPAaiOLztbfztOwR/ZvivEGDY5T6AdfXl
	9sOZ8z3/+Z1mHIxQPGLbHdbBElWlpEyytYHOS/lI0SnjwGiQTxrWn4ysa2v16Srn
	VPhwwaHRb3PCQwwnriLhSmV6u0pRe+PWejInubfM2hHwRjsUI4VWaXHVDsifAVLh
	AnaqddMrBir5mqYNgd610W31fE/Kh9w6S+jISV1oyzfQjGm9Dw9df2uT8Qq5WoGF
	4Zx1o5QAdk28XwyrWNww2w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtyqpy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 23:07:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59FKvGYK038371;
	Wed, 15 Oct 2025 23:07:03 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpgysrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 23:07:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/ox3p/XyCgNhFOIF86KrI8/lbaNI4/wYZ2s0qVXvSDdkrAPZjCv2kRSgfGoC+Rt617bDlFJAwRIa5LhmMjhZ0/YiSLPTl53xdutehPI5QSaRmlYsTFHUAmY6HzilYQLY5PbF61O9pOoK2xm+MiM/gZHHsF5sGTNoSDIzRGTITFm7vTFG0fUc8quTNt+qz4/eBsCL00/ZuxGHGNr3LFtH7tO7+1DJiDuNOVWQB3UODIqnZTf60a5ShluhqmcYIYGhBgfsJTUcXcEYdty/VNnJHYGrjd9Slie1Rqn0V3tUCG/xTA3pbvqKG9EDddMR6uTZs9MK4oagYdl7fzQQIdnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnLXYgA6AlFLJdksKLSKP7tIH3xo35stjhFDJX9/7T0=;
 b=TsElDAovpXANcTRm7+TFkxuWxYlNFS8Uc5RB5E2uQkwPuSV/4QfRq82ZgZAGZjVSYVmVwZa3AgUfbI7v2eF8X8brwj96qGLCnVYODodcd7Z5sidqzBpOk+Y2034lPM7VGWpTA1/B/qXOGZfoLmWU7AO26kJ59OApBFXH7HjVbVab/y5+UnD52Mq9GTZxkIXpJNk5fqZ9Q/Lhm9sV+UqUdIOvTZGEtDC9OdRmNQFEwX0jqMrL5Mp4Zf6jcZIyRkV0ygIVio2um72z5XUemMT+VPBqSAoTOt0k15gb1OBpz7CjnNNkPhsFQYbi4HkDqLzv+I83LFEXk3g4V39nlHj6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnLXYgA6AlFLJdksKLSKP7tIH3xo35stjhFDJX9/7T0=;
 b=KdLqUvawIVh1ZrUmHkFs2bEC9c20NRyGGmrgKEy5LQ6N+PL8w1L/6zb2VVaewYZmYrtRK0yFjUralPeNmN80//K2qBVcGtXEQypHM7b/AmCJGYUtARpqz25U8Ss0HDVKiDv6FTdiNYkxX7tCC5JJH90HrJ3y4b0t9qcqs6yaWgI=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 23:06:59 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e%6]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 23:06:59 +0000
Message-ID: <e8da975e-25d0-4ae0-9b95-45eea1f49a12@oracle.com>
Date: Wed, 15 Oct 2025 19:06:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
To: "Kaplan, David" <David.Kaplan@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Graf <graf@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <bjgjmijirueqwwmuen5dr6v7yqdcivk6kwa6gbukn3rodfcwko@fb5yxyqycena>
 <LV3PR12MB9265D0A464C2F597219A7B1294EBA@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Language: en-US
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <LV3PR12MB9265D0A464C2F597219A7B1294EBA@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::8) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|MN2PR10MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbd772d-e2b1-4a4b-65dc-08de0c3f8b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzFsZm92QVJya3hSMjQyMHhmb3ZHNDN5bUNkTjNBOEpPZS9Obkc0bUN6VWZW?=
 =?utf-8?B?ZGVxY1o0RkUvOHVSZ1RFQkZKNUlqeVByM25ETEZsTnNHMnBLaW9XUU1neGM1?=
 =?utf-8?B?ZlpZU0g3OUtGNG5qVnlBUUxXMnUrVi9OVjFEVEdvbTB0V0M3V2libFByd0l1?=
 =?utf-8?B?c2NRSkFkY1R4cFpCcXUzdjl0eUw3WFJoMUNYRHVacnl0QytORm9XVWk2dUdM?=
 =?utf-8?B?U1IxeW1NYzM1TWFiNFVOcldnTjZnQU1qOEI5aytaM0pEZU9ta0VhTldXampX?=
 =?utf-8?B?L0pjWDEvM2ZXaTdRZnlCM0JBNXQ5MzZGTmFoTGQycy82Vmt2bGF0Y0N1aE5a?=
 =?utf-8?B?WkF4OVZRaW1PSmYvSHZMOXNOeHl5TVJFSW5LVGlKbzNPQWtjSVYxekw5TnFX?=
 =?utf-8?B?TmpTUDhmeUdhd1ZZckwrV0JLREFjVDZnTkdUWmpGQ3pqMkdRckV2VG0xak04?=
 =?utf-8?B?SlZQVVBON0cwbjZIMXRBbmpnTFFqdy8xRG1NSHowSmhTSm5FMWtvVlF1a21x?=
 =?utf-8?B?OFpPK21DcmNHcm95U2oxaDY1WGtEWWwwblQ2K1ozNGpMMFBDL1J4L3hzaFlI?=
 =?utf-8?B?SzBlVzVyUktGUXhPNERrOVRWaFVPRzN3OGxYcEU1eFIxcmhUblRrelRsRFdr?=
 =?utf-8?B?U0JIQzVvNjZDamtzVDBsV1gwelFDbkNqU3NsZG5USS85U0tZTlBGekRBclQw?=
 =?utf-8?B?UFF6dXFMY0RYL3lvQXl0aWFWNm1aN0I0VmxNL2I1Lys2NTJIcHRuZndUUE5O?=
 =?utf-8?B?MlljNHN5Zy9mMmxVSWdzOUNyS1BKUDZIZ2kvdllMNHYxbklrVk83dGliZ25D?=
 =?utf-8?B?NmJoOUFObEt0REltUDVNZ3doOVZ2TktwSTNMWEVxMkRWcnlzUGxsZjE3S0lB?=
 =?utf-8?B?aVdMaWtDSnM3ZXlvT1hLaVJsYVRVdDRDNEVCalFlaE02V0NZa2ozdW1FWEM4?=
 =?utf-8?B?ZytXQTZtUHRCaEE2UERXS1R3TDBKV0UwWmdFcDNvUC85TDhIRTUrS1VnN1BS?=
 =?utf-8?B?Sk1mUiswOHl5RVJoQ3lCVTdrYkZMejF6RUJRR0dMT2Fxcm1INlBCWEY1dU9M?=
 =?utf-8?B?WmFFR1FZR0tSMG5yUE1KMDNieG9yenpLcWVXQStVVUo0ajQ0WFNBd015VUMr?=
 =?utf-8?B?ZXFNZ3c0MnJYbVFpUC9ITy9KbXZqTTBkMXp6RFd5bE1wMnVRcVVkWWdWemNS?=
 =?utf-8?B?Wlk3Y2JXTjBFcUVJbnEyZWgxU01LcjdmZUlEMjhnb3NOVjhzc1dNVXRqdTBa?=
 =?utf-8?B?TVdySnFySGsyNlNVRWVDdVhta0hQalozS1RxNS9iYmVFYmd4TUo2VW9jM1BZ?=
 =?utf-8?B?TkdzVDVqYXBnVTlJL2d0WGhheWFFa24rU2Z6M1E0Tm1EYWdBMWdjT2NxRE4r?=
 =?utf-8?B?bzNsenRySjQ2VUloam5LcVcyZ3NiSnJ3cDRTQ3BQdVZxQUlmRWhFRDFaMjQ0?=
 =?utf-8?B?cUt6cm1aWGV5b01yZGwydE9NUVJ3eUNtdzV0UldLZTNmOW0wSVVVaDRLcS9y?=
 =?utf-8?B?d21USVh3RkpUVWRCTElvdjhMMmMxc3N6cHYvSnB1UnhpRlVVRTAxR2ZENTJX?=
 =?utf-8?B?MWg4U2daZ0Rmd1dscDVBSjlWZ1pDbWpXRUw2K3VYbERweU9wbUVHbVhDdXVt?=
 =?utf-8?B?d3BFZkpBSzVTaVV4MGs4TjU1T2tIV3NyMEJxbitrMmZFR0JHRDJDRytSbGdh?=
 =?utf-8?B?ZzBKMUswVGlKWDdJajZ2c0h5SW1aODhOcEEvSHNIU0N6SE9paFNiSHcxUkY3?=
 =?utf-8?B?SE51QlhodTd4QWlVS1MzMmQ5Y2VEYjE1c0VFVzA2QlFlYy9WWFI0eEFLeHpv?=
 =?utf-8?B?WGprb1p5dFROc1pNV3A5MTQ4L3VxVE9vdTUwZEM2Q1FUTjVOMWJKZjU1YUgy?=
 =?utf-8?B?MWZYWXY0QXNoTE1kM2UzQldaV2NGM0VLOUp2cHl0SVRBc3I3K0ZqMnVxR3NJ?=
 =?utf-8?Q?JIQUdsOF9iFkN8DiPsyNboiqq7yr9VD0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFBQMVB6YzVZb3g0TzFBbFhxRGlNZ1JwSDd5YUlieDlkdy9kN2R3bXIxdFdD?=
 =?utf-8?B?dU00d0RpeWFJa1llSkxTQUxoaEp0akwyQnkvOUJUZnlwSmFIaVZBb2Z3bGVa?=
 =?utf-8?B?UUJsUHhZeUpNYStPUFlsR3VQTS9KL2FjWGlLeUpmc1dqRE15di9PMjBRUGlJ?=
 =?utf-8?B?elFyMGJnMnF3cDBWV0tjbEhHalp1SlVSTytrRnFOYkFaRjdyNzM1cG1jME5H?=
 =?utf-8?B?aTJTenZ6TDJCQ1JieFdEajlLTU1YTXczOWRXVWoyREVUSlppdEp4YUJOcnI5?=
 =?utf-8?B?ajlGcG5ZL1IrOEpIN0F5VWJHNW5aaFljWGpueEZFNmM5OGlsK1JUYnArZXAv?=
 =?utf-8?B?SFZBT3lJTEJnOFQvM2xVMnRTNGt1S0FVK1JvcnI4ViszTkdEWVRLTC9Tcmxr?=
 =?utf-8?B?UklieWpsZ2dDM1I3d2ZZdXBWcG1nUzRCWlRybnFpL09rTFEzU3lTWmg0MXI3?=
 =?utf-8?B?RTZQQnI5dW0rRUJ5M0xOQWFHdjJWUUpvUXVOc1JRK2J4bUFobE5vQk1SNGRz?=
 =?utf-8?B?c1pTSHpXNFZ5ZlVuZW5KbXZNY2FNanZpMkFNUzBScmFueUlaVE1mbHRiQm5H?=
 =?utf-8?B?N0hVL1g0OUZiQXhOZGFBY1RGQ2JQVjNVeUh1WmdMMjNJbDdudnZQZE1pTEJP?=
 =?utf-8?B?SVdzL1JwSjhUUXJPK1JiWHNCY3FLS2FKTUZOYWFPVjMzSG9Ga0FQRi8yd2Jh?=
 =?utf-8?B?VXUwWFAyUE9rRTdadEtvYytER0FHaVJXSTMwYmNJelJpVnhaWXp3TGFjNFVS?=
 =?utf-8?B?TnBDQ2FaUDV3Sm51ZlltZkxleXNhMm1ZN0FmNmlaUnFPc2cxYTlZMW45eVQ2?=
 =?utf-8?B?V0VvWGhUUzdLaEY1ek1neVdxbW40ajY1cXFQV29HbU9vZ1JKUmJBM0tTWElU?=
 =?utf-8?B?QS9mMENoN09ZTlZFQWViOVJLcTNHM0drSUxGVzdZbWdDcS83REFwaXVLeDQz?=
 =?utf-8?B?ay85UnA1WnhhNVNJRDZrVXdzYmNab2t4Z04zNzJ4R1VHUXNJdkdzbnFUdVZX?=
 =?utf-8?B?Ym16d3l1SUpWRmN3QmJxM0R5T01kVkNDU2hnY3hUTkNjR0l2WGVBZGh5Rmxw?=
 =?utf-8?B?am5hUHhiVUJxSEQ1Tm13Z2E1bGNXMVBBVVN4UUUvdXA2NmdwTTViTFpYZGdC?=
 =?utf-8?B?bFJWd3dSRG9KYWcxVHRBVVNObmhrK0pDdElOSUpSekFMdmpLNFBwTDZJU1F1?=
 =?utf-8?B?VDdJemRPY0lSUllkcVJPcC9xNVVYNHJmcFp0Tk9FU1krUHEySldDRnZ1NGFx?=
 =?utf-8?B?emRua0NwdnBZWUx0YXNtTTcxdG9rWDE0T2FhZHcrVkYwMjRkRDBIQTdTdldk?=
 =?utf-8?B?d1BTcXA2eHJ3Mk1Qam94ZG1lbVdnNllCR3FnbVpKYndOMyt1OURCSE1tb0Qz?=
 =?utf-8?B?R0VFN3dNbEZhQ3I4YTVqRGxmMXdvS3h0SVgxM3dvMG1rRXlzZDc5cGQybGNa?=
 =?utf-8?B?L2c5K1h3RC8xb1puWkRQcjhqSkNXZmY3TnpMYmNzRFpyck16SnZobTNJOVlG?=
 =?utf-8?B?OHVyeWZ2dmxoUTV4djBEby9DdS84YVV4STdsZ1FBT3NsYXZzaHJhUXpvMnpw?=
 =?utf-8?B?VC90QkhpcFNPUUhIWENSRDJLM2dRUFJMeHlpV21zOTJydjB2TnZRc2NoV2p1?=
 =?utf-8?B?cGxzbUtZRnZXTG56aXhubDA4NHRYcXFMN1lXWWcyVkZhTE4yWHlyS3VuYkVO?=
 =?utf-8?B?TWdJZGZoeCtTSnFwSVRkOXRxNjVTaTRIdEVyQWJ5bGlwMUxDK1VuOFJHYmhZ?=
 =?utf-8?B?SUUzYUZ1SHhPVGtCSmtoYzdrN0w2bU15K3gyVnh2b2NrYW9FSzUvOEZQcTJE?=
 =?utf-8?B?dDZDTGgxWGNObjM2TmpVYzdvR3RmejI4bk9oYzA3amRLYzhvRDY0V25pbDcw?=
 =?utf-8?B?WStlTEJ0Q1MxOUU4N2FmV1lXRmdNeTZCTklnL1FEajNwbjVCeDdBNklTdkE1?=
 =?utf-8?B?UHJ5bHducHI4UWxrYzlTRmo4YW0vdmpVQ00rb3loM05peFhHQjJwMERqcFlh?=
 =?utf-8?B?eDk5RlJuZGgwRGd3bnZqUmE0SlJhRXJ3ZS85KzNkcVRzSERYK0dYR0xLTVQr?=
 =?utf-8?B?cEVVQVNXK2tkRk1Td3AzN3hiVUg2eEFmR2l3eWpGNGI2Q3RLTXpSU2Jyb29l?=
 =?utf-8?B?YVpscU9OT1hnVHJzcnExeGkrVS9GWit2ZldTYlNRSGlRK1pVa2ZmWkVEK0lr?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FBBkKDh4QK/n1OGEmg/ZycXnNvHkKZsSZBXQfzok6PZ9dWjfQ0hTb2fws5RXXP4ncNoXEKVTNxNOJPbAg8ElcPzOypPfKTM6uAAyMoS+ER/rJzeMZTzxAKfzXTXm4bWkyPdi7P1vUhLuMBSRqMzJdqpYibbWGp6LWmRfMZkj+8pZwd0/3TB1A1VG9wFesiEewKyusnyshvgPxYUTQ4xFdv7AeYhBmkhjiATdCCnlKypvbE1lyU5CH4jYHAZT85hEtXhw3ORVY8gGR43UKkcz+tEP8D0KLnGDZISF/OQVZiKuFrXrmbcS4fOKdlmmQGh9z5yP5OBw74gKTc7qhHcsb02LgGiEm1Y+l7THRkcaXEYZ1qtrnbn2l424XVcQRQGmv3dwMWIOcPn0HEb0Lvdc+N0fvBlxCa7Mlz9/wzN2VUDaqHlnLLGUE1CoVQ5C170wtqLEx0gk2ovP2Lxrnkz2xbnm6yeG6vgao3PlgnT5XtHpX0tGTBgsjiRQfVB+bAZaAlDOjLaEzaIc+1ua/XslniKV7jRUsehI9vDjmNXLWAeNPD/XFvQbKpmmmvv1jzzO+UeWWnDuV291LjFupr+zeVpZxpt69PNs/ujzsSmfw2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbd772d-e2b1-4a4b-65dc-08de0c3f8b62
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 23:06:59.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBGo4zraF22KHtqDvv0npIWODLUrqyki1hlOmk835x4mVJkYm4ST/cL2hkgYlTlNsZE4vg9Gb8xUjSqEZrf/facBElRYWUcoqYf/9xLTij4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150176
X-Proofpoint-GUID: HMyWmsZojcO58D40wrncKnixA7k1JPI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX/d+31s9XjJMW
 0kYmNjLxHaHmMeusAkFvfDPuMZkY5Vb6w2NtsscnH19vVa/PSKZCKkajrsd9yHrM61RiZOPXevi
 qU766SuSz7Y2F52qRsJRp6TmqZ8FtHJPOZnY4Rx5/RhgaWWTILX0lF/lhq9+Rt9MlnXanuxuB1z
 pn9wJWYpO0O+xg/PwzZ0r0o1ZrRH4kN0GpdqpCzRHHdjrXC34tPb9EIRXhd+wPLPpajIq2sKY2h
 GK4bfodu0ESw6NpJSu2U0m8Bkbvzn8s7wK4+O4sOv903s/Gy3+N44NrAw1+ZrIW8/JUeP1hFd00
 zeYEt9xHCKdhqnoenQtJY6Jzg8TfBfcz/bIIKa5y2VcFr8ecai/k7L7Qp4bZ5Mo0H3lPnCwrHbD
 9SykhF5Mivv4KtR5CCkIGGDxrlDr29LPyBBjICbV0OCAOaxVLu0=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68f02918 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8
 a=mgOKBoPJTAh4FcwYoaEA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=NdAtdrkLVvyUPsUoGJp4:22 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: HMyWmsZojcO58D40wrncKnixA7k1JPI5



On 10/14/25 2:06 PM, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>> Sent: Tuesday, October 14, 2025 11:29 AM
>> To: Kaplan, David <David.Kaplan@amd.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter
>> Zijlstra <peterz@infradead.org>; Pawan Gupta
>> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
>> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
>> <hpa@zytor.com>; Alexander Graf <graf@amazon.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [RFC PATCH 00/56] Dynamic mitigations


>>
>> I'm not really a fan of this.  It adds complexity to some areas that are
>> already struggling with too much complexity.
>>
>> IMO this would need some REALLY strong justification, more than just
>> "hey, this makes things more convenient."
>>
>> The mitigations should be a "set it and forget it" thing.  I don't see
>> anything here which justifies the considerable maintenance burden this
>> would add for all existing and future mitigations.
>>
> 
> The problem is there are environments like the one outlined where you can't just 'set it and forget it' because the kernel needs it set at boot-time, but in these environments you don't know how to configure the system until much later in boot.  So you end up running with the default settings all the time, even if you don't need them.  And the default settings can have significant performance impacts in many cases.
> 
> The cloud guys on this thread may be able to offer some additional color here since I believe that's where you're most likely to have this situation.


We've had quite a few cases where initially selected mitigation would 
turn out to be wrong --- either because we discovered that performance 
characteristics were not what we expected or that mitigation had some 
issues (i.e. bugs). Once could argue that this could be true of any code 
but this area has been particularly troublesome.

There are ways to get around this such as live migration or 
ksplice/kpatch but these are not always possible or practical.


-boris

