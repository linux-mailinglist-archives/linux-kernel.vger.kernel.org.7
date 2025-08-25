Return-Path: <linux-kernel+bounces-784299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F87B339AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A9C16975E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B9229E112;
	Mon, 25 Aug 2025 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gf71yKQ6"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66302C0274
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111114; cv=fail; b=tGRjRglMYUjQcx4e3hATtc/F3hdJXm3G1D6df1wZTjdBmAkhiBV53F+ei8ZrYRn8MkRbus5ToVfTfodiGJH5x7+NykHssc6XVHBv8DAOKlIJCH4VeGjGWD6Ten19CLMDQ7f/NQ0y75adN3R8jljYUC01PPg8RQPSZwr+IaQNusY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111114; c=relaxed/simple;
	bh=g6a8MPgiuacW5wcz6bdGFcDrhYhWOOs/ORLsbL/8KL4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qowf+0bQpOchaLsecXGOwE7j6XBd/2tXD+8pMF3BMb51LlAvj2bf2cKtYRBIAKeXzLldt1SqSnbFQ2QcJKFxlet4SNYhZJ82/damyyAHIiY0V7cb0OCmVTzk33n8LtVy5AoQ/elWbF4ZlswrK6wm1Lylr/iDFk9preQkfOYOwyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gf71yKQ6; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocvYd8ILx6wwEfAFH8X+EnJIFVwwPmNaSYKrBrRfKsldWoziCYB73XIngd7/MQQHIagL6py13ikPBh4ZLW0Wy97fLB9s4xhJdlukD2PnoltSluX8KKrEyQPXy7dtXExOu2FIps9+KEOPgZkUMMLMlj8Pv7YyywWj4wGeT6qjdilybTkesxRnJuNBoqbr8saVvaSwcrg7YPevnnB+7fRCv8cPx/D50f5aATEnWYVq8OJPVU8c8Ukdh9+XhgqVH2/1LR1tY0G1zurBaZ0si1LSCBcv747Lts33mrzeDeIWlbjTHK4idhBEWcuz4Nex4Bz6et9Lv4WeDSb0zS9EBP1XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNZdkKBpTmbzDXAYgm1DXeyaGBdsF1R0kx+GWZ+9IyY=;
 b=oZmh19cH8OKCstYtePZZ21i/ts4dPe0EmaHxaNgMi9d2JHVrCzw1PXS4nLnvGTaicGsqLPreIF4uGksyqb3rar4MpRGWkIfzDNPk6v01WOtOj0p/x7xxndsahN39pwXNOgw4JHamOLKsUnZ+QyBaW9mqC4XaoUgA9G5wlwZRweLfNPFnwXkBu+5bLXnAUfRSOSjE5FbahYfW9I/6uBA23jJotgUUlmhkQ8SIlvAhSaCP0Oo/jPSIkQ1IzCaAcLy2bS2MJvCheKxjasCTRqSh7Nss4pZAz0qlj9s/s8EbReHzOQM+xh7WQ802yeAWDYbioxRDXOotz7Br/MwLhkiudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNZdkKBpTmbzDXAYgm1DXeyaGBdsF1R0kx+GWZ+9IyY=;
 b=gf71yKQ67LmK69o7sXLTrdB4JLd0WJf4s6nXcmnncgkMF9/4kCsdiB3iupc68LKzPrFzHwK1vL4+sYfdxwqffJF4fo36AIE+JMenR4Nip6mBcmx0hKOEOTi1PsA8YQHRNgJPM0BnhxvhNqKZsiY/GWRIYO3fqYSQRkMlq17QZc1rkXmGYWt5zo/vneOhCBl4Fcgvujgz3NGfTmsQcIqdA9h4NudZlXhVtKFHRSi7ydfdqDqu03cpsS2DcIi6/U5jCpyC2VR77qPuFy4B77YLsGj9MAICUf6sakedtmqB3qeCajU3p0ccZ+3GGhz9BJB07T776f4SkkmIgrvjSGllYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MW4PR03MB6587.namprd03.prod.outlook.com (2603:10b6:303:12a::9)
 by MW4PR03MB6868.namprd03.prod.outlook.com (2603:10b6:303:1b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 08:38:26 +0000
Received: from MW4PR03MB6587.namprd03.prod.outlook.com
 ([fe80::1fea:d26f:4671:85f6]) by MW4PR03MB6587.namprd03.prod.outlook.com
 ([fe80::1fea:d26f:4671:85f6%4]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 08:38:26 +0000
From: tien.sung.ang@altera.com
To: jassisinghbrar@gmail.com,
	mun.yew.tham@intel.com
Cc: linux-kernel@vger.kernel.org,
	Ang Tien Sung <tiensung.ang@altera.com>
Subject: [PATCH] MAINTAINERS: Change mailbox-altera maintainer
Date: Mon, 25 Aug 2025 16:36:43 +0800
Message-Id: <20250825083643.43882-1-tien.sung.ang@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 MW4PR03MB6587.namprd03.prod.outlook.com (2603:10b6:303:12a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR03MB6587:EE_|MW4PR03MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e58bb56-ed6e-4c53-a0d6-08dde3b2c254
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0tEdVM3VVdHR3NGM3NlZTY5Vk94MVh6U3RVd1dnalNhY3l0cFd0K0lodUtI?=
 =?utf-8?B?ZmtidktKWEduLzlxS05ZREJVUTExdFVwU1pBNUdtdi9JNVp2bEFYTXo1akZk?=
 =?utf-8?B?RDRNOHRsSkpNa3dGRTJQaENQN3Q3VG9aWk9vaWVPMHFTS2RQcHRzbW4yK1Zm?=
 =?utf-8?B?dVFaTys3ZEM2VkV1Ri9vZDI5Y0dYRkhxYzVjTVowYUI2ZVBoQUxJUU1ncFpT?=
 =?utf-8?B?MHJ0T0R6dVJORUtnWjRDS25iZEJnZ3VEU3VRaE9HOFhPc01wbVFlSzlwdjRT?=
 =?utf-8?B?TmlLblh4Z2g4ZWlONGMzS0gveWFXUDh3YWNhQk5jdEhWaGZsMm1NNVF4MzV1?=
 =?utf-8?B?VEpaVldoY055dm1aSXhnQmxYRVlXVk5OaWpUUWk2SVdBb1cyZ2FYT1ZRaHo2?=
 =?utf-8?B?ZlFZcmNPOW1wWE5hYkhJV0hNR0Y1WFlZVDJnL0kyOHloSnU3ZEw3T0N5dDJs?=
 =?utf-8?B?empXYXdsZWwzTzdHTyt3eUkyNDlmVXExQmI3azZXQWpLYi9qRHF6TGRZcytF?=
 =?utf-8?B?Vi9Pb0lBTHoyQ3cwWE1OT1JYNTlxNmphSEx4WUcwb3l5UHdLNHR4NC81NVJz?=
 =?utf-8?B?MzdGVVR6eUxSV3ZkNzRXRmM1VUlDWFlwMmFBWU53T3lwY0Y1eWsvMmgwZVR4?=
 =?utf-8?B?YmpEK1g5SmRXdlpyTkVlRjh1aDNMSG1zakMwMzFXQU1IaWEzdStVLzBrY2Mr?=
 =?utf-8?B?aDQxYnVkWUVGZVdpQWpzSFBjUjhBVmtYY1pkR25oYkxCa0FENE95YU1OK1NM?=
 =?utf-8?B?OHFSKzVxbDJvekFGb3RUTWZRcHZxZldteks1Y3FJdkNDWVpzaUVlUWlhbFNM?=
 =?utf-8?B?Vko1UnZLYTE3UjZxS0JOb0twcFFhdlE0YlhyT1VkS2RWbFNCc1YrMlBqdVY4?=
 =?utf-8?B?QllnYTV3bEZlYmNUbm5LdTdGZDQwU2cwem9TMkcvclZtaUx1bnN4Tk9weGRo?=
 =?utf-8?B?bTZRdDlDbmIwMzhVTWJ3VUliVnlVSU9rZFQyMmprVDRUWTdyRCtqK0h5ekZ1?=
 =?utf-8?B?cFF5ZEx1K3gxTGhvbE56MDNOb2RnckJGQWJJb1ZjNXhUSG51eW1CR0R0cWtr?=
 =?utf-8?B?ZWkvRW9XM2poL3NPV0NzMGdoVUNhZ2xNZmRVd0Ztd29OT1kxNjBBbVh4WU9S?=
 =?utf-8?B?cWNrTjNuRjRyK3N5cDNSVVdJNGtSS1dnTXNpQkhBeDJDa1ZScjExTFdScnls?=
 =?utf-8?B?SjVlREhkTmd2Y1V1Q0ZkL0V0bEhsMUVneWVpUWZUMmRRVWlNMTBHMy9LbWgz?=
 =?utf-8?B?djBRa1pibmRlcmJuRHZOVnJaVnRYT21BME4vaUticmJrYy9IQ2pQbTFDb3hT?=
 =?utf-8?B?VCtCYjBNaFFyeWN5d25wY1ZzN0U4OVFBNk1sTWFqNHFpYjJla2RUakY4cFBC?=
 =?utf-8?B?bEpEN2lVN0xTNkEzWXZyMit6UkY1anJzcmxKTnVtaE9TUEhtT0g3ZndCcUZD?=
 =?utf-8?B?RzJQeXJrSEFocjFYQkJBMEN6QzNNbHpJMUdMZjNOM2VvL1NBblRibWRXM0t3?=
 =?utf-8?B?SmhTWnRPMm1OOUUvb0N2eGFESGNIYTJhTklaZHkrclJQUjdKb3ovNGlrNDFp?=
 =?utf-8?B?RjI3RWN0Zng3Sk9iWEp2YmpSSDErNUM5V2w5TWljZ3Q1ZENzMlhTblI1S0g2?=
 =?utf-8?B?Sm9SbVRET0ZoSm8zK2cxeUxzNWsvNnJPQk1ic2pDYXhpdWhzQnZ4WUFUNU1M?=
 =?utf-8?B?RStFbyt4NndqOW9VbW9RYXgxdEkxZDE1MmY4QVFTRzVyKzRkbWJVZGt6eThR?=
 =?utf-8?B?SHBwdmFNTHNxN2EvVFFpMjhkb2xtRXhSZ1NmS2k2NXBnU0tMWFlrZWJBQ2Rw?=
 =?utf-8?B?ZjJpWnpSVTdiZmpvRUVJUjlRTmtVQzM4TU4yMGVSbU81NVNMNElnUndMRnhu?=
 =?utf-8?B?ejBaRmhmcmJDSUo3SVlSQ2luUE5zNmJiaStLaFgvU1RHNHdCdHJUTG9lWTd0?=
 =?utf-8?Q?vxyo29Rb2jY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6587.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTJRK1FBWDhUdmVuMHlEa1U4Vk95dTlDSFBzMGxMNnBQWkNzTTZvdzR1M1F1?=
 =?utf-8?B?c0JhbzBKdERWdWRLQjRIVkZQeW5mOXExaGVWRDV4bUVCdFJGUnRjK3dvNmQy?=
 =?utf-8?B?LzdqM1ZFS3RqQS9NS0t5dFA0Wk9YNkY4NmJ2SEJ1RVgrZVMvSHF3WERjWS9a?=
 =?utf-8?B?Zi9ZNHBOUkc2YWl3a1YwQXl6bStBVC9yay9Ea2VjdlU0YXM1NVFvMFRIaHpa?=
 =?utf-8?B?dHFGaTJHcmZHcENLVDNheWQwemFjT2R2WktMaUtCbG5NcjRrSFlDVVBORU9K?=
 =?utf-8?B?STFnc05VNmhPcmJ6NS9qZXlSR3dxbXA2SDFMN1pKUjRtNUZ1UGE1ckszRjNJ?=
 =?utf-8?B?eWYyQ2s3L3BKUFl3RnRaclVuZmE5VlBvaUhxTGQrRTRsandzdmlDcHNONGxL?=
 =?utf-8?B?aEIzUXhHajVJTDZvU2lyVjRpeUZDQkl6MFJkUEtNVUhCWC9uV01wdHplVml3?=
 =?utf-8?B?cVNGSEZHQlF3WXpWNFIrVXVxZDl4N2RtWEprb0RRSkZiSDk5MDYrRzNqQkZC?=
 =?utf-8?B?VDc3c2g4aWdJeHR6L05VcWRMK2c2UEVyMEVmTjlKdHcxTmFEWTFtemZLL3d5?=
 =?utf-8?B?bGFEVTZoZE54NHI4YllGTzlOU1dPcU5MNUEyTThoUS9VNXkwZ1BZZmdodWJD?=
 =?utf-8?B?Y0lZbHBpTHpJM29JY3o2Q1pYalA5cUxaRmhXMWUxcUdpeXNkZEJBN3d6ZmRu?=
 =?utf-8?B?em80NmsyeExramZ1U2FLWERNZ1BGcFBvREVUK1VJYmY3ZUEyNEV1SlpNcXdt?=
 =?utf-8?B?eWVrUHh6QkZKSEptRytRS2VlZVdxK28rU3hPUnJmcEs1NHp4elQxdTN2TWhB?=
 =?utf-8?B?SGNzNTd3M281NE1jb3FtMjZqWTE5YmVYVGxWditLRElBZEZudGVLNDl6eHU3?=
 =?utf-8?B?a1ZSL1lqdlZIRTRxWkVXdlk0OG1WUGp3cGV3V1FlMWhJcCtPVFBOaWYzRHdt?=
 =?utf-8?B?RGs4T0FUU2JCYXJQQ3RxY3laaFBMUC9nZURhMW15NVk3NDBYNi92T2VGUXZv?=
 =?utf-8?B?dHlBUWRPTjBQaFZ5TlRJRXBlWUpzZDF1L1dJbmp4Rlg1bC9RbUdSL3Erc1FR?=
 =?utf-8?B?NlBlSVJmWVpENkxyU2g0VXIwQkFEaUVYOGtGYVc2K2hvRTBMZGxJbExZL0dF?=
 =?utf-8?B?a1hLVDJPMERFR0l3YnRqcW1UcWF4RWQ5Z0FQM0ljSHE3T2szbjR6U3dmL05Q?=
 =?utf-8?B?ZDNnVGJOR3EwVm1peVlkQW5YbnlYZ1hyZS9qK1ZrTE5MVGZTY2VjWmhESXcy?=
 =?utf-8?B?ci9TdmJKRXR2c2g3eUc0b1F6S3RMSEVxU2kyTHdWMW1JMEs2MldKM01tN2Rh?=
 =?utf-8?B?blY0SStrak9FaXZWTWxTV3ByRkd5elpzREJrMjExRHV4OU95b3RGYW4yS2NK?=
 =?utf-8?B?ajRNV2U4NGdsd2thcGovWXR2UW03YXBsQWFBaTFLZFNqelNOVGpOd1d2dnhF?=
 =?utf-8?B?QmhpT1YzVXZGL09yTW1Dck5OTTJUVlN0ZHF0bWRwa01YaCtrN1JkUlhpOXRj?=
 =?utf-8?B?eTVZUjU2NitvdVRDYVRKQ1I2SWJPTkY2OEw1MmdtQ0ptbnh1MUpUdld3NVll?=
 =?utf-8?B?SGZEc2c3L2dqRFFEUW91dmd0dzZIcStDUlpJZkJKcVpUZ1RjREY2dmRpQlFl?=
 =?utf-8?B?VE43My8zTmt5Z0tRSlZjS0lDcjNPUUVLUVNtSGV5cmpaUENjYXk2Z20rSGww?=
 =?utf-8?B?UVdJM3EyZDJYSVhtNGVKMEhWUldIY0NrYnY4YWdoZm9EZzZYYjBubDhCWHk4?=
 =?utf-8?B?d1d4bm5tTll4S2k1TlZQV3NYR3BVblFCWjcxbzZ3dFFyZ3d2anF2bFd3WTZm?=
 =?utf-8?B?N0hQM2JxMEpmODQzckJjWXFCWWlNazI1bGR3eHpsdzNNUEdneVBjNHo4WE56?=
 =?utf-8?B?RWZJdmxFS2huSWh1UDJjODBuKzhOcmlhbVo1Q0lEMi80MXhCWlN3c3ErT2or?=
 =?utf-8?B?U042THNqakxEaXEvMHo1d1dMZWQxZ2s1YUQyV0UyT0Jwc0pHQ1VVUk9CT05E?=
 =?utf-8?B?ODYzbUw1cWo2TDE5K20raXRtcnlIbDJISGZhUGRNUmd0eGVTYll4bUZRcEF1?=
 =?utf-8?B?a3BsaXdMSHdqZVZnMzN2M1lCZncwVHVFYTh5bGFLRHpmWG1Fd2VjTTFlQm11?=
 =?utf-8?B?blIxRk1DM3l4M05CdUhhL3NEdFlEYi9BYkVtTy95cWlTNndySkVvWUR1S2NE?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e58bb56-ed6e-4c53-a0d6-08dde3b2c254
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6587.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:38:26.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCofoUjBO0ahqHv6rWQqDD8q/4f+cB98slyyL5IV8En/ovTSIKr1BodTc5n4kUybwShi3TJ5Xjk3sLhQubh/CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6868

From: Ang Tien Sung <tiensung.ang@altera.com>

Update the mailbox-alters maintainer from <mun.yew.tham@intel.com> to
<tiensung.ang@altera.com> as Tham mun yew is no longer with Altera.

Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..bf18abb5027d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -918,7 +918,7 @@ R:	Pali Rohár <pali@kernel.org>
 F:	drivers/input/mouse/alps.*
 
 ALTERA MAILBOX DRIVER
-M:	Mun Yew Tham <mun.yew.tham@intel.com>
+M:	Tien Sung Ang <tiensung.ang@altera.com>
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
-- 
2.25.1


