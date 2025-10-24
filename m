Return-Path: <linux-kernel+bounces-868956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F50C0694F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74D544FF788
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEC13195FE;
	Fri, 24 Oct 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZN8c/x4N"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769153176E4;
	Fri, 24 Oct 2025 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314051; cv=fail; b=oiErIdtC1ypLWK/LHrgA/ScIMx1Ty0eUIA/cV/xI3BZHztU7DDjBG+78YlC0t0jyYQ4mNS2n2x/c4ypvABnwFann8XP+b5r6r59Bhh+uwDs2Uzjx/m/Uqb2d325lwSoy1T2Jip5SZMJS1B8uUO+TfCS/HIm7diA/ciN7bZbq33I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314051; c=relaxed/simple;
	bh=qq15N8T/4pI8Qv7FJ7D9BQ6XV0kOlRjurv9hDu4vBgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afNhOFuKFJTbMIy2K0ZuWaSHvGN5tW6Ntuye1buuyml4B4YDz99gwfyYRmO83NlvnnceumURFCPKp3sd4ufqmSITfrKJx3Q46ezaXf0Bsod4gnkQ43lYnMYnSulE2FBHjcPVb8lnKiHADe91U7XblneJ4QvG+B6hooC+6HepjWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZN8c/x4N; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOh3Gor3lyTB2mgfnXN8ykxs7lsV7W62kj04WhL/IQBoHgBqvGPjCXi6GoQ3P4o8GxjhOVHbJjvGF3NP/2H+K8Kpa5dYaMcYNRMH+4GUtjU4Zv6FaVQ+gFGOJj9RBe0r1Y/3zOHl4iecadlEZWiK3TAxqI7Noha2F6lHYri0pYYj2TDieDEHhGS7gkbQ4xdywhC51w155PzhYtMXSuA18fZXDebbB8F9L3i8YoKCHx0J361AAJMBwDx7OqKrTlav5FkEmdWPbky+jC8NB0quKqg/4hfZlrGI/q+5130O0gh8GpjggTjuGeoGwP/4K5BN/i4AWabhqK5fFFVPHERchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMZo2Hx3K4Ty9XeZvIrJ58R3P0UaMJ1kFqUPy71LBco=;
 b=mmj/IASRCJeix8f0Hrbey7MdojwYPteGQwCSIey4fJWqr5Inssh8cYU+PQHvWSLjkgeN+gC2Z6Ai6n2/rsdA1n6NiQyJsRoyS/3Z/fBIoLhkRmHj4ZD+bwQ3aKZPnQzYUJ1X4kA4YcGMrTN+Du8nHFL3/k7IRPURMXk4iyS301yK/8jbeGqBpZCR/Fvrj3EBuWpbmYtOBwliemD6V2Vtk2EgN6UqwPag4hrnAZ2/Awe4tyLL8SoDZFttQhu7ymIz/GdTKBElqmlRhPj1d4k3IXM/lzMvRWoW0RMeKs+Xy/wPtLoBW0pfN0e/8hZf/gu630C5cSajcmqD4f/LyAlH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMZo2Hx3K4Ty9XeZvIrJ58R3P0UaMJ1kFqUPy71LBco=;
 b=ZN8c/x4NwRg0WKxLQk6vp0m+A5R6D5z9NARHbP0Fd+bAXIM89ajuGGM5BlAecSIHyUyFYdNdltzDAJVUqIzpEybW7pTxJ+Qeqi3GbZXHZ9CIemYnHiTqC+7XNH+68bL/snGgxF3lHl8XCQ0kdSgZfvNhdNlKiKdGdcF4VJVHhlGvn0KraGYfesBVqSwo9tfIfaCFu48tBMqBu/Vpmnl+j4nD8S2ya3MBd76BQeJncE3ZfCqPPFfvW4c1KTcwzVx4pM3pPzSQv6ewhHw0Q4dP97a5hKK8YMzvStXGZMQ6Z3ag1TIpOtWYLSqQLnc1gTtY9VEKn3m2ug9BQqFd4IU2PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA4PR04MB8062.eurprd04.prod.outlook.com (2603:10a6:102:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:54:04 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:54:04 +0000
Date: Fri, 24 Oct 2025 09:53:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	kernel@pengutronix.de, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] Add vpcie3v3aux regulator for i.MX PCIe M.2
 connector
Message-ID: <aPuE94zh+381yeMm@lizhi-Precision-Tower-5810>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024073152.902735-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: CH5P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::12) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA4PR04MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 82860eb0-939c-4331-7c3c-08de1304cb37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2R1Ny9lUS9VS0VKRnhMWEMzdmxEMS9rWU5jYTAxM2JaTFRxRms4MkJQbWpY?=
 =?utf-8?B?eDJWUnpiV3k4MzM2TGRyUHV5Qm12dmdkQllkd29Ub244b2xNQUVlY0FEdUFQ?=
 =?utf-8?B?aEh6U1VtR1BkTHJMWmUrS2p6MEVka2RTazd2a3lmcUlNUnpHbno4ZFQxRk9k?=
 =?utf-8?B?RnNINjdXVEcxcDVZd1VlRDE2L21MSU04UytzQklWeVV3VnZpcWJ6ZndaQmJi?=
 =?utf-8?B?QXdLbnNndUpGdUh5MzBxaU5TTWNlWklaZmdDZkdWNTRmcms5ampCM2hzT3pH?=
 =?utf-8?B?Y2ZhdFVHWE9XcHRoOGFhM2JpcFBLYzhuakVLUE5qVnFiOUhOMWorUjRORTB5?=
 =?utf-8?B?M0pKT01SNnc0aUNzYzRLdU9PWktFRCtqUHVnNmZJYUhyMkRlNy80N0tsNFlH?=
 =?utf-8?B?Q1ZpTEZDektEL2tHWjlsNjM1dG1WMG5KNUlyaFN5ZDUvaC9ySFp6SDJFTHgz?=
 =?utf-8?B?ckk3VCtDb0N3bmdydktPUHdPWStWK1hzOG9tZmhIUWVqSDVzN2NvRUVYUHR3?=
 =?utf-8?B?Q3VYSXFIcUFsRzBDOVJLOFRZaDZ3WEhjMEx6ME1HUW1aSjlQUkUyWWFvaFYw?=
 =?utf-8?B?eWVCSWsxdDUreFZrcElsN3hIQTcxR3pVZloyWG1zVmdKMUp3VENOb2NMdmli?=
 =?utf-8?B?eFVab2VoRGVmZjlRV2psa2xNdnQ0cHcrbjRHUXRtejByVUMxUVNlVVdnUldu?=
 =?utf-8?B?anVPTWhXY2N2QkJwcVI2bnE5T1VCNmc2Smk1ZWNMZUlKSmgxd2d1UXZuZjJn?=
 =?utf-8?B?QUJZaGs3bENESXVmZ2U3em9sQ2dnSEp6NklaclFBKzR5bWRaRWE1QXhMUWU3?=
 =?utf-8?B?K2RvaHdxYjRyUlVXemJYWi9UZUk2SkJWQ09ScExBaUpvb0psT0x3N2VoUWtq?=
 =?utf-8?B?Z05SQ3lTYnB3cFZMUDkwM1pCS2tJVTRZZ2djcm9jSWZhUDBXZEpXd05GcTBC?=
 =?utf-8?B?UEZPd2FTWEtwMXQyUS94UC9WQjdzNVlmdUd2WXZ6UE8zU1lTWW1TbGo2TkRx?=
 =?utf-8?B?RXlOYmRLeEdGTlVwTEE3V2Rxb2dEdHU2SFd2REpuWEIvMnBDZ2lKZ2s2cXI4?=
 =?utf-8?B?YUVkUWpEb1hGTXdJQ1dLVm1ocTY3TDUzWWhMM3BFQmdBZFRuSTBDeFF3YUox?=
 =?utf-8?B?dk9xQSt5Y0NsakJnb2tzam5kNFdXMEpFNmplMHR5RXZDUU5jS3Vybi9YUDBT?=
 =?utf-8?B?RnR5ZXdJWTN5ZEZIa1EvM1hqWW04d0UvZ3dFVEVITUxmZHlqeUhCZGk4MjEr?=
 =?utf-8?B?ODZkendSYjdyNmpYMDc2Q1hkbCtLckRPbW9EWEpHSnBhMW5HWHlUOUhsNmtm?=
 =?utf-8?B?Z3UvQ2ZOKzBHTVRySHJSQTFuTm1oWjhsUEZoYi9hNHMyUDlZSkhtVzZmMFNH?=
 =?utf-8?B?V0p6cXRlQUw3L0YyY2pVaFU2Yjk3TTRTMU10TlhoYWI3bFhEaTNQRFQvME1m?=
 =?utf-8?B?TW5yYys4SkZ1Qm1BMHFXMUQ5K0hIZG9DY2Frb0RGTS9mL0VSU3d0c1hibTZJ?=
 =?utf-8?B?ckZRZUZKNFNrMHQ4R0tIYnB0dWZZSzZPVGc0a0tJTDdNQ0h0NVNyNE1kUmx1?=
 =?utf-8?B?NGdzdW9LcFk1MEt5M3NISEdzQTBPUU5IV0JZYkRWc0JLdE9BRWZXK05BZkl1?=
 =?utf-8?B?QkY2b2QxRDI3UkdQRi8zZjZHaEJKZHZpb1lBdE91b2xMKzNmOHZqcG1kTnlr?=
 =?utf-8?B?L3owaW53YmNHYmJJZ2NiNUN1RUNWNHM4VllUVVY0SXRic2FkQU0wWFpWUjc1?=
 =?utf-8?B?WVNWakRsNVhVZzVzWWpvNWp6blJlTjhuaXd3Vkh2RElQUkdLamVKRTdLa25E?=
 =?utf-8?B?VmtGQ3lReVdPcVhZY05VUHlVR25IN3pJWUhUVmIvVm82VlVIWFltc2duQkZu?=
 =?utf-8?B?ZjJ6M0RwYmhWMFdNb2gxU2Q3SS83aStvVkpDQ28zMWFYN1EwTWlmTDNVbytB?=
 =?utf-8?B?cW9lWXhnT0lpWS80THBER2JOSCtSQTRKNGhUOWRiR0o4WU9ncWh6dWNPOWpx?=
 =?utf-8?B?R0Ntb2gzM2FmckhFSjZ0Znh3WjhFM3BpQkxnL09OYlhSNlZGSjNaWVp4R0JT?=
 =?utf-8?Q?EJzkTB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWJ2MGlMM3Y5dnFvcFpTcGxLVXZLWWdlNjZHRUpDWUQyLzc2VGk5TFpTbXVZ?=
 =?utf-8?B?anptZTBWdStqczhlandJVzNBaEd0YnQvUUhZYlJJK1NrRU1YOSsvVzVET2g1?=
 =?utf-8?B?bU1KQVQ2ZmI4L1VPbjZJTVMzYk80enZUY0FWRmdQQWJmZnVDcXRpbGtJVndW?=
 =?utf-8?B?RkNTYmVSaUJGQWd2WndYd0FUbUlNVC9pTm1ETForUUIwUWdBMGtXaWhCR0I3?=
 =?utf-8?B?QzgydmhtemoxeElkYlZvYU5UUERJeEpJemVzR01kRENnMllXVnNWb1RaVU9y?=
 =?utf-8?B?WU9LNGdZbEphc1JDajNhc2VpbG5HVTh0UWVCNGhuNDd2cDFwSDhKWEhKRUd3?=
 =?utf-8?B?QTNBZ3VySjR5azV1Nm1VVU9NSEw5d00vN0x5aGdaV3RSYWw1dGRUQnlHYVJU?=
 =?utf-8?B?aUpvR0pyNklpYldYMVB3cDgzTnhaTmVScjBBamhmcFN5S0F5bGZqTFZoK05z?=
 =?utf-8?B?c3pacVFZTEJ4SU93bVVleXdLNkx2eWEzUGc2V2IrY2lxSEVqWG9uQmpnOEUv?=
 =?utf-8?B?QUlvVVlzOGlWMzU4dm1DSzFHdTlsT1VibUNsYUQ5aTF3UTJ4TngybEIzemdX?=
 =?utf-8?B?S29aNEg1VTBPM0w3M0d0RlFNbTZyRHpDckRkMTM0a2gxeTl3UTU5QXFWdm5h?=
 =?utf-8?B?NXEwNjB4OUJDWEN4N0VZUm02cVBsNG5HbHBMek1hZHc2UFlaejZIeE10VHRS?=
 =?utf-8?B?Y3FtUy95V1JEcnF6cGxKQ21CSUI4NWFOWVJGUjlQV1EraW9YcFhxcDhUZkEx?=
 =?utf-8?B?VUdCTWZMOTZPZkNIa2M4RHoxWnRmZEdoN1U2bXFCTC9GdkJHYmJkQnJpclow?=
 =?utf-8?B?ZVFCSzNiRjYyVmE3RGlnZ2daZUFZdHFXVkE3RXNGUmNDcDRmL3VGTThPWmxL?=
 =?utf-8?B?M0F4VkJxeUtobjBhekdjODVJSFkxNCtmV0k3eStTY3lTZFJSVWJlU0RxT2Uy?=
 =?utf-8?B?ZTJ5Tm91TzhpS21PU2hiQy9veGFncThUOUlSR3RmK09DNUUrbFN1TEJBRzFB?=
 =?utf-8?B?enlwbXU1S3ZmaENVWjBMbVhSa1FWUjZ0VGJ2WGd3VGRMQmxsei9vRkR2dkRo?=
 =?utf-8?B?bjlBRTluZGVQK3F0d3BrT0txaklpd2RGRGlBUnUxRjY1bVQzM2lzMXFmeld6?=
 =?utf-8?B?SWZHM29IWGYwdEZzTHNVL1JWRGJZWitTTUlqYWZIMWNaTU5SQW1NY0l1cEhT?=
 =?utf-8?B?a0dZREYzeVNnSFA1YmZGSlZuTWdWbDduVGZWb2ZRci90Q3g5UTdkRHp5V3cw?=
 =?utf-8?B?a3I2enRjcXBSOG0zcFFUdUh6YlRKK2ltQ3hkNWtFMG82QlorNkpOb1FCY1hY?=
 =?utf-8?B?MGdGN0dmejZRVGI3UHZRNmdNT3FYN2Z5OG1TZ0IrcXg4YmpkcVBMZURyVWx5?=
 =?utf-8?B?ZUdza3BMYm0zbDhmYnVmTDlmT0VNWm9BNElFcmdrNmw4WHlwOTFRdTFxd29M?=
 =?utf-8?B?R0xpVWNjK3JIaTVMVHRQcmRlYnhHcHc5WEtUWmlpRXk3aURiOGxURGpOYkJT?=
 =?utf-8?B?R3BIOWhxYkxOZjZMVGZZMFJxaldxSTJVV08vNXpnQlV3OEJLcjBwU2ZOZytV?=
 =?utf-8?B?Z0MySzcxV0Yxc1dldlhSS0hPaTNoenhKT0ZIaWkzTERJQVhYOFNidkp6TXlr?=
 =?utf-8?B?V0Q1a3phSzZBRXltcmFDOHUvdWxMZ0hOVVptL0NmaW8zc0tSVm5kbENnZ1pw?=
 =?utf-8?B?ZXhrTUJnSnllMHlXcjFLQ3BDM0NTS0crajFMWldJMG9PTW1VdERwdTZHempP?=
 =?utf-8?B?MFhYSFR3am5oWm5maUpmVkRrbnBCTHc2M1lCZ0V5VlZzME94RnBwaWR6Wksr?=
 =?utf-8?B?UEpkTFRvaUcvejBKakJDR2ovVkdOa0liRVI3NkVvU2VoMWMxdnVXMlZYRlVz?=
 =?utf-8?B?cVJ6bFNRVUVBalRjUVJFN1dMNzNjZkRVdkkxMVZmSEpMTkFTa2FELzI3a1pB?=
 =?utf-8?B?a08vd2YySXg5NFVxTWRjWGF0NmFhZzJ5c1U3cDlpYmllTzdhZEd3MU9md3RW?=
 =?utf-8?B?Sit6RS9LNlpvN1NSQUFiTmhrcUpKdVNNMmFNcG1uWlBYNGRDdVpSK1BwQStU?=
 =?utf-8?B?K2l2dWRnb1pobkRBRUhiVi9DZUVKc09tcG1rYTFTQUsvNXozeWZzdkVaMXpY?=
 =?utf-8?Q?XFfw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82860eb0-939c-4331-7c3c-08de1304cb37
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:54:04.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgKG6JAL+5/7jNmxt7tQKvmCtdP+rGGW97SHDIgPXQvv1kdR9IMBZdVobQdaPA+/b5+CCPFUtQMVQUshBB5dsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8062

On Fri, Oct 24, 2025 at 03:31:45PM +0800, Richard Zhu wrote:
> Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
> Grounds.
>
> PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
> source, 3.3 V, is expected to be available during the system’s
> stand-by/suspend state to support wake event processing on the
> communications card.
>
> But the current vpcie regulator may be gated off during system suspend. To
> avoid the DT back-compatibility break, add vpcie3v3aux regulator to let this
> 3.3 V power source always on for PCIe M.2 Key E connector on the boards.
>
> [PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux regulator for
> [PATCH v1 2/7] arm64: dts: imx8mp-evk: Add vpcie3v3aux regulator for
> [PATCH v1 3/7] arm64: dts: imx8mq-evk: Add vpcie3v3aux regulator for
> [PATCH v1 4/7] arm64: dts: imx8qm-mek: Add vpcie3v3aux regulator for
> [PATCH v1 5/7] arm64: dts: imx8qxp-mek: Add vpcie3v3aux regulator for
> [PATCH v1 6/7] arm64: dts: imx95-15x15-evk: Add vpcie3v3aux regulator
> [PATCH v1 7/7] arm64: dts: imx95-19x19-evk: Add vpcie3v3aux regulator

For all patches

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> arch/arm64/boot/dts/freescale/imx8dxl-evk.dts     | 1 +
> arch/arm64/boot/dts/freescale/imx8mp-evk.dts      | 1 +
> arch/arm64/boot/dts/freescale/imx8mq-evk.dts      | 1 +
> arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 1 +
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dts     | 1 +
> arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
> arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 2 ++
> 7 files changed, 8 insertions(+)
>
>

