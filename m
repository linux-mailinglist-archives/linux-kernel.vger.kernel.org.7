Return-Path: <linux-kernel+bounces-720689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFBBAFBF41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D807E3B01E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068715C140;
	Tue,  8 Jul 2025 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XVu5QpMh"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31612CD8B;
	Tue,  8 Jul 2025 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935010; cv=fail; b=ZfrS94gn6gzTDKnwox/BLDPiPMroGwp/NqzRSLGTS1uQ4TT0bH3VXbmuZd2EHKvbnzWQ6Bk9Y6buMLBFpcmyX6EoKUHBR4EJTvAhh+px/lKmnx+RBKsKhFYn8fSMxApxAk5T1wEPAKJPSBIgzVDgdfDNzk6kAk3/3FZ2Rt913S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935010; c=relaxed/simple;
	bh=0wX5huUXY/7iGRuB0ia75qZST16tFIL91mLVGCakDQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OCXfxPZELRFXRgKelUgx/DsyFXpD4/UQSvJDoGVcjOiuuhC5hqm6MjXtKTTmOP6WHrhKi3fiwlRStTd3D2nBHUEgDlGs+1pYqoyW+10oYg5k9ZHabH1ieprrLUAlXFXI230e56cGiMyCEBqH/vMC0ffpJrow4pwhjjZm0Lp0XEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XVu5QpMh; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZiepeDfapUtiMGShGppVljaoJLSIAs5RtefLoyvyS3j9eQV/vmr9ndTeyZHRIRR56LgGMuFUUYinnZ8CjuZ1AGrTvH+/lhdqD6wG79IBrgio14WP4smFBAkGxdlHW5Re2CbN1i/GhQyfOX7ND83rcP6Fn7be/K06M+2gJxO9itOTw/bYDP2wUOrv9v9IwEsnb9iJE1+ZYc8Oq9Y/arPNO9DN8wft8GKXzATCZvUyPCPr7aNkSHIdhGPuM7qRNHEv40M4D6c688Kvrz+id3OSJU8VXQgY2Gm9YWW+1h2SPr2e3PKghR6L4octBtNAtOgr7+rYwZO0l17bNHzU2rpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGoUzY94crIodBVpKsLNuuyFKxUHKlZdlEo8DwjaM5w=;
 b=y2NNOAnNqm/wsRiMJLZnaiPcfGy7+Zn+ahu6dIINGV2ATO8qluDw9LK6lnSbsZ6UZpgp9Rowh8l6Wa7hByqf0mGnH5UIngPZ3w+v43VIHg1hIJjnhWEG5hpW2IgWIdFt+vUnWxAn5SVGwnEmLEM589LIXWCji4hJL2Bb38nBvnHcdVBcwhddz6qB7LP94wpExnUaN+0RFdmJIvHdgtxg5Xq/0nPzcbTXY1sbC3syGRv8DSrLRcIuiEinZlaAjhX6ZbLhIbe8hfRTZhJim8UYiDCp0Pwcf9U6dKz8CW9FtRBXrvZBWA+gwHjvkM3tG4sHyT80g0/0+TsJxOeWoz1ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGoUzY94crIodBVpKsLNuuyFKxUHKlZdlEo8DwjaM5w=;
 b=XVu5QpMhd3ODyZ/k2fY3dcEtQJvh3i4AgB6Gau8xcBXpJZKqJ8TcWRIIdUy8cZfH9fieO5j4/gB5wbkGGVIkENgrFBImLW9tNldh/STxjGMmkAL24yQh5Op+W4czxycgnEHB8YjwMR0R5utJ9Ys/fmohT40Y/BSvn5dUzcjn1t7G+JRVP7zq1/rwpDrItcp2fd2r8AL0ofGcJQWcM8wGhOzbNrg++b+AWWLi4OJ63RyA/DbpNV9RgLI0Ch4R1olr0lwHCHwQ4v8V61jPcI/6mBV4fHS02rvxIyvXX8qMsRLJPknguCdei2JKUBkwvUd5+07C0M9zHNyLHZ4b1sV7cg==
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
 by MAUPR01MB11168.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 00:36:40 +0000
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c]) by PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c%7]) with mapi id 15.20.8835.018; Tue, 8 Jul 2025
 00:36:40 +0000
Message-ID:
 <PNYPR01MB1117130A5FA9DE0637D925C16FE4EA@PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 8 Jul 2025 08:36:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] riscv: dts: sophgo: add Sophgo SG2042_EVB_V2.0
 board device tree
To: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Inochi Amaoto <inochiama@gmail.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1751700954.git.rabenda.cn@gmail.com>
 <c1b6ccdc69af0c1457fc1486a6bc8a1e83671537.1751700954.git.rabenda.cn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <c1b6ccdc69af0c1457fc1486a6bc8a1e83671537.1751700954.git.rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
X-Microsoft-Original-Message-ID:
 <097c3a7d-b34d-4191-bbb3-c59cddb51784@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11171:EE_|MAUPR01MB11168:EE_
X-MS-Office365-Filtering-Correlation-Id: 7859f5ee-a5cc-4990-ad2e-08ddbdb7818f
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT9t7DujJ6AQN4qQStI03N4JsBLsVb9AxlShDdvlTwPrz15ceYk05ZMJV3aJHlZQPe9I3nQASxCBiRQBZoBBpPdeN3Bu7HpaMyhO6ud0I/FZfLjy37QvvE8kYLXtbwxhHjdpBin8gEJuo0AtpTJoxgbn3xfhMNJKA3qLzhQ/czYo4k/D26klFr5wyn7CgeNW8ILRv/OEC4SFQCeVCOegaJzTrY/PqUW4U7yRiG6bzmui/wBjTCuPPkY4jDHbG6YUp65JCSTJo+Ry90AHXH32HcKLlBymVe3MJQjYGxhRUS6MhlJneOGpqAtAOPEEC1XOzj7urBrod6UJN2mQdMv3Vj4dO0cluhTy3iVPF+029GkV4uV7HI9FncwPfNWHS/JIv+3EBzwIqTfFXG/RZyjPHOVqzPrzM0Z0ySOGe+UCgNPekBcAA+N9SYUn7VFkOG2AcODmrAAe1IWmZ/Cv4nnlYDN7YruolEWh0omNaZtHuc9CozzjhrNcXEXhS/lH1I+gm3EqK59EBiI8JHwJjO4uNkPNLA7qzBDrPlZ6EKmb3qqn+SlLboWbHJw9WOMZZBbD27Kv0Pg1Hu0RL85EhlRSCjLfHPC0wSBOa34Ji72PjtA72/NGYGl/BjdrNTw8UU1XADEGt975tbzsvnPwc4GfsSScPKif8iiTy4JafFoyOvNAKz7wF/ZWGtAEboCLOlnNWzKUGjM2nAvcG6tj8rA9PUmShat90B/ZHIJoLqoM+kGDqaUH5ne1FdiwM0ej9fHmy+CgrKF9mWQ6+dS+3K6FWUSr0jPhlVnPlMJkiNZzh6RitqnV8FXq8yDS
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|13031999003|15080799012|6090799003|40105399003|3412199025|440099028|10035399007|18061999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2V0aGprY1dYU0pqRDN2eGwvVDBkQ3QwNkxUMEdBZDN6YStRSndhRjRJWGhT?=
 =?utf-8?B?dU9BeWZ5MGM2emZzNjZhZ3ZDS09lWURWZnZZK3E2V29YRXR4d3dNS1BLNnNH?=
 =?utf-8?B?bmpadWptNm9YTlZiaHRqdXhtL3NuRlIwY014aTlSZmJvYkdETDVxTHpDajlO?=
 =?utf-8?B?aWhlL29tR1A1bm02MzRPYlhrOFlLQldQS28vVUVMbjlRanIrK2tvZ3lYTVM4?=
 =?utf-8?B?U2lCcTJmS1pkcjdOajJFUndKMHEzL2M0bjdUQVBEcitzVDVHZUFtUjQ4WDVD?=
 =?utf-8?B?VDlneDVnTzdwU3FsbHNnWXF5ajFYMkxWa2M1ZFZMOE1BUXI3Ukh5TVBOMnNv?=
 =?utf-8?B?SDFjbkt4U2lWTTJzTjdVQUM3QUxwMCsrYjBycjJjb2lzTno5TG10U1NDWDVn?=
 =?utf-8?B?QUt4Tkc3QWtkc29meW1JeHUvU2xneUtyaFMvMEdWWDN3RXpKT0FaaUVPeHJP?=
 =?utf-8?B?N3dQalkzZVYyOExFMmVXMDBXUi84MU9FOGVySzQ0d1VlRVVTQjYySVRKNkJo?=
 =?utf-8?B?UktxZXpjNENWQkVoVXh5bTN1TFg3d2QraldvYWFvK0YvaFgzVm94YUpWeFpt?=
 =?utf-8?B?dGkyN3R0OXFpQTgzV2pYRzdpV0hjcERLaG4xV1dLTHdHaWhHTGkyeWh5OElH?=
 =?utf-8?B?b1BjT0xlQ3ZlK0RBMVR6KzdmUk5ldXdUaEpnQ1VLeWVpRURMM0JzQ1ZicFAv?=
 =?utf-8?B?azVYWmFwU3FmMFhoNDlsOGlWL3pBVDFlcnZlM3NJZ0pML0ROMG5KMWhYOU5l?=
 =?utf-8?B?V0tRNDBTeVR0YlhuTUdTcERGSE0rTC9Ha3BraHJRUzIzenVNS0hCSHZ5cjdV?=
 =?utf-8?B?N3h0enRuM2krSmdOekJNdlFVQ1RhaHVQVkdmVE1RdXlHUGttSHhTMzA3QzU4?=
 =?utf-8?B?Qk8vbzdhY1RSNGNHZWF5WTJRWnNRY3BiSW9uT0pMRXNuZmFhRjZTc2FYZXVB?=
 =?utf-8?B?S1FKS0VQMWJ6VGxNUk1KT1MramlTWStsQ3Y1WGNMeWFGbnR4UlhlU0QrRGVW?=
 =?utf-8?B?K0hsMkYrUjM4ZmtGbENSWCt6NllTbG9hMStWdTFGTm9xc1ptWkV3YVA2a3lt?=
 =?utf-8?B?NWVUcmt3WHlGRmdsN01CZ3ppblB5SEQ1TDVBMG1VaHlxd3lzNjJZcFpLVGJz?=
 =?utf-8?B?aW93VE9DZldwVXVCeHB1N0I3WVVDdGVwTkRRMWh3NzJHTWsxd3NnNDJZd1NV?=
 =?utf-8?B?U2U2TnVtbXhEVmo5dHBJOTk2S2lPYVF0U2xSbGpSc1VXejVXalh6a09NNWpR?=
 =?utf-8?B?YUw0NGZ5ai91ZnMyT2FVdGJzeVlkUjhkSG5wT0JXNjFOT0hrK29xREMwNFBL?=
 =?utf-8?B?VXo0aWlOK1ErTXpJS3JGZzczazBUbFRZdjlIR0xiZHNhZDBDYnZVVDVwL3ZZ?=
 =?utf-8?B?Wi93WWtJTjBUMm55eVF3cmlvMnlBKzN2ZkFwRlZoYUlNSEN1a0I4T3hIRUNq?=
 =?utf-8?B?c0xVZ3N2ekJ3ZFJ1RHF1T1RpRFBxK3NTSDhUS21UenQzTCtxU2h3akhwdG1u?=
 =?utf-8?B?Z3ZCd0VPSTB5cml4ZFo5RERtVjEyUEoweXNmY2hJOTlISVNJY1JHaG5iVUhN?=
 =?utf-8?Q?vJqf1/gNUIhORAbahZsT6xGRQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0hKMDhjODdxMWpma3JkVGVlcFlmQy9FNWNIVXJQYVZuQ01UZmo2Mk1YMFFQ?=
 =?utf-8?B?blRXSVlZNGpsS0QzQVcrTXQzUW5TdElyOWxqU1lTcE8vVlhJSlkxYVMvMEVO?=
 =?utf-8?B?UHh3V1UwYzllcDFPTXNYZzZZTWxyT0ZRVHF2eEVPbGdIK3BjM255QXNHMFpP?=
 =?utf-8?B?b3o1K3RaWDArelVybHJsZEp0WG9lZGJST3ZzQTdyTnBWNFlNWFViM1hGNzhC?=
 =?utf-8?B?N1FoRzBHak9aak5ic3paSFhHdFV2ZWhRR3poNFd1eWpvYU9BYk1TN0ZReXZm?=
 =?utf-8?B?dHZCUWIzRG5zVkRoclFvaVo3OENtYkI4Y2FuZ0dMK2ZSdzJOajI0ZVFKbGxl?=
 =?utf-8?B?NVlTZzllQm82NlNqZkc0MHBsaEdhWCtaMktBdXJMTnZ0UGxnK0M3OWVQUDZl?=
 =?utf-8?B?TUxUZUVCdUcxaWVsWVhvSldnaHJ6N1hJSVVUK1ZwM2h5LzJ3R3p3TS83bEds?=
 =?utf-8?B?TFNzcTdIVkJaR3UyTUQ0Z0EzSDFQOWx4VGgxaWJqWUhvVUhrUEpZanlZZ3dr?=
 =?utf-8?B?TjdEVFJHeDVUR1ZBZDljejY4RGhDdmd1U0s0WHVsTm50eFZQVldJSVJKeFBQ?=
 =?utf-8?B?R2pHbUU0NTUzYjBvNGJMUjhMY2x0U3hmbnYwc2JqTUl0VWtySnNZbVJSc2VX?=
 =?utf-8?B?N3ZabUQ3cmlPYTg4YndDMlZxc3JqQ1dnNmpaSTlTWVNaV0czM0ZWbzR1OTFx?=
 =?utf-8?B?QU1adW1EV2dHZHcvTmc0Wm9MZEQxR21XZnV3WFB1UVhLMnBhTHBJeHI0ZkhG?=
 =?utf-8?B?ODdFUkhHbFFnSVhSYktRRDVYcVV2UFRoNG04WC9hUUlFVmsrU1BsLzRXbHJY?=
 =?utf-8?B?WG4xQit1cGpJWXQwQ242bUNPeVNYUFZtbmpJRml5TnhZcFlkanJycVYzQmlm?=
 =?utf-8?B?dTM4Y3BDNndEQi9yWkpTbEFiV1MyR0wzV3RNUXVjZ2RjTE1yT2YzYmlxN2Iv?=
 =?utf-8?B?UDdjeC9iWWIwdk1ycW1ZL1pYS003b3NQMHFtRkh3SkF4aFlYcURhSElWeDVC?=
 =?utf-8?B?RkJKbk9EbVdxUjRUeFBCOC9TM3Y4a2RIa3RoYks4M29yNUx1MkhDY2JzUUlS?=
 =?utf-8?B?b1VRYWhMbGdrL0VHdmdqejFUUVNkYjlSSEdSUEJXRERJMFpNZmw4aFlMaytX?=
 =?utf-8?B?VlJHRW1hQ2NhOVpjdWtKeVFFRGNJQlJYSVZDd0YrWVM4RnRDZHcyZXVpL0Z4?=
 =?utf-8?B?NHUxKytyY2ZmY0loaVFhUnUzazZDNUJRZmdhYkdLaUtPdDBCbXRtbFp3dzlJ?=
 =?utf-8?B?Ty85WWE3NW9yN1A2K1l2L2ZlYkFDRk8xMlFmSVRPRCt3M2NQMmJzY2l4ZTB4?=
 =?utf-8?B?L2twamZmdnZPU1dhYVR0TUFQMzM2Rm1ORkNtK0xsbHBtbnF5bTE0b2FoSUsz?=
 =?utf-8?B?YTlmRDRSWnR0NkplUHVvOTlkOUxGYWFhRGVlVG40RG9mbEZCa1JCaVZLdUFI?=
 =?utf-8?B?VzBKOGNldVZheVVnWjhuYk1YQkpNeS92akNMWW5Yc294N3Y1aDF6V2k3dDE2?=
 =?utf-8?B?Rm05SGlDRldjSkt2SHdMQ1FyTEE2T2ZOOHpkaVEwZjdydGdNaTlNNk5YR3Fn?=
 =?utf-8?B?L0I4UmhmRnN3KzV2YVlOekJLTUlOWUhGNVVselhFWGpHRGZnOHl4elh1VFZx?=
 =?utf-8?B?Tk1qKzE0ZGhjMklJQzdERkZmNmVtUmI2alh6QkdaQ0F1UldxMW0yb0NqUGhi?=
 =?utf-8?B?TkVDeFpQNXF1QkF3dk1JdEpKVlhZNnJJQmJGZVM5eXVwVkVoMjlFcC9lYmI1?=
 =?utf-8?Q?+XMF9vJoLqWJi5iiZirVmTpEuEA1uvpl5vPsuf1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7859f5ee-a5cc-4990-ad2e-08ddbdb7818f
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 00:36:40.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB11168


On 2025/7/5 15:39, Han Gao wrote:
> Sophgo SG2042_EVB_V2.0 [1] is a prototype development board based on SG2042
>
> Currently supports serial port, sdcard/emmc, pwm, fan speed control.
>
> Link: https://github.com/sophgo/sophgo-hardware/tree/master/SG2042/SG2042-x4-EVB [1]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Just note that the patch for ethernet support has not yet been upstreamed.

> ---
>   arch/riscv/boot/dts/sophgo/Makefile          |   1 +
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts | 233 +++++++++++++++++++
>   2 files changed, 234 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
>
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 6c9b29681cad..6f65526d4193 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -4,4 +4,5 @@ dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano-b.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-evb-v1.dtb
> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-evb-v2.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2044-sophgo-srd3-10.dtb
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
> new file mode 100644
> index 000000000000..46980e41b886
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#include "sg2042.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Sophgo SG2042 EVB V2.0";
> +	compatible = "sophgo,sg2042-evb-v2", "sophgo,sg2042";
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	pwmfan: pwm-fan {
> +		compatible = "pwm-fan";
> +		cooling-levels = <103 128 179 230 255>;
> +		pwms = <&pwm 0 40000 0>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	thermal-zones {
> +		soc-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&mcu 0>;
> +
> +			trips {
> +				soc_active1: soc-active1 {
> +					temperature = <30000>;
> +					hysteresis = <8000>;
> +					type = "active";
> +				};
> +
> +				soc_active2: soc-active2 {
> +					temperature = <58000>;
> +					hysteresis = <12000>;
> +					type = "active";
> +				};
> +
> +				soc_active3: soc-active3 {
> +					temperature = <70000>;
> +					hysteresis = <10000>;
> +					type = "active";
> +				};
> +
> +				soc_hot: soc-hot {
> +					temperature = <80000>;
> +					hysteresis = <5000>;
> +					type = "hot";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&soc_active1>;
> +					cooling-device = <&pwmfan 0 1>;
> +				};
> +
> +				map1 {
> +					trip = <&soc_active2>;
> +					cooling-device = <&pwmfan 1 2>;
> +				};
> +
> +				map2 {
> +					trip = <&soc_active3>;
> +					cooling-device = <&pwmfan 2 3>;
> +				};
> +
> +				map3 {
> +					trip = <&soc_hot>;
> +					cooling-device = <&pwmfan 3 4>;
> +				};
> +			};
> +		};
> +
> +		board-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&mcu 1>;
> +
> +			trips {
> +				board_active: board-active {
> +					temperature = <75000>;
> +					hysteresis = <8000>;
> +					type = "active";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map4 {
> +					trip = <&board_active>;
> +					cooling-device = <&pwmfan 3 4>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&cgi_main {
> +	clock-frequency = <25000000>;
> +};
> +
> +&cgi_dpll0 {
> +	clock-frequency = <25000000>;
> +};
> +
> +&cgi_dpll1 {
> +	clock-frequency = <25000000>;
> +};
> +
> +&emmc {
> +	pinctrl-0 = <&emmc_cfg>;
> +	pinctrl-names = "default";
> +	bus-width = <4>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	wp-inverted;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-0 = <&i2c1_cfg>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mcu: syscon@17 {
> +		compatible = "sophgo,sg2042-hwmon-mcu";
> +		reg = <0x17>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +};
> +
> +&gmac0 {
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +
> +	mdio {
> +		phy0: phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			reset-gpios = <&port0a 27 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <100000>;
> +			reset-deassert-us = <100000>;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	emmc_cfg: sdhci-emmc-cfg {
> +		sdhci-emmc-wp-pins {
> +			pinmux = <PINMUX(PIN_EMMC_WP, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +
> +		sdhci-emmc-cd-pins {
> +			pinmux = <PINMUX(PIN_EMMC_CD, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +
> +		sdhci-emmc-rst-pwr-pins {
> +			pinmux = <PINMUX(PIN_EMMC_RST, 0)>,
> +				 <PINMUX(PIN_EMMC_PWR_EN, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +	};
> +
> +	i2c1_cfg: i2c1-cfg {
> +		i2c1-pins {
> +			pinmux = <PINMUX(PIN_IIC1_SDA, 0)>,
> +				 <PINMUX(PIN_IIC1_SCL, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +	};
> +
> +	sd_cfg: sdhci-sd-cfg {
> +		sdhci-sd-cd-wp-pins {
> +			pinmux = <PINMUX(PIN_SDIO_CD, 0)>,
> +				 <PINMUX(PIN_SDIO_WP, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +
> +		sdhci-sd-rst-pwr-pins {
> +			pinmux = <PINMUX(PIN_SDIO_RST, 0)>,
> +				 <PINMUX(PIN_SDIO_PWR_EN, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +	};
> +
> +	uart0_cfg: uart0-cfg {
> +		uart0-rx-pins {
> +			pinmux = <PINMUX(PIN_UART0_TX, 0)>,
> +				 <PINMUX(PIN_UART0_RX, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +	};
> +};
> +
> +&sd {
> +	pinctrl-0 = <&sd_cfg>;
> +	pinctrl-names = "default";
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	wp-inverted;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_cfg>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};

