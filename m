Return-Path: <linux-kernel+bounces-813777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53DBB54A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033471BC15AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C099265CC9;
	Fri, 12 Sep 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H+zTXapG"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FAA2F3C2C;
	Fri, 12 Sep 2025 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674959; cv=fail; b=bp1DKxpLjat5E4KqYQPyYqPJkiAJ++XKdngzii4V8w8XUgsSZFAFxVZ13TITShu+OQwb2Wth5Wg+b3IkVY1M5gIEKHF+mFXGCO7+ZggAoq4euX5kAA2Qtkmk2kjkev/86ktYE56Fs10zmwTknRbLIfzLHmhKTC+DsTirgIoM6/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674959; c=relaxed/simple;
	bh=MeIiQkT0NamzCXh0n6Dce7lhDHHseWMOzAysKZFrnI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RsBz9vkhPx5mn2Yk/qtNTyxysc4fjJ25WX45crYeiFRqzioPAtDgwj47c+1fg81+c1UVORF+lcYX2FmEXSJpu83w+O7gL8WTmCbLrwvtZz3vqXvSYbCanXCrakjMGhDHTKMVO5iUhNNsi9foqpAD2+SsXzwikWGl4TNtqYEe72Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H+zTXapG; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTPvKpE6NqGIxvJJRbd985NfNvgk6DaMkHHydnVWS6SlpQrFRsEOdMuTvr+X8kdG0bSJ76qStnzIn+RYTSBCcXJ2xATKXAgS83cLxKDyuvPPiWySMzuFvlP2k3VKjLlEG335YO7UVwX2Ua1aUb+GMjtuSBm9s2vvzHHe5wRnnTNi23DHL3Dmh51/MG4JssO5PftxW2H4c/ZGDrCa8BTz50AsUhbhMqpqPo/WrgtpPTajoc7uZwwPCI0RAQP2IZnKsGuQoqqxke+NefZKBy7OGhLzR+mjHl886QaBhdooYWVNDhDo2Xg3rSbfdJ3H9LbwflP4Qlgf9y/3ZieHFPFPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEv42D+oRsUW7F66caI4+WYxekgre3MZ7qD4NB+Z3us=;
 b=mjFbmj/WUZYkzfcpNAJ6g3UyJOs5selYFgmNRkHfpV+FCB2Cn5AsR2a977CS1/tnAg5Fr5eEvYKjRGkpUdcJ9CaAl5OwsBTfRZu8+ndknq1afWPT2bGSCY43ilpm6uNmVAr9Vv5GvfU0xWS2sQaZr0cWxDzeooTiyv9+qV8NYJWr63l/qzAvBGYC2vy0ABYY6FZPfMtS2tUXYyzJWGM8mms7v6f4bI6YJd8Qi+VEGw/vL5x60ZIdClvaOCmEHW/EXIadm2ao/3gUqNC7ON/04YOfgw2TUjnOBdwO8um5y0eCd5X3gV/xlWfxvqNnUXLKQs4N+0abpJrXRG2ygB5uxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEv42D+oRsUW7F66caI4+WYxekgre3MZ7qD4NB+Z3us=;
 b=H+zTXapGH2MCvnUYJIiQ9mcCew2nFRTCYa2tYmuVL/quppyzI3Pcu/vJv7ZhMCUsq3Z43/v1pf+K9io0mP9Me1dJM7f2ooBT+jRp2+LNBQ7+7RJ8WO30ZebErKcQ9OAMREXhZXTspPlzvpdaXx52KsQvHAQmJ4A4rgO/lJxH5ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 11:02:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:02:36 +0000
Message-ID: <29bd0b43-b5a4-4182-961f-a3613acf47d1@amd.com>
Date: Fri, 12 Sep 2025 13:02:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: zynqmp: Minor DT changes
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1756799774.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1756799774.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7e8e10-f53e-467d-d6b2-08ddf1ebe18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU5qcG0rQVBUR1hBTlNnS28xaEl6ZjFLck9MR3JtbW0zbG9QaklEcnpMeGQv?=
 =?utf-8?B?K2tpWXlyRURERitnRHMzbWRCZmF0dDJ6WnZxZTBkajFlNWJRdk8zcmpIaXVr?=
 =?utf-8?B?MFQ2TXEyUkpCSUxpQms3eVhvS0pFSlpSUkZpU3Q0MmtzVjNWMmk0SldyL3lU?=
 =?utf-8?B?aW5mREI2dnk5Sk9DamtieC9XUzBTL05CaGJKT25mMU02SUl5SHdOUDJJYzcx?=
 =?utf-8?B?dXJvZEd5K3ZiMm5rRDZ6ZzFlMG54N3dYVWlHNlVpN1QvRVNRUEhZSEszOHJH?=
 =?utf-8?B?WWg4ZVFJUWNSbmRMYWc0SjdxeU5CSCtkbG43d1E1YkVnazJBVm5Tc0FGQVBm?=
 =?utf-8?B?RXZ2OTZyY3ZiVENTQ3lQbG5YSVh4R25XNEtSODVmdUFZYS9zZm9kT0xGKzlJ?=
 =?utf-8?B?TlZUb3I4bkUyZi9NS1ZIUHJPd2cwanA0YjhEVjgrSUNDU3lkZjQvTE9YMVZu?=
 =?utf-8?B?SERMS0N3WFkrbXlaZm02aTY4cmpidE8zNkRSOThrdDdOOWc0YXQ1OWFSdk9o?=
 =?utf-8?B?VTV1UFhRbVY3UEpkRTA0bUtOeDBTcUhuOE9Ld1RYL3liOCtaa1AwVi9tZGIr?=
 =?utf-8?B?LysrVmVTMmRnc1llTW8weGVVMC81OTFDUDBmUnZYN0paWmt4MUZLNXV3T3p1?=
 =?utf-8?B?R1R0cUdaVnNvcU9ZK1hBMjBTUnpOSnQ4bmlBOUc2dkFGemYrbWZGcG9acGxm?=
 =?utf-8?B?SXR5SDZBSXhHTE1MWFRDZ1FHUFlUNHpYZWYvTFNEY3E2VjdhVzMzOVRXOVJ1?=
 =?utf-8?B?OFJiL0dFS3BCTWJTQ0dNQ2VydzdMUnUvSkVyZ3pwNlNtV1B6WHVVNmIwa1B2?=
 =?utf-8?B?S1lNYmVFM0dlQXAra1FQZGtvMUFFR2d2ejhkYjM2SUtvN040aHBTcTczakxJ?=
 =?utf-8?B?QWh6Um5ySDZWZG8xYnMvMmY5Rmo3a1FqV3BvM0R1RUxHKytFemV6bjI1bDlo?=
 =?utf-8?B?Sm1leTgxYnFVTWJIb08wTHJ4TnJaL1h4LzdjTkZ6VTl4ZU45ZzlQblZVWUFH?=
 =?utf-8?B?YncrTElmaW1RN2kyb01MZS9EbHdNWmJVRHlFTzRiaWJRdXVsZGpHT3dvNnFx?=
 =?utf-8?B?YW40cld5N2thTnY2VHBCSjhOTXhyelZ1cjZ5clF5dWVhdWwrT0xRRDJQemZw?=
 =?utf-8?B?YkZsUHFxdkpqU0xDQzhmSGttaG1JUUpTL3M2QjR0eHRLU09qMXF1Q2dpblFi?=
 =?utf-8?B?SWNXWUk2bWtWUXhGM1NvZzF5RGN0SmtRZ2oyMFhtdk5GTUNXbG9nWFMrS2hv?=
 =?utf-8?B?Z05RNEp2dFpHWE5JbmJuc3VEWHFJZXAzSnludXNYZERrYzlUT3JpQlJQOGtk?=
 =?utf-8?B?MW5qbG5YZStoaWo4Q2F4M00za1BUY2h4VUlnTEFURzhwcThMeWhlbmE1Y0pl?=
 =?utf-8?B?Y1hyaUJXbTJ3QmdKZTFnV0xRbVhnVVc2VHVsb0lIVGtUZ09pTDRYcEtVMXJM?=
 =?utf-8?B?Z3NwWGdHakVReGhHMFd1OHVOT1UzYXB5M2kyaEUweTZEVUZRRkJQOVNGNW9Q?=
 =?utf-8?B?Y3Z6NWwrTWN0N1dRSGRWdDlvQVU3ckk1TWhtamZwekV5VHhLRlRFT1ZaY0U3?=
 =?utf-8?B?WDhYTWtUQTdKRjd0MThYYUdHMThhVDZzc0J2VnMrbXRTdkVLTWZESVUwQ1BC?=
 =?utf-8?B?Y1g1RWhONEpFdm9MZk1RdEdZaWh4ZTZTTGlSS29kOEptQ0lEd0x1WncrdnVx?=
 =?utf-8?B?Uml2SmltV01keTJRcHh4TnVoeVlQT3NOSEhoa3lxSTZLdHBCTEJzV2VIbjdv?=
 =?utf-8?B?V1BVb0NDNXNYbHVIVlRCYVJ0NDhod3BjYTZRcFlBa0diSHBXYkxJU3BxbTE5?=
 =?utf-8?B?OHpFRGI5U3VLd1ZYYzVrS1hxa282b3BsOExNczZyZERIc25hVjUxc2FEQlhS?=
 =?utf-8?B?OE5nL3RZMWFvMGVJSHZTNHRhWi90L1JUZEF0aWRzKzIxeGJKWWhIcTBLVXFi?=
 =?utf-8?Q?HxsYV8pOnYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkpJOC9jTkxmbk11elZQL05JajFnRklVckdZVXlvTlVYZUErR2dHRFdBZER4?=
 =?utf-8?B?cmNpSW9PMGdidlRsakZpRHo4OGgwN3N3Q2JjckNsKzJUeXpRTjhubkQ5LzF1?=
 =?utf-8?B?bjcxMDFMMWlNaEV3ei9GVHFEQzdSM05PazJJSkZ1emtRZFNZTlJDVXRNTFhl?=
 =?utf-8?B?cUNsYWwvRG5nWmNBWUVwNG9zZStVa3lJUUpOZ3BFMS91RHM0MGZLbU8xejg1?=
 =?utf-8?B?YnhGSnNaZHIxengxQStmanMxN3lvakJKWWE2alN3S0xCWUVaOHdIZmRQdXRJ?=
 =?utf-8?B?UVJrczhqZzZMVElwdWF4eFdKeVpXWndNQ1ZmUE9xdzZYVUZQaWhuYzVldUNN?=
 =?utf-8?B?NzZUM21qcExUU0JHM0FORDV6aE1FNkRkdkRScmkrcTFCL2J2cFdRcG15MDBF?=
 =?utf-8?B?OXlMc3VjR0Z2dG5ZT1M0Z25ZMjJ1cTJSMVZsbXpPL1pkRHpQZTJEYWs0NW5J?=
 =?utf-8?B?cXc2YldicXlUcEpJVDFhaFNpbmk0c25lUkhNamxlanFObzZhQjhKMmYxdHVK?=
 =?utf-8?B?UHRNYmVmOUdDZjhTZDh6TWxFamV2RUVGbGM5b1VFdndCMWpITTQ5ZklBc0Vx?=
 =?utf-8?B?WEc3TEova0R5anEwcHZ0OHBidFgxOU1EY0VDaXlyNE5zSnMwbVNOWi93NDN2?=
 =?utf-8?B?bzBwM1ZKNkZ6YmdQcnRzQmdDd25TMjErdlBkQXhUUmZwSjhjNURLdHo5ejdV?=
 =?utf-8?B?QlZFNDhjaUZvWVlVSmpjR2kyTGZuMnp2elBQTml0ODhEMzYvRG9IU2JSZU11?=
 =?utf-8?B?djZSRUxHS0JHbGhYVHQwWjZWUGlLNldOd0RaU1Bwb0F3MUVnZWxIVkZyRzRE?=
 =?utf-8?B?S3h0dmJaa3J4TWdzTGZsR0d4VmJRa3BITm1UL2pwbng5QXh6Unh6S3VESTM1?=
 =?utf-8?B?bWpTMUFubDNkMEsvQmFYR2U2UHJnb2dxMk1LUnNIV3BHSkJnb1EweWRJS3Ru?=
 =?utf-8?B?eXFrNzJHWVlKazFsb1N0Zm5QcEx6YzZ2TzhERkNtYkZiUkVJYkhqdS9TcXlR?=
 =?utf-8?B?K2YrWS9yMWppWFF4Ykpla2VjaEI3UmYvZDdsVnJtcUd4MmhJeDRXcVZidGdY?=
 =?utf-8?B?RHJjbkQ2V1NYV3RZaUhMVUE1RnJFbnA2L0lNOWFaRjZQTWFtWkQyMEM4alEr?=
 =?utf-8?B?NnZ3c0tyVGJlY0lrdmtvRituS3VYQ3BNd3RnckVHaHlza2NxV0ZzU0k2SXZI?=
 =?utf-8?B?cWp1OXkzM3lCNnJ3N256a3ZmN1BwZSt1R013NE5LU0NkdVhMV3BXVnE2dXZ4?=
 =?utf-8?B?N2pWTWlLMXUxYjlFYnZXWWJJTC8rVnRkMmh0ZkVUNVJvZnlpVE5kTXQ0Wk5O?=
 =?utf-8?B?VXhZOXo2RTBxSU5ZK0p6Y1ZoZE5RSEVRbW52azZpdVpRUUdUaTJDaGsrWExW?=
 =?utf-8?B?eTh6MzZCQWM2bThrckxVb0JqZnpiNGhubzRXWnB3cnRpelE0OFl2V0NVTjk1?=
 =?utf-8?B?dVd0VVpjQnNkZzN2M0FLWkIzM1RXQnMzVld2MW9pLzJxeHZwcStkcWpqSTc4?=
 =?utf-8?B?Y1ZmSk9EME80ZmEycWtyb3pGUzRyOUhaUUpxVy81cjFVYWVhaW5TWW9SRHpE?=
 =?utf-8?B?cEVQT2IwUWltUGdUL3VKZWNVbXN4ZmU3aW0zN0c3Tk1MT01pcVFMQmN1UmpL?=
 =?utf-8?B?Ry8xRUs0Z3lPSTJkNG12RGhCRmhZNXl6OEM4RzRNeHpUWGhHS0o4dzIzcmU3?=
 =?utf-8?B?RDN4aXYzOWtwMW1YQ2VkVjJZaVhYVlB0VzVPb3JONnN2ME15NVBmclAwQTdL?=
 =?utf-8?B?dkZZQVRERjVxSzkrM3Y0OHRFc25pclpCaXRBcmdTMElUUDZDMHlrdTRmb0pW?=
 =?utf-8?B?TW1GU1AvMEg3WlJMMHpPUTBmaW05a3BwSEhKWWJtZzhxMUVTUU5ycStVcDF4?=
 =?utf-8?B?MWlTYkdUMFRlZTlpTG8vVlkrUXkvWS9EUmgrdUpsRWN0RTlmRncvSkhubGpo?=
 =?utf-8?B?bHhvMTFVWFE5Q1NaVXdXZlErVGNHcnZ6VEZEcG90N1pDY2xRWmRGSkFRdmwv?=
 =?utf-8?B?QVhhVXpMMDVtZERCZUloZHdQM0ZmUndNWmh1T2FEbGNzZ0xvYlRYOUhybzZK?=
 =?utf-8?B?a0JyUm91WWhqT0lqamNhTzlKSFowMHBRT3FqMURBMGhWNVRxV0ZPYjQ4M2dF?=
 =?utf-8?Q?6VqOCWs4g8Mpq91rfwINSdXQ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7e8e10-f53e-467d-d6b2-08ddf1ebe18a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:02:36.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijhnVK5BTGKh3rS+f1xpG3UoWKYeYtV/VTbiISIoAAO831GyQaf2qKYB0+A+l3M1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118



On 9/2/25 09:56, Michal Simek wrote:
> Hi,
> 
> sending some small amount of patches to get in sync with U-Boot DTs
> to be able to switch U-Boot to OF_UPSTREAM.
> The next step is going to be to add missing boards to Linux.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (2):
>    arm64: zynqmp: Describe ethernet controllers via aliases on SOM
>    arm64: zynqmp: Enable DP in kr260/kv260 revA
> 
> Quanyang Wang (1):
>    arm64: zynqmp: Disable coresight by default
> 
> Radhey Shyam Pandey (1):
>    arm64: zynqmp: Revert usb node drive strength and slew rate for zcu106
> 
>   .../boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso | 17 +++++++++++++++
>   .../boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso |  5 +++++
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 21 +++++++++++++++++++
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso |  4 ++++
>   .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  4 ++++
>   6 files changed, 53 insertions(+), 2 deletions(-)
> 

Applied.
M

