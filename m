Return-Path: <linux-kernel+bounces-830696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36A0B9A51F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FFD17D3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351778F43;
	Wed, 24 Sep 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZpvbZaS"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAB308F27;
	Wed, 24 Sep 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725067; cv=fail; b=s1aF1rkzFDX47A0/HgX8ZGe01Ttq8o2RRR79fZKk2yJWEevr0OJzT72+cGm0K3mDMTyDMLbtY61E7orERcISYqMnTVVc7ZMZBZTGUlH/brEPrmKXAz8DF08V44Qnp/qmzrEP/O+dNf0A+GnX+cWj+cv9p6/ZASfAnMcSCAYYPas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725067; c=relaxed/simple;
	bh=ROmqHqr5pIVNk601Vq3PDrnYY9bBAQcSrEAhChPLylM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4xti0CjffqvhdbEqtHJIkxw/trU9eOYaMeMzF4FxTde/dcriomo1KDGWO5dJ0IVFC/MBrrXXFa0aeMH3k8nPetxfAmp7BCz2vdkanxxkXeweMiUsTEEN2PMEwZrcv7vXqFRPVBlHAAfBvZ0zh4TyjODnutepZKMRY4oQdHj7vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EZpvbZaS; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeYg+MLKCcI9fBxCyeS2BFBEo4aj1af7+k5YQuPigxamYZeNku8GTTNTK6NjTM7A5VMRmBGm+nSu+4+oEOHttT1CUPTA8Y5bxEUYfqo7IyuihRPz9oBuUII/W7Mg5hpve5afpqS221WmTL9wpAWwuQi1PyOUZq7Yu/tdRbfp0PQjNn5RrdPHfaQtKeUhx0OnO4oxqC8UkLYDiFoZyXxsZ36FeoqtCrSLqIDoVOTQzvJxUXBkr4w6YI6Ev6jXYEfacuBGzI7n/zzpQ8Im00UjhTizqan8yE1Ri39eyK0dJQKsOfIgfFyFHVFaTM5eRe9jdCBGkltnw0qIlXLc/mpo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROmqHqr5pIVNk601Vq3PDrnYY9bBAQcSrEAhChPLylM=;
 b=iIr9FCC7PMrY5TgFKQcVwsaXhXCn9NB0efEyTl84A72MR489mnhU/zpic5vy4jD1r5MBRU3JvjIKc6NXXNSiQFlisXfV+IGayryC7sSTnxCpTtOkaP+4r2kt42rKhIyLT/QaRGU8mfF8fT2h8YrDZzpmDkjsduh1oUhPCyZswKCVjzD9UzwNVYK+2W0pzdT81xJmjqez3ZI8h3VWGp26/+c/5SJ9zTGNzEe9HU235JSFcHzMZ7K93DRHszl59L3iFUTDSaSXrePdadWwzxNK2UKzSO+XmABgbIdbV2lEarrW1ycnIaOzUiAAEoNtSCYZFX4riauQXi6+0GC9x30R8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROmqHqr5pIVNk601Vq3PDrnYY9bBAQcSrEAhChPLylM=;
 b=EZpvbZaS04Hf0Z02x8TZZXHEAfs5LymdK3CGkzId0+5QA5ZsR9TpjkemTkBF0WOmUIJb0bvKr7VRL9ZGxm4/J1kf2ExJrelh6nUadijIr8gRis3IHJN3MUyqRX/fz4CPUkHHALGRMIacEFETb8IiIpkgdf5dGa0HzpY9XUtXSKmrh05+M1pjE3BU2kYG5vypQxrK6xJpgsQbRJzzc8dowENSD7mCPyu3KgES+sK8UoGJudO5f3Xa4qWJ+qPWnIaoNb1lQFQSGI8WtOgLm+Gy71aQt4v7thKMJ4tfB+gNF0/5NMA2KfWQ5IIoTOyb8HegGyAmmOWkT/OHUbTJz9T8tw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9146.eurprd04.prod.outlook.com (2603:10a6:10:2f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:44:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:44:21 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Marco Felsch <m.felsch@pengutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 0/5] clk: Support spread spectrum and use it in
 clk-scmi
Thread-Topic: [PATCH v4 0/5] clk: Support spread spectrum and use it in
 clk-scmi
Thread-Index: AQHcJhrzzSvzXvZmwUKK2s6WD+GF97SidVZQ
Date: Wed, 24 Sep 2025 14:44:21 +0000
Message-ID:
 <PAXPR04MB8459265997E9822F17AD2BC0881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
In-Reply-To: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB9146:EE_
x-ms-office365-filtering-correlation-id: 64f358d0-0101-4f6b-973d-08ddfb78d91e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlM5eVZscHlqaGdXQU1PK2xaMTZMaDJ0Q2pKM3R3ZGNRejA3VEZPWmNteEQ0?=
 =?utf-8?B?RW1telJraWZ3N0RZODZ0OW0vZW5wSEhMck9URkFPanJUbmtxMDl4eGUvSVd4?=
 =?utf-8?B?TDUwQzFidUJxblhRQzlDRDJIQnRUVkE2TXRYemh1NFZpUGFNQTI1VWF2TTh6?=
 =?utf-8?B?QWpRNkoyT1dlQVZKVmZObDdPTW1KZlFVTWpaMWtjMWlUelJKejBuNzJpdEFm?=
 =?utf-8?B?OGJRNFhnVzVxMkdmcVkrTEVRaSsvMTkvYzRqbWVUa2tQU0U2aytEb2dNNS8x?=
 =?utf-8?B?TWZ1ZWZpUkcwVDFWdUpEMmhhcGd4c2hCRmtxNnhaazA2S1NaSW9TdmJIYmhV?=
 =?utf-8?B?WVNnWFBEZm9BMmRsRktrKzZsWVNram10a014S3I3NzZ3Y2ZpSlE3MkYvQzFK?=
 =?utf-8?B?WlN0TlF4ZVp2Y3hCM3JGbVV2UFpQMnlZSHpvT3hQOTZyd2NmTEl6NFRXL2Uw?=
 =?utf-8?B?Mk4wRVllWUd0YTBER052N21JNWorWmxNNVh5QURVYUZlbXp1U01XVnZ5MUJL?=
 =?utf-8?B?VVBoVzJIUXAybjRaSjdXeWc2czM1M0NKQnd5eVJKQ2I2bENONXgzcmEyMjlo?=
 =?utf-8?B?Q2kwYVB5UFF5aTkwZkVPTmxxcjl6cUlJZ1p4V29KNUtNZGJDaXZOL1FJYUVR?=
 =?utf-8?B?MW1tVm5oREZ4SEdwd1BVNll0K3RKYnVSSytxQW5QMHAzSlBZOVFWT1pmUHoy?=
 =?utf-8?B?TFVlOFFwa3FWRUt5em9PdkRROFYvV0lYZDRnMEJwL2hTQmducDlQd3JLM0gx?=
 =?utf-8?B?b0l1VDVhUHREYlN0NzUxd3FmVnhQUUc1a0RhTXlKODk0STZ5TXA0WVZmbEpM?=
 =?utf-8?B?YlUxK1RiNWd0WjdvQy9ENkFhN2ZOaE1vRktHQmtGS0VHN3c1N1Y4dG41R0x2?=
 =?utf-8?B?ZWNiUDkxd2hRcEdwWThiVHl4NVR2OTZYdWFwampjcW10a0tjWjBaV2hqMkZu?=
 =?utf-8?B?aFUwVlo0bTMyY09HRGdhZ0ZoZUNYVGtWRVNvWHdaNnBBeFg5YnBneG5ZZEVq?=
 =?utf-8?B?UGQ0ODQ2NThnZkVOY1RaUGRadHFScGhmdEVVeE9GSC9ZODROSWx5aW1TWFhN?=
 =?utf-8?B?OEE5cEIxRjNBNTN4aXlYeS9jcmFNL3VVQnBaZy8vV0g0Q1djQysrVmpwRXgv?=
 =?utf-8?B?ajQzNnVCVE5BdUxMemNOczVxMGQ5ZVVmbmYrMHlnbG1TczdIcnZSakZFU2hy?=
 =?utf-8?B?cUpERzFVRld0MkJRZzdwaW5vWThacTZvTjJwSVRzdjdYbG95MEwxaC9wdHFI?=
 =?utf-8?B?SzJFMWFlVnVSUE50ZHdyRWl6ajRscmkydzl4T3BzT2JpbmpUb2RkTXZDZkZN?=
 =?utf-8?B?UW5RbmdHenNWcTNjaTRGOU95anVtSDEzTXlFWHZrU2QyeVJCSXlBbmhBOHZ0?=
 =?utf-8?B?Zk9lTU10YllMejBXeVdwTnRxYzkyT2k1MzJ2Q3Q1L0hkVEhLd0JteFBFQmRC?=
 =?utf-8?B?eC8zbmZLUU9TRVNpdVMzUVRVQmIxb0FONHVrRnJJZ3BHRW13UWNucU4vMlNm?=
 =?utf-8?B?ZjFPb0pkUVJDMDRBc2ZWZi9IYzRNNlMvakFCcUI4dGFWWVJDbVhOMm1oUjlW?=
 =?utf-8?B?cHZTbG5GWUIzOFJQNHhieE5WS0RHc1ByS25jVXFTaTk4Y1hJZ3lBNUpKODhX?=
 =?utf-8?B?VjJpTGhKYkEvcjNLNHhQSVI3WkxTL04wT1YyWUN2c0theERaU2hGVUtZU1hO?=
 =?utf-8?B?cTc3S0F1dFFtcjVKQURhZkM4QU9WS2x2T2FtZ3p1S0Y1MEk2NWxBekRBVVp3?=
 =?utf-8?B?K0p1bEQwcW0rOHdFeGw4a2NSd3I0eXNTeVRHdXlmYnFxTElsdW9ubHEzSWI5?=
 =?utf-8?B?ZUVmamEraE5EVE9ub1NFbGgyVmRxSklGMkhDRVFnS2VZcDFlYXAyWHp2N3gv?=
 =?utf-8?B?NlNDMVVZbHFSbm1oTkVTcm91Ri96cy9oVEdKVXFBd1JYWmJ6R0VlMUlnVWJ0?=
 =?utf-8?Q?AmeZZSzy2BWDuwsLnNkyp2wwfSYhE1QZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUw4UnExNEFqVGZ5LzNSR01rdFhDSE1FWnUzMmtZVDZYYytZdSt3a0oxTzk1?=
 =?utf-8?B?bmErRWVtVElKM09wbzhDa0xMbGVqNE9TN0pxT2ZBQU91bDBxSGRiMnpvUnBN?=
 =?utf-8?B?elNBVVhNekdOa254NE56VkNhd0FxVGlzekk0b2NSeVIrcGl1U0Y1SjFPeXFo?=
 =?utf-8?B?QitLbHdvQ3pqYkNrT3gvUktKRUgxbGZ2NUtYb2E1bFVKLzZINW8wMlZ6RzF6?=
 =?utf-8?B?VnZlNEJzanJuSEhkTVNuSUJxZDlHd3VmRjF6T3dialZXajlQbUNMenFadGFY?=
 =?utf-8?B?RmUvQVRUM1F6dXZTY28zUGtyNzdEbHJiQi9iWldXTG1sS1BnWXBZZFVuRFA5?=
 =?utf-8?B?akNvWFhpbXpkQUxOM0wyZk5wT0c5d0VQWjRaRFBjRmhyak9scXFCamNuMmNZ?=
 =?utf-8?B?SVJEYzJScngzTDZ3L1JaQlZwTktPUWlJV083N21GRTZkWEloNEFwUGU1eXhV?=
 =?utf-8?B?WkRiWFlWaGYwWE9PZWRVYllsenpiOVQzWHBjNEIxbnV6S29PTEI1OXo5bTlt?=
 =?utf-8?B?K2V2SllXRG03dmNMM2s0OEhhVXEyNGdUemxDelVzZDhrL2RBcXFvZ1ovNmpZ?=
 =?utf-8?B?aXdySDloeXp1QmVLZWhNdHlZWXRzL0NnNmxwS3dkRnNMNzBuZDV2cS9HSm5r?=
 =?utf-8?B?MUcwT0pJcC84cmdIeTlHdmkxbVJQWXlBWE9vbDFjQUNCWllsVnZTOW00VzRL?=
 =?utf-8?B?OFQzanhuM2dhRStJb3RUWDJkd2FCU21GNVQ3Y0FQZCszUDljVDdpSStBcUNH?=
 =?utf-8?B?YzNGbEtNa2dseGJCanpDUVR6WWx1UVR1cHJhRUQ5b3BVUUFVQlFobVdtT2Vs?=
 =?utf-8?B?RDNuTElwdFljbnFMU1VYaWV2VWRZWGR0ZjdnOUtNVG01Qlk2MjJIK0Rpb0hK?=
 =?utf-8?B?RnUyTGRqRkJlSXIybUlrdUw4cXdMOHp1VmNhaVYzNkhlMlRhcGk1cCtsNVJN?=
 =?utf-8?B?SnpoclV0eERvaEdDMFJYbDJ6VzFnOVVvb2xHUzZLblVrRDBtaG45VEF5bUVj?=
 =?utf-8?B?a2Y1YWNMZmNjaVZ4OVFPbldNVldqYjZLTHNsdGxTMXQ1eUVsa3BWQ3VrYlFj?=
 =?utf-8?B?c1ZRVmVuaDdSWmU0b3FEZjBiaE5zZk1VM3hqVUMwZG1hQlpFU3FZN1VrNjVH?=
 =?utf-8?B?Wk12Q1F2Ui9GT0VZcCtUd2g1OURqaG9ySzVQNUltUy9ac2NEbkhRc29iNnJV?=
 =?utf-8?B?bHpaNUllUTg1MjZGcGIrdDRiNW92VmxmNXlmRlNBT2ljNFhQdUM1bmxGV055?=
 =?utf-8?B?ZmFORWJjNWZEN0l2QWRjSThhek16WmFiTWJaam83UDhrOGQzYnFpUzN0dWFv?=
 =?utf-8?B?dTI2b1dBOEt4OS9qUFY1M3NhK1kzYnhQRXhJc2psSitBaExUMU5sdnBOQ3dv?=
 =?utf-8?B?djVEMWF4YVQxYmZNNU9GRloySzJvdG5aSnBNc1hKTTk3TlBSbFRRTzkvcUY3?=
 =?utf-8?B?Rk9tVTRMZEdiQ2NoQW04UmlocHBtdUtncTZSZHhMcWtrM0d3Q3o3WWdwbFdX?=
 =?utf-8?B?Q0RhZmNNcVNGcHJUUWc4UU43K3ZiaUpWM0lyODlOdXBDRlo0SnFWM0NodkY0?=
 =?utf-8?B?dFlOZjM0eEFPekF1R1plVDFmYitnWmlhTzc5dDFRUXlROTdVSEZ4eWxQRWRl?=
 =?utf-8?B?RUlYR1I2aWdtNHBHdUl1dDZaYVUvaUJ4YWxTR040N1J3QXF0MWxpWkVXbWJZ?=
 =?utf-8?B?QnFnVWhlKzBmTjlmekdVZEpxbSs3Z1FwOThiSjRaWURCQnYvbm5tTEZ6OTVS?=
 =?utf-8?B?ajFodG81NzBnQzczNmVQRk9MY2lNbXEwTGJhRUxRZDE0T3Nib1lYR0pRWUxZ?=
 =?utf-8?B?RVFJa1lBUkRLME56MEtQOGhaYktlYktQaXZLZTc1cHE1dHNaSGcvS3I5cXBV?=
 =?utf-8?B?YzlReEJCQThOQm1FWXFLZVpsbzZ3ZkF1LzBEdU9HeS9yRElUNklFWWNxTGZs?=
 =?utf-8?B?MEExQlRIQTN1a3RyQ0lqVEpKWXVodUFTL05Qb2JVNzk0SDBQc0tNUzQ5SjFv?=
 =?utf-8?B?ckdpanZ6cGdzeUQzc054OSswMGdUdXAxOFM1Uk9XOE1rd0xuK1Q3SVQ3eWJQ?=
 =?utf-8?B?NHJxb0Z4M0ZFKzdrRnZFc2lXcmxkZjBJMEQzZUVlMW82UGcvaTdYR0NsZlUv?=
 =?utf-8?Q?JOdg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f358d0-0101-4f6b-973d-08ddfb78d91e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 14:44:21.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjE2uI/DnqQIrJ5ILK8FhLFu6bYTBazwH6GETFOerHY4QtelCmaZiCtSPQwiQsEikC8R7/4AegKOk6IK+BUaWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9146

SGkgU3RlcGhlbiwNCg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMC81XSBjbGs6IFN1cHBvcnQgc3By
ZWFkIHNwZWN0cnVtIGFuZCB1c2UgaXQgaW4gY2xrLQ0KPiBzY21pDQoNClNpbmNlIGNsay1zY21p
LmMgZm9yIHNwcmVhZCBzcGVjdHJ1bSBzdXBwb3J0IG5lZWRzIHNvbWUgYmlnIGNoYW5nZXMsDQp3
ZSBtYXkgbmVlZCB0byBjaGFuZ2Ugc2NtaSBmcmFtZXdvcmsgdG8gbWFrZSBPRU0gZXh0ZW5zaW9u
DQppbiBhbiBlbGVnYW50IHdheS4gVGhpcyB3aWxsIG5lZWRzIHNvbWUgdGltZS4NCg0KVG8gcGF0
Y2ggMS00LCBkbyB5b3UgdGhpbmsgaXMgaXQgb2sgdG8gYmUgaW4gbGludXggdHJlZSB3aXRob3V0
IHBhdGNoIDU/DQpJZiB5ZXMsIEkgd2lsbCBwb3N0IFY1IHNvb24gd2l0aCB5b3VyIGNvbW1lbnRz
IGluIHBhdGNoIDIgYWRkcmVzc2VkLg0KT3RoZXJ3aXNlIEkgaGF2ZSB0byBjYXJyeSBwYXRjaCAx
LTQgaW4gZnV0dXJlIGNsay1zY21pIHBhdGNoZXMuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+
IFNpbmNlIHRoZSBhc3NpZ25lZC1jbG9jay1zc2NzIHByb3BlcnR5IFsxXSBoYXMgYmVlbiBhY2Nl
cHRlZCBpbnRvIHRoZQ0KPiBkZXZpY2UgdHJlZSBzY2hlbWEsIHdlIGNhbiBub3cgc3VwcG9ydCBp
dCBpbiB0aGUgTGludXggY2xvY2sgZHJpdmVyLg0KPiBUaGVyZWZvcmUsIEnigJl2ZSBwaWNrZWQg
dXAgdGhlIHByZXZpb3VzbHkgc3VibWl0dGVkIHdvcmsgWzJdIHRpdGxlZCDigJxjbGs6DQo+IFN1
cHBvcnQgc3ByZWFkIHNwZWN0cnVtIGFuZCB1c2UgaXQgaW4gY2xrLXBsbDE0NHggYW5kIGNsay1z
Y21pLuKAnQ0KPiBBcyBtb3JlIHRoYW4gc2l4IG1vbnRocyBoYXZlIHBhc3NlZCBzaW5jZSBbMl0g
d2FzIHBvc3RlZCwgSeKAmW0gdHJlYXRpbmcNCj4gdGhpcyBwYXRjaHNldCBhcyBhIG5ldyBzdWJt
aXNzaW9uIHJhdGhlciB0aGFuIGEgdjMuDQo+IA0KPiAtIEludHJvZHVjZSBjbGtfc2V0X3NwcmVh
ZF9zcGVjdHJ1bSB0byBzZXQgdGhlIHBhcmFtZXRlcnMgZm9yIGVuYWJsaW5nDQo+ICAgc3ByZWFk
IHNwZWN0cnVtIG9mIGEgY2xvY2suDQo+IC0gUGFyc2UgJ2Fzc2lnbmVkLWNsb2NrLXNzY3MnIGFu
ZCBjb25maWd1cmUgaXQgYnkgZGVmYXVsdCBiZWZvcmUgdXNpbmcgdGhlDQo+ICAgY2xvY2suIFRo
aXMgcHJvcGVydHkgaXMgcGFyc2VkIGJlZm9yZSBwYXJzaW5nIGNsb2NrIHJhdGUuDQo+IC0gRW5h
YmxlIHRoaXMgZmVhdHVyZSBmb3IgY2xrLXNjbWkgb24gaS5NWDk1Lg0KPiANCj4gQmVjYXVzZSBT
Q01JIHNwZWMgd2lsbCBub3QgaW5jbHVkZSBzcHJlYWQgc3BlY3RydW0gYXMgYSBzdGFuZGFyZA0K
PiBleHRlbnNpb24sIHdlIHN0aWxsIG5lZWQgdG8gdXNlIE5YUCBpLk1YIE9FTSBleHRlbnNpb24u
DQo+IA0KPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRyZWUtb3JnL2R0LXNjaGVtYS9w
dWxsLzE1NA0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMjA1LWNsay1z
c2MtdjItMC0NCj4gZmE3MzA4M2NhYTkyQG54cC5jb20vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0g
QWRkIFItYiBmb3IgcGF0Y2ggMSBmcm9tIEJyaWFuDQo+IC0gRHJvcCB1bmVjZXNzYXJ5IGNoYW5n
ZSBpbiBwYXRjaCA0IFBlciBCcmlhbg0KPiAtIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyNTA5MTItY2xrLXNzYy12ZXJzaW9uMS12My0wLQ0KPiBmZDFlMDc0NzZiYTFA
bnhwLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBOZXcgcGF0Y2ggMSBmb3IgZHQtYmlu
ZGluZ3MgcGVyIGNvbW1lbnQgZnJvbSBCcmlhbg0KPiAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9hTGVFRnpYa1BvZ19kdDJCQHgxLw0KPiAgIFRoaXMgbWlnaHQgbm90IGJlIGdvb2QgdG8g
YWRkIGEgbmV3IGR0LWJpbmRpbmcgZmlsZSBpbiB2My4gQnV0IHRoaXMgaXMNCj4gICBxdWl0ZSBh
IHNpbXBsZSBmaWxlIHRoYXQganVzdCBoYXMgZm91ciBtYWNyb3MgdG8gZW5jb2RlIG1vZHVsYXRp
b24NCj4gICBtZXRob2QuIFNvIGhvcGUgdGhpcyBpcyBmaW5lIGZvciBEVCBtYWludGFpbmVycy4N
Cj4gLSBBZGQgQnJhaW4ncyBSLWIgZm9yIHBhdGNoIDINCj4gLSBOZXcgcGF0Y2ggMyB0byBhZGQg
S3VuaXQgdGVzdCBwZXIgQnJhaW4uIFNpbmNlIEJyYWluIGhlbHBlZA0KPiAgIGRyYWZ0IHBhcnQg
b2YgdGhlIGNvZGUsIEkgYWRkZWQgQ28tZGV2ZWxvcGVkLWJ5IHRhZyBmcm9tIEJyYWluLg0KPiAt
IExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA5MDEtY2xrLXNzYy12
ZXJzaW9uMS12Mi0wLQ0KPiAxZDBhNDg2ZGZmZTZAbnhwLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2
MjoNCj4gLSBTaW1wbGlmeSB0aGUgY29kZSBpbiBwYXRjaCAyIHBlciBEYW4gQ2FycGVudGVyIGFu
ZCBCcmlhbiBNYXNuZXkNCj4gLSBSZWJhc2VkIHRvIG5leHQtMjAyNTA4MjkNCj4gLSBMaW5rIHRv
IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwODEyLWNsay1zc2MtdmVyc2lvbjEt
djEtMC0NCj4gY2VmNjBmMjBkNzcwQG54cC5jb20NCj4gDQo+IC0tLQ0KPiBQZW5nIEZhbiAoNSk6
DQo+ICAgICAgIGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIHNwcmVhZCBzcGVjdHJ1bSBkZWZpbml0
aW9uDQo+ICAgICAgIGNsazogSW50cm9kdWNlIGNsa19od19zZXRfc3ByZWFkX3NwZWN0cnVtDQo+
ICAgICAgIGNsazogY29uZjogU3VwcG9ydCBhc3NpZ25lZC1jbG9jay1zc2NzDQo+ICAgICAgIGNs
azogQWRkIEtVbml0IHRlc3RzIGZvciBhc3NpZ25lZC1jbG9jay1zc2NzDQo+ICAgICAgIGNsazog
c2NtaTogU3VwcG9ydCBTcHJlYWQgU3BlY3RydW0gZm9yIE5YUCBpLk1YOTUNCj4gDQo+ICBkcml2
ZXJzL2Nsay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArDQo+
ICBkcml2ZXJzL2Nsay9jbGstY29uZi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2
OSArKysrKysrKysrKysNCj4gIGRyaXZlcnMvY2xrL2Nsay1zY21pLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDY0ICsrKysrKysrKystDQo+ICBkcml2ZXJzL2Nsay9jbGsuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNiArKysrKw0KPiAgZHJpdmVycy9jbGsv
Y2xrX3Rlc3QuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMjEgKysrKysrKysrKysr
KysrKysrKystDQo+ICBkcml2ZXJzL2Nsay9rdW5pdF9jbGtfYXNzaWduZWRfcmF0ZXMuaCAgICAg
ICAgICAgICB8ICAxMCArKw0KPiAgZHJpdmVycy9jbGsva3VuaXRfY2xrX2Fzc2lnbmVkX3JhdGVz
X211bHRpcGxlLmR0c28gfCAgIDYgKw0KPiAgLi4ua3VuaXRfY2xrX2Fzc2lnbmVkX3JhdGVzX211
bHRpcGxlX2NvbnN1bWVyLmR0c28gfCAgIDYgKw0KPiAgZHJpdmVycy9jbGsva3VuaXRfY2xrX2Fz
c2lnbmVkX3JhdGVzX29uZS5kdHNvICAgICAgfCAgIDMgKw0KPiAgLi4uL2Nsay9rdW5pdF9jbGtf
YXNzaWduZWRfcmF0ZXNfb25lX2NvbnN1bWVyLmR0c28gfCAgIDMgKw0KPiAgLi4uL2Nsay9rdW5p
dF9jbGtfYXNzaWduZWRfcmF0ZXNfdTY0X211bHRpcGxlLmR0c28gfCAgIDYgKw0KPiAgLi4udF9j
bGtfYXNzaWduZWRfcmF0ZXNfdTY0X211bHRpcGxlX2NvbnN1bWVyLmR0c28gfCAgIDYgKw0KPiAg
ZHJpdmVycy9jbGsva3VuaXRfY2xrX2Fzc2lnbmVkX3JhdGVzX3U2NF9vbmUuZHRzbyAgfCAgIDMg
Kw0KPiAgLi4uL2t1bml0X2Nsa19hc3NpZ25lZF9yYXRlc191NjRfb25lX2NvbnN1bWVyLmR0c28g
fCAgIDMgKw0KPiAgZHJpdmVycy9jbGsva3VuaXRfY2xrX2Fzc2lnbmVkX3NzY3NfbnVsbC5kdHNv
ICAgICAgfCAgMTYgKysrDQo+ICAuLi4vY2xrL2t1bml0X2Nsa19hc3NpZ25lZF9zc2NzX251bGxf
Y29uc3VtZXIuZHRzbyB8ICAyMCArKysrDQo+ICBkcml2ZXJzL2Nsay9rdW5pdF9jbGtfYXNzaWdu
ZWRfc3Njc193aXRob3V0LmR0c28gICB8ICAxNSArKysNCj4gIC4uLi9rdW5pdF9jbGtfYXNzaWdu
ZWRfc3Njc193aXRob3V0X2NvbnN1bWVyLmR0c28gIHwgIDE5ICsrKysNCj4gIGRyaXZlcnMvY2xr
L2t1bml0X2Nsa19hc3NpZ25lZF9zc2NzX3plcm8uZHRzbyAgICAgIHwgIDEyICsrDQo+ICAuLi4v
Y2xrL2t1bml0X2Nsa19hc3NpZ25lZF9zc2NzX3plcm9fY29uc3VtZXIuZHRzbyB8ICAxNiArKysN
Cj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svY2xvY2suaCAgICAgICAgICAgICAgICAgIHwg
IDE0ICsrKw0KPiAgaW5jbHVkZS9saW51eC9jbGstcHJvdmlkZXIuaCAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMjIgKysrKw0KPiAgaW5jbHVkZS9saW51eC9zY21pX3Byb3RvY29sLmggICAgICAg
ICAgICAgICAgICAgICAgfCAgIDUgKw0KPiAgMjMgZmlsZXMgY2hhbmdlZCwgNDY0IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogODk0MWU3NWMwZjEy
MmZkZDc2ZGM1NGVkNDVjNGNlOTE3NTg3ZTAwNg0KPiBjaGFuZ2UtaWQ6IDIwMjUwODEyLWNsay1z
c2MtdmVyc2lvbjEtYWNmNmY2ZWZiZDk2DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KDQo=

