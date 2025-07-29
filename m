Return-Path: <linux-kernel+bounces-749344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C5B14D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDD4174CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BE928C5C5;
	Tue, 29 Jul 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bKjvH2c4"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012021.outbound.protection.outlook.com [52.101.126.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF3E5479B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789725; cv=fail; b=DoUsd4kTK6fpSIjfd97Nlm+/MtOsfw4nedboAdVpJuRg/+uKHsUA9KPHP0Nk20C2C6W6IsBwTJ8Sz7ZJwKoMji80k2lui3/whthswhZAsWRhBbYpCroClcpxjdTcF/N/+CI7vs9hMAa5Dr9TSypU+PZwnQe+T9d4Aiak5hzXl2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789725; c=relaxed/simple;
	bh=h/JwobVLs6JoaeTM6zYWEV66VCGJw4hg4wXoCHuWO/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hXqZ0WRYqgtu0hu+NDQX16lf5N5QxWXFz8yabaytiVHVo0q73kcwMoWaNAFgXhuYrp4Vhmak60g7c3F9WpPPINUYlu97vdjLxQHXPrAS0lo7skvEDsC6H7yWnZF8av2fO/7ZnKb1XmVVDnJkIlFmvUICpFIfkfd1WK5n0iMfLBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bKjvH2c4; arc=fail smtp.client-ip=52.101.126.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1VBgg53BVsHWpmcfa4+kcBSayGmxWfJ6Dtmd/NorDdVzKknpboUnellG6iAFvVxLXSNDcMoXWo7rujrQB2rA3vAzis7ThHETFzIMB0p7ImFyQOOTaOQKGX/KyadT85k5eJQmh7reQbH/A0ojwr+1XQC8zM3xjUCvNTdjS4h73GMtynt7ktQOx9zV0VddSXdQYO7Ecnlyk16T7uDIp0biKLkiRWGSJyvK+5r0GwEVAU1Gkf8i49muNHn4NnrYo7zOFQ3Ku1WH5HDI9UrMHDu03KqPell4n2FWlZbMFkFgHCWZu7tDxOhjurjOglnuWXZx8EqXV1Ucop0/lCn4y06pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icmIOY1Cfp7VfqVIE9E1W6ps+CMmHZXLVOZ6nkc8/ao=;
 b=DItA6zTCajiEH12ZxTbGIe4BRUpODAUWSDodLBSsZvMgdDRQPcQ1gqKky/8e44Y+eFZMm4gKjcfpnqo3j25pmeHgoND8AqFzEsaa1CpoWHUxAMX6KwvbS+sDbFAMRBoMBAMhLmLh8W7kBBAvZeGabqsRoZbk6LAoRkBxLBMxs2XeVmKykAME0Lnk0E0+QxEDPUtliBpPhPyaWP3rZOMjtTQSFDHDxHm1b9fqkJ6cauzANRh3r7m7sdbCX3fIW9F++ZwBnzBpT9o9OThJTA3zDhVKjhLUh0gE2mDX+zYixWxS51kVcMQj4pFwGaFzLHGTGhxIZKBl0SRrmzmRBd+3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icmIOY1Cfp7VfqVIE9E1W6ps+CMmHZXLVOZ6nkc8/ao=;
 b=bKjvH2c4gfOhRpJ1on44DV6hyv2IvVj2dFZELomtRuuh+NR94AYgRbd0pxjJ0wHlSNeoxqg8CzCxHKPab/4JQpDoeFlE4YslXo6VYULmGWLx85rPG/2b9AzAWmowzUmMP6BIpTzmyQqxXZ5cA1gpAka1UF3toJ57QsuU8ufaRt82zLlnw7O3yLiorlmg8JPl91CrBUQQGyxvL/o4T4s2lpPfCj+qxf06ZMaEC6nRIQzKaoVmHFBtYBSAVpH7TuS6j7cnO0yAWdQp+R6c7P7MCfxzU6nsLW3LJAKCEBicNC4CizuREDlWlmxCHleYCcmpt1XDCxDsn30ZSOCL7O7GGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by PUZPR06MB5769.apcprd06.prod.outlook.com (2603:1096:301:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 11:48:38 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:48:38 +0000
From: Pan Chuang <panchuang@vivo.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Jonathan.Cameron@Huawei.com,
	u.kleine-koenig@pengutronix.de,
	angeg.delregno@collabora.com,
	krzk@kernel.org,
	a.fatoum@pengutronix.de,
	frank.li@vivo.com,
	Pan Chuang <panchuang@vivo.com>
Subject: Re: [PATCH v8 1/1] genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Tue, 29 Jul 2025 19:48:04 +0800
Message-Id: <20250729114804.21984-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87qzxzjr3l.ffs@tglx>
References: <87qzxzjr3l.ffs@tglx>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To SEYPR06MB8068.apcprd06.prod.outlook.com
 (2603:1096:101:2d4::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB8068:EE_|PUZPR06MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: efb59da1-7989-4322-bd0e-08ddce95db72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wzwpU+OQzMODYg5TgOr1pw123v4y6s9lpScSoigBLaL8y88lpJtzEa40b5ao?=
 =?us-ascii?Q?TZAy03Pn4eOoQ0BEyT4W4g/P+JvFAuSvUHIsyReu2aFf8HhBky59JTC35Aa2?=
 =?us-ascii?Q?hwAzzsN8RfIXa3Md/v7+N+95Lfus2fhCQvA2KN31cEgUTkgDZoCvQEzZPmiF?=
 =?us-ascii?Q?F76+pJbyyQ+2T+hIpcSRP9dnusaICDGbXSs0bilydnPCt3gIl9pfI4GYssYU?=
 =?us-ascii?Q?0W3Q3k0WI7vB3lyiXQTERFA7UewV4B7gZRAN/xoNNtnO53i7367M498G4f2/?=
 =?us-ascii?Q?ohc0eFcz7ASmJS3nQ2Jn44+AZSUXpDMVF/o2yKEfCGJUCoe+cUgbvnViWXGv?=
 =?us-ascii?Q?Sfwc+bLElDsAM5JNMizrNTh0HN46My/BtEK8x594UEu//YIZ0knVaPxpwIJ5?=
 =?us-ascii?Q?KkKech8MrTUaLv1OSKqbXlxw8bvCt/A6Lcnaj5afmbSMfAI9Dbufp2Wq/pUt?=
 =?us-ascii?Q?YhaJc6oAg3ZzcHY7yt1cQr2lGC49I7FKx2vGYQ4TFA7zkOFwpKbTn2+sUZXZ?=
 =?us-ascii?Q?Q+d9NnNI0ZHuWVEizwziRtT3BeeTJwdUz6hUWOEu9WAtjoDMcxJj86gGD611?=
 =?us-ascii?Q?WMl9SDiGLOdoE9OqV/8kEX487tlxlSdPk5Sp7nCvFn3Vy676/BQejcbeLqhb?=
 =?us-ascii?Q?/audR6p/egShg9CYtrfPh/m59oc+mPM0RnAgnUIulbhknKzoKjDIM21ezmfN?=
 =?us-ascii?Q?Ioul+qJJ1n8AiTl73qstMruXscGKG4gOSapBHG/paQe2GId8gkbraljrcSK9?=
 =?us-ascii?Q?p1My+8IhMb4HB9alPabSl2GcPW1Rj7FhGSU10VAetmo9fpWg3bD4GzPqFrBc?=
 =?us-ascii?Q?lSHfm8gGyCSJH6Az7lLWu43RWgKdEjXcWHu7HicqFs+fYkguUaCTyGFpIKhq?=
 =?us-ascii?Q?O0TGc74Man5XLektemmd2npBbcv7wUA3p+KeY/bd7mwZ1awaNgnTy1+8qS8L?=
 =?us-ascii?Q?pIiBPXOoyKBAlfVzE7xn6NOgkML3zKdiKIWZvshLpCzVQek5NA3zWJFpKXxS?=
 =?us-ascii?Q?HkQ0N91mHaqwDOn3rpoA8g83GaOTs6K6nTUQ289Xj+uFu56HmfwdbAPgSW2/?=
 =?us-ascii?Q?c24/TTQ2Agm5oUzJGnbljmNzncpBAJpi7zFKwLfHWEyUIEzVXy4a9+rfkafh?=
 =?us-ascii?Q?zc6NfsKgp2DKdDB9RtpN7UTmqYvcyuz21gPBTYMAlaaRzkwi3YSYKzLMGBN5?=
 =?us-ascii?Q?JulHuE+f40chxhe6z4wjYKxnHdBm3xKlPqqEtF4xd6fbxv9EsU/JvfHl4hkL?=
 =?us-ascii?Q?Q1Mv76mOxRDnuy6F3d7EM7wGAM0eCuKjv8PZIMd707D9jqpMewgK7cxC0Uzh?=
 =?us-ascii?Q?kx9WlRIDznZkLirJ5QWASO/UKwlzHZMuvPJDAc0zV55THY0Y6QXUY1VML600?=
 =?us-ascii?Q?JIs5NI3Ur3TBuBusgU3V4eyIM/4oRF+rE3+TrXFYP/h9gdasYSKmNspQu0Ie?=
 =?us-ascii?Q?5U09KkLYm27dYLKIlaQ2zAtfYOogw2hqQsAEoYXdyIP3p9oBTjRQHZV0oF/r?=
 =?us-ascii?Q?NqqaP/RcIQOhyR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YqtxaCnODzcErnZKFF9ahQfbvu+qW1aQnRGC8ymh0pP5Bi/NKfH1hxYDHZNq?=
 =?us-ascii?Q?+c16eJ/LScPVxzrbkw+QSW3tORrD+LNXZKW+vhByxjKWhzecFIptwp9pSl2p?=
 =?us-ascii?Q?I5az/Au+rauMEMXkKeh6glNy+Taoutm1DozwLGnl4qpqRMcThdnIog+Xw5Hs?=
 =?us-ascii?Q?H9dJpjjxWFT94ZxHoORCvH/7R8u96jpNDodSx0BA9vcOt2lw5e33TVeIAUiT?=
 =?us-ascii?Q?IzQnXDO/wp+Z3Eg1C35qb70pcaZeDCk2aNIoRPG4L1GLCs6WJhpY11Mn5J3G?=
 =?us-ascii?Q?dzRZMXAt7DF/y6MFI46P/Z7BDq343wHvzdJubVi2KHXn9uBALEZ1F6WfQ3+U?=
 =?us-ascii?Q?b3iJ9Rasn8ZF2lu7K9GjMSI+0tTNxNEvTMMlbQuZrwCn0MJtr4TXSkEb7kDy?=
 =?us-ascii?Q?yXpiqjNF7/meY2xqvrRjWv2UNqM2Y524oIMpYkPF3wGIAPH+wyJTXRAzwxRj?=
 =?us-ascii?Q?pREA8nDEWhNAY36f3kytEPzT18zEYvsgz845aE3qObt8SrsXYVRm4vjYAmGY?=
 =?us-ascii?Q?e7E/Y1Afy8+slRZdmEbw0rB4g8Z8TnWdu38hubns0+tkuZVKbof3ZsygiomW?=
 =?us-ascii?Q?ySJOAJn71KIa1l/k51K8NoiA/JANJwMrQVi3rs3QJ9Noy1qzuH/N2ZPehzjM?=
 =?us-ascii?Q?5ikcU5zlz1VyCMt+eM9MFh2d24WP63LB+X2TL8kq44+4tD/Xp2w/Z1hk/3UX?=
 =?us-ascii?Q?F/r4P3D1DdLchgmPwoqI2CF6MZQeDXn+AdHBEQE5xi+XzjK71udBIqYCCjef?=
 =?us-ascii?Q?od6xM1gvpSpLRPA0a1VTdYzVZcxEDqgdCn7y276Mv+zr/BS+o9HbyMyZK2kN?=
 =?us-ascii?Q?Nt/kLRAraAaK/QmWYJS3H2aeqKiwSw/3qKAVgQ9pwQMPGdcf8Ce2FpG5xooW?=
 =?us-ascii?Q?/+KLB0Gn8TPeyHpslpDFlqIOjYEtRACuUwRtTxFJOi5EFaGTWmPzHMcnGxIh?=
 =?us-ascii?Q?ZYbJL29dQT4s9lA1Jkzv09Spc+iGMyHMfcuKnq/jBor6gMEkpdHrUFELDgiB?=
 =?us-ascii?Q?5v/0t2T1K1MkcG34d8T3+ExN1LWbjNodA8wPI0uDaM8b9rbO45t+xNy77mpE?=
 =?us-ascii?Q?+mKfiObLhC3h/l6WH8za0HHRvygU8OVSPrjLibvMWUcjbJunKIgUON+H9X0X?=
 =?us-ascii?Q?jqEeqTW/JM3euhMxDBSNLcD14Egu8h0OYTYWsn47nQTffmtT1L8TOdfkw/BC?=
 =?us-ascii?Q?anJF0yelj0mmxg0enxrKCirJwPlHYnRd2LCxrshakg4223l/b1Wz8ZiilXeo?=
 =?us-ascii?Q?3+T/DIdoNoMZ6hOopalm9U3QLAG10uZrSlFpdTFa+vQz9vYqsIctShJ9aYyV?=
 =?us-ascii?Q?ZxmoZd89lW6HQfe4th5QP+m5mSgeHq8FE5MmUw+8ahHRd4d6+XDERRNGfwNy?=
 =?us-ascii?Q?co8OzfMeukxo4uwcLBYdAnc+TajS9c9RXRTl5F2pOLh2768d6/ssI5hEiobP?=
 =?us-ascii?Q?GX4gp8rZoyRXDEjpMNrVswoOR0vZn1A4k4XJ2Gv6iK84aXep7IatHZReDUY5?=
 =?us-ascii?Q?ihadEka4LzIdEjoORPo+f/3Hy+mKNm7tIkUihx2BH7zrtrgyHM9mZBmdiA74?=
 =?us-ascii?Q?QNXU8Y27RtDTHthsiJEDKxAC+Q81X/+31DE0vjGM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb59da1-7989-4322-bd0e-08ddce95db72
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:48:38.6466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPtL+VRvNqQexHTkpPa7RcbXNXS8QiCoEcl2I73tWGB0rZZgJ2KpCnpcm1zBgzbKvHwu/sCNcZrAMuxEvvFkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5769

Hi tglx,

On Tue, Jul 29 2025 at 17:14, Thomas Gleixner wrote:
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> This SOB chain is still incorrect. Again:
>
>   https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>
> If anything is unclear, then please ask.

Could you please advise if this SOB chain is correct:

Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>

Thank you for your time and guidance.

Thanks,

    PanChuang

