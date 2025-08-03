Return-Path: <linux-kernel+bounces-754334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B266AB192E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 08:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3770B3B6B21
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC9023E358;
	Sun,  3 Aug 2025 06:16:33 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE117EAC7
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754201792; cv=fail; b=NiroO5a4he7We55Bb47bw/TP337ypE65yi30IGThZVD/C7KQ68HHbZWA9pcPSt2+P1uPu37TrGa3NwJesdaCYQWoOLGQeuMZZH06/oz11d4k3fNyhVv6InzLVvZecCDK/WxrXVkM91t/KCtwIAM2SMk6orBVWBSUy4SlRHft6dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754201792; c=relaxed/simple;
	bh=IW+w50nwkBOSbrn0kAQmXi/qE/SOC14nPrTWkdB77A0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S6Tpj+ab5I/8KsOUGnIqGHOwKeEvZFkujTIS1hFbwUSmgIFhOrwOKuuHZqzlxhE+PAPtD0I+OfcslfQWeMlvE4G5W/I1UD2H1e/j+1KgeKhmkrTOMoAP/ZNxo5Az5j90bQk1jA7u7UdVcptDZR5iC+ne5mkr/uj/sUG14lAfguM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5736FscD3642366;
	Sat, 2 Aug 2025 23:15:54 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 489dy10jck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 23:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0A41/oiTSpayDBXzlkManml2z4BLNfI0bfPYH0AunNCi9DAGH58NAakt1zgzuwzduJNYZfzj++eAjAitP4qKOv5uN5nAuJxiK7+/9tlZT0jio+1VLI6BR0XZb7LO0i1pNnK20/cc4lKPX9v8Dv6VhL8oH4YiiG8JSnAMwj7reW2onh2ekH7E8TKkifRV9WI4r7ANfkKuLEjSlbWDGK0qCa67NJMFBI6vIYpnaeQYjeDjEXn9kESo1u1vND+BPAAamZUSwHTnIi9Z8U6Z+24mfVEZCSpD+7oHPQguSYNmFmojVyXZi5mctr8h6/zrJ4+Z7pxj2UMriI5O0tgQuxXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBOpHnUPvu1XSkJc5l7vxi1xEJZ24djbdSX+Rn/nmPo=;
 b=A3gw2LcCkECF4PLmecJ1YnZUdwtcguGXGTSRK0eD1dEvdHtAavT8p4hYFi9tsJivxLRjCO9hdmIHWKk/L6Yzragt1X/BCQeS7lFcLXUXXaG6g22O/ywWWcsAS6LJd4c42Vks45XbX7GZBEoKSML43Neq/L1Sy3PWgKstSgs5S6VytTEnZcVPLqSnWTvsgrbJlhpeQYmvSiU61kmaJ3M5FXHeCtHXPYvp3N4NMBmjleGkkJMs4W5vfc8FjM74jmUtf26JcYpOdCXBdgL8oukb90qbQsSaqkpFYICBgth1VD7GDDWJhO1jY6+OXC1iqaoemnd0KwW/O5P6Uke8LR+U6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Sun, 3 Aug
 2025 06:15:49 +0000
Received: from IA0PR11MB7792.namprd11.prod.outlook.com
 ([fe80::385b:609e:4289:5e04]) by IA0PR11MB7792.namprd11.prod.outlook.com
 ([fe80::385b:609e:4289:5e04%5]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 06:15:49 +0000
From: quanyang.wang@windriver.com
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>
Cc: Quanyang Wang <quanyang.wang@windriver.com>, linux-phy@lists.infradead.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: freescale: imx8qm-hsio: Fix a use of uninitialized mutex
Date: Sun,  3 Aug 2025 14:15:29 +0800
Message-ID: <20250803061529.2303291-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7792:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 32528e73-267f-4a13-2755-08ddd25530d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jed6ZaEmlNwioR0ijocRzh8L2dhO/jB0gsut7aQFQN2+3TuGNk08MSCUUIxH?=
 =?us-ascii?Q?scMGpU31mJ46pjWQommKkG9btznCNt+CJV6umZFmZAyyV7LeBqKMl5eJDZ+b?=
 =?us-ascii?Q?yvamxYLQkHKblOYwxKlAZYWYbMxDX72G2T1INn3DNRtnBL52qInuUt8JVsct?=
 =?us-ascii?Q?DsU1z7kwPO5MW1cS/3zoCT0a8IIAlf9mRprBO3Tw5+tw4x9YP7LvnVdp//6U?=
 =?us-ascii?Q?V9ijlosEes9ttWlAKk21oxTgjhXHaK4X3nHULHFAUIXmezQmIfpMYKsu7PH5?=
 =?us-ascii?Q?AXFGf4NPJ1UVIHGXslWIRVJInjh3EERweHCplgxvpI8jVJZLGh7odNzRz2eh?=
 =?us-ascii?Q?XCkUFSujFAglEfIzMXeQi8+hWm83vBYxHBSHrCQtT3yIxpknhXpuKnBZO8E8?=
 =?us-ascii?Q?mJ1eHb8oz83kBpyaBw8T2IpElAvGBTUD2KILfMkdd4fBxlHZcxGhd1v1+bDF?=
 =?us-ascii?Q?Z6zFD8fQ6XKuUX2PmcX70BBzs13BzwYCvf+9PKvr/TLBz1bl5Jjw3QcVbHUx?=
 =?us-ascii?Q?fa/UP+u6Coq1/XTFdY9kWWr4XcH+hDEEilfcgANyG6F62TlHxuD1I+3/ubVZ?=
 =?us-ascii?Q?6RjUtPUyUsEcKHREQ8kJ8fbNYFajnDbmh4pWeAcUCTbhJ8Vq2KAwVTTjBLeO?=
 =?us-ascii?Q?QjbL2itcSU7Y0zykaxYj7rXbBaT20OlYMI4myq5htBRvTmGT3fDMbtPfgw1Y?=
 =?us-ascii?Q?nth7p+ogflz12xvGyLciHT+T72lcXcOUAfKdGwFmkBAyWD5V1+8y1FSFsyrg?=
 =?us-ascii?Q?vi5ahQzpxc9Vl0rsFDSoGKCyaqMRvbU5KBeVCqhNU2GD4WwbexZRe6vr8gOE?=
 =?us-ascii?Q?LBfGmvOOQQSiSodpO5jIWi3V0oN+li6ni07COXtwBR++Hnndh3eRtEVGarjU?=
 =?us-ascii?Q?xyMdVCgB0qrq8uZPvc2vBYCGTR71GuTbglTNkQPZrxGb2mfFRAV9d0cJ7yf7?=
 =?us-ascii?Q?N573JMwlPEV6bNjjb2WlPaG2PiD0YmJc1V9psrQA3oRBRU4h1e9NaF0ptBPs?=
 =?us-ascii?Q?Ebexz2/JRdv05+FGTzbhWAyJKWs79JGe7QOLd3FZCZXWZS4d3W5UiJbtFnBs?=
 =?us-ascii?Q?NT7PftOTNwehPRf98mNJu9P2DGpTEncmMZ+HVLUHTlOWZARMAIwtzqydhSaw?=
 =?us-ascii?Q?0gwC1c4C6nMree3esom/wITVGQ2Fus9CajA9oUY4KoMSpQeKe8o/WpHgaAmD?=
 =?us-ascii?Q?9kwGi/aCjHGG+Q0idHaT9HDMxASl24aDKISI8rx2qK841WKdJEEPk7OoDsTG?=
 =?us-ascii?Q?jR+m4muUCrWJsgR04j1YOHv69edFucJwZJuH8fRMpPrO1EPBGxnkr9jcjEsA?=
 =?us-ascii?Q?khtlPO34AfysDf7UanDiQmOvAvh8bIf5mHzH0FXhs3ZP2pRZ074Z3DkYzEJs?=
 =?us-ascii?Q?Vth0rfPulPvrrHu3JK4vUyzo5EtIzxlQT4RfXbNcvagQVfhlU9UBPZP8M2oD?=
 =?us-ascii?Q?scAgizqKCosaM6/b+wKv+imzXrJC8pjqhaHjcbk+T92kB13zx+YSTFOuYm4U?=
 =?us-ascii?Q?9wQBo99j4q+Z8Io=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XqwCKexG52rsyrBfWDe+q1zQ0HojmGsJ/etWzaZYAGA7et5W0KuWInT1MF9?=
 =?us-ascii?Q?l/0spu2gdeoNUH1Uvfryir0OAeNy9UsMbYDmrk7yA41I9Y49ADVV6EeDF+ob?=
 =?us-ascii?Q?2E7gYND3fF3zCZS0TPTW4VZA+EMesmbsRhqaS9ITaCmJhU+2xslG7gsZbObg?=
 =?us-ascii?Q?S10Zf7iUQXFJcHZerrjebf1Q3q6ecJfnGqRY3zMzWvVwVfGp3Hex2zV04JoM?=
 =?us-ascii?Q?tFhjrzv2BcqmPdgQfn/obxShofO6A+XSR8Cf0TAdkY8B/+8Se2lBFPFmEu1X?=
 =?us-ascii?Q?PMsFt11iouuDrF9brnECQmYUBxa5daDPcC1pQrhWHNXQ3X2swM+rTb4sxXsJ?=
 =?us-ascii?Q?/oxGp9wqmigdYF6HPK4SXuaFNaSgnnbcPeBj+YWNbUQkZPhqGbL8s4VDMXX3?=
 =?us-ascii?Q?fs6dHw9mlGbIFmaEf8oxcgj3ZISPm4HwTghkvpF2R301iFasqq2OozqW28al?=
 =?us-ascii?Q?s6q5nRzEbBUXC4t2dvEG5pla7EhlyjEgqx7hWniP6gy7CwetVEiyGaMIGRYY?=
 =?us-ascii?Q?6bNnzd6qhrQ6M8WycY/kRFRR3BgcsdruiNUSgrVUroIk3kcGnQi4MHrFY1Ek?=
 =?us-ascii?Q?B/EDmtnX2kowkIUReI7IKdt5WDNH7XXkg2jzsaen33uE/24N86RfSp2j7Kr3?=
 =?us-ascii?Q?9FXiXEsR0ww+jHX96z2obwWuiA1M9t08g5bp1wU3BmzzLxmi2QUx7ObiQN0T?=
 =?us-ascii?Q?2b+kEJMH5ckfIeNPV/Jis48A3MaVZ4+moIk/nViYObB+5GRFBE7YeIuVFB6Y?=
 =?us-ascii?Q?D4fHnY3nuecqqCqazIHwRAEbsXQAsIqjaj9aaVH70DRw0XRKrRJzBq9/WQuW?=
 =?us-ascii?Q?JFg9sic+kieiXZn0or0NQdZQcWcOtGgLwLXCdb7u4Y3VR4iTnW/xELPqpR4K?=
 =?us-ascii?Q?iuq+ESQu9iN4G8QIZaeLb8+3R8cRm7MGYR5K6GfGmEUhg12pByhn8BDsugoY?=
 =?us-ascii?Q?l3FSS4Qou2rmgsMRdKvBr6Te8REu9HgGEVBOLgrJuBCBtzCH2RX1DJg9AsPp?=
 =?us-ascii?Q?u4DEC7WX8SCtLBV8A7BVECmfhqLLvAJ21WbZdbYflonWrqTs5N9b6qMpFDJn?=
 =?us-ascii?Q?EqXOx+1kdo3aQyTrBt7HjxrOuNw2MMATyubaMqxJ+u8RI2LmeruYS+r6L/3X?=
 =?us-ascii?Q?+zfkHc1FHpsT6Q2Fd7gmz4GiWklNdQWZ1gebU7UUpebMZ2hnGNA2qMO060w1?=
 =?us-ascii?Q?v+6bOvAMIUNixWUcON5k0C1U5CoPwTaqVzjxLFeRXJLoP79BPcv5ev4WaM8o?=
 =?us-ascii?Q?nIVMcWDZUc7aVcxF3scHPi6pX4vlIAnK6VkAhiFhWf/AAWQLRk+cKhSK+bOK?=
 =?us-ascii?Q?seDMD7qrwiZiuTXIIWNjXRA56Em0PnhXjrf1LL0brvo6/XQs16P33qOfpYDi?=
 =?us-ascii?Q?1UTEoUwYDwcZ4d+mmBiid1u8Jr1RWfNr6t6ENJrKN4KvQYn4VfbpoodSIMqF?=
 =?us-ascii?Q?sK0qUyscu7FoKfO6kKjytUPr2wM3j1nMUP49E9l+CTnlmcH/YRMcl4/y0wv0?=
 =?us-ascii?Q?9lUfe/CZ9ims9X2W0lZEyucY6mlfSQTjmNp0jPob6V8YOoE6dFRpJy/wEmIT?=
 =?us-ascii?Q?lcMJC0MonDWwYu+rk6hr12SBYKDh4aI2vHQk+hlkcf+G6ZomDKVkqBiaJHxh?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32528e73-267f-4a13-2755-08ddd25530d4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 06:15:49.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct+EWS/uQwnFqeaNh+lorhO07+zCtvMlIRzPkae8o95+wKqqnWncZtM6J3M/01arfUIcp8USYMsm503tgXgwCRDP0SBXNwQMHgEK+vCHmUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
X-Proofpoint-ORIG-GUID: Dz6xghd0qcxi_u3XJoXPiGjDlgcLEgJR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA0MCBTYWx0ZWRfX0KTrILCOsi4i
 z7aisPecwafYVlf0mZdy1Zn1+DUlSNSvec8u6n6/1EVKMmJPcyGpvkJAN9PecQ+JuaUYMO3CWv+
 viYj5/X/wxmIFVcp/I52oEuD/GtOiZh9FftEY/mSDzwCFcv0pAbC8MBq+enPc/duwf1Fjv12auF
 2XCDjmVG4VydEoAe/xqexkTpNB3M8PmpXmzPfMTn1ig4/unL9ApKE35nbYg0RyvTIY6KHPB4lG0
 tXXvIeS9NvEXUgmrxk/HC+hyconZ3TRLZiXw1QTBecc9IRLMkj34UvkN8Xt1fUIx/gdphO3Ez6J
 ar44SJYVqnc2d8pKqvUxQgsQZ9YjNKkXryaylfiaBqGEgjprQ13CRl6dDAHFEh59N5P6Wg7TqPk
 yJ+6dAS3
X-Proofpoint-GUID: Dz6xghd0qcxi_u3XJoXPiGjDlgcLEgJR
X-Authority-Analysis: v=2.4 cv=LtOSymdc c=1 sm=1 tr=0 ts=688efe99 cx=c_pps
 a=/81dOUaqqWO4f6DVepChjA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=t7CeM3EgAAAA:8 a=QANj-dxJC74haVyuHsoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2508020059

From: Quanyang Wang <quanyang.wang@windriver.com>

Using an uninitialized mutex leads to the following warning when
CONFIG_DEBUG_MUTEXES is enabled.

 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 2 PID: 49 at kernel/locking/mutex.c:577 __mutex_lock+0x690/0x820
 Modules linked in:
 CPU: 2 UID: 0 PID: 49 Comm: kworker/u16:2 Not tainted 6.16.0-04405-g4b290aae788e #23 PREEMPT
 Hardware name: Freescale i.MX8QM MEK (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __mutex_lock+0x690/0x820
 lr : __mutex_lock+0x690/0x820
 sp : ffff8000830b3900
 x29: ffff8000830b3960 x28: ffff80008223bac0 x27: 0000000000000000
 x26: ffff000802fc4680 x25: ffff000800019a0d x24: 0000000000000000
 x23: ffff8000806f0d6c x22: 0000000000000002 x21: 0000000000000000
 x20: ffff8000830b3930 x19: ffff000802338090 x18: fffffffffffe6138
 x17: 67657220796d6d75 x16: 6420676e69737520 x15: 0000000000000038
 x14: 0000000000000000 x13: ffff8000822636f0 x12: 000000000000044a
 x11: 000000000000016e x10: ffff8000822bd940 x9 : ffff8000822636f0
 x8 : 00000000ffffefff x7 : ffff8000822bb6f0 x6 : 000000000000016e
 x5 : 000000000000016f x4 : 40000000fffff16e x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008003b8000
 Call trace:
  __mutex_lock+0x690/0x820 (P)
  mutex_lock_nested+0x24/0x30
  imx_hsio_power_on+0x4c/0x764
  phy_power_on+0x7c/0x12c
  imx_sata_enable+0x1ec/0x488
  imx_ahci_probe+0x1a4/0x560
  platform_probe+0x5c/0x98
  really_probe+0xac/0x298
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0xd8/0x160
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x88/0xe8
  __device_attach+0xa0/0x190
  device_initial_probe+0x14/0x20
  bus_probe_device+0xac/0xb0
  deferred_probe_work_func+0x8c/0xc8
  process_one_work+0x1e4/0x440
  worker_thread+0x1b4/0x350
  kthread+0x138/0x214
  ret_from_fork+0x10/0x20

Fixes: 82c56b6dd24f ("phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---

Changes in v2:
* Use devm_mutex_init instead of mutex_init, as suggested by Frank

 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
index 5dca93cd325c8..348fefcfe7a5c 100644
--- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
@@ -534,6 +534,7 @@ static struct phy *imx_hsio_xlate(struct device *dev,
 static int imx_hsio_probe(struct platform_device *pdev)
 {
 	int i;
+	int ret;
 	void __iomem *off;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -590,6 +591,10 @@ static int imx_hsio_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, lane);
 	}
 
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize lock\n");
+
 	dev_set_drvdata(dev, priv);
 	dev_set_drvdata(&pdev->dev, priv);
 
-- 
2.43.0


