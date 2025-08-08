Return-Path: <linux-kernel+bounces-760662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B30B1EE5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CB256780B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89C218EBF;
	Fri,  8 Aug 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1FFz9Mvp"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E561DFD96;
	Fri,  8 Aug 2025 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677667; cv=fail; b=B6rMfrBHluSEdu8+N0HEDMid77lCmjhxAYCOAATxCjet5JAIxt32+5e+LehwY6wzOI2BP7DEQhFiChoJK2/F+3h2wz+3EuM8DjkRtfVMv7g9+ZrA4/2eJ8Sea72WSia6bflnzuVkne4ew0yiGP5AfsIRr2Z0+nTicYaWvR5+caA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677667; c=relaxed/simple;
	bh=6NAo21cnc4ZTLax8fvW9tnzUq/b3qH4pjKjhKBo3YE0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OfqOUtJWvIzc9enuvd4iA14idbukBesT+IqE1T7RR4q1hrypm3j0lGIKe4aWngzjdX8S2dNPE0rIf7QY7ZFLTYxSn51wpq517Ii17dRT++h8RqaMQtYxdo0V2VXrhVCV7PPoCjEeJQteJpjg2fXci1v2dYKUdtqFjo14nGjqJ8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1FFz9Mvp; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRztrvo9IoeFjOlOne+A8KL0WasQluBqYg44E8VvzYq5zUr9TOhAJWVRsZNFxvFsMasF1iZx/3EHL6TQk+3AwqW9/rAf2OVdKiuF6p1a5rPZlReeYUMwFlUG2UWcktBXF7V10XqamXYIpBz6HtrEUu7+HKcd6zQS0jxLq5AftImjVU47+n7OhsX7CTD6AfgwjUeUXh6KEIwfwExE5kMLqpG6dMW9KOBUfdR7DielgrMKPYSM2x/fNd0pJGwKDFBGkf7fgG8o1skbkNX7IThOx83BF5aG9Lh7GGOEbQJBWMM3M79nEyexC6kbIKoKKTt5Jh17DmDGfxRZexBjXRITmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2SE2gr+smUMeauTLoc/IyTTOlmPTFvXns3HeLxdb1M=;
 b=nXCnZ5WrW1u1am955liNcw5CfzcnIKNuDUldnkl1ENgK83Z6pWhz07eJBc8vjl/30UiTi0Oob342YNTLgZUpphhRjWe8ce5rO49ljCWSuUdqTUNwPbdcvhdPLelNn8I40zy7X8/VqWZQ+j/0Qu1rAiI+3tIx7TkCInoZe+zhuSNHpw3pTjGCs6eNHB3nvWwu1oa+uXmE99+h5PSp96BXPg8p0AwkvpV8RBy4kZftp89pPSdJrHJd9+q0TeVMBOX6BHaWF5QBxUM5jBmwrabxw7sFbu1QtT0ddfTy9TGbpH1B1/2+m6r5KRvhFyOZ7u0ua0u2IopPNuGSj9mR2D83Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2SE2gr+smUMeauTLoc/IyTTOlmPTFvXns3HeLxdb1M=;
 b=1FFz9MvpJoAltt/6SBgXJwXat1T7z7iK/WxOpvDeDz9aIvEbTg5uuYqsyLlqfD03/G+lR43MYJoTaT4/XT3xaQq2Gy23V9cgthQIFtePQ4zDKAcjkZqnKCra56wZt2erTeShW6y1zRhphV+jSHv7WDHR3oGIYYgVYB+EKbDBcf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH2PR12MB4085.namprd12.prod.outlook.com
 (2603:10b6:610:79::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 18:27:42 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 18:27:42 +0000
Message-ID: <e3234cb0-2c2d-48d3-9e48-2c9cb5e02d32@amd.com>
Date: Fri, 8 Aug 2025 13:27:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 26/34] fs/resctrl: Provide interface to update the
 event configurations
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1753467772.git.babu.moger@amd.com>
 <15ecac1be290452ff119f67f640c26b8203a4c01.1753467772.git.babu.moger@amd.com>
 <9887b44b-4813-47b8-86aa-ba72de3c96da@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9887b44b-4813-47b8-86aa-ba72de3c96da@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::35) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fea33c-9538-4825-9843-08ddd6a9431b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHVNY1NqbkFkLytRNWJ5K0dlRUNwWitoZzdLUWxRVWdYenZaczdrZjhBZ2dF?=
 =?utf-8?B?Q2tBTjJ5UTJIZkNGKzJxYU1FY0w2WTU1WUN4cTFHZVZ1allUYzMwR1lLQUc2?=
 =?utf-8?B?MDR4S0Z1U01IVEJxK3hucWVzT3hWQWFJbGViRkwrbFhnYkN4V0taTGFOak9m?=
 =?utf-8?B?UFYwZWtkQ01zSnJJaCs0SXROWlBmUE1LbkovaHRYUDhPaUllUlhoQ0VlNysy?=
 =?utf-8?B?VTVwNGdRWGlHdDZGcnpGTDhkdENvMktwSFNSV0FISVdkblpyY0poNFpJUzZq?=
 =?utf-8?B?U1hnK25udXBnK0tJbUl2NkdXdGJGUXJRbC9pTzNZVGF0MFp1enRndkZTbXZU?=
 =?utf-8?B?M3hqek5xOThvc3RwQnZmTFZ3Z1QvMTZqZDM3RUUxWGdNZmR2eHNqU0hOcXpY?=
 =?utf-8?B?N2xDL1cza0t4Qk0xRTJENFUvZHcrbC9JODR2TWowalRvWFArSldobzhWYzRT?=
 =?utf-8?B?VXQwU2FOdFlQZVFZVzJnSU9vM1NzN1NqQzhhaHdGNG1ZSElUQ2V0TnZyVEo3?=
 =?utf-8?B?Q1Fidmh1NTBqSE4zNTBwM0NJdVFxVVl3UUVQN1RyRlJZZGVpc1gxT0FWTHZC?=
 =?utf-8?B?L0w2VGdHQjNSUWM5S2tEMkRUQTNONi9RTS93dytTTU5DYTA2UTNGaGp2eWFS?=
 =?utf-8?B?UEVjRkZDVUFVSlB2K3I3QlNnd2JISlIzWFhtamdYeUhwczBYaVZnT0JteGdo?=
 =?utf-8?B?bkpRZkRaYVY1Sy9PajZVMG1sN3d5Sm5Pc0NoMzFJQ3h6VkNXcWVBNVN0YkJu?=
 =?utf-8?B?OVk5aUFjQ3lkaWxxS3o5NitwY0FmZ2dxdEl0TVQrM0drTWUrNVpMdWdIY2JW?=
 =?utf-8?B?alVIUlRLVzlNYTlpNzJmZHF3Y0RiNU5vUVkxZWgrTXNaRi9NUmdKYTY4Mk5n?=
 =?utf-8?B?OXRVL1BLSUJuVlgyRkxmVmYwNFduK2w3TTQ1NXUrS0xnTDV2QWhMTDhTb3BU?=
 =?utf-8?B?YmpjOVJGQlI4MnQvbkVsbHFhQ3h4aytjbEVGWVhIWHUzUXFxOG0veVQyMWRT?=
 =?utf-8?B?ejY0MmZ0eGFpbXUrcHVubXVWMmY2YUVvOExQbUhXK0xPd3FMRHlDUkx4Qmta?=
 =?utf-8?B?ZkwzTWFNejlHZnd1WHQvUWtxdThzVXhROEk1TzJDRXJTdFk1Z3lqbU5kQmF3?=
 =?utf-8?B?Z3loSk9pMWFpVE1oT3VMNmlObmUrU1R6ZlBycW5xakpJcGF3WmtDaWtOUVRl?=
 =?utf-8?B?YnRRUWdyanpwcDZLMkNWZlpLSm4zVXRPcm5ZcTVXWVgrWkdHK0o3NjQ4elBN?=
 =?utf-8?B?am1XRVFJQ3MvSnZSbDNpdGMvdHlKU0ZrNVQvOUNWSWQxSGtDM2sxdmdtbEwx?=
 =?utf-8?B?alZnRkgzNTllSGpxMmgveHcyanIvWXdUcFM0Sm1hMEs1Yk9NWU5XTWNTL3Jx?=
 =?utf-8?B?N1NCNm9tb3Bxd1ZVVjYxaDhER3ZnR2dhd1Q1WUJzRXhndkw1SXZmQjNaV0tZ?=
 =?utf-8?B?S3pCWHJXeFBISzJ5Uk55ZEpQdXc5RWEvZG5lcUxrNmlURFBmbExtMTFKaEZH?=
 =?utf-8?B?dENEK0NmWmdwNmtpRDY0NmtkS3hYQmRwWk0wbXNRbnJwcHVxUDNFOVhiWTgr?=
 =?utf-8?B?RVFYQ0pCb3BZR01ETlc0Sll6Q1hnOVZrb1Vpa0lVakVpemc5NHM4Y005dzRX?=
 =?utf-8?B?YkVNYWRSN2NzNzdvSzVRLzEzekg5TFdsNytkVFhqUC9QeFBQRmIwTFNZSThw?=
 =?utf-8?B?Z1pMK2tqZXJoM0dzbVhzaFBYMVlsOGU1MjB3dk1zTW9MclZ3cnpzeWtPM2pP?=
 =?utf-8?B?cEVubjloYmppY1JlMzl0VUhoNmhsSjVwZ3lnZzU0dEZ0emgwcEk0bTZOZHpR?=
 =?utf-8?B?L0d0Q1ZTb1FJaGpHUmhXWW9nMFJNczVHQUVNSnpnQmpuOGE4NGRLbytNK0Np?=
 =?utf-8?B?UXB0TUl4WFBlOGlpSWtqRjdMQm1TbitJbEFYYVhKemkwVTlaTk5EYUZHSmhy?=
 =?utf-8?Q?6zZE4+MqEZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VS92c3JFNXhVVVZtZ0ZNc1FnR1pGZnZNV2UwTGVtNzdLaHF1QW9UdTdIdUR2?=
 =?utf-8?B?OU53MXVzeHVoWFRnVSs1Q08yWnpmTm03cDhTVGhzWHdaVXJWOHhlaWt1V0FW?=
 =?utf-8?B?U0ZLTXgyQXVVNldEODV3dEtvZmJqNndxODR5TVUrRU5OWnNFQ1Q3OGM0cVJx?=
 =?utf-8?B?MUw4RlRwVjVwT2FLUTdiS0dVWlF0dnNZQ3ZBbjRjdXZCMW1mQmdNOFdHbzdG?=
 =?utf-8?B?T2ZuOWpIbEpQMEliRGZxK29kWXFtZEdHWVJQOXI0WFlMb3lncEowUm93ZWg3?=
 =?utf-8?B?aXhnTkk5U1hqZVlHcmFKSldNenk3RDBCU1QrVk5PaXJRdmY0QjJ3MVhPYm1o?=
 =?utf-8?B?S2JGUVVHSzhaUWR0ME40KzlhZ2hobVFTd0xLaXdzNDVNNUxXMFROakZjeith?=
 =?utf-8?B?bmI3Q3E2b1N1YzJ1bVJ4cUk5ZG1NcU9jU3VjRGxUTXdjZzFPOWdSeWM2bkh3?=
 =?utf-8?B?ZS9IWWhhTVk0TEVUV0h3TWRYb0JzdCtuc3VFWUxYYVowdFZ3Rit3QWxrTENF?=
 =?utf-8?B?WFpYSlI5SE5pS2RjcnJWdWxjUFNRdXJjdmdaN1o4UDBoUG5HTDIxM0JqdTAv?=
 =?utf-8?B?NWh6ck9MU0JCbGpKSDJoMkFjd0k3cXp2aVd4ZG9HQ0F4RFFJOGgwQklscWJR?=
 =?utf-8?B?d2RHQzZuOHBPejY4UUplYkhMOGFEYkRwOWFOdFFEc3lnNVlCakxsaFVTenA5?=
 =?utf-8?B?NndwYkErY0M4VGVjVDBieGRicDRnS3lLNVBkUzNkQ0RGbWZYLzZJbnQ3aUFt?=
 =?utf-8?B?VW5jQ0dqMFZPSFVjeVlEU0xLQjZWVXIrcm9FdFI1bm1VZkE5VUovd1hpZDBj?=
 =?utf-8?B?MHlBd096dXlJUHpVUDlJMlNmYzZ1emM3R09yeGgxK1czaW9JL1AwRjhINlln?=
 =?utf-8?B?TTFCc0dxL3NyMHhHR2pORThSU1g0cGVoeXViL0xBMHE1QTBXZytMc3loNmsz?=
 =?utf-8?B?bVRkTmRqSmhoMmcxTk12bGJxZ1dWSVhJd3JYUXNHdjNSVE8ySHRVWUpqeDJJ?=
 =?utf-8?B?UEhjaVVEL1dUd3pCbTk5Q29kemZBb05tSjdXcUQ0dElTWnd3L2hzeWJpYW1I?=
 =?utf-8?B?cTR3WXZxa3ZTVUd3a0srVXNlTGoxZEJoQlc5bnovT2hGZzBqM2J5ZUhOenF2?=
 =?utf-8?B?bFJRUDFkMFVSTHI0YmtnSW1velg2Q3hsSDBCK3ZheXhYVmpqL0xFSVZOTlFk?=
 =?utf-8?B?TFZaYjJTNWVuSHZNZkRucTNHdDg5UkJVNko4QzhPdThEa1B0MDMrbExQbFlT?=
 =?utf-8?B?NFlmYXFkenFlaFlSSG84MUpHWkJabmE1bUNtSW9pR1BHaCtIZDh3cHBiajBp?=
 =?utf-8?B?Kzhlam5CNGRlcW9tbmoxZWhzUVJlR0wvSVZVaklQZUlhc3VPREh2cExhbHEx?=
 =?utf-8?B?RUlnY2lFY20rSm9QRldQVjcwRnJzanlXMVBjRnBzRjdkYmlJa3VIZ3BSekNv?=
 =?utf-8?B?NVFUMjJvSjhhNFJyTVorSFlJRCtPbmNSUC9ZaitoUFhnRGFwNWRsMUhJREhR?=
 =?utf-8?B?djMyN3loUzZ3R3NqSnB6MUZycGpESmQ0NzZtQmpFdVZpeERxRXZraDBFNEZ3?=
 =?utf-8?B?STU0eGQwbDN2SkhLNXVWUlA5K0IyYWFVWlh2VEhuY0VadXRPRzNDc243RHQr?=
 =?utf-8?B?RE1RQU1uL1EwOXRTeUxJRDZFRG1XUjIyUXhqSUpnTy9XdG04R1FOeVhRRTMr?=
 =?utf-8?B?Mm5pQ284eVNEak1CK0JtT3MxZEF3N2pOY1Zwbi9sSzBiM1EybFZDb3NVcW5N?=
 =?utf-8?B?UlFtN3BYSUQ2SldzVHBacWVwSXM5Ums3VWhEdytrL1JpNVN4YlR0MXBwdUZP?=
 =?utf-8?B?czU5OEZMdTMzb2Z2K2p3ZTRmWGVpYVQ2UUo3NFBqZE5OUGZXQ00xTnNNS2NM?=
 =?utf-8?B?TUxPdUZUUnVOcG9COHFMbTBZOVc3eExQY1d5VUUyMWd1Rk1QSlBTMVNDMlBI?=
 =?utf-8?B?clppR3piUGRYVDIzS0VwTElmV0M4K0dINlFDQXNmbkJILzhRNm9PZVRLeXNB?=
 =?utf-8?B?dTI0N1NjaHlsbmVQdmgxQm82b1lUcytMSG14YmRXalJjeXlISS9yS1FybWJB?=
 =?utf-8?B?eEF4aCtVT2JhRURPbWJpdUlzL2MyVGtkMGs5MDVpQ243VmpobExWUjBZVFZT?=
 =?utf-8?Q?zqiara+vCVFe1ej01J5+gCjMW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fea33c-9538-4825-9843-08ddd6a9431b
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 18:27:42.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBixibEDxlQ4aWDamVGkFQuLXuvdDF6/sCHmnHaQ9uXHEmNcUI2bkEzui1eUWgpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085

Hi Reinette,

On 7/30/2025 3:05 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> When "mbm_event" counter assignment mode is supported, users can modify
> "supported" -> "enabled"?

Sure.


>> the event configuration by writing to the 'event_filter' resctrl file.
>> The event configurations for mbm_event mode are located in
>> /sys/fs/resctrl/info/L3_MON/event_configs/.
>>
>> Update the assignments of all CTRL_MON and MON resource groups when the
>> event configuration is modified.
>>
>> Example:
>> $ mount -t resctrl resctrl /sys/fs/resctrl
>>
>> $ cd /sys/fs/resctrl/
>>
>> $ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
>>    local_reads,local_non_temporal_writes,local_reads_slow_memory
>>
>> $ echo "local_reads,local_non_temporal_writes" >
>>    info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>
>> $ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>    local_reads,local_non_temporal_writes
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
>
>> ---
>>   Documentation/filesystems/resctrl.rst |  12 +++
>>   fs/resctrl/internal.h                 |   4 +
>>   fs/resctrl/monitor.c                  | 114 ++++++++++++++++++++++++++
>>   fs/resctrl/rdtgroup.c                 |   3 +-
>>   4 files changed, 132 insertions(+), 1 deletion(-)
>>
> ...
>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index e082d8718199..e2e3fc0c5fab 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -409,11 +409,15 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
>>   				  struct mon_evt *mevt);
>>   int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
>> +void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt);
> Is there some code ordering issue in monitor.c? Looks like this function
> is only used in monitor.c so seeing it here is unexpected.
Yes. Not required anymore.
>
>>   
>>   void *rdt_kn_parent_priv(struct kernfs_node *kn);
>>   
>>   int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
>>   
>> +ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>> +			   loff_t off);
>> +
>>   #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>   int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>>   
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index fa5f63126682..8efbeb910f77 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
> ...
>
>> @@ -1193,3 +1264,46 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
>>   		rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
>>   	}
>>   }
>> +
>> +/*
>> + * rdtgroup_update_cntr_event - Update the counter assignments for the event
>> + *				in a group.
>> + * @r:		Resource to which update needs to be done.
>> + * @rdtgrp:	Resctrl group.
>> + * @evtid:	MBM monitor event.
>> + */
>> +static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +				       enum resctrl_event_id evtid)
>> +{
>> +	struct rdt_mon_domain *d;
>> +	int cntr_id;
>> +
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
>> +		if (cntr_id >= 0)
>> +			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +						 rdtgrp->closid, cntr_id, true);
> Should non-arch MBM state be reset here?

Yes. Added it now.

Thanks

Babu


