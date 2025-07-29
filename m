Return-Path: <linux-kernel+bounces-748757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E002B145B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C7B171F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0211DFDB8;
	Tue, 29 Jul 2025 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Pxpgj6ME"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020128.outbound.protection.outlook.com [52.101.191.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F961DE8AF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753752014; cv=fail; b=rh1hptkXv0nAQDoRYSBOWSkyrBPm16eMs8YjuCYEDLSS4E5gikJ8sxAX371VLo3SD3TuHSEmifOrgZVnnOqIE8DYg6wwur8S7ptVoeXH4sZvdn0NNzVOnrT3gye27Rnyqo2FJojabpIa67FmL5Tb+rug6brn52Xd0t5ocE/JCls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753752014; c=relaxed/simple;
	bh=FEALpYa1U7cgnXLElwnhPW05kB8skXTgAAWKDfU51AY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tb5+ivM8vKY6/tTwZF3YL02jzLgWX27YtaJxW0lvgWj3Xq5mbirnEmkRLZm2l9fL1WRCJyueekcTWVe2lYsJKxF+Ld1KQlcAK80s3OPqi6rYQOTtspvDrvK2DRWw8lHog8w3FrnN0MAOCyWjLPVucXDSsqjY7dcTIS76GxR+A9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Pxpgj6ME; arc=fail smtp.client-ip=52.101.191.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjOA61IcIGeTdNqJFulIKCwp6ioFTfQBpJ2b2mm+M40Iwvf691Uk3OvviU8S680A2vlYWdaBgjW1LgwpL37hN/qzIGVxU+xOjye4/ywN+Ode72fxm1emJ+iovdrdW3Ft2W+fiLe1oUUIOV4QipEeYem3ubYOUhUP5iHKZsHM7SEYKfaT1spjC9rrJTMCfV6I1qOZUiLdnvNKSEff2R2wuNMy4I7VccafU9f1/zq1++G3LiRij9agP/0DU2K7kKKwVjC9unjaoVEgP3mTEq5W8l3wyQnDT2kmFZWiMsKwX1sLQ2aFlPpR3h+81rcPfRrgAn8cwTMo8ECTSavwyuw0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTM0ZfGdmmSDSZ2p/B4A0f+boVuG2rb7QHtBgIbTExw=;
 b=QUfv4GgqbFd89QsdROXj/EloDAY9lZjsOB5oTAjcx9tmidJAr6JO3tVA8XORM/DvfW/q6UWtgnTaD22fgBTq6DzwnvuIgykCxBMEqIGVLVFEO34CMx3wPBRaVHqqH6E3uvvvtygFfipNhY2pkpy6IO/92Q6lCqoXLP5Aqlpt1HlMWkplWmzhxToqc1LOmudRjk+HuMhQSqidOnc8UTNtahQK5/O7NwbCgAREp6ed1UK9GH/zb9Fv0ns8Wj34FwdJO6Gr2RgT67vS9zC9nZPriZBLnA/dVNL0AJcv28JfrLJEn8nGHVjLl8X1SwooM0kbsfjtTOspl0k64oV9jFe4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTM0ZfGdmmSDSZ2p/B4A0f+boVuG2rb7QHtBgIbTExw=;
 b=Pxpgj6MEk6QmAPhBsvhBhGYfQHmvjeSNeVzvxRAoExZf1MK3Ar1e0i5RK5uM/zY8n7opIwac6HMmAiFpCV09CLmdDO9L/Yt3zvP9naIjRqwDrxfr023JCWTWearw7MzMW/3PZIpdHqQx0wDsWs9I1Z7LY7eUrIH1Dhhqj3AXQCAXsoKC/Emi/I67GQ7XWVvt1ltVaoT9IeMNeRo3diVoS+f8v/drJ8i5M9dIA4Aeoye4MhaauB3WrHR1eQj9v6IKCOzfC4Pw6Kh4q8JKmQcOS4ScdNYkd9MP84ePP2uXbgxhFluHZLhq/zTbzs99JgROHvKhCCZABwT9k6knVuZB5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5804.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 01:20:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 01:20:07 +0000
Message-ID: <d9b6fade-8156-417a-a8f9-3d4fec14363c@efficios.com>
Date: Mon, 28 Jul 2025 21:20:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING in sched_mm_cid_remote_clear (3)
To: Thomas Gleixner <tglx@linutronix.de>,
 syzbot <syzbot+c3be4001853e1add0a03@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@kernel.org>
References: <68877998.050a0220.1a379b.0005.GAE@google.com>
 <87bjp4pe41.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87bjp4pe41.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0245.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 40493a28-366e-4f04-798f-08ddce3e0dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWppd2pORFJuQmVwUUdVYzg5Q0FjQlZiT3U2ZVZCWnI5ZEs0eVBLQ3ZuRGJH?=
 =?utf-8?B?Vm50c3JPMW84RGZJUFNObE9MRTBRSG1Jd0dUbVZUOXpiMHU3OTZaT1dtMDdE?=
 =?utf-8?B?VUFaZUFFMHRwZk0ySGEyTTZvMFhNRmlGOHU2bmJjWE1lWi96aFIwdmFrMnpi?=
 =?utf-8?B?QlNBUk9zVVRNUXl1azd4Q1dkL2MvL1UwK3JMR1Q4MzlLemkxbmxFazNUZHlj?=
 =?utf-8?B?d3I3ZWN1aVNoR2dmWCtXK1FpQnFvVnlmbjJ5aGszNFpiS2xDLzgzM2lhd3Z2?=
 =?utf-8?B?d0M0c2lZUE1sYXhPekRoajVmeStTUGMrQTRvZGR1VzNHbGk4ZFQycGg1Y0E1?=
 =?utf-8?B?aG1nci9rYm5WdjZCM2NRZkpLMnE3MXJMSktMcjEwMitvdnRvLy9iYlUvUTRp?=
 =?utf-8?B?SElTNW1KbU5tU3J5RUZMK2g5SndGOGNkcm5BcXo3UG9ITXdjSXpnMUgwbmhu?=
 =?utf-8?B?d05mL3haelc3MG16aW0vRUg1UnR0YmRwc2lSVGt4cVhjbHZZYVlDT2FUcnJX?=
 =?utf-8?B?VXlVME5TbEZwUVN0R1lzU1VVTnByVTJaSzByM3BUanpwNWREK0RzS0dsT3Ux?=
 =?utf-8?B?QzJ2d09MOWIwNWh4Um1MOFFCcjJpeHhCRkpENkZkS3IyR09STjZJNGtWQ0FE?=
 =?utf-8?B?OUs5Z1ZWajVJak1ibldHQkJIU1liWkg2c080S2R1dU04dzNGbnZOS0xxNlRB?=
 =?utf-8?B?MlpneUJhTGdtS255STNHa0ZnVS9TQVZBWU11K1pFcDFUQXZjZ3ViSGdPYmh1?=
 =?utf-8?B?L2tlYVI2SnN5Nm5yVG9OWm9ZR0crWndpTHdLaXJmNnhPam5ad2hYM1ptRzFD?=
 =?utf-8?B?c1J1dWhtbjhoTFF4K2JjZHliK21BMWJxbjJZRnA5VTlKL21XaXhOVFRFdERG?=
 =?utf-8?B?THZ2L1RYTFZZdXhNZW9PN2JYRkFneWUxbGtCQSt5djNqelNNMWdRSkM0V3Rn?=
 =?utf-8?B?ZHdQWjkyRnlKRUo0VXBIL1NMUHdSbXJ2dFlHT2huWXZhZ09hbG5IRHFhYjh1?=
 =?utf-8?B?SHpZaFRZY24wU1UrYzkxMzRCQ25pMCtWRmwyaUMrUE9wU283QUJicFlsR2U5?=
 =?utf-8?B?WmI1THVVSGlBSDZGZmlIVUlxY2ZSa05kV1lVK095TlJjUkUzUUkxSmpMdEsz?=
 =?utf-8?B?TGJ4cUFoTGVRS3pzd20yRU1CWlBtWElmY2VuMXFJRVF5ZWdkN1lBdk90Uysx?=
 =?utf-8?B?MXMwZjAxbHpOdFdNbEZFZFRrVm05OVFyUlVZRnhkaTVTbzl0L1ZGQjhSWWY5?=
 =?utf-8?B?anAwUmt4SnFOZGJzdTZCc0VSdHNiRCtyTDRtT0ExL3JsOTlXSk12bytNM0N6?=
 =?utf-8?B?QnJJZFRGWWJLc2V0NnBPRW1oUUgxTytNcXF0MnhWeXpMK2hQOHBsM3dwMGg5?=
 =?utf-8?B?T3lFNzg5TU0wWWlwSENWalorS3FJRnN3eXZ5MVlUOUJuTDF0N2dveWNhVmtt?=
 =?utf-8?B?M0I2bWZlVWNPWGNkemNXWHNkeVJkMXNiSFZaT0I2bnVUVDQ1UmF4dTlGRmpi?=
 =?utf-8?B?NitWd1hlSjRGRGNjcTgyZXVUa0pyVGRKY1plcEx2clVMU3kxRVVtYzY0Z1pM?=
 =?utf-8?B?dnhnVjVicm1Ucm9oZGs0aDhrRkxjRldpb1dDeWNiRXowa0FRaTVGZWlVNU1E?=
 =?utf-8?B?Q0Vtc1RlbVB6a203dVNmOWNxaU5yZzJHREZ2RXRvQUVkRVl1dkNVZU5jaFlu?=
 =?utf-8?B?RVpkSWJ4MlU2THROdm1mdHhCNEJYSGlxb1VnNXc4QUwybXExeWJ6ZWNtaU5C?=
 =?utf-8?B?cTZ4M3ZwS0hoMzkxZGJ0RHVNZ0xTNU5YRlNUTWxEVE5rL2djcWM3bkdidWNJ?=
 =?utf-8?Q?5wjAYRk6T8yClvGQF+vOE36HW/ZHqS6bLYv5Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFd0SXE3K2kwODVUbXlVNEFOQ2pxaDVRYUtVc1BnRGVyV0pjclE2WUtaVWxC?=
 =?utf-8?B?S2h1NWdUV0RTWjlPZVkrSDJvRGMzdGorTWxaR3VtdUtSM2s1elFZQkRMdGJJ?=
 =?utf-8?B?MTNSaWtpMXRUb2pzU21TVlZXNkhBSkF4ZWZ4QStuY0hUMWpPWnNEWG16MTQv?=
 =?utf-8?B?VGJmVC8xZFRpMjUzUDRqM2k4bVluVDBUaVBzRzNqRVIxQktzbVBCVmRjYlZt?=
 =?utf-8?B?Y3RSRml0Ymw0aU5GbmV5WGZwZDgzVWRyMWNBOFIrQloycUhLQlhxSzVYa2Nt?=
 =?utf-8?B?eVJGWEFsZWdNZytaSGdaZ0E2dXhUTW5mc0dOUUE2VU1MY29pcktvNkxkMTFE?=
 =?utf-8?B?UmtOdi9TNjU2QU9nQ1d1Y1dqTDJobTNPaFZQd1Z0cnVyVm90aUdYcGtSQndR?=
 =?utf-8?B?WWVBbUdZQUN3eEdkVnZxRWFnVHo1ZFB0c0NhVUJ1YjZyaVlLYTE4N2Q3Wlhm?=
 =?utf-8?B?SC9URVA1ejFLUi9sRm04aWwwQ3ExVC9RN2tNTmZKMmRUTU9FRlcwc001N29z?=
 =?utf-8?B?eUx2cHBYUzZGMXdnWWFUUEdpRmsyRHFqMU1paFl5VzkrSDluMmVXcFIxUVBa?=
 =?utf-8?B?Ym5ZRmJma1VyYzQxZ3JCZjRyMkNXNi94Z3YrVytNQ1FETkkzbkJGcFJualZV?=
 =?utf-8?B?RDBXUlFOSGxnNXVGWTFJVDB3K1hjLzVuUEU0NWkvRURJZTQzcGI3OEtoRDdZ?=
 =?utf-8?B?R0VoNHVLaVEyb3hkMUV3ai9aaFJXRHZoRDFNdW9DS3JYdEVWOTllUjhBYlVt?=
 =?utf-8?B?YjRHbUpSam1kekR5TjZwei84VzloTFZ6WXNjR05WNW1TWlRGdGFWelptdVNE?=
 =?utf-8?B?ZElrUHdtN2sydkJHaTRadUN6MHBLTnlhb2xEVk84WEs1Z3c3YXR4bGx1RkJO?=
 =?utf-8?B?Z1BLTVUwb054Z2ZYYWZQMVFJY2tjd0FXUXNEenROU1NJOWdBdXVubGEwVncz?=
 =?utf-8?B?M0wxSHpXeTVHN3R6YTRFQmpnbUJjaEJoZTVycklsRkhiNCtmbDBoTzN5YnZv?=
 =?utf-8?B?aHF1NmEvTEJwNzc5NlFMNGxZbzdsSXMvM0FEL3hWWTNkaCtsMTcyeExKU0p5?=
 =?utf-8?B?empNNTNVRGhYZjhNOEpBR0RCUndNblhqM3hqUjVQNjZVZ2FKckk3di82T1Jn?=
 =?utf-8?B?VHlOeER5L3ZvallHZlJlSVdLcmFTS2h4SjZzejI0ZzlldTRURWdFeFJ5Vlcr?=
 =?utf-8?B?TUNHT0FncENGMEZRa0VOZFVnbFV3aEIrdHpmb3lUTHd5N3czVTlHT3ZFaG9E?=
 =?utf-8?B?ak1tRmFWa0Q1NDFxQ1pRTkE1WndHYWRlVEwzeWsxc2tUM3dWSFFOQk1yRlJW?=
 =?utf-8?B?bFhMZTNjb1cwZzB4OE1RdXdrclRkZjJuRHJzOEZtOUxrSGhjVTMyWDEzZ3VY?=
 =?utf-8?B?UDEray8zMUdjZFRBeEJ4d3h3UHRVZUVvYTFXeXNBNnh4RnFhSy9heGxoUCsy?=
 =?utf-8?B?bEhZYXJoZ2xjaDZxM3hrQzQ1d1Jzd3ErVXJVVFNnd3d4Yi9sY2pKQzRrcTdq?=
 =?utf-8?B?cHRkSXo4U2dZNFFTdTZJTFMvM21XZWRieDZSUjJzZ0FUVGVCSEN2eXFkZjF1?=
 =?utf-8?B?YWRRZmQvd2NVM1BlUEUwYUNDcVAyb1NlUUFlVDhPWFRielpONUlMYWVWOGJw?=
 =?utf-8?B?OWc4RGpoa2d0VjF4V2xaaDFiWXBTUEZ4OERERzRnV1Uxd0JGdERhSjc0MTdy?=
 =?utf-8?B?bExGamZQTk1mQlNMNEFITHFCeE9SMGVmTkZJYXVEN1I4Z0ZVTzhKTm53V3kw?=
 =?utf-8?B?b2xVZE9vOUg1bG9wZis4c08xWTFGbnpncFZVbFRMbFR5ck9RelpjNVFjMVpW?=
 =?utf-8?B?dVd2NnE3ZzRHbWhBdk5pTWVwR29jcXZmdm9kOW0vRkQwbG1CRDV4WkZ2UVg1?=
 =?utf-8?B?U0ExeS9ybHp1WGtSdXZXREFJKzBxekFXZEFUbVJVUFh2SnBYbEJxQlVtR3o3?=
 =?utf-8?B?UFhxZm4wdk5COTgrNFBrdW5WTlBSZUtHNlEycG5acjI2aEVKWW1IMDRWNzd3?=
 =?utf-8?B?K2k1d1JsM1ZYcW04V25YWWMxUisxNXRIdGM0cTVtUmtJV2d0dUJyK2dLSnhn?=
 =?utf-8?B?OGJMVEJLOWwvdGMxYkZZUmhJSzlqeWVSMitGbzlZdm5IWkd3bWtZREErbGRy?=
 =?utf-8?B?WVZLMytJRkdFWTNOZitNMG1RVDJxeGJRK2dBbHF4eWdUZkpMUWdEYzhJR0Vs?=
 =?utf-8?Q?wGGRiL1xfP7rGsqFqKo1f64=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40493a28-366e-4f04-798f-08ddce3e0dfc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 01:20:07.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2s2zbSFXD6P7rrPBX+asfnC0905yA6DGLeHjbBM5IjMEs3oZbC150DQdC/IbQl+BLKW4HO6NoP+81962kHCyPCzdxg18j4xpL26u2JQAhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5804

On 2025-07-28 10:46, Thomas Gleixner wrote:
> On Mon, Jul 28 2025 at 06:22, syzbot wrote:
> 
> CC+ Mathieu and leaving the context intact.
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    25fae0b93d1d Merge tag 'drm-fixes-2025-07-24' of https://g..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=136930a2580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c3be4001853e1add0a03
>> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/7acf9d19f311/disk-25fae0b9.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/532080ae9996/vmlinux-25fae0b9.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/47473831ee3b/bzImage-25fae0b9.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+c3be4001853e1add0a03@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 cpu_max_bits_warn include/linux/cpumask.h:135 [inline]
> 
> That means __mm_cid_put() is invoked with cid >= nr_cpu_ids ....

I'm trying to figure out how this can happen. One potential
scenario I see is if we have mm->nr_cpus_allowed > num_possible_cpus().
Is that possible ?

We strongly rely on having mm->nr_cpus_allowed <= num_possible_cpus()
in __mm_cid_try_get().

When a process is created, it takes the main thread's p->nr_cpus_allowed
as initial value. Then it is updated by mm_set_cpus_allowed(). It is
basically a union each thread allowed CPUs masks.

Can we expect all scheduler classes (including ext) to guarantee the
affinity context only includes CPUs that are present in the possible
CPU mask ?

Thanks,

Mathieu

> 
>> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 cpumask_check include/linux/cpumask.h:142 [inline]
>> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 cpumask_clear_cpu include/linux/cpumask.h:620 [inline]
>> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 __mm_cid_put kernel/sched/sched.h:3622 [inline]
>> WARNING: CPU: 1 PID: 12208 at ./include/linux/cpumask.h:135 sched_mm_cid_remote_clear+0x488/0x4f0 kernel/sched/core.c:10543
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 12208 Comm: syz.4.2719 Not tainted 6.16.0-rc7-syzkaller-00034-g25fae0b93d1d #0 PREEMPT(full)
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>> RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:135 [inline]
>> RIP: 0010:cpumask_check include/linux/cpumask.h:142 [inline]
>> RIP: 0010:cpumask_clear_cpu include/linux/cpumask.h:620 [inline]
>> RIP: 0010:__mm_cid_put kernel/sched/sched.h:3622 [inline]
>> RIP: 0010:sched_mm_cid_remote_clear+0x488/0x4f0 kernel/sched/core.c:10543
>> Code: 0f 01 e8 3b 71 0e 00 eb 9d 4c 89 ef e8 f1 73 97 00 e9 67 fc ff ff e8 e7 73 97 00 e9 47 fd ff ff 89 44 24 48 e9 17 fe ff ff 90 <0f> 0b 90 e9 f0 fd ff ff e8 8b b3 fc 09 e9 06 ff ff ff 48 89 d6 48
>> RSP: 0018:ffffc9000480fcc8 EFLAGS: 00010012
>> RAX: 0000000000000093 RBX: ffffe8ffffc476c0 RCX: ffffffff8189c611
>> RDX: 00000000ffffffff RSI: 0000000000000004 RDI: ffffc9000480fd10
>> RBP: 1ffff92000901f9a R08: 0000000000000001 R09: fffff52000901fa2
>> R10: 0000000000000003 R11: 0000000000000001 R12: ffff88807b22ed50
>> R13: ffffe8ffffc476c8 R14: 0000000000000200 R15: ffff8880b843a2c0
>> FS:  000055556f5a3500(0000) GS:ffff888124820000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055558d727588 CR3: 00000000668d0000 CR4: 00000000003526f0
>> Call Trace:
>>   <TASK>
>>   sched_mm_cid_remote_clear_old kernel/sched/core.c:10576 [inline]
>>   task_mm_cid_work+0x3b4/0x910 kernel/sched/core.c:10626
>>   task_work_run+0x14d/0x240 kernel/task_work.c:227
>>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>   exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:114
>>   exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
>>   syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
>>   syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
>>   do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f8ef99c1265
>> Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 f6 54 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 4f 55 ff ff 48 8b 04 24 48 83 c4 28 f7 d8
>> RSP: 002b:00007ffe741fc2d0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
>> RAX: 0000000000000000 RBX: 00007f8ef9bb5fa0 RCX: 00007f8ef99c1265
>> RDX: 00007ffe741fc310 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: 00007f8ef9bb7ba0 R08: 0000000000000000 R09: 00007f8efa7eb000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000048110
>> R13: 00007f8ef9bb6080 R14: ffffffffffffffff R15: 00007ffe741fc450
>>   </TASK>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

