Return-Path: <linux-kernel+bounces-723987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705FAFED44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3200483736
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D052E8E0C;
	Wed,  9 Jul 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="F3A+D0Eh"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2138.outbound.protection.outlook.com [40.107.103.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AD2E7656;
	Wed,  9 Jul 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073826; cv=fail; b=j5urNiKUBQA7tcm7yql/43RrGG+E9srPWCnmNQrgv/lnMwby6tBFU9TA6Mla93euVZ5MsbTt3EwP3+1kpIG2VhjTS8Oou+9Sz8rCqlCBJQWvT1ITYkZETnTvwgDuseq8M6iuMfI66hGGyOUx6H+6oPnz9qITA80Fzf3Ahw9fVhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073826; c=relaxed/simple;
	bh=k0libBrD3eP6H848lsHwZ+NxwNLUFSVbPJNMEgcEnS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4BJmPtgcwtEBKNYyl5G/88b50AwD540sAu2VxTgos9uQAdtl9ff08xvRlZH2loZ2F/qsZu1RLJu509x82AZKi5Yi9Xmzs5NJvMKrYIMsu2cMgjqpMtA0rA/iLaakMSJFiX/BsTE9ibM6atFE/f4zaDJm3CSD9sngoAGiBXxFaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=F3A+D0Eh; arc=fail smtp.client-ip=40.107.103.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYbrG8JwtFPG95jzu6TbVixCTbFWKQnEZL5kmr9isMzenv00ISqHsDbASnV/NTRtg4jtPfEKQYKjbA+WmXZob/VXH7PFo+JJ6VkzHXEcV/S2P2et2yPTXhqf6hBWpFiMdo6NIriLwIBJ5QmlrnGuL1bxJJIWDajrSEoOTYmlhHl8+JjWHC7eAu2oOpGxnWzV2uAcpAJp4nj9P8O9DYAHH7vIwqc6OcXegTCfH+EsKJvefOSq/+iKMeE6a5f9Ovk/lYOjBUflSMEbfGiyxm/H4viXGmYQvHRi9ILrJbMTRow+gRpJHLuzi5pWXZ9VfEr5vPZj1y5rdE+HObL4nftU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfnSzLR/duxm3IUxGAlwn2fbzDVyLuSpyxsrAfEf0fo=;
 b=JAWWmjZJj74tyAjuWSYnujMA99z1FDVa0V74whBVLn9WnsLavP3S+iGhyUwyz+rg4mBtm30H3I9pXtoDNbsO9DPx2o9Q4nGnzwFlGMvxGZLZy7W5Cies/8FmHobxsv0YS8SmTWTqBnYjmLN4nCv0IqZA106YkzoTnB1oRAAV15ADSSF/Ta75KquZIh4hXxE6HX4xBMDvfL2jSCPJ2JjG8JdGRg4tFaLE61h2TKwHYwX5bBB4Wlt8lJwwRAI+/rx60ool9KuoXzd7OP1Xj/z/KFxuGTNNAIfjevJoKyf044dG3gAxjXwnmSiVOyO35SlFuhw2GqmqsUWZ+VG1JBHxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfnSzLR/duxm3IUxGAlwn2fbzDVyLuSpyxsrAfEf0fo=;
 b=F3A+D0Eho2SvDcw0G6Sfj8yFmt3g1GQvb2zIieqdFZNfWny3Gsv3gjiN3c/2jY/WOYIzzeZPU9mp18ShNiA9rc2nDZfHA1/NKvmIJiEjV7SbvLBsmENZZd9sXhFDge+uhDHIz5pcxD9RM97Be8Q4b/cGWoGf/emkbO5myLQ50pw=
Received: from DB7PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:10:52::16)
 by DB8P195MB0711.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 15:10:19 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::f0) by DB7PR02CA0003.outlook.office365.com
 (2603:10a6:10:52::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 15:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 15:10:18 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:14 +0200
Received: from Diagnostix.phytec.de (172.25.0.14) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:13 +0200
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Wed, 9 Jul 2025 17:10:13 +0200
Received: from pc.home ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025070917101370-211 ;
          Wed, 9 Jul 2025 17:10:13 +0200 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH v2 05/11] ARM: dts: stm32: phyboard-sargas: Fix uart4 and sai2 pinctrl
Date: Wed, 9 Jul 2025 17:10:05 +0200
Message-ID: <20250709151011.366537-6-c.parant@phytec.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709151011.366537-1-c.parant@phytec.fr>
References: <20250709151011.366537-1-c.parant@phytec.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2025 17:10:13,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2025 17:10:13
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DB8P195MB0711:EE_
X-MS-Office365-Filtering-Correlation-Id: d1434a7d-4694-452f-0ce8-08ddbefab7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sW4WYyx5vpKYelKZSUrY9s8FR4lswO9UyOUhAYISM9gywgd/J2JqmDW+pGu/?=
 =?us-ascii?Q?jzIFR23vHCuM7ZHW+F7G+HSBEro/6+R9kzFtKRGNmDfuqEAx4Vpadh/FgDKN?=
 =?us-ascii?Q?GZl1uRWW9n14Gkf2tA4WTFYAcCS0w4hfvFzSn9Yp570IF064cPt9tPjAdRW1?=
 =?us-ascii?Q?BTmGcxwx/1DZ1y1Sx2C4GjOd0lhahA8FPj/zElHFLx/xReNqFIfXCcM/8tfx?=
 =?us-ascii?Q?b84ov6WrBdGdF/OwiHJm06qOzD6aChpU+pR9f+Yue7/iZRZzIpdDqWIlRD2O?=
 =?us-ascii?Q?RK4mHy5gTZy+h2k+hjConqh3GKjmRTmzU2sS2+mlfkWXTpikZA7sSGkoTNkW?=
 =?us-ascii?Q?kZ0k08Oa7pFoRFXKWXuZYFkAZdIqJlr99zYeCi+JBca59c3YQC8dk+mboRMd?=
 =?us-ascii?Q?xY7wxxUOoKoB7ThwTWudQh/Mz4A9pQzBXoBoRiOo0ASwl4+gBb2hq7ljpYZ/?=
 =?us-ascii?Q?eHKJwm7yuWJBcWGaj1uNBDfQdiTR1i03dRL9rdz++a5KNxGK7P9M6oCwtxcg?=
 =?us-ascii?Q?61CREH3yf96/uoJTgx8oWuPRsobFkWzXac0XyJBAlykPUqKzsbJaM2IhDLbk?=
 =?us-ascii?Q?5ixo1VZ6xMvzutgs3mebcWjJxj4n/Tn1NSlE7ecJYmNAv9qkRLLQPAyUR2g6?=
 =?us-ascii?Q?Zm6MXWsd9I19y/xjoKA37BOeBXbVJs8+JVgecDaSy9+IVM/jaJTsjURTC7b/?=
 =?us-ascii?Q?YAj2HrUujyLidaUty/VLPPel/+mxtBP5PnPN0BXuvl3eUNE5QXF0ZPr0hbI3?=
 =?us-ascii?Q?iRcgNaWS2YKHQ2DmsT9DAqX23e4Whygg2TRCuTYu2JSFf/t6Vo9+c5fwpVo4?=
 =?us-ascii?Q?UVecEIM2SjepEKQP7lsJZbmqWdMZa8dEHT7UUYQpQiew/XJdl8ad/oYKIsSN?=
 =?us-ascii?Q?BfPw+KYigsEfF5tziXuCxeIucBZyDRo8Pfj1qbrtO1XA3ABdWDW3D6MVbLTv?=
 =?us-ascii?Q?aEAnxzLEAmXzuxJ4/LNIXmYM1ut95ivmRsy39aOtqn+TqUhVJLoZxvuKb/Yl?=
 =?us-ascii?Q?Ag5t0IRSFOSGaSyTR4WPOy6XvfvLVPdDjgKtR2ErAt3UUbRgzOCIt2lZ5f4D?=
 =?us-ascii?Q?bDiz6igao3jKlCU7fkH2lmf5GfSj0YTzYXtsYo7YhqFFlHUwTupom1JrAN8O?=
 =?us-ascii?Q?fSFwT//sZ0H7493mwzjdwykMVZrzjW5ZM/8E59TDnLWyoSsWhUmzn/vIoDZ2?=
 =?us-ascii?Q?TZYPAN6dXswC0t9X+xi71P4XA1W2F69jMeVvioiSnw7pG8Fq+k2IEPhtB5TT?=
 =?us-ascii?Q?24nXqOGST6PifiY4IW3YcuA/umCKa7ltF4h1wraPZBQJYSZWNMGg8AvSwYo3?=
 =?us-ascii?Q?lomO3HRnjHEK+MNZ+JNWM27v+qxyC+lmGEtuMRLrTqYwmnqFhV/aQ7ttTVDp?=
 =?us-ascii?Q?v3c72IqLqcmUK3xgQNlwQRpdPLyD8u0Kr1DACMn3eFKQuQsrY6AIvCMtU4+C?=
 =?us-ascii?Q?bQe+EvUc6zYVaagkatz8B67pHk+6Var8HMVoJgF4NM4RvOaJ3CR2MAaMJv0W?=
 =?us-ascii?Q?yn6bUEYLv2DbRcMtYWDRh9/s3bpOX+Fb8isM?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:10:18.9543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1434a7d-4694-452f-0ce8-08ddbefab7be
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0711

- UART4:
  "uart4=5Fpins=5Fa" pinmux option does not apply here, as PB9 should be
  used for UART4=5FTX instead of PG11 (PG11 is LCD=5FB3 on Sargas).
  Use "uart4=5Fpins=5Ff" instead.
  Also remove "pinctrl-3" which is useless (identical to "pinctrl-1").

- SAI2 A:
  "sai2a=5Fpins=5Fb" pinmux option does not apply here, as only PI6 is used
  for SAI2 A ("SAI2=5FSD=5FA"). Other pins of this group (PI7 and PD13) are
  not used for audio.
  Use "sai2a=5Fsleep=5Fpins=5Fd" instead.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi b/arch/a=
rm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
index 2fdab99fc562..44f3aa1ddebf 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
@@ -143,8 +143,8 @@ &sai2 {
 	clocks =3D <&rcc SAI2>, <&rcc PLL3=5FQ>, <&rcc PLL3=5FR>;
 	clock-names =3D "pclk", "x8k", "x11k";
 	pinctrl-names =3D "default", "sleep";
-	pinctrl-0 =3D <&sai2a=5Fpins=5Fb>, <&sai2b=5Fpins=5Fd>;
-	pinctrl-1 =3D <&sai2a=5Fsleep=5Fpins=5Fb>, <&sai2b=5Fsleep=5Fpins=5Fd>;
+	pinctrl-0 =3D <&sai2a=5Fpins=5Fd>, <&sai2b=5Fpins=5Fd>;
+	pinctrl-1 =3D <&sai2a=5Fsleep=5Fpins=5Fd>, <&sai2b=5Fsleep=5Fpins=5Fd>;
 	status =3D "okay";
 };
=20
@@ -202,10 +202,9 @@ &spi1 {
=20
 &uart4 {
 	pinctrl-names =3D "default", "sleep", "idle";
-	pinctrl-0 =3D <&uart4=5Fpins=5Fa>;
-	pinctrl-1 =3D <&uart4=5Fsleep=5Fpins=5Fa>;
-	pinctrl-2 =3D <&uart4=5Fidle=5Fpins=5Fa>;
-	pinctrl-3 =3D <&uart4=5Fpins=5Fa>;
+	pinctrl-0 =3D <&uart4=5Fpins=5Ff>;
+	pinctrl-1 =3D <&uart4=5Fsleep=5Fpins=5Ff>;
+	pinctrl-2 =3D <&uart4=5Fidle=5Fpins=5Ff>;
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status =3D "okay";
--=20
2.34.1


