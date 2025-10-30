Return-Path: <linux-kernel+bounces-878093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E6C1FC30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2156242706F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8663557FA;
	Thu, 30 Oct 2025 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Fnu9KAUy";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="C3qRn9d0"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744C3557F5;
	Thu, 30 Oct 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822770; cv=fail; b=oWdqsVEf+KVcxO5q41gdA8TAqU32BoPZIazeyCzAT28mDEHw88v0MBS3b6u2UtqyqGh/d7IH+MPnyroKd3mQeK4kxlp7OXJoeqQ7nsNa62ZAyEFLmDB5f1dTkUNbDNNqgxgMYCb3nTlaEOb/EDkuhJhrDq/M3uX+yf0TY6xubCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822770; c=relaxed/simple;
	bh=D+fBRyjDz42De07gREPdKrXJ6qL0sLGLnbiBdG1Z9Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fARfpY+DjKraRQ472m8QVDRR5u9bDrIiOaRbwb7wsCV6ee+Ml8ZYyr2KUZVaH98Zh+tPS7btzuhJNbc5spUMLEJ0dvCZpbQ41et/p/8ITDtQZUoH0Qlp/eXYnmD9DeV+/pk2eHASUEaXyVHrthxf5PkVNQhLImneGWQSU5xPyN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Fnu9KAUy; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=C3qRn9d0; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TI9T1T2908662;
	Thu, 30 Oct 2025 06:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=HHaVl5scbvvqy8qREh
	1uN5ZCTfpJiU7Y5f1KjpLfUyk=; b=Fnu9KAUy7yVdIsGGaUMXkn4NDWrEe3xWSt
	pq6bkcSxDrHEsrlV11CHRE5GmRTqtc0P4xAr+9HQfz1XZ9OI0TsC6nk9CHIg4LPF
	ioAY6oSgYq3RixTxzpkhdu5EMRr522WY/V5LOJkLKxD4H/o8USY2EBr73MVkTVM9
	wc0heTchCst1zpkUqfTy9tP6oEH4gF2ruyrfD4BAycLvlqotKuOl3xtOcWnkfuzd
	V7HFUcfVQxxMxuubuhZMSkFzGHG9Ao3+Z30sEFDCId2i5e+Brq3zY89A8HsqTpjX
	pJ8n5LM1fZJHWFiEtmtgtrs2DvcoILWzTQoLnN2EcsVmFlofrKSw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020109.outbound.protection.outlook.com [52.101.85.109])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a34a6jdee-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 06:12:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsuVZmosmUiu2Xhogbsy0K5WLXsgOhS07qC/aOIAH8XV7VxsTz5sTknx201fiVZUsaWIr+YAyYnRcv9h9elAdfjCRA/fcjfld1K5mU07Lh5vOnbYENEO73DEozR0O4uWqMZvKsnRohQ4q9utZxwpacK610fqiOONBZl4EIWiwt/S217C9c5IlUbS06eA4qQ0NcWlannytcNVtq1y4m77/qXEQ/+Z6wEBS6HSpzkdcUdbS16+qES8Cvc9KQFqMjP+exgqWtXDb0kQY5QXAGSSNrKP8Exw6HGbj9X4MEAdjn4ewpU0dOyRWFa5NchbGBZex7ki7WZEdBL8hKkAIJd8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHaVl5scbvvqy8qREh1uN5ZCTfpJiU7Y5f1KjpLfUyk=;
 b=T1nXoFMrCrfVp72hQ+ig15/Ijn+EvaeKgJRcJh90bkdWF/w/RimJ8XH9VvlJqBmCugIanMcll5SlzXMEouW+sfkYACXutGTmqRnTrZq4EaiocuZVilwUgWpYpZlnjsZC6Yhcya6K5TzKvh4R2UPqDD8wilgnmzDBxENC4+xzretf6b92lSBvx685S+NjNavqk00bY8N3TAEjyKEhttL573jWfZedsv0QHALDnGiHYOW4WgeIG/DXw3f4PcpxOM+WCq4icCHqBHR1keTowr8BuXuE3pSeFdQzrnqQEw+qsddDa8RK88N6+WDQeYCqrMknLvgS+29PaVdhHZSkNdTBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=analog.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHaVl5scbvvqy8qREh1uN5ZCTfpJiU7Y5f1KjpLfUyk=;
 b=C3qRn9d0Rvl/At82QcBcLB0QSv48knHJOa9tgZy0cFrTmUlXWWhYx9hrLXNPig85zhdY5gnOkH7H8A/aoyS/q3Y7ycW4QsA/hSNMYa0ikQBn25ciIXbRbAdDHla8uYbbKBxWq+uPrldKRTivR9VnMIT7dRWCbKWqeAlVX9HLQfg=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by DS3PR19MB9390.namprd19.prod.outlook.com (2603:10b6:8:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 11:12:15 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::c3) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 11:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 11:12:14 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A7211406540;
	Thu, 30 Oct 2025 11:12:12 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A6EC9820257;
	Thu, 30 Oct 2025 11:12:11 +0000 (UTC)
Date: Thu, 30 Oct 2025 11:12:10 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Peter Rosin <peda@axentia.se>, in file <patches@opensource.cirrus.com>,
        "open list:ANALOG DEVICES INC ASOC CODEC DRIVERS" <linux-sound@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/APPLE MACHINE SOUND DRIVERS" <asahi@lists.linux.dev>,
        imx@lists.linux.dev
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: consolidate simple audio codec to
 trivial-codec.yaml
Message-ID: <aQNICuhbRiIrq+D6@opensource.cirrus.com>
References: <20251029214018.3969034-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029214018.3969034-1-Frank.Li@nxp.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS3PR19MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: 235239ef-79fc-43bf-5637-08de17a52e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvIqi8m0jViiCIFFwm2/jkh4AKDBNAlzl6R0yyF2VEYKt4PNepOiL2Sjj/s+?=
 =?us-ascii?Q?n6kk3LCcLNoEIASf58Fb53fnzRcT/iSglg+YgGGKMcW1Bv8FVn4snxD7FKi9?=
 =?us-ascii?Q?aURChWI9bhT9GyiMxy7TmFmw7z9/gZJz4piZryOBN7PQP7BO2dPHMRV3y/99?=
 =?us-ascii?Q?2VNvaDa8636fpkxtLxNZonDfi5zf+eTDftLusst4Kl6PdmepcOpc497VTJTi?=
 =?us-ascii?Q?yFwKT3cSFoyteWxV6aJ2Lsa3qCzSr+/J1efzwBLxIS0AL29L+VRDAmJK6pVb?=
 =?us-ascii?Q?Oc01ZFiWDWH34NP9Mz5Uwkej/aNmdhs6ouQrS7VsMOxxnoP7ENL5KCysi6Ec?=
 =?us-ascii?Q?XUfxWSNB0WmWC9W4B+YJq1bFIlIeHAipPBAoGsYDXsj8mZtuhPPOBgUg1YYC?=
 =?us-ascii?Q?SjQgh/XVQGRIDCRz4miUc8MQ4RZ1K4sSi1yMM7BUu8/N/CdMmvh38YVMnfWq?=
 =?us-ascii?Q?AtVxvG3SwBiRt2pXF/BjcqU0Hz15BdHcvRWhmhf3ZdN0d7wGdeHB/LYCt9ap?=
 =?us-ascii?Q?VuNV0atzpSk+fTshBvYxnJ/EPU3SKVts3rUGUNT4krMacqZrGtm0D2uU9IbA?=
 =?us-ascii?Q?DsELPHLGq9+ob0yDRNKGwUfAs4zb1ItLpEWNsJhPWArhEUa+hNv27xGHtPsX?=
 =?us-ascii?Q?QvQ7sLrMMxEOEsfNXXyaStKjvb78O957kScBCK4mPqq3SelmU91t08IxBL6M?=
 =?us-ascii?Q?vugL53EMKLJy4FSxiXDjHHFwopw7ZMwVl9wt20er/jTbXiDeSVcTRgJnB3wT?=
 =?us-ascii?Q?4O1tUsoTtmSWZjrj/Fp/eoGMTWrAV8ERBxT1njRj/15TVlnAkeqFlQhI/dqu?=
 =?us-ascii?Q?hk9fxorFP4qgiB56FTqCmSDz1Y4AzARuOJe4XLqyhXCLRyRBJl/C5mC7E41k?=
 =?us-ascii?Q?v5L5gUFi4GPBDCBSQnMQLb6zRv/RIy/onof0PuuSJfPz5zrWXzxNMa4vJaPy?=
 =?us-ascii?Q?zR3qKVxPBWui0u56v3n/x4Dz4jhrq6lJZUS+cbpuP2TBtZ4AN90ER+JjfMkn?=
 =?us-ascii?Q?ELCMuk2ByfvOpnxa9coiEy8B5BapCJ6NlB0v98WJbYm+Vbyy7cw1doCzVkdC?=
 =?us-ascii?Q?tdG8dzTaoSgdPi0n2pCaW63A78erw2WAfqKP2KPbCiVX+OZ13qcZXBGWHv2N?=
 =?us-ascii?Q?lVrm/3N472wo6nZLmyypZaN99FoWBM3EX6ScZahIhIxCoJ1oK5dTsN5DF+UW?=
 =?us-ascii?Q?zM/7zfeqXYremH5LYkWQtfawYWiEa9UcwXXEniruhfgjeXBsYJCJXr49wUBw?=
 =?us-ascii?Q?p7czTgs23S5zKs4cOf/ZbiQdKJ/ftb5MhhK8M31NNgwj1UoeBg6vwrq59YPr?=
 =?us-ascii?Q?NGfO+845Jy6yR1MFlzg17ElkFlGnoshJ2ZTSt3X9nbtKJ20qkadzIchObffz?=
 =?us-ascii?Q?h7dv+1vdxWAQQ8SeouyS49IApWN9QWyr6GLf5NrhgadfDFdAXz6kQTj3mJ6a?=
 =?us-ascii?Q?f5kFo2RZEAhgCajRIB2AntoaAjuee41fkHKGwHL4dsxE7FVmTHHa+1kVaftH?=
 =?us-ascii?Q?wGOon11f5bOiusm5MQkVXFYOzVSANR0Fw+ZTInjZzcmP3joOTaw2HdqR01x7?=
 =?us-ascii?Q?1Dx5u++Jjq+ar3q8wRk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:12:14.1259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235239ef-79fc-43bf-5637-08de17a52e25
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9390
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MSBTYWx0ZWRfXxhXVB0V8C4oI
 Kzt5UuTicGiJItkNYdwdnzRZDa6dlwGWVZgYvT6luwagesrBIrFauvz4uNhlosKsWgfTKmrjhNy
 B5oyz+TehrxOcJc97dkTItneVBUvKEc5D5nZF3EV9AqdgqtjQ4+6NvvpmSrbIQFoGF2E54N/X+h
 ldu7hQcoh3mQ19mXibuAMFigQn+WNF8s4kI71O1TWghI6kQ6Z/ggXK8Wqg4uADMklrLuoMUfkpF
 QuwZe+y3o8g3O1Pg0omQM07Pmxw4OX0XBf6RcYd5udJuNsXK0WcyOFYG7STvXS+Cne4DHInz/KW
 wWPHOmtbTR7MDYPHLR5uS0ejj4dj3MSzIC0Qv6wFY/aEerCaO6RPGqaRTHzuQuTmMybqyXWCn0D
 myjINLkuZUXwSd0FWekCpXp4kOclhw==
X-Authority-Analysis: v=2.4 cv=HLfO14tv c=1 sm=1 tr=0 ts=69034811 cx=c_pps
 a=zEwEPAIedI49nOb3SM4JYA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=w1d2syhTAAAA:8
 a=dXypxJJ5AcpkTrBvMckA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: JGwqIKt6BkjiIXtfdB8rSkbJSDmd2-op
X-Proofpoint-GUID: JGwqIKt6BkjiIXtfdB8rSkbJSDmd2-op
X-Proofpoint-Spam-Reason: safe

On Wed, Oct 29, 2025 at 05:40:15PM -0400, Frank Li wrote:
> Consolidate simple audio codec (one compatible string, one reg and
> '#sound-dai-cells' 0) to a trivial-codec.yaml.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

For the Wolfson bits:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

