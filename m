Return-Path: <linux-kernel+bounces-811139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C23B524D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F211C83370
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B662DAFC0;
	Wed, 10 Sep 2025 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aWouM4Xp"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020090.outbound.protection.outlook.com [52.101.201.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451E277CA5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548717; cv=fail; b=Asr4ko4DQcY+F2eMLVrTfPdiVTSPCH9bfVgx+gjADvLA08+5+RXN6umnJJ0fjGK80NOyBx8mtftYp9Utw7boFX6GdXP32KsDlwzkE+Hg0Sjp6A8HAnezwHuSdWBAU1R+1DcuD2AUCQge3gXxi5cMt/XTNOR5B8VCvOh9Cc7L+5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548717; c=relaxed/simple;
	bh=GaoohYEdR1YpT8ydNlKQaGO04Ulbk0FedxUWUuKrifw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pfWDdSX1NtZ22SrlDYQ2KpoxX97Jwj71gzUSGo5sevGMgP/9YyFX7MIKb87JOzB64OB6kmD/y6ByadIqX3M9caZExkbwqIyVlOKxFu6IxfebNdfwf52mOuNHvGrPvYvr1/C3S/TZnP7/StX9dC5nCk1PScNPEsIy8i1cS836EGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aWouM4Xp; arc=fail smtp.client-ip=52.101.201.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YstkoybcIZ6QftxrDpzFRtXXiKxe2G87racwKlJc15MV9s//qcIFdWgMWNFJXqkpP1jhjRi5zNlmubqbw75e9EAcpbgZC0ub4pCCIKUB/53RWhJtnJHx1AgH1EK/MVcyoBTXfqj8hkPJ7Tltzm/sAv6SKtf5S32SFrLoZULqzNNaybMcpjkjPPWaeu8GutSgTIuGeXG0/EmqIfLPyZDDRyout7lq0Mj3EzCRJiWntEgypueWan4O1cWWAdm3TINtwEpHz460NVCWwP5Jm65laQwckDqGkv4+zwawwkWjgaOsNrpiPVvN3H7JamM7acC4TuO0k4MqdmUtNj6f5ElPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzq4yUpwhx8DScMIAhwsHIccPYtOQVqyr7bqnx7VnaQ=;
 b=d9xAu9Y6CYteUcI/5DV4r4WGZ5N+p5GV72eZBLDvdosMEkkJUKt06/MceSWZ7TS9gRR+9oHyEpuY7BWb73JczU3T/0YZGQOAXQ+jd1UsKW29TDsz1TG3pLFs4QE50abn/KT+w7qhuFYSB58VCPTaLINBwM6w2mrhS96mfS2R0koW7RtYV2B62XjIBM8AFfNUbxYWF+Gfm4LgKAcg72aQsv9aY5G1ChElqlENroDWbk9MybnObn8gqt1pDqkV100ilPR4Ijlv42joj2sRTAuYmU2u1NcDKrUktcksyYc11VlxChPFR6Q6j8rD1kXRlrIkS7AMnpQ5ZMiZzaLfdI+CFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzq4yUpwhx8DScMIAhwsHIccPYtOQVqyr7bqnx7VnaQ=;
 b=aWouM4XpAtfrNsj8o9ouRE69h4OkjPoIlgiwQwroXsGAPn/fVWHbsl2xhoR97xxwEVFa5F5VH/9xQp0cesdoN6MmFbgNRX5SQiPVKCbDl4C7gHNDFkkFmi2VMdxqIRyCAYh6IF1RqNQrAubHi//MWKClxu0CieXqQKCaudMRDOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ2PR01MB8347.prod.exchangelabs.com (2603:10b6:a03:542::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 23:58:29 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 23:58:28 +0000
Message-ID: <dcc3b52d-0b86-47fc-8297-a6abc8af4c38@os.amperecomputing.com>
Date: Wed, 10 Sep 2025 16:58:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] arm64: tlbflush: Don't broadcast if mm was
 only active on local cpu
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
 <20250829153510.2401161-3-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250829153510.2401161-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ2PR01MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: f4963710-695e-4d21-1816-08ddf0c5f02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2hrVDU0MjQzMmRDeURyMHR3bElPZDdrOXNabTlqRlVSMmdkMjZLTXhWdThZ?=
 =?utf-8?B?SmFSR0xwSDBqWkJ0ZDJKUEpNbU5PNmNMYVZWLzVOa2xkcG9Zcmc5aXNsMG1H?=
 =?utf-8?B?ZkN4NTN4TGtrZ3hpUldPWEZERFdKZDg2a0FKVnlqYXRIQTJOaHpQVnI4aXho?=
 =?utf-8?B?dkVUeWs5RThpMk1YM3VQak0xUVlVK2U4bU5ZZlZhRWFobTRVNm1NNWQvK09V?=
 =?utf-8?B?VVpTRHp6UXc4eEtmc3l5OFFMeDZzOU85TkcweU9RTUdtZ29IcG51cjFwUThX?=
 =?utf-8?B?amdXZFV2eVVaN1dPdk1UeEpnbGxya3FldjdwRm1WczRjbnh2UXBzNU1RWWto?=
 =?utf-8?B?cC9zNzRDYUZ2L3MwNVFXSS9nMlplVEdHVXVWMEhOa1hMckRjYzB6L3picyts?=
 =?utf-8?B?VzVHek1nMThCRldPcnJ3aDMwSlhWL3VJalNMV3VqWWpyZC9qN1h6WmxzZlh4?=
 =?utf-8?B?MmxBUXQwV05RcVNEOFR0M3NPN3ZvU2JOMFpHS0UwNitXekV2QXRqM2FtemtV?=
 =?utf-8?B?bk5jcE1ERWtPM3FQVTBQVGxvb3BScnhnZk9uZTJBSWt5cWFHUloreXlIeGdI?=
 =?utf-8?B?R0RNUTNzdFZwNE96ZUl2N0xMbUFLZWxXZzBMb04ySHIyZ0w0UkIveXpSZFZU?=
 =?utf-8?B?SVpUTEdPc2xyamttQW1qTlN3NGtoUnVmYm5rc0dHUEpIWGJKK1BNZVM5YkZM?=
 =?utf-8?B?NzN2bmw3bkljNnAybUZ3TUZvMUIyR2k4YldRMWxYMTJCMWx6SlU3VVd3K29Y?=
 =?utf-8?B?M1hPZWRuTVN4S0JLSTlTZGQ2c3loS0pKWDVrMThpYXlhVC9wbUhKQWFOR0FG?=
 =?utf-8?B?QnZSeFRydEdnV1EvRk8xK0FRVkdmdDBsanh4dnNValVXZ1laTnVhMklFYUs3?=
 =?utf-8?B?dFl2Q0Rkd01MVXA1TjIxbURDbUpSSGpSQzgrMVpINDlVVnhXZnZTMTd6V2Vk?=
 =?utf-8?B?WG1kbEpiNEtscE5QNUl2SlBvMVFScVBaTHkyM0d3eWR5WjhsalVjZDFXd0FR?=
 =?utf-8?B?WWpHbi9naEFiTnNwbnJmTmJXZXFiWkhrUGh1bENTeHgrU21nOXU2aG1tbDgv?=
 =?utf-8?B?MVB1T1dVNVNiSmdHOGM4azh5L0Q3NEdjZml1RnlkdXZLQi8xVWpkRlREcXpT?=
 =?utf-8?B?VjRLelVBK1dUNE9ROFZVbFB3eTF4ckJwOGEwMWJCdXZjdDdmQ1RLV0t5dERI?=
 =?utf-8?B?TXQ4R0xkSW5KOE5GTDZwOVlnRTNiMXJpU09neWozN3gwYzVobHhjT0l6dExW?=
 =?utf-8?B?YURvMzZhakxlWllKY0FpMy9hamV1MTNWdm1Dcnpiem5kNmkxUU5SSC8rckJR?=
 =?utf-8?B?Nks1VlRpM1lERWdodEdmNWxPbFMyZFh2WUh0a1ZoN25BaXd6eDZveDhLd2ww?=
 =?utf-8?B?WXppYW93NFkzTWlTWmtEMHgyczAvS2t6TCttVjV5eVdPSlFSNEtITmVGVFJr?=
 =?utf-8?B?T0I5RnlGeExrcnU2WWZLVEMxT2l2VVlpNzlmWnhObndkbEROaldlTDdKdng4?=
 =?utf-8?B?K3czemhTWHkyWWdJR3piRzdocHBwRzQ3YkkzVVJMUURSb0tHL0pJUWRtazNi?=
 =?utf-8?B?VDZaWEJhNEZVTGZLeUp6SEFRZVFkbkZ1Zm04NGJ0ZDMvYWlqTldqVHhjb0JG?=
 =?utf-8?B?MzdIMXVFQ0VSNnJyWDE3VExrc1Y5OGlkWldrZWN3KzRXY0dZMXJKSVFVdkw4?=
 =?utf-8?B?WGxzR3k0ZmE2aVQwbldmSUNCeDJQcG9EaVMrZytPd052cnpkUHNsejJ0Zjk0?=
 =?utf-8?B?ZkU1clpCTmpYY2kwTk85Q3hvUmhCK1M4MkxmWjFyQytIM0JkR3hOcExGVEpj?=
 =?utf-8?B?NW42bnFYNHVWMy83RDh4azJiRFZ3MUd3MC9WTm5vUGNpNFJ6ejN2VW51T2NQ?=
 =?utf-8?B?RFEvMjdnOFluSWk5V3dJcjhuc2xkeWxIMXFrL3paeDZPZnNuMlRzSUxwd3JX?=
 =?utf-8?Q?I8RtBXBKuxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0hVM3Ntb3FLQ01CYkx6eHBkZGVvRk1iY3lFZFlodGNnaXN6blNBTU9jcWVx?=
 =?utf-8?B?bUQ0SmQ5Nnd6QWhYVms5S3BFR2x3Vi81MWpSM3BQcm11a2p5SFRNdDdsZ2ll?=
 =?utf-8?B?YVhvNldLdDNiUXZlWnYvZXplN1VGWG1XWGx0WnA3NjRZYittWnMwMnZESXRE?=
 =?utf-8?B?dVlHZXZEZm94VVg2OXcvVlJHb0pROHBqQXByaStPbllzQ2wvcFlZemlBTSth?=
 =?utf-8?B?L2o0MVpiYlRnUUlFSTFpNCtMbWM0Tnl6NzRyZVY4c3BKZWhpa2JMdDRvTjY1?=
 =?utf-8?B?K0hRL1VpVkJLOWJNK3dhM1U3bUFqK2hTUmtoVENHeW1vM2N1VnR3QVZkWVM3?=
 =?utf-8?B?TUFGK3B1RVBRV1BTR1dVT2o4MkNRaWRubEdHd2lUcGJ5cVdoejZhbkJaTmlz?=
 =?utf-8?B?UlVIMFdjNEMzUkEwSXk0RDcyeFJLaUEwTnNIU2FDN2QwV2s5T2Rzd2hucjEw?=
 =?utf-8?B?ZDJOclR0QzQzeWlqbzlVd2d6TzRaSkxRa2JBRzNHRjRjMVk0eWlXclVnK3RU?=
 =?utf-8?B?RzNVeXdTU2ppLzZXV0UxdzJIMjlqWkVZd2Q0UlJUak8zNUFFcnFwWGpNQXFK?=
 =?utf-8?B?OVpSYjdxcVZQM1RqUW92Rnp4cWEyRzBrUWZBZzFMblZoL2VmeGNtLy9mOFdN?=
 =?utf-8?B?Rjc2VW9nMmVOMmlJem9NZ3I0bVhFZFFlNHdjc01XbDlMZCsyZGJaSm1ySlhk?=
 =?utf-8?B?YTFGalJudSswVzJibDlwUzIzc3Q2UEtya0s0ZzJRdUJGVE82a3FCTU1MQXdT?=
 =?utf-8?B?d2FsdVhNRW5sY2VHMUFCakxSTjVKaWgvY0V6MWlUb2pXSk41T25JaHJLd0JV?=
 =?utf-8?B?RjZpMTF6M1E3SEdpT0dxZ0dES25iNCtVYmNBSWhLOGtOai9qODNKMUxIYVl1?=
 =?utf-8?B?SC85cjV3ZWt0dlg3L0hmZFM2blkzTkk4TUN4OXc4SXBFVXNMWk4zSzBUNCta?=
 =?utf-8?B?a2Q5d21VS1VVWFdyaVZ1RUhPT0hSUjNWL3IvYVVqcTZoZ1pQaGluS0theFZP?=
 =?utf-8?B?bDJMdnJObVVVbjBjWWMwU1I1SnZ4YU91YVFYSkpBQ1BPTFlZRmp2a2EzV2ZZ?=
 =?utf-8?B?UE41QzdMMmlidytPdnpmRlNGdjVNVEhtTG1ONEJ4bnlBUis1bEJ1RFFvS3Ri?=
 =?utf-8?B?bEJQV2lXcjNXUVBSZzFqSzhSQ21EU1FuUERsOVgzNnBacFdyL1BuNFdmbVBo?=
 =?utf-8?B?N1VLM0NyWWRzdVR1S0Qxdno1SEF1UWUwSitsZDNCTnVJWm5TMkZtaE1BMFZG?=
 =?utf-8?B?b2xveW5XWnVPcjFCam5venpZUkZ2TkwyY3dVMkw3WGo3dEw5eVpxaXYwMDdo?=
 =?utf-8?B?dmc3TjlYN2tEcDdKTHlmWmdaci9ZY2Jybmt0cHFOT3pvT3FkZ3paUUdPN1J4?=
 =?utf-8?B?b2RSZm1oc0dPQi91aVpDVUdMck4yOFlJeHJqNjJvWWhubmpmN29FcnFMRStI?=
 =?utf-8?B?T05ZV3prR2lscWlXWDNocm1aSm5WcE5qdnlxc2pyK3BHUDJmRDdtc2RqUzF2?=
 =?utf-8?B?a2FSK21Jc0R1N0xrZEI2QUlOcEtwc05FQ1BRLzgxUlBTSk0wV2FlamxocjVm?=
 =?utf-8?B?cEtWOGlxQlh3S3VOUEhrNHlIS3llbVdPTTNSSjQ3alpXVy9EZUdBZklSYnlQ?=
 =?utf-8?B?bGZ3dFhKNkVjdmdjTmVib09pRm52Y0NiRjVFdW5pRUwzWVBwRS91N3J4OHdt?=
 =?utf-8?B?Y0dTamRGZldXdW5yc1k2M2w4aG0rSmZ6Rm5uN2M1dmdnMTcrV3J2VGRlOGVu?=
 =?utf-8?B?K3JLTU50YjM1YzZMazFEOXpnS0JEWHRMM04vU0FmcXg0UDlxT0JoYnZtcFBY?=
 =?utf-8?B?L1h5eWhzR2FZU3VJUVZPeC8rUlF6NDhTaHhwcjlBYW12RkIzTHVTSE9WWWFh?=
 =?utf-8?B?N0JQZjE1RzUveDNHb094MFloUmNrWEF6QTJkV1NoeitidnhqZGpveEEzalI2?=
 =?utf-8?B?VlFMdUhYcVpRam9vQ0NDa3UxVVB1R2cwT21jenFVQ0FJSUJxZUJlb2cvczFK?=
 =?utf-8?B?L0xEOENHQlRhc0wvV3VNUGhWRGQzaTI1dURzTmxCRXVzYmpOaFM1ODA3bWZq?=
 =?utf-8?B?NElCQ3dOUE1xeGtpR0xsR01VNHVCY1JtbTlKMEt5VkQ2T1pMUitsU2pFeWZW?=
 =?utf-8?B?Nm45eVo3bzJPOEJMcUxYU3luWmdLNm9FdFZnRUcrNVJ6UnNDRHJjSW1MM3BY?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4963710-695e-4d21-1816-08ddf0c5f02b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:58:28.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiBTu4bC0FQyzGki/ACeBE6WOFaHIkzND6zU9JN7SnkLfKZXWuMbaK0le2WMp9PuQjk0jHpo06Ey+to8f9LUmLz9JODVATP0W1oLVmZTDig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8347

Hi Ryan,


On 8/29/25 8:35 AM, Ryan Roberts wrote:
> There are 3 variants of tlb flush that invalidate user mappings:
> flush_tlb_mm(), flush_tlb_page() and __flush_tlb_range(). All of these
> would previously unconditionally broadcast their tlbis to all cpus in
> the inner shareable domain.
>
> But this is a waste of effort if we can prove that the mm for which we
> are flushing the mappings has only ever been active on the local cpu. In
> that case, it is safe to avoid the broadcast and simply invalidate the
> current cpu.
>
> So let's track in mm_context_t::active_cpu either the mm has never been
> active on any cpu, has been active on more than 1 cpu, or has been
> active on precisely 1 cpu - and in that case, which one. We update this
> when switching context, being careful to ensure that it gets updated
> *before* installing the mm's pgtables. On the reader side, we ensure we
> read *after* the previous write(s) to the pgtable(s) that necessitated
> the tlb flush have completed. This guarrantees that if a cpu that is
> doing a tlb flush sees it's own id in active_cpu, then the old pgtable
> entry cannot have been seen by any other cpu and we can flush only the
> local cpu.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/include/asm/mmu.h         | 12 ++++
>   arch/arm64/include/asm/mmu_context.h |  2 +
>   arch/arm64/include/asm/tlbflush.h    | 90 +++++++++++++++++++++++++---
>   arch/arm64/mm/context.c              | 30 +++++++++-
>   4 files changed, 123 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 6e8aa8e72601..ca32fb860309 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -17,6 +17,17 @@
>   #include <linux/refcount.h>
>   #include <asm/cpufeature.h>
>   
> +/*
> + * Sentinal values for mm_context_t::active_cpu. ACTIVE_CPU_NONE indicates the
> + * mm has never been active on any CPU. ACTIVE_CPU_MULTIPLE indicates the mm
> + * has been active on multiple CPUs. Any other value is the ID of the single
> + * CPU that the mm has been active on.
> + */
> +enum active_cpu {
> +	ACTIVE_CPU_NONE = UINT_MAX,
> +	ACTIVE_CPU_MULTIPLE = UINT_MAX - 1,
> +};
> +
>   typedef struct {
>   	atomic64_t	id;
>   #ifdef CONFIG_COMPAT
> @@ -26,6 +37,7 @@ typedef struct {
>   	void		*vdso;
>   	unsigned long	flags;
>   	u8		pkey_allocation_map;
> +	unsigned int	active_cpu;

Any reason why you don't use bit mask to mark the active CPUs? And 
mm_struct also has cpu_bitmap to record the active CPUs which the 
process has run on. Why not just use it? x86 uses it to determine which 
CPUs kernel should send TLB flush IPI to. I understand this series just 
check whether local cpu is the active cpu or not, but bit mask should 
not make things more complicated. And it also can provide more 
flexibility. We can extend this, for example, use IPI to send local TLB 
flush if the number of active cpus is quite low. AFAIK, x86 added TLBI 
broadcast support too, and fallback to IPI if the number of active cpus 
is <= 3. IIRC, Christohper's series did the similar thing. He should be 
interested in this series too, cc'ed him.

Thanks,
Yang

>   } mm_context_t;
>   
>   /*
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 0dbe3b29049b..db2505a8eba8 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -180,6 +180,8 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>   	/* pkey 0 is the default, so always reserve it. */
>   	mm->context.pkey_allocation_map = BIT(0);
>   
> +	WRITE_ONCE(mm->context.active_cpu, ACTIVE_CPU_NONE);
> +
>   	return 0;
>   }
>   
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index f66b8c4696d0..651440e0aff9 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -182,6 +182,52 @@ static inline unsigned long get_trans_granule(void)
>   		(__pages >> (5 * (scale) + 1)) - 1;			\
>   	})
>   
> +/*
> + * Determines whether the user tlbi invalidation can be performed only on the
> + * local CPU or whether it needs to be broadcast. (Returns true for local).
> + * Additionally issues appropriate barrier to ensure prior pgtable updates are
> + * visible to the table walker. Must be paired with flush_tlb_user_post().
> + */
> +static inline bool flush_tlb_user_pre(struct mm_struct *mm)
> +{
> +	unsigned int self, active;
> +	bool local;
> +
> +	migrate_disable();
> +
> +	self = smp_processor_id();
> +
> +	/*
> +	 * The load of mm->context.active_cpu must not be reordered before the
> +	 * store to the pgtable that necessitated this flush. This ensures that
> +	 * if the value read is our cpu id, then no other cpu can have seen the
> +	 * old pgtable value and therefore does not need this old value to be
> +	 * flushed from its tlb. But we don't want to upgrade the dsb(ishst),
> +	 * needed to make the pgtable updates visible to the walker, to a
> +	 * dsb(ish) by default. So speculatively load without a barrier and if
> +	 * it indicates our cpu id, then upgrade the barrier and re-load.
> +	 */
> +	active = READ_ONCE(mm->context.active_cpu);
> +	if (active == self) {
> +		dsb(ish);
> +		active = READ_ONCE(mm->context.active_cpu);
> +	} else {
> +		dsb(ishst);
> +	}
> +
> +	local = active == self;
> +	if (!local)
> +		migrate_enable();
> +
> +	return local;
> +}
> +
> +static inline void flush_tlb_user_post(bool local)
> +{
> +	if (local)
> +		migrate_enable();
> +}
> +
>   /*
>    *	TLB Invalidation
>    *	================
> @@ -274,11 +320,18 @@ static inline void flush_tlb_all(void)
>   static inline void flush_tlb_mm(struct mm_struct *mm)
>   {
>   	unsigned long asid;
> +	bool local;
>   
> -	dsb(ishst);
> +	local = flush_tlb_user_pre(mm);
>   	asid = __TLBI_VADDR(0, ASID(mm));
> -	__tlbi(aside1is, asid);
> -	__tlbi_user(aside1is, asid);
> +	if (local) {
> +		__tlbi(aside1, asid);
> +		__tlbi_user(aside1, asid);
> +	} else {
> +		__tlbi(aside1is, asid);
> +		__tlbi_user(aside1is, asid);
> +	}
> +	flush_tlb_user_post(local);
>   	dsb(ish);
>   	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>   }
> @@ -287,11 +340,18 @@ static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>   					   unsigned long uaddr)
>   {
>   	unsigned long addr;
> +	bool local;
>   
> -	dsb(ishst);
> +	local = flush_tlb_user_pre(mm);
>   	addr = __TLBI_VADDR(uaddr, ASID(mm));
> -	__tlbi(vale1is, addr);
> -	__tlbi_user(vale1is, addr);
> +	if (local) {
> +		__tlbi(vale1, addr);
> +		__tlbi_user(vale1, addr);
> +	} else {
> +		__tlbi(vale1is, addr);
> +		__tlbi_user(vale1is, addr);
> +	}
> +	flush_tlb_user_post(local);
>   	mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_MASK,
>   						(uaddr & PAGE_MASK) + PAGE_SIZE);
>   }
> @@ -437,6 +497,8 @@ static inline bool __flush_tlb_range_limit_excess(unsigned long start,
>   enum tlbi_op {
>   	TLBI_VALE1IS,
>   	TLBI_VAE1IS,
> +	TLBI_VALE1,
> +	TLBI_VAE1,
>   };
>   
>   #define flush_tlb_range_op(op, ...)					\
> @@ -448,6 +510,12 @@ do {									\
>   	case TLBI_VAE1IS:						\
>   		__flush_tlb_range_op(vae1is, __VA_ARGS__);		\
>   		break;							\
> +	case TLBI_VALE1:						\
> +		__flush_tlb_range_op(vale1, __VA_ARGS__);		\
> +		break;							\
> +	case TLBI_VAE1:							\
> +		__flush_tlb_range_op(vae1,  __VA_ARGS__);		\
> +		break;							\
>   	default:							\
>   		BUILD_BUG_ON_MSG(1, "Unknown TLBI op");			\
>   	}								\
> @@ -460,6 +528,7 @@ static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
>   {
>   	unsigned long asid, pages;
>   	enum tlbi_op tlbi_op;
> +	bool local;
>   
>   	start = round_down(start, stride);
>   	end = round_up(end, stride);
> @@ -470,13 +539,18 @@ static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
>   		return;
>   	}
>   
> -	dsb(ishst);
> +	local = flush_tlb_user_pre(mm);
>   	asid = ASID(mm);
>   
> -	tlbi_op = last_level ? TLBI_VALE1IS : TLBI_VAE1IS;
> +	if (local)
> +		tlbi_op = last_level ? TLBI_VALE1 : TLBI_VAE1;
> +	else
> +		tlbi_op = last_level ? TLBI_VALE1IS : TLBI_VAE1IS;
> +
>   	flush_tlb_range_op(tlbi_op, start, pages, stride, asid, tlb_level,
>   			   true, lpa2_is_enabled());
>   
> +	flush_tlb_user_post(local);
>   	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
>   }
>   
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index b2ac06246327..adf4fc26ddb6 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -214,9 +214,10 @@ static u64 new_context(struct mm_struct *mm)
>   
>   void check_and_switch_context(struct mm_struct *mm)
>   {
> -	unsigned long flags;
> -	unsigned int cpu;
> +	unsigned int cpu = smp_processor_id();
>   	u64 asid, old_active_asid;
> +	unsigned int active;
> +	unsigned long flags;
>   
>   	if (system_supports_cnp())
>   		cpu_set_reserved_ttbr0();
> @@ -251,7 +252,6 @@ void check_and_switch_context(struct mm_struct *mm)
>   		atomic64_set(&mm->context.id, asid);
>   	}
>   
> -	cpu = smp_processor_id();
>   	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
>   		local_flush_tlb_all();
>   
> @@ -262,6 +262,30 @@ void check_and_switch_context(struct mm_struct *mm)
>   
>   	arm64_apply_bp_hardening();
>   
> +	/*
> +	 * Update mm->context.active_cpu in such a manner that we avoid cmpxchg
> +	 * and dsb unless we definitely need it. If initially ACTIVE_CPU_NONE
> +	 * then we are the first cpu to run so set it to our id. If initially
> +	 * any id other than ours, we are the second cpu to run so set it to
> +	 * ACTIVE_CPU_MULTIPLE. If we update the value then we must issue
> +	 * dsb(ishst) to ensure stores to mm->context.active_cpu are ordered
> +	 * against the TTBR0 write in cpu_switch_mm()/uaccess_enable(); the
> +	 * store must be visible to another cpu before this cpu could have
> +	 * populated any TLB entries based on the pgtables that will be
> +	 * installed.
> +	 */
> +	active = READ_ONCE(mm->context.active_cpu);
> +	if (active != cpu && active != ACTIVE_CPU_MULTIPLE) {
> +		if (active == ACTIVE_CPU_NONE)
> +			active = cmpxchg_relaxed(&mm->context.active_cpu,
> +						 ACTIVE_CPU_NONE, cpu);
> +
> +		if (active != ACTIVE_CPU_NONE)
> +			WRITE_ONCE(mm->context.active_cpu, ACTIVE_CPU_MULTIPLE);
> +
> +		dsb(ishst);
> +	}
> +
>   	/*
>   	 * Defer TTBR0_EL1 setting for user threads to uaccess_enable() when
>   	 * emulating PAN.


