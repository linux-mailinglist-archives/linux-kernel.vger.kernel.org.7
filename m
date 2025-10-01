Return-Path: <linux-kernel+bounces-839176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC375BB0FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D471892325
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A030C0F7;
	Wed,  1 Oct 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XrNMwhXE"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF830B511;
	Wed,  1 Oct 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331040; cv=fail; b=QhvQpWPh7suJyigWHUBIvuyPlEGdiSKCQJ6HHDB53yeeV69FNqqIXysM2IsTOoHtjiziTvqTZE/a/KUijgUW6ZxY5OaKnsaZPExwHv8NNj6LRgsiRQ+wPNhjwzOQ5wk4T8+o3bG6SGTTmPSfQrgUla5Ygp8FkNRw0D3Gw75bNb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331040; c=relaxed/simple;
	bh=ERvXOniV/bepGS8pB7dNJz2+Mg1/NG9GkYFZVKxa5sg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lGUDdIz634LPeeeuczA/jLsnCJS4fZPO+5p9WCh7ojHVfRPI6XiEMh/rIK6vd9a98eTYNMTiWmOs7l0CoTOF6a0DwzKyrod0WmdD3spFaQvgV64H1cpkDNhJhIegchAZm21BZH65kAJfA/3iNoEN2AdMnK/qCtfaFYbouwqzaT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XrNMwhXE; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSEib6d/Lh0NFvZRYiez6aYqJV55/iuXgaZWo2FxpCNOcjwVLdcJdFt33voLhZV2GxFQpmm5IuYI7hAlv55VnGgicNkjzEd/qauT/dOQsCbQAYkxo7Cne3uecxdTCmgczIvWVcRyvxHQGI57+cLRBXbEvB8qJhtQoZIJuh+t9KAi7RT0nMezXrwXzzUKSwsIUZN/jR193Qi+9Tk8uIWajwjCU8vVcoRxpltoYMsDdioWnzutR5J3vyXQgHPTY9X+yMhMkyH5bcBmDBnOqT3VwM0/0GB7ILyIg5Yd5ZldhZ3o0PS5YO2DPsAlDUCGCXNXhMioHMZgw4vpm5dA9ywPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH+S5ou7LvQwaGiOP9g19UDCEwDgzYmMuXjgJhvoqik=;
 b=gp97AR0oz4xx/9/dU/AGlIQ0DL6/anmmmlOdo3OKf1hQBgwvP9aORMAZnEOtn1Fc9Eqss7M8PJgpStUeynBPniq9Pp/GuijkdutbpCrKrs+rH7+R9qn8pQjsA4idPY8iDHs90dHgO3+6GrVi379MnmJmxsAojPufeFfMBAkfTqdi0g8qEu7FeN0CMpwTQMjCKPvnb8jhT8lOU7kx0nZH8uC9iXxZuk+32K73R712f5blI4YN2YkYVmPR4JlZo+GrK4sB+DmJ9JZCsdX1xWMRD+L5bPu6fHOqWL450vwFhv8CEk4wZ1l7gQlI7fajk+R1AGlo0E23wTuFF8Oan7PjTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH+S5ou7LvQwaGiOP9g19UDCEwDgzYmMuXjgJhvoqik=;
 b=XrNMwhXEZJgrGfq2shIBux845TJcUY27+/JX/JMroKKPGyV3J21itue87N8SkGE3++P1qe7nJ0mtyHgIo7s5F1speISDfGPLurNmk1UfWh3C68l8D8M4otLZy3pwwfyPxlmAQ2UbijTAGO8UZl/oWlIbrATDsdnV3R9dQIo8GMY5Lcd4NG77Gtw/Xqwnw6uNt84pFlOEpoEzDAyDJGe/GDAUxvxixG3Ev8nqCljn7MyMBPEJMgUJbgmkSjeOmBQ2fk1ebBIOKfDdlN9WUVWwA/BHCqfh/xDjaKwpiDLclZeqia5+UM6fzKcg3JL6/mxvonLOTKhtqKug2xJtMkRohQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:03:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 15:03:55 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 02 Oct 2025 00:03:14 +0900
Subject: [PATCH RFC 2/2] gpu: nova-core: demonstrate use of BoundedInt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-bounded_ints-v1-2-dd60f5804ea4@nvidia.com>
References: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
In-Reply-To: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0166.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 376689b5-89e9-4679-db49-08de00fbbde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjRDVzMwcmZ6ZUVOUHNmTzhjRnFOQm9IblJSakk0Wk12SHJRNStXNTM0TVNr?=
 =?utf-8?B?NjViUHZ0MzU1Q2grOGZGOXk1OENzRkVMR1djek9TaHlRWWRLc21vRUw4YXky?=
 =?utf-8?B?N0pCZ0pDYkVldVJqeDFISTJuN1FEY0RUUDg4b0MweittREM5RjFZRUhTTVBM?=
 =?utf-8?B?QlJvUzdWV2tZZGRBYkFDQTkyMStlRVFWc3FNSGV5eXR4RVNjUTVuRDUrTFpV?=
 =?utf-8?B?Q2FpVzlRdGFxWUgvdlJxNWZwYXJzVlNCUmZybE5QbjNXaUdJNncrQzF3ek1k?=
 =?utf-8?B?RE44TkFnVUN3ekhNL3dZLzZIeUI0Z3FQcitZWUFvWUVvUkI0Uyt5N05TbEE5?=
 =?utf-8?B?b2dpVUhMenpOTEFFYmZ6OU9RemtXMmk0QUFCalhLQ3ZTOUN4N005ZkdTbnVj?=
 =?utf-8?B?TDJvaFVoSjdSWHJHbEF2SnZVK3dIcGVFdTFIZDBGQlowUFNlelZFMml2L1Nx?=
 =?utf-8?B?TDVrUUtSeTk2cU12RFlDMlQ4bG5RZmJqU1FkSkh1bXYzL0xQSGVoclcvNmFZ?=
 =?utf-8?B?TThYZGwveTRMN0lMMk5VdCtpaVRzT0diTmF0ZmdHbnJrRlZLSzZBWmNLUko4?=
 =?utf-8?B?aWZEL1JQK09Ja1ROZFFBdVRYQVhLOVI4dXlRTXViYVZwTUxuZFNUY2xyMlZ3?=
 =?utf-8?B?bmVZdThNUUNNNDRPeWZwWnVSOW1QMmp2SHhlaDFBdDZ4SnRaQlZjMjFuSDZZ?=
 =?utf-8?B?eGFjRnB3OE5VazladUQ3eVNIaS84SENJTnU3R01ka2g2TmFteUkvWnYwTSs5?=
 =?utf-8?B?bE1iYVpKSFM4d2Y1eEhYTzJsZlNJcHhyVFNubXp6bE45WGhTSmR6OVdtTUFQ?=
 =?utf-8?B?UzJtdzhRUXZyeThNeklSTTdvRTZlQVhzNXg0N3FReHlJMEJkTzArV1ZWcXVh?=
 =?utf-8?B?WHpPaDI0dm4vamtPS0hNSTJOVkhsclBTbzFpWG9QeHphZVJ2WThNWWdpUDM5?=
 =?utf-8?B?VzZPWHYwcXFrU01uMGI4OFFQQnFSVkVhelJhYXljUE0vNkt5S2FkSUY2MzhM?=
 =?utf-8?B?NnVOK0pUNDU4MitKOHZ6ZnNSVEJ4RTdPUWpENDBWWkJqc052cVcyQmoxN09I?=
 =?utf-8?B?VEVLVmlqM2hraXJvREtWa3pqVGZDcHpDbGthQzVhVmpBOHNwTjBDaG5jOStN?=
 =?utf-8?B?T3RxaXFFZWxXYVF0amxuSkNBT2c1UHJKc3R2WmRUSXdVYXpTeG9rWHNoWkZm?=
 =?utf-8?B?V1FXTVdtMllzY3VVZ0JNaEtFZGwxYk9QV1pZZjFEclVZRXNsZjVZdlRYSDlQ?=
 =?utf-8?B?V0xDOUZlSjA4bnQwNU1pbldYbjM3eGV6cWdVaE1jdWxHNTJGRFpjKzR5MHEv?=
 =?utf-8?B?bXhKMDkzb3VPQ2trWEdmYXJpYjZmajdOUW5VOW1VVGpoNVlscDk5NE1Bb2M0?=
 =?utf-8?B?OXh6b0grbHdheWNmWWxlV2JITC9BRHhQRGYrWCtCckJLTjUybUVldDc0aTRa?=
 =?utf-8?B?ZEJKaW91enBjNWlDWFZmcFBLTk9pb2NLREVyS1pXUjVHZ2xCRVBNYmpCV3pP?=
 =?utf-8?B?OWpnaW1UTXRpNmR4a2hTTm50aE14cC9CMEY1R3lhbzlUTUVJaUU0YzdlMldn?=
 =?utf-8?B?bHVkdVdJd08zNk5QdDU4aWV2b3R4bm5QSmxvRXZ0czBtTlRIL2tTdm1kUFBa?=
 =?utf-8?B?VjZWSC9EUllvdjVhd3RsRXZxa3UvWWk5NHltMy9QRnRqVjdsdmlVR3dQdGZm?=
 =?utf-8?B?RlpEUGJmUzlLZWpMazBrYzJyWExsazJyRmRuSytCb015VGpERU9pZDZvVldh?=
 =?utf-8?B?QUltVU5oRVpTeGsvc0JkdkQwYy9sYlpVVitOMHc4dDhEalE2VlFJMjVoRzhT?=
 =?utf-8?B?Y2RlMlgxSDFuZ1FtMkkyb2Q3UUtoWnBnWENsbElEUnJXVW52RjB2Z2l5ajlW?=
 =?utf-8?B?bEhmbEFGaStER29WVytFMXVrMGlNbnFobEc4Q255OWJER3E1bngyS0N4MWd4?=
 =?utf-8?Q?MiqqsIVI1Cf+Ywv0LqhNakySD86LZt99?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVVMcEZpeTJlQmFHRmVJUmFibnFEeTI4ak93OEw4OWJZNWQrRi96YXZZcS94?=
 =?utf-8?B?NWs2ZTN5bDcrOXo3TmswK0IwdjN5bmh1UGkrUXRmUTdpOFBxSHQ4aVd0OURQ?=
 =?utf-8?B?L2N4c3RNQS9XR0pIVnBXbS9VQjdJYmdqamxwNG5Zc0RSQitFS1Y2a0thRWJP?=
 =?utf-8?B?eGhFUXlPejNHd0JXT1laY04zQmg0dHdEVUVrRlJ0VWhOYjJtdFJ5eFNWby9m?=
 =?utf-8?B?TmJ6SS9mV256Y1d4QmZLS1BuZFdudVB2QU5pQS9nbWo3Q1BXUTZ1bVhDeXVM?=
 =?utf-8?B?ckVFbjNHMTFHS3Zpd2w2KzM0NUxlcTJ1UnFXMmRXQ1lHYVg3eWJZVUZiYzgw?=
 =?utf-8?B?R3BXZDdqclF5ZWNuZTgwRVZxTi9LbFhnMDlCU1A5Vlh4bEFnNHVRYzFHWjYv?=
 =?utf-8?B?eXptZm1oOWNFRkx1cWNreitLQjJVdWhnUklvbnN3UG8yODlvamllNExLNUEr?=
 =?utf-8?B?N1JOeWhRdkQzSVFqMjRaZ3g2bEhmRXgrclFqd3JoK05GN0tacXNmUVdseWZP?=
 =?utf-8?B?SDM4VmJoTUNuSy9vdzZDV3hqcHRTM0huTzlwR290ZDgzN0l1NTJCbUxvTUZu?=
 =?utf-8?B?TTJ0YTRWTlJ2MEl3b2hjRUd5NWtaK2k2S3BGQzg2alZhb0dQdU83RmpDZlRB?=
 =?utf-8?B?VThqZy9BekxTdWs5SXlpeVZzTnRhWVFSSnA2WFlBQXJVc1cvTVFnSm1kWHF1?=
 =?utf-8?B?ZkIzdFBFYVlBTVRSRG9nTGY3Q0ZmQUFBSkU5K3p6bzJRZjM5THFGSjVKcmZk?=
 =?utf-8?B?Tzg2SU1yWGhlQXdWSnRRUHFiRG9XYm0yclVXd1N6T2dwcitoYS9xL2FjOStH?=
 =?utf-8?B?SFcwbnJMSnRxVld4alF5M1JWRStsaC9EMnlZYm5nKyswQlNMWHd4RTBQSVhF?=
 =?utf-8?B?RUZwSjdTM2x3di9JdVdQV2hycStkaEppWEVKVkp3VUxIOXNzRDY0djhHc25z?=
 =?utf-8?B?WmxTSVZaQlRkKzVxVUMvUjFOVEIrYmxEbjRvTUsydDlnZmVZampoNUJIRkxq?=
 =?utf-8?B?R2M1MHFCZGVYbGNHQnZDQ1diVFlzL1Y0SjdmdndnNVJLQkFtSFkvWWZET0hF?=
 =?utf-8?B?QVIyY0E1SmpENy9qL05mUndwekhyNUhDZEZGa28zaGlYWW9VaHlhcWVWTURP?=
 =?utf-8?B?T25hcEpFeEx4NE1jcVZUZjNTREc5RDZiTU5IcG1maVZidk5aMFJwTGhvQ1lL?=
 =?utf-8?B?MnovWmE5d1hWZ3ltdXRIaUZhQjhkYnk5WkpWSy9KWE9NWkVkQlVpdDBadmxS?=
 =?utf-8?B?WSttZWVUTjBDT3d0THpCcmRrczBpVW1JRHNNTFdZZ2g4dFdGQnVHek50TXpa?=
 =?utf-8?B?cXNUSWhQZnZ4THJPMnREUTdybHlNYmdvd2RHUW8zanZHVTl5U1FOZkhrOVZM?=
 =?utf-8?B?Smh6blZpbWd5SG0wVGszMzltYnhvSnp2RVZrbmhjdGR2YUpQdVpGSHBHOWRE?=
 =?utf-8?B?NlhDY3MrR2R3NHVJMEw5ZTJ0QVJDS3RkSy9BNjh1aXhyaFZSUTEwb0NBQU1j?=
 =?utf-8?B?YnJlVE15ejhtb3dLQVN0WU1raEZmWGdySUl3c1RXWGJVd3Y1VWVlSXR4Vzhm?=
 =?utf-8?B?Z1g5WnRRY3BtOTBKUzdXQ0V6VHBTdEYrMGc4bXdDUzZEdC84U29CK2tuV3pp?=
 =?utf-8?B?RndjaXpyaUMyN2NzdlJCRGMvcEhwS0pid3VUTTNzQWZZcU44eVl4QU5nc2xW?=
 =?utf-8?B?cWxiZENqUlowdVB6L2ZwT01hMUcvZ1VKSFhSeXA1cC9Yc3FBOXJKam80VHhX?=
 =?utf-8?B?bFJXVGladGl4Q0dEZjJUQlFkc1djK3Y2TXgrdTcyUVpobmNMbG1CdVFaNXFn?=
 =?utf-8?B?ZDMzdnU5Nk52R2ZXdUxMbHpLaTI2Umd3bWN3cW1NU0JSUWRtYzh4RGFaNTR5?=
 =?utf-8?B?d0JHdCtLZThXSUJiZmVNNVhjN2FQeHdXdnROdXZFTG9yTElxU1VzOXhjY3Rh?=
 =?utf-8?B?b05SWWJDT0p6WEJya2p5eEtZeVNZY0hCWTlKcVJXNmtSM2dHenpjaXQvbGZE?=
 =?utf-8?B?R0wyT0doS09YV3I4NzhnelBsdEs2bmpCT0JCdXFVRWpRRlEvaVppNkk4b2I0?=
 =?utf-8?B?RTE0UkJaVGY5NVpNL1RTdmM0U2QrMnRkeGpQQzh0alMzQmRhUUNaSmFKQnZQ?=
 =?utf-8?B?ckliZnZVa1FkT3hSbHY5bnJnZjQ1M0o3WDdYWk13WkN4OHFVYUplb2xZOXZw?=
 =?utf-8?Q?Er/7pmRPf4QFRuvOEAFTCys44Layyqa55DD0FE/RNOIX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376689b5-89e9-4679-db49-08de00fbbde3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:03:55.6789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjVl2+JFa/LuDKMWK1FEq4rPYgbRtNzXB4AGeCWbszPR2pdlT97359Vus2Tt9nXvQNu+FI9P/vdZrHMA46uZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241

Augment the register macro with two new bounded setter and getter
methods, and showcase how they can be used in the driver.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs      | 14 +++++++++-----
 drivers/gpu/nova-core/regs/macros.rs | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 37e6298195e49a9a29e81226abe16cd410c9adbc..2ce2635c86d8cad6e61862d4bd1976d642090c5b 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -6,6 +6,7 @@
 use hal::FalconHal;
 use kernel::device;
 use kernel::dma::DmaAddress;
+use kernel::num::BoundedInt;
 use kernel::prelude::*;
 use kernel::sync::aref::ARef;
 use kernel::time::Delta;
@@ -488,24 +489,27 @@ fn dma_wr<F: FalconFirmware<Target = E>>(
         // Set up the base source DMA address.
 
         regs::NV_PFALCON_FALCON_DMATRFBASE::default()
-            .set_base((dma_start >> 8) as u32)
+            .set_base_bounded(BoundedInt::new((dma_start >> 8) as u32))
             .write(bar, &E::ID);
         regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
-            .set_base((dma_start >> 40) as u16)
+            .set_base_bounded(BoundedInt::try_from((dma_start >> 40) as u32)?)
             .write(bar, &E::ID);
 
+        let r = regs::NV_PFALCON_FALCON_DMATRFBASE::read(bar, &E::ID).base_bounded();
+        pr_info!("BASE: {:x}\n", r);
+
         let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::default()
             .set_size(DmaTrfCmdSize::Size256B)
             .set_imem(target_mem == FalconMem::Imem)
-            .set_sec(if sec { 1 } else { 0 });
+            .set_sec_bounded(BoundedInt::new(if sec { 1 } else { 0 }));
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
             regs::NV_PFALCON_FALCON_DMATRFMOFFS::default()
-                .set_offs(load_offsets.dst_start + pos)
+                .set_offs_bounded(BoundedInt::try_from(load_offsets.dst_start + pos)?)
                 .write(bar, &E::ID);
             regs::NV_PFALCON_FALCON_DMATRFFBOFFS::default()
-                .set_offs(src_start + pos)
+                .set_offs_bounded(BoundedInt::new(src_start + pos))
                 .write(bar, &E::ID);
             cmd.write(bar, &E::ID);
 
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index 754c14ee7f401688da51e138db71ccaa58445aa6..03a1830f492fdc1747767ed768ce2239e9ce41ec 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -565,6 +565,40 @@ pub(crate) fn [<set_ $field>](mut self, value: $to_type) -> Self {
             self
         }
         );
+
+        ::kernel::macros::paste!(
+        pub(crate) fn [<$field _bounded>](self) ->
+            ::kernel::num::BoundedInt<u32, { $hi + 1 - $lo }> {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+            // Ensure the returned type has the same width as the field.
+            ::kernel::static_assert!(
+                MASK >> SHIFT == ::kernel::num::BoundedInt::<u32, { $hi + 1 - $lo }>::MASK
+            );
+
+            let field = ((self.0 & MASK) >> SHIFT);
+
+            ::kernel::num::BoundedInt::<u32, { $hi + 1 - $lo }>::new(field)
+        }
+
+        pub(crate) fn [<set_ $field _bounded>](
+            mut self,
+            value: ::kernel::num::BoundedInt<u32, { $hi + 1 - $lo }>
+        ) -> Self {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+            // Ensure the returned type has the same width as the field.
+            ::kernel::static_assert!(
+                MASK >> SHIFT == ::kernel::num::BoundedInt::<u32, { $hi + 1 - $lo }>::MASK
+            );
+
+            let value = (value.get() << SHIFT) & MASK;
+            self.0 = (self.0 & !MASK) | value;
+
+            self
+        }
+        );
+
     };
 
     // Generates the `Debug` implementation for `$name`.

-- 
2.51.0


