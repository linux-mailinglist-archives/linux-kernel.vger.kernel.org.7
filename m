Return-Path: <linux-kernel+bounces-762663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A59B20975
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076577B009C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FBA2D8379;
	Mon, 11 Aug 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NpvKB4Zi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KQdFZEaf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C72D5A16
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917082; cv=fail; b=AScdrlsXyjASxBioHFPzT5ek1leAqV2qSeL4d19o/3CZjgjQ4hRBBPQBcx5m8ggB0s2JuhJ2Q+82tdir3VKCEDS9/CdQQepvMcIMWWtS4bgh7KdbDC5NJ7en6HkSIJ0CTjMX79t0RCFDk8eRHHI5pfvwe2jZpHrIKdsGzb8yon4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917082; c=relaxed/simple;
	bh=wDoKLYAeE1KeK0pxGtoX9bAa9V/SxJ+wgnwNWapVkM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fm8hgnO8Oqb1tqbELAf6gAUmQs4Lv9omtWXkFe/4HxEHEWWzvPFdCNJQNi+3h6Va+VdI1QagrpUD5SpRmtZlMGyWhIbBijjZ3xHE7ZtCRua92yXszab5C2bNez93tX0CzAiLbSPp8je8KEpGl8/ib81MVKFYyBgoa6gUHevsKxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NpvKB4Zi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KQdFZEaf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uBJQ010627;
	Mon, 11 Aug 2025 12:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wDoKLYAeE1KeK0pxGt
	oX9bAa9V/SxJ+wgnwNWapVkM4=; b=NpvKB4ZiSGs6UTCDYPxMljQ/UzxA/QGRy1
	1NL6IjrLjy8D7fKgb094YP1bByosx3sHPQIz7G8sffPs/ZbI+3+eUoQ7LIibc21Q
	ehmP6ph7XCqWHJvJNzUPpPEolsjTcphf0zeBTIbHk73ygDYEOh8vmorwBYHztWTf
	NQXVcpqQqhwBnu/kb9MSkxttKYgo89S3DXsuc7JnGdLqRR7qBDJHYxmccDT6Mlq2
	0SWO9p2ZwR0/FnJb/jAY/u1qwaft2CRD1JLtYP04ZwEwnu3QKLS9wixnjDy1GXsl
	ffytxDUxByBh7SxqvRr53GPLA4pDj7NE41Cm5zRjPPvRqRyOgG0A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrftfsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:57:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBtvQk030254;
	Mon, 11 Aug 2025 12:57:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8krv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvSGSr4B+prUXMkaVLc4aZak5P3ZGV3fcwKTYZ92WAxoIRFNCq5DRTtbDXYIZ3AVX1dwOjWZCBasvHIz2J41q5k7GqzSZeonorxmBXA2VslvFzqZDnlujAZldafKxgcGjKYiME3dDRhz4d+iKj3ro3pgN5eoGVNCKDub4y4jns+P2ks4LQsGM+7PPTBkutIAdM6nAn0kgfoyVe4QXEg4bkCSUbXVa2x099Iip+NFEFmakuui/wFzFT+7Tdlfu+QNSm5U2rrj5MS9rjcJ4yjOSOsnqqlnZPc2kZ8cY/cc97ebHMRqT6UGAvY/34njMMO6Y0O7ye7SCTkzEkxZiIhvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDoKLYAeE1KeK0pxGtoX9bAa9V/SxJ+wgnwNWapVkM4=;
 b=okHqblqlul7AQcCrse6L593AJwx6P/U9pcRrfzzCW+g4KcIrrKM8Q3t6CgEzTWGRVru2mdd331vbhywPIJOaCgOxRbr3Qb7NqxpzWljWPJgtNzJINgtMHM/AZ3ACKKU29a6qICuEyxWJrm41+ZdSU20MuuPaXcPdYODXXQbMfr4dT4SeQw9oxl5PyzulOmJY02FMOgyY8sDNyAaCuhiFF8maxT5cIv4fexGhsew5qhYOmO+SHsy9jF6499WGH06BI0hhJYyxEfY+PsGff+706hiI5tYcGZjJnoBRhUw1hmlk5sEJk2p3aOoEhyi/ko2YHI0qBEnOL5sdf8v0bX6CqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDoKLYAeE1KeK0pxGtoX9bAa9V/SxJ+wgnwNWapVkM4=;
 b=KQdFZEafCkam9uhzrhiViz9imZZ5RCdVU/jJ97aEcI9vIjYKA75TQMsydm+jhW54zf6RdqYZfgaZkdwW2N99lfZFhtf9SJoljTgqsJU2eZZ27JYvY8jouhkYm5Lo4MFqk796XUrGjnBhalYSWcfxJ/lu1yQJbmau+nP3aZ+hhYk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 12:57:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:57:47 +0000
Date: Mon, 11 Aug 2025 13:57:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 2/6] perf/core: Split out mlock limit handling
Message-ID: <d96e96f7-b74e-4d7b-9cb4-c2f5fedfa77a@lucifer.local>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.540223161@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811123609.540223161@linutronix.de>
X-ClientProxiedBy: MM0P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 1423ccb3-54f8-480a-2ac5-08ddd8d6abcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tp4y3TJUDl0cSBND1VtM8wKe+SzpPSxzUJUPpgvXxlBoFu861T5chrFJ0n9B?=
 =?us-ascii?Q?J1PSsFIRfhk+dMqFH8aYc0LyXp8XBWwKbt0PmGYgh+zHPPW2Hf0dgcYLGhyx?=
 =?us-ascii?Q?lJZyZyMZcUGl+icLOLbXDb4ORwA44Mj4kYoo9FuJ3qN/a6J5wmined/tFBF4?=
 =?us-ascii?Q?i2pAlw3USTv4nqDZj60uJZmNGGe9zg6OlvCYGJEntzaRQq67/Y01aKnMX2VP?=
 =?us-ascii?Q?fAivWdtmvQZN4tTAogItzmoOcKFS9Ef6sXQjYJk3XJY5D9r76pcJdLvYtGJR?=
 =?us-ascii?Q?Ad4VIHlAEK+xVkGga4Yhx+rXaCWIg8dbVoZ/7m1qQRMH0D8Bsmqf1c2cUP4p?=
 =?us-ascii?Q?sFaC6Hk65TbPaj5xRyy3ixBt3MTw4s9P1Zmzm4hRvjhsA4BHUpmnDGRlv5bn?=
 =?us-ascii?Q?Ai5fYzCX6et2MyaYHVdX624/uScRWXlB9XvfON/eNlV0j6ILMS1cb6lRIQgA?=
 =?us-ascii?Q?nwGYzfAxtXqTBX3BtajpYAbR8XVueJZVtnpBKXU7lZDiFgtYk49wpV41RZXZ?=
 =?us-ascii?Q?h/zW6qTASQJr670IFL/X00n89TBSKivuLPkl/6VWw5bnMadr+EO/qPlC6V1D?=
 =?us-ascii?Q?whbnFMSsp3WFpZgdHc63e5ycv8fnusC9DFFxxGpgjvFcjhZhpD3CJXBjCkI8?=
 =?us-ascii?Q?vKNWAHrD0vk5oegjPknjaQk32MwQPm2LZ8appekanSPKMCPanEV7a9ibsflQ?=
 =?us-ascii?Q?W+QSR0Qlb7x/TmsR4lTfqu7aejVdSWyjTqg0lZS3B97PF70Gpt06y4kdzvJG?=
 =?us-ascii?Q?uJPE3dWn4+n7KS8ShFnhWEEuYWTY38d3k3pwvwcF+wRkUNzu5PVrpewOg4cC?=
 =?us-ascii?Q?xSNgmMoMUoaQZtwuXU5GYMOhVx89N6lRQCSTOdID8dT4SzRme2/ahzyFXM8P?=
 =?us-ascii?Q?n26tF4e0es+/U6dOC6mYgI0n4iKw+VQ98a60JFsRyyrbWxQ0wS6v6o3yBg7+?=
 =?us-ascii?Q?fORzq5ISx1n1x5W+ysGOO03he4Umomp2S0URslA8Za+ZMmY0SfwQ0jvw8aWR?=
 =?us-ascii?Q?VE2uGMYM2SANbttM8EMdobz1mMAt9xvPINT8rYmoShl5kFaEfqxqGwCbk8Q8?=
 =?us-ascii?Q?DebPf9OxYoDmdzfJPqvAyvkP6cy35bYs+P9ZF2YiToP/xWAw56h53lbJUbU6?=
 =?us-ascii?Q?iCkuLB3clXM7tpKaJKqKMIWAY7nl79fPz10ldPBh6r4jRelc6oMeOEmGUnyl?=
 =?us-ascii?Q?+6/qpTsZ1lBrejo7G0wDW72IgZYIeBUEA73QI5qDucKZREKK9tw2dl0MwlhL?=
 =?us-ascii?Q?vBUr9UbCGwhtaq9vhXiQn863mDSBRm5jdY1vDiVS4gMYjAjaIAhMe8U01D7j?=
 =?us-ascii?Q?oQ0H+TZiZRuOoay69sXQnu8lvaJdp5nwSOHEHQmsxVXAMPXONY+FGUVvyKjQ?=
 =?us-ascii?Q?hmh/1SGbeiQWpOVbsdJVR4VQRCGw1CwsbnDbXvWRCi78d9TI1dSJE4xij6g0?=
 =?us-ascii?Q?AXwzx+8i+mI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NiIh0cst5Kkyqhn4OGQiV/9VVWHlQA4AWH6sGlPkveaskOSoaDhqA/Q906lk?=
 =?us-ascii?Q?DMCIQhJrVqDL2ENBGk0OjMMr4CT3osGDnPMJj5RK/36TeiQ6GvNI73JmEhpp?=
 =?us-ascii?Q?u+nEQ+iROCYBBLaHSVCocSrikeONZGpIZzcIgAr7OPPYl3CRoP324D9rMDcz?=
 =?us-ascii?Q?23KFlujwXERjxoynAkd3jKRX2ht1+G2jSiyMWnwZFj+4sH/DY0O8oFBH9Ku3?=
 =?us-ascii?Q?2N7GDMXYCW3PUG+osWTavO6v3V6hl27VDe/4XabGcq16lRvlJ77IYy9pSHoa?=
 =?us-ascii?Q?wuoIJr3h6jXfjw7CDhrjBHbYODT2e9z2Zu7BnGa7gFpmo5ZsHgc0ZLAiikcA?=
 =?us-ascii?Q?U6CLDW4+m1R5e4cE52WH+sNh/LvY9jXoaiQtCobc/NmCjr+gnksevVWp6XBA?=
 =?us-ascii?Q?SnKrvi76VS+zmhRg6MUnes83Ecnh04UoS8AgjpgR4FCh9pyxrsp3WVTAeKFY?=
 =?us-ascii?Q?axLna60nJyyARZTKtJkcp13VLn0Y7KaKGQS5XjsoOtL6//D139nWpuX/ai8d?=
 =?us-ascii?Q?VB553Js+cuEPEwnQTITkund7To2zq/taWgYTjn9BvcyS5dEkkj38MTQw756f?=
 =?us-ascii?Q?dfYpkCw7ZTmwuOKQyXfnWSGc/qCP4xwhAO6DLLup9oezkVn/S+QbXU+jQJdd?=
 =?us-ascii?Q?QzhnmyUO1hP2+dICtHLliGg+/k99os1BrOFch+lOgLDWEYNxGkSpJESSWRG9?=
 =?us-ascii?Q?SX9IGy/HlxkhksAypgGqT1vTXFce6MgeeYBQvK7DIu9RfJxweOMx2fvIL+Wl?=
 =?us-ascii?Q?GoDFaG9bL77PNv3LqamwwWatqB8BRuW4DItEq44zlsMS9t0U4E1Qm/Zt5eLO?=
 =?us-ascii?Q?AOnuGiKsG8z7m5fMpX6Bm9KFY96ul21alru/N396zsKMc8sPHMjRThzu2/UV?=
 =?us-ascii?Q?TZff+mJfzlgErGYI2fWA0BaoxxHdZYD62aZHqogjzeVor07tB14Ejpr2sqoA?=
 =?us-ascii?Q?6p80OebMJjaV/Myp+ynCVxjwKdP6L/Uax6qTvnHD3Wftdx8A/1cIgrCoHw/n?=
 =?us-ascii?Q?0lfzFKV9uUHos69DMcrkG+ZrXbpGWWhHay9GX01mRoCxBD0di0RQMKqKraqP?=
 =?us-ascii?Q?0v5SoVD8Fx6PZGDJncgyR9dGOwy64Wgqpmt5FZ3RCRDyvTNi3PPUW+1qZ1vZ?=
 =?us-ascii?Q?HNTUZSKafmviSuTJK74uiUYdIpp+EFHMN6VNXnKhLCmCUI3CcVvhsqRE70Hv?=
 =?us-ascii?Q?eapnQyu0Eg+YGpHrh9YKOxUi5ImvN4wr3mnAm+ut0sKnBhJRlgO6hveUWxmE?=
 =?us-ascii?Q?CS6AuvYw+dksNMoY4L8zmRx2dGsKA/uUY/m5r+ZawPkDgnQv2DRtjjUZFEwC?=
 =?us-ascii?Q?nfPVhm2o9ByemDt3YStnJ4JkN8OwJQNdqZ8lRfMb4F60pZlDm2ccVIgc0eCD?=
 =?us-ascii?Q?ZujgvFUS/5qVYK4FHziuakAI/AOXF+248GmT8a0g6V5pwaSl1LHSaDzsJD+N?=
 =?us-ascii?Q?/+Ecm6kZoigkHnznO5wKXU5iae4dKcAnIx827xFr7JN10VAAcdybP9koXQmQ?=
 =?us-ascii?Q?5Sxn/b1g7lbPsXi63ag+lAWgVgArffjpevVZmaqpovGRr6aY4ppbO952Qpyy?=
 =?us-ascii?Q?C54Q1DpX2GLDBfNJXstIYzL1gDZGZMdZCWKfRVhqP6u6zQOVxp78KKmO1+/M?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nSEtRJquI+qjjZh8rMnYSDMIRPs4u35QKnCVQ5t6n3J74RVlT0UkWbgb8yMqtmlb3Vs+nLdwvVOfkmhiilIeWyO1x9EubSPr5hG6OWoo5hYRbAAXjbHDLMBnmdLDKUt1bLrQ2re5qLal7v001I6EtEsSOunp+QZLDhMnLVkElk37CKsCAvM/CitMvyQc+fDSG0hkrnVS8Tjq+yNFmBxyXUEp1iv/Vtp/IAnxshF7Lz+eZvO20CJ7GgvDqVwTPh/olYE2CDfwg7jvyn3SyunSKrlpIGlmVJrPitIgW3EWrPDYEN7IqTLOVaJJYhpNIw7UBaAY+ZswsTzJ0DyTMiGL3LcGenoymovXGRd6KW4mPKjYZx3Edir9Y+8p+kmGdGYtz2rlo51WL8pD2E5D49PoQiw3Ti2l61hH1L4dR3Oph1mraoaqoL39cYf+zFagATvvA9puP6yiTQ360sPLX06BbiOJG3CwFEP9N7XIewFV7oxawTZz0KSaZhJIVA0gwe3R+ytM1kxiCZCC+XVEi0Inmwkot8KYb2VNsiIQ5TxD1WSUAyYIgbXYX+BclUoJpfwlWdhYBD79VrEOHUIusLileS7sNf/uLYcrXnE/qYxyTOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1423ccb3-54f8-480a-2ac5-08ddd8d6abcf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:57:47.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWnv+h4vdCoRiJ+7cD27gVn/uh4vh2ufaKAX915iK6aBq/QCYlUwNP6vsx5do1uspsKMuuh0I+G/h1bv3VCXc4cUirENCyZjLE492k6JOE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110083
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=6899e8ce cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WInJcZfm4erLqI_uFIIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: x3Y1P7X82CoSIMEYtOHO72obafakJEUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4NCBTYWx0ZWRfX8a6GoyV/bafb
 2dZVvlvXGI2QgHFAD3w72DClE/ZGS7kVSMJ+vGe5zyIANs8AMIVxzEqZK+wWYsfktBNsxvA0zkp
 TzTLzUnTS+rI8WIOtvQd7dc0mYfxA5ILmmzBC1Y3ib524RraJ7rVqSWZ16fzdyrsMVzZgKmX8Fx
 C4Jliu0tMWtogZgjeN5bXfDqPl0+PTs22S3lqa1OjEUvkN1ndgW49b6Ycf84FDVuH3UKVhyGXY5
 k5yJPvtxCPPT3QMAbCi3LjRwJZurTyddSAHznAhQkPMF0BY3g/IHOPNtliBOL1eCW0LJXjgqig1
 r4J5bj412R0U2H+j/pVA9JOS5NANKUMZUr7tgbLILzyEORCTr8GHUMILCX80HLE6HqUAjZCSrPg
 aDoZlv2ffpmi24BX+iR81l0QHBCawZ9DKGy4wz258g3VmoovSzcY1Lek+CdmdLaoDqcx7X1V
X-Proofpoint-GUID: x3Y1P7X82CoSIMEYtOHO72obafakJEUk

On Mon, Aug 11, 2025 at 02:36:30PM +0200, Thomas Gleixner wrote:
> To prepare for splitting the buffer allocation out into seperate functions

NIT: seperate -> separate

> for the ring buffer and the AUX buffer, split out mlock limit handling into
> a helper function, which can be called from both.
>
> No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> ---

