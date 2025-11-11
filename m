Return-Path: <linux-kernel+bounces-894704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E5C4BA91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D55464F04A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52B2D593E;
	Tue, 11 Nov 2025 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="alOpS/6M"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3602D2384;
	Tue, 11 Nov 2025 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842073; cv=fail; b=qszQcFYHFwAlF3B6u3IYUTWLHpPPcOvtbrF0U8O43URpmwAJAWoVF64n9zImGKsK2SX6JfmR8C/ixw0o9KW0qk/wH3JeqHkyY7GnUgkmeE5NtYzzoqib9aTN11zHCcCeRN3R+qrPeTb4/KhFlHuqQqeiWqOsx+/bUPy14hW+w74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842073; c=relaxed/simple;
	bh=NpEIdrKADd5zbL+hj/i/dAYLUThNyHgHHW+2y0hyY1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZPZMy63cfWmP8HTfiQqVi4wvDdu7oSVEHrw2m5W5Qq6+wY5GwM70TKAVoLYpIZWauX4EklMO5gvoe/RZxAfcfuc2JHRGtWyFNOsW4d8SSl29oY3kAP7tyJDhuUu+4Cta6JuG4mrzKny4+dUa1YsaUD34YjOsGBZxptAGkqsA+7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=alOpS/6M; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lemKoM4yErgrDKhA846pVBIfGdx8OvJeP2dTAwxKuekUjyl3GOHtlKrSg2GvCORFg5+SwZrmOVITnSY3qao7Lw5j29fIcleWiQ4MAtcTCVBPDIL4FKUXCUEnGgsaKT1gKgalfQOIFUgl48BAc0bsAd8iQRGcKJLZm2ysA1jNEUuYCZi4r5M5fUEO45JAHFMCPs+FVm6YegE09mbYidiI05mAtjqVtDVwPBLWdGTtxBj0lB+7PMBvwfwF7JSzXpLbLlM8X4KeIDfbzPmqY0YzPVvS1Px395ikSaHQIL41Mq/MfNSoer5LETgn+uf5nqbXZVIVES0IVqIDg2YdnD15jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qw28ZzOYN3fS0bRpHOfcOj3HiGnYSoyvif/35txr5Q=;
 b=bsB2T6qnVQU551qYh7mOZvkEgSysm1Nl/l7BluNi1TD5507WEbCLUoNdtye4g2PI5NkI90HYyygwvPrJtgGhd4O68D6BUcBXVuwGIhW5G4V4w6Qgd6FNQ/R4QQS1SS5Ute73fRquXNjrgrs480h0jfvW3z6RwXmThmtfSuiWwkcO64h3aoHIJU/AlXO6GcZpv6DAiZg3xt2vamE1JLMzC4zRbo0YADEBRfpgJlvPO+pHs64TuEOb05jIrvLnpo31++SsQDwZpjEj96TX1G9hMnCDOrpjVPJshG2i5BowuD2mW+onQsbt/PVpUPCgIdy2KMuebC2xbiS1/T5FL3eakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qw28ZzOYN3fS0bRpHOfcOj3HiGnYSoyvif/35txr5Q=;
 b=alOpS/6Mts+GWG2RR2gaDl/pHSxidkVzWy4eSipNka6kYdZTi/Y7fmjUq5kSSvqgxOdy7J/R/UMBWkTSWhJGi3DvbX0q5kvBS5uc9WtMlZKgluQC3mkLHg5upZVjNFMW/PHj3HtjbDPyNsS9M5dQ1aVa3b+ZHNDdIkzD2dCB1Pm2J5Io9bZX2itT2C60tmOAVGzTrahmCmQw8Vr+XNbbFzNd6X6h5GrMKW5O/JL8Ra1SIkMcpkz7ZSz3CDTDSDwn22G1mX+xxu4w/qrh3snL6KhfDih0M1wqEhT4jOAHJ+ENMvRGcju1TP0xwJL0D4aM1w3TW/C9LvsLCCsV5564hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5049.namprd03.prod.outlook.com (2603:10b6:5:1ee::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 06:21:08 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:21:08 +0000
From: adrianhoyin.ng@altera.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	Thinh.Nguyen@synopsys.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 1/4] dt-bindings: usb: dwc3-altera: Add binding for Altera DWC3 wrapper
Date: Tue, 11 Nov 2025 14:18:45 +0800
Message-ID: <607dec2fdb41cba0220b7b9947e04651f51ff56e.1762839776.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762839776.git.adrianhoyin.ng@altera.com>
References: <cover.1762839776.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::14) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c91a890-98af-4019-bcae-08de20ea804d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjhyR0xtU2U3YWV6TDMwRzlEcjg3SWU1QTg1QlcxYmVQamRSVzdnOFI1VEdT?=
 =?utf-8?B?V0huQ3F1cnRjNEJKb3h6Q3Q2ZDZvNU1YZWZMVVkzYTRMS2lBWmZYYjBQSTZK?=
 =?utf-8?B?ZForWFpoODAwNjc0S21pakhwWGc1alFPWWVxRGlzcVVwVUN1QW9kMWN0L1I1?=
 =?utf-8?B?VjF0cWF5N1NDQUYzaW1HVFpKNnljOXRUd1ZtZHRka3JZbUZqN2UyWWxoWkRu?=
 =?utf-8?B?QlZQcU12di8vb0pueVEyc0ZsQjZILzA0c0IzYzB6TGlESmNLeWtBWm9ZNmE4?=
 =?utf-8?B?cVVqVUdxYWZRekZ1ZEFnM3FRQ0MzVGtUK1d1UDF3SUl1M01BcVJCTEMyOVFi?=
 =?utf-8?B?MmFXZHJSbDExWmV0NCtFbWxacDdlUEw2ZkMzNTBpbGZtdlpYTnFZSHV3MWNL?=
 =?utf-8?B?c3NqbmVtd2pTSmxCOUo1dlZwelRtQWZKNkRybVBsSmpwMUZZYllGd1hKSjhp?=
 =?utf-8?B?a0swVWJKd1pBUUt0angvc2g5NlB6bGljV1RGSUVLdHRnZHF5WktWaU1KMXVG?=
 =?utf-8?B?a0srT1lxUlI0MlZwamRrU0RFUWlXWS96MWp1L1I3NFJoOFZqczVmWWNsK2Jh?=
 =?utf-8?B?ZTBOQTZ4ZHc4dEZUS2oxaXdIcFFEMkpHSDhUZE4wU0lLWGRscGFBRlhVOHZ0?=
 =?utf-8?B?a3VqTmRhUEZZK2xaUFRPU3FJaUFDNjljSTlQRlVQMlRZUUxHWDVGM0l4bjZU?=
 =?utf-8?B?allreUxPUm9RNU9BT2xTQ21heXdwMVd4VlJzdlFWWDd6UXpTYW0rVGdQVWtQ?=
 =?utf-8?B?L1BidEk0ZnZBRUZVQjVBOUFRSkUyMjc1N1Z2WkZRRHdLaW13UlQ5RUJmbUM3?=
 =?utf-8?B?RjNBOHQ3VklKVGJtTmJmTUV2SkFjQk14MEh3NWxWS3VobnFZWVJ3dWFYQnZV?=
 =?utf-8?B?NG92aGE2VUhIeVhTMlRobHFYNUlXeE90dDBSOGJQZ3NDcWRPNU80WE1qMnll?=
 =?utf-8?B?WnU4VUJrdVMvUEpSMzI3MGEzbUF4Wk9yWi81cjdXMWhHMWxmRmt2dnZtWTFx?=
 =?utf-8?B?L3BCNExIQkpJSHJXRFlPM1hUblcvZ1JXeEVXbitxa3ZVZGFaWStPejJvVEtQ?=
 =?utf-8?B?VDJ1TEQrQVIxWCtBbWJPK0NTTFdFZTUvQnl6aGdRUVRvRTJpMDUvTVB3bFA0?=
 =?utf-8?B?UkFOY3FldjlDSVNKTWhqWitpY0YwVVhVRUJ2aWNiVG5IbjVUYk5DQXk3dk9Y?=
 =?utf-8?B?L1VQaEtHSm5DNHhNK0hHd0ZZSWdoQlpyUHFPRlVDL1hsSER6SmhKaHVHbnBu?=
 =?utf-8?B?RldoZ3pwMGVGTlN4KzBWNzkybkxvbWs0RTFVV0ZtS2h5V09FSnlSNW9IdVA3?=
 =?utf-8?B?Lys4cEJmZGFXUlRpRTY3VDdiMDNTUUQ2MWhNaGU0b2ZlQThvc1ZscFpxYzN6?=
 =?utf-8?B?NmNrbWdRWHlXQVJQRjNZN0FVVm43VEVNSi9zdkZPTENTQjJtSWd1SG5FTmF5?=
 =?utf-8?B?anZpMVJ5d0VHTlVieGMxeTFJdlZqYmpqOXlKWXdhN3MrSk5aRUNwcDVGMlZG?=
 =?utf-8?B?dGJsOHAyUjlJekFsTmo3QWJlZFMvNlNtWWNLaDdtYUpQUU1OaVBVaTUwTEJC?=
 =?utf-8?B?NW5hMFF2aXhoMXdyRGowbDdQVllvcjFzdnRWWmpOalVxcm5aVitoRmZsMnh3?=
 =?utf-8?B?V2w0VUM0MlI0Y3pRUysyU0NqYmpyRytuUHJTTWVtRmFkcTc4NndmM1d3Y2RU?=
 =?utf-8?B?ZjRwVWErSXE1UUpWL3V4REhIaDdFVWlqU0cxdnJ5NHhVVnFkem54SVRwUDV5?=
 =?utf-8?B?WWkrbTNvUU9GeUZVRW9nb29mZkdzckd1bWlTck1BQUJESEhZaWoxMGhlMFZL?=
 =?utf-8?B?b0N5WjkyY3JqRGdaeWdNc2VLNUkrRUl0bGE0UTRWcVJTQVVvU0QzTjd5RC9I?=
 =?utf-8?B?OGJiOW1zVzBlSTdSeDVEelZ4ZTNyZFpXYURJQ1gxTitiSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTJTYmNUV1VZNDJJV2MwKzZSTjFSUzN1cjdXZ3BnYS9UMjVNOVVrK2dxVWE4?=
 =?utf-8?B?bmg0bStDekR0ZmtvTWFqOHQwbTVDbVVrKzd3U1g1cDRTSmFPNDNLTFRjWG9m?=
 =?utf-8?B?dnhDaEtyODZtSzdjNzM4REtRZ2FMMHlTa3FDUWlIZzJkcnhtTHIraVByNUFF?=
 =?utf-8?B?SFl0cklhNkxvY3FaTmczSEFNL3RhUXVVOE8vVnRwZnBydDV2Uk4vVW9HamlX?=
 =?utf-8?B?VEdCUHBCZkRJSnVFc01QR1lxUXZTZlMwSmZFODNtY1BuMkZMRk1CQ1A5amdW?=
 =?utf-8?B?aDlTRXkzQXFLWStVbzMwZWJXWE9FcjRJZjlUNWU1ZDNHVFdWQWJBR0tjbHJ2?=
 =?utf-8?B?cFhoK3IwUllOTmFWbGxOVGU4NENmWEhDblkwSkFxWjFxR1ZSRW5RVWtqckhy?=
 =?utf-8?B?d1hrU3VacnR1cW84V29HZlZFNlludzdZUlZxcjVONWt2TytscEVCNURlQlNz?=
 =?utf-8?B?WGZLMHEyR3pQVXQrTVdmOVVTdlJsOHczeUFKSjhKY01udGM3WFo2RXJuSXND?=
 =?utf-8?B?bk9hZkp5cUtBR2pLMFNDMk1tdy9uL3RUMWNsdnVVbFRNSXM2MTVLM2pNc3Zo?=
 =?utf-8?B?Q3ExYU9Qd1IzKzUzN1Y4c1JIY0wwTWFSTVZBS1d6VFNSQ0N1b3JDYStjNUFm?=
 =?utf-8?B?SlNTTHV6Z2VvdmYxUytHOGFMUUF5MEpNUXVjcDlvdVBFUGlhZ3c0ZnYydnEx?=
 =?utf-8?B?WjNCTUZCVVEyQ0FqcHhtUmQzdUVML1h5eHo3TmRZTjFQazI2c3VmNzdHYklL?=
 =?utf-8?B?MmYwRFNDUCtoR1luWHhsVmdkUUN4d25lRnNlMk55WXhTc2g3UVd3Skg1bnBm?=
 =?utf-8?B?YUxxZ1B4WHh4ckxMaTN5dVRNV29zZzRwTUtwTUxpVDZIZ2ROSmZFd1hMRnNP?=
 =?utf-8?B?VURabXgzZlRQNUJGTXBrOEI1d2pZTGVNUHlkcjZsTkFOOWtRUzZnKzNiUnNE?=
 =?utf-8?B?RGZhYVdBMWdYM3FOSnd3SDdQMC9NRDJma29QY0dTUnpSSWM5SnpKQmQ2dWZ4?=
 =?utf-8?B?NTdTRlh3ZnAvUldSM2lBd3lOZ3pHbVd2QzhDQzdBbURNRnlVNnBhTTlFcHQw?=
 =?utf-8?B?YVRNM1Q1TXhZM0dNajVZMldieU1YdXE3U3QyQkNXVWpNUkpYTW5pc2o0TzVs?=
 =?utf-8?B?NEx6N2RZSkw4aVFGSVYyUDNvY2hDeExmTDVEV2dlZnpKK1I2YUZvbXl2dlJL?=
 =?utf-8?B?d0l5YlEzUi9DWXFMRU53KzN0Y1VrZkdLR1FGeVhxdTJmMFdOYkcza2ZXeGt3?=
 =?utf-8?B?UmNtV2xPaDVhSTJOQzZpN0VvS08rOXUwNVllYmRnWG45bEhhZFdnaVdPNTRS?=
 =?utf-8?B?d0lhQTN2NThLSlNqSlo1a1BpdjF1V3Zzb2puLzgrN0JHbWxid1ZCUWVRRldJ?=
 =?utf-8?B?WkpoQ2Y1WmRTZjdTeFZwMEFvWkwwc2ZPekFVVTRrK21nd3VFU2psUmF0aHNE?=
 =?utf-8?B?cDlyUG0wbHgvektQaW1NRFYrZEpOUm9DSVVCb29WUU9RTUNJcExaN0ZXc21K?=
 =?utf-8?B?NmMybGlZSkNLNVpOdHdBRW1nZUpuazI4aUs1dFpQS0VyNjNxWEVJcGdjdjNJ?=
 =?utf-8?B?cnBxWkwwVkNmRVhYMFM2VENRcWQ4cThlZjdTbDdmTFZUOU1YcWNkVVZGbVNI?=
 =?utf-8?B?dzZsZCtNeDUrZEt0ZXJtZUNzc1dzVExwcTIzVW0xSlptU0VGbUVHbWcrQmN6?=
 =?utf-8?B?ZHJQd3JxR1NaK1FQbHZvSmJGdStXeklHWERIWi9tZCtFQXZJSDhiUjR4Zml0?=
 =?utf-8?B?a3ZlL2hsd05HalVRY1NxNFpEcit5USs4Z1Awdzc4U2QyenNEenZ2L29kNVdC?=
 =?utf-8?B?eXlzOUl0K3hPdmlOclorY1BnSFJLUjd3eWZmbG91ajl2RDg4Rmt2ZWl3TVJY?=
 =?utf-8?B?dWtMNDRnZjBxdFN5a0xPVmVlKzROc2J4SDBSMTBIZFQyVVAwdmlZZVhLaEpQ?=
 =?utf-8?B?UTJXbGo4YzlCbExFSUVFMkhMaXl0NWsrd1dycHFPOE12WVc1ZDVhT2hqa2xO?=
 =?utf-8?B?NUtQb2M1VXprOG1sdDBjYjB0V0pVZUU2aUdwZ1lwRHQxL3FQc1F2NXBuVFlG?=
 =?utf-8?B?Uk9ta3dubk5RTGtzUG9KQmE1elViNHRMOUpLVVJ5OVFIZ0JqS2FJL1VTY1JS?=
 =?utf-8?B?Qk42YklXc0cxMEZSdU5xWmlwNEVYNnNKNGo3am1kRFpXVzcrUndhZXZFT0xT?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c91a890-98af-4019-bcae-08de20ea804d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:21:08.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JcBho84LqSqIy2y+WSTokz+wpogzY6mhNotn5rbMhW8lWNgFoNz1eRehLY/IZZibzYyfu/+m+iTe3cD8uQeQ6wK51QPajCa/NuII6s03Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5049

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add a device tree binding document for the Altera wrapper around the
Synopsys DesignWare USB3 (DWC3) controller. The wrapper manages
SoC-specific integration such as clock and reset control for the USB
subsystem.

A parent–child node structure is used to comply with the generic DWC3
binding, which restricts the core node to a single clock and reset.
The wrapper node provides the additional clocks, resets, and address
translation required for the Agilex5 integration.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 .../devicetree/bindings/usb/dwc3-altera.yaml  | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-altera.yaml

diff --git a/Documentation/devicetree/bindings/usb/dwc3-altera.yaml b/Documentation/devicetree/bindings/usb/dwc3-altera.yaml
new file mode 100644
index 000000000000..c998d587723d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/dwc3-altera.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/dwc3-altera.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera DWC3 USB Controller Wrapper
+
+maintainers:
+  - Adrian Ng <adrianhoyin.ng@altera.com>
+
+description: |
+  The Altera SoCFPGA wrapper around the Synopsys DesignWare USB3 (DWC3) core.
+  The wrapper provides SoC-specific integration such as reset and clock control.
+
+properties:
+  compatible:
+    const: altr,agilex5-dwc3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - clocks
+  - resets
+
+patternProperties:
+  "^usb(@[0-9a-f]+)?$":
+    type: object
+    $ref: /schemas/usb/snps,dwc3.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    usb@11000000 {
+        compatible = "altr,agilex5-dwc3";
+        reg = <0x11000000 0x100000>;
+        ranges = <0x0 0x11000000 0x100000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        clocks = <&clkmgr 54>, <&clkmgr 55>;
+        resets = <&rst 36>, <&rst 44>;
+
+        dwc3: usb@0 {
+            compatible = "snps,dwc3";
+            reg = <0x0 0x100000>;
+            interrupts = <0 94 4>;
+            iommus = <&smmu 7>;
+            phys = <&usbphy0>, <&usbphy0>;
+            phy-names = "usb2-phy", "usb3-phy";
+            dr_mode = "host";
+            maximum-speed = "super-speed";
+            snps,dis_u2_susphy_quirk;
+            snps,dis_u3_susphy_quirk;
+            status = "okay";
+        };
+    };
+...
-- 
2.49.GIT


