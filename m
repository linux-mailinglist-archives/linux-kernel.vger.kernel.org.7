Return-Path: <linux-kernel+bounces-873391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D69C13D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94B845625DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EAF3019B6;
	Tue, 28 Oct 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="PDoR79me"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46932FFDDE;
	Tue, 28 Oct 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643752; cv=fail; b=RlJZcnj/BBqZOKBxINMG4G1LmFx4wR8xdDgpszF83+aKj27VmlkgkO+o/ZgehTze6qD3gh75rCuWlydAkzh/TqwCa/ODTr+22JkFAzEb5sfm8kQ0ivH4U9MD1sWwIlZvQMVv/MQ6SnxBAT+hvTDSvCjf29GlWIT/BWwT4dh5oes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643752; c=relaxed/simple;
	bh=EQxvGu5VA9Y5rViuzneB+6VXAFNbXNFwzau+BJBvAwE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFiDTekYqHOL7WRbjuOr/2w1RauMkelfR0f9CcJGfkwNoN9Hi6NUwkbf+QiPZXOmf6OyLPfg0KlBnncX8MVz3JrmCivykaw8eeI92+TVWRDiLv4km8foCm8A4NwmjgVf1dg/KSx5SI7LCd6FmNWTb+Xbn3ocELcYaJIWEktTIEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PDoR79me; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtR8Nvpx/fGm18LHTKtSTMjPnTO5ZUeNQ2RnXbLX0TgLoDWryS2Yd4XyJG15eyNYmShD8W3IvH6DF4flcWpTzhgwQ345JwfU0r2tIHlr/4/aHcV8ubMO7X5fbm+onr76lfoC3atAPmcU/FQmLJCXHuG8v1Z00WPWZrWDEsU6zACvwvBo69MCtvSP8JWVW4z50+xaLhty79Rq3UOgsGWcxiXbIeFCt0lxvWgp/VdiwoZ0JLGPE457CTSjVelZQbuKNAFZGgsIHq2eT7+/0VhVtbRst8PfETZhAegnJoD2tj10yarAOMXuIzXY5cBgbkFGGF7oUgZWNCy5KeLAO/51qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQfhVphl4B76AUDf/S7MbMHaXnT5Djx4fL9eeJcFh4U=;
 b=DMdoHT27RSsVxqP409tDkpHfEvQyC9rOPULKMkGiDcF2aR8Dr4Jhb0r2fz5h0nC5JNsnetxwqu3ArV42xxh2Mvyf2dVYx4RewDg23dUJTdmqzpBeTPtB2t2L6DQOtoSzRI/l7gkHddzxTiW6gh9wj21wTD4wL/T0/3aq75qRskjrJkKc3sCfwM5fMPtmdKpMz4b1GxAL1a5hHbFA3k/wkM44rL78hYQHbVgxqpI0a8hb3P/p3wrK90OiOnl/xen/kD6xM/81ZNg7VWXohhSIeJ4xLwdw4V+WfnJ2kjha5eV2ZgiaRhJLqMrtOCjqHtn2P5FR/wZPf0w3fkxHolscpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQfhVphl4B76AUDf/S7MbMHaXnT5Djx4fL9eeJcFh4U=;
 b=PDoR79me5UvwfpxDCACCU/I35BVh8OnZ3RqElArv+rIkAmtFGQ5/uXs5qsczGXr518WkGKseWT29SthcZ8neZWiWrUNDjzVj80Bos8CivZjKJxBwU8snia+J5jX5gSNVq56wiD55nFv2erua23yvfrbPiWSQ+XlF9rozWteX01pVySWzhuNfrD9WDW2AraDaQzwTDKPE8CcCvPHDxDUXvefRT15IPwmzJqKLHuFV8dyWzqOzEc/RW8MA0uNdrtF7Qr+ZhVnkAv2VmLsqoI5zMQNLWzDgGcgJJNcbuh4sH03p0BKToOKj/KXHkB5KkN0Fjn4VV27WfQO2rB2+JCmhqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DM6PR03MB5338.namprd03.prod.outlook.com (2603:10b6:5:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:29:07 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 09:29:07 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list),
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/2] dt-bindings: firmware: Add Agilex5 SVC compatible string
Date: Tue, 28 Oct 2025 17:28:59 +0800
Message-ID: <728e10b5100e3a41d2d4595f227d26df6bdbe205.1761643239.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1761643239.git.khairul.anuar.romli@altera.com>
References: <cover.1761643239.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|DM6PR03MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aadab8d-aa31-4d25-ed05-08de1604713d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yEPuKcmUsOQFR878wuO5Sm7/ePuXgWnrp8o/hTfuUWLWESQmSOBR06iGy93Y?=
 =?us-ascii?Q?N0T56lT6n0HX1ou05FJpTKA0HOXNP65T9rXwHG5Vl/6AWbJQNibkFhGtmtVV?=
 =?us-ascii?Q?bPpDm/XXY8gymuI3of+56mvpsGYvqmb8lfMONtWqWrGdq7D09TBeNYDWbXTO?=
 =?us-ascii?Q?HmIr1NnjQI2KLDJXe0xb3ZCWA1g1vsesHetoWuPKQdOm1VWul2FJ03TR0FxV?=
 =?us-ascii?Q?83FRtcVNZdjZ2mlP/Jc21WFMPLthmW4cVAW8p+XH3GgWyl/XQKmjjsLyZuG5?=
 =?us-ascii?Q?LP0cFsOYK7H+teb/r88j+6DOuEwXzy8AMbUGRwmUnxfylrSaq4i66rN1FF+i?=
 =?us-ascii?Q?H73nmp01N0w40aG1P0w9cXeeHbbbJBN8K2lzyxA4d+J1yp/mkB68lTt7Jwz5?=
 =?us-ascii?Q?vJzBgkRtLplfdkAeIDmwgO+OGAzgY1ussw26cLz6C4Isk9/ofh7jxHzqgPwu?=
 =?us-ascii?Q?pj4W3J0VFOjt42TJ2+/Zt8CwOS3o7QdsD9d9hecTVMS0gv/1pK/l8d2zDEyl?=
 =?us-ascii?Q?FJi0TK+0EMe6dgbTeHwMkfmWVsadsptTSCEB2nPQxo6TGeC+6bH8jhE2tY4M?=
 =?us-ascii?Q?XKAUNMflvW9/Pu1WLDCpaXfEiLk8NY9w2cwb/0yBdgn+QCBH1juYfuzPgZSU?=
 =?us-ascii?Q?3GtofngrI24yNtPRJ5/ApqGI4a7VbL00Vdf4jn9JMwMMRHd/qz4FflUCLoWY?=
 =?us-ascii?Q?vPC5SfOIQ9CYUpsmgGKsKyZ8sRT3hLeGsifn3f12ls9TQFVRp35wRpc2mXdj?=
 =?us-ascii?Q?nQxq/QgQH5BzPziwRRjRgxv9HfHrUpq03mMeNYmBMd8Z+dPa5fVUBOGYsBLm?=
 =?us-ascii?Q?YqsLIlmWneUECwt3F4529RnaY3tyei0vU7Jg1y/aZV8WIMwYpjmECmIjXBFG?=
 =?us-ascii?Q?TzmztATQ99DLTzcofmH7F3kWLdiXP08PgATz1OXnLpdcIlLEbDhsWCZm1/f0?=
 =?us-ascii?Q?IgRk3lAi1FssoLRfC+ATX0SVZ2knxutrFNSRdODFneTmUjU1/9rjYDBzXt17?=
 =?us-ascii?Q?zRRNHRKLJw8OqBxYKHjs6XrY4doEUqiEzyJ/ZmVdMG2XqRs+OK5X9IK+47TS?=
 =?us-ascii?Q?QlO6x5a36xeqmCSatHJerKTaEUOR4plfAtxp+Y7QRIsVJ6eBS7FsjiCWSlDf?=
 =?us-ascii?Q?1cH6mA08DrOEFhbpfP1IDVBe/3ic7Jefd07VMhTlWkFj53/VfRiyw1j+Xn72?=
 =?us-ascii?Q?yUPou1dXD6Xs0Hb+KzCmywa7Pg0izqJYJRQbrR3Uf/sfP0TRQh9Wp99yoyIA?=
 =?us-ascii?Q?Fuv6cfKh7S1eGn8JA9zIjRiY7FY9rA9IsUzqHHw4lJsNBFtqCA1ah55ccxYm?=
 =?us-ascii?Q?fLs7ENwvwHpFsxoaqBmtPBzU4zZ4W7ZXJ0TQmS4MISgERlZvieqsztFP7sxO?=
 =?us-ascii?Q?MwxK9nIIZOe+7x2/ddNy3mBaBS/R52xe0jvZ6VBsLtAjsxUpx8uFIM+t64t0?=
 =?us-ascii?Q?hTbcxOWqP9xGjHWKde6yoYAuCes4BR4+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPDV755/KzMZX///5Fr3MaQm8TkQijecL9I33xOS5ZKPyahSrEtfxlPLVydX?=
 =?us-ascii?Q?esueGm1YNBlJuYWARpQCgJZF12ojXXUdBkJx4sCACtUx+DU3dDtx1dN/xCgx?=
 =?us-ascii?Q?31Hk1D12rH/MXSZ+TIPSKicuzBZEqgi5YhHl9SMe7EupZRWhkI9vkURXFQaI?=
 =?us-ascii?Q?ezZnhVx75OAwTJI2hhge0PWkntUNLtxsMaTC/h/N0HLenRYDFO5X7ta8ZSb5?=
 =?us-ascii?Q?RMwBLCG2V87H/1jILqRT4+0+Es39YJn+gH4iZhvCTPhQzwUzY8dHKumlLaNL?=
 =?us-ascii?Q?lzjekW86T0xDHDcSeIcAOsqRwc31ARDkUEkiU/ZdGHx2ODCkzcacyshrL0sZ?=
 =?us-ascii?Q?ZGHwTqmhOjYD8KJ431AZNXocHuTu+ej06S/79hXtaturTYlKRrPcu1f3YBOq?=
 =?us-ascii?Q?zJn2U09Chh5mDwjDeii/ELTxXns1xiG7t/dY/QihwTfltbs7xHTRj+QAxZiS?=
 =?us-ascii?Q?9SfzNuXVdL7l1LaZirxUrl2rQxhxOY2ia02UrsBxxVFdTvOp9t8k7iwLtlZi?=
 =?us-ascii?Q?QtlYJNlFNKmElMD0om1ZLjFZ9B7fH1dOb0Zic9moN5DTQtWVOSMku8HAO/gw?=
 =?us-ascii?Q?R10ZA/orGSprcU64z09vG95Zp8MwPi5+ZQKNwrEHdl8BA3hY0/o8szHiI9jS?=
 =?us-ascii?Q?T1V75F5pnJFjhv+tw334PnLLm8z/TjIF/O/7gPLnHwN6nmY7gOKa00DoAVTT?=
 =?us-ascii?Q?6RBrIT8gmW8ShIMYD3+XW5JL+G6nB07ApaZ3oOxZBawOlwllSHmYBr8EsEB1?=
 =?us-ascii?Q?1Jw6P/EQ+YK290K2ebRYJ4EhBef3Z3dw7gXCskKcajzjiH9DaA7k6uCQcwwf?=
 =?us-ascii?Q?7WwT8UJYwfMLrkYqmrEyLFlERPpXVnL3O7/0ncdfdVcwiyadXecDELsp5yU3?=
 =?us-ascii?Q?NlBghGvc+mNo4oOq/QzK4yQmo1qUOwSXF20EtabWNnQus88p8SSuQiAumUAd?=
 =?us-ascii?Q?L8giKqXrivdmLiemREEQcunOdZnVse40PQ2WSjzXFRGSoo7CGMRtEVLoEFkP?=
 =?us-ascii?Q?giMIQ50ogXuS/JWI07zQoAFN6hWGTAkKm1q08bWqPWcPTU4SW2Dshv3AOzTX?=
 =?us-ascii?Q?BbsNqxY+WQqKbEsa3RzKHMO47siq/qScI6toDU1+V5pQIWB4hU/6HgQLcHod?=
 =?us-ascii?Q?JFiH22U8zjtia3Pb5oohtupYZVd7UDQAjYrbAezG2CJAWMMiHIpEsV7ummGU?=
 =?us-ascii?Q?36PVbRNIh0JDX3rRjVOCaRKjUpd4Sf9vPzMWU8eXMVCTilJJZij1Lj/P8waj?=
 =?us-ascii?Q?YiFMRVad/n9ONgQHDS89wubtIIlCKvsS8+fKW94r9LuB0IEig9hUBF/vDrHP?=
 =?us-ascii?Q?Gb8NFxfT3o/5W3EuJndHTEJ++S+k0qq3nQvCTyqCHeM8I1UZWxXlYRAoOp1e?=
 =?us-ascii?Q?iVcljmVqEhcBHGtpIBpkd7i4bqRDH8K4zowqxLiBtrX1CgquGqt9TwcaMugg?=
 =?us-ascii?Q?PUOtgzbuzpmxSmm/A/av3kXVkBRrFEj0gue862r59VMi9ElIDOnx1WumGRr/?=
 =?us-ascii?Q?B+1IQ5f41XY3ynHjly5asQpjZn5QXHEUOCTA5R0iSYH9+3MYVQYIWPxKrwIy?=
 =?us-ascii?Q?VYuZJGFcUG62SGTsWz+meiEBqv3STqCR0Gma1OSIBoAmtzxOytA/yIfQ76h3?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aadab8d-aa31-4d25-ed05-08de1604713d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:29:07.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IV/w5B9a3jbIbhwjIW3TcqErpOK+RTZn6122ju3WcjP4XM4T6ClQ21JLsdabng5ABopw891RgwDjZ41Q6FfKG8SP9435JkvUT1X0HbfJEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5338

Enable support for the Agilex5 in Stratix10 SoC service layer (SVC) by
adding the new compatible string "intel,agilex5-svc" in the device tree
bindings.

This is needed to differentiate Agilex5 from previous SoC generations, as
Agilex5 uses a different mechanism for mapping reserved memory regions,
which rely on IOMMU support.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 .../devicetree/bindings/firmware/intel,stratix10-svc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
index fac1e955852e..90b4c00e3079 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -34,6 +34,7 @@ properties:
     enum:
       - intel,stratix10-svc
       - intel,agilex-svc
+      - intel,agilex5-svc
 
   method:
     description: |
-- 
2.43.7


