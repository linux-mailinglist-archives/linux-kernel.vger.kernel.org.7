Return-Path: <linux-kernel+bounces-789017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB44B38FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062577B5037
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C520F2EAE3;
	Thu, 28 Aug 2025 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ikwjwvo1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lme/da8g"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5979F5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341062; cv=fail; b=fumdJWy9+QXrkDNY+L0Ty9VntG+q2h0tcHb1Pj+ETCUd8PNfmvRKyPuccKa0nEfGx4tmiHEgcAdlk4YihtBz27n6SsTF6tsw/i0fJmzNnkqdTC4XLNwUNdJmNzXXlklV3SPiNt04Vi/MK0rHgJTl19BWxI8/Rh3r/H0bx+NCzFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341062; c=relaxed/simple;
	bh=2/DxP3wxV5V2DpY33JwhRnMPb60r3ZF42vcuJrspsJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLPlB7G+xuTNOPBlk+Zs47rkS8kWyeER2YrQEsvi3OxZWlX7fMsCycwYByIxq0e5iouPkK2Lykmj1uhBqn7yMZAhFWQrh6yVi/p1HGq8q3wf6ktZmK1satXx9KR2msqwcux61t8ntG+Kl9EIjxFddIkfVKN+D66SLrs8Op3e9SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ikwjwvo1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lme/da8g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLHG9Z015532;
	Thu, 28 Aug 2025 00:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+EXQmozK0gJJ6PkG648stwdb9xsUMSY06PKqIWWvbHI=; b=
	ikwjwvo1h2F/N76cqZiXKNIIcld7wV2/o1FmXvchWXotbKPhQsKyqlFD3x8HRdK2
	xFV53DtG3njGF5KUkRMBoLGdSyzsBpOV9vUvrw8P6p8eCKTC3+YqzDJq4hZ5ABX6
	xV1KvcVBBJvc9DsxRqdtli65Gd8uJ0c7E6dqcJqsxcxyFXt6nuYk+6y+a/jc2Icr
	0RF/CMHNXuOQnIQyWy/YAVej+0LlbN5Ft3d4bUECWgqa7h0+w0XWbnokHbHZ6W3P
	wY01qkuWHiCvYje/d+BwxKkK7ko4CvpLi1G+uWEd3Vuyk+xKhEvapvOmhk3kj2L3
	4S0wdZwNzdGjasbonuHaWA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e27m75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 00:30:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLpvNd012418;
	Thu, 28 Aug 2025 00:30:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43b7tjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 00:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5IHIo9dfAy782QrIwV8vfRa70IwybQxTkP5NAxf+yihh9YuTDbd7bt/ycYRZVU99CqWOWPgPMszLgThRT5uiuaMssA9pYTQLDdoqJsMwSKdJsL1qE7pOX18uBhIcOOzK+aN959Pvxqp2ds/ZzJhi4Uk8Esh/nd6zWEKI1DtXneJ06aNr+g1/MLIRx0EJ7XqzpbSLJkJTk23orIbujFI4qIeiAA9N4+OjL5LgDv6VmuLYkuBKhVPrKjmPCwpu9IUFxsXmcaSE/jcpiq0YpiANJ1CczVpD1Bl9mUFPEdxtugdjtEu07q7TR3Bwl8L9RCqPYv0zG599SST9m39+jNnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EXQmozK0gJJ6PkG648stwdb9xsUMSY06PKqIWWvbHI=;
 b=kZoiC9a2VUFRgK0V8ND+fiM9peyAYxooLRnFXWtICEYIjBhIGZHEiU0m1RY5HEa/WqleROYpPfSlDgZ+aoTVeLIgjY8CzXPmtAfiSr4cMy6TxFIh7t/fdDoyCOhS/LmJlqKgH70FsVoNE0Hhbj74M+VoeUeDeZMAexEzGyesAOgl09ujADiiu92rHL5moc5Th/oIo6GmmnGY3lOOOomAnA6mHY8kyDdckO5kgmPVrI7nHgtlzIKHDIOC2DgoMJcwToQE21Gz4EOGFiiFaanILSaTaiFDkWM9etLxeniDIpDJRP+dIv0ketamzxvayweDZ9IDy5BMkzKGCvXFOizdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EXQmozK0gJJ6PkG648stwdb9xsUMSY06PKqIWWvbHI=;
 b=Lme/da8gk3jHCiU5YNqScAwJd5zQ6Vn9jkPa2i1lEHogejJKOz1yUzeitVUtqToRYDACe0oA28YD9iJwRthHom6FlB/GJT1Kq8c6e9W3ZJS0DxQKFfyQEthkZQyXFyFlBkfInLBXbUykOPM3Fp5YPvGkamIt+84nz3phCljnj6g=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 00:30:48 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 00:30:48 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sidhartha.kumar@oracle.com,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH 1/2] maple_tree: Fix testing for 32 bit builds
Date: Wed, 27 Aug 2025 20:30:22 -0400
Message-ID: <20250828003023.418966-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250828003023.418966-1-Liam.Howlett@oracle.com>
References: <20250828003023.418966-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0192.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BL3PR10MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a083cc-f66c-47d4-8203-08dde5ca22d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fHVJdd3nOG56eRjzFEXWxFMo/LTfO+BW3JpK54HE+B0wFaL3e8PjOPm23JG3?=
 =?us-ascii?Q?gyij7ilBiqMQ6oIalV5khfuwzAI0vEplhXjDejjJ4aPXyCfk/oO8RlAEycEk?=
 =?us-ascii?Q?gdWO15IhXCv8BrU1TcRWcVooC6qOR6Oeh+5WvNKqyj6BXyxEYkOsvE0+pNK5?=
 =?us-ascii?Q?MwyWdTGBIGtE6k+bcfQVl2FV7tWrv+S7mLQ9qSyiJg1faO/Zg9JywuBLFcmg?=
 =?us-ascii?Q?+I90Zi9OzaDDIoOIeUug1Xv6zFBrDp4TIGv+vKMQ+QX2DErC2X9OBmsqGutG?=
 =?us-ascii?Q?S6j8/ZEgAiSZZA9gQU8HNvmxgCgC1aA5QYaBAFfBe9crffhZnIGRn/UfkB1w?=
 =?us-ascii?Q?KoV3ZVwb1j3n87bqCcECOUoQab6DCsyGolUTUMxz8vNX3l2VyiIXF9SZ3Sam?=
 =?us-ascii?Q?aj+5HDwZ2+9OjfSkKsrxar7GrAEt2Qx/xZrNttRd5zope7B6GdaHgksr5wrv?=
 =?us-ascii?Q?WdlPp9QvKWtsjFkBPwzdYmDfTi4fM/u8pBBc9Y1JzSSYDHoBKmuSgY4lX8a3?=
 =?us-ascii?Q?yFDrKrmQncwnFse/tE58J051AxExyqv+uJDc0vkabbei3HELhPVQik0DDWn9?=
 =?us-ascii?Q?FgrAMbBte30DarCjj3m8NeCAPYVJVigegg8qxTqtnUGxWsRG5HUr0FsNvLy8?=
 =?us-ascii?Q?6sWccl4nJB63mk6Z7krVbJHq7Yo24ER5zAhSthziCehtNXaxT3UAubh29rHN?=
 =?us-ascii?Q?2rZpPB8AvDC5/fp+GJMrgZgi+aZ6Ig+WTKNAi2vH5QzHS2KVzUxWMFqMMqWD?=
 =?us-ascii?Q?V6yy331jXpyFSB2ODG0n6NHWwVNyr1G/XDtRzYZLMKetIZG9LI9xjH0RH2AE?=
 =?us-ascii?Q?sODnhZ0GidEB6wmIoiKAv/KuduPZgfTR9k1QGOJObe/i3melXwzBV3eQGxac?=
 =?us-ascii?Q?gOBaq1C5YeLZsGLRDdgYE0zGIixG9eZiJzxGCXolB4UXTXoQ3Z+IYaiBp9TV?=
 =?us-ascii?Q?A5F0+I2247Ofxs2Z052MU4kSWpkZXQG4PNuKROV07d+483fcNX7R6p4QHjsA?=
 =?us-ascii?Q?kpVyxUamZlAxyhJ3uMhZ6EQ7lgg7stnpTqwLWLwGGnbR5uJmxudGW21NdVNB?=
 =?us-ascii?Q?/U7RmlCE9m/aCMUcknVGM64p/2ZaAUN79LITiE0Carz/fWhc5qF56qdMg2IC?=
 =?us-ascii?Q?BC3pUrG2FSAnduH0r8s9wD22SsJi4m01UHLh/uuilvnl/xx6/EOWZX1NcQn1?=
 =?us-ascii?Q?7zvdVAChdoGROY6LIrmkjKQjIp33Y6DafZdxnBEUkPEZwpEKWeThtB2JzPej?=
 =?us-ascii?Q?ME7tb0p9e4RvO/j+LWf4lZyTUq+keiTvoDHesQmWfqsaUVesTclBd5+Pp4+K?=
 =?us-ascii?Q?DRjI3k8kE0RYSDGevr3DmUVVxV9W7/Qfi7DkGuSntdcHjXdUCs6umcpSar6I?=
 =?us-ascii?Q?1Ftcj+5rNM2zQmP/7lmXgOQJpZasIJ9PGQlGRHZWw0LERNCLciezBnoQzusp?=
 =?us-ascii?Q?tcZbX/H0Nyg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9vBHyy6zKB87eNlT7XVN19S2y2hx1syOI7+/Fjpr7Hm6ys+ijqI3LKHOVtl?=
 =?us-ascii?Q?iM+qgnx/BzvZumFupc5VUOXMLVsNG2fgGzsVjeKi7yxTycvDdhDxyQVxO/6H?=
 =?us-ascii?Q?K8bztsoo2wLEVASY3ASCgnky5fQ1jvMlRvbAaQty9TUTnZjHY6/l8TaVbxnr?=
 =?us-ascii?Q?SJmuAp6cK+6Uq64byJopIb8kW/A2+6ojSKexJyAiCMzYdEFC5Hxn859JG24U?=
 =?us-ascii?Q?2uevIdjw/HzHZcZ8hEacLearxlxFFBqARH6C1RVWGIx73LlSHIN6wtDUb0b6?=
 =?us-ascii?Q?zRX2MfxteMu7HUIKwJMtqVeZIMnoScjgC0X/xqQxjRXWNI6oXBJfQU2Ie0aY?=
 =?us-ascii?Q?EWqcWAkgVD51KZTyVCt9GqpfVaMCoUu+6Sx39RkddfJO2rePaPfgsQ7ZBM/O?=
 =?us-ascii?Q?hp87rul5tTrq0azoKTp6ZH3KZsGXN7kGNxQ3n0/f5g4JpE9oyb78OglmvD+Y?=
 =?us-ascii?Q?1D4kzeQmr/P+xgbO1EYwhIQaBNu1uXWiaFVsG3Y2QrwTBJ3DBQdZqAU3avIS?=
 =?us-ascii?Q?/UuY4FvOVDq7c2I8xfZHtaGsEYC+ZQ1GWIgzlDZzM47Tc/DaiDZEpOdhxBon?=
 =?us-ascii?Q?mR5dInpzEKA6EgiUJbLXQ5tzWAcGzB7yztjgqiqttXqMMMFRMWalEelCzf2R?=
 =?us-ascii?Q?NoxqAOVbn5UXz8EfVUVG4cvRQm+dKp09USy4s5VqoWXDsLF2bVzh4WHPPGNv?=
 =?us-ascii?Q?NyzUjks/Axb642Yg+yonra2y6kXG6qn7aGap2Akek85xCQprh5+3/Ha1+4Ej?=
 =?us-ascii?Q?4dWzm3/4H06kzz8Gkz53vgPMo1SVSqiYSXuoEDmch4ft5KcahT1VVu4ruWRX?=
 =?us-ascii?Q?xsIXpFN4Gkw7KvVXoUmvLFfQlfstw1878YibgMqXLLISw798h2PdkAPCEncb?=
 =?us-ascii?Q?dCM8AiMKB+7KgF8aysCcNDFFF9LqF4gr3Muk3tAazRGXcgejnUykT1ykNqbJ?=
 =?us-ascii?Q?Ni2vlo9kR61vX5jtafVlMKP/52UusRZMXn/jhQicO2bygIBz7VacBx40HECi?=
 =?us-ascii?Q?9+C8FbEHiNlJEE7XkmV3tlyV59xFQkT7fnulSxAelZi/Pr8/1P7t/VQHbFZb?=
 =?us-ascii?Q?KDz+yLvapFEl39SahFJWBSpX1hrJ65d51n9Wu0CFxtUZuFsMDLd6zXWzEmEj?=
 =?us-ascii?Q?/tSF971xgHLapadcpNU8Uiya56tFKYcXM2o3EDtgyylXCggYgtXpXjfQj/9R?=
 =?us-ascii?Q?ghI+ob5IhcDHycfN2lGkwccYWrq2kpiZFmf/s9OVWozmVG8lJuDmG9D+92Ex?=
 =?us-ascii?Q?QwEKJS2Zwk/NGEJaGh2/JbhPIAQ0JrbyHxVCfm1C8Kqbegj1jXMp4oop+bOn?=
 =?us-ascii?Q?2o3TO/IqVnqFC6XuBGkbUBHWZ/yu2fjtUNsgtXwuBMDaQkJYFNKWYsnmVhtX?=
 =?us-ascii?Q?Y75/LPTsVNptdy3xCsKTyggBDyUzDH/Uhdhpoxd5107a39rIrgq7SMo0YBiu?=
 =?us-ascii?Q?j4awAzKHGNWsHcFs2fKmtR2nHkghZrGzDl+vkYvxYQt9rN9TIGGQKKdiGw3D?=
 =?us-ascii?Q?jXMJOBY6eOug7UlpByW/kGVsPBbPePhm3xVXIwJlBibOBbgSsNzOYD47xWFr?=
 =?us-ascii?Q?6dqoBLLf48Vvp8q+CAz44hSvNESRr8RdLTV3C81TUP/7i45xxYMg/sjAdvww?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+/iBRM42oorJbZ9IcsM+UpppeWp1TWBEdIIj2mFm5PKjLm8F9cwWYjG66L1lqfigrGJZcvepmcu0HxugZNVJwTZ+ysRdUaLCL6fEn5/gGO2mnn1BLUFXqMuJONME3YCazCZcj7s03KoZ/T4FZsVVSPieCIQO6vBP2b4QDTqBOQwG3cjYZeCk+JedYBx39qJbIS2F70A5QiGoa0hunZBAmSVt24ElCEvF/ficR4ysw8PhVd58AX1XTjq9qR8hewQUbdRJ7XI2AvQvRAORr2QETytPqcM9ckqCG4Kr0ge9DNJsJXaibP/zKK3QYOyQzCi93M1Bx7cqDFkDuVJ8CJPfSbcWt83/2zt1TEQagoUHx2wI9+h95cP/xH2P/L6WaaHNU+iw+tKA5vUUAtERTTA4rndbxjMhLCihOFtIA1CNfUPpjXAGOJu6iH89dT3V+m1qj7kEl9tdXIX+Kbh70egDI4ibpC2qoTCNnh/C0oCXsDneUcOwqBKOhHQ395rJaqtG52yndq895VDpu8pYth95F7u28GM/fKYCi5wcsoZ8aXo1NpitLeYiSJh683uIF/yOdpKhgCRZMFfbCKYTrAHRzo627SfqtQZ1WkQXWdfDoaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a083cc-f66c-47d4-8203-08dde5ca22d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 00:30:48.8371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xh0Z0bYlCkK6sWUrNNVX+a+VlSrgWZxhHZtD1tP7Hnjtkzp6WK+LQBIJvbh4u1V0lUKrKsrf3FmcQCdAewUpHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280002
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX1G7otO5fTAM4
 FT/laAoE/XPSJr3cVyWypieU6OfZD9Rcg/q9E0JdG3TWb6Tb6VBpbFbTXh8uxohcm9nvAt857J4
 fePnRvH3mNZlTVwblbvrEDAJyAiID5/fBvKzj3k6GTM3bStJ1vfGIjEf7zG2jHRJC8qvDTVviF+
 EfPU3knGSEeijG/dPQJunKi8mQLdD9zATqtpYGYDSszMDiG1VF6DcSfWMwCl5FZfUNR+rRE1nGf
 06B0OhLzg9p3lSmixURQideftXKdK1YDRY85CkkKncUGnSfIep+5SLDZo+LKJYzfG9bFYHX9raY
 nvoqbW+JbM0xZvABtlAzkRUkxChLqktwawhid/+4LH9eGX72x5qBLWLXOQ2MKFJKj6Btyr8EaFe
 DUXuf5UgHueumfqh+uFwvF4du/z6Xw==
X-Proofpoint-ORIG-GUID: KlTGXVnhKoM5ZFm7Y6UXGoAp51__YZpl
X-Proofpoint-GUID: KlTGXVnhKoM5ZFm7Y6UXGoAp51__YZpl
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68afa33b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=UzVOrZvaG17i3bQcLQQA:9 cc=ntf
 awl=host:12069

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Some tests are invalid on 32bit due to the size of the index and last.
Making those tests depend on the correct build flags stops compile
complaints.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/maple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 172700fb7784d..90a0db45a33c3 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36428,6 +36428,7 @@ static void check_nomem_writer_race(struct maple_tree *mt)
   */
 static inline int check_vma_modification(struct maple_tree *mt)
 {
+#if defined(CONFIG_64BIT)
 	MA_STATE(mas, mt, 0, 0);
 
 	mtree_lock(mt);
@@ -36451,6 +36452,8 @@ static inline int check_vma_modification(struct maple_tree *mt)
 
 	mas_destroy(&mas);
 	mtree_unlock(mt);
+#endif
+
 	return 0;
 }
 
-- 
2.47.2


