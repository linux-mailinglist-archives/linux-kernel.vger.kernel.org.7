Return-Path: <linux-kernel+bounces-747696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB20AB136E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FA27A2E10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4322A4F4;
	Mon, 28 Jul 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J7G6RpXn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OHSUbOd2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3781C8611;
	Mon, 28 Jul 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692166; cv=fail; b=E+fdl2Jt9TIH7iVe2SXWb3sN/5Z3pQcXbK1FysixbuDu0FTpkZKGOxcu3d1am8FELSsp0PfPDot/RU9hvvoN0YxqXN+qTTeA0V2IwftOoPIYZcmYPi/FMxfM6124a/bJWOISlx8Yggap7+j9wwXfyP0yt6i7506Vd5X/nTXkGro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692166; c=relaxed/simple;
	bh=bzIhDxZtLwd1VQFkR8mPE1rYFtJHXk41LAfPd8MdE8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mz0xl5pIvS0CyUAESmEGsP2X7kWdMURVdBFWplMFA859YrjTnKzKxZcax7P4Kj20PL74pqj7A67wOVJqOqk5Irm2iysFnKH7xEM2lnaXqwc2LOjFo6HuMi6Df+XLEk8iS7vfSrIGNM27xhOoGNrMfE/5R8uWfgscJcBySkHAdgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J7G6RpXn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OHSUbOd2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S7g41Y020408;
	Mon, 28 Jul 2025 08:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cNjMjSMSie9Y8ofPaF
	paLD1VwyBi7sBueNPyFGu6g74=; b=J7G6RpXnNMTqhhmyEMoZwVpPHtNh72l9cr
	cYfhWwJIrHCKol9ueFJPVojj3Vi+G7ebkA4/2hlNT4BKKtFraBMbuTMl69lkms4z
	W4oSznjVQQel2h0oT7jySEXjlvTriEnLQTbou2ni3EzU6qykvRCgCNLENB6XIfKb
	Pnqsek+R+YIgCauJfc5Fa5rxOsIAcxZabkK+UNmkzgaycX5hbHmh42ka68MB9ETG
	YQ8b4MqH7iAxHZ8t8/loy5gksizYgYEM0s+Yk28OaJskj1HfRK8OAat8ttbpko2b
	TOjVyab6rFPlJGolpCfvizR1+gEyKQ4qnBb4viwUkkXmpnI6uMBg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29jrjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 08:42:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56S6xkVQ035233;
	Mon, 28 Jul 2025 08:42:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf8g2n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 08:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuw5xuGvLWpZU9qGIJJYk4kuIFajYmjzUW/am/+FD3nQlh85ZorpGlb0sySJuylkBYcFkpbxYtc8M4COtJPsoO0BkPXrRa649HrEK2WjG9CHR3Do3OCyNGKvDHUni8l0W7ra0BdlXjHHLSLjuU88YL66+sHS7XBpThiCpnps2C2FrVQYotxk+rf3zqSzoGXr34XOraAogJqAKM5d8HX75hg0Tkr4dNTZH7vyy3zC0Mo23JorKLi/abWE2H/v47Qb8w9JrI+Wo3LQuX9N0MXIeVw7QLmktZzyl25mzH8nWFSaPgC2qO7xz2f9+InSkzrI8ozaQPRP4H2sFLqckSdFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNjMjSMSie9Y8ofPaFpaLD1VwyBi7sBueNPyFGu6g74=;
 b=fG6lpASGQja+R/8wI5X2By1LKH65XqLEWtqqoVIMFQwlrbQ5M/oWDNMvUOifHwII9z2rzybZK0wLlYGTYL9ZeT9o6xjzgr8YHA7fqwlBV5kN72czec8TKJi+41UJFLWyDBNgJN4T7rfkbcrTBHDAy0wQVjw63Oba99foCgLoY6HJEcJNtaduiRMVjgO4UjUY/GPO6KSZTWj6bV6Gam92Qp/Tf/UKtH12fdG3DmM3vpM8bzoL8xbghwk+AbNn1sXC8/GmmDMl35e4woLjyGXK+/srFNXgD47NeLpjbP6jzx7qvV+iIsHrgykpU5M/+zGBd1iS0jvkU3phxW8BkVWrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNjMjSMSie9Y8ofPaFpaLD1VwyBi7sBueNPyFGu6g74=;
 b=OHSUbOd2YtIFEqpVLfi50x1dP38EP6IN7277ZzDhOnjOpI98TCwaxFHvalVgeNVTCNzWxn8L1edfx63TFedKQKTwod3DPj+pr/U4qfZA5cEx0JasiLuc+1fb2KfvPgXlCoXnQ8sHHHTh4khF4QrXCoBw5QYTr86G5Go6FgFRl6s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 08:42:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 08:42:31 +0000
Date: Mon, 28 Jul 2025 09:42:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727195802.2222764-1-sashal@kernel.org>
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a309e1-2ebf-4741-7c51-08ddcdb2b103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VXUO/gREEAyLlF3mrWZo80RSWphcCgDFdzxexxI+UVJMNrNWDeJYzOvK8JDO?=
 =?us-ascii?Q?FqlEt0r4udIXqEY6mDmz2mWZLE1EF+649aFFV8jTqWcgI/qre3N+PbFXp3RD?=
 =?us-ascii?Q?ceDAooCAheiWsbapaovXngGMm+/My/nXeiKi2Ny7f34kmHwpCtePJepqt91O?=
 =?us-ascii?Q?4BcogIajrg7xXVIzW9MAKTtjnDocrppTjInXI2SCSBMO/fxQ0Fnu0ra7eVnv?=
 =?us-ascii?Q?61ILhuxnVuvlRfuZkMpQO+jtMyLhPBcWfAe20aiV+X29u8O/ulhvbxx9uvGS?=
 =?us-ascii?Q?NA+LmTwaUr2H1tU5dRhXnpivc96TiNiNn3Xw+2sC7D+wGz0sZk/EHVDjQRL/?=
 =?us-ascii?Q?SIOeIEehqz4UVMEO0JB1S+x7u0cLDKLDEsHgR6V2zCmzKFb38etlCnVBcv6u?=
 =?us-ascii?Q?izMiOkCvALSdWxyGp/OWWzY1YPAJSjw+UNK0/nFv3rdm77FOiqZU/iy2TvkQ?=
 =?us-ascii?Q?J4bTY5aaGp4C4EpmDfyh6qgvMVRs388jM5PZtbOvAjUUDcuV9JYd/aywOx+s?=
 =?us-ascii?Q?yOn6dSs4EtAkjyvtzKFz7UVdiFKrFpw1441bnBePh1yJTceXAAU9AYbCWw3+?=
 =?us-ascii?Q?kDpgNNmkmT9qFoABhSc2dJ3Ab+6rdRyQF7oE7bAtEpquYYvwiHXJhHjcvxgN?=
 =?us-ascii?Q?qrHrP1YRPVDwyFbRO6z9gKDT9CXWg41wDJxUUX34j0XRKU4OK/oe4/iUtk+3?=
 =?us-ascii?Q?nmeLvIaIqwtz1uZFOO0IFwDPp9Jmi9I4mejOlu1nbvw+xlTcAMLVmOwnDCqp?=
 =?us-ascii?Q?upSJs7vpxRS41JzMyy1d8ishM4auazX1zPkO4wtp+vYUnLyix0ebYRMzJ6Ea?=
 =?us-ascii?Q?MorJjaIo18NYnSRLC1CK65Kt9VLFwmyJ6RDVK956QPvlcSmSUEqw//do3e/T?=
 =?us-ascii?Q?+6JIyjBg2RL+kp5/ikOkuQCeo2KffwUc32daZ33ueA3NGLeBtlud/+lig7z6?=
 =?us-ascii?Q?oNcySQPcRg1JxXq+idG4ddDDW2wR2/hgqVdiJOu+Uuyzu/XhwfXkpKUcpNZt?=
 =?us-ascii?Q?GBSUDl8G1sYo6gAxojpmS1Px1PhEN9B/t9GCEyEx20Z7gIHOmWSOXQEVrMjh?=
 =?us-ascii?Q?7SAfY3WHoGfawgviatBDfCaAhH2yWSq8xAnuq9Oa/ON5+UedaQEQ0hTOsxwu?=
 =?us-ascii?Q?RL2ElldDVof/uP9nWuyvqfJ/og9qzD0/C3wQDQhWNos37sRuq5TGHM5dfmP9?=
 =?us-ascii?Q?R9r86X2+3RJVBq2/k9STJR0b7enLHi+csTitb3Od4jSW3W99xsQFm56KZ2GE?=
 =?us-ascii?Q?mmJ6NkWBl9TOZ2rrVmF/P2IWSJa49p0gAZer703X+Xy+LA+GwZuV5n8pgy0D?=
 =?us-ascii?Q?13Mje5tksD7Vuq4glUZGOr7WTcQXUGj0qfqTEumIMuYxyQ5zs5i0YGjZFSRz?=
 =?us-ascii?Q?5EQzepEEtYGQZZisfIp1D3PkBq9OwdRZ/LxSB2unX4GGMgxjMJT6MtO5gMUa?=
 =?us-ascii?Q?Wq0+zNBL4hQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rECe8g3LuS6cP26RDFJijE/iSH9ghbJ1efERLCrdaKQehU01VQCUrzs2zuXT?=
 =?us-ascii?Q?cORBm/30i2VqH6DvqGIrN+0ZAeqB4wFrNcau63RGDCDZ38j7D64rzT8WTZzU?=
 =?us-ascii?Q?Wv5RAIgBHZCtqUXNaHuTkL9myk0rEl62nUhU6l9u82rJicqblTF8ZyEBHalA?=
 =?us-ascii?Q?OwT9Bgp+BoOhZuelN+rsYhv6UHVtSurKteVccbv4/Pe0/RgKIbwFbsTiHNQN?=
 =?us-ascii?Q?pjRwqqtu69fUC3jFkYX8JwgTD2Kt0nxR8wZTu4uy94P4h/9E9kmBIC3M/gTJ?=
 =?us-ascii?Q?+rUR73Mz4LIkDj1SHoRQRC1kUXPPf1j6wPrk+SIiCL/ugj6oVi3jMnYW0ErN?=
 =?us-ascii?Q?D+Y0Gv+R2hXlcrDDpKH7MmLce4dZfhtzm1Y/Hejdz7WiksUgqI0Gc5KRIzhK?=
 =?us-ascii?Q?wKFafd/+tawbAyJaSGIqLF+MG9315lqUaX3jpNzFHcL9UsxQDq4HoxRfPsmO?=
 =?us-ascii?Q?6ROWmYKZf8VoBp2u19HteTkcdYC1Wu+cO49+vOO1ZiR3dRJIxu1Y4e4BIf73?=
 =?us-ascii?Q?4rmYQhB78KKqbaJ/1zlgyRrciuydy3kPNU/vKxas8zAXQmS/8K6P/LfNK4jl?=
 =?us-ascii?Q?1Sg3p0lc2kVDkwj2yn975ztvAysIUjIEmjkINQk1aYgdaIcyuGCLij2ILFW2?=
 =?us-ascii?Q?4XSkiMKk+9riz9E0q6h9NLnHY5nbA9n5gF2V94bXPMJ+hTkBGt0yZglpRFqS?=
 =?us-ascii?Q?CgC6u/DU1HYKVNNL9W4B6uAHM09E7mj/3tyZBPpOrZ0nGg2wuFtgdfkmtMXg?=
 =?us-ascii?Q?aPzxvA2qV0H87vXmgRmYOp6IXdMs+mvL30BroyStbPoNIbxoxRKpTc9X97Ty?=
 =?us-ascii?Q?fOlycNIWMbsSF+HmXF0fRo1DFqKL7dH7uUtb3hU/LlrYPQYTU0FdUI8GFE38?=
 =?us-ascii?Q?LkO8whJmSimnN+2QxGks+TIN7j9Ly5AMSTHljxgPr44eaa+PIUXJKhkIa9R0?=
 =?us-ascii?Q?kxitenxNSf8POIfl/4TWDy4mXy6RNIhholE0AclBHsWlEgqVpHEb3js2ZxZ2?=
 =?us-ascii?Q?DcZowSDskI7ddCBvtb7pNvws0hKrMtcgx23qUwQhzQqhQLK95KexYB6G6MxQ?=
 =?us-ascii?Q?Kn4341YLRvximUSb5LE2kHdnpCL/u0Mc4jTtOlGv+EpaF6qNcwNL335sU2H2?=
 =?us-ascii?Q?6+m3A1IQum0RhvHCQBAVRx0ds354JznauHdCCYMzD5VXBL76DKizYac3yTIW?=
 =?us-ascii?Q?Gg4j1nj6/67T2XEWC2Wayy87NFo8EcWaVn6Nk2oeNiQHA0SlF0wO9fY5pZtU?=
 =?us-ascii?Q?A5Onrl2d4z7q+nLDEphtwnpn3q/BpVxqMBVb/9BUejCehbeV5YNIw4VIVp34?=
 =?us-ascii?Q?ZffuIvUHSdyD6o6eOcEoJtNLIYvD5hY18Hzr7fg0esdA0/wwonxt+/W5fI17?=
 =?us-ascii?Q?vfImIfB6nRC+So1rzCAQISovYPBn8YlBFezJnAgbGIGq9sFA/FJtKrzMY5tX?=
 =?us-ascii?Q?+ze12nnQ0RKMfDZIBEjiwdH52BOWjUUCqadv/zNnLtB8CHLAsW+lTjxF6YJD?=
 =?us-ascii?Q?X4Ktl4hfVUm7/sY6Rl32JBPvBrgntnLU4UwO8QYWtywUrfFNxPRegmo48pXq?=
 =?us-ascii?Q?OtZHaghF6m/cvmTxRee5nR6ERuWVQzhJ1RV7svZv4WE4zc1usYpKlW1a3+RR?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m71F7/MoBpWzARllxY1fd74chEjC3e/pu+iqEL1dzOZ3tvToE1m0WeiAUgZlFhGh6ToGkXDENHpBv0f39x6WcI3GzS1lZGrzZvbkWmDMulKLl81deAt35HQeGdYPkvMhSNNBTYjI+dh8gIaRjgqureNo5M2u4w6vZakPmU8p4oa40TK60y1/XBVlJWVoRGIbRbOrythe6fMuXJklbS85vHRzfnJPY8HkaOXBT/X3fcy9eRc+DB43eILYZyNwEy8coxBVOoI5d2cdS5Gid1gjrFdNziPhQvJYX7CoOQjd0Ai98Uw+P1jFOZPH2mQuisRnxw6UMJ4MrGQUEjP6Bfsq59ChkEjkFTnTHiPEFtbOCr9FlzMZF5JJPu/td9JRAeIqT1Ka69oe2sKycq50PLmSNrm4+h/4VvBBQAby5pamphaM2iFe6oq3zgUSs/dxQFbBWdI7EpawkjL1wD1bVATPyuJd1aKGKb5Ri9/Av/YfnaYOQmLWzHrgs39bGt81rCke8ZLNBrasuZYPkJkRy+SlcRQzj3fyj3D1NEtLgSl1WtJe/wJIyOg5PQCpBMABDH44onXfQoeAS0qsksFtH7x0TeBNITK7Ij0aQkL97S4POO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a309e1-2ebf-4741-7c51-08ddcdb2b103
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:42:31.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3pgip1hAhKY01QRyKz+hoFL+EaZ4gcBasI1XqRoeaYYd95T1kzVT9X7dMEtmNHJVahoKV6NRTxVxqXv7PlcR109cXU7aBA8NWozHSERXjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280063
X-Proofpoint-ORIG-GUID: Atcin3D9TBo9hQzVtr0Vi5_oOt1Az05M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2NCBTYWx0ZWRfX4hXRetAbzcmu
 yodUzLceQQj0n1Q51js819Wo4ae6OHeeXw2bu9wJD4PiytOae9WRojCM7cLuXIN/Bk2sdf/Sb22
 Qm9l7M19c9h3S+8dMBkfh+vfpgRjJ+FxQ85NZI2zYCnvqhgFb4o5/BffpvuDjaW4/UjjiYyMl1L
 zrqr9nVvxsxEFD0tOE5OYGctcmWqnhOeWTmcu5X0yC95zNrMA4uTlBs8Ie/lxIVJzQr6Blt0u9V
 8ghQVhDRwv658jgoRDWosL9HSEkSJ5oT0DrQoeQRdneualYo+IRs+8JR66mWZWZHV2yMUa21fYt
 iZWP6QGlStMbYJQDYJLxdHLJrMgcJlNmVhCCdEzUXkALF7m3SKOxHjU/i+ntOBqimVQSaLXxGSo
 2+WuxTmwAMBtKzcPX1KCGK74naYZeCxfOpU4rfpdFMcChFWnr4Rsy/LvOdzmheOwrDjdrI26
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=688737fb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=4A_fLyBlz-x4Rwru9cYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Atcin3D9TBo9hQzVtr0Vi5_oOt1Az05M

+cc Linus

On Sun, Jul 27, 2025 at 03:57:58PM -0400, Sasha Levin wrote:
> This patch series adds unified configuration and documentation for coding
> agents working with the Linux kernel codebase. As coding agents
> become increasingly common in software development, it's important to
> establish clear guidelines for their use in kernel development.

Hi Sasha,

I feel like we need to take a step back here and consider some of the
non-technical consqeuences of this change.

Firstly, there is no doubt whatsoever that, were this series to land, there
would be significant press which would amount to (whether you like it or
not) 'Linux kernel welcomes AI patches'.

I don't feel that a change of this magnitude which is likely to have this
kind of impact should be RFC'd quietly and then, after a weekend, submitted
ready to merge.

This change, whether you like it or not - amounts to (or at the very least,
certainly will be perceived to be) kernel policy. And, AFAIK, we don't have
an AI kernel policy doc yet.

So to me:

- We should establish an official kernel AI policy document.

- This should be discussed at the maintainers summit before proceeding.

In addition, it's concerning that we're explicitly adding configs for
specific, commercial, products. This might be seen as an endorsement
whether intended or not.

Thanks, Lorenzo

>
> The series consists of four patches:
>
> 1. The first patch adds unified configuration files for various coding
> agents (Claude, GitHub Copilot, Cursor, Codeium, Continue,
> Windsurf, and Aider). These are all symlinked to a central documentation
> file to ensure consistency across tools.
>
> 2. The second patch adds core development references that guide
> agents to essential kernel development documentation including how
> to do kernel development, submitting patches, and the submission
> checklist.
>
> 3. The third patch adds coding style documentation and explicit rules
> that agents must follow, including the 80 character line limit
> and no trailing whitespace requirements.
>
> 4. The fourth patch adds legal requirements and agent attribution
> guidelines. All agents are required to identify themselves in
> commits using Co-developed-by tags, ensuring full transparency about
> agent involvement in code development.
>
> Example agent attribution in commits:
>
>     Co-developed-by: Claude claude-opus-4-20250514
>
>
> Changes since RFC:
> - Switch from markdown to RST
> - Break up into multiple files
> - Simplify instructions (we can always bikeshed those later)
> - AI => Agents
>
> Sasha Levin (4):
>   agents: add unified agent coding assistant configuration
>   agents: add core development references
>   agents: add coding style documentation and rules
>   agents: add legal requirements and agent attribution guidelines
>
>  .aider.conf.yml                       |  1 +
>  .codeium/instructions.md              |  1 +
>  .continue/context.md                  |  1 +
>  .cursorrules                          |  1 +
>  .github/copilot-instructions.md       |  1 +
>  .windsurfrules                        |  1 +
>  CLAUDE.md                             |  1 +
>  Documentation/agents/coding-style.rst | 35 ++++++++++++++++++++++
>  Documentation/agents/core.rst         | 28 ++++++++++++++++++
>  Documentation/agents/index.rst        | 13 +++++++++
>  Documentation/agents/legal.rst        | 42 +++++++++++++++++++++++++++
>  Documentation/agents/main.rst         | 22 ++++++++++++++
>  12 files changed, 147 insertions(+)
>  create mode 120000 .aider.conf.yml
>  create mode 120000 .codeium/instructions.md
>  create mode 120000 .continue/context.md
>  create mode 120000 .cursorrules
>  create mode 120000 .github/copilot-instructions.md
>  create mode 120000 .windsurfrules
>  create mode 120000 CLAUDE.md
>  create mode 100644 Documentation/agents/coding-style.rst
>  create mode 100644 Documentation/agents/core.rst
>  create mode 100644 Documentation/agents/index.rst
>  create mode 100644 Documentation/agents/legal.rst
>  create mode 100644 Documentation/agents/main.rst
>
> --
> 2.39.5
>
>

