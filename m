Return-Path: <linux-kernel+bounces-799179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD845B42811
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6882B1BA2673
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1342D5930;
	Wed,  3 Sep 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Snrywzcv"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14B1547C9;
	Wed,  3 Sep 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921104; cv=fail; b=VudqIGgbht60dKUIvgvopvU92/q9St1lR9+j5IZTWxflWzQTMQmj7tNHh9ViSN3TgnAqrZ6t42tjH/XDpIbmSIjM4cPjpDRfRqPbCPa4XtT5ZAV1XEMGl+MZ0c79iafRY9Gcxey3y4hBltXJjjRqfLim6AxeFv3z6JkDY72m66M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921104; c=relaxed/simple;
	bh=+ibP8hoFxnzdg+ua94eP29r8VzhISvyZnagPQuUQN1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0eVTNvz2rUP+1QO6/rpdxYSHh714tD7/Y/oHjUP9V1F1Ulxfa8dlGZb5+z+rLoUMhrWQ/ywzEgFcZbsFu7/6dwlhhEbFPn+16UerNRtPhlZ+dp1kutfZS8GoX6NdcFbgD0iE4toOZ7vqhkO5OW8CsOORjcJeK1nkIoZCbUrF0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Snrywzcv; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCUy5Xz1U6lOtpPIDbqvSlUaSAfG5uSLEIx2TObDVveLzrFSVOBa/Q/9dz//SOvId95q6v7dfwKx8jzrnvoirVlyspNuAq9dbyHxQQ/3rZokc/LoDOmD5WCFSa7iWx6qjaIsBMP++aRV8u9ys2vUs7lCS9op+KF7zApWM1GxrwTnZvAG0gSuF8bobHWKkQCovSv2Qjdjj2sjTfId8j2pZwNd1bj1hp8eE/30142LAPe+pGlHXxDsc6Bhu0Kv0D7BbH7QEj+1w0DIo1oseKwj9gBm6Iq3yyJz1d1oGAWe35rCxSvPWO3XoR7LdZD8bRcEPeWNX+QIhU3CI+25TRiIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3UPtY+cHnn2TeJRpLhqyYyr/024v2N6Jr/t3IHfLIk=;
 b=R28kLoNGjDCaB6LrJVTH3/g6RPBLNWAuyGIdVt/TiWtPyIUmnaG8MmWgfxlZEkNpkAsfD1AsuL2DCPpKD4riurTYq9L6b0Wq4ZtH3fjL4BTMf04COtfx8FyLitjyCIn9Hkuv4ZBTWLdRtYw47ly25rtZjfRYPOYCL1fa69DIUFIUC6Ap2dTK5VVfyIJZ6hmH8zXHzluetCszdnKVs2wOe4gZpJSTlglheMHGTlPsI27Ion3zEl1lBtYfi1Uf3DuOFRwzSptorKA2Lk/dqWxL+rI7ddewLUQLdPsWlTH3bFYy+QVPxuJZ7uNZ7ni5QYCj6a8cgrCtVdZKaupYo6LR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3UPtY+cHnn2TeJRpLhqyYyr/024v2N6Jr/t3IHfLIk=;
 b=SnrywzcveQZ2tNz3U6wSl5owETiYxODCk0zyfu0pD6L3G+HkTsBwQH2y83Mb22DODjeWM31iNvc+6++5bPCYt3Wax3CR5vPFglpPVcl8VIndqpmAjasE2U6P4WKwOEQ9giy6Y7jS9VjTpcOcZcNag1VOrZdNn/emilbIauDa80I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ0PR12MB6807.namprd12.prod.outlook.com
 (2603:10b6:a03:479::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Wed, 3 Sep
 2025 17:38:19 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 17:38:19 +0000
Message-ID: <dfc629d3-08d8-4443-9a8d-61e4612dfbd6@amd.com>
Date: Wed, 3 Sep 2025 12:38:15 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v17 25/33] fs/resctrl: Provide interface to update the
 event configurations
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org,
 pawan.kumar.gupta@linux.intel.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, thomas.lendacky@amd.com,
 yosry.ahmed@linux.dev, xin@zytor.com, sohil.mehta@intel.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 mario.limonciello@amd.com, xin3.li@intel.com, perry.yuan@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <cover.1755224735.git.babu.moger@amd.com>
 <4d497589d3bb5389565676512c2116e5cfa6df7c.1755224735.git.babu.moger@amd.com>
 <c5f97d82-bb87-47e8-bbf0-e9dfca332313@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c5f97d82-bb87-47e8-bbf0-e9dfca332313@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:806:6f::20) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 165a5bc7-168a-4080-f07a-08ddeb10ab8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0xuNnpTZlhKZEI4Y05EeDFXVWczb3Y4RG1MOGVGRStQYmIydFN5MHdadmJE?=
 =?utf-8?B?djZWelZiTkt2NjZHYUpzMGxBSVBTUzlxaU8xaWxZc3hFSDZCT1RPTWU2a1JS?=
 =?utf-8?B?bDlZM21FSWlDNHRzcHlpeHhPVitpVDFMai8zcXRrL1p5eTZ4NVhXdUt6K0hW?=
 =?utf-8?B?ekFvLzJPNmNIdmluTUY4UnRYZW42UHlOcVNweEF6Tk5UdzhRWjgycEp6UG0w?=
 =?utf-8?B?L2Q1UER1eXdHVlB5allUeXRRTEtIeDZOREFxMCtRcWhMYjB4NFNjWmc1a2Rt?=
 =?utf-8?B?WGw4TmxxZFpvenVHaVdGUHc3QnVjZnh2NUVpTWJNamJzUEpmOGNuWVVNYWxR?=
 =?utf-8?B?YVh0OEJRdDI4cTRTREcva3cwMXJrWHduamdjVGo5ajRseUtFSUw4QS9QSmZm?=
 =?utf-8?B?SmxIaU02cnduSjlQdnhVM2tuMTVnTlBCa0JaWEJLWFpOQ0pnRVFTUVNZNm5Q?=
 =?utf-8?B?M2k3SzI0bmFkZWhvSzJtNUZWcS95NDNnWWZSNFNZbUEyWW9ya2tVZDEzRjJ5?=
 =?utf-8?B?RVNEdDEyamlMYlU5bS9OdFE5UlgxUWRNVE81WmhOT1dBcU9vbnlDd3h4VnZT?=
 =?utf-8?B?bG9wMWpNWmNGd2N6VUpQVXBkVUVXUVc1dUJJTlkwZUdyQjVWQXhKdVh3Sy8r?=
 =?utf-8?B?V2xxQzR1M3UwdTNuTTBxR3pJb01JODA0S1RidFBKRC9Jb0lWZDRZRDdmc1F4?=
 =?utf-8?B?TzhSRG91ZnE0TnJqVEhISEM3MmJqV2VqTzI3VlZXM01XNVFkMzlLRzdxTDc4?=
 =?utf-8?B?WTBPZnA2SGNPdVhnVGtKWmpGRG5veE5aWkFEMlpyaTZBdmFJdHZuZHZ5SGEv?=
 =?utf-8?B?dUp5dEtZQzBWelBwd0ZvSGNqNmdBd0tTMHNYMVdxK1F3bnZKcGVjWjJHSFky?=
 =?utf-8?B?R0gyUmlIbWMvOXJhNXhPZ3pVZWJUMm5VdUFMeWF6MUtGSDBCMS9UKzRPWU5C?=
 =?utf-8?B?K0hmZXcwZ01wb2R2REhIQ0UwRnhxR0tvZmtpb0hZM1FGSDBXOStUbi8rMUZl?=
 =?utf-8?B?MTJqTytTdUliTktPbGtJZ09mQXlQaEh0VWVWZFExSGFaN3F5N2phYlJCYUJD?=
 =?utf-8?B?L08zOXdMWHp3YXZQUkZxVkh4S2k1NEhRMTZUQTRTR0dkK0k1c0JPTFdWN2Mw?=
 =?utf-8?B?UHV0Qi9nK3BNb2tEeTFFVWVzNllpQnl0c0FrUW51NTM1MFd6YndwRXZJNUdS?=
 =?utf-8?B?QmhVa2JhSkloSnVLbEUxbUQzS1VGNGU3R0RJNUJRZ09oVjIyZ3FCSk9PVlRN?=
 =?utf-8?B?WmNnZDI3dXByMUp3a3E0U3dwd2tYQ3NRa0ZEOGNmaGU4b2wvcHZFdGdVWlJT?=
 =?utf-8?B?aXljbnRhakVwb05PaThrSDBiYno3MEY2bmk2V0VHUjAreHZQNkYrczY0a0NG?=
 =?utf-8?B?eHBNTHpNTS9CL0VhUTFhTlpvRE9zbVhKNVJOZ1NTVjcxRHFkMHFQR1BMaVVD?=
 =?utf-8?B?VloyWFRhaUNWZU5XMGtrRElzRUZhUW1DKzkxYXJuNnBkbVlBbk9zeURENWhk?=
 =?utf-8?B?N0RLbjl2RjhYY2JyTm1IMjludFZMdGNwdHVrTzg3dU1EcDl2SitqVzBVTmVB?=
 =?utf-8?B?ZzlUcEF2WFFKVVBQRzhXelkyNy9oMUlsdU1ZS3JJRGdFNzgvejE0cVdoRjlr?=
 =?utf-8?B?ZmxyYzB2SDJBTStVS0trZ3hpN0hoVHkzZ09VOXd0MUlUa00wVW9Xd3Z5Qnd3?=
 =?utf-8?B?NFZQa2ZSSW1CYUlVVzVqK2VidmV1UE9XMmtaUG1TY3UzT3NiR2xSRnRKSkp0?=
 =?utf-8?B?Z0JjMXBZSndBcWlULzZXU2RpaFY1UHZHcmMzTnhJdHAzd0Z6bHNNa2E3eVpv?=
 =?utf-8?B?YllqNmlkc1p6U3k2M2wyVVdYK1VhUXVJb3NPTGJJQjlpNGxZc01RM0Z6eEF2?=
 =?utf-8?B?ZkpSMHBaM3BabG9zanZkL3ZNTGJyZFVLUlpQYlFwdm5aRzVWQ2ltejMzYjhR?=
 =?utf-8?Q?THoyAS5ENm4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am01QS85UGhaVTd5ZDdrZGs0RFJOUnpsZmlXamZ5TUluamhnbk1HSjJjYmc1?=
 =?utf-8?B?YkxEQ0JTd0w1UzExUk5FNmxyQi9CU1QrU0JKYnZpakhFakQyQTIzdmo4M2VM?=
 =?utf-8?B?RlVRUG4xODhleUFNS2xpNFFjUEVFb3Zrc3BOb08zcjg4WnlKQ3NmQmU2QVd0?=
 =?utf-8?B?c1gycjdLUDM2MW5Jd2FCYTcvZzlSTjRaMlQvQ2E4bFZEOVBHNzhwYmMwbFpH?=
 =?utf-8?B?TU44alZlWDlLTFk3ZDR5cVAvNjVUUm9hVW8yZC92YSsyTUJXWGdQbjk0SnFo?=
 =?utf-8?B?eFIzV1hKLzBBeWQ2NkVmNXkyODErbms5YlFVY2g1V0pkUDJRM3FIZkROS0Z0?=
 =?utf-8?B?KzhIY3ZRbnI2TldLQ2ZDZDlTcGE2YUg2Tks5Zjh3VmwxMlVTSWlaYlhmQU00?=
 =?utf-8?B?U2JzOEY2U0NqMy9FM0g1KzB5UzlmejhYdnQ3VVZWTmpZZjdaTk1ScXdnOGtj?=
 =?utf-8?B?MmhPd05sZTY2OS9CSmFVWktLa1FBdWx5eTlaTjU5cnJxd3NBNDhNWnhsNWt5?=
 =?utf-8?B?UTIzSWg0NE01eEVCTHBlVUMya29nVTg2NFZCMzM1VHRrSksvSUJOMnRhbTZ0?=
 =?utf-8?B?bXk5QklGSFZDalFDdEhoSWR1SGwwQkh3U1JOMlh5ZzdhRnIzUUtuWnE3V0t4?=
 =?utf-8?B?TW1IVXBUMDBoOXRIdnVrWWRzaUpNSEVoUWdTTEptSTFOVThndFI2RXo4ZjF4?=
 =?utf-8?B?UjF5aFdOWUxTNGkxMHp0QXY4U05QcUpwR3I2RExQSUFvcHF0dWpxS3VlTCt0?=
 =?utf-8?B?MVg1SlJqWER2SjkyMTZCWUE3d2pQcUg5aGp2TXhVWWZRVHNFQ0lhUDdTS1di?=
 =?utf-8?B?dGhIbUJ0M3F6SnZiMzVvMWczTExXTFJpZWRkQzdhMGJyQzdmRG5EenNoQkdm?=
 =?utf-8?B?Y3UyaEZYbTlMN1RyMTVwS3IzQ0dCOW04WjRpbzlLVGlCUlNSWU5EWUQzdFVy?=
 =?utf-8?B?ejdtU21xdFA2d1pQdHRSOWI1YkR2SGhUb3g5YkM4SEloYWFLVGR0YjJxTXdo?=
 =?utf-8?B?MkQxZXNjeTFLN3YyY1ZoeE5oR25OKzdaWFNhOFFSdGN6eWRWUXI4UmdXaGZk?=
 =?utf-8?B?ZWdRb2p1emtoVHRKYjdxVnFHajR3b2dTemV1Y1U5MjhKbEdDcER2UjJZaVB6?=
 =?utf-8?B?SUpDbTBOdWk4RER1bGwxcWo0QkVVd0k4ZmVFd241bitXeWo0bndFTFl5cXZC?=
 =?utf-8?B?SDlkaFowVlhuMEVUY0JaOVlZRUVkMWFBUlcrd0tScDFRNTFFejR3VmJCZWF0?=
 =?utf-8?B?Nk9FdUFod1pER2VpcUZ6VjlJcGFFZHI1K2NtQlFMRHJUcFZEWUJFWWUrN0s4?=
 =?utf-8?B?VkxYWmZUMEkzdVpFQStOd2NxMzBlWXhYU3dIVkpENkRibjFlTGJxNlV1L28x?=
 =?utf-8?B?QjZ1VTU2cU56R1kwRnViVEJDaU9FM3l6Q1hjdmZqV2lNTisrdTJEWWg3UE5U?=
 =?utf-8?B?WUIxUlBtZ2xiSG9qMndQcnoyKytBY0NjOTJaOWdKZVRBRWpuRm8rbi92L0ly?=
 =?utf-8?B?aGZjbmxSQi9uMFZqQVI4dlN5VFRuMkNCcTlNRlBZZzFJRTdjMTZLT3Q2dmt3?=
 =?utf-8?B?M2hKKzhRemFCZzBETHpJdWJYd3lXWkwrdFVEdjdNNXl1WHczSU9MZFV2VUdP?=
 =?utf-8?B?ekNTMVBuWGtwbWtXRXVsQ1RyZHN4TlJTZ3FaZzJnRHh3RUZ4Z3ZDNVBkeHdl?=
 =?utf-8?B?b0pwOVQrV3JNbHZSQTFrelR4czZIMmI0cUxpUUNuSkVEVWdmMS9qeGRQd3g0?=
 =?utf-8?B?dTUrMUorWTQvM3c3dGpaUGJXQnp0UmxwZzMxVitGUTY5eStIVlhsTGs4RXpv?=
 =?utf-8?B?STYvQ2R0NTNUQjQ3dmVRSTVrVDl1VW9keWxFK1pCNmJQbzdtZ3V4OVhnM3dy?=
 =?utf-8?B?Q0cvZWZLZXZLdzh3clhLMzVoeW9iYzFGVzV3Mmk1M1RtT2hsaHhYYUkxbm9n?=
 =?utf-8?B?NUc1Q1dmemRYOFkxSDVRT3VGT1BDYm1pd3AzQjZ4cElSdGFJM0lnYyt3c0t6?=
 =?utf-8?B?c1A1STlxeW1QVXZaTDgvWWpWaGFQd0ZWd2QvQkFjVG9ENnNKK1VqWGdkd3Jy?=
 =?utf-8?B?ZzN4WVdVMHFvcitTYVRyR1FpL2lIYXUrVTVmQ0hsM0hLY1VybEM0b0FiOE9X?=
 =?utf-8?Q?wQvk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165a5bc7-168a-4080-f07a-08ddeb10ab8a
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:38:18.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUm/EWKjRIwFBpSdt1Lk3pCaJ2mPTgirSskGqClGXbhPbXtEcspnXqEwq2BoS74/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807

Hi Reinette,

Thanks for the review of series.

On 9/2/25 21:41, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/14/25 7:25 PM, Babu Moger wrote:
> 
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 25fec9bf2d61..9201fedd2796 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1029,6 +1029,125 @@ int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v
>>  	return ret;
>>  }
>>  
>> +static int resctrl_parse_mem_transactions(char *tok, u32 *val)
>> +{
>> +	u32 temp_val = 0;
>> +	char *evt_str;
>> +	bool found;
>> +	int i;
>> +
>> +next_config:
>> +	if (!tok || tok[0] == '\0') {
>> +		*val = temp_val;
>> +		return 0;
>> +	}
> 
> Looks like resctrl_parse_mem_transactions() can return "success" with a parsed
> return value of "0" (*val = 0) ... (follow-up comment in event_filter_write()).

Yes. *val=0 is a valid value.

> 
>> +
>> +	/* Start processing the strings for each memory transaction type */
>> +	evt_str = strim(strsep(&tok, ","));
>> +	found = false;
>> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
>> +		if (!strcmp(mbm_transactions[i].name, evt_str)) {
>> +			temp_val |= mbm_transactions[i].val;
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found) {
>> +		rdt_last_cmd_printf("Invalid memory transaction type %s\n", evt_str);
>> +		return -EINVAL;
>> +	}
>> +
>> +	goto next_config;
>> +}
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
>> +	struct mbm_state *m;
>> +	int cntr_id;
>> +
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
>> +		if (cntr_id >= 0) {
>> +			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +						 rdtgrp->closid, cntr_id, true);
>> +			m = get_mbm_state(d, rdtgrp->closid, rdtgrp->mon.rmid, evtid);
>> +			if (m)
>> +				memset(m, 0, sizeof(*m));
> 
> This looks like open code of rdtgroup_assign_cntr()?

Will call rdtgroup_assign_cntr() directly here.

> 
>> +		}
>> +	}
>> +}
>> +
> 
> ...
> 
>> +
>> +ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>> +			   loff_t off)
>> +{
>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_resource *r;
>> +	u32 evt_cfg = 0;
>> +	int ret = 0;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	r = resctrl_arch_get_resource(mevt->rid);
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	ret = resctrl_parse_mem_transactions(buf, &evt_cfg);
>> +	if (!ret && mevt->evt_cfg != evt_cfg) {
> 
> ... is evt_cfg of 0 (a) a valid value (that will not cause hardware to fault) and
> (b) a reasonable value to allow? 
> 

The value evt_cfg = 0 is valid and permitted for both ABMC and BMEC. I
have confirmed here through verification and testing. In that case, the
event counter will not be monitoring anything.
-- 
Thanks
Babu Moger


