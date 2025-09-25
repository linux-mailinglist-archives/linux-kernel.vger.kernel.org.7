Return-Path: <linux-kernel+bounces-832462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF153B9F627
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FEF166CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810A1DE4FB;
	Thu, 25 Sep 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C593Qmib";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ekt7TlhX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187310A1E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805116; cv=fail; b=djrG2eeveyXwgMImL2/+FpDj66UcUTJLN+C2fAcYiboJr/GRG5Sp1LqQFbrsSUJN6R+gM1VBXDYkK9fM15tFTmWvNEz58QrbfYnjgtgtYGN+7rlBN1YjkfLF+BKLnJwXuFyTbBXpUt5+3zST1PbhWsyik0e7GuhrRmw8sgCIKU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805116; c=relaxed/simple;
	bh=ZFRk+n48oMROk4Tn5+lFIRbptjRQw25pEAQOR/CU/XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NwZZWS7KBo3JmcRMlCPIY7ohdcqtl9CPZ6PML0pgDF0tzs1tB/9IAo5SlAq7+8dyJDYQ5w31xt/7SKcerISJtK8lXDnxZr1y0lzPd/dQ2slfvdWe35nvxYR35IdAwrvyyAilMo02oRzHCwBG76IkJHC84cFYsx9fHDoO6hUjiyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C593Qmib; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ekt7TlhX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtuXO015805;
	Thu, 25 Sep 2025 12:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yeNmloR4/uKPE/y3Jend4I/W11TlF52d1lH84EnKJYM=; b=
	C593Qmibipfn7IsfmH/zBsKwARKwrC/hKrZerYGhvsWLlmaQ3pKYgRs5nW9szzvj
	EDfFeLikdOk3etGoywmhjLZ8+hPHu+zosD71RZFeQvZCukBGJMxdHE+ejgLH2+BV
	a6pOS4PvsAd9YPwoEWd5r+BFtU/yskxa1M1m4325tcQPmeRz8zN1JqnGt7jWpfQ9
	201ZLoahzXBmCFGceXdJgZLzKRDzmCd+gj3T7hwvWzcVK1wwdZpAYCyrMiWsEJBU
	esl8M3jWUQfKPCqvAulm3wN8dWRl9F9KDVc6xjAl5Fgs4HIlg1FqcycNwt1uLshE
	n7yzjGQS1JtsDFn2A7y7Pw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499m59hwav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 12:58:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCs0Mi014539;
	Thu, 25 Sep 2025 12:58:21 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a95243rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 12:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHrS+TMvUZMxVR1GI/D9/otPv+BmCPtT2ws1neg6ChsIgp+uxxQF+vWenKvz4rLWeWAz7jMx8ZKrt9D3IF9xR7meCoBWjDZS2UPouYm1v6YErEBG2lDOSnhCRs3zMzq/IvOhuDA4puxflqOTYTjfm84svWx0aA5AchGOwNwENDoGJCVtkksOXatbPd2vyHLMJ6ov0xcMAy/uxwLXEqFYzkBthWZvaF2tKIoE8fsy1zamlK6Cqycrjajp0rrwsBRMtTNAHIchbX3w1+n90FOBDj5+zGwiHAqA5Vqg1t7S93STRjTKZBhnSQ6dPuZdzH50amvz+GCONT9eXpCP03VX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeNmloR4/uKPE/y3Jend4I/W11TlF52d1lH84EnKJYM=;
 b=XvWktoF6WXh9vk6e908wWYACDe6sQbDaX4FAyxrmPdcoNOEM0A7Y4IMDYjIrM3iHpyIzekjNUVnafn39oHZhBvTeK8LKywpBQG7C+MRFFzcSc10yFblnkmmYjN5WqCoJDUqwxlFM7K3Y1DVaRxo8j99M+GkQjPNx9palFeOYgXgm44tHLU7WGTyLY8gCTMzN1bVIFJ7NsvsTUAbrQRPAuCVjgyfkd8S2r6bd8av0hrGSINm48E45MMw5naxmeQROcYP5wSNJ7SQhTkwrH+BuE0kdcGTdszsGr6nCXy6+apAZnN2GlS++uC6g3k+UCbdXAeVB1MMpZlUxyKbZ7YgQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeNmloR4/uKPE/y3Jend4I/W11TlF52d1lH84EnKJYM=;
 b=Ekt7TlhXkmOy7/KRqdQCapVxkOmjCc3Z4KjLzDoPcJCWpx1vNCBZXNKrOsOokRAj/3vFyh5Qgnyh7Gl1Stfkx93GbhS1QzS9k62EAwMvt5AyxboPIFXHzWp3ivJ3kWDzjNMJlQMuJLeeRGWGLkjb0ALl6IBDWSwPJhHmN1JRciY=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SJ5PPF5467E3597.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Thu, 25 Sep
 2025 12:58:08 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:58:08 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Scott Haiden <scott.b.haiden@gmail.com>
Subject: [PATCH 5.15, 5.10, 5.4] NFSv4: Don't clear capabilities that won't be reset
Date: Thu, 25 Sep 2025 18:28:00 +0530
Message-ID: <20250925125800.74222-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091224-CVE-2025-39798-a66e@gregkh>
References: <2025091224-CVE-2025-39798-a66e@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::13) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SJ5PPF5467E3597:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca64746-1d24-4746-f461-08ddfc332cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fJieT2TLGpO3/u5wsH+bzycSvbk6SzMcfwxQRGiHmwNhJoUA6ngXQkjuSGeY?=
 =?us-ascii?Q?xdI4R8C5cCu+HfHeln9w0s77CxYwcCpIbWef9u2q5tfdJMfCu+KYB7J3aWWl?=
 =?us-ascii?Q?XddzBGMAXoqTE5Nty4BC3um5Ax5L/G8L6BpCGA/k6GSSWruigqiq2Fd8uaPU?=
 =?us-ascii?Q?y1fYY0IZiAox898BidnYcb26yMDKA+1RkRD78SZqoOQtYgd6lyM92WDL+WoV?=
 =?us-ascii?Q?b9kR3dRwabI7aOqz6SczKbHhYPYxlZmo4Ky7Wm0WlApgLlH18v/X9yi1uyZe?=
 =?us-ascii?Q?8OQcS2bsWJNMfuN2T40+rGFazT6a6jlnS1aH8VYJvruDKivLDkOgjfw9ZpGf?=
 =?us-ascii?Q?g2OHM6T2U3XK6TMS/hZ8IxwP5cSbTnwP0pX/stdM+bNXY+SVpxlKogvQj/LR?=
 =?us-ascii?Q?xpx8Ob0es083HAtpNawJHDAzmiVF5n6MeEJrLef6C4wse6GqBrh1oPMhYpvx?=
 =?us-ascii?Q?Zn/UHKH+IFRZw+yubrwdXW/qU4bh381jbZmnfiHbYBR+2Z7StGhUiApP6Njz?=
 =?us-ascii?Q?6bEh4d/xpHRJ6JT1YsvE3qafKA/Celyp1T3GCGRI7zULqvymhEh6hQ8676kh?=
 =?us-ascii?Q?4Aq+2Z92Snhhz5eq63PKoU9sSFZ8evPuv/DaK8nwNYpA+t5KK3u7+chZoERv?=
 =?us-ascii?Q?MGyGnohtW5tm+Wxb7IpvKwQv3sjWOi0p0qqO2W4uoSJo1Odt7uFh2s+VvDQI?=
 =?us-ascii?Q?M30XbOoKDSgfv/mq862eMpI6yKFX6Pc7qf/YsrHVRepA/5rzJ5nlasGfMFDS?=
 =?us-ascii?Q?kMEGtFSsq72ot/i54LNMT+g0u8lhrdgxBGR+jOUKNGV+C0acpmq1soXzXmBe?=
 =?us-ascii?Q?0+zdfosr3dq3IBX2Q1TRVqC6ENldN2CJQYBtxrVoJNpxjmRK16/XPR8yx25m?=
 =?us-ascii?Q?InxByoagI08HHtzcGudVe9gzlkuhYNa5XWuYyOcULMCe5emHXU4Comvs3Osr?=
 =?us-ascii?Q?SfPypLUcazfhT1v5aZSxo0e5FxPSKyumEg8p9H3bOkXvQm0gLo2VxDsQpRmY?=
 =?us-ascii?Q?MSSw/uYOLlIQfkQFJRmg/fBZyQG9yEcOeMvcGVG2QRpWCcZ8ixMs/rI5+xFM?=
 =?us-ascii?Q?lDAPXTHvZ+H/zeBtgmvIuJT554QXBKr83fJ+cvLeVes1IIGWTKsKaNcFo2jC?=
 =?us-ascii?Q?dEoZnuaX8kT9dM8wWREWb8MozfVEvGWx0PY3/roPAmCFId6B/u/vm7epHXgn?=
 =?us-ascii?Q?1xvc6GvY0v5kBnxDAcNn0P6qKw0E38CtJoWx17C0ko9yKwJIPYaRcwvB8tm9?=
 =?us-ascii?Q?Lhf5+CiwUwDf8XEC7AXn+7B7ECgNO2C8s6jePnFqNiV9RnmbzYwAsNKXxp44?=
 =?us-ascii?Q?FlX+bDcNAErLYg6tUdc/TwTlbru2e5MoLk2YBl4A9RmXbUlTwn23S7YCaA70?=
 =?us-ascii?Q?8EPxKWbNNUonqkqPKm+UDdGyEJW5hoPB7oxHQ507552DJHHXzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jnHaO0SNJd211+sOZLk4DMk3yLtAqnZne9ACLGEaHEMa2lAPbj/Ig4N7MsKT?=
 =?us-ascii?Q?GVryRu8+zSC3vK0E4MP3aDRH4Dpeiir08FwxTDY8zqBN4l/pXI5H8ymX8MsN?=
 =?us-ascii?Q?BFYwp4s3UttdHUaeJfq+e/gFjTqGaKPnHj8fAW8+O19TRbYVI8tmb0wPCREq?=
 =?us-ascii?Q?Rh0KWpG95Ch5T/YICVAEDH1MLpqllA1lEaCn2jJZpnoQHLBMz3fcYWZZ91K0?=
 =?us-ascii?Q?PclXxiwi5/FdXdlFxy5lEBKsoA9MVWWvG9MKE/qPiPeQNkPqEeKd92UmVZMP?=
 =?us-ascii?Q?7gAQre6G2cAugehVGS7zhhg4tAD9jBXUovmtC+FRboItNmpAo3DQ/szZikn3?=
 =?us-ascii?Q?FGz4EPFImdeCsqnN5BHNvj48c4r7z2bwYfBI3NQFsoWU3ouQB6PSBsSmvoQY?=
 =?us-ascii?Q?ywXKMYtT9A16+AYSoSY/97G+jButdmd7PBv4AMVXAgCnoTt6xGwEBSKucd6o?=
 =?us-ascii?Q?cUQ33eLOXIe5VTFguvbQFdsd1tqHeYouhfYOBPG7p/4uxTTU+N0FCs+7o4/G?=
 =?us-ascii?Q?Qr/LN/gjGiaNK9vE3fThNZYlhqW7C4TLcC6iwlxbEpdOT7JzntPTfe/LiQi2?=
 =?us-ascii?Q?4qLHlbnTIdmC73ZcKkgHHRgPxOGlGs+f9lqRw5c3G1KcHXBW8uGx46BUV2DZ?=
 =?us-ascii?Q?SNAMepgWEeS7Ypew7mQHMCJ1Sr32GZ/e6BYDhAnjG9MPs0Mv6/JcOYsBEha+?=
 =?us-ascii?Q?wJ2o6AogNJHrKZDfvmRKhCxXHXDiRuhmN55r7x1BPecimpCFDYFC/h5lZiH0?=
 =?us-ascii?Q?XeNXU9dyGcgYnnpCi7yF/z+S6gBVoTUxVnxRAtVd9sqs1E//pDnO6Yr9wzMb?=
 =?us-ascii?Q?qjs1Z6pYxgRdYtAcaZNV8KsyrIFdAC5T4Ii8FHQCDH3lEw5HTMb6OSOqkOJf?=
 =?us-ascii?Q?kioeit3FrHpOnZT5ZMM5OLYlD+SVPNtaaRtnKIlA9vEa2kpKuF3zlMmjjwqi?=
 =?us-ascii?Q?7UxLVCerpQMLYEZholCeiIs7zwcL8r9FImEgcNU/PEkQgVntoo5N9GbUHOnN?=
 =?us-ascii?Q?l5F6Q6AhiIi/bl+5HBRu1tH58WgUFJ7xWeDdPuVAnw8wnka6ck96u/sVfJcP?=
 =?us-ascii?Q?P0XI1PjLz8+0IGlwwDukt3L/Viu3U4LDeaYvU3qCOwPCmpp3G1g8YB/+yiM0?=
 =?us-ascii?Q?nerEoHn7mp/UzUYw3gYIoZO+KNDC5iXGxfeEYWIbhYQiBGtqDcj9mLHFErHg?=
 =?us-ascii?Q?zL3gIt4U7lW8fHdM2DP0ukzQRuSKHue6xgLL23cbU4ZgSoqb3j7M4jvtqyDI?=
 =?us-ascii?Q?LebQ8p8Lj4XwBHpQgXog6Pbd+5xRTEis12oycPuBnskIPSJHUkc4UI/F6iA5?=
 =?us-ascii?Q?7/5A680jukVikeyy0VnkkIqTRWhQ/fZh5nGhHF4ByOa8QvrXb5BemeHe4d4P?=
 =?us-ascii?Q?teHx9BnNa3EzMi2istnD+1/abnapmHORhb2IC8L32B/AQW/cTboBzA5enS/7?=
 =?us-ascii?Q?4HgWl2vWd+t8CRdlF0BlI8vIwy7VP5a4VgANZoT/gJfXdZjW8u4W8Z9CN70w?=
 =?us-ascii?Q?0iH+GZmLwZfxb9lG/mnJtW36MAUeK54JSYTH0/cZCAqSOc3XzGUcXBcm3GMU?=
 =?us-ascii?Q?QhhWjRuavnD6Qu4J4G1wUMKOh0hhQCNjyKbllV2BI1VUmuU0S/HvqCQSdLsn?=
 =?us-ascii?Q?1mver+Jkm7p32g3I3MmHPzbqFHKIPS0ZSU/fE1u9mHz6IidTFENeU2Zg06gY?=
 =?us-ascii?Q?vjgw7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+sKR83wJ/oLdXDsXRilMrKzHUzLRXxgF+3ITxsAffhzaHPXnbHg+sH4s5OvNK3F80tL2GQ9SQdNR/GawlCWTVm8ppf6DH+v+WRpE9gXitL/ipbk+YTofZ/1llaZR4nHTKdb/v5OtOSW8m/hyT/zjpbk+65X7ApRB2Y9iS3YuOtl/vTmPfGxcZJeFkeTbK9w5lL6/Vi8Db3wHa3ce8ZSH/jryUIYoV4YMwV44Cn7aAFQhXyMXh7A5gJnyrDhrvjX1HDrJQzs9N1JhJ/67BqHAxPkJ6OIvIwquasI2CkHS7I3hVZLSVbfuSxMd5PJjAlcWqzatx4K6GjGeREadUlyiAynN5GgEyAahgbuhpVAD0OKqJ7sGNUVJDQ5q3aUMuU6e8WCH8EZdMR1rIUXjgsrOL5hdjG5EmVK8AZ58H+Wepz9ONZqYFyNBQ5Voppuub7EZ3vJtRrn1NQE7mn+Ly3x5Baaxx2qjRuwyVr/UQPSPDW9z+YNCQlgRgPSUnXPFNN/9C3RJYqnrDYKMJ6ANd+Bou00e0Oo9V5au3cTFXtLv3zEq5PFjP3ar/oW3YRghPNSN6JxtPK5TETmT6/1sB6fnBFzCTjZWy1yN3Xl6V8M4VWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca64746-1d24-4746-f461-08ddfc332cc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:58:08.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5ZskUmba4BcIqRAt/x8nWT5qXRgH5iSFnCCtu2xHxERDZ30qe7etkLCK7TYqgvS/QMvRxPdMXEej91CNpLwlhWXCqbj0kmWE8YIDbJeV/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5467E3597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509250122
X-Proofpoint-ORIG-GUID: VJaLYyA3NJf3L5wIDdVqEgnAy8HC1GL9
X-Proofpoint-GUID: VJaLYyA3NJf3L5wIDdVqEgnAy8HC1GL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOCBTYWx0ZWRfX9TLDDxMvxwX5
 KGsidvP+megNc+IrIaNqPQvFgl4PiWSMU8X5/9CYPMhy8BWBFtQpTnd0qY/96VPkmLatI0obmWr
 z3o1DghWJGFRUHCziuGbqxB9/z4LlCouRLZnr34wI+NjVTlqqw8pjC/WrgtAEHaEo4TVTiRqhWP
 yFV+9SEjuA7prceYTjQ+4nAYmsmgB+kMoLh3O0rGXuWjJnDCT2Xm4RiUNeMoApN0ZTSzWq7Khhd
 UAK2Hjl5wBwH9JbMOmqUqSdiGS9Eu5SLEDatEaWX5wZ5Go4KDEqYg9B6vI+mCWBu5RSmaLmskwN
 qx/F2u7fV3I2lbd9XI/ZAeH52yovSepIXlK6fYwFv2YrtThVQhA3P1MPDbKKc496mDlNhwr6cp8
 FVzOofQTfOhj/6AAciK+byKCRls31A==
X-Authority-Analysis: v=2.4 cv=HJrDFptv c=1 sm=1 tr=0 ts=68d53c6f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=SEtKQCMJAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=sXPqrKvQQVvRe2FZSi0A:9 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:12090

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Don't clear the capabilities that are not going to get reset by the call
to _nfs4_server_capabilities().

Reported-by: Scott Haiden <scott.b.haiden@gmail.com>
Fixes: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
(cherry picked from commit 31f1a960ad1a14def94fa0b8c25d62b4c032813f)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
This got backported till 6.1 but not later for some reason. It got
cherry-picked cleanly.

 fs/nfs/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5f8de86b2798..f511087d5e1c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3885,7 +3885,6 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.51.0


