Return-Path: <linux-kernel+bounces-818051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35FB58C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1672A69B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42AE221FD0;
	Tue, 16 Sep 2025 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jm8vS8te";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ma+BH7zO"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C6D528;
	Tue, 16 Sep 2025 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991820; cv=fail; b=FsuL9bOn6TFOPrwA3FcVXD8RdEoExMNj6HrAodvTSDwBq+8pjuaRtAZhPz8bl0glfKH+qZ9CclnzuwKOJgYzsaBezKVznHHV7qlFmAic66HO7SSfa1MrFM6L+i1gZawPK3H9IXsDHS6qbq+IXtZcHKQfXiXtS0NoO5oZXvn6L3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991820; c=relaxed/simple;
	bh=oUe23kUx/aRcqIeUrZDZVs4YZXeLInTRJd/PgSHFXUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HaX15VC3BYKrL+6uy0ZBSZoRhvQGwz8SCczMHCIp9v8ag+mKWAa/eqB5azroFUUiWLUat7E+qvEUP097qYmBtvKdAzB/1X3oBPq2rpLYN5nFDIbdEwE33WspKTO6nzbzI0ZAJdhl9vhMNmJEmoUz2orvG6XfU+fNvQJ2vBfsVj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jm8vS8te; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Ma+BH7zO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b94b892a92a911f0b33aeb1e7f16c2b6-20250916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=oUe23kUx/aRcqIeUrZDZVs4YZXeLInTRJd/PgSHFXUU=;
	b=jm8vS8tebq+fzWlsT/hWRMMkNj+DUTH7bjS65PTbEiOa4Q/vs+1QRXSJHtYANWG/WckPypB3aGD/fpP7L7ZfPANuBvF4jS23qO/jpHZ1Zev4469/EedqLPssOOboydfZgZR2piVRan7LJF0bCEqDb+NTGpyvZOcmF34r88VyZ5g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:5833ff27-70f7-44a5-84e8-35c911ba6a9d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:3ad5976c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b94b892a92a911f0b33aeb1e7f16c2b6-20250916
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 954436474; Tue, 16 Sep 2025 11:03:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 16 Sep 2025 11:03:28 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 16 Sep 2025 11:03:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc3wq+MkIpCyNC+og7d+njvoB87Eylr39YKupFU6CznnZXzQhZH3ttGkbbEYQUqwhVMjmmlkdo7tqTs/flPFKdvI0T5ohUh7Foba3fvMURw9fUg3oz5yP7tBEM0CEW2rGXUoQM1kNbKgHgFBnTaqiKroQf27czR99Metp2G0Oej2i0lEz8XaUyyin+pg+8F5c45F4IUP638kgu2+q8RSLb9Y01y5FS9IjRuXJbVAnEuzLOblNJRl03RVX55nC6k1hlLb9c4TOJL2XlR7Im6ukcM5V/onD4lYKYnvNsMHWiB99uWUF4FBrdKK6sAAPsXRky20KnjKC+hBEK72J86umA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUe23kUx/aRcqIeUrZDZVs4YZXeLInTRJd/PgSHFXUU=;
 b=caS2MPJ0GN0goq8sFDWbQ9EnLVCEUNzAkCl2Aq/42nbnqgNKZcIBOhbGFVKyCPjreZ7e3f4qU9H/vZRllMoqS61E57FfnVbK0JDQHVA9RXFWL71xOeUEyEQ0GjYTbdGn9jqmtDLFDhJnyTp+3A0g47uyT7x/bc9tOhfmp5njfwibEEo2OpiDOXraELAy9CObPNLuFfPb0T8d+SOHBWl8vi6kZsvLxcfri6rfqy+5748k5duJlyCmZFVBWz95cr7UO+u8PM8N5p93yPuCqQ3govu+ePaoz682wKC1eFpeZ1BE2fv7X/chR3grNYDc43k+pAiSJhcJ0f261E5JP9/BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUe23kUx/aRcqIeUrZDZVs4YZXeLInTRJd/PgSHFXUU=;
 b=Ma+BH7zOvpcdSvnfyK48jzyzE3s7L3C8ERE++ptpqBDGtPC4JJHOt9xy/MWOwxTuYa+wAQyp9rAtZhU9mQBjswgylhUmhjMq6+kSDzpIjdqZiX+7CuXbpndMDQsiCPX8c/KtCj1tqmxrSAGe27EukM9rKdAy3In9qcYVxGnDdTQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7744.apcprd03.prod.outlook.com (2603:1096:820:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 03:03:25 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 03:03:25 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?=
	<Paul-pl.Chen@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"fshao@chromium.org" <fshao@chromium.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH v4 06/19] soc: mediatek: Add runtime PM and top clocks and
 async controls for MMSYS
Thread-Topic: [PATCH v4 06/19] soc: mediatek: Add runtime PM and top clocks
 and async controls for MMSYS
Thread-Index: AQHcF/M+3AnIlAAMBEqsXMRYxgdqwbSVPQcA
Date: Tue, 16 Sep 2025 03:03:25 +0000
Message-ID: <9d157ab1fbfc268a052b44955192092757ce48bd.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-7-paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-7-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7744:EE_
x-ms-office365-filtering-correlation-id: bf86bff9-242e-41ec-be3d-08ddf4cd9abc
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|42112799006|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YnRlNXF4OFdXcjJqWHkvRDhCOWpzbHRMTkhSbGV3aTRwRUI4b1VoT1JHdlVn?=
 =?utf-8?B?N09MNzl2ZXB3VHE4YzFqS2Y5cnBhbTZlZmN3a2NKQkY4Z2tSU3YyQkh0cDlD?=
 =?utf-8?B?VXlVQWQzdTYwdHV3aW1QTTljU2pYcEQ1RzRGYjIvL1hVazIwdThoWnVZZzB1?=
 =?utf-8?B?cW9LVHR5Wis5eklCTUx5aUw3TVVZL1FWVGpYWDJLeFl2K3k1TExDbEx1K3FB?=
 =?utf-8?B?TEs0V2RFdmlmNi9aSjZ4Z2diaGpyVUg5bWRCcER3d0RYd1ZlSEk5RXRoRHNQ?=
 =?utf-8?B?NEFIOWVWdGtNd2FISEt6d2kwOGpwdDhzTWhjRXQrdFgyWGRKVE9BeURSTHNE?=
 =?utf-8?B?V0REdGpwWndvaXBtQ0t0SFh2UXFnZG93ZDNVWnVJOVExSFlvL3Mwckw4YVFI?=
 =?utf-8?B?NGZXT0krWWJ4cmlCdVVKVVpYSHlRVHdTQ2VtbVlCZkphQTFsR25BbDVCSkEx?=
 =?utf-8?B?c1hoczRocmw5bDkrYnl4UlMzSm45eHhOaTJWNnFweDdwUnFYNDZSME03cUZE?=
 =?utf-8?B?QmRJQUpoQWdsN3JrQXFOMFl2TmthWGR6REx2OUUxRHRqUCsvMmVQV1JQN1JU?=
 =?utf-8?B?S3B0N1dQZlFucGZhT25qRU9xbEJXUWRMZXJQY1E1eG45dDBMZ0t3MjZKQU1X?=
 =?utf-8?B?VnFWNnlPRFkwWWtxU3NMZ2xQMU04Qml1NzJwZE9xd09qRzdac1FwdlVFYVBV?=
 =?utf-8?B?TVExNkF6SEZOOUtzaFlhMWFIMHVVTW1udmVRU2xGcGRRTm1oVGF4ZTJnWDJG?=
 =?utf-8?B?eXN6QmFTaWJlZU5XWVRnVlg1aG5OODhXWWUrSEl6NGVuSkhFOUVRWEJYRGxQ?=
 =?utf-8?B?Z0M4eFppVzlCLzBWWkxiZVA1cFQ1VVk1V0pRUUZOWm1qUHJNd09XQnc2QXpC?=
 =?utf-8?B?OG9JRVZaWWV3QUZKcTR0eUluMmYxb2NVd1B1V1p5MW5pZ2hvdm9aeENtcTRl?=
 =?utf-8?B?SUQ3dFREVGpaVkppRGZvcmh0aklCeXVaZ1EwRVZreEUxcWRwVlBtcGtjSWNz?=
 =?utf-8?B?Nmd3czBncGxlNEIwRTlOV3JUdnhBa3FLeDVxWWdMaUM5OUFFVHdYL3FqbGtW?=
 =?utf-8?B?Z1VhbTJ3Y3FNdXRhS2tZMDVKOWtrazh3Rmx2dms3OFREMmV0bDRvcEI3aFRz?=
 =?utf-8?B?QmdBSEl2L1k3djlDQUdobDFQY05iZlE1Y1ZGbVpRYXRQcWEyTmh4U2VYZ1FT?=
 =?utf-8?B?Skp2K1dvQWRCckg2cjJ1MDBBaFZDYzVOYURycnJUSlpCaDZsM2liRG1INitS?=
 =?utf-8?B?Yy9EN0ZocmtkNW9ySFp3WVFtWlBVbzY1Mkd6NlZqYjR5VXJXUjdQQzU2aDlD?=
 =?utf-8?B?a2o5NEh1cXcremJXK2xMaXpsa3RKbnBSR2tBNXg4UnphSzNiSGpmbVZjeXpP?=
 =?utf-8?B?NjRlUmRJdU16ZkdKdjJCNlZUQ3dyN2NRc3lPRG04eWUvNndJbG9KR2JCSC9K?=
 =?utf-8?B?dTUwMGdjSG5DQUcyODFQazluV242WGJsY3BtQy9tU2oxdFUzdlRDT2szeFBk?=
 =?utf-8?B?eFJjeTlrbUxnLzdYOW1UR0t4a25VYVhhamptK1N3cVVLTFQrRmc3MWN5Nkw4?=
 =?utf-8?B?Slo5OTliSHNlcVFHTG94bkM4MDVXNkdnZjN0SHcxR0ZJT1ptbXMyc2MyMVF0?=
 =?utf-8?B?WVBEZnhOaGhBNXVxY1lkRU9JY0FSTHFWUnFYeTQrNEN1emFGZHZBVmdCeHFC?=
 =?utf-8?B?bE0xdWRiRDNoUHU1NWRRaGdYUzdaZk1iMUZzWWZ2Y0hsdGZ3Mnh6Ry9zWnVq?=
 =?utf-8?B?OXppMlJVMk56YkJxK3JpblRxem1SbGlWMjZDdjNlOXRGTTlXb0oxU0JiVCts?=
 =?utf-8?B?Wnd4TW5kWVk2ZFRGOWFSaW1uSW4wSmowMWlQNVdGYUlGNG5OZmNDTlp3RnVv?=
 =?utf-8?B?ekNNTzAzcTFyeVNpaUVobHZUUlNHVnNObWt6Vjh1Z0ZDLytxZEJSTTYxbHRi?=
 =?utf-8?B?L3ZiN3dDUERZNWhmUlo1YjZ1SmRJTjdUWCs1a0Y4NkdrNzArSkphUmlMNEww?=
 =?utf-8?B?V09iZUI3ek13PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmFZL3IyNndNUlAvbW1xL1dQaENLZmVNdHJqaUFwQzZuM0ZZeEhoR2k0NjRM?=
 =?utf-8?B?ZE45T1B2THNBRnI4M0FnNUdhZzEyWmxDazduNllEajN1N2pGOWM5b3lacnU2?=
 =?utf-8?B?clAybjJTZzBjMG5kR29sbGpXb21Qa1AzUDR3YUF2c2RHYlRuUTkvcForTWpj?=
 =?utf-8?B?L0hJbVBkYjI2NEg2cTBJUEZVcm5FUjI2ZGZsbVhvZ1lXNUs1RThIUERBUzcy?=
 =?utf-8?B?dDYwb2wvdnRVc0pCU0E4MElqOFJMM2QyTGVSTTc2eGpMbWJZUzBwN3BhakhW?=
 =?utf-8?B?Wkhwbm4zWlltQWtwS0VLODNXOEtWOGpBRENvQ1Q0ckhjRFdieDVZNjhMSis0?=
 =?utf-8?B?elRuU0JHWUhhblJ0R3pJaDU0UTVDOVNUalVraGw0TmtSNHkya0NwK08yMGw4?=
 =?utf-8?B?L3lSdTFOeXpYYTFBc2hHTHg5Qm84RUdsY1N3T0xtbkdiYkV3RGxxeHJJeGFD?=
 =?utf-8?B?YzlrOTc5MFFDT0RUYmI1V2JZTDhGbS93RzgvRHB6YTlOY3pPNEpqMThlS3Nr?=
 =?utf-8?B?eFBZRTRJNG5wbTRYcDlpQndZTkcwTzB5eW5SQW1SOWJPd2JCeEhweHhrK2Jx?=
 =?utf-8?B?WWxBWm4xaHcxbm5uank4ZW81bG0zK09sU2IrNmNabWxGZWxhbk1iczE3R1c4?=
 =?utf-8?B?Ry9HVVdWZ29jVE5pYnpXKzBiQVB1T0VCT01Va1U3Z3ZhWnZsS05yU282YTJW?=
 =?utf-8?B?ZWpZT3JMSWMxYXBETUkyYmNRQVJuY0l1T01mTitDcXc4c1B1cy9jZmhIK2l4?=
 =?utf-8?B?R1hQby8wZUk5dHpHNzR3VUIzRVp0OFBQR24xV2lVNTdMSDFHQmZndmduOTQ3?=
 =?utf-8?B?R2ZHbDl6MTdDY1BIcXk2L042bGk4YTFINGZQT2FQZmNMZmxzZUl1SnJjS25p?=
 =?utf-8?B?aGI5QkZkZENmcHJkNHQxc1o2aXBJejZwbHhBUlpOQWNWS2dkMWwwSnUxbUJk?=
 =?utf-8?B?L3FQZFhEL1hHMkROajJ5YjRJL2Z0RnU4UTVJUW9JRlF2a0xIOFZocnk4RUxD?=
 =?utf-8?B?QWV2SGt4dXlnRmNxYmw4Mm5lUnhxQ1VGSi9obEE5L1AvWHJtNGRma25KcSsx?=
 =?utf-8?B?b1ZBR1E4dTMvcDRsWE1hRmp5Q0EwN0RzM1JPc1M2K21sZ0VMVlBad1lPWXFw?=
 =?utf-8?B?MWVMeTZhSlFnWTN5dXM2WHdNS1FGUGpaRkV3ZU5lZTM5WXVwdmJuZXRjVlQy?=
 =?utf-8?B?QzYxQzRNRGtyV1dCQmFYdUk5elU5b3pmdDVzYm03ZkdFVGlQY1lBc2dHdjZm?=
 =?utf-8?B?dkgrazh0bWF1RXl0MlZzRnEzOHlDSnYwcXphNGNyRWVoUnh3cGlJUXkrazJF?=
 =?utf-8?B?RnZ5VW5QcXJXTGpDeTAwbXZPRGZkOGNKZEltV2pCLzB6N0E4MEk3dkx2djlO?=
 =?utf-8?B?dUVmenR2WEF2eXA0ckhDMFZYamFQd3dkbUxYek1IcFZncmFhNCsySHBRSmVO?=
 =?utf-8?B?MFpBcXNnZnQyR3phQVhEMGJtN25lNzlzTVNQcjl6N3VTSkFnanVIVGlJR0g1?=
 =?utf-8?B?UWQvbjBlOHRONjR0TkFwY3JPSGFDSGpRNUs4M2xrdCtldDVGVnlucWhQaEVJ?=
 =?utf-8?B?Rzd3SzZ4YkpiZDEvT1Z2dEJpZ1pqK0dSOTlST1VwQzIyVzZmNmo0S3d4UGpl?=
 =?utf-8?B?M1FrWmJJU3RVME1XakZya3dVV2NQbXl4M3NxQk0zL0ZRVVJUUitzT2J3bEV5?=
 =?utf-8?B?eDE0ZzVpQWowUkcxSm5xaGJibWZDenN4YmNKUHl3aTdxcHNmM1Q1WnpScEVU?=
 =?utf-8?B?Q1RhblR3VmROREV5SHB6VS8vNi9GK21rcmh4YTJ1dVF4enpqWmZiTlRLRVFo?=
 =?utf-8?B?ZmNmV0x3Z3Z0RStndnNRRTAxb1RhT1VBYzNNa0IrQkhiZ3J4OGVPUzY2NDRR?=
 =?utf-8?B?cjdORWZTalhiRzBtZE16cEtSZGM4dTFFRVlTMlBnVkFSUFdqRm8rTGV5ZWNo?=
 =?utf-8?B?akdJa0VnZi9XWTNMYkM4T0FSVExTR2M4NXRJUEgyc3A3OG54UnNnSkJIVFFR?=
 =?utf-8?B?R01oWVg5TnN6UjVXNmpKVmJwMGhlUnJ0UUNkTVVwaE44R05VRXV3eEJyOVp2?=
 =?utf-8?B?SnMrNHZQWTI0ZVh3TE1Jemw2cUR3Y1V6bExYT3kwUnEwazh5Q0lETDhnK2J6?=
 =?utf-8?Q?4Ol0fn/jvj0NwyxOmq/RyxVU4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AC46528393EAD4D94A7E0C608C5EA4D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf86bff9-242e-41ec-be3d-08ddf4cd9abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 03:03:25.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XJp2+Zpqkk1laqmQP4Pxwyge7xld606D7nquqBEv0+H4Yi8GeBQYCntyyGLc7ZgYHmFUCINoVMd7vBZHo2Zrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7744

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDE2OjA3ICswODAwLCBQYXVsIENoZW4gd3JvdGU6DQo+IEZy
b206IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IC0gQWRkIGluaXRp
YWxpemF0aW9uIG9mIHRvcCBjbG9ja3MgYW5kIGFzeW5jIGNsb2NrcyBmb3IgZWFjaCBNTVNZUy4N
Cj4gLSBBZGQgUE0gcnVudGltZSBjb250cm9sIGFuZCBuZXcgZnVuY3Rpb25zIHRvIG1hbmFnZSB0
aGVzZSBjbG9ja3MuDQo+IC0gQWRkIGZ1bmN0aW9ucyB0byBzZXQgdGhlc2UgY2xvY2tzIGFjY29y
ZGluZyB0byB0aGUgZGVmYXVsdA0KPiAgIGNvbmZpZ3VyYXRpb24gb2YgdGhlIGNvcnJlc3BvbmRp
bmcgTU1TWVMuDQoNClRoaXMgcGF0Y2ggaW5jbHVkZSAzIHRoaW5nczoNCjEuIEFkZCBydW50aW1l
IFBNDQoyLiB0b3AgY2xvY2sgY29udHJvbA0KMy4gYXN5bmMgY29udHJvbA0KDQpJIHdvdWxkIGxp
a2UgeW91IHRvIHNlcGFyYXRlIHRoZXNlIHRvIGRpZmZlcmVudCBwYXRjaC4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBQYXVsLXBsIENoZW4gPHBhdWwtcGwuY2hlbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0K
DQpbc25pcF0NCg0KPiArDQo+ICtpbnQgbXRrX21tc3lzX2RkcF9jbGtfZW5hYmxlKHN0cnVjdCBk
ZXZpY2UgKmRldiwgZW51bSBtdGtfZGRwX2NvbXBfaWQgY29tcF9pZCkNCg0KVGhpcyBpcyB0byBj
b250cm9sIGFzeW5jIGNsb2NrLCBzbyBjaGFuZ2UgdGhlIGZ1bmN0aW9uIG5hbWUgdG8NCg0KbXRr
X21tc3lzX2FzeW5jX2Nsa19lbmFibGUoKQ0KDQo+ICt7DQo+ICsJc3RydWN0IG10a19tbXN5cyAq
bW1zeXMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwljb25zdCBzdHJ1Y3QgbXRrX21tc3lz
X2FzeW5jX2luZm8gKmFzeW5jID0gbW1zeXMtPmRhdGEtPmFzeW5jX2luZm87DQo+ICsNCj4gKwlp
bnQgaTsNCj4gKw0KPiArCWlmICghbW1zeXMtPmRhdGEtPm51bV9hc3luY19pbmZvKQ0KDQpmb3It
bG9vcCB3b3VsZCBjaGVjayB0aGlzLCBzbyBkcm9wIHRoaXMuDQoNCj4gKwkJcmV0dXJuIDA7DQo+
ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgbW1zeXMtPmRhdGEtPm51bV9hc3luY19pbmZvOyBpKysp
DQo+ICsJCWlmIChjb21wX2lkID09IGFzeW5jW2ldLmNvbXBfaWQpDQo+ICsJCQlyZXR1cm4gY2xr
X3ByZXBhcmVfZW5hYmxlKG1tc3lzLT5hc3luY19jbGtbYXN5bmNbaV0uaW5kZXhdKTsNCj4gKwly
ZXR1cm4gMDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKG10a19tbXN5c19kZHBfY2xrX2Vu
YWJsZSk7DQo+ICsNCj4gK3ZvaWQgbXRrX21tc3lzX2RkcF9jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2
aWNlICpkZXYsIGVudW0gbXRrX2RkcF9jb21wX2lkIGNvbXBfaWQpDQo+ICt7DQo+ICsJc3RydWN0
IG10a19tbXN5cyAqbW1zeXMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwljb25zdCBzdHJ1
Y3QgbXRrX21tc3lzX2FzeW5jX2luZm8gKmFzeW5jID0gbW1zeXMtPmRhdGEtPmFzeW5jX2luZm87
DQo+ICsJaW50IGk7DQo+ICsNCj4gKwlpZiAoIW1tc3lzLT5kYXRhLT5udW1fYXN5bmNfaW5mbykN
Cg0KZm9yLWxvb3Agd291bGQgY2hlY2sgdGhpcywgc28gZHJvcCB0aGlzLg0KDQo+ICsJCXJldHVy
bjsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBtbXN5cy0+ZGF0YS0+bnVtX2FzeW5jX2luZm87
IGkrKykNCj4gKwkJaWYgKGNvbXBfaWQgPT0gYXN5bmNbaV0uY29tcF9pZCkNCj4gKwkJCWNsa19k
aXNhYmxlX3VucHJlcGFyZShtbXN5cy0+YXN5bmNfY2xrW2FzeW5jW2ldLmluZGV4XSk7DQo+ICt9
DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChtdGtfbW1zeXNfZGRwX2Nsa19kaXNhYmxlKTsNCj4gKw0K
PiArdm9pZCBtdGtfbW1zeXNfZGRwX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIGVudW0gbXRr
X2RkcF9jb21wX2lkIGNvbXBfaWQsDQo+ICsJCQkgIGludCB3aWR0aCwgaW50IGhlaWdodCwgc3Ry
dWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCg0KVGhpcyBpcyB0byBjb250cm9sIGFzeW5jLiBTbyBj
aGFuZ2UgdGhlIGZ1bmN0aW9uIG5hbWUgdG8NCg0KbXRrX21tc3lzX2FzeW5jX2NvbmZpZygpDQoN
Cj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX21tc3lzICptbXN5cyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KPiArCWNvbnN0IHN0cnVjdCBtdGtfbW1zeXNfYXN5bmNfaW5mbyAqYXN5bmMgPSBtbXN5cy0+
ZGF0YS0+YXN5bmNfaW5mbzsNCj4gKwlpbnQgaTsNCj4gKwl1MzIgdmFsOw0KPiArDQo+ICsJaWYg
KCFtbXN5cy0+ZGF0YS0+bnVtX2FzeW5jX2luZm8pDQoNCklmIG1tc3lzLT5kYXRhLT5udW1fYXN5
bmNfaW5mbyA9IDAsIHRoZW4gaSA9IDAsIGFuZCBpdCB3b3VsZCByZXR1cm4gYmVsb3cuDQpTbyB0
aGlzIGNoZWNraW5nIGlzIHJlZHVuZGFudC4NCg0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlmb3Ig
KGkgPSAwOyBpIDwgbW1zeXMtPmRhdGEtPm51bV9hc3luY19pbmZvOyBpKyspDQo+ICsJCWlmIChj
b21wX2lkID09IGFzeW5jW2ldLmNvbXBfaWQpDQo+ICsJCQlicmVhazsNCj4gKw0KPiArCWlmIChp
ID09IG1tc3lzLT5kYXRhLT5udW1fYXN5bmNfaW5mbykNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJ
dmFsID0gRklFTERfUFJFUChHRU5NQVNLKDMxLCAxNiksIGhlaWdodCk7DQo+ICsJdmFsIHw9IEZJ
RUxEX1BSRVAoR0VOTUFTSygxNSwgMCksIHdpZHRoKTsNCj4gKwltdGtfbW1zeXNfdXBkYXRlX2Jp
dHMobW1zeXMsIGFzeW5jW2ldLm9mZnNldCwgYXN5bmNbaV0ubWFzaywgdmFsLCBjbWRxX3BrdCk7
DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChtdGtfbW1zeXNfZGRwX2NvbmZpZyk7DQo+ICsN
Cj4gK3ZvaWQgbXRrX21tc3lzX2RlZmF1bHRfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldikNCg0K
V2h5IG5vdCBkbyB0aGlzIHdoZW4gbW1zeXMgcHJvYmU/DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICt7
DQo+ICsJc3RydWN0IG10a19tbXN5cyAqbW1zeXMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
Kwljb25zdCBzdHJ1Y3QgbXRrX21tc3lzX2RlZmF1bHQgKmRlZl9jb25maWcgPSBtbXN5cy0+ZGF0
YS0+ZGVmX2NvbmZpZzsNCj4gKwlpbnQgaTsNCj4gKw0KPiArCWlmICghbW1zeXMtPmRhdGEtPm51
bV9kZWZfY29uZmlnKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgbW1z
eXMtPmRhdGEtPm51bV9kZWZfY29uZmlnOyBpKyspDQo+ICsJCW10a19tbXN5c191cGRhdGVfYml0
cyhtbXN5cywgZGVmX2NvbmZpZ1tpXS5vZmZzZXQsIGRlZl9jb25maWdbaV0ubWFzaywNCj4gKwkJ
CQkgICAgICBkZWZfY29uZmlnW2ldLnZhbCwgTlVMTCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9M
X0dQTChtdGtfbW1zeXNfZGVmYXVsdF9jb25maWcpOw0KPiArDQoNCg0K

