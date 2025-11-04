Return-Path: <linux-kernel+bounces-884411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D34C30200
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708881884C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38C31352E;
	Tue,  4 Nov 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TAAbBf0A"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF43148B2;
	Tue,  4 Nov 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246417; cv=fail; b=V5Z1upZBWC6TA2JR8TLhyAJZKIJamH2Ec96FCThk7kiCiqwRo+5AGFYyNq2GMhqrZ6SPAR+rGLWDogd4CkpZRS8j3s6O2BDSgPbLKw+vW3qzKP1Fc1eVjzwv2jUipKgtCUpkTSPh9iSVteEHNOXFDy+5mnPYnanPIqTJ5Hdv6pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246417; c=relaxed/simple;
	bh=S9yciAdRPhirJD3b7jeA5or33H4JvX9M/l9f+z383c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYDNlEJENiLExP/Bss79n9ud0GjHnqU61Xb94WvpEWwsvXsE8woo3hU558SKiYFXlNdYfkI/tOPlShSVKYcu5GUFvlULaEMEJ1hYMSFpCKRbjjC1EP37BF5Zr92ygOo0Ttga5n4iln0ILwzFV46Q5fSYfaqA3yUUbH5f32D+KOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TAAbBf0A; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5SPKSYKKoNcRnYNaWr2UgtBO+OD7OGYvxF77XY0zvAAb0zV5PdpuzKHVOSV0P/bXmRRD6qukNoVXtzisneNe+s4Yy7NxbtJUhs8lQRUHFJFsuBIN8duw3JBOddvqO6ugqv991bFSUxBYNQ9EyLHhObNmCYpHGVYCs/XAON6RWGQ+f+8XQ+5yLEqi7TvVLs5Cvn7OMHLmT8PKoavmx5ppNTBGNnbRvAfPHsX9K6AjfaCGMrVgfwbsETWbTi1RC/Hq9GsRjw3/9N4n7RFjPmUq5Br20k+cChpV0tH6vrVOkDeJ0HPTY2iNlcOkAPoy/0bU7j2GdQHWZQ0+AxXVyOyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbeHsyG4iiHUM7jydHk7u5IJ0GT0S1na5srtnjWfqUc=;
 b=Lv99RWiIvisP+ijBpxifDQYciZSb1ckJVEZ5ANdPjrsVjz5o4ZY4n4zZNRJ3KOA6gjWqCrT8LPN6iiec5s3Fqex2xrxnuf2EXmFY5Zmkg0UNgpPIQ/qelLjXELTk58QKgdbICQE4yfSywJCOqUQVxjYgPlma0C/K4TkwgCdfiiesgVFYh1ObVllM0PuDgOscNvwiR+OcPVljwNirtkhien2j/ICctbrr4vbW7W2RIcBLzDNxtNWhNLNzDdOggTLigd5EC+wbm1FoM+feSraMYLKXwD1qwpLd18FYXzqd2vDdZ/BvFES3wdZQFPDevdgE8YuntaxJA/lTorscP9k64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbeHsyG4iiHUM7jydHk7u5IJ0GT0S1na5srtnjWfqUc=;
 b=TAAbBf0AtBVjghzWeKMWSSP15Un1DeFpAabqhIjjmCwlOwJ30LOSytOVrwd0Ej9ewRxGW0w+HGOmHhsZEx5nVXGhxehDI2UxTOonwfaDh2s1wep6YStVEKureseu21bVln/K/RMsFp/7XCspL3wm0WQG3UcljBL1gz4YH71K6bs0JQ6nQaaak7EfZOu+KHGWu2R0aS/XB+MjXsk7dBiwKf+tsEPam89K64VruG+52BJSXchiDgzGHYBH3wfpqM4aOyUH2LSorbMTYb47aJkD0J95fp8vL1FKRI3ipJEslf874JzQl1BqUB3QzrVI+sUlg9NPo1DHnbRBB66Y3FAhcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5164.namprd03.prod.outlook.com (2603:10b6:5:247::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 08:53:34 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 08:53:34 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 1/4] dt-bindings: i3c: Add snps,dev-nack-retry-cnt property to Synopsys I3C master
Date: Tue,  4 Nov 2025 16:51:08 +0800
Message-ID: <9c16c22f67858e24fe7c3a7184537cb5c2c1a85c.1762245890.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762245890.git.adrianhoyin.ng@altera.com>
References: <cover.1762245890.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:d10:24::8) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: cad22765-acff-4bcd-da2b-08de1b7fa2ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eliQYAZBN/NTkhjhJqOXhFFK54OMEu7zL6uuY5WmX4J3izVFeqzfExBUol7z?=
 =?us-ascii?Q?zHCM0sQbcbNr/+pPRoIqYrYJ7Jcm1RdfjdDmrwaG3tquTSm3N2hNUvmAKWy5?=
 =?us-ascii?Q?0wS0vY91OwTjt4ZEnKzTZputHMYzEP5yxlxpOQkNwALw8/sCY8YvGlXQNscs?=
 =?us-ascii?Q?mWIjiX7aHAL1duvclYoOGQuuiWRGbda0o/RnMJnPZ/CmjTfgQfj3UKnuQ9Rk?=
 =?us-ascii?Q?ymVtJ9uku5MgbLiLK5tqGNcG8ZnR+OOx8Yb9beLqx0kl7NwN2UU/gabIj54i?=
 =?us-ascii?Q?bjtKC7jlFH6zsD3bIjJOe0z6DatbaRYuR71fvrQRRBzcCGvr2HN4wl8B+ISv?=
 =?us-ascii?Q?nl2oU83/T1J0aDtbimZ01BCsUB9VRH/pE55CSAloj/3e+riyXOGmre9GfdHT?=
 =?us-ascii?Q?+TVvWdEGy0zI6HHCc555tklDDfUMR0a/MqtUJAxfPsv+z9bDeHxNGxJraxM1?=
 =?us-ascii?Q?MkjUQy+24IuKOneJRLS3Wb8lH/g6FVsPwPnsVVpR1qDyhqJGvS9p/PwML8GJ?=
 =?us-ascii?Q?MpneRRlbjNe3EshdsFjWeg1s4bknHkcsFT5XRLPygxcHncZ8sJwJLjaXVDTe?=
 =?us-ascii?Q?EQW/hyNJ3Peq923XnohCJbDTDGY034C8+1CaeO4APEsf5T/YNFNgZ2NM3Ylc?=
 =?us-ascii?Q?p8G23RQEJDt3mZAQByV4hnKNKtnIaZS7rKQ6qboCLfk2AFpTdBhFbJwBIem2?=
 =?us-ascii?Q?/2tIfTcXyMlJfVetvm/2euaUaxFl2scjLylVOvSAnQdeMzdjhMRultsA8XaM?=
 =?us-ascii?Q?qM3yl3WFS7XIzn3D06SF63lzbEuH1d/yJG4tIbyVMi/QvJ1RHfni/BqdfYkV?=
 =?us-ascii?Q?wzAb3saWN++EaHwiyWMSejGIyaVawiFschQngpEe85U5He4FXJXgbaQOwAC5?=
 =?us-ascii?Q?09dt6PB2dutDXi4i0BJypQkExRudYdWydiQgYgQ+FtAy+fLHw78UY+wWBe8M?=
 =?us-ascii?Q?kcKBNcbrf3cbw2ze4H9TPL/oNLk2qvgo2+Y4E9nXMzO7JD5ki9hynM/QjMlO?=
 =?us-ascii?Q?znj9gDF6CzNyLWb9QPsZz+PBr02vqh7IkOWGdRIGTwAlmzRZwEqYThHgBgtv?=
 =?us-ascii?Q?x2yHMu/wM/Uajjrujy5ePGKr34er/U/Bzf8KZoVCFLPlq+YOZgRgdhoRKXIS?=
 =?us-ascii?Q?04W+1fVoaQG81WLQAIUqa289ohqNkiwv8RFLLVBWdqGpyzSanDnNPnktt4bQ?=
 =?us-ascii?Q?sDTFOhRSScC47mQ2fpolI0x0dVXAzh8Qx26gVxpM2MqdlVwFDCKVFbDJZ0sZ?=
 =?us-ascii?Q?Xc/s76RXHNb12f4ddFP8z/ClTG/EhTEJlWUhhmHzsGO/xMWaIpf2u5jjQV36?=
 =?us-ascii?Q?4hzOkziu6RZsO8CaiUwt7wXjPpFatp8PsUX3/67DlyLXay56oGZ4H/oofMK+?=
 =?us-ascii?Q?AwimbNFhe0VSWIdyuM56Xl4ppVob2HyqKM0F2FlDa7ZDcoLw2d5ZKwga5GpY?=
 =?us-ascii?Q?Z2cTT5O73fsPyzSzHYkE53nGuPdwrrtcEvzWdWLz6Jmw6gT7iM8RN2CYgCaC?=
 =?us-ascii?Q?IyXQEAvveI7EGUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XLiQ1etoEotLyGLwFquQKH5Ux3QcTcONPG5nwu80Y+AIgtLjXgM2McKNVN3J?=
 =?us-ascii?Q?xCQXicOHVNvAXhG/DL5u1YzDncULxJzdzXnfoCO8WXbKEautJHEgScvQM0xp?=
 =?us-ascii?Q?/013sgs1uAp/0F1OiYTdzjuidxhHF5RKkwTexNAhWEAMvrsB5/FSxSvH/r2y?=
 =?us-ascii?Q?49t/DGppi/ipko9NLhym5/lgh5biuts51/R5XF5lfxs7FY+DGj7wwFqRymZ6?=
 =?us-ascii?Q?B1XhByGvtuQxLtQWjiuoXwvRSlIyyjDX6ApRsQwvuW0WOzf+441MJ/EanzxS?=
 =?us-ascii?Q?bSkPc9BQwOQp9bIL0D1/LOyF9x0oUDNLeE8Imrb0sHyVZ1AbA8NhWeeuJ0zb?=
 =?us-ascii?Q?+6sXINMCxj0Ix5TjI+Vb1h+SDk5xFG1qjGyeF5Jxu0bnJInIsbhzg3kkOVZh?=
 =?us-ascii?Q?TUD6oxJB2p1iJMtrjHr9oVYcvGW2/HUUZ7r0DWI+mcnBymHeKSUKVFNmV862?=
 =?us-ascii?Q?ovPUDpPXgZWnHLECLRcpEGl7Ecbl6KB8t5EC4ZWVhbqPYVmT2ZBYEVPDVUIe?=
 =?us-ascii?Q?q/+DBzuSzIZMF+Jh8DGtPTWGZeMSsgw0OzsR+FTN1f1bQgcB0Qt3vhWnU45b?=
 =?us-ascii?Q?BZZMTMa0noPTDtA0s2W9sFk1XU4ZfmiwBMZ3oVqfB6ZA6SEPkDfdFcPFTiiS?=
 =?us-ascii?Q?u2yX3UdME5oVrHE2zNteXhoto2ZNN8aaJuMDIYzBA5QgxBPb/g4Ll5ZsYDiP?=
 =?us-ascii?Q?9wAGhK6i1TIgy8FkZxkEN+OMuLMaSiwIy7vUYbo3EuW8JyOyo6+1u+VT4nWq?=
 =?us-ascii?Q?BTYLWPh+4JMH8p7kRiqev7LqdE/XG3WVRxca1o+Cyev341pLKJX9dsH8zVjW?=
 =?us-ascii?Q?WrmiJGypTKmwXeizXKmmmE69PgNpREnKRuEpcyraUQtsct1YVpYl9EwPBRS4?=
 =?us-ascii?Q?ubFF6Ps5M1q01yZhZrDjWYHYXIidA9GsdcWYdaIqo6lTGaqQ/lWyqzGRHjGS?=
 =?us-ascii?Q?UW9zXtISalFS/nVTzctbapTdrs9Mm5/7nPtjCv43ARMtPuW6wGyuD2gE7S32?=
 =?us-ascii?Q?BN0LHcMpFElGyTwa1bwwoBpkXaTFXIUaKvZVH5OYJR740Eyblk4m7H23rHTK?=
 =?us-ascii?Q?UFGoSR7YvSLv7I+8PmrQQJYJE7HWfZJ72VeOiFJlc/FEHHzXVeWd3SIcC6QW?=
 =?us-ascii?Q?feDSd82BGt0FUOuNeKHXNSO7m8VtJhE3XARElUC3UKEkXPhOAK7fm1xazB+p?=
 =?us-ascii?Q?4UBJL0ta16iseB3p4cB59EwtWpw/yZI+uo0GaEsjJnpCfVhUOBkd3zE/nyP5?=
 =?us-ascii?Q?ES1IPVbpICNG2z77fxktTp1L/ZoYhoQxCM8G68o7hgpBAaAHi9a91cOH7dTp?=
 =?us-ascii?Q?39E5cFxMuqEoX3fyCmehoURClV5jvCJwcqqUChzi9u228To31y+pDFj3MEXf?=
 =?us-ascii?Q?0w/Cz8IP8Tcry1KqEY73Ql+irFAA0FW+gNDymxfHA2sDiWQqr2OO9Aa/M813?=
 =?us-ascii?Q?AQr7bcbyUL7lzaqOAoZMGGh50yIpGYhIee8UpmQ1B9gsv0YQG4OzmPi4VHWF?=
 =?us-ascii?Q?U3H8pWNcPhM1EssCOPdM/Y9TiBMJ691pS4VE4hkPBdrIsEMa5URuYIWgq8av?=
 =?us-ascii?Q?T3zZ69mH7RnMNxQ/2pR5ZSd1yjuKx3Bqdgc8n76GT+iXf8tmehsE5JQlEBcB?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad22765-acff-4bcd-da2b-08de1b7fa2ac
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:53:34.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8lc2fo0tEf6q7AKRdOOPIulgWAA2DyKYBCBDsx9a529Gvsh2nFma9VJ8QB2U+1okih9kh7ZQ/LXem2bAbNclDNGQNjGZrXoJbuGJV3Pqyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5164

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add a new optional property 'snps,dev-nack-retry-cnt' to the Synopsys
DesignWare I3C master device tree binding. This property allows
configuration of the Device NACK Retry count, which determines how many
times the controller retries a transaction when a slave device responds
with NACK.

Valid values range from 0 to 3, with a default of 0

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 .../devicetree/bindings/i3c/snps,dw-i3c-master.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index 5f6467375811..c233be2d4a3c 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -37,6 +37,14 @@ properties:
   power-domains:
     maxItems: 1
 
+  snps,dev-nack-retry-cnt:
+    description: |
+      This field is used to set the Device NACK Retry count for the
+      particular slave device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    maximum: 3
+
 required:
   - compatible
   - reg
-- 
2.49.GIT


