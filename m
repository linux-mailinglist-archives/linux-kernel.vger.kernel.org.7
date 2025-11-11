Return-Path: <linux-kernel+bounces-894525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32321C4B3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC8B44E2889
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4B8348883;
	Tue, 11 Nov 2025 02:44:38 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021078.outbound.protection.outlook.com [52.101.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51022330328
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829078; cv=fail; b=YsSYMfh3jslj3enPgR+CH0v46cXvDCtQ51OUKKyrKVdzvHLwWRtHCHnkTYbq0N60zQJJLaoIVIgIRWKbMN11MjXzADRqEVCRqvaKL7XTHFCfelE/LkX2oSnekpMrIT5nshStGrwsgw1O2FONFcEX8U0ki8jHhC7swYVkg0yljIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829078; c=relaxed/simple;
	bh=PAzQCxxLy0d1vc6KAH89pC87z3EVTmDlDKw+Z/qIDVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GjHXpJcPbo0GKp3ggSpMFjtv3E5zu5ARuwB/I55RDIYtzCFzaN9G0mh66X4+q3D7Jevly5ZpClFx5Aa45o2t4EPRd+Ys725CzHcp97QmeSA/TNQqfOw2FYECkF/u/IlBu0kBMWMPEVryl2xOohh/u+rpgqtidMaEYkJNztPdWkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4dRTVQH85zakkI5O882hwLelCge17CNesB+Y9i2+q9g7KdA9quDFTretTTHEVMSHnGI8Y8vARhpyu+nHcWactxEM0yHr08JZsERlk2e/QvoJz2i+taxIHMpNz+XBJ51y3KAkUmIYDrKaiDNxbvF811zjeQV1TDR/wHe7e0Kgy0UEze9CZgQs6lUD6uZUBqCyHNzV0yBKU5rJKmocWNimmsLUFSabAG2KGDmBuWACj/lnWYcDevTnxWVAhQs7JXzCSzmbhZGmCKG3oGa4xHEHO1XDdaOqNmibyE9wW089T2BtA2mITJf1Jds+dDlD1WegA/b/E+nQJLc+7Xo9Gg4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WwKrbvcNGu32bkly2LaezwlYczC512ysz4Bws+GP1o=;
 b=BIWtCmRjaAOC+jn56uwHQHQ3dW7l0iLosngiaBcbMnH6A2UDBWMz1MdrlPASdE0acMcnatLzRezd/F1gzLQI0k0z1+M3H0Zpcj5NX4DET0NDRV5ymgs7Ny/TrEgnO/hchgfjkw1b7rESkJEvtpfb1rEqn1kRi5Ij2K8VklYVYta9wKc45lZUjSBX6HvC4xsHd7T3a8HtXw1T/nR0//n8m2YWZjTJDGlDu1npm6UDw4R/5gZf0BrjQ8yCGrb6bCVGMOVQBPBz1UKsv+xUPtKbEQCmB/Ae+ECOWbwERmrbutjiGt6P/aqLekLNBOBNpsVcvdeKse9PTViWfPBYczPmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOAP123MB8301.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 02:44:33 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 02:44:32 +0000
Date: Mon, 10 Nov 2025 21:44:29 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>, 
	Babu Moger <bmoger@amd.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>, 
	"james.morse@arm.com" <james.morse@arm.com>, "babu.moger@amd.com" <babu.moger@amd.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Message-ID: <w6thhucyyfnveawixyub2yugsb3s2goiocqtene7s56csrgtfz@x4zll7p6tyla>
References: <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
 <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
 <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0392.namprd03.prod.outlook.com
 (2603:10b6:408:111::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOAP123MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: ff90d679-7db1-451f-83d2-08de20cc3e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SElybWo5OWQ0Mm9qMnE5UCtSOU4xamUyREtxYVpxaVdNVmFZcFE2cXNwUE4y?=
 =?utf-8?B?U3U5ZlB0Q1FLK3FnM3ozT1BNUitYL0JWbWIxUlJtbDdkUXpCeXp2dDc1OWdC?=
 =?utf-8?B?UHZwMnBnVDNxcnF4WXpCTzMxb2dYalZLaWVYSks3cE5XdENtN2ozZGdyVGVU?=
 =?utf-8?B?eWlXR1BCTDVDaW91L3doSHJmSFE0eldVV0pIMkhsaEpRSlZlR3RvMnl4NDJq?=
 =?utf-8?B?VlZDWDNkcFBiVzZHNWlDRWFqN2hJYm5ZZFlaMGtZQjJQSGtkWmFybk5aMjNr?=
 =?utf-8?B?YTNIT0g2bnZnRElvbHlBWmxTR1RqTlNzTkIwZkdwRE9pcm9rVFVNbEdOUGs0?=
 =?utf-8?B?VUZsSGd5MnhoOExacGJHTmNGbnRUQmlYaWJHUGxmK0tNYVJHMHBqZkFyUW5o?=
 =?utf-8?B?aGY0UUxnMXpkUnJ3NU5BVXJSSU9oZ0c4OGJPQkxub2ZxTnhyRWlOdG02QTVW?=
 =?utf-8?B?d2lhNm9nVzhONEdtcnhuNS9TZzkyNk9Zc2dzVDMzUDhVME1Ia0NlY3pkK3Bh?=
 =?utf-8?B?TkFuL0VZK2M1MlpkMEs5V2hJZ2ZVelRYa0d0QXRmcEYrM2Z2ZlBsMzlHSkg0?=
 =?utf-8?B?dkFzMHh4UDc4OW91YjRRNCt6YXh6dm51UjNPaTRFRXdSMFpDSFJFajIxcE5S?=
 =?utf-8?B?OGhpNXBUckhlTDB6by81S0pEMjNVZG1CcER5T3cxYzlTNThLME5KOEtXOGhO?=
 =?utf-8?B?YUJqeUFFeFlMcUxTWG1DNjhSckpITlY3bGV4RmFZTEdpTytQd1ZIWlp5NXFW?=
 =?utf-8?B?YjhGWENZQndGNTcrcFZNOE1aTEhFRnhsVDdGakhFWklFSC9oV1pldkZsV1Uy?=
 =?utf-8?B?aXdTVE5nWHlNQTVjWWxPbnlWV0Q1OGxCNTI0aFMzQnBqSk03cG5Fbzg3U0k1?=
 =?utf-8?B?VFNjUHZSdzR3QnJWVnV5YklMMGw3QjRnQzRWQVpmOVcreEo5akRXWi90djJu?=
 =?utf-8?B?WlB4Sm5meUlCdXJYZys4MWg1L2JSSGJJeWtya0VBaWNJTlJMaGhDaWEwcWNB?=
 =?utf-8?B?dENVWm9pZVh1ZTRhRXhpaTVjUUhkRmcxZjVIMFNGR3F1dys4UEh3ZmpoMnNJ?=
 =?utf-8?B?VXJxRUh0VWVyZkJvZmZGZEt1MjdKdWdjUkVleVhueE5LYlRKaTBoK2p3U0hp?=
 =?utf-8?B?MXliNitVdXM4R3V1NU5TZ2d3NFppKzM1WW9NRjdta1VkWFdGNlh1SVBBVmE3?=
 =?utf-8?B?N0pJM2h3akVOSmJ6VUJwZG8yRjFtZTM1QTBlVno3amY1dnhvbnowTlhaK2dZ?=
 =?utf-8?B?K3pGMU9hMExZVUxmc3p1c1JialBZbXdtenRlZWQxN1ZyMTluVTNnWCtlbXIz?=
 =?utf-8?B?Q05oVUVZSkd4Tk9McDJMMG9XblE2ZUE1TVhhK1o5Y0tDRFJ1Mkt2R3VWam9q?=
 =?utf-8?B?eGp4U0FRZmljMU4vVDZXd3BheThteC83Q1RYWWVlSzFRUVFZeFA3OFZsaVU4?=
 =?utf-8?B?dzhXdXlQMTc3VlhvYnpNeVZDMmdtY1B0ZUtaeEVyTU01dHlXV3UvMVlVblhB?=
 =?utf-8?B?cjM5SHc1RUdNSnZVcE8vT2w4aGtHdmk1QUlKbUt6Q3RYeVl4R2hWM0xlc28v?=
 =?utf-8?B?MU14Z2NJM1RoUFJlTEp4WlJrUS92RGl3R2FaU1NiNGRCaVBlMUNXa0s1THQv?=
 =?utf-8?B?UGh1TXhJTTU0K2h0NG52MnBHNk1Bcm1RbFFIblQrenVPMUx3OFhkTGF2R3lw?=
 =?utf-8?B?T21aTFpKbGtrMmhvUDBzUytMd00xempLZTZMZVdKUjRGdElEOFZvYVJBaHNC?=
 =?utf-8?B?Q1NXYTgwV2xweitjd1BjbEcyellSakFTZ3J3VjBuSGFuL2ZkVmRpSE1ySElo?=
 =?utf-8?B?RkNWczBJMndMWExZa21IZjBSSmpIKzlOS29Cb1laZ3Jma0JkWkM1ekFZb1BV?=
 =?utf-8?B?eDEydmhuK3c4dFN1TjR3M2dYVkVoR0s0a2tWbUN3UmxjQzFZQ0RSd1FOSnpq?=
 =?utf-8?Q?FOxZrGpGa2xCnyyQTWmUtPmBhKkh36LG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U29MVmlNUmJ2QnVLTDJ6SGFLQkY4Vk0yRWxhS0RON2tyQXZ0MEp0Nm5WNWxC?=
 =?utf-8?B?VFhRai9HV3lmbWduSHdOYWYrUnljaDhrOUdCV2h0ZHVIRm5sRy9Ld2h2NjFy?=
 =?utf-8?B?Y3IzZ2xiSXpyTmxJYmlwU3NJdjNGVUVORVRNZ1ZUU0lmNjZZTVlNQUlCRW9P?=
 =?utf-8?B?b2pJS2YvTUtzUitHRmF4bllwaUNTTnV3RFpEdlVPWUxXYy9aUlI0N2RjSEZM?=
 =?utf-8?B?V2xiemJlRGlQQUJHcjgyVXFHdHByN3c4OWdUVTdUd3ljZzA4dDV0MCs4YWVs?=
 =?utf-8?B?U0JSWTBUdUZRa2s0RXZGZy9QN2ZOT0svZE8xMUtLaWtSOXVpMU53ODZJT1cx?=
 =?utf-8?B?WEJSSTRVSnNjdG5aL3VNTG0waEhiUkxIdmhoQm1iQ0RtelRCUHlPL2VJSFdV?=
 =?utf-8?B?TVdFaEY0blVULzBLbUx5cEdYZ3V0Sy95MGJKZ0VkQU1VdUpCbVRmeVdXdWlO?=
 =?utf-8?B?eDdpS0svVGszMnFpRHZTK29tVU0wWUpUNitlOGFkQzFYMkpBdkNWbTk0Vjl4?=
 =?utf-8?B?V0lZbVYrOTJ6Y2RHYjBZcThvS2xFZ21MbHRXK1I2dDR0K2wzN1JlQjFWT2tI?=
 =?utf-8?B?aVhYRUhSb3hqTFk1MzJpMWZqM0lBbWtMd0MxRW9oS1NRZkpjWU13d0x6QXRm?=
 =?utf-8?B?R1VuZk5SSW95Vm1Bb0xaZGdqRGVVRk1jMURuc0tKNEZuSTR2WFM3WHRVZkE3?=
 =?utf-8?B?ekRBK0JSbTFZTi9OUWgvUDBjZTZuOUZZOTdLZTVsSEhkV0pnWHhxVFZRKzhq?=
 =?utf-8?B?VlFLRFF2RTJEbTFrNUFzVnJFMWM5TTFrc1dMK2M1Uy9IWWVSMkRVNUgwaXBP?=
 =?utf-8?B?YWQvVmZYcUVZMFl1bmRrNTE5WHNPWjgwaGFHM2lIQ3A5TDZ2UWRXMmZpRE9w?=
 =?utf-8?B?Q1dPTDkwZGlLbTJmSmQyd2V3ZEZVUnlydFBMM3RCV2tzNXo4TTU4Y0hYSTZS?=
 =?utf-8?B?OFUxWnN0Ui9zcER0S0FMNS9waG5nSE1xT1VLbEVVK3NrOTRJU0phM3lVMDNu?=
 =?utf-8?B?VzVXMlFXTmtTaUdwREpQS1BOWEs0QXpmWDBRaTYxZ0dWNUk0Wk1mellrT2pM?=
 =?utf-8?B?dkpacTE0NEVtcGRHTXo1S2F2TGNLVTZWZG9WSjJVQ0tuVGpPL0J6a3ZLMXdC?=
 =?utf-8?B?a0d5emtwVzUzWTZmNTRTQWl2MjU4RVZzNWVZbzBwTjhKamJoWlBFQzJTM2hU?=
 =?utf-8?B?ckJXY1FldWJlYUtkMUpzT21QWmw5T0tVcnc4ckkvbWlrT213ZWNKbXFKWERD?=
 =?utf-8?B?bS9QYXJoQkJHem53cFE5M2d6a1YyMDl2S0U5V2gyaEtEcGk0YUwzd1B4azRI?=
 =?utf-8?B?SWVQTlZXNnROajBqLzRTNkpoWmdVQ2F4YjBsckhZTjE1TmNJemZ5YUV4MkNT?=
 =?utf-8?B?OFJlblIzbDcxVzZsSkpXRFBQOGJTdW84Z2hlcFN6RDU4ZzdlaEEyMFluYUtF?=
 =?utf-8?B?WnVkSjNrbkFETmhvTTBhNXUxN1JYcUFVS3VKN1VWUmlXenBCcWNpUGp5RHMx?=
 =?utf-8?B?aUQ3d29iQW5RVHRiR3FtRkYxRFNTSVFvQnp1c3ZCbFpmWTZZUkQ4YTNWYTB3?=
 =?utf-8?B?WjVvTXh5NmQ1K2NxSTBjc1J1YklRZ0ZKeEg2TFFZZlBaczNSYzd1NFVYUzZO?=
 =?utf-8?B?amxRcmdxL1N5bmE5RSt0aHlybnduWVZLaktVbnZtZVNpMk45Sy9lTlRHeFpE?=
 =?utf-8?B?YUVES21FcW5DSm82M1NPVG1zbVBOY1VoUTFkaXFoK1VrZy8zZnFJNUdwdVZN?=
 =?utf-8?B?YWlHUisxdm04N1BHRzExRStkNUIwRDVYcC85LzJZbVRZRVRKWjlvZVMxMWpX?=
 =?utf-8?B?bnJBa0xHMFdseHdjM05JcWY3VnRIZlRzdFQ2MHNnbEVzdXZCcDNXa2VPTmND?=
 =?utf-8?B?Z2JJTElCZmtPVW5rL1hQVXdTSzNNUC9pWDBUVWNBZTBqZUozaUtKanVBdVh1?=
 =?utf-8?B?L2orK3pYTHNZb245RTZWSUU1ZXREQXFuaU5XeEpzemR0UHhtVkJlSkZTcmZH?=
 =?utf-8?B?MmtGdFFYOWp1RWNpeTc3WE9KMnBIU05lV1FJdy8zTUtDdHNFNjVXYXJ0elcz?=
 =?utf-8?B?eDJnMUhEaGI0dGdoZll6YjA0UmdGd2FBRXMvRG44RmVqTnhIdDFHYk84Y2dT?=
 =?utf-8?Q?GVDUdBcU7iHC2Q+raAQ8C/sLp?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff90d679-7db1-451f-83d2-08de20cc3e76
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 02:44:32.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByfdfPYcI/na7iRG0QhLcZPy2dqj7CIHSBPz3upxb1Xkhci6Y0NBbs1RP82JvaDPVL/n0wnY23iVS2jSigheow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8301

On Tue, Nov 11, 2025 at 01:40:45AM +0000, Luck, Tony wrote:
> > Seems like user space has needed information to perform a sane reset?
> 
> Like this:
> 
> 1) 	Read info files to figure out what minimum mask is needed for this system
> 2)	Use Babu's suggested syntax of
> 		# echo "L3:*={min_mask_from_step_1}" > schemata
> 
> Rather than Aaron's
> 
> 	# echo "L3:*=0" > schemata

Hi Tony,

I am satisfied with either approach.

However, to clarify, the primary function of the "io_alloc_min_cbm_all"
interface is to efficiently set the lowest architecturally valid CBM across
all shared L3 domains. This operation relies entirely on
r->cache.min_cbm_bits. Since this value is guaranteed by the hardware to be
valid, this approach is robust and will not return an error (e.g., -EINVAL)
to userspace.


Kind regards,
-- 
Aaron Tomlin

