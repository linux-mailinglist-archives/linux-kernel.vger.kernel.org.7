Return-Path: <linux-kernel+bounces-759667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C627B1E0DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4EA7A1FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF11A00E7;
	Fri,  8 Aug 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AwHfHRox"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726F224FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754622861; cv=fail; b=WQbBW+n0Ovzpq+dCcdOzvUNQpw49KHLghVNnKypOwZUhVdyS2rPptz/0ok00I4h34pbpCGFGUpDPUlBx5+NeCFU+vGqWusHGq+rANHMxiXl7pOLyJ0inxbXl3BvfYM89YXH8Rx4xLJRa9vCb/K+guaLdWZBhS8YzjHfFAUaDlqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754622861; c=relaxed/simple;
	bh=gmr6mdbYgybnXMx/ZPPTsiIq9nelfLTGBn+PWnlIX7g=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=aaryby+d8GB6M09JY4rZgxaWnNNB9a1j6jimnWdjlJEBNWoSwL+GE3+y5YDy2vCpFnRT+w6bQNNNh0XazBkF9umBNcHoCMjsOG38sn5tagnHrBXvj5Mrj2KwTIITvWtglWET03OhhwFlR7O/gI8+aCYJLrMHQtSNOywzpVotnbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AwHfHRox; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoQIDsqdyyKWsW0ErvX0CTljiN25NrzV98cIjA7WhmZoy066UbJgUMEFBcbnK69jLrNk/1SCHdHCjmNhXLmJIPP6Vzb0brtvxWktZmGWF+46gfxqbfBx7dZkqYm08wlfAK5poz8mKutIduelsuCCx/m/u75TfiTyJbgoNUkHhFMvNqCVLcpoy3TmbBR6LMvwmbKn8JbSRjY71qTyB7+emRAns7ZBChrQAi4tS1PuoZCnAzOrIrvObFN/Mrs4LWNdH0Dcfj/snuR6SLlNCYdq/j0R5ea5sywsvBc660pTotjIJG1j9afeFr5L2UoTcogx6s0XyofKOJ4fXQkQC4gSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmr6mdbYgybnXMx/ZPPTsiIq9nelfLTGBn+PWnlIX7g=;
 b=ljGk1HuvhJ3qSnNUBb8MNqBy+0v9piSR8/Bsi5dxwoQxcJBJYbmUzdiUFOZW1LvsMScXVC+Ltm1jhaw+wiYcWSEm2ihKW5spklA1Hi72aUuozg31p3GEiQLLzcOwxYhS5ZM5kQ6L2nvXBY+gkqKMpIBZ9AKLOp1rATV4IXklVl+32aRPxOcff6dtNQyd/k8KHgiXkSss6V18vmsR2ZKUV8M8mhcHvqLmpVvbE9Wau1AONVZWQlmUAEiRqhC2MCKstm+zSMc8hJ2PVL8b35SgbpKS396yHMjhVtl/dRD6eKvx1MEKTuFhz4ieMg6QwssQLqnYk6CNoDkcSmp9BlRD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmr6mdbYgybnXMx/ZPPTsiIq9nelfLTGBn+PWnlIX7g=;
 b=AwHfHRoxu087Usc0rtFleYEFj3IGygP7TQQvBBhXmLMeVOVenT3hnWYz3bNDEnzTr5uA0VYzpqzXQqVFriWDrjY187lwGHTlJP5qZM2lLeNubMmCAyolMHka8zjmdOTMI/iZuXDDz/Qqa67zyDWblFZrFVyIPyxgPnF5OcJK4RscC+Iw4x1LZrmxjM3L4hzhWfk1qnxPephXM5ANr7VWcYEwrOh/NG3QOJmQZvyL0razpx2h8mCRSgGk+mwdEJnublGt0HeDCpheNm6n2PoZ208XXjVdhymFJUcEXSDYGXrR4X2lW13oM8cuqY+kFagq9z+ZQsIoVs8sbRHPRqdc6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 03:14:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 03:14:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 12:14:13 +0900
Message-Id: <DBWPW3820V7U.23RB50RJZL7MN@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Philipp Stanner" <phasta@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Nouveau"
 <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] MAINTAINERS: Add website of Nova GPU driver
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250807070756.103816-2-phasta@kernel.org>
In-Reply-To: <20250807070756.103816-2-phasta@kernel.org>
X-ClientProxiedBy: TYCP286CA0171.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b51a59-f6ce-42b8-3413-08ddd629a8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGt1UmN3WXBDaThBOG5pcm1zdU5CTEc4OSszQTRDVVUydURBVEdLZ1NwRE9V?=
 =?utf-8?B?endMQkc1NjlVWGFqQTVYSFp6UGFLOGNRZG4veTZaQ3RwTWg2dUNTaE5qZjlm?=
 =?utf-8?B?V1l4VFRiWXFlcjBSd3NlckxtQ2pDYU1qSTdCL3JxSmFKRHRSUUNBa21GU2c4?=
 =?utf-8?B?dGptQVBLR254aitBZ3JKb2lnZzU5TlI5YXlLdGZWMWVOYXZNUkFYaXAxNElQ?=
 =?utf-8?B?VnYvOTZFQm9OVm5pZVZ2Mjh5SkN5MFZSQ3JzYnQvRmx0WUpNTHA3QWRoZkRT?=
 =?utf-8?B?cTVWWVhmcERqeTJtQ2owZmpydUNBSkNRbDhWeGV2c1BUMW5vK0t2VFU5VnVi?=
 =?utf-8?B?U25YZ3dBdVBPM2ppalk4bkxoNEpSWDJ5Q3NpQzVoWlVDbUpsZk9sbW9rQ3pX?=
 =?utf-8?B?U1c5aDlCcmVwenJ2YWttWUl1MVB5UGt1aERpNUtQNHJ3dEJrUFhDY0R6TU5W?=
 =?utf-8?B?VWFUcERLY3BFSUFPRDIyY1Q0R1doZnNORDRSc3BrOHlZOWpqMldHbm1IV3Ft?=
 =?utf-8?B?Tlg0VENXSnMveVhyTXRNeEZxZjNDRUxUeXAyZkZQMjhQN0N3V3pkYTdjbG9I?=
 =?utf-8?B?TkpIMk9SN0ptUEpycENFNURmbC9vWXRBcS8yNGowODFlUTRKS1ROUUpCUXpZ?=
 =?utf-8?B?cTA2dkZUN2lMc0tEaHJqakhRaUFhUHNHR1ZZbnRpSnNocEtteFBZUWFCZXl1?=
 =?utf-8?B?OTYrYmY2Qy80Qnp2M3VVMWR1bzE2UE91WnNVWFFoYUNsdlR6aEhnNWlrTVI2?=
 =?utf-8?B?azFLVmZRK0lHVitNdk9CemUrMDhSNnlwN25Pay8vNW1rcnUyaU1McEhscU5Z?=
 =?utf-8?B?SXA3RS9NeGw4Nm01RkxlZkpuKzQyaTIwcFZGMWt5TUEzNHVlM2pKZG4vbmhu?=
 =?utf-8?B?TnM4QzFVeHNuaHBObm81Nkkxdm4rdXBBbUxXVlJBOUJsRG43NmhUcjdoS3Bz?=
 =?utf-8?B?V1JYaENKYU5KOHZwakdVdWNkZW5aR09JSnNsTmxKeksyUkJ5TmlSVGwvZ3Ex?=
 =?utf-8?B?RHB2WWZmMUZoQjJ1a0VDZ0pnY1QxOEJsNFlWbFYrTStJd1NxNUxETmVXQUVv?=
 =?utf-8?B?NlJXY293UzdINVZJTXhqY3M2Z3hXbjMxN3E0dlREY210OVFxUm1UVjcrblc3?=
 =?utf-8?B?Z1RWQTUzbE9UVHpoeEhtMHpiYXZ2RkdWNENUaEJSSWRWVThIYVlVb3pJK2tY?=
 =?utf-8?B?L3VZQTZaK3F6VFJaaEdacjNhcEZzV3NadmtjYzV6TlpWV2xabUlid0pJUWs1?=
 =?utf-8?B?MFNRd240Tmtsc2hzY3YyRVlCSHJNOFk1MmdMWGhkL2JJUDkvOGZ5b0pSeWE4?=
 =?utf-8?B?OGNuWUVrNk9TcUlGdzNmZ2RaampmR0RScitkcUpCNXRDdkFrNUtRSWpVRmNV?=
 =?utf-8?B?YVZnTEVpbms4c3N2YXcvMUZrSUZBdGhDSDhZc0o0Ti9BdmNyQjRvWUM4UFV3?=
 =?utf-8?B?WjRqOVhoQmNCRDYxUjBseEhkUXhiWUVWV3loanhXTDZ2ZFNTREorWmx3U1ls?=
 =?utf-8?B?b044VndnTXhaZWZ2dXVLRmFVWnc4UW1mNUxVSmZHd1Zpa2ZRQVJWcmJ4RGRG?=
 =?utf-8?B?SmZXaUxKMTJwTUx3QWdMb0ZKUzNHbFVmY0QvMFJBeG9qN2Z5WkNqUitJZXBm?=
 =?utf-8?B?cTNGOFhPZnJMSkt2VUpPZEN4dnlNRXBYaVI3MFE1YlNZMEdTREczS1hTVk9o?=
 =?utf-8?B?OFRNZi9CeEJrbVp6MTNzc3NEZEp4NjJFaUxSNDE0MW5sa2hEc2ppYnltYnVC?=
 =?utf-8?B?OFNZZUVWUWJPQ1ZYR2I5NmU0aWpYZ05RbmNMTWc1cGtxUmFpT1djVGlBUDZQ?=
 =?utf-8?B?QTRxWWx3N29iWTFiRmtDbk84WDF4Q0xQaEFFY1BoL201TTlRUHhOdGRkb3J0?=
 =?utf-8?B?em1mWXpDaEhtZFRyMmlwalRmQytWZm0xNlp6RS9YLzZvQkJNQVMwVjFvcmY4?=
 =?utf-8?Q?hBv65O2uhKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUw0clFmd2tjYVIrRUlHK1orVTJqdHJJZ3dneWtUNENpdWN2cG4wb2FYTUk4?=
 =?utf-8?B?QTQ2QVR2MTRpRUVyZFFhb0FMMitncDRscDl4RDdFQnNkNnpDa1oyMHV5Vi91?=
 =?utf-8?B?NWIzVnV3dXZaMEhtQUxZZmtGM3ZTRFNjbXdiM1Z5WVg2bnh5Q3dLNTdoZDVI?=
 =?utf-8?B?c2wyeUJYNnRtS3F6STF1ZCtqalNoYXpZc0FWa0VRdFZLWEZXVVQzSUgxL29F?=
 =?utf-8?B?TGxySCt4N0NTTVRleFIvNWw5YmZuOWNvYTdIQzBvVC9lZDdkZERLekxaUEJH?=
 =?utf-8?B?WmYvcnlxNEUyUHkzWkJWNGt3MkRKU2tTV0V3NGw5L2Jaa2VQVUtxQVRiN3Q3?=
 =?utf-8?B?c2hyaHdQSlVrQlkzb3hSTjlrR0UyZGlaaUt2NmZFNTczdzBXZEZEa2hiTWs3?=
 =?utf-8?B?SVhGSDRkWHNVMktXa2w5cDRGMzhHbUZ0WHNibEc5NHcvZUU4UXArdXN2bUJk?=
 =?utf-8?B?RUc0NFF6T3Q5bDN1UjFOK1FSV1p2THlMMDNMRmExVTZ2VjUyeTVoQ3hNQ2xy?=
 =?utf-8?B?TXQxVmxhcUNyVlVCY3RoU01BNkJQMjh1cm5PZ0w5STJxNm13Z2hid3hYcFdI?=
 =?utf-8?B?aVhlUkU1NU9taVMwLzFYMXBKakczVDdyR3lLbG9IbStqTkVMa083VmtiNGVn?=
 =?utf-8?B?R01qT2FxaVB1Ty9tZG5UdnpwRnlsZ1YrYUNkbXJQa0c5Ty9sRWFhM0x4cmV4?=
 =?utf-8?B?ODQ4YzRIVENieGYzSmNjblhaajFZY2xYcFltVlducjJmZXBlZy9TbmE4UUp6?=
 =?utf-8?B?akdIS2dMd1NZaml5eVlhYzYveTRNSlE2ZnlvVkpKckdUUktPNXVHUm1KNll0?=
 =?utf-8?B?V1lXQVRRS3ZQTVpjc2FQc2NPK28rQXJFcEcwSzlYTkRJS2xvYi9KV0pmcjJy?=
 =?utf-8?B?Z1gxMFdGSnltZEhZck9UWVVVUHRxWUFNRHhJVlNDZVVVVFdkckdhUUUxVHhz?=
 =?utf-8?B?d0JUZ3dweTJCQjUyYjd1L0JEUVJUTHZhTE1IbEhkV1lMUkRhWjBBMlBYZHZF?=
 =?utf-8?B?eHdiRFZSRVpjbGRFRGhJRzFjTVBYOWhMTnFSVFlXT1kydGw3MzJLS0VPRWVQ?=
 =?utf-8?B?cjlSNThlRXRtdHNsOXV4WXlJck5TcnFkaElOS0lzU1VZTWlnQU1wMkp4UHk3?=
 =?utf-8?B?WVp1S0Zwd2xYczRLdTRUeXFTU1pyVE5hM29iOUFzb1hxZGFYWEZyeEZLZEVw?=
 =?utf-8?B?ZkJLM3lqY1dHL2pBM2FFRnl0Z1VPSnhNNjNaRy9WY0tVekk4aUJ5Y0VNaHhH?=
 =?utf-8?B?Qm9uQ2dtZmszc0pwMTJtTGZMTFgyUzVJVTJ6VUhHV0dJRGEvdnVTU1U0K2tN?=
 =?utf-8?B?b3A3R1AzK0Z2Vy9ST3lqTXNEbWRYUmJHMWxoNWtwbGpROFRJTFNjeE54TXc2?=
 =?utf-8?B?L1NyVG9UL3lmYWpCcjFGcVljTm5rWlJYbWJhU2NxYkorQktWR1NuYXg0T1l0?=
 =?utf-8?B?MUhJekMwdzZlSmJpM1Z2Y2YrSzNXS1Q2RXNVSjFEM005enoxY1RvK2dpWG5T?=
 =?utf-8?B?Y3VzblBDK0tjYVZYYjFHaTkwQ0ZZeGpsUDREd2c4ZHQwaklVRHNiU1MyTm03?=
 =?utf-8?B?aXJTU2wzcVd3c01nUGJPcmh0WEhmWkVLRDlnampLVUtMYk16TkFnS2NvYmpJ?=
 =?utf-8?B?ZkFIQUt3WEZKY3A5eldKcDljd2lLb2F1eUw5dWcwWHRjSTV0dEUwc1JvSGlX?=
 =?utf-8?B?aHJ6RFlvbVNLNWhzWkhPOHN5Y21PbnpjUTA5T0pGbGNPQlkrcjVCTHNmMFlO?=
 =?utf-8?B?c3JrTmtNUG9mclE0NFdDYkRSUnZ3NVA5K3I2QTN2WUdleEJpTlJqcjRsaXMw?=
 =?utf-8?B?VWpUUTFhMWhZcHorb1l5RmhGMDhrN1N2OHVYSE9wa0tuR3JKNW5pamtpMG1Z?=
 =?utf-8?B?OWtoRURvSnZSRWtGQVIvcWI1UVdsK3NsbXh4YnVCNXliSzhPdDFIbEQrV1pO?=
 =?utf-8?B?VEZUWkRCazUwWUE5bnRab2ZYQ0taWXRkY2xtZjUwUk0yYXFCaGJPUzUvOEJv?=
 =?utf-8?B?WjFkRGxjTmp5WmJjNUpLaUdoQzRKUmJXeGdIZWFST2lkd1FGa1p6eSs3U21S?=
 =?utf-8?B?Uk10WjBWNnpXOUExY1JDbGhhRTMzRGVlcWV5M1NkcmtXSTR4ZmJJS3BhQjRW?=
 =?utf-8?B?L2tSS05VL1h1dTRwNkxsUHVxT1hGdy9SdkdnMFJGUTNkbi9YNVJFREZXb3Bp?=
 =?utf-8?Q?cNIqJGsH0L8k65uPCeDyVlN6Z2MHKJkeGUrNTKhk7pRW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b51a59-f6ce-42b8-3413-08ddd629a8d5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 03:14:17.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSm9TC+YWFVGoVwFR+i2fJ+pFOXQxx3DFE5QbB1Xa8tV+nyqgyG9dJ4RxuB4uL1powKmTYukN2ghslkF36fG1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506

On Thu Aug 7, 2025 at 4:07 PM JST, Philipp Stanner wrote:
> The Nova GPU driver has a sub-website on the Rust-for-Linux website
> which so far was missing from the respective section in MAINTAINERS.
>
> Add the Nova website.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Staging this for inclusion into nova-next after -rc1 gets tagged,
thanks!

