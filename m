Return-Path: <linux-kernel+bounces-732115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D91B0624B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF09A5A29A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEA1E9919;
	Tue, 15 Jul 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WbOTSGW5"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4A186294
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591361; cv=fail; b=c6cb6VRfVHjPIDzOIpLRtEL5szOZpivKlAIKtwL8cCb+v1hxPx8bTZsksQgiwgcCerGshaMwkap5E4UIZARecvh/t0CMVRP0MKkTp+BnF/B7JyIXBXh/FH2rpRHrDetFZ2l6gRixewb8Tspj0XgDSbohYgsc1cDIhqRCB4ur9f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591361; c=relaxed/simple;
	bh=+CdbfSAnk1X9IutsUkqJdU7NwF2WZy9BZVi0kKqvZ2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PhrQsNGezwNR/gmEdHsiUEFtJPXuDrPs1p4DN5fg/75PGJKTw4w7FXFO2F/jfGoMUnx6Ft9CqJ0tWXRG4hLYWgU9T8wJbSfRGhhBK/vHx+nDbMp7gWRUMdD5b9OIOBTUDZO2GQ4kHXC+EpO/eI0dh9aaxIHNTZUyBBoEUV6OoDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WbOTSGW5; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FEWAHe009688;
	Tue, 15 Jul 2025 07:55:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jfOZMZbTq0Jm1zSggsD1zjJ6M13DC8wlRbk7d8TkJAw=; b=WbOTSGW5CkQr
	a3i7Tj5sG7yaRm43YeNLAjEGtg9nl0YRGkOuVpfPO0bIqiJhc+8uqZJ2YkUVNF9j
	EshcpRTTIp2JhVvzD3y+BJg1iwBYXPfmZLAGHHBRz7ByN6GTqdVpOc/EGtugEIk3
	yWJUK/xudKNRs1VBnaKyt8FWsmN0BWbwCdDgN94/xu2O/uEIsXekZ8cDvLxb6h/4
	vXFkiPI/efWdkFzSne+qVvQN7oYaQyfRcjd51BoEhqvAA9pJkicvLpfoE+pUSazY
	yQNSg5fZp8fw9NgHJQeoGKMqZfTfV7XQE0hi9qH41RhXVtWK/FQso8xEIKbbHIl2
	Enhn8U7VnQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47wrt8r6k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 07:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb3OY0YdPRTxroATCyldnxHSH5NyZzXz9Uh7WUaJCBvTfhLteTtM24ZEX/SlRTp9qkiLlddDXHfBmNwr6jCTpFyBEWG49ywlUqIObehHvooYpDhCcaQol7DXsvhYHHxeO7XsnIfjWbC4erUdLL6h3ZRt0Od3DEnXFiZfIlxvCJjdl1cutzCk+8yhApyfg76DKUzivICsdEktywagvJ9OgvW5AVrzlStyKUqlnRq/xk0+/aPJFwzKDW52vrVR4O4CMkAIAX6BtiLkVtOXp2cpUb2SZ9vxA8Bqs7Xqz0gwAyGD7wkp2QPS+61DBk+ZScuIp4aI9yzsGuk+9lo9i1t3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfOZMZbTq0Jm1zSggsD1zjJ6M13DC8wlRbk7d8TkJAw=;
 b=ZY3FCmEH60WFzq1qkVvmGOyPaJwbBuD+CwbRW6iYEuQveLCHYt5BtYdIWympqXLa13d8qFT7fJDYJ7kDmSPIDKxudAZ8eQMl5NWaOnammBBjfypD2jHI6ga5tQ1GslhPHEkO51c9PqdiwaiKSMW9GooRazNTm1azOxI07g7IkNV0oFi5D9hwceSmxXo9PdoVw6heRyUXcso7trfOkcSKKHmFl79JdHPUVD5ZXzF+s6tcqUQd+qBsJ408nN7OxCDuzm5FIltDkMSJOq/UWISSZFkPndB9VYNyFp9QSYWzGe4YmAr4cyvl7zMXx/CgFJeRFGvYG4HmYwCXvgjqiWTI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH7PR15MB5317.namprd15.prod.outlook.com (2603:10b6:510:1e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 14:55:25 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35%7]) with mapi id 15.20.8922.025; Tue, 15 Jul 2025
 14:55:25 +0000
Message-ID: <3c67ae44-5244-4341-9edd-04a93b1cb290@meta.com>
Date: Tue, 15 Jul 2025 10:55:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server
 handling
To: Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20250702114924.091581796@infradead.org>
 <20250702121158.465086194@infradead.org>
 <22aju4edxl4hf7tihzl6672cg234eam5kcgazxbf2ga5thsmm6@l2wwkn2wth7r>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <22aju4edxl4hf7tihzl6672cg234eam5kcgazxbf2ga5thsmm6@l2wwkn2wth7r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::22) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH7PR15MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2d35da-475b-4c2f-a95f-08ddc3afa13c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3B4dXdXYnQvZGEwSmhvdGVvWTVYU2U2VWlSTkZyV01IQUp0TnJ2Q2cxTDdv?=
 =?utf-8?B?ZjBvVnVaZW1WMUY1N3YxTEo4ZDcyR2FObDNEUVJKak5zc25HUW1VeFU5REZW?=
 =?utf-8?B?T2RkaG93Z2ljQVRYaHdwZXFocDlzY1RDZzZYOHhZNmJNUnRkY1BKczR4ZEps?=
 =?utf-8?B?K0xQYStNclNZZk1IRFFnd3RRWWV4b3dRUWYzNU5qVVJKZkNXWVZWMk1LMytS?=
 =?utf-8?B?TERxdW5tOEQ0bnh4bVI5VmQ3bFJpL1Uwc05vcU85WFFSQi9pMHBLS1dHMlV1?=
 =?utf-8?B?QTQzeGJDYXg0SWFiSTF0TllZai9KWGZBajNRS3pUaXVyOFl6ZGdxeGUwY2V5?=
 =?utf-8?B?azNHRDJBN0djK3Uzb2VUMURWMjc2emR0bTdWZWR3eW5sK3ljbytZRTFud3lD?=
 =?utf-8?B?bENBd0laMFRXbVIzcUFqRmtOcm5hTUIvbk1TdXpIUFgxeFA4alpoZXRGc1h4?=
 =?utf-8?B?WEY1V1o5Rjdpb3o0VUhvOElNQ2FXc2hBWEtXQnFQRy9sTXhMQmRzL2hMRmxn?=
 =?utf-8?B?L0NpNmhXZUUwZEdRM1RxTHFVN1hJRlhxeHVxRml2Vjk2b003Snllck56NFhT?=
 =?utf-8?B?cUxpMWtOamNMaUVCSVF1QVVScjVpNnM3RWZoang2dU5xdGRZb1pLRDdNMm00?=
 =?utf-8?B?YlpOU2licW1aK2hsbGcxWjVvaytUV2V2SW9nVldmSllpckUwVVhIMGh6Q284?=
 =?utf-8?B?QWx4N1pNYVJhdXd0REpRbEdQMDRqN2xxdTR1cHJUaXc3TVpOYVViMkZJTTZk?=
 =?utf-8?B?TUUzVU5Nck9KTUkvZzZMZTgxeThPaEZZUG5EMzdIcm9pYytzZWt5dUk1YXc1?=
 =?utf-8?B?NEFqdndMZGc3RHpSUk9CZnA3RGhFZDFjTGxkQVJzVUZzdlg4UzB6TWtQLzNU?=
 =?utf-8?B?MnFXUzNhYzkzZ2tKMWVFYnF4OEpTWXBRcm9MTEVXMHR3Y2p3YjhqSEsxa0Rx?=
 =?utf-8?B?UjZPak9FdHpQNlM0NTg3SGh5dTVYYWxZRk5Qb0RjQkJRa3lvVFlMdkZFajhi?=
 =?utf-8?B?Ni9naGR2cFpoUFhDUEJUemh3VU82YitnSDRLZGp5YnpHQngwMHlBbFpMUEZi?=
 =?utf-8?B?c1hKNzlUZU1yT2tKR0RENzd1NzRLaEtEaEpmRDNHaFFPaVRtZnZKd2dMZjFS?=
 =?utf-8?B?SEJNVGl5dHN1ZkJQOWxZc3h5RWFBOE9ncTgvM3czamJDMjNuUkUrcFhFeFE2?=
 =?utf-8?B?Y2JtNEZqWW5TTnRTM29NMHZOa1Q2ck9mTWtQNURMU2VCWHNWeTl3d3g4bUpu?=
 =?utf-8?B?SUFUVXl3cmhuMHdKT01pcXl2b0s5cll5THlZTFpBZHQyUWg5L1NkYnlYYmlN?=
 =?utf-8?B?M0Zab3ZxS05qRVRGQkhveDdYVVBwR00wT1hkVmJtSE9XdWZ1VGV6WUE2OHRp?=
 =?utf-8?B?ZG8wQ0R2aFdIR2VLZmlNV1praUpWaFduMDRYN09kcHozeWVWOEVWRlR2VjBa?=
 =?utf-8?B?bUprR1RpSlV4SEltVlRQM04vaUNkODRkTjUwNTRqV1pmeVM5R2xNcDlNQnk4?=
 =?utf-8?B?SURZazhCTWpwWUJlNXp2dmJXMlBiUVF6WmtwV1Rqc3E0djJUOVNvZ09Tb0xx?=
 =?utf-8?B?Z2xzbTNUNjREUzFPQVhMUzRlbFJDUkV1c200U0svVXJvS1JwcFROWWtzT0V5?=
 =?utf-8?B?Z2JhSFRVdlVUV09rZGFNVEZGTnk2MUNUditIRHRrMGJJRkZLQ2NGWmw0aCtr?=
 =?utf-8?B?T0lQSUphVWZUakVGSnBqRWxOaFVLSjVzTHV0L09ZcXY3MHp3V3JZem1SZ1ZO?=
 =?utf-8?B?dU5RRVJOYkhHZHpwMVBoMkdZM2lmbkFIUFNuMVNqTU1ZRnQrMzJNbDZFOU5I?=
 =?utf-8?B?eDdSOCszaTNINTVTUnVRM3pydHFhWExVQkFnaHI1bWhTTGNrWWF4S0ZpRmky?=
 =?utf-8?B?SHJuQ2dlbmdhKzBhalBFaElRUFc3OUxsU1d1djhKSTFuZUtENWZyYlJ2a3lS?=
 =?utf-8?Q?3ChhsPW6C6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXAvbEtDYTF6bGdlYnh0ZnQyWmxmaWNoc0JCd0FYQmJWUHBCQlBpOW1nSkQv?=
 =?utf-8?B?V21leXNqQkszdzRQbTAwa21qNjU4ZDBOOUE5d0xnYVhIcnI3dmFVejdQa1Jy?=
 =?utf-8?B?OWNObGdjRGZYUUN1dFJaalQzenlCdlZienI2TnRiVytOeW5aN3g1Tktpa0Q4?=
 =?utf-8?B?M3FRR3BwaU03bUR1UEt6Tit0NzB2VDNnUUVpb0JxbDNEMDJvSVBlMU9YTE83?=
 =?utf-8?B?R2RGN0VtU0hiQnpSa1JSeFlQSjRWcDJCUjVJM1Y2V0RJM1dVVHlOVFNVVUk4?=
 =?utf-8?B?R0dTWndqSzJUZjNUNGVRSnlqYTgxeUd3cFpQRnh4S0JPWlh4Q2t3ejd2M0cz?=
 =?utf-8?B?ZDZBQytDS0RTMDVqdXVYaHhySUwvY3VvWDlEc1JkQTNWN1VHVW5WSTRTZVFX?=
 =?utf-8?B?K25aRTI4eTYrVTNmbTlveWQxQUcvZUdHUXg1Z3piZ05GdmhzZU8rcDlSaHlF?=
 =?utf-8?B?WThIQUFxRi9kekVVZ2laZnlHdDJ4UzZDa2dPSHliM2k1bi8wL1FDeDR1VGlL?=
 =?utf-8?B?TmFmRVZtbnRNdnJDMlN6YXRZUGFEMG4wTUIraVBZLzFjSTBXSWV4Q3dFdzJF?=
 =?utf-8?B?blgrYllDWEFCS3J1ejk1b2E5ZE9oajV3ZHh6ZmtsNVdZblptc2NtejVlck5P?=
 =?utf-8?B?Vjd1b1pORi9ydzJPZnFZcjJ6bnRyeEdrdFRXYWlvTVFPdnlzdzNrWGZPN3Zh?=
 =?utf-8?B?WWpETXJoeDVMemhyV3FIbWpnU2htNnhzNHpDdnZNWVJBV2FKTTBiWEZkMnZ4?=
 =?utf-8?B?empjR2Z0aFMxQmFxTVdxU25PYi96WnYxeDFsYTc4YXVIU1RiWXMvVWZMRjk3?=
 =?utf-8?B?czlSZS9oOVZselJFQWNWcVJTWlhzV0Z3UG1sME9MbmQvZ1g0ajFyYmtVMnB5?=
 =?utf-8?B?eGNSRlhtVXB6REdVcDBOTEY3RThiclg5ekE3WTdEQmlDMEl1T3QxeVJQd0wy?=
 =?utf-8?B?YUdGQlhERWc3c0c3d2xFNThUNjFYQ1ozSzYwbUdiUTVseFNoNmY1ZnZaNDcv?=
 =?utf-8?B?SXlzeS84NXJ5UUxKb3hsYVFMZXcwTHVaKytrU0lYUEl2S0F1aDFzdU9uc1Vq?=
 =?utf-8?B?UVhQTWlmUGdCZGdDWnBEVXVjTjUrMWljQzE0bS80VzBqN3NLaU9GUEt5SDdH?=
 =?utf-8?B?SmxSaWJlU09Ybi9WaURFSGR1SXZySGIvcnpEV3V3MEx0MW5ZbVUwVlNCbXU5?=
 =?utf-8?B?MnhxaldZSitDZHIxNGwyd0hqb1RtM2VsNy9VcjJsN3ZxNGp6R3VsVWxGYis2?=
 =?utf-8?B?OEFuN2tIcENJVnhrei80eDUvRXk4VWpRelVOSXRmVjR2OGhpMHBHQ2xEblM3?=
 =?utf-8?B?TFh0Mk9JNjdjQWkvV0tMNGNYU2VrMlkwWDNtWWRpV1lsa3VkSUhzbXBudGYx?=
 =?utf-8?B?WVlNYnNUSW1yT1FCYmFieG5FSFlYT002Zkk2SE1TMk1xN1JWN3JwbHFjZ0Q4?=
 =?utf-8?B?MC8yM29QRmtQMklrNTV2Q2pOQXllcHYxdGdGOWN6S2lPVWpkcjh3TXgwYzdS?=
 =?utf-8?B?Z05vZ0o2WDFFa2wxQllsN0RVbEdScVF6cVNmc0o3L3hEWWFlcTN5WXpIK01L?=
 =?utf-8?B?RmZHSkVhVGgyUENBckl3TW9MOWhmQ2g1a0pENEkxSkFPSVp5dVgyS3NuZU4x?=
 =?utf-8?B?ZmlQbSs5VGREZCt2djc3YzdIMVZqTTUwbDJnUFJGZHVPQmJlcjZSR0RZaW5h?=
 =?utf-8?B?eWdNRm9RS3hiNDZYcVV0QVFOZTc4SFRLNEV1NnRERzV1SXlRaFJSVXBXdEl1?=
 =?utf-8?B?SlBycFhIS2VBU05GZUZYa2Q2bTlmNVh6RFpzUWJCK3plZ2pLenNRNzBnZ3pr?=
 =?utf-8?B?emFDazlwMGc2UUgvOTZ6WEtVcXArVElHVGZtVkxCMnNnTkpYdlRGT09qWCtu?=
 =?utf-8?B?ZTIvbm1jdkRLZFhwMk5oeEY5MUo3M3BqR1dSaUUrQmYyN1pSczhDREFjdmN6?=
 =?utf-8?B?Y1Y5T2Ntak95Wm1Od2t3UnlpcXpxRVRFTkZpamk5R3JMekoyK2k4ZWhkcTlo?=
 =?utf-8?B?ZnMwVWw2RDNRYngzQ0dRRmlNS0hZOUZtUE5sdjdnU1VDTU54U3VXRTBxWTUv?=
 =?utf-8?B?SHFzZUFZOXlDL2lZVUdwMjFUMFhFczh4OVlwSlJFdTlYY245K1V5eGRNRjV1?=
 =?utf-8?Q?eBG0=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2d35da-475b-4c2f-a95f-08ddc3afa13c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:55:24.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffISZDymsceZfz3xxEUYdnx7+WMQ0mu2yAv4m3RJbu6vvxjNJJ3bvps2u9e6oVxq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5317
X-Authority-Analysis: v=2.4 cv=d/T1yQjE c=1 sm=1 tr=0 ts=68766be1 cx=c_pps a=EpvH1avkcIZxQBnqYGWDjg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=NEAV23lmAAAA:8 a=T4TPGNrSxUrRG2IgW-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vOIpcRjlPvsDdUOPmFydgdS0baZK6Btx
X-Proofpoint-ORIG-GUID: vOIpcRjlPvsDdUOPmFydgdS0baZK6Btx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzNiBTYWx0ZWRfXw/GpUryKwVC1 XlMaFOk2aek6nP+cWgB+fB3J+n8QL/Lcm8rBRXXu2pNzWLKvvLNC0aqucY/kWsfrAMxbYP0R/W3 oKll7whG77A58xPG0V8qaCqt1UYEhelvLvFzbYW1nq8Dle12tjW6Io/X8ogGfoHlotXqL9TmoXX
 GBrrRL81z/JRI/mSXm7ry50AxqFYmfqD7SoLs4u10RzJ1r4JVwflaKOxaNsWD77Py2LCWNpYmIs JxyZO+Q0fCVi+7qtkCL4oA7Jg6jbrk9JS1y/6sbLnvgOIyrCmxMYkxLJKgMWQJLqy/o5FQo3Qdb 2OuL1Ve715lu52hclvlB7pt08qBCUya16fhCq9fDiQ9L30+MLCcE2667AH8h50WYlR9kY4l2+Zw
 QbHaGqqvkAs+ZUUJr9NmJZozL/zL8Nr0ilsPOM65nBOCp05J6mIHcExiBLepY2qTyNbEhoTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_01,2025-03-28_01

On 7/14/25 6:56 PM, Mel Gorman wrote:
> On Wed, Jul 02, 2025 at 01:49:26PM +0200, Peter Zijlstra wrote:
>> Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
>> bandwidth control") caused a significant dip in his favourite
>> benchmark of the day. Simply disabling dl_server cured things.
>>
> 
> Unrelated to the patch but I've been doing a bit of arcology recently
> finding the motivation for various decisions and paragraphs like this
> have been painful (most recent was figuring out why a decision was made
> for 2.6.32). If the load was described, can you add a Link: tag?  If the
> workload is proprietary, cannot be described or would be impractical to
> independently created than can that be stated here instead?
> 

Hi Mel,

"benchmark of the day" is pretty accurate, since I usually just bash on
schbench until I see roughly the same problem that I'm debugging from
production.  This time, it was actually a networking benchmark (uperf),
but setup for that is more involved.

This other thread describes the load, with links to schbench and command
line:

https://lore.kernel.org/lkml/20250626144017.1510594-2-clm@fb.com/

The short version:

https://github.com/masoncl/schbench.git
schbench -L -m 4 -M auto -t 256 -n 0 -r 0 -s 0

- 4 CPUs waking up all the other CPUs constantly
  - (pretending to be network irqs)
- 1024 total worker threads spread over the other CPUs
- all the workers immediately going idle after waking
- single socket machine with ~250 cores and HT.

The basic recipe for the regression is as many CPUs as possible going in
and out of idle.

(I know you're really asking for these details in the commit or in the
comments, but hopefully this is useful for Link:'ing)

-chris

