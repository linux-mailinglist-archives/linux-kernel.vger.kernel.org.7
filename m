Return-Path: <linux-kernel+bounces-833235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEEEBA17AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB1156344D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623531E8A7;
	Thu, 25 Sep 2025 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MgRiysJ+"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95668322759;
	Thu, 25 Sep 2025 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834866; cv=fail; b=FsxsOxNFXFwa6URu4StG/Z2TB1GJBF7NosgXmAF29WJoAK7r28xFG6Wl5ukOICbKMhgYXrN8IRfU264NeTRjrA4Hv49wjIWltHgyWdk8b7pXhoODkkzzDXKxXyral/JjRND/mAOf58hTZVUcAkdXotCs64LajbzgrzzCG1jAnBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834866; c=relaxed/simple;
	bh=viq9nA3ofPon+PpRpfguphppP+TdNUaxHYTA6iGn7js=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eaptvrcDiUHOpq73Ng/c+PUTl2dtqQYcAENki8umKH+J6UqLu4V9jSlSLSVqKuYYWzxofONU+Oluch6Tna0rT9+prt4sHZQu/PQl09W0zkGF4pnNDz2u3BQKj/erLgE2odWyiiCf7qwek36vGHZ+RCojJpDL9hfyP0jJjOA6dEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MgRiysJ+; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uqg6tkAE9WDKXJLV6LUpmcdp/J9tGFlUTuwpZMiUIoWXgOd8Rf35IohDEFBxWOefQFRhAZX1P8/0J4zu5M/Csd9tICnRQsATxxilwDzYd37CeDOuQHNPaVQ7o+iJR1mKrkPSDyIgfTQuqKngOl4VHqwz5A7dEMDnkoebBZTv15MhSojkDLYk5Fr8xWkzjkICy3dGVuC9V5UBfWf5puHLkNIxMFr+cZ/+g2rYz74OoABG0Tcpxkp4T1ja2DcvC0FhKQPvORLZoEjuBnOLkE8dcA3Hi82/SaWFrKx0ZUcRTAW6hZXU6VUJF2nP7aIuh5M4MfWEY5ZeEUo/JxRdFsnuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5wfxwSym9BIlN2iOAgSRDT9iY0bTwuht62/LkUbdF0=;
 b=FCsFYhRRhQSqdZe1Ob1j7ohjiKuBekMVopGUKtbBsUbZ7Hc/fwZDBfEWkNqfP/X4UsFf39LbURrE3hq3KAmqTHsulJD8kXQQC7zcvHkoPAFl8hshX+kf+M+DCzGljKmWLblHcnHwgaXLpvyMiq5xGukFyqlAHe2D4ZH1jAeU0dOwYB5I8tvYYn8E9+Vq3H3eYzyzxHKNpDNFjhtAnYDS5dMpmSI/LRagY+DkH7YpF3py4ql+5MO2+Bvg2DggP+Bt4+TT5JdXZttLCYFqy1TdNdiiCDu5dx6rHk0qXZsD6LrvPH3nxzAa5QG3iZ9SQuAWMyz7O6ml0261u8YozaeabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5wfxwSym9BIlN2iOAgSRDT9iY0bTwuht62/LkUbdF0=;
 b=MgRiysJ+syzIz4Jy3kUVl0m9bqRnkQnSgnNy6juaH+C4xATROWj54lMoTQyDHcUiUk14FYzZxstjBWUkY3skta8A7Ncd40dhY6ad6wYxTQ6AOTdVAN5NIJJMxlGAvpC0vzsYfO5ORdff1aV729hFPr9uCgzahoRxga2w3pN31nHhd+kXTU27vusR6Ef9iKFEXfnIh/H7WEm6g5SSG7J/TaMl0G2yBerlJw2oO7Al+XLSC1vH1j1kHQVNF5sedmEctxM6gGpXsCeXofXTFEDDdsylV7/U5KcFY9BIwsDwcK/H0VsLcAatYPh8VRyRKOsiTNJLui4RKIigmEmoXj+f/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:23 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:50 -0400
Subject: [PATCH 06/11] ARM: dts: imx6: change voltage-divider's
 io-channel-cells to 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-6-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=2194;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=viq9nA3ofPon+PpRpfguphppP+TdNUaxHYTA6iGn7js=;
 b=oTpXo9xUDsbwXv/uJ9YkcD5OSY/xJyCyCV1VUc4XVQZPsKyY65cH/1iYwdKA1I2oglLlkn5K7
 Er54DLe9i1CAkOjPGDVYfEyH3NhC693kjd2Pr0NvbBmdpkzW7kYWg0t
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: d61da12a-06b0-415e-5351-08ddfc788035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXN6YnNnNm5kbjZSRUI5dkZFVjJ5eFJmRHBGQ0NlS0ZGeU1hclVxTjVhbWZS?=
 =?utf-8?B?WCtON2ljOUszdVYzYytFRWs3L3g2OUJiaDBYZXB0Zk1peXhUbW5Fdk1oMkxn?=
 =?utf-8?B?R1FDSWphdGRZTjl3eWhYK0FuZXRpOTlUNUNsT2o0WWJCellyOHZTTElvUmt2?=
 =?utf-8?B?M25vTmtnd1I2bmF4MFBOTUhGY2wxT0htdHJZUmEraEIxSDdGSGdsZU10bjdj?=
 =?utf-8?B?NnBnR3pqL0lnS0o5cXU1bjl1cVVBZVhJL1FJOENUd2djL0RpY2kxMzEreWFT?=
 =?utf-8?B?Wi91OGg1YWhGZTlOSjcvbWtxUXU2RDZBeGIrT1JTaXkvV3BacTJHb3hzVVgz?=
 =?utf-8?B?K3FENnRjRUZOTTdEU3l1b3pDdEtOdVpJdmZadmpDOGJ0WTBwT1Z5ZVVIdENz?=
 =?utf-8?B?dk1idWtwNE5Eb05rbTEzR3VTOGhOZ2VZSTVFWWRLU2FCMXB5cmljQlJGU244?=
 =?utf-8?B?cXgwbFVybGNOcXhaWHVsemhtOTFnWFpmWHArNTBvUE9ZTDFNZ3pLTml4Ykww?=
 =?utf-8?B?Q25Ia2ZJV1NFUGZLWWJsTmhHck96ZFVTRzh3VENsZ2lKYzdiVnZ4aExHR2R3?=
 =?utf-8?B?OUxOL1pzZFdCemR3c29KeDBYNjNCRUJyaEpvR2hhRCt0UTA5bzY4SUd3UC9t?=
 =?utf-8?B?RHVCazJKOE5Tc1M4NUpCUFpYWTBoZWM4TnNxSjFWTFFtbkc5UjZLcXJnRWly?=
 =?utf-8?B?THFRUmljQXZWYld2c0FiMGVaK0hNRmZ1NGF1UXVLNGt5b1A5Ym5wZnR4M28z?=
 =?utf-8?B?bGlCMlg2R01nckE2dzUzYWpXZU9rUUlmZ2dUZlFhZGpnVnF2cmdrN09EdnE4?=
 =?utf-8?B?ZGZ3VUZGbFB0WnUzaFkxOHBlaEl1WHdBYnNPQWJubFRyL0R2dE5sREU2VkhU?=
 =?utf-8?B?a1hnOHo3K1VqREorRTRqQ3pCOG9ZcjR4ZVZzblArd1VhQWNWRThlQVl5OXdF?=
 =?utf-8?B?NmliQnQ3K2Q2TmVNS2Fwc2pXWjNDRk1QNDRnOFdlazN6d3dGQ3J6Z0NmMW1F?=
 =?utf-8?B?VzJaTGl4VVJKK21aTTBXbVJ4b3Y2bUFFeHUxSXFXNVdFTlQwVTU2d1dHUkN5?=
 =?utf-8?B?c0tpMEdRWFdTT0xUNEpaNzhxenRTNnNlRDJ0bG5xUUUvcWIrYW90VjV3Nlgz?=
 =?utf-8?B?WkJFQ2RSNzU2R3NuQnQybm5zdTdyanRHQVBaVU4vVVFQUTg3b1ViU3phdWRv?=
 =?utf-8?B?VEhGTWdOKzRDZEI5M3dYV2RNc28vWTlkcksveXhWeEtDZFUySmkyMmRxSlRv?=
 =?utf-8?B?RWtETDhPVmlqRXc2YmYxS2V0YVNNRTk3Q0NyMHZYQTR6SlFvajllaWtDS1Nk?=
 =?utf-8?B?dXcvMEhFZ0V2NlVFWUxSRE10TVRzRmx4Q2VwOVlvTDg4aWRhRWI3SUVWQ1NH?=
 =?utf-8?B?NTBEWW5aY2tXOEFwUkltOXFNQzZIb1BacjA2THBnNWpHSURnL240bVo2bitq?=
 =?utf-8?B?azJ5NGF3amxiYVcxQS8zNVVqeUdoR2RETjlNQU5SUHpjdEt1UkkyVzQwS0pv?=
 =?utf-8?B?RmlMc2FWZktzcEJnTGVXTSttZEJ3aFFoNm1nekpyUktKRVRWY1h6Tm43dFVl?=
 =?utf-8?B?VXNocWFlZE5lNk1BQVBnanlxQ2lJWWgyYWR0M3IzMDl3Q2oyeG1LNWNMQXRs?=
 =?utf-8?B?TzJoNi8zakE0WHN5WlowbjFlamxSZDM1dUJNUmxRZmt4L25xaFJLOG1lelBM?=
 =?utf-8?B?bEZ4QnkzRHRaaUV3djVRNWtINmdmUWE3TkVVSUJ0dWtXck9DM2tHK1kxSXhP?=
 =?utf-8?B?SDlRc2ZhNDVIRFVwMXN3RWNERVdTUjFkcVBweEJtSEc0ZDV1RGlDa0NlZXVW?=
 =?utf-8?B?RHhSZVpwV3JzSEExbG8zMmNONVZEU2V0MlhIZCtSVzFTY0ZLS2N0dUVVTVVB?=
 =?utf-8?B?amNiUExJc1RML1R4ejEzMFlNQjZjak5CKzJqMmxWbUo3RHZpd0Q2Sy9kZ2U0?=
 =?utf-8?Q?/WKyLapvjs4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0tzR2RUUFRJUzI5WWRrZ2wzbEt6NlRaVkRxUWg4YlRJTU1XU2hJdDI2NTFp?=
 =?utf-8?B?cW9md3FJMTlSdDAzOG5pM2NaT2tnZ3ZpMk1pZVBtSFFDY1FjYkNpbTlpVHhh?=
 =?utf-8?B?NUlYamhNOXFhZTgvRmI4U2kycHkyd01LTnI1K3hhVXdCQ0hySjM5NHF3dXNJ?=
 =?utf-8?B?bkJZeUI0bFRrdFJML0xQQW1sN3hVSUVBdzJURG5zY1RCek8zQlNLbUs3NGR3?=
 =?utf-8?B?Vk9XUG1xdnh0dHpjUWtSVklTSGt0TVlyK0ZuY1VJTkQ4VmVZZ0VwS2xEcWMz?=
 =?utf-8?B?OVpJZXZMUW1yOWdTRzBBMlZ6RGYvNjZwRzVHWWhiZkxjU3Bya2dXMkxFaHpC?=
 =?utf-8?B?MExkN2FpWUdqL20venZpYjRncUc2bSs3Y1dnVnFFcnM3UHhteG54OGRxWmk1?=
 =?utf-8?B?NnBNeEJsKzdmRG1rWXFCb3pKTitNRW1PdVdvcFZCcVJ6WGM3akpaTEZWbXlK?=
 =?utf-8?B?ZmIyMm5MN05YcmViYTZmN1lOdVN3YTM4Y3hUM3ZpZHNuSFRNNzQ3V2Ura0p4?=
 =?utf-8?B?MUxVZXhjQmtsWE12SUNCaFU1c3QrellJOVQ2cWRCMWlZN21CeDRaTkZTYk5i?=
 =?utf-8?B?S2xxeEJubVgyZ3EwWmNQL1VTbGZCVUs3UUl6ZGJDYms0ckI5T0RWZEs2eEt4?=
 =?utf-8?B?TlhZUVYvVXR6dGdHUDlYMUxJbHNHVjUybkhjaDN4dVdha0tlU05GOEI3bVVu?=
 =?utf-8?B?U3ZvV2dtNE5OaEMya2N2VWt3L20rVnQvZkNkT0xCUi81SVhvNjdLNCtySytE?=
 =?utf-8?B?QU5Tbkp3ZjdIMldjYmhLcGRkSGkyL3IwUTJ4ZXlFNzd3NWRWMjJZSmh6RFpC?=
 =?utf-8?B?WWtsK0ZFRS9KMHRhTGJuelAyQXBVK1FxNHBWZkt6VDVuSUlHaTY1TzB2NFRw?=
 =?utf-8?B?TEdCUVFoUCtEc3pjR0tEMm4vSjVLTXoyd0kxZTVBQS9QSmlsQUNJbnBmM1ZC?=
 =?utf-8?B?U0tmRmFycCtJcGZEN0ZIRElmeDA5cG9XbWpnaEZCc0RTL3NnVGsxK3EyNS9r?=
 =?utf-8?B?R3JDY05kOFlvc3FucHk1NW5OdW9lQVI3aXIvZUkwVFNNVVNjckJCcGc5Vllr?=
 =?utf-8?B?MWhvMlQ5RTJRaTVrNFR4MEJtckhLZytEVXdyb0E1RVloUlZQUDlEK2NHYVZ2?=
 =?utf-8?B?L2V6elF3MzJNRmlSSjJpT1FBWGZJMnh3OHlHMmlPM2VHNWE1N256TWR2aDFj?=
 =?utf-8?B?SGV4bDJYNEd3bXVla0VCaEFnNnZBSGVmNXE5VHlaTmVSbUltYmNjOW5uTUJ6?=
 =?utf-8?B?RHdlQWtIZzZaV3VJLytHeHI0czViaTJBSEdQSWRRNHE4eEdQU3VKOGNSaGZp?=
 =?utf-8?B?ZTYzbnNpWEIzMDFrNVNpdFJ2TTVBY25venJDQ0J0MVBwVW9SK09FRDRhRFZX?=
 =?utf-8?B?N05vNlFvd0RCMG5oeFpDdFpLUkdYOTdpclBWaUJLK0NNd3Fkbm84RlVsYTha?=
 =?utf-8?B?emQyNlNUb2pnaTYzbFBJbnJXMC9obXJ0VzZiTjZIM3JFSTZ2NE01NCtpbzdi?=
 =?utf-8?B?SXBkR25TejhOdHp2MmYzaHdoaktqT0lkdHJJbndNUTBEenZmRVZDQ0NGcS82?=
 =?utf-8?B?MEVFQnowdzd5b0UyQ1ViUzJoc21YOVl6ZTQ0K3h5REdoSkNpbzcwMXljMkMx?=
 =?utf-8?B?U2xoeWRIM1ZEMXgrVzJRMUdVTFVHQXozb1MzYytOMmF5UUdBMlpQaXhQRTc5?=
 =?utf-8?B?U21mTHlnUmxIT3QzcEg5VFhQNDBNZGprR25GQmNHMnJmUExLQ3ErKzNMdHFy?=
 =?utf-8?B?dkNMSW5zZW1EQ1JQd1c3dkxxbDlnVWJCKzJ0aUtla2VhVzJITktaK1ZHQjB3?=
 =?utf-8?B?Ry93MldqK1JJWjVQSzdVTElhbUdBSlNDN3lCWU1tTHUxQVE4OHVqK05qRm9w?=
 =?utf-8?B?SDFvZStQK1VZVTV4emdOUkhjTUw0Q28zRFptNFFUQlB1cHdNM01tVXdhMTVp?=
 =?utf-8?B?Mmg0QkpHZ1FwaGlhMEdteEpuR0pPWHJmS3hnemdkNG5LWWRrWU4xU0YvUnZa?=
 =?utf-8?B?TFdjS0FmUWxUdXNiQzU5cWJLV3NVaVVJc21tMVBBWWpRL0ZLN0V4d3FMR1NI?=
 =?utf-8?B?TlBpRW9RWG42QUdyeHJDS3YxNVAvZDRnQ1ByZjZibnBXQnNjalpHQU1MVWVK?=
 =?utf-8?Q?o0mINKT20sOYJ6jGYbuV9lvSN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61da12a-06b0-415e-5351-08ddfc788035
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:23.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGBAHcEE1Plq6lridNvxVYC2CeGoi4WqmXceFWNGWa31HIZmKB0fcz7TpOJMXMxP8Y9DmSMPERj72bHozOP30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Change voltage-divider's io-channel-cells to 1 to fix below CHECK_DTBS
warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dtb: voltage-divider-vaccu (voltage-divider): #io-channel-cells: 1 was expected
        from schema $id: http://devicetree.org/schemas/iio/afe/voltage-divider.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
index c9dc48c1f9b1c36e33a55c64b9fa64262f011f8e..353f7097cb7e0256c7c89a36cb7568f229370f4b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
@@ -55,7 +55,7 @@ display_out: endpoint {
 
 	iio-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&vdiv_vaccu>;
+		io-channels = <&vdiv_vaccu 0>;
 	};
 
 	keys {
@@ -318,7 +318,7 @@ vdiv_vaccu: voltage-divider-vaccu {
 		io-channels = <&adc_ts 2>;
 		output-ohms = <2500>;
 		full-ohms = <64000>;
-		#io-channel-cells = <0>;
+		#io-channel-cells = <1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
index e258e7b3b3fe792d061002a6b70bef4b22c5e89e..76b0007d20ad22eee738ab40ed126435a8fd17fd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
@@ -35,7 +35,7 @@ key-enter {
 
 	iio-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&vdiv_vaccu>, <&vdiv_hitch_pos>;
+		io-channels = <&vdiv_vaccu 0>, <&vdiv_hitch_pos 0>;
 	};
 
 	panel {
@@ -147,7 +147,7 @@ vdiv_vaccu: voltage-divider-vaccu {
 		io-channels = <&adc_ts 2>;
 		output-ohms = <2500>;
 		full-ohms = <64000>;
-		#io-channel-cells = <0>;
+		#io-channel-cells = <1>;
 	};
 
 	vdiv_hitch_pos: voltage-divider-hitch-pos {
@@ -155,7 +155,7 @@ vdiv_hitch_pos: voltage-divider-hitch-pos {
 		io-channels = <&adc_ts 6>;
 		output-ohms = <3300>;
 		full-ohms = <13300>;
-		#io-channel-cells = <0>;
+		#io-channel-cells = <1>;
 	};
 };
 

-- 
2.34.1


