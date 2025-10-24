Return-Path: <linux-kernel+bounces-868270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7D8C04BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FB115004B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6192E92DD;
	Fri, 24 Oct 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lAY8v7A5"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF522E92D6;
	Fri, 24 Oct 2025 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291175; cv=fail; b=N2Yd199UGlUG02wggREVAfx/P/dmByQw4tRLPIhiC9uvtVy+K/+56p/c0ve1kOwrE2wXJNDzC975jlFOAJwbs+Jile+VcYFROyrdTg51wTglQfy2/mt6s3TCPIIuzpz8z1+hYJY2BfRt9cfJc3egr71UhbbwNBCtmDytK5qy5sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291175; c=relaxed/simple;
	bh=oqtOC8eqBZGU6DSeKX9+ORyE17KWwMPWve5ZUnKd/Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5hgeRoi+NiDwxSZPUzu1R/6LA/zvdh4wfqkSZpAQGX9iccF04nRK7qC9FmpGrWJ8gDaKDwBG0kntGObTYJ3OPQ+GBECHFpi2BwZfU3ZrbWLC5EVfrB2WT/m9Rs/MtxG9+C2p5plU8qTQkhHo7/rkx295h6pV7UrMrJ+AQ8CVyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lAY8v7A5; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRnq0Bvva7MGM+ttnpkdZh+HUUYRpH+SbGEjJ9x+B32Wb+wmYswPeAkHYPWqEdCsb2AGjX/k7bgfqSJ7nuls06LTXyLWBToT4AF8O/uctzQIpFxy6az8Oqani+vO6DasATvdJEYOKD9Lj6gPGYpIsZLdVMkuyq2HXc+sna/DbWOqaUlMQtbdO0L+0EYnW9lLb97maUKlOvWklnAunnDtO/cuHbQ8qXmBu7Zu8Mn9/cSgfgtK8sNo4dodMQ9D3cE2Fle4w07VDDMQy4fKEwLIP0HXI/1bsrT0yYbMOXJt5uyJvdblwNOuuZel44yVonk/5Tmp37ui1bwUlXjj5F70bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzYWWCIJPakimGmXxLWIoQMCgGs+AALU/rfm0jgjLZQ=;
 b=Rxiv+3ZbcBcVq2Cv3vnBFZNdz3kW+GncwgeC0y7MgV6jAAAO1IO6gWaB+CuI8Eg7iwvoofKLT1+r8TkuneaFnRAbbI3Zr1Uik1H2mwoMz7Af8mDQDJ/RaZ60yGFf9oCwTN6AzpNclZVxFFE6xQ8LTZ9KGQNqJL/3lhYqxLrf37y/0gG2Agid+Stx2mBRGYiN6Bud249+1Jyf5EadblYpBlinC+ekds/i/Y9BTWWSdb1VT3nKhGCuXQ96P6ziCGcR2pRPx6AbKyanItBTrWnn5ZfQXwVQHyL2yfrpDcrEkjVFZveh5JN77cHSysgCgMD+SJlWbe9TEtGQihGtsZih1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzYWWCIJPakimGmXxLWIoQMCgGs+AALU/rfm0jgjLZQ=;
 b=lAY8v7A5hq3OuhOCAu5b2tbdgyN/Wamhdv64BqGYPez3CXcXZMCHhv+q6sRqxDm55sOcyqxikn0oZCXfVAfiaUwvvlo4xvLMOO3ihqXmrq9XbtPcWf5tj9/lIZXvYGZOLPMt2FZ1L0UeeOrnCcQHa5932Q+V+4IUe8kqWhLF13Wuo/xmB1EqXzHSn5/HiPER9C2bOb1tI0sjoAmoJ9hO3s75KNIHWwHvBN+xLJPkeTEavd6uIt/tFwazK+ALhfv/m/WgRuMf+Ik4pdaTkfziDwwIImvqZS8CUa3SFz8ynQQs7/yHtclAi9ZNp0VtDQ8gdVoOCX9pcqMF+2Csl3Nyag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 24 Oct
 2025 07:32:50 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:32:49 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 6/7] arm64: dts: imx95-15x15-evk: Add vpcie3v3aux regulator for PCIe M.2 connector
Date: Fri, 24 Oct 2025 15:31:51 +0800
Message-Id: <20251024073152.902735-7-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024073152.902735-1-hongxing.zhu@nxp.com>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d8824d-d7dd-4b23-0f36-08de12cf8827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q21FS2E4NjZVdDRGWHhQbGlLL1l0WkhsSFRVQ280QUFNSjRxbjJUV0ZUaUxJ?=
 =?utf-8?B?RkN3dWRURTZtZmdIUjdSM2czdjluRjhleUU5aENtUGo5KyswdVhCTm9NZHdK?=
 =?utf-8?B?T2Z2UGl2a1BTWHV6cnhSMk9yMnlNL1dwYTI0RUlTNkQ3WWRCWkVSaGlBV1Ew?=
 =?utf-8?B?bzhMMi9EV2VBdkwwYVhWMkIxVVUvb05oQ2g5dFF4NlFuNEY3UUtnQ3hDcGVT?=
 =?utf-8?B?WmcwOWpJaWg1ODlWSUN1Ly9aT2VUZXFscS9ib0cxUytMektlZXpGSFd2ck95?=
 =?utf-8?B?RWtKMFNObS96WHZtME9jcTZuZzlpWGJOZVlyZ3JQZWJJbXRWWWF4N2RoMzlZ?=
 =?utf-8?B?ajBia0l1Z1dLaFB1c2pKM1ZIUGM3d0tEbEdNTFZISGJUbisrQkM3c0NKMCtC?=
 =?utf-8?B?UzFqU3MySEtCR2lrRnVaa1l3a2VWMTVob25ocHVpWkRncEVvZE9DZDBDV3d0?=
 =?utf-8?B?U1Y3RjhMWk4ycU1kcVNCRkFlMGlXbkE1S0tsK092eWpTb1MvaFR5cTRzSmh5?=
 =?utf-8?B?c0l4cHhQditwQnRjaVBmQ2JlWTNTZWVLQ0VuVDhwcXR0TEt5SStXeUlNOUhP?=
 =?utf-8?B?WmgzbzcxWXZYUEwxVWN6ZDNTTERiZ1RWaFBBRjN3Q1JjWkpaTFpvdmxVQ1ZJ?=
 =?utf-8?B?bk5ua2ZGRWhMVHNzaWZuQnZGRTg3clhUdmZMZnhJSG5rK2V5N3ZNSWR5QTdv?=
 =?utf-8?B?UDhGZzhQdVJmbVdFTFl0M3ZIT2JzMVJUSHpFWXBzSXdsZ1lqWmVkTDkyQ2lZ?=
 =?utf-8?B?dEt0T0wyMlF4VDhwWjk0TXlWVU9oeWowS1BiVzRSVmVmZG93Ums4TEpWditV?=
 =?utf-8?B?N2VyUHVtT2ZqY0lRWmh4TzFvQUZXOGYwbFB0Q3R1VE00SHlUOVVaTEN0WlVw?=
 =?utf-8?B?cHZNZTcwV0pETEZaWHRKd20wajVvdS9nUlgzUXdPcHh0bUV1SHRqc0FtTSt4?=
 =?utf-8?B?S3ZDOWNPWVZjSXF1T0tqY084Tkk0Z0plaXEyU2NjTStZR0t1QXhMN0xhbWVi?=
 =?utf-8?B?eGFNTzE2OGdOTFlEYlZFbVZtMmF0dGJTVnNGTG1Iek5ja2lpQ1E5Y3haVEUr?=
 =?utf-8?B?bXVnOU9Nb09GYVptQmNDVDNjSUJqNE1NYm1zOFJPckxQbklIZGh3TWtNcWoy?=
 =?utf-8?B?RVp0ZlN2L2V5bk15bmlqM2FXZ21LcXRHSllERmhJeVBxKytJeDBKakt4Ujhl?=
 =?utf-8?B?eU1GY3AwOUZVZDdsSnZGZzRoLzZDa3pFdXhFMmpZRW03eGJwZnVxNzMwT1l0?=
 =?utf-8?B?aWVKM1RkNnhKT2dnLzV3QzlqSitrTVhtdmZYb0dZZDE2aC84OWY3Zy9RZi9Y?=
 =?utf-8?B?R3dDZ0N5QTdaNGRyZ0NCRVQ2cmRhNzN4Tkt4YzdGaDJnc0tLVkFXZUpqWlJp?=
 =?utf-8?B?Wjlma0xBVlBGWGY5UWd6NUc5OVU2RUF2czluUlZXNWcrdHI3cTY1Vkl0S3Fr?=
 =?utf-8?B?azkzZ2JJNVJEZnNOSDljTm5vQm00WmJrWGV4encrMWp1bDYrREJBUHFaVDlB?=
 =?utf-8?B?OVJYejc2RWlhazlFd2JScFpWUjRFTndrcHRHRVJHMGdTTVZrQm1aR05iN2ZJ?=
 =?utf-8?B?bjY2L1FMRWNwUXlpcTNvRllZVzNwejdPRU9qVTlyR0UrZzhwU01sVE92dTA0?=
 =?utf-8?B?eUp4aHRLM3c5S1M2MXZuNi90SmlSTmJvR3BrT3RzOVVNSmtlZGhCSzlNMkcy?=
 =?utf-8?B?UXZzb21aRE5qcSt4VjlNUEZVb0VmejBVT1EwOVA0bW1wTTlmTWJPMTZsNUt5?=
 =?utf-8?B?dnhTdXEySWNJekpNSFdKajcwLzJPVUJPdmlYNkNjdVdXK2JVaGhST2ZmeXRP?=
 =?utf-8?B?ZEFWcFRTaW5iSVRkQ2p2YWxxdkwwUzU1emRSdXlMNlBweFpPZHdNVldLSi9h?=
 =?utf-8?B?dlpaODFIaHRLSytRZUhaK2xxVnEzdFg5eTBRR3ZsUi9wNXpBa3FTWDJCb3Rj?=
 =?utf-8?B?NjVuRjhhQlVVc3AzUlpPVWx0VW15T0pOZmxNTHVVdU9yNWFpbFVjQnFTcW1s?=
 =?utf-8?B?TmZqeVpGL2tlcUhiRzBPNk5CZjVSOG1WSk9XRVBQN25oNHlwdFdtOC8rQmR3?=
 =?utf-8?Q?eeKYBE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay9DYng1Sk9tSlA4T29yVnZLRlMvZ0xpSVpneTZXWlFnV09YUHhvN3grVDly?=
 =?utf-8?B?c1gyRmxEQmF1T3JjQ1BKZElKb2RFSElhK056eFQrZm1qSTNvdkNaVXJEbmNL?=
 =?utf-8?B?M2NlM1pUc2pZQkpHQ3lYMnNtM09uSkJNM1Fma2xzbTFKYUdQa0ZuZ0dGVGJw?=
 =?utf-8?B?VTU3eFVDY1Z3cDhNMCtscXdJVVArNlVEeElTbWZ1TTZPejNUM1NaM244Q3Br?=
 =?utf-8?B?Y01weWNNUzhLaGJiR2pRQ3JHT1hScUx4bWdRWm5sczRYS2g4YTNzdnRiNkh2?=
 =?utf-8?B?MkZvYUNrYnRrVVhoQ3ZsWXB2SVYxSWJndjFvUjMwQ2pZY2gyRWo0S3F4WDZR?=
 =?utf-8?B?RHNpVHh6NkIrcE9jNTVtQzRWZnRDb21VMVYxTXBwL3lYeGxjWituTVdPdWJ1?=
 =?utf-8?B?dHZvWU9qOHUwUG5OVEZtZnpkOVlwc01MTFNuV0lpVHBxRUQ2K0ltUVIyUUpI?=
 =?utf-8?B?aHZLK0doQlkwUFM3VUtlN0wyazNGc21KM1Z5WWtKQVhkbWlkNVpoLzNhNGt0?=
 =?utf-8?B?WVJPeHY0bzRXR3RJL2NwM01YZG9ZTW1BOUhzTlZ4ZEZQTDY5eTdnVFhqaWZP?=
 =?utf-8?B?dDgrVVRrcEJEc2lIUmk5RzB5dXR0TEJQc3p2VzdFdGcxRUtpVU0rYzlQbjVF?=
 =?utf-8?B?K2hRdFNmSGtvdDd3QXJ2VmRXWHM2OFFtWTNwZG5TU2M3djg3cERMOGdMR3lH?=
 =?utf-8?B?bHFRN0FqbnlnazZUQlJjS0t2UTNHeHJVNnRlbTBoNE1GTGNIT3ZVK2M4SDNG?=
 =?utf-8?B?YlBTT0xXMGJnL1ZLTGl3bE01S1ZXendYOUdtbVd4VFhqcWpkc0VQWGFQS2lP?=
 =?utf-8?B?ZUM5NDNDVVFtS1ZoSXU5NlhaTjVqUnFOZzlqbEVqcWNleGJGMFRzcGc2RmVl?=
 =?utf-8?B?aEw0TlZ5Z3NMYm1MbGVjeHhHNWhwbXdjK1diUlV3dGJhcWN0QmYwaGlxSFpC?=
 =?utf-8?B?ellxM3REMnVJcFNDNEsrL1QzNTRwdGc4bGh2Z0xRMXlvSUR6VFNiL3pTRXZB?=
 =?utf-8?B?NHhzWUxFenhad1VyYjNTdGkyaE5VbGtOWXE1eE1BOVRGcXUvMjVTRjhETWdX?=
 =?utf-8?B?TjVSZ2ZrRHZ3NFRSUFNrWkFJSU9JWUdpM05nVFNzNVJpKzh3b2lIZEczQ3Rh?=
 =?utf-8?B?OStjVEUyd3hzWG9SMjB2Sy95TUFqUzZZVkd3bisySzVnK2d6dEsvMXR5UHNZ?=
 =?utf-8?B?VWlnTk81Q3RQTXZ0U2RGTG1xRll1U0lLYlk0QXZUcWxkcW9McWZwS1hQNkNT?=
 =?utf-8?B?VFdtR2pEK3VVcVVUbnBoSkR6V3U0VlJqL08wWCt6ZkQyR0JDc1kxc2pMMG9n?=
 =?utf-8?B?cC9IVjBEUlVUbUthSE5XOFBlOGNhak1Nbk1YTUtmbkY2WEhneVh0TENqQ0Zr?=
 =?utf-8?B?V0tYUGNhOU9Ba0ZsMC9tU3UzRW9TZUtnNE1tblpBbGlpenVIZmxMT2tadTY1?=
 =?utf-8?B?NlE4KzhZQnY0YXNHa1Q5ZEVwaDRoUEZ1bnBVWjFFZjNXTUl1ZmRnK0VlaThR?=
 =?utf-8?B?VDNwT3VxM09jb2lDSmIyT2E5Q1cxOU9odXhzaGdYeW1FdGoyUlZSclN6OWJR?=
 =?utf-8?B?MlBrV2QxanNoMVJ1T0Q4S3lpUkY3eCt2S0VVODRMMTdaWmg2OTdOSW9NM0NV?=
 =?utf-8?B?bFJsTmJ1b3RTMU9HS3lEbTBWWU9NYXhFMXBuVDM1R3VwTC9aUnBiZ25QMThn?=
 =?utf-8?B?c29Kb0FmU1FlbDNRVmh1UFY5eUpBMWRxbFJ5UnNVYncxNHdGNFI0VHNXcFdW?=
 =?utf-8?B?aHBjSnA1eEorRW5BRWFlQTYvK0QxU29YRFhpYmo4MzJ0akpLeVRkcEZta1Bo?=
 =?utf-8?B?Ly90Rk55L2xubmh6QXVZYUNwT0dmcmh5K0huV0hlZndKQWMwTG52cGZ2aXVT?=
 =?utf-8?B?SjcwUnI0TUo3S0xyZ3dwOXZhaXJuVzNla25UcEhrMXNSSUxHTnpFZ1h5V2No?=
 =?utf-8?B?bG1UVHZmK21KUXluK3dJYmVFSHk5STJQWlYyYTl6ZkVVZURpWkVPNEFQQmNv?=
 =?utf-8?B?YVd4cW8zNllmZ2UvZ1lpRS9xTUwvN3pLbnN5bkF6VXdCNG13UEIwM1NDVHNF?=
 =?utf-8?B?Q3QxUGl2TVh1c2hGMUNUNi9tNGl5N2dZbzhUdUlyV1dsNWd2SUR6SVV3a3dZ?=
 =?utf-8?Q?EKIZPc0/eqlGHfT+5gRM1ZqIz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d8824d-d7dd-4b23-0f36-08de12cf8827
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:32:48.8650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqKtAd0p91WJwdF4DEajHMczy/R+aeJkSv37OqIPjTqOTU+dpbN1Q4PSsCcXcO3z+80Q/1uzDB7W0W53J/nxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
Grounds.

PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
source, 3.3 V, is expected to be available during the system’s
stand-by/suspend state to support wake event processing on the
communications card.

Add vpcie3v3aux regulator to let this 3.3 V power source always on for
PCIe M.2 Key E connector on i.MX95 15x15 EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4a..3cd8ab556c330 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -556,6 +556,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
+	vpcie3v3aux-supply = <&reg_m2_pwr>;
 	status = "okay";
 };
 
-- 
2.37.1


