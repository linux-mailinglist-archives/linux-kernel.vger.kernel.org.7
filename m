Return-Path: <linux-kernel+bounces-876605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE15C1BEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EA215C6393
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06F22F74E;
	Wed, 29 Oct 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="e9ZLNvo0"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022103.outbound.protection.outlook.com [40.107.193.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C791DE8AE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753260; cv=fail; b=HGvDNjQr4hW02by/pjTlq8UxO38sw9MAXDv2LXqBbg1Stqy+2VsGJl8eY8r6fH50o7QmtAWR5B1fA98XhRXYFcgAq9aW6EpaZkXVhYM1Li4DFuliPnRp6dLhmqgkdn8YwQ5fQ4kxc+i10MgbA4gkJWVS1MZ22ecjwmc+hRR5IS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753260; c=relaxed/simple;
	bh=kRDN/pmKMK/vLZrQcjEhBp0edyxhZYNslv9GPYtqC6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E+yP+iGnpWYcQi/NJOYT/cFwPfp8nhx+5EEhIeTnQf6e+bh8dUXSCKRAC6NZN7Yrn8kb1M70WiVuSFUhOomR3XzQT6y6WXfwwwQXU9edB83wXJ4v9M67hP4lp7o+Ec2mHKxaPBgqr69qA5CbygOt/izcaIf3YXTuaj+imeQDdmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=e9ZLNvo0; arc=fail smtp.client-ip=40.107.193.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq4UMy9f1Jt3ysfhyUKbwK/kzr+5W855Alnv3he3uPvGqjE5Lgj+8Amj559lXMxYy3VrqsGuxOO/W/HoKynTtn52+NkDz5pTTP1frJztf4D5y+Qrn3OXgG7O82eiMJsCFDn3xMw7ozGlRG7n64XpYBq7UqfchLekPzzoROId/kKHslyJv3tmIGxSHkjJxYCrwQWDZiXAogIm0UiTzmDYYEUlhQ3qqrdWfe1FmS7wNCopxyBxqCCesL2v+Zvlyol76Rlk9G9FC8pDjHZG2vEbnMbM/rBZc2NGPTYS5mWXo/ZMWJM9CcWGdLk49EbAD5UvBg+joJ3RbkZcK440jXXMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTuGAazX2+1R6Y8NVJlPJpSXc9t9KzUTgZ6EDdxMp38=;
 b=HzW95yDj0ce5KBhZDqEurwV5ZiKgPSslkuX0AD9JQG7FZsiDr8be3dnhAn5yNebIyGHs1sUWGLvjVJOLloGzaFIoSzFzsPhJ+sWkfuYXgvQgizpXlXkP/cyTgRhymA/kA/JResCm0ge6+GikOtCUSDUiADwekPC+O8jjcU6tIuHeCw4Ic2GDlhBOFZV6pw619e5IcCfkP08WuBc0nlWA3ALIXIe+NUxiCcR0Am+O5msH6VxisLFYAS6PZrls706LKyc4yCKPF8gZpcvgCY8HXM+yM4Bh65uUwvEot8kWDYyhNjYvFahkCF1Ff6VoSa6/vQi3LhYDgiuUqRKuAN90TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTuGAazX2+1R6Y8NVJlPJpSXc9t9KzUTgZ6EDdxMp38=;
 b=e9ZLNvo0qbS7LVoen+pGc8kfwL4Uwtb7uviOLxUNp8k+t9TZqEEVfPQPb81ywNuuKPq+cXWpoNQ74/Q417ldE8lV82Q2GtJZnVMBpJ6XT6eh4wUCkSchlmXkVIcXoijww3rq2IhWXPh/V3fRxSzk2T645CLlLt/dAXpFECieHSigMiMCUSQOhASYBYdx/jdN9I821t138pry2lJzkehxKifjKNl3PzISFNpCHzBpxoUZNL58Edo68941g1dnC5oNOcOYgG0FXfC0Rg6HLA8m4XHBqyvFVYvFMZcbWUvxCS2medzoRO+9rp+Z6dPjkUZXJdHEygpX5/q0xUHBGg0gZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9715.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:54:14 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:54:14 +0000
Message-ID: <938a1d18-c7b0-45d6-ac4b-4c1246e08044@efficios.com>
Date: Wed, 29 Oct 2025 11:54:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 09/20] cpumask: Cache num_possible_cpus()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.846126176@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.846126176@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f8a625-1cfe-45bb-3e5d-08de1703683f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1k0emdETUxBc3RBQWpjMEpiZUV5VGYrQWdzVHY3THphUU1QRGNIMDA5Y1o5?=
 =?utf-8?B?bDRuekJtOUpPQUljakdsa1BGL2tKRDVmVTQxSEVZeERIaDNuNDE3SVRYZlJN?=
 =?utf-8?B?Nkhwb1NUT0pIOVNmMDdaR1drSFl6TWoxMkMxNGpmSngrK3J2Y05zQTgzTFR6?=
 =?utf-8?B?OTNOTThGWUhjNGlrYlJaTUJ3aTRFdzFndk1YMnZ3SjNhTzVUSG1TM0FWd3py?=
 =?utf-8?B?U1JxYlozaktzbThrUExraTJEWnVWZzVsOXNyUnZxZnhCMURSZExjWUc3bUJr?=
 =?utf-8?B?R1NHNDhsb2FRSktYOE5qbUZiNlY2ZlFLdUp3NHNqdzVxN3N0TlNvdk1yWXp4?=
 =?utf-8?B?SmdqalFKSTNXTm1EbFBsdEkrNnhaWU5XUUhnVWRDbDUwTVBOUGMwOVltbG53?=
 =?utf-8?B?Tkc3eldwMkZXaERVekRkenNsMHFYN1k2L0RHeE5RclQwci84WCtFem5iR0ts?=
 =?utf-8?B?d0liZmdzeWttd2FWYWZuUUQxaS9CRkhMNkxobVNYZStmTDRzSndJUFh0cWFI?=
 =?utf-8?B?WGlxNVUwK1JVeU53YXJsRkNHanpGRktPRWpLQmFjS2pJcjlvdi96N1A4ZzFh?=
 =?utf-8?B?S0VHVFMxSzE0ZWR2SUVrRXFONjRBL2t3WUUrOUw0SFNMdEM5V05tTDB2STJw?=
 =?utf-8?B?V3NTMy9UMnFBUGVlTDljUUxld3FEQzd4TittdlBUaGhSZ1RBMCtyUG81aldy?=
 =?utf-8?B?WFg2WFp0c3VSRHp3M3JFVFMzckFCNGdoT1hDVDBGMWZYQmRnZU9iNG16L255?=
 =?utf-8?B?M1UwbGlaWHZOd0xjU0ZKbFZYS25SL1NGK01FTEJWVFBuME5CMDRCN1FQejdI?=
 =?utf-8?B?NFBROGVpNDRLa0IxOXJtbDFscU1BelkrV0pnQS9zOWZrQW1HcS9lT2hYYk1F?=
 =?utf-8?B?YzgxOWFZTEdyQlZLTlpRandLRi9PWXFyTkw4OHZOdkFDWUhNZnNtekg0U2hK?=
 =?utf-8?B?VHMwMk1kNDB0MUhBRUNzd3hHRXpSeExZd3J2OW56WU5aSTR5SlppeVU5MDJZ?=
 =?utf-8?B?N3JBUnF2OE9FcHJ6ODJkbzQwNU1VRWNpNTJmR2dwNDN1MENLeklPUEpVZ2Q5?=
 =?utf-8?B?cW90WmFKOUM1d0ZYdjVjM21pOXVVSlBPdlJuRGZYRU1oNnIybUpRUnhRNDNG?=
 =?utf-8?B?TlFqdk90QlhaaVgxUkp1T0RGN1RIR3BZQjFKM1FKb2hUVEllckJCRGJrRmNH?=
 =?utf-8?B?d1QzeCtoTk96QnlxU2YrYW5JWGxUTkNTM1U5dm1XMUlJZ2Z0TTBSZm12dk4y?=
 =?utf-8?B?RTRMNWsyM1o3T2xzaDB3bERkSC9pNlNEWUE3bldITGtGeHRrczZmUERmVUR4?=
 =?utf-8?B?WG5YVzNZeDNkU1h4TzRiVDhTZ1lQTDczemxrMjQzSWd2QlpyS0JpVCtNSFY1?=
 =?utf-8?B?TEo4bE12K1ZxcXNYNDNRMFdrV2ZGdm5sQ0tUOHgzTGlxaGd1V3VSVzRZNlUz?=
 =?utf-8?B?SDhHb2RCc2hrb3RUamZhTC9CdHJWT3dsckhkbGFQRXhSVFNCb3liRXVhWlFq?=
 =?utf-8?B?Rm95bXh6WUZSQUtkMzNiK1B6RkhFU3pBSFJvc3pkdlZaQytyTENNSkk2UTlV?=
 =?utf-8?B?ZnpRa3dCV1RXc2wrMXFMWDFlelF4dUl0b2pyMVhzNm9Lc05jWnNtaVNrRFNY?=
 =?utf-8?B?Sk1WdzRSMWh6VzY5L2Q5VDdCV2lZUllKSWk3MFdHSW9HYWZrQXh2anNmcFdV?=
 =?utf-8?B?Wnk2UUo3WklNMDM5eWNaOTIzU0hneFlKcVRzVGJpbVp6UWx1czJKSE9TOEdL?=
 =?utf-8?B?QXVkT2o2bVhxWjRrTVYzbmQvMU5KRWE1K2UzU3A4M3ZucmV6L0ZBNnlrQkNj?=
 =?utf-8?B?ZUtzQnNUWlBnUEJPRkN0eXFUQUlDWGc2RUp1aSs1clhnRzQwLzJUWnp3WmZr?=
 =?utf-8?B?bHpOcmVtL0pmZGx0b2FXdTRGSmpteFlrd3BIaGdrUmhId3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjE0OG1NdXRVdGliQ0hETkcxdUs0QUI4RUpzSmhvMERPMXdqRDRGTzdQZTAy?=
 =?utf-8?B?Y2ZIWlhjbElLaERyai9ZcEtjYWpoNTVYV0s1M1BTa2I4Q3lWSzZqY24ybHky?=
 =?utf-8?B?UUJWK2tIK0NYYURQN3VtQlc4MlRGL0RaejdkdDNzU3RZRXRLNHhzMFAxSnlt?=
 =?utf-8?B?OHBDenNEZWRWMUplR2ZLcENjQzVXUXYvWVY3ci83RFducTBXTzhHUDVQSzZI?=
 =?utf-8?B?djRnMmtMTUNZTkoxU3RNMWhDajZCc2x6aCszUDl5ZXZBQVNRRDVvY2wrSmIv?=
 =?utf-8?B?MHdKMUJXcGtoaURIejErUlpMcDVvdW5VSVNXYVFOUGwweVhTYjlCd1k0YlV3?=
 =?utf-8?B?Qi9WcVZKTXp0TXdGZUF5VTBmZVp3UEJqNVgxT2RWWmRSNmVUZExsbDBrR3hE?=
 =?utf-8?B?TTROZnpZaW9hdnQ4UmFuaHg0YmJWOGQ5elZCUzM1aEw0QmJnQ3hpYVpzUDR2?=
 =?utf-8?B?Qk11b1YxZW9IWHFuZG11anlHb0hIQXAwdW1zZnBvbjhDNnVQSTgwUW1waHBw?=
 =?utf-8?B?TXJSbGZVSEkwVTAxdUJZRHBNeXJEWmdpNjdjSzF3eUNPZFdzZDRNODBEb255?=
 =?utf-8?B?djNXWk5GSHgzVWo4MVdJTzV3bDJaUnN1d1RYNGpRbWU5ZkcxREVOVmdWZ3Js?=
 =?utf-8?B?VlJ4aWdLTTd4dWZsYTVhM09JQjlUYkpKejBmOGFmT0p5bDFTZWJ4VVdoeFM2?=
 =?utf-8?B?YzBwYmxCa2hGSkd6R3M1UnF6QmFObHU2dmcyd2Q4bmwrRGhWRUgySzVoaStn?=
 =?utf-8?B?c2UzbHJWMTh0QlhkK1U4UVZIV2tmclMxSllKUGJvSmo3dCtCSFlQUWN3UVRT?=
 =?utf-8?B?SmxVaEpMSFI5TjlSMnRjQVlCeGhRUk1VbGQraDZ0dVhXYVAvaTlzTm15bm5F?=
 =?utf-8?B?ZWlkWXpqVVFSSDM3bHQ3Ri90L092OGhsVXk5N2VaRnpPQ1V2bUZkeTFPZWlr?=
 =?utf-8?B?Y3prUFZLM29lU1ZreGd2b1RwYlFGcnBLMVlXS0pFUlN0TWV5Rm5xdmlQNzY4?=
 =?utf-8?B?S0xURHJNOCtsNVJCc1RsL3ZNRG9mbWZxZmcvSUNrREZrdys1dkcyekRLd3Bi?=
 =?utf-8?B?WEd1NWUxWlFabXlDSTVqdG9kdFFsK3JYMDhOUm1acjdRQjAvbXh2eDNzMFFD?=
 =?utf-8?B?d3A1RnlnU1JSbmM3bzgyTTNqWEpUS3d0MjVER3NUeUR1T290KzB3dVF5Rk9Y?=
 =?utf-8?B?ekU3eVVRaURTNWNoaWRFK2Q2VEVZdmVqdGRGMVdxbi9QelZmMXBST0JYYk1S?=
 =?utf-8?B?V2JSRnF1N2hjVzlNQ2lINmovNzI2a1J0VC8wR2dhcDB2NjFGNnFTdFl4dDFo?=
 =?utf-8?B?ZnVPNzJISzJpRUdMQ0ViKzE1VnBjc0Y0ZzVzcHJBVGtWTEJPOG9tS0t5Sm1W?=
 =?utf-8?B?a1ZRUEVIUWl6WnE2WWhwbW5zRmd0cmU5bXh4RUc5eWw4elIrekRDbVNWZXMz?=
 =?utf-8?B?amtBOWo5bTlkNU9mU1lNSk82ZHhBcTZZOWROQjZERFZ6K2hJVlE4dkFRbW9r?=
 =?utf-8?B?MmVndzZ4V3hnbk4vK3F4SEhaeWtkWjJaWi96WDhJczZlWStQb2RsMC80YTR6?=
 =?utf-8?B?UFFqZ2xQRUFDb0oxQXk5K2UxM0RuRGpKaE9ZMU5EcTdqQ0pPcSs5bW5TSEpG?=
 =?utf-8?B?SFZwQkJ1MkljRUpaVnBuUmxBWE54QmZlQnJDYk85V1hORFV3aG1ZMGZIZmZ5?=
 =?utf-8?B?UVJ0NG9HNVZKUmhnd0g1WDlHaXVCQWlPSVlOZHo3aEQwdHp5c3FkZVpMQUo4?=
 =?utf-8?B?ZVRKOVhZM1BBWUpxODFIeUxPanBqclJkOGcvMWxmSjg4WXlleTRIc2xiNkFv?=
 =?utf-8?B?WS9HVGN3Y3VlcnJTalNadEViVEl0VlAxbUxMVDV0V1NTdWlvc3dGdys3a3ZB?=
 =?utf-8?B?TDgwQkFsRFFZZm5PcXhMeWNqdEx2dzZtNkRuRDBHODJoOGlCSXUyK0g5Uits?=
 =?utf-8?B?cHhiaU1yTEsrSVRYSWx4SHpYNm9SbjBPRUdTQ2s4T3dZQTNGQVIxV0FlejNQ?=
 =?utf-8?B?b1RrRE1lTlJVZGxhaHpKRHBLUWNKT2REcmpuWkNhU251dzBNMXlwdDA1Wm5L?=
 =?utf-8?B?UjJpWWw4dmh1M25oSzZ4eU1LZVdrOHB4djNvUGlMZnFMdTZXSUNNTitqRGNj?=
 =?utf-8?B?V0srR3pvbzZ4OE9JbXRocWlFbXR2WmV5U29IU05TQk9Yd1pQSE1pbEthQUh0?=
 =?utf-8?Q?dlYRj7yu9H6DRv/EWuKQIUA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f8a625-1cfe-45bb-3e5d-08de1703683f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:54:13.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9zHSm7nyot0xHme+hheEoFLKbfIT14fwrXfzFNSP02Im18tNMjXG57vO99e+fs1pfhA+xZZKa6He+hwBCHwyY/DkMbABnLfXlZWW0pw9Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9715

On 2025-10-29 09:09, Thomas Gleixner wrote:
[...]
>   
> +void set_cpu_possible(unsigned int cpu, bool possible)

Unless I'm missing something, I suspect that "set_cpu_possible()" should
be marked as __init.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

