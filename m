Return-Path: <linux-kernel+bounces-880276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829CAC254AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59308188F126
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02E23D7F8;
	Fri, 31 Oct 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZsSj2xfZ"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DD22A4E5;
	Fri, 31 Oct 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918024; cv=fail; b=chiX5xP+hkYR9dFZBTuzJLKlDK4tGRI0NRCR9Kn3a6/Cq8jmT48Z81AbXum5ocaxzWqjfo/DCF7VjvVgge3G8NSkBUsQQB5d81jTRdX2IXOAw7mD0vSW18QfO0oAhwv2XV97cAwzI7BURmYm+BL4ufj2RroVJqdaSU7JhFg1c5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918024; c=relaxed/simple;
	bh=gj2y4AdcIvOe4Qy9sKKvr28bUsvM/lsLPgg5j4WTsQU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YDcakFAygpk1uNaL0rdaCnTgiT8VJwde9FgtGPhmoFDR5+lmREikRAH+PIHzCfnxADQ4uctnlp1xvuFM9VuisqwJQljaAGEFxDiwWzsch94n23WZyN3bVqVa2YgUc8SfMcVFwOC6eVoupHggxCX0rjWLY33eur/3M/1s3sMyWoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZsSj2xfZ; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoHSBEBlHFfpbp4Uk/kCavLbVn/VEafgxCOmC1cuRCFD0S87fOTPxp9h2m3svwq1tB/CMQv/FlEyAHtIoJWIhhWjNfV/7YK/7Tj0aszogAPa7OJCZ/a6mh4XMy5jp8nsTidV2IhzkKmU9+AT/n7oGYo4GRPeBOQNlIPIxOncctuQWC0S+e0oETPNpddkCdn1OTh7LB8L9xCPaTi1i9o5d3bFWsdQRxR6rqjhPsWt3hHWgoz7l1ap8kgTslVFFhVi60bCAB9++Z/pjaF2Uu7lwHgiUzivj1rEw793Ngq1dtTtrm+9SHfaYEPqqreI/sSJYyoKhfMoUzu1nDjWVoAc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcEIy8GK95nks7lv6EqLFx13YTW8r6iD00Jay5XJvtg=;
 b=Jl2BhKrIwWkUHdli8XOHpnjTDNrqlq63t+8e80L548x+bVYVcoOjfMPloxN83RdVyVUmtHHB5s7wkCZbFX37si89nW4cGrjVaIA4LoIBEf7ihWWF3TBfVBtbpFadXjQ/d62EgTCZA6hL8+bmwl+mqzrROe9mLKZSBl9pJqrQOkIyiCuIYHGHxWepTIfh24z4dnx7QBMLZa1HakyiC+IqYqp11HfmZetL1mAwF6otDEhNwvcWWC44vrfUM+tECgicqeWLe25xY5Vc3CC0hUQX3ESqj+eOiaqxxTztB087Pm6BasvILfNQ6dSGKf6rdzGALrWSrtUc2Ym3JItfAuEbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcEIy8GK95nks7lv6EqLFx13YTW8r6iD00Jay5XJvtg=;
 b=ZsSj2xfZpVoxKPZrUGgljwlz6EBaU1PYk5tOAuIu+EkNNmX23Qq5DASqv1zvoUSv6SGPSab3+61SBhd0fbJjlADslu0VDWNy8BzhRK4nRnQjLh+zoq++jw06K3w6m528kAPZTrjQ1gZUhwdraZc/0kLpHqEMaoGiOZhuM0zj8bYbJzTuh/M2Grv6isGkFFV5vFGVtICzpIvroP0YhxPh+fy2JNA6fzywDneqFrGMnc3nHv+lz4HYhkSxyEirP/BzDrw/uS8pm8TG1RsF1rfUx5sjWx3NhmXxR6pD56r3+rzHNeqK418iLu9R8qECR4ZOa4vwNRgxgtEbv2qgjWVPYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 13:40:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 13:40:13 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 31 Oct 2025 22:39:58 +0900
Subject: [PATCH FOR REFERENCE 2/2] gpu: nova-core: use BitInt for bitfields
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-bounded_ints-v1-2-e2dbcd8fda71@nvidia.com>
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
In-Reply-To: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 546b8c4c-0f50-4575-ed66-08de188304af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDlidVpaUDJrbEpsQ1MzNGU5T0JYc215aEFWazhHTlltRDdSeUxmS05PMWp0?=
 =?utf-8?B?OGtScGpUSW80Q3BDV2dYY1BQR3NHbU1iMGprV0xRN1hUa2dYOEZLNlFRTGVX?=
 =?utf-8?B?Q0NXSmh2d2gxam1xeHd2RGV5WUlFV09XZDV4YVBNN0ZBN29IQmQ1MndLMlQ5?=
 =?utf-8?B?bFVQcXp4ZDM0T2tHUWw4Y241bGx4Vm5YK2V6NE5vZ1Y4aW8zcGg1cjRxRlNY?=
 =?utf-8?B?b1kzV1VaUEpXWW1qcnl1VEtQOU03b0VYczJZSjU4OG12UXc1WFZjNkF0eTdT?=
 =?utf-8?B?YjVuNkwvQk1hZEFadUg1SkNoc0toU3JWRFBGMDVrTWgvVzVva2FBcmI0Ynlh?=
 =?utf-8?B?eEdXOHBWMFFiS3YzeG9SRnJNa00zaENuenNjWHZKdkc5dEhuTFRCcStSOGhR?=
 =?utf-8?B?NHU2OWdtdFcxTkhVZ1p2MUd6ejdSTUZCS0wyR0lXUnZLMzhNdzRSeXRFemE3?=
 =?utf-8?B?eGI1VVA2cldXZXpjVXdsNHpCTGxwK0lFYmc3b2o4QkNRRjBQU0F1azVsTEJs?=
 =?utf-8?B?VFAvR0w4MDRldW00YWJhK0YwU0F0T1g2YzJTd1NkdGlJOVNZQXZvcXJoc0Np?=
 =?utf-8?B?ZzIrdk1qYUJMRmI2VXdVSkdtNXhSTWdGTGVlVDlSRGlEU2FQM1pZeGdEVnhl?=
 =?utf-8?B?NHZ3akVEZEs0QW9IWWpXZXNXbGxIQmpjWjMybnhIZVFqZnd2a2ROMVpNejk4?=
 =?utf-8?B?NVJRY01ZRDZHTHZkckpPQXhEeUlPSUlscmRPSlZCaDkxYXBYaTNmb2dKbDJC?=
 =?utf-8?B?OWhzaTdyZVZrak4xYmVJam52Qk1ab2NqSEJjbnBrdlM5QmNreVE2L3BHbFZT?=
 =?utf-8?B?cXhEai9TVlJ5Yk5YQzhQOXJLQkZhNCs1NHFBbVp4UUMzbzNTWWUyeGE5Nmw1?=
 =?utf-8?B?bm5RT2E2Wi9VUiszcE4rdFc2eGYrSDhHc3VqbUVSWncreFQwTmFSN1RFeWpl?=
 =?utf-8?B?MVViYWVOSnQ3cGJUYlpPdnUwRGpjd2pZUzZNVWdEZEtzb1NreGtmMXlSb3ZI?=
 =?utf-8?B?L1Q0N1QxQ0RQekIzNjNSam52Wi9VOUE1Um81RDUzWEFhMnZNU3YyZThNSkdq?=
 =?utf-8?B?NHM5RDU4SXI3Kzd5aytsQUR5a0RXeU1OYWNRT1NYbmlsMFE4eDJVaHdHb0la?=
 =?utf-8?B?d21uNER0MitvKzBCd29qY25sNSs3RFd2S0RUVzB5a1RLSTNKK1ltUFh1RjhK?=
 =?utf-8?B?K0pLTnpzemRIYjgrMTBWK0pyVEdyU3NHNW1TTXhwNFppTkorbHI0UzVkK3VV?=
 =?utf-8?B?UUxSVFk0LzA3N1RzNThIODlSODAzbkhURXJOOEhtZXBvd1ptSWdMd3Qxa3hK?=
 =?utf-8?B?WGVXZUVlQzFHUTB3MXJhUUpUWEY2Vmc5THFyR0dLTnZ1Sk80S1d6WGcrRWI2?=
 =?utf-8?B?UlFaalJuVnFsREh0a1c3Q1ZSNTE5cTNDMWluckNhN3NjN25mZC9hNFJzQWNk?=
 =?utf-8?B?c21GR3B2Y3dLS0ZyMGs0RTdqS3hRazJwOSsxcllLakJyYmtQS0hlZzd0N1ZN?=
 =?utf-8?B?cVZDYmM1ajRJNFVvRy9kVkl3R3ZRblRqRWNTU241WnhIdEpIN3RidlE2K0tI?=
 =?utf-8?B?NmloV21TMXhnMDNJRHVaNHg0ejd0K09CNmxxdHZ5STNjMDRYUnJSaUkyNktK?=
 =?utf-8?B?a3NtWHhtYk1kVWF4K0lKbnhPZi9lczRxVGJZSmFPQnZKTjl0ODB3RWRYQWZx?=
 =?utf-8?B?TVp2b04xV0hLbElwRG1UL2YybysxSVAxMmtNQTVDTnhnejV0OTlncXVOS3Vz?=
 =?utf-8?B?ZUo5WmhEV0k4aWdORjFhY2NWTDlXdTIvQkdIZ091Z3pOTCs4Skt2YmMySTNq?=
 =?utf-8?B?S1hYRFhIeUM4cEkwbUh2RlVycFRVUWdzMmh2b01ydXdpY2JWNXBTcDRmMHNG?=
 =?utf-8?B?SmVJU1k4STlyV0hCQ0F5RDRrOFJvMHhKTUYwZ2ZGYy9XQTBsOWIzOHJXOHlH?=
 =?utf-8?B?ZjR6dTJOWjRYY0tTd1paTVpKalVLcmdjMFJnUUVrZDQ1ZDVKRW1Ma09WbGdz?=
 =?utf-8?B?U2VZL3gya2dYTmRiS3g4SXVtTzFrYlR5SklGa3BLTmhjbXRDcjJkSGZMUk5D?=
 =?utf-8?Q?AF6S2l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzlScmY0bDBSa3lWOEZIbzY4K3d0NzlMQ0lCNDFJaXNLSm9QQjNiZzJPNmhi?=
 =?utf-8?B?ZXRJTk54SUZuV2pLdS9yQi9qSGpvTi9JeDZFZDRHWDMxUkxZVTNDcWVvbFhF?=
 =?utf-8?B?bjk3SFVPRnQ2WWdNZFlmd2gyZGE3aDB4K3ByWmNPd0VzQWxBbzVXdko3Q0Qx?=
 =?utf-8?B?QSt5SGhMN1htTG1SZWxtRzlxUll0bVZibHFvTDVYQzdEaTdYcm4xN1FpdzFM?=
 =?utf-8?B?WTVEdk9LclNNakhxQ3N3eUE4UnljdnNvTW5lZUZ3WStmVjRxdGxCUk1Bd0VU?=
 =?utf-8?B?dG0vWkxvU090bzV4aCtub1VnanRheS8rNHFhUjlMRGc4azlzZjNMUFRZNkUz?=
 =?utf-8?B?RENvUHdOcW9xTUtnYm1sOWtEUTg4K012Q2Fjdmo3V1p4R1NJQkNUcjhxS1VU?=
 =?utf-8?B?M0pvc1p0eHNxRXhiUTUvM0F5N1p6RVo5U0JMd0lyUkJkV0FocFN3RmxBcmll?=
 =?utf-8?B?VllXTGhrZlFWZTk1Mk9YREc4bFpjM1E4S0IzT28vbGV4L1NoeVlqbk5HcTVG?=
 =?utf-8?B?RU51c2VvYkxQZ3NWSUtVbE5RQ2t2S3pObnh1b2tnSXFWTW5xbFlkZlJ4TG1V?=
 =?utf-8?B?UEZndDYyVDg0T0MwS3NHTnhySm1PM3ZJMWVFM1gzTDVGckNXRno2RFFZZGND?=
 =?utf-8?B?eVVBSktWM29JUEkyeGhDNmF0Rk0xdGNnb3J3QTVPTkJzbTRMTXNoZm1hcGp4?=
 =?utf-8?B?WHZOVkgrYk9UeWRMRzAxVUd4Y0lnR3VrWnp2Ykx5Ulp2L29ILzFYaHFPRXVp?=
 =?utf-8?B?Q2ZoY1NmZ0FVZ1JENSs5WS81NmpPQXVCSHEwNEhlU2NXUmNoZ0JyZ1J6Vmc3?=
 =?utf-8?B?bzlORmhzSDRqNGhsa1FXMS9udUVxYjJyQ2lOMUFVQ2RzRnhDcWl3TGVpTDVk?=
 =?utf-8?B?anFrNDhGM2VHeHBVcXAyUVp0OSs4NFhtbThjL1VQTHpzVnlkVzZ1YXQ4L3R5?=
 =?utf-8?B?NDQxOURsQzV4K3dUZWMrRkRaVmRqSzhONDdlSWI2b1ZmSmtMd2d3b0hJMm9V?=
 =?utf-8?B?MTNVdmJ0NTFFay9HNEJxRmdlQU5tSm9XeEdaNlFydlBvMDh6Q28zL3dkQVlE?=
 =?utf-8?B?Y29ZR1RPQmNQN3ZjSUtIMW5JWlNrekpNcjY1NWx6cDdqNWJoY04zd01iWWFK?=
 =?utf-8?B?ZnBMd0FHeUU1azQrWHVDaVp1ZmRNc3A4NDhOUE9nZDlLcWdkVW1BMDZXYnV0?=
 =?utf-8?B?UEtGU1hQV3A1Uk95Uno4aTJpRVg5Qy9Ba0RybS94bnh4YVJMMTVvZU9HN0p1?=
 =?utf-8?B?Q2RoaHIvT1pVdzNRRTcrb1hKT2FhckdPbHdqME5XOG4rWCt6ZWl0MWsvNkEy?=
 =?utf-8?B?em9Ub2NBdUxGaXRDNFlkb1hLVnBpd3RKUkRlOTEvRTdtK3Y0N2hjT3d3QTRM?=
 =?utf-8?B?K2VMTERnZjBCL0xzbU5ENnh0bjNzWkptZXBkZ1RSMHdGb1o5ckhubjgzMXlL?=
 =?utf-8?B?Y2lBVWpKZXcwNzJJc29KSEtlZjNUc3lqdzNCbk8rdnkxeWdOTk5HZG9vRmxZ?=
 =?utf-8?B?enBzM0FTTDJQVyt6THhLUlhoOUFzWUpTbjdLV2NJV0NSNEVMOU0vcUlFZFJu?=
 =?utf-8?B?b3pCaXIwcEVzWDU5T01pY1NDOHl6eDdTWTYzQXZtL2s4QThHNHgvSCtrenhl?=
 =?utf-8?B?L1RCd2N6ZTBvL1ZaaW9JSEN4ZW1acUt5MFNiSXVPZVk0d2tuRlpHY3JyRW44?=
 =?utf-8?B?aUY5cFA0K1NuUnpycC9tRjZIMEJtK3N0dWtDVzB6WTAwU1BDV0U0bjdkaUU2?=
 =?utf-8?B?YmJxRlcydjVVamdOMmFueUFxMmZxa0prem14aVJyb0lHTVI3QXJoazNXMjBO?=
 =?utf-8?B?Q3dEVlRYQUxrYnpOTWVsWlVTSEFuakdtQTB0QU9jRFBlOVNwSG9NQWU5WEJp?=
 =?utf-8?B?Z1JJVFIyaVFZdU9GZEJ1SUllMGVuMEFRZ1F4WjBJcjNHWHdTa1ZkekgxWXRx?=
 =?utf-8?B?NzVjeUkxS3UvZGQrc2RWaFdhUVI0VDhSK0IvZDhlNkh4ZG0ydHJPMmFhZVY5?=
 =?utf-8?B?QXpHcHRqenkvSmdER2d0UWRYZTZOaTZwa3pMd3NnVnA5Q2kvTVRmdVVHYnM1?=
 =?utf-8?B?MVEvTUpWbjFZZlFrK1ovMXNlR1kzOWVleUlXbDVXMms0dXB3QzhQNmw3WG5Y?=
 =?utf-8?B?ZTRlZTlsc2hieER5T0pKS1NkSHRZUFhUUXhzKzlzZzZ6U3V2Ykd2SDV5SjhJ?=
 =?utf-8?Q?My5o+YZnk9XQy9v8XOWHY6n/73fQ1ydkJWEiSnby30mx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546b8c4c-0f50-4575-ed66-08de188304af
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:40:13.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO7HZvBiZswOXw4UUEkVxGDxhUpnNvD/iyJ5w+sRIXNi6UHXqsXJ2NC768gtu4LS/GhfIkXBBYZ5HNujnt32jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211

Use BitInt with the bitfield!() and register!() macros and adapt the
nova-core code accordingly.

This makes it impossible to trim values when setting a register field,
because either the value of the field has been inferred at compile-time
to fit within the bounds of the field, or the user has been forced to
check at runtime that it does indeed fit.

The use of BitInt actually simplifies register fields definitions,
as they don't need an intermediate storage type (the "as ..." part of
fields definitions). Instead, the internal storage type for each field
is now the bounded integer of its width in bits, which can optionally be
converted to another type that implements `From`` or `TryFrom`` for that
bounded integer type.

This means that something like

  register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
      3:3     status_valid as bool,
      31:8    addr as u32,
  });

Now becomes

  register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
      3:3     status_valid => bool,
      31:8    addr,
  });

(here `status_valid` is infallibly converted to a bool for convenience
and to remain compatible with the previous semantics)

The field setter/getters are also simplified. If a field has no target
type, then its setter expects any type that implements `Into` to the
field's bounded integer type. Due to the many `From` implementations for
primitive types, this means that most calls can be left unchanged. If
the caller passes a value that is potentially larger than the field's
capacity, it must use the `try_` variant of the setter, which returns an
error if the value cannot be converted at runtime.

For fields that use `=>` to convert to another type, both setter and
getter are always infallible.

For fields that use `?=>` to fallibly convert to another type, only the
getter needs to be fallible as the setter always provide valid values by
design.

Outside of the register macro, the biggest changes occur in `falcon.rs`,
which defines many enums for fields - their conversion implementations
need to be changed from the original primitive type of the field to the
new corresponding bounded int type. Hopefully the TryFrom/Into derive
macros [1] can take care of implementing these, but it will need to be
adapted to support bounded integers... :/

But overall, I am rather happy at how simple it was to convert the whole
of nova-core to this.

Note: This RFC uses nova-core's register!() macro for practical
purposes, but the hope is to move this patch on top of the bitfield
macro after it is split out [2].

[1]
https://lore.kernel.org/rust-for-linux/cover.1755235180.git.y.j3ms.n@gmail.com/
[2]
https://lore.kernel.org/rust-for-linux/20251003154748.1687160-1-joelagnelf@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/bitfield.rs         | 366 ++++++++++++++++--------------
 drivers/gpu/nova-core/falcon.rs           | 134 ++++++-----
 drivers/gpu/nova-core/falcon/hal/ga102.rs |   5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs     |   3 +-
 drivers/gpu/nova-core/gpu.rs              |   9 +-
 drivers/gpu/nova-core/regs.rs             | 139 ++++++------
 6 files changed, 353 insertions(+), 303 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 16e143658c51..c75d95ef1ae9 100644
--- a/drivers/gpu/nova-core/bitfield.rs
+++ b/drivers/gpu/nova-core/bitfield.rs
@@ -19,21 +19,21 @@
 ///     Auto = 2,
 /// }
 ///
-/// impl TryFrom<u8> for Mode {
-///     type Error = u8;
-///     fn try_from(value: u8) -> Result<Self, Self::Error> {
-///         match value {
+/// impl TryFrom<BitInt<u32, 4>> for Mode {
+///     type Error = u32;
+///     fn try_from(value: BitInt<u32, 4>) -> Result<Self, Self::Error> {
+///         match *value {
 ///             0 => Ok(Mode::Low),
 ///             1 => Ok(Mode::High),
 ///             2 => Ok(Mode::Auto),
-///             _ => Err(value),
+///             value => Err(value),
 ///         }
 ///     }
 /// }
 ///
-/// impl From<Mode> for u8 {
-///     fn from(mode: Mode) -> u8 {
-///         mode as u8
+/// impl From<Mode> for BitInt<u32, 4> {
+///     fn from(mode: Mode) -> BitInt<u32, 4> {
+///         BitInt::from_expr(mode as u32)
 ///     }
 /// }
 ///
@@ -44,25 +44,29 @@
 ///     Active = 1,
 /// }
 ///
-/// impl From<bool> for State {
-///     fn from(value: bool) -> Self {
-///         if value { State::Active } else { State::Inactive }
+/// impl From<BitInt<u32, 1>> for State {
+///     fn from(value: BitInt<u32, 1>) -> Self {
+///         if bool::from(value) {
+///             State::Active
+///         } else {
+///             State::Inactive
+///         }
 ///     }
 /// }
 ///
-/// impl From<State> for bool {
-///     fn from(state: State) -> bool {
+/// impl From<State> for BitInt<u32, 1> {
+///     fn from(state: State) -> BitInt<u32, 1> {
 ///         match state {
-///             State::Inactive => false,
-///             State::Active => true,
+///             State::Inactive => false.into(),
+///             State::Active => true.into(),
 ///         }
 ///     }
 /// }
 ///
 /// bitfield! {
 ///     pub struct ControlReg(u32) {
-///         7:7 state as bool => State;
-///         3:0 mode as u8 ?=> Mode;
+///         7:7 state => State;
+///         3:0 mode ?=> Mode;
 ///     }
 /// }
 /// ```
@@ -112,12 +116,9 @@ fn from(val: $name) -> $storage {
         bitfield!(@fields_dispatcher $vis $name $storage { $($fields)* });
     };
 
-    // Captures the fields and passes them to all the implementers that require field information.
-    //
-    // Used to simplify the matching rules for implementers, so they don't need to match the entire
-    // complex fields rule even though they only make use of part of it.
+    // Dispatch fields depending on the syntax used.
     (@fields_dispatcher $vis:vis $name:ident $storage:ty {
-        $($hi:tt:$lo:tt $field:ident as $type:tt
+        $($hi:tt:$lo:tt $field:ident
             $(?=> $try_into_type:ty)?
             $(=> $into_type:ty)?
             $(, $comment:literal)?
@@ -125,173 +126,208 @@ fn from(val: $name) -> $storage {
         )*
     }
     ) => {
-        bitfield!(@field_accessors $vis $name $storage {
-            $(
-                $hi:$lo $field as $type
-                $(?=> $try_into_type)?
-                $(=> $into_type)?
-                $(, $comment)?
-            ;
-            )*
-        });
-        bitfield!(@debug $name { $($field;)* });
-        bitfield!(@default $name { $($field;)* });
-    };
-
-    // Defines all the field getter/setter methods for `$name`.
-    (
-        @field_accessors $vis:vis $name:ident $storage:ty {
-        $($hi:tt:$lo:tt $field:ident as $type:tt
-            $(?=> $try_into_type:ty)?
-            $(=> $into_type:ty)?
-            $(, $comment:literal)?
-        ;
-        )*
-        }
-    ) => {
-        $(
-            bitfield!(@check_field_bounds $hi:$lo $field as $type);
-        )*
-
         #[allow(dead_code)]
         impl $name {
-            $(
-            bitfield!(@field_accessor $vis $name $storage, $hi:$lo $field as $type
-                $(?=> $try_into_type)?
-                $(=> $into_type)?
-                $(, $comment)?
-                ;
-            );
-            )*
+        $(
+        bitfield!(@private_field_accessors $name $storage : $hi:$lo $field);
+        bitfield!(@public_field_accessors $vis $name $storage : $hi:$lo $field
+            $(?=> $try_into_type)?
+            $(=> $into_type)?
+            $(, $comment)?
+        );
+        )*
         }
+
+        bitfield!(@debug $name { $($field;)* });
+        bitfield!(@default $name { $($field;)* });
+
     };
 
-    // Boolean fields must have `$hi == $lo`.
-    (@check_field_bounds $hi:tt:$lo:tt $field:ident as bool) => {
-        #[allow(clippy::eq_op)]
-        const _: () = {
-            ::kernel::build_assert!(
-                $hi == $lo,
-                concat!("boolean field `", stringify!($field), "` covers more than one bit")
-            );
-        };
-    };
-
-    // Non-boolean fields must have `$hi >= $lo`.
-    (@check_field_bounds $hi:tt:$lo:tt $field:ident as $type:tt) => {
-        #[allow(clippy::eq_op)]
-        const _: () = {
-            ::kernel::build_assert!(
-                $hi >= $lo,
-                concat!("field `", stringify!($field), "`'s MSB is smaller than its LSB")
-            );
-        };
-    };
-
-    // Catches fields defined as `bool` and convert them into a boolean value.
     (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as bool
-            => $into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(f != 0) }
-            bool $into_type => $into_type $(, $comment)?;
-        );
-    };
-
-    // Shortcut for fields defined as `bool` without the `=>` syntax.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as bool
-            $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @field_accessor $vis $name $storage, $hi:$lo $field as bool => bool $(, $comment)?;
-        );
-    };
-
-    // Catches the `?=>` syntax for non-boolean fields.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            ?=> $try_into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(@leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$try_into_type>::try_from(f as $type) } $type $try_into_type =>
-            ::core::result::Result<
-                $try_into_type,
-                <$try_into_type as ::core::convert::TryFrom<$type>>::Error
-            >
-            $(, $comment)?;);
-    };
-
-    // Catches the `=>` syntax for non-boolean fields.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            => $into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(@leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(f as $type) } $type $into_type => $into_type $(, $comment)?;);
-    };
-
-    // Shortcut for non-boolean fields defined without the `=>` or `?=>` syntax.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @field_accessor $vis $name $storage, $hi:$lo $field as $type => $type $(, $comment)?;
-        );
-    };
-
-    // Generates the accessor methods for a single field.
-    (
-        @leaf_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident
-            { $process:expr } $prim_type:tt $to_type:ty => $res_type:ty $(, $comment:literal)?;
+        @private_field_accessors $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
     ) => {
         ::kernel::macros::paste!(
         const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
-        const [<$field:upper _MASK>]: $storage = {
-            // Generate mask for shifting
-            match ::core::mem::size_of::<$storage>() {
-                1 => ::kernel::bits::genmask_u8($lo..=$hi) as $storage,
-                2 => ::kernel::bits::genmask_u16($lo..=$hi) as $storage,
-                4 => ::kernel::bits::genmask_u32($lo..=$hi) as $storage,
-                8 => ::kernel::bits::genmask_u64($lo..=$hi) as $storage,
-                _ => ::kernel::build_error!("Unsupported storage type size")
-            }
-        };
+        const [<$field:upper _MASK>]: u32 = ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
         const [<$field:upper _SHIFT>]: u32 = $lo;
         );
 
+        ::kernel::macros::paste!(
+        fn [<$field _internal>](self) ->
+            ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }> {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let field = ((self.0 & MASK) >> SHIFT);
+
+            ::kernel::num::BitInt::<$storage, { $hi + 1 - $lo }>::from_expr(field)
+        }
+
+        fn [<set_ $field _internal>](
+            mut self,
+            value: ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }>,
+        ) -> Self
+        {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let value = (value.get() << SHIFT) & MASK;
+            self.0 = (self.0 & !MASK) | value;
+
+            self
+        }
+
+        fn [<try_set_ $field _internal>]<T>(
+            mut self,
+            value: T,
+        ) -> ::kernel::error::Result<Self>
+            where T: ::kernel::num::TryIntoBitInt<$storage, { $hi + 1 - $lo }>,
+        {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let value = (
+                value.try_into_bitint().ok_or(::kernel::error::code::EOVERFLOW)?.get() << SHIFT
+            ) & MASK;
+
+            self.0 = (self.0 & !MASK) | value;
+
+            Ok(self)
+        }
+        );
+    };
+
+    // Generates the public accessors for fields infallibly (`=>`) converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            => $into_type:ty $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
         $(
         #[doc="Returns the value of this field:"]
         #[doc=$comment]
         )?
         #[inline(always)]
-        $vis fn $field(self) -> $res_type {
-            ::kernel::macros::paste!(
-            const MASK: $storage = $name::[<$field:upper _MASK>];
-            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            );
-            let field = ((self.0 & MASK) >> SHIFT);
-
-            $process(field)
+        $vis fn $field(self) -> $into_type
+        {
+            self.[<$field _internal>]().into()
         }
 
-        ::kernel::macros::paste!(
         $(
         #[doc="Sets the value of this field:"]
         #[doc=$comment]
         )?
         #[inline(always)]
-        $vis fn [<set_ $field>](mut self, value: $to_type) -> Self {
-            const MASK: $storage = $name::[<$field:upper _MASK>];
-            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            let value = ($storage::from($prim_type::from(value)) << SHIFT) & MASK;
-            self.0 = (self.0 & !MASK) | value;
-
-            self
+        $vis fn [<set_ $field>](self, value: $into_type) -> Self
+        {
+            self.[<set_ $field _internal>](value.into())
         }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> $into_type {
+            Default::default()
+        }
+
+        );
+    };
+
+    // Generates the public accessors for fields fallibly (`?=>`) converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            ?=> $try_into_type:ty $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(
+        #[doc="Returns the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn $field(self) ->
+            Result<
+                $try_into_type,
+                <$try_into_type as ::core::convert::TryFrom<
+                    ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }>
+                >>::Error
+            >
+        {
+            self.[<$field _internal>]().try_into()
+        }
+
+        $(
+        #[doc="Sets the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<set_ $field>](self, value: $try_into_type) -> Self
+        {
+            self.[<set_ $field _internal>](value.into())
+        }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> $try_into_type {
+            Default::default()
+        }
+
+        );
+    };
+
+    // Generates the public accessors for fields not converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(
+        #[doc="Returns the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn $field(self) ->
+            ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }>
+        {
+            self.[<$field _internal>]()
+        }
+
+        $(
+        #[doc="Sets the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<set_ $field>]<T>(
+            self,
+            value: T,
+        ) -> Self
+            where T: Into<::kernel::num::BitInt<$storage, { $hi + 1 - $lo }>>,
+        {
+            self.[<set_ $field _internal>](value.into())
+        }
+
+        $(
+        #[doc="Attempts to set the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<try_set_ $field>]<T>(
+            self,
+            value: T,
+        ) -> ::kernel::error::Result<Self>
+            where T: ::kernel::num::TryIntoBitInt<$storage, { $hi + 1 - $lo }>,
+        {
+            Ok(
+                self.[<set_ $field _internal>](
+                    value.try_into_bitint().ok_or(::kernel::error::code::EOVERFLOW)?
+                )
+            )
+        }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> ::kernel::num::BitInt<$storage, { $hi + 1 - $lo }> {
+            Default::default()
+        }
+
         );
     };
 
@@ -319,7 +355,7 @@ fn default() -> Self {
 
                 ::kernel::macros::paste!(
                 $(
-                value.[<set_ $field>](Default::default());
+                value.[<set_ $field>](Self::[<$field _default>]());
                 )*
                 );
 
diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index fb3561cc9746..7d85a01ea06e 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -7,6 +7,7 @@
 use kernel::device;
 use kernel::dma::DmaAddress;
 use kernel::io::poll::read_poll_timeout;
+use kernel::num::{self, BitInt};
 use kernel::prelude::*;
 use kernel::sync::aref::ARef;
 use kernel::time::delay::fsleep;
@@ -23,11 +24,14 @@
 pub(crate) mod sec2;
 
 // TODO[FPRI]: Replace with `ToPrimitive`.
-macro_rules! impl_from_enum_to_u8 {
-    ($enum_type:ty) => {
-        impl From<$enum_type> for u8 {
+macro_rules! impl_from_enum_to_bounded {
+    ($enum_type:ty, $length:literal) => {
+        impl<T> From<$enum_type> for BitInt<T, $length>
+        where
+            T: From<u8> + num::Boundable,
+        {
             fn from(value: $enum_type) -> Self {
-                value as u8
+                BitInt::from_expr(T::from(value as u8))
             }
         }
     };
@@ -47,16 +51,19 @@ pub(crate) enum FalconCoreRev {
     Rev6 = 6,
     Rev7 = 7,
 }
-impl_from_enum_to_u8!(FalconCoreRev);
+impl_from_enum_to_bounded!(FalconCoreRev, 4);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRev {
+impl<T> TryFrom<BitInt<T, 4>> for FalconCoreRev
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
+    fn try_from(value: BitInt<T, 4>) -> Result<Self> {
         use FalconCoreRev::*;
 
-        let rev = match value {
+        let rev = match u8::from(value) {
             1 => Rev1,
             2 => Rev2,
             3 => Rev3,
@@ -82,24 +89,25 @@ pub(crate) enum FalconCoreRevSubversion {
     Subversion2 = 2,
     Subversion3 = 3,
 }
-impl_from_enum_to_u8!(FalconCoreRevSubversion);
+impl_from_enum_to_bounded!(FalconCoreRevSubversion, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRevSubversion {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
+impl<T> From<BitInt<T, 2>> for FalconCoreRevSubversion
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
+    fn from(value: BitInt<T, 2>) -> Self {
         use FalconCoreRevSubversion::*;
 
-        let sub_version = match value & 0b11 {
+        match u8::from(value) {
             0 => Subversion0,
             1 => Subversion1,
             2 => Subversion2,
             3 => Subversion3,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(sub_version)
+            // TODO: somehow the compiler cannot infer that `value` cannot be > 3. Find a way to
+            // handle this gracefully, or switch back to fallible ops.
+            _ => panic!(),
+        }
     }
 }
 
@@ -126,16 +134,19 @@ pub(crate) enum FalconSecurityModel {
     /// Also known as High-Secure, Privilege Level 3 or PL3.
     Heavy = 3,
 }
-impl_from_enum_to_u8!(FalconSecurityModel);
+impl_from_enum_to_bounded!(FalconSecurityModel, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconSecurityModel {
+impl<T> TryFrom<BitInt<T, 2>> for FalconSecurityModel
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
+    fn try_from(value: BitInt<T, 2>) -> Result<Self> {
         use FalconSecurityModel::*;
 
-        let sec_model = match value {
+        let sec_model = match u8::from(value) {
             0 => None,
             2 => Light,
             3 => Heavy,
@@ -158,14 +169,17 @@ pub(crate) enum FalconModSelAlgo {
     #[default]
     Rsa3k = 1,
 }
-impl_from_enum_to_u8!(FalconModSelAlgo);
+impl_from_enum_to_bounded!(FalconModSelAlgo, 8);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconModSelAlgo {
+impl<T> TryFrom<BitInt<T, 8>> for FalconModSelAlgo
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: BitInt<T, 8>) -> Result<Self> {
+        match u8::from(value) {
             1 => Ok(FalconModSelAlgo::Rsa3k),
             _ => Err(EINVAL),
         }
@@ -180,14 +194,17 @@ pub(crate) enum DmaTrfCmdSize {
     #[default]
     Size256B = 0x6,
 }
-impl_from_enum_to_u8!(DmaTrfCmdSize);
+impl_from_enum_to_bounded!(DmaTrfCmdSize, 3);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for DmaTrfCmdSize {
+impl<T> TryFrom<BitInt<T, 3>> for DmaTrfCmdSize
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: BitInt<T, 3>) -> Result<Self> {
+        match u8::from(value) {
             0x6 => Ok(Self::Size256B),
             _ => Err(EINVAL),
         }
@@ -203,25 +220,20 @@ pub(crate) enum PeregrineCoreSelect {
     /// RISC-V core is active.
     Riscv = 1,
 }
+impl_from_enum_to_bounded!(PeregrineCoreSelect, 1);
 
-impl From<bool> for PeregrineCoreSelect {
-    fn from(value: bool) -> Self {
-        match value {
+impl<T> From<BitInt<T, 1>> for PeregrineCoreSelect
+where
+    T: num::Boundable + Zeroable,
+{
+    fn from(value: BitInt<T, 1>) -> Self {
+        match bool::from(value) {
             false => PeregrineCoreSelect::Falcon,
             true => PeregrineCoreSelect::Riscv,
         }
     }
 }
 
-impl From<PeregrineCoreSelect> for bool {
-    fn from(value: PeregrineCoreSelect) -> Self {
-        match value {
-            PeregrineCoreSelect::Falcon => false,
-            PeregrineCoreSelect::Riscv => true,
-        }
-    }
-}
-
 /// Different types of memory present in a falcon core.
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
 pub(crate) enum FalconMem {
@@ -245,14 +257,17 @@ pub(crate) enum FalconFbifTarget {
     /// Non-coherent system memory (System DRAM).
     NoncoherentSysmem = 2,
 }
-impl_from_enum_to_u8!(FalconFbifTarget);
+impl_from_enum_to_bounded!(FalconFbifTarget, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconFbifTarget {
+impl<T> TryFrom<BitInt<T, 2>> for FalconFbifTarget
+where
+    T: num::Boundable + num::Integer<Signedness = num::Unsigned>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        let res = match value {
+    fn try_from(value: BitInt<T, 2>) -> Result<Self> {
+        let res = match u8::from(value) {
             0 => Self::LocalFb,
             1 => Self::CoherentSysmem,
             2 => Self::NoncoherentSysmem,
@@ -272,26 +287,21 @@ pub(crate) enum FalconFbifMemType {
     /// Physical memory addresses.
     Physical = 1,
 }
+impl_from_enum_to_bounded!(FalconFbifMemType, 1);
 
 /// Conversion from a single-bit register field.
-impl From<bool> for FalconFbifMemType {
-    fn from(value: bool) -> Self {
-        match value {
+impl<T> From<BitInt<T, 1>> for FalconFbifMemType
+where
+    T: num::Boundable + Zeroable,
+{
+    fn from(value: BitInt<T, 1>) -> Self {
+        match bool::from(value) {
             false => Self::Virtual,
             true => Self::Physical,
         }
     }
 }
 
-impl From<FalconFbifMemType> for bool {
-    fn from(value: FalconFbifMemType) -> Self {
-        match value {
-            FalconFbifMemType::Virtual => false,
-            FalconFbifMemType::Physical => true,
-        }
-    }
-}
-
 /// Type used to represent the `PFALCON` registers address base for a given falcon engine.
 pub(crate) struct PFalconBase(());
 
@@ -414,7 +424,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.reset_wait_mem_scrubbing(bar)?;
 
         regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
+            .set_value(u32::from(regs::NV_PMC_BOOT_0::read(bar)))
             .write(bar, &E::ID);
 
         Ok(())
@@ -481,18 +491,18 @@ fn dma_wr<F: FalconFirmware<Target = E>>(
             .set_base((dma_start >> 8) as u32)
             .write(bar, &E::ID);
         regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
-            .set_base((dma_start >> 40) as u16)
+            .try_set_base(dma_start >> 40)?
             .write(bar, &E::ID);
 
         let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::default()
             .set_size(DmaTrfCmdSize::Size256B)
             .set_imem(target_mem == FalconMem::Imem)
-            .set_sec(if sec { 1 } else { 0 });
+            .set_sec(BitInt::from_expr(if sec { 1 } else { 0 }));
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
             regs::NV_PFALCON_FALCON_DMATRFMOFFS::default()
-                .set_offs(load_offsets.dst_start + pos)
+                .try_set_offs(load_offsets.dst_start + pos)?
                 .write(bar, &E::ID);
             regs::NV_PFALCON_FALCON_DMATRFFBOFFS::default()
                 .set_offs(src_start + pos)
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index afed353b24d2..c43e48823eff 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -51,7 +51,7 @@ fn signature_reg_fuse_version_ga102(
 
     // `ucode_idx` is guaranteed to be in the range [0..15], making the `read` calls provable valid
     // at build-time.
-    let reg_fuse_version = if engine_id_mask & 0x0001 != 0 {
+    let reg_fuse_version: u16 = if engine_id_mask & 0x0001 != 0 {
         regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::read(bar, ucode_idx).data()
     } else if engine_id_mask & 0x0004 != 0 {
         regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::read(bar, ucode_idx).data()
@@ -60,7 +60,8 @@ fn signature_reg_fuse_version_ga102(
     } else {
         dev_err!(dev, "unexpected engine_id_mask {:#x}", engine_id_mask);
         return Err(EINVAL);
-    };
+    }
+    .into();
 
     // TODO[NUMM]: replace with `last_set_bit` once it lands.
     Ok(u16::BITS - reg_fuse_version.leading_zeros())
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index 871c42bf033a..5b55ca8aaddb 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -2,6 +2,7 @@
 
 struct Ga100;
 
+use kernel::num::BitInt;
 use kernel::prelude::*;
 
 use crate::driver::Bar0;
@@ -18,7 +19,7 @@ pub(super) fn read_sysmem_flush_page_ga100(bar: &Bar0) -> u64 {
 
 pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
     regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::default()
-        .set_adr_63_40((addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI) as u32)
+        .set_adr_63_40(BitInt::from_expr(addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI).cast())
         .write(bar);
     regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
         .set_adr_39_08((addr >> FLUSH_SYSMEM_ADDR_SHIFT) as u32)
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 9d182bffe8b4..2db3e48ea59f 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use kernel::num::BitInt;
 use kernel::{device, devres::Devres, error::code::*, fmt, pci, prelude::*, sync::Arc};
 
 use crate::driver::Bar0;
@@ -130,15 +131,15 @@ fn try_from(value: u8) -> Result<Self> {
 }
 
 pub(crate) struct Revision {
-    major: u8,
-    minor: u8,
+    major: BitInt<u8, 4>,
+    minor: BitInt<u8, 4>,
 }
 
 impl Revision {
     fn from_boot0(boot0: regs::NV_PMC_BOOT_0) -> Self {
         Self {
-            major: boot0.major_revision(),
-            minor: boot0.minor_revision(),
+            major: boot0.major_revision().cast(),
+            minor: boot0.minor_revision().cast(),
         }
     }
 }
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 206dab2e1335..1542d72e4a65 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -17,18 +17,19 @@
 // PMC
 
 register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
-    3:0     minor_revision as u8, "Minor revision of the chip";
-    7:4     major_revision as u8, "Major revision of the chip";
-    8:8     architecture_1 as u8, "MSB of the architecture";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    28:24   architecture_0 as u8, "Lower bits of the architecture";
+    3:0     minor_revision, "Minor revision of the chip";
+    7:4     major_revision, "Major revision of the chip";
+    8:8     architecture_1, "MSB of the architecture";
+    23:20   implementation, "Implementation version of the architecture";
+    28:24   architecture_0, "Lower bits of the architecture";
 });
 
 impl NV_PMC_BOOT_0 {
     /// Combines `architecture_0` and `architecture_1` to obtain the architecture of the chip.
     pub(crate) fn architecture(self) -> Result<Architecture> {
         Architecture::try_from(
-            self.architecture_0() | (self.architecture_1() << Self::ARCHITECTURE_0_RANGE.len()),
+            u8::from(self.architecture_0())
+                | (u8::from(self.architecture_1()) << Self::ARCHITECTURE_0_RANGE.len()),
         )
     }
 
@@ -49,7 +50,7 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 
 register!(NV_PBUS_SW_SCRATCH_0E_FRTS_ERR => NV_PBUS_SW_SCRATCH[0xe],
     "scratch register 0xe used as FRTS firmware error code" {
-    31:16   frts_err_code as u16;
+    31:16   frts_err_code;
 });
 
 // PFB
@@ -58,17 +59,17 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 // GPU to perform sysmembar operations (see `fb::SysmemFlush`).
 
 register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR @ 0x00100c10 {
-    31:0    adr_39_08 as u32;
+    31:0    adr_39_08;
 });
 
 register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI @ 0x00100c40 {
-    23:0    adr_63_40 as u32;
+    23:0    adr_63_40;
 });
 
 register!(NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE @ 0x00100ce0 {
-    3:0     lower_scale as u8;
-    9:4     lower_mag as u8;
-    30:30   ecc_mode_enabled as bool;
+    3:0     lower_scale;
+    9:4     lower_mag;
+    30:30   ecc_mode_enabled => bool;
 });
 
 impl NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE {
@@ -87,7 +88,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 }
 
 register!(NV_PFB_PRI_MMU_WPR2_ADDR_LO@0x001fa824  {
-    31:4    lo_val as u32, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
+    31:4    lo_val, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
 });
 
 impl NV_PFB_PRI_MMU_WPR2_ADDR_LO {
@@ -98,7 +99,7 @@ pub(crate) fn lower_bound(self) -> u64 {
 }
 
 register!(NV_PFB_PRI_MMU_WPR2_ADDR_HI@0x001fa828  {
-    31:4    hi_val as u32, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
+    31:4    hi_val, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
 });
 
 impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
@@ -123,7 +124,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 // `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
           "Privilege level mask register" {
-    0:0     read_protection_level0 as bool, "Set after FWSEC lowers its protection level";
+    0:0     read_protection_level0 => bool, "Set after FWSEC lowers its protection level";
 });
 
 // OpenRM defines this as a register array, but doesn't specify its size and only uses its first
@@ -133,7 +134,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 register!(
     NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0],
     "Scratch group 05 register 0 used as GFW boot progress indicator" {
-        7:0    progress as u8, "Progress of GFW boot (0xff means completed)";
+        7:0    progress, "Progress of GFW boot (0xff means completed)";
     }
 );
 
@@ -145,13 +146,13 @@ pub(crate) fn completed(self) -> bool {
 }
 
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
-    31:0    value as u32;
+    31:0    value;
 });
 
 register!(
     NV_USABLE_FB_SIZE_IN_MB => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42,
     "Scratch group 42 register used as framebuffer size" {
-        31:0    value as u32, "Usable framebuffer size, in megabytes";
+        31:0    value, "Usable framebuffer size, in megabytes";
     }
 );
 
@@ -165,8 +166,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PDISP
 
 register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
-    3:3     status_valid as bool, "Set if the `addr` field is valid";
-    31:8    addr as u32, "VGA workspace base address divided by 0x10000";
+    3:3     status_valid => bool, "Set if the `addr` field is valid";
+    31:8    addr, "VGA workspace base address divided by 0x10000";
 });
 
 impl NV_PDISP_VGA_WORKSPACE_BASE {
@@ -185,40 +186,40 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
 register!(NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION @ 0x00824100[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 register!(NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION @ 0x00824140[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 register!(NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION @ 0x008241c0[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 // PFALCON
 
 register!(NV_PFALCON_FALCON_IRQSCLR @ PFalconBase[0x00000004] {
-    4:4     halt as bool;
-    6:6     swgen0 as bool;
+    4:4     halt => bool;
+    6:6     swgen0 => bool;
 });
 
 register!(NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase[0x00000040] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase[0x00000044] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_RM @ PFalconBase[0x00000084] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_HWCFG2 @ PFalconBase[0x000000f4] {
-    10:10   riscv as bool;
-    12:12   mem_scrubbing as bool, "Set to 0 after memory scrubbing is completed";
-    31:31   reset_ready as bool, "Signal indicating that reset is completed (GA102+)";
+    10:10   riscv => bool;
+    12:12   mem_scrubbing => bool, "Set to 0 after memory scrubbing is completed";
+    31:31   reset_ready => bool, "Signal indicating that reset is completed (GA102+)";
 });
 
 impl NV_PFALCON_FALCON_HWCFG2 {
@@ -229,101 +230,101 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 }
 
 register!(NV_PFALCON_FALCON_CPUCTL @ PFalconBase[0x00000100] {
-    1:1     startcpu as bool;
-    4:4     halted as bool;
-    6:6     alias_en as bool;
+    1:1     startcpu => bool;
+    4:4     halted => bool;
+    6:6     alias_en => bool;
 });
 
 register!(NV_PFALCON_FALCON_BOOTVEC @ PFalconBase[0x00000104] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMACTL @ PFalconBase[0x0000010c] {
-    0:0     require_ctx as bool;
-    1:1     dmem_scrubbing as bool;
-    2:2     imem_scrubbing as bool;
-    6:3     dmaq_num as u8;
-    7:7     secure_stat as bool;
+    0:0     require_ctx => bool;
+    1:1     dmem_scrubbing => bool;
+    2:2     imem_scrubbing => bool;
+    6:3     dmaq_num;
+    7:7     secure_stat => bool;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase[0x00000110] {
-    31:0    base as u32;
+    31:0    base => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase[0x00000114] {
-    23:0    offs as u32;
+    23:0    offs;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase[0x00000118] {
-    0:0     full as bool;
-    1:1     idle as bool;
-    3:2     sec as u8;
-    4:4     imem as bool;
-    5:5     is_write as bool;
-    10:8    size as u8 ?=> DmaTrfCmdSize;
-    14:12   ctxdma as u8;
-    16:16   set_dmtag as u8;
+    0:0     full => bool;
+    1:1     idle => bool;
+    3:2     sec;
+    4:4     imem => bool;
+    5:5     is_write => bool;
+    10:8    size ?=> DmaTrfCmdSize;
+    14:12   ctxdma;
+    16:16   set_dmtag;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase[0x0000011c] {
-    31:0    offs as u32;
+    31:0    offs => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase[0x00000128] {
-    8:0     base as u16;
+    8:0     base;
 });
 
 register!(NV_PFALCON_FALCON_HWCFG1 @ PFalconBase[0x0000012c] {
-    3:0     core_rev as u8 ?=> FalconCoreRev, "Core revision";
-    5:4     security_model as u8 ?=> FalconSecurityModel, "Security model";
-    7:6     core_rev_subversion as u8 ?=> FalconCoreRevSubversion, "Core revision subversion";
+    3:0     core_rev ?=> FalconCoreRev, "Core revision";
+    5:4     security_model ?=> FalconSecurityModel, "Security model";
+    7:6     core_rev_subversion => FalconCoreRevSubversion, "Core revision subversion";
 });
 
 register!(NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase[0x00000130] {
-    1:1     startcpu as bool;
+    1:1     startcpu => bool;
 });
 
 // Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the falcon
 // instance.
 register!(NV_PFALCON_FALCON_ENGINE @ PFalconBase[0x000003c0] {
-    0:0     reset as bool;
+    0:0     reset => bool;
 });
 
 register!(NV_PFALCON_FBIF_TRANSCFG @ PFalconBase[0x00000600[8]] {
-    1:0     target as u8 ?=> FalconFbifTarget;
-    2:2     mem_type as bool => FalconFbifMemType;
+    1:0     target ?=> FalconFbifTarget;
+    2:2     mem_type => FalconFbifMemType;
 });
 
 register!(NV_PFALCON_FBIF_CTL @ PFalconBase[0x00000624] {
-    7:7     allow_phys_no_ctx as bool;
+    7:7     allow_phys_no_ctx => bool;
 });
 
 /* PFALCON2 */
 
 register!(NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base[0x00000180] {
-    7:0     algo as u8 ?=> FalconModSelAlgo;
+    7:0     algo ?=> FalconModSelAlgo;
 });
 
 register!(NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base[0x00000198] {
-    7:0    ucode_id as u8;
+    7:0    ucode_id => u8;
 });
 
 register!(NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base[0x0000019c] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 // OpenRM defines this as a register array, but doesn't specify its size and only uses its first
 // element. Be conservative until we know the actual size or need to use more registers.
 register!(NV_PFALCON2_FALCON_BROM_PARAADDR @ PFalcon2Base[0x00000210[1]] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 // PRISCV
 
 register!(NV_PRISCV_RISCV_BCR_CTRL @ PFalconBase[0x00001668] {
-    0:0     valid as bool;
-    4:4     core_select as bool => PeregrineCoreSelect;
-    8:8     br_fetch as bool;
+    0:0     valid => bool;
+    4:4     core_select => PeregrineCoreSelect;
+    8:8     br_fetch => bool;
 });
 
 // The modules below provide registers that are not identical on all supported chips. They should
@@ -333,7 +334,7 @@ pub(crate) mod gm107 {
     // FUSE
 
     register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
-        0:0     display_disabled as bool;
+        0:0     display_disabled => bool;
     });
 }
 
@@ -341,6 +342,6 @@ pub(crate) mod ga100 {
     // FUSE
 
     register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
-        0:0     display_disabled as bool;
+        0:0     display_disabled => bool;
     });
 }

-- 
2.51.0


