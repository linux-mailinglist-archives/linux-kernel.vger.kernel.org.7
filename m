Return-Path: <linux-kernel+bounces-734008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF5B07BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7044A7819
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3E2F5C55;
	Wed, 16 Jul 2025 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPR9P7Vn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C72F5C44
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686306; cv=none; b=QUofSeWxgFOJ6ez93MXGdayBIdSEF31rzbcXVbJrAHIJFvQrVkRChGwEAch+qV8unVFPboe0zvUUP8HTJ+p5D7rppoH5ogFblXp6C8aATs8i8iJNnAHaPjSDJGvTtl7R37Y/m2yEa0EOhhQUsKcy9cLdY+2B40RSJwNgfvBA/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686306; c=relaxed/simple;
	bh=6RzJT1L60GvhmajeO4pYpV61WuPIfNveFy1ljekZwUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjKCBMMBofSmWKqiSIW5P1tNCNyRg81qiuRRPYLX3Sb+09HCicMNMnK1L603P8Te4JZwXZnb6QbP/o4eoox7FKu3IrGfkHFYzmViTa80MXBxHGzKBl5jbPJXTTPoozYwZ448NJV5vzmHEfaMLpCJLN82i7d0se9Gd9Ooz6hC+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPR9P7Vn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDVtY022256
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/tMth6o7tHgbIUQxZkR6tUZ2rv+sepU1UeAb/Pu8vhE=; b=hPR9P7VnD6Vfboen
	Oe0xd1Hbb1CL+U8J8zbXW/1QCBNPzds+NcaxleI45fPoewHe81S+KWfBgRSizcxH
	h31zRd6dXlLR/y9Rm/X9XG/mF4YAC/sj3YFRp+4p+vjNhp18YNzx9bvF/iqPnMik
	Ir3mQBdU6YFs+8JXvPZAJCglt7cY6IpMy45ButNyHot1hj5ldKfMLXbg+MgBIb0b
	DQClV5cw5FosXR/mwchmdNA7PYTmjwNIrr/QfJpOvPxBKe/Ib1TYRrOc9CJkkh6b
	Hm10V8eIPtpcTZxaskQCLL6LZV6yWsvU9cpzQiy2qpR94snWFQAbWNSOm1kKJAoe
	9cxjfw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy4p1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:18:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31f112c90aso86691a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752686303; x=1753291103;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tMth6o7tHgbIUQxZkR6tUZ2rv+sepU1UeAb/Pu8vhE=;
        b=P30Cd1iZ77mjzmUBtemTMmthecvfXylxm0b3XVibAWo6DSLWJyVyPGtQ89KCMRt+XF
         qCU6sbxiDI95MwgtgxvVWZvlFbiZOpI9s0OsDDo3yZ4J8MR+ajd3cG6Ps/ZWx+ldLmO9
         XXM2HiT0k9Acqs1fzBuDzJQJa/lJ4b3u2laJoJRCq54dC1gNekkvDePaBUcJOpI3FcKG
         xsBd57gN4GznGpT18GSAUCgSi28d8TTS0x7i0evjLQutY+n8ISvw13hcRGqwdwpoliwX
         FzsoZmagf75ld5kK44GVQPf9tfs+Ma2n089XnEcpZKJtS1v+1Z5nNy0gkns85IVIXvoq
         q32A==
X-Forwarded-Encrypted: i=1; AJvYcCW5Hc2O78VACRlPARQQ9olb2fTQJAAGhMU0PErNgXv9ziBOExlGaVziafrL34qIDmTAmOw8PsQEWPhGN24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8OBV7JSaB4P7bAQYZU+XWvud/XXIcNjKdIrTT3/ghSQOTA6Q
	FFQiI6krjpeIeQo71Xo6sNvRxYuxtqo/n3bcBOOolaeuRjk3QA9vX34ozq6wj+WfDHzAp2Ildwn
	0uSH9QXFRora1Ka0sL5uaUJCz/4ty8LOZqdFyv7G2mzGNAK27AyrEJlLdOFmnzArZI8M=
X-Gm-Gg: ASbGnctUoRwicfjAt3dBnbxtAWB8tFqQS8c8D8az4c5Wf0Kn1fEQxY9eupyLkUHsAHa
	jrzDsj25kSh/A+bvNUGblCE8wBRNYfppRUIuqftl5zB1DItzuPPdJPdfN5S640ZBONdOF1WB+Au
	MTiBkPqyHY8AJHV34J89iaGm0hs55WpuYvLhpJyTwaRHNoRDcjipFebwpRDnK91m1HXXiUfcp3d
	d36k96BLghuKQ01JMXjkBRJTq8/PpvCjqJojsXHdHt+Mc487VskeiDvA9cm9qPguie6WgQcqAH6
	jOGFUGnCtkXLuwU+Ph52iuCr424e36crpjSMUrCwtue9uP6U6niqvCN39xCrYtpyblhMLRezSe2
	40yhlvFBnNCWSsoy5eEE=
X-Received: by 2002:a05:6a20:1584:b0:234:e109:6bdf with SMTP id adf61e73a8af0-2390c56e8bbmr294952637.19.1752686303013;
        Wed, 16 Jul 2025 10:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF56y5nV1rAeM2TuaaRxByMhD0eKi4TFlVWOHGMOxWKdeVyu82Dt3msTx7dIP/gme5crNDFgg==
X-Received: by 2002:a05:6a20:1584:b0:234:e109:6bdf with SMTP id adf61e73a8af0-2390c56e8bbmr294908637.19.1752686302511;
        Wed, 16 Jul 2025 10:18:22 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe345f2esm13991621a12.0.2025.07.16.10.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 10:18:22 -0700 (PDT)
Message-ID: <3dc23475-1c16-435b-9c6d-d2d7996280c4@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 10:18:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
To: Johannes Berg <johannes@sipsolutions.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
References: <20250716135252.51125baa@canb.auug.org.au>
 <4ee6758a49e6f01c5e42b2f7c27aff905ac07dfa.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4ee6758a49e6f01c5e42b2f7c27aff905ac07dfa.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1NiBTYWx0ZWRfX4+MkZdqFEvKM
 Q9haiCDa+3Ioiit6NMPFUET8OnCk4tKM7Xa+9CRh6xpusn09pcbNQeSBwfbvSKrEenXdGu0qnDl
 Gk3/pei7XIvXpu/OIwXbsVBVt7sR2aR9iMAulNeMaPlblh/ag7PIR1gAE4oUWmNtxJ1+Xvb4b+K
 9p+1hffx5M06WCCbQesHfF/H4qY3vik89jr+RYS0UXuowviAtGZfmm0zJ3AV7Tp/2kydJTC013H
 M/jdQlY8bgQqxUg77fepyEOTDOBFck5iVantRSVCPybyCKPzuAy0MDK9c+9Sd9b+qC6sfmeDC1e
 nwOzNC2lcrAWSa2otQ1GKGy2ldQURSIn2C9PQr/RPD9IhqmRg88o4ZmyRfXJzdIp/lXuvPFnpFE
 4vu0HiAxeUAEUErGUHlB2FDVglklOXpnGw164RgpSHwWwJDTwPT/Db3vII7zsiPO9PZ5OgZZ
X-Proofpoint-GUID: VDWILs06iGSC_nENcjHu_24jH7aC7VFV
X-Proofpoint-ORIG-GUID: VDWILs06iGSC_nENcjHu_24jH7aC7VFV
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6877dedf cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=ULWNt2tdzX7OOLHh:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=Swg7eHfTgBCftI4JXWkA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160156

On 7/16/2025 1:59 AM, Johannes Berg wrote:
> On Wed, 2025-07-16 at 13:52 +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the wireless-next tree got conflicts in:
>>
>>   drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
>>   drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
>>
>> between commit:
>>
>>   5fde0fcbd760 ("wifi: iwlwifi: mask reserved bits in chan_state_active_bitmap")
>>
>> from the wireless tree and commit:
>>
>>   ea045a0de3b9 ("wifi: iwlwifi: add support for accepting raw DSM tables by firmware")
>>
>> from the wireless-next tree.
>>
> 
> Thanks for the heads-up.
> 
> I'll double-check, and give Jakub a heads-up, he's probably going to hit
> this, unless I defer the wireless-next pull request. We'll figure it
> out.

I'm planning on sending an ath PR for the 6.17 merge window early next week,
so I hope there will still be one more wireless-next PR.

/jeff

