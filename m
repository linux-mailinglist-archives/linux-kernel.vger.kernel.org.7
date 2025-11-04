Return-Path: <linux-kernel+bounces-885157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D25C3223C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E491420314
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030FE33769C;
	Tue,  4 Nov 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QpQIoYWm"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD3333754;
	Tue,  4 Nov 2025 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275105; cv=fail; b=mZFgTyT3Ke7MEaxHJlEKZFAbP4jxhlXDnsZVUsyTb3F7zWDw26Ai46Sm+L7aDG0bSyzt10GUzmBKoqMIC2BtftBRfFwMfDRqvIIFUF38apzOGOuWMAnra6Opjk8LLrmnwyeakKYTmj9HSy6ATv2nMZRW+Zl9l83LJXw+wazUnjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275105; c=relaxed/simple;
	bh=DRWJ5NgivOyveFyD7T0kimof3tEMw9gJKbNPOFcqOJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZmHSNRuQqXrHCfFiJXQZlqYFFFhIH5C0d2UJaq1UxzTSTNjRZtk3SSDmPBcCk7vqkWFJc5J2racPctWoV4WQZ2HpsiIVXbYV6Ps+jVmaAFzDsYgK9SqbKWNuhA1eSvSguTuBrJjGVk5tjIWtTKQF0hPchDJPyndNGQKchkKVyEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QpQIoYWm; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P01hoQ3TOL8qHPKnrxEH3ApSRKaprF6U+dM9GevITLLBAnawrcGDSGlI8q2kzBMtKo8WM+ELbMMpgdnv/VsYt/0fV1XVUCmqLcnItNG/dxuwNE/tZqjcQ2xz2nzZmu93zSu079IwX9j06iTMjXDZGEJn1xYNH0DWacyBitbQGT6RYq5Xj38LAQUu4cfFTXh0T1nFyBPchSHH7XhAah9wRwleeuf1w4EEgc6gCVAq5k3wnpDMNf7TLkjIMr6EM//V2UCgD2LcxRjLtkKz7O0XodrFPQ/GoZOE6VhZAnHE0FVCRVou/2WO24My5mP+HbPt1N8qLdyQNAz7ktqI7MrDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGdHtzXF1o8Vx6QrY7Tb+M94CeW1XUgYCxO3Y923wgc=;
 b=kfhszIdoafBqle0xT+agHgHTexdWxJadKiADWVXr9FDbLGdyM0Ywu/g7bpi6BGt12k+Rp64FObSCbO+WOD77+oDk0VDpZTMaEvRhOqXdCgt6ghaoHHAx2Ux77ZHRc9G8tUA2pPW/6FdgN/DHbTOFpmALaGvpyASMOfElIBkA1C+cBgYKzIgrAmONzy6LDc/6EBqPyxydyLpmlqX7lG58G+CL/u/JvYo0n1BLSvL8yeLmju1Y0SqGREUUGTzeVm+YTo9EqBZp9+W0mswxLBeGmmS1JefUxoW2U/ryKVwqoGeNWvRmXQTBg9viDWn4XQ9zzUDC1oqmHOQPH2lnJZzhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGdHtzXF1o8Vx6QrY7Tb+M94CeW1XUgYCxO3Y923wgc=;
 b=QpQIoYWmPfil0jBspnAyH7lmgvakpDIcPYd/fGWyPlHkz2bvK/OpqrNrM7sXZ3mI7/rh2Z7FbbODDP5nPp9T4PMlei3SqTKD4jhbMbcmUBT+6tU4xHG2qoWz3pjFglST8m9KqenJCO4c0EEaqiBBhGZz5eH3MSa193JWJPseHSl5oFd4h+/BVxtz8cDJBC8WzN90ExdL49FsZgB0bNoY3L+t4yIsUwcpRkxE5k97RFIMjbWSImZvIYKTDJL36owRoXP23m1H/ritWGWVeJPevV0JBHZ6kTEGLyVA4Uc7y9ONvcm86oK5m1Vb8d9tG44707qWFvbhpcb40k+lF+Pf2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB7188.eurprd04.prod.outlook.com (2603:10a6:208:192::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 4 Nov
 2025 16:51:38 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 16:51:38 +0000
Date: Tue, 4 Nov 2025 11:51:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guoniu Zhou <guoniu.zhou@nxp.com>
Subject: Re: [PATCH v2 3/3] media: nxp: imx8-isi: Add ISI support for i.MX95
Message-ID: <aQovEV5d6bvihzFh@lizhi-Precision-Tower-5810>
References: <20251104-isi_imx95-v2-0-c05b7cb104cd@nxp.com>
 <20251104-isi_imx95-v2-3-c05b7cb104cd@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-isi_imx95-v2-3-c05b7cb104cd@nxp.com>
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c4fae1-ea9f-4f2f-5caa-08de1bc26c0b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?6oF8PspE9RfD5tAadnS9OPH+rk0jo3qZdA6gwKqYJupmtJGby3eLzQAdjzty?=
 =?us-ascii?Q?Cq+LiRCqJl5NfiK6qEIArhomjgU3zAdlFuh4TnHjQdMzxoeZeuZKmpE5KBE8?=
 =?us-ascii?Q?jENz/ShQ9iz8NTqqiXIt3TLweyyRMT8gM6u5cu96vdwdhjIj0egMwn5ZGvE1?=
 =?us-ascii?Q?GwPqOaTaqLQOmf2TzcJoIddWfXMUCIEcILRBCinSU3yysFlFSsRAkjz3f7hG?=
 =?us-ascii?Q?Wyu2Ye/xHoBx36/mNGmBOBkQKJLz2UlK+Pp/OVfrPqUidQAe3dSWtplocwCb?=
 =?us-ascii?Q?1O03gW4YFHTpSyRH2p4IGApmtCVMBjyeMgdKFNTfodE2T+dmGc65MpMrzTs3?=
 =?us-ascii?Q?rs0/aXrJRVSg1A/OVfrSk8PsiSZGLeHagevHaKpAnQftkJew2+la3cNob2NS?=
 =?us-ascii?Q?yKvd8FXDHQ61naZxz+LMNB5nA5cDRX9ynPDUkG1TGQJwiEv3KE4hamPY1km6?=
 =?us-ascii?Q?gq2Xx96hY7p2A8FMzLlxAANymPAT8fsLXHRb115OrFu66gA68AXNnnOG1sbs?=
 =?us-ascii?Q?97qd4K3LdbCWlrKd0RmNMcxxwMrdEBeONX2IZEFG/690Ofy6nG/Ja4iy12m8?=
 =?us-ascii?Q?GLNOE81ysXxB3Im7f+kHZg8rzHVn8S0LGx1klw2vpMaf7xUhl/jESIa5C9l9?=
 =?us-ascii?Q?jB+GcJLGiM16QYNSGTza6/O0UK/wP7/FuDFMh7PEDw1nUsiu53mm0iu5pcP7?=
 =?us-ascii?Q?94NSrbmL6oUy86glf3iJu5c0KWDoivZk5212/khnRGOPjE5Jnsjyc6sEOkS/?=
 =?us-ascii?Q?AsKlMcrKM1jMspSR9hqIe2rz76rUEc7VJsAgKUUpCaWGyFSV6WrAFPelTBJF?=
 =?us-ascii?Q?tI1dkEyR/k5lWtjJxKpJxrZ4UEGEdD77dVnG9d/g3UJqqIQRO4F/YzxOTpLJ?=
 =?us-ascii?Q?P/KLrV4iY0LtB1kHR+y+GvBQkWDVaLdvHrk9NTbg8DkW9cNgQS/h7S9MVmi0?=
 =?us-ascii?Q?lqyp5/2WFdMwfOxtKAU6h6IXrwqN9wOQH5wKZTXw6uRYmkNwXCiwugA7m4eE?=
 =?us-ascii?Q?77gavK/DbMsbbLLiFOzNx7I5y7b3z8Nfyrf/1GrclJ88wbqa4ZPdYOvRrFhQ?=
 =?us-ascii?Q?STRX6OSZC99CaDke0EfUat0IQYu7L8a12MUk6FGsnlPHsTfOhli5bVI1c3IL?=
 =?us-ascii?Q?fEOYI85UeNFSc3SgX8EGAWY63jlmRUOARKnLZ4sruWtJwkthuyPO3L8dkcxm?=
 =?us-ascii?Q?vG/atoJFCpWKCkADXIkxOIWvACBJg/ITV5hcv0aWYmg1oPF9OYTSvxSy7LI8?=
 =?us-ascii?Q?6iG9uV09507yUcfdSW9aaUBWYdyrNr3pwJND4yqjQboKBi4nC9AWKrEq3pnI?=
 =?us-ascii?Q?7XYVOHfSZQnGJPsn4VNKng9/qGGc7QdB0Ci6QPze/cUg9C+DGW2OxJ8Jcc1Z?=
 =?us-ascii?Q?X2X5fXxj+uZN/9UKDHBpIXcXsn8Gg4fTFUd7fI2J3xVjCb2kSCsNqjx9aIpb?=
 =?us-ascii?Q?NBG5SjZZ9joddk1hofiZF8VoqfQCHn+zQUbEX/W+dDOZx5et9ZexxkY+OrAr?=
 =?us-ascii?Q?TWriUtknwMzsnTgr8kiJen8RHO3AyVoZWORu?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?yTEyRxIm8wk6VrwwIg/IsPJ3jjfT81ky2xORWYhFralrdtF9kojfyqNjAUIN?=
 =?us-ascii?Q?LFl8NqAJP3toUqXhyybCOA68lHs/MOw374s4DDUaRSh8sL26UJTLSKzrq7go?=
 =?us-ascii?Q?HSGPYT/5V+H5D/uRhvejA42cWILV6SVmm6LZoW1hw5ECJH34MtbGK5gFSifS?=
 =?us-ascii?Q?79EN27AQOCKFs+3LVcMX87ITeyELKmk17/feK18qjiGSdmx0nsQXGNcRtzhM?=
 =?us-ascii?Q?vhxRxFlPHDbSPY/SvrD88t2dPIgJy1wSXqzBM2fNQHnX4az0etBlYi9nLLRN?=
 =?us-ascii?Q?+HIqSyw94UfYEDj1f9RRvamWAST+hF0ZGlOPQ4uK9UdrRWPwMq9ZBF+1UXja?=
 =?us-ascii?Q?9HoF/o1ByBzhpKr1RdUpKowdSlIY6D0B9LMf+K8ESReB38yt3CfCd++0ZmUe?=
 =?us-ascii?Q?fPifvSrhGSYQTBIPuPcCfpQOzbe00EVBxVwJRYyW/LORtC/t/y7NpVfHcRAQ?=
 =?us-ascii?Q?mYv16twatYMhBhjRoK0wchILoN4xU/oDDGUL2w9NXXtAOt6v2NFWxN7D+0yH?=
 =?us-ascii?Q?NUNMOlksp3DB6RPGI7XSsWTtyi4uwqxB74zdi4Lxe5nBb+ADOxN4RO0eBfCd?=
 =?us-ascii?Q?XbJEhf3rVwSe6MCmJJPBbGGlHFEjqIU1MTNAUC67+mftbmPSN9BXGF+Fm1if?=
 =?us-ascii?Q?4Qa6EHC3623iXlUeXXEu3hkfvqQ9226/445bfs4a0ZtLrUONbOpwIOICcmz8?=
 =?us-ascii?Q?EOnrDibpy++OuGETfWKwGyjQnQJHVXNaByLTViKc39ziD/5KeFxRv7B3uZmG?=
 =?us-ascii?Q?LUIXXtyJscKViwV4sDNRunrWfTEtYc/+Iu6rKkvPK2Big4H69dJ+ctk6W8Tf?=
 =?us-ascii?Q?TvsmhOzUdaVtHBBKaqeCnT1vkonmeOyq7M6jiPO0dWJWz2CAHkjSzh/+lBSN?=
 =?us-ascii?Q?REWZfzdlPL0mMuavVpQXNFEuXiUFR/xA/1J9K4fwxZUcl11lTgmAD7iSB6hF?=
 =?us-ascii?Q?c65zP52vC8hJeKFCNMDvXX6bmeOg/JFC2PqaX5r29kKmC5GXt1Nz3SxU6ZGu?=
 =?us-ascii?Q?LmtUSkC6Q8tkMvblg5tzG27tkeuMJUrFQ47MhPz98ElY+6mJhuUYx5/w7tmW?=
 =?us-ascii?Q?F1qbcIpFc5Trx54UvtfWQOpdLLlSbQ8enLJRrrdh5YpePb6BjCxFGoLuH/ot?=
 =?us-ascii?Q?pSry64+i/2FzGQxa8ukNVl6VAZ7B3jK0sJyDrRpOYBx6L8RmvBwgLO2t3GRE?=
 =?us-ascii?Q?QEq2D03YNBVeZHsIWLcPEaIS9WT5aPSMyOvAl6p+R5ftm8liEUq1E/NTmdtJ?=
 =?us-ascii?Q?AOu6f+xR2XOm1xgeclgRai7+5S1HndNOnU//QFiBpwz1WEGVHJlyB8zC5a1J?=
 =?us-ascii?Q?XCmoJHwVMHZbdgzWUKJPXJIK/ig1mprrIEiPZdqUUFNS0M+Fe8B5UyCbGT43?=
 =?us-ascii?Q?86c/jiSFcl+TUp7yEGqGkKctYllJAYINizmp3SRbmdY7YeBLub6pNchALJBt?=
 =?us-ascii?Q?cN0ED7ySMEf2qf+2zxPQbRKscqIsyzyh07HZFV6q418P8ZPXfV2/TmPqDbQ8?=
 =?us-ascii?Q?gdRO9csivBqm+h1qyBfTsnOJd5isztDJhY24PxPzXslttE1FxXfr7ZzpmgtQ?=
 =?us-ascii?Q?jb2mcwQpI/5wqTJF2V2vY3oPJn1Mmofptse2aX0g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c4fae1-ea9f-4f2f-5caa-08de1bc26c0b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:51:38.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU4Wp54ARAL6blz4VaayNZ8vSHbp0ng4Is9Yw9J/EdlJfRPMvxnTA1hF+lbIgrtxgLeSvqcNt9stKE7NFm+23w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7188

On Tue, Nov 04, 2025 at 11:21:07AM +0800, Guoniu Zhou wrote:
> From: Guoniu Zhou <guoniu.zhou@nxp.com>
>
> The ISI module on i.MX95 supports up to eight channels and four link
> sources to obtain the image data for processing in its pipelines. It
> can process up to eight image sources at the same time.
>
> Add ISI basic functions support for i.MX95. It works well when system
> loading isn't very high, such as no ISI buffer overflow.

"It works well when system .. " is reduntant. Or "Qos optimization will
be added later for high loading case."

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 12 ++++++++++++
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> index adc8d9960bf0df87d4e475661a3439beaf5ce9f6..cf609320f19e91c9c0f57634fabd62e0ff65123b 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> @@ -337,6 +337,17 @@ static const struct mxc_isi_plat_data mxc_imx93_data = {
>  	.has_36bit_dma		= false,
>  };
>
> +static const struct mxc_isi_plat_data mxc_imx95_data = {
> +	.model			= MXC_ISI_IMX95,
> +	.num_ports		= 4,
> +	.num_channels		= 8,
> +	.reg_offset		= 0x10000,
> +	.ier_reg		= &mxc_imx8_isi_ier_v2,
> +	.set_thd		= &mxc_imx8_isi_thd_v1,
> +	.buf_active_reverse	= true,
> +	.has_36bit_dma		= true,
> +};
> +
>  static const struct mxc_isi_plat_data mxc_imx8qm_data = {
>  	.model			= MXC_ISI_IMX8QM,
>  	.num_ports		= 5,
> @@ -548,6 +559,7 @@ static const struct of_device_id mxc_isi_of_match[] = {
>  	{ .compatible = "fsl,imx8qxp-isi", .data = &mxc_imx8qxp_data },
>  	{ .compatible = "fsl,imx8ulp-isi", .data = &mxc_imx8ulp_data },
>  	{ .compatible = "fsl,imx93-isi", .data = &mxc_imx93_data },
> +	{ .compatible = "fsl,imx95-isi", .data = &mxc_imx95_data },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, mxc_isi_of_match);
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> index e84af5127e4e7938e55e31b7063bee5e2cd4cb11..e52c7fc334b0f5624ade600914c275e7539290b4 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> @@ -161,6 +161,7 @@ enum model {
>  	MXC_ISI_IMX8QXP,
>  	MXC_ISI_IMX8ULP,
>  	MXC_ISI_IMX93,
> +	MXC_ISI_IMX95,
>  };
>
>  struct mxc_isi_plat_data {
>
> --
> 2.34.1
>

