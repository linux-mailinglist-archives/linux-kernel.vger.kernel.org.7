Return-Path: <linux-kernel+bounces-833770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC41BA303E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1714D16C725
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64F29A9F9;
	Fri, 26 Sep 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ud6u5AIG"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021139.outbound.protection.outlook.com [52.101.52.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671EF29A30D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876684; cv=fail; b=YNKFWD7awHkDYI2aucUo2ud2iSAtffP0EUzl8aghbDiSbSvOGPkmhpBH8/qg2mtLbqXYdbJQO8FkjPBctEMuBcFi+gSavbHI+akNP5Kq8Co4T2kfUABGdaivtQGs0L0GtedPs8WjaZzgwsLuZntACKZQmMDTsjRYZpEWJ6gYeC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876684; c=relaxed/simple;
	bh=m0LNCqOP1pY3BjR/bD2Grh+aUz6c3Oabk+UYdZnN+LE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A4KQaTHCUApdrYYXQO5Izys0qa3X3p9rGkcefMh410/Um71zoLVY94mjfL2b6Zmq0ruYyJb6S38oSl3Wtn6dFql1d2uzsuOgF2OmxXyHFye1PBy09ceDYf18wOABHuKTk0RnQ2B6k/2VlCPWB3dJSxEb3ixQa7ZsSiZOFawmMM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ud6u5AIG; arc=fail smtp.client-ip=52.101.52.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD4M8KP80zal7tykvjs9P71bHPbqLIHaHZJqymGSiAAbsVmCh1JDzRRuRkrcWkOQv5rLVcDWm1gJP/OYB7/jglODi2DusBlWVxCbC/rpLN1Sne5k2h/irFAtvvF7ubcayd9SDaqByE+6BtOM3UUXG65E1YGGmHM7cmnWpUju4fxAX91AhG3je4VrHyCKRS397v4f7TgC6tPB1OI+3L5xayvMJXdrpm29IYH/D/fCXbz7g+zFKVHW4+40yQc9OsvOmmNnqB8MHye2V0ag+oER0/NYCEXRGCrOSATIOZX/jHHjENn21ac/oqcjbJxztn1tj2FRJOcdgSHoyYg66PhBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1Cu4vU0x8xSL0z6vTdPeeRccmPPfjxISn8WwPxccYo=;
 b=tmtBAjWUErcZWNGMClhuUvPuODeyqfkih43IjRu0ttQmfWTB/Kqpt0PbNE6EuiOGYPQm1GykWjZkor236FKyIZ0Easu/zkcaFj7ObDdxPkL39drZBYYDdlmPAHEmO//Z6QRzDTZNBfip0bSTj2sXa1WQ9Sr3L8R7FGhS7YR4NLpK2HtKEUGtpSaflwyy4hNKxwS+IGUNu9s/yGoRaqbSVLIFE5Eb+As9aa3Um44AE8ATuzo8RIJ9UA4X/wUbKMJoV84LY7YuGdDCqcGVl2lnkUKxfUhPJmDnwUf1mY9UTbt4rg+Uq4WGqMn2xP3hdznbRWZj4nqja8zZLR4iOMavAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1Cu4vU0x8xSL0z6vTdPeeRccmPPfjxISn8WwPxccYo=;
 b=Ud6u5AIG5Nlft5U85FAudlHtYV+A09dQGvIWkg/eThGGtLXfaJBreTqJjLd+AgQlg9oTaNGU0CMixidOcJVcmsUWMfF/Y4uBFJW9gzAtIPrMd9p8r1aaqfJW9yhJtLS+NKTvzk4Y58AACIJLx+uPNA3FjZHgJZUT4IBdV7muZnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH7PR01MB7727.prod.exchangelabs.com (2603:10b6:510:1d7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 08:48:36 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9137.012; Fri, 26 Sep 2025
 08:48:36 +0000
Message-ID: <3cb6ebc7-a2fd-42b3-8739-b00e28a09cb6@os.amperecomputing.com>
Date: Fri, 26 Sep 2025 16:48:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 26/28] sched: Do not enable cache aware scheduling
 for process with large RSS
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Libo Chen <libo.chen@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Hillf Danton <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
 Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>,
 Len Brown <len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
 Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <881a665a94858d4fb6f13491f4dffe58c8fc3870.1754712565.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <881a665a94858d4fb6f13491f4dffe58c8fc3870.1754712565.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:990:4::17) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH7PR01MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: eccd7b1a-941a-4817-4b50-08ddfcd97b07
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFZjUnpKMi9BclNlVDVEN3BSNVYyZGtxeG5OSms0U2NGQ3FjOGVYekF6V0hH?=
 =?utf-8?B?K2srbVRnVUFWZVRUSlpWYmZCcEs1T3lscHpMSzRSVnlFRUpPZlMySW9sWkxI?=
 =?utf-8?B?aGtoeEpJcCtuREpOOHRpaE53TkhjNG5DMHFnUEI3Y0h6cFNGNlJDVEVubUt5?=
 =?utf-8?B?TnRHZ1FWa1ZqSG12N0FSdUVTWmxlL3B1ZkdwTnk0MjZGVTYvbzk1RjJKM053?=
 =?utf-8?B?azVuSmN5NzZtc1pLenpxZmpoSkx5T2V6SVpsaTZ4VVgxeGN4c0dTTWtMVGtV?=
 =?utf-8?B?RE5DS1FodU9nK3N4RTRuMVdObHlGRUl5c2lWNkFsVFVYb0dsMmt6a0t2VEZ6?=
 =?utf-8?B?L01RTmt6T0g4RittdU9QRjFhSm41ZEhranNuTklKN3Q2VW1icWl6OS8veG5r?=
 =?utf-8?B?b1NaaXp1QUNqOGcxMXJsMlgxNmlHZjdQOEpVa3hKRmt5MG1pOGs4YzFxSTYz?=
 =?utf-8?B?VWJwQkpGQkN0WGl4MnpFbXhHTzZIUkJ6VFhJNVVGaXB2NCtGcnJkdFYxdDlN?=
 =?utf-8?B?VEx6RktESlcyWW5lUHVxUkplSCtTT3lWd3RlZTJ1ME83U2NYR2o4SmcxQmlQ?=
 =?utf-8?B?RjBicjlBeVJWSWg5Y0ZPOHpReW1UR2tJZU05MXI1a2R0Y0ZYVGxBRGhFd3lt?=
 =?utf-8?B?cnpxUkhnSTZ0NVVvTjJVbks0dzI1MkNMK0hxLytOd3VMVy9tQm14YWFEbTd4?=
 =?utf-8?B?T0NicFBSenkrK3pmNTlTSDZLak5ycXhoMDJsVUdvYmFsZVJyNWMyUmxWNS9m?=
 =?utf-8?B?aXhsZFhRd0FEZC9mWWtETUV0cGk3dmhLalBTb0thRkdTRUdXYWJKL0pDT29X?=
 =?utf-8?B?L3gzdjgxVDJJSzc5aXpLZFdPTjVvQkJ3cGYrSzBQNnp3ei8zY1dwTVJMQ3M0?=
 =?utf-8?B?SnJ3ejVsdkhGczRod0xSNFZWeGtJYXlac3YyaFRJcG1naE9EOFIzaUJkclZ3?=
 =?utf-8?B?SEwyOGlBU3JHUVFWWnhDb2JCNTFQdGlhN2dGUFVQVmptQlRZSTJNd3ZBUUlj?=
 =?utf-8?B?Kzl3cHVqKzdkcnBhalBMV0pxNDVBLzRrTzVtWm9jbjEvZDc0SjJXZk1WNnhS?=
 =?utf-8?B?VE1EeENPQmlYck9nQU1QTGRRVGE3bkNBVTQ5dUNFQXRwS0t5MTBWdHVrb25R?=
 =?utf-8?B?RDZMYUxlRHpETFhveXZoWStGMDEwSWhMMHFSRGgxSFRHdldvWlNEMEo0aXAr?=
 =?utf-8?B?ZWtIbFFDaGNocDR1WGxJd1NtYTh4Nk02Z2YxMlljUGNEeGFRMlg1ZEdidkhB?=
 =?utf-8?B?TzJsQU95ajlZWFVIQTNkNkdQaUpoQnFoTnpQQ3ZnTCtFWi9KTitXSGNsb1BV?=
 =?utf-8?B?TGpYVmxkYkx6VmQ0UG5oTHErS1MwNlBldjZwNWw0Yjc4RUlnUTZvTWo3NHVq?=
 =?utf-8?B?NytLTytBTGx2L2F0Sm8wc1IyNjFoYVdwbVA2WjRvNEp2cXcwUXdSbjl6R2V5?=
 =?utf-8?B?N3U0WE9JN3ZHVTFwSlgvVlN2Z2ZoUmJKbXFNMU56OTFOOVFwb1JDYUdvQ3Ju?=
 =?utf-8?B?UzM3elVNWEk1aHhDY2pMZkpmVmdLSlplZm9iTEt1eEl0TnkzcFdKMDZzWjRs?=
 =?utf-8?B?UDMyTzc2R3NiY1lFcTUwVDdTTUU2SHFicG1NcENmNlh1ZUlBck5kUERGNUxD?=
 =?utf-8?B?KzR5eXpMNDBRQjExOENqS2tLL3lyTEVndjZDWUpoSlNNL2dNcjl2dHNBZUh2?=
 =?utf-8?B?a21sWGNxaTNYd2UvY091SnhxMU51V1FBcDBrNk9mU2pwVllidVphbEdSTEJI?=
 =?utf-8?B?Mk9ycDRlY1ZOcmhXR1k5aXRhWnRLMnQyODg3Tnc4UVJhT0VycGxtUnRTaDg5?=
 =?utf-8?Q?rXKwTsv8BWyM0w0hCbGUUuOn/vqfEQjrIYSC0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmVJQzZ0dml2cjZGWEZDUFhJRjdRcklSY0dVZTA1dEdEbENFM0d6dHFXaFBx?=
 =?utf-8?B?d2RaTXQvcTQ2K1V0c1RwZlk0RGRsYmd4bE84K2pOanF1OWlTVVBnR1UwNHRG?=
 =?utf-8?B?SGw4Qkp5QmFTTUhiWVBZUW1OSUN2alJ6NWFaMCtabVBISndPa3oyQWVvckdU?=
 =?utf-8?B?VmVvenIrQVhwOFE2ZFNFNnhzQksxUTBpck1ib0ludmJFNndhV25ya09ROTNH?=
 =?utf-8?B?YTZQVHJOV1NsVnJobk80Qm9ZakhYRGc0OU1KZTRLSVBaQVFmWWVLSDFhbVFZ?=
 =?utf-8?B?UjZsVm1jdFpzWHB5T0NhMXlHZ0JWdjhTMityam1TTTRqOE5jeU1CMXZQRXpG?=
 =?utf-8?B?Q0hQMFVGMlRjS25NKzJCYmFhbkFjeG1saVdDRlh3dlVzUXJOZkFyR2FDbytM?=
 =?utf-8?B?SjU3SGNTY1B6dy9vSEtmZVEvMjFtY21ya25yNGFpZDFjODFZV0RzK2RlYjA5?=
 =?utf-8?B?cnp6ZUxRSUtQenp0ZE1XNlVjN3huUHVSdVpTcTBNWU1ZQmZuS2VJaGVBVGYr?=
 =?utf-8?B?WGpobnhpdDhWY1dsaVBmL2NmUE5nV1lIMzA4VU5WOGhBMUE3ZmduazRDSHht?=
 =?utf-8?B?Rk05dHpNRTh3c0RoRXpEVmVzWjAydCt4SWwvTlF2dnRRNEw4d3lNOFU0NFUx?=
 =?utf-8?B?cEVlazJiazRTSWdzMXI1SjZzZXlTdEVybmVPd2pydVpWeXZFNlNJL1dmcG93?=
 =?utf-8?B?dHZ0M2Q4L3FBYldTblJmVUIzajRqeUhvYTlacFNDQjVva1pDUE9IREZDSTht?=
 =?utf-8?B?UVRzeXBpSWloUmFmNVFQMDViWnQ3OWNsRStwOWJvc1U1UjZYSngrWEFOclJo?=
 =?utf-8?B?WjI0bWxQdnNtVE1CQ3V4dFZISlR3L0xTbTh2dUNscHhTM2ZiWHlDbGZESHg2?=
 =?utf-8?B?L1YwNStQczNBNlhRbXNZOGlNdGlaQVg1UnNPNEJRTitENHdZYmprZkE1QjIr?=
 =?utf-8?B?L2NlNGl4eVp3d0tXVXBQbWtUSlpRNWcvMWRtRUJqVGxOUStjU0xCc1V3MWND?=
 =?utf-8?B?eVlGSDJwNFRIUXNVYk9ZZXJOV2M1anVDd3ZtSFBzN3ZPRHE2Z3Q3OG9nM1Vy?=
 =?utf-8?B?OHJTbXBLWi9xeFZ2OUlrREswTG5QSnJUUzNldjFIR3FKeGxES2hXQkhWbnN1?=
 =?utf-8?B?SFl2M2tNNWZpdjRtYXJPb0tVRWJrMTJMMVZ6Y0dvUEd5UHU5MkVCek5MSUZB?=
 =?utf-8?B?bEI1dXBUdmNTYzNCdEJodGhvN2tFdUN0T2hMMUhSMUZsVitjL0hwWEJsWlNK?=
 =?utf-8?B?ZS8wSTRuZ1pua0ovaTlDZFlZNWlNMSs0NWVXTUJkQVFEcTBTTDlOOEh5ZldL?=
 =?utf-8?B?cm5sNVh2YWZhc0JVdlZYamR0SS9jdU9oSVlZVXhXTUVMRXBoWTBIdmZEUXNW?=
 =?utf-8?B?R3FRelpST1Zzd1ZuUmdnK1N0VzBwRW90c3FVaSttVjlKNEZjYUNPM1psVGtr?=
 =?utf-8?B?NWlFYlY2N0xXamI0SGV0UW8xdzZ1OC9DVUxET2ZBMjZkNXpTWXI3dTVJU29N?=
 =?utf-8?B?MTNmNmd2UlpCdHd3cUdESmE0c1d4Y0I5L3Q3WFNHQTZTTFMxU25FODhtVFpj?=
 =?utf-8?B?azZiRThFRTl1anpyOXdJcFlTMUQwRmpFbXFyOTIxeFRWRVIvelRYcCtxNVNo?=
 =?utf-8?B?aTFhQmhkMldTYnRnL1hTMTR0T3FWajFPdGJuV3JLOGJlbGpYSDRkTitkRTN6?=
 =?utf-8?B?VFU1QkRma0tva2JQN1dzUVI0VzdpeXNMNGcxRkNKVzQzZVI3M1BsSXYxSG9n?=
 =?utf-8?B?OURJa2VoY0hHdCtIOHVTM2ZPRnowL2ZVMmwwcUJRNWtBWUo4UXhZVjBkRVp3?=
 =?utf-8?B?bnBLUEY0YXdqb3dhMlJrRWFPbXpNT3VkbitReDQ0S2hEd2FpL0xBNGRDNjVN?=
 =?utf-8?B?S2p6bHd2bXlYcmE5Z2Nsb01OL2hQQ2xGYXNMeXd4ekM5OXNvaHNYdVBJZFVs?=
 =?utf-8?B?ZU9HYXZFK3FxeGQwOWs1eUdZVVJMaUE1VVZERWVVK2FKbmZubGZIRkkzQmE2?=
 =?utf-8?B?RjVrVGtvVFpoWExlbGZpVEJLdWZvSFhQYXNZLzZXZGlOWE5DZzh4MUJWVCtr?=
 =?utf-8?B?KzRVYmU0aFFRalBnN0c5dkF3N0g3Wm5pV0tQNitTbVdvclM4RFRmUldCUXJw?=
 =?utf-8?B?Nk5kNUFVdFMzeGRBcnJ5Ry9iNVpvK2M5YTJUbUc4b3ZVblZBbWI1M2orRk9y?=
 =?utf-8?Q?PnZkXi3L/FyZSTisfyuv3XA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccd7b1a-941a-4817-4b50-08ddfcd97b07
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 08:48:36.0429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lly7oJQAKQOm+lCtLOX8gMLickZ4QS0gaN/UKXVLN/fbULWFhsdbOKUiNHs6zcZN+OHKMC74WDFCHalaKa47TOrbDg9Jm7r+J55pNlU4aRdA+QMKthhUrVoXfTACZetf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7727

Hi Chen Yu,

Thanks for your work.
I tested the patch set on AmpereOne CPU with 192 cores.

With CONFIG_SCHED_CLUSTER enabled, and with certain firmware setting,
every eight cores will be grouped into a 'cluster' schedule domain
with 'SD_SHARE_LLC' flag.
However, these eight cores do *no* share L3 cache in this setup.

In exceed_llc_capacity() of this patch, we have 'llc = l3_leaf->size',
'llc' will be zero if there is *no* L3 cache.
So exceed_llc_capacity() will be true and 'Cache Aware Scheduling' will
not work. Please see details bellow.

I read in patch 01/28 "sched: Cache aware load-balancing" [1],
Peter mentioned:
"It is an attempt at modelling cache affinity -- and while the patch
really only targets LLC, it could very well be extended to also apply to
clusters (L2). Specifically any case of multiple cache domains inside a
node".

Do you have any idea how we can apply the cache aware load-balancing
to clusters? The cores in the cluster may share L2 or LLC tags.

[1]: https://lore.kernel.org/all/9157186cf9e3fd541f62c637579ff736b3704c51.1754712565.git.tim.c.chen@linux.intel.com/

On 8/9/2025 1:08 PM, Chen Yu wrote:
> It has been reported that when running memory-intensive workloads
> such as stream, sched_cache may saturate the memory bandwidth on
> the preferred LLC.
> 
> To prevent this from happening, evaluate the process's memory
> footprint by checking the size of RSS (anonymous pages and shared
> pages) and comparing it to the size of the LLC. If the former is
> larger, skip cache-aware scheduling. This is because if tasks
> do not actually share data, aggregating tasks with large RSS will
> likely result in cache contention and performance depredation.
> 
> However, in theory, RSS is not the same as memory footprint.
> This is just an estimated approach to prevent over-aggregation.
> The default behavior is to strictly compare the size of RSS with
> the size of the LLC. The next patch will introduce a user-provided
> hint to customize this comparison.
> 
> Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 47 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4bf794f170cf..cbda7dad1305 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1205,6 +1205,34 @@ static inline int pref_llc_idx(struct task_struct *p)
>  	return llc_idx(p->preferred_llc);
>  }
>  
> +static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
> +{
> +	struct cpu_cacheinfo *this_cpu_ci;
> +	struct cacheinfo *l3_leaf;
> +	unsigned long rss;
> +	unsigned int llc;
> +
> +	/*
> +	 * get_cpu_cacheinfo_level() can not be used
> +	 * because it requires the cpu_hotplug_lock
> +	 * to be held. Use get_cpu_cacheinfo()
> +	 * directly because the 'cpu' can not be
> +	 * offlined at the moment.
> +	 */
> +	this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	if (!this_cpu_ci->info_list ||
> +	    this_cpu_ci->num_leaves < 3)
> +		return true;
> +
> +	l3_leaf = this_cpu_ci->info_list + 3;
> +	llc = l3_leaf->size;
> +
For some arm64 CPU topology, cores can be grouped into 'cluster'.
Cores in a cluster may not share L3 cache. 'l3_leaf->size'
will be 0.

It looks we assume LLC is L3 cache?

Can we skip exceed_llc_capacity() check if no L3?
Like this draft patch:

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1227,6 +1227,8 @@ static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)

        l3_leaf = this_cpu_ci->info_list + 3;
        llc = l3_leaf->size;
+       if (!llc)
+               return false;

        rss = get_mm_counter(mm, MM_ANONPAGES) +
                get_mm_counter(mm, MM_SHMEMPAGES);


> +	rss = get_mm_counter(mm, MM_ANONPAGES) +
> +		get_mm_counter(mm, MM_SHMEMPAGES);
> +
> +	return (llc <= (rss * PAGE_SIZE));

If 'llc' is 0, exceed_llc_capacity() will always return true.

> +}
> +
>  static bool exceed_llc_nr(struct mm_struct *mm, int cpu)
>  {
>  	int smt_nr = 1;
> @@ -1363,7 +1391,8 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
>  	 */
>  	if (epoch - READ_ONCE(mm->mm_sched_epoch) > sysctl_llc_old ||
>  	    get_nr_threads(p) <= 1 ||
> -	    exceed_llc_nr(mm, cpu_of(rq))) {
> +	    exceed_llc_nr(mm, cpu_of(rq)) ||
> +	    exceed_llc_capacity(mm, cpu_of(rq))) {
>  		mm->mm_sched_cpu = -1;
>  		pcpu_sched->occ = 0;
>  	}
> @@ -1448,6 +1477,14 @@ static void __no_profile task_cache_work(struct callback_head *work)
>  		return;
>  	}
>  
> +	/*
> +	 * Do not check exceed_llc_nr() because
> +	 * the active number of threads needs to
> +	 * been updated anyway.
> +	 */
> +	if (exceed_llc_capacity(mm, curr_cpu))
> +		return;
> +
>  	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
>  		return;
>  
> @@ -9113,8 +9150,12 @@ static __maybe_unused enum llc_mig_hint get_migrate_hint(int src_cpu, int dst_cp
>  	if (cpu < 0)
>  		return mig_allow;
>  
> -	 /* skip cache aware load balance for single/too many threads */
> -	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu))
> +	/*
> +	 * skip cache aware load balance for single/too many threads
> +	 * and large footprint.
> +	 */
> +	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu) ||
> +	    exceed_llc_capacity(mm, dst_cpu))
>  		return mig_allow;
>  
>  	if (cpus_share_cache(dst_cpu, cpu))

Thanks,-adam

