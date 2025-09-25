Return-Path: <linux-kernel+bounces-831572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A818B9D0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C77A5F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0972D839D;
	Thu, 25 Sep 2025 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="FLDe5ppt"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26678F3A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764376; cv=fail; b=a7Dsnv1Tdbl7REOZ6G2ns2hs6N62f3xpCvNJZd136teT0TrqCRDtTqRIHB0TwAcl7lRr3LEUlZDyGK4J4OlAw3oNK6nCwetCwqeUKM+0aWyMeXkZOMIyrTHKAEAyULAvUf5HWB35JE518v+cuO17oBBIu0+7+gH791Nz3gqNG5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764376; c=relaxed/simple;
	bh=0PwA+9AzJkLCqGxzVX3NyIE/VZiUgXsEtqzydgR6TGw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nIPnHwinN179Wv8gF3nV+DUC0RbipL0Z81sT6ryJNU1Z3VL5Cjo1yvp+xyDyfN67hlDsPUPIgpM7DxgxDrLkYql+Tu41jmamFeYZJcaJQS+/dI9tCJsmBxIHduGse7O//30abLquFUbhAbCjlTU2BLV1CCbnjYK1VOJIb/0/yAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=FLDe5ppt; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58P0pncV2286738;
	Thu, 25 Sep 2025 01:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=zZXjIdj1i
	76zrv5ZmYcsqd04RRG9rK1YAzPEF+/C7c8=; b=FLDe5pptme5GnEg5vSoiO8x9V
	f11rtRGyHfcviV63ssfRXpDboLiOWlqWDen8dDmunDhDDHg7AljUcUusvhDvJZp2
	0TB/xIP3sAYqyBZrkwDlr6Eg33FgNyF/+R6gsxD0a/VFWQMMWRPjnmJNyejQe8OJ
	dHlz/6jbOdoiIQjBJCL0ub7o6HoNHZe+ZS0TgiHKClsmHL+Xxxr1v8nrAGYt2/Yc
	hNpQ/WTgb/kqaK2oRkFtPkx+N4MuMS/8aZkTbT6wOWQJ7hJ5arhPTShopP4Puu9H
	W8rwWbVwW+LIG8hTA0Y/RAhpGn4ea4PAPov7gV/XV1H34trIpgk8/n8wcLMkQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499hg1nrvg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 01:39:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvPI3IBj3ULvMTajUi27GehmkQS7SVU7g7t7Z63bLF2psDDvm2+l0dBpx02be50JDYaZezr4djPre17OEfahIK+NG7cr5SJcSuqguQ48ZKWUZ++KXUqBU6l40wpU+Ql3x9nZuH/tlk+BgVz4ESandPB5tXo4COxJJTfXrx0l61aE7e7R+kP3T2+J6s9yPuBQ0tIZxVen6bmIbus4aPrGl9srCExGzKccwyIep55sctAsfXVXiqekljawbuzOJX/3zXw4Xd/l40xmSTd8TqFPnGDXRB+JzjtnAECStAQGaYZvvm1ein5dDm7TJcadcO0wdUy+fZNo+ZTa0Kio2oUjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZXjIdj1i76zrv5ZmYcsqd04RRG9rK1YAzPEF+/C7c8=;
 b=Bg2FSWaEo9K/Tmv/5H9WkAH3h8yAxc//r7Edtp1SIe/M9cMfAIOGWt0DHyI5LiZOwyoWOfhvKNvahVQPR9OrW0PRzgDwQHecObO5rqdzYq4MvSboFaFeWZnmgKGXj/tCaWYJQmAB7s7/5b48pif8XNV8gz/IS8gtbsWhdi8OcDA2Jo3mWamr4XuByd6EPHX9vf01GhKaeYclDuJKFtSjVVFgCVQEDV7TyqphXRBpaoXkZsszGO0QTGwQ3FK/Lf96jSHZNtM3qUAWaNAqWxsoZzzrNJA5zlb80b/bzhund37HtWSl30HWB7cb0FcerYpjaOJVe1MhOKBaj2oLdwQQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by DS4PPFACFC9C99E.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 01:39:15 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::4b10:b3ea:35de:ab99]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::4b10:b3ea:35de:ab99%7]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 01:39:15 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: Frank.li@nxp.com, vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: freescale: Initialize priv->lock
Date: Thu, 25 Sep 2025 09:38:06 +0800
Message-ID: <20250925013806.569658-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|DS4PPFACFC9C99E:EE_
X-MS-Office365-Filtering-Correlation-Id: ac52e0ca-1239-46b4-d50b-08ddfbd455d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lm8TRyrzSXi4L5+QWuS+JjHfYf2fVDdUZsKh4yyblSX9FoJuR4+8Lr1YtcEZ?=
 =?us-ascii?Q?je064w0AeDEXoFIWjjsRBddwrG5aCsuUdKfqwGeDSoHWCKukUsVK5wo+Qoex?=
 =?us-ascii?Q?PZK4WjMhY3AEfJtO/LyPXd8q6H0LA9t9N6I3yt1si4xPmTdutqcyBuVhgp9G?=
 =?us-ascii?Q?BxBqhHyO8kBwB2G8zSnaC1ana1mhrhEexsXe5G/Qp4nibzcFNWnjwro4kxRL?=
 =?us-ascii?Q?Qs3SL/8XpRsiWd1EblHETx+rApV/kktMfbImiA8ffKTHNP8sCtmFMqMjz0a7?=
 =?us-ascii?Q?/dt3HUH+CiRNDYGixna6frzmNZZkdju5J9Ge2W6NjNvWFk04dCcfXucsqkVQ?=
 =?us-ascii?Q?Da6nYyjYYDu9OHpLG8qCefeNQwrpZ1xZv1Nhl3biaS+HvefvGTVHfeKsNzU+?=
 =?us-ascii?Q?6NgU3s5YUECXjxW86eU9ZqrEx8JRDYxA/rOuBdbRFUW+Qb4D6jzSj+fRel8h?=
 =?us-ascii?Q?8yuMF0tvADCLKiQithXh+yOyz9rcxw02l7laAnDqGEYbVNUwOqXp0nkIxYH2?=
 =?us-ascii?Q?Y4fo8nKJ+BGDvu8ljd6Fvbm5rf05pZhgDxfGhEzrm850NE4Fh3ZgukHeneMb?=
 =?us-ascii?Q?QhrCnr6mOD2uWiUAQZKS6+sThhtxa1A111LXuk0G0SnH4i5r7VY//Itk0Lf7?=
 =?us-ascii?Q?y5pgJ1y+e9Sq90ap79wLYa4JhsqaGVzS8TCQ27FL1HeCGs2RECH9iTthMekX?=
 =?us-ascii?Q?GKuDuWrxFojgGc92jhLqAsDWvLtBx6ea8TbzGHM12FNz+5AX8z5FYjhrRZP+?=
 =?us-ascii?Q?G5gvZP99jXre1jVShNlZIinzD4cX4ucTikHsX+7qi+Mkn8wBG1ra9M6aU3HQ?=
 =?us-ascii?Q?X1lx+e0t5vFoxNQtNQ5IE1QMRyt1WrQtQ4dKXmEOEHY6kJXICLakKXWyCs7I?=
 =?us-ascii?Q?a+cSmwQb3ynEO3WQRYLmhI/3i+j+4/E9Kjg+YhsnT+VyQyn/jBv2SzvmHTlu?=
 =?us-ascii?Q?n0m26D+0V36TLuZQmsrRi+Dm2qJjS/bzHTy2WSj1FDVNxd6+aH2zp1cWXjDQ?=
 =?us-ascii?Q?x788L7CdQ/0/WLuE9uAZNkDmUvdSFDooPe80qzN3zbTjZtz9jZxX/vuv0Vrz?=
 =?us-ascii?Q?nQUygUg47t1poPTHEOfmvYJC3ppc3K8pDBTc5VRngzkcbuH5uERCm2+zcPVY?=
 =?us-ascii?Q?rirR3DxtlYoqKFrSClOdn+B6IdBLcjLKz0zLCjTXbsJ6NGFMIpu/f1VlvPb5?=
 =?us-ascii?Q?kabieh0LXlIYPsEF9hCFIETqlA79QyzXChDfIgxZw3j/xfN6H4gBybWMPQq6?=
 =?us-ascii?Q?m5VM2dsd8eJ7oV+ua+CEavvmhkNQv+3nadSabIY14d1yaEjcFy0VGdNxHeG0?=
 =?us-ascii?Q?YcOZRNJVrPD9D3mRSkRqkttnDdRBENoCuuDs/Bpqei6oiKxAM+hc2PtE8qEL?=
 =?us-ascii?Q?JXiHcA116QBR1wIhDuV18/+5lP/cNQEkPU1BM6nM6My6Mug7obpd8xeyBpoz?=
 =?us-ascii?Q?9k1EggibYHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OMqxrib/KxElcE52SM4+0mJCw5rcOuNkp3a8QKwMrwiJ7E0RunPvEoIkeUvG?=
 =?us-ascii?Q?SofjZPUduyIuMzBbo27wDtkL2kyHogkQ1diqATpbE5hZGOwTTKSEvqtyCA2L?=
 =?us-ascii?Q?1vT2X4twEK7XuEVwGw9zpC8LvIfD7EB113MmKFB+GifQ9gfrz/VO7WUZARh2?=
 =?us-ascii?Q?bnIEFadKcoLAZHOM/p+y7+inebm41TFuTQlSltNOp4w88T4ho8Ij/aPqAI6z?=
 =?us-ascii?Q?ytHIhtDLFL6YZlni5e0XAnPdubtxeCZy9ofeOggkgTUv63fwLp9/u5tdvQ2r?=
 =?us-ascii?Q?0ym43EdqIxCWro9jkTMEbZE35pazV2CQer6eAHMm8WekOa1Dy0ZeEGDdOMB0?=
 =?us-ascii?Q?5yfxCaEH6tPrD1AcdlYn4PBae5TzOGoJSgkE7E2h1gNVH0Byg7xsjK9VthPj?=
 =?us-ascii?Q?kA6D5hoinlYerbPe8+Cy6PwruOrHtsPF9FT0v5Ol2pgw2yp83Iv+gXLVFsqC?=
 =?us-ascii?Q?eFOZGauGeGrBVCObq+ZpVWhrcHdavnw1mKC38/7pr2B2NZs5OfeDjr+dIqAs?=
 =?us-ascii?Q?x+0VDiR7eiRfjES0R9sKz1b+N7ym8wI9PPZDfTe814ARXGj5Csi+nwctVjSZ?=
 =?us-ascii?Q?WHKhn+Kv8LCD1j1lZZ/EvLDVhYCQm+Fdm69/sv2HDoqvq05E2wwyex2hriC6?=
 =?us-ascii?Q?g2AanW3XpO3odk4sdFJCWr7qijuZmlUTwRGnDozQjyGCVEFi5J6EVhJg+J1M?=
 =?us-ascii?Q?1LIwp0UBiRWHwN9H5A85vLajmJijCNMo33sQd06J/0w1mHi78JKJbJw9IAwx?=
 =?us-ascii?Q?FRH3sS3K+i1+exi92HzxQ/dblv2iGuNJ25SNWJo11mdkWA8cBZjsO8woUV46?=
 =?us-ascii?Q?/sRD+HeGBpQbgzIHtrG7pvXded4I+GuRdEYy/kRGeAa1Vnlx+CHB0SDlCCMO?=
 =?us-ascii?Q?nBDGR/I2rZ+T3EzlcFhPsgt91CQdDVQloF9YXn3DKVJLpmh2z9uAQfXyfPRD?=
 =?us-ascii?Q?wL4PGKKpOHkIA/ALLy9QGItES/E/N9s+rLJ96LhwP2Bl2wn5vBdzoAZDLU9Z?=
 =?us-ascii?Q?9iRtWlrils8GI8vfOw6U6L8uPpTKNudPzsWQwp+Vh6bI79Hl2D4xdDD+kADb?=
 =?us-ascii?Q?93cOwi6kPb+oVcq2hjlxU3xl5fgoSdG8F+xvFcIrj6g2UWiUKCAo1GrIVd8L?=
 =?us-ascii?Q?mWDvO7FTYq/GNqSb5c+g+58cstPVoHkQQFwbVVYEpCv8447z/WeJeLxLPsDv?=
 =?us-ascii?Q?cSNPlVBODmHzxOFQ9btHlvSDyJftKQo1jxwlS3+VrGk0tLvHtED4gFyrmoI/?=
 =?us-ascii?Q?09WU+kTX947euXkict/LatRu7dl2KmkEkVcurqO1TtPPglKeQAtH8rY51TZB?=
 =?us-ascii?Q?r/uzBj+OIaSNemMpwFdnjj/8pVir0K7aLnpCBLmeBhfsjtVjjcFGeo6Xnmu/?=
 =?us-ascii?Q?LF1zzc9j/Q0k4Bk5LT2Igc1qfiVx7lLCM9aC9nnWm7V6rG3dD8xdioDJRMfE?=
 =?us-ascii?Q?+DI6UwYACVm50lgc9lOqS8qhfZORNkFVvYBsn4RuXsvFXoa7G1NzKg7TCiXK?=
 =?us-ascii?Q?rHeD7mt/U2t7QY1TslsFaeBBwvfLjIomCF+Va9yg0Zeja44n/ZOPYUxC+NB1?=
 =?us-ascii?Q?kBJ0w/Ah9s1W1TedkX6LM57xFSn34RqUNQKEbz6XoBXRCQjYJ+ngmIjQdpMA?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac52e0ca-1239-46b4-d50b-08ddfbd455d9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 01:39:15.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvqDLDwcyI+Ngje86ogKd0nH8tW7KVzfmgzjdk8QgZGdcgn3pplvGfewfIgb4uXUfb5rPnIVshfSs36ike+MUEafGGJP/eqJd81YsVQM3qE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFACFC9C99E
X-Proofpoint-GUID: 62ayGdwvHGwKR5xRWdfnzFbnGsSMhurf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDAxMyBTYWx0ZWRfX2DXNa8gW5h3w
 TR+tQA5o333ZHX5egEF1K+dd1bFuQhE4dfrpMGZbr+Jvy13LjWudvvv/xzlzVoQflJw2mtrsP6G
 VZN0DADnEpb5N7dB9Y23idLeq+8ugY6uXv4DErcd224YjVa9hhH0ry7n8SYwc49Z9DiGoxrC/2g
 jdofYKNA5VGfby4hx9WMly1ZKBHCJBGv1VWnnwg3W2ELeQ8L6JmMnKut2/G/dh3wjIqJYcvnvfD
 bz4DhJYdXu2qfz2BpwVr2KuAJ7VFWoF8zX8M002NyfvpVWygSixgYQiu9GZXBVmmEfTuj2k1Q30
 Ro014McC5cGbU+HRhSU1jB5i+vQ86GQNA5SDwr7wLtmswf2Z/p38kpxb+V5IR0=
X-Authority-Analysis: v=2.4 cv=Yfi95xRf c=1 sm=1 tr=0 ts=68d49d45 cx=c_pps
 a=5ROfPwdIRWh2zNeQ7OwrBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=oonn7jOhsOf9ZOVEF7EA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 62ayGdwvHGwKR5xRWdfnzFbnGsSMhurf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Initialize priv->lock to fix the following warning.

WARNING: CPU: 0 PID: 12 at kernel/locking/mutex.c:577 __mutex_lock+0x70c/0x8b8
 Modules linked in:
 Hardware name: Freescale i.MX8QM MEK (DT)
 Call trace:
  __mutex_lock+0x70c/0x8b8 (P)
  mutex_lock_nested+0x24/0x30
  imx_hsio_power_on+0x4c/0x764
  phy_power_on+0x7c/0x12c
  imx_pcie_host_init+0x1d0/0x4d4
  dw_pcie_host_init+0x188/0x4b0
  imx_pcie_probe+0x324/0x6f4
  platform_probe+0x5c/0x98
  really_probe+0xbc/0x29c
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0xd8/0x160
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x84/0xe4
  __device_attach_async_helper+0xb8/0xdc
  async_run_entry_fn+0x34/0xe0
  process_one_work+0x220/0x694
  worker_thread+0x1c0/0x36c
  kthread+0x14c/0x224

Fixes: 82c56b6dd24f ("phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
v1: https://patchwork.kernel.org/project/imx/patch/20250923141611.1295395-1-xiaolei.wang@windriver.com/

v2: Use devm_mutex_init() instead of mutex_init()

 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
index 5dca93cd325c..977d21d753a5 100644
--- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
@@ -533,7 +533,7 @@ static struct phy *imx_hsio_xlate(struct device *dev,
 
 static int imx_hsio_probe(struct platform_device *pdev)
 {
-	int i;
+	int i, ret;
 	void __iomem *off;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -545,6 +545,9 @@ static int imx_hsio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = &pdev->dev;
 	priv->drvdata = of_device_get_match_data(dev);
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
 
 	/* Get HSIO configuration mode */
 	if (of_property_read_string(np, "fsl,hsio-cfg", &priv->hsio_cfg))
-- 
2.43.0


