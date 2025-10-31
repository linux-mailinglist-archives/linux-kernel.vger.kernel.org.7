Return-Path: <linux-kernel+bounces-880804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0CAC269C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B13E94EA686
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7142E7BDF;
	Fri, 31 Oct 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hj8dacF4"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B9405F7;
	Fri, 31 Oct 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935804; cv=fail; b=YmhyjVB+LFjyMlfPeoTUpt618re7ru/TxHzYz76snznTLikzZHcCL5G/bnmHvQWOBu2KbyoH5rJSDOADFV/azQOY94xow1GtqaHFylUbNl85K4YtM6x+qU21ddo8YWWuqEnrOpwfA0jgufOF+5cWhgRxAU+AREhH/e9QEVkYSKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935804; c=relaxed/simple;
	bh=h8/U8VBlnKTkLUITaOJhWCxuBo01ahVJT/P+jhxASZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PJJVUaR0jvf8iPV4ptHq/sMuXZFf3Onh7Qss24i4Cr3Ffx+gVRnba9nvvV/N7qDHCFHGGVdqGa17uY0Pz4q+GdqWZgp1E+QCEMV7qWcInHYeTKDJPKWxL4FNR5BXQtEdAsxJu05ZnvwEBjuJ1Ulr7C72bXkOJMhyeMlTrnmL0Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hj8dacF4; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgpNO5hZw7p53lRtd7/XfHFkSQ6Wx+uRxsq2aXqwfQQObZIi61WeXLMLPc9Qu9W7Lck7bXRdvoDQ1252e5Qx2A7U/H0DvDe7wDgGZqNiT71SDOLtx0M2YBMS4De9tOnzp7XGRfljUN0I9Vh0/RoTIkTrRXVsoOjSemXL/pC2vxNvABD5u4iFKr6BQ+/NP/VHrCkl/zJHXr2pFMNKywxFvDiiF8ohAhg5c1xzsLDivfxpfwMColuKVZrWq2ix+Qxdj7QdxUbDqVIbOrHpffyuQxWDTQmgGr2ON/wmaPHLbJTomUYd9zXIxAi4uMG0BEsaWq7luQoqkR/3ZX/RMu/Tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK3cHY7+14v+D7nZTBRRTr35BE1w2vW5sa0bsAWAOdY=;
 b=dKn88RYOWLEiitmMrIn33mTSBEATHrepxuOFjJySQs1f1tjuWDEki1pAhpgLNv+gndEbWBhAz+K1tfF37RYCMAmnRLdjjBxP9i2QuxMtVmvsYA1cfGblVWIVB0a85LQWiAV2AYuoLBRegpRf1Jlpx5icpY7ft/J1M8dsIIqkMqldwwYhMj6XicKwdKMYE1zUU8nlx60xoORgAcivNxcrgfv3PcEoHorS8QcS+pIdYZ1/FATVDWw0z42A8IKdH4YC2j9yMoVu66bFJEkZJeZmKwBOw+/Z7I0QEFBRR+NAiJGURsc+7WGT785CXcb5hjufmTS8pJksZb2OYo8HN1kfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK3cHY7+14v+D7nZTBRRTr35BE1w2vW5sa0bsAWAOdY=;
 b=Hj8dacF4XoyWMMr45xn+F/LYswcPAIw7GSUtBK3oWY75DnhhfetTEYZKMmW80TnWgkMr5YIYuHlIfTwk7+fLf1IKo75bOwx6Xhl3dbpZvIZRyAN0UaoKyHhEit0u5Wt4rHl64tdyodZ2C6qY6Yqxhrq1QCI17r+N8Yy7Q8JZJewQnOhSMx+UHauVQ5D25OaAfVvOT/4zlN7Xesk5IDFLFVGk/QX9LWe92j8BoB8/x/VRGzDCITJ6UOgG47XCxaNnIUQHq5rjSMSGkqx3dgRnO40EB3oW3zKUjU2YVckaUCue4BVspYvVFFlKlk2Hqc7RYo3Lq1cz/BXAaaQWcTPT0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 18:36:40 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 18:36:40 +0000
Date: Fri, 31 Oct 2025 14:36:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: adrianhoyin.ng@altera.com
Cc: alexandre.belloni@bootlin.com, wsa+renesas@sang-engineering.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: i3c: snps: Add Altera Agilex5 SoC
 compatible
Message-ID: <aQUBsNyMw3G3CN0v@lizhi-Precision-Tower-5810>
References: <cover.1761901158.git.adrianhoyin.ng@altera.com>
 <c55c62f31b63a9aa821501bbf93c6b5e9fb2487b.1761901158.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55c62f31b63a9aa821501bbf93c6b5e9fb2487b.1761901158.git.adrianhoyin.ng@altera.com>
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: e4771b8d-cb87-460c-f0ee-08de18ac6e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPvML6e5KsdGdI1jbiPy2Q7dSNxfkvTnDMp0jqY+6Wm3IQu3oYoRr2dneEM9?=
 =?us-ascii?Q?CvD8D7R8Xhv2GeOjU0Gaw5VyIv0GIJ+B09fOOvr/HX/qva6oDZX3jgTpvS/h?=
 =?us-ascii?Q?9ynw0RRwpxC0wRPClAyyOQgWb0Ta13q8pt3UCqY6FjdDL+sVUFLzzocr/Xtd?=
 =?us-ascii?Q?jFlPHUrSw/PLGJ035W3Q0aKLYr7R0x7kVrjcpssU2VEm3dSThqVVD67tc59t?=
 =?us-ascii?Q?t2eH2kG0yPbiV/hWyWReuXP7xTbodm4wf2vLpXZbLvl2v9SHLa2kbsKKhIpj?=
 =?us-ascii?Q?LDXDEXdudeWsuIJtIaHIqEtoI2YTMkmD4Rdnmd+7SiNcrOeF5X0t2BNkVJrQ?=
 =?us-ascii?Q?MhAEewx2pcdZSOJMboX4/ZUHY/ECkGP6ICuRfCEY6llxZYd+v1tJxEdvWSxm?=
 =?us-ascii?Q?wO1GqaitFd9bGshQtFpfHcCgv24il/o/HqYUKbYBIu2AoNfHPdAszrWBIzbK?=
 =?us-ascii?Q?rO9NOjJi815QykFsHNEGKth2xs/LhQlzirULJp6rzCwSiQUSnBJOfQzzMg+r?=
 =?us-ascii?Q?eeh5br0aPgXUgrNoK6t4ua2XqcoaXJU/bbWgg7rKhCfeRtFGCYhusZZDi+MR?=
 =?us-ascii?Q?symCmRmxrjXhVlNoRkQH1YCyviIqKD9QYycDps5V8ehyjGXOpcethO/vBiMa?=
 =?us-ascii?Q?SyauhKzuEXezzn72OjkoG1xx6g/LzQ06Apm/egogaZydEtYYqIqthbQWA9Cl?=
 =?us-ascii?Q?Rqp1Z9X9ewsbvnaBubtsiuBfKC2DAiedcGetjPsOJ1tcDUy8ZCHkyGajD+lg?=
 =?us-ascii?Q?Ytmu0tb5pnKC1/I5OOIMuUsunXFKK5bxpEDgr1TfPYt8wAqx/WPl0719umG0?=
 =?us-ascii?Q?3f2IR0rdGyuFPrb5QxSuFT4ZTfQ+sE/JfLEKd+a1K+quRSImOiSAYJ5Kee9O?=
 =?us-ascii?Q?SAKoJXGp/6vzd2IenKqaf6VdwuxK2D1kzVyxKd0ZJL7h1Hnxl+KRjsaENJJ3?=
 =?us-ascii?Q?UAyBbDIszOXdEM0oOCufEHaFBnR1AZ9aXNe/6zK8gV694Hcsw+Q9a3gfm27V?=
 =?us-ascii?Q?xXb54asMlqN1PhB1Napz051Mipk1okHgwdV+iJb2T7OsPz+nZgoWTzF6qbUN?=
 =?us-ascii?Q?8GtjaxjGPqHr6jd4Snbbk/aIcIMcRXr2c4y3p//onDH7kfy4Oa2li89lFrp9?=
 =?us-ascii?Q?RfFqe5pXpdIcG8F4MFvhcnOvSyA/UWWMfR/4cmJymz83BJZYl7TxQ1JDQ/Mc?=
 =?us-ascii?Q?s2rYlQaAsV3uPCXX3b4TmS6v/gggK1s4FvZtGLKagAFfbwETGWQSxS4jKy9+?=
 =?us-ascii?Q?DQ10mJpcoy0FX1Ah2w5cnPmjs4mAphkwHB+TJ5c9Tg1YQcmPN5cvRW7vhjPv?=
 =?us-ascii?Q?kIvWbJW8SBjBfwcOb2s8HdG2sjN12HZRM4CNRPKslsQ2K52beswYClA/D93Z?=
 =?us-ascii?Q?W6k6S2P4pRHHkGkBaEUvVSgrI/OBkbj5BhsVlgaMTH2T9x+XKT80EErPQ3QR?=
 =?us-ascii?Q?GM3kKzdplR2fVzirZ4MNKIfQ8Tz+4OU3X9F0lwnH2F/0fvKa3QMyl9TUex2v?=
 =?us-ascii?Q?IANV0K0f0vcz5EDJj4gugh70u1e23agRWLXq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CUU+Gtc91wdruB44PToKZfc6Q+texU5IGWMeMBTu/cG7kyA9O2s5xxHQ6FQ3?=
 =?us-ascii?Q?Lk0HmnphV1AKsJCueKJgbaz7KUsvqrdjo3GqJmiCdT8h6/rAke2co3SDg0YV?=
 =?us-ascii?Q?n5CGfByZ+ZcQ/iQm3LmK7XHTCroIII7JYoWFlFetmgw9CIv/Bw/MUMbRdQe3?=
 =?us-ascii?Q?5Ywj98R83YsioWSAFdxm+A/NsKv2FTQQMbWdN9LkEn/bt2GOqIKkeWapCtYn?=
 =?us-ascii?Q?1xHyKbMr6lG/4lYRFvkLV/zRU6X5NzIPuIFIGTYQKxxwyvqmMtXp+3CKnx+E?=
 =?us-ascii?Q?H8+hVZtGw74udLA+uZWUYcCfOCqH4+w4dUjJPqX/4Gc7MEIp39k/qvr3XpMY?=
 =?us-ascii?Q?PBVRR8wh2vuIGqB7ktKA/vbj7ZQUdz5KhDxqltWsW4vdJz3Elv3rABO7QRE7?=
 =?us-ascii?Q?snp5yRL4AlTHSF7ckAaGXqa2jzwBqIcxHfl/2efXWqfHCCLEysNFqrTaO2HN?=
 =?us-ascii?Q?lrb5nVak9CJXVi9iDrQZqRjqo94SA36NBj3ycks5zUyexu36PgCBGm16NM6N?=
 =?us-ascii?Q?sq2hSZDAgIk/xautp4iwInyF8cCzf9vjheSBBYm8+wUJJ6Ix68WPHROq6o0g?=
 =?us-ascii?Q?tYx1d1nt4x/+mcDBW2JJ21/efU2ux3YbnHELLe2ziZ5iTN9hhSh4bOxy5EXK?=
 =?us-ascii?Q?kbX9e1T8QnJQ9lH9yShzbIKQiqa7ei2J9T7f+mtJrLd4SODQ/Uu+ggGCSpFA?=
 =?us-ascii?Q?j1xmykAFbc3qCjjnPIhJgHu6SEGoEQKhxHOkcsA3kl6M6EvCL8zdKHqqoGR/?=
 =?us-ascii?Q?ZLxiNcqorCPQc5GrlpLDT0m3/2TlQ14Mh83Bnp311FOzecPj9F7cToxta+d+?=
 =?us-ascii?Q?I/xLBuu3agPcQbNR9XkRe3DjS58qbNVUZjzv6SidUC1XNhio0wPBDOgmW5KV?=
 =?us-ascii?Q?8gqLspoMiORCufAXWl7zaxSfsr+1R1SKGzyBAf9jCnrAchFL/tMVCz8hE0g5?=
 =?us-ascii?Q?vkRKL7YfqUdyxMBGRpj9sh7Y+duKfP7T/ldSv69L9CEj/7s33/DH/l3Mzffa?=
 =?us-ascii?Q?tAx33ALWkIRVYM1HlZd/OJCjC6753iRioLZ0CwkrU1h4wrlV720bmt+IFz0G?=
 =?us-ascii?Q?dWQE6YeMYoUTuZdESiIlBtjgjjl0PQez9a5OvCfJUSO9u29NpGx1Wt4JAPbx?=
 =?us-ascii?Q?z4j+qubC6JhvT8K+oohi8q/W4ZxTmvfJXfky2ilHWAXTQ7VMwATpSQi5JSga?=
 =?us-ascii?Q?4VcMjk0ARVDhhnyKChyNL8mVIqDH0rpNiVkqtzu6Uwmt5IjyZTOxd6CCB2aP?=
 =?us-ascii?Q?mLm7Q+MEcEoci+PZlS74s8R19zgj5lT846NMDm/wC39qJwn3RoLiDrRx1iGh?=
 =?us-ascii?Q?kz17Brv4hVk0YT3BOv0I2+rhhKdotB+8WEvnG/y/Cao7olWyGipbe4RkTbD2?=
 =?us-ascii?Q?1G0f2iMSwh7XS9YQxfp2t5rSUS9uqKgBgwSgkppdBjCN/4YP/i08jACgOSo6?=
 =?us-ascii?Q?qW1lt9ur/cJMMIu3l7Xpa4+3Kt+4IqFAkvce4VRvzUemVRRilao4EmwWjh0F?=
 =?us-ascii?Q?hHcMHwvtyM9/hnfraanX2/DWCOml6I7MJ5Td3XWwrcSxX9CBuMhFDYI6jPuF?=
 =?us-ascii?Q?USz3b7moqXTIswt3LZLMYejfmjww/UKSjPxFb4Hg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4771b8d-cb87-460c-f0ee-08de18ac6e8a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:36:40.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjNQzYhYH8jkCwOChPbpXJh5aXwmGPKNKhrnF1tWk11qK9LVR5VlhhtEiIBCJ9QBJ6PpwmzwcI5nv0IFWy8VxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158

On Fri, Oct 31, 2025 at 05:05:56PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>
> Add the "altr,agilex5-dw-i3c-master" compatible string to the
> Synopsys DesignWare I3C master binding. This allow Agilex5 to
> use the generic DW I3C master controller while applying any
> required platform-specific quirks.
>
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../devicetree/bindings/i3c/snps,dw-i3c-master.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> index 5f6467375811..e803457d3f55 100644
> --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> @@ -14,7 +14,11 @@ allOf:
>
>  properties:
>    compatible:
> -    const: snps,dw-i3c-master-1.00a
> +    oneOf:
> +      - const: snps,dw-i3c-master-1.00a
> +      - items:
> +          - const: altr,agilex5-dw-i3c-master
> +          - const: snps,dw-i3c-master-1.00a
>
>    reg:
>      maxItems: 1
> --
> 2.49.GIT
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

