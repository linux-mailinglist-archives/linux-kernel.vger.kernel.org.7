Return-Path: <linux-kernel+bounces-817335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35EB580D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503784C2114
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5432B35083E;
	Mon, 15 Sep 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="LBEzD4c7"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021106.outbound.protection.outlook.com [52.101.70.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50D34F476
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950159; cv=fail; b=LbZ1crBPBPVILou4MPR3hlRcXAdOa18k1RFCZHtUJB3LnZPqq750guBxyVW5W7uvnnIUwt/CYlJEOyB/3X/ruq5zrFiL9x7Z/G4RpaArl0CdEhzl9nZxYI+uiWmxJouGe5JZzUZ6bI7eD4pQQX0ptmV/fLIe43J4iYEJrmDWhwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950159; c=relaxed/simple;
	bh=Wn8lyCZbPQYWszZWNiFM+A2MZkysOMPGuAoWFGlIDZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LhSfbae3epCg0Bt8OB/eqG/iwLScgUrrTsYawKgVnVzPB6wvUnB6bipFxvNVrsavbs9Lc3KsMhsvGSjQsIQXeBEZZLQEdK9t+pEElroUzOs9jIQlT5VL5MxwiJf2U95M0dYZTGypk/1kF76gzjKjlKCU6kpDcLF9M6LtjmOthOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=LBEzD4c7; arc=fail smtp.client-ip=52.101.70.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soQvWxk3SDBC1px6EWarimxgeTUF32DPCqZjbuTRBCryHAfK6z9L6+QgNztIkE/Lh5kMe7qXlDKpoZlzub6dBGlGBvgd+KcTXKCrvTE1D3qgifUSIwtQ3/+3oBipCkcWwuaK1DhzNHkX8SU4anEfMWcPbbETF4GEESEDp+1Ba+veM2AbSFoeECmcoLuv4yyCmVOQ0VlEeZEiA2eUqPhpEAd9T/uvYH3+VqhVu449SN38zSKwEGhtmQ99mPuPmOlH2Dgq3aSrzJrCk3rOcsW/8VJXL//5/dxN023uN5ssIGF694o08NaCcSErfAJ1msKRN0hPMQSr7ziqGAXZfKaBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC9wAnTO4Ke9a0hJWIpSTTJD6xRtzAfbYqdhv5fvPxU=;
 b=QaKfXJ+rGuIRWF3kEapKzaMR2+SkN+dTpiDhRGYCduCWGDqgrsklTdD+iNVPXIzXK5BanhFqDIsNuxhO8POQio5rzLUDiPs6nGTbVrtW5VQduduk/UxW6nvNS19nqKOL2sRMHmNPXfJe/0bQSAdBohJdvf3pvy/5MF0H+l3h/Y5+yZthEixcVKImlJXYW9uAEGfPqRKcVQPxpdNTgQb9mWyjUA2YSSZTzSB2ejZrUFoKsbSBWQ73RvlnHEKmk+Jtsfb910xwyThEKuHgDdJqGDBz9dgHMCRM6pgQQH5XD9iEJieEZyPR8SWoCie/zRKgl6VV+sbRUcIyBrSTC3+ofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC9wAnTO4Ke9a0hJWIpSTTJD6xRtzAfbYqdhv5fvPxU=;
 b=LBEzD4c7h9viNkjLIGllrbnfh6ZECMZ7tPWgICgJAFbbXI+j/LRr8hu76WtLO3pblSa9AtAj/C8MlOTkAT8Aw/eSwvBkOUMm5NiLUC5wnD8kR+Z7q9ybdaRp9jG0M1nt6MDHdbNlrzA7gxYVHXl42MnuMmqcPup4m1raGoF/PrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from VI1PR04MB3984.eurprd04.prod.outlook.com (2603:10a6:803:4e::28)
 by AS8PR04MB8214.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 15:29:11 +0000
Received: from VI1PR04MB3984.eurprd04.prod.outlook.com
 ([fe80::e8a0:97a2:eb7b:afae]) by VI1PR04MB3984.eurprd04.prod.outlook.com
 ([fe80::e8a0:97a2:eb7b:afae%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:29:10 +0000
Message-ID: <b1a2ff62-441c-467b-843a-5125cbf14ce9@sch.bme.hu>
Date: Mon, 15 Sep 2025 17:29:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: sysfs-pps: Fix `Description:`s
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250815-b4-sysfs-pps-doc-v1-1-61d315eafbca@prolan.hu>
 <c226c97b-e42b-4ef8-9cc9-56299f0b37c3@enneenne.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <bence98@sch.bme.hu>
In-Reply-To: <c226c97b-e42b-4ef8-9cc9-56299f0b37c3@enneenne.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0156.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::40) To VI1PR04MB3984.eurprd04.prod.outlook.com
 (2603:10a6:803:4e::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB3984:EE_|AS8PR04MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4381f1-9f23-47cd-edce-08ddf46c9e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|1800799024|366016|376014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1RFR0l0WmZ5UnN4OUc3OEdITmVjaHBpRzJ0QlJMM2hpaERqTUZWOHZoMGVo?=
 =?utf-8?B?aXY3M2dHNEJYbkVYWVB4S1Z2cFRpS21TVWxtMWhic0FBWThvNHBrQnR4aWpW?=
 =?utf-8?B?Tlh6Z3RDRGRkc3BFN291MUU3VTcwd1hsTmtpVmpQWWlKM1prUURJV1FvZlVC?=
 =?utf-8?B?TUhKZHlYV0lHbFNhQnZIa1kwRmFBcS9FWERxL0FsMTNvK29ESU04NTEwZGZq?=
 =?utf-8?B?NmFkK09YeU5yYWdUcndFM2Q5L2VrMkJIa25WWURVOEhxc0NhOHVtamFIZmdT?=
 =?utf-8?B?VGNpTk9OdWRQbURBdU9zdWpiekdmblgyMWhFZ00zVFQ1eENWc05Fck9RaDcr?=
 =?utf-8?B?SnplUEt3T256TU5DQUhuTTFCYjZmeXJyWHZ3VFQ2N3ROMmtuMmp6RTltZDcw?=
 =?utf-8?B?Z0RMQS9QYUw5cTUvL1Bza3pRNnc3UXhwM0dacjVHQk9sSG1lY2lVSlNFUGs0?=
 =?utf-8?B?OEk3TzBDaElnQytQMElVMXhVcnlzYkIrc1Bnc044a0tzejNXMWJlVFZPeWxR?=
 =?utf-8?B?MHdJQVR5enZsMUN1aW12SkFCYUZHcW83L28yTHBuVE9DdGREOHhrb2szSU5n?=
 =?utf-8?B?TFpjNDRqcFZiQ09Kb0RxL1hZRm5LWnRmY0EwYkNqK2F4Nmh5TFYwd2xGSWtO?=
 =?utf-8?B?NHFOR2FQZTM5enhsMmVXZmVDNHRQVzR2blgrYytQeGlMbXg5akk5c2t5c01t?=
 =?utf-8?B?NmJHQUZtcnNTMDZoV0JoVmtOdFFsUzJBY0tXVXVyTWlGenVzSlgyMnp2b3VW?=
 =?utf-8?B?aXFlaUl5THg0ZERGei92UEJZU1p4VUU0WUpsWkU3VDNKODdyd2g3NThJRGRP?=
 =?utf-8?B?RzdFSk4rUmdveE5uLzZrZE1ybG5oY3g4YldJV2pBNWVhOEp2TzJMbExwU0k3?=
 =?utf-8?B?SnM2Vkx0WHNBYlJJQWtxU2pRKytqaVJrMmFnVi9NWlNqVjQwQWE5MHZGZlE2?=
 =?utf-8?B?L3lsUURrM00yRW9FOWJQMEZnbytJTzFTMzBXb09EV25ROWhPa1dNZ2cyeC9L?=
 =?utf-8?B?ZEEwUXBNVnBLeHVFQXRNRVJMUU9WcTJEWjdZOUxDUUV5S1FyQTBYNnUrQmVP?=
 =?utf-8?B?aTNESy9YM29wMXFwcStpMkExeTdhUHI4WmNuN0NrQnlRcGFFbFRGL09TcFp5?=
 =?utf-8?B?ZEhJVmZsb29BOE1NaitJNjV2Y1hHbjJiN09oL3hIL2lldFhrd0VJVzRmTnU3?=
 =?utf-8?B?a2tQMGVaWFJlbzIxbk9hNlJmM3oxQ1FsZGtvSnVIOVRta2xUUmlWbVVDb2Zo?=
 =?utf-8?B?SE5MUTNmamtLVEd5cG9CUHNFeThGdGlTMnZZRXBEaVN6cUVSK3hQQ05GcVpZ?=
 =?utf-8?B?RWZQbEVpS3JzSlJNTkwvLzJHS3FTNnE0cHN0YzFjNHQ1K2lNVXRGZmZvMENj?=
 =?utf-8?B?ek5lMzUwb0szK0ZmTjd3YXBwa24rUDJXUFR5amkyYkpVUm0ybUhpM29FM2RD?=
 =?utf-8?B?cjFxRnZTNDFEK1N6Mk1RaWd3clFaWjlyYXhCMU92TGNBOG9rL3RRQlRoVDdm?=
 =?utf-8?B?VFF1Wmg2bWY3eWkyRUEwUVJuUHg5RUxhenlteWo2aFhET3IrcHhJZWtDUVF0?=
 =?utf-8?B?TXhlaUEwekx2bk13amc2WTBIeWRxU3FTbjlsekJzTFRkU3YyS3dDNDhOYkRp?=
 =?utf-8?B?V3VHb3lwQlgwZ3gxamtZL0Y5ZklDN1cvUGFFOFpaY29MOGgrNzkrSmJzdjVk?=
 =?utf-8?B?dDdYVzNiWEgyMzNpZitjdTAzOE1kQW1HQkppUVVXU1VtS21NUEhxNFVqNDlQ?=
 =?utf-8?B?Vm9LQWRzVmgraUpRd0lTaHZuK2dLVXdmK0YzMXA5S0tCSFhIWjBGV2RKV2p3?=
 =?utf-8?B?dGJlV2JISVlBUWdyRWpKV2NVUDk1SjRSajFYVld1R1pFaUxtN05Ka05IMkxk?=
 =?utf-8?B?MVlSQmlmVVNTSFBlNDNRa29JZVhwcFAvWGpkZDJQamliYXJDYURuNG5KcTlq?=
 =?utf-8?Q?kEMCue46B9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3984.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(376014)(19092799006)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVBLRFVGZDltNnl2bCtJdHVBU25VanNmaEJOc2pNRURQbVNSakpENHJNRFY1?=
 =?utf-8?B?TmZNQmh3L2tWRzhMcE1sdzRibHp0d2RFKytnWnNnVmtzbXducDFoTkVZNW1x?=
 =?utf-8?B?c1djRjJrc3QwUUNGMzd2TDBhaEZjWTY3cytnU2MzYy9Ick10VDc2NlZ3U0lJ?=
 =?utf-8?B?WDhGZTV0Z3JYNy9vQjNKUEVDb3dXelZmLzBVYVRlZFhNWW9jY1VVVGw2T3ha?=
 =?utf-8?B?RDhLQXI3U25jZVpjY253OWh5My9XWXdBRmk0REhwcUVqNlBqMGxBU1VVQ211?=
 =?utf-8?B?U0F2WXg4dFVoL1FibjRQL3JPay9mY0xkUXpJbHdCSFFmZHVrWkFiVDZkak1r?=
 =?utf-8?B?WkRObFQydkMwKzI0T3Q0OVg2NkkyQjh5ZlBWNmp2NmRVbUJoN1V2THRGZFpq?=
 =?utf-8?B?d3dpc2Qwd1dubzEyZWdtZlhEWERDMWFoMDVVdE5oSjJnSFJoaHZkengyZGU5?=
 =?utf-8?B?Qm1pVTE4Q3lranAyUmFtUUVBMkNnaXJDejk5RmtkZGVRem85bUZzLzV4MnVL?=
 =?utf-8?B?QUNvMUVpMVZodTFJUDdHRTlQUFhnZ1J3R2VxQzRqUG1QVkJJdnlNVWoxUTUz?=
 =?utf-8?B?SnlRaTZBVzk2K1pVNEVwcHBwRlBCWlFYSmUrYmt2U01WcjdNRTVNd2FrSVVt?=
 =?utf-8?B?blBmVVo4LzlDK3dqWjQvc2lOK2ZqRlIyQWtPcFlsZ0hMMG56THJaSE83bkov?=
 =?utf-8?B?NWZhQURSd3JFMXdBellpanJxa200VXJMQXJqQTJRSTBjczV4WnpjZDFzd2Z4?=
 =?utf-8?B?OGtOWDRKZ1pJOWEwQWZ4djljaEVaQjBMY3pJVWthWHZPRjhmMTVuLzV6Vm9u?=
 =?utf-8?B?eFlxSUV0aENzcnFTVE42K2ZGcEJETzZDS0g5S3hZV0RtMXZiWUVTazUzaWlQ?=
 =?utf-8?B?Y3Z0Q3ZSUnVON0tMdm9ma25XUUdLK0FrTGJsblEyY2YwYkp3RDM2Y1U2NFgr?=
 =?utf-8?B?bTlRR3lnZHgxaUlpaTBsU0lKb3lyL2VyNlRDTW53S1dGNFduQXNsL0M5aFFp?=
 =?utf-8?B?QllXbSs1YTFma2dNWG5QSGNkWVN5QVBiQzRiWktkUGttL25abG5IRkxNaGJo?=
 =?utf-8?B?Z0RNOS9pWGtrdkQ3UmhkRFdYSndIK3dGREMrN1Z2S0hYcFNaYVlodVN0ZTJw?=
 =?utf-8?B?bitlK24xNWprbDNPQnRqNmx6Unh1SjY2azZwWmIwVjFERjVjSkUrbWdlOTNP?=
 =?utf-8?B?RkFQZDV4S2lBa2NvTFFyS2cwK3NrTlpKOTRDSWJCS3FXMVFhRk1zTytrckY0?=
 =?utf-8?B?ZUh3UjRUVEZvUkpDM1FnR1FkU1QzajVQQ2dEYkIybkZGQmJyR0tRQytmeitS?=
 =?utf-8?B?MG1tZDhjZ1ZkNnpNZi9CYWtuViszeTYrSEQybXZZbkVDRkYveWl4cENKK2ts?=
 =?utf-8?B?czRHS0JENHNyeGV2MmUzaEcybVRQY3ZnN3NuQnhmaGdzY3Q2eXhCdDlYck8y?=
 =?utf-8?B?d25Yd0RpRDB6ZmY5U1c0Z0FEVVNVc3JhTGd1a2poMzdWVmExS3lMNWRkMWF4?=
 =?utf-8?B?NVFzbmp3TXloa2dsK3VJMXRlanRHc2RYYmJBOXhPSGxLWmo3V2FOczlyNEhI?=
 =?utf-8?B?aE9CNGR2dmJON2h2bFErcnhVaEg1SkFVTGh4U3ZzMGdWQXdlMkhvT1dJRWJG?=
 =?utf-8?B?ZzhDemhCaDE4b0ZmMjYrR2ZWNGRrWDRTU014TkR1T0Rpb1hjYTBhcWlERzR0?=
 =?utf-8?B?UWVqcWpQUTBJSStwSE5wd0c0MWR2eURrbndOWkNMWnhSYUxHMy9hMDJINThI?=
 =?utf-8?B?MjkzZkhsUmVrOHhUREdCelVxelNSOVQ5Y0V6SnlHSy9sZDFlaUR2OFI3cXhP?=
 =?utf-8?B?S2tSb29tZG56Tlp3UUEvTXB4OEw1OXRIbmxGM09PMjUyVmhMY0NMaGVaWksr?=
 =?utf-8?B?YU1tcDFOUGU1V2JseFVoSGw0ZWp0UGo5T3dScWNGcHdiU0dleCtWRjRGclcr?=
 =?utf-8?B?SnF3RFlnQUlwZHNqaXFXdlVvcDNYR3Rwby9Ja2l6blJ2eTFiTEdHZjNYb2tt?=
 =?utf-8?B?dGtSRi9xNWFwWGxZZEg3RWhsaUdsRmF6NFpNZmxOYTAzRzdCZTRHclpUNmtk?=
 =?utf-8?B?WFVoc1Z6UXppTXo2UWI2RDNzUnFxSXlGdWRnaUFVcVQ2OSt6R3EzSXM2aTlT?=
 =?utf-8?Q?x86Z3V88yOHToYCO24jBnlOZ4?=
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4381f1-9f23-47cd-edce-08ddf46c9e34
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3984.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:29:10.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqZgEkVAF7EEfuIvu2EAt+0TWT+DCvUXDjCwdhx0YGuiwjplJ24d0/EQbpMs0SjEMs98P9vQabve5CI27ZO6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8214

Hi,

On 2025. 08. 15. 16:09, Rodolfo Giometti wrote:
> On 15/08/25 15:58, Bence Csókás wrote:
>> It is unnecessary to duplicate `What:` content in the description. It
>> makes it harder to both read and maintain.
>>
>> Also, the uapi header no longer lives at `linux/include/linux/pps.h`.
>>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>

Has this been picked up yet? How can I track the status of this patch?

Bence

