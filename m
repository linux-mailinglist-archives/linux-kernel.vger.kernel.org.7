Return-Path: <linux-kernel+bounces-892292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6DC44C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E973AE5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659021B9C5;
	Mon, 10 Nov 2025 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkLjvxdy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I1a3J1JF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A96A8D2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742246; cv=none; b=qSRTXTNfOiX6+FF8W36kbeTub5DZ09GREVLCEokB/Ulc7rDkXAWCvtj+5dePQFqpPdYcosvEY8KpstBBaZGpZgS4nQi08oqpvnanyL95JZEUXmQ7MhPnHBLpJLbxcx0Y1AI2Dl0AzYFRvI/ZqHUyn2Ned6VoWzBFGotOrtCI2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742246; c=relaxed/simple;
	bh=dDUr6RlWVp++AWWjuwzu9Ndht/5kl/qlNbxSBekCeaw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fpw0OVQiIUj0P/oi20i2KTgS2l2PlG0Q9UL3/qNyi1L2IauQS5FEluhqC0i3UcsFyqZlAhuWgIkhJrEE9nGq9q/dHRtkbGzTlQ6RAcs2Qfb0AMCcmoN59Mk+KiCq0AZt65QX3/x4Im16uvC0pQ8yQBx940qvDuMivGoUEFHCZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mkLjvxdy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I1a3J1JF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9FvTeW845225
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFedLY6wqoSs/S6BwoIDBMsnBgrbfZK76Wkoc+0jWL8=; b=mkLjvxdyejPF1iT+
	lh+pa3mvmBFgma30YUCsNl6FAsmmoN1TdYa3yfe04wFyrLwzshyyJmfoo0iZ9NUI
	VHcuJk49k0zN/2O2npAnlRYXQ3M8yl24OAXWnClppwuRRpT4PLv3FsA88qbPuqQs
	VLZ0e6ud5Vs00vOy9YZb47Okqz5DXh39JrM9XpzqnG7fePL5VESwB9yIlvNQl/2F
	/8vodz16ezxNhhyxs5Df6sJS6H92+hMHdnYF4ycNIGCaoFVdgVJmzCVdxVh58XlK
	BchxiRxSi2jvXeb3pzhNz9HsGOf9TjFgKt5kJeDDHpAB9slDgsyzWk7UdBevu5uB
	008IQg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu9u3h3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:37:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2956a694b47so33407205ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 18:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762742244; x=1763347044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFedLY6wqoSs/S6BwoIDBMsnBgrbfZK76Wkoc+0jWL8=;
        b=I1a3J1JFWmsEE3u7dYesV7Q0QhVjDQZIQuPvsk8KYGbWc4SCbLR1ZXwU+iUlqmqu9d
         gqMBHYL9E/xYHSd3G6u8aOcYY8P11+4u9SZLC1JDvtUzAFuZP1GaRWsAdwUvKugrbcDN
         exevlbgb1bPHPksipTjlmuFPS/4St74mH8I8j67mjgt+QXJ/P2SeLjrT/5QOzddrG0gi
         cXfMAW1JX0tU6LKP+snfqfYGzALn1ulLsLy67mGDfXAwT7mSErDdRDxteStz0FCkMedx
         87B2TEMBKkFo5mU0BjvJOUvGJDPGnkWj72AvFlIAUXwqVBoKA12Ya+Wdxy2WC2iYSmrU
         cHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762742244; x=1763347044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFedLY6wqoSs/S6BwoIDBMsnBgrbfZK76Wkoc+0jWL8=;
        b=m+yykJcTT9v80gqC/Icjomu6X+m6eGbHY63Ru0Z3oS2XFbB77fr22TYSGlZguOQVXh
         wSB53mOkMP/wdTaoJl3GffJ5dSJHmqEYrA49j2sp/xLV5tm3LWcccoPi3JU/lAn4FSvJ
         1SDPKWPjXFF0do15COfryxTITNuNueWrkiYd0lIM81+UdQ2pdZVIwDu4IYo/PJA6MCWY
         3lKkhfFmpV8ry21g8hXxtWG4rL6RZafPfU8DpVE47sneTYrjtk3EWzIhekiIUC2EoOmH
         oeCHc0bN1HGoYbiToev6/0Xv78hsPHj+j6+N45IdTUxjC5DlIEuJcU6rPun++V8JEqCq
         KjGg==
X-Forwarded-Encrypted: i=1; AJvYcCUyXNd5b3FjhdrJfd0KNEGir5sdrtLAfinJQaJxeafM53QbE9baVBP4JX9CR4wwos727K6LCcNiwOOU5qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6653KIhwWz3TXdOoTeNx3m9HbFYR3AXrx2M5HbHgmJ90LBFY
	8LOCOm8I1F5zwbA61uAr2tlqmOUk9m1owNtwlFmjAMwimdEYniKGbF2zf1g0xKjIutLbLCoCwQ/
	PpF0OHfRfzj6vLXuqqUZVY9BkAL4aHLvJwkbXb/8UBri/4aSbdVwS1GcarACxzD644l4=
X-Gm-Gg: ASbGncvHEsa8EmBlh3ACR7aMeIU6pSeZvsyWlLxWCD9VyTT4qNIHJJ/TvPlQZTdI3Rl
	eUq7Lt98GkM0Jjh8jyVAN65XRPuEpEDfpJ3M7DDbZtVqkzTp9t9zwQ58YJnnZNq1FzVIXMFBXma
	oJJ0eigRc/lUdppL8ud8DePnt3m1kiWdNK4H+IYAxBkKiOK3DZSafypHhi2ErdpnM0Hc5Cs1CN5
	129yW1+XYjE67RJESzQNAC8VIxqpgctU1tLtqBwAyLZqXd1Om0HTVNiK748c8QY0lo7W/a61i94
	eG9WjM8vMEXdjkDMCJXuqXlS0u3UIKyyc+AMp1KXFRnmS6ZJVLSJJ/kX339RWVQ04uvxX7GknO1
	b/+cwxw/4MYcW4WH7xfrv8xxhrNleo7hXK872py3XWfUtyLQ/dQtrh50PMGx4DEzmpJMGrA==
X-Received: by 2002:a17:902:cf42:b0:295:5668:2f26 with SMTP id d9443c01a7336-297e56c9ebfmr95693275ad.46.1762742243682;
        Sun, 09 Nov 2025 18:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUHXymZR9rRNblimju8QZIyozw3WayNgOSOEEBRKq6hlsqJaliQCDAqvcNklp9aQ1xLQ/O4w==
X-Received: by 2002:a17:902:cf42:b0:295:5668:2f26 with SMTP id d9443c01a7336-297e56c9ebfmr95692955ad.46.1762742243195;
        Sun, 09 Nov 2025 18:37:23 -0800 (PST)
Received: from [10.249.28.136] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c9c310sm127743155ad.87.2025.11.09.18.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 18:37:22 -0800 (PST)
Message-ID: <46637f07-f6dd-4a9d-aa52-0ba12b571c29@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 10:37:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wangao.wang@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
Subject: Re: [PATCH v4 2/6] media: qcom: iris: Improve crop_offset handling
 for encoder
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251106-iris_encoder_enhancements-v4-0-5d6cff963f1b@oss.qualcomm.com>
 <20251106-iris_encoder_enhancements-v4-2-5d6cff963f1b@oss.qualcomm.com>
 <1728c571-1e25-59e2-beae-124d9976fb3f@oss.qualcomm.com>
Content-Language: en-US
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <1728c571-1e25-59e2-beae-124d9976fb3f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Pbvdp5a5F0bjiSJGRm1NH3rxmoMg_ffj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAyMCBTYWx0ZWRfXwhBlaIz2xQXj
 L9YbgyYDzvQj3KFLFKz5ymmulRbtkCzXehidzWxdpmS1tYXgLfU4GkiUsg4CFlET8z+urOXawon
 yyR/HwHo4fz5LYRKI1Mmqyu+ExXywh/ON3T+MxkxyfA0UlJouUd5yX4MdRN3NtVOjjJsCllOpRF
 xvoNdO3xhkHlNeytAaveQFztIg+oopJ+EDN+1gUsb7jy4gGK1jnoWfYIdTuEVEszPaHzoa3Q/fF
 4uMDcCSoaWGB4sP3Elbv/f17ima/BuIWwUr6Zh7oYEZwM3QjGMWteEyJoZgq7B8FIrq6jWEWJPl
 db+yxK5RF9HMUrWqjv2YcdtcSYWQxzVHZxhSx489URHFp/tEiDI5ELjO8qZfZc3gvibfjRmUA/P
 Kog7afyHCBU3oOrU/TLY3fWHcNZ9AQ==
X-Authority-Analysis: v=2.4 cv=ZPXaWH7b c=1 sm=1 tr=0 ts=69114fe4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0ZktX4uVc-4WF-759KIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Pbvdp5a5F0bjiSJGRm1NH3rxmoMg_ffj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100020



On 2025/11/7 18:25, Dikshita Agarwal wrote:
> 
> 
> On 11/6/2025 9:00 AM, Wangao Wang wrote:
>> The setting of HFI_PROP_CROP_OFFSETS for the OUTPUT port is correct,
>> but on the CAPTURE port it is used to inform the firmware about the
>> ROI, so crop_offset needs to be handled accordingly.
>>
>> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> 
> Does CROP use case work with just this patch and first one?
> 
> Since you are enabling different features in your series, pls make sure
> features are working with individual patches.
> 
> Thanks,
> Dikshita
>> ---
The crop for the input port works correctly with just these two patches.

-- 
Best Regards,
Wangao


