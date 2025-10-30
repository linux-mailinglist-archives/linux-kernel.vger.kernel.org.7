Return-Path: <linux-kernel+bounces-878453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C3C20A85
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11393423F85
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A5B27FB3C;
	Thu, 30 Oct 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8iKekqM"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8635957
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835016; cv=fail; b=RD6xOznvk5RB0kn6KzRnsjoGoo4E6FoE+T43zSPjviS1UBDQsgQjm+CC3vTAdCreTU6QFCN169CN6KdDaZvIN/DhjwDpO4K9QFYB84zoutB5l9wB/v6cwBDkRTiCx+UORMvX/yBvLwXkzixeJZny07NEFGA5zo9gVRXtQe4gZdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835016; c=relaxed/simple;
	bh=Gr4VsAdy5Q19K/moc/8v62AjVGRvY3qwK7luv8JSMUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLEUhUkzK8ZROybZ1f1QDs03PvXoJfPTUDmpzo8BifrlojSJtNRN7jDgULajb9lUtGAeAFR1Qy/0btcVLBOVnrwkdpo07QzX1BIR4fj6INld7Z/bIHK4dizgMRqG/eZS8z7ly3D9TJy5vEzxPFazo4eJU6oBT9ZHcivIDVhyfxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h8iKekqM; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA8x6JZNYwXqPhlullelLKoseOLNp/bv5vAylr8jr7nhN+6xZpWFA1SWFwcA9p27A9nStBENcOKEAAadXO6CVMzT6z0ASkpiSBd0mMqHdGX0VUzD/W4o4kqJRrU/4ry146iJi6anP8ohWoMv93MxfwUBM4/hC7fV+sE+xCE4Czgxx738p0KBcCR+fiRXxlPOqamVyoaUBo1Z/ZKHdWGPK4zwESjohgzL/TuGPBJMuMqXKufyYUmBmdl0l/uheqF/GpNP0ZHiP0sD0JMPlRdDTWlzDqQjlG4+bAX74uQ8zz7ehY1FvJEFDDHru0YdV0kkfwnkUG2wfhwmN8zE/grQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv5wgw27tL6cJ18W/s62juu6vpXmQ1prixbeg/MWXTY=;
 b=Aswum01cgj3jHF2AjV1H17WJi87144qBjQOAGDqMKmPN04lamGiIoS1XQM6t1RWToxRalbtXqIFvXGkSn8Ojv5hBncrNBzHoLEHjUAZEvLVdg2ul0r6YQuUTjUwSw22c8dgknGw2IznXMrHJMtv6jk6wmm2VAHRqJoMaRc7GB87JktTIPg3UfZcEtBOzMuQ8WQXBOqPGQJoWsGFMZlwPnNSm/kk37zSsIRsb2Oy3tcmE5x4J3epzmmmzbiSyJ8tjV2rCpsAmXSmkCyLvNR4PZSx+VNqg9BWLyQAosGa/M5uQSOwHtTdDfEuKOIrLzhe19z34+R1P6yHkXKgFxrkYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv5wgw27tL6cJ18W/s62juu6vpXmQ1prixbeg/MWXTY=;
 b=h8iKekqM0aaoDPOrwpmsd0vrbjHsX+7gz3pcXDge+bkKPsIVHJtqKB6uOO28vVOYnpozqwtHC88gCRLKzO1s4gJP9utnQz0/D2Tb3RQANUISFM4qB6IVP0vQ5x9pSE4fPZ3NlYqzHVTYukyQ9CKwrh8UfFKiarJT5F+ofbgGaZBT8I/hcAN+xz/xfz/riS/JoLV7+eGNonppup5lOzOBgUzhCxUreFkIcI1bePRjk7hWBhHNNHyDiYFZZma5pKCvqYuh+U4dGAMXGS0nS2S4b/u3F2ORi9VPPFgjqPHGcmYFJwxAhj2+FwQKwwovwwUitbBsyMT2a8C13esAe9ZiQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:36:51 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:36:51 +0000
Message-ID: <9c32fa45-2b8f-4005-94cd-a9755981cff5@nvidia.com>
Date: Thu, 30 Oct 2025 16:36:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
To: Johan Hovold <johan@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Lazar <alazar@nvidia.com>, Simon Horman <horms@kernel.org>,
 cocci@inria.fr, linux-kernel@vger.kernel.org
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
 <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
 <aQNw5NqZSZk5JNxn@hovoldconsulting.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <aQNw5NqZSZk5JNxn@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b3ad54-a9fc-4f09-8cdc-08de17c1c365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3NvZ3J3cDJRcHJJVjZKY2s0SnZscHkwanVQWXFsMUZHY1kxZnFBWmNCRjRW?=
 =?utf-8?B?K0U5NEsxSEZ4WXA3TUJkMXlUdmYwMllHWFdOVnZGTjdCM2RKbDJQYzdsbkc4?=
 =?utf-8?B?WlBFdW5zamZnbEs1dXAzYmd0ZVY0WVUrSFJJYVR1U3RDMVJoYklONWNLSC91?=
 =?utf-8?B?U3pUUWxKeGJBSFNQSlBwMTVQOHMxaGFVZ2NMMGFma0ZzMUlpMVJqeTNQS293?=
 =?utf-8?B?UVNHMW5nYkpPd1ZZWWI0NDhOckJvNVE5ZlhrdjV1UzJ5a0FkNURhUjJ2YVpC?=
 =?utf-8?B?SjV5TTZXNkJXM1JIUHVJaW1nenc2U3d5S3RIeXN1NXY5WVpaNGNodTZXMkxx?=
 =?utf-8?B?S1pjcjRwdW5JT1BaYTJJdFMzWlZMYUtZcE9Mc3NpcXl2MWVVenZhVm03bDUy?=
 =?utf-8?B?R0oyUHR2UWtVTW5WK2VDWXBhSW5tVCt3VitRdzQxTEJQYVpsK2dPdnI3TTZC?=
 =?utf-8?B?SHd3SWxLNldpOHZ5SmFIZ3g4QW9FczQxSVArRk5uOThYNEtudjFUcWQrZXVu?=
 =?utf-8?B?MjZ6T1VscEFyeVlUNW0wVUI0RktzQzkwUjkxa1VuZTZqbFhYVWIrZkpqRTQ5?=
 =?utf-8?B?ZVA3VjBHMkg0dHZFb2dYelNiaVJmM0NFRTRmL3AwSUVVdVh5U1hmd011eC9q?=
 =?utf-8?B?aDh6VVg5bUl3bGlEcCsvd1RUZkFrZXlzSTZ3K0ZyM21OM1lPRm1vaUM0em00?=
 =?utf-8?B?MVBDbUQyTWNiaHhoMmlFNjBFZ0dMYnIrLytjakVhcXkxQnRyRzNLUGVjemVN?=
 =?utf-8?B?QnM3ZG9ZR0NZbXNvZ0VTdEhqT3FWeDcwM0NKTmp1bUNjVHd4aW5mOElHNFMw?=
 =?utf-8?B?Y0drWklYRXVXZHljLzZHSk82SEMyUm5BOVhEL0RCUC9lcldYTmI0ZlB4VDE0?=
 =?utf-8?B?SlRaSnV4QkFtM0daTld4dHpyNnBTWllTOTRzdWFLcDRsa2k5ZmZIbkp1VFFI?=
 =?utf-8?B?OUJhUlkwYnc4blA5aW9xS01EeHpwaENsM3NZNlN6dWJyRFFjTVNMUDNOL3Vl?=
 =?utf-8?B?cURTbE5UMTJvKzc3d2lWMHpsb2p3WGUydmxEd2FqWExONHc1aGowLy94d2RL?=
 =?utf-8?B?ZUVHL1FTTTJKVWV0NmxTTE1KVk1zTkhqL2xvUnEybjRjNGRNL1ZPRjN0eU9C?=
 =?utf-8?B?RFVIeTNkN2N5Nzd4WGpLWkZQbnlVcm9CaDJUL0FERSsrSjNCck1aUk1HNkUv?=
 =?utf-8?B?ZnZKY2taeHM2NDFVTVpYaGRkN1B0M2FHbTdNRnJrTlgycENHY3Q5TmN5VnF3?=
 =?utf-8?B?TS9qbG1DcmhscGZuOVpGKzNwcDZuUFBCK2MyNERYWmVIZ3FnZFFzZ29aR0VX?=
 =?utf-8?B?VE5ZQk5Kenk5dzQvcVhzZ0ZlWGgzeHBvTjVvUHhFaVlxMlBqNndEUGFBODVm?=
 =?utf-8?B?TzlFUVBMV1VsbGRubEM0Y0wrM2h3NUd1d1FETWVMLzE0dTZNdEErQmZtdzls?=
 =?utf-8?B?cFdXSUxHWXVrQUl0Tks2T0c0NU5MajZpR3JIbjQ5Lzg5RmprTTc4TzJ1U3Uz?=
 =?utf-8?B?N1QrV0s5a1FWN3FmaHYvdnpKWEF0VitaRXl4eTl4VEozcTRaWFAzZmhjMVFh?=
 =?utf-8?B?ak9VcG1oYlhOR0pob2QyT1VjUFkwL0JLK21ma3hYUHdLNTFROGVNVVFCZFlJ?=
 =?utf-8?B?aDE5WU9kdDlTVHpySDBnVjhpM0dkWVR4NCtQTFRYR09LWlB5OXNKUHJ4ZXVN?=
 =?utf-8?B?ZkNOcndGc3JzV2docERzRnVCTE5WRkQwZXFKL0N0OWZaOTZhczVHeG5Va0Rp?=
 =?utf-8?B?NlJyL0l3dm55MXJ4bjc4OUlLUDdXZWNJUXlCcFFZY2ZjTHF0cGxscks0MDJl?=
 =?utf-8?B?UzR0dHRFVjFTREpnYjhLeHlISGhTRVl5WEVTNkgrRmp3Z2M4TE9nOVR3eXRD?=
 =?utf-8?B?YWwrQytUYzZ5dmtHMlkvdUtHN0xsVkJjcTVjalNJem5aU1h6NmR3ZjhVa3NH?=
 =?utf-8?Q?gTC8e//WiQgJZ4l6BhsObxGT4795rVLd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZudmRvL3BPc0MwMnY2MEVmdEV6SGNhSEVVV1RDZXVuNXE4WDkrM1hBWUZG?=
 =?utf-8?B?MmFnazhSRUpUTHYwRDN2dUk3LzZRa1BuRnB1bTlVcFIvTXUxU0IxZFdRakxv?=
 =?utf-8?B?RFpGdlRiUndyOG12Uk5wSEVMYnRJaW91d21GcHFXRGEzUWk3QUdLSlAyK0JL?=
 =?utf-8?B?TTB1VnIzSmFzK1NZblFFVTJ6TmpPNlZRZFdQbUt6TEFmd2ZOc21lTk4zN2Vl?=
 =?utf-8?B?YXVxWjMveDdXZ1U0b2FBWWZFMUpsUElib2FmQmdYZkpsWStqOURJaXV1Z2VQ?=
 =?utf-8?B?RmJSTDM5UC9OaVlveGkzMzV2ZlRJaG5adkNZNGVSUTNrWWtibUVyeU1yejJH?=
 =?utf-8?B?UHhqQTN5TnlnbVFIekdOSVNlUDh6V1FRc3lWWHQreWpHWXJ6dzZhZ2plNkQ4?=
 =?utf-8?B?b2ttRCtYQjBmQ1A3dm4vQ2MvSUlwUDNnT2owZS9yYlNnNDl3ZTNCNjUyM09t?=
 =?utf-8?B?eTZiTVhIT0liaHh0QzdvekwxRmxvNjF4MDFIRGR3Y2h5c2JoOFhpVnpIQUVZ?=
 =?utf-8?B?STBnbmdUU0d1bll4d0RvVG9pTWFwSEFxTFBvdG5kT2VGN2dxaUpDN2pReDFC?=
 =?utf-8?B?V055aitaaGFLM2FaYnlwdXVaMnp6UWJjbW9rZ1lFSzN5UHJUSnFvTzFLekha?=
 =?utf-8?B?YUhndjlYMTE5bnZuSWNBaTlZaFhxd3VNVGw0R2ZIdkp1V0hneFlBYXc5aFM5?=
 =?utf-8?B?Z2drQTNseXlFNWlsMlBxcEYwVEdPbFhDL3FOS3hnRFYra0pvNnoyajlDcjVL?=
 =?utf-8?B?VU9TQ1hFSjdmOTRtblE2QUtwVG9lYzJvZThRVXg2WlRuU0MvVm9ZdUZOaXhT?=
 =?utf-8?B?cWJQMmJYcTVTc054aUNpVHlsQUdiVXkzSytwTXNaY3pXemRxWnF1a0xveHBS?=
 =?utf-8?B?VHpKbVdaeDBDRWc0S2x2WDlMYjhudW40d3NsbWVpUnRadW8wOGk0RnJUcC8y?=
 =?utf-8?B?WWpEaTJNTUd5a2FZMExwaGNPMGNaUGo2b1ZFbktmV2xnOWh0ellMUjNqOGZJ?=
 =?utf-8?B?aG8zdG1xOWRtdkRoRjBYYjBuVW1ubGlacDRUeFhuWllVTVVmWC9UWnovZXFX?=
 =?utf-8?B?T0pvQ1VScTd3Qmlqa2RBY0Y2V2hyVkhYdGZMTlg0WnZmUjRYSnhGQmhENHMv?=
 =?utf-8?B?bGoxa2ZpYWE4R08zYTVWeGx6YWpPL3hNdDdJU1lmYmNWREFyK1pzdXljV0F1?=
 =?utf-8?B?dkk4M3Q5L0p0ZFRjUWg3RG5aYlh4VW80MmdsQVgyaHBWazY2dEpyVXdVcEcx?=
 =?utf-8?B?M3FwaVN5Y2JTYjZNdS84KythZXF4T045UlV5UUNYa0NZZHpKcHpKZkY4clBP?=
 =?utf-8?B?aElCSWwzNGxVUWs3Zmt6dFNmWWp3ZVBpdnA1OEk0SjBDUlZUK041MTA0VkRs?=
 =?utf-8?B?bkxzNVIwT0xva2tRU1dvM1l6bFE0TG92bzV6Z2E1OElYTXFlR25lWWFsR0pK?=
 =?utf-8?B?NG9GWFNmU0FsVm1PbVc5bndNdmxzcmRnVERvckUwYTZkbUJKUE5TOEpSOVF4?=
 =?utf-8?B?N1ViQ01MbDJZZ0RnOWlGTFA2QlRBdGg2ZnBnWXRlMFR5S3c0SWpPMFB5aTRJ?=
 =?utf-8?B?Z2JHZmFPNWRWSGhScUlqVnNqVHV3U2ErY0M4MUs4S3VEdkZlTS9IaGR0SWhq?=
 =?utf-8?B?QkYrb014VmNSQ01sSFlDUjltblcyY3BYOVVYamJtaVh4ZDlvRzNrOXhURnpB?=
 =?utf-8?B?L1hneHJwSVhJbFlacG4wLzYwUkFWVUx4amozeVJjQnBVaEJHWEl6aEg0Mzkw?=
 =?utf-8?B?NER3NFlnVHRoSERiMWF6elVBSjJ2UkNJZ0xJZUx2SUtHMU9RZDB4ZXJmMWtP?=
 =?utf-8?B?ME5VeEQ0NkM0Q3pSOHYwYkV0N1VqM0JycE9pUXVNNkFLb2QyMVpVbDRZOGJC?=
 =?utf-8?B?RkxiSWlJSDhuQUdiUDNzZFZhY1VId0c0N0JPbEdxSjRhUG1uUlhlVnIzT2Z2?=
 =?utf-8?B?a3pLSllEWUdHa0xTUlVETjdwNCtldi9LeXo1dmxRbkJFSWkvSkxoT0hmWG5J?=
 =?utf-8?B?Y0RpbW8zSTQ0K2dVWCtzR21xMll3K2Q3c2tWQ1FTU202T1EwWDkxVWEwM0th?=
 =?utf-8?B?RVZhbE9uUGw2MzZyaHdWMGtMaVhjcTlZT3VrdXQyS2ZPTmFtOVM2T1hjSkpG?=
 =?utf-8?Q?sgq6bwEKf4SL/vAeiVI2Pc5JR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b3ad54-a9fc-4f09-8cdc-08de17c1c365
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:36:51.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkqjJ7BONgrUEpCbshb0IRbRlfyZCJt0a46uyxbeX5MuGbflY7xqE6xqBghmDvhF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

On 30/10/2025 16:06, Johan Hovold wrote:
> Note that in most cases you have ret variable that holds the errno,
> which would not be caught by this cocci script either:
> 
> 	ret = PTR_ERR(p);
> 	dev_err(dev, "failed to ...: %d\n", ret);
> 	return ret; // or goto out;

I have a followup patch that catches these kinds of cases as well.

> It still generates noise and extra work for already overworked
> maintainers that would need to explain over and over again why they are
> rejecting patches that appears to fix "warnings". Some will just take
> the patches, which leads to inconsistencies (as only a handful of
> printks will be converted) and a push for a style which again only some
> people prefer.

There's the subsystem maintainer "rules" documentation in
Documentation/process/maintainer-*.rst which can document these kinds of
stuff.

> 
> So I still think this script should be dropped. And you still need to
> review drivers manually if you really want to use %pe consistently (e.g.
> for all the cases where there is no error pointer to begin with).

I am not sure who is to decide, obviously I prefer not to revert it, but
I understand your concerns.

