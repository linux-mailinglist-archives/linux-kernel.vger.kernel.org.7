Return-Path: <linux-kernel+bounces-893713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D743C482BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF9154FE1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476A320A0C;
	Mon, 10 Nov 2025 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DsDdMAAG"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020119.outbound.protection.outlook.com [52.101.189.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C131DD99
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792933; cv=fail; b=EupLF1OqX61h/ydreeKwVZuYOn6H8sx4ZYZaLLEna5WJUeUi1mWpeIDMpDpieT06Ix1au/VqHcYktnRgkAroXmqGesif3WtQcffxFBdHtEWf6ZZoOMUpk2PUfqjkarDKgVdRvel/mFnKfRVD6u0pnNK02m0InZLyHqRCFGwRvTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792933; c=relaxed/simple;
	bh=avElWHaRvb9dQZTF3Sj33+D7tf3d6zC/gRoiR94dakI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=knPkiVpq4Ac0PKNO+Ivzbr49REdEr3wZu/as+CjfzqxwAbJnudNxfct3dNcoH5KWDADBhXSZJMcu0g5syxcfOb+Ki1WdITUYVqTN4WT1LkKjxBeN6K8FWQ1TmPtHOhgs8w8Zdmyfl1csdRwZ1RIOmj+GOf/eH35uewb415hS43Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DsDdMAAG; arc=fail smtp.client-ip=52.101.189.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBiJytG5eCF1uwr02w/C2H75exUFOZTkLfJnBp3PbgajBmDFCfCgme1DxV1EHPuWZQNBm8Z27B3XwcmFvZMzgc0QeP7785+ldwd948JdNHMPPHGH/N91DYR/6H6VbcrNknKWWn5/h+M4/sUgqZ0R6D0wdUfsD0TkYzy92N5q+GMC9KMb+WzQir4kuZpCImhnO3BV55+k6yvQaL289+zEsYNQYhcnBWCu1b+E7/GF0NAED5J04YDpoCuHdmB4kbS73stgpf7h752kHx2FCe6vbf8Z27AzUjer259jBnjWAqMbPPyPlpJvDKogrznNRkK5RMSWz4tsqFIyouHMEnfGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZGraXFq5zNZ0obFuZG/RTbGK+ULCLHICDZ6cgJCdLU=;
 b=VYROg25drBd3vd+dmU0WUOtlhukfdQxPq0q79R+sEpGleAHHrAXdMymrSci0QlfgzJ7Oz+6NS5LXcKyFA2Qiur632YUJUHHD9YSZk5Vi3fHysybkX6NR7Pv2F9YAO6j1avFYTHl3WkDhASSb+Aj8ArOTEHHsSBWngpkTP0QtL4u67lscfJBo3ExtmqtM7b5PFeR2RNu+g314ebw0qc1hZdpTgFzPssCnI2SckyU0eXTH9qDADc+y4EUbXeCvh0rCJScHcNVvznTMz3I9I1Mf+AT6DpmIxA/miZCU7P8jEOvb2328vDRdaJlMoYpcCMI8A1FfucQZhOzEZ8uvxCGqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZGraXFq5zNZ0obFuZG/RTbGK+ULCLHICDZ6cgJCdLU=;
 b=DsDdMAAGrMFl+ReYokTUPVFXWcInx6h4ohhJ/Leh8dTXjkS9tuQ+YVWUXUqiiA7shPwThHs5NczYAFPiW6xf9fui0S/a3K5dSTOVYwpe60rVLHKkdFl0tSbeMySKRZejxG76yCX3MME55Mb0HowsD0RV8q/r1JDhNRB+BYCJtv2uuB4dBSltdW3zXQZlmVWvHOMWtB+5tw6PC8k65eOmHRa19VEkpWo/kBKDvOK9sqDSsFsYJltRpMqkfaPE7AiOXj+/o8ua6z10HftSux3QXsLkUVxFd8qyMZqSb7KImGr1Hkw9opVwKqZ6oqJiTN/r8E6z2wJS1lpn69l0ccflNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9287.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:42:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:42:07 +0000
Message-ID: <ef7931be-1f18-44c2-aba3-36c3f0aae388@efficios.com>
Date: Mon, 10 Nov 2025 11:42:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 07/20] cpumask: Introduce cpumask_weighted_or()
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.717519165@linutronix.de>
 <88d397b7-5eeb-41eb-ba44-980e72008fd2@linux.ibm.com> <87qzufw8fc.ffs@tglx>
 <20251110161111.GB278048@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251110161111.GB278048@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0198.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4f815f-2b44-4c46-813b-08de207815d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWllaDZ4MklMYmxxSmhGZERkaGFkQTFiWXo3Z1pvTVdqNmFhdW1xOVM2MkIv?=
 =?utf-8?B?RWhxSzJHaVRSNTFlZTV2eEEreEFVWVpEbUNEY05YRXg4ZHBCdXJSRmcwdVZI?=
 =?utf-8?B?QWRDR04zRjdPZnhwcjhGS0pNTDlxazd4OVYxM2VUNHhCcHRab3ZNWXVIQlVX?=
 =?utf-8?B?ZkFWVDc5VGozaVJFSFVqOEJTZlUyRzUrUGR2ckJWbjFCR2pOcWh3TGhlajg3?=
 =?utf-8?B?czJ3UXovSm15aThiSFJWeFFsY0UrM3hYdnhHMlp0K2lNbVBhNTh2dWg0WlpB?=
 =?utf-8?B?ajRZUmE5Ri9Bam5zR0VhSUdrTkNZWXBrRjJ5OVRqSDNzbGQ1MUd4L2VNRzd0?=
 =?utf-8?B?MHNEZ3ZteFJmaFJTLytlMzlaVk0rcjhpV3ZoM241a1dlcUpRRGxiVTcwZlNU?=
 =?utf-8?B?R213MndQZ1RFL1Fyd2pVYmZjb1RwdndIN2RScVpFZkFFd0FwY3BTU0xOQVFT?=
 =?utf-8?B?QjdkWTZiaE9iRzdHZ0tSbWlGL0VZN2tDaUkwSzJqSGlMN2RBSG5rTHpnVHRa?=
 =?utf-8?B?WFZRZFp5TlN5bEpxU3MyN2NxQldMZ21CbzFQVWxDUnhpRlB0RFhqMFdCZTVm?=
 =?utf-8?B?U0tmNzFQcWpta291dHhHTk5VcUhzdmF1dEt4NXk2cUVZYm0yZXl1NktIWkFk?=
 =?utf-8?B?MEtXRW1oMTdqNGRXSy9HVFdRVU5pTkoyTmc4aEtFMXFlU0NHVDZkZkY0MU0x?=
 =?utf-8?B?S2ozVkozVWdwSGZvd3hUajZTWWJjdWkreVJDZFJxcU9CTFFSU1BFeVVWTlFm?=
 =?utf-8?B?TkpWRWNuMmFsUkcybE5OdjFzU2NZL0pkcU1oWkMyZXVYSkduRG9Lc2JlS0RM?=
 =?utf-8?B?UmYzVlEyeWVMbDZFb3hXQ3l0MTc4QWUwVkdHSStUZkU1SWNyU0RDbXNRcXdn?=
 =?utf-8?B?MG1SMmorWlZIaExNa3hzbXdWeW52UzBTMWUvdGYyeGZhT2pkcTdSYWplYkNy?=
 =?utf-8?B?c1R6VVpDbFkwTVdlbXA3STNxWnRFZ1FDeW9YYjJkNS9JSlpBM0pnWk9mbFp4?=
 =?utf-8?B?Uk1kSk5MYlN3OHlzbTdqMGI5ZVJoVVcxbUVqL3MvVmRTUnFMRnJFbU5hcG1L?=
 =?utf-8?B?T20zY2lJd29SK0NCQk5Ga0xWc2lLUWQrQVJnWXBSL1BaZzVJbFd4Tkx1Slg0?=
 =?utf-8?B?STg1NFl1MG1FSGFyMkRDZW14Ynp0SHVaZUZ2N2F2VVpZZlJQdjd0VWdTT3Yz?=
 =?utf-8?B?RkNGQzd4Q0VyU0FEZXNBNytteDFtSDRQa1FoUUZZbUxUVTEyMy9TMnNKSmI2?=
 =?utf-8?B?S2JGY200Z2Vsenl3dEYwK0FCY0g2cWdHSkxXYzhiRHoycWlGN0hnQlBnM09X?=
 =?utf-8?B?aldDTDFRQ0hCUldIdHdrSkt2UWV2MWJXYUx1T0F0ejljd1RxUjFJamNqbHhr?=
 =?utf-8?B?OXB4OCtjbzFTaW85UDNzWXJtTTkvbnhybEVacHdvdllNSE9HcVhoWHdBak9p?=
 =?utf-8?B?djNjdlFNNm9xYWQyTXRpeUhKL2tQREVXVS9iWW55WUJZdy9mREhqdDYvYUlO?=
 =?utf-8?B?dm1rTnIwT2U0VlBXeGJTV2RlQS9aSUI4VVNTL05ickk4N1NZV1pFTFVBRHds?=
 =?utf-8?B?ejYxM2M2QzNwVXZ2VXQvUnFIdFYwdGRUT0g0aFNRR2l5d3pzejNuNE52czhv?=
 =?utf-8?B?TjA5aENaajlMZ0hsUEVPWnEwamdKeGpBRjN4Um5odGtmTVVRczFlSXhsS3No?=
 =?utf-8?B?dVFoTmdVU3c4ai82U3pCNERyL2hXTERtdHB5R3FjbWw3eE5PMWJPRU9iK1lM?=
 =?utf-8?B?WGE0a1lka1lMOUVZZ2lzbHo2ME5RbGdXa25RTFNJRXFhUFBEdGttWVZNUEov?=
 =?utf-8?B?bmRxeWMyRkJXN1NGWjVxUHg1VTRsQ0hWOXZsYjduOExtNkM2aXg1ZWxVNzA5?=
 =?utf-8?B?eDFIczlrWXZPUGRYNVR2V1BpdVVpMUdTT1pCV2hLcUdGZEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUhxZTZ3aUZDZ3F1djdOLzdDNlFmMlJaTUlvOFRNVGNxOFJmNnhBT0E2RE05?=
 =?utf-8?B?cUpGYW00MDBiNXE4aW9FOHFEU1F5QUxCYTlpQjVucW9naFZKeFQzNmh3WGVh?=
 =?utf-8?B?ZkFEVlVBU3FPV0ozMXh4SUpQdy9PSWpFZVRDemdVYS9JQ2Z3ejhrcFdJOFZo?=
 =?utf-8?B?NVBFSFdnaHlGeW04S3pYc2F2RTVoTWpJOU1leHNsY1cxZDc0YSszbnRFNE1p?=
 =?utf-8?B?UkRVSXJiRFF6Y1dBL200c2ZMYjhaRm1RTlM5TnJvdGVWR2E5eGtaVzgxUmlB?=
 =?utf-8?B?RjI3ZXJEeG42dE1NWXBCczRwc1d6ZjBKcEdvbnVNNys3TUl3RDcyRUR0S2pI?=
 =?utf-8?B?b0JDNEJDZWs3Z0luRlBJVG0xUWZRSzdkUFEwU3habFNCTlppODdYd0VQWjFp?=
 =?utf-8?B?VWVYUW1MTDhNMi9IYUF2MHEyMWViYlVpNlQwVXJadzE3UzZSV1ova2dHOEpH?=
 =?utf-8?B?Sk1SYndGOEtadGFHMW1qR2NXTTZtaDVLRUNnQXZnSmpTMlJ0MWxzdkNiQWRJ?=
 =?utf-8?B?ZjkweGxSNG5aNkxPSGJucjBvTEFEdjlHODVXQnR4TFZ6dkRrQjFob09JTXMv?=
 =?utf-8?B?S2tZUlJ1SmVDODFsYkF2YWE0WkRqcU5BajU3aTMvZmFqNmNzcGN0VWRIQkpx?=
 =?utf-8?B?OWw5UXF4akRMUEJlRytyVDkvckd5ck8yTTBQOGhrQzA0dzB3cHBzYWpZU2hn?=
 =?utf-8?B?cmJUZUhjSW9qamR0NU5HQnluL2dLOEFVTEo4TEt0ajNWbEdVaHhqQmlBeVY1?=
 =?utf-8?B?MGxFV2M5bHlsYlg4eDV1Y1B4NGhJYzB6VXFDaVljdjR5c0cwNzdWR2w5SWVp?=
 =?utf-8?B?OUdLb3c1SWtRd2c0N1EyeTVsWE43V3F6Nzh4VVBsSm0zdGtxMW00eXVKdGQ5?=
 =?utf-8?B?Y0xWbVYrZkRhM0x3cXhHMDc1TTQ3T2JzTW5YVHZoKzhoZ3ByaG9JZkVoQXU5?=
 =?utf-8?B?M3d3VjhMZHQzQkJRUDh1dVRSa1MwMnM0NUV3dFJMZ3pLTFFYWmpyVlluaXVR?=
 =?utf-8?B?ejBKQ2gyMDBwbjVKN0ZEdWl6cE5ieFcwVEJ5eEFJa1Z6NGo4NTVwSWY5U0I2?=
 =?utf-8?B?QW80NXJhbExpeitCdTgvRlR0L0ZvUklvOWJTbk5uL3ZtSVBxZmNEWFkza09M?=
 =?utf-8?B?Vk1JQWhZazJlZlg5UkZ2K05DM2VmZC9sRDhPUzF3dkoreCt6RG4yVXdHQnRP?=
 =?utf-8?B?WHpjQkh3UDJJVDZaamRubGpMYnNMb3orcGNsSXllVVBEQkM2MTgvRUl5RmRS?=
 =?utf-8?B?K2QrL21QdTVvUzJteDRQV1NzbXR6RUlRaVVtSm55ZGRqcVlzOVpDMUNaa3du?=
 =?utf-8?B?RUpkeHNDSm5CL1VrN2NYNjMxYUhVMzNZMjZPNUR5NlJsRm1OaGNZeHd5RWpy?=
 =?utf-8?B?MGFFamowNEZvL0xmMFpQRVBNalF3MitHNy8xbGZLRnFhdFUyY2s5bzlTN3Ar?=
 =?utf-8?B?UVpCZ2l2L3N2eC9IWVlIWUwvWSs5QnVia1Jpa1hjTFdJb3J5RTJ1UFFmSXpa?=
 =?utf-8?B?UnlqV1BPRlR4bnRXVGVCZjR2N1RUdWpzaWJXZnJwTDQ2dG5uWUtLQUZvRnZV?=
 =?utf-8?B?QWcyVEYxMVNQemVZazdRU1BSYldSSkU1YVo5czFyclVXc3pKQytiZUdvbjly?=
 =?utf-8?B?WTJRTmlLbXV3dXlXUFF4RkZpeTgrcXRaM09jTEF4NUhwaE5WSGUxVVE4WDNz?=
 =?utf-8?B?L05vRXg2b1BUb21semtBNldYYUpnd3liOUdrS0VwWmFkdjFJaDZBQVZ2dnND?=
 =?utf-8?B?MG13QUhZaW9aWi9ZOU9DcHNEaVZVcEE4ZDZaWTBFcXdwWWV6Rm9Gc0hPUGxi?=
 =?utf-8?B?TTBkUDIyTjhobWs4ZHpYUGl3SWVoNCtzSUZ3L21GREV6dm1Nci9yY2RwQ0RX?=
 =?utf-8?B?Z0kzZ3NIM1NUS283SU5xVXJLNW9ZNExySlNhMk9JTjlad1R5NEt0bmdTcEhl?=
 =?utf-8?B?S01zK1k5M0t4bkVmcmtLWEFEckxuU09XMHdiQ2M0RXdETEhtYUxuRVM5RDMv?=
 =?utf-8?B?ZjRjSUxlUHRTWEhJVWFqR1pmVU5BeWZrcTNzUStIZzBuaHJoTG9xaDVRMW4z?=
 =?utf-8?B?SFNHRENLVnZGMFg0Y0Z5Tlc3QWlWL3c4eWlDc2pQVnBuNXN6QnFwbXQ5NGZ1?=
 =?utf-8?B?OE52OEg4bDZTeVMzQzJhenVwT09VcTZGYklsSDdiWlNMa0tpYWpjQm8wKzdO?=
 =?utf-8?Q?dNcL3ZxTQFMf3Kxf9YG5UcM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4f815f-2b44-4c46-813b-08de207815d7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:42:07.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /smtZgOryFAVvNfJ5gI8rJYnR4nlRGhQDvHqQSIboSam75BKT1a9+04iY1f/3jt8QyhyMh7Z8AQkzlEWnIw+oV1K4IQKUNH56XHjsy5d7nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9287

On 2025-11-10 11:11, Peter Zijlstra wrote:
> On Mon, Nov 03, 2025 at 02:29:59PM +0100, Thomas Gleixner wrote:
>> On Mon, Nov 03 2025 at 14:45, Shrikanth Hegde wrote:
>>> On 10/29/25 6:39 PM, Thomas Gleixner wrote:
>>>> +static __always_inline
>>>> +unsigned int cpumask_weighted_or(struct cpumask *dstp, const struct cpumask *src1p,
>>>> +				 const struct cpumask *src2p)
>>>> +{
>>>> +	return bitmap_weighted_or(cpumask_bits(dstp), cpumask_bits(src1p),
>>>> +				  cpumask_bits(src2p), small_cpumask_bits);
>>>> +}
>>>
>>> nit:
>>>
>>> We have currently cpumask_weight_and & variants.
>>> Wouldn't it be better to name it cpumask_weight_or ?
>>
>> No. cpumask_weight_and() does weight(mask1 & mask2) but this does
> 
> The comment was about naming, notable: s/_weighted_or/_weight_or/g to
> better match the existing _weight_and().

But if we go for "_weight_or" to match "_weight_and", we end up with
the following different semantics between "or" and "and":

cpumask_weight_and():
     inputs: mask1, mask2
     outputs: none

     return weight(mask1 & mask2);

cpumask_weight_or():
     inputs: mask1, mask2
     outputs: mask3

     mask3 = mask1 | mask2;
     return weight(mask3);

What we are trying to do here is apply a bitwise operation on two
inputs, write the resulting mask into mask3, *and* calculate the weight
as well, which is different from just calculating the weight.

Naming things is hard. I agree that the distinction between "weight" and
"weighted" is subtle.

Perhaps something along the lines of cpumask_eval_weight_or()
which would state the two operations performed (evaluate and calculate
the weight) could work ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

