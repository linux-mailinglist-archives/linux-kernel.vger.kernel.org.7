Return-Path: <linux-kernel+bounces-750219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F9B158C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0175118A2037
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C781EFFB4;
	Wed, 30 Jul 2025 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NR8aqcAw"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012037.outbound.protection.outlook.com [52.101.126.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A42BA33;
	Wed, 30 Jul 2025 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855908; cv=fail; b=uyDtL4+I5UG/a91lViVslfW3YPC0TGfDeSXVfD29lLtdlMYLBQrfrqBZvqmay67s5TYFH5+xHBvQ3t7ZlyZcJSHeCtdryZpx/mfdoxXor+QNwcRz9W5TRfDWGZs39n6KV26H53v94clEN4YzhmHax0RmG3kTroHlWS55EybSaio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855908; c=relaxed/simple;
	bh=IK/yTEnPGPygRB6JWsp6pDibwKdMbwMN4IiEOC27dXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o6BixsDXkKba2+a8DGdI/HOGDAWgt8tCPh5RmM07q+oEczTVeqAiUshL8Kj0nKDbWmEjVVaCjzzDWs9XljIFNmm5qw9agwxBxBPVRk4UcFXF4+1A+/5QqTZlqt8JEq5ORd29nwTmRAZ/ux2N+jvdjPcJfNkQPQuOHK4uooozRik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NR8aqcAw; arc=fail smtp.client-ip=52.101.126.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXiUrqB+5+/Oi5rOewPfhoVKHFjQk5xukghuxbTDVc6TueZcUDnXsNd9Gj2YnqtDkUpcuPi3DKPvhCTyFH7+BXfyEvlnR060l0rRGFs8gGvzCleE9fiTSDwB57KCQjQR+uoYW2rRg/3z/QQe3u4IG1Zu00aCf9W4cCnx0+xr05J9bVMJCGQdB/fQrPOso0LDuBIitMYSYFrGJfZL6FZAQKvilW6WL97HheCRzYIw20GnrN5fs50n6dB1RJ5RXRa5pQy7XhGEWsuxYIFsLqcTHi0H+LhXNN+gQ+zUSZL35ymURi88y53mmXBtC+y6L0gRnYt+lQ247TeshPQH9bCDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIovpqM3AEHEjFxzYyuCqqxpdBSSpkDaDtkgQP1r+CU=;
 b=V/GBrGITaprj1zcoW8bPFnArHs+AITfDzwtazg5o20V/cRoxqBvgzOiAZzyRDkuMwwrCvvNGoEXZ08AtXDQZfFSZDHLcuf0iTT0PFEL46i7fIbp3dW52uD/gYKrwSTABfECYx9i1AIf3EW6m4VvDVbH3kJnv7x26xaQLsdIK4628f3AblzNYREY7nH/LplUOJfJz2wsK9lcYDNCDYQKMgLYaaB8ZO2N70FXPkHQ7GaUUq/HocsZeoV2cuD/Hb26vYODnvX/a0bSq98c3t+HhQuZaB/+tyE0SvZGrmsScmySHsGYcGM1Ua0xTUvAPVBpPRR5kE/RQ2KYEHuPggzO7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIovpqM3AEHEjFxzYyuCqqxpdBSSpkDaDtkgQP1r+CU=;
 b=NR8aqcAw+BhHo2pERZQXUyr0zO4zcttZiSYbrSr5cwn857FPHzq9N/9E+rSWHT8SkAShgnwohpRjTHWJaQJ/fXIeScJYqw//CYjkdGrLmyX3c32FbRcN0c1yKHSrx7vWA4D1hoyBqK29o5zpVChr/OgC4PX9J9lMc2fZMaPp5SLqIHFQeW9Co72a/LGDQBNbDAxV6XN/cyDfUrP9Gx4vhRyfLByzwhrd9mRMiV6YUc25PktoV1QgiNWFcYJl5AXUVt2IzM+E3lzmwcT7JM88VG3glt1yKvvCp3IbyWaLR2AK3uULecCewOvcCAwEr+GOq+x82kCf1FXnoyO0ULEkJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYPPR06MB8052.apcprd06.prod.outlook.com (2603:1096:405:31a::12)
 by SEYPR06MB5765.apcprd06.prod.outlook.com (2603:1096:101:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 06:11:39 +0000
Received: from TYPPR06MB8052.apcprd06.prod.outlook.com
 ([fe80::5cf4:4746:d56a:157c]) by TYPPR06MB8052.apcprd06.prod.outlook.com
 ([fe80::5cf4:4746:d56a:157c%6]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 06:11:39 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Markus.Elfring@web.de
Cc: kernel-janitors@vger.kernel.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Jonathan.Cameron@Huawei.com,
	u.kleine-koenig@pengutronix.de,
	angeg.delregno@collabora.com,
	krzk@kernel.org,
	a.fatoum@pengutronix.de,
	frank.li@vivo.com
Subject: Re: [PATCH v8 0/1] genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Wed, 30 Jul 2025 14:11:28 +0800
Message-Id: <20250730061128.259744-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5c0837b5-b3d3-48c2-a028-97cfcd1ec4fe@web.de>
References: <5c0837b5-b3d3-48c2-a028-97cfcd1ec4fe@web.de>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To TYPPR06MB8052.apcprd06.prod.outlook.com
 (2603:1096:405:31a::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYPPR06MB8052:EE_|SEYPR06MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b35a5d2-439e-4e7c-2c18-08ddcf2ff229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ADyKRdD8YuSS8WcC4EamMWq/ZKtM3Dgu+sZJfC/AN8kXdzGPRwHn+0a4bSyx?=
 =?us-ascii?Q?XI07sB/dFeNsl6qLKnaSggQuASzgYKSkobxuWJ51j0rXigu1asuXO4Sz9AQ9?=
 =?us-ascii?Q?WmcXxdpktyve+xkrab669BeEbtvjyMHQKdjgz/LuOelz2Lq5PyYRelIat8LH?=
 =?us-ascii?Q?Hl0nY3JkYBmg/T1Gr189DuaTZJicEN+SoOvvDqfquMBCxoF6TQ6tf3P1Rlfq?=
 =?us-ascii?Q?eekweAFrYVQP9+nmBmXiUSFiZ1qJ9bIjnx3g0Lr392Kr7tK34WgvgLX6Ohdt?=
 =?us-ascii?Q?tYav/jXliFtJKOQeFIkg50M4nOwGieXFVak2jH/7NdNsAkap0D10W8D6RZpI?=
 =?us-ascii?Q?QkjlAvGyNTbp65z+tt/nAziCQbKo8/OlY7MpyDkQTPK+gstnSPqy6c7Ipaex?=
 =?us-ascii?Q?eQ+ySDZ8NDRhS0lhI2gp6LnDxglbj73NaAFLG2sJSHq0c0D1zvx8iJlU6GpN?=
 =?us-ascii?Q?G3Ud5BMUM2OyldluuOhVfRmqZN1T07uhrRSCJ4v4zO64agcPbEkiarfv02b8?=
 =?us-ascii?Q?aMDWuonlYTyiYJvhQPijbT5D8osDl/8wNBSrmWLKr/uj2IajrgGGJGkeaiyj?=
 =?us-ascii?Q?O+lWY7XczXdSer81Bw66F4eGj2P4+GxsikeLGMVgUknDfyfjsiXm8rBkaiic?=
 =?us-ascii?Q?fhOFm8oySqU66+PBTH/cK+Bt5ykzblXfo9TiP5Zu204E+hyTTD83JLRUGGx1?=
 =?us-ascii?Q?bBPUOlr5dekqVyOC6mR43f+UsWYzcqG7aETbuvl48fCMUXxh29S9Mw6IVVWx?=
 =?us-ascii?Q?I6qe+XpS/ak/c0pJXXWo1xJaeg0OUwDGryrnAQ2BHqeKHkcPKxwH57eYd4Fw?=
 =?us-ascii?Q?sxr4tZaPcowXQV0PZvnjsq7FvATTOOXV+WoTtD0gZjlwxffDaOKbZG0XR/1C?=
 =?us-ascii?Q?XDp1SbnQcLobOiF67R4GTs5KqwlQvRjniEqzZXo59FEUmyo3StgrDbyDSPkX?=
 =?us-ascii?Q?50bXxbiIieyEm3lJYxVZG+BPd37oj5/+g6DT6Eix9YxpE411IlA3yjDOlekq?=
 =?us-ascii?Q?5gTe2K8b9ytbOVMHwr6kTI11Xm8SSSx+W+fkKJA28J6cnFw1Grbfmu/VbsUp?=
 =?us-ascii?Q?Ok/wxkVp2g9LanSV8fLnwfm43k5480D5L0hrinE+23tSfTxh39/ha/p5pwOh?=
 =?us-ascii?Q?RWRBEVGlwW/xg9EENP7ehUfvjao8oZYYjYjhWg2K8+Kw3G7S3uNO0aC5nlLP?=
 =?us-ascii?Q?Fj/cQ+hllbTD1yupubNyV0f3GcKkLSC3vhPrrc61YQ3CAUJt/Jyxwgoe6Ruc?=
 =?us-ascii?Q?Qy/kA0FvOKnDYONQsgNwLxqzlWIdvHPwAaUChxpez6ifLkY3QYJH8Bza5mkR?=
 =?us-ascii?Q?RU1JEuYKifvQEBSWyj/2TFmZP8o7hW3WE8OurKtm/EnB8mA7Os7Ng+jyk8Z9?=
 =?us-ascii?Q?cHnvS5MSHYZ4c9Qs3pfi2nEClUVRNNN92AXgFJ7VzvPQp+5oUpnjPus0tGp7?=
 =?us-ascii?Q?J+B+czkJQtf+M6isprxCTwLjrAx4ZChM435HzRQOX0ac/PvueEbSsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYPPR06MB8052.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+BLj1aeU4i/HI6GGPyW6njIcoCYWgjxOuBa86m+5wICM8JVBgjcQGyPBBZS?=
 =?us-ascii?Q?lPX/fNUXIauCte0phm0U3O8FPJT5Jj+pxQykh0LeuzqQLZ7k9hj0OFw4/AIO?=
 =?us-ascii?Q?Y2/g5Hp7y+l00TBWkY10SXBL5f8V6Q9TUsKHqaiEj0mRxkmwv0tRLnsDb5nA?=
 =?us-ascii?Q?3468TySvi6dKVGUpvHm3k0ESBB9hPG78NBaxE0dg+gU/C0jCx2HOKm/frSuH?=
 =?us-ascii?Q?QNogMumjJMZhIDZyLE/TWo1s9HA9AkPddpt4xn/9Xx0QGxMJGQ/pfZbc0+4+?=
 =?us-ascii?Q?29ZCPxwTznBmeMlnbXVbccDE1hf3UCJTFkqTDN0IXvYvj8yb4yV15nI9oqtZ?=
 =?us-ascii?Q?WqmjN4hXvJC9U6SfYkXOs8MNnG9hgR/e27tz+X7HrMN3hibAh/uQWKccVhH9?=
 =?us-ascii?Q?fFtQl7W0E3ZvMNc54byrTV13A9HiE5wMtHhl0TF+GbkEqrGW1XgnGDCX/4bV?=
 =?us-ascii?Q?ytAWNAMFVGYm6bXjuCD663QtqoYgMKlCk2QdjB64TZ4MA5ye2peWvhB2RBLV?=
 =?us-ascii?Q?ThRmAnVamwb974qqE4z5NkZMuJpkg5YBvdPBgzsFlgWxzukJA4UuGyedSGxa?=
 =?us-ascii?Q?mDh3NlHCYDDujTMHVJc5nIvzcurDpNp1vAOUmYEwHMpXocoo/EcUppNkFg2E?=
 =?us-ascii?Q?3wQ+Z6eqhG+EVVJ9+udMFI9JLzBL1/NFSUK6s48bhyW8K82+LvobP58MU1Hk?=
 =?us-ascii?Q?ejSGxeG/4JJyrt45hzMVC176g5zAvBXVt4U5ryBJ6wsJbXoa7daRMFFBiND/?=
 =?us-ascii?Q?5xSHXGfXaS3XIV2MRSoCR68QgPdGtP4cX84sMWWvXOJhQVkNFjMJPt9pPevy?=
 =?us-ascii?Q?/7UqmaTPq6gfjZf54Q48LJdgQIFCNDunrnK+kuahaFn/jgapcA1SlWy+NpVh?=
 =?us-ascii?Q?WkrR5eCJtFjktBhOL4Z3i1i4hAvMdk6FDx7A1EhenFI0i+hqlEyGL/H2Mq3o?=
 =?us-ascii?Q?W8FfLepCja+OLI711Xa7kinQB/bjn13DtFNV7WotgwAPC0q4A4yD3vCcrp+V?=
 =?us-ascii?Q?+Bi3pfSSFqztUfTh1IiOPMkrGCGmHe6dXwccfizsQjXhpLzTImKLqrQZK5YM?=
 =?us-ascii?Q?fHM0sXiMKDe6gV6ZKq9ayk8WvCvof08KH0n7CnxQo99o37ej4clR68+n+pvM?=
 =?us-ascii?Q?RxOkRmjVjMw+IW10c5tYJHgYzZiuJefM+DC3K1zk0PeZ2GOMSlDimDzZ4Qxs?=
 =?us-ascii?Q?yG527T0G9FM35G1KKjD1SqBUk9E1qtJ4RnbIGh0EkZ7W7WxJLxpDpyz5YxMq?=
 =?us-ascii?Q?Yu5yzq8A6O3a4+muFeCxqET+3UvVI9qXEFX3d6B4foM6uOVpB1qz0w7+hQzB?=
 =?us-ascii?Q?KnFDNQ3uoPMFx9kf254IYrOAkPQ5y1jExwDZT/RHxtEeRBlL1jY3VEVloi92?=
 =?us-ascii?Q?eARSANVd2WfnujRWwMCRDBY3O279qCvojUmQ145y7rVqN8I8DAzwa/1sSqwk?=
 =?us-ascii?Q?Xw7M1oZ4HFp6iEXxI6yE75ldZxlvAzG9tR+Nq/Zuiiy7M5dY9Hq4BsBWCxaC?=
 =?us-ascii?Q?r7eVV+kvC+rnuNNVVc1rxaX84XagWWFSnSYiygveU2CTwJjfhvT36n2mFm0m?=
 =?us-ascii?Q?2/kM16+o1nrwNK7VoiOtvh6+rQ7x7JoPoDU9sNu7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b35a5d2-439e-4e7c-2c18-08ddcf2ff229
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8052.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 06:11:39.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEq8qY7+pU/dMlmgMf5mnTY436NJPZ8eEFWYMffaQ/QC2njm1KItgfgXEMZeFtB10BIPIXpl5tU7tVlYNq8yTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5765

Hi, Markus
On Wed, Jul 30, 2025 at 2:35 AM, Markus Elfring wrote:
> …
>> This patch implements a standardized error reporting approach[1]:
> …
>
> Would it become helpful to move any information from the cover letter
> to the (single) patch?
> How do you think about to avoid the presentation of duplicate data?
Thank you for your suggestion.

To ensure commit message conciseness, we only describe:

    The context and problem being addressed.

    A brief summary of the solution.

Regarding duplicate error messages:

    The failure probability is low, so temporary duplication is acceptable for now.

    We will remove the random printks from the drivers, once the core change 
    has hit upstream.

Thanks,

	PanChuang


