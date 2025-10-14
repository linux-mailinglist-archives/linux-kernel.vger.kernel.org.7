Return-Path: <linux-kernel+bounces-851812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB0BD7559
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC833E86EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E030DD1E;
	Tue, 14 Oct 2025 04:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qu3J4WqB"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530030CDAB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417716; cv=fail; b=Y11+38E4GNF+hQpQsDJC7M8ox1YuPmY5Xmy51SEZ5EkYZY/JXVE8ucTIWLA2Y2LJ4maMuIrBkZBL+lRl3sQSzr1e+XzXZKboIEK0J4Oqn5TlpJgrZtlY17N67LBDsT/rQUNwDkOi/nxXXXTWY9BEzxhLPUt1JD8RrjSbRvu0uHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417716; c=relaxed/simple;
	bh=Tguh0qFfXOeNMR7vybX3LiGKL6okEdnbBJ73eOTbO0c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H+jMys+bnPmuXbMrHWSbZuA3TRZpdmGpYwGWPXrNtVYv9Dbop3nKn/oXQ6C0n3eWGEy9WYTQtwczdfZn4kwJYTTX6rsN8kSO01J+0dNDXlmn+faj84IjvLlnGsqanorSbiQxPakG8+E0SfycstR0WnYurETIE+FDJN3mJLV2aaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qu3J4WqB; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Us4OHpYtjqQCh5FW9e6Wf7K8VIiwfaGJxmcEItDPOxWO+3K1dE5PXmF33Wrya1ukXgbOWN7/Y4E8jP9gugiZufN3//vi2c1ENN72LojUp77rLcwvnaLEHAFwoU1S5rotMZwCho9efbkT3Aoj0VY0avZEFHRwOsBXVHQ9UyILgx/NGYHpnUKME7nCuWKvGw6JB0AXkpWBkpTKO+9XRRh5iiAUJk1xhviRyChy+SNGhPxDxLDwBacKH2+VzVhTufKgwIQnb/pFlqJrqjXa+8/uLEAs3N/VqT+IPzDranyuGZGY/DxH0CuTOJ2cTR3m3rzduKQD4R1WDtw2jU+/KTjX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5NuLsSA/MR2pG/SbwlQFEHc0ZxkLo5nvBDtFe62Txc=;
 b=oBxt9BJiTQZ+ldN74oPAD0p9p8p399tbhR+sVqzvKhDvgKMxvmZqoNakBMHXCIdD6es6XMfzRAHMsy0bCDOJf43QE4vAQtLFJC3NlSRZi/MokYGmXFMvboj3meUWoUuJwlkxcokAjLYXdpFMCFxfctd1CJ2Yc7LFR+ALKRzcHHwXW9weVMxG1EHTVDn1v5s2l5SH/OCZkeYbmFjI4pWY+CVZSqtDuqd9wrDGeyly675p7BCytCGlCBzd2OYnfqRYAzLhlGNENXcVp1X44cw00mBOroIVCkmkp+3slrdZS+DVXrlpg1EXRmZ3vYadhfXZnE7DzkUPC+jVokMvpD0GHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5NuLsSA/MR2pG/SbwlQFEHc0ZxkLo5nvBDtFe62Txc=;
 b=Qu3J4WqBFLllm+h614H/ppeJq6GEFH4hIPaCdQ+gvDzlSZGrGtLhWVU+cmeLPBo08Vw+5cvyOrSdtlMMNd0UDuuIA6HzImtngr77li5ZUBUDtM4Ldoe91HKAseSg3Hb8BMrkiyxB3D5C3dbAtJ2fO6c9Yr6scwDapt8zNyiuDq4nlnVTeZRv32VfqQjTrgDm4rgxGSb9hlkznOPkVFHLTSDZxes+aUWayrRG2/A3PKmHnbEvu3hwNxLRqXHI+/mRrqg+jo96AeShDCCNIJV17D5BgYNZi2k0wtTlUIg6BpNYbxA2UcizIRnT4oruVeW9R6+w32pXaZzSpfz9YHOFXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 04:55:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 04:55:13 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 14 Oct 2025 12:54:42 +0800
Subject: [PATCH 5/8] firmware: imx: scu-irq: Remove unused export of
 imx_scu_enable_general_irq_channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx-firmware-v1-5-ba00220613ca@nxp.com>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
In-Reply-To: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760417688; l=838;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Tguh0qFfXOeNMR7vybX3LiGKL6okEdnbBJ73eOTbO0c=;
 b=KrcA+n7TtJbGvprrw2kJTTnXEdQudc+Kp9jq3CQ4d8gcYc8kD4nAo+GY+DZQPFnCVEUJ6N1GC
 XUsSHNu38uYCoM9lj2oL7sGnHdg9QjfQLF9lS20D8Yyp7Xa9C+hOqsU
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c0901f-d9dc-4a10-6a3c-08de0adddbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGw2RXExRU5vSkZEMUFQaGU5ZGdGdFl6SkM1U2NIM1JrWXhjVU5zbDh3anJ1?=
 =?utf-8?B?TEJEeEtZQWJQNXQxT1laK3ZGSzVUdk94TlFDaXhRK29tQVoxdU5lSDhVanMz?=
 =?utf-8?B?WjV3NmN4VUNnNzNybjBuWkIvSHp5T0Z5TGxaZVpEVkVPTmllaG5sd2luT0ph?=
 =?utf-8?B?V0twaDNvcVBrVFN6Rko5MWkvZ1k0Y1JNNlhtVVMyczdHZjBmK2JXbTQwaWR5?=
 =?utf-8?B?NmF6S29GaFQwRjBmMVdySXM1eGV4L3lGMjlGdFBSOWRxYVNVV051aU1EaG1s?=
 =?utf-8?B?UGV2SGtGZ1JSaFd2YUZtdTlPb3Y4ZC84WFU2ZnU0M0M1Y1BuTGMrSk9Gc3kw?=
 =?utf-8?B?YXVEQ2ZxTXllRUFOVDFiRHpHbjBNaGRlOHlwK2xReTYzWTFhdFdhdndVVnl4?=
 =?utf-8?B?b2R1dXFPYmpLcXZUYjJKbmd2cGFsM0I3a3JmMVFtVXViVW82U1hKUmM5d2VH?=
 =?utf-8?B?TEYrUndTbHlPZHRpaUY1U1FoUDFkeXVPRVpPOWJ4VmJxVE9jbUJFVEUzQThu?=
 =?utf-8?B?dDNFbHdJcGYxNDMwNmVKd2lldWdycDR1bVFjQUR4LzRKMW01QXEwcTRmTHNa?=
 =?utf-8?B?UnA1SC95dzdlMFh5QmxUaThpTXZFdkMrRHdXUTJJTVRMZCtJTVZKRy9ldjNU?=
 =?utf-8?B?ZW9oNEtGdU9CbGF0MUQwM1NtSlM5RlNSSXd0UHNkeGRzdE43SzBZSFdjYVAr?=
 =?utf-8?B?OVBXRklVZVRIUmN4NUFCeUc0WXllVmxCN2dSVDVwbGpqZEZpVzBkN2t3c0Mz?=
 =?utf-8?B?emZTdDE4YU5qMGZjbmVBZ3pVbGh2WVluTzVzczRFSlI0TGlBUmFZNTA3MkZJ?=
 =?utf-8?B?QTlHOUpVdmJXTkFuMldxZEhWZk52QW13b3VuSi9haHVaMWlkN083bC9reS9x?=
 =?utf-8?B?aWp3dDVUd25lTGhQTVB0UXZGbWMyK29HcGFYSGFoZEEvZWhrN3k0RjJrWllZ?=
 =?utf-8?B?WHFoajhDa2ZkNjRlUDVpeGFkZ2pXYUh4KzJUd1NYRmlHQmVpUEYrb2gvRVZ1?=
 =?utf-8?B?andSY0JMVURiR3VOd3JRdm9IWXRVS2FUcjdOdHQ3SGhCc3JzMlFhZmFwZEpk?=
 =?utf-8?B?bW43Q2hiL2o2cmlkUGRUOGRodXNQaUl3alNSZE1FeDg3QVpxaFVsbGNXdkdz?=
 =?utf-8?B?SUZtZHF5R0tCeFNycjloUTVqUG83VlN5Nkt3M2lNVjZBZm55WHlWM2xuZTRH?=
 =?utf-8?B?eG9BdlBuMmVxWk9YTGYzRTg1Q3ZucUw4MkdCRTR2ZFRPTXgxRGw0cUNrdTV4?=
 =?utf-8?B?ZlZtcStjSkRFakF6RUhOZmtUVUpRSlJQdXU1VzVRSVpxb2JOQlE5OVBNaVNk?=
 =?utf-8?B?Z3A2Q1g0OEhkRWNjb2RkaG5vRFRGUWNsTkQwV3d0c25raWhrd0lvRFhaemxt?=
 =?utf-8?B?blN3bWx3Q1NycHRmVzNPdlE2ZjNBTDAvT0FFdzJwMm0rSm1maGtqcndIV0NW?=
 =?utf-8?B?aEIyK1RDRnJ1Vll1TzMyZGhOUTg1YkRZSld1dFRzOENSZXBwQlZpYlRoYkV6?=
 =?utf-8?B?a2tuVXJpSndkQkpLRUNIRTQ1TGFqQmxMcVhCVHRINTZUNGlweEF6Y2wyZVdM?=
 =?utf-8?B?d3V5TXAwRFArV1FWSUFTWUdmbEcxUGxQM1R4N2EwVHBnTFRDRzNCSi9pTXMx?=
 =?utf-8?B?YUxRVldRdlFobyszTDZRdmdqbEFPQXQ5NjhjMXFmT1U2cFVMYUpJL3ZZWU5I?=
 =?utf-8?B?ZTlFdkxiWlZaQjlhRzg5cmN1YTVVVllyUWpTQW5wN2ZZb1VJTkpUSlg1ZmJa?=
 =?utf-8?B?M3RsY2h6Nm9mV09wNS9nakY2Q3YvenllMGZKTEYxNkxaRWp5T1ZWR2I0L2xr?=
 =?utf-8?B?dCtUSXVlM3JNNU1hbTBCaS9ZdHlYSjdaNlFCZDJZdURNQ0hpZnRyanRhamZB?=
 =?utf-8?B?UVBlM2RZbzhoeHl0dTkrbHd2dFNTMXd4ellTNGRkM3FoUjY5Z2J4clhyS1E3?=
 =?utf-8?B?YWIrOXZMZStKOXdHeGkxdEE4Z2VNa3k4N2xTa0Nwc082VzhVSlVwSGJXY1Fq?=
 =?utf-8?B?WjBjODMvQ093TVdhcDJUbmhsczhqSk5OT3FnNFVZZjhqNVF1ckdTZU9jTnI2?=
 =?utf-8?Q?iaJ91t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2YraFlyZnJjSURrSkV5bCtPYkpSYWtXSVhRMFU2dUpXOWw3TlpPdkF5NElD?=
 =?utf-8?B?QmVWSERNdEUyOTVmYUxqbVpiaXZYSGNyQi9kREkzdTJsQkVaNUkzWnlZZ3hw?=
 =?utf-8?B?Y01RZlgzZ296dEVsL1pJUnVkS0puK0NzQlFXc1haaHROQjRsU1NrV0VlWDdq?=
 =?utf-8?B?QWFGUnR5UXA2UjBYT2paQTZ1bm5TOTRyQ2NGRFRzbVhPODI4ZmtXNTRmeUZ1?=
 =?utf-8?B?ZGJuSmJFNi9CcmJHYzRFYkxkMVpHYWdqRUppUmZ0S3U2S2IrYnB6bHFKR21J?=
 =?utf-8?B?Si9QRDh2L3VsYmlhZUFuWUUzTk5SSVkyR1MyZ2wxUkV6dTJXR3FOYXRLL3Jz?=
 =?utf-8?B?S2FyN0lkRU9VMTV6UWl1TlNYSkx2aHpPNkwwU1BjNmFjL1hlaC9yc24wT2dr?=
 =?utf-8?B?cnNlZ0NwUVFTb25URkxxMnFCUnJJYU1rYVRoREZpMFo1WDJOSWhOTmRwS21Z?=
 =?utf-8?B?L29LZ25aNXpPRW90TUhBS0xYb0RNOEM4WWpLZ0JLMjBITFl2eWU5emd5NVlh?=
 =?utf-8?B?WElneGkyYmJ5WUhwekRTendzV3R5Zlo4QTR2N3JEUVJmTzRzSnlKMjhuRzhw?=
 =?utf-8?B?S1YvaWM1Y0pYanAybHNmcllwVi9uL3ppTFlVeGVXU1B5eUx4d2k5eUhVanRD?=
 =?utf-8?B?RURtMXU2dmI5NnVzY1haUmp5WFVGems2MGV2ZWwxWGxhM2FDQk11MDNkWEVJ?=
 =?utf-8?B?WDRTYzM1MzRMbCt0c3Y0UmpXRU9pZ1kwVzZEL2dqN3dHWnVpYTV6V3ZUUzEw?=
 =?utf-8?B?NWxicHUrUjIvblZYbUE5aVVtWDJaMVZzS0lSd2RtQnA1dVV2Zk9GWUt3dEFM?=
 =?utf-8?B?R1UrYkFpaTNpOU5hZ1hJbXR6MHBVV0N0bzFKKzErWVZyZFBqajFGcHNFUG8w?=
 =?utf-8?B?ZTI2MnB2bm1vNFEvaDlHVGYrejR4Nmx6bm5VOCtLQWI2WGJTeUVvVk1EV0d5?=
 =?utf-8?B?aUFqRzFTbGVBT1J2c0FLbnFLSlN4aW50bnFuT01SZHNqSGtBL1AyZzBuWU1V?=
 =?utf-8?B?UHc5MklQaGZCS1owZ1VXTGg1Wll6cm52UlVONXNsTVlDQmdEYXo3VEsvaUlH?=
 =?utf-8?B?dUhrMU9pQmtQUExPcDZnS3BubWZmMjFXSW1LZGxRQ3dFSWlXSWhTS2ZzTHZj?=
 =?utf-8?B?aDB3ZENCZjYrOTNxNzg1SjVHNWJxNFNCNjZab2kxWUdVNlE2Y0NVTHRYUysv?=
 =?utf-8?B?a3djbFdmcWlpQUJjNXhPV1BsYktZYW5XWXF6S09zM2RpK2VSK0dKZ3JDOGgw?=
 =?utf-8?B?N0JCNmx6V0RndWUwYzBKSUVhYW5XckdiaEswaldWcXI3WGJBVjh6NnFNbHhz?=
 =?utf-8?B?NlNFdS9SN1pqNzRRMDlEYzAxeGIyR1FjbklVKzBEeW5FcFpnM3dYRUc5ekdu?=
 =?utf-8?B?eUNSRU9NMm8rLzdZamdiek5mUnE0OC96bVIvOWRVbnA4R05wbFFCb21meGQ1?=
 =?utf-8?B?WVpFNWd2SzNpamdkRDVVcFNmR1g1OENXUWFhWXVFWE82RXRveVdnWWxyTGZq?=
 =?utf-8?B?Kzg0Mk9HTmxzenRiaHJKYUl5RVZEVEl5THYzQVcyQldOZTByZUUrUk91b1JK?=
 =?utf-8?B?cGtra25NaHI0MVVOUEI4enFZYnZYVGVlNjhSdzFnTkRDb2ZuSWZ4YUs2MjZZ?=
 =?utf-8?B?elZDYVFta2I0VXNIWkl6aGx0Rmc5RnNJdS9mL3VNd0FPK3QydHNybjdsKzZx?=
 =?utf-8?B?akdZME1Fd2Npei8rWE5iUjVLcTZzd2pMWFAzTjdndFo2Q0xkZEdNMEhmV1lD?=
 =?utf-8?B?N1o0NTBBMEdzNnp2S1RtVkoxRjM5aTV0eU1hREd6N01VOWF1c2pzbjkzNjl1?=
 =?utf-8?B?aWhoeXlXREtZR2dpUHpZT1kzWmREa1krdThWU0oyb3IrRUtYN1pzY0xISnQv?=
 =?utf-8?B?aHNaRFE5eDBiWFhEN2l6Y2JwTGJxcDJnZ2RGOUJ5WFBtMGZyRExjMm1JY0lx?=
 =?utf-8?B?RVpwNmVrdU14VDBtRTNWYU9JcXFPV0RBdkxLUXVrcHlZTEs2eG1xbEErTnhW?=
 =?utf-8?B?RXIvb2Fib0I2U3VURnF4eU1WaC9wcUMrUTZvckpjTUM1TE9WMmF4Nkphd0tO?=
 =?utf-8?B?cGR2TGRSKzhjNmt3YVFOeElNL0tGU0FWSXovZlN2V1l6bWlYbTJLSktCc2hI?=
 =?utf-8?Q?Je3mjcyqwMDoUCT0Q0BouFNbL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c0901f-d9dc-4a10-6a3c-08de0adddbd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 04:55:13.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxaG8zg8inNsxwPLtrOszEvnt8aimN8DYNHXNaU4ukUH00snlfwlMLmQZpE13DbvPQuawLuya1wWuLFgm2y+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

Since its introduction, this symbol has not been used by any loadable
modules. It remains only referenced within imx-scu.c, which is always built
together with imx-scu-irq.c

As such, exporting imx_scu_enable_general_irq_channel is unnecessary, so
remove the export.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 1346b75596293892ccd90a856d46f52171d88734..0be9c4c75d826a641e7078a265d30f146e8eb14d 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -259,4 +259,3 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);

-- 
2.37.1


