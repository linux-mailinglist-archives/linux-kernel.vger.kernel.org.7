Return-Path: <linux-kernel+bounces-899754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51EC58C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5111366D68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E87E3587AE;
	Thu, 13 Nov 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b="HYu/kwwG"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023135.outbound.protection.outlook.com [40.107.159.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651D3587A3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050056; cv=fail; b=Ou2ZtNFPhtHM6uD6hTBqKEZW6424gJdNJhKYq84RpI0T7lpk4HdhYlj96sTQ1aTvRRk9SynsFeviufHyNnyYwzuP2XSX9Skx5EGOHh3TJwfL9jJbmegStBQPcB8Qb8//avnaguwnHpGpC2LLxliF1UuUUVndkRyt8zrAx9XwVHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050056; c=relaxed/simple;
	bh=09MgEBwot2K09LDQir5fDKywQEMix7Ce3URg8Bvl4EA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dC0ypLe8JTc2ia3wLAajGNHDbNqPHloGF5CVsmY7pMWPlyjvkDvlGveMms1+Wp/VvSFE9msBD2ZooHZjm+N2KGhxJGmq51o3W9LkAAP1/LbTQT8yS7Tr0DPk3ypGkfqgDyuIe132z3nOs2+et49C0onVoNgiXz4rMzqF01zt+BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com; spf=pass smtp.mailfrom=htecgroup.com; dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b=HYu/kwwG; arc=fail smtp.client-ip=40.107.159.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=two9KFNL5yDLysbKpKOIH13BcedH8CiTkFT3xzP1akvOt4YeOzNS1/eFF04zQLVi44WzCeZisSCH/r0X9zgBFKc/V8klUBmho6/j1NPd0SeQyMOLC6+f8dYjciTO9Krar6UNSdCWaSdLJMIhlNYGIx93UaAinL1o0hUocY27wbStEcykhsPvnwUAiNVWhRe/1Z9MzR3MBoDRj43RXCvZnqr5r+v1VIPDQ+8T2vtnN3g/LbrA8aBZGiNoQdciKBycDAm/Ck2F2UvSoc3xqlgAtqgEd039ifVwE+xg/Sav2e5wOgTjrpd5WimZb/VHj+uX7//QkIjn2HVo/sX6yFJX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09MgEBwot2K09LDQir5fDKywQEMix7Ce3URg8Bvl4EA=;
 b=ZDzXLFt5AckWsSow/11pkHgM3Gf98/0iKpeUoEekQSNd+TYsh7vXN0yMxRCmrF0lIY/IpxBdFRJSOrmDePsCLf37M2iC2SjYztk8WuzPzhbbSupML5nsFwDeD/bwZyY/FCenTjpfghyB+/+xpamG4Tucbbc7HSkiCn2/h5Wkj/03sMPrh04KXQSAiDEPzFLDU5kh4/az6fupD0/KXo9JYeEuI9zYD9pEckRDznMCWjpLq2zcjtBZKqrLpgrRHEO/EaA/g+9K8/zIH2MAZ0WJ3h44sX1jzoMiwZVMs+n5fL11zKy1NMjR/A/CVwVYfZ6H4iHU2EpnC/RsGPBm4huzSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09MgEBwot2K09LDQir5fDKywQEMix7Ce3URg8Bvl4EA=;
 b=HYu/kwwGVLlPTYSfqUKujz7d1wAGbhuadMgCtEldfLcCHJPuIvbixFxBRAN87H91t5ug+65U7wx4za6BbAOxfC//fAxkERXgwZKgvm2D/aoxkbXSdvStjmizNmUfmoUcuCdGRrvyF8heuSRRp2L7ce9klASXAiDNsgispIfXo9X6orZgcx1+F0gPBx2+KdZHjPTR/u62mlifGiPR+HPxv13UGVhRh9gW17QOeKToRnrIbOqaUWcFFKUVIGtJPar8VdHJwcjfltoYayY5RbAJQr0bquv4558hE5qE/5lVNBgThYFC1ejECAo67ZOiVxo9Wpy1ikBun0u4OWg3P9X5QA==
Received: from AS4PR09MB5681.eurprd09.prod.outlook.com (2603:10a6:20b:4fc::5)
 by GV1PR09MB7472.eurprd09.prod.outlook.com (2603:10a6:150:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 13 Nov
 2025 16:07:30 +0000
Received: from AS4PR09MB5681.eurprd09.prod.outlook.com
 ([fe80::8d2b:5798:928f:9faa]) by AS4PR09MB5681.eurprd09.prod.outlook.com
 ([fe80::8d2b:5798:928f:9faa%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:07:30 +0000
From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
To: "conor.dooley@microchip.com" <conor.dooley@microchip.com>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Aleksa Paunovic
	<aleksa.paunovic@htecgroup.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "cfu@wavecomp.com"
	<cfu@wavecomp.com>, "conor@kernel.org" <conor@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>
Subject: Re: [PATCH] riscv: Update MIPS vendor id to 0x127.
Thread-Topic: [PATCH] riscv: Update MIPS vendor id to 0x127.
Thread-Index:
 AQHcTNNlUqzeKAlBlk2IdkuCz3mYBrThgu8AgADmswCAABekgIAADYIAgAAAvQCADkXUAA==
Date: Thu, 13 Nov 2025 16:07:29 +0000
Message-ID: <8ccb619c-69ba-4a53-9d47-15f276d64f9f@htecgroup.com>
References: <20251104-reclining-eskimo-9ab425c708d3@wendy>
In-Reply-To: <20251104-reclining-eskimo-9ab425c708d3@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB5681:EE_|GV1PR09MB7472:EE_
x-ms-office365-filtering-correlation-id: c93eb2c6-3781-4889-6c44-08de22cebf53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHVsbGZaQzhVbEhnM1Q3cHV3bHBxUFJOMDF4ZnZiWitydnVwVVlQUlhvR1dr?=
 =?utf-8?B?RHI1eXdOajMrZEd6WWp4TEpiVTMwYVNyUlFXZmJGKzlBNU1wa0xNN2Q5TVhP?=
 =?utf-8?B?Q0JKcU9oMDRocjQxVTBYTkg4VWc1ek8yYXBOZmp3dEVTMmlhNFBLci9TcWpo?=
 =?utf-8?B?UVBKTlRZbjN4RXdFN1F2NEVBSFppVTlxNnVHTEw2RnlZVlI2MnlPVnc4M2F3?=
 =?utf-8?B?b3l4eUtxMGVhTWJwR2lmNnFLbm1iaTlGN09pbGpRYm9jZXJ1Z0RaYXZvQWwz?=
 =?utf-8?B?N1hBZjc4azFTNWsrd1NSQyt4Mzk3TXdkY0dMYmY1cmdNM3pnWVByOHFjUmFr?=
 =?utf-8?B?UVBMMG8zaWE2QmM5MWFKQ095bFFkamI3eDdoOEQrTndJK0U4ekFWRHdJMno0?=
 =?utf-8?B?aitRcU9NcFVHOWZwRTRIbEovbzlRYUEyMFFFSm9YWWRDL0hiU2RMYmtDWExR?=
 =?utf-8?B?K0RuMEYrbFJpSytBdU40Wm5PQktjMlNjRnRkWTZrOC9KcjZXMW9VS3lwQ3pF?=
 =?utf-8?B?MjJZMlhmdkJ6N2NDbzFGWjR6ak5OanV4ZzBpaW90MFcxTlE0V3J3elpkYTB3?=
 =?utf-8?B?R3lNRDQ3YXdYRUhvRXNjNFBGd2kvZGlMMlVHRFp1d25jdmF0d09qUzFTYUVl?=
 =?utf-8?B?YzBWbmNydHJSYVE5eWdaN0hWM2xCNVZXY3R1WEMxVG1aOVl5RmJ3bTJTeE1S?=
 =?utf-8?B?bGF5NWQrWURiUkkvZFZuY1c2U0x3ejhZcDlHNzhheTR4VjF3VFZ2RmNLbzV2?=
 =?utf-8?B?RXBHRUx6bDdHQlRTQ1NHcE92dkZhNURXbndHQm1XYXFKVzZQTE9Sb2VVMXF1?=
 =?utf-8?B?dHd1aFgwcWI2ME1jVmVsN1Q1YlZGZlU2MDBjR2FySHo0ZmZ2RDYvZHBieGhR?=
 =?utf-8?B?amdQQUtWc0lYYU9VSWNBNTVQZFhSeVFYRUJKcmFQOWp1TmFNczRnSGVlcWFj?=
 =?utf-8?B?TGExWlp1eEtUNEQ5MkVMZkVoQnJaTjJmTEJQZ2VETy9PVkRpUndrR2tHNFp3?=
 =?utf-8?B?UXRXM2wvSXl6c3V0VWZRd1NabHNneTVzWVJzOTNyc2twVWp5eElUOUFYZnFT?=
 =?utf-8?B?dURXbi9nazZ4dFYraDRjY0h1c2llZUw1N0NEMENKcGtnaldKeHhhSDc5emFz?=
 =?utf-8?B?SzlVS3NVekNaZlArMkVyVGFxVkRuTTRuRVQzVUdCcnNFNmZVaVUwL2FjWEph?=
 =?utf-8?B?dnZ0ZDhZNkxZTm9uSjFwYm1kaFVlekdjM0xFclFiWnYwVFNnOHd0VWlaR2gy?=
 =?utf-8?B?VTFhUVZDVUhBU21acVF4QXFGaUlqazNWMy9jQXowci90NFJkbzR0RzR2U3dw?=
 =?utf-8?B?N1JkWGc1d2xGTk9Mbm5nSGluS1RXRzJVaHFucUQxWDNpVFhsOHlJSkplQUFl?=
 =?utf-8?B?OFUzWENFWFVpWnhhTzRsRmVoc0JwSWRTRzVtU0VTbGRVWXlqZTNqb1pKWEZ2?=
 =?utf-8?B?QTV6aDRnZU12TUhFNVpzKzVCSnJ6WFNpaFdmdmxxMjB2U0NWSnVzLzBoUXVU?=
 =?utf-8?B?QW5SdVhVV3pSUm5ZdVdrRVZsWlVCSU0ya0xUOGhnWTlGVWxDTzhQYktObUZm?=
 =?utf-8?B?MHlIa1FZdVV5SklnV1NoYURGb285c0lBbmlOdnI2WEwyRkI2UlY0Nk10WDRG?=
 =?utf-8?B?M3Y4NHhXNXcvMStWaktIMHlPUmppSi9lbFcvek41dkI3OEdGTzN4RUM5aEpI?=
 =?utf-8?B?WVh3cG1ENjFESmNNbEthYVU2S0NVd1ZBUWs2VllWZUhzUXRhR1A0SFZ4WllQ?=
 =?utf-8?B?TnZTSFVmd01OdDdobDdWS1NmTklzd3F6Qm5mZVhhdjVFaEJwSVZHY1pjYkNZ?=
 =?utf-8?B?RWYzeGlTN1lmV0V5VGxNdE9CaStXWUZVdGlZUDRKYXpnc3ZQV0p1ZEhxbDlj?=
 =?utf-8?B?bDEzUk1aVjgzTnBSZ0NkajZKSW0ramFPS1FKeFJVbjU3K0d0R3lBTVlDa2pL?=
 =?utf-8?B?VitQMnBxZ0paRGgwMjk5TG1GdHhRMkdSTGpwV0RmK0hzcUtSTmtOMmp2NUpS?=
 =?utf-8?B?SXpWMFZoWVpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR09MB5681.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2wyUHo1OEUrOVFjVUhGaUVRbUNRcXQrTmRTZ0J2YTZvUEhQeW9tNm1RNktm?=
 =?utf-8?B?c21ET3hXYTgxM0srVzRlMGZQNGh3N04zK3RwTFJnOGNlbGJCcHlLMTl3SnJQ?=
 =?utf-8?B?NUJHTVVyOFRoREVoTnp1VVFMWUNBcDBvNnoxbDhDRzVlZVBUNFNWUHVVd3l0?=
 =?utf-8?B?UjZLck1vMXN6MkJCMXowMGp6WUcrazgxVU94L290WStZSnNwU3VxNDNjcTJ4?=
 =?utf-8?B?b0xFVkNtUzBuOW9qaEloNmYvditiN2ZLam1NOGlrVUVsay9aZ0VsWEozb3Q2?=
 =?utf-8?B?c2RSZFBCT2lBNnhheUpNM2QwVTJEcEZYWlloVDJDRGRMa1FLWjVBSmgyZHBv?=
 =?utf-8?B?S2Q2emRpY0pJMW1Pb2JON0RwMXdZY2FNNXVGOEplWXZ1NDVHOUgxSnpaSXU3?=
 =?utf-8?B?YzhkYUpyR0NMTXM4YzJEa3F5ZWhLRExiNUEyZWtzbG1SNzFjMTlLNmN0cVpD?=
 =?utf-8?B?UnJIdWxsN3JVaXNNOE9WQUoyNWFNSjRQVGx4WjVYSHd0K3VTcVB0K01SNVNT?=
 =?utf-8?B?V0NUV1NUd3RJNWY3UnowbDdiSnMrWkJ3WnhpUUZ5MGtCR2xHZnVsTkg5ZjJ3?=
 =?utf-8?B?YVBUU1pjaHlCWCt2NzcraUlXSE5GQTl1V1VQaWxhOHhucC9YSllqdy9LeE5H?=
 =?utf-8?B?Wi9kQlluMTlMd2hXUjVJQ2JLRVJaTnE1Rjg3eXNiTC9CU3V1VWVIZVVDTGRn?=
 =?utf-8?B?V0ROM2g5R2dRUjRnZExWQTFRNXlJdmV2YWRraVo2Y0pDVG05RTY4bTFEbE5L?=
 =?utf-8?B?WmlZbmhJbmFtbXFpczRRM1J3eVdZbnhINUxNVHhkaWt2Si9Zc2NqL2NrQUM3?=
 =?utf-8?B?eWplOUhMdW9XRlBmVzFQZ25laEF3N28yYzg1MHhvYzhGN2lwNHl5NysvZXB2?=
 =?utf-8?B?eGZha2pmOTR5VUx3dU1MVWFSMzFzclF2aElCVHZPdkViSFNJbEJFRTJUaU50?=
 =?utf-8?B?UE9wS0hHcUZlNHRBQVhwRzV4SVVQUTZ0TUV1NXdrdUhEeGVxNUl0TnM2Rzgz?=
 =?utf-8?B?Wlg1akZFQ1dxeDFrK2hDdStLNSt2SHYrajNFOERTQWZ1VzR2OEN5RDZncTZF?=
 =?utf-8?B?VzRHRTMvRkJRWW8xOU5MK1RtMzlQcjBiVkhoN1ZMM01VTVRCZWUwVS9VU0Zv?=
 =?utf-8?B?T3FtZGdxTjZ1Y3Jud1lMdldFSlZFRHBpaW5zK0puelRzMDBOY1lncVdUbGU2?=
 =?utf-8?B?SDF3UWw5UjVCVWtQNm1JOCtEaWl0cUpxTUtsUWhjaE9rUGdmM3RFR0c0T2tn?=
 =?utf-8?B?cndoOU00dUFlbC9oTEVTQnhkN3Z0VEo1eXRSTFRYNjc5YldGU1A1QWdMTERK?=
 =?utf-8?B?bW1qWVpGSjdaUTcvUW1YMVpKNVgycHdVcW54MzJvQTcrM21LMmRtcDR2SlVi?=
 =?utf-8?B?cmpQcWl2bldNV2MvYWNGWkJ1OGNzWU5rRDhBblpZTHJORHphdzdpNjR4MTNn?=
 =?utf-8?B?emEydURIQXY0NHZydkdnUlJrS1F1bE5FcGpDT0IvMkRyNk1qcmxlMFVXTFp6?=
 =?utf-8?B?WEhFaUpBUEtqcGFacWR3NmgwSFRKc0NRNGFyc2xCWGRjbytPVWVrUktTVlcx?=
 =?utf-8?B?QU5yYzNicUdBUW9tc21HR3RaKzMrNStnVlJPR3E2SDhOcXB0WGZZTWl2aVlp?=
 =?utf-8?B?Z0F0ajlKK2N0K1BGQmtHZGNrczRtYU5vNHhhUVZFc1NKcmFIMUEzaFhxYUda?=
 =?utf-8?B?WkxuekRXQklPdnN6aWJMeU9JaHRRZHpnTllnbVFkNzNTOHJwTG5NRUFNMFpr?=
 =?utf-8?B?VlpNbE0wSEhXUzhwdzRPejAvRUthVGxHcThsT1NLLy9NdktsbWtVMzB6TWhu?=
 =?utf-8?B?c0Z1ZW9HRE9XbWNEYis2TUpEcDgyclplTHczMWVuRURPRmYrT041U28yWlhl?=
 =?utf-8?B?byttWXJnQnVwQjUwdkxPbkIzUFA4cmZ1NFhwNmVkbktoaVpwekcySFhMWEVv?=
 =?utf-8?B?SW81UlBQWkNEOTQrYmtwSGduSktVSWcwZWRMUkM0Z2FreUNsSXMzVjBtTnQz?=
 =?utf-8?B?QWZDbVN5UERSNjg5TWYwVWdHWVdGZmthMFBubHViRDd5QTQzZFA1VHJWUzZ5?=
 =?utf-8?B?QlQ5ZDNVS28yUDJoc1ZzdVd6NDQyNUNSRXRhdmU1Z2tMVmJkY1d6QU8zRkFh?=
 =?utf-8?B?OUtoa3dxdDBsSmpuVHdXMVRlTk9SbmJxV25ZcFl2ZWoxM2lUdWVBdm1Vb1lU?=
 =?utf-8?Q?7o+QCqFhcrazQ+wqKEOx60U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B68035F96AB864C9944D6E4DE80A2E3@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB5681.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93eb2c6-3781-4889-6c44-08de22cebf53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 16:07:30.1295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+ogQI3BmHuUJEgE+e3cE+hH4vgE9vlL6qryIVfKwf2MuSkfrsG69cJ0ajhw0xpTmYsqVFZzJTArQTLwEsaGDByHZ8bw1aiFYLpylTIK/fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR09MB7472

T24gMTEvNC8yNSAxNTowOSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAwNCwg
MjAyNSBhdCAwMjowNjozMVBNICswMDAwLCBBbGVrc2EgUGF1bm92aWMgd3JvdGU6DQo+PiBPbiAx
MS80LzI1IDE0OjE4LCBDb25vciBEb29sZXkgd3JvdGU6DQo+Pg0KPj4+IE9uIFR1ZSwgTm92IDA0
LCAyMDI1IGF0IDExOjUzOjQ5QU0gKzAwMDAsIEFsZWtzYSBQYXVub3ZpYyB3cm90ZToNCj4+Pj4g
T24gMTEvMy8yNSAyMzowNywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+Pj4gT24gTW9uLCBOb3Yg
MDMsIDIwMjUgYXQgMDQ6MDU6NDhQTSArMDEwMCwgQWxla3NhIFBhdW5vdmljIHdyb3RlOg0KPj4+
Pj4+IEZyb206IENoYW8teWluZyBGdSA8Y2Z1QHdhdmVjb21wLmNvbT4NCj4gV2hpbGUgSSBhbSBo
ZXJlLCB5b3UgaGF2ZSBhIEZyb206IGhlYWRlciB3aXRoIENoYW8teWluZyBpdCBpdCwgYnV0IHRo
ZQ0KPiBwYXRjaCBoYXMgbm90IGJlZW4gc2lnbmVkIG9mZiBieSB0aGVtLg0KPg0KPj4+Pj4+IFsx
XSBkZWZpbmVzIE1JUFMgdmVuZG9yIGlkIGFzIDB4MTI3Lg0KPj4+Pj4+DQo+Pj4+Pj4gWzFdIGh0
dHBzOi8vbWlwcy5jb20vd3AtY29udGVudC91cGxvYWRzLzIwMjUvMDYvUDg3MDBfUHJvZ3JhbW1l
cnNfUmVmZXJlbmNlX01hbnVhbF9SZXYxLjg0XzUtMzEtMjAyNS5wZGYNCj4+Pj4+Pg0KPj4+Pj4+
IEZpeGVzOiBhOGZlZDFiYzAzYWNlMjc5MDIzMzhlNGYwZDMxODMzNTg4M2FjODQ3ICgicmlzY3Y6
IEFkZCB4bWlwc2V4ZWN0bCBhcyBhIHZlbmRvciBleHRlbnNpb24iKQ0KPj4+Pj4gSW5jb3JyZWN0
IGZvcm1hdCBmb3IgZml4ZXMgdGFncyENCj4+Pj4gV2lsbCBmaXggdGhhdCBpbiB2Mi4NCj4+Pj4N
Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2EgUGF1bm92aWMgPGFsZWtzYS5wYXVub3ZpY0Bo
dGVjZ3JvdXAuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L3ZlbmRvcmlkX2xpc3QuaCB8IDIgKy0NCj4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS92ZW5kb3JpZF9saXN0LmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L3ZlbmRvcmlkX2xpc3QuaA0KPj4+Pj4+IGluZGV4IDNiMDk4NzRkN2E2ZGZiOGY4YWE0NWIwYmU0
MWMyMDcxMWQ1MzllNzguLjU1MjA1Zjc5MzgwNTViYTJiNzQ0ZGJhNTExOGJiYTkzNWJjYWMwMDgg
MTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS92ZW5kb3JpZF9saXN0
LmgNCj4+Pj4+PiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3ZlbmRvcmlkX2xpc3QuaA0K
Pj4+Pj4+IEBAIC05LDYgKzksNiBAQA0KPj4+Pj4+ICAjZGVmaW5lIE1JQ1JPQ0hJUF9WRU5ET1Jf
SUQJMHgwMjkNCj4+Pj4+PiAgI2RlZmluZSBTSUZJVkVfVkVORE9SX0lECTB4NDg5DQo+Pj4+Pj4g
ICNkZWZpbmUgVEhFQURfVkVORE9SX0lECQkweDViNw0KPj4+Pj4+IC0jZGVmaW5lIE1JUFNfVkVO
RE9SX0lECQkweDcyMg0KPj4+Pj4+ICsjZGVmaW5lIE1JUFNfVkVORE9SX0lECQkweDEyNw0KPj4+
Pj4gSG93IHdhcyB0aGlzIGV2ZXIgd3Jvbmc/IERvIGRldmljZXMgZXhpc3Qgd2l0aCB0aGlzIG9s
ZCBJRD8gRG8gd2UgbmVlZA0KPj4+Pj4gdG8gc3VwcG9ydCBib3RoIGFzIHZlbmRvciBJRHMgZm9y
IE1JUFM/DQo+Pj4+IEknbSBub3Qgc3VyZSBob3cgaXQgZmlyc3Qgc3RhcnRlZCwgYnV0IHNpbmNl
IHdlIHdvcmtlZCBvbiBxZW11IGFzIHdlbGwsIHdlIG5ldmVyIG5vdGljZWQgYW55IGlzc3VlcyB3
aGlsZSB0ZXN0aW5nLsKgDQo+Pj4+IEl0IHNob3VsZG4ndCBjYXVzZSBhbnkgcHJvYmxlbXMgaW4g
dGhlIGZ1dHVyZSB0aG91Z2guDQo+Pj4gU28gYWxsIHRoZSBoYXJkd2FyZSB1c2VzIHRoZSAweDEy
NyBpZD8gV2hlcmUgZGlkIDB4NzIyIGNvbWUgZnJvbT8NCj4+PiBJIHJlY2FsbCBxZW11IGRlZmF1
bHRzIHRvIDB4MCwgc28gd2VyZSBub25lIG9mIHRoZSBtaXBzIGNvZGUgcGF0aHMNCj4+PiB0ZXN0
ZWQsIG9yIHdlcmUgdGhleSB0ZXN0ZWQgd2l0aCBhIHFlbXUgbW9kaWZpZWQgdG8gdXNlIDB4NzIy
Pw0KPj4NCj4+IFRoYXQgaXMgY29ycmVjdCwgYWxsIGhhcmR3YXJlIHVzZXMgdGhlIDB4MTI3IGlk
LsKgDQo+Pg0KPj4gSSdtIG5vdCBzdXJlIHdoZXJlIHdlIGdvdCAweDcyMiBmcm9tIC0gcGVyaGFw
cyBJIG9yIHNvbWVvbmUgZWxzZSBtaXNyZWFkIHRoZSB2YWx1ZcKgDQo+Pg0KPj4gKDB4MjcgYW5k
IDB4MiBhcmUgYm90aCBtZW50aW9uZWQgaW4gdGhlIFByb2dyYW1tZXIncyBHdWlkZSBtdmVuZG9y
aWQgYml0IGRlc2NyaXB0aW9ucykuDQo+Pg0KPj4NCj4+IEV2ZXJ5dGhpbmcgd2FzIHRlc3RlZCB3
aXRoIHFlbXUgbW9kaWZpZWQgdG8gdXNlIDB4NzIyLiBQbGVhc2Ugc2VlIFsxXSwgZm9yIGV4YW1w
bGUuDQo+Pg0KPj4NCj4+IFsxXSBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNTA3MTcwOTM4
MzMuNDAyMjM3LTEtZGpvcmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbS8yMDI1MDcxNzA5Mzgz
My40MDIyMzctNC1kam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tLw0KPiBPa2F5LCBjb29s
LiBDYW4geW91IHB1dCB0aGlzIGluZm9ybWF0aW9uIGludG8gdGhlIGNvbW1pdCBtZXNzYWdlPyBJ
dA0KPiBzaG91bGQgcmVhbGx5IGV4cGxhaW4gd2hhdCB3ZW50IHdyb25nIGFuZCB3aGF0IGlzIGlt
cGFjdGVkIGJ5IHRoZQ0KPiBjaGFuZ2UuDQpXaWxsIGRvLiBUaGFua3MgYWdhaW4hwqA=

