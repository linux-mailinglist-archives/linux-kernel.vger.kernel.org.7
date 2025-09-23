Return-Path: <linux-kernel+bounces-829622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D7B977B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5402A64A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17A42DF716;
	Tue, 23 Sep 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HMbmxaj7"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14C30BF66;
	Tue, 23 Sep 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658994; cv=fail; b=VXUKwxmNS7SBz0r3hzCe5Ex7K/MT2BHmCZ6JYUUrGrV+dl+DzfHM+cDFzABeik9qLYovpmF8Rmi7qiq1u63yW/jpp5PA4aqE3NUvlA5RSVqQY6A0GvH9rdl+lODSREXUin8HOr4jLJgs15Or9WHua3+/dwOGXh+NQfmXR08Uxo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658994; c=relaxed/simple;
	bh=gL2M3aOcqxxdhs8F2+tays8dWe6dK2iWCv3uKTUAcU4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fcm/bEf3Hpnld+urAL/ZZpGw8jOMlSxBymBTcpX46DzYmVsQVr7vEEyHmQW8KzQGDOCIJXCbPfHxKhd4Dx0IOjZ8XssUwzMzm3xQ5AVsVRjeJ+bSGXq+YAPhYE9Rd+TyEsDTD+6U9t0Vrx/rCD9eilhZgYZ45BflLrvI6udRWuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HMbmxaj7; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTNGucAgSHu7VLYrZPE0wVNZrkUrwjK9J9SlXBwT8+2Hg1hOzBv5uwsZNqv37T3RpI+/3z1eCX0KB4+nuNHPzVy+RQM1JCiZCBzRO1O30XouMyCx6yXynJRleYaL9Pu8dZoX0i0kAwxA6pIGPHIKuQ+rnQxQP4fltTxBghq6mp0Q+dwfwmtCc+XVo4z/IiYViticZLTInQjqCzneueNs+1zGaPmJDf2u0xiXLPRAdEuv3kqWaXuxVqmT56WspQ4xFru2jp3Pd6Sv9aaTanpDCoUEClkatpX3qxSIyHzLio/l+Q4Rb9ZUkpce3ffOSsAq1xadm0niWHORkksY8z4yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RIjhM75n2hSGLJoUlt0S06Heg5ZylNzeaoNynjFZGM=;
 b=lNnCVU4EfA2SuwEKaeZYAEk2n8n2wyXsIWIRHMjLjWqX46wnh6mUgpZkImZVX8vvnScvlt8dE+qS5K2SRo5NOValcG6br2+ztuUX6c3fWfib26Sj4n2fBA6buHqNfEiFBOTq1L4DzCjlUnwwUgUc7oCklh1CpxpLwXQefJYj2+80ru1ADgiAgYl3pdBXvnc3XkNAW562oEPgF9xdZcLaUkusriA3jfssOmWZ39jXAdYqqoeqVDL09EGxhm66Yy9NGH/AC46Ig65gokv9nhlhQrJr5z6Xv9uReAGipjmOP+EixJ/rTUhu5BRNqyvLDUnu+JQ9Hs5Vm6ZvJSgRMLGYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RIjhM75n2hSGLJoUlt0S06Heg5ZylNzeaoNynjFZGM=;
 b=HMbmxaj79ua+DwpR1iMv67nrooc5JfSHzenU0YrLMbFW8S1wLsnxqiE2vzz2yVyGZ7N3NyLYadAk9l+fy4Ov9XXA+j5jNfLUPGB0juJlb3xxJdXC+Koqg9RQdB5CzixtaZCqcdFdZOPck/xBwJXiWyzjSVy0w9rwxRVEpha76T2cs9oQu1sKLx6IYWfyVSkm2+SARxvIUOdl7UrAQleBbZ/uERC2u7zxBoSrjEHNPw6cVPCdtvFzNss/44bJ0sGMfYuXO3EvjytpevDDIr0sXfXyD/UAD5/GMF3hNZDTkCQD5YOJ9sx0CdAb/4FSY9R9g2/UoEvKcB5tA19ZZVGLDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 20:23:09 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 20:23:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 23 Sep 2025 16:22:49 -0400
Subject: [PATCH v2 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-ls_dma_coherence-v2-2-ce3176396bdb@nxp.com>
References: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
In-Reply-To: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, Frank Li <Frank.Li@nxp.com>, 
 Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758658981; l=2775;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gL2M3aOcqxxdhs8F2+tays8dWe6dK2iWCv3uKTUAcU4=;
 b=fv8k06lgqhx/angnzv2OmQbyxCqrsKE8lLG2h/Me92SiXoTxdwERXs3TEcau3wQfJRfyZ3mzH
 PdeW+JXjkQQCakFaQIBdZYO/T2ixMNu8sIPXr0Ix6oLNCA9myOyMpqH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM0PR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::39) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b76728-cf94-4ecd-91f2-08ddfadf02aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnlkaEc3WGptWGdUa09OWUw5YkVFMWFYUk9UM2psZmVCRzMwQUFoY1IwTzk3?=
 =?utf-8?B?djlWNHRlaU95QndQTHQvRFpIaEpIOERVN1dHZm8vQjJuazFobVJzOENTRVJl?=
 =?utf-8?B?ZERGa2FBYldyajVhTVFhZ1dBbDZEQ2ZaRFhLSUUwNGsvckUvbXplUlBLb04w?=
 =?utf-8?B?ZWJOd3RxTXRIZXZia0MzampQaEh1ZTlIWW9SblJRY01wUkVDYWc2RElhRW9O?=
 =?utf-8?B?VEZHUnpnTWlmVmNGTWt5VGJYdnVVVWFWT3A1OVJseWtKU0ZGdjkzS1hkdlhw?=
 =?utf-8?B?L08vSExpVGJTUkVyWStORm52WFRlOW01cldlSjJLaFJybTk4WGtVRkxiWXp1?=
 =?utf-8?B?WDBESXlBcVRRVXRwY0xyaWdsYVJZd21QYVptSlNlWUtQZDBKcXM4Skpqd1R3?=
 =?utf-8?B?MFcwNHUvU3Y1bFl4TGRUQ3Fra0NpVmd6bkdYVUhDUXdsZlEwOUxVWm1lcHo4?=
 =?utf-8?B?QzdYUWh6cmVKRENlSDRheis0SFg5SFFINjBJYTlaNGx3VTkySHBIRVEwNHBI?=
 =?utf-8?B?QXFNZWJ0eFFGdHBPMjlGc20ySnB5blBFNUlrREFqTjJibFJCSFZ3TmgwZjBp?=
 =?utf-8?B?NFAyVTFwUWdkNm03VnFxaHF4cWplWHQ4OTdOcUhKTDlhblJrb0llZlpJY3VR?=
 =?utf-8?B?UGMrcHQzMjE5Q09haFIwVzMwRURxaXRJTGlQM2xkWUdwLzI4MjNaREgwc0lF?=
 =?utf-8?B?b2VhWVZJVjVBakJEMjhMSEdvaGlSVThoSnFXdHFaTldaVUZFSm5vcHdIQXRw?=
 =?utf-8?B?R0piODNkVVlacEVwakt1NWl2UVlrdUlOY1dIU3BqamxibTdzVWgwTkNtS21Z?=
 =?utf-8?B?NkVsQjJSNWlqLzJxTU52eWxYNmVFdThqSmtyRXYwL3JGNFNoM1pUTGRpUW41?=
 =?utf-8?B?cjljRGNBMzViSWp2c25zdWpvbU1SRXpsVk1GMFdTQXpKNzBaM2pxVXpZSFkz?=
 =?utf-8?B?K0ZOSU5VdkZMMkdxS3FSNGxjTkgwK1V2NFRVOFpBMEN0WExtVWV6Nzh1SUZl?=
 =?utf-8?B?a2lBTjFWM2ZDMGxrUDRBU3VwMVBFVWdiVWd3MWJ1ekN4L0NiTWZJZkFMc2ti?=
 =?utf-8?B?Rkw4QzJCUE81THpqd3hWd3RsMnRWM1pHazNBUjU4VEVFSDdFdmFLaU5raTZO?=
 =?utf-8?B?VjUzazA2blBZS0ZaMDBLYXVvenlqdDBJSGZDZ1VwK256NnV4WVNTRGQyQkY1?=
 =?utf-8?B?Y0dJUmMwVy91Z3UyY2hPOTQ0QTVGaFJPUkFTMmZLdGtaSlczcHZGVjZxeTJw?=
 =?utf-8?B?T2VIUW9lZlo4aHpodlZ1VTVDZWtIY05oSnk2TWRzRnJSWjRJQkZxSGcxWS85?=
 =?utf-8?B?WkUzTWFsZG11WWowdUFIa2t0ektpTW5CWnl2aFBZdUdrdjhCbithbFllTUFV?=
 =?utf-8?B?dzFiMm5mM0N3YU15b1BKMVR5QUpuZU5iUllXcG5Ed1c5T2dIdDZBcGJBOHJV?=
 =?utf-8?B?UnVZZnRwMGNOYlZKQ1RCYWg0cmVBb3p1c3YwMkhvdnlYK1lLalFlQjRuR1Qw?=
 =?utf-8?B?NFNsRWlqZEhXYW1XNWhPUEpjT2hvYko4UUVTL2c0MERLbTFERXdOTUVNUEdm?=
 =?utf-8?B?bG5sLzFZSzlEd2M4bkhXV1lGNml1ZllHOGprSnVDSFpjbUlyV29UZDdrcTcw?=
 =?utf-8?B?K0VlNEhHaEZZTkNxcTFyWHZUa0F0NmxaYWx3eVNWZmxNZ0FqaVFCUzZobE1S?=
 =?utf-8?B?REpuYnpraExkY3pLN1FOL2RRaVhDdS9ydFo4RGNrTktvdENRb3RnWUUwT2VG?=
 =?utf-8?B?K2Z1ZWJxcVlnV0tDQW1tZDcyOEhXZ1BNT0IxdUpEZ3VabFRSeFUvNG9LRVpy?=
 =?utf-8?B?Rmc4SkpSWHBycStvZnR4OHZWRmNIVFA2b2w5c0FFQzBteVFCVVkxeWJBeE9y?=
 =?utf-8?B?cjdPTkNadXQxTmlCU1NaTzZzQlpTRHpvSno2MlZReGdqWHg0b0g5MnJPRDQ2?=
 =?utf-8?B?dXF3bWZEYmgyRXZicDBOcHlPMzVJNWFPdWtnODlOdnJ3MytLYW1GQWwxRWRr?=
 =?utf-8?B?Qml3ZHU0SnV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d01CWUQzS0wvTi9FZDRLVzlpam1CSDM1bk16c01vTDN4TnRaM0RTMGpjSFdG?=
 =?utf-8?B?c3NWVU5PRkF3NjBnUE9oam4zaERXbWhUQ1VSMThHb3hjOWtUY2duNGQ2YnZJ?=
 =?utf-8?B?M1ptRU0rclFRTUJGei9NcEVkbnNSaFJTSXdMSHpqTHIyZHUrQjlFakJETkd1?=
 =?utf-8?B?T1ZmRnV2UHU4b2R1L0lMTVpGRlhTSGJTQmVMLzFlb3lnL0ZQZkdyNWo5UjVW?=
 =?utf-8?B?TXhCRFY0ZnRsQkNhMEJERFcvTnQ2SFhwTnQreGdycE5TV3lzb1k4K1dUaVda?=
 =?utf-8?B?U21hRHZ2b2JRT2o1RjVPKy9FSTFBSERKYXhpbm1pazZCSDZRbERta08rQVhY?=
 =?utf-8?B?dUcwOFdkcmNOOEVEeTgrbXpIUTRXS3hFYURqalJoMHozUmxudFBEVS9GNVpH?=
 =?utf-8?B?ejh4emtNalBuYlBjTmN1ZTJBS3NBa28wUkliQlN3N3c5Y0dhNVJtaUd0a2xO?=
 =?utf-8?B?ZGo1R1k5OThxR0lQK00wajZBcE1HTFJkMndXOEZDdkI5Y2VNOEkxei9Deksr?=
 =?utf-8?B?NlRZV0ErakFlVzJhTXFqemNTekJiWGdwZ0F0QTBLU0doRWtsZUFQOWdmRnlD?=
 =?utf-8?B?OHY4ZkVacUptenFiUVBIZHdYcDNJZnRyWmdLdEkxa0NvaElOTDFIRTFpbTNO?=
 =?utf-8?B?Z0FvdXUxeWtINENGclFza2E5VjZJbnBNQzhNRDRrSHR6Ym5DNWRBdm9RRHBw?=
 =?utf-8?B?S1QvNHFjbWNkVW16VTNhdVo2Q01wZzJXbm96MzZuOUJPMHhGNytablJqTXdV?=
 =?utf-8?B?VUtFNHpnVUZsdmhUTHRROGxLZUl0U1QxaTQ2Si9Sd2ltUW9GSUIvN0s0Ni83?=
 =?utf-8?B?UnRBc3ZTeHlYSldQWGhLVVFFY0VjLzkvVTM4ZWNkNy9Held0bExmdFRIQ2tW?=
 =?utf-8?B?UzVRUFdrYmdmOFB0bm5kYTZVWVVDUlJBUHkyQ25EdzlvWDBUUjRMUEVNTlY4?=
 =?utf-8?B?WTVYeTdvNTZuYSt5OWZhMTUwdmRrdy9VQ0xicWx5UVkyWkI3ZHJMR0ZobC9I?=
 =?utf-8?B?dU0zVm0rNmZwMWdXOU50dTNwRlBHbDF1ZHo3ZE1oZlgzU2NNSFRXM2hWeTlH?=
 =?utf-8?B?L25MMTA3N2ptVlgySVNuWW1TbmFoU0VPcG5qK3RSRWF6TEVsMVRTTUNuNFIv?=
 =?utf-8?B?R0J4YU51a1ZVcWpjMGZmcE1TdTZPd3ZyZStEOWV2Z2JGWGZxL2pUQVRXK0J0?=
 =?utf-8?B?dU9la2ZvQ3pVSGMvQ1JrSCtiQlJkb2J4eXUvSC9jak5XTXJ0Nk8vY0JzVXZs?=
 =?utf-8?B?cW9LN3JWZXdJNDRMZE5qMGFaRXE1cTljbXNYMW5DbnJjT21RL0h0eXVIZUdx?=
 =?utf-8?B?YWx3aUNUZUR6bGhtR25yOTY0SStjMGZwS0RiMlhvZU1hVWFXQlI4S29wampP?=
 =?utf-8?B?N29oMEt2SUYyR09ycC9RUHpMeFBEZFE4WU10SG14bjZQSVhEcGpJenFoYjB2?=
 =?utf-8?B?enc3T05XZGcwenJhZ0pscVJKZTUzNnZWU1FjdVpiZFkyd0tMNitKOUZ6S3o5?=
 =?utf-8?B?SlRISmxPWlJHQTZ4SkVKd3NWaDVxbkl0Mkd0RXRUQWRuajJ2SlJsaDdkT2tk?=
 =?utf-8?B?QithUmFKblJ2MlB1eCtKL3VMRHFteFNZb3V5ZFJxcTRFUGRNQXNTNkZpb1VE?=
 =?utf-8?B?a3FyanhrRTUyRE5pSHNkT2dvc2pKY3BaVEVLcVFIRnF2VEdzZjZpdWtsMDd6?=
 =?utf-8?B?YWtyRzNBTm9ZQVVrZHFMWW1keHIvMnNnTFJYNmpaWVozcVcrbThVdjUzSFBu?=
 =?utf-8?B?MVk1MTFsRHk1NkRVRDZMT005MlBpaFlHRkNtL05qdXJOc2JvRkRJRjBmWmZq?=
 =?utf-8?B?Vk9acTB6eHVwN3BvV09LN3Y1azRmWkdVbURXOHdmVXEyajRvazBTUytaMHdK?=
 =?utf-8?B?Tnl4NjZzSk1ySWNENmNjRzZBWVJibXlxRXFoWGUyeW9kVVAvM3VJV0V5N0FZ?=
 =?utf-8?B?dFd4TWRzY00wQnNHY1ZYMGZhYkpCaG5vbTNlSm5mS2dVc1hYZFFtdStrT0Jm?=
 =?utf-8?B?b3lRZHlSd2RnTVdmQzJyZXpxTmRjVzhxUmJ4TTczR2V2dm13SnlSN2k0elpX?=
 =?utf-8?B?SnRDV0Q4eFZPbjY5VzhsTDM3b0M0Z2J4b3hpWlRtYkhvRmpRcDBSNi83SnZX?=
 =?utf-8?Q?QwINRKumIOrWk6ywQStTjz/go?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b76728-cf94-4ecd-91f2-08ddfadf02aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 20:23:08.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VV0ozRWy5iDbjX5ax5l1cPaffHdWnY1rLwEVEXCqHM78DpB79atbtPNL8B+WoAJ7vgjuBYy9rX6JKwebqQG0xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953

Add layerscape dwc3 support by using flatten dwc3 core library. Layerscape
dwc3 need set software managed property snps,gsbuscfg0-reqinfo as 0x2222
when dma-coherence set.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/dwc3-generic-plat.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index d96b20570002dc619ea813f4d6a8013636a0f346..d886b6e557b12edda71203e4f640a9a0a53b4f35 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -8,10 +8,15 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include "glue.h"
 
+struct dwc3_generic_drvdata {
+	u32	gsbuscfg0;
+};
+
 struct dwc3_generic {
 	struct device		*dev;
 	struct dwc3		dwc;
@@ -29,6 +34,7 @@ static void dwc3_generic_reset_control_assert(void *data)
 
 static int dwc3_generic_probe(struct platform_device *pdev)
 {
+	const struct dwc3_generic_drvdata *drvdata;
 	struct dwc3_probe_data probe_data = {};
 	struct device *dev = &pdev->dev;
 	struct dwc3_generic *dwc3g;
@@ -41,6 +47,8 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 
 	dwc3g->dev = dev;
 
+	drvdata = of_device_get_match_data(dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "missing memory resource\n");
@@ -70,6 +78,17 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get clocks\n");
 
+	if (of_dma_is_coherent(pdev->dev.of_node)) {
+		struct property_entry props[2] = {};
+
+		props[0] = PROPERTY_ENTRY_U16("snps,gsbuscfg0-reqinfo", drvdata->gsbuscfg0);
+
+		ret = device_create_managed_software_node(dev, props, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "fail create software managed property node\n");
+	}
+
 	dwc3g->num_clocks = ret;
 	dwc3g->dwc.dev = dev;
 	probe_data.dwc = &dwc3g->dwc;
@@ -145,8 +164,17 @@ static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
 		       dwc3_generic_runtime_idle)
 };
 
+static const struct dwc3_generic_drvdata spacemit_k1_dwc3 = {
+	.gsbuscfg0 = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED,
+};
+
+static const struct dwc3_generic_drvdata fsl_ls1028_dwc3 = {
+	.gsbuscfg0 = 0x2222,
+};
+
 static const struct of_device_id dwc3_generic_of_match[] = {
-	{ .compatible = "spacemit,k1-dwc3", },
+	{ .compatible = "spacemit,k1-dwc3", &spacemit_k1_dwc3},
+	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);

-- 
2.34.1


