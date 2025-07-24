Return-Path: <linux-kernel+bounces-744635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA24B10F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD49D5A11A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD7A285CA6;
	Thu, 24 Jul 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="JlqrlDJq"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E11DF244;
	Thu, 24 Jul 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373277; cv=fail; b=aslUthsLxwhQw0GyDW8angnUXeb9nr3snmzPOrlXaefQo9fdabyP+tBnhWUd8k1DsZeXHENKrnYBwrycssyoZ/cuVjL9SI8sthke1VNcpiXbuzD25Ide+wT65xLK7tIyu+ugLg3OKh+4BSVdrTvHCY8KJLaaOJ0tfIqYcmDbrm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373277; c=relaxed/simple;
	bh=C8fhmhad6a5XtIfOSxVRJKltx54zZgeD4MBK3sRN2yI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m31FZ8OMztihRoxEOhxa4ehB8cNPLJILBNy73pNp/EXi22whspb8DByox15r602FssVwOwEGnCTZG5HRrXvXj/kjukETYlmjOKLVtN7JQBFbOuQnOD84pginBpCUgT1xm6+qOSH7kwklYh2jbTrgG9JXhkF7M0NZ4pKd2odRcfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=JlqrlDJq; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1E1OidAZ/i5O2JMncAgavjhkXZuns6/0DkVinMBim9uaJ7zx/gkQC+VWJPKNBXqUVQf1nPA+FwA27YpoK7hsni9MRGgfO/83MmqCTXb+0f1krfCuRbXOOMjKWw0aN9/RgWqafqj1oPMvPRhyr/Pei+/mTGnw/KJW4HWMxjrEfKtEtTvdu425NTw7uMyyq3UbPSyDKOn9eIPQmV0hV2IzTzJOvC0wq03bj+9NK6KFnhoSnLyGNYaABriJQOToGTDGAsqaYBqgGYgvlMSmAyaj70WpbNa7jla8DSLvUrhpcT1opeBByqTtGucJC4MjfGlMUywOOqKlsO/rDAhE4+e2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK8W6NDBNNGZ8IHgx3fj9sdyOVHw/XskUXlXBBnVeBM=;
 b=P12tx3NG4Cttrf7gHqqWAjF+/d7iZtNt3VuEWuJATYxS145BJH4a7iATbdpy0fDGy6/0CcpDaAIeoKpbdNRdN8N2R99vistkAwfy63Cj79nO2SR/+stuh7Cbt5YjyGcaT5MuaT/SK4Pmy6M9RTghOg5IMzHgdfesgLe3vsTZIlgSu8xTsmGLifiLKOLUWdMGrhtB74hIqarkpE4aWqWCG1O0BmQYQmzWaxPc6E2GjnulDx6AT4uLDZ0FkqVTuprr3lwVlr4BqQvMXrdn24qXPsAwovpBdjyj4RS+8HravB/5YNSn02maW9GwB7N/ii8qLy1Xuu51yX1YNL6LqVEokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK8W6NDBNNGZ8IHgx3fj9sdyOVHw/XskUXlXBBnVeBM=;
 b=JlqrlDJqTdH9gjlf4g7zAgkZT0sVqyGoG6mvhgjDk6fNI7G8Y6RFU/AKS6AsCeD6qRz1tw+teetXA2ld8LdmIUajYi9c78zVeMjNm48ofpsPq5szHbC5Paz1fAnkn1iz/TE0LAhXCzk+h9UzXcCi9f23JSuZnn4nBkzj+FIJvmqRwRUnhI3VE96lTbmuTCNh9NdeiaBBVRhjCB9bbqbsyIIQ/2qtPUv9rVsrwVaCFZPtYzCOOShF9q0k48mjAg9pRWT65fvvI29RSgJxi8DjI30SmEFmxMinM/hZitF76MfPtBZVbWtNhsgN2PBxhZZrjuDOFvxuTw9g8AqndBfTUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by DU2PR07MB8377.eurprd07.prod.outlook.com (2603:10a6:10:2f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 16:07:52 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 16:07:52 +0000
Message-ID: <d9bbedd0-b31e-4803-a070-ccb58e3186a0@nokia.com>
Date: Thu, 24 Jul 2025 18:07:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] genirq: add support for warning on long-running IRQ
 handlers
To: Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>,
 corbet@lwn.net
Cc: akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, bp@alien8.de, arnd@arndb.de,
 fvdl@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org
References: <20250723182836.1177-1-wladislav.wiebe@nokia.com>
 <aeeb783d-d921-450c-885d-c8e8b328f81b@kernel.org> <87ldodrkcl.ffs@tglx>
From: Wladislav Wiebe <wladislav.wiebe@nokia.com>
In-Reply-To: <87ldodrkcl.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|DU2PR07MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 3149e2ed-68da-49ad-de33-08ddcacc3e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amdxQWdNd3JXOVBvL3ZuSXZnQlhpTVNwZS8wN3lCa1lsTVBIcmQwRzlHUWpy?=
 =?utf-8?B?eDFsVFpQaE5IdzhRQmFlS3ZuZ2ZHSTgxcUxqYk00VlZiSEZ3dzlXd3VXVXRQ?=
 =?utf-8?B?ckcyZlIrdVFpRmlVTVF5RXl5Yy82MER6cnhXdHBOWTk1UEN3MU9MUFZ0eFJP?=
 =?utf-8?B?a0tDQWdXV0RaSVErNm9GUktTSVZObEJ4VzdOMGRDREloTllkeHpZZkxJMUNO?=
 =?utf-8?B?M2l3SHJSUjUrQUM4d1FkSFVHeHFwOUNJUmNZRzIrQUFXN1laT3d6cGYyMVVr?=
 =?utf-8?B?bEpIUU85eFFzSWpEZ3FCNmtuTE42aXFkenNmT09FUHJRaVRLckdLWTh0dlNP?=
 =?utf-8?B?SnBjYldXbCt5aUdkUVVPRW5meHhNblRHZ0lIWnpGUGgxK296d1h5ekM0WGg5?=
 =?utf-8?B?WkVJSDJEaVNLSjY0cWhtWmdwYWljeU9xayt5emQzM0NlZDhqdHNVWUVnZS9a?=
 =?utf-8?B?alRKWkNNRFoxSkFUclFQdEtGTFZHckRabU9qM1dZTSt1VllnU2hNbkM3NVo4?=
 =?utf-8?B?a2pkaFJnMHNISVI1MWRCSllOT0YwcUFNMDNOZFZFNHRmZEhmdWQybzNNV3FS?=
 =?utf-8?B?dk1ieTBSNGxUbTRDdVZSVkhQcUlWOUF0RFMvVGtaKzJxeWFTNldBb1N0WlpM?=
 =?utf-8?B?WWlza2FEZ3lwTGk5eVEzKy90WUVSNVozWlpXVEVMSE5GVXJTeGFGam5YK0Rl?=
 =?utf-8?B?anBlYlRSYWVXN1BkOUozaUZTeEN4M081NHRZbnZQV3NObzU2bkRGeVJTUkFp?=
 =?utf-8?B?NGMzUlVjaGZLbzRiNlFQbXpyamZvWHNYTmFTSERXK0ppNlRpVWtLY0ZnSm9S?=
 =?utf-8?B?aDQrckQrVHh6NjMybk5QUE9LZjE1Tmc4YzhJcWVmRGtmNGtkZEtTbm1xazE4?=
 =?utf-8?B?TklUMHBnWWFFTmxTYUtqRnRSZ2tBWjB4WGRVY3J6WDRPV25sR1A4NEZvNXNF?=
 =?utf-8?B?NDZhNEpKcGlyZnk3bXJRUkRIT1A3b1FMYTNCSjcvZHRKVGVleDNoaVIzbWJr?=
 =?utf-8?B?MmFoYkNWQ1JrbVJQOVlpcktib3dRNmgwVDR6eXZmWkhiVk9XOXUwd0F5aE1R?=
 =?utf-8?B?T1E1YldqSDJocXZUcHF2aVlnWThINGM5UlhrOGhHbnZTZVlyTE9tRlRKUE1T?=
 =?utf-8?B?SW14VTdNa2hnTnFEU3JBT0FnUUVEVFR5MWJNRStVVUxKcmdmTTByV2VMU0Jk?=
 =?utf-8?B?RFpLZzhJaHo0N3hmcThBSmNOWDhsMXRWdm40K1B6L0VheEJFbFdCV00zK00y?=
 =?utf-8?B?cmxpMzdpWTc4L3psTmM3a1BBdW9XSVZVNTF2YVFaZ2FqcjdvWFBBZ1Z0Yy8w?=
 =?utf-8?B?SlZKTkpFWk9pc0F0eG1CNXozbFBKTGtMUzZmQlg2OFlFY2ZyU1V4YVB5VjNs?=
 =?utf-8?B?ZHlUTlBLT3NVSUUrSktPalBGbXJpNklpYWI3RVRJSnEzdVB5UzlEdHJNNWRu?=
 =?utf-8?B?VnlGZE9FelRjSlAvMDNUK2g4UUVydmZiMXppeGVOMXh5d3BQTXlpb0x3Uk1k?=
 =?utf-8?B?V05YcitzOHNSRHIrQW0rUCs5UzBVOGtocllwMU8vanVlaW9pUHRWZCtsaVNB?=
 =?utf-8?B?eDk1MnRBT28zTmsrVG9TbjJHdHM1V3A1ZENmM09mTHdwQWZydXJKNisvZ3Jx?=
 =?utf-8?B?K20rYW1nTEdHM21EY0ZKMkI2d1JNNGgwMGtvM0hidGlMemltaUlwcWJRVVd2?=
 =?utf-8?B?ZEdRcEZUVzdacWtMd0FjaDhRS09sVzJiRytCT1B3SFJHUExSNXozZWdYTkxJ?=
 =?utf-8?B?Ym5ObHNBUjVJV3U2QnJodVM2bExTZVljTU1wSmtTSlFndGRHRnljbDhKRmts?=
 =?utf-8?B?OEVZL3ZGTVAxK1VmOUxOeXdCNXozblpUTE1XbXczbnZXTWdOc1BWUTRkZGo1?=
 =?utf-8?B?M1VWVklURE4wU0tRZm5seGVvTHNsQUtoQjExS1NucWRxcXBMYUJUSkxuSWcv?=
 =?utf-8?Q?W02aXPrv03s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFZUbnNYbmE5Z0E4ZGw5TzgrZVBjejNSWktPczBpYVhodzY3MVdZZFRhbUdX?=
 =?utf-8?B?Z3FkNW53OFJZQjhiZlJFeGZ4MmJ5NzVIMWJDVnQ3dnRBWGF2SVVuMGZNaU9C?=
 =?utf-8?B?U21DVkd0L3JudE9haExrVDRPV0p0NEQzTEpJVEJhcWFNMTdQWC8xOWRVdDZQ?=
 =?utf-8?B?cUpoU1VnWS9qYUU1Znk4cXJYb2VWS0VlVWpUWkhTdXMxcWhTcjJnQkY3aWU1?=
 =?utf-8?B?R1pTYTJNM2ZVMDNiajF3NEhsdDRQQ3NtSWhoa0x0a0puTHZxc241SDZaSkZB?=
 =?utf-8?B?K28wSUpBU0FZcFNCalVodlZVbDNXcDhDUjl3TmRma3o0U3lvckdhaW1ETyt3?=
 =?utf-8?B?aGlLRzFSODJLQWg5Z2lZb2MrZG8vTVlMVlM0YVE3WWRCckUrR2R5WEplT3dn?=
 =?utf-8?B?K2lPQWczTHk5YnI1TjhqeERXSmg4cEtMZjFSVGRpNmFrdXZrbWl0SHdWVTQ1?=
 =?utf-8?B?K3R0Mm5LM2paVmp1RGFzWXRPSmFYREZVTUFZZjZYblNzeThIeW5RSy9UUmJQ?=
 =?utf-8?B?anpLem91MlVQUXZjdWlFR1VlMytIRThwV2w1Zm10dCtnQ2xaYU9ENzZMaExQ?=
 =?utf-8?B?UklEZjcxREVodWdNS3haTTdoZTlEa1VhUWlqNmQwVEtva1c1cFVjR1Zyb29L?=
 =?utf-8?B?RDU2bm91WkxzRlRtN1JrQitkUHRyQUtMakE5RGd2ZEx1REUvUWw1OWIwdzVY?=
 =?utf-8?B?YkhmbHZqbnRqMXA1Zmg0b3RMV0gzRDNCQlZla0taOHplRmNHbElrZ1hidDl0?=
 =?utf-8?B?TC9pNVZ2SzhpNjZScml4TDVGb2NzUU9yWVRETUtPcCt3K1dDa1V5QkJHSFRy?=
 =?utf-8?B?aEhGVTFPckJEZVV4aXRDRGdSamRiV1pxRUh6blFtemlSYjNpQzE3QllJQ01R?=
 =?utf-8?B?bzYycVRzQVNseEozUE5tdGtOVHdmVmN2THFwMktBdlNEZEtzNlNDZ0dIdG5N?=
 =?utf-8?B?NGdNUHM1MStLNG9QZndOYXlpZEhxVVFhY29lWHBjQjRsN3VONXBhYTh6YnNl?=
 =?utf-8?B?eHVRd2J2NTZieG8yMFRaVjZkZmNVUTk4TlRpcXlaODVqYzhnMzRZMG9ENjd5?=
 =?utf-8?B?WDNIbHBaQ2FHOSt3UG1KOEZUVTdGeFY4N0JxcEpXL2o1Sklta3o4b0ZCOU5F?=
 =?utf-8?B?anZRTHh5WnRCNWZBQjBqS2xZKzRacXB0YUNiQ0xCMlFtWHRXbjNBbSs4SE5U?=
 =?utf-8?B?Rjk1K3pSOUVjV3RoR3VkL0E5SzhVYzBvRUVQVURGSWwrV2VFMnVDcjZCblo0?=
 =?utf-8?B?b1ZJeVRWSEpNRHBLcDVPc0wvMlU5Qk5SVGpEMXp3TjBSSDhDN21VT0Z1M0p3?=
 =?utf-8?B?ZVcrMjJlSDlUN1RkWWFDRmVzTitXYlZhdlVrNmgvZ1pzTWxXaHFtOTBjS1JS?=
 =?utf-8?B?VGhTK0tBRnlvNDV0OExqWWE3Mk5WWER5MTVIYmJ4alpCNW5MWVMxblJzUWlw?=
 =?utf-8?B?ZnVQZDV1YU1wRmdwQWE1MDl6QjdWbVB4UkZ6alNVWXFkN0t0VzlZNmRKajAy?=
 =?utf-8?B?SmJJdjN1eFRrN2sxa28rUS8xZGhpZGpqL1VnTzlHNGRoT09mZTRFcTlkR3Ew?=
 =?utf-8?B?ZEJMQktEY3ZFWlZkczdOK0g2QzUvWklCSFA3dVVDYmpsK0J3aGhaOU1wTXVZ?=
 =?utf-8?B?VjdnOUdadHBTOVl1NjA0QTBzV2EzN0JWQUtnNHNHVUxiRklYRVRKMzIvMDNu?=
 =?utf-8?B?R0h5MENtYm5QZzZHTU5PVG03MFZabGFaQ1JES2NRRy9jQ21Jb2UxL3Vma1hE?=
 =?utf-8?B?T1diSXpTZ1pTbUtHaGJXMnllai9ZM3dzS3RwRzJRZkpiek9DdVByTE01RHBO?=
 =?utf-8?B?d216OWR0VFhCakdqRGt4V2crakVwQTVTS3lIYnRwK0c3eFZab3pEbFBxV2Vm?=
 =?utf-8?B?eHFBZDlSVng0aWlaWXRTWTh6YytDanB3L3FqeTJTWFY5U0tWT3BBVjVKcnBo?=
 =?utf-8?B?eTF0cytjRGRIRjdxbHQ3ejBsZTJaSU4zQzMxREYvZmk2ZW1TeUhUSlpOVno4?=
 =?utf-8?B?Ujl5VU5sL0pJQmc2Z2pTd1R4UDFpSDE1QTJhaUVOUGlaMHlYS0NZQmQvMjVV?=
 =?utf-8?B?ZjF0c2tFYVRiRm12MDRDa0E5WGU5bHhWaWh1UHlRVEh6UDVqZjQ3ZllCWXJw?=
 =?utf-8?B?R2NNN1BtelBNTEh5a1dlRVlIRzMxS0dDQ2hiMGRXbjBpV05XVzJ4ZzBDSWp1?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3149e2ed-68da-49ad-de33-08ddcacc3e34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 16:07:52.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nq24JNzuEopCXsO6VqF/9I7mAgNNFqB9Q8wOyOogMn+L7nnctqqEsRiQItXDC1uqnVa6TCF0B8UZ5uzESyejsB/gWrxeuEtWX468nxh0fEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8377


On 24/07/2025 11:47, Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 07:18, Jiri Slaby wrote:
>
>> On 23. 07. 25, 20:28, Wladislav Wiebe wrote:
>>> Introduce a mechanism to detect and warn about prolonged IRQ handlers.
>>> With a new command-line parameter (irqhandler.duration_warn_us=),
>>> users can configure the duration threshold in microseconds when a warning
>>> in such format should be emitted:
>>>
>>> "[CPU14] long duration of IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"
>>>
>>> The implementation uses local_clock() to measure the execution duration of the
>>> generic IRQ per-CPU event handler.
>> ...> +static inline void irqhandler_duration_check(u64 ts_start,
>> unsigned int irq,
>>> +                                         const struct irqaction *action)
>>> +{
>>> +    /* Approx. conversion to microseconds */
>>> +    u64 delta_us = (local_clock() - ts_start) >> 10;
>> Is this a microoptimization -- have you measured what speedup does it
>> bring? IOW is it worth it instead of cleaner "/ NSEC_PER_USEC"?
> A 64-bit division is definitely more expensive than a shift operation
> and on 32-bit w/o a 64-bit divide instruction it's more than horribly
> slow.
>
>> Or instead, you could store the diff in irqhandler_duration_threshold_ns
>> (mind that "_ns") and avoid the shift and div completely.
> That's the right thing to do. The setup code can do a *1000 and be done.

Excellent optimization proposal! It has been included in v4: https://lore.kernel.org/lkml/20250724155059.2992-1-wladislav.wiebe@nokia.com/ Thanks, - W.W.


