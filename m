Return-Path: <linux-kernel+bounces-788632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2232B3879D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37271B26496
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818031EBA14;
	Wed, 27 Aug 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cYF5tHJ2"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5614AD0D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311388; cv=fail; b=Bl0E1dW7NbcsirBScdmabOEBR0vCyFXrGipDAMZwYIT5SwfE2o4aYI0eo9bQFaTWenXhCowBQgOcRjFODzo5hLT1Sa3hVp25Rx/+IuJ5uEaHvpJ3Ju6cJkoLpfgyRs9OcqKw0Uddg0rH2ed/Gqsq2x5N3bgHW2T854SU1/GOo38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311388; c=relaxed/simple;
	bh=RlvxS/UYJOH9YEB4Py8eR078YroFJX5iCa9pmXWs4kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aDiBeZdiBjXGvtbLYxaJGy9eQ0t15kOx7Ur2edNQYOcTzSBeWyQhiLgndYcl9hPNXAFoETzKZkYwdrAKWqSi1lMX3rwNSHapmh13y049QgIzBzoibXnwqTIb4tY9C9ENubwk6Yy/+PmoKi7stlUDeKpZTCkZDYS1ZOXLGbCJcr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cYF5tHJ2; arc=fail smtp.client-ip=52.101.83.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3nwSADbEt+xdkiB32kzU86dWHvTYSlTR1rZZwNM43kiTNk40HAZyTv2HGYiE9pc4qzPB7/08WBYfTiA4prAfVX1egkD5b8ohBHetbPsbBMaXX7PvI98r63skM3MiaA8pLLv7IPkcWpCbB+rG7Gw7kdUDaVuKZUMp/TfwSyuW2HNh4xOqkuYZaRnwlwEVuN3DTj8kgRgW49uoLUACSmYnT1gyOnWG9vV7bzrZVzLzR8PnmliD0hP52RtkmVV4LlaGnHBYbGlVrNtLg6BLH3MuHDsVOOl4W08bwpeteAI62C38S8yndNVhVmtqVf7IcrtxC0Zm77OlHmPWU8yZHC7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV/ILft7B6/5+HJfCO3vtFhtHaOeRVdmOqA9SuHOy4E=;
 b=MkW4Mwr1jFVjdIeB8jT0qD74dyZfeut8QSv0nW2MFdNMRSE8QHyVUcSBucwXXCh9SV+x0OdMshPW7A3Tm4JSmAmY95VQdMrkLBUIIZTH/B59kThlBPqYgcVUf1LD0A8kZ3LENK3z3jkspimpeBL/rFlkKh9dc0KAlZXKNTYT6jJ5E1IDbukpY5yWNaTkFI6IxhUUb829FZ8MYX+qMMehwitRRjLMyEC/XsP4VzVhPuFZodwTvFKwHF7htlhkoHbEwM7gm5F9QlfS3YW+mvy8yjc+9aTCpVcCocLVtx8aEAChthNZPJFOSnoifG2iFEQLuCA0BwrxmVJ/U4l4ocNm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV/ILft7B6/5+HJfCO3vtFhtHaOeRVdmOqA9SuHOy4E=;
 b=cYF5tHJ2RQe78WKNc1NxfjEcjUQAXpnojTpRW1Ar9CIQz9H1pT30E/hTN5p9itaEJviBrFBS2CAPzf7hMYtlE0E1qz25G/Xzhl6XrzxQhuDfOCcXB5RruXZNpksy1fod21LmBgt+CVuAHlk1oUtTKvllpbZFiVqVZ0LUPrkEdJc+r30DchsCGc611S+6p4cJIbwKjCp8np0KqyO+FLDvQ1rwrl8ET3k72UoWxAG5GaGgjXhg3e96YDlKNSPUgD/KOUB+SEsd3fm2LDkbC2AL4s4IC9+yVKQmLxKLoeBmM3uRtg7l5FsVYkYsgtEzIQRI3eB/lnvrmYOqV+welRuTHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB11144.eurprd04.prod.outlook.com (2603:10a6:150:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 16:16:22 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 16:16:21 +0000
Date: Wed, 27 Aug 2025 12:16:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1] i3c: master: svc: Use manual response for IBI events
Message-ID: <aK8vTpg3nHkzqOYR@lizhi-Precision-Tower-5810>
References: <20250819090831.3009647-1-yschu@nuvoton.com>
 <aK3eHkf31uIw04EH@lizhi-Precision-Tower-5810>
 <CAPwEoQPnxW2jRpcqE_QSW2rNm8-zHfkTF=Ns_w7szYj-k3bTXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwEoQPnxW2jRpcqE_QSW2rNm8-zHfkTF=Ns_w7szYj-k3bTXA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB11144:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd7e861-d6a5-42ce-b504-08dde5850fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3phTVZpRmpZdDVDSnJEd0dHeS9UdWl4bEdhbkRkdnhNU0FlWG1pV3pUays3?=
 =?utf-8?B?UG10S0dFdlNBNWZLb3paR1YvK2RET2ZSdUZYa3I1OXlkNjlpN25KMW1YSnkv?=
 =?utf-8?B?YkpYOWJHR1hOdTk4TmE2Y09BYmtNdjBDUkx0bElXSGc3OTFRVWhFcndyV0Y0?=
 =?utf-8?B?N1lZMEVuWUtCN2tFcTlOZmlxRS83K1NVMkJ5RzNyaHE5cUVZekMvWE8zbmo3?=
 =?utf-8?B?MSt5SlVPSlhHNVdIQ3VYbi82aXRpTTBEYTlXNUZTNGV0akhnRktxb3BQMVFL?=
 =?utf-8?B?enBvRXFvYVV4TTgwa0VKeVlZUDJ5dVJpcmpVUzB3T1JTekFNRHZ4MzN0ZW9q?=
 =?utf-8?B?T2pLVGZVbFpucEE1R3FNWEU0MlI2MVVsTjN5aE5YSkNyay94R3VWNGlrVFJm?=
 =?utf-8?B?RzQxS1JxYXpkK3hxc2ZCZnE4SWg2SHVaVjI3RmRmUkZqTjhrM0hiLzNjS0Qr?=
 =?utf-8?B?VWNGb2V0VDJBdjFyMytHdmVRN0VRb00yeURzK3dpc3hIOTgvYVBZSVloVUxX?=
 =?utf-8?B?ck53c20weXNJZlhMZnpnK1NpQWw2a2tMWHRaZlNqWUVGTUtiaEx2Y1Z4WFJO?=
 =?utf-8?B?bzRMa3IwcUl0ckVQeXNROTF1Ym1ZVjFZOFBFR2hvSTArRkZjRGVLZ0FSWktp?=
 =?utf-8?B?OXpHbTQzS1Q4dVNuT3cxVTgvemVSSnpKVE9tVldiczFRaVZmRHlHVWl6UGl1?=
 =?utf-8?B?KzVhOWFUL0JLdXVlbnl6MmlSOWJBQXVCZ2x5M0o3MjdsMWtlWmhaeXJ6OVBN?=
 =?utf-8?B?WEFwNmV3NndxT0pIb3IvTmppMDVUT0JEamRDVDlveDgzVjV6QVl0ZnlVU3gw?=
 =?utf-8?B?aGYvcm1HQWlLMWQzcWtRTlI0dHl4a3pVMTJOcUVMREczVHV3TnNLdTQ0cXRY?=
 =?utf-8?B?SHFXV2ZxODZOejZZa0FuWlJhZHdobC9NOGtOWFZKTWRaenRsSHMvdGJWNEk3?=
 =?utf-8?B?MUdQOEZ4RUs1MFhYTGk2dmV6MEdmQ1J1dTBrS2FqNUF1d3h1K2lOUHdtWUJp?=
 =?utf-8?B?bFE1Mkc2RTVkNEwvaHpXN2JsRGI4QVdYRXF0aFN1TlFFM1VpakhVazdwYzZw?=
 =?utf-8?B?V0RGczdWOWFJZ1hqUTl1NHMzd3N3ejdGOHViS1VKSFdRY3M3NStOSGgzNmJW?=
 =?utf-8?B?SXRlbWQ3cnBvREJCT1BRNU4rYTdaWmJiVjJUYjBCS0UzaEtUeEN4amF4Qmxz?=
 =?utf-8?B?b29sQ0EyMlZ0cXQ0UEFSNzlOdGFFNC9UQnh4cUVTZk9CTHk1a0NzZGpYYVhO?=
 =?utf-8?B?djNuUDZJZHo5NUM4R0RWVSthNTZWU2IyM2ZSeWxJTGlMZ056d0FsYVBXc2Iy?=
 =?utf-8?B?RXNQZlNucUNaUDV5ZzdUQ2JiTkJmdWZHYWtsZVROeFYwWEJvVzJIRGhxa2pF?=
 =?utf-8?B?SCtISzU2cDlrWC9QNFBrN05kMFlqWVhjRUZSY3QrZmFZa1ZRb0QyN0l5K2lZ?=
 =?utf-8?B?ZXczNHlNeTQvTGUwTEZvdDR3bWZHNmpSM2c4SWlNZ3Z3VCtxcW5zcVZ0aWZ4?=
 =?utf-8?B?Szhid0hoZmNDckRlZmJUcjMwWTN6K3hZS2xITWxWTzdSM1RXQ2N1cEtKNDdB?=
 =?utf-8?B?Nkx0VllBcCtnL0djOWFNMHE4aXNwdUwxUkQ5YmtmRkFrSE1ETzRza2ZSVXdv?=
 =?utf-8?B?SjNZcEdVNU4wcEpqeXFnUmdTSmVFaWZtbWMyT1dFY0poVzRkRnczLzdQbEY0?=
 =?utf-8?B?bDZEVTBwa1lhalFpT3VLM095VStYSEwyQ1VGUlprQThMVThNc3pJRGZXSDh1?=
 =?utf-8?B?cDJBeUZ0VHBQdlVoZXorRkpNTWYzTEFxcmdBei8wNHpoRGdvUFlGYllLSDJN?=
 =?utf-8?B?dldMTGNvNnAwSWdjK0orT2lWbW1YTFNWVUlzTk8yOFYwdUdoVHB3a3MzZm1C?=
 =?utf-8?B?d3k0STNoN0VUZmZVZk9rWnNBUmRMdk5uUHpTTWlMb254MERqK1psNEpXSTBH?=
 =?utf-8?B?VG55am1LRVRrVXoxSDBmWjdiN25TdjVVdEZSTlZQVnkvS0pxekJrQ3hqM3RO?=
 =?utf-8?B?S1phc1piTzdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG9wK2hKRERYeXhwYXhmb3ZpZE5wcmI4cnNwNlk3d3dTdUN0Y1RWMzBJU2E4?=
 =?utf-8?B?d080bEIxYjNxTWdGNTdTNjd1MVRTOEJQdUF3RG04TlNWYjZRaURNSU1XQXk5?=
 =?utf-8?B?ckFHVzV4VC9jb2h5dWFURFVOc3dtdmNBbnk5OEtTK1VaVHdNb1BxWENCSUlM?=
 =?utf-8?B?UDBwelR4ZTBiY1RXQmttM0JzTlRKNHZzUWpWcnlsdmc0YmYxbVBhc2c4a3c1?=
 =?utf-8?B?NHdGMjNXM00ydXZaQ2s4R2UxS3VjK0ZvL3lGQ0xPRFZ2UTdHVnBFVkVvUCtU?=
 =?utf-8?B?ZURIWXhjUG5GdEk2R2xDQ0htNVF6WE9vSFBoem5LcW45VHI1NGVOMnBQckUx?=
 =?utf-8?B?ZG5GcTJvYWFJelhHTER3QmZtUkQ4ZXRLVGp3UG1ocTV3dmxZTWxtZUswckw4?=
 =?utf-8?B?dDBYS1NlMTZ5eFB4dEJETkdLbHU1SzVlTDU4MFNYd0xqUCt5bUpaWjl2YTVw?=
 =?utf-8?B?SkxNdDRraDI2VVNsZGZ5QTNXUU1EdFg3NDh2NHZLdW5VMkVGK2Vub3E5M0lP?=
 =?utf-8?B?SWRheHMyaHFnYm5QNDZQOGFJK29WRVZjSWhhbU5qUVJscTF1bEh3ZkJlSUtF?=
 =?utf-8?B?Ykc4Wm80Rzh2MjBqd0xXWlJHZHVXWis2NGthdTk3NUh0ZnV4eE9teEh3QzJI?=
 =?utf-8?B?N0hSa1RZVFExeUxpcFhhQ3JiTFB5VnJySWxkZEhZcG5CKzlnMER4RHFxeldt?=
 =?utf-8?B?ZDRmc3FZMDR3UFhQaFQxeXNoeTZhRmNCOWdHVFdjRHpLM28zcXJwSjBUWi9H?=
 =?utf-8?B?NVMvZXZZVTBUSUxtZ3lUczhaQXFHTWNLY1o0RDlwSlpQTlFoYnBnYjRLZUhp?=
 =?utf-8?B?dWhqUXhDbFR5enIxck91Y05wdE11Y25yRndxdW9Ldm1GcXlZU3JjMnZvNG1T?=
 =?utf-8?B?SFpiV1hIcFFwNkpvOURpekh2QTVyNEZSeWV3RFRkU09CdFRpdXFqMVVtTjMz?=
 =?utf-8?B?eDRkeHNkVjdxdzE3VVQ5TFY2Z2lSRVFpNStuZjI4WG1oVG1WdUZ6emE2YzIz?=
 =?utf-8?B?MTdKcEdsNjJaRjJyc3MvU3hQVk9sSVEyalNuYXNFNU1PVmVnejF3RzhjcFRh?=
 =?utf-8?B?bFcyQlQyRERzOTRIdlovdDRPeFBNdlZ0MnhsU2t6cFRRaG1uVTd1NGVjdWRN?=
 =?utf-8?B?MmZTOVRrYnVuTWtKd0lLM1hDTWRtN0xaSnhLdldVMVNuUXpHMnMxL2FwY1lZ?=
 =?utf-8?B?MGRaQkFRRVphNlJka0JhUkdLVUJXOEx1Y05JRnNNOGxHZS9DeUdvUldaZkMx?=
 =?utf-8?B?RmdqSTV1bHhrc3M0ZTJwMUhqK0lJSnBGVVppYWZXQWtDdUErOW1zY2tpa21X?=
 =?utf-8?B?YVdCK3M5YUdBWVFmWWRFNDZPbThnM0RGTjJ0TDdxVUE1aEVTdWE2azRGelRz?=
 =?utf-8?B?MEg0VnNQcHc2dnRyVUVoWjdvSGpnUWxTSjFDT0dNR3Rva3BGV08zZ3NJeHBI?=
 =?utf-8?B?c24reVhFVjliT2V0MDZycmhYK3BHTjF0a2FBSUxKSzI5ZFptMGxwVUNISDJy?=
 =?utf-8?B?OVBrZXZXT00yNy82eGhhUTRiQjA0RVNXaVEvOGFUc1VmYTBjRlhqakh4YU9p?=
 =?utf-8?B?eS9TdGFYMmRROEEyWm1wK3o2RmNtTnVWaXJkQ0JNZWdGdEh4VnJHUFc3aGMv?=
 =?utf-8?B?RElMVG1CbnVKTGp1UjRrMi9UaXpDVUlzU1BUczRSN1FOWFFYT3R3dG1OTDRN?=
 =?utf-8?B?YXVGWk1yVnJTNndRRWl1ayt6NS82cWdETGJ1d1E1MlRiWERoWm9qdml1anpX?=
 =?utf-8?B?T3B6b24xWTVVSHdENHpseTQ2RlZQdnNJeWRoSjcyamhrYVFXRDJLSkR2b2F1?=
 =?utf-8?B?TDRaNFF3VGliWjBGME4wVHE4NWlvdUFaRnlobnNVMmlYazBNZUZYS2w2czVv?=
 =?utf-8?B?eE93QjNUMDI0NndWTjU2WHowWEw5UUp6TEZoUDJLbFdmc3hqWVU5WlluNXhP?=
 =?utf-8?B?Z1p0M3lCT3hFWmJqV1I2RjNjdCtTWTdYYmE3M0VqajZwNWVZMmwzTk96R0c0?=
 =?utf-8?B?OVVnOG5NK2txVFpOK2RFWlVJUGNNT2d1VzFMOWxHN0UvZmlFNFUydzlHV3dl?=
 =?utf-8?B?UEVjWWpVb2xGU0pUMzA4REtvNGoveVdCUlN1Ylo1NkxUcy9Ra0hpWk5GSnVT?=
 =?utf-8?Q?o04ZUK4IHK0Fs/7fWxEC1wEA8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd7e861-d6a5-42ce-b504-08dde5850fea
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:16:21.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUUIZB0GvQAcrAjx9DGxnNb3LSVKLsPj96kOZB4vj6SN5RJ8QMyC8TWT1G3k77CPcc4w7vZevROUGrQJPXt/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11144

On Wed, Aug 27, 2025 at 08:54:03AM +0800, Stanley Chu wrote:
> On Wed, Aug 27, 2025 at 12:17 AM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Tue, Aug 19, 2025 at 05:08:31PM +0800, Stanley Chu wrote:
> > > From: Stanley Chu <yschu@nuvoton.com>
> > >
> > > Using IBIRESP_AUTO causes the hardware to ACK IBI requests even when the
> > > target is not in the device list. The svc_i3c_master_nack_ibi() has no
> > > effect in such case.
> >
> > how this case can happen since default target's IBI is disabled. Need host
> > send IBI enable command to target devices before target pull SDA lower.
> >
> Hi Frank,
>
> This is to explain that the original code svc_i3c_master_nack_ibi()
> will never take effect when using
> AUTOIBI with IBIRESP_AUTO rule.
>         /* Handle the critical responses to IBI's */
>         switch (ibitype) {
>         case SVC_I3C_MSTATUS_IBITYPE_IBI:
>                 dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
>                 if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)) {
>                         svc_i3c_master_nack_ibi(master);
>                 }

Okay, i3c target may stay in IBI enable state if host reboot.

what's bad thing happen if host ACK IBI? other IPs IBI auto handled by
hardware, I think there are not complete logic in these IP.

>
> > >
> > > AutoIBI has another issue that the controller doesn't quit AutoIBI state
> > > after an IBIWON polling timeout. The following sequence is the case:
> > > 1. Target pulls SDA low
> > > 2. SLVSTART interrupt triggers the IBI ISR
> > > 3. Target releases SDA
> > > 4. Driver writes AutoIBI request to MCTRL
> > > 5. SDA is high, so AutoIBI process does not start
> > > 6. IBIWON polling times out
> > > 7. Controller state is AutoIBI and doesn't accept EmitStop request
> > >
> > > Emitting broadcast address with IBIRESP_MANUAL avoids both issues.
> > >
> > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > > ---
> > >  drivers/i3c/master/svc-i3c-master.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > > index 701ae165b25b..17644e041b44 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -517,9 +517,10 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
> > >        */
> > >       writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
> > >
> > > -     /* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
> > > -     writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
> > > -            SVC_I3C_MCTRL_IBIRESP_AUTO,
> > > +     /* Emit broadcast address for arbitration */
> >
> > Need comments here why Request_AutoIBI not work. I think it is IP design
> > defect to make REQUEST_AUTO_IBI useless.
> It is not an IP defect. Per spec, AutoIBI emits a START with address
> 7'h7E when a slave pulls SDA low.
> A SDA glitch (high->low->high) can cause the controller to remain in
> AutoIBI state.
> 1. SDA high->low: trigger IBI isr to execute
> 2. SDA low->high
> 3. IBI isr writes an AutoIBI request, the controller will not emit a
> START because SDA is not low.

This is overall design problem, not IP implement problem. AUTO_IBI wait SDA
low is wrong. Normally case, target may release SDA after pull down SDA low
for some times to avoid lock bus.

after your patch, you will find no place will not use
SVC_I3C_MCTRL_REQUEST_AUTO_IBI at all.  So SVC_I3C_MCTRL_REQUEST_AUTO_IBI
became useless.

Add comments here why not use SVC_I3C_MCTRL_REQUEST_AUTO_IBI to help
developer know this problem because SVC_I3C_MCTRL_REQUEST_AUTO_IBI look
like should be used in here from IP spec.

> 4. Finally IBIWON polling times out, the controller remains in AutoIBI state.

>
> >
> > Only concern here is that svc_i3c_master_ack_ibi() need send in 100us by
> > i3c spec requirement.
> The function svc_i3c_master_ack_ibi() executes promptly in the IRQ
> handler, taking much less than 100 us.

Overall I am agree on what your change, but clearify some situations.
Manual handle IBI is not good idea overall. Core may run some EL2/EL3 codes.

for example, improve SVC_I3C_IBIRULES_ADDR and let SVC_I3C_MCTRL_IBIRESP_AUTO
to check if target address is known list.

Thank you find this problem and provide solution. I think just add comments
in /* Emit broadcast address for arbitration */ to show why have to use
SVC_I3C_MCTRL_REQUEST_START_ADDR.

Frank
>
> ---
> Thanks.
> Stanley
> >
> > Frank
> >
> > > +     writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
> > > +            SVC_I3C_MCTRL_IBIRESP_MANUAL |
> > > +            SVC_I3C_MCTRL_ADDR(I3C_BROADCAST_ADDR),
> > >              master->regs + SVC_I3C_MCTRL);
> > >
> > >       /* Wait for IBIWON, should take approximately 100us */
> > > @@ -539,10 +540,15 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
> > >       switch (ibitype) {
> > >       case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > >               dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
> > > -             if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI))
> > > +             if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)) {
> > >                       svc_i3c_master_nack_ibi(master);
> > > -             else
> > > +             } else {
> > > +                     if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD)
> > > +                             svc_i3c_master_ack_ibi(master, true);
> > > +                     else
> > > +                             svc_i3c_master_ack_ibi(master, false);
> > >                       svc_i3c_master_handle_ibi(master, dev);
> > > +             }
> > >               break;
> > >       case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
> > >               if (is_events_enabled(master, SVC_I3C_EVENT_HOTJOIN))
> > > --
> > > 2.34.1
> > >

