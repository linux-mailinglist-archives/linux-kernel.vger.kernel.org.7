Return-Path: <linux-kernel+bounces-853271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63328BDB14A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F224A4F11F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535232D0625;
	Tue, 14 Oct 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VP1idQem"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23F2D0626;
	Tue, 14 Oct 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470729; cv=fail; b=RdlNQMwFFCZrHqKPNq8Qvc6aL9AFFT3HkAGQQUWHxd7I0+mZiqh2xPR8TBwvDp0BcOaSe0p8x94k8PXMIsJXK9cpuAaPUDrUQvDvfjOInMq6/FWZHQ05l9m6rCu/KxO8yL3zfV8r0RO17egSH1FvXFs31ofJi+5SidkVlpGj8v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470729; c=relaxed/simple;
	bh=2wzB7zdqenBM7zegv7SxF7k2t/No5zU8RVrXyNylZQM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k9KVIjSEy61DEG5FFE81E2U+q+Fk/GB00Dfi3zBnq9NJF5jmt6v+dWYAN9zTlLPY6Q++ebev8GXLQtryYyArc2e+U9ZmZrKKir2TIi/2ST2vopL6TKgrQr4+JSr61EMgrNdHcRkMqMCj/mTGXw5MJbR+WgiMB+h7yyfWmlUQ/m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VP1idQem; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRLOwPy/t49eo79ptk8/wLN+BH68WFTDLKlFJ8LY1CnGWWGlIdImaFrUR9rfoYBVH021bLL7UWMptAPJqZPMJ3zKlgF9+vO9F+GrgZ8BdImwtmRIg4a82k5EhydnutnECEN4UgA/RYQGmLaDscYD6QTva1SlmBdTrj3VW6xZs8FZzUC/zwvTReGvMQvhPPQ/kcpGK1oDvWOJ/NgWmX09Q+CZd4o8KV+ZZ0H3rrIEI1jFaGQK0oBkQMSe3DnXjKWEn2e+f6YM5xz7Bvfw1suOH63B9TZ3AnYzHvgomsGc8p7snbbcOO7rYw58ZxC0F9JrEVqPaqwXKj8WuZorDjjsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KNsVDo3LShWq3fTPWamBIaSUwjNZxgeJoIzHmQ9ozM=;
 b=JlDcksz7QVWfQ/SOSrNXP5we5IXnhz+ljwquuN/fNN2onRA4TvSKmc3qg/ROlf2qQt3qh+2ujtS4YSXnHQv26XbOitpW/FdP7YcqnUrzddMiz6MgYZoRgs8VG4PBeQOYUAfA77PuLm/1FpbpiLJ4fkw88H/4Kyr0cajKA+hLkAhHN4gb0AXLce/eVX9V7G6q5w9cs+ZYgrtsleYSgPrWiijqSQxVMak9VlhksmVgXJ3CzuhUCAgkcztQcQxrexZZKbVXqkctk5z1MVIL/8LnGDgACWaYJs271m6uf7NMoqxkZ5bhHMuc1VQ/AUus81ISplunU+D8XpjA3XaRsdQaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KNsVDo3LShWq3fTPWamBIaSUwjNZxgeJoIzHmQ9ozM=;
 b=VP1idQemgZ5IRxHugdTCTaqNV/zMxIaVntTlRAUm9Nb4eqUrDYv9WpVxmVNNpaIdTxuURJrXSca1EKJQcPTZvryYjQ2zahu7N8LBOnuTowomrPmaGTn1Kyr7NNIj8tdNPScIpHACfH+HYzDnqGeriGaNWEISqXDheTNizidjLHSkSH6ACsMzYMV4Nh13U8qMh6bqyiiq4NY17OnC+w/JYYsuS81kPNhCe3yGEU9/9d1iTwn9Es5LeOykFusXVhsgpEUTG5rxRUCQQ0Fgsua4980nRFwxLjMLBDKMHxUOtZL+gTQOlrqmOSKCTLZujLpvKNxPkX8uFwubCZQeS3r6wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:38:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:38:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 15:38:18 -0400
Subject: [PATCH 1/8] ARM: dts: imx: add power-supply for lcd panel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx6_dts_clean_2-v1-1-508b36e5a3fd@nxp.com>
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
In-Reply-To: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=14705;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2wzB7zdqenBM7zegv7SxF7k2t/No5zU8RVrXyNylZQM=;
 b=bldPLLumO0PYyH21E3spEta26D+urvnIs6TeWBIPZl7pSaH8H0Mm1hTWPrkbzkgiS/ZvZiWCG
 a02Q/gY6YOVD5GbUEr+2b6x1FbAgl2ukpOd9MoK6v8r8DAlMM1BOGdI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c48156-bf8a-43ba-4aab-08de0b5949fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlIwMS8wQm02dE9OcVpaQVEvOG9LVjlvQlE1ZWhOMTQ3b0NlS0FhMHBjM0E2?=
 =?utf-8?B?UE8yWjdmT2hKVWc3WGhmOHhWUCt2RkZ2ODdtOU5ySG53cEF6TUx1amRvV3VE?=
 =?utf-8?B?MVdacHNDTW5MTUMwbmRaVVJCSjk1N3JkY2QwalRtS3NHdDlUUkY4R2RJcUd0?=
 =?utf-8?B?WGpnUmpzN3dCQ1duZkt1cXdKN09CdzVQZ2srcUxEMDlheFBzTnkyMDF2dWtV?=
 =?utf-8?B?dzNycEw0SmpKeXVrZkROU1o2YXRQK0dqR3ZLbUFYNHNoM1B6VmthVDZSMVFJ?=
 =?utf-8?B?MGswNElmclpVWXJGOVdPYitUWit1Q1FoWXZNMk51WGJ1R25jbzNyUEF0WVlx?=
 =?utf-8?B?bVI2bC9KeFc2c2tBWks4emZyek9yZHltSk1RV09iUkk5M1RpN1MvYnl4MWxI?=
 =?utf-8?B?UWk2YlRUWGVoYlhJaHI4U3ZiejZXajVmY1NaUklvNkY2RHNJc0pnckVYbFQ5?=
 =?utf-8?B?Mlk3UEt2NldEOXdvOGh1MWlPbGlXSUFCcUZJOXhndG84akwySjUwMk0wcDRt?=
 =?utf-8?B?LytLNnRlcFFFUzZUL3lMMHNJV3lsZTQyZzBpRTdmaGd4Z2dBSzkzcFp4WWNq?=
 =?utf-8?B?N0F0dG5CeTlGTWJOU3NTTm9HRzJJc1FQV3pMTVA5YU5iN2hZRmNPT1pjVE9L?=
 =?utf-8?B?V3BwVktIalJHUGpUSFFEdmk1ZmZBUEdOYm93bXY4NUdOa0NqZWNHZERmelBQ?=
 =?utf-8?B?M2hpZnR4dkJteHZ2SVdIQjRiTlpyek0yV0xLOCthNldRSklYUHlZZjlYdk9l?=
 =?utf-8?B?OEJRemNTcWZaVVo1RFFsVWovU0FRaWUxZ2pSU2ZNQjVCOW1uNStFN1dXSmZI?=
 =?utf-8?B?dDhwM01DNTAwandGS1JtQnV0VHdQU2xOckRtbGFRdWRTNXhUN1pPSDRISlBl?=
 =?utf-8?B?TVBCbjM5RDVQbU9ESHVaeGlpbmlUeW9aTkZ5cG5VTlBSai83b1ZvYW5DZjFE?=
 =?utf-8?B?UzUyR3o2V0VJU24xZWFvSVRvd2JmQnYxa0l5ajJlb2gyRWhMR1NrTEdtc1pY?=
 =?utf-8?B?elRUaWV5amgzOXVrMXh3aGxWZjYrSDFGV0YvbTZOcDh6bUR6WmNNYTBpWG1z?=
 =?utf-8?B?MEMzWWxmZ2lLYjQ5dFFzcEFvUVZGL3BnZEs4NE1jMFp0bmJqZUJJLzJZRitw?=
 =?utf-8?B?S05oMER5cVk3SUpwdkpFZFZWM0ZqMVNOR0FRTytDVDFtRWNsd2t6dG5WemRP?=
 =?utf-8?B?MjRqSjNUNWlNY0ZzQXJhaURaYnUxVDNqZWJ5MDYyRGdaaWl1SHNVT29tckN4?=
 =?utf-8?B?Mmx3WVd6MFIwbkFGT2syWCtGakVnYnBDeXdjR0tqN29Mc3ZYYUU1MkRPSU1u?=
 =?utf-8?B?aUxPRlhONXhDVlh4NnFOQmdrM3ZHRFNtSXcxNW03VzhTVFNEQVRMbG81eURF?=
 =?utf-8?B?OHM4SHRWNkphVGdOL3cyUEtoMTAvejY2N0VwSllpbGYwbXUrK0ZYdlVoR01w?=
 =?utf-8?B?QWJXZ0FMZS9vUGxqYU9GZytETGNUMy9LYUNxN1JmeGtmeTlUa1lxanFjOHVk?=
 =?utf-8?B?alR3d0pQNGpIVlMzLzdVcVdJb3laUm0yYlJmdkNQb243VzhjTk5QeW5acGc1?=
 =?utf-8?B?OHJHN1ZtQW1uOFV5WnNkZGJOU1BuUnVvRXk5NDdTRGt6TEJPM2svdVpaKzhh?=
 =?utf-8?B?NEFYWVMvWE51QzVDUTBJdWt2S256Zk9MSnhjU2lWTnE3TDkvNmVqRVhLbnZk?=
 =?utf-8?B?RU9DMFVNMTNqRW1IenFtMFhNVFR1dUZwUjVUMSthbXVIcTFUWFZBb21MMXhW?=
 =?utf-8?B?dEtDaUMvNzRzZStEVTdEeDQwV2JxVXJlSlppdmNQOHhUVHMyRms1VGRZRW5D?=
 =?utf-8?B?azBvdU83QzVsTVdVbDN5Sm9Hd052aGVkbkVoQ29ZSGt3VFBNWHdXREJmWUw1?=
 =?utf-8?B?cEE2MVMxQVVKR3Q0dE9pc1BiTktUekRYcE54dm82Wkx5REhHRTVqNmtSQXI5?=
 =?utf-8?B?TVcwc1NFUE84ZytibW9Bb1VkcnNRem4wYkd0TTRUdFBDN2tlWldKNTJ0cHZZ?=
 =?utf-8?B?VjRRL215MUN2SjhIR0pnV2F5Mnk3TEszbVpsNnhhTWlsRTBLOW1jNjlVQ1dB?=
 =?utf-8?Q?W+ONRC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0Urc1JQYzB2WVZVYWtTeHc4alE0OVl3TTBSRGRNU084Nko4MkJWRkJCV3Q4?=
 =?utf-8?B?MTh4R0VNdG5sM1A1c0hpNEczNjV5c1BKUUJlcTJrOFJhN0p6elh3T3VNb0M5?=
 =?utf-8?B?eW5XVllMdU80Nm9rMkJlRjc5TjB1dHFhNlBxVnlKcUdDdUVwOHlCRnY1WE1a?=
 =?utf-8?B?WkRic2hIQVRCL0NLNkgwanA2MkdSK25uQzljeGlCbUh3TGZ1a3RtQThlR1dV?=
 =?utf-8?B?Tkh3dUE5ZDFNNndjbm81bnlvM2lPVGRVRDk0dUl2OEJZWEV6UFNZa04wTUJF?=
 =?utf-8?B?RXlMNGIzcVUyYXhWT1Iwa0kya3A0S28wRTNvWkFWWWcxM0hBNVZUUWcraUJ0?=
 =?utf-8?B?b1cwMmdQZGZRQndXb0MzTUJkKzJROWlPcndNb2tta1dhQmVrRDNMY1dPSEtw?=
 =?utf-8?B?dEY3c1JvYWcwTjA4bnM0Smh2WHNnYVYyblZtUzNUWEpqT0EwNE95QmJMNTR5?=
 =?utf-8?B?U1kyV29ZaEVUYS9rL2U4RTU4M1V1Mkdla0daenEvaTRITnN1VlNnYVlaOFpz?=
 =?utf-8?B?QTEzRERrL0VHa0xmNnc1djJpY0o2TEgwM2JFWDY0Ty9LQ1dWVlNMam40T1pO?=
 =?utf-8?B?RUQ0ZzFOV0IwYnV5Q3FONjJCTXduNXk4VEFINGNUQWx0cnFtcWFZeStSYkIr?=
 =?utf-8?B?VVNSMDBjK1hpaVVnRkhESGI2ZC9xdUxhaWZKczlmR1ZaUUMwTnRSUHAzVTZG?=
 =?utf-8?B?MVpQQXh4b2UwVDFrNk5PWUVvRTRHdndWN0M0T3pMM21jU2VMM3ZHbkhFL08v?=
 =?utf-8?B?OEZZVFBNZ0R0Qm05UWNXMnpUcDB5VjBlUVcvNS81ajFLSkU0VEVuVTNRSXdL?=
 =?utf-8?B?ZDRnUnhQZ25ldFFDQUJ4UGMxMStTSElLL2hpMml0RmFDbmdGMk5mSmlsbU1R?=
 =?utf-8?B?SWNYVERaeHlXQ1BONTVjZHRPcTdYK0QwRmZmZFJKdktLU0g5L0FIR3JFSFZw?=
 =?utf-8?B?eHBTUUwxRktmRi9rSEozUjVHVEd1aURTSUoyMGdsTHY2L3FrT0JTYjM2TVlX?=
 =?utf-8?B?VDN0VWhZOWcvRlorNHp4UVF5RFg2dmZuQVZYMU4wR096aEZWV0FzS3RWV0c0?=
 =?utf-8?B?Q2laYnZIODhIdk1XY005amlneE5ONVdlQ1lVbEdwUHI3NXkrNXhrMjhWMU1L?=
 =?utf-8?B?K3k3aWpWalBSWC8yNGt2eVU5MmQwWEYyWDJHTG93bm4xQ21pTm9sZzVWVkxH?=
 =?utf-8?B?V1gycXRIKzFHd2xjN3pSKzN1NS9BbElTSXBTWUwzZWtsVHltVWhLcXRNMGFE?=
 =?utf-8?B?ZUxlZlZYbUU4Q3BmSDc3V0lSbnlJSVNEMENmVjJWeXcvMG5UUjhJZ2o5TGJq?=
 =?utf-8?B?NVNLTllUTFhnUEpZWUN5Z2tRMURHNTdoc0ZaM1VFSzJqNnJDOW8yRnQya1N0?=
 =?utf-8?B?TmdaSXRySzN2eTNCWmJlT2EyZ2w4RXVIYi83ams3bGxYYm5yRzloS1BLZVlo?=
 =?utf-8?B?WUJzZG5WWk1vSzltanFFdDZHQnoxTHRjUlo4TkU1cmQ4cWdKRHZjREQ2VzVa?=
 =?utf-8?B?K2Q4a2pSdWgrMG9ZeGpWTmk4MTRUbXl3WkpvejUyejlyS25IMWhPVVZHNVFs?=
 =?utf-8?B?SURwMno1VTMrSk5idmFTUDY2YXBYdnAvajlkdktEK3RYQ2szb1hDdnZuR3Iw?=
 =?utf-8?B?YzNVNXhzSG42T05ZQmk5K3lLVHh6dkJnTzlUMndYaWFSSHoyMm5ZamRFdkRZ?=
 =?utf-8?B?WnJSTEN2KzJOY0QrWFZFUzNIREN3VEt1QVZoVXB1bVZuSGpDSVUzaEpJQm5J?=
 =?utf-8?B?YkF6RFV0aDhZcUJ3NzRxdUN4M0JUUUg0YnlwSGNaMVlmQjgrOU00VGlCNGpi?=
 =?utf-8?B?ckloQkRlS0J6TXJFK1QzK0NRbmlMcnR5NnI5UWExSDNYVTZmVGMzS0VMa3Iw?=
 =?utf-8?B?eFJxdTZLbTNjcDA5QVZPcTFFS2FyYTBmUmJZNU41YXY0TTdVNVNneGJIbjFC?=
 =?utf-8?B?eFBBdDMxc2pXL3R5MkxIREZ1M2NjZDEzMThjcC8raXQrcU9vc0N5Wm9MM3Rm?=
 =?utf-8?B?cEl3ZjZONzBIVVFvMVZvQTVqWlFiRUtJV09scktOQ0J2QnNCTXVyVnh2UXBJ?=
 =?utf-8?B?RjhYNUtObEkvTW1MTDcySmxuNlQ3NVNjclJXdWpMQ1M1ZzlTb3FLQ0ZKd2RY?=
 =?utf-8?Q?DUy4+xUvJV/gUevWs/RK7F/wa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c48156-bf8a-43ba-4aab-08de0b5949fc
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:38:45.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq5mXMkCk1i1vsUg/aWxpv5fnmOTZ5KAtwei0Jv9mZyPKqboNmwjGJCADmVAo4XhX6AA7ZRZbae/T4Bt7GqiSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

Add power-supply for lcd panel to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: panel (sharp,lq101k1ly04): 'power-supply' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts  | 1 +
 arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts           | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts         | 1 +
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts               | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts     | 1 +
 arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts     | 1 +
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts         | 1 +
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts            | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi      | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi  | 3 +++
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi | 3 +++
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi     | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi      | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi        | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi        | 3 +++
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi       | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts      | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts         | 8 ++++++++
 18 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
index a7400d42475b49928d0b3d376516e58cb8b656a3..bf8e07f971435da537e2b8a64be7bcfc01f21955 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
@@ -20,6 +20,7 @@ memory@10000000 {
 	panel: panel {
 		compatible = "lg,lb070wv8";
 		backlight = <&backlight>;
+		power-supply = <&reg_3p3v>;
 		enable-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
 
 		port {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
index 7c62db91173b78659372b3095a2676fec4eaea0f..47a6d63c8e04cf28795310aafcdd3b2b05740830 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
@@ -72,6 +72,7 @@ led-0 {
 	panel {
 		compatible = "edt,etm0700g0bdh6";
 		backlight = <&backlight>;
+		power-supply = <&reg_panel>;
 
 		port {
 			panel_in: endpoint {
@@ -89,6 +90,13 @@ reg_otg_vbus: regulator-otg-vbus {
 		enable-active-high;
 	};
 
+	reg_panel: regulator-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	usdhc2_wifi_pwrseq: usdhc2-wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts b/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
index d3f14b4d3b51e19a5bdf52f9d99da4b314da7811..929def2bb35ebbd40455133e7b0cfbbd34d7f61d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
@@ -46,6 +46,7 @@ backlight_lvds: backlight-lvds {
 	panel {
 		compatible = "dataimage,fg1001l0dsswmg01";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_lcd>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
index 78d941fef5dfb288c69d702ed190150caa92ba7a..c764634cdb2bc6145590ebd1636c51b6d02be1f5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
@@ -55,6 +55,13 @@ memory@10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_usbh1_vbus: regulator-usbhubreset {
 		compatible = "regulator-fixed";
 		regulator-name = "usbh1_vbus";
@@ -81,6 +88,7 @@ reg_usb_otg_vbus: regulator-usbotgvbus {
 
 	panel {
 		compatible = "sharp,lq101k1ly04";
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts
index 02aca1e28ce3feeecebb737b09ea4f8208974e43..1ad3bdcea4a3497dd5bf1c6ad0dc32cfa8af9522 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts
@@ -16,6 +16,7 @@ / {
 	panel {
 		compatible = "ampire,am-1280800n3tzqw-t00h";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts
index 241811c52b624625c7a44cbd46558b78d5f5b154..9e1c64da0b30adf371958505614cd47a0c451053 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts
@@ -16,6 +16,7 @@ / {
 	panel {
 		compatible = "koe,tx31d200vm0baa";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
index 56b77cc0af2be51d8eb6a9b0931d977e1f267670..b821873aa52639c912d05e0694ce6a55da248cc5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
@@ -145,6 +145,7 @@ backlight_lvds: backlight-lvds {
 	panel {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts b/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
index fb81bd8ba035165525337a35acfe67f155bb7e46..73ed40ae5a7bc25ca13683d907dd762f7a8ca52e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
@@ -57,6 +57,7 @@ led-debug1 {
 	panel {
 		compatible = "kyo,tcg121xglp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
@@ -72,6 +73,13 @@ reg_1v8: regulator-1v8 {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_wifi: regulator-wifi {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
index 8d471450d5c5c76131ab9677986228c1615f584e..610b2a72fe82557c51fbad1bfff65154540e2279 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
@@ -127,6 +127,7 @@ backlight_lvds0: backlight-lvds0 {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds0: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
index c727aac257f9c3a1f16dc357fce355ad46a3f699..ca29933302c6b9b19eb5daced48cab2b458d85c0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
@@ -237,6 +237,7 @@ lcd_display_out: endpoint {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -248,6 +249,7 @@ lcd_panel_in: endpoint {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -259,6 +261,7 @@ panel_in_lvds0: endpoint {
 	panel-lvds1 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds1>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds1: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
index 806af7f60419e7e81c8373cdbaca36453abbbba6..03fe053880ca6e0e9870cb13f932a3b5afc8fc79 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
@@ -114,6 +114,7 @@ lcd_display_out: endpoint {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -125,6 +126,7 @@ lcd_panel_in: endpoint {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -136,6 +138,7 @@ panel_in_lvds0: endpoint {
 	panel-lvds1 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds1>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds1: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
index c71aa7498acf4a0b1cc8f74c325c8944ed1a781c..6a353a99e13daa2f13ba91d7311f60c88b40695b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
@@ -179,6 +179,7 @@ lcd_display_out: endpoint {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -190,6 +191,7 @@ lcd_panel_in: endpoint {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
index f7abc17c7c93a7016854d7beb7d041dc90301514..8323be1bfb769fda5c21ea9d4790786654e996a8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
@@ -207,6 +207,7 @@ lcd_display_out: endpoint {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -218,6 +219,7 @@ lcd_panel_in: endpoint {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index e8368c6b27ef3be2bae1d1dadc7c29672db0e5df..cc2a7b61a293a0d8919a74a0ea28ae83390dd68b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -17,6 +17,13 @@ memory@10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "reg-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_usb_otg_vbus: regulator-usb-otg-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg_vbus";
@@ -139,6 +146,7 @@ led-red {
 	panel {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi
index dd4e5bce4a55dca44ee70d5485017ddba1e186d2..8232f4ea27526584b52654d7d3940eb5b104794e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi
@@ -16,16 +16,19 @@ backlight1 {
 
 	lcd-panel {
 		compatible = "edt,et057090dhu";
+		power-supply = <&reg_lcd1_pwr>;
 		pixelclk-active = <0>;
 	};
 
 	lvds0-panel {
 		compatible = "edt,etml1010g0dka";
+		power-supply = <&reg_lcd1_pwr>;
 		pixelclk-active = <0>;
 	};
 
 	lvds1-panel {
 		compatible = "edt,etml1010g0dka";
+		power-supply = <&reg_lcd1_pwr>;
 		pixelclk-active = <0>;
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
index 73c9cfbdba621c1cf42f56ef2e9d31574c4f8311..3d147b160ecf150f2f3b6afa8b5873fabc2ba96f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
@@ -43,6 +43,13 @@ reg_2v8: regulator-2v8 {
 		regulator-max-microvolt = <2800000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_sd1_vmmc: regulator-sd1-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "VSD_3V3";
@@ -157,6 +164,7 @@ gpio_spi: gpio@0 {
 	panel {
 		compatible = "innolux,at043tn24";
 		backlight = <&backlight_display>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
index b29713831a74489e8cc0e651c18a40d85f9f9113..04e570d76e42cd67a38e0f3b2301598f712e6bd4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
@@ -199,7 +199,7 @@ touchscreen@38 {
 		reg = <0x38>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>; /* GPIO E */
-		power-supply = <&reg_panel_3v3>;
+		vcc-supply = <&reg_panel_3v3>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
index 7acd28658e6ffa3bc649c93c19d2f0b8e5a9f51e..2192f105ec81cb488f1c3634cf0ecda21492eea4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
@@ -35,6 +35,7 @@ backlight_lcd: backlight-j20 {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
@@ -61,6 +62,13 @@ reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
 		enable-active-high;
 	};
 
+	reg_3v3: regulator-3v3 {
+		  compatible = "regulator-fixed";
+		  regulator-name = "reg-3v3";
+		  regulator-min-microvolt = <3300000>;
+		  regulator-max-microvolt = <3300000>;
+	 };
+
 	reg_can2_3v3: regulator-can2-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "can2-3v3";

-- 
2.34.1


