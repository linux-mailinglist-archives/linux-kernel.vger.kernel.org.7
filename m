Return-Path: <linux-kernel+bounces-881826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 203D8C29032
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A3964E6DF3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712D34D3BD;
	Sun,  2 Nov 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0LvYwLo"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F8224B1F;
	Sun,  2 Nov 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093522; cv=fail; b=DK69LOpvgNnfZnY/M28HDn0ysnG8ltjAVvrnqKO1TPfnXR/e+jnmDWTqSL+AHsbvTmdMdsWMfSrg0rZTDmCAsBwV5tVb16f61Xa+zMbuUN+B/Nrgp/gf34wUCEpjEPqtFJ7CbHokjSMneGcLVUSwW82KEBhEwr/qQPbgj+RLCfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093522; c=relaxed/simple;
	bh=mvCHnJ8QIKt9y4WMUtv6Dp3/q2ua9a9Rax2VrIDcDEc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pbOiVdzAf/fZSDDMtStAaT/xI2JUVwqUjbt/p75I7Iwo0oAg4uwteOT1N30Hl4izy7L4d7T6dCILdmkjDN1pUmBDfNryjiXxBtMgnKhd0TZP9BoiT1kUsoTD5p0QE1iZQzRFxpeFJfuhoLfBWTLjVK8MoFqs6eia+Wn2p4mlZ3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W0LvYwLo; arc=fail smtp.client-ip=40.107.208.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdaVvN7eBLi14dWCuJFcykU5sv5Ln8DW3NbHicHUx0Ab/vZdZu2vxtjayFPsCYqYVzlosCEhchb4fJuwoy49HO3CF/D8mybu3lVDcLWb9rSAXd5j3snqjpIuCDkeh1Pmzj/lZKvgmRqpH6wgsCXpmcB9tb4OWX8kuCTgSTGQTTIa3j6r+SeeZRPqNY4x1pXgWab7X5uSxIzHuEb8+5Z8KT6dZ4HgFS3c4aRGQ9v2UHy4zFBlOGBTt0co1tzXoVTsAttImp9J75RrAIqY/7aCRvx8dOdC/wrt0+POd4oDHejDsTSDFqpFX8MVmKNDABPTPniRAWfSPmekSZF4WLY6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xp1jw3iRJOrwhtQkQuGuuC3G6+pMABMDsAxcn9gdpQo=;
 b=LqI5SwBgT5hHkmbXr1DjWT+v9l5iSaglM1r4b3EAYcEjF2U5jf2DSX2012ELG+LUsaN7rTOuif3M5Ao3iLnDdJGCyA3rvIKELYF/HQEzLoA16FkP33qiLiGUXNsxBZl5mzOLBd6A9EW7mkOduIjLgkSlsSml9yc0rCUQLirdlWNyHcdlAJ9tFEByK1eG14ICGRaN1GMr/9iH2rsK1SyiNAFfkfTgaXj6KKVnIQne+/edvWT5LJX7qe/0ZbfSofymp4QqWOUeei1nT0RK08tEt2XqT2kjp7MvB2MqOVCK0STV3jcetPu7jcdOt6aJpEAr5R6RBSoYecnufIgnooxCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xp1jw3iRJOrwhtQkQuGuuC3G6+pMABMDsAxcn9gdpQo=;
 b=W0LvYwLohMezV+cj1yaessH1i22MVrExj+ZCQQls7lyjY/zXHi4OiovluODcQkZejECvgTiVjaaF/Qjwniq6Mpuu2LMuZK5Qgwi8hos/tmATFoh+JQcilJIVVn4DDy+ErFv6/RHbJmK8nkhK9T+stYmWxi224R5BVinyPPQhW9s+c1S7vsSCr90kIcA0KFrL99Hc7ws4TsxLNQ6qeVbPG/i9M6BLQQl1BwkXeUBLXjUkBNHVjFyfOEKKn5Y+WEWDqk4FVLJbW/siduMqNudxhXwzBwspVSLcg1c7jaLG9wL2T/iwfxgDUeXGA6FCQ7aOtaZFx3U3ULNUjU3c/Kt9NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 14:25:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 14:25:08 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 02 Nov 2025 23:24:43 +0900
Subject: [PATCH FOR REFERENCE v2 2/2] gpu: nova-core: use BitInt for
 bitfields
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-bounded_ints-v2-2-7ef0c26b1d36@nvidia.com>
References: <20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com>
In-Reply-To: <20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0241.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: b131db71-3a3c-4b37-1263-08de1a1b9fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVRqVlRnR0hVMnFmWGxCQVRJTzU4ZHBDM2NWYXVJcURqdnF6K09WUWZTVHh0?=
 =?utf-8?B?N0I1UmhZSTREZDlYSklncDBKd2ZiMWsyQkpuUmxaTEpQZ05qc1F4MlNmelg5?=
 =?utf-8?B?alhVTE9jREJUdVYycmFEU3VDZzVXWE1RSkdoZ3drQ3JFZW5uVDFEbmllMG9J?=
 =?utf-8?B?cVk1d3BPWlBQSUd6NVVOWXYraTRUUS9pbnhEbVFlMlBKcE1LSlZOdEIrbUtY?=
 =?utf-8?B?cHBWYnZWVHVTN25QSkFpRU9tYlNac2ZMRUNiclBrR0NWRGlmT29Ia09HR2c3?=
 =?utf-8?B?RzVnamJGalhzSisrTVgxWTdqaHJqcFZEUFo5WEtXTUZPNEw0dXkzQXRKWlFq?=
 =?utf-8?B?QjU5ZWpCRWdHakE5akgrRW1oUHJGbUZ3ZERNVU9VWHFMZFU3U2l1c0RDWUxL?=
 =?utf-8?B?UWtrL3dUdG1CbUpXc3FwZ25OcTFndllkbmlUeWdHTm1MZ1I5ZldNaHlkeWsz?=
 =?utf-8?B?UFpzbFZueE0wSDc2V1ZHVEVxQytnRkU4ckdBQ2poSzRnZnVTeTQzRVo5SERF?=
 =?utf-8?B?TVVZVW5wWnZadThOZmNQZEhwZ3FSRysxOVZBTVBiYjl2dnhnbDUrb1hQQmpU?=
 =?utf-8?B?ZHNJczlmT2k5SUQwMC9idDVWSDVMZThUbFZjTElMdmQyVmtXV2txQXQ1a0I4?=
 =?utf-8?B?MDYxSGpvVnl6SHNUekJUR2I5WS84UElDSVNCOFVXbG9rSzFyUWdBOFE0OTgx?=
 =?utf-8?B?SDdpVlo3cGJCU0M1dzZKcjNnbk0xQW1LV1BzSG5ZMjZFK2pDc2t1M21JWkJS?=
 =?utf-8?B?dnVVdEk0Tk1MUTRTQ1R0MFNpblVRZGtLZ0Rvd0h2RnUwSEpQaUIvWVlWV1Zm?=
 =?utf-8?B?Ull1UXc0Unc1Z2tYNzc5cUZIWVJVbGRGWjdHU3hWSmlYeC9Ub3N1UWJwR0dt?=
 =?utf-8?B?eC9MMVQ1RkxoZVVBamlKVnJXQWZFMzJvTUc1SHlrS3Rwanp6cmFqb0VZWjRq?=
 =?utf-8?B?cnk3OWdBOEp4QTZ2YjhvWE5VSTNJWmd1UHJQdy8ySkFjRm1pRi9MU3UycW9o?=
 =?utf-8?B?eTJ6aHFQbno3Y1o5MVowSlY5bk5OUURmU3hkMzYyNzdYVG54T21EbmF6eXFz?=
 =?utf-8?B?NzNWWUdJN1p5OUxZU1BWcUJmZUdNWjFVbGRxemFtUUt6a3ROQnNTdGhWSm5W?=
 =?utf-8?B?TnRDblNuYkpkZTJUdDNQZExFQnQ0bWQ0Z0xIUjcyRG1KUmtXS2IwNE03dUtU?=
 =?utf-8?B?Y05IYk1ic1JXYStsZVRxbTNsZHRTQ05UMTBPM0Zva2RyVGxlYlJxcFBSRUl4?=
 =?utf-8?B?TlY4am1WY1B2cko4NnRBZE5OelJ1TjRkTG84di9hOUZORTRMbFRZV01kWG9w?=
 =?utf-8?B?bTZXZzZac2lTMURFanFOanNMQzFvTGlSNnhtbVU5bEZlWlBVTm1VbnB6eW1y?=
 =?utf-8?B?cWkxMTVjY1dyTVVXeUUyZFdNZmtPZmwxUWNYekE2T2ExSE9qZExwaCtDMnBD?=
 =?utf-8?B?RHdwWDFBWmV4ZDB2NWl6d1ZlT2pGQllFV3dUVXVBcSt6MVA2TUxpbk1YQ1Qz?=
 =?utf-8?B?STArZis2eDZOdTU2UG1VSk1SY3lJSnFSQ25WN3VMTWNYNTNTS3dJeWlUSkg1?=
 =?utf-8?B?TXBtQmpHcE9ab0pBYWdvYUlEMWhwOXdLWnc2VjJZMlR2VnliMHlrcExnNklo?=
 =?utf-8?B?VmVxS2taNHAxd2tXYXlGMkk4T2pqa3lFVERCeU5PQjFlVVFlTWExYnZVaVBm?=
 =?utf-8?B?ZFdON1FDU1FueHd3a1JqWmdtYVYxeEdJZUhmRHZMbkl0VUN5MG5aV0dpaTBM?=
 =?utf-8?B?b2crUHJmRnlKNFI1anlFUmZJMktRT1Jmd29qTVoyTjQ0UFpkR0ViWDg3dElI?=
 =?utf-8?B?eTN6NktsRXlrdGEvTWVpeFpyK3VYbVFzcUhyc0t5UTI1VzE0S3NsYnFoS05K?=
 =?utf-8?B?L2F6blk5TVhNZG1Dd3pQZGpmbDlWRE1ZQXBJWk01TUwvUm1xQlpmNkk2alRi?=
 =?utf-8?B?NG5Pa0xVRW9xZ0srV1cwQUF4T2R2ZTZ3dFExQnl1c3ZVRDhNV2Y1YlQ1aGFl?=
 =?utf-8?B?eENPdWRUdlVSL0VDdUxEbU9NYTJMdE9NekV1QzE0S3lpTTBuVkYwQW5XUlJI?=
 =?utf-8?Q?9L4PVO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFhRS3E5RVBOZWJpMm9pY21UZ0lIVDQ1NTBzQUtETnJpb25ybU1Vc0pYVkNM?=
 =?utf-8?B?UjkwVzI1NExuVHl0OGFxVTZ4QzZReUhMMHdSbDV5azlsK2lyZ2xEK3R4RFll?=
 =?utf-8?B?bHBXaUhvN21pV0VGdDMvSmNrRVJDb2NNTkZ5dlhyajFONVdUZXhuV0hWVVIy?=
 =?utf-8?B?a3RoTGlBa1BqeHk2QmRGSDhCMGl4dDlScjZyMVVwdmp6VEs5czZHc1hkQ2tW?=
 =?utf-8?B?MDFvMWRrY3NNQ3gyTkVnd1JDa2xTMUxSWlh6U2VLMzVyaUpUZTI2aElQdzlz?=
 =?utf-8?B?eDE0SEFlZ2N1c2ZNR296cVM1blZyUGxXRkl0T1d1YkRDV0Z0N3RpenVQaVNG?=
 =?utf-8?B?RGt1Zjl1NzFiRWRPNVQ3NzBpMGdyMHI4R3BKZVVJOC9HM0FYSmo2WnJkeHNa?=
 =?utf-8?B?MjlXSTBUT1poYmp3cU9BSjdHZXU3Z1E2RDg2QjgzdUh3NW1reDErT3JEWFgx?=
 =?utf-8?B?dzdnb0pyRHNpOU5vUGZBSU5Eekw3UFl4U3g5RmhWV3J6c0xWbDBFc3pGa0Vv?=
 =?utf-8?B?RFdSbVhudkFiVjZzV21lUzlOdUFyeG9QWC9VVy9PbitHKy9KaXFZNTFpRXMv?=
 =?utf-8?B?QXg1L1JWSkgwYWluckh0QytpYVV4VGtGRUIrNnhSak5aSFczZ00wbzZVUm9z?=
 =?utf-8?B?Y0U1ZUhuZTlIQVgrb3FtNFV5ZkZybkJySEJ3OWhNb3hrbVBPYWZZMXR4MXVU?=
 =?utf-8?B?S0lON3pGTThYQTVnSGRFaEFINnh1dklhSzk0aUtLcTBIVyt6aUdXcjVLSEQy?=
 =?utf-8?B?UGlzaXorWHZ5VkxUZWN3enNzZkFETVhGM1hGcElkN1FXTTZUTkFzV3YwN3A0?=
 =?utf-8?B?Qlh2S3pWUFBSd2ZvNzlQMUpUT0l1V3FSaFVFMXdqMkVTeTI2UThpODNPZ3lQ?=
 =?utf-8?B?TEIvRTRwU3BkNFQzQU02Z2EvQ2VsbEdZREgxbWdGVk9yOWEzWGpEQmxhWDBn?=
 =?utf-8?B?cHRGTFNiRUhldUhTV1U3aTFUYTBFWEJBWmhQSzdTWjBMYnlWcDVxRTNGcUg0?=
 =?utf-8?B?Umc3c2ZWT3plcm4wenFPZENuSmNoWUp6QnQydEREdERkZGx4bm56UnZ2aVVY?=
 =?utf-8?B?Q2F3WmRlWWl2YUUwNmNNZFlqQ0Q2aVUwSjllRDJ5TXhnQnd6TGFEQnp6T0F2?=
 =?utf-8?B?SGZpeFRMa0VhRDVtdWE1RVJlYVpscXBEQk01UzFuekF5Ym5sRkloQlZmWGtI?=
 =?utf-8?B?M1RDOVZBUTJnNkwwdUNiTnU0R1pWTmdYUEtUVWVpQ0t0T01JRUMrYUVSVkQ1?=
 =?utf-8?B?SUlEZU1vZVZ1dHlOcVJMblUxcGRFbndKUXVJaXhYN2lYZzluSFZ5RDRYWWF4?=
 =?utf-8?B?dmhkK2x2K2E2TEFRTDJEMXBGRllVdEZsRVhna3ZuSlY2cndJYVJzQWlZeWRx?=
 =?utf-8?B?WGdkbkxRZ3V0YllGU0tUT0RCSW9KRC9TNEtJeGcwWnRaWXlGZjZMclM0aDI4?=
 =?utf-8?B?YW9nSk1LdWV1UkIwcENxZGtLaTkvWEFjejVjMW1tUENYeVVtNGZOTnVKakpF?=
 =?utf-8?B?bmJQWlFaOG52ZEhndWdtYVRTZmtsVS9QdnRneG5tVkp1cldmd1JYbmRvMTZU?=
 =?utf-8?B?enAwRXA3SGc0OUF0SUM1ZXpteUxCMkRUZWpkdllsSlJaOVR6alcwZkliQUxz?=
 =?utf-8?B?dVZ3TjFNR05EUmhRck5kdmdIL0xDOGNQSnAxcDFlZjREMVBTNy9HT05FbmJs?=
 =?utf-8?B?UDhuYm84Z0NKN09vN2xOdUo2SnZaM2JFRkFpZ0JBeGoxNHBKT3dZNUh0RE95?=
 =?utf-8?B?NnJ4TG5KL0tVK21oYWdkU1RNSjJRYUJHN0VjdzV2eVFvaW8xdHdMZG1SQ2Rp?=
 =?utf-8?B?RThycXZOUWtReTZvVVliY21TSGJYU09TemRZWDJkNkJ4TUNlUi9ZMEw0OHFa?=
 =?utf-8?B?Sm1OUWNVempueHBobGxWeVMzT2xYdFIzZmRqVzRWUVRVUmpPTTdFRWhSREg4?=
 =?utf-8?B?OGFsOFQ2VnE4T3I0REQxVWdaNDZXcTlYUi93RW1hVHBpOG9xeWFvTTdtOUY3?=
 =?utf-8?B?NlFaOXgyekhrT2cvUGh4M0IvY0NWTnRUMzRHWjFEUWtOQkVWZTBVMW5DRW1H?=
 =?utf-8?B?bWFVcTYzYjFIYTBhWVFvdGVSYnFNOFRhUlYrOWJQMTdwd3lHd04xOGc5dXBv?=
 =?utf-8?B?RXFneUg0Z0tpZGZCcWlzV0NvdFlPN2lsMVpwS0lwckhDYVlrenFTazFTWVRo?=
 =?utf-8?Q?jLS1kGkt3t7bO9EMKcSaTEd6bUIA52pUOIJxWPl7WQzN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b131db71-3a3c-4b37-1263-08de1a1b9fba
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 14:25:08.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgQgNrWT5aM/e7WsLjxfMl7oEZp9C3NUzUIk8k3qj7RVNyr0RdvqtULUzsj0YkqAl1bfrhjkcJA0k82ma6Xxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

Use BitInt with the bitfield!() and register!() macros and adapt the
nova-core code accordingly.

This makes it impossible to trim values when setting a register field,
because either the value of the field has been inferred at compile-time
to fit within the bounds of the field, or the user has been forced to
check at runtime that it does indeed fit.

The use of BitInt actually simplifies register fields definitions,
as they don't need an intermediate storage type (the "as ..." part of
fields definitions). Instead, the internal storage type for each field
is now the bounded integer of its width in bits, which can optionally be
converted to another type that implements `From`` or `TryFrom`` for that
bounded integer type.

This means that something like

  register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
      3:3     status_valid as bool,
      31:8    addr as u32,
  });

Now becomes

  register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
      3:3     status_valid => bool,
      31:8    addr,
  });

(here `status_valid` is infallibly converted to a bool for convenience
and to remain compatible with the previous semantics)

The field setter/getters are also simplified. If a field has no target
type, then its setter expects any type that implements `Into` to the
field's bounded integer type. Due to the many `From` implementations for
primitive types, this means that most calls can be left unchanged. If
the caller passes a value that is potentially larger than the field's
capacity, it must use the `try_` variant of the setter, which returns an
error if the value cannot be converted at runtime.

For fields that use `=>` to convert to another type, both setter and
getter are always infallible.

For fields that use `?=>` to fallibly convert to another type, only the
getter needs to be fallible as the setter always provide valid values by
design.

Outside of the register macro, the biggest changes occur in `falcon.rs`,
which defines many enums for fields - their conversion implementations
need to be changed from the original primitive type of the field to the
new corresponding bounded int type. Hopefully the TryFrom/Into derive
macros [1] can take care of implementing these, but it will need to be
adapted to support bounded integers... :/

But overall, I am rather happy at how simple it was to convert the whole
of nova-core to this.

Note: This RFC uses nova-core's register!() macro for practical
purposes, but the hope is to move this patch on top of the bitfield
macro after it is split out [2].

[1]
https://lore.kernel.org/rust-for-linux/cover.1755235180.git.y.j3ms.n@gmail.com/
[2]
https://lore.kernel.org/rust-for-linux/20251003154748.1687160-1-joelagnelf@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/bitfield.rs         | 366 ++++++++++++++++--------------
 drivers/gpu/nova-core/falcon.rs           | 134 ++++++-----
 drivers/gpu/nova-core/falcon/hal/ga102.rs |   5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs     |   3 +-
 drivers/gpu/nova-core/gpu.rs              |   9 +-
 drivers/gpu/nova-core/regs.rs             | 139 ++++++------
 6 files changed, 353 insertions(+), 303 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 16e143658c51..c75d95ef1ae9 100644
--- a/drivers/gpu/nova-core/bitfield.rs
+++ b/drivers/gpu/nova-core/bitfield.rs
@@ -19,21 +19,21 @@
 ///     Auto = 2,
 /// }
 ///
-/// impl TryFrom<u8> for Mode {
-///     type Error = u8;
-///     fn try_from(value: u8) -> Result<Self, Self::Error> {
-///         match value {
+/// impl TryFrom<BitInt<u32, 4>> for Mode {
+///     type Error = u32;
+///     fn try_from(value: BitInt<u32, 4>) -> Result<Self, Self::Error> {
+///         match *value {
 ///             0 => Ok(Mode::Low),
 ///             1 => Ok(Mode::High),
 ///             2 => Ok(Mode::Auto),
-///             _ => Err(value),
+///             value => Err(value),
 ///         }
 ///     }
 /// }
 ///
-/// impl From<Mode> for u8 {
-///     fn from(mode: Mode) -> u8 {
-///         mode as u8
+/// impl From<Mode> for BitInt<u32, 4> {
+///     fn from(mode: Mode) -> BitInt<u32, 4> {
+///         BitInt::from_expr(mode as u32)
 ///     }
 /// }
 ///
@@ -44,25 +44,29 @@
 ///     Active = 1,
 /// }
 ///
-/// impl From<bool> for State {
-///     fn from(value: bool) -> Self {
-///         if value { State::Active } else { State::Inactive }
+/// impl From<BitInt<u32, 1>> for State {
+///     fn from(value: BitInt<u32, 1>) -> Self {
+///         if bool::from(value) {
+///             State::Active
+///         } else {
+///             State::Inactive
+///         }
 ///     }
 /// }
 ///
-/// impl From<State> for bool {
-///     fn from(state: State) -> bool {
+/// impl From<State> for BitInt<u32, 1> {
+///     fn from(state: State) -> BitInt<u32, 1> {
 ///         match state {
-///             State::Inactive => false,
-///             State::Active => true,
+///             State::Inactive => false.into(),
+///             State::Active => true.into(),
 ///         }
 ///     }
 /// }
 ///
 /// bitfield! {
 ///     pub struct ControlReg(u32) {
-///         7:7 state as bool => State;
-///         3:0 mode as u8 ?=> Mode;
+///         7:7 state => State;
+///         3:0 mode ?=> Mode;
 ///     }
 /// }
 /// ```
@@ -112,12 +116,9 @@ fn from(val: $name) -> $storage {
         bitfield!(@fields_dispatcher $vis $name $storage { $($fields)* });
     };
 
-    // Captures the fields and passes them to all the implementers that require field information.
-    //
-    // Used to simplify the matching rules for implementers, so they don't need to match the entire
-    // complex fields rule even though they only make use of part of it.
+    // Dispatch fields depending on the syntax used.
     (@fields_dispatcher $vis:vis $name:ident $storage:ty {
-        $($hi:tt:$lo:tt $field:ident as $type:tt
+        $($hi:tt:$lo:tt $field:ident
             $(?=> $try_into_type:ty)?
             $(=> $into_type:ty)?
             $(, $comment:literal)?
@@ -125,173 +126,208 @@ fn from(val: $name) -> $storage {
         )*
     }
     ) => {
-        bitfield!(@field_accessors $vis $name $storage {
-            $(
-                $hi:$lo $field as $type
-                $(?=> $try_into_type)?
-                $(=> $into_type)?
-                $(, $comment)?
-            ;
-            )*
-        });
-        bitfield!(@debug $name { $($field;)* });
-        bitfield!(@default $name { $($field;)* });
-    };
-
-    // Defines all the field getter/setter methods for `$name`.
-    (
-        @field_accessors $vis:vis $name:ident $storage:ty {
-        $($hi:tt:$lo:tt $field:ident as $type:tt
-            $(?=> $try_into_type:ty)?
-            $(=> $into_type:ty)?
-            $(, $comment:literal)?
-        ;
-        )*
-        }
-    ) => {
-        $(
-            bitfield!(@check_field_bounds $hi:$lo $field as $type);
-        )*
-
         #[allow(dead_code)]
         impl $name {
-            $(
-            bitfield!(@field_accessor $vis $name $storage, $hi:$lo $field as $type
-                $(?=> $try_into_type)?
-                $(=> $into_type)?
-                $(, $comment)?
-                ;
-            );
-            )*
+        $(
+        bitfield!(@private_field_accessors $name $storage : $hi:$lo $field);
+        bitfield!(@public_field_accessors $vis $name $storage : $hi:$lo $field
+            $(?=> $try_into_type)?
+            $(=> $into_type)?
+            $(, $comment)?
+        );
+        )*
         }
+
+        bitfield!(@debug $name { $($field;)* });
+        bitfield!(@default $name { $($field;)* });
+
     };
 
-    // Boolean fields must have `$hi == $lo`.
-    (@check_field_bounds $hi:tt:$lo:tt $field:ident as bool) => {
-        #[allow(clippy::eq_op)]
-        const _: () = {
-            ::kernel::build_assert!(
-                $hi == $lo,
-                concat!("boolean field `", stringify!($field), "` covers more than one bit")
-            );
-        };
-    };
-
-    // Non-boolean fields must have `$hi >= $lo`.
-    (@check_field_bounds $hi:tt:$lo:tt $field:ident as $type:tt) => {
-        #[allow(clippy::eq_op)]
-        const _: () = {
-            ::kernel::build_assert!(
-                $hi >= $lo,
-                concat!("field `", stringify!($field), "`'s MSB is smaller than its LSB")
-            );
-        };
-    };
-
-    // Catches fields defined as `bool` and convert them into a boolean value.
     (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as bool
-            => $into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(f != 0) }
-            bool $into_type => $into_type $(, $comment)?;
-        );
-    };
-
-    // Shortcut for fields defined as `bool` without the `=>` syntax.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as bool
-            $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @field_accessor $vis $name $storage, $hi:$lo $field as bool => bool $(, $comment)?;
-        );
-    };
-
-    // Catches the `?=>` syntax for non-boolean fields.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            ?=> $try_into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(@leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$try_into_type>::try_from(f as $type) } $type $try_into_type =>
-            ::core::result::Result<
-                $try_into_type,
-                <$try_into_type as ::core::convert::TryFrom<$type>>::Error
-            >
-            $(, $comment)?;);
-    };
-
-    // Catches the `=>` syntax for non-boolean fields.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            => $into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(@leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(f as $type) } $type $into_type => $into_type $(, $comment)?;);
-    };
-
-    // Shortcut for non-boolean fields defined without the `=>` or `?=>` syntax.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @field_accessor $vis $name $storage, $hi:$lo $field as $type => $type $(, $comment)?;
-        );
-    };
-
-    // Generates the accessor methods for a single field.
-    (
-        @leaf_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident
-            { $process:expr } $prim_type:tt $to_type:ty => $res_type:ty $(, $comment:literal)?;
+        @private_field_accessors $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
     ) => {
         ::kernel::macros::paste!(
         const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
-        const [<$field:upper _MASK>]: $storage = {
-            // Generate mask for shifting
-            match ::core::mem::size_of::<$storage>() {
-                1 => ::kernel::bits::genmask_u8($lo..=$hi) as $storage,
-                2 => ::kernel::bits::genmask_u16($lo..=$hi) as $storage,
-                4 => ::kernel::bits::genmask_u32($lo..=$hi) as $storage,
-                8 => ::kernel::bits::genmask_u64($lo..=$hi) as $storage,
-                _ => ::kernel::build_error!("Unsupported storage type size")
-            }
-        };
+        const [<$field:upper _MASK>]: u32 = ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
         const [<$field:upper _SHIFT>]: u32 = $lo;
         );
 
+        ::kernel::macros::paste!(
+        fn [<$field _internal>](self) ->
+            ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }> {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let field = ((self.0 & MASK) >> SHIFT);
+
+            ::kernel::num::BitInt::<$storage, { $hi + 1 - $lo }>::from_expr(field)
+        }
+
+        fn [<set_ $field _internal>](
+            mut self,
+            value: ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }>,
+        ) -> Self
+        {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let value = (value.get() << SHIFT) & MASK;
+            self.0 = (self.0 & !MASK) | value;
+
+            self
+        }
+
+        fn [<try_set_ $field _internal>]<T>(
+            mut self,
+            value: T,
+        ) -> ::kernel::error::Result<Self>
+            where T: ::kernel::num::TryIntoBitInt<$storage, { $hi + 1 - $lo }>,
+        {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let value = (
+                value.try_into_bitint().ok_or(::kernel::error::code::EOVERFLOW)?.get() << SHIFT
+            ) & MASK;
+
+            self.0 = (self.0 & !MASK) | value;
+
+            Ok(self)
+        }
+        );
+    };
+
+    // Generates the public accessors for fields infallibly (`=>`) converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            => $into_type:ty $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
         $(
         #[doc="Returns the value of this field:"]
         #[doc=$comment]
         )?
         #[inline(always)]
-        $vis fn $field(self) -> $res_type {
-            ::kernel::macros::paste!(
-            const MASK: $storage = $name::[<$field:upper _MASK>];
-            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            );
-            let field = ((self.0 & MASK) >> SHIFT);
-
-            $process(field)
+        $vis fn $field(self) -> $into_type
+        {
+            self.[<$field _internal>]().into()
         }
 
-        ::kernel::macros::paste!(
         $(
         #[doc="Sets the value of this field:"]
         #[doc=$comment]
         )?
         #[inline(always)]
-        $vis fn [<set_ $field>](mut self, value: $to_type) -> Self {
-            const MASK: $storage = $name::[<$field:upper _MASK>];
-            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            let value = ($storage::from($prim_type::from(value)) << SHIFT) & MASK;
-            self.0 = (self.0 & !MASK) | value;
-
-            self
+        $vis fn [<set_ $field>](self, value: $into_type) -> Self
+        {
+            self.[<set_ $field _internal>](value.into())
         }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> $into_type {
+            Default::default()
+        }
+
+        );
+    };
+
+    // Generates the public accessors for fields fallibly (`?=>`) converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            ?=> $try_into_type:ty $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(
+        #[doc="Returns the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn $field(self) ->
+            Result<
+                $try_into_type,
+                <$try_into_type as ::core::convert::TryFrom<
+                    ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }>
+                >>::Error
+            >
+        {
+            self.[<$field _internal>]().try_into()
+        }
+
+        $(
+        #[doc="Sets the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<set_ $field>](self, value: $try_into_type) -> Self
+        {
+            self.[<set_ $field _internal>](value.into())
+        }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> $try_into_type {
+            Default::default()
+        }
+
+        );
+    };
+
+    // Generates the public accessors for fields not converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(
+        #[doc="Returns the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn $field(self) ->
+            ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }>
+        {
+            self.[<$field _internal>]()
+        }
+
+        $(
+        #[doc="Sets the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<set_ $field>]<T>(
+            self,
+            value: T,
+        ) -> Self
+            where T: Into<::kernel::num::BitInt<$storage, { $hi + 1 - $lo }>>,
+        {
+            self.[<set_ $field _internal>](value.into())
+        }
+
+        $(
+        #[doc="Attempts to set the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<try_set_ $field>]<T>(
+            self,
+            value: T,
+        ) -> ::kernel::error::Result<Self>
+            where T: ::kernel::num::TryIntoBitInt<$storage, { $hi + 1 - $lo }>,
+        {
+            Ok(
+                self.[<set_ $field _internal>](
+                    value.try_into_bitint().ok_or(::kernel::error::code::EOVERFLOW)?
+                )
+            )
+        }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }> {
+            Default::default()
+        }
+
         );
     };
 
@@ -319,7 +355,7 @@ fn default() -> Self {
 
                 ::kernel::macros::paste!(
                 $(
-                value.[<set_ $field>](Default::default());
+                value.[<set_ $field>](Self::[<$field _default>]());
                 )*
                 );
 
diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index fb3561cc9746..7d85a01ea06e 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -7,6 +7,7 @@
 use kernel::device;
 use kernel::dma::DmaAddress;
 use kernel::io::poll::read_poll_timeout;
+use kernel::num::{self, BitInt};
 use kernel::prelude::*;
 use kernel::sync::aref::ARef;
 use kernel::time::delay::fsleep;
@@ -23,11 +24,14 @@
 pub(crate) mod sec2;
 
 // TODO[FPRI]: Replace with `ToPrimitive`.
-macro_rules! impl_from_enum_to_u8 {
-    ($enum_type:ty) => {
-        impl From<$enum_type> for u8 {
+macro_rules! impl_from_enum_to_bounded {
+    ($enum_type:ty, $length:literal) => {
+        impl<T> From<$enum_type> for BitInt<T, $length>
+        where
+            T: From<u8> + num::Boundable,
+        {
             fn from(value: $enum_type) -> Self {
-                value as u8
+                BitInt::from_expr(T::from(value as u8))
             }
         }
     };
@@ -47,16 +51,19 @@ pub(crate) enum FalconCoreRev {
     Rev6 = 6,
     Rev7 = 7,
 }
-impl_from_enum_to_u8!(FalconCoreRev);
+impl_from_enum_to_bounded!(FalconCoreRev, 4);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRev {
+impl<T> TryFrom<BitInt<T, 4>> for FalconCoreRev
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
+    fn try_from(value: BitInt<T, 4>) -> Result<Self> {
         use FalconCoreRev::*;
 
-        let rev = match value {
+        let rev = match u8::from(value) {
             1 => Rev1,
             2 => Rev2,
             3 => Rev3,
@@ -82,24 +89,25 @@ pub(crate) enum FalconCoreRevSubversion {
     Subversion2 = 2,
     Subversion3 = 3,
 }
-impl_from_enum_to_u8!(FalconCoreRevSubversion);
+impl_from_enum_to_bounded!(FalconCoreRevSubversion, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRevSubversion {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
+impl<T> From<BitInt<T, 2>> for FalconCoreRevSubversion
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
+    fn from(value: BitInt<T, 2>) -> Self {
         use FalconCoreRevSubversion::*;
 
-        let sub_version = match value & 0b11 {
+        match u8::from(value) {
             0 => Subversion0,
             1 => Subversion1,
             2 => Subversion2,
             3 => Subversion3,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(sub_version)
+            // TODO: somehow the compiler cannot infer that `value` cannot be > 3. Find a way to
+            // handle this gracefully, or switch back to fallible ops.
+            _ => panic!(),
+        }
     }
 }
 
@@ -126,16 +134,19 @@ pub(crate) enum FalconSecurityModel {
     /// Also known as High-Secure, Privilege Level 3 or PL3.
     Heavy = 3,
 }
-impl_from_enum_to_u8!(FalconSecurityModel);
+impl_from_enum_to_bounded!(FalconSecurityModel, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconSecurityModel {
+impl<T> TryFrom<BitInt<T, 2>> for FalconSecurityModel
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
+    fn try_from(value: BitInt<T, 2>) -> Result<Self> {
         use FalconSecurityModel::*;
 
-        let sec_model = match value {
+        let sec_model = match u8::from(value) {
             0 => None,
             2 => Light,
             3 => Heavy,
@@ -158,14 +169,17 @@ pub(crate) enum FalconModSelAlgo {
     #[default]
     Rsa3k = 1,
 }
-impl_from_enum_to_u8!(FalconModSelAlgo);
+impl_from_enum_to_bounded!(FalconModSelAlgo, 8);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconModSelAlgo {
+impl<T> TryFrom<BitInt<T, 8>> for FalconModSelAlgo
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: BitInt<T, 8>) -> Result<Self> {
+        match u8::from(value) {
             1 => Ok(FalconModSelAlgo::Rsa3k),
             _ => Err(EINVAL),
         }
@@ -180,14 +194,17 @@ pub(crate) enum DmaTrfCmdSize {
     #[default]
     Size256B = 0x6,
 }
-impl_from_enum_to_u8!(DmaTrfCmdSize);
+impl_from_enum_to_bounded!(DmaTrfCmdSize, 3);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for DmaTrfCmdSize {
+impl<T> TryFrom<BitInt<T, 3>> for DmaTrfCmdSize
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: BitInt<T, 3>) -> Result<Self> {
+        match u8::from(value) {
             0x6 => Ok(Self::Size256B),
             _ => Err(EINVAL),
         }
@@ -203,25 +220,20 @@ pub(crate) enum PeregrineCoreSelect {
     /// RISC-V core is active.
     Riscv = 1,
 }
+impl_from_enum_to_bounded!(PeregrineCoreSelect, 1);
 
-impl From<bool> for PeregrineCoreSelect {
-    fn from(value: bool) -> Self {
-        match value {
+impl<T> From<BitInt<T, 1>> for PeregrineCoreSelect
+where
+    T: num::Boundable + Zeroable,
+{
+    fn from(value: BitInt<T, 1>) -> Self {
+        match bool::from(value) {
             false => PeregrineCoreSelect::Falcon,
             true => PeregrineCoreSelect::Riscv,
         }
     }
 }
 
-impl From<PeregrineCoreSelect> for bool {
-    fn from(value: PeregrineCoreSelect) -> Self {
-        match value {
-            PeregrineCoreSelect::Falcon => false,
-            PeregrineCoreSelect::Riscv => true,
-        }
-    }
-}
-
 /// Different types of memory present in a falcon core.
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
 pub(crate) enum FalconMem {
@@ -245,14 +257,17 @@ pub(crate) enum FalconFbifTarget {
     /// Non-coherent system memory (System DRAM).
     NoncoherentSysmem = 2,
 }
-impl_from_enum_to_u8!(FalconFbifTarget);
+impl_from_enum_to_bounded!(FalconFbifTarget, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconFbifTarget {
+impl<T> TryFrom<BitInt<T, 2>> for FalconFbifTarget
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        let res = match value {
+    fn try_from(value: BitInt<T, 2>) -> Result<Self> {
+        let res = match u8::from(value) {
             0 => Self::LocalFb,
             1 => Self::CoherentSysmem,
             2 => Self::NoncoherentSysmem,
@@ -272,26 +287,21 @@ pub(crate) enum FalconFbifMemType {
     /// Physical memory addresses.
     Physical = 1,
 }
+impl_from_enum_to_bounded!(FalconFbifMemType, 1);
 
 /// Conversion from a single-bit register field.
-impl From<bool> for FalconFbifMemType {
-    fn from(value: bool) -> Self {
-        match value {
+impl<T> From<BitInt<T, 1>> for FalconFbifMemType
+where
+    T: num::Boundable + Zeroable,
+{
+    fn from(value: BitInt<T, 1>) -> Self {
+        match bool::from(value) {
             false => Self::Virtual,
             true => Self::Physical,
         }
     }
 }
 
-impl From<FalconFbifMemType> for bool {
-    fn from(value: FalconFbifMemType) -> Self {
-        match value {
-            FalconFbifMemType::Virtual => false,
-            FalconFbifMemType::Physical => true,
-        }
-    }
-}
-
 /// Type used to represent the `PFALCON` registers address base for a given falcon engine.
 pub(crate) struct PFalconBase(());
 
@@ -414,7 +424,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.reset_wait_mem_scrubbing(bar)?;
 
         regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
+            .set_value(u32::from(regs::NV_PMC_BOOT_0::read(bar)))
             .write(bar, &E::ID);
 
         Ok(())
@@ -481,18 +491,18 @@ fn dma_wr<F: FalconFirmware<Target = E>>(
             .set_base((dma_start >> 8) as u32)
             .write(bar, &E::ID);
         regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
-            .set_base((dma_start >> 40) as u16)
+            .try_set_base(dma_start >> 40)?
             .write(bar, &E::ID);
 
         let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::default()
             .set_size(DmaTrfCmdSize::Size256B)
             .set_imem(target_mem == FalconMem::Imem)
-            .set_sec(if sec { 1 } else { 0 });
+            .set_sec(BitInt::from_expr(if sec { 1 } else { 0 }));
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
             regs::NV_PFALCON_FALCON_DMATRFMOFFS::default()
-                .set_offs(load_offsets.dst_start + pos)
+                .try_set_offs(load_offsets.dst_start + pos)?
                 .write(bar, &E::ID);
             regs::NV_PFALCON_FALCON_DMATRFFBOFFS::default()
                 .set_offs(src_start + pos)
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index afed353b24d2..c43e48823eff 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -51,7 +51,7 @@ fn signature_reg_fuse_version_ga102(
 
     // `ucode_idx` is guaranteed to be in the range [0..15], making the `read` calls provable valid
     // at build-time.
-    let reg_fuse_version = if engine_id_mask & 0x0001 != 0 {
+    let reg_fuse_version: u16 = if engine_id_mask & 0x0001 != 0 {
         regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::read(bar, ucode_idx).data()
     } else if engine_id_mask & 0x0004 != 0 {
         regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::read(bar, ucode_idx).data()
@@ -60,7 +60,8 @@ fn signature_reg_fuse_version_ga102(
     } else {
         dev_err!(dev, "unexpected engine_id_mask {:#x}", engine_id_mask);
         return Err(EINVAL);
-    };
+    }
+    .into();
 
     // TODO[NUMM]: replace with `last_set_bit` once it lands.
     Ok(u16::BITS - reg_fuse_version.leading_zeros())
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index 871c42bf033a..5b55ca8aaddb 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -2,6 +2,7 @@
 
 struct Ga100;
 
+use kernel::num::BitInt;
 use kernel::prelude::*;
 
 use crate::driver::Bar0;
@@ -18,7 +19,7 @@ pub(super) fn read_sysmem_flush_page_ga100(bar: &Bar0) -> u64 {
 
 pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
     regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::default()
-        .set_adr_63_40((addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI) as u32)
+        .set_adr_63_40(BitInt::from_expr(addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI).cast())
         .write(bar);
     regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
         .set_adr_39_08((addr >> FLUSH_SYSMEM_ADDR_SHIFT) as u32)
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 9d182bffe8b4..2db3e48ea59f 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use kernel::num::BitInt;
 use kernel::{device, devres::Devres, error::code::*, fmt, pci, prelude::*, sync::Arc};
 
 use crate::driver::Bar0;
@@ -130,15 +131,15 @@ fn try_from(value: u8) -> Result<Self> {
 }
 
 pub(crate) struct Revision {
-    major: u8,
-    minor: u8,
+    major: BitInt<u8, 4>,
+    minor: BitInt<u8, 4>,
 }
 
 impl Revision {
     fn from_boot0(boot0: regs::NV_PMC_BOOT_0) -> Self {
         Self {
-            major: boot0.major_revision(),
-            minor: boot0.minor_revision(),
+            major: boot0.major_revision().cast(),
+            minor: boot0.minor_revision().cast(),
         }
     }
 }
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 206dab2e1335..1542d72e4a65 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -17,18 +17,19 @@
 // PMC
 
 register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
-    3:0     minor_revision as u8, "Minor revision of the chip";
-    7:4     major_revision as u8, "Major revision of the chip";
-    8:8     architecture_1 as u8, "MSB of the architecture";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    28:24   architecture_0 as u8, "Lower bits of the architecture";
+    3:0     minor_revision, "Minor revision of the chip";
+    7:4     major_revision, "Major revision of the chip";
+    8:8     architecture_1, "MSB of the architecture";
+    23:20   implementation, "Implementation version of the architecture";
+    28:24   architecture_0, "Lower bits of the architecture";
 });
 
 impl NV_PMC_BOOT_0 {
     /// Combines `architecture_0` and `architecture_1` to obtain the architecture of the chip.
     pub(crate) fn architecture(self) -> Result<Architecture> {
         Architecture::try_from(
-            self.architecture_0() | (self.architecture_1() << Self::ARCHITECTURE_0_RANGE.len()),
+            u8::from(self.architecture_0())
+                | (u8::from(self.architecture_1()) << Self::ARCHITECTURE_0_RANGE.len()),
         )
     }
 
@@ -49,7 +50,7 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 
 register!(NV_PBUS_SW_SCRATCH_0E_FRTS_ERR => NV_PBUS_SW_SCRATCH[0xe],
     "scratch register 0xe used as FRTS firmware error code" {
-    31:16   frts_err_code as u16;
+    31:16   frts_err_code;
 });
 
 // PFB
@@ -58,17 +59,17 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 // GPU to perform sysmembar operations (see `fb::SysmemFlush`).
 
 register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR @ 0x00100c10 {
-    31:0    adr_39_08 as u32;
+    31:0    adr_39_08;
 });
 
 register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI @ 0x00100c40 {
-    23:0    adr_63_40 as u32;
+    23:0    adr_63_40;
 });
 
 register!(NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE @ 0x00100ce0 {
-    3:0     lower_scale as u8;
-    9:4     lower_mag as u8;
-    30:30   ecc_mode_enabled as bool;
+    3:0     lower_scale;
+    9:4     lower_mag;
+    30:30   ecc_mode_enabled => bool;
 });
 
 impl NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE {
@@ -87,7 +88,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 }
 
 register!(NV_PFB_PRI_MMU_WPR2_ADDR_LO@0x001fa824  {
-    31:4    lo_val as u32, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
+    31:4    lo_val, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
 });
 
 impl NV_PFB_PRI_MMU_WPR2_ADDR_LO {
@@ -98,7 +99,7 @@ pub(crate) fn lower_bound(self) -> u64 {
 }
 
 register!(NV_PFB_PRI_MMU_WPR2_ADDR_HI@0x001fa828  {
-    31:4    hi_val as u32, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
+    31:4    hi_val, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
 });
 
 impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
@@ -123,7 +124,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 // `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
           "Privilege level mask register" {
-    0:0     read_protection_level0 as bool, "Set after FWSEC lowers its protection level";
+    0:0     read_protection_level0 => bool, "Set after FWSEC lowers its protection level";
 });
 
 // OpenRM defines this as a register array, but doesn't specify its size and only uses its first
@@ -133,7 +134,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 register!(
     NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0],
     "Scratch group 05 register 0 used as GFW boot progress indicator" {
-        7:0    progress as u8, "Progress of GFW boot (0xff means completed)";
+        7:0    progress, "Progress of GFW boot (0xff means completed)";
     }
 );
 
@@ -145,13 +146,13 @@ pub(crate) fn completed(self) -> bool {
 }
 
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
-    31:0    value as u32;
+    31:0    value;
 });
 
 register!(
     NV_USABLE_FB_SIZE_IN_MB => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42,
     "Scratch group 42 register used as framebuffer size" {
-        31:0    value as u32, "Usable framebuffer size, in megabytes";
+        31:0    value, "Usable framebuffer size, in megabytes";
     }
 );
 
@@ -165,8 +166,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PDISP
 
 register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
-    3:3     status_valid as bool, "Set if the `addr` field is valid";
-    31:8    addr as u32, "VGA workspace base address divided by 0x10000";
+    3:3     status_valid => bool, "Set if the `addr` field is valid";
+    31:8    addr, "VGA workspace base address divided by 0x10000";
 });
 
 impl NV_PDISP_VGA_WORKSPACE_BASE {
@@ -185,40 +186,40 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
 register!(NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION @ 0x00824100[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 register!(NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION @ 0x00824140[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 register!(NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION @ 0x008241c0[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 // PFALCON
 
 register!(NV_PFALCON_FALCON_IRQSCLR @ PFalconBase[0x00000004] {
-    4:4     halt as bool;
-    6:6     swgen0 as bool;
+    4:4     halt => bool;
+    6:6     swgen0 => bool;
 });
 
 register!(NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase[0x00000040] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase[0x00000044] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_RM @ PFalconBase[0x00000084] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_HWCFG2 @ PFalconBase[0x000000f4] {
-    10:10   riscv as bool;
-    12:12   mem_scrubbing as bool, "Set to 0 after memory scrubbing is completed";
-    31:31   reset_ready as bool, "Signal indicating that reset is completed (GA102+)";
+    10:10   riscv => bool;
+    12:12   mem_scrubbing => bool, "Set to 0 after memory scrubbing is completed";
+    31:31   reset_ready => bool, "Signal indicating that reset is completed (GA102+)";
 });
 
 impl NV_PFALCON_FALCON_HWCFG2 {
@@ -229,101 +230,101 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 }
 
 register!(NV_PFALCON_FALCON_CPUCTL @ PFalconBase[0x00000100] {
-    1:1     startcpu as bool;
-    4:4     halted as bool;
-    6:6     alias_en as bool;
+    1:1     startcpu => bool;
+    4:4     halted => bool;
+    6:6     alias_en => bool;
 });
 
 register!(NV_PFALCON_FALCON_BOOTVEC @ PFalconBase[0x00000104] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMACTL @ PFalconBase[0x0000010c] {
-    0:0     require_ctx as bool;
-    1:1     dmem_scrubbing as bool;
-    2:2     imem_scrubbing as bool;
-    6:3     dmaq_num as u8;
-    7:7     secure_stat as bool;
+    0:0     require_ctx => bool;
+    1:1     dmem_scrubbing => bool;
+    2:2     imem_scrubbing => bool;
+    6:3     dmaq_num;
+    7:7     secure_stat => bool;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase[0x00000110] {
-    31:0    base as u32;
+    31:0    base => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase[0x00000114] {
-    23:0    offs as u32;
+    23:0    offs;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase[0x00000118] {
-    0:0     full as bool;
-    1:1     idle as bool;
-    3:2     sec as u8;
-    4:4     imem as bool;
-    5:5     is_write as bool;
-    10:8    size as u8 ?=> DmaTrfCmdSize;
-    14:12   ctxdma as u8;
-    16:16   set_dmtag as u8;
+    0:0     full => bool;
+    1:1     idle => bool;
+    3:2     sec;
+    4:4     imem => bool;
+    5:5     is_write => bool;
+    10:8    size ?=> DmaTrfCmdSize;
+    14:12   ctxdma;
+    16:16   set_dmtag;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase[0x0000011c] {
-    31:0    offs as u32;
+    31:0    offs => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase[0x00000128] {
-    8:0     base as u16;
+    8:0     base;
 });
 
 register!(NV_PFALCON_FALCON_HWCFG1 @ PFalconBase[0x0000012c] {
-    3:0     core_rev as u8 ?=> FalconCoreRev, "Core revision";
-    5:4     security_model as u8 ?=> FalconSecurityModel, "Security model";
-    7:6     core_rev_subversion as u8 ?=> FalconCoreRevSubversion, "Core revision subversion";
+    3:0     core_rev ?=> FalconCoreRev, "Core revision";
+    5:4     security_model ?=> FalconSecurityModel, "Security model";
+    7:6     core_rev_subversion => FalconCoreRevSubversion, "Core revision subversion";
 });
 
 register!(NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase[0x00000130] {
-    1:1     startcpu as bool;
+    1:1     startcpu => bool;
 });
 
 // Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the falcon
 // instance.
 register!(NV_PFALCON_FALCON_ENGINE @ PFalconBase[0x000003c0] {
-    0:0     reset as bool;
+    0:0     reset => bool;
 });
 
 register!(NV_PFALCON_FBIF_TRANSCFG @ PFalconBase[0x00000600[8]] {
-    1:0     target as u8 ?=> FalconFbifTarget;
-    2:2     mem_type as bool => FalconFbifMemType;
+    1:0     target ?=> FalconFbifTarget;
+    2:2     mem_type => FalconFbifMemType;
 });
 
 register!(NV_PFALCON_FBIF_CTL @ PFalconBase[0x00000624] {
-    7:7     allow_phys_no_ctx as bool;
+    7:7     allow_phys_no_ctx => bool;
 });
 
 /* PFALCON2 */
 
 register!(NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base[0x00000180] {
-    7:0     algo as u8 ?=> FalconModSelAlgo;
+    7:0     algo ?=> FalconModSelAlgo;
 });
 
 register!(NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base[0x00000198] {
-    7:0    ucode_id as u8;
+    7:0    ucode_id => u8;
 });
 
 register!(NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base[0x0000019c] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 // OpenRM defines this as a register array, but doesn't specify its size and only uses its first
 // element. Be conservative until we know the actual size or need to use more registers.
 register!(NV_PFALCON2_FALCON_BROM_PARAADDR @ PFalcon2Base[0x00000210[1]] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 // PRISCV
 
 register!(NV_PRISCV_RISCV_BCR_CTRL @ PFalconBase[0x00001668] {
-    0:0     valid as bool;
-    4:4     core_select as bool => PeregrineCoreSelect;
-    8:8     br_fetch as bool;
+    0:0     valid => bool;
+    4:4     core_select => PeregrineCoreSelect;
+    8:8     br_fetch => bool;
 });
 
 // The modules below provide registers that are not identical on all supported chips. They should
@@ -333,7 +334,7 @@ pub(crate) mod gm107 {
     // FUSE
 
     register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
-        0:0     display_disabled as bool;
+        0:0     display_disabled => bool;
     });
 }
 
@@ -341,6 +342,6 @@ pub(crate) mod ga100 {
     // FUSE
 
     register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
-        0:0     display_disabled as bool;
+        0:0     display_disabled => bool;
     });
 }

-- 
2.51.2


