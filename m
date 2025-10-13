Return-Path: <linux-kernel+bounces-850043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F1BD1B39
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374591891395
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE262E1EE0;
	Mon, 13 Oct 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q5Icz6H4"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BB1DE4CD
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760337702; cv=fail; b=Nq6aYlu5UwCy/7l8W4Tdjlgl06NovwJ7ds92SE9tC+sunFDiNAY8d8HVoLhWR7435g3pC23Ij3h6X01dt8rG0TVBNGsAe4IR/rZP0JH4kL8grTbHENJ8PJKX+pGxDhaCiMp8diZcyBd7syhqJebCgxdo9I47k0G02Kiy4V0J6fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760337702; c=relaxed/simple;
	bh=fooafrgOd6mfmgMHbQqePurXP4RxEp0wu92iO5EW4tA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n65YO2enI7ENn5Np656ed48b5grMQB0DCRKDzsHUTfgKq5EdYf9gEoqvTrrPAoVuJ1PYPFmUZjHnqdR+cbFmucSygsx+XDHlzeAJwEMGwxsRMdtzi81ivBdXOWxEwEuZWdfkfUeL4QMDnyKo2OEMb5QYlta3XOeMfBCRYCVeml0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q5Icz6H4; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBL70r5cQt2O8mEvGeh6g6oKSLOiAAzCmpbWHNsXQx1gruBfSTDw+sYZfIs1Bqs0UePXJm5OBh+xqTwRv2qBp+Ip9+G6QWr0MsuXNluSCkQBarc4wUqvWfbrelmt10frnHN2YrZdI4PrOEwdED4HDr7NvV8QoRshTMSPnJimH6E5uq5ak4hvmUz8TH+7hbiH+3rii/AfhM+UaAG46wJUyh+jy/cDinxLBC56k4xTAwgDklgooa53ieAzP3gZxs9EJIcxxKHi7UwSc2DnzpPoepsFMrDst1rwF9IKMSg8bLs06mCaa9V1khAgIeSFLuZSqZQ4/PNjNCSbWje7iqXfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpE70J6MWm+Derbaq3t1ZHfpqV2rX6h8CCp2IXBDnQQ=;
 b=OsiOv/rTIkUvq1AZTLdmXe1xMwR1umcnFX7nRnq2tQYUn6iOfU3RYka4pPQH33tb/XSAxkdn9J56x7jM5RFYAg9A+R9nlGcsRFJipyiUcyqeu9haiTnhev7GPhHlQuZUOybheWAo7Uqu222dN0f2h0EclwUb0rcgPPt/JdTXljZ2mFRfV4fYwClVQIjZJRwxyqXEu1BtFdvvbt9ZEvkULsw28Jtbn1fhFGTRL1qJQTurYH9lLqWDOYPOndbhJkqdBjvF2oyE9G8AFKG8K/jpzOAq5xY2Mzhyg7EVyRqLdYvrZo5/HhYX802cXJVlpCzRsV6c0bn4nsu8Gom87re/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpE70J6MWm+Derbaq3t1ZHfpqV2rX6h8CCp2IXBDnQQ=;
 b=Q5Icz6H4GeZVndqyIFzcKNXaBpK0iJYublVTU02WOHKKg5BOrJx/lrVKE7ARrMFcEqTrbYD9p+6KRcqcC+ZjBbiaeYvaSy+a/l8trWXu70yE1Kx7PwbiuMksOoavYVCZrUh3gqu+umuLkfL0xaOt9fkVjKYSODINSNJKBavdKEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 06:41:37 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:41:37 +0000
Message-ID: <3af92c11-9e8c-43bf-be92-85d1fd9280f6@amd.com>
Date: Mon, 13 Oct 2025 08:41:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable missing AMD/Xilinx drivers
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com,
 linux-arm-kernel@lists.infradead.org
References: <457c3a128e300241afd20da693d1d80a35d1ece6.1758099050.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <457c3a128e300241afd20da693d1d80a35d1ece6.1758099050.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0089.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4968b2fe-ddb5-4b3b-e3ca-08de0a238e9d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekk2OWgxSThLMFB3NXBTblV3bmhHNkhtU2ZOT1ZDME1BZGRxUDR2YTJ3VSt3?=
 =?utf-8?B?Z3gvY0tCbjRma05rMXNndkVsWDdiM3dtbUxMVEk5L1czemZNUnlvaXhXVkI5?=
 =?utf-8?B?MXFqaVRWUlNhVnR3RURzVGFCS29UdkZLNFNUaHhIajFxTDRzRWwyN0l1TG1K?=
 =?utf-8?B?MkxGWGRxbGlHbFEwNmpjb0duSis4ZHBmeDhrWjVqdm5tWU5xNitZMmRudGMz?=
 =?utf-8?B?QitnY0xtVnhVOGYvTE9MQlM1VnFBQ2Jlckc0cElBOGtOU2I3L3hNcWZ2OE1S?=
 =?utf-8?B?dVhocnB0ZGxoekRZYVJmZkhhUkVKbU81UFZiM1UxcE9mV1JXREQ3RUg4VWxE?=
 =?utf-8?B?Vks5aC93RkE3c0tvMmFnNDlIc3pnejZYemJzUjBJa1Y4a3RXUDhGUU1ROHEw?=
 =?utf-8?B?U0tqeldWY2VoNlkvSWhnRmgrSWo0eXZ6N0tQZWpZVWx2YWtUaGVWc1d0bnQ2?=
 =?utf-8?B?dzBscS9zekIyRkRwbjFLdERjTXNHV0lLZ2ZOUDJ3OHFadkhYQm8ycys2QlIz?=
 =?utf-8?B?T0d3ZFpwVEhORzQrZXJ0WHBQYWtUWFIyeHlaWVBYaHkzZjFlRXZMUnBkS3Bq?=
 =?utf-8?B?eFg4VWZLaFdRaGZIZytLMlBLZWZyWndzcjJqNlZrRWpPbEhkejRodGFjd3lV?=
 =?utf-8?B?S1hoQlFRb0xGYnE2RDREYzlmM1pLMkNxWXVqRDcwM0J5UlpNTWtwWEh2d1BS?=
 =?utf-8?B?bGYvbGoyTDIwdkRpdG1VZFRDOXEvYko2OVZiWjJPeWt3bzhYem9nQWlndlJk?=
 =?utf-8?B?a0haZUl1NDl1SVcyQUVOQUg1ZHFXbUdkV2xLZlBtTXgyTTFJeGJmV3NIeXk5?=
 =?utf-8?B?QnVkV0dZRkNXOTBCMi9Tc1RLUGVjc3hKUWhiMEswTnZwMzBkVFB3YkRXZHB2?=
 =?utf-8?B?cXlhTGlZT0tJdXBpUm9kcWQwUXNXR05palRKa2djN2xzbkoyWUNlTlBZU2o0?=
 =?utf-8?B?aUYrVjZESUdvZEJ1NGFZckVuU0FTcy9nWWowTk43TnFwY0o2aUhKM3h3OVlt?=
 =?utf-8?B?b3k3QTN1ZzR5TU1ueS9ib2NLbUk2U1pyc0pabTE4M0lMY3V6YUVlMHd6aitu?=
 =?utf-8?B?NnpnOGZmZURVSXh3MmJmWnhsWm5BR242bjB2TnQwSHZjc1VwWDV4SWpmQmxU?=
 =?utf-8?B?YnZHSUZ6dldjWjVLRFR6alZKeDFZcmxGWHJCNGhzRU4xNTd2Y0YzVW52NHlM?=
 =?utf-8?B?K1BVdENtaFpUVlRVWFQ2bUVtNFlRTkhPWGE1eEdMaDAyaVVxWWF5c3dSRUpp?=
 =?utf-8?B?OTRBUVpBby9QU1oxL3djRWxBdHYrSmRGTHkxQWFqN1daL01JZm4yRCs4ZFFE?=
 =?utf-8?B?K2VXR25hRzRSQlp1UTh1ZmRFUWxKSnoyZkVnelN1OFJjYmpVU1hkTFZtRzNP?=
 =?utf-8?B?bjVzd1JDNHJPdjA3Y3ExalcwbmV1YmhqQjRKcVBYSUcxdWZsaUxZSlNGd2s0?=
 =?utf-8?B?SFFrUmoyR3A2eWllTlVpSGhyWi9iUXZmbmJCMExSMkgyTGlSVy9vSXkxc1RH?=
 =?utf-8?B?QzlGTk9CMnJSaE5BVEwybitCMU5JRUkxcFhva0dWWW1WN0JlSDhWeUNucWcx?=
 =?utf-8?B?bW9mMi85aDdraE1BWHRnSUhaODNBc1NndUUrTlc2amJTRnI5K214dEpjS1Zs?=
 =?utf-8?B?SUNEMzRlcVFTMXlLdHdBRkhPVFBiM1d0MEZEOUFuUFlON05yb0ZYT2J1RUw1?=
 =?utf-8?B?NUN0VHRDK3NET3JIejZBOFI2VDRrcjg1cERzZVJ3SmNQb1RDdVhpQTJqcjFU?=
 =?utf-8?B?THY5QWdBa3NrQ1VKWllETm53WGw5b1dJWjlwb2ppWHlXRXBBUlpIMWtYNk13?=
 =?utf-8?B?OG9NMXZwUWoyU01WQ2tERmQ0MTRmblM2VlIvNDJQem1JaGY1K2hyOHZFYXJa?=
 =?utf-8?B?WXBEU1RoaVlsSEtnRWdJRzVhLzBwTW83Y2NpaEMwRzcrUVVzVGhqSmQ1Unk1?=
 =?utf-8?Q?pqvFetGvK8niG9Ix5/rWK3zeXL15mowC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHp6NkQ4UzArSG13d1Y0RjRGdEdWSjV2cjZsa29YMFBIM09EMHNiSUpkUUtn?=
 =?utf-8?B?RldJa2t2OGtTUFA3SEhnSC9KTWliRVVsZHB2aVgva255RWNibXBNbzN3ZWFW?=
 =?utf-8?B?S2wwU1BwWjlFVVptdFFhSllvUndscnVYanNNZEMvNGhkMkpsOXdSWXIySVpX?=
 =?utf-8?B?NXUzR2l0Nml1bTJGTzBBelBHQXRuaFY5d1NLSnFVN0ZpV2x1Q0Ewcm1VOFAw?=
 =?utf-8?B?d0VRNURWbzZPSkUza3ptVXBhdVdHeXJTNHJMUjl0dldFUTNqb1ZnNjE4em5y?=
 =?utf-8?B?T0ZtRlEycm5tUmE4T3FPSlBMRm9INWJWVFowMmhERk1INnhKcldzdzgwK29K?=
 =?utf-8?B?RDg0cHg2RHI1MkRVUWRQdCttbWJWQjBRRGNqbnF1eUdidE14V3E0czVsMU1K?=
 =?utf-8?B?ZTN4bEMwTENMTEFHQWM5ZURyTG1yeENuNzcxSUl2TmNOZjB0SkdWYnNaVStI?=
 =?utf-8?B?KzR6andRRk0rS0dTVHdNd0RVbzR1THRnc2JlYW45blYwM2Rqb1RDSVg5Q3Q0?=
 =?utf-8?B?OTJKMkNsWUwrMEo3ZGlDeTMzUVlISml2L0xZbWRvaVNZRmhIbVBSbGEzN09Z?=
 =?utf-8?B?RFFBeGFrazdjN3RxNklWVXg2eldFWWlnTUw3eU1CUEpIeXU1ckJBUU81SCtq?=
 =?utf-8?B?cGd6cDZQbFE2RHRYblRxOGdOLzVkeTgrejVuNm4zUk9vL2l1NmFFY1MwSDRa?=
 =?utf-8?B?K0c1Kzd4WE5PRWpGZmh6QnpxdTJYSVN2SHlKR1NMNSs5ckRPL09sbitKKzBB?=
 =?utf-8?B?Nk1Mc0kwWHl4RlZ1ZjFsTitVbEtVcDBEeXhyeXBhNFV5eWdsTkxaNmYyank4?=
 =?utf-8?B?U1hjanAwZ3IvYzF0cm1tQUN5aWQxcDJlS2ZNcjBxaUdOZllPZitnK25DMkY2?=
 =?utf-8?B?TDVKM0p3aHM1cE5VSnQ1b29QeFdtMEo5YWF6UjJTRXQ3UHpBTUZKWmd5QXN5?=
 =?utf-8?B?Nm53SitBV0M1RVFNR2huRnkyVzRaWmlLOVdCYzR1N1l2SmFIU295Q25lbHp6?=
 =?utf-8?B?YW1QSmdCRUNRbHkrb0ZIQlNkaFd0RSsrTzFwTitFWlIzUnBKWjdxY2JPeGpB?=
 =?utf-8?B?RFYwUE5QOUs4SmJjU1JMRjFBSTZmMEMxbEhGWnE2OHF2M0g1NmhiTTVNcUF5?=
 =?utf-8?B?ekpsZWUxQnloYjROQ3c3aVN3VmZJK0k1SUwvL2xEeU1RUk5kN1NZK1Q5cW1k?=
 =?utf-8?B?N2ZhemErV0RHQVIzM3FveGJmQnV4d0tTTmNCOGNFVmp0VzhiejUvSTlvZm15?=
 =?utf-8?B?Vm96RXpzWmpLQUxVbGwzWURsOHR0bDJocVJIYTg3NGplZGdFRC9lMWZMSndY?=
 =?utf-8?B?SlhxWGFxNjdoUTFMd2gyWTdpNUZCcUlWalUvY0VPbURDS2M1Sng0cU1jN2p2?=
 =?utf-8?B?Y3JvSWY0c0pCSGZCUHQvbi9RN2YyR0M5RGxKQWFRK2prRFNxbVV2WmY0dXRU?=
 =?utf-8?B?V0hSVFl1a0piTkQ4ZW5XZHNpeGhHWDJyRmFvTjJHU2FhSVFsMUtncDZPOFlP?=
 =?utf-8?B?YTQvUnJFUnlJRENib1ZWM3d2VTVCeXByMmlJMFl1b2lZVTY3M0F4WVA0VGRD?=
 =?utf-8?B?WCtETDVwY2o5THBQejFaODJFc2RvNGxoOVRva1hDaHF6OU5wVjhJbGV0aXJC?=
 =?utf-8?B?dWlpTTNPNlB0bmhhTjVXNVlRelJYMkZMRk4xUlZBRDMvYW1VWnR2REN3NWVr?=
 =?utf-8?B?WG5IODhCUXNxSU0yakNTSU9XWEpVdDZ3Z2JteDl0ems1dVNPWHU5RnM2cjY3?=
 =?utf-8?B?cG1YakdsVVE2U0s3Z1BZN0sxN3N6TWlmYWNJTTBYZmRjQUswdFlYam8vVkp6?=
 =?utf-8?B?dGc0OGZ5c0tjMCtteHlLKzlEZ1dJVFp2Ry9DZm1VWXp5RDRPU1hDSUpSZ2U5?=
 =?utf-8?B?TE1lNlVzQkM1cUtqY2lTbVF2OHJLWVhyVG5ja3RFN1FmR1pMUC9xdGcwRmJD?=
 =?utf-8?B?NFZsU1YzZFN4VnpzYVJlMjlxbG0yZWVXc3o2YjllV2hGcEMzSldwVXg4QmZw?=
 =?utf-8?B?YllIUEoyYUNaZzB3bC9Nb2d4ZHlqYUVkd3dhTnR3dk9VekdKQk01bmVDajVT?=
 =?utf-8?B?dGpsMnRkSXlPZ2FKY3kwc1Y3bzM1OTkrVmZaeVdGQnh3dytjMW9mS1QvNmUx?=
 =?utf-8?Q?bowkO/2OLYfgFURbXwrpZYMgi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4968b2fe-ddb5-4b3b-e3ca-08de0a238e9d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:41:37.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJUogfDHy/Ksv3Te8Vx9LdUeIl0BRgVAVZJnhE3pdideZW7xx/QfWak/TNmjTArU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262



On 9/17/25 10:50, Michal Simek wrote:
> Over years number of upstream drivers have grown for AMD/Xilinx SOCs
> (ZynqMP, Versal, Versal NET) but they are not enabled by default in
> defconfig that's why enable all drivers for these SOCs including USB5744
> on board USB hub available on Kria ZynqMP based SOMs and Carrier Cards.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/configs/defconfig | 43 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e3a2d37bd104..10b0c71a4e3e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -232,6 +232,10 @@ CONFIG_PCIE_RCAR_HOST=y
>   CONFIG_PCIE_RCAR_EP=y
>   CONFIG_PCIE_ROCKCHIP_HOST=m
>   CONFIG_PCI_XGENE=y
> +CONFIG_PCIE_XILINX=y
> +CONFIG_PCIE_XILINX_DMA_PL=y
> +CONFIG_PCIE_XILINX_NWL=y
> +CONFIG_PCIE_XILINX_CPM=y
>   CONFIG_PCI_IMX6_HOST=y
>   CONFIG_PCI_LAYERSCAPE=y
>   CONFIG_PCI_HISI=y
> @@ -271,6 +275,7 @@ CONFIG_QCOM_QSEECOM=y
>   CONFIG_QCOM_QSEECOM_UEFISECAPP=y
>   CONFIG_EXYNOS_ACPM_PROTOCOL=m
>   CONFIG_TEGRA_BPMP=y
> +CONFIG_ZYNQMP_FIRMWARE_DEBUG=y
>   CONFIG_GNSS=m
>   CONFIG_GNSS_MTK_SERIAL=m
>   CONFIG_MTD=y
> @@ -303,6 +308,7 @@ CONFIG_QCOM_COINCELL=m
>   CONFIG_QCOM_FASTRPC=m
>   CONFIG_SRAM=y
>   CONFIG_PCI_ENDPOINT_TEST=m
> +CONFIG_XILINX_SDFEC=m
>   CONFIG_EEPROM_AT24=m
>   CONFIG_EEPROM_AT25=m
>   CONFIG_UACCE=m
> @@ -390,6 +396,7 @@ CONFIG_DWMAC_MEDIATEK=m
>   CONFIG_DWMAC_TEGRA=m
>   CONFIG_TI_K3_AM65_CPSW_NUSS=y
>   CONFIG_TI_ICSSG_PRUETH=m
> +CONFIG_XILINX_AXI_EMAC=m
>   CONFIG_QCOM_IPA=m
>   CONFIG_MESON_GXL_PHY=m
>   CONFIG_AQUANTIA_PHY=y
> @@ -406,7 +413,9 @@ CONFIG_DP83867_PHY=y
>   CONFIG_DP83869_PHY=m
>   CONFIG_DP83TD510_PHY=y
>   CONFIG_VITESSE_PHY=y
> +CONFIG_XILINX_GMII2RGMII=m
>   CONFIG_CAN_FLEXCAN=m
> +CONFIG_CAN_XILINXCAN=m
>   CONFIG_CAN_M_CAN=m
>   CONFIG_CAN_M_CAN_PLATFORM=m
>   CONFIG_CAN_RCAR=m
> @@ -556,6 +565,7 @@ CONFIG_I2C_S3C2410=y
>   CONFIG_I2C_SH_MOBILE=y
>   CONFIG_I2C_TEGRA=y
>   CONFIG_I2C_UNIPHIER_F=y
> +CONFIG_I2C_XILINX=m
>   CONFIG_I2C_RCAR=y
>   CONFIG_I2C_CROS_EC_TUNNEL=y
>   CONFIG_SPI=y
> @@ -593,6 +603,8 @@ CONFIG_SPI_STM32_OSPI=m
>   CONFIG_SPI_SUN6I=y
>   CONFIG_SPI_TEGRA210_QUAD=m
>   CONFIG_SPI_TEGRA114=m
> +CONFIG_SPI_XILINX=m
> +CONFIG_SPI_ZYNQMP_GQSPI=m
>   CONFIG_SPI_SPIDEV=m
>   CONFIG_SPMI=y
>   CONFIG_SPMI_MTK_PMIF=m
> @@ -683,6 +695,8 @@ CONFIG_GPIO_WCD934X=m
>   CONFIG_GPIO_VF610=y
>   CONFIG_GPIO_XGENE=y
>   CONFIG_GPIO_XGENE_SB=y
> +CONFIG_GPIO_XILINX=m
> +CONFIG_GPIO_ZYNQ=m
>   CONFIG_GPIO_MAX732X=y
>   CONFIG_GPIO_PCA953X=y
>   CONFIG_GPIO_PCA953X_IRQ=y
> @@ -752,6 +766,8 @@ CONFIG_QCOM_LMH=m
>   CONFIG_UNIPHIER_THERMAL=y
>   CONFIG_KHADAS_MCU_FAN_THERMAL=m
>   CONFIG_WATCHDOG=y
> +CONFIG_XILINX_WATCHDOG=m
> +CONFIG_XILINX_WINDOW_WATCHDOG=m
>   CONFIG_SL28CPLD_WATCHDOG=m
>   CONFIG_ARM_SP805_WATCHDOG=y
>   CONFIG_ARM_SBSA_WATCHDOG=y
> @@ -987,6 +1003,8 @@ CONFIG_DRM_LIMA=m
>   CONFIG_DRM_PANFROST=m
>   CONFIG_DRM_PANTHOR=m
>   CONFIG_DRM_TIDSS=m
> +CONFIG_DRM_ZYNQMP_DPSUB=m
> +CONFIG_DRM_ZYNQMP_DPSUB_AUDIO=y
>   CONFIG_DRM_POWERVR=m
>   CONFIG_FB=y
>   CONFIG_FB_EFI=y
> @@ -1068,6 +1086,9 @@ CONFIG_SND_SOC_TEGRA210_MIXER=m
>   CONFIG_SND_SOC_TEGRA_AUDIO_GRAPH_CARD=m
>   CONFIG_SND_SOC_DAVINCI_MCASP=m
>   CONFIG_SND_SOC_J721E_EVM=m
> +CONFIG_SND_SOC_XILINX_I2S=m
> +CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
> +CONFIG_SND_SOC_XILINX_SPDIF=m
>   CONFIG_SND_SOC_AK4613=m
>   CONFIG_SND_SOC_AK4619=m
>   CONFIG_SND_SOC_DA7213=m
> @@ -1151,6 +1172,7 @@ CONFIG_USB_SERIAL_OPTION=m
>   CONFIG_USB_QCOM_EUD=m
>   CONFIG_USB_HSIC_USB3503=y
>   CONFIG_USB_ONBOARD_DEV=m
> +CONFIG_USB_ONBOARD_DEV_USB5744=y
>   CONFIG_NOP_USB_XCEIV=y
>   CONFIG_USB_MXS_PHY=m
>   CONFIG_USB_GADGET=y
> @@ -1248,6 +1270,8 @@ CONFIG_LEDS_TRIGGER_PANIC=y
>   CONFIG_EDAC=y
>   CONFIG_EDAC_GHES=y
>   CONFIG_EDAC_LAYERSCAPE=m
> +CONFIG_EDAC_ZYNQMP=m
> +CONFIG_EDAC_VERSAL=m
>   CONFIG_RTC_CLASS=y
>   CONFIG_RTC_DRV_DS1307=m
>   CONFIG_RTC_DRV_HYM8563=m
> @@ -1268,6 +1292,7 @@ CONFIG_RTC_DRV_DS3232=y
>   CONFIG_RTC_DRV_PCF2127=m
>   CONFIG_RTC_DRV_DA9063=m
>   CONFIG_RTC_DRV_EFI=y
> +CONFIG_RTC_DRV_ZYNQMP=m
>   CONFIG_RTC_DRV_CROS_EC=y
>   CONFIG_RTC_DRV_FSL_FTM_ALARM=m
>   CONFIG_RTC_DRV_S3C=y
> @@ -1296,6 +1321,9 @@ CONFIG_PL330_DMA=y
>   CONFIG_TEGRA186_GPC_DMA=y
>   CONFIG_TEGRA20_APB_DMA=y
>   CONFIG_TEGRA210_ADMA=m
> +CONFIG_XILINX_DMA=m
> +CONFIG_XILINX_ZYNQMP_DMA=m
> +CONFIG_XILINX_ZYNQMP_DPDMA=m
>   CONFIG_MTK_UART_APDMA=m
>   CONFIG_QCOM_BAM_DMA=y
>   CONFIG_QCOM_GPI_DMA=m
> @@ -1459,6 +1487,8 @@ CONFIG_SM_VIDEOCC_8450=m
>   CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
>   CONFIG_CLK_RENESAS_VBATTB=m
>   CONFIG_CLK_SOPHGO_CV1800=y
> +CONFIG_XILINX_VCU=m
> +CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
>   CONFIG_HWSPINLOCK=y
>   CONFIG_HWSPINLOCK_OMAP=m
>   CONFIG_HWSPINLOCK_QCOM=y
> @@ -1570,6 +1600,8 @@ CONFIG_RZG2L_ADC=m
>   CONFIG_SOPHGO_CV1800B_ADC=m
>   CONFIG_TI_ADS1015=m
>   CONFIG_TI_AM335X_ADC=m
> +CONFIG_XILINX_XADC=m
> +CONFIG_XILINX_AMS=m
>   CONFIG_IIO_CROS_EC_SENSORS_CORE=m
>   CONFIG_IIO_CROS_EC_SENSORS=m
>   CONFIG_IIO_ST_LSM6DSX=m
> @@ -1602,7 +1634,9 @@ CONFIG_PWM_TEGRA=m
>   CONFIG_PWM_TIECAP=m
>   CONFIG_PWM_TIEHRPWM=m
>   CONFIG_PWM_VISCONTI=m
> +CONFIG_PWM_XILINX=m
>   CONFIG_SL28CPLD_INTC=y
> +CONFIG_XILINX_INTC=y
>   CONFIG_QCOM_PDC=y
>   CONFIG_QCOM_MPM=y
>   CONFIG_TI_SCI_INTR_IRQCHIP=y
> @@ -1666,6 +1700,8 @@ CONFIG_PHY_UNIPHIER_USB3=y
>   CONFIG_PHY_TEGRA_XUSB=y
>   CONFIG_PHY_AM654_SERDES=m
>   CONFIG_PHY_J721E_WIZ=m
> +CONFIG_OMAP_USB2=m
> +CONFIG_PHY_XILINX_ZYNQMP=m
>   CONFIG_ARM_CCI_PMU=m
>   CONFIG_ARM_CCN=m
>   CONFIG_ARM_CMN=m
> @@ -1696,14 +1732,18 @@ CONFIG_NVMEM_SNVS_LPGPR=y
>   CONFIG_NVMEM_SPMI_SDAM=m
>   CONFIG_NVMEM_SUNXI_SID=y
>   CONFIG_NVMEM_UNIPHIER_EFUSE=y
> +CONFIG_NVMEM_ZYNQMP=m
>   CONFIG_FPGA=y
>   CONFIG_FPGA_MGR_ALTERA_CVP=m
>   CONFIG_FPGA_MGR_STRATIX10_SOC=m
>   CONFIG_FPGA_BRIDGE=m
>   CONFIG_ALTERA_FREEZE_BRIDGE=m
> +CONFIG_XILINX_PR_DECOUPLER=m
>   CONFIG_FPGA_REGION=m
>   CONFIG_OF_FPGA_REGION=m
>   CONFIG_OF_OVERLAY=y
> +CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
> +CONFIG_FPGA_MGR_VERSAL_FPGA=m
>   CONFIG_TEE=y
>   CONFIG_OPTEE=y
>   CONFIG_MUX_GPIO=m
> @@ -1797,6 +1837,9 @@ CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
>   CONFIG_CRYPTO_DEV_QCE=m
>   CONFIG_CRYPTO_DEV_QCOM_RNG=m
>   CONFIG_CRYPTO_DEV_TEGRA=m
> +CONFIG_CRYPTO_DEV_XILINX_TRNG=m
> +CONFIG_CRYPTO_DEV_ZYNQMP_AES=m
> +CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=m
>   CONFIG_CRYPTO_DEV_CCREE=m
>   CONFIG_CRYPTO_DEV_HISI_SEC2=m
>   CONFIG_CRYPTO_DEV_HISI_ZIP=m

Applied.

M

