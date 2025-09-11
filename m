Return-Path: <linux-kernel+bounces-812686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36135B53B66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD80FAA82D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA4D36CC6E;
	Thu, 11 Sep 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="INhBER6S";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="INhBER6S"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023103.outbound.protection.outlook.com [52.101.83.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203036C081;
	Thu, 11 Sep 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.103
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615331; cv=fail; b=f6IrkLXZ0IfepRbt8OZk6avNHDOtKUY/8aFeReQhY/GC/47FJVluZdzhwmONweECw0OJI4dolvtuLtmMItOgDMyOXC7dJabgNVzz3goOFpiQITmNQVMpRsd2o24GIdBhJs3/l79FniNBMa9JfPcRuF+TR7vtW8VyP5He3VObpqs=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615331; c=relaxed/simple;
	bh=0UUDnGdsvxNxtWzsIFo84svTzrLSHjaYtIlkYwPI7Y8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tMrvvf4piLvLU5RyhmUevQzF3ckJBABkMIZ/OdlB7lLB1FEcwD6tIeOb9C7Kq5bygmsR4wQmJVKRiG639IT3JtDKaxTd3AnGQnq/BMk3TH8lk9vYowDuGaSrPL2fg8fto8pEq+m6Qhqo1x0B5SaxqUyeT0u8n9QFtSrvMhwfrGc=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=INhBER6S; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=INhBER6S; arc=fail smtp.client-ip=52.101.83.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JSCgGGbONYxOHYbOrc28lzoFLxmCSTN+gF7NywRrPaob3eMR4Xbff5H1UysEbS/x9VKEEOkYd4M8ni7N9JDzwZQltwgaLiLviH5UILbs56z/qQUpWw7Y882gBGtcgXQA/+5cIWselirTthVwth0abeqR0LC3P3l3+EzBa8C+qwaT7DrAZ7mEacOYK/KqLhxcNPM2QP2CWFyCs2yuWuwIrq5sDh0o1eOtm6YK06xL+NtAN8vdAzZ+SnJoFOBKjJiWqVMjNfO/7RdbOSDonX/gzHYuilx6k12IzvZ5kz0B7kaJJ9eMv2LMKqgerB2o4Bb75Xi0nXIF0VoV/rgLFCeCiw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYr28FrCemWJlDLFY78DdrALNctkbSDST3RLEdUBW1o=;
 b=BPgOvBuzzhy2WS3sZQCKOEGToC3dmqa6EBDjTHKjxrDJ4qlPoMBxRtaeccs01AVxf2HsIrkpgH7OKAfxeMMwSVPbahpaixSAJlsgIZcwSoKVQC+Hp4HfiSNrFVN9DBfcI4eUIF+/W5LmI7fJAdD8AQ3sSyrHchT8yw3KjsvIErkqAC7djwyKhGt8UKu1m8Ujie0BWONxefG31m0PJgqQRHcmvtMdcqoSHfWQ9pYnvXBr61yjDOl55jliwuHOM2HjB2/DZYSeDilxibW4hhKa94ZuuJFUAE+YbPgDI/fwRl0lNoWCCdO1KzcNiOz6uZLpfV3A+XvGlAGvJQmYs+V56w==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYr28FrCemWJlDLFY78DdrALNctkbSDST3RLEdUBW1o=;
 b=INhBER6SaNpdqin4wsJ3NwvgbBafxs08KVA1ZVwPqHGLoy+/lqQa6579SPivMnAM+SBbyceyDwufMpnMeHrPqD8Cyb36WzEVmPMTUB2XMO8qZbpQO7NTUdMjhlkXtvkQNohHH5M7XoTvl4QZJgbjDxxiCUNyDauWnaxp758m64k=
Received: from DB7PR02CA0009.eurprd02.prod.outlook.com (2603:10a6:10:52::22)
 by VE1PR04MB7453.eurprd04.prod.outlook.com (2603:10a6:800:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 18:28:44 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:52:cafe::78) by DB7PR02CA0009.outlook.office365.com
 (2603:10a6:10:52::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 18:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 18:28:41 +0000
Received: from emails-9432246-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-93.eu-west-1.compute.internal [10.20.6.93])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 65AAE8061D;
	Thu, 11 Sep 2025 18:28:41 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757615321; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=CYr28FrCemWJlDLFY78DdrALNctkbSDST3RLEdUBW1o=;
 b=PAAhwQz7IvGFKFy2vgVanePmdkjH1jQiNG/ru8ma+9x2g2QvbrLT3m18efv0otwJZEmtw
 r3zvsH2wUdXsXj3fRVK01jaSD81dFKGXf8XS1JFgvjnxbD4y+0dtEnKNr3U5hketaPFjK1F
 9zLVu60M5GYy+UXt1VqxZrSodvIZ10w=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757615321;
 b=LdK0we7hYj4dwh0gPMZRjM62k1QFzLahhueNci/slNUtuCTVQ/Y1aXo46JZ5+XicoQLAu
 zpXsebKdgG7Gfsgv7OtONrZs4OiYPbjCcuwwpOk3vQjG4/nNpAHfn9Gt7T5d/pOFso/QEQw
 sYfQHF3n7jc04vRWyuB1jWi5n5oJ1fM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdMRaiRDCq2cwstCR3G9TuIKujmS4+JXYGok07ZpFU4cIy3JXsJfvL+iYPCe5YCJ2xFektYhtKIxTn2Y7MTB1u7SBchI2TyG2Zq3K4w95uNr1IIvmCGl+coFeHjw4Dwq0NQ0DNKkzCvkTwM9OYWWTInGQBiPTiwReESArBdNImLzUASujd/4F21FUpMfg0COyIaRIPfdCInet3YVe9j53PPgAc/APa/D1q89Ye1J/hLCqOrW90cniXNOv8ynMuCRiT4brtcSXS4Z6YDMayYBxfJoNe7tuL4zmGlIlK4e9HwvfUMkCgg2zAPJPT6McnjHRoH21nh9W/+nMf96wQqh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYr28FrCemWJlDLFY78DdrALNctkbSDST3RLEdUBW1o=;
 b=jgw3w2WOQpUdafsye5kkheBRF9c34wgIzysqwZZR2xS+GE46CnhqnzjFc6E+hv7uyU9K6J7glSy2sMofZ+wPNyHQVivyDdk6Mt5xYaYLtKfBz6wCIUKeg52RdViml7Sx+29+Fkki1o3wcBiQdGM+/sTtgb6rVk6VUjTo2D82HJZIYD/ahhyuapjmZy4AidGlp/2dvVT/Atxq5GbYhLs2pUvN6qTFFxhpIz4J106LU+UkaqECqN6h+zGUEx2xl3eBtFTdBHXAjvxh7FkfpFx8Uf1RpcpJ0s+5BpnbAhPq085nKYRkwcwS1pjkdOyY+lmhMO8wbqfxhyw130siRxITNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYr28FrCemWJlDLFY78DdrALNctkbSDST3RLEdUBW1o=;
 b=INhBER6SaNpdqin4wsJ3NwvgbBafxs08KVA1ZVwPqHGLoy+/lqQa6579SPivMnAM+SBbyceyDwufMpnMeHrPqD8Cyb36WzEVmPMTUB2XMO8qZbpQO7NTUdMjhlkXtvkQNohHH5M7XoTvl4QZJgbjDxxiCUNyDauWnaxp758m64k=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV1PR04MB11488.eurprd04.prod.outlook.com (2603:10a6:150:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 18:28:32 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 18:28:32 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 11 Sep 2025 20:28:07 +0200
Subject: [PATCH v2 4/4] arm64: dts: marvell: cn9130-sr-som: add missing
 properties to emmc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-cn913x-sr-fix-sata-v2-4-0d79319105f8@solid-run.com>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
In-Reply-To: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|GV1PR04MB11488:EE_|DB5PEPF00014B95:EE_|VE1PR04MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 518fc6ba-4ec2-46ee-e68a-08ddf16108ad
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dkVjV09iUGZVaUNvdzhPVjNoQTdPbDRFNlp1UUhHOUZiSzQxYjA4b1RiSGhD?=
 =?utf-8?B?TysrUjNxMVJqNG5KS1c4VVlkUEgva3pITXZSZ3p6MTFPRkpOZ3ZmNnlxZnNq?=
 =?utf-8?B?RzJiaUd5TnJHOE82cDA2ZWFRdFJ5a0c4RmhwbmZmbnc3RDVSVFhoNVVPd3Bh?=
 =?utf-8?B?WnJyeGI4SE5mak9tY0d2QlRLYkdwd0VDRHFCeiswRXZtLzVGWXhHM1Z4M3Na?=
 =?utf-8?B?K0NFS3hGVWRRbThKdEMzaHRlaUNMSFhGZU1BODQ3NjlSbVYvSFhGR1hCcTNI?=
 =?utf-8?B?eXlvZ3JhRkg3OXZiU1FFM3l2WmxFdDdURnlUOVQxZVorSzdNZE9uaHFocXRO?=
 =?utf-8?B?RHppOW9GR3E1bWFFSDZNU2RJNkxyRGFHVStRbms4MlVldVR5ZE4va3JlNzZH?=
 =?utf-8?B?QmdYV2lpcndKMm1Ld05XQW5iRXVVMUxCcFZYWWttSGpaZkhBMjRMRXgzZFd2?=
 =?utf-8?B?cVRqbWRtMm9wM28rdnp4UlhQZyt0NnE1NHBvVDIxMWxCVHdHWkRaVU92Ukdp?=
 =?utf-8?B?ZTFVRWsrY0U3RlpNbnN5Qm9id0RzcnpsVUdibkpYLzUvdHc0VkxwQ1JhQUhv?=
 =?utf-8?B?akJiUTF6Z00rbGNNY0RyRjUyRnBWV3VyKzFnZUZrMEpLcitjZDhjYXBrZ2p2?=
 =?utf-8?B?Y1kzV1dwTFEycm5xUzJiMVJ3ald4NnplMFRsSWFicFR5WkNzcWdCVExQWTIv?=
 =?utf-8?B?bGtLZzZrc0JLQWpId3VxdHpxT0tUUG5SUTNJRWpzUlh4RkhScWJFckVUZElX?=
 =?utf-8?B?L21MTG9oQzRvaGRjUmlITTFIYWd4U1U1Q0Z3MnN5Zk40YkFXOVljeTU0Smg1?=
 =?utf-8?B?bVQ3Q0tzUDRzT25pS3BqMEI5SzBWNVUxdTBUL3J3TXUrRFZTVVY2ODdmU2Z1?=
 =?utf-8?B?RDk0Ym9sYTRNNXhJQlBXUHQrV2RKTjZWYnZMSllYdWYxK0ZEemVHeTQ3bURP?=
 =?utf-8?B?Y3l3RFFIbGpXT0dMSDUyMWZSNEFUODNPK0lobFVVQm1VZHhhL1Y5NlFsaitw?=
 =?utf-8?B?Q0pPWHkxTVB5SHNMZlNLNVFOT2w0bVgwNE52ZVBZZHp1dmVIUHBiK1lteTZV?=
 =?utf-8?B?MkVoUFFuVkdvWjZMcVV6N0dJVjBnV0ZuNmp6R1pCUWNpTnczRkp4QTJON3la?=
 =?utf-8?B?RG9DMzU4WS85aXdOZTNNUElVSFZSY1lXN2lDTGIvWXNZTFJITDhCSllBSjQ0?=
 =?utf-8?B?Y2oxWEltNEJJMzlXdE53b2JTOTQ0L1c4UVNiSVVvTkpWOW43UmRwTnRSYWgv?=
 =?utf-8?B?c01Nc0ZSbkVvazRtSFpqTm54SHUyNjJmU2t1ZDliUkREMkRBYzEzL0NLdFA3?=
 =?utf-8?B?ZFBrd1g1aDZJYzlIWnVjU3NzYWUrNmkzd2k0V0I1eVlOeHpPVXNVdDJzbkZt?=
 =?utf-8?B?Ny9LZGVkYXY4bWNZcDk5QlpkL0JHZ1BYOWk2blp3eUlBQk5PaUI0Q0hQeGdn?=
 =?utf-8?B?U3NUVUlNajQ5MXROL3VSTlRwaXpBV3lML01VNm1HOGhHTVgzRE9ISG05VmJk?=
 =?utf-8?B?eFU5TmFoeWFuQ3p4UFRpbUZnWVVmQitNei9DRnRoOVIzcUR2VU1VbGNNQkdK?=
 =?utf-8?B?K3dUTS9Da2NQOE5ORDlveldidFd3Uk5mQUI1Y2xsQ0RCM1dVNW5hdjB5NVdI?=
 =?utf-8?B?a0FuZkhmcERRSVc1WDFpeHAwQy9CRk95VkN1aGtaZ2dnb1lDRTZHQzZsTk42?=
 =?utf-8?B?RGZWQlRsYk5QaFVrYzdjM3VKQXhQMVY2UzdHUW41RXBKa3ZPL1drc3VpU1VS?=
 =?utf-8?B?YVMvSmMxdEtEZ2w1NGNKSlpsNXdKLzdTaG1jTzl4a3Z0MndmWVdjZXBzS1BX?=
 =?utf-8?B?QmhndlA3aUZyZzVMVlJLdXgxVUhRVE9UQ2VkU2FJVHYwR0hEdUZnNHRrSVRi?=
 =?utf-8?B?c3oxUXlNVlFoZ3BYcjdWNVQ5NkprYU1ibkN5SXFKVDJvVjBTVjMreG9mQnF2?=
 =?utf-8?Q?b+wYDi4JuCw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11488
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b03e0b2808cd4e788081d5ef137f42b6:solidrun,office365_emails,sent,inline:7da486be377ea48cbaa4492ac4adef44
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	86a58df7-2a9b-4dc7-d386-08ddf161035e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|1800799024|82310400026|35042699022|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3NjZFNUdEE1L2FaM2wyUGRZWXdwcUlPL3lEdkZOQkg2TUY1eFBDejlsRTJk?=
 =?utf-8?B?bG5iQm4wVm85NGN2bnpTZmJQVXFyQU5aZUJJWFpoOTVSRE10MG4xSmhMeElT?=
 =?utf-8?B?Ry91dnFzV2RIR1FxdGdFOFNQV1I4WTllbDliZHUvVGNLTkRSUVpNd2ZxNE5p?=
 =?utf-8?B?a3kwZ1FyUjdPczcwMUh1cTBUWE5sMlRVWlU0aTlJSG9mNzBBbis0R1lIa0lR?=
 =?utf-8?B?WkZwUWJrRXRIZFNGK2VUK0F0MU9xY3VJczNobURRdnhuQnJKSWkzL3RLNjBK?=
 =?utf-8?B?TjVmQk45QUZpendWTm9yVzZieU9ZNEZVbWoybGV0VGZUMmhqMUtCaStXQzVQ?=
 =?utf-8?B?a3NrR0RNSXM1YWI5TTBvaFlVTDluK1RVSGV5WHgwdHFWSVU3QnZ0amtqYXhX?=
 =?utf-8?B?Um05dGxVZUZxRkhUZVF3SThhNnJ6UWd4b0JiZHVLRTlzQWFLeVc0MzZtZ3JC?=
 =?utf-8?B?alJlQmZRMWowVjFQWFhGYWFvMEFyWGJQOUdxQnhjclViQUg0b3pRSEI5d3cr?=
 =?utf-8?B?RytDM2RpV1ZHaTBLamtZblcwOXJybTNucXVDUHVDb3lRMWx2T2VvUVZrTnl2?=
 =?utf-8?B?a1NFRGx5S0g5VmFuV3p1eWFZa3N1bDRzdC9ZallLNldRTk05bmJocjZNMXN6?=
 =?utf-8?B?QzZOVm5LN0EyS0ZNeDQ3Ry9kcHVlczQ3ZU9GYk9LaW11UjVKNHFUQzFPeHJz?=
 =?utf-8?B?cm9OREFteWJ4OXBNTDFPQ1BZTHFFL3MwVnpJbWIvWFFOWnZXRlZmbXA5NFhG?=
 =?utf-8?B?OW1OWjBPT3VDNXNjV3JpTndtNGdTaldXeEtSRW85Q2FadTArS0J2TTN1WHRV?=
 =?utf-8?B?RVYzVWRDTGhqNzhnc1pDNDU5eGkxWUdGYWhnTit0WkJvWG56cXdtWjJTY0E2?=
 =?utf-8?B?RmV0UmhzbEVBN3NjK2lzQVRtTVRYUHVIK1NNLzYyVHU5c3Exemo5R3FCMzBx?=
 =?utf-8?B?Q1ZlUWtqOUxQdXcwZ1lwUk5KMVlRM2p5V3c5TWNoNHJnODlMcGg4cnE3WVNN?=
 =?utf-8?B?bnpoYmp6V2k3eEZJRWdPOGZVR3RIL3QyUDBwVFZnV3ZEVzY0cU5nTkE4Tjd1?=
 =?utf-8?B?Z1FTcGFlK29MQjhzUjVIK0NHQjQ5UEE4L0EvNjN6QlByMzJ3azluQUQ5ZENX?=
 =?utf-8?B?bVpzcDNRc0pmTTNhdkJZWHRwOTFPd3B1eXVZaUU1RzFkajZENUhlSElJMTdT?=
 =?utf-8?B?M1NteFlLS0k5QU85NjJhRVE3dEVXdHhSRzR2blFJRVM0N3U0ak0vUGkyNTJa?=
 =?utf-8?B?U3JTVWRxUXlQRVdaWm5TVStFdUVYVXFoYjdLeXUwUWU2bG5yRUdlVUUxOHN2?=
 =?utf-8?B?L2FhaVpQOFZKdnN5dTVHUnIvdGpuL2IwVldjSTZPWElIZWVVcU5mZmdIbk1G?=
 =?utf-8?B?a1d6UnI2Vmx2alRXTTdrVWh4ckM4SkNjYWdsYUpjUHkxaFRFQnpOLzg5ZWoz?=
 =?utf-8?B?QWFWdjdLSjVkVUdFTXlOaTlKZGM0S0ZERHZGWUc4cTFpMFNlcGIrNG9wbmhJ?=
 =?utf-8?B?YmJlcGlzRFhtRTZ6ZGRTZEYyWFVsWHlFUUZwc3BPZTNtMjlPOGx3a0xveEhX?=
 =?utf-8?B?Wnd0eU5LYU4vckRkY0xOTWxZTDllcEd0RG5HbEdxQllzeFZTbHk2Rm5GSFRa?=
 =?utf-8?B?RUdIemoyalRrOE9NQWtDL09CTDVGNzBDN2hRQ1RBSXMycWlFSGxsbTEwNkhC?=
 =?utf-8?B?dVdHenM2QkNPUHJWK1U0SFZtTjB5Z3M3b3RQL1pDVUlPaklTNmJ6cGUyU2RL?=
 =?utf-8?B?UU5zRFdCajdtdEt2V1NSMzdLSXVmVGIvTkRvVlArUm5nQnFwYUtacEtYSnV5?=
 =?utf-8?B?UFVBc2d2TCtHSWcyU2hNS3hBMGRpbHIwc2orK0ZkbjlYcUw3WXJTU0owcHVr?=
 =?utf-8?B?Q2lTTUt2MU9BeWpIMERBUys2REtXNjU0ckVJcjdpcWh3VU5rcnk2N2RsaWFI?=
 =?utf-8?B?MHpyNzViTlFOK0xQQmlldDgzcnR6c08xUlVkY3NUQU9FcHFQMnpiWW83ZVg0?=
 =?utf-8?B?L0xrMFNRNm9NNEx5SldNZHlra1FFWWMrRlZtWVVRM1FoRWhOekdzTDRIRUgz?=
 =?utf-8?Q?ZaeYuz?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(1800799024)(82310400026)(35042699022)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 18:28:41.5535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518fc6ba-4ec2-46ee-e68a-08ddf16108ad
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453

CN9130 System on Module connects an eMMC to ap_sdhci0, but the common
properties indicating eMMC were not added to device-tree.

Add no-sdio and non-removable as applicable to eMMC.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
index a997bbabedd8a9679e9d209225666d7696dd7da2..f95202decfceb5cc9dc777ddd1870d5972a1bc54 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
@@ -61,6 +61,8 @@ &ap_sdhci0 {
 	pinctrl-0 = <&ap_mmc0_pins>;
 	pinctrl-names = "default";
 	vqmmc-supply = <&v_1_8>;
+	no-sdio;
+	non-removable;
 	status = "okay";
 };
 

-- 
2.51.0



