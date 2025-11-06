Return-Path: <linux-kernel+bounces-887902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59933C3956A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88C624E6957
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4C2D9EEC;
	Thu,  6 Nov 2025 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p1/ucRCl"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE392DD60F;
	Thu,  6 Nov 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412894; cv=fail; b=KPhRme0NChkgLWGoEFpxgX8k9nJCEwRr8cO6iPvY4HCsAaHu4lMzqr+iKPPZ5BnK/bnOj1NPgXfDKVnQn7Yru6cIDGZWnlXHhiVdPwmZ9meMVMJSe5kdBpZ+D/aOHeWrMPJueDStxVS6lklbCwoiIiB/lXCl5h92glyGBwYqUqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412894; c=relaxed/simple;
	bh=k2UDZ+Y0haD2UJqgaztflwZw39NRu/uDAifWgN+fAE0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gMu2vCmW/93EfGvpuvVYkAd3/mvWG0yZY6fm/0bnwCGbQ83quM2MCGo1zhdvD9Eyr7oxShSAAdJ226Yj91i2NYmx1yPHrYtJicF5gcuE2F0lOkyowMRfcpq2cxYUg59u6xyxIVjIWOPupiCqY2GZZ5QksY3giFXnUAjDI95krDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p1/ucRCl; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMB2qPoy6eKC/SY0pcX8oIUJ+ekh3+qhuCJA9kaKnKduCibdxh7M4QW70TLlCK1KWHO7tSxf/NhsaI+lEXKfbqQYbu6AzNvprOBPFMHEuGnAEAZPyyIMU0p8UHG3FYLDt+NCUcNl1kLvdNAm1du6l3FW+poXASyYwowYXXAxrHdjg6UEzlyQb/W+pQdHMCpA7NTq9Kcss21G06dPWVs+WVsbl0HAz/ArWft9lAuelB3ioi5f166UMB6/lR87mkyvNxug6L7lJK9U7Lmpf18EUr331jhig+rLC3HtB+/DcJZ/wqCTlnX/nWBMYjXP636TPF1LW1EkUwK6jw79SIJzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34YkBIh6bRuZljkDu4foSHg60DdJGklwWcFh8+KbM0c=;
 b=tKWwEDGGmdT3CCEKxI8NrsEamGNuLpD5i/G/V/QF6BxWLH+mJIozN4EMs5r2Kz8b4Ge4jSWqKPYiO3uJ93ZNtegjqqj/VMwYQaXDqYHv3rbOeL4uD247fFj/M1hPAy7K/Slujo6jNhW5y01uS2b4m3b+7EziE/KEmGE0wxoon0TpsWxEEOeoD4UdVG7rCv4Q0TTAd/3ULOplDnPheBqjKS7++l4hTM++uGmbif71v0vjtCg+KMI/TUdnqIezjTDvzoFkudf2uAG5U1vMmDN23Xs9CQSl5ZPNxOtCqQIQ3VxNi0Yg41qjaAxhJ0RCYtBtj6xcr4+zWvViQkQKQ2vTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34YkBIh6bRuZljkDu4foSHg60DdJGklwWcFh8+KbM0c=;
 b=p1/ucRClkAfC1DWkod8yaZq/ziuy+BA5Plsoeu1MbJA36y70JiMTabmHgpgvGfSKK5fqfOG6MqvyX3vX7ganXRx0ExyQ8t9Opb3ZvGnT/UlPEd1AbKI203b0784aJJ8htyyUi92VNXCnbfhk3u0Jruz5H8mWmy8UGmSSAQ3Tv4Bsw8HDg+FN+rrireC0AdbiGmdpc+wTcJlHP9oSPtVWxX6Pe+WbXbgf8UmcxDMQ/v3yAFObZSPuX4qqIW4jFmvGBYoztZt+SOwZS4H0lKUuH1c1O77iQAeLk0yda2sbRab9aa7eefoM+O4oLCI0ZNKs11bmW75k3fM1TQZxggD1JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 07:08:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 07:08:05 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 06 Nov 2025 16:07:14 +0900
Subject: [PATCH v3 2/4] rust: num: add Bounded integer wrapping type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-bounded_ints-v3-2-47104986a5c3@nvidia.com>
References: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
In-Reply-To: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0184.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: c241faa8-ff20-446a-c6fb-08de1d033b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2RGNEVtWWI5V2F5VWFnYnFVeVVOekRhUDFkekwyR1NkOVl0ekxIbXBYN2E4?=
 =?utf-8?B?RzRxbnRUZFFOVldoNGhCbWp6emNBNWtXOGxBUWk5aXo5NlM4eXZQaUhuV1Z0?=
 =?utf-8?B?cnVzUTRLYjN5cGNpZ09XVEtxUUd0aGNvUVF6ZktZV2hhR1dkbXI1d1lHNTJL?=
 =?utf-8?B?bTdyMFNsL0xleWZNTndPT2pZOGU5WWgwUVdtMERIWnFtaGRMQ2ZxZ1BvNjVQ?=
 =?utf-8?B?S0hwTUd0K0lIdnZwRUZvdkRzWUVuUWsvbzk1b25nWXNucDIxUFhIY2gxYVdO?=
 =?utf-8?B?SVpYdWdkZThHTHRpOFdWZkF6WUEyRWRlbGdXVFdEcVJ3NTF1YnlGZ0tKbXh6?=
 =?utf-8?B?M29kQjZJUzZlZWlkVndlYlNtYjFGdW9Vbkd4ZG5DUkYrV0JvNmJKeWVQa3JJ?=
 =?utf-8?B?V2tUREJLOTV1cjI2VDZESmhMQWxUV1VlVVBEdkNSeW1xRjVXYWlOWDBtTi80?=
 =?utf-8?B?MkJQZTZTbzlzRGplZXBMNXZxTnRpYnRxNFcxV1F5dVpPSEtEOTNuRWxoV3ps?=
 =?utf-8?B?aHp0eXcycXFRMEFkbkJRTTk0NStFWUQ0L3dlN2NwY0dLMHFERmlxQjlvbWhX?=
 =?utf-8?B?L1JOK09pMFpxbDFxbmpWcW1zaHppV2JWa3hvdmQzbHQrS21iUjZOcmFST1ky?=
 =?utf-8?B?VVNlM3ZsVEgzV3Q3aC8xb2wvNDgyWlpvM2EyNitzVUgzaEdGandrQS9ub0pH?=
 =?utf-8?B?Y1E5YUpyMnloT3lPZk9uRFhSTTlab2tCdSthZkhvTWRmVWg3RnhURXA5VDJY?=
 =?utf-8?B?YkZ2cHBLUkZiNzR0TnBxck8xNEc3YmV1VUdHVVY4cnpXVDhGNkcwQmx5Y2Er?=
 =?utf-8?B?MG0wK0R1aWlxQU5jMVkwSmlQcys4MmpwZ1IwOHJXVkhKNENuOG5nemJmOSs1?=
 =?utf-8?B?eEFCUU1ZOG95N2JPSlZNbG94bWxWMGJKQTlrUEVGUFZYNEx4alZ0VTJkMEtQ?=
 =?utf-8?B?MUFlSEdxYWRaTU9VUysrVndjeWFzWXJKNlZVcS9CL3laMDA1aUZxYTlNaXZD?=
 =?utf-8?B?WTNCK0tDTGJlZm02clhsTTk3RjJ2QWlvRXVaOGFGTi9uUzNnTVc3bFhVK2J0?=
 =?utf-8?B?YmhsOWx2UUFTaDZ5R2RvZzFJYkliRGFjajBEK0lqdGp1RjVsK01UMXZQeThk?=
 =?utf-8?B?aGJpaW1tTGFBSUxWdnR3d0p0WjRPK0wzR3VSb21NK255WnNGdGFEbWZUeG1k?=
 =?utf-8?B?aXBGNkEySlp2SHVtdkJ6VHBLMmloRUdvcThuc2UvcFRQb0tkaCt4THBBeEEy?=
 =?utf-8?B?NUl4VCsyQTIyaGhVT1MwNzZYc3QzVnRvRW12bGxZNVJjWVUwR2JrWUgzbC9s?=
 =?utf-8?B?bzZJeWdCUjFKVVF5bTVpb092aGsyOEFNM3JjZWU0eGpwN2JwY09OWUVmd0l5?=
 =?utf-8?B?bWZMR3h0cG5DVlZsTHVFbTJrSysybHpyNytqK2tsRG9yaWRUSjJ5RndDTTNP?=
 =?utf-8?B?c2lHNHF0UFFmT3JsZWU1YSsreTVnWWNQaHNRQ2lXSWhEcXFhc2g1YlA5bnlF?=
 =?utf-8?B?OWE3QnVHcTRVRjZnSG93S005cUYzNVQ3VGpiT29uY0ZSSVNOWUU0ZXJRbWdW?=
 =?utf-8?B?MkdkdlBwbmtZdkhPcFNYUEdkMW1haU1IRTRYSnFLOWpXMW5TTnR4UldXRlJM?=
 =?utf-8?B?SXZLaktHbEJhZWNwZXJuQ204NGFmR2s4MU5pRGZjN05kNytBbXl4N0xsVEpB?=
 =?utf-8?B?ekRzS3cvclM4NkNrbCt0VXA1QVVMMCtvNUI0UVZFTTVsaFlNeDZDY3pVWm43?=
 =?utf-8?B?VFBmSU81aG4zSGJ0OTNtMVdER1lBMEFhVkJMbGVmTHkrYjVPSm9UQWJJRDJv?=
 =?utf-8?B?VkpXTzMxSzZJbjZFejZwUVVTNWpRWXc4dzlZMXFhT3h0T0tQcVVHbjZTdFN0?=
 =?utf-8?B?VVVYajk4ekJDa2p6QUN1QTdnYzY0MUg1KzEzNVRzNWFGdzZ0akhqOHU2aHBv?=
 =?utf-8?B?ZkVGcWhzUC9TK1BLbmtObFdBSTFneHlkTzZ5SXR2S0RUWU40cFJIVy9tWjFm?=
 =?utf-8?Q?uS/bqJC0T6tkp3psU7QOV95CO1zKDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkdLNWNOWCtzRGtZdlU3YjI3c1pVRkJ0aTJNd0tOeEYzUGNtTzNLTGhBRThx?=
 =?utf-8?B?djIyOUtOUEpjbTFDbldyNFM0RjIwc1drRnBmM1F1ZHhudjZQeTRwUGhHTmxV?=
 =?utf-8?B?alBkWlNxVWxPZDFmeUk4eDYwVU00bVhOT0N2NlJUdzNRbmhLVWdXRVMyRWo3?=
 =?utf-8?B?ZnljM2wvcFRyQWs3eitFdFZlZ0hmRHV3Z3dCeHZCOWhycTczRk5GeCtQQlR0?=
 =?utf-8?B?Y212N1BoT0ZIUnRodllZMjYzdkRkSVB1UXJlTGRGcTlUMVkzOGpRNStGVE9U?=
 =?utf-8?B?eE9ET2w0SDBrTEN0K2lyd2RkUUZ6UHliVTZsdFg5V3Z1b0xKRlVhdzJqVHJ1?=
 =?utf-8?B?akhxdnNCMmczWUppM0plbkN5SVlxZHZhN29PbVlIN0t5SHdudTlDOEYxMDhH?=
 =?utf-8?B?Tjg4RXNrT25mdkVQMUg5Y2F6RnVkQmp4ZjhtenZOdnpNSXpDVjNWS0lURkth?=
 =?utf-8?B?UWpGSkVIcDdrR3Bxbm1OR2F5WFRNQU9lMWs0L1FtN3MyaHBlYUF2bUlrWWlE?=
 =?utf-8?B?Q3NuSDUzbEJMOEFkTG9UclpRdlVuNk03dVBRb2dMRWthN0ZCYkZKS0U2ZEhm?=
 =?utf-8?B?amZSak41a0pKL3JYQWhBY0FER3ZaenlWWHlaS0lKNzNMWFRESGVrYXdSNXhT?=
 =?utf-8?B?cEdoQUprQU1LeHFWU1RHZ3VIUmpOejdzV09kQVlDNi91amUrRXFtbVRyWEtv?=
 =?utf-8?B?TlZvRGs4Um9objJQa3ZXRmtWMGxCZ3ZPU3NKQVdBRzJBc1BOb3Z3WTlzcnor?=
 =?utf-8?B?bmRJRURGQlpoR1RaTkFiN2xDRU9RSEpzd1BKbG4xb1lwVTdmWTNjaVY4U05n?=
 =?utf-8?B?dURJTFIyOFNCT2pnOE5JMHMzVHZRemYwazRhcVZQdlVQY09rR0FKUnMvTy9R?=
 =?utf-8?B?VU1nb3RPelFjb245K1FuT1J1R1J2QXNlY0JBTjUva29oZVBvUEVydmtKMXBI?=
 =?utf-8?B?WkVTSFplbG5QMS9lZ1pPQjBnK0lING4vMUJMZ3Qzd0ttK0I5cmhwQnZrUXdu?=
 =?utf-8?B?ME1kNy8wSDVzSmZsUjBkRDNIUFp4V1Nzd1BOb3N3eDBxa3I4cXg4R05ZeGVi?=
 =?utf-8?B?c3lXcFFYWGQwT3RpeFlwYmQ3dDV3eDVPNk8zMWYvUEN5eHBnT2JjdFgzVWFD?=
 =?utf-8?B?RU1HR2F5U3R0bitWV0cyUytoSmYxUnpNNDlOUHdsaFBSVGtJQm0xR3R0ZnpJ?=
 =?utf-8?B?NzAweFlGdHRLQUppT0dIVWEzaUxYK2llM01NK2l4TWJpcStlclBERDNZT0pj?=
 =?utf-8?B?SCtaaHFmVjNHZ08vVEpKdXoxbTZ3Z2VQOWlZb3dwUkNhTGFNaFhqdml5UVFZ?=
 =?utf-8?B?Y2l5d085dHJHYnNkaUdCSGJkcVcwenF3SHNaaFFka1NLOGFqa1hsNVZ2OFhW?=
 =?utf-8?B?RWFoNUJRZUYrSHI5aWNrZFUyL0tHZXdPb002YVVBNnRNdWs1RXp0NUYwd3pJ?=
 =?utf-8?B?NXhpdkEzV3pBQzRZQ0dha3Y4aVNLZlJjMmFMQk1BNEhJY1k0Vnlidi9tT0Vq?=
 =?utf-8?B?aVJ3NTc0L2N5bVB5dU40bzRoTUt6VHV2UmEyRG9pdisxbi9xZC9MbjNnL0ly?=
 =?utf-8?B?VG9Ib25Kd3BNT1FCSzQ5aFZrcGg2cWxxdEZ2RDVMTXBVTm9BRkRoRVR6L2I2?=
 =?utf-8?B?ZHprOHlHRDVrQ3k4dVNZWi9sWHJpUE5zdGdZN1dTa0ZFaGVGUlBMMG5ycSti?=
 =?utf-8?B?VmNrNmV3c245U3RVN09OVWRwVE1UckZEdnRUSWMwTWRGSG5kMFRxQWw1eE5K?=
 =?utf-8?B?YzEvdDIxS3VFUnpacm52R1FKWnErL0FXTGE1dHFqaU9NMTRiNzUzSkFRZGQz?=
 =?utf-8?B?bEg0OW51QzE0RnRvblh4bVRxU3FnSlFkMXlaZkZkUTVFdUJTNWZtd1cvWWpE?=
 =?utf-8?B?RGtiR1F3L2ZVUTJ5VS9jTkNLdkViU05vRmVHZ3lndDFxc0d6NjlLZ0JOWHd4?=
 =?utf-8?B?Q0RMTk1kZ1RycGd4ZzYrR3hyNFFBY2ttWWRnazVsUDU4NGVHSlJuNkRZczVm?=
 =?utf-8?B?NnQ0TWhGNm5VQ2pMa2R1OG1UWFBCR3Y5UDluV25YWFF5cmZIWXJ3a0MycHNl?=
 =?utf-8?B?VjFUV045WmhEQmpxUFFGeDNQUU1ScUFZYm5PQmZqNHZnRER0WUdLRFZzN1Fr?=
 =?utf-8?B?Ty9kenZwTElOSFg2TDkySndUZXprcGE0VmsvZy8wTzM5S0l4RVI3b3hlWm05?=
 =?utf-8?Q?4l83LEmV42eD2phctS2VhJjn+pEr1xB1ffWD2SgW2gMQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c241faa8-ff20-446a-c6fb-08de1d033b84
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:08:05.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asyvF4buRm8SkIq0NUltctaDTPPecUIECCEy5E+LbHKk8lJbLBd3KTsPON2XZfWdtY30U/h6RyawpnxkuBNYzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

Add the `Bounded` integer wrapper type, which restricts the number of
bits allowed to represent of value.

This is useful to e.g. enforce guarantees when working with bitfields
that have an arbitrary number of bits.

Alongside this type, provide many `From` and `TryFrom` implementations
are to reduce friction when using with regular integer types. Proxy
implementations of common integer operations are also provided.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/num.rs         |    3 +
 rust/kernel/num/bounded.rs | 1045 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1048 insertions(+)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index 3f85e50b8632..bc9abcc3a317 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -4,6 +4,9 @@
 
 use core::ops;
 
+pub mod bounded;
+pub use bounded::*;
+
 /// Designates unsigned primitive types.
 pub struct Unsigned(());
 
diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
new file mode 100644
index 000000000000..2e4bc4ce9af5
--- /dev/null
+++ b/rust/kernel/num/bounded.rs
@@ -0,0 +1,1045 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`Bounded`], a wrapper around integer types limiting the number of bits
+//! usable for value representation.
+
+use core::{
+    cmp,
+    fmt,
+    ops::{
+        self,
+        Deref, //
+    }, //,
+};
+
+use kernel::{
+    num::Integer,
+    prelude::*, //
+};
+
+/// Evaluates to `true` if `$value` can be represented using at most `$n` bits in a `$type`.
+///
+/// Can be used in const context.
+macro_rules! fits_within {
+    ($value:expr, $type:ty, $n:expr) => {{
+        let shift: u32 = <$type>::BITS - $n;
+
+        // `value` fits within `$n` bits if shifting it left by the number of unused bits, then
+        // right by the same number, doesn't change it.
+        //
+        // This method has the benefit of working for both unsigned and signed values.
+        ($value << shift) >> shift == $value
+    }};
+}
+
+/// Returns `true` if `value` can be represented with at most `N` bits in a `T`.
+fn fits_within<T: Integer>(value: T, num_bits: u32) -> bool {
+    fits_within!(value, T, num_bits)
+}
+
+/// An integer value that requires only the `N` less significant bits of the wrapped type to be
+/// encoded.
+///
+/// This limits the number of usable bits in the wrapped integer type, and thus the stored value to
+/// a narrower range, which provides guarantees that can be useful when working with in e.g.
+/// bitfields.
+///
+/// # Invariants
+///
+/// - `N` is greater than `0`.
+/// - `N` is less than or equal to `T::BITS`.
+/// - Stored values can be represented with at most `N` bits.
+///
+/// # Examples
+///
+/// The preferred way to create values is through constants and the [`Bounded::new`] family of
+/// constructors, as they trigger a build error if the type invariants cannot be withheld.
+///
+/// ```
+/// use kernel::num::Bounded;
+///
+/// // An unsigned 8-bit integer, of which only the 4 LSBs are used.
+/// // The value `15` is statically validated to fit that constraint at build time.
+/// let v = Bounded::<u8, 4>::new::<15>();
+/// assert_eq!(v.get(), 15);
+///
+/// // Same using signed values.
+/// let v = Bounded::<i8, 4>::new::<-8>();
+/// assert_eq!(v.get(), -8);
+///
+/// // This doesn't build: a `u8` is smaller than the requested 9 bits.
+/// // let _ = Bounded::<u8, 9>::new::<10>();
+///
+/// // This also doesn't build: the requested value doesn't fit within 4 signed bits.
+/// // let _ = Bounded::<i8, 4>::new::<8>();
+/// ```
+/// Values can also be validated at runtime with [`Bounded::try_new`].
+///
+/// ```
+/// use kernel::num::Bounded;
+///
+/// //  This succeeds because `15` can be represented with 4 unsigned bits.
+/// assert!(Bounded::<u8, 4>::try_new(15).is_some());
+///
+/// // This fails because `16` cannot be represented with 4 unsigned bits.
+/// assert!(Bounded::<u8, 4>::try_new(16).is_none());
+/// ```
+///
+/// Non-constant expressions can be validated at build-time thanks to compiler optimizations. This
+/// should be used with caution, on simple expressions only.
+///
+/// ```
+/// use kernel::num::Bounded;
+/// # fn some_number() -> u32 { 0xffffffff }
+///
+/// // Here the compiler can infer from the mask that the type invariants are not violated, even
+/// // though the value returned by `some_number` is not statically known.
+/// let v = Bounded::<u32, 4>::from_expr(some_number() & 0xf);
+/// ```
+///
+/// Comparison and arithmetic operations are supported on [`Bounded`]s with a compatible backing
+/// type, regardless of their number of valid bits.
+///
+/// ```
+/// use kernel::num::Bounded;
+///
+/// let v1 = Bounded::<u32, 8>::new::<4>();
+/// let v2 = Bounded::<u32, 4>::new::<15>();
+///
+/// assert!(v1 != v2);
+/// assert!(v1 < v2);
+/// assert_eq!(v1 + v2, 19);
+/// assert_eq!(v2 % v1, 3);
+/// ```
+///
+/// These operations are also supported between a [`Bounded`] and its backing type.
+///
+/// ```
+/// use kernel::num::Bounded;
+///
+/// let v = Bounded::<u8, 4>::new::<15>();
+///
+/// assert!(v == 15);
+/// assert!(v > 12);
+/// assert_eq!(v + 5, 20);
+/// assert_eq!(v / 3, 5);
+/// ```
+///
+/// A change of backing types is possible using [`Bounded::cast`], and the number of valid bits can
+/// be extended or reduced with [`Bounded::extend`] and [`Bounded::try_shrink`].
+///
+/// ```
+/// use kernel::num::Bounded;
+///
+/// let v = Bounded::<u32, 12>::new::<127>();
+///
+/// // Changes backing type from `u32` to `u16`.
+/// let _: Bounded<u16, 12> = v.cast();
+///
+/// // This does not build, as `u8` is smaller than 12 bits.
+/// // let _: Bounded<u8, 12> = v.cast();
+///
+/// // We can safely extend the number of bits...
+/// let _ = v.extend::<15>();
+///
+/// // ... to the limits of the backing type. This doesn't build as a `u32` cannot contain 33 bits.
+/// // let _ = v.extend::<33>();
+///
+/// // Reducing the number of bits is validated at runtime. This works because `127` can be
+/// // represented with 8 bits.
+/// assert!(v.try_shrink::<8>().is_some());
+///
+/// // ... but not with 6, so this fails.
+/// assert!(v.try_shrink::<6>().is_none());
+/// ```
+///
+/// Infallible conversions from a primitive integer to a large-enough [`Bounded`] are supported.
+///
+/// ```
+/// use kernel::num::Bounded;
+///
+/// // This unsigned `Bounded` has 8 bits, so it can represent any `u8`.
+/// let v = Bounded::<u32, 8>::from(128u8);
+/// assert_eq!(v.get(), 128);
+///
+/// // This signed `Bounded` has 8 bits, so it can represent any `i8`.
+/// let v = Bounded::<i32, 8>::from(-128i8);
+/// assert_eq!(v.get(), -128);
+///
+/// // This doesn't build, as this 6-bit `Bounded` does not have enough capacity to represent a
+/// // `u8` (regardless of the passed value).
+/// // let _ = Bounded::<u32, 6>::from(10u8);
+///
+/// // Booleans can be converted into single-bit `Bounded`s.
+///
+/// let v = Bounded::<u64, 1>::from(false);
+/// assert_eq!(v.get(), 0);
+///
+/// let v = Bounded::<u64, 1>::from(true);
+/// assert_eq!(v.get(), 1);
+/// ```
+///
+/// Infallible conversions from a [`Bounded`] to a primitive integer are also supported, and
+/// dependent on the number of bits used for value representation, not on the backing type.
+///
+/// ```
+/// use kernel::num::Bounded;
+///
+/// // Even though its backing type is `u32`, this `Bounded` only uses 6 bits and thus can safely
+/// // be converted to a `u8`.
+/// let v = Bounded::<u32, 6>::new::<63>();
+/// assert_eq!(u8::from(v), 63);
+///
+/// // Same using signed values.
+/// let v = Bounded::<i32, 8>::new::<-128>();
+/// assert_eq!(i8::from(v), -128);
+///
+/// // This however does not build, as 10 bits won't fit into a `u8` (regardless of the actually
+/// // contained value).
+/// let _v = Bounded::<u32, 10>::new::<10>();
+/// // assert_eq!(u8::from(_v), 10);
+///
+/// // Single-bit `Bounded`s can be converted into a boolean.
+/// let v = Bounded::<u8, 1>::new::<1>();
+/// assert_eq!(bool::from(v), true);
+///
+/// let v = Bounded::<u8, 1>::new::<0>();
+/// assert_eq!(bool::from(v), false);
+/// ```
+///
+/// Fallible conversions from any primitive integer to any [`Bounded`] are also supported using the
+/// [`TryIntoBounded`] trait.
+///
+/// ```
+/// use kernel::num::{Bounded, TryIntoBounded};
+///
+/// // Succeeds because `128` fits into 8 bits.
+/// let v: Option<Bounded<u16, 8>> = 128u32.try_into_bitint();
+/// assert_eq!(v.as_deref().copied(), Some(128));
+///
+/// // Fails because `128` doesn't fits into 6 bits.
+/// let v: Option<Bounded<u16, 6>> = 128u32.try_into_bitint();
+/// assert_eq!(v, None);
+/// ```
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Default, Hash)]
+pub struct Bounded<T: Integer, const N: u32>(T);
+
+/// Validating the value as a const expression cannot be done as a regular method, as the
+/// arithmetic operations we rely on to check the bounds are not const. Thus, implement
+/// [`Bounded::new`] using a macro.
+macro_rules! impl_const_new {
+    ($($type:ty)*) => {
+        $(
+        impl<const N: u32> Bounded<$type, N> {
+            /// Creates a [`Bounded`] for the constant `VALUE`.
+            ///
+            /// Fails at build time if `VALUE` cannot be represented with `N` bits.
+            ///
+            /// This method should be preferred to [`Self::from_expr`] whenever possible.
+            ///
+            /// # Examples
+            /// ```
+            /// use kernel::num::Bounded;
+            ///
+            #[doc = ::core::concat!(
+                "let v = Bounded::<",
+                ::core::stringify!($type),
+                ", 4>::new::<7>();")]
+            /// assert_eq!(v.get(), 7);
+            /// ```
+            pub const fn new<const VALUE: $type>() -> Self {
+                // Statically assert that `VALUE` fits within the set number of bits.
+                const {
+                    assert!(fits_within!(VALUE, $type, N));
+                }
+
+                // INVARIANT: `fits_within` confirmed that `VALUE` can be represented within
+                // `N` bits.
+                Self::__new(VALUE)
+            }
+        }
+        )*
+    };
+}
+
+impl_const_new!(
+    u8 u16 u32 u64 usize
+    i8 i16 i32 i64 isize
+);
+
+impl<T, const N: u32> Bounded<T, N>
+where
+    T: Integer,
+{
+    /// Private constructor enforcing the type invariants.
+    ///
+    /// All instances of [`Bounded`] must be created through this method as it enforces most of the
+    /// type invariants.
+    ///
+    /// The caller remains responsible for checking, either statically or dynamically, that `value`
+    /// can be represented as a `T` using at most `N` bits.
+    const fn __new(value: T) -> Self {
+        // Enforce the type invariants.
+        const {
+            // `N` cannot be zero.
+            assert!(N != 0);
+            // The backing type is at least as large as `N` bits.
+            assert!(N <= T::BITS);
+        }
+
+        Self(value)
+    }
+
+    /// Attempts to turn `value` into a `Bounded` using `N` bits.
+    ///
+    /// Returns [`None`] if `value` doesn't fit within `N` bits.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::Bounded;
+    ///
+    /// let v = Bounded::<u8, 1>::try_new(1);
+    /// assert_eq!(v.as_deref().copied(), Some(1));
+    ///
+    /// let v = Bounded::<i8, 4>::try_new(-2);
+    /// assert_eq!(v.as_deref().copied(), Some(-2));
+    ///
+    /// // `0x1ff` doesn't fit into 8 unsigned bits.
+    /// let v = Bounded::<u32, 8>::try_new(0x1ff);
+    /// assert_eq!(v, None);
+    ///
+    /// // `8` doesn't fit into 4 signed bits.
+    /// let v = Bounded::<i8, 4>::try_new(8);
+    /// assert_eq!(v, None);
+    /// ```
+    pub fn try_new(value: T) -> Option<Self> {
+        fits_within(value, N).then(|| {
+            // INVARIANT: `fits_within` confirmed that `value` can be represented within `N` bits.
+            Self::__new(value)
+        })
+    }
+
+    /// Checks that `expr` is valid for this type at compile-time and build a new value.
+    ///
+    /// This relies on [`build_assert!`] and guaranteed optimization to perform validation at
+    /// compile-time. If `expr` cannot be proved to be within the requested bounds at compile-time,
+    /// use the fallible [`Self::try_new`] instead.
+    ///
+    /// Limit this to simple, easily provable expressions, and prefer one of the [`Self::new`]
+    /// constructors whenever possible as they statically validate the value instead of relying on
+    /// compiler optimizations.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::Bounded;
+    /// # fn some_number() -> u32 { 0xffffffff }
+    ///
+    /// // Some undefined number.
+    /// let v: u32 = some_number();
+    ///
+    /// // Triggers a build error as `v` cannot be asserted to fit within 4 bits...
+    /// // let _ = Bounded::<u32, 4>::from_expr(v);
+    ///
+    /// // ... but this works as the compiler can assert the range from the mask.
+    /// let _ = Bounded::<u32, 4>::from_expr(v & 0xf);
+    ///
+    /// // These expressions are simple enough to be proven correct, but since they are static the
+    /// // `new` constructor should be preferred.
+    /// assert_eq!(Bounded::<u8, 1>::from_expr(1).get(), 1);
+    /// assert_eq!(Bounded::<u16, 8>::from_expr(0xff).get(), 0xff);
+    /// ```
+    pub fn from_expr(expr: T) -> Self {
+        crate::build_assert!(
+            fits_within(expr, N),
+            "Requested value larger than maximal representable value."
+        );
+
+        // INVARIANT: `fits_within` confirmed that `expr` can be represented within `N` bits.
+        Self::__new(expr)
+    }
+
+    /// Returns the wrapped value as the backing type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::Bounded;
+    ///
+    /// let v = Bounded::<u32, 4>::new::<7>();
+    /// assert_eq!(v.get(), 7u32);
+    /// ```
+    pub fn get(self) -> T {
+        *self.deref()
+    }
+
+    /// Increases the number of bits usable for `self`.
+    ///
+    /// This operation cannot fail.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::Bounded;
+    ///
+    /// let v = Bounded::<u32, 4>::new::<7>();
+    /// let larger_v = v.extend::<12>();
+    /// // The contained values are equal even though `larger_v` has a bigger capacity.
+    /// assert_eq!(larger_v, v);
+    /// ```
+    pub const fn extend<const M: u32>(self) -> Bounded<T, M> {
+        const {
+            assert!(
+                M >= N,
+                "Requested number of bits is less than the current representation."
+            );
+        }
+
+        // INVARIANT: the value did fit within `N` bits, so it will all the more fit within
+        // the larger `M` bits.
+        Bounded::__new(self.0)
+    }
+
+    /// Attempts to shrink the number of bits usable for `self`.
+    ///
+    /// Returns [`None`] if the value of `self` cannot be represented within `M` bits.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::Bounded;
+    ///
+    /// let v = Bounded::<u32, 12>::new::<7>();
+    ///
+    /// // `7` can be represented using 3 unsigned bits...
+    /// let smaller_v = v.try_shrink::<3>();
+    /// assert_eq!(smaller_v.as_deref().copied(), Some(7));
+    ///
+    /// // ... but doesn't fit within `2` bits.
+    /// assert_eq!(v.try_shrink::<2>(), None);
+    /// ```
+    pub fn try_shrink<const M: u32>(self) -> Option<Bounded<T, M>> {
+        Bounded::<T, M>::try_new(self.get())
+    }
+
+    /// Casts `self` into a [`Bounded`] backed by a different storage type, but using the same
+    /// number of valid bits.
+    ///
+    /// Both `T` and `U` must be of same signedness, and `U` must be at least as large as
+    /// `N` bits, or a build error will occur.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::Bounded;
+    ///
+    /// let v = Bounded::<u32, 12>::new::<127>();
+    ///
+    /// let u16_v: Bounded<u16, 12> = v.cast();
+    /// assert_eq!(u16_v.get(), 127);
+    ///
+    /// // This won't build: a `u8` is smaller than the required 12 bits.
+    /// // let _: Bounded<u8, 12> = v.cast();
+    /// ```
+    pub fn cast<U>(self) -> Bounded<U, N>
+    where
+        U: TryFrom<T> + Integer,
+        T: Integer,
+        U: Integer<Signedness = T::Signedness>,
+    {
+        // SAFETY: the converted value is represented using `N` bits, `U` can contain `N` bits, and
+        // `U` and `T` have the same sign, hence this conversion cannot fail.
+        let value = unsafe { U::try_from(self.get()).unwrap_unchecked() };
+
+        // INVARIANT: although the backing type has changed, the value is still represented within
+        // `N` bits, and with the same signedness.
+        Bounded::__new(value)
+    }
+}
+
+impl<T, const N: u32> Deref for Bounded<T, N>
+where
+    T: Integer,
+{
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // Enforce the invariant to inform the compiler of the bounds of the value.
+        if !fits_within(self.0, N) {
+            // SAFETY: Per the `Bounded` invariants, `fits_within` can never return `false` on the
+            // value of a valid instance
+            unsafe { core::hint::unreachable_unchecked() }
+        }
+
+        &self.0
+    }
+}
+
+/// Trait similar to [`TryInto`] but for [`Bounded`], to avoid conflicting implementations.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::{Bounded, TryIntoBounded};
+///
+/// // Succeeds because `128` fits into 8 bits.
+/// let v: Option<Bounded<u16, 8>> = 128u32.try_into_bitint();
+/// assert_eq!(v.as_deref().copied(), Some(128));
+///
+/// // Fails because `128` doesn't fits into 6 bits.
+/// let v: Option<Bounded<u16, 6>> = 128u32.try_into_bitint();
+/// assert_eq!(v, None);
+/// ```
+pub trait TryIntoBounded<T: Integer, const N: u32> {
+    /// Attempts to convert `self` into a [`Bounded`] using `N` bits.
+    ///
+    /// Returns `None` if `self` does not fit into the target type.
+    fn try_into_bitint(self) -> Option<Bounded<T, N>>;
+}
+
+/// Any integer value can be attempted to be converted into a [`Bounded`] of any size.
+impl<T, U, const N: u32> TryIntoBounded<T, N> for U
+where
+    T: Integer,
+    U: TryInto<T>,
+{
+    fn try_into_bitint(self) -> Option<Bounded<T, N>> {
+        self.try_into().ok().and_then(Bounded::try_new)
+    }
+}
+
+// Comparisons between `Bounded`s.
+
+impl<T, U, const N: u32, const M: u32> PartialEq<Bounded<U, M>> for Bounded<T, N>
+where
+    T: Integer,
+    U: Integer,
+    T: PartialEq<U>,
+{
+    fn eq(&self, other: &Bounded<U, M>) -> bool {
+        self.get() == other.get()
+    }
+}
+
+impl<T, const N: u32> Eq for Bounded<T, N> where T: Integer {}
+
+impl<T, U, const N: u32, const M: u32> PartialOrd<Bounded<U, M>> for Bounded<T, N>
+where
+    T: Integer,
+    U: Integer,
+    T: PartialOrd<U>,
+{
+    fn partial_cmp(&self, other: &Bounded<U, M>) -> Option<cmp::Ordering> {
+        self.get().partial_cmp(&other.get())
+    }
+}
+
+impl<T, const N: u32> Ord for Bounded<T, N>
+where
+    T: Integer,
+    T: Ord,
+{
+    fn cmp(&self, other: &Self) -> cmp::Ordering {
+        self.get().cmp(&other.get())
+    }
+}
+
+// Comparisons between a `Bounded` and its backing type.
+
+impl<T, const N: u32> PartialEq<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: PartialEq,
+{
+    fn eq(&self, other: &T) -> bool {
+        self.get() == *other
+    }
+}
+
+impl<T, const N: u32> PartialOrd<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: PartialOrd,
+{
+    fn partial_cmp(&self, other: &T) -> Option<cmp::Ordering> {
+        self.get().partial_cmp(other)
+    }
+}
+
+// Implementations of `core::ops` for two `Bounded` with the same backing type.
+
+impl<T, const N: u32, const M: u32> ops::Add<Bounded<T, M>> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Add<Output = T>,
+{
+    type Output = T;
+
+    fn add(self, rhs: Bounded<T, M>) -> Self::Output {
+        self.get() + rhs.get()
+    }
+}
+
+impl<T, const N: u32, const M: u32> ops::BitAnd<Bounded<T, M>> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::BitAnd<Output = T>,
+{
+    type Output = T;
+
+    fn bitand(self, rhs: Bounded<T, M>) -> Self::Output {
+        self.get() & rhs.get()
+    }
+}
+
+impl<T, const N: u32, const M: u32> ops::BitOr<Bounded<T, M>> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::BitOr<Output = T>,
+{
+    type Output = T;
+
+    fn bitor(self, rhs: Bounded<T, M>) -> Self::Output {
+        self.get() | rhs.get()
+    }
+}
+
+impl<T, const N: u32, const M: u32> ops::BitXor<Bounded<T, M>> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::BitXor<Output = T>,
+{
+    type Output = T;
+
+    fn bitxor(self, rhs: Bounded<T, M>) -> Self::Output {
+        self.get() ^ rhs.get()
+    }
+}
+
+impl<T, const N: u32, const M: u32> ops::Div<Bounded<T, M>> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Div<Output = T>,
+{
+    type Output = T;
+
+    fn div(self, rhs: Bounded<T, M>) -> Self::Output {
+        self.get() / rhs.get()
+    }
+}
+
+impl<T, const N: u32, const M: u32> ops::Mul<Bounded<T, M>> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Mul<Output = T>,
+{
+    type Output = T;
+
+    fn mul(self, rhs: Bounded<T, M>) -> Self::Output {
+        self.get() * rhs.get()
+    }
+}
+
+impl<T, const N: u32, const M: u32> ops::Rem<Bounded<T, M>> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Rem<Output = T>,
+{
+    type Output = T;
+
+    fn rem(self, rhs: Bounded<T, M>) -> Self::Output {
+        self.get() % rhs.get()
+    }
+}
+
+impl<T, const N: u32, const M: u32> ops::Sub<Bounded<T, M>> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Sub<Output = T>,
+{
+    type Output = T;
+
+    fn sub(self, rhs: Bounded<T, M>) -> Self::Output {
+        self.get() - rhs.get()
+    }
+}
+
+// Implementations of `core::ops` between a `Bounded` and its backing type.
+
+impl<T, const N: u32> ops::Add<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Add<Output = T>,
+{
+    type Output = T;
+
+    fn add(self, rhs: T) -> Self::Output {
+        self.get() + rhs
+    }
+}
+
+impl<T, const N: u32> ops::BitAnd<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::BitAnd<Output = T>,
+{
+    type Output = T;
+
+    fn bitand(self, rhs: T) -> Self::Output {
+        self.get() & rhs
+    }
+}
+
+impl<T, const N: u32> ops::BitOr<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::BitOr<Output = T>,
+{
+    type Output = T;
+
+    fn bitor(self, rhs: T) -> Self::Output {
+        self.get() | rhs
+    }
+}
+
+impl<T, const N: u32> ops::BitXor<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::BitXor<Output = T>,
+{
+    type Output = T;
+
+    fn bitxor(self, rhs: T) -> Self::Output {
+        self.get() ^ rhs
+    }
+}
+
+impl<T, const N: u32> ops::Div<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Div<Output = T>,
+{
+    type Output = T;
+
+    fn div(self, rhs: T) -> Self::Output {
+        self.get() / rhs
+    }
+}
+
+impl<T, const N: u32> ops::Mul<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Mul<Output = T>,
+{
+    type Output = T;
+
+    fn mul(self, rhs: T) -> Self::Output {
+        self.get() * rhs
+    }
+}
+
+impl<T, const N: u32> ops::Neg for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Neg<Output = T>,
+{
+    type Output = T;
+
+    fn neg(self) -> Self::Output {
+        -self.get()
+    }
+}
+
+impl<T, const N: u32> ops::Not for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Not<Output = T>,
+{
+    type Output = T;
+
+    fn not(self) -> Self::Output {
+        !self.get()
+    }
+}
+
+impl<T, const N: u32> ops::Rem<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Rem<Output = T>,
+{
+    type Output = T;
+
+    fn rem(self, rhs: T) -> Self::Output {
+        self.get() % rhs
+    }
+}
+
+impl<T, const N: u32> ops::Sub<T> for Bounded<T, N>
+where
+    T: Integer,
+    T: ops::Sub<Output = T>,
+{
+    type Output = T;
+
+    fn sub(self, rhs: T) -> Self::Output {
+        self.get() - rhs
+    }
+}
+
+// Proxy implementations of `core::fmt`.
+
+impl<T, const N: u32> fmt::Display for Bounded<T, N>
+where
+    T: Integer,
+    T: fmt::Display,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const N: u32> fmt::Binary for Bounded<T, N>
+where
+    T: Integer,
+    T: fmt::Binary,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const N: u32> fmt::LowerExp for Bounded<T, N>
+where
+    T: Integer,
+    T: fmt::LowerExp,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const N: u32> fmt::LowerHex for Bounded<T, N>
+where
+    T: Integer,
+    T: fmt::LowerHex,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const N: u32> fmt::Octal for Bounded<T, N>
+where
+    T: Integer,
+    T: fmt::Octal,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const N: u32> fmt::UpperExp for Bounded<T, N>
+where
+    T: Integer,
+    T: fmt::UpperExp,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const N: u32> fmt::UpperHex for Bounded<T, N>
+where
+    T: Integer,
+    T: fmt::UpperHex,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+/// Implements `$trait` for all [`Bounded`] types represented using `$num_bits`.
+///
+/// This is used to declare size properties as traits that we can constrain against in impl blocks.
+macro_rules! impl_size_rule {
+    ($trait:ty, $($num_bits:literal)*) => {
+        $(
+        impl<T> $trait for Bounded<T, $num_bits> where T: Integer {}
+        )*
+    };
+}
+
+/// Local trait expressing the fact that a given [`Bounded`] has at least `N` bits used for value
+/// representation.
+trait AtLeastXBits<const N: usize> {}
+
+/// Implementations for infallibly converting a primitive type into a [`Bounded`] that can contain
+/// it.
+///
+/// Put into their own module for readability, and to avoid cluttering the rustdoc of the parent
+/// module.
+mod atleast_impls {
+    use super::*;
+
+    // Number of bits at least as large as 64.
+    impl_size_rule!(AtLeastXBits<64>, 64);
+
+    // Anything 64 bits or more is also larger than 32.
+    impl<T> AtLeastXBits<32> for T where T: AtLeastXBits<64> {}
+    // Other numbers of bits at least as large as 32.
+    impl_size_rule!(AtLeastXBits<32>,
+        32 33 34 35 36 37 38 39
+        40 41 42 43 44 45 46 47
+        48 49 50 51 52 53 54 55
+        56 57 58 59 60 61 62 63
+    );
+
+    // Anything 32 bits or more is also larger than 16.
+    impl<T> AtLeastXBits<16> for T where T: AtLeastXBits<32> {}
+    // Other numbers of bits at least as large as 16.
+    impl_size_rule!(AtLeastXBits<16>,
+        16 17 18 19 20 21 22 23
+        24 25 26 27 28 29 30 31
+    );
+
+    // Anything 16 bits or more is also larger than 8.
+    impl<T> AtLeastXBits<8> for T where T: AtLeastXBits<16> {}
+    // Other numbers of bits at least as large as 8.
+    impl_size_rule!(AtLeastXBits<8>, 8 9 10 11 12 13 14 15);
+}
+
+/// Generates `From` implementations from a primitive type into a [`Bounded`] with
+/// enough bits to store any value of that type.
+///
+/// Note: The only reason for having this macro is that if we pass `$type` as a generic
+/// parameter, we cannot use it in the const context of [`AtLeastXBits`]'s generic parameter. This
+/// can be fixed once the `generic_const_exprs` feature is usable, and this macro replaced by a
+/// regular `impl` block.
+macro_rules! impl_from_primitive {
+    ($($type:ty)*) => {
+        $(
+        #[doc = ::core::concat!(
+            "Conversion from a [`",
+            ::core::stringify!($type),
+            "`] into a [`Bounded`] of same signedness with enough bits to store it.")]
+        impl<T, const N: u32> From<$type> for Bounded<T, N>
+        where
+            $type: Integer,
+            T: Integer<Signedness = <$type as Integer>::Signedness> + From<$type>,
+            Self: AtLeastXBits<{ <$type as Integer>::BITS as usize }>,
+        {
+            fn from(value: $type) -> Self {
+                // INVARIANT: The trait bound on `Self` guarantees that `N` bits is
+                // enough to hold any value of the source type.
+                Self::__new(T::from(value))
+            }
+        }
+        )*
+    }
+}
+
+impl_from_primitive!(
+    u8 u16 u32 u64 usize
+    i8 i16 i32 i64 isize
+);
+
+/// Local trait expressing the fact that a given [`Bounded`] fits into a primitive type of `N` bits,
+/// provided they have the same signedness.
+trait FitsInXBits<const N: usize> {}
+
+/// Implementations for infallibly converting a [`Bounded`] into a primitive type that can contain
+/// it.
+///
+/// Put into their own module for readability, and to avoid cluttering the rustdoc of the parent
+/// module.
+mod fits_impls {
+    use super::*;
+
+    // Number of bits that fit into a 8-bits primitive.
+    impl_size_rule!(FitsInXBits<8>, 1 2 3 4 5 6 7 8);
+
+    // Anything that fits into 8 bits also fits into 16.
+    impl<T> FitsInXBits<16> for T where T: FitsInXBits<8> {}
+    // Other number of bits that fit into a 16-bits primitive.
+    impl_size_rule!(FitsInXBits<16>, 9 10 11 12 13 14 15 16);
+
+    // Anything that fits into 16 bits also fits into 32.
+    impl<T> FitsInXBits<32> for T where T: FitsInXBits<16> {}
+    // Other number of bits that fit into a 32-bits primitive.
+    impl_size_rule!(FitsInXBits<32>,
+        17 18 19 20 21 22 23 24
+        25 26 27 28 29 30 31 32
+    );
+
+    // Anything that fits into 32 bits also fits into 64.
+    impl<T> FitsInXBits<64> for T where T: FitsInXBits<32> {}
+    // Other number of bits that fit into a 64-bits primitive.
+    impl_size_rule!(FitsInXBits<64>,
+        33 34 35 36 37 38 39 40
+        41 42 43 44 45 46 47 48
+        49 50 51 52 53 54 55 56
+        57 58 59 60 61 62 63 64
+    );
+}
+
+/// Generates [`From`] implementations from a [`Bounded`] into a primitive type that is
+/// guaranteed to contain it.
+///
+/// Note: The only reason for having this macro is that if we pass `$type` as a generic
+/// parameter, we cannot use it in the const context of `AtLeastXBits`'s generic parameter. This
+/// can be fixed once the `generic_const_exprs` feature is usable, and this macro replaced by a
+/// regular `impl` block.
+macro_rules! impl_into_primitive {
+    ($($type:ty)*) => {
+        $(
+        #[doc = ::core::concat!(
+            "Conversion from a [`Bounded`] with no more bits than a [`",
+            ::core::stringify!($type),
+            "`] and of same signedness into [`",
+            ::core::stringify!($type),
+            "`]")]
+        impl<T, const N: u32> From<Bounded<T, N>> for $type
+        where
+            $type: Integer + TryFrom<T>,
+            T: Integer<Signedness = <$type as Integer>::Signedness>,
+            Bounded<T, N>: FitsInXBits<{ <$type as Integer>::BITS as usize }>,
+        {
+            fn from(value: Bounded<T, N>) -> $type {
+                // SAFETY: The trait bound on `Bounded` ensures that any value it holds (which
+                // is constrained to `N` bits) can fit into the destination type, so this
+                // conversion cannot fail.
+                unsafe { <$type>::try_from(value.get()).unwrap_unchecked() }
+            }
+        }
+        )*
+    }
+}
+
+impl_into_primitive!(
+    u8 u16 u32 u64 usize
+    i8 i16 i32 i64 isize
+);
+
+// Single-bit `Bounded`s can be converted from/to a boolean.
+
+impl<T> From<Bounded<T, 1>> for bool
+where
+    T: Integer + Zeroable,
+{
+    fn from(value: Bounded<T, 1>) -> Self {
+        value.get() != Zeroable::zeroed()
+    }
+}
+
+impl<T, const N: u32> From<bool> for Bounded<T, N>
+where
+    T: Integer + From<bool>,
+{
+    fn from(value: bool) -> Self {
+        // INVARIANT: a boolean can be represented using a single bit, and thus fits within any
+        // integer type for any `N` > 0.
+        Self::__new(T::from(value))
+    }
+}

-- 
2.51.2


