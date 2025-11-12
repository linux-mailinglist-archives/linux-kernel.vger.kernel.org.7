Return-Path: <linux-kernel+bounces-897008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC3C51CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D4854EEAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638E30ACE6;
	Wed, 12 Nov 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FnU6R+64"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBBD3016F1;
	Wed, 12 Nov 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944459; cv=fail; b=rP0sAUINLU6D26KJlWqXns1MEuBhCkcabZm+0YDzsnOz5Ay8xHVnsKmaD/T42t/+rVFiIEAJCeUZrYWzyfcAEdAK4q5QzM1SaXKdeGmr2fEcZ0lbzQVhzPy1ABmDbz0PSeerYasrphd370Sxs5giwdYnxClPusfRTgs4aQby8VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944459; c=relaxed/simple;
	bh=V/bZUVJcM4sar3TS7DcHOMInjIQBtI+HPRUoyArDdpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G0kH7QqRZnzsXqCal9rgvk7m3kcrZe96cVWWExEfSrNR4QziKbDlbFyS1LXUCNxzuaHfEQ80X0RtLtz5HpkanKnBi//gWmxZo9otQ8LkFwir/7N6fXXmG76mbvIw79xzbL8+eS1yzwIvi3FihaVTf2Nx/rfgetOWiFx0UnsBFc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FnU6R+64; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACAkNhE965864;
	Wed, 12 Nov 2025 11:47:11 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acret83pb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:47:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj8ai1CyWAFJdCNwYI8R/aqlct+O+FqCBkWoaLJNZfMWYBEI0wyJFHeS6C5j0WR4dIFRfrgKkAgTapT/ZoQusi09fj/wwjbr4a7biCJnVyxQg9bkvbHlRTqxMuis2pNtxB+L9jnBnZEMbAhq/CD1MihsoiHOKFH0JuQjqS+lsG+9/yC7KUeInDxZv34L11CJQHHFVL5Csb+aPy/je2cpzI9aUIwPuMhMTX4DOA4eNdc1VGvs8zWxJVNOYH8YhwtLd0zKsuxzCu9T3C1oi3UR2e3EX2NYKshS0G8BMXwsiQCX7xAPxjFJfdkaH0vclpOq07TdBZYXJlQq4Z9LCFWE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dbe+C4JL0UZOJb7yQU/zoG/1X1vfGQr24dk72l+paQ=;
 b=ccb5j2fmPkeuTvX4/6uponiAg6JefbPKh7AUq9uwlT+KWLCPQ4ljZBdYcIEP1E8FWP5GcJ3T8sjoF3jc4/fZ2Q7lIpVZdVJzCbdXmD7139Eg9etWZMmMs3pfLCJBXJLpWKu2NqrFSE9Z8zVfrQONpWOtYv/7K8WO6ieEmEGvYSCOavYPlU8Qxg7tvfX+befHTB9pIueYj2udUnsk1sFRQFPvC/83/hlxMjdHGETiDS8I/GCu+xedble1rDetY/9t0yU5npBn6ivDWFuQ6JeUTPRqnJFQr10NzNsQ+arBW5f07fSBrEIhkv7aPYAFkGuBjPgnaRHX2hLLBrkY+8Zg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dbe+C4JL0UZOJb7yQU/zoG/1X1vfGQr24dk72l+paQ=;
 b=FnU6R+64GLoQaooDemz/almvlLKXRMQrfT34uTZ2xGS9DG3ZYHqGDUyz2VOPwddi79zUCNe8JpU7V5qpomjYmdCDXGh+R3oL7L+CmdGpLSBjNivAs/EtesP9ywg90UOYIAPwb+JYZIFGojDJgObYlFKnujCZSBVR5+96o15DrsWIMMxUYnXGYsri4AkNZnRSmu8bk/+YmvYdmjUUzBMAEPimWPhh9K2w48pOCqCov7xQWJDuxPPhWcNnPnKEzEfEH5oPsHze/x3sm/TE640uM8rXVvIahxRax5olrGDn7q6rdbyTQpv4vgphgIJXiVqilAVdxG3QQw7fIlMR4kvKWw==
Received: from AS9PR06CA0706.eurprd06.prod.outlook.com (2603:10a6:20b:49f::16)
 by AS2PR10MB7983.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 10:47:06 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:49f:cafe::cb) by AS9PR06CA0706.outlook.office365.com
 (2603:10a6:20b:49f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 10:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:47:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:16 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:05 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 11:46:43 +0100
Subject: [PATCH 1/6] ARM: dts: stm32: Add boot phase tags for
 STMicroelectronics f4 boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_uboot_properties-v1-1-0b19133710e3@foss.st.com>
References: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
In-Reply-To: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|AS2PR10MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cce6df3-6a37-46c8-4c47-08de21d8d256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHpDN0wxVkhKWTExVmFGbkxwdmJleWJITDRKb2M1QTNVQU9QNkhzMy9SVm1O?=
 =?utf-8?B?SHBvT1FmSFBPSE8vT1lXUnE2ZzRoOUdXK09od0NOQy80SnVvWDZEcHB1SGg1?=
 =?utf-8?B?eHdoQUdnZzV1QnNBNVJ5eG92UW4wMTRHOHMvanRUZVY1YVc2QWJYNWlUbVVt?=
 =?utf-8?B?SkFmb2FOOUp0cmdzZUJ1Vk9yZTNqMEI4a2IrbFdOL21od0VTelNkVXVWTmpt?=
 =?utf-8?B?N3BRNjI0STRDZU5sNWMyRU5td3JRZXhoQVpSWDlwZXFjVlhxY29TZEdGRjNi?=
 =?utf-8?B?ZFZCa0tTSzZRbkN6OFdaWWJYSTQxU0Nwdjd0ZFIwYzNPUDZtN1dudWh4UHFR?=
 =?utf-8?B?clo3L0pTL21tZHcvWWtxSEJFMDE2bkx1aFh1VGs3OHM3NWFrMUpYalIyV3hT?=
 =?utf-8?B?UlZQQ3FmS3pBNUFvVnRhRit1UC96aCt0MGI2cUlCT1RrUGJESzhqZGRGYWRM?=
 =?utf-8?B?eTEzQ3JPOGhuOWFVRFZjZytRODVFQlNpZ0czdzZlMHBIWk5MZCtZbmU5MW1X?=
 =?utf-8?B?MHRoZ0NtQnFGZWVOWDdURGsyY3JtSDNIcGNQVzhjMitSZEpTRVFGb1ZRd0pU?=
 =?utf-8?B?M1g2UndHdERjcDhtUW9BUTY5YkxpRFpKdVArVWh4WXNJalUvZDFSK2JIQ0pv?=
 =?utf-8?B?aG9LTzZFNzNPRmcxVnZqb1R4MlRxbXBzU0pZY3FocUFrSG9nb2hVai9GWFNL?=
 =?utf-8?B?ZDU0MmdxL1RyVU9mdHo1T1pJUVFCb1llQnlvZHN2Sit5dXU2UlV0WmZoS0J4?=
 =?utf-8?B?Q0h6WnZuUXJuZGlDQWw4bXNsU0ZRTTR3QzduZ2lKNFh5UndTelhNU21FZTg1?=
 =?utf-8?B?R1FUbHQ4blpwYlpBdDY3LzBaYkJWVzFHby9kT3Q5ZG5xVXdManpIOElCQTF4?=
 =?utf-8?B?a0pQT2NxRkROaXU0ZW9RY2I0R0dvK0oyTjd1WTQxc0Jva3Z6cUozV2FVR0RY?=
 =?utf-8?B?QWlaajJUNTFBWUhaWmRUcUJuTll5cktmUUhBYktyRVpneW9ZUG9uVThTLzVh?=
 =?utf-8?B?M3NvOFh6Ym5yQllndDdqWmJ2NlFwanM0eE5XU1hHWTZNMWRXb3pPU1NFc0RD?=
 =?utf-8?B?dTNrQ0FqZklhcW1BZ2RCZWhIdUphN3IrMVF3aCtJWmxwVGpwWTFjMmgwSUkr?=
 =?utf-8?B?NzZQTkF3V2crRGMzM3RaYzlUeFhGVmEweW5hMTNmdDBDWkRvWDJGMDRtZzVD?=
 =?utf-8?B?aTI3ZXlWMU1JVE5Zb1pjaVhQVnpOdW9CTXE5ZHRjaE16bWdYK05Ea2c3TzJz?=
 =?utf-8?B?U2ppcXhhdXlIbFV0NlUvUEFiVHFmQ1BXd1NqUnV6V3FQbmZRalcwSHpiUUY3?=
 =?utf-8?B?MFU0bExDYlNEc0ZzanNGTkxLdk5NRG9GYjNCQWNESTVVOTJkVm4wTENzRFpC?=
 =?utf-8?B?VzdWclIwbEFNdzB1YVY2Z2ZuZlAxQzBGSXpiR1E5UmJLa0Z6NjAvUFJjUEZE?=
 =?utf-8?B?WGRKelpyOWgxOTdjeEIwSTIweDBaMlVUZUdVMFdlTjFqMG9URmtDMlJWUzFB?=
 =?utf-8?B?eHArN2pXeFlXQWJ2aTIwVXVobS9SdDFDNU9tWmEzQm1KeU1BSHRVazJBSmFr?=
 =?utf-8?B?M21taU9TU0t3ZGtCNVRVSVdaaFpncHROZ3BZemxJWEg5anpPSENpTEYzby9N?=
 =?utf-8?B?TE1YOGNsZkJOUmRESXViTGUyMjhKUGxZWjZ5cmUwL1NrK2d5S281Rm1pdFBO?=
 =?utf-8?B?a3RCdmsvSnZaNUpJUVYxVEhvT0ZtdzVCWXp1Nmgya0V1c01DQWFJa1ovZjBJ?=
 =?utf-8?B?aytRdFJpOFk2VXU1OVJvelpCcFhuaTFWUjZiTDRFOHJZaVJiZlRENC9aWWhh?=
 =?utf-8?B?OUFxOVBqMms3bExlejEyMjNZaVpYL3ZHUW9Uc3hGS2xTZjRLaUM3TlZCOWNa?=
 =?utf-8?B?VlQyQlJ2VmM2V1I3bjB3ZDJVTEhJeUhDTEFxenI3YmordWN3d3RTYlo2TGsv?=
 =?utf-8?B?S3VlOGdieHo0US9NREpZUzRyK1Q3bXlobUFTQnRDNkg3VnYzbWhVMXZnMm1E?=
 =?utf-8?B?eHhpUHZJVVF3RytkbkFkQXlNY01SYVFDMlZBeVRBa0lCYVhpemxvY1k2R3Zk?=
 =?utf-8?B?LzZNOUxDSlhvdW5Da2lUMVZHOXFIZEdOZ2ErbThML2hsdGt5Y3JTandvdUdH?=
 =?utf-8?Q?+lz4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:47:05.7810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cce6df3-6a37-46c8-4c47-08de21d8d256
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7983
X-Proofpoint-GUID: 4IAaAVxRER7nqtZCTCfijKLyzj8ktA7B
X-Proofpoint-ORIG-GUID: 4IAaAVxRER7nqtZCTCfijKLyzj8ktA7B
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=691465ae cx=c_pps
 a=GxenEFv9DmgebrKzBBA+LA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=h9jCnciPw8RmqMyquroA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NiBTYWx0ZWRfX2bijaHpT6pPr
 TDOLj/oikrxTcNNYULPAKHy5IGyge7fBksgwmOhooJQuOX51wce6/Xfrd/FZVziE8bTqiV5h46A
 zy2uGI0Xsv/VbQO7Ro5d5cTr31pzHSP4M03TJn7r9n5EdHraJUjbazM8rKe3Ffl+1OY+bkg+v15
 tp0t3GHsycNAe1CgFEOgSG0wsPPQDpv+dchytkG113SYFc1g1m5ywRF+3fwb7a2u945DawKxieV
 25WbeQAz+CRoEaNW8lj9+g12MU5bNAX73Ae9PD/C3O8iasx9P0X7ba/yrIEIpfXPN7rzh1TbTy/
 ZbymAOJzLsren8NY3DTKMdcPq699lt+Uyf/YSexyH6MU5hzX4LuTpodo1ezsvTeX7ZNFOx2BR5l
 3jzx9ETx1OZ9K/oNMVUjeaZhmSBCwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120086

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.

To ensure SD boot, timer, gpio, syscfg, clock and uart nodes need to be
present in all boot stages, so add missing bootph-all phase flag
to these nodes to support SD boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32429i-eval.dts   | 11 +++++++++++
 arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/st/stm32f429-disco.dts  | 11 +++++++++++
 arch/arm/boot/dts/st/stm32f429.dtsi       |  9 +++++++++
 arch/arm/boot/dts/st/stm32f469-disco.dts  | 12 ++++++++++++
 5 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32429i-eval.dts b/arch/arm/boot/dts/st/stm32429i-eval.dts
index afa417b34b25..3b6151fcb070 100644
--- a/arch/arm/boot/dts/st/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/st/stm32429i-eval.dts
@@ -312,6 +312,7 @@ &timers5 {
 	/* Override timer5 to act as clockevent */
 	compatible = "st,stm32-timer";
 	interrupts = <50>;
+	bootph-all;
 	status = "okay";
 	/delete-property/#address-cells;
 	/delete-property/#size-cells;
@@ -326,6 +327,16 @@ &usart1 {
 	status = "okay";
 };
 
+&usart1_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 &usbotg_hs {
 	dr_mode = "host";
 	phys = <&usbotg_hs_phy>;
diff --git a/arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi
index 3bb812d6399e..bcaed4618738 100644
--- a/arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi
@@ -51,6 +51,7 @@ pinctrl: pinctrl@40020000 {
 			ranges = <0 0x40020000 0x3000>;
 			interrupt-parent = <&exti>;
 			st,syscfg = <&syscfg 0x8>;
+			bootph-all;
 
 			gpioa: gpio@40020000 {
 				gpio-controller;
@@ -60,6 +61,7 @@ gpioa: gpio@40020000 {
 				reg = <0x0 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOA)>;
 				st,bank-name = "GPIOA";
+				bootph-all;
 			};
 
 			gpiob: gpio@40020400 {
@@ -70,6 +72,7 @@ gpiob: gpio@40020400 {
 				reg = <0x400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOB)>;
 				st,bank-name = "GPIOB";
+				bootph-all;
 			};
 
 			gpioc: gpio@40020800 {
@@ -80,6 +83,7 @@ gpioc: gpio@40020800 {
 				reg = <0x800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOC)>;
 				st,bank-name = "GPIOC";
+				bootph-all;
 			};
 
 			gpiod: gpio@40020c00 {
@@ -90,6 +94,7 @@ gpiod: gpio@40020c00 {
 				reg = <0xc00 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOD)>;
 				st,bank-name = "GPIOD";
+				bootph-all;
 			};
 
 			gpioe: gpio@40021000 {
@@ -100,6 +105,7 @@ gpioe: gpio@40021000 {
 				reg = <0x1000 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOE)>;
 				st,bank-name = "GPIOE";
+				bootph-all;
 			};
 
 			gpiof: gpio@40021400 {
@@ -110,6 +116,7 @@ gpiof: gpio@40021400 {
 				reg = <0x1400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOF)>;
 				st,bank-name = "GPIOF";
+				bootph-all;
 			};
 
 			gpiog: gpio@40021800 {
@@ -120,6 +127,7 @@ gpiog: gpio@40021800 {
 				reg = <0x1800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOG)>;
 				st,bank-name = "GPIOG";
+				bootph-all;
 			};
 
 			gpioh: gpio@40021c00 {
@@ -130,6 +138,7 @@ gpioh: gpio@40021c00 {
 				reg = <0x1c00 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOH)>;
 				st,bank-name = "GPIOH";
+				bootph-all;
 			};
 
 			gpioi: gpio@40022000 {
@@ -140,6 +149,7 @@ gpioi: gpio@40022000 {
 				reg = <0x2000 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOI)>;
 				st,bank-name = "GPIOI";
+				bootph-all;
 			};
 
 			gpioj: gpio@40022400 {
@@ -150,6 +160,7 @@ gpioj: gpio@40022400 {
 				reg = <0x2400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOJ)>;
 				st,bank-name = "GPIOJ";
+				bootph-all;
 			};
 
 			gpiok: gpio@40022800 {
@@ -160,6 +171,7 @@ gpiok: gpio@40022800 {
 				reg = <0x2800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOK)>;
 				st,bank-name = "GPIOK";
+				bootph-all;
 			};
 
 			usart1_pins_a: usart1-0 {
diff --git a/arch/arm/boot/dts/st/stm32f429-disco.dts b/arch/arm/boot/dts/st/stm32f429-disco.dts
index a3cb4aabdd5a..39a80a9caa5f 100644
--- a/arch/arm/boot/dts/st/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f429-disco.dts
@@ -209,6 +209,7 @@ &timers5 {
 	/* Override timer5 to act as clockevent */
 	compatible = "st,stm32-timer";
 	interrupts = <50>;
+	bootph-all;
 	status = "okay";
 	/delete-property/#address-cells;
 	/delete-property/#size-cells;
@@ -223,6 +224,16 @@ &usart1 {
 	status = "okay";
 };
 
+&usart1_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 &usbotg_hs {
 	compatible = "st,stm32f4x9-fsotg";
 	dr_mode = "host";
diff --git a/arch/arm/boot/dts/st/stm32f429.dtsi b/arch/arm/boot/dts/st/stm32f429.dtsi
index ad91b74ddd0d..51c931f7b9d5 100644
--- a/arch/arm/boot/dts/st/stm32f429.dtsi
+++ b/arch/arm/boot/dts/st/stm32f429.dtsi
@@ -54,16 +54,20 @@ / {
 	#size-cells = <1>;
 
 	clocks {
+		bootph-all;
+
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <0>;
+			bootph-all;
 		};
 
 		clk_lse: clk-lse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			bootph-all;
 		};
 
 		clk_lsi: clk-lsi {
@@ -76,10 +80,12 @@ clk_i2s_ckin: i2s-ckin {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <0>;
+			bootph-all;
 		};
 	};
 
 	soc {
+		bootph-all;
 		romem: efuse@1fff7800 {
 			compatible = "st,stm32f4-otp";
 			reg = <0x1fff7800 0x400>;
@@ -580,6 +586,7 @@ syscfg: syscon@40013800 {
 			compatible = "st,stm32-syscfg", "syscon";
 			reg = <0x40013800 0x400>;
 			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SYSCFG)>;
+			bootph-all;
 		};
 
 		exti: interrupt-controller@40013c00 {
@@ -666,6 +673,7 @@ spi6: spi@40015400 {
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
+			bootph-all;
 		};
 
 		ltdc: display-controller@40016800 {
@@ -694,6 +702,7 @@ rcc: rcc@40023800 {
 			st,syscfg = <&pwrcfg>;
 			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
 			assigned-clock-rates = <1000000>;
+			bootph-all;
 		};
 
 		dma1: dma-controller@40026000 {
diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts b/arch/arm/boot/dts/st/stm32f469-disco.dts
index 8a4f8ddd083d..de025a385e9e 100644
--- a/arch/arm/boot/dts/st/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
@@ -169,6 +169,7 @@ dsi_panel_in: endpoint {
 };
 
 &ltdc {
+	bootph-all;
 	status = "okay";
 
 	port {
@@ -225,6 +226,7 @@ &timers5 {
 	/* Override timer5 to act as clockevent */
 	compatible = "st,stm32-timer";
 	interrupts = <50>;
+	bootph-all;
 	status = "okay";
 	/delete-property/#address-cells;
 	/delete-property/#size-cells;
@@ -239,6 +241,16 @@ &usart3 {
 	status = "okay";
 };
 
+&usart3_pins_a	{
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 &usbotg_fs {
 	dr_mode = "host";
 	pinctrl-0 = <&usbotg_fs_pins_a>;

-- 
2.43.0


