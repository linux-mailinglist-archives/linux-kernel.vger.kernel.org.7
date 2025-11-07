Return-Path: <linux-kernel+bounces-890487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723CFC402C5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B3C3B95DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3822F546D;
	Fri,  7 Nov 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PtIXN1Ne"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A82F531C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523063; cv=fail; b=OjyLeUOJznJrO1lGR1knicI4L4YKYSi92hBhhyvCwSWanRvtw26RCMMAWsYuNfVBlfVb0rShSS3T75UYX2y6CFwPyjzU7wrhisKq3F2oImZ72lP6r24yhh/0VGgeFqRxeDLpigdpSeIEq0MH9I9iZzA/8Hz74eglzzMIg7DBhRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523063; c=relaxed/simple;
	bh=jeAmo6WLw0EK6MNRRtvKEebkEwhbF7BwL25Z9h+vpHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dDMervkTpr2bnfBOD95ud9GouvF2Xbh1pEusa4nKbNVgR9HNKW7kMinpwssGV8mbjbtwF9eZJm1m+CyVWBXoCG73doq+CoMdrulQxIz8xXCfTc1fsRBt3DXfOQSYVPaBWQhBy5qz4IKFP2DLrk27DGU94/NsR6ui3E0cX8A7Fns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PtIXN1Ne; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3kf0FnbyBKfwkaLT1ApC2U6UmvQPRPi4kHEH/6l5hnn84rWRgkKhhc9eRVkCQ/T/WR6cCDiZ39NwijEofppR/M1xhvCx2YCP19gMopNkl7Tl/IT1DwMqzyakDYXR9S3iq96sCJKUkV3wtEL15giVaXRqaY0arxoGZabBObNGgWYityU5ncfS+Qts1bHPw3OeMKSP7OMO4h1sZjF5sIX/bpud1NlgHzFwr/4iz5rgHmI0aNnKm4UJ8uzlEMFZHVMDgSPXK6ECW0WoAouVGHFN3g4Hu/kIYgD/Lz3ImJj3vb2n2kJPfZbh1b9U7fqQl1HjvZzdxh8VuWIqq5e2NedbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeAmo6WLw0EK6MNRRtvKEebkEwhbF7BwL25Z9h+vpHE=;
 b=RYi0cdzt0koE6+7Hgu3oWroVEmAYyw09buCg6nIuSJRh2SiOo23yxg7TG/iFsWpzko1Bx7QtFON5SgnW7le3M5YQtTooNjGUgaL02gjEGblKcgvKEPrTL51WoAcz+flKvxMiRyHu7uQvXLGoTAM/uCnfkUiGMsxMpKr+Eg9M9VuCUZMVuXUfJY6WLvhcy+sGgKpEnKDnu3lDeWK7YFaI7qYhtcS/HEcQfiyudDXZSNdXRQ1yp6hMBvmVhk8wJ5prI0Z0fR3nhbgE/e8sFkW02g48OWEJidgE4+4GEdifj7+1wyVhuuZnBG+E83g7As7pVPtldABpGBFBLRrdhoDNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeAmo6WLw0EK6MNRRtvKEebkEwhbF7BwL25Z9h+vpHE=;
 b=PtIXN1NeR4mddW3MG0cwzSeFvztXJCJ/pc61VSqHavRk31uqyhnv6+kat5zWC+hsqDqE7y9ng8+YIMRNeA7aQBOw7rBRVFYEbdh6hSrdFOWuERFPoQFYUva4R1bi6c24P+XpEddTdVTv/UOnIaHl8wNlEG/ybXXIdBmc5iNnLEllzoXiQO9Pj17i9pITt9aHSX/cXyVdBSSl/7YOLrkKJQ8hgLQRac+nRSKfgxpWXtqxmNGI+7nNqLQZx1TSVUGYsLs7k4+sVanZGtUb/POdt15P0dejGjTFv9EIcFTz2iuTY3gH1WG/AWw3kn2PwHEzQV0AqL3b4xv5Y+K8tYHmlg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7467.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 13:44:17 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Fri, 7 Nov 2025
 13:44:17 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "arnd@arndb.de"
	<arnd@arndb.de>
CC: "hui.wang@canonical.com" <hui.wang@canonical.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Topic: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Index:
 AQHb66DA/2ST5DqqmUGvisuiiSELdrTh5/AAgAICrICAAIdYAIADcAkAgAAV6YCAAAoQAA==
Date: Fri, 7 Nov 2025 13:44:17 +0000
Message-ID: <b0028d72d839e4053e1493f02dd4197cf5005c91.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
	 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
	 <2025110513-manliness-repayment-d005@gregkh>
	 <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
	 <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
	 <3e265b9e-c0f4-452d-b1da-3c708517e30a@app.fastmail.com>
In-Reply-To: <3e265b9e-c0f4-452d-b1da-3c708517e30a@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7467:EE_
x-ms-office365-filtering-correlation-id: 8c60fc16-2d7b-4997-ddc8-08de1e03bf0c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmFzMWxNU0tRSDIwSFV3Z1NzSklwZUFoaDZ3WmdRK3NLME9sZ3dCaWhQOU9r?=
 =?utf-8?B?YjV6SVJndXNKM1hpc3VYQlh0aE54UG9oalpIZFRMN1Y4WldqUW1vSG9XTmxo?=
 =?utf-8?B?Y21SbUdrUktZQVJZckRzWEtONlVGZERZMGR0MnRqdzhyNE13OEtzMlpHdzhN?=
 =?utf-8?B?dlNaOENDbGU3NEFXTEJrTW0yamNMazdVNGg3eld2MHMrMVJ1SVVyeTB3L2RL?=
 =?utf-8?B?YnVHcVh6WTVrUHhoRUNub001YlBiRUpWbzBLT1BoNVQ4VmxxMlYwRkNSVGRh?=
 =?utf-8?B?dmgwVWVwaWhTRlNSTTU2WWhLVGR4anRjQTh0TUZWOGF2Qzdrc3Rwa3VmMjZE?=
 =?utf-8?B?dWVpaVpCMzhDS1RiM2VPV2syU0Nob2dhckN4NEpIejBMOU1BeDNMN0t6c1BG?=
 =?utf-8?B?UzhXVTdZRk42akJLVXVvN0tyUDkyOXlQV3BQbDhZWTFsWVlOay81K09VWkM3?=
 =?utf-8?B?M3lMMDREUzM3UXhrTldrV2ZxUmtDT3M5YjBVbFBpNXl2eDJ6Tm53azdRZy9n?=
 =?utf-8?B?OWs3aWFVSUJDSS9VVlZhMVpsMmZkSkdFb1E5QWZiTmtxV21sNHVUYVI0Q0x5?=
 =?utf-8?B?enk2Ly9tbzQvRVA0Z0h3REh3VzB2NEVad1lQSVBVZ3QvRWNDWWxlTTlRSy9E?=
 =?utf-8?B?WVJ0M1RlMUE5QWlidDAzc3d5ZGFGbFd1Q3lmSGhtUk1Oc21od3owSU5pWGth?=
 =?utf-8?B?NFpwdGx6VFljQTJtbWhCdFFwLy95LzgvNldEdTZKdk9pcm04VzU1UElWaUQ2?=
 =?utf-8?B?ajhLeVNtWXE2Z1RSamJFbTd1Zk9pNk0vNW5iUzVQY1kzcnhSNndtbXAzQ1RU?=
 =?utf-8?B?QUdRYzVyeHZlTGQyNEI5SDRYK0FHQkcxQnowYjJFb1lnRDl2U0VYY0pEaWNO?=
 =?utf-8?B?dURpMW5NZXNMNVdOTGhnQVB0MDkrWjg1dERIaHBKWlFGTEJBM0tHL3ByMDQ0?=
 =?utf-8?B?Y1lzTDlQa0FmZlVvWlg4VUxPcnFhdFJYWFB3UlFPaXpIREQ4UmdjbEowOU8z?=
 =?utf-8?B?bVB2bFp4N1FSNzNDUnNVYmp5QUtmcnF0bFI4cVdaL09wNXJ2V2NWc1dQL3lN?=
 =?utf-8?B?RVhsNFQ4NmtKUXRUcWR2cmxwRXgxenRZODE5UENSSGhaTTZXazBGNENHS0h4?=
 =?utf-8?B?S2FucEkyVmpQcERGS1I2NSt5SlNoTjR6RENyNlBkZEFqN09QZ1BlaVlHYTNV?=
 =?utf-8?B?bTdmSDIxTmc0R0JlVThZYVNXZElVYlBHdmZieUFQaWczdW9pVWtORHNLN1Zv?=
 =?utf-8?B?WDgwenp6TE5XcTIzZXRtUjk2Wk9TeWpMRUhkbEdEbElBWWl0UHp4U1pMQ0xY?=
 =?utf-8?B?Z3RlcGU2aTcrTXlJT05Zc1pOWlR5TXp0d2xsVE5QbWw0NHE0RjlnMFJHL2pZ?=
 =?utf-8?B?dGQ4SVBYMXhJUjB3bFNZQ0k3Uml2NE82QlZLNmw0a0pZcEVmczdiWEtzbnVa?=
 =?utf-8?B?aWhNengvYnQ2NExVcmUxS0s2TTBzempVYndhMFIyRU1xUXRhUFNlRFJNbXZl?=
 =?utf-8?B?bERxNnVNNHRQL1JMa0JPQnVwTUZ1WXBuSUdCMVI5Z1Z6QmNCSmhQem9yM1Z6?=
 =?utf-8?B?a1g1a3kvd3JrNHZBZjlwakVuQkl0N01lMDcyTkFpN1pJdkcrOHlHREcvODRt?=
 =?utf-8?B?MjlSQW13QlBmSkFLMVJHaTVZcHczcDEvUG5udW81Wm9WaW1ReWxqUmlUQ05U?=
 =?utf-8?B?NFVDMTZhL3NURnRlQ3Z4UHlTRDR1WkQ3MjRrVEIyTkxJUmViK0UxKzg0S284?=
 =?utf-8?B?OUhkdkRUbVI2ZmRTMGU2TVJtT2c2b0RkVFJ2eWtKZmVkdGpvTGMwT2hBNGp3?=
 =?utf-8?B?ZTIwRjQwQjQwYmp6VHdyczl2TEZRb3E0N05aelNPTGRLNktIaEVLa3BUbGM3?=
 =?utf-8?B?aHUzQ01LVHYrUTE1QzFHZ2xVL1U1eTBrOUprTGM0eDhlemRsOW1HWkNabm5y?=
 =?utf-8?B?NVE2ZlZtVHhlajFuUkNSWVBlSTluL1NCcUx4OFQ4SU9tZGlkQU4wYmozNlpQ?=
 =?utf-8?B?RUdlMThVWTBRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZCtiOVEralZSdEVXNEduYlJrNnl4d0R5VTQ0bnIzYVVuaTBnRGxNRjA4c2F5?=
 =?utf-8?B?ZnZzYUFJSnI4MG51MTY1ZDBBSW9yQ01pZWE4MDdJdFNyUGovTHJDMHRjVzVC?=
 =?utf-8?B?RWV0YThycFc4Vnl4dXRtRDFlOXV6QnNyTzFFelhHeXJTZWZyTlYvNVFBK2RN?=
 =?utf-8?B?RmR1S3UvOWdWdG1HUHRQTUs4ZC9nci93cHdQZ2IrdmRlUUt4WUU1MFMxLzdt?=
 =?utf-8?B?cWN3Q0dwb1JVYmNmMjU3RlZtMng3UWxRR1F2Z2JEUDFnRmJKK1pnK3JpRzNk?=
 =?utf-8?B?bzJQcmNhSWtoMGlVcE5JN3VnNmJYMG5sYmpaZG1xL2JLUjNpZGpBVXZJTVhI?=
 =?utf-8?B?V29MZWJrUVIyOUtTZHY3RWk3ZXh1YmJOR3hvUkRDRkE2WUwyRlh4WUNid3VV?=
 =?utf-8?B?UmppWU9zTllWWU5GdzFCQ1FFV1crQzROaDEvL2VLd0l5R0JmR0xDRlYybGhE?=
 =?utf-8?B?LzkzenVVZjRQa2F5emdlTitrck5heHk0Z1JwamdLVWx2UHE4d1Yyb0ExekFo?=
 =?utf-8?B?LzU2ZmZNQWxkNWZtUEsxT1Y2dkxyU1FQNWdBeW5IOGdBYjRkZjlDcm1aSEpu?=
 =?utf-8?B?TVZXd0NBT3g3UFJwTzFaRUQxQUdZblR1WUtXQlN6c1FTU1F4Yi80S0tTUzRZ?=
 =?utf-8?B?NjdMbm1TOEU2NzJnNy9Hb2dWVWQxbzNLOXpaTHZ4eEpReTFnOS8vWUUydVdh?=
 =?utf-8?B?NFRHZDBTRzkxV213bEJ4Sm1adXB0SS9zQkxWY3o4Q2VZUE8xUUpIeVNnN3du?=
 =?utf-8?B?UFp5OElYOU9yTG9MYi9IQ0svMnJaVTV6dzg3aGI2ZGhqdnlzdExTYlFuUEhq?=
 =?utf-8?B?MzlaaHdqVUMzUXg5eVdXR2grN09pNTQ3UnA1TkdLR2phNE5yMWhmQzBUOTFz?=
 =?utf-8?B?cjBSRzlSK21DVWI2VjVUMkxJSWhERUR0eGpuMjNqSjV2Z21UQzdabWJqaUJj?=
 =?utf-8?B?U0tzb21iWjNQTmpnaCtsdzc0SEp6WS8relNwUFF3YW9BU2N6cVZySFpCVStB?=
 =?utf-8?B?TnZQazNJVWVackxRQ3N4S2hZSWhGZWtqeE9ucEIwc0tnajBZYTRTeVNvNitj?=
 =?utf-8?B?cVQ1OWhuMjZpYTlTVTNaa0JSb2tYb1BvQXk5b2VsbzFQNHMrc3dCU3MvTkxl?=
 =?utf-8?B?ZXZjYkdEYUkzWS9yYWw3S05tVHc4cXZlSjNHL1M1L1VGeFBBK3IwelQ4Um9y?=
 =?utf-8?B?MGcwbEtPTlFYVFV2ZlY1eFFUTFE1NUptUlhOZW1NejhoWWpycStOU295YlZ3?=
 =?utf-8?B?WHV2TGRwNHVuRWZEeGowVWVoeE13WlBhU1p2THNXdXI3WEhlbTEyTm5ycUx6?=
 =?utf-8?B?UitDVnByNVo0eHltRXYrSmZIUVYrRSsyb2QxS3ljUVFNSkpCbE9xN29mMlpl?=
 =?utf-8?B?SzFUdER0M0VGeHhKWE1JalZ2eitydVNFM1RsNnpybk1XZ1c0VC9NVUxxdmFm?=
 =?utf-8?B?T2wzZmhNSHg4NHIxTGwxb0ZTMlA4OWhhajNmVGZoVU1wYUFLL3B4U0hqVXVM?=
 =?utf-8?B?YVBZY2hGQzNzNUdZNGwyRGxTK3JqN2k1NEFNVE9aanFJcE9oWGw3OFdlSVIw?=
 =?utf-8?B?Uk5LK05VME9TNlRHRUpka1pFNjVrTnhTL09BcW84ckU4N25MdklIV2hFSGNs?=
 =?utf-8?B?TktUVnRNWGpZbWFjM2ZCZ1dFR0g5ZDNrK1NQQWdycDlxdEpnWW15QUtRdm1D?=
 =?utf-8?B?UFIxY09YaUlzWFo1Y0RFQ0ZUWTBYRHllMHF1UVJVT29KeCtRbUcvcCt6NFQy?=
 =?utf-8?B?b0lFdEp4ZzhteldDUUsvbzBsY3p1Sm1mQkpmZCtuM0RLS0ZyMyttODJBSUs1?=
 =?utf-8?B?YkFsV0xSVThrQkIxVHdyK20zalBrdndTTHJGOWtBMFVxRWFLYWppakRjcDJK?=
 =?utf-8?B?MFJ6U3cxUmdFL1NqbXRnaXlFTWcrbzQ3ckFNQlpSN08xS0doOU5TeEFOZlFK?=
 =?utf-8?B?TU8yWHNrQ2NNbGxPakpldkRaNVE1ZXpsV3RqT1E4Y28zcGNrVWt1bzVGcENK?=
 =?utf-8?B?TjlLYUxtL0JDRlgrdXowVS9vUFRmNWpCbitrTzNGU3RIQ0paMFNXd2FvVE5F?=
 =?utf-8?B?TVRHQUdLR0p6WFNuNHBwUDM0UE5Wb3U1U0s1QjVoQitGMWExWWZsOHUyYWlJ?=
 =?utf-8?B?Y2lVcERaQVV3TzRMNXJxVFlnRmFWUkM0TVBXMndzVWJmV2FTUitwbTBRM0dx?=
 =?utf-8?Q?eXiBuxFKy3rkFh+6AhQjEyg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C73FD1856CBFA409D3FC072D834B203@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c60fc16-2d7b-4997-ddc8-08de1e03bf0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 13:44:17.2102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTO6Ku462K3KW6SZMbqzOt3QeaEdrW0Z2mBUs5oSGg5TcAsyawXXipAQIlXFDJ3JkbGew5kpIYl8fUqnkVpjlDTObc+6rz2vv6zh2b4/XDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7467

SGkgQXJuZCwNCg0KT24gRnJpLCAyMDI1LTExLTA3IGF0IDE0OjA4ICswMTAwLCBBcm5kIEJlcmdt
YW5uIHdyb3RlOg0KPiA+IENocmlzdG9waGUsIHdoaWxlIEknbSB0cnlpbmcgdG8gZ2V0IG15IGhh
bmRzIG9uIGEgUFBDMzIgSFcgc2ltaWxhciB0byANCj4gPiB5b3Vycywgd291bGQNCj4gPiB5b3Ug
YmUgYWJsZSB0byB0ZXN0IHdpdGggQ09ORklHX0RNQV9BUElfREVCVUc9eT8gVGhlIGZhY3QgdGhl
IEtBU0FOIA0KPiA+IGRvZXNuJ3QgZGV0ZWN0DQo+ID4gYW55dGhpbmcgYWZ0ZXIgdGhlIGZpeCB0
byBzcGktZnNsLWNwbSB5b3UndmUgbWVudGlvbmVkIG1ha2VzIG1lIHRoaW5rIA0KPiA+IHRoZSBj
b3JydXB0aW9uDQo+ID4gaXMgZXh0ZXJuYWwgdG8gQ1BVIGNvcmU/IFdpbGwgeW91IHBvc3QgeW91
IGZpeCB0byBmc2wtY3BtIGNvZGU/DQo+IA0KPiBJIGhhZCBhIGxvb2sgb3ZlciB0aGUgcGF0Y2gg
YW5kIGRvbid0IGRpZG4ndCBzZWUgYW55dGhpbmcgZXh0cmENCj4gc3VzcGljaW91cywgYnV0IEkg
d29uZGVyIGlmIHRoaXMgaXMgcG9zc2libHkgYSBwcm9ibGVtIHdpdGggYSBETUENCj4gdG8gc3Rh
Y2ssIGFzIENocmlzdG9waGUgbWVudGlvbmVkIHRoaXMgc2hvd2luZyB1cCBvbiBhIHN5c3RlbSB3
aXRoDQo+IFZNQVBfU1RBQ0s9eS4NCj4gDQo+IElmIGZvciBzb21lIHJlYXNvbiB0aGUgb3JpZ2lu
YWwgZHJpdmVyIHVzZWQgdG8gYm91bmNlIHRoZSBkYXRhIHdoaWxlDQo+IHRoZSBjdXJyZW50IHZl
cnNpb24gYXR0ZW1wdHMgYSBETUEsIHRoYXQgbWF5IGxlYWQgdG8gYXJiaXRyYXJ5DQo+IGRhdGEg
Y29ycnVwdGlvbiBmcm9tIHRoZSBpbnZhbGlkIHZpcnRfdG9fcGh5cyh2bWFsbG9jX3BvaW50ZXIp
DQo+IGNvbnZlcnNpb24uDQoNCkkndmUgdGhvdWdodCBhYm91dCB0aGlzIGFzIHdlbGwsIGJ1dCBp
biBteSBwYXRjaCBJIGFjdHVhbGx5IGFkZA0KYW5kIGFkZGl0aW9uYWwgYm91bmNlIGJ1ZmZlciwg
Y29tcGFyaW5nIHRvIHRoZSBvcmlnaW5hbCBjb2RlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvZDViZTE3N2QtNTA1ZC00ZDcyLTlkMTgtOTEzZTY5YzIzZWE4QGFwcC5mYXN0bWFpbC5j
b20vDQoNCj4gVGhlIG9wcG9zaXRlIG1pZ2h0IGJlIHRydWUgYXMgd2VsbDogaWYgdGhlICd2YWwn
IHBvaW50ZXIgcGFzc2VkDQo+IGludG8gdGhlIHJlYWQvd3JpdGUgZnVuY3Rpb25zIHdhcyBwcmV2
aW91c2x5IGRldGVjdGVkIGFzDQo+IG5lZWRpbmcgYSBib3VuY2UgYnVmZmVyIGRvd24gdGhlIHN0
YWNrIChzcGkgY29yZSBvciBzcGkNCj4gbWFzdGVyIGRyaXZlcikgYnV0IG5vdyB0aGUgYWRkZWQg
J2JvdW5jZScgYWxsb2NhdGlvbiBnZXRzDQo+IHBhc3NlZCBkaXJlY3RseSBpbnRvIGEgZG1hIGVu
Z2luZSwgdGhhdCBtYXkgYWxzbyBmYWlsIGlmIHRoZQ0KPiBHRlBfS0VSTkVMIGFsbG9jYXRpb24g
aXMgbm90IHN1ZmZpY2llbnQgZm9yIHRoZSByYW5nZSBvcg0KPiBhbGlnbm1lbnQgcmVxdWlyZW1l
bnRzIG9mIHRoZSBETUEgbWFzdGVyLg0KPiANCj4gQ2hyaXN0b3BoZSwgZG8geW91IGtub3cgdGhl
IENQTSBETUEgaGFzIGFueSByZXN0cmljdGlvbnMNCj4gdGhlcmUsIGUuZy4gbmVlZGluZyBhIEdG
UF9ETUEgYWxsb2NhdGlvbj8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcN
Cnd3dy5zaWVtZW5zLmNvbQ0K

