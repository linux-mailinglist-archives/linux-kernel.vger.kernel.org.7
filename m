Return-Path: <linux-kernel+bounces-829103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C1B964AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DD63B0F39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C32EC550;
	Tue, 23 Sep 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gJLfQZyu"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895B2E8B8C;
	Tue, 23 Sep 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637543; cv=fail; b=jpcfJ/LrQbuR5M1Yl2dj575iAodf1KAT6ncvuRlIMV7ntXtwx3UeKH4lMnWxODvKZlOeJeDRuAOx9vMc807IhubiVwlIu5eNR+TwW1rYfuBLyFovtjEWoa3ELfW4TphWW9fRhwcLO7XdCm6Zb7mQRCZ7O9o8mEGpmEvwA/8fcWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637543; c=relaxed/simple;
	bh=xd+SFA/121YmxxmWMTRg6Y2eBhhoTx8k5ZKv1F78+bo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BeM4TK2pWuLklwvhuKcPzuQjnuUeCF1V4SnSBmdz8K2Q4g7IL4+HD+lzcLo5gE0jvIGWa6HSR7v8ZKROXZYuF8Nd59BzGHpiT6IAQu1G6qTvathxBy4mWdf8BWlkRB0/ZT2/dAXQjH1Ttgf18mqsC5l9xjoRrSbstxRjJjTksUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gJLfQZyu; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58NARl6I2162914;
	Tue, 23 Sep 2025 07:16:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=GDtp5QKRj
	PcYKDn7N82BD836M89YBc3TrMMSkxj9lUQ=; b=gJLfQZyu+leBLtcH/AiEn8lZQ
	FMxOudHi8eKczVqkXOnzQV5xkvidzpp8mAewpyZBlxFyIUTKRTwD1ADpKxIAJONv
	RFzdoZ0HIq1Yayx0w0IVOssYmS/HFdS3ETscqQSyVjovYG7iKE31nVcK7vBPR8GH
	2njBz3AuzdXrnizfM0dslRjJZ2r0tes+ZiEFmOo7Di2EhJIksxrEMCp+hZr5X10A
	8QRmvPvDadN9YGaelb3oVYJoKiXlV9+rQuXqm6FIuXSkU52osYY7G/jVQKHbvaRY
	pc/Xx6x62IPrX8J1XqKffSyNIRscpnc1ZaTrHe/UptALNdhR9N6OiDEAYtuDA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499usfjx3y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxZWlpmYub8rSp0YVqEd1YxmUpFST7VNCN6nOvGo0FxfloXDxp9XWQus5xEQMlZ7PyM4YDgah7629CzgeBYHADKF3ct+OzfEeey6o0GkwqLwJQntd+hPL4WhEkMDU8opnCp5pnHVfXXBehvgJ7LZDaP3akx5gjPMD+mJHX9YIMyhBMQtyfANy4xPYCRBb7Z/v1fhM+GKIwk9GaqQsz1mWBIn5w8usnUEziFlfHh28owpXvy84zT1/Q3hs+7JA2xO/J+WcfSRkiB1SsRHrlSAYursOsiI2ExEuBXWikKcl/DRavqUkjkKSRpimDYmC8vrSDSSMkAuTI1WTzeJ70pXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDtp5QKRjPcYKDn7N82BD836M89YBc3TrMMSkxj9lUQ=;
 b=r6+Ik/fV8GqHT6ODDMZG3zxWj5MXVjMbYgtaWIy2EBBEDihT6FguWueln3sfhJ2YYAAPDxPoT4henEnzKxcNCC4J2I25FBdI8/4+tPnC57OjcVQRaRwiupiwiMHK9eNGycbf7ZvWUcfSSLV/jWbCgUkyb2hu+HoF8q8Fq/Y9saN5qkPSho9a1MtqpNbRNltvFE+iz2BXERpNG7nl0hIdPdw4s2570oFcsh9ZUJfkP6uD291bql9PokhLwm30OhhiC9ibixJKQG55UDXPBzVBOxdTRo/sjIbOU2bHosBGvgjASBtY+5YOIXzK5kWJCr+qqyMYH3dWn1AwSztwlmgPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by DS7PR11MB7952.namprd11.prod.outlook.com
 (2603:10b6:8:eb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 14:16:40 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::4b10:b3ea:35de:ab99]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::4b10:b3ea:35de:ab99%7]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 14:16:39 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiaolei.wang@windriver.com
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: freescale: Initialize priv->lock
Date: Tue, 23 Sep 2025 22:16:11 +0800
Message-ID: <20250923141611.1295395-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|DS7PR11MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: dd92cc0b-479e-4997-fb4f-08ddfaabd000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4E/uvYaOwX5DvcJPoo9ixSXpmlVo9CDt7XZuk1dHVsPs8IYf0BP0Bamb63DU?=
 =?us-ascii?Q?+1WSqQNc5fbKhC8STz3zBmkQnZ+M0mGFrXdKG/qkwo5sSAgF2PuASDOYV6tx?=
 =?us-ascii?Q?cr2lb7Gl27eC/ewvA/CFACuarzw0DUsIxWW/+lRXYTz22MVVgyrUk0mL3HaV?=
 =?us-ascii?Q?ucM4sRGWG2RZ8zVgXW1OgF9/PZrO3sFUeQ9oeEIUcLNOLalLd0HwHPdKuPK1?=
 =?us-ascii?Q?Gp+k/8tEx+PpWrtUpp+/SqCBVPkUGg0bPXtFeVXrGQGB8wgGejN63F4Tr0NO?=
 =?us-ascii?Q?lILvIN9aXCJmLk5EmTiVDUsSQwkAdN7boT5Nda8hzq9p4wdLjfx3UkTxH6E8?=
 =?us-ascii?Q?XFDyr8MHLGWwlMXiqzbPPpVzrqK3/f1LmVlyP31GOXk/6T2Hpri5RJa8emP4?=
 =?us-ascii?Q?IpVoprxRUc+YE+8V+OondtQnOyCi810gRW98GU6RI8x8a8QwWbxnxyq1WAuK?=
 =?us-ascii?Q?q8lXrroApZFjL1bEIxgSUWFdFSLCT3b+3LDaGDQuGNsgp2CkEqkAsSVlrxP8?=
 =?us-ascii?Q?cmVd4kretRrL2q4Inv5cR2S7c43+4g2uptoVZD5qa4q5AXvfdNgqT7SH39l9?=
 =?us-ascii?Q?GMWtMfO/H/aZa2Vv2mKRSI5kH1BZe2wdrAXhIVmKWpoCEX4NNEVOtlC1m1C3?=
 =?us-ascii?Q?dUcVlcfWDChntAxi1UrY8/uFG5n1dsQIsuOjuTRC/OpEaMCm1IOBIx3u5khV?=
 =?us-ascii?Q?kk9kVDUAJIYKSwL23QQQei3Hpw7SgvhRM4AUhhJOUEohPrqTpLffs6mjMDBt?=
 =?us-ascii?Q?U5fK2E/MTDc8/SP9hPhFQMbAg9pos/LWequxn1xquuFSdKRIVbiGdYaTc6lt?=
 =?us-ascii?Q?e7walwVHo71+e9I6tk7tHjQniBNOQUjNPthDyj17/JpWEBFnPBunGKHxROHR?=
 =?us-ascii?Q?Y+k8/pbJf+aOh+Ddwa29xrZvCkgiaXRSZ0LJeZW95kc/IdStPHGPD0wbNNxh?=
 =?us-ascii?Q?7nYCxKDPF7bAi9AZx7coe+oMxDoymQIRxUna6Vx8A8ywx3AeG4yl/eUyrU9p?=
 =?us-ascii?Q?mNZA2I7KCPJX4XpioSFxRQC/F9Gouq+WeJ2ERACZ8OKNPk6mUuw+8cSTZ7gs?=
 =?us-ascii?Q?0tbhVVy5fFoLKdYKJmrD4URNTIU+K983u7Sgrd8H7dCRWgHBA3emGe5FFqTF?=
 =?us-ascii?Q?0bUz9MeHBqm8yhMPGNDoi+Z23F/h/6/sJC+OwuF9CpKQVzvx5yc9oBTPltfw?=
 =?us-ascii?Q?cgKa9MbBximkDt/44j7fUzrytCIASBM+cQ+bsL9WITFNynBiSkao8Xhbb415?=
 =?us-ascii?Q?vOkmOXcag7E690f3O/SIIiPpHp8/dzdoyLCiii0Y0/GffjliA7+RgW69DJIs?=
 =?us-ascii?Q?x98RXJl6b+bR5hNs0uXGC6JhIgAYsAWmVfshSNsKNWGGYo43YnOkVFBT7Mwe?=
 =?us-ascii?Q?x98cVh/xquALNXkwUKC6zNQ5bAjRZlpgwQ5dpZWuCaxIRgsP6n/7lsZFvByS?=
 =?us-ascii?Q?1j3Sw/hJYcV26QaI45FsUUTKwHPgmeW8uFd+77zKwvvYhTDLw8Flow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8EwuuLKarlrEqGu6G+9EBAPV2o79q3XDO/SMSdUqRqK4ppRJhsbRJCvppkWo?=
 =?us-ascii?Q?3nK9G3VxPsuP6lFb8EIRaIfyD6cr5cLBll182MVPttWtWJHwfP70kZbLTUyh?=
 =?us-ascii?Q?JNcMEUF3zCWYbPONlGIObaXIcdbKBHtMv+DBdYcwcKTmiQt5LTieUO3RiifF?=
 =?us-ascii?Q?rEaNxrc0H5Tm2qZmA9+ZuDZXiThnq+SB+vqev5g2+nRSXZp1RIM6WlvJ5wqO?=
 =?us-ascii?Q?Ux18RMDM95HYIWP+kDf+OE/84yFQE15hR52rOe3VuLR2oTh3OlW+k0CDAr+x?=
 =?us-ascii?Q?wHrWHwb10sbX7HPj1K9uEzeYtBYjXjFQBI9XkWgFM2dF7bHvmGaRSeaZ9Zht?=
 =?us-ascii?Q?fQK8k8r5vqTxohHMUgyUbUiPVDfRI7JFQZL4etv2PSlByUxEn2YK2FIoHemU?=
 =?us-ascii?Q?nfmVZ7Xsr+XEAKdC18ObtRjI09idAlk4km77rABXWFDn/S9gdlDgZPLLwLtI?=
 =?us-ascii?Q?FPCdJUNMaFWndz1T1GSPUnFsxck9Q4RhY2iEAN2cRXsQxQRK5fG+yhRw/C7N?=
 =?us-ascii?Q?tIUqLjwS7JIi4W36Gd32V34UMdfwtICaxCRNvxeU3Ywh6p++mSygrCIPCWx2?=
 =?us-ascii?Q?2sV4h295IORnllEPWxN1BeNq+cbZpBBq3VKHtJia0Qdw53wsqx7XMoX+wByO?=
 =?us-ascii?Q?eK+ScRtAr87twD1KRMlK68fJchn+28NK3MmxQi1o/Pjb2+8M3/DbvhauZEJa?=
 =?us-ascii?Q?2xPSsewD8hiVVnGvn8LAVsYlUM1FqQtLcU84QKpu158cmACI2g11O2s50QdT?=
 =?us-ascii?Q?tm58PeyBL5o08rkk1GadYQPYg6iSKmNsAafyJQsud/nfNeZmt8f9M/9K+ic9?=
 =?us-ascii?Q?9Cz3KaO9RCJelN+JHAzQiIS8I5i804Gu1FEhX3RsQM5wpS6LxwZ+NBINl45R?=
 =?us-ascii?Q?9jbJBVGGcLkqjQX1IlKwADc3NcFd0Rfoi5qhj/lSfGuU+U0njwE+4FxzJVpe?=
 =?us-ascii?Q?xEpGtaDDEJr7tkfZ54aiuGMVuEelHx+jcvkfkcgmnJniQ7JCtX8JGGLtAmVh?=
 =?us-ascii?Q?3NtOki7VDF5owHlL79mweU9rjC7axWO2xMxC96V9+mqvVObee3e17kVLA+bM?=
 =?us-ascii?Q?LewhG+/+mq+suJjStgFNvvY4Qj07957zZHlUihlCyUn/GkAUwvC55PoDzLGc?=
 =?us-ascii?Q?aYRFH8Cc8uXy25MEFhZrC6EaZcbW2n8eUdLDmrSfrq8Li1zBUVp6ZoCaaern?=
 =?us-ascii?Q?gr9Lsv4UgkKHRXGP13+PGvlcoOnckzCa23ZJ33T8+4U5kARVhoQXGbpc7tAs?=
 =?us-ascii?Q?lndl0O9Yl1Ph7irD/4+sZZtDojbjlCfGvQPPPaZsimVuOcil6vBTBoak2pd0?=
 =?us-ascii?Q?2eIYzA1Y8lBZeP8Bfy1I8mRUmHsEo98jpic2siZT0YoXkahu/wliJGWej/Qv?=
 =?us-ascii?Q?OEO4t3Yqkoab5YtOBFFc8TiUvHYNQHwpEYRxcByfS4KG7eN9C7pfzKPswtBO?=
 =?us-ascii?Q?hXruOtqzfTwL/H+ApcBJYxyxVhR29X24Dy6Sdg9jkRAQvkWNVq5IBWOk0Rt5?=
 =?us-ascii?Q?WKhU9zbr77i6G+gZEGTqsccC5yeB9NmG0hTWDmw6RNYwPfMdJ4oaL3gY5nRw?=
 =?us-ascii?Q?3mo25QJoX0BqoqbtS4/QTVwRofJOIlTAtnRMauExZsr/c4Oms2sclDF/2Vju?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92cc0b-479e-4997-fb4f-08ddfaabd000
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:16:39.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAK+5awxTMirlxoukH2ip+SPP++NqUhlESdxcX54YPanc8RosLVvQS/5BisjqctCUDmhujKNFySgZVFGv0M95kAsXLwnWSelUBqzz8w+FWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7952
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzMiBTYWx0ZWRfX4snfc4NR0quN
 OEZ44+2SBAzefQ7rsYEZg1K7Hhkdf+JlzAQz5J16l+/HCGTPDyS2OVT3NNU/TJj02XxxpugYkEI
 yE7ZOQMoKbeXD2cR2bdwcqLi8gcwVNvx3XFNMF8ECJe3r1tJ6yAiqpyoFhZtY2eHKCyejOgnSAh
 xVU9skS6OI5HGtG+k8+odE9zY07iuqZfCkDAsSMnHmxCqx+Awu6dNUqlKXKI4WHHWf9yOI9hpHj
 awZw+53EOTvltG6Wb+S33nSVyGD7l65wusbDTXZqaqQ3y+3fQDfp9rlUBFNpl6m26q78J2pxocK
 g0/+DDvY3yHUaoPbJmmh88uA6pf9bLarKXfJF1HnjAhqmhOHeeoLyL+0PusqyQ=
X-Authority-Analysis: v=2.4 cv=DrxW+H/+ c=1 sm=1 tr=0 ts=68d2abcc cx=c_pps
 a=uEqrJT4jjddHaitOG1ym6g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8 a=tQJbgDIb0QjpQc5WANIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 2xbLUneQ4xheg2TcHs-Hhp4_Ithz_4ky
X-Proofpoint-GUID: 2xbLUneQ4xheg2TcHs-Hhp4_Ithz_4ky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Initialize priv->lock to fix the following warning.

WARNING: CPU: 0 PID: 12 at kernel/locking/mutex.c:577 __mutex_lock+0x70c/0x8b8
 Modules linked in:
 Hardware name: Freescale i.MX8QM MEK (DT)
 Call trace:
  __mutex_lock+0x70c/0x8b8 (P)
  mutex_lock_nested+0x24/0x30
  imx_hsio_power_on+0x4c/0x764
  phy_power_on+0x7c/0x12c
  imx_pcie_host_init+0x1d0/0x4d4
  dw_pcie_host_init+0x188/0x4b0
  imx_pcie_probe+0x324/0x6f4
  platform_probe+0x5c/0x98
  really_probe+0xbc/0x29c
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0xd8/0x160
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x84/0xe4
  __device_attach_async_helper+0xb8/0xdc
  async_run_entry_fn+0x34/0xe0
  process_one_work+0x220/0x694
  worker_thread+0x1c0/0x36c
  kthread+0x14c/0x224

Fixes: 82c56b6dd24f ("phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
index 5dca93cd325c..9453ab98e475 100644
--- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
@@ -545,6 +545,7 @@ static int imx_hsio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = &pdev->dev;
 	priv->drvdata = of_device_get_match_data(dev);
+	mutex_init(&priv->lock);
 
 	/* Get HSIO configuration mode */
 	if (of_property_read_string(np, "fsl,hsio-cfg", &priv->hsio_cfg))
-- 
2.43.0


