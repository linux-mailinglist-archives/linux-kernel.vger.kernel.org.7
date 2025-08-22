Return-Path: <linux-kernel+bounces-781719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0419B315E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B59E578B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BEF2F618B;
	Fri, 22 Aug 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dfFB8bLb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r1nBxEJJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1A2C0267
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859859; cv=fail; b=tKtOHVgIz4O1/JBouJZj1cne0mPoNQT9VEU5JVGvp4sp/FrUfjprgx4FBAP4+HBmfW2U2y9E9VbU/qvNGe5O1Nmrngzc06TMJDifS2FeeQM2A14bH84tbfz/JhXiGeVaOahjj+5krWB9SeEVqEWsNVP7NRJPsacvUSjSpqaiKZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859859; c=relaxed/simple;
	bh=6lR1E66e8/oCVloQFKwXPBDXe0iOmsM+/rH5fqtsr1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ax2uct2A/nB94Ngv72eofhvYrSNvzt2GOxcyVNSHv/D6IWa3b/yTUmGmnpRBtKQSPBh3j9uLG3X0W1pRt3RrnVEEUlBsEo/x0NWmKL97w9zTmf+aSQ19hJ9j2t1sjR9Ves6iztI4rHoplSqNhpbFlmiBtqJivucTii8mvNI5zCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dfFB8bLb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r1nBxEJJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MAQuId004381;
	Fri, 22 Aug 2025 10:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6lR1E66e8/oCVloQFK
	wXPBDXe0iOmsM+/rH5fqtsr1I=; b=dfFB8bLbz4Jay4/3F7R0KuQJTBM3doEyvC
	wT89ZFylAhPSmKSHI7yT8Q8ZWamgDJ57KeYmowBZri8uKOAt0bt2CXWtyEFTkTVi
	WyDh3nVduNc/dP2W/OcVByPD5fJik7NvFiCPQpQ89yx84BkpvN57yTd2hbqQvycr
	FiY+mY9AVibNb1WaJTNqxxag0bP9+nWcgHqj5EzPX/7KuFX44R932elPy8M0vrQS
	LgJMK3hDY4HKlPAhdSXQVoeP1Sz+kWDXIYtmHAqiKujMrTfw/Iue0pJR2Laqeear
	ZWY/AF57w66YcKhvf+eCMv951LFRNHkmn5Vj/z/oK9QKxaqAgzVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pa269224-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 10:50:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57MAhxT1007329;
	Fri, 22 Aug 2025 10:50:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3t7ye3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 10:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGaXyhp1MOmQFDsbZaV6R2hdBKBbTxCZKBxf4g3gYiFYV1vMy2/DKggIpk2mMMzEyP1qS47m2aFnfMq7bx1YFuIH9TrBxRWZEkTJihqNxrE5M0teHSnCjONxTQsNQN4zkIN3ltCTaMo68xhjx73jcMxMZA0wxwMuuU5yYsLyOZ01v8ON7E2FMKL8xAabdebFvM9w7z7GUppj8i85quOc67ORcGrkBrlwVlMqHduIxRnWE5Hwa6Qd8JDqNO8ueQgDM0UA/9C3hSaXtzx1ScnShL5LiiB+7qcNXWNjER/SaMzbyKQazG66Vz3ZdvJ3J8n1KZB1T2pI16ZY7+xnP1nISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lR1E66e8/oCVloQFKwXPBDXe0iOmsM+/rH5fqtsr1I=;
 b=N5s74TPG9iopJr7Edb1OQbXc9vp3xK8qi9VZ3xIqEqqsc4P9fEI69NCzGSMGNo2C7wk3XjFaMSVkszWWqRi6IQzW/eEuE0T/cpzb4/yIqUHl09PuoLDaXAP+J6IuwQnjUQ5bBmZnKHSxnVF3I+qGHmIRzzt7qi2i/d4ONRXhE4NoRYobGvcOBCdZgAtF9QVS2wP2BadQgGi7GhYrThl3IIebVhgMKylJ13cw4yJ9RDHam30hrwNEfuCos3yeNvAP/6PqFhBkESotIcNbpR7SN4qEZAbp0VyVIBQ9cO0gzCp1GGUqMQn7IC3OcMJqslDtWlxLIJ64YNnYiiDuHf/Dzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lR1E66e8/oCVloQFKwXPBDXe0iOmsM+/rH5fqtsr1I=;
 b=r1nBxEJJlpoZSKswBJVrkyTDK+34n4TsXthSyqQ5sfyNKAyMghXQQDmwf0/X8dLecMFERVasjOOTuOnalgHt0R36BboMch413q5WBQw+/2oeNkrz/f8p/OCJ/PvGIb3VM829/G1z3Sjf44rpFF5S4+Ig+l7+o1s3+2znSLdEnp8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6765.namprd10.prod.outlook.com (2603:10b6:8:10f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 10:50:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:50:21 +0000
Date: Fri, 22 Aug 2025 11:50:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        android-mm <android-mm@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [RFC] Unconditionally lock folios when calling rmap_walk()
Message-ID: <3972cb48-2684-4ba6-ab78-66460a939929@lucifer.local>
References: <CA+EESO6dR5=4zaecmYqQqOX4702wwGSTX=4+Ani_Q9+o+WUnQA@mail.gmail.com>
 <CA+EESO6iqowMAOnBPJjERqZym_qvd6kx8BDMQG8+3xQSrNFytw@mail.gmail.com>
 <CAGsJ_4xccre0rz5zgRTA=NbFzF4FLS-ZUohgLFnfTGY9Jdequg@mail.gmail.com>
 <3133F0B4-4684-4EC7-81FC-BC12A430E4C2@nvidia.com>
 <CA+EESO7_-64GU5v1FTMXbemQixPX+xo6SGm8r0txohZJLs97cA@mail.gmail.com>
 <aKhIL3OguViS9myH@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKhIL3OguViS9myH@hyeyoo>
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbfb9c6-cc52-4aa4-88a7-08dde169b0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLaQMuUG8uQ6Dqo5cSVSVRYuiCBvuXjh8u2MedICWXwcmmRjw7AiqBwC3PnA?=
 =?us-ascii?Q?ZJgt66yKfNjRF3smLl0EWq+vnsXfejLoC2cyLdaKHvdKeUT+SrD1HoFBGLkM?=
 =?us-ascii?Q?IS7Rm6OO9jH3S1q65c4OTBua3xyATHuYQDjTPQZrJ7EoE0REKBVuKfIRWMB1?=
 =?us-ascii?Q?z3Au3ibmEF1jb8vkQEOoqZ+mUAuS7xVhvAMofB4qQrkdh6S/7mB/RRbU8gAg?=
 =?us-ascii?Q?Z4TtlMEbdAWxfx3dRlbkwS+MoZ7FML99R7lNUDLdRQavqoaT4KUi8xzNK5nQ?=
 =?us-ascii?Q?mjbrsm/Ig37oSB9z3dTQ7FzBxfsk7R1Y2fu6wenhoYTIUIj0gv/lfqLEUcUp?=
 =?us-ascii?Q?EgWdjo7mJ+ntRqDcu8QIrcOdYi/z6vdC9rAG3Uxwn7KoIEwFukROJlbvbjLL?=
 =?us-ascii?Q?1NeUMb2t9I9FH0CbpEw8vZMoWRSbQHwVydpkRxfQoideVCKxXrbtVN503fKM?=
 =?us-ascii?Q?AMrv+W3X6ijk9swJVnTvHc46801Uqbb0pPRGi3j8iZLz+ijihNwCqZNN1Ntt?=
 =?us-ascii?Q?RxTayioWAAtmlg+I7112GjVIrgE5abDJ5NFAfApV9QB/UhS5DOmyU+aw7N4K?=
 =?us-ascii?Q?R8Pd40hRyJ5oyJDhpt1//PrmKVE2AwWQ7TzawoA7Zjl3c8bFW9trdQVXBYVm?=
 =?us-ascii?Q?XpE+dAPA/bzh9Dg87NT7vuzG1tZXsfnGj2BJdey1wsNGYRAcGgKoyfbpRP0k?=
 =?us-ascii?Q?HkwTWrCxlePTHdJ7fAdR92aPrAD5wOUGxN3gzlNO2PR0I/GJzIWxnwzHBJcc?=
 =?us-ascii?Q?eaHu4spdyt+WXeFLkSLOaZHB1Yw4dSnzyTWr4MJpq50BuTBJTu1LeP6aeG//?=
 =?us-ascii?Q?wHhVfrpP7zglQbkDnhnfSsnrDlTvOLZB+wScUbz58JiX1glAdK4sQBnK/Mld?=
 =?us-ascii?Q?mFoSWUYZhkngFpZYs47X8SKNzi4mqm4oeuzotPBJDUb1zxzIgUsgaLx0V7KT?=
 =?us-ascii?Q?8tlemaiNH4Kx2zz9PfqqZtFTXJHEjDmg7Z0PcYUJwi8wSRQvCaJ4Bz2PpGjh?=
 =?us-ascii?Q?H81hGb6aOz3zwjxiLrMUgISRXwq99opjsPzCUopuRue2BDoqPI7yZBUVag7G?=
 =?us-ascii?Q?WvcpS36jiClGXRdispnrQhl6B0gZ9wwQM8sLIOnqknRvOu0gzJgi9fh6LRDm?=
 =?us-ascii?Q?WrtCcHIlGYyVRV2r5/bS3IazQDRPGgcwoO4k+1pGq6aMS7HHW3/be9v0NnSq?=
 =?us-ascii?Q?6rvnqZrLHftFsU2mB7GfUNtbuQzFIiF3qAcZEA9TDtD9vqpSnRCh7AFVSz41?=
 =?us-ascii?Q?N4PRr8MgNCao0iye6QneY2beL4bJ9Ga1jK0JjH7RJmWA8O+tZiv//XIs5hZ8?=
 =?us-ascii?Q?w2RUqRLUJ7PiX6NVnaFCXTxbr9v1IKyxe3+3DE+nGDF6vyDMi8xQrpjeLyCB?=
 =?us-ascii?Q?qkyOXDFO8rvMyimCid8TXRATMBaxEZ6U7p+RCMRCxfVRRQ4evZDvbEFzFagX?=
 =?us-ascii?Q?MjOA8Dyuk0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pCowBJr6Gcg3erf5ZRal2BoHAxWRfZ2T9T1N7wQ9PtsPq/8mheqn26z50jC?=
 =?us-ascii?Q?+Ql1l7kNXpbJfczDHZPc8iUjDcgCRI9WgiiGMNr3+rJsnjqtozIuTXG13sV7?=
 =?us-ascii?Q?crw/nHsvzU7ymeMN3kfgnbUfxPhIkZqJODLnavrRJXmBepxAZ3SKn4PEYtIp?=
 =?us-ascii?Q?WEbc54kfhG90LZ+OmG+XpEKBKHpHfHEIda8/AA3nwV9iAt2QAWk70o7hwcyM?=
 =?us-ascii?Q?skxmb78Bvm+SFzblDeKAtF4A1GCwzXZCGlNlQhe2vyAHnhutLwxNPaiwkIEG?=
 =?us-ascii?Q?eXEquhs9/I2+ZlQ0LNK5JMVViKe4uMQpK3/mKiU6GfD8ZUVHMmm3dWHOoFaW?=
 =?us-ascii?Q?aM2IB7F4l4T34V37C+MG7q6F8EA0Bu3Lq3KYnrHS1EAPqasX3kqNyqFFr3z0?=
 =?us-ascii?Q?I2Q+g3qP3s4BB3KQeRBdN6Z3iso1C2moTYzR/+iG4mWgK5MQqf68FT3lW9y8?=
 =?us-ascii?Q?1lHM3hcWCneCTv+4O5k1AKdfewlqQWtms03T2hJklSNVQ7WUyOJ74avHGui7?=
 =?us-ascii?Q?5m/BWilM9CRlE5TcROF3pyyyASR1tjpThzvDHzxIdNtfkKoKF99CFJh0wNsN?=
 =?us-ascii?Q?2KkxIG6HKLwSEwQoyJZZZYGe7rAorFCfza999Dh0kprqk3qpm7mpuBcEu/cc?=
 =?us-ascii?Q?P9+h6IWRotZ25mo2h0Q1BHZGL2d51z9zNy1uslnSgJGOzCL6eHvaPFibrGkI?=
 =?us-ascii?Q?0bxzDlXlbZJ4j0zgpz8gpppQQCKmYOz9Ds8IPG9awuqix6wHsJFy4S21AGKT?=
 =?us-ascii?Q?cJ7wHEmwhqFBsVV+EZ6Qp9PxIK9LViAPVVqyY//nvnUMPR/ejeTJj7CJi9Kq?=
 =?us-ascii?Q?WBSzQmDdOR7XSjBkohwuhYAY14pjkEF7iQnA9Di1KIWek5HGgJXipiDdO8gO?=
 =?us-ascii?Q?+4a0N+EDYrcpvugLrC7PWF55GUhcKY526jWrKiKUsL/a8ksA79o2cx0fdmA9?=
 =?us-ascii?Q?jI5RcmM0G19D2hGtZzYvScIr42GP//Kh2BgqHSJ2HFIprw8pgoL0heAv1XHE?=
 =?us-ascii?Q?CgpVMF5UVgA1Zt3dq6gKJgHwowa1W5lqdVhWfXvwy+2zaX0FiqK2iPVEFqKV?=
 =?us-ascii?Q?r6atZ757MY122YAogsC7S3bW779GQ1UE/TYgiB2itvsEaO6fMEUF4t7X3DnM?=
 =?us-ascii?Q?FINnk1+SXUIi6xSTo6KlW2WxvpfRF2bZFY/U7fzmevQ+FJEZ20d5SjBJjwGt?=
 =?us-ascii?Q?0/EyLTTRELoc5mbivmmPeWCAHuMGTkPp6XJ5PAkTwqp2pG+H6wg9UllJfFkM?=
 =?us-ascii?Q?R4yhxQMDLSLLua5iyMYA0z3Cdf2oPUitdXgyPVUf3AUxK2Qx7pL8SMrreBAq?=
 =?us-ascii?Q?n94o98vJGQG5kbCMIg4hP8A2AZrsoHFBwCK3Fhoo0NQmkuU7/ytr++bKT9i3?=
 =?us-ascii?Q?InUu5PpO3NjhUUBgalG3GTfEQFQ5iS94i1HSZEH7CFafOliC6u0DweC8ODiu?=
 =?us-ascii?Q?fAGowE4Mpd3dFuCxOQGdhwVuvDc6Ky804rWfq7GXHbXR68wQ43YLuEwKO1lc?=
 =?us-ascii?Q?JZwvF8v6rVn1H3rR/z7mJll8quYKzCT7yzXx5NUlY62jm74B6wBDHetYiFz0?=
 =?us-ascii?Q?J4HS6hDNPTLo/DtJhyy/D3dOJWg2nce3fiR3xO/ngr86XsqnTggvOhXKXHT+?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zx02rUGa5F0LStp/RD3XINbmNNMy6PaLyv4TCyM/jBno0mSIV8/zxCvnSjdpd5d7Y4jRziT7eFAAnvGzooWqlc4hLdZKlk7WpQDfAQ7jNgBtohtfHHbixBL6dHuYUOPRZiM+iW02ghZX/J2wij35kg/QYDr67xz821EB2c/26eZO2EH02VdieyFUOHsMXQ2XFDTvCC8b9Xs5lHdoc38GrEzPGQhirgsoHdU6Bpzj+/Jxcc/rEGF+sHBs8Gw4jvSUrpTWxJ4PohqKRjOMSLvZ672306TJ3JBN5ylnN12sF4iZp3dWfaw/sTLAmLNQ9PzwWHTEBxcSd69462Xp1dw4kFMTytEhdmC6xyGtwah9Qhuy5KOfHV1grEYTBJcSJjtQSZzXOh2701QSSyXrXIT0MG1gnwKd9GMjuGWA9QJQVzpSr44UF977HkopwCNLMC3vLZr/uIOPrMOjFoeT2kGRn2RYxyauQjNJcHvv9n+WWKdz03oxqtdIGAdS6W9l4VwQ8DFVg4a4Z2nD8QGXhvMchQqltkiXlJwflWFlVszkm1qLkJjVw9jmFdRo4rk+UIAp6T7gZLWLZYhtvZNsx9vYsIFqz1IDd3KxbKo+VmeY08I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbfb9c6-cc52-4aa4-88a7-08dde169b0bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 10:50:21.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8qiPKOfHWnzDalgiTUxpC9mywrC55ntlwrNO83D1YPKgpPiStcp3qLJEFZTeDqn63ev5Q7FXl7pGf9k1hWYtKDrip9m8DiSwT9AcEePMaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=678
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220102
X-Authority-Analysis: v=2.4 cv=ZPiOWX7b c=1 sm=1 tr=0 ts=68a84b6f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=zLcoRSa202Yh6R_KctwA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: iyTHWgWPx7CVghapcJPRGNWG28Wqm_yw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE2OCBTYWx0ZWRfX6TRVPXJagtgO
 ohjgDyQaZTEbE6ivdrnWLuwCvqRCZqDpbDGph8xoM0HpjJ1XsFCpBi1dc4NQnzIp4/QRxvYqKT3
 EKJ/KHmUt2lLiwD8LabMDikDL2HMgsn65xyiXamrslk8hsOhiuKcMNouhsQZz9fCDZY6WOwtCqh
 As4o53cpKnquVcOiqxO2yfUP2GL/W8/+tqWaJ8N/ALB/CfYxh/JNj6iEBZkwlPS5dSCN1WJy5+R
 N2+g52kilQOyVPaUhC0BuANexMzFmyzA2A3DnPloBwCpM4xA8GCS04pex9JR9gzdZA0rk8+yBRB
 pnyBmlGANuFBgNSux7AtYlhSXeG+8IOIeKk4mCT0SmyEXHwlL2KYtO3qVsz3xM1TFnDXnVXG/RK
 Z51w6o1PrXAKpuHPwBeesuSnliWiUg==
X-Proofpoint-ORIG-GUID: iyTHWgWPx7CVghapcJPRGNWG28Wqm_yw

Lokesh, this is a mess :/

I've been a reverse mapping co-maintainer for 4 months now, please check
MAINTAINERS before sending this stuff out. It's not really impressive to
learn about this 2nd hand...

Also I cannot get lei to get this mail to me, no matter how hard I try. So
it's _really hard_ for me to respond to this.

And you label this '[RFC]' but I can't find any code (unless it's lost in
the thread somehow). It should be '[DISCUSSION]'.

rmap locking is _extremely_ sensitive and the discussion needs careful
attention.

It's hard for me to even track what's going on here or join the discussion,
could you just please resend, correctly cc'ing the maintainers/reviewers of
rmap, and prefix with '[DISCUSSION]'?

You've already got responses here so we're inevitably going to fork the
conversation, but unfortunately I don't see any way around this, because
I'm going to miss all the conversation that I'm not cc'd on.

Anwyay I simply can't engage on this as-is, and I really _want to_, because
rmap and the locking around it are issues of PRIMARY importance to me.

Please try to make my life easier :)

Thanks, Lorenzo

