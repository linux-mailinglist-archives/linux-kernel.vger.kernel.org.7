Return-Path: <linux-kernel+bounces-894703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C8C4BA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790F13B8A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992612D248C;
	Tue, 11 Nov 2025 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JMA8no41"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097D2D063C;
	Tue, 11 Nov 2025 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842071; cv=fail; b=ncFWk/444Q4ZNVbjezdEaZsNLsDe0KijK5wAxGaUzHpit1QkX/105Zuhq+ZDpAq7m1LWuNwqiUCOCn0OIQxO/JtczBAYeGEkKxyBfbmyyYO/CvAq42K0eOPRmMPgPm/k8DYQ1hXHWBcR0N1oqLNvysCwKBOqdY0mSMZboLfIvHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842071; c=relaxed/simple;
	bh=CRmTqP4tn8LCfGJXK+stLPDHpraUWnGgvlhjwWdh4/U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aDqfIxGuoqUq2UXgK+54XysXN0aCwYnsCJXqB+zgfNqr/x80T4FR1hu0i4UifqFNnnu403tuGquoXX8FJfsvszHgjeObztYW8RHpz5Bi1FE3Up52VnHqRWUgFe7xaxUjqpXWw0KA4b92wWO/7UL2PneaMp6vUV2YRmBDakB/F78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JMA8no41; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzhkUPDXk9RwSrusrHg/JlWt64FpiG5FwY/xoGFvZDN5XOAJbU73mdKvB8HJYwdmz0XegYYIe4Js529AwyVWRVO5YWMjLh67oWXyotHpeEbjN2ATkZcLQUf1Wteb/YOQzvvXbzvhZmy6BfU0J2izQh3JSku37yXJlc3AMh0JTw4Su4P8Zn3tVMCtMxkf3xriomsl35nIYlJN0fwTQ0byndpEEhZWGnfKn9PWRKv4Sw2poj5b5ktHLHP+q22RdFW7+d1jtR1/Mnyv4TEqd9y+w3q17tV3/NaSrU3eOEU2gSfTXnuIlAAERdS+CXYPFvuJkKTcGQ5BGtCVG8qhtZdCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLCC98WSirU+VLuCwCfyq/EDTnTJ1Vor5rx5ljpuh9o=;
 b=vEqqpeVkeSWX9OgUUBHVkBxJZ0WX97fQF9LKNkcgqnjlpznRLsmcb/l1K5L3xhhft1DmOq+cegG244q6UBHEq1ifG4QJrPs9aKVN1d/T0ZdWttbkUIqpUueU0valYms8G4sc7fGXRIBfZufrTOgiCk4I76pSIAq6XaxWA69ad+yvK/PEVRJaucPzegC5IFAdSAshqQGzkM2JZU8M7424SVaTTljULpTKTIsM1FfOKjH+7R0f614Yg7gDubGsz6t1ZM7ADzzDKfc2NdQCVfpaCMokkGZixYIK+mQCun/G7hORkKHsgn5DfG9YH5D6UdIlDDZaKVdjKJk6iTngt3BHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLCC98WSirU+VLuCwCfyq/EDTnTJ1Vor5rx5ljpuh9o=;
 b=JMA8no41MmuzV4ynj7Mhrroj0J4yZ2zjjdo7lgSYlYi/t9pxA2UF5eutT4yjmfRM4zmYsh0qgOAWTSBwhx3azO+gxOlbGfZC3Of+NWhnKQxXdxDXLLS57iN0iPABHVEWUbBUvCwhhOVWWrSbymDLkPsOWr84tD+CQ7gao4Aax2Jqkr14tSVa6snGj6X2+cfCtsorNagc4sx0yww61HW6MdDlUb2ipoICWETl+cubP/5Wz7fLroh4f0+Q48fAXDS/EymiOCN75uvJjebio2pnaN2/NJT6OlX3J2iF2h/fggu1oJLnEvy3ZlQScJBIgjCBE5XpaFWdnsNDFIF8VWUoLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5049.namprd03.prod.outlook.com (2603:10b6:5:1ee::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 06:21:05 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:21:05 +0000
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
Subject: [PATCH 0/4] Add Altera Agilex5 DWC3 support
Date: Tue, 11 Nov 2025 14:18:44 +0800
Message-ID: <cover.1762839776.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
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
X-MS-Office365-Filtering-Correlation-Id: 16c89ab0-9aa8-4c7b-6481-08de20ea7e87
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGJyNzlhWFR6dFlkdFdwenNwdzFUQ1JOaDlLdzJHQ0VUeDFlOXhiMVNOQTN6?=
 =?utf-8?B?eks5c3N0ZHgrUS9HbStYWnlOYzlhNFc3L01DZm5EL0ozdlFqWUdFM1g0cXR2?=
 =?utf-8?B?cTU2a2Z6dlBESnVjNGpKa1hyVmMyQXlCSnU0QUNhUXBzTWYyTnNLQ3ZqeERC?=
 =?utf-8?B?UmJYTVVPM3JjdGlaSVlVaytmTkRKd2JPTVI5b3FlSUpJbG5KVjRVVm50VWRT?=
 =?utf-8?B?NHBjR2E0WTdFRDZEMk1iVUM3NTRZLy8yMnJpQ2RlYXM4VS9tb3dtMGREWVV2?=
 =?utf-8?B?WVUrdTJzOHh0TGpoMUgxVkZQWEtudDBqcFlGRVlFanBHcTZhVVhndXJxQzFj?=
 =?utf-8?B?WnREU0FmUUM5b2pxTk9nd2Q3VHBXSFd3RUFqaHVoaGppVHN5YlViQ2tMMXIz?=
 =?utf-8?B?SHBQZTFYbFJORnA4QXZSZWRGdUQzVXZ2Q2VWazJWc0x1TzBKY3k4RE5uVU0v?=
 =?utf-8?B?MjZ6TERUL1ovZC81amFUNjVscmYxVmRkUC8ybFJtSmlLSGVIUGtGN2NYbkha?=
 =?utf-8?B?V0p4UmJKamptTGUyYXNlRUNSVVpyYjJqeWJ6YnhjVnJtOFFEbVpQYWZHOHhw?=
 =?utf-8?B?Q1J2Y1NQZnlSWlN3cVBpRkdFak5mOVo1TDdMZkJJd3ArK3RLNnAzdGVCdlNJ?=
 =?utf-8?B?NmtrV3JoL1A3eSttOHBESGkvemJQcGtwVUY5aHB4N1ZlR1F0TlcrMTNkQW9Z?=
 =?utf-8?B?NjJ3M2I0QlZibytaTXpvbjI1SlJrTVBLSEtUcVdGOGxWMHRSYURSY2p6K2lZ?=
 =?utf-8?B?UUxmUkdEZnBSMnlVNWdudVRMWW9Zb1hDYTRaSUFRNm9ScUhRNTh3emY1c3BM?=
 =?utf-8?B?b0dEU2JrWGM3MlRQbDhWZXU2M2FmT1JxbisyUjdiYko1L3B6MCszOGQrWVNM?=
 =?utf-8?B?QlFzdUhyc1NNRVdEL1VhZG9lMnE0VzkzODM5REx4S0tNZmxMUXdlSTdNWWtI?=
 =?utf-8?B?Zm0rR2pRdzBrT3Z5SXd2MGNib3h2dXREdWZHaDA5eUtqTFdkaU9QM2s1MTJs?=
 =?utf-8?B?VFJCUXRobE1uRzVXV3EzVlhnMk5FcXYrUVorVENnRW5aZmRrWVJERHpNMVQv?=
 =?utf-8?B?QURneTkvUkFXZy92K2IyMDU4NmlzMjdYSFN6VmVXRnIzSDNtTisrUUVaTDA5?=
 =?utf-8?B?dWRrWjQydXJvQkhSWmx6NTJGSGhKSTNOU2hHUmlLb2xTS0FIQmhPRmM4ZDRM?=
 =?utf-8?B?WkRYTWN2bGZkRkd5dFZqb1RZUHd4QkVyTGcrTFA4VzVpQkxnelgzcVh5YURY?=
 =?utf-8?B?L3dlQ1lCZlBpTFhSSFlrQkM4VEowR1lsb0VtNmNzMGVyTnphSmlCT0JwTkFB?=
 =?utf-8?B?K25oTDRtWkNYYWp0blJZaEFDVzJpQ3h6RDNrWEpadnQ5MEM3ZnQvTm9GR21J?=
 =?utf-8?B?K04ycndUcmJ1ZlZObkZyRis0eUxSd0w5UUlBTmx5TjNIOFgvbmhKakdEWFln?=
 =?utf-8?B?cnFzNElWRmxqUjQ4dWdydmVlQjlwaUJ3OVRVMzAvbU1laVBhc0l6UEc5cm0w?=
 =?utf-8?B?Mmx6WGY3TWJSWXg1L2l1L0YvcXpKSGZrcE9OelBsSFEraHpRZ21vSER0Sysy?=
 =?utf-8?B?RTFTa0dRMWZYR3NtTS93S0NvcmtSUjltbFhLcHNMMUp1bDlCSVR3c29lZ2FR?=
 =?utf-8?B?S3FIRkw2VnZrWi9ydWRTZlZCcFFGTlViMjN6WEJMSEQ4OTZGUUVNeS9jU0Fv?=
 =?utf-8?B?UmUzRTVQT1gwOGZWR01rR1JlMG01V0Fwc3VrTE84NFZCTk5qcUkray85NDdX?=
 =?utf-8?B?NU1iczhJNTNrSVlHV1hrSVhCMGRuZFZETWp1QlpONi9YMzlabzdpOW1zQytB?=
 =?utf-8?B?OVMvQjVNV3RzSk9sOXhadFQ4clgzZDIyTjNESUw5KzlPdmVGR2RIa2tQMmdt?=
 =?utf-8?B?ck8vbUtRN2E3VFV6ME1tT0NTK2tWSGp1RWtDU2dNNDlnN2pycGZ4bUpXZjBY?=
 =?utf-8?Q?nQ8LTIrnZzrhmf6BfaoRtVsE2xSpzza+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUE1REZ5Z0FkbFdyRjNieTQwRGR0NFd1d1N5M3ZaLy9Xa0FQQjFPR1haalZW?=
 =?utf-8?B?SWwxWXBJOWtpY1UyZHZNekEvckVSbXc2bHkyUnJNd1dSSXVKMWxERG5jS3Jv?=
 =?utf-8?B?dUZET3VWYWFrSjAzeUR6UzdEOU1NV0xiSUVLa2ozKzEzM0VueTU5ZmZMNW1N?=
 =?utf-8?B?NFJneEVmWDhmT1ZKRzVkWXdyWGEwQzRLWU1XRXhMQkVRc0dXTlhkc1owQVIy?=
 =?utf-8?B?YzhYQlpKVzE1cWFGLzMyU2pmdXh1MjFmYnNFaFRKTGV6OHdDOHh6SGU1QVV0?=
 =?utf-8?B?TUk3dkw4eDZnVHpWZFFYaXRSYUU3U3MwbjZTS2Q5YjlTV1lPdXBDNEVTaFBK?=
 =?utf-8?B?Q1JjY1YwTjNoSDlSdWllSFZxSUFlcEFEMXV6bjRwaitFN2dJd0psNE9QWndX?=
 =?utf-8?B?NlY1SE9QUEY5ZCtJTG1ZUVNJRGZHbk5ZWFRrNm05OU4yR1B1eDdvRDFzQnlM?=
 =?utf-8?B?ekJMUGZ5L0dNbDJncHZpU093RU9PZ1hoc0dMSFBMem1aVmxPamdGcE9Xa3Bs?=
 =?utf-8?B?VDNhWkYreFpwL0pQR05zMkZWMWNhWEVEYnl6MDFRM091Y21RN01CUmYxRVh4?=
 =?utf-8?B?ZlpPQmhCK2pxRGtJMWFJYkpPS0UyMDdVME9jb0hrQXRLMmVZZFRCalVYMDhI?=
 =?utf-8?B?dUg4VTNxbjVhOGFFQ2JyeWdJdytzV0MvWGRiTkFWSmNlK3NsaldranlXRmlT?=
 =?utf-8?B?TzRDZktNcDI4ZCt6MWt0RFVPU095NWdsRDdaaldicXgxVDhqbHVUZlhuUm9q?=
 =?utf-8?B?ZjRzbVMxZTRBRXBRWWxtc2w0SDVDSk9BcTVwQ0dQTExrYkc2UWczZVFWblIv?=
 =?utf-8?B?Q0dZcUh4bHp0aW1FSEVHZ0RqYytZS2hMN2lFeTdZU05peWNTOVRmS0JxNERI?=
 =?utf-8?B?UHhOMXJ2ZER2NUgwdnh4NnhCQnZWOWZCWWc5eG8zYTd6TThzVENzTTE4UDBL?=
 =?utf-8?B?VWRmN3JTbFB2RDk3bWNvbURrSUF4a0NBcDNTY2FDVW81MG44ZmtSaXM3OGR3?=
 =?utf-8?B?cldpS1N6aUpZazJJZmJ6UmR4dEpkM1ZCUWlnWGh3aWtiKzF2bERzVDRTVVhL?=
 =?utf-8?B?RG8xcDAwUyszUXkxeTVqTEFUOXpIczBaM20raGN5V1hRZjh4Z0dMcXdQVVpB?=
 =?utf-8?B?K1pHL2g1aVdnQVF0cUZXMHJnb1dtbjdQYURpSTVMYk5hbmhyWkUxY1ZVam02?=
 =?utf-8?B?cmp2L2JlYmpBdHF4ZjNqSll2V3ROeEVNYllrWEQzVkZqZVpJY0t3ZndwTndJ?=
 =?utf-8?B?aUZRRGtwWC9RNGtsM094UmpLalppc2ZtRS84N2k1VHJ6RjdaQVdLS2JqM0xz?=
 =?utf-8?B?OFQ4OVJ3bGhzRTFNd0JNYkRZZEFpUk5CRzhPYUFFZ0FOd2w3UXQ4V3NFaVdo?=
 =?utf-8?B?R1JLcHNxbk1OVkxXTGFwWkVIVTVHcCtYZ1BxRzlyZXZycUNmelhzamRWMGpk?=
 =?utf-8?B?Q2U3dHVaTUJTa2dFWVZSQllZUFZBd0EzL3MzTjdFYzN1OERkV1p3VUZwY1lB?=
 =?utf-8?B?VkF3WE5DUzBCSVpJYkh2NlhzVjlGL1Nhc2RRa3NXaVZGM3M3MmhFM1QvV2hG?=
 =?utf-8?B?MnJ4VUcwVkc2bGhjZUc1aTQzTE96Mjk2NUhveExRbUxuL2R5Z0I5N081SG1H?=
 =?utf-8?B?Y090bXAzRG9GWEVQRmZTZHdMdDdOUFlibzNKN1RRQlVqd09qL290RHFIdWsw?=
 =?utf-8?B?dmJQNmZSdUcra0UvbkhyZTh6SmdwTmx6R0lwRUZJZGlsazY4aEVDTVRmbVNI?=
 =?utf-8?B?Y2Rud3BDY1BTMXQxNmhKRUl2Uks1V28xSmdEWFhEa0pmR00zdVFENjQ1bDNl?=
 =?utf-8?B?dHRKdUNxMndFcHd6UlZVV2ZYbzdJNFhnZ29yZVVwTkdQN0FrbFdKY3djRzdj?=
 =?utf-8?B?Vi9zc3JKVHhUUW5PYnVSYjZ3SVdZNmdHYlRaaWlHOWw2SWN3S3M4aURMejAw?=
 =?utf-8?B?RFEyM1dPaDRzRS91eWxBMzFnTW1OQ1M4MlIraHdxZnRCR0FsTzFkYjFRcnJ2?=
 =?utf-8?B?SVJUTTcyMU9YV29qQkNpNWtjdUZKV1c4Zk5ZS2N5QjhTWUltVldVd2N4d3lK?=
 =?utf-8?B?VzY4TmpNRlVvMEEvYUFWejJwZ3ZpRjh1aDlQZFRUU3VCVzBNUVM4ZjZlblJJ?=
 =?utf-8?B?RW5LT1BCQkNqSW9iZVFvc0JWQUdOenlRbmdmV1dPVk5vNWd3eFZpMVF2L2tS?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c89ab0-9aa8-4c7b-6481-08de20ea7e87
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:21:05.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQFRzmZxAN2gXIJ6fVFF0qI1JDPCtkAjqT17Og6YkMjRVvoKsgkoyAAAgEfStyA/3P2e87uO0pXnCVK42vQq+/KpQ8WY/RRZmIrzRq6thVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5049

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

This patch series adds USB3.1 support for the Altera Agilex5 SoCFPGA
platform. The integration is based on the Synopsys DesignWare USB3
(DWC3) controller, wrapped by an Altera-specific layer that manages
clocks, resets, and other SoC-level interfaces.

The series introduces a new device tree binding for the Altera DWC3
wrapper, adds the corresponding device tree nodes for Agilex5 and its
SoCDK board, enables support for the new compatible in the dwc3-of-simple
driver, and extends the DWC3 core to handle configurable DMA addressable
bits. This allows Agilex5, which uses a 40-bit DMA address space, to
function correctly with SMMU-enabled systems.

This series also disables the DWC2 USB controller node, as the daughter
card does not support simultaneous operation of both USB controllers.

Adrian Ng Ho Yin (4):
  dt-bindings: usb: dwc3-altera: Add binding for Altera DWC3 wrapper
  arm64: dts: intel: agilex5: Add USB3.1 support for Agilex5 SoCDK
  usb: dwc3: of-simple: Add support for Agilex5 SoCFPGA
  usb: dwc3: add support for configurable DMA addressable bits

 .../devicetree/bindings/usb/dwc3-altera.yaml  | 78 +++++++++++++++++++
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 24 ++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  9 ++-
 drivers/usb/dwc3/core.c                       |  9 ++-
 drivers/usb/dwc3/core.h                       |  3 +
 drivers/usb/dwc3/dwc3-of-simple.c             |  1 +
 6 files changed, 122 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-altera.yaml

-- 
2.49.GIT


