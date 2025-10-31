Return-Path: <linux-kernel+bounces-880255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D292EC253C4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58F5735138D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7F34B687;
	Fri, 31 Oct 2025 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kVQFrRMS"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C67346FCC;
	Fri, 31 Oct 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916803; cv=fail; b=LIIdymLZFX2rVg47uPTSGUYu+n8LqwmRPPystwlKwig0MS/y8jJ0OETSQ9No+goc0Fl8mGvNghpZqd8coR5IK1KuAdru05rSQuUezJq80cJwcsPBePJwp0XGsiasgW0UNyUtF6A99tXh7YaXJ+7IFzabSHiAXM32JGAP5VaHL4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916803; c=relaxed/simple;
	bh=3ZTl0MgoauL36kNGKOxfPoHJdW2/S1Z+MyUfU0wM0+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EWgU44kJxw1U/lMd9BjwC0zhTJppFr0Dc2pNCCgvDnTzWStYadlsfetxoxYr1T5r9nWzwAVcOtPjz2pmFmMPY6v/zfoHTPbwaT10D3HyOGpxcSctpkoUiL+WuGcb5Umc6yo2h1V2o/RsGc41zgpwpiLHsxenjTVBdsctQ71J4KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kVQFrRMS; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/EGfga1lGucNBVBtHagoSUW+TE3TDNa3uH+oLrqbRs5owR6EHHBMEOK2mjbZXwWE9+x4P17QJD2zE2oQZ9He8k81W2SS+EMpIwn1RxzfnQd0KFJG4oPNyTObpYW1XPn3dNyeWBLKnZwLA1QosVD7OrCMBc6oMcA0mIGnV5rNr0KwoZU59LSzSVZXJ8bSFAHKMZNoO1Q8TEF6OCgPsQ8WEL9p/FZg18mnUTwg1EPTfkQu2UhcHFznbECO0SZ0Rbv5jabMqYfWsIkSTN6TQ4Rwb24b/WuMtEExliuZtjn2f1puR4Q5NdwxDZGtYWShfBEtOnQ2qNBRaZEzKeDN5rFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+HgrgX/d4Ls9g25gbH/5226hpXxdpea2u+fAj8lU78=;
 b=b6kJEudLg+XVQ046gzAUZ6CKdA95XXRJ1kyc5cIMMIYKdq97rO+SpaMAU2kTQLCUuiis4vy18O0pu6WlxOU1z7JgcPbIpEN6uGlAsb9WTCBhab8sSnmNhQNwn+Wl0sax5BiFj4M/FoiFOTC5OmJGsHTuvrzWQ5LV76wRl3aO0peTFhLSZbUCwt+2aeJZFL5JER7WS/lLj2yth8uElyjYFjNaVqp/URcNv1SlTFdtZxEfPvm08vVcqrPjRjY4+xxkkzLsuIwmtCii+VZeDGdbBQ8mWlILrjMv6Gz/2rfqEorZ9pdwsPVFAEE+HS6xjCLVrzwVkm9s4eqCW/YvOpTXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+HgrgX/d4Ls9g25gbH/5226hpXxdpea2u+fAj8lU78=;
 b=kVQFrRMSrfZFxGnruXvt93PiJ0TGRlk14yoCbtwWWlhOzxSuibtjWCYpusfdTkqSSytOIPswUaBdr9yu1csonLNvt0Tnv74OV39rZp3oEzG/YhKmj70rBoaQnJlkZaUD0waK3G4kF+CWRm5jGgErvQnPaa58STMNQDXOwPntoNZtv/IZ5y3sUXHLtAiu7DkJh6yFnNJV/AzTi2tMxl4RteyLB2oEpHilS2sxSs+8eV7ByqTxozgJX5h7Uouk6/9awDkDok6zI+m/HGzPShcCB1wzNG/8mHkbclhM+NxOB/mY1hM65BV6l7w81mn+OC9eFUzWsZ5YsMC6bymk7sRJTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SA1PR03MB6579.namprd03.prod.outlook.com (2603:10b6:806:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 13:19:58 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 13:19:56 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: intel: Add Agilex5 SoCFPGA 013b board
Date: Fri, 31 Oct 2025 21:17:38 +0800
Message-Id: <20251031131739.914012-2-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031131739.914012-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251031131739.914012-1-niravkumarlaxmidas.rabara@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:820:c::13) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SA1PR03MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: cda95c8e-283e-436f-bf21-08de18802f28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUPdc16M//7AJ/HNGJ1lj3ITVtGhFwzHpXqqKuSyEB8KEnIDoVo2UAVC/qA3?=
 =?us-ascii?Q?putJp2ENcS53cVWcvPHqF0YM2JnvOl2piyB7w4hDS9ymbXP2widoO170rB6D?=
 =?us-ascii?Q?oQMgHspkXMpH19nD5zojrUsXv+Mc86YSyfQZraWM968ncuRg5L3Geea6PfPR?=
 =?us-ascii?Q?ny5Vu5Av05v+J+LS1jIA8JIXcy+ELBoylk+J8oAihFXE0JvfW/hBtZ1Foz+T?=
 =?us-ascii?Q?AkklXrdcPoKuovmWWmj5osuL+UWZvyFPX1w0cki2htiRMqvY4iR5CZWcXxgy?=
 =?us-ascii?Q?wTqOSSJBmYYcuKOA8SbVGJMFHDSHWUnuy/Z4o6aFTlJUUmG1SalHq7haItQA?=
 =?us-ascii?Q?fd0kOS+jvBS0YdJAw+i50OYQBRPw1M8qRgBePOhy4KLApiL/BCBS+qjjmYTD?=
 =?us-ascii?Q?qT1+spyMo0czrTxAaSvoDJLX3AH4Y0+oD0BYOpTLHC/bHCYV/iS1Cm1dcjKy?=
 =?us-ascii?Q?iSn4lue9xZ+JKRyDyYBhukK+zY1i+U5wYL17YTONf511+i+0jGgvsmLjTMzm?=
 =?us-ascii?Q?hKXmJztKgoRDwjyHiyc0SUhEewcXyfg4QtjEPgbO0/VZOPGLnfu5m5oh6U+x?=
 =?us-ascii?Q?ZIIfu1RnJRbduB0hPK+79b30k2IBwXbz0c1vraXf7WHf0xv4AGZ2Avd3Vbdj?=
 =?us-ascii?Q?SuY53Qrp5GPWXsbQ4o2ARJfbs+okGYmIz+gRuyMffhTXtIS3cb+jSZSds9iu?=
 =?us-ascii?Q?yjeXwO4gSvgGWGRDYskvih4hP45+s7KwbtmrA+j020wY0Boyp7s4Sxywkw2w?=
 =?us-ascii?Q?/xaokPvatNJlhSxWs2Mnfjd6GusC9pVcJ3xKFl0tCY+dhK5jLZw1TIW5w582?=
 =?us-ascii?Q?yAPWUqIGPE6vbG/PU8aWzA8xlzJjO721ljqIDK22pYqqjoePNQlgFfw/EdGx?=
 =?us-ascii?Q?EtQ4nJ3nMw7BJi1ZuthLDpEn0N4IV2yoj6QmUL42qHNpYB1oR1lyqMhdcyrD?=
 =?us-ascii?Q?BRrRLsjQ/CkyZKPdQ6BHbSZluNagyH+gqkqbIynlogYckJmYOsFySqdapgUF?=
 =?us-ascii?Q?3F8hBtc9iZE+2W8dhfRULVuaKa8sH74UU3bdOLznKtA79aERQpkGeyiBpcNB?=
 =?us-ascii?Q?c/+exlJzzd6c8KnHpX/UEh8NTOxHb3gSiw+FzWCuXgyA7fVQMplWoCyfoNhx?=
 =?us-ascii?Q?38GUHHPf82fEqRndbl3WrCIGJIHlhLFjwMxKgAxzoQMnAYHvnUZx+bOBX95J?=
 =?us-ascii?Q?PsiesrZOTskhdqvF63+ufWV3Mmr2lEnei9nmksYfpI91G0Uwq++Q/YIC9BlY?=
 =?us-ascii?Q?KMPTp6mX5O5pUdJwnGQNslhdN3+UaCDrXgYh8cBfqYSGHyE3/IoPxY0uvm32?=
 =?us-ascii?Q?mpp7BGCxKByJDo4utiuRzFPwYq/UEpxURxOLoSQq3CEVUrjlgEkOBAB8uwxm?=
 =?us-ascii?Q?QeIDS2PtqWMVqe+ujJ3M3qooSvFQAP0IwSq41o0EVJHKEp+girQ0zD+GakT1?=
 =?us-ascii?Q?Xid3e4p9P59KVmDgSXq/v241H21+FveCQHSYfpLB5PjXdhFnWkfc/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?amuLgIEGpkCtTNTqlz8K6/7RYruLCGkFeUvMLdSwrANXGf2Ud+FGMXR5wCaN?=
 =?us-ascii?Q?hNexwOk2fxDnRgawpVdrnFOtgD421JuDPZfzd9747hH2yXwf6BPk12JEgs5e?=
 =?us-ascii?Q?FkgZGH9vFct1dh7PMz7Sk/IOjb9BSlUbreiLzbg2M/awV53xFVxGBzQs1CRj?=
 =?us-ascii?Q?cGtDLGNc8OstlzsgnmqO8oGNMLARVK/NCNREhQR8t/nWt9kiPj8w6SYfot7Q?=
 =?us-ascii?Q?rJ/vzU48/xUug9uonyIy7XEljRDbXHdJ5YxQpSzJxVmW0jZw6SxXhQo3nNG4?=
 =?us-ascii?Q?9mZ9wBCGGTnGLIUTPvnJ0nYOj393zmLSsBAw1yt3O8qUQ36RuSPZ00h+Kz1a?=
 =?us-ascii?Q?xTm8PFrR3iI3dZipDkrQL8tn4VUYXtexdKkCLRm80DI4QPU3PH3gaSoL3y1R?=
 =?us-ascii?Q?eTa0+HKNnO4fxeapsVai092vrN0R3BWBSF7tl3advje/gV12PujJNpBWB/ql?=
 =?us-ascii?Q?UmhhxQNwHh/NXacmidh+SqbPK0ZRcO5W7/qyTJTJV9RgfIjRAC8tAv/K0urv?=
 =?us-ascii?Q?e4Ymwv51nUVEFzDAdCyYr89/2dpz6HtImNEo/mZqEfKIMpIWF1JreI6SNsuZ?=
 =?us-ascii?Q?pAGps086WBG8C5GfdsXr8YCi985QVD28Mlb4tafephow1e6bLCtEKebUVO18?=
 =?us-ascii?Q?sNdTtbZQ6w4p6tdtwqfl1DSrAcMl3Qp7eGjW5rCKGH5LDmA8J7XXV0a/XR3W?=
 =?us-ascii?Q?Sy5JY7qaDogOYJrR+fthFapU4WwbzaKA3P1ZTCr2cL6/O3BYu1EqzfVIrIrn?=
 =?us-ascii?Q?nU74DxXn7A8vqHpYsgjxPl9IBnzYjDYzV9a65+NIvErphPwUPYh2S2PkQohX?=
 =?us-ascii?Q?2rFCpwuO43hwCnWQDzWkBx+aSG6Gfn8MhJvuUJG99JJMTbSqssghnt+TYVJm?=
 =?us-ascii?Q?QRixYxLQKWRW0YGsXNJmW4l0R5WD3NX+/SadMtGRzO2aOsQ4lZqMERBtcfiT?=
 =?us-ascii?Q?KDDK9dReUEAF0Df95SVDMdnhnv5XVbYSIRtwUB0yu+GEr8RbAwSDF3htCspv?=
 =?us-ascii?Q?v/AylPRklu3IWhv91jOjQCk+v0ThibAA2+NmoQESGi2fWDtYkvsF9150nVEP?=
 =?us-ascii?Q?cJh55MOA+EqUE2ykSyiyq5TQJASQcPKS0gjzIvOVvDKJR7l4lPmts/FnOrFS?=
 =?us-ascii?Q?unAwpeWy1lcking7LQgiFsn+Ez928lMxdgGTYyIsc/3IL4hDdU4y259EXzqU?=
 =?us-ascii?Q?Oh56ZXNnbf4/NCPE2T/WExq78vfK1orfrB+2EfEFiIp2HuJP6lbxfJhKVSb1?=
 =?us-ascii?Q?hoXSPTKx1kyrHjOhRSRjHpp8wMpo9CLU2ry952HmnWFfuL908ppHG06hlPST?=
 =?us-ascii?Q?k9sk2JHIJQqx7NFJyNEb/dyGNGUO5D54E2fwVZfrJlVyUcX2H/OLNW6As653?=
 =?us-ascii?Q?3UfLo38wK3fxM4xxxF5lPdxzFNIQUFzkPIeTuatxLm2RnFVvg1bO6nb8puEp?=
 =?us-ascii?Q?okTqxX6XdOepVaCmpeEFwavALJvKggF56DE3zd5/mBauhvJS2Ijt9p8ezkkZ?=
 =?us-ascii?Q?NwqzqSpMig4kLNRhWJ7v1BtHYL1s0oHYiBzbNWg/IB3kUZOdA91MY4H++wCO?=
 =?us-ascii?Q?FzuOlA73Pu1+f8kbk4uFUPPUINOb+2jjfB/UgXqfllSixqhSnuhrEBL+ab3Y?=
 =?us-ascii?Q?Jj5jlmn5vgHjYfM0oiCAWp3kPutQFCfIqYgZBw6a2Lmq?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda95c8e-283e-436f-bf21-08de18802f28
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:19:56.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQ8JWLm1XnsZ4dJey8axKek5xwyJpzsyKEK4hHUtDgfQm9P7gDqT2I6ZHbMR1VKAqn0t7I7yROLNUoPMvkGOzO65DkQ/5HLdrZXyXnkbeXRMHvAZvGfrIohIRFsmTJAE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6579

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add compatible for Agilex5 SoCFPGA 013b board.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
 - No change in this patch, retains Acked-by from v1 patch
https://lore.kernel.org/all/20251031103117.910187-2-niravkumarlaxmidas.rabara@altera.com/

 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index c75cd7d29f1a..cf7a91dfec8a 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -25,6 +25,7 @@ properties:
         items:
           - enum:
               - intel,socfpga-agilex5-socdk
+              - intel,socfpga-agilex5-socdk-013b
               - intel,socfpga-agilex5-socdk-nand
           - const: intel,socfpga-agilex5
 
-- 
2.25.1


