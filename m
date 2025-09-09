Return-Path: <linux-kernel+bounces-807043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A23B49F3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797BA4E6C48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251224BBF0;
	Tue,  9 Sep 2025 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1oxVdVS"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA254723;
	Tue,  9 Sep 2025 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384979; cv=fail; b=X0quJueYJjL2eltJ0DPdFDp0UIX4tbMdkG7KBfg4y1zN23dR2yzVhIaGeeeegsdMWwF0J5sQCBQCloyMdwlfsXizlIg4PxYzvkqGH2IwUH50Altp+yDh3+NLvMe4Axobjs2B/kXbdCXtzLEE1kmUTEOWWv532W2mn3ep5vozkUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384979; c=relaxed/simple;
	bh=wFy2wALZdXRQcQkygxDzWYBxDC88dssRzFA03G122fc=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=iiig/VCdgiZ6dTYDE15N5beV3F3NmQ61MHdn0kWmJ5+JNEMVMiDS+PjP46ks7IaZ3WfgXbyMCvghYzzbKvLeFS507hyRr0O2rted+wZltIhC6hMZV4x83issdYoegLEVnsQB4dUGosQzkLrgZsJulgbPd6x0pcSiFf7b8VUk6J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A1oxVdVS; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETUtLSfA8GwT1sFxnzJV20Du12/pYQFXgZVhh6o6jHi5m3yqHGHBbi2OwwPc3PHBO8pZD4cAe1mxDxlubUPCIT/fUKxkjY3VyN5F3+vuIJiS+nbBoEE3iSiAhSnmyBnk5+oDyrX6JiOZ8G+soX6yEtl6PWlSMmD0hHS1AYOI+vJqtKnhJiWzgOn7fvGkNVdPi7xxF2fNTcgH4xxdVV/j26bYXjA2ebkGr6sStHXcQl09p+HfC1wMIBsNKhuQ0ZahlA3cpb0kfMSnycF90oYuPYAEvUFp576Ayewe2faDbuqbaegFu3LIYwaSx3yHVnCWWDVfv7Fb4ILUQcZjyxbCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFy2wALZdXRQcQkygxDzWYBxDC88dssRzFA03G122fc=;
 b=pKEsQp6/bXvtQReXPVTNvtPaDnU/cog9J8WeM+AXNriDeoXBII2uigvN84Dmbo6V1+un6CDjbeXGfoXI3xd6hERoms2ai3G0qBK7uL7w0g1p4RBTeiIrtHKbUqxtkDJCrZ4jyNb85NjoViZlBnkDwxaYHAFBoAV53wazPgZtc7qSPvbq5seKUFiKmOAHoYx6fE8o0f23RvN6ImwKdSzc+TxoXarnSwi5mU+hRAchwWveKxs5+OEUFXLM4jbK32mL0F7cwqap5HnxCtdiCYEqOOOrjZ3NJPN1xxK1M+sRA4r03XPZSZnrA94AE+A/nf77YXDR7Jmth0ko3JgBLcTOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFy2wALZdXRQcQkygxDzWYBxDC88dssRzFA03G122fc=;
 b=A1oxVdVSUh7qe43kvLhT9qQVpNVacpwW0+LM+3hxmxmaw3oLddai4hhHZhoJZgbdXtnPBx8xcr9xcChiFju8BupMgWGVbr7dMZKwRWP1+GZT4CZw6iADLDVC2UcE7KI6iIjp21adOKWooN4fcYjrYit+0HQG2fHqBxpgmrHlawFdx8FDurmvXz66K7Z+PAZ2xASOgZXlXnwqvoJiy4hZ9zIQsGbuFg4sNzOF5wCvJzStdpuXD6XoGTF6Ee8BDV+PFrc4Brj0hnqXKzfwsCd30jybidZ09NF5up70bt4ymEmQYe+/luHrwyFfYw5Z1O9QuWDkHvnuK5fnKqGtNXOeDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Tue, 9 Sep
 2025 02:29:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 02:29:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 11:29:31 +0900
Message-Id: <DCNWZAQ89YO8.3HWO1644ICNG@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com> <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
In-Reply-To: <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
X-ClientProxiedBy: OS0PR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:604:27::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 34847883-457f-456b-1a90-08ddef48b77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlN5bVdseGFXRTRFWmRQai9FMW13bTFacElkL2dEaUtCZHNxcXM0OUtueURp?=
 =?utf-8?B?TGlpWWp4V0VBM1JIOTc1bWNhSXVRSzZVUGZEZWROOFdOL1FuRXFHZWdhSGcz?=
 =?utf-8?B?Q0VUdFJWWDhsVitwTm96NTR6L3JodW5URk5kb1JMQ2ZPSkFHVTVwTXRBRUxk?=
 =?utf-8?B?SHczTzd2ZnNmYXcvWE5wYTRZUE4rWmxXVHhBUHFUYTZ0RUpFai91UnkvWkgv?=
 =?utf-8?B?enNOM3lpaVpXTFFEMlhleXYvZXBWVVBuSHpVTzFoTnlGSnZGUGdZWnZRVFRZ?=
 =?utf-8?B?SXVaOTQwYjNOT1RTQXNpdVpPa0Mzd0x4TS9vOTZkamY0QUwyb201U010Vlpz?=
 =?utf-8?B?Mm9CRXhpZUJnNGtCTWdMTDJWdnpWUHFyMlRzY0NZeEszNXlBdUtoeERjeWVL?=
 =?utf-8?B?QW45Q2tSWW4vYm44VlF1S214TFFZaEhuM0JwM3VUZzg1MHV1Z21CUTlCL2s2?=
 =?utf-8?B?VXA5dk5QWEN4SzZORmlTdWk2K0Uzd2RVendTcW03S3N2Q25ZT0M2RDJPWFRZ?=
 =?utf-8?B?cGp0WnlFRnFsaUp3UUw0a2Uwai85cHR0aWUveFIxaEZzcVVKcVZvcEh6YjRT?=
 =?utf-8?B?VG9FTWpsV3dnMGVSSHBSZXlva0ZsMzBTWFBZV0plaElhU0IzS1ZNdG81cWdr?=
 =?utf-8?B?a3ZFZURUeGY3WUQwU1JGZUFyTE4yM2x1cUtQV3ZrdDBNRTQzdmxDVG9IMjFQ?=
 =?utf-8?B?TklOMDRDN2lyYkNLMy9mT09OZUN6WE5vbFpNTkdGVk1vcjRPVFRudGYwZWNR?=
 =?utf-8?B?YzdGOWQ1R0JVSTg2d2tKc2RIR2tBaVlqajhDZ2FWNzNhKzZ1eWRpS0V1SzVB?=
 =?utf-8?B?S1hXZVZCbkNLTXllYng5bkc3QnNtdi9FVVUwbW5HVFFNbEJnZ3k1N1JML3Ex?=
 =?utf-8?B?emNnMEY5UkMxbEVQOVIvd2wzMXNtWk1RM0p1YXZNWmxWeEo5T3Vkd0o2ekF1?=
 =?utf-8?B?RlRheEVNem1ZcW4zK01aYlhtTWVleXdTcFUxU3VEOTFkYWg1by9heGNZb1VZ?=
 =?utf-8?B?MUZNRWF4c0NNVDIrZDZqS2tRYlFHTTVUVVkrRjluZ1UxbXl4SGN1cmY1Q29r?=
 =?utf-8?B?R2w2dTdyYmxrMDJzV0pOM2E0NHU2VW1lTzA1RGdHZ0htSmYrUThyWWlzMnNR?=
 =?utf-8?B?YkNlcmF0eC9KUUc5clEyVUZFZlp6OFRoVHA5UnZqM2g0ZDl2Z25tdERDcnc3?=
 =?utf-8?B?Q3hVWG40S3haOENEK0pHTndNZkhOeWszbFc5VzhrZ1drbERTekVseUR0UERL?=
 =?utf-8?B?U3dSTzFYRHBEcG5acVNUeXZNSU9palBhK09xZXRuS3h1Q0JsWjB5NGZadHNN?=
 =?utf-8?B?ZytYaWEwNzZBUGNtMWYydVBMVkdFRzNqM1lZRjFiTWluS0l3cXErNWZ5cjlQ?=
 =?utf-8?B?blZzUmhFSVdPNCtka0xNOEx0QXdDeTJVUkFrSzJYUElWWXJvTTF6S2gxR2tm?=
 =?utf-8?B?UndWVE5yYVZhbFlVTnpOcjVubEJIZEp3U3VENXpJUFlyQklvS1AwNE0zbEVm?=
 =?utf-8?B?QVJYKzRDcXU4WVJpakcwRnBMcytaQ1dSU2w3cDRBcmZFak9HeUJCdnNVTmdy?=
 =?utf-8?B?cHpFbnZkeVFFWkdEWjM4TTU4Ui9zeVREeTBpelpiaHlkZ3YzdStYQzZlODU2?=
 =?utf-8?B?RUppMS9QSnhudnN2U3RhRDJDYzFGSGNTV0huaUVsUHhMOFdXeXFoM1VuMTNk?=
 =?utf-8?B?OU5NYlhFYjV1eTh2OGtUMzYrWmNmdHJOK1YrcnByTkRQWVlyWUdxWTMrb28y?=
 =?utf-8?B?MUFYUkpTNVEvRUxRT0ZsYytPZDlRNDROM2RrM2RjQ3JnbFdWZ04vaERWV3hT?=
 =?utf-8?B?WmlLOHRFMFkyeEhNTGg4K2xFSUV4dU9mQVZ6NERGYTRYbUtwVy9PbkM1YS9y?=
 =?utf-8?B?d2VXNjg0ZS9leGNDVnVJcmZ3Um4xRFpOenFlaVc5dDFORlZtblVNelB5eWFU?=
 =?utf-8?B?cVhrK0lnQVliazVhS0YrK3pZc2loWlh6dVFXOHlOOVBjc1VaRHE0WkxIZDFw?=
 =?utf-8?B?bHMyS0xmWFNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjJmaEFuUG80OGFSeGxIaldudHdMeFJHZGkwN1FCb2dCQ2lnSDFiTXlEVVNG?=
 =?utf-8?B?UEZmK2ZyNlFleExQNStxdzFWVW51SXlHU0NtUjBWeWpzek4zUHVUZEdycXRP?=
 =?utf-8?B?R3FWaFlzaWxyYjRWeFBaWDBGZmQ1KzB0bzFhVDFiQXdGenZFNGljMWxpZG9n?=
 =?utf-8?B?VTI1ZHV3L1YrU25OZkY5ZXpycWpkQWV6TFZEYkY0azN3bFA5SXZWMUJaQVpo?=
 =?utf-8?B?V3BnZWFtUyt4TmZGZit0cDVab3J1U0dITHhVb2VmQWZLeTd4ODR3SU84Tkd6?=
 =?utf-8?B?bWdkUzJVMXZTZ1g4YStSKzFxY1hRaGZLSE5UM0pQQnlOaWgzamZRWDY3d1p3?=
 =?utf-8?B?QXliYUJoeTUwd1FJd0tOcEt4Qit1Si9hSjkxWDQ4U3oyckRGMVFaQ1I4cGly?=
 =?utf-8?B?am1oWVNIcGY2YXBlR1RNQXFmb3BKbnBtOVVCK1RwaCs0VFFQbnhrdW9VNCtz?=
 =?utf-8?B?eHlLaFl3VjRMTlBVNWgxSzFrM09jZjROc0hRbGZ6czVCaXFyQndFMUw5c1JI?=
 =?utf-8?B?TlRsdUY1R2pLTHM4UWMvcGRMazNCbTdweGh3QXEyU0Erdm9rZlZIK3hwZmtV?=
 =?utf-8?B?c0pjLy84TlNnU3l3SUd6UHZGazZMVnNpU21ZUHlKK0Jnbkt3Q1NXMnN0eWIw?=
 =?utf-8?B?cGU4VW1MazJZSW1xQmsybVBTM3R2UWlTWFl5ZVl5bXJmVHNOam8zNVppeUtF?=
 =?utf-8?B?LzhHVnVKVVFrUVFGRGVUZ2FpQmxaRDVoOGF2QXNKajNZN0g3ZjNnMXRXS0Z6?=
 =?utf-8?B?UE1wU2ZUamFkVytDUWFwQU5Zcktsb0wxTE1TcnQvWEUweTZhL0hZcy92T2lm?=
 =?utf-8?B?NGp4Mi9hZzRwNDVNUXZNSmxWU3JDY3ByZDE2bHZJY1RrMk1GSGlPUlg3MU04?=
 =?utf-8?B?c3ZQeFQ5aTVhczdFeDN2V0ZFY28vSmswajBBaTBkVndYVVZrZVUxbmdnTk9I?=
 =?utf-8?B?Q3JGZnhTeXI5QXJtQ3JnWWRIMS93NDZJSkEvc0c3V1hUK0RnRWtnSEpRNnpa?=
 =?utf-8?B?QitSWG55OEN3YVFRaC9DZmFHMGhteGRQNERuaGN6d0ZranVzR0wzcmRPa0ZY?=
 =?utf-8?B?ZE1iM3RYU1pOU05qc1kxU3h6NDZhT0ZOWFpRbXVQSDljeHo2WFJaa1RTOXBq?=
 =?utf-8?B?cnUvZVdtK0xFbnlRdnFlN2NuajlEdENBYUVPYXlVZXhaSVJ1Rm1yVHdBYkdk?=
 =?utf-8?B?OWVORWhNRGtvajFVd3BNTzRTNDRqcXBUd1dKZnZrWlFIc2NNNFZaRUliSTcr?=
 =?utf-8?B?TXYwMFE2VFpScXcwSEtrSUZib0JaTmdSYlJhSzJYa3MvZVY2RzhXL2RndlFW?=
 =?utf-8?B?ZTdSTU9JN24rY1NyUCtFSDBoQkw1ZWNHZDhYYmVGeXdwRGhpMHQ2a2pUVENi?=
 =?utf-8?B?OFA3ZXlPUHRxZndpbTJJMTUzN290cnZURmxTd2dxd1NOVVZyU3B0SDVLRWhF?=
 =?utf-8?B?Vml3cFV5cGU5U2lVYXZmeGtZREZLM0pSbmo2bGxHanl4R01zVVBvRDlpQjhT?=
 =?utf-8?B?clIySVQ5WW03TTN0OTFQc1JzckZHWUJ1YS9obDJPTW83MWhCWTJpMWUwbW5i?=
 =?utf-8?B?aGtOZ0hGald3RnowU3NVOTlkVUUxSFZ3SlJOM2M1R0FoQllGUC82a1V2cDkw?=
 =?utf-8?B?eHR5SGkrVjhmcTRuUWJsYkhodG5lTTVMZUZyb3JGVlNiTURHS3pBZ1BOWGsy?=
 =?utf-8?B?UTduU0pzWmVHTXpDZUVlWVBJNmhBRFhIL0s5dlA1dFN5SU9MZmtHd3c1SkJT?=
 =?utf-8?B?Nmo3aFdDZmtZNGR4T0ErV3llSkNWQUJNdVV1UEVaeEcxTlRlMnc0dkI3aEhv?=
 =?utf-8?B?Q1ExMDFhcS9sa213SXZxSTBYcStabHhrVEtqM1BnSGxNcDFKaXJnUldiN0Mx?=
 =?utf-8?B?blZoa1BjUjNoNndpTnZyODFQSTh6ck82Rmh6YktnSHM0UEZCZzJGTy9UdUNq?=
 =?utf-8?B?TTdublZhNE85Z0ovVTJWajhjQVhQSzgvbi9oLzhqWjQ0MDNaUWU4U0lJL0ZK?=
 =?utf-8?B?K3p4MmttTXd1WjJDdjYvS3g4OGxNcDFMM2t4Tm8vUU1VdCs3UHlsNDlPandZ?=
 =?utf-8?B?WFowbGJJQlJRckVpaDhTb0FVSXpOckVXcUkvYXREbUE4OXRHaytXaVJSQTNl?=
 =?utf-8?B?dlN1NDNtMEdZNlFFay9PRkRaZVBjbkdUVEYvNm5vWVE1c1lYRVdoZ3dJZmlQ?=
 =?utf-8?Q?7hpLHWKDEbxLo8BetLoTmA8LFrqTCB6mkO1OZCMHY6B3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34847883-457f-456b-1a90-08ddef48b77f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:29:35.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iquc/VhyI2kEezddjkdIjk9p8hv0TqedOlc+59bGcf+AOHbvtK4AkFKkbvSZtIvaboC/IfM/lBquaoLl/9jedQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286

On Tue Sep 9, 2025 at 8:10 AM JST, Daniel Almeida wrote:
> A lot of drivers only care about enabling the regulator for as long as
> the underlying Device is bound. This can be easily observed due to the
> extensive use of `devm_regulator_get_enable` and
> `devm_regulator_get_enable_optional` throughout the kernel.
>
> Therefore, make this helper available in Rust. Also add an example
> noting how it should be the default API unless the driver needs more
> fine-grained control over the regulator.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

