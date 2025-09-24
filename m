Return-Path: <linux-kernel+bounces-830911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D42B9AE18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B707517BC13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685C313D5C;
	Wed, 24 Sep 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IgHbi/c1"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020115.outbound.protection.outlook.com [52.101.56.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A03043B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758731322; cv=fail; b=oqw0k79pMm6reAdxfZ+GrCBE70dzz5aPJjtE4lqPYVTFEMlrz7yJANTJVw79qm0+lxpR9OxETYchGAwsXhel1Ozr6D2PvEoTqrP998hQkIrWAm6RqFfv48oDaQEPMAE4wWC6HqyhIAkpNQxSU2OwPsZYWK7His0iFjjvxprHlMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758731322; c=relaxed/simple;
	bh=2F0EOvkFpN2Gngp4cejCdyt+p0/WyPnq3osLgW8xGz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=g0n2Ipm6C6Wnc+Aq5amy+roWSqrK2HQXmoYlby+1J792RHWulqU8y4ailEjHH6RnRml0fgNftJSeiTjm+/W7XE8GlmfKgbBx/bnkkxlXnN+9T2rUS4cZxvr8PC0ppQC2jwvlgk1UWFsHEdICwJPoHUAj4/GHFv4A74TOQvERrYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IgHbi/c1; arc=fail smtp.client-ip=52.101.56.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU/r0w/pVFN5bTZzkPB4cuIPhNkO8MOC6XZDxt7y18idK0h+y8iqldRlU6sw0pj88g6gsFl8Wvgj3ZCNibki1BGf8d6ykg7ULa5yptxDpY2iN2CUlLGIsqetuasV2Dvp9Xg2wxdspfmlyEqAK7PxbMh4QT6w7524ytjEM7UKDSK5DtviZbkSE/SRKlPDkfB77dzafGQVY5Mmbdg9sR/pDpTyGTK3tOQX51OKogAVQqPvCGjPjzQRPqya9PiBC4U6ZhtIPIkjOgg3o6LBWHXIcTJMMZxdYLDlTz/qY7hH1hzHGNYxSM/72zizZ4+d8jxcG5pEEB6TPFBsvk0ixDH1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB1xSQkNnZqe0RB7p7zWe++N1/8xvU9tBwa1WvZxnas=;
 b=gXVNVHHj6S7D6pODRgnjQ7ToQzeSTu/RfzwIRMbOjTZkgEPr/Tex8txcM2wLMMr1LB4nRljGX5I1TdNFm6pk0z9jVwERAY3SIdNLIrYIeg2+Fjzb5f4Cynj1mxPBf+qMJlt9Ujarz/yf2toF91jBE/SZRcrD/nJjqzL2a09r0hY3qoTNgcG7Md3IgqZbWOKE59SVJi+OMUBJR8HGw4+HDkorsaCJqkIfwmW2BfxQbDGVVCv1MVz11rD+qkKX9Pdhl+2kiSLdP60E5k6Uszkxj1WIfmxX0qaKCdWMxN6gLl5gCvK42vwYtU1TNUim57FkKgUpHIRoc3hw2WKBOPMyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB1xSQkNnZqe0RB7p7zWe++N1/8xvU9tBwa1WvZxnas=;
 b=IgHbi/c1BEzPJ+ORU0RHkqzAUZOD5o8escsmqFHUx+N5GaOURhRxS88w9Bvc3kCtWbAoGVIZ39nGuLvq2SxQH7n3EvkWkZDY6WxrA0cp0xDTTOt2c7iU+S7FL+3zQPjyyGyGTsnFw6upqP4DR30Tb9tncUiSZxAqzGiD+PkKomI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 SJ0PR01MB6367.prod.exchangelabs.com (2603:10b6:a03:297::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Wed, 24 Sep 2025 16:28:35 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%2]) with mapi id 15.20.9137.015; Wed, 24 Sep 2025
 16:28:35 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: Jie Gan <jie.gan@oss.qualcomm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, James Clark
 <james.clark@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Tingwei Zhang
 <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
In-Reply-To: <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
 <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 09:28:33 -0700
Message-ID: <87v7l7n7bi.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|SJ0PR01MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e973f3a-cfc0-49bf-a877-08ddfb8768d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eCtHWmNGeVY2M08zbnlNanNMZDRINkc4a24wNmdBUTFCUU5abzYzMy9FelJS?=
 =?utf-8?B?Z29WZkhTdW1VVlZEYXNSb1hkNWhta0xpdVFiWkNHK1RsbmFhblBqTHRZdG1j?=
 =?utf-8?B?ZGtsazBmc2IwNUp5RkRBV09HNEFmb1BhZ0l3UGQyUTh4NlEvcDB0aE9tcVBv?=
 =?utf-8?B?d1oxRWs5K2xtUWFpaDExUXU4SDZ3N2s2Q0tlaDhhbkk0Y3lFMng4amRPMTgx?=
 =?utf-8?B?OEVsY212VHhBMTVqcWUrYVJhdzBHaU9rQVQxakZNU2pPZGRWU1pVRXpLbU1y?=
 =?utf-8?B?TnY2Vk9zTXAyK0VmR09oRXlwRlUvVE5RK0xVSlJMbllVQ09rOHVqWjZneTF1?=
 =?utf-8?B?WUtTZWk5eE1BbWlzaW00cnkwNWpXU3UrQW1ybngwUmswUDRpZ3dYQy8zSUIv?=
 =?utf-8?B?Vzk1cG9xZ0huTE96WXhPVWQyYUZ0UVpCdEJYd0VReW5OdGJrMGs1K3pZWndv?=
 =?utf-8?B?am1BNGlFV1RoNDIxV1R3TkVaWkNxSk43RTBQVVE1cFVTRjMvWWhXOENxZmNV?=
 =?utf-8?B?WFpiRDdQaWtGSXluTS9EbWtOYnJmT3hFbUFGQStwTTVvdlZlNEVBdjlmL0Y3?=
 =?utf-8?B?cm9McUQ3ejRUdDBqSnIxZlBMaWl4U1UxMDE2Zno0SitPNFZMbG5QMkFJOEh1?=
 =?utf-8?B?Wkw3U1Fyc2NMTytyalFFK1pNU1BnWlNvT1EzaStMWU4rTWJUcURVWmh4Nm8x?=
 =?utf-8?B?RTM5SlFsZnNMZER1c21VVFd3Y1ozRkZGR09RbkdZT3EyTGEvcVpwU04wUDZE?=
 =?utf-8?B?TGRsb1JMMTJDaFRIYmN4c1lURjI1aExMNTRqVXNaRUJYUHlxTHBYdU1ZMXBF?=
 =?utf-8?B?MmFEeUpmdldNZU1hM2Nobkh1Q1JNMU5Qc3dtWEh6dXdTKzJSQmJIQWJ1eGRm?=
 =?utf-8?B?OFQyRTFEZUozcDBZVURhcUZHYy9Gd3ArUjdKanBpalF3Zi9KVHdwRHVWaWtn?=
 =?utf-8?B?MVFCVUU3NHRMclkxZVRWNXVpMUQ5V21pTnlKQmptQ2YvaVdyc3VQR2xGU1Jj?=
 =?utf-8?B?SDlmbkVRUm5GSTNCaFRaVmFmalJrQzhtN3BuZVN1akMxa3p3TGkvVVV3STZy?=
 =?utf-8?B?R2VtOUpLc2lCdm8vbUFMejY5bS9NSkhGSzExMlFhMEdmS05xZGR6U2tGZjNo?=
 =?utf-8?B?dThGZzdvN2xuUXVoRzRRQnZhTHFhT0V1cTYxS3ZMY2E4N25lZFdzeEFNdWJo?=
 =?utf-8?B?OHpsUkhGano2d3l0eTkvU2xiQUVMRFhESEhKOXJyajcybEpUVXJJTHd1UWc1?=
 =?utf-8?B?MUJxVnBjV25URm1hVm9RaGROVHVmSytpYm5KMnhXOU9nTEtWL0xjMnhpeEFx?=
 =?utf-8?B?ZVhFTnhBMWtRRTRlcENiSDFEMjlKaGxpOWFLWEwybDJEVW5LYmVXMUlvWFZj?=
 =?utf-8?B?REJnN0h0eHdaMk03QUdKek9jdHJ4a0JVNjdmUTJsZm5OSGdleHB0YW10bjJM?=
 =?utf-8?B?dEg0Uzl3VTJNbnliYlBrWDJWOVdxM0JBNGlHSUpjalpYSHdoSkhNM0poMUVw?=
 =?utf-8?B?Z0dlNHZpc0RDWVU5RHV5Ym1KOUlyKzRaTlFONnZsbEd6blJmOWV4U1hpSjdJ?=
 =?utf-8?B?SWxkWmxZdXdPVUFCN0tpNFdqS1MySi94cnR0ZWE5OWVMVjE0Y0pBWS9EMzJ6?=
 =?utf-8?B?ck5JNjZaWE9UZWdiQzFpRkYvR1hQSGlPN3RIMHQvYzIrUHhwUncxWkc1YUp1?=
 =?utf-8?B?NW5XdDVBL0JtSUp2aUNvR0JyK0dONDVVSlhsR2FGM2YzdkpkZVU5MWJ5SFVJ?=
 =?utf-8?B?eFdOMnlRNmpYbk5EVTlWeG50TWhwZkJsdTBLSmNGWVB4NzhjOWUySSs5V2cz?=
 =?utf-8?B?L1Exb0FjeGNxZnJZd291ak8xZFQ0TEhuRWR4eU9yQUNubWJaUU12YmFDUkg0?=
 =?utf-8?B?Y1BDOFN2SXZ6OGs0N0J5SzlWdGJlZGlmRTMvOTg0Ulc4V0kzb0ZuS0NaRHJq?=
 =?utf-8?B?UjZLSCttaG1aSXJtMUZzZWgzbTIvQllRSVBmSEJzWTVkV1NEMEpLdThjeFZQ?=
 =?utf-8?B?REM3TW9BUXlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmxaMXdoeXgvSkdrbnNvRlljM0wxaWhza1l0NzhZLzc3WXdOaDhVM3p0NHFH?=
 =?utf-8?B?UEVxVStrYW9uOVpwUEdUZ3doYnlRZlkzWmxNaUFhcTNqb29BanI5UjZSQk1H?=
 =?utf-8?B?cm1PeDZwNk1oTmNrQ01xN2NNWG5TOHpSbFFxblBiMU0rY1ZqZUY3a0dTSFZ2?=
 =?utf-8?B?TU9QL3hNL0hWNVVSTmc1S2tDWUlrMUl5Tk9TYTZpSlhxRUs3RWRKdTVYbmZ2?=
 =?utf-8?B?QTg3d0N6WUVQaUQzTFBDVHVDajRUZmdVOS9ieTIwRHlHbmFZOFJlRmdzMXhY?=
 =?utf-8?B?ZjRrSjNDS1QrNkp5ZTJoVG81eW1KblVBL241SVh6K21CVW50SDBxd1UxSnhQ?=
 =?utf-8?B?dUJFZlphWnFjMHZmQnRBTkdVUGdtVFNseFhGOVRLTnVDSTFXK0RvdksvaUZZ?=
 =?utf-8?B?WktFSi83NHIxTXhrMFJFKzZZSkVtVTkrMUxka0NTSHZUMTZGZDN1MWs2MDVR?=
 =?utf-8?B?UVhXc1JqbUhsTHB3RWFMbDhrRkhxMDdUZjVPT3RIbGVGdjJJSVZIdE9Yci9v?=
 =?utf-8?B?eFBuTloyRnZJb20vcUcxc0JadEtKQnNHak5kTVVBbElHMkhxcG5LWGVaYnhD?=
 =?utf-8?B?dW9Ic05UTmdZV1VESXRBNDVOY1lSbEdUQjd6T3VoWnlpdWJHcThJT2ZLUzdM?=
 =?utf-8?B?am9TM1pBd3ZvbzExeEFSRXNhRHpuN1JkdEttQURoR250TVl4RlNuZDFnYkVk?=
 =?utf-8?B?T1hsQm4vZ1c4Tmp1QVFQYXI1UjMwSFpwaE1zanFvbW5nMm1mL2ppUFNndk01?=
 =?utf-8?B?S2x2MzJReGdPbWd0YWRwbEs2QSt5N3NUZW1DcGlZVmRrSUx5YmJUL2xXZDU2?=
 =?utf-8?B?eVp4ejloZVFnUU1NWTN5RHBacjl6aGpLYTFFVkc2VS9rdTh0NjdqUTZrbWJp?=
 =?utf-8?B?T2lJVzRGaW42eDl5dlhCdVpOd05ScHFIeUppbDBHTUZyK1NYekRxM2twdi9I?=
 =?utf-8?B?SktKQlJCZGNreHhmNHFPSGJWckFKb1lsYVpjOTlOSHlndWl2Uk50bjlIRnJD?=
 =?utf-8?B?REtIMzhPTjc1dCtQL1J3TVpMK1hOOU5tNFhWYWhVT3lRc1dmQ2lvTmFTaE1z?=
 =?utf-8?B?N3JGeXgwV21yejJudm1GbkZ3YitscVgrcXpiQlcyNkVNS05sMllmNXZoRTFs?=
 =?utf-8?B?UEFhZWdnK2ZPc2xwS0x0eDJ5OUU3eXZpTkR5UGpielB5MmNveTVuc3FOSE5X?=
 =?utf-8?B?c21Bd2lob0NINXlxc0Q5cmhmNUpoRWYxdCtSVnRFMGdQZWF2UHVjTVlSMWcr?=
 =?utf-8?B?Y21uSUxwSkZnRjc2RFBHR21PMXZ2U3laUzcxajB2MkQ2RUdLekFaMmw0TmxE?=
 =?utf-8?B?SlRScTBQck95MFFieDRwZzVPMEVtaDZqQ3NiZ0IvSm9tQVUvbEU5M0Z4d1pv?=
 =?utf-8?B?YkZ0UmhUMUg2cGNhdGNIa0ROWVpQYUl4aTZHWE16bEpKVDFmdzBZTlRYK1lV?=
 =?utf-8?B?YkgycFF6OGpBamVhY21NYkp1YzZzZGtRZ1hYK2J2TGpIV2FJZ3NWMktQYktS?=
 =?utf-8?B?TFFSVm4zZlRWTEFUK1psWEZJeWdUdDNEOHF6R1pKT0wvUThpUzZYc0hKWjhL?=
 =?utf-8?B?SVEybWxKZVZwNU5ibWhpd3pSdWNXaGdGS0VZU0tya2J2N0oybkxYT0xzUWE1?=
 =?utf-8?B?RzdzVm5UNkEvUXR4QXRIQmJWb0pzOEVkS3dBTmgxaG9YVlg2Z0ZSSWhCbmlp?=
 =?utf-8?B?d1R0c0Y1YnVqTXRLOW1jN25PeXpScVNPKzErTk9vMXBqRzErZ3lPc2xLMkRk?=
 =?utf-8?B?WGF5czhEdzZVYUtTcnp6S21tNVFSOFJoNTZkL1FBOEdlTnR1ODhhRDBjY2Yw?=
 =?utf-8?B?aEZ4QnZPcFdKREZqUENTbUtWUmhLbTAzTVBuTlN1YUg5OUx1ZnJMY01lNEEr?=
 =?utf-8?B?OGIyNjFlQzRPbWhTYnlrSWFsaDRrQXQ3M2RMaVdJaWRQbGZVdDBmRFpqSVhF?=
 =?utf-8?B?WDYxcFVxTEI2WUV3Q2FDUTBXNDBpRVRpTE0zRG5tdUFtVUpWaEtiVko5KzZY?=
 =?utf-8?B?T0x1T1FqOFlTcnpkM0NEa04wdGlYenVweUVQTVFtRnAvZ2VuZnZBQTNoZjFm?=
 =?utf-8?B?WUd2V2UyaGZJTkhSVm1kb1phckhGWmJlTWthaDR6YkQrdWpnRVNDRTRvNWtG?=
 =?utf-8?B?SXU2ZDB6eUJob3VPb1h3Z2lFTGh6dVpXSTVlN1d2OGFwMmxnOFlNZkR0MWFr?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e973f3a-cfc0-49bf-a877-08ddfb8768d5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:28:35.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsjYj5RT5ybS1dzVYVQWIdIvuWqmzJeEY3GvdOgg2revcrVQZCCjUqVuQmNMQj0BuybAXNsL5uZHLMnMwPyXEWwHjiRjuVPRF/5ugLidZPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6367

Jie Gan <jie.gan@oss.qualcomm.com> writes:
> On 9/23/2025 1:31 AM, Carl Worth wrote:
>> I'd still like to have the original command I used to trigger the bug in
>> the commit message. I really like having reproduction steps captured in
>> commit messages when I look back at commits in the future. So, that was:
>>=20
>> 	 perf record -e cs_etm//k -C 0-9 dd if=3D/dev/zero of=3D/dev/null
>
> Sure, I=E2=80=99ll include your commit message in the formal patch series=
, I=20
> think it's V3 since you have submitted two versions, if you're okay with=
=20
> me sending it out.

Yes. Please do. And thank you.

> The core idea behind coresight_path is that it can hold all the data=20
> potentially needed by any device along the path.
>
> For example with the path ETM->Link->ETR->CATU:

OK. That makes sense to me. The name of coresight_path definitely threw
me off, since I interpreted it as being a description of the path, not a
container for data to be consumed along the path.

-Carl

