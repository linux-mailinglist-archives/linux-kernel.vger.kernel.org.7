Return-Path: <linux-kernel+bounces-774480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19522B2B2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDC8628811
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146632773DE;
	Mon, 18 Aug 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hw/dGnSt"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CD276026;
	Mon, 18 Aug 2025 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550127; cv=fail; b=TwXbtZxsM7PB+U9JRyLTPifBK9TphZTHaTGEFoqNbI1Qm53n2B3cU6tXfs+r0LaAR04BHif6rBWqYVEmHWRoBPVYlzyz89bIYG3c8wZb/jtULOKtrGoBcN9LZ/6+117PDZXHeGHljrcayTM4WawWKz9Q4UXXF81mUe5Rtjsfd3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550127; c=relaxed/simple;
	bh=lH2L3bYy6MfNeA0NfqxHq+g58Wapn4xU624nZWx0zms=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BCLbHxVCgEziv65MXvOcLqh0iy2QqbBDQ/QTQN+dLqsnPsVmmkmkb5bo9dcrKN9Ku4xicSKjb66J5qSvfI5hGeB34t0PVnMxsIR4q7w8bz4cTss0tOvzK/Nb39auP8GFjW0xiQykVkG03E1Z42Lec6g3dMmUcRpSc55Ho7ls3aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hw/dGnSt; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyMHwbD0Ni+RZVtHaWLyGcQEAhCEyjB3eRyssr4XLCxDHSl6cVHATR3yQaeh5MTPw6V/2uyHYINN4BlsWUEwWSJkioHNa1KoIV+BYDq+5Q+3vNs71hFXwlTH2OI2IPOxERwQ0uFhC1pbsvn/Oy6t8qblK75HtGAqNDBgaDd6vA/HHViniU/vDIwIosoHWF6Cc1UV2CK+cWXTeUCQ+WWWuvYj1kxM+zSDWUi3qco084av+kYNLejXJ2zL6cLIMtzAr/kg+IH+CYgrrlqlBrTCc0q41enlK4Z+Na/ZDZAqOv4K685CZ28IgkDfHhkREN6kqPuGI8SIsqNG/GAir62yCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DOel1+8uGLofgegBhW0BSRWWtLJtO7cNXN5Ob+IJeg=;
 b=a/+qw1I+vFJU/a3PlMTe6v5owApyLjDqaG+ZM+B7YUZOeiuCGeM+ov/2XoNlQOsLusuGkyGkeQr31fEIy1uvB20JLQxGSGia5aOUzZyStpfe8MWYsn44Qo2tEdIdSQGc+rdzotwlC/cR/TQvPzqBnyqVr+Q9uR3QF/I/SNbjW4EkTYXkmqq4I7zLXwNyQRqCnjgcjrOZw9SFdOY31mwulNBS3RHlC32ph1qYR9tZwgcPoYXYKAfrWat/WxxSl6eZoK2V6z7KvEKDOIWh0UrE0truZijvGA4uvjNEGQQxOlwf9e5cWmMHsoERDdUK2phR4fcSbQ9MZyR0wNdoZofvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DOel1+8uGLofgegBhW0BSRWWtLJtO7cNXN5Ob+IJeg=;
 b=hw/dGnStrQ1cunEZ4MPDECAtmKGhrD0PXYVRfUtBiqG02ZwSsgeVM9hiUSHM+z96BDs73g/mqQIgIJff/heNV93EJuE7mVcp7sCJL0ITSqUjtmtzG5B30SWaMCHdQi9KdmVoKbhqMf5wCmRB6/0s+9lvvcsGEaDxCx1EhuOuFLsMIfJWSrwSF2MPCGbqRguvlPjplwF5ELd0lc0+jDe6Ik11aAu/PyRBvjbXw5dukUykxYnFVRzcekB40Wvb6J3wVhc9kRowZdF+X+2djRdiS4EtWSYE5BmvjHUYkjZM8XZAd3qqURyrEBBq+5SipqtEqyQIj/LGYjqTk+1F+oUc4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:18 -0400
Subject: [PATCH 07/15] ARM: dts: ls1021a: Rename esdhc@1560000 to
 mmc@1560000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-7-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1037;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lH2L3bYy6MfNeA0NfqxHq+g58Wapn4xU624nZWx0zms=;
 b=VosxkOwubhRTyDD8ehsRsXdc/wPCoRQpoAyB9KQeaaD4kWi5Ep9DkAgy1YA4SKgX3ntorLdgd
 X6amz29SgWiA0Dv2GWvR90xfe9TB/+jA61QZ9cmduauf+7oqGBV2sgB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ff53a4-e08f-443c-2684-08ddde989d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjUwMmJQVnkrVWZpUkJzckxQMGlWb2ZqWm9HdlREZ3ViZytUVnk4a0x4dEdp?=
 =?utf-8?B?V2lkeDV3eFphRVlvU3Z2UDRZbmQ4ZE9pM3d3Q0NabXAyM3dGbUJYN2JTT3gw?=
 =?utf-8?B?OHNMaDI0em91L2FJWXhHTWFQaVFNRGpDSTBJZ2pPbDJqMU5EUEpxdVlUajh1?=
 =?utf-8?B?K1MrSzdQd3hXNWxDMjVHc1d2RHRScUhTMEx4SzhlOHpkTk9qNTJONk14Tmpn?=
 =?utf-8?B?ZlNEM2dxNG5ETlF1blJCSWhuUVFYOHNMNXhZc1hXRGpuY0F0eTBFQjRrV3Fy?=
 =?utf-8?B?TFNwQU1jN0FSUm9pODNmYURrSFVxZTlhWmp1WjRUUzBTWE1TMnpVR3FSYitt?=
 =?utf-8?B?MVh6MHZHSzZ1cFBHWHE5c2M3TUFxOHJYcFVoMTBodTF2QVFzcE5CMmpJUVd6?=
 =?utf-8?B?RWE0YWVZUVJRZTE4eVZRbjNNRVpRc25mN1c1Sjd0SW1KZEpsSTdXbTR1UkZI?=
 =?utf-8?B?cEM5b1h5SmdzYkVTUkJHS042WDJocXhRUm44K2VjTWd6TUVyampSdWVBVnBJ?=
 =?utf-8?B?a2tGRTJHN0FjMjVUU3dQM1NYZTRZOE1xN1h6ZTFWQWRsRWE3VzFrRmkxNytE?=
 =?utf-8?B?TklXMStHak41ZmxkNnk2cUp2WDlrSThOa2ZuRGgxYm1PQ0dxWCtOQ29GazZ4?=
 =?utf-8?B?bTM2QnB3MndkUGp1bnBaTk53RURkMTlqQkJzU2xkYWdZZTNtcHRWeit3ekZU?=
 =?utf-8?B?enpuYzEyTnYwdVA2NmhXbWpjWFFDTnZGTnVOWDFwNGw3enR5eVdvcTd4ejVK?=
 =?utf-8?B?Z3R6RTg2c255VDRrYVdtSVpvTkVCTk9Dd1BOUVJnNFk1U01NUUNjVG9mWTF1?=
 =?utf-8?B?eCswdGdtUElDeXBuQTdKQ2o1ak9nY0hCNUtVd3AvMmJTdHQyKzFrcWRLc1dV?=
 =?utf-8?B?WUlDZjRwK09sblJCVjRETWNOOW4xRUdnRkZMcVozZTdnNG1IcFg0T1BHMStD?=
 =?utf-8?B?NmFIQWtIMWMrZUo1U2ptRUFsc1RnUnFadGI4OHhNRkFLRWVHeVZNdFdCeUdV?=
 =?utf-8?B?STFxQjBQL3d6WW5BSnZLb0N0Qm1RNExUM3BFbkpybVlNMG5NV3V6R1FWQ0pW?=
 =?utf-8?B?cWFrMEZHVnBVc0NzczRpNWRmL1lRWWN5aWZrdndNUldSczZ3VkZWV2xUQUxk?=
 =?utf-8?B?L2Y5MFVDeHJRMWFJaS9taExTZ2pGc04zd3Z4SjFhcDBsM2NCbU5pK2tYYWV1?=
 =?utf-8?B?cms5MFgyVkxMN3dRSmdsOWIvUXhxK21HRmZOQnN0ZEduSFMweVpVUkYrbXc0?=
 =?utf-8?B?c0dqOWRzb29KTGd1ZzVLZngzRXBHR1I4MkU4djBxVlRoTkpXRk1Wc0dGQWY3?=
 =?utf-8?B?c3Rja29jWmY1MDhOZWNBWklsdkJWeFpFQVlOMllzcFVvSW4zMFdYZ0wwU2x3?=
 =?utf-8?B?ZStpWnA3UXBTN3F3RnJPWTZtdXJsbTFPTVIyWDRMTDlIZ1lPNGdzdWFtKzhk?=
 =?utf-8?B?d0JYTWxGem9EaWhBSkZOU3ovSFl5WEZZWVpEYjNoY1JtcThhSEVKQ2tKUkVw?=
 =?utf-8?B?U3RSOFFmdVBESVlyZzZXd29XM0pNSXJNdGU2VnVBS0JPZ1JuOG5pT3BhNGN4?=
 =?utf-8?B?WmZ5d0NXQWtLRU5rdFY5MEhqMVYyQWFPSEtmNzhIUGh2eVF3MTIrdFlKdTFG?=
 =?utf-8?B?aWhtTUY4NTNZZUVpL2dtaERTNTQrRlQzUUZDYXFWTGRFOHMyTit3am1oajlT?=
 =?utf-8?B?S0l2czh0Z2JwaXR4UEZ2eXBCa0cycFowMWJweUwzbDlaS0MxdGg0dSs5cVdZ?=
 =?utf-8?B?aEU0cXJ4K2Q2Ymx2TTVqNldkSm40N0FaZG84cTdBYzdwUVQ3WXo0YVpVME5J?=
 =?utf-8?B?MmFQNkVIc1hCY3l2dVVOUDA2QmRLRzhWM3JIdzFLQnV4RFpON0YxK09TVTdK?=
 =?utf-8?B?RDR1NkxySVdocDBtelA3MkpkQmFJYWNFUjlJY2ZkZDlPNjlRWDRuSnhLRDB3?=
 =?utf-8?Q?bUKVU1fiPzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTd0aVgva3FMT0ovcm9PblgvQnRVQ25iNHcxVXlpUFNIMkZnVkFXZWZrUC92?=
 =?utf-8?B?QVZyc1Y4QVQrYUw0dzFlOXAwMTdrV1o4YW9teFVNdlZnMkpmb1FmMEZwbTds?=
 =?utf-8?B?ZWV4cWl4T0IvVGZBbzJZWmFVTENDZnVkZWpyRXR4RjJqcW4zM21kTjR3bytl?=
 =?utf-8?B?RFo3b2QrODQ0QW1kRUQwN2lEakFITUxIVGVSTG8vYnVpb2YraUUvMFpqTld5?=
 =?utf-8?B?MFNXbTZEaUxnVElhaTlSZE1CT2FsZHQ0aHA5bzAwUlVGU2Q3M0lXU21WckZH?=
 =?utf-8?B?R3cxMDNwaldzcVUwR3ppdTlOdkYxS3phVzdrdmEyYkxzVWF5NWd3OWJ5d2dO?=
 =?utf-8?B?R1h5VEVtZnVQRFl0b09WZGg2c0VLQlVoMGowczZkaXFTWGNiZFNGNjZLWDgv?=
 =?utf-8?B?c2xmWUdBd3BqSVBXK1FMdnVRQ29Oei93a3NTeGdpbjFHZkR2N3ZxbjlrR2l3?=
 =?utf-8?B?ZDNvWFkvUXRXUnBoajQ2Tk01VThvYTJYUTBPd0hqSVpPeVFGYVhZd0dRUmFF?=
 =?utf-8?B?cXkvbzBzdWtoZEtuV21jY1dDa0hIeFM5Mm1tTm81K1Nzbjhhcno5Vy9EY2Rs?=
 =?utf-8?B?WkQzaGhXeVFFV25DMlpmWjltQ3pWclZ1RVdhaXBYZ2ZpV2U2cXNGQk03T2ha?=
 =?utf-8?B?YjNuanVoU2VIK2NLR1FHVUdnSkZ5NHp1NjF0NXk3N0tENFp1ZFdhU1MzZ1JN?=
 =?utf-8?B?THV4Qng1TW1obzZBNGFZYTErUENNZE1qQjRUb04zYjhZbFhvd3dITzYrTDIw?=
 =?utf-8?B?OXJZTkhlMDUyQ094emFreFdWZmVwZW5iNzR6NmVCaTlPM3dpVDAwYVA2T0ps?=
 =?utf-8?B?cjhBc3JzcG12K1VjbTdSQjU1c3F4NFJUb3l3eW9ZcmRBdDRvdlVIWkFGTXRM?=
 =?utf-8?B?VStsb253UkxkRU9KaTV4REVTSmNPY2poYzdOUU9ybmpOck1FQ21JTW1TUDJR?=
 =?utf-8?B?eEdSN2F3bU5OR2preXVQWUxHQnpIL2ZkYzVzYkhMQ2xnT0F4Um5MMDU0Vzdm?=
 =?utf-8?B?S0xRKzJ4VHNxK2cwcmlxWHRsbi9yM2pSYjJrYzFZMVhTZEZreXNYSFBQRWRK?=
 =?utf-8?B?cWd4cTFqZzUybVB4T2JFTjN2cG95NWhrU25jUlFrdzZSZm9KQ3NnUDRzWUly?=
 =?utf-8?B?ckFOK0UvY0d2N3dzSXZFSFpoMGczNjJ3bitFYjBZckhnRmJhYk85ZGlXU2Rq?=
 =?utf-8?B?MDRMaW4ydWp0MEdrTDNXZ2h4bjV6UVZaWDYweFJzZ2lBRlNoYjYwOU5tZnhG?=
 =?utf-8?B?elVGaDE2U3p5ZnBZK2k1Nng2eUk5UVY1bUxCeDdyWnVJekRic0thNUZHeUpY?=
 =?utf-8?B?WWxiYTVJWmFhRUdYdm53RmY1bXRETEt2ODI4OGp3RTE5ZDg3YnVjbXlNTzBB?=
 =?utf-8?B?TEd1bVpVT2wyOUFtQmorbHk1aHJlWkhObDZ2Ym9pSStpTkVkSnVDTElId1pv?=
 =?utf-8?B?Yll6TGZxR2xIaEZYN1ZkY1B1UXVKV0NBVk1lajU2VDluUHRwdW91SFFFS2Vh?=
 =?utf-8?B?cy8rQWMzZllyY25maW1oMXJlZnZZbEdaSHg5QUxZWFg4ZDNwRENkbHdYakdO?=
 =?utf-8?B?WkZRVXZFZjdxTWVxZXJqS3lUU3l6WmMyUWk5bndFb3pGYWFjblpSemtwYjVn?=
 =?utf-8?B?K3JtYWFoczFHTXRnMjdrOWwyWk5xblg1MFVmNVlodW9QejduNHRCREROOXJL?=
 =?utf-8?B?L29DaEFXWFAvYjR4bmhqLzRYSW1BWkd2N2FXL1RjamxDZzM1SVdCcjRTRFBy?=
 =?utf-8?B?NnQzb2hXOVJzMHZVTnVsRGxFcFBId01IOFJ6L2NEVFhJZy9hZitjNjFRSDZy?=
 =?utf-8?B?Nkw0QTBFd3I4bFdKYWlQTEFpUmxpMHhFMThQVUQ4eHVjWW5hR0hCVU9LWDNo?=
 =?utf-8?B?VXlvOENhYTVta3c3YndOTDJVRE12dUoyd3JKMFM1RzBxZEFuaWJBTWVnenN6?=
 =?utf-8?B?UnV0MmdOcWdCaTFaUkNUd29jZ2FhREdQb1UreUNORXdVMmFhYTV0TzhwYXkz?=
 =?utf-8?B?TGRoN3pXRjJUUVBvL0tUdUdDWEJ2ZU0xLzEva0VsSHBJZlFiN2RHYXhQM2ZX?=
 =?utf-8?B?aTFySGQ0L2p4WkVCSXJtU2xoa1lNUXpqbTJRUEFrQ1JSYjFFdzh6b0NBa2ps?=
 =?utf-8?Q?+JI7zWrceLdt1o9bevwjbuhFl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ff53a4-e08f-443c-2684-08ddde989d4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:41.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLv5cEBfvBF29DbtfSkUPZ3TtgmOkoZouB+GtxZZ40uGKKpBGcmbo3YdPEcy9mQt7OlbxtFKHiLvF7/nTMLx/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009

Rename node name esdhc@1560000 to mmc@1560000 to fix below CHECK_DTBS
warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtb: esdhc@1560000 (fsl,ls1021a-esdhc): $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index d095c6107745d75b108a430a5eb15e4f2511e81f..3921d9c4912713064dec1e10ac00cc0916d8974e 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -154,7 +154,7 @@ qspi: spi@1550000 {
 			status = "disabled";
 		};
 
-		esdhc: esdhc@1560000 {
+		esdhc: mmc@1560000 {
 			compatible = "fsl,ls1021a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.34.1


