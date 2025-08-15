Return-Path: <linux-kernel+bounces-770563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF50B27C65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0673C1D062AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E24F2E283D;
	Fri, 15 Aug 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UrxTsX5o"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AAA2E11AE;
	Fri, 15 Aug 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248722; cv=fail; b=dNeKeBawTTv46EGv33QTljPJACSZmXtbuW601j/tQ8tqMF/gvRNXIkpdT7s8CraAm4CdeQ/sfyszNgteWBgdRfoioDmmyUpYskeTMfErz7ohILT8yzp7FlcFzRqZ4POTgtt3tiTBhboJssthn3ePtKohIjseL3HkN+9UvbqjHS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248722; c=relaxed/simple;
	bh=w3E105ZZgS92RF3p+rxMf4CnH97WG546KfRlvEdo0mc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=af1PvwfKu0cp1U0TZWtqXu0Lr4a+Ul2Xiyh5cNu22HvUqhHG8QMxmgn57xbgkMIllVfBILiBEkl/Q56tXXomDy5xs1uH2zy5Uy2fngTxitjQe1q/W6rBavBZ6B4efI8bnJ81ysM73Iek17+f8iglS0rD4bEMOifkIDZ/j+y6ZmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UrxTsX5o; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9EtesjDrx3Qz3/d9QKPp7Sq8KqPaK7+nq/zsYF2CWwXQydB5iJAqn8njDSDW2bAfQg7F6/v3a3eFx9oRyOaleR7/jBH2XcQ5pKuwQ0vWoK97BzPci7kdcjcI0VYIONrR+dnZP6EtlUJ3AEnQOeYT8ov/be1LzoziUxXyPyd+VpmyWIrhX6LMVq51MgwP1NxbfELwYHWIb2/iiiU5Ky/XrazFos6HxgM29jW6b8dFAIpWzFR8u/GWhQmYBf8n+RsXz1gGs6Ke62mMddSI0KLViugbQPy9KOAHH6ykxGpmF26Ivvi4Bvt0qML8F4oIgyfA8WyA+rRe9Of97osKxuivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vmn0laJSMREI0yXX0pfkTZKZJqlAHDRnbqOulaj3nU=;
 b=qxt0sFNerGJ9M8qq2b5Rx03hfQOMr9EeQDNSSsDlQWo6aLsEgd31P5qqFTK/xlBfCCa/0UdwpXrs532xcarNfiJX641CvRIdKBHRiQOMxDVPjXAyMGFkllzlG7jprjIs+Xre4xBm41w3H6UFabsXobJSevAjsIvDu5ZEc4kPlR8chnyA+k1HrDkjm5rzoBA1obGcwGuhBk2FmK7ihbDTL2FYRRa0KaP0A8SDdfLZ5rjNmUn0vLQ7E1n6U2YgY0DrU58oipRP3LXwkIA3E4cIZ8ZiyrynWgMrunPSHzP9qBi7xoWErnVJdDkmZblxz0FpkWimZ8H74d3/KXJ99cRryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vmn0laJSMREI0yXX0pfkTZKZJqlAHDRnbqOulaj3nU=;
 b=UrxTsX5oLsjeCoNN6K8wZc3JqDFN5n0TWSzHyWgDX0LO2jTMQf+yC+yZ0ap4hxyphoGCHjNl0Lmca7yv6G0vD57j+6VXPY5HbIdm0zdADT+FYlQJnWF2s8qFpLnPjkVTW13Z30LSYPEeovc7lRUEnOtzNZ0+bss4n5s2wDeZCeRFYg32pIk3prTe+sC8oxH8OvT/9sDuj9H4do8XkDX7hl/wKQhI99UGsxNggGlCEkLA3V9gvLUxr+PRl8SWg6UFS3BevrEVp2hUnxE6Yj38+6slre717JyBQTGh4Brbn/ITadSuemprymmcbsaBrnYA5f7BQ2ojtCjBnL2a74XiuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8007.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.7; Fri, 15 Aug
 2025 09:05:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:05:17 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:59 +0800
Subject: [PATCH 13/13] arm64: dts: imx95-15x15-evk: Change pinctrl settings
 for usdhc2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-13-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=1437;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xf7NS/2Kq6zElMKZSQfiAvwHXdppxox9fEsbQ3vz1NQ=;
 b=6fPkWrrKsWBFSkz5TiKxlvtX3yxIxYUVZdFtIFbS/6z1FLhggslYDd7oFGNb/9ZZMpBgoPdsP
 LQq2UlrJU9bCxVz+0fJnpO8uBl0cnWzUQOhn7qLpOSp7NxUgWdTchqD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 69261e36-fb0c-4e39-fa82-08dddbdada02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU0yWG15cXhrOC82aFNJYjB3Qi9YM3FKVXEwcVptR1BGdXhwWE0vTDNrTmlI?=
 =?utf-8?B?RGhjRTdrNEYwSjBIdDRXajFJSjFNd1hQTG50L2Z5cWtnVmY2ZFZJWDdDRFND?=
 =?utf-8?B?YzJQUll5VmhvTDlMYkRiZ25HckZuaE5ydVBmeFhNaXNZODZzNWdxb0syYklL?=
 =?utf-8?B?YU81d2tzVy9zT0hmUjY0c3cvb2xpUlBEK29kOGxpZkc3WnFLMEkzSE4vTXRH?=
 =?utf-8?B?T1U1U3NuN1RnS3FaNFJnK3g4b2RueUJ1ZFFxeHhqMjVFeUdVaFZuc0NWR2hw?=
 =?utf-8?B?TkpaSHNjanJ0REJTeG5PVmNLSnl0UVoweVpOR3lTWDJJaWd5MVkyemNOUHJ4?=
 =?utf-8?B?VFhVMWRsd1hPbXRwdy9rSmtiOURFRkFqZzZJQzI2aXYwMGhwVEdjNE5GcUlo?=
 =?utf-8?B?YkpsQ0syRE16VUNIMExGRFN4anFsZGxzZ3lFTWV3V1BWR2w5eUc1NG5ETXV5?=
 =?utf-8?B?VTRTc0FzbCtZRzNpb1lCY1cyU28rdDg3aEt0TzNqcnlUY3hwNThlaEJuZWQx?=
 =?utf-8?B?bXlvc1hhQWFUcXRrZks3VWNZVHMzUUg3ZVhVS25jbEthcUJONEJTRXFNK1BW?=
 =?utf-8?B?Z0J4c25uVXlTZ1FsZ2s5WXhVL2lrQ295SWpXcm43TFFBd2NvdnBUc29wQmVU?=
 =?utf-8?B?bHk4UzFXMmtPYWhocGdUNitnRitySmhWM2NEWkNLejFEMWQ2eHU2eFl4c3p0?=
 =?utf-8?B?ODhaTTRsWDdQSUNySzkyRnkwSjNUWklTcFNPSTdMSENIN216Rno4N3plVEdr?=
 =?utf-8?B?SkdJTnR3NlF5YUJnYWkzbVdodmMvVWRSZHRRalR5a0xhZDQxN2xTMjZRYUZQ?=
 =?utf-8?B?VFpsRm1la0lIMS9jZk5lZHdBZHBNN0MxdStTWVdyYXZiNFFWblJ0NWNzM0ZN?=
 =?utf-8?B?UzZWUDR2alFEVkdVZXJaMDBhRnI1cEFQSGxDdDNnWjFTbmZnb3ZmSXlwS3dE?=
 =?utf-8?B?OElSTEZaNVZuVFJJNzBXaUJ3N1ZQTDJNZHczT1h0TFZPelpxL1UyeS9vTGpX?=
 =?utf-8?B?Zm56ZGxjbmdNY1hXMlprR0NXdDM1MlArd0ViSUVvcGNqcHNVVmQ5UTIyc2dz?=
 =?utf-8?B?RWs4eHN0YjdYOGdTYzk2bTc3Z004UWVXbU5XTmoxTVdVaWZRdU9yTWRPbEk2?=
 =?utf-8?B?SHFqZW5wQmpuVjNPTi9OMTF5WGtkMi9BVlBLYnpMbERKSk1xcFJoNWVlTFht?=
 =?utf-8?B?K1I3Q1FRM1kwb05ydXRyclFxbFR3K0FnL3UyWFR4RjNpM05kOHJtRlhHSGhF?=
 =?utf-8?B?K2NjVmh6ajlObzhrV0YzS0RJYWFTUXAwMFlDTklhYXB0Tm5ZNkwyUnNXT1JR?=
 =?utf-8?B?VTZKYVZhN1dtb3c1QzJBRDNXa3dMN3RrOXFYQkY2aVpWNERXQjdlSGx0M0dT?=
 =?utf-8?B?RlJvYnBtYmdoWTl2a3laNDY2UG9mRUh2ZjFzSi96MlRtdUE1bkJSRXN3RWNi?=
 =?utf-8?B?Vnl5U1NYZlR4L3Rka3VtMnBiTElDOWhUSlcyM2E3ZFRWeTFTV3lQY3Jwd0ZN?=
 =?utf-8?B?SjBPbXZFV2VxaUpOU01tQWxSbkhBQm9LVVJaUFp0SjZFUnhRS3hBb2ZkQ0JF?=
 =?utf-8?B?enN2SUpVb3NRTFlnSGdhZGwyZHpsWk1UQng5WTQxMkJScjJLK1NiaDF5MG5H?=
 =?utf-8?B?NnEvNERHVkMvV1oxRjRieGk1ZmZqMitjYUdCZW9rT1dFMmtHOEJFaWZneWFL?=
 =?utf-8?B?RGJMTzMzOGZzRU9Lb1BhYlYzNzFSU0FtZnVPRCtXU0hnN0RSbUdoOUh3eUo5?=
 =?utf-8?B?UHJlVjdBT3dMN2J4akxOS0FIQ0VVTkg3azhNUFpJbGNzTm9oUGI0Y044elF2?=
 =?utf-8?B?VzFzTllEeFR0bEhFMmV1djk4QThnRmd6ek52bUxBOTQyNmhiaTVWTGdRU2Zq?=
 =?utf-8?B?NkJQM1ZVWlM1WlI5UEUwVWJRWXliMUtSRHdVc1RlWFFPYXlDTk90SmF6YXEw?=
 =?utf-8?B?REVmMmVwZWlnSzZZRjhnNjYzOGoxS2kzbEtDZmE0VzB5R0lRRE9oK2ZDRHB6?=
 =?utf-8?B?MG5rWVZWVEhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXgyaWRaMnJDdEdFdlFHcmx2UDVXb0FSV0Q2VWJkdHNXRTBnWEpjWUZmNkc2?=
 =?utf-8?B?Z25xbmxIVnh4MFVkb2hCWXVid1ptc3hqdVBRQzZ4NnNMZzA4eTJzQURoZmlw?=
 =?utf-8?B?Si9reEhZSnA1Q3RGUTB6QnA3dCsyWTJaRk1US29rOTZpYjdSZFZFYk80cTNK?=
 =?utf-8?B?TmpiZ1VJc3ZVZVFhM3Z2S2lmQUpORDF2bzJSV2JDK21uanJ1eWQ5OGlzR2hs?=
 =?utf-8?B?dzFaUVZZOVUzVHNFd1ZHVFRzU1F5TEo1Nlo3Z3B1ak5BNmViOXBRbDdhK0tP?=
 =?utf-8?B?Y3FmR0JBa3IyYXZaRGRSeG1Ray9Hd3RkbmVRZGxOZGsxb00ybzFYKzliZnJk?=
 =?utf-8?B?M0Zsa0FHVXJMNXNSOW5HamVGN3UycnNCSXMrRlR6cXJXcUE4VDZPcDlBUEd2?=
 =?utf-8?B?L1NFdWhHU0ZURjdLZ2R2ZFFUUERnSUVLT3R2NnlqMFFLT09pUXVCNitEejE3?=
 =?utf-8?B?UmFtZDRPcUo2Y2VXdG1NRUJHcHhYdUN3dFFzY0V6VXFoeEl4aVJqaEFnZ2pX?=
 =?utf-8?B?ZXNCVW9KcHVrYnBqTjJQcmd4Yk9QTUFVQU5GNlI2c2tNOFoySnpjd1dKZTdz?=
 =?utf-8?B?MWlPcDZaOCtIRzcrS0Q0ZjN3TzZoYlVKb3B1MVRsWWIzc3FXOUJDMWFYYjZC?=
 =?utf-8?B?SDNuL0FCWjVsMEo2enJSZWFOQW51bVFEZXZxV1N4UDgvN0dRTTdGaUtvaGo2?=
 =?utf-8?B?TDNxRmRJV1A0U3NUbEFiUVFjcDRvekNGM1ZCalNmOFNYVHBleHVBQTdXdWxX?=
 =?utf-8?B?ZjhNNjNJN0drbzMwbm9BZEpERHcwOXEwaDNXSmFHcjN0NlMvMTJsc08xUEV1?=
 =?utf-8?B?K0Ftb05wbmU5a0QrM2gxcWJtNDlha044SjAwS0JoNGdLNjJrTk1Qdi96VGE5?=
 =?utf-8?B?aENCOXZKb2JHa05RaGRRZkxvcUJMU2E4N3ZQcEFXUC9ocEl6dW1JMytpYVhW?=
 =?utf-8?B?UDZiUklJMHYzYzN5VFVvL0tiVHd0UTBacXQ1RWxmK3JkQ3EyL1c4cVdBblZ2?=
 =?utf-8?B?RHpCWmxoVnFtK2R0ZmY4TUlUNkU5OS9LQlJyUFVWcGd4YnAvY1BwdWtSa0hj?=
 =?utf-8?B?MlhaNzQvNnJrbENzb1kvL3R6a2R0VjhoSjFQazJIWGhnK2FBV1ptdnpWZFRu?=
 =?utf-8?B?c01UdzUzWEUyM2dJdXFSKzc1L3FiaWRwRVJhN2lTd09YZzFUVXZDSFN6dU1V?=
 =?utf-8?B?UWtJcVRzZFhtbkQwRnQvTGdlN093QjJBZTR1eFFIeWs3SFFzZUd6TnJSbTJ5?=
 =?utf-8?B?eGdtRzc3S3BscEZSZmQwRUt2SXNLSWhaRE5mQnJjeWdyQmRqYXJaYUcyaHda?=
 =?utf-8?B?T0lKbG1DN2l0V0R0QkRYUmtIRXY3RkNwUE5CdVovQkVvUmtOQkMrTnF1WEc0?=
 =?utf-8?B?N3V6LzBqTmZyTHV2Q05PM0JCa3NPaXNjK1Z1VW5wV3VrQnBqKzJ1cGJYQTha?=
 =?utf-8?B?b1VBN25ySEprOVZ3ZWp5cG9aeG0ySytDZHNrY1IwakwwVktoNlRFZVZvUGlo?=
 =?utf-8?B?WHlxc1VqWjAwdndoSlJsblh5dmlkeDdpeXlDbVBqQlcvR0R1eGZJZWFiU2ow?=
 =?utf-8?B?SHhJOWFPbU9EUnBML1pBeVh2UEM4bjlEWVlwbnZLVjhpZUJJSnVZM3RYeUVU?=
 =?utf-8?B?R3lGaEgxdWdKRUk1aC9mWDQxZ29oNGtDYkErWHJUTnAxbTBJMmRsaFZRL2lp?=
 =?utf-8?B?cXljVFVLYkNiS0QzUXJHK3JheVU5U21VbVhoT05oOWY5RlNHVHhxcm56a1N2?=
 =?utf-8?B?RHhvekl0TzlrR0VOcUFFejdkOTFLM2h1emg5UXdqa2tUbks0bG9taTZlNjNM?=
 =?utf-8?B?cGFHMFcrZXN5NHpIM1VMTXVuUlJFRGxwdmlxdjRpQnJPRzN4M2dxUXlqU05s?=
 =?utf-8?B?VHdVdlBDU3BGOVF1SktPTjMwOXp3djU3S01uUjJCazV1d2JQVkhRVFl5U1Nn?=
 =?utf-8?B?ZTBBZnAxMU9MMU9PVzFBdVkya2Q2SGhQWTRWVFlTRlFhRCtDTFRVTWRFYkhB?=
 =?utf-8?B?dWNkbGJOblNtKzdkR2xZL0NVeVVRelJkOVlxSy9lbGxtaWxiVDd5YWdVK1NW?=
 =?utf-8?B?Wi9LTGhSemJtTWkwdDZvMUticFpOd0NXNHR1dFo1emNkZ0kwNFdiWnlVcXdw?=
 =?utf-8?Q?bRfdLfo/nYB+nwUglnbzdSPRh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69261e36-fb0c-4e39-fa82-08dddbdada02
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:05:17.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6w6jXsByO7iBQqs6l738D3+oGI7j1HoMbNtLX1tHqpucw18nmOMIG3dqNsProEQDa5YB1tk/Mmr9/8X6LUqeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8007

From: Luke Wang <ziniu.wang_1@nxp.com>

The drive strength is too high for SDR104 mode. Change the drive
strength to X3 as hardware team recommends.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index de7f4321e5f9d7d6a6c46741d3710756dd2b69cf..3c23022923e68fe0f5205d322ad6f8834a46dc56 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -881,12 +881,12 @@ IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
-			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x15fe
-			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x13fe
-			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x13fe
-			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x13fe
-			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x13fe
-			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x13fe
+			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
+			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
 			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
 		>;
 	};

-- 
2.37.1


