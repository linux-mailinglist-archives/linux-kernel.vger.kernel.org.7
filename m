Return-Path: <linux-kernel+bounces-762850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60450B20B81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B0E3AA35F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714725178F;
	Mon, 11 Aug 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y7PsbcSP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WBlWmd+T"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB23246772
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921457; cv=fail; b=hKShs55CQWYa5utEiIba1tBEWVUDejM4xYiagDIk6SFK6e2/iDAuOGp3rIljd+PoXbg66Gezi9xXpDJwrdCaAedTbqOrXLin3h44wgiRQkYkBeVNzCfmHVTRximHe33xIlFxGXx1djozqANGwbeycCcEycRQ6Yq+v00Bu2JccTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921457; c=relaxed/simple;
	bh=NferS8E36ja0Tp6d5jejsF50u5W5brziF63bNhSh2AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtFKjP4NB3im9JGc1xDvuiFWexH7TNjikzR+b3jtlgYNdElb3h0Q0M5N71S+l+Ah3sluV3PMojf87t6UC0jE+t8X6abovDHpRODtiHgFuBjSG31gamHcAgDPr6VVjs/VeMDZ/G2LCP6Y6bAvfngclV546gb4b9mykdjWe0mlUq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y7PsbcSP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WBlWmd+T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDMuw4024825;
	Mon, 11 Aug 2025 14:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=z0OD7W/9kZjADuQGds
	gmGIZUfCrUYlV1j31+kJoLTGo=; b=Y7PsbcSPQsL4lqse9FfNLCY/AsHoOIXXVZ
	HOv0tFjmag8249N2QWBckkg6j9rjARQhdthY1E7Es3uHIfKTOqupISTn0XOSgIgz
	vZrgdKPDJ29s3cq+Y92fpD5MKDUWr5LD0wE8O8E+NqtZJAbNk3AUDaf87gHMJrRH
	Xi7J6qpGpiwSoMmbbI/PSOzSKuB77hwmuqGrqKCvPlmLU8XKLAV72TP1Q/5sBi3B
	DxhHKcBREyEqjJtnXqBDl7hGeEV/ctA7YnP/cmwNOLjw0qUfeu24jaWQfvRcpOmd
	0Y5mDcUUTKxoy3nQ0+3xLR7cLx7atJkJTaenurXvD49RvgQTZvyw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv2nfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:10:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDrBEO010436;
	Mon, 11 Aug 2025 14:10:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvseyh6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfpJIZZEoYfoJvVZ04uMeB+MKB+GibDbiMManROmAq0/gus2fPl43FSb9LwYpFkwvk/ClAmajvufioBbGnENpU3kdBEoMd9f/7uIMKpERTDgBo3e48EJlFIIrx7fUssoSZVGKu09IWwIaEK78Ef1HROfu2+YZKX5cEYmddN4aWkq9AeX+Ct7xTHooNLbE/SkepZjeHZAuuDEWmFvJrpzcZW3QqtJH/2qO8RDjMMH35z7QbVvr+WnQKw0qAdZD2c18dP5v0++whPico9mWpmqvvYM1Daaacy183FsOpqEXFJ9upLakQUkQ9wGHMDcKrqWmJ0gZTbsV+fiFz6EQNPoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0OD7W/9kZjADuQGdsgmGIZUfCrUYlV1j31+kJoLTGo=;
 b=BpoCJMLMUmxPKCcTzGzOkf3vVOf2L0HieTH8CzQUdqu/9dwzJ6Uka1fyagURzQyZoM4lSAzq42sA8BuFg83a0LCrhc6CDfjS7ToM8HJbBZjrsPDaw/rfHvYaQ/oOgUsqH2yp3Us6b7s9XNnjmEi/PEGz0sjt47WfRX9A8JIQlqNG5yf4OnrVQ8KSg2lQdruevJPJ7q43WPx1dOHNXZABCgDBLWghfGc/vH8cAe6XNMa4i35TYy6qxUR3kmpxioO7ooQckYAY7qxSUXFUkdt9Tv4yqNIE+rZT3eEWCwilvRqAcM8lPB/gVQVt/UvJFgZOKJnfeWL9gJWaS/G5TMYGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0OD7W/9kZjADuQGdsgmGIZUfCrUYlV1j31+kJoLTGo=;
 b=WBlWmd+TVLQg3yPM52xB87QgfRrAhn4f2XF0oVq3yqYhHTIqNMd/8MztV6qbSd0ISzjW733+DExk3VW7iuTy7h5j6izS+mQCzOzMXVCuCSQ23BapmLrsNktD9M3shv5znMSNtegnYCRcESF3CA8abYpb5nkXgEQ0VivrCN/v3L8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF3367D7B9B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 14:10:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:10:40 +0000
Date: Mon, 11 Aug 2025 15:10:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 5/6] perf/core: Split the ringbuffer mmap() and
 allocation code out
Message-ID: <cf3021f1-b4a4-4969-87c1-cf2580d58b33@lucifer.local>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.729827000@linutronix.de>
 <bbf55749-3fba-47b6-8151-39e66fec8950@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf55749-3fba-47b6-8151-39e66fec8950@lucifer.local>
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF3367D7B9B:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e2caf5-4cb4-459c-4c53-08ddd8e0da47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2nXc6OG6cUkMjluVD8vprsMwpaSBG3P8jUkiVj3LDvqzKb99aSBlxOwKuCOJ?=
 =?us-ascii?Q?xcc1E2lvgMHz/eLtEqFt/+zT/f/eBv08iP3li7CS9I4okEZlzG63oBn6QIp6?=
 =?us-ascii?Q?BAmSGBarbFi23Ome4mr/4HmysEW21ZQWpLXhhIT6qLWBch3uRJHj0hPvNxPC?=
 =?us-ascii?Q?kI9ew8KFGHFzBJZredPYowC4tFWQg2oavBk2NRw7kL3E/xdWOnUSsSPKdHvZ?=
 =?us-ascii?Q?SZMdLIyPyETvALHQRw4ctRFbT9qEYqSH7jB6Srp23qxkH55DKU2C0THU08z4?=
 =?us-ascii?Q?+BebVhkVGSibb1r69R4J/yTqSqRp/fTHHZPC4QPWNzaVw2WR0s86Gujm3/gq?=
 =?us-ascii?Q?2X+y3iVar+voSYn72c9STfDmtDcMaOoJLaLoI7wvwjOgZu/QD2LMNpxUSxi+?=
 =?us-ascii?Q?FQXqftlpgLIqfbsCuIOPL61AF06+vRV3t9qp65gzhFzK1EqsbaNeOQYFSeGw?=
 =?us-ascii?Q?Lmu6RSnhUAInfEBS+NW3IZgPy1bHUQtXqDL3bH6RIgcPGzPzgT0vT628Ryef?=
 =?us-ascii?Q?2tMzpMnwdWNwXB2MxjzremQmMDGeYoJ9Bt2T6PzcbLBzZMfFyaabSBxwkxVT?=
 =?us-ascii?Q?D+mccxl43S8jcusIxqmKqyq2ORNVDakR3UQKt7/buam7MsgoG9Bb4f6WjJWG?=
 =?us-ascii?Q?OA0dzps/tH1G42V6rIXOW1bxD9pFU2SL2tPXk5ooQg7dkIZLqRqBO8clJoX+?=
 =?us-ascii?Q?S0goPLs6F04dtTzknbVv9HOrWrarbUleQVFtgYUJZcUKTrgw9beBV3PEm2Xe?=
 =?us-ascii?Q?XGxThL/hwJLe2JxXW2wWmPQFQ8Ypp67/WDwQUO+whHN9ucb3iv7wrNR377s+?=
 =?us-ascii?Q?pWX7ayE/K+oaIBC5o+W71NnKEjSaU5VCSIcB8LOtgx5/y0EOpPfY1w/M4ACo?=
 =?us-ascii?Q?kAicTKIc16ph/w3ltELdhDVBz6RNrM/TGLZnC6fDfLri/e9vu6EjoyEChkHn?=
 =?us-ascii?Q?jlRZswlOYaIJqDo4Hb3BC+1KdfWklbzgkjnfZCXSXNZQSEDnrHyJ8VrPg7af?=
 =?us-ascii?Q?MK8NVEOn04JcQ7kIC4gsYJasqGwIaMh0Cetn2wGGjRP5zas1x6xlJuH1WuGn?=
 =?us-ascii?Q?bamXi2pUgfYVw+5CWwb38Mppdsl7LuIlq3oP5eKmR+QmikmGmjr5zrJtBbva?=
 =?us-ascii?Q?wXRrFXruG2vRefHFbLd6X4SM12CB4slOWf/m4LUiuGmq4rPfTkRnReGksxPi?=
 =?us-ascii?Q?CloXjhZTnNO5tCEisLAOHPYIqUaexAomFjKHoPL5n9McSb9U1xu44up5AL8Q?=
 =?us-ascii?Q?DGhpHwBQlW3r+GiVSeK+NLyxvp0o00XdECMWv0f3cHnM1cpYxzEPmc4AbHdo?=
 =?us-ascii?Q?M8pK2U9gQBxz3N3lzEKoC1CqJRhUlig2q9UD0+j2NUnsmxFaQY5AVald+6uN?=
 =?us-ascii?Q?/r47JfP0TCUkq35XNsx9q4kw8uwlmiTRL3R4ACmhkd46QraRkJrNuUk5cfkY?=
 =?us-ascii?Q?2q270zfu7U8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBZuX+2lpaBywMN9UmBQry+0sWrrVySONFmB2vYC62YTVUuJvmJSmGx78Ahd?=
 =?us-ascii?Q?+P5/K7Wa2c6UVumuDc6/3MY1jwFou6zS18bI1BAkDNfHmMAW+64hWOUTDD/k?=
 =?us-ascii?Q?WzNw/ysLVZ7aDgkL2Cq3BJ1P6xOkscFFaDDyMGgi8JUo0V2UQQ3QmrumOk8j?=
 =?us-ascii?Q?CHacMSEHOTIfQNAT6KriqIg3oXx2Gy7KCDMqeSTvlbEpl/lv4cqfmzZBeF5l?=
 =?us-ascii?Q?kZtO+FWRafX+2/a9JgRSU7z0ng+F/ZiIDHTJ0WKs5zUVv4d7j0ddN88eMH1h?=
 =?us-ascii?Q?wUHhZkvvqVpEqB8SGieW4PDkS517Re+RQe5lrAtKIGWCS5qIeERySes4WCo+?=
 =?us-ascii?Q?uP9yZkiRLcb6HlmrV163wk1qEtW7y1YOG0lyrdMmyjfhFDkg+4iy3d8j502t?=
 =?us-ascii?Q?G1GeY41+i6eQU50AXusHRjSkIW6GST8uNBOF1zKi+tciui0p3BYIsRaEed4i?=
 =?us-ascii?Q?ZWwpdXv+QuNyk5PW6HUwDTEANXOzR7PzLohVXGJ1+8LIyD0Duzz53L6AcfmG?=
 =?us-ascii?Q?qqphMcKu/NFkbUpaUEn8qaWWxXi1DunooFfP7pnXBead0OROjMj39NPtV8NP?=
 =?us-ascii?Q?RiXdEW5GPTO3LVC5rz1UBOz1TBVcBJo6e+D5BBplUMxLzaW0NSQw/1//qL3V?=
 =?us-ascii?Q?v0EGpjaqkrkrR2+4UChEj53KyV1yxj8x+cA8jL3HDXHGRe26ER3cK1PP31sk?=
 =?us-ascii?Q?40j5/uL1/QEA9hFEqszq6CE18qWD21OkrhvRX8S7F7lJuZHYnczDNA3rkTBV?=
 =?us-ascii?Q?WepJWt5B8cCDViwEeZg96wf1JXTIE5P65Iy4QivT2UUYBNIO++0JljeXVm9q?=
 =?us-ascii?Q?q1gctu24Ad3QE+WRLxCM3+7oaRdFxLW4TWz7Cu0+j+rHk7waJlRfuPvnzuvv?=
 =?us-ascii?Q?YblP/DCOJ03de9v+zcdbsCcki/8CAc9mNBPU25kaKij48wLNv8cQ5NUwFOdO?=
 =?us-ascii?Q?Km10Xa3G0RIfSUS3WKIs8VY92814X5mSOAatsZJM/19fc4Ozu+U+9fxwBRYy?=
 =?us-ascii?Q?zzOGL1dhnji6GyCE3okYOhGVGDjAkwS+lA7Wq1/vvypDtxiSRVMO1ifM6ydX?=
 =?us-ascii?Q?OBe05PZscasET/U1F7g5SU5vMijj+EL6g3PtVxhJ8lGw3dzf8NOFMDhpuB9b?=
 =?us-ascii?Q?Id8RGCry2/HSeb3xZyBDO/pSVikUtcKMHzy9Hj6kMtw2uLeUUS7shSmBuF3/?=
 =?us-ascii?Q?8a7pJBxXR3UQTa2NFoWig/YFyI3ky88jkeOoljR+uczc0nh3mW2qE/NtVtuf?=
 =?us-ascii?Q?ZQsE7voCi9ZF3HY3JF16zTEjq30SepOXiUhKExQ8PwVYjoTlcN6CGirOf9yi?=
 =?us-ascii?Q?IM1kzWM9HtHG6AQ/BxZUOZMxcQY5nUKqMpB5w1ZTvem7wtwA6Mkr2etw6ham?=
 =?us-ascii?Q?hKEi+x4/hCiifBwSL5cQPP8KqB05TEENC1OQjQtw8tqpWautaGHdYHxTDnaK?=
 =?us-ascii?Q?+QX9VHxV0HD7AWMnagT6lGu4WlEHSyt7jkE98pN/vgrfHI3mP1WXZMIPrwId?=
 =?us-ascii?Q?6PmmkAzDjoboDajjl6LxYHHhUKms6vHdl2/oOJKpcVxUqq65J7jBXaNnlUrb?=
 =?us-ascii?Q?NaELuM5wEnv6pEUs0uupjX1LktdcqmI+VjwWESoaLMo752MjmeWx1JkStmvc?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5jIzZZ4bFKNLEyd7BXYyyNeyzgLvm4Q4rhl/7zLwMEa0CiNOiVnO8rb7OJ7NoYQ3Yv0F90pBmOrLJNByWTLe0RN3AXLzb+MbkOgr3IV7I4TFrDOHPOZLc4BG9xkvaDY7qY9Rv63tOK4BF7nlmdRk9ytuziVIjmGPFnJnTwAceg/NBNGLxGbDzGeKGcbvmeWMOJqpl3/WCi2DrvzciyRvLDFN/bnh+MsDL0GWK48n3syfnMNeOoHAuPE7BToYHAJNNtjWLoOXp0yDTp3JJBTPbcTA8wXwSM6pGsS+SD9PY1QmyZGFUJJH3Y2vI1wtAeDzYjBDJ2xNcuRg7rIHaAU6aQAhA56Wwme/z4vnS1255+bgJyMvG81N6vSLguaoxPndhMeUBRH6c8gGsyCI3gaR2QqDluil4nUKLCffw+Sk6lFjyJD3eOqAuhkIgBVyJJlv6QLB1Ab4KQYyGH5z+SJQtezSaqWCtz0tc+pHQv/joW+XDq+bbYfewfFMLiBfaa0KuEflYQC5c9Z23ZwOMJd+mZbCoTfdP4U0Gf/Q6gRNU6AYJ39JPuyJsfjUMZ6VcZmM1F0IOzzxu9C0AWBzkL4pyHsvIjAnO9m3Ge7OgV9XjBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e2caf5-4cb4-459c-4c53-08ddd8e0da47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:10:40.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzmwNSo+/hYiYAQO6uKQT8T9lV1D/o5Z0hh+/3ofgCle6OUwXLZZg1fa7ye2YefWOMLzWJyQugekQNLwfpm9xptipVagbLqtTxkrV//QtFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3367D7B9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110090
X-Proofpoint-GUID: RTP-7c2y5Y94wY80YWNN_vpeGdOvxVb1
X-Proofpoint-ORIG-GUID: RTP-7c2y5Y94wY80YWNN_vpeGdOvxVb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5MCBTYWx0ZWRfXwP19oGZHRntf
 k6feuc2huNgAvkYC9m93GRXC40dqtEEXbrB6w0nN6rDbjTuppswiIrg3WJXdo+HBkaPm4O9YJxz
 6ocG5uKuWJCG/MrG63gebBGNMulDMxNisnbKdoa0M/DRzZdA9A2l6+2DgdkZxJfuV+5t30P0Z3O
 /IWFOBxBk2bJ1f18RYBDCBHIVUVpd9bdPlfG3BmkBm/M1WvJnQLwrYnSnZr/9AsuuOWydPkx5ke
 7FvxJa9rlJkjrnjeoBqdWMFPe0g4t+FO/+INHHWAJKNLBXtz5Jc+dEYDI1kEnP5MHCHD+2i43u9
 FNxYpSsZBJ/MFnT65K/JPZTO0Tip0o/QVQtL0N+MKj6g/MmK6pkEGH7vh+8XExuQr8pJ+XBIwio
 TecUXdZfyDjYijrCYPBeboGNGnHt0o2MlvpaNIXGiBTYZWpCOCyQldNyd7w/oaZttyX00SD1
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=6899f9e4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JExMh_HkU3N1pC4JphsA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069

> On Mon, Aug 11, 2025 at 02:36:37PM +0200, Thomas Gleixner wrote:
> > ---
> >  kernel/events/core.c |  176 ++++++++++++++++++++++-----------------------------
> >  1 file changed, 78 insertions(+), 98 deletions(-)
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6970,6 +6970,70 @@ static void perf_mmap_account(struct vm_
> >  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
> >  }
> >
> > +static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
> > +			unsigned long nr_pages)
> > +{
> > +	long user_extra = nr_pages, extra = 0;
> > +	struct perf_buffer *rb = event->rb;
> > +	int rb_flags = 0;

...

> > +	perf_mmap_account(vma, user_extra, extra);
> > +	atomic_set(&event->mmap_count, 1);

OK so just one question - here we move from an atomic_inc() below, to an
atomic_set() here, which resolves the issue we saw before with use of
refcounts.

Is it definitely safe to do so and not breaking some expectation that this
might somehow be raced by something?

Thanks!

> > +	return 0;
> > +}
> > +

> >  	/*
> >  	 * Don't allow mmap() of inherited per-task counters. This would
> > @@ -7071,114 +7133,32 @@ static int perf_mmap(struct file *file,
> >  	if (vma_size != PAGE_SIZE * nr_pages)
> >  		return -EINVAL;
> >

...

> > -unlock:
> > -	if (!ret) {
> > -		perf_mmap_account(vma, user_extra, extra);
> > -		atomic_inc(&event->mmap_count);
> >  	}

