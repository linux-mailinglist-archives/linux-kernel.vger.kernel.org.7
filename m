Return-Path: <linux-kernel+bounces-759279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66091B1DB76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2C585BC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3226E16E;
	Thu,  7 Aug 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="caXkhrCU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kUlpiU2V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7D13C9C4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583238; cv=fail; b=dy6fWG28VliXo6rKS5bPrglIRJdsA9VimL/0Rw1GbhaD7VrSpTRBcMt4H3S1JKMBTx5mBvnUAms5xU4NTgZvFiIKEgwqX8wcyLGZo8XlarufEBuQWhseC3kuh31mc7xohr6PXhCE7ex0voXtQ8j4KWUUdgG2SQOftiNV7LyI/Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583238; c=relaxed/simple;
	bh=Ge1Iw5sSqRYo8Jss6wimveAkoDMn8WO4Z4igOjKnNq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ie9cPmNtT3hYtFsMN5cosBZA2NY0vNN9dG4Wis2/m1Ag84U7wByhicTEep2ZAnFmvc8QYEQJ0dyoK10SQqqpXMrk/QRHcdJ/QO1zZwjzbKB3w9R+eCqLuyVK9YfNGwgjwtwG8EzNWVzW/0j+zODfBB8rivuI+uxAd+AjRhK94vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=caXkhrCU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kUlpiU2V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577FDTrH017112;
	Thu, 7 Aug 2025 16:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ge1Iw5sSqRYo8Jss6wimveAkoDMn8WO4Z4igOjKnNq0=; b=
	caXkhrCUYq1AktR87PJ2aWjNDvTwGKWkRWtpUizGvnj3yb/CULS7u3tw42p4a8Wm
	9n7OqBJWSpDtPMFIehvFFWx+Sm//PvhOLvf7JtkWJZJH6eAX+0MqOVj6hNZcXNnR
	ij3Ye+7vNMFGxIFBXOH9RJOcqOtd1jFruevkXFROalSNfqspFT2vlWhSTzDstieW
	i8pEKoSN1XP1SfWjaIUAvqXjADjZW/YFnAdgpx9foyA2EJeyE0zI3nwmD8LQcfFs
	Q7y3k2/86onMvyG2Optfrlv/hwqckOpI5zMPzuDZWvEqszJwM9/h8vNugwx7IeV4
	01szrkmHvMWVdmVMBLv/LQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgvec3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:13:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577FUebo027280;
	Thu, 7 Aug 2025 16:13:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpmd94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyrnryTjNmnQEgBIfV9E9XaC89/P7F1zqy/BNDpNOE+EvGrn+SyaF+dNpeNFgf3E0Q0K+hftt/BR/XQFIyLpw+tllyQZL2j4obg35n+I42IrjXb5Y6EumiFvZitGWEjUhs+gKstc2icahwq5u45D0n6WK4KBC/5IWslSZJOSaiogKlbjxA/oSVB5RhOdCCTHTsx8xIf0x7e9aEQn7khvVWMGVszYO8K75H14yhk8Kdi0HHB2FgqSzjLWS2mEXPmtNK70UoXDz0WAlxofV+ord6VruhmWo4ZsCAP5qQtvsNWRwZDZqyzcHVH5sO2lRn2GHXl5dmiXldCi8UXyi2JGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge1Iw5sSqRYo8Jss6wimveAkoDMn8WO4Z4igOjKnNq0=;
 b=sdhqY+yqfsXrfQm/HFXm01EVfvKEMPCQD19GB7tqMN7dnpQXCWjCUrWV/ZX16cFhZnY5V1ocsVhqWunYFXb/UbpsvHOocNI45szcpYN4oA4s1mrRcJgPyCY4mFMCAdv3QBhEsq9lDVRpXEJB9L91/Ex656revTWj3cE5745jZOqu9tp2hy9ym6a858V6v+cYIB7xYnjiXFBB7tVqvkzlTbIdYy+GS132puHppNuQwvzXbmZI/xVW3bzuK5yeF2jJ2lupvBX3DncgpPv8qUdtBNM2q+KlqV79y2m8PpUTBjI5Qi8zSkdPuXTZlQZMrVjwvXV6TGGuhAbk3Cuq/X6Nig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge1Iw5sSqRYo8Jss6wimveAkoDMn8WO4Z4igOjKnNq0=;
 b=kUlpiU2VCi6o23vus2EefRgRXYWFhXO1IroCphVJklxD/b7tmL+6xIjwqZ7FCvqQ2snh2RzOuY73QxMsMbJ/y18fb32kw5tr9i29wbbJmc0U97F9GyGQScKZECLgYuRoiAhIV5MNNDSnJaPcaEFaqrB+wUm5+Oa31QsVUapYEGQ=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by CH3PR10MB7138.namprd10.prod.outlook.com (2603:10b6:610:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 16:13:37 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 16:13:37 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 01/11] sched: Scheduler time slice extension
Thread-Topic: [PATCH V7 01/11] sched: Scheduler time slice extension
Thread-Index: AQHb/LZRoohaxDA/AkO7zPAZBTuqUbRWKXQAgAFJiAA=
Date: Thu, 7 Aug 2025 16:13:37 +0000
Message-ID: <4D9C86E6-C4AC-42A6-AB51-5D90FD4FD95D@oracle.com>
References: <87ms8cchqf.ffs@tglx>
In-Reply-To: <87ms8cchqf.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|CH3PR10MB7138:EE_
x-ms-office365-filtering-correlation-id: 89bbf680-ed60-41ea-8db7-08ddd5cd5db0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1hGbmdzK2NYZWNUMitKdWdLdWJxcHhiemUxUWVsckNYcVYyN2IySlk5WHc2?=
 =?utf-8?B?Z01XWTh3RUVUd29rMnpDU3Z1RHhDRTViSWdPMi93WElMYS9XeVB3NlVMOStF?=
 =?utf-8?B?eHVBTUdpQ2t1eGNvMTF3NXlSVVY3QUVFNWNsMitLY0FsRllDT3JDZFdQbjQz?=
 =?utf-8?B?L3g2QlFvcmVCenJ6Y29YbVBjRkNxRExJWXJGcU1vTUhaQVpsT2dvMGdnTzR4?=
 =?utf-8?B?ZFpkSm55MHpFTHVKQnVCcVU4alZuQ004QjVHK1F6NmlicFI0VTdmTUxHNXM5?=
 =?utf-8?B?MWw5SEh4L29UNmlObnZOV1Njakpib0tjdG1MeHRFcFNNVzBTNmJleTlUc2c3?=
 =?utf-8?B?TThrRVpGVFFXNVZCdmJJb2VSQlIrRUZDN3dMcHEvQ3c1UE5kb0EvWHJDSmFX?=
 =?utf-8?B?TFFBVC8yMkozaXdtL0RiWGxGLzhoU1JXLzU4NkxKOXRTQXR0OXJ2WG16ZENF?=
 =?utf-8?B?M2UyQmVhTTk3alkzNGN6Nmg4RGE0VGdlRUtEVDIveTQyMjYvRndUSE5FQkcv?=
 =?utf-8?B?ZHczc0RISkRwQWQvQ1R5Qy9ETGtueTljN3gwZ2s0ZTFkb3RkNmJoMzF0aVhG?=
 =?utf-8?B?K1kwcE5JWWN3NEdUdDQ2bU9reUZ6cHFCak9mNTd5WmJJMHpDTlZxVi9IcnpK?=
 =?utf-8?B?K0gwSjJJdnhuNGRZdlMvajI5a0pBempqSUdKWCt6M1dZNldkaS8wR2dIbUhS?=
 =?utf-8?B?Qk5kb3V1ZG5qZ2VZZ1lqOU1rWlpqTjBTdmZLM1JlejI3Rk96WWdBVkI3M2pi?=
 =?utf-8?B?OStlVU9Ib0xlREh3M0FObk5ZNlRuR21Gdm81eVltZzFpT0FiSVJMZGJFeFlN?=
 =?utf-8?B?Y3NjWlJKcVpDcktjUUgrUlArSG10MTVsd0w0SlBaTDlzZStiZVkxUitVaGJy?=
 =?utf-8?B?bVNBcW1uVi9mY214Q1VjaGZVT21Nb3Y2QlFSS1FtWm1HY3k1ZnFTMTRDUmwr?=
 =?utf-8?B?Z1d2REswZHVSeWcrN2pNZnVzMXJidmF2ZEpxQi9jZDlWajFNV2F3MGJTaERh?=
 =?utf-8?B?NVk4WUJhdUZsTlF1WEZ3RXQ4ejlQR0J6c2JBZVc2MU1FbmJlaWlSUldyc0dU?=
 =?utf-8?B?R0RZNUtKdGhGVGQ1NlNzelV2Tlh1a1FnWTZNeDBFRUpqd2lvcTZ2d3FMdmlE?=
 =?utf-8?B?Z3QxZERFV1dHNUpNRzY4THRRWDJOVmdXdUs0QVdYNnZiWUM1c1VaeDNwUFJE?=
 =?utf-8?B?S0N3VnpkUDlJd2J3aytnL1NxbEpid0E5UkJ4bXVsZWU3emJGUURleWdNbHMr?=
 =?utf-8?B?TTRkMHhvRDBkNDFMWFdqMDhXeFZRQ0kxNUQvbG5uay9aRmtCWGlGNFdYMHRo?=
 =?utf-8?B?d1VoZDlvZVZqZ1dHYXJtMlZWamlPR1FKMXp5TzBpak5wQnNKMWpRSWttd2I0?=
 =?utf-8?B?WEJ1VDJwV1IxWkhJK2p1REhaNzIvSXo4OWlISEZRdjlBRUR4N2ZPeXhYM0ZF?=
 =?utf-8?B?ZDVkSHlRTTl2RTFjenRWZHk0Q2xHdkJLMGQ0MHJCb0ZZeldpOCtKamJJZE1O?=
 =?utf-8?B?MEMvWDVvRmdWaU5scXVkMENqbzVEcVh5TG5xeE82enp3OWczMkUwS0tRQVl0?=
 =?utf-8?B?amRqeUpKWlZPQVFnMksrdlEzNHhFOWIxSjlCSHhNVWJWMkVFUGFZYVEvdng1?=
 =?utf-8?B?UFpwT2wvc29yOXA1VmZOT1BxT1FtOVJkNTIvRG93TkUrclpjUDdiVU5wamhh?=
 =?utf-8?B?cy9DcXhFNW1aWk1aZGpCK1lFTkJ4dVFzU0ExSGZ5N281bXdvNjJ1MjFXMHJQ?=
 =?utf-8?B?RUVMN1JueGVZbXlKdVljVEFGYVU4UFBtT1RJUUVZQWJ3REZxQmFiNUM5UUNN?=
 =?utf-8?B?Q3pVektQdTBhMUlmQ01DalRKdWgvZjRFeUlFV1VKdkdIMDZsaTFXeExGNDN3?=
 =?utf-8?B?SWpQTmVRdkVpaURlNHlKUUkzK1lqbjlGSHNmalMvZG5OeTdVMFBIcG1nbXNZ?=
 =?utf-8?B?dUVGOVg0YWx6cTUxNHhNVVV4Yk9rTElwV3Yzdnh3c0xOZjd0R0JqMnJRU05o?=
 =?utf-8?B?d3Bscy8zSFhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWR6eGkvUHZEajJ0T2F0bGwyQThhVWQ3M3lSaDM5ZldScWxxNlhuZTM5d1Bn?=
 =?utf-8?B?VmNDR0srcTZ5Z0JzbjhpZUxlL0RvamZUbDI4Q0hvMjFwVVVaY1VJT1RFaVB4?=
 =?utf-8?B?QlZHY1hCbWFWSVEvT0ZMRS9wU3ArL08zWUlRRy9rRDQ2RHBjOWxuTDJSUmpi?=
 =?utf-8?B?VHJwQmtUdnRCU3BzWjhSVXp1aUdiM3VDVGd6MUNwRnIyd0c0UXg3R0ErS0o4?=
 =?utf-8?B?M0FqdUVpM0RkZGtudGtMZlorNFhKMnpicXQ0RHBBbGxqQUthZjR2Yi9pUVFX?=
 =?utf-8?B?eWxQYUhlLzM1Z1A5bEhFN0l2TktRdk5vdFJyeXp2VW41bVVDZVBrdkFLdEU5?=
 =?utf-8?B?cEFiMitoc29QQ3RrSGM1Q29XTDQ5dGV1ZEx0dldESmUwUTJaZ3RMSGQyQjUr?=
 =?utf-8?B?VU5aV0xxTld2ZW14Z1hVR3pQZmJLNThKQ0Q0c1N5OEkzYkV5RlBQQ3FFaVhC?=
 =?utf-8?B?ZzRFL3k1bGkwVFpjRDNhemQxQjFpSnpyVWt6bThURkQyemsvVm5LMms1M1ZW?=
 =?utf-8?B?RURPc09QYmxwMXhHM0xYNm5YeGc3N3pGS1AwQWtlcmQrdDJCenFGTFluYy9Z?=
 =?utf-8?B?Q3Y4UW80bWJldjNwQUtDT01PekVnQ3FPbDRPcjJ0NU5meEtlTzVvZjg0RDAx?=
 =?utf-8?B?NzlCaHJ1YU1UcC94RjRqWjM0WG94ZDJFTE0rM1ZtNU9QOW5jQWlwU0syVG9u?=
 =?utf-8?B?OVZhREtpeWlVZ0N0VGxsRGFjTWRwUjhBRlVUSGxhZkplU1pLMkVwdkNYbUd3?=
 =?utf-8?B?Y01KY1k3ZG8vT1J1aDdrZnVtMkxTcEkrTFovcThPTW90OXhFS21RTUVaSWpn?=
 =?utf-8?B?TWJwdEY4TkFWUnRMdjBGdWVvdVpzb25yYUNudHFxdnhvdFM5WmtoN1ZVUkJ4?=
 =?utf-8?B?cmJCR1hkRUE5c3ZTVEFkTnNFV1pJT0dCeWQxTEpiU2x0NUQzMDE1ZVpUTnVw?=
 =?utf-8?B?akU4OVdHU3haS0lRUEIzNFZvL3hQTndKbzF6a1V1UXJvbisraW9NSnlUdDBQ?=
 =?utf-8?B?RHZhYVg2RlU0di9aeStNNGZsOUdRUVB2Ly9FUGZXZUVxWGJOK1czZzlLUCs3?=
 =?utf-8?B?TnQveVdGak42OEp6TStBTDNEMXFJaU1DOEdIbG1jQXFvU01rMk5FVkdhQlp2?=
 =?utf-8?B?QzBTWE95V0NUNkdzM09nSTd2dXZPeXRNd0dUOTE2dGlEQUtYVkFZcDRSZE9Z?=
 =?utf-8?B?bTNmTVBwV3J6VzVycmY5VTRtNWY2cmhtRFpuVmI2L2VsU0o1Q0MxOHJkb3pY?=
 =?utf-8?B?ZW5HK0xBRVZkNFJtVEFob3h4b1hmOGpSZFhFbmVTUHVLT0pHOStGUDZzYWRB?=
 =?utf-8?B?ZEM3bjF2WjdQYkNtZzl6MmtmNWJ4T2R1RHh6eEFOcmdwbU5adk54QVlRSXRE?=
 =?utf-8?B?N3VoSnFBVkg3WFVOakVJdkkvbG41dWFJRHJPL04wSU40YmRuY3dCNjdnWDVz?=
 =?utf-8?B?WFJNWmJaVER3NTEyd0ZFOGxBcUZHTjhvQk90RWgxRUlVVnB6c3FsUGJDb0tu?=
 =?utf-8?B?aWJCZ0E0NUpWaThORVpaMEFUZzJqQ1hxMEN6YkEwOFZPUEltQy9TNzBsVHFD?=
 =?utf-8?B?ejNaQUQwWHY5dUtKWnhrYlhVYmRJSklSZ2hSV2NhRFRuK0RvNW5Qd1JvSDNB?=
 =?utf-8?B?Q1RUaDdqR1FFNG41L3pZMmV0c3UrTC9UY2FsanpzTlc0SUVhZG44c0RYbGY2?=
 =?utf-8?B?N1IraGV0amNENEM4UXFZOTFBWlRLd3JCOUUyR1Z6ajNYVytlL0xtWEVGMmNF?=
 =?utf-8?B?dTh5QVUrd2pjTUM2cUl0clpQSDU4NnRwcXhzbGNqcWtMd3dIREdwTVFndGJj?=
 =?utf-8?B?NjRDYlExVW1KQlFHalRFLzVuSzMzT0Z4QmtOSGhpdjZUUjNaRmZwd1JWM2FX?=
 =?utf-8?B?ZHNFQTNLdStRNUpEeGlkTjlBQ3UzMXZVU0FnK3lrc05lUFBKVXFWdUwzamxs?=
 =?utf-8?B?SkxUcGlSWVBDR29halRwVXNQVzRzSUxaZGkrdk5lcnVIajVkZFBnSTZrMHov?=
 =?utf-8?B?Wk1NYk84K1lwMXhrM2dwQkRWQmtIRTUxeTN2WW83QTczY0NHU2ovNjJOSlNT?=
 =?utf-8?B?ZjdSZm8vc2I1ZFpLd3NYbTNIZlNNWVdRaE45a2hmbHYwd3VzUTArUFB5VEdI?=
 =?utf-8?B?eFlRVmJtZ25mQ0ljbC9XYWFURUN3QWU0Z0tXOEhrTDV4STMvaE45RlMzNGZP?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF42F1775874FE4EA878E185E37B1FF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rI7wE9Nt+sY3BuPSWD3tEOI5+G18ygS3YuGlpO/+pc3nnjma1HthZ0PRD13uflyS1NC2fQe8cahlM/RNUmVeF0jj1S6iXZl55KPIgPyw1KCw3PcSKZgMu2bL4qKkw6FqFOdkgaB7uHZWf3V6KuoEdUFG28/Lqrx0RstuGxVa+Cydf6r16oocrBxy60dT4CeCwYg/91ohuf0WzQZndHTa+oqmTtMFZoE1ilNtdpSP26W5JYjCT63Kd8HOATir3shAHSFKXsBervgIatqJoPO1wv1ubM4PqWwajSsiI/bZ3cYgiHTF0+9uiF1LNJ00xhvGNBksHCKDLbuGDwEz/7jSoVE2FfesehUnY36OLUmvFIuedY0iIYa+9gu3AIymrwm6Mr7Cwlk82gh+cjnRTV4dBVj/aMX/bdO3GoWZgEsKWnVYG1ksu+8Dm07oVEndCP8BMuSMGykhwC1MSIWFxz1m6fS0OlvbNlGMkHC2LcTGq+WwJQNoY2zfRpVVzPc3HOhe+k+VhQhnubRs5OmfbBN6pCJD7QggDIFNLDadbhJtn/V2QdxNa6kclsU74OlYWG2N2G3ZqcsCuxzJUC05p0Bpy5MrNzmA+0Zet/1kdMBZBKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bbf680-ed60-41ea-8db7-08ddd5cd5db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 16:13:37.2794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzin6Y3ie3N/LiEdv8LBOq05tNzUaDmbrvUdDa/jzorvuSWOcf6p5wrKttD+Rk85Rv8RlhDqmKlcixGITjU2x/9hptwDdqvyRWH/+0U6/BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070132
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=6894d0b6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=fI9IfWR63trHFJobejsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O3nw5QVyAHBbTTq70hPg278pgNqcnzLf
X-Proofpoint-ORIG-GUID: O3nw5QVyAHBbTTq70hPg278pgNqcnzLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEzMiBTYWx0ZWRfX+35Z6UXeuKrN
 C0zIR+tYf+roe1/+M/dp8V7QPjD1dtdiibAxRkmRoJegahq+v9cXuG3f4//PtGAGS0FHVa+EYuS
 SEL+I52kQx2EvmrvAk9hXKPVZ3JkS91/NxC3dgBvBV/h9tngr05jSsKZS5mgNLpEIOI6dDqK1L0
 55x0cPjXoaL0dFfBsvsI+Oyr80M7K9rL5qZT24NkuMbI+9PcOYdQB5t6eGNvU3f2EE841l1T6+Z
 K8xMSxIamVkEpiBe8aLCxnjVcskCYVrnXtL+lnxe5yJCXB0H5EUzjINEebWC0LjJbzBZeNfgwei
 5oxEJIXn09BvzM3UoN5DF7jV9CMVHXllFIUaw3lM0R7lFoqrSbKHcCoe8IsJvDwxUEGMztG/v6K
 0KWoyoJJzzHHd/dDMSlq+Syb1dD2vI0P0D/B/eUZQXGb67xgSZPd8aQ67B+cQ8geOlIh1f6R

DQoNCj4gT24gQXVnIDYsIDIwMjUsIGF0IDE6MzTigK9QTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdWwgMjQgMjAyNSBhdCAxNjox
NiwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+IEBAIC0zMDQsNyArMzA0LDcgQEAgdm9pZCBh
cmNoX2RvX3NpZ25hbF9vcl9yZXN0YXJ0KHN0cnVjdCBwdF9yZWdzICpyZWdzKTsNCj4+ICAqIGV4
aXRfdG9fdXNlcl9tb2RlX2xvb3AgLSBkbyBhbnkgcGVuZGluZyB3b3JrIGJlZm9yZSBsZWF2aW5n
IHRvIHVzZXIgc3BhY2UNCj4+ICAqLw0KPj4gdW5zaWduZWQgbG9uZyBleGl0X3RvX3VzZXJfbW9k
ZV9sb29wKHN0cnVjdCBwdF9yZWdzICpyZWdzLA0KPj4gLSAgICAgdW5zaWduZWQgbG9uZyB0aV93
b3JrKTsNCj4+ICsgICAgIHVuc2lnbmVkIGxvbmcgdGlfd29yaywgYm9vbCBpcnEpOw0KPiANCj4g
SSBrbm93IHRoZSBrZXJuZWwtZG9jIGFscmVhZHkgbGFja3MgdGhlIGRlc2NyaXB0aW9uIGZvciB0
aGUgZXhpc3RpbmcNCj4gYXJndW1lbnRzLCBidXQgYWRkaW5nIG1vcmUgdW5kb2N1bWVudGVkIG9u
ZXMgaXMgbm90IHRoZSByaWdodCB0aGluZw0KPiBlaXRoZXIuDQo+IA0KPiBBbHNvIHBsZWFzZSBu
YW1lIHRoaXMgYXJndW1lbnQgJ2Zyb21faXJxJyB0byBtYWtlIGl0IGNsZWFyIHdoYXQgdGhpcyBp
cw0KPiBhYm91dC4NCg0KT2ssIHdpbGwgY2hhbmdlIGl0Lg0KDQo+IA0KPj4gLyoqDQo+PiAgKiBl
eGl0X3RvX3VzZXJfbW9kZV9wcmVwYXJlIC0gY2FsbCBleGl0X3RvX3VzZXJfbW9kZV9sb29wKCkg
aWYgcmVxdWlyZWQNCj4+IEBAIC0zMTYsNyArMzE2LDcgQEAgdW5zaWduZWQgbG9uZyBleGl0X3Rv
X3VzZXJfbW9kZV9sb29wKHN0cnVjdCBwdF9yZWdzICpyZWdzLA0KPj4gICogICAgRVhJVF9UT19V
U0VSX01PREVfV09SSyBhcmUgc2V0DQo+PiAgKiA0KSBjaGVjayB0aGF0IGludGVycnVwdHMgYXJl
IHN0aWxsIGRpc2FibGVkDQo+PiAgKi8NCj4+IC1zdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQg
ZXhpdF90b191c2VyX21vZGVfcHJlcGFyZShzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4+ICtzdGF0
aWMgX19hbHdheXNfaW5saW5lIHZvaWQgZXhpdF90b191c2VyX21vZGVfcHJlcGFyZShzdHJ1Y3Qg
cHRfcmVncyAqcmVncywgYm9vbCBpcnEpDQo+IA0KPiBOZXcgYXJndW1lbnQgbm90IGRvY3VtZW50
ZWQgaW4ga2VybmVsLWRvYy4NCg0KV2lsbCBhZGQgbmVjZXNzYXJ5IGRvY3VtZW50YXRpb24uDQoN
Cj4gDQo+PiB7DQo+PiB1bnNpZ25lZCBsb25nIHRpX3dvcms7DQo+PiANCj4+IEBAIC0zMjcsNyAr
MzI3LDEwIEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBleGl0X3RvX3VzZXJfbW9kZV9w
cmVwYXJlKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gDQo+PiB0aV93b3JrID0gcmVhZF90aHJl
YWRfZmxhZ3MoKTsNCj4+IGlmICh1bmxpa2VseSh0aV93b3JrICYgRVhJVF9UT19VU0VSX01PREVf
V09SSykpDQo+PiAtIHRpX3dvcmsgPSBleGl0X3RvX3VzZXJfbW9kZV9sb29wKHJlZ3MsIHRpX3dv
cmspOw0KPj4gKyB0aV93b3JrID0gZXhpdF90b191c2VyX21vZGVfbG9vcChyZWdzLCB0aV93b3Jr
LCBpcnEpOw0KPj4gKw0KPj4gKyBpZiAoSVNfRU5BQkxFRChDT05GSUdfUlNFUV9SRVNDSEVEX0RF
TEFZKSAmJiBpcnEpDQo+PiArIHJzZXFfZGVsYXlfcmVzY2hlZF9hcm1fdGltZXIoKTsNCj4gDQo+
IFRoaXMgaXMgc3RpbGwgYW4gdW5jb25kaXRpb25hbCBmdW5jdGlvbiBjYWxsIHdoaWNoIGlzIGEg
Tk9PUCBmb3INCj4gZXZlcnlvbmUgd2hvIGRvZXMgbm90IHVzZSB0aGlzLiBJdCdzIG5vdCB0aGF0
IGhhcmQgdG8gaW5saW5lIHRoZQ0KPiBjaGVjay4gSG93IG9mdGVuIGRvIEkgaGF2ZSB0byBleHBs
YWluIHRoYXQ/DQoNCldpbGwgZml4Lg0KDQo+IA0KPj4gYXJjaF9leGl0X3RvX3VzZXJfbW9kZV9w
cmVwYXJlKHJlZ3MsIHRpX3dvcmspOw0KPj4gDQo+PiBAQCAtMzk2LDYgKzM5OSw5IEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2RlX3dvcmsoc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MpDQo+PiANCj4+IENUX1dBUk5fT04oY3Rfc3RhdGUoKSAhPSBDVF9T
VEFURV9LRVJORUwpOw0KPj4gDQo+PiArIC8qIFJlc2NoZWR1bGUgaWYgc2NoZWR1bGVyIHRpbWUg
ZGVsYXkgd2FzIGdyYW50ZWQgKi8NCj4gDQo+IFRoaXMgaXMgbm90IHJlc2NoZWR1bGluZy4gSXQg
c2V0cyBORUVEX1JFU0NIRUQsIHdoaWNoIGlzIGEgY29tcGxldGVseQ0KPiBkaWZmZXJlbnQgdGhp
bmcuDQo+IA0KPj4gKyByc2VxX2RlbGF5X3NldF9uZWVkX3Jlc2NoZWQoKTsNCj4gDQo+IEkgZnVu
ZGFtZW50YWxseSBoYXRlIHRoaXMgaGFjayBhcyBpdCBnb2VzIG91dCB0byB1c2VyIHNwYWNlIHdp
dGgNCj4gTkVFRF9SRVNDSEVEIHNldCBhbmQgYWJzb2x1dGVseSB6ZXJvIGRlYnVnIG1lY2hhbmlz
bSB3aGljaCB2YWxpZGF0ZXMNCj4gaXQuIEN1cnJlbnRseSBnb2luZyBvdXQgd2l0aCBORUVEX1JF
U0NIRUQgc2V0IGlzIGEgcGxhaW4gYnVnLCByaWd0aGZ1bGx5DQo+IHNvLg0KPiANCj4gQnV0IG5v
dyB0aGlzIG11Y2sgY29tZXMgYWxvbmcgYW5kIHNldHMgdGhlIGZsYWcsIHdoaWNoIGlzIHNlbWFu
dGljYWxseQ0KPiBqdXN0IHdyb25nIGFuZCBpbGwgZGVmaW5lZC4NCj4gDQo+IFRoZSBwb2ludCBp
cyB0aGF0IE5FRURfUkVTQ0hFRCBoYXMgYmVlbiBjbGVhcmVkIGJ5IHJlcXVlc3RpbmcgYW5kDQo+
IGdyYW50aW5nIHRoZSBleHRlbnNpb24sIHdoaWNoIG1lYW5zIHRoZSB0YXNrIGNhbiBnbyBvdXQg
dG8gdXNlcnNwYWNlLA0KPiB1bnRpbCBpdCBlaXRoZXIgcmVsaW5xdWlzaGVzIHRoZSBDUFUgb3Ig
aHJ0aWNrKCkgd2hhY2tzIGl0IG92ZXIgdGhlDQo+IGhlYWQuDQo+IA0KPiBBbmQgeW91ciBtdWNr
IHJlcXVpcmVzIHRoaXMgaW5zYW5lIGhhY2sgd2l0aCBzY2hlZF95aWVsZCgpOg0KPiANCj4+IFNZ
U0NBTExfREVGSU5FMChzY2hlZF95aWVsZCkNCj4+IHsNCj4+ICsgLyogUmVzY2hlZHVsZSBpZiBz
Y2hlZHVsZXIgdGltZSBkZWxheSB3YXMgZ3JhbnRlZCAqLw0KPj4gKyBpZiAocnNlcV9kZWxheV9z
ZXRfbmVlZF9yZXNjaGVkKCkpDQo+PiArIHJldHVybiAwOw0KPj4gKw0KPj4gZG9fc2NoZWRfeWll
bGQoKTsNCj4+IHJldHVybiAwOw0KPj4gfQ0KPiANCj4gVGhhdCdzIGp1c3QgY29tcGxldGVseSB3
cm9uZy4gUmVsaW5xdWlzaGluZyB0aGUgQ1BVIHNob3VsZCBiZSBwb3NzaWJsZQ0KPiBieSBhbnkg
YXJiaXRyYXJ5IHN5c2NhbGwgYW5kIG5vdCByZXF1aXJlIHRvIG1ha2Ugc2NoZWRfeWllbGQoKSBt
b3JlDQo+IGlsbC1kZWZpbmVkIGFzIGl0IGlzIGFscmVhZHkuDQo+IA0KPiBUaGUgb2J2aW91cyB3
YXkgdG8gc29sdmUgYm90aCBpc3N1ZXMgaXMgdG8gY2xlYXIgTkVFRF9SRVNDSEVEIHdoZW4NCj4g
dGhlIGRlbGF5IGlzIGdyYW50ZWQgYW5kIHRoZW4gZG8gaW4gc3lzY2FsbF9lbnRlcl9mcm9tX3Vz
ZXJfbW9kZV93b3JrKCkNCj4gDQo+ICAgICAgICByc2VxX2RlbGF5X3N5c19lbnRlcigpDQo+ICAg
ICAgICB7DQo+ICAgICAgICAgICAgIGlmICh1bmxpa2VseShjdXJyZW50LT5yc2VxX2RlbGF5X3Jl
c2NoZWQgPT0gR1JBTlRFRCkpIHsNCj4gICAgc2V0X3Rza19uZWVkX3Jlc2NoZWQoY3VycmVudCk7
DQo+ICAgICAgICAgICAgICAgICAgICBzY2hlZHVsZSgpOw0KPiAgICAgICAgICAgICB9ICAgICAg
IA0KPiAgICAgICAgfSAgICAgIA0KPiANCj4gTm8/DQo+IA0KPiBJdCdzIGRlYmF0YWJsZSB3aGV0
aGVyIHRoZSBzY2hlZHVsZSgpIHRoZXJlIGlzIG5lY2Vzc2FyeS4gUmVtb3ZpbmcgaXQNCj4gd291
bGQgYWxsb3cgdGhlIHRhc2sgdG8gZWl0aGVyIGNvbXBsZXRlIHRoZSBzeXNjYWxsIGFuZCByZXNj
aGVkdWxlIG9uDQo+IGV4aXQgdG8gdXNlciBzcGFjZSBvciBnbyB0byBzbGVlcCBpbiB0aGUgc3lz
Y2FsbC4gQnV0IHRoYXQncyBhIHRyaXZpYWwNCj4gZGV0YWlsLg0KPiANCj4gVGhlIGltcG9ydGFu
dCBwb2ludCBpcyB0aGF0IHRoZSBORUVEX1JFU0NIRUQgc2VtYW50aWNzIHN0YXkgc2FuZSBhbmQg
dGhlDQo+IHByb2JsZW0gaXMgc29sdmVkIHJpZ2h0IG9uIHRoZSBuZXh0IHN5c2NhbGwgZW50cnku
DQo+IA0KPiBUaGlzIGRlbGF5IGlzIG5vdCBmb3IgZXh0ZW5kaW5nIENQVSB0aW1lIGFjY3Jvc3Mg
c3lzY2FsbHMsIGl0J3Mgc29sZWx5DQo+IHRvIGFsbG93IHVzZXIgc3BhY2UgdG8gY29tcGxldGUg
YSBfdXNlciBzcGFjZV8gY3JpdGljYWwNCj4gc2VjdGlvbi4gRXZlcnl0aGluZyBlbHNlIGlzIGp1
c3Qgd3JvbmcgYW5kIHdlIGRvbid0IGltcGxlbWVudCBpdCBhcyBhbg0KPiBpbnZpdGF0aW9uIGZv
ciBhYnVzZS4NCj4gDQo+IEZvciB0aGUgcmVjb3JkOiBJIHVzZWQgR1JBTlRFRCBvbiBwdXJwb3Nl
LCBiZWNhdXNlIFJFUVVFU1RFRCBpcw0KPiBib2d1cy4gQXQgdGhlIHBvaW50IHdoZXJlIF9fcnNl
cV9kZWxheV9yZXNjaGVkKCkgaXMgaW52b2tlZCBfQU5EXw0KPiBvYnNlcnZlcyB0aGUgdXNlciBz
cGFjZSByZXF1ZXN0LCBpdCBncmFudHMgdGhlIGRlbGF5LCBubz8NCj4gDQo+IFRoaXMgcmFuZG9t
IG5vbWVuY2xhdHVyZSBpcyBqdXN0IG1ha2luZyB0aGlzIHN0dWZmIGFubm95aW5nbHkgaGFyZCB0
bw0KPiBmb2xsb3cuDQo+IA0KDQpPayBJIGNhbiBtb3ZlIHRoZSBjaGVjayB0byByZWxpbnF1aXNo
IGNwdSBpbiBzeXNjYWxsX2VudGVyX2Zyb21fdXNlcl9tb2RlX3dvcmsoKQ0KaW5zdGVhZCBvZiBp
biBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2RlX3dvcmsoKS4gDQoNCg0KPj4gK3N0YXRpYyBpbmxp
bmUgYm9vbCByc2VxX2RlbGF5X3Jlc2NoZWQodW5zaWduZWQgbG9uZyB0aV93b3JrKQ0KPj4gK3sN
Cj4+ICsgaWYgKCFJU19FTkFCTEVEKENPTkZJR19SU0VRX1JFU0NIRURfREVMQVkpKQ0KPj4gKyBy
ZXR1cm4gZmFsc2U7DQo+PiArDQo+PiArIGlmICh1bmxpa2VseShjdXJyZW50LT5yc2VxX2RlbGF5
X3Jlc2NoZWQgIT0gUlNFUV9SRVNDSEVEX0RFTEFZX1BST0JFKSkNCj4+ICsgcmV0dXJuIGZhbHNl
Ow0KPiANCj4gV2h5IHVubGlrZWx5PyBUaGUgbWFqb3JpdHkgb2YgYXBwbGljYXRpb25zIGRvIG5v
dCB1c2UgdGhpcy4NCg0KV0lsbCBjaGFuZ2UgdG8gbGlrZWx5KCkuDQoNCj4gDQo+PiArDQo+PiAr
IGlmICghKHRpX3dvcmsgJiAoX1RJRl9ORUVEX1JFU0NIRUR8X1RJRl9ORUVEX1JFU0NIRURfTEFa
WSkpKQ0KPj4gKyByZXR1cm4gZmFsc2U7DQo+IA0KPiBUaGUgY2FsbGVyIGFscmVhZHkgZXN0YWJs
aXNoZWQgdGhhdCBvbmUgb2YgdGhlc2UgZmxhZ3MgaXMgc2V0LCBubz8NCg0KVGhhdCBpcyByaWdo
dCwgd2lsbCBkZWxldGUgdGhpcyBjaGVjayBoZXJlLiANCg0KPiANCj4+ICsgaWYgKF9fcnNlcV9k
ZWxheV9yZXNjaGVkKCkpIHsNCj4+ICsgY2xlYXJfdHNrX25lZWRfcmVzY2hlZChjdXJyZW50KTsN
Cj4gDQo+IFdoeSBoYXMgdGhpcyB0byBiZSBpbmxpbmUgYW5kIGlzIG5vdCBkb25lIGluIF9fcnNl
cV9kZWxheV9yZXNjaGVkKCk/DQoNClN1cmUsIGl0IGNvdWxkIGJlIGluIF9fcnNlcV9kZWxheV9y
ZXNjaGVkKCkuIA0KDQo+IA0KPj4gKyByZXR1cm4gdHJ1ZTsNCj4+ICsgfQ0KPj4gKyByZXR1cm4g
ZmFsc2U7DQo+IA0KPj4gLyoqDQo+PiAgKiBleGl0X3RvX3VzZXJfbW9kZV9sb29wIC0gZG8gYW55
IHBlbmRpbmcgd29yayBiZWZvcmUgbGVhdmluZyB0byB1c2VyIHNwYWNlDQo+PiAgKiBAcmVnczog
UG9pbnRlciB0byBwdF9yZWdzIG9uIGVudHJ5IHN0YWNrDQo+PiAgKiBAdGlfd29yazogVElGIHdv
cmsgZmxhZ3MgYXMgcmVhZCBieSB0aGUgY2FsbGVyDQo+PiAgKi8NCj4+IF9fYWx3YXlzX2lubGlu
ZSB1bnNpZ25lZCBsb25nIGV4aXRfdG9fdXNlcl9tb2RlX2xvb3Aoc3RydWN0IHB0X3JlZ3MgKnJl
Z3MsDQo+PiAtICAgICB1bnNpZ25lZCBsb25nIHRpX3dvcmspDQo+PiArICAgICB1bnNpZ25lZCBs
b25nIHRpX3dvcmssIGJvb2wgaXJxKQ0KPj4gew0KPiANCj4gU2FtZSBjb21tZW50cyBhcyBhYm92
ZS4NCj4gDQo+PiArDQo+PiArdm9pZCByc2VxX2RlbGF5X3Jlc2NoZWRfdGljayh2b2lkKQ0KPj4g
K3sNCj4+ICsgaWYgKGN1cnJlbnQtPnJzZXFfZGVsYXlfcmVzY2hlZCA9PSBSU0VRX1JFU0NIRURf
REVMQVlfUkVRVUVTVEVEKQ0KPj4gKyBzZXRfdHNrX25lZWRfcmVzY2hlZChjdXJyZW50KTsNCj4g
DQo+IFNtYWxsIGVub3VnaCB0byBpbmxpbmUgaW50byBocnRpY2soKSB3aXRoIGEgSVNfRU5BQkxF
RCgpIGd1YXJkLCBubz8NCg0KIEkgY2FuIG1vdmUgaXQgdG8gaHJ0aWNrKCkgYW5kIGRlbGV0ZSB0
aGUgcnNlcV9kZWxheV9yZXNjaGVkX3RpY2soKSByb3V0aW5lLg0KDQo+IA0KPj4gK30NCj4+ICsj
ZW5kaWYgLyogQ09ORklHX1JTRVFfUkVTQ0hFRF9ERUxBWSAqLw0KPj4gKw0KPj4gI2lmZGVmIENP
TkZJR19ERUJVR19SU0VRDQo+PiANCj4+IC8qDQo+PiBAQCAtNDkzLDYgKzUyNyw4IEBAIFNZU0NB
TExfREVGSU5FNChyc2VxLCBzdHJ1Y3QgcnNlcSBfX3VzZXIgKiwgcnNlcSwgdTMyLCByc2VxX2xl
biwNCj4+IGN1cnJlbnQtPnJzZXEgPSBOVUxMOw0KPj4gY3VycmVudC0+cnNlcV9zaWcgPSAwOw0K
Pj4gY3VycmVudC0+cnNlcV9sZW4gPSAwOw0KPj4gKyBpZiAoSVNfRU5BQkxFRChDT05GSUdfUlNF
UV9SRVNDSEVEX0RFTEFZKSkNCj4+ICsgY3VycmVudC0+cnNlcV9kZWxheV9yZXNjaGVkID0gUlNF
UV9SRVNDSEVEX0RFTEFZX05PTkU7DQo+IA0KPiBXaGF0J3MgdGhhdCBjb25kaXRpb25hbCBmb3I/
DQo+IA0KPiB0LT5yc2VxX2RlbGF5X3Jlc2NoZWQgaXMgdW5jb25kaXRpb25hbGx5IGF2YWlsYWJs
ZS4gWW91ciBjaG9pY2Ugb2YNCj4gb3B0aW1pemluZyB0aGUgaXJyZWxldmFudCBwbGFjZXMgaXMg
YW1hemluZy4NCg0KV2lsbCBmaXguDQoNCj4gDQo+PiByZXR1cm4gMDsNCj4+IH0NCj4+IA0KPj4g
QEAgLTU2MSw2ICs1OTcsOCBAQCBTWVNDQUxMX0RFRklORTQocnNlcSwgc3RydWN0IHJzZXEgX191
c2VyICosIHJzZXEsIHUzMiwgcnNlcV9sZW4sDQo+PiBjdXJyZW50LT5yc2VxID0gcnNlcTsNCj4+
IGN1cnJlbnQtPnJzZXFfbGVuID0gcnNlcV9sZW47DQo+PiBjdXJyZW50LT5yc2VxX3NpZyA9IHNp
ZzsNCj4+ICsgaWYgKElTX0VOQUJMRUQoQ09ORklHX1JTRVFfUkVTQ0hFRF9ERUxBWSkpDQo+PiAr
IGN1cnJlbnQtPnJzZXFfZGVsYXlfcmVzY2hlZCA9IFJTRVFfUkVTQ0hFRF9ERUxBWV9QUk9CRTsN
Cj4gDQo+IFdoeSBpcyB0aGlzIGRvbmUgdW5jb25kaXRpb25hbGx5IGZvciByc2VxPw0KPiANCj4g
U28gdGhhdCBhbnkgcnNlcSB1c2VyIG5lZWRzIHRvIGRvIGEgZnVuY3Rpb24gY2FsbCBhbmQgYSBj
b3B5X2Zyb21fdXNlcigpDQo+IGp1c3QgZm9yIG5vdGhpbmc/DQo+IA0KPiBBIHRhc2ssIHdoaWNo
IG5lZWRzIHRoaXMgbXVjaywgY2FuIHZlcnkgd2VsbCBvcHQtaW4gZm9yIHRoaXMgYW5kIGxlYXZl
DQo+IGV2ZXJ5Ym9keSBlbHNlIHVuYWZmZWN0ZWQsIG5vPw0KDQpTdXJlLCB0aGF0IHNlZW1zIHJl
YXNvbmFibGUuDQoNCj4gDQo+IHByY3RsKCkgZXhpc3RzIGZvciBhIHJlYXNvbiBhbmQgdGhhdCBh
bGxvd3MgZXZlbiBmaWx0ZXJpbmcgb3V0IHRoZQ0KPiByZXF1ZXN0IHRvIGVuYWJsZSBpdCBpZiB0
aGUgc3lzYWRtaW4gc2V0cyB1cCBmaWx0ZXJzIGFjY29yZGluZ2x5Lg0KPiANCj4gQXMgY29kZSB3
aGljaCB3YW50cyB0byB1dGlsaXplIHRoaXMgaGFzIHRvIGJlIG1vZGlmaWVkIGFueXdheSwgYWRk
aW5nDQo+IHRoZSBwcmN0bCgpIGlzIG5vdCBhIHVucmVhc29uYWJsZSByZXF1aXJlbWVudC4NCj4g
DQo+PiBjbGVhcl9wcmVlbXB0X25lZWRfcmVzY2hlZCgpOw0KPj4gKyBpZiAoSVNfRU5BQkxFRChD
T05GSUdfUlNFUV9SRVNDSEVEX0RFTEFZKSAmJg0KPj4gKyAgICBwcmV2LT5yc2VxX2RlbGF5X3Jl
c2NoZWQgPT0gUlNFUV9SRVNDSEVEX0RFTEFZX1JFUVVFU1RFRCkNCj4+ICsgcHJldi0+cnNlcV9k
ZWxheV9yZXNjaGVkID0gUlNFUV9SRVNDSEVEX0RFTEFZX1BST0JFOw0KPiANCj4gWWV0IGFub3Ro
ZXIgY29kZSBjb25kaXRpb25hbCBmb3Igbm8gcmVhc29uLiBUaGVzZSBhcmUgdHdvIGJpdHMgYW5k
IHlvdSBjYW4NCj4gdXNlIHRoZW0gc21hcnQ6DQo+IA0KPiAjZGVmaW5lIEVOQUJMRUQgMQ0KPiAj
ZGVmaW5lIEdSQU5URUQgMw0KPiANCj4gU28geW91IGNhbiBqdXN0IGdvIGFuZCBkbw0KPiANCj4g
ICBwcmV2LT5yc2VxX2RlbGF5X3Jlc2NoZWQgJj0gUlNFUV9SRVNDSEVEX0RFTEFZX0VOQUJMRUQ7
DQo+IA0KPiB3aGljaCBjbGVhcnMgdGhlIEdSQU5URUQgYml0IHdpdGhvdXQgYSBjb25kaXRpb25h
bCBhbmQgdGhhdCdzIGNvcnJlY3QNCj4gd2hldGhlciB0aGUgRU5BQkxFRCBiaXQgd2FzIHNldCBv
ciBub3QuDQo+IA0KPiBJbiB0aGUgc3lzY2FsbCBleGl0IHBhdGggeW91IHRoZW4gZG86DQo+IA0K
PiBzdGF0aWMgaW5saW5lIGJvb2wgcnNlcV9kZWxheV9yZXNjaGVkKHZvaWQpDQo+IHsNCj4gICBp
ZiAocHJldi0+cnNlcV9kZWxheV9yZXNjaGVkICE9IEVOQUJMRUQpDQo+ICAgIHJldHVybiBmYWxz
ZTsNCj4gICByZXR1cm4gX19yc2VxX2RlbGF5X3Jlc2NoZWQoKTsNCj4gfQ0KPiANCj4gYW5kIF9f
cnNlcV9kZWxheV9yZXNjaGVkKCkgZG9lczoNCj4gDQo+ICAgIHJzZXFfZGVsYXlfcmVzY2hlZCA9
IEdSQU5URUQ7DQo+IA0KPiBObz8NCg0KVGhhdCBpcyBhIG5pY2UuIEkgY2FuIGFkZCBhIHByY3Rs
KCkgY2FsbCB0byBlbmFibGUgJiBkaXNhYmxlIHRoaXMgZnVuY3Rpb25hbGl0eQ0Kd2hpY2ggd291
bGQgaGVscCBhdm9pZCB1bm5lY2Vzc2FyeSBjb3B5X2Zyb21fdXNlcigpIGNhbGxzLg0KDQpJbiBh
ZGRpdGlvbiB0byByZWdpc3RlcmluZyB0aGUg4oCYcnNlceKAmSBzdHJ1Y3QgdGhlIGFwcGxpY2F0
aW9uIHRoYXQgbmVlZHMgdGhlIGZ1bmN0aW9uYWxpdHkNCndpbGwgaGF2ZSB0byBtYWtlICB0aGUg
cHJjdGwoKSBjYWxsIHRvIGVuYWJsZSBpdCwgd2hpY2ggSSB0aGluayBzaG91bGQgYmUgcmVhc29u
YWJsZS4gIA0KDQpUaGFua3MsDQotUHJha2FzaC4NCg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAg
ICAgICAgdGdseA0KDQo=

