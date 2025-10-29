Return-Path: <linux-kernel+bounces-875367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CD4C18C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0F4A4F743E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C501827472;
	Wed, 29 Oct 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fx5C89Rc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O5dZaeXN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C92E8B80
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724232; cv=none; b=FcDQdedABhQ1Q7/wCBFwSn3eoLNp9RctgTZF8Lo8DrdC4fT7aiOdXFny8X8iNsmeQvvF/q3sMpRmcLvlF5OR293FC91gjyUy50vHUeMrhWJYnx7lgdhjFdfXacJf3gntQtXmt8Db0yoeIYWW3XAXp2SPZrqxSUVGpPOonqg0UNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724232; c=relaxed/simple;
	bh=T/IbTI5xaD9PcdWfELicZ2QYQ5TvNueDbfPT51973gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RG6HSLVCyvBdvCh/6RgKrS7OW07AZYGM0hcKKTprsNrFmKu1KTfsbU2iDXteapwkFTObsXzXUzcyPqhea15zXCi6a4z3T5/QfmG/9gg91In/7IVGIEl7VQfyo489oeEx3EfufxBUMo9koDJ8lMnIDWnTFvzvXY58Y3imqorAf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fx5C89Rc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O5dZaeXN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4utmV3720398
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZMJkUQVenyXNnUkuqWmmaeKqgMWhQaaisg9JMWnK+po=; b=Fx5C89RcoAhlSpe1
	TvnMBdcM/2wlXMR6UgSU34H6nzG73SZD44NMoemscVnvrgufIXby/VxyGKyFw8Pc
	Hn3BhTlYli7WAjahBP2Rd0FQX23uOGOnZIOPf3L1iraT/IuuebxafT7WwS9th/wA
	raFTFTF4F3QVCAHvZ3fwI5d6sAkcJbUyx6sQTmXNIofoh0O1Td/vMjbRENRyCM+R
	fUxCmxB0gAZ7Xfqzlc5PqSzFwJuVEHUVLIrt1ymIh9PutwmlaEVCqw6X8K4H1MyX
	nNhNB2HHH/hfx7vQHtw16WccW2rJcGClhyZYZl7DjGTuUAuxwpop0liFnuh4hYZx
	iFqI/g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a21pv1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:50:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7900f597d08so5338722b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761724229; x=1762329029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMJkUQVenyXNnUkuqWmmaeKqgMWhQaaisg9JMWnK+po=;
        b=O5dZaeXNtpZ5ReuXi9YlNyKYqGYuvjIrpniPSisI+xG+wPiKJrEjSHBP5ycOls9j2w
         tli10msM6Rg4rnzjvMrxlsLOGZIw9uMr8daid+Gha4IvlNWDos3+Owv12J2D4dp9PaCN
         hajKj8pxBzt0J7XCO9L3/E5QHGYdC/6+hKtf8eNEnxCh9nXWDKJIb9L60IlZzZ0c3RhK
         seHxR2RqacZoPoT8MSrIUwVDP+TU6heBEp8mb3yYqL1V1UEQhGtyvQ9RW3ygXntehZjy
         vKm0VyqHcp22Fd9ddJX2HXzW4sh+i15mb9fYTgaFuqDfTMdayukp8+rxZSB3ww00BKIc
         n4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724229; x=1762329029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMJkUQVenyXNnUkuqWmmaeKqgMWhQaaisg9JMWnK+po=;
        b=N3dUsR9FOGZ9rbNu3ZEGzLLkfRF0RKuJFkeubaMuttQ/6flQzHfa4CxW0XLq7OSkxo
         /Utw14LA3PrFIvlEvArmx7OpDljjcWrzkPQhm+fyk5Cwcy0GwRBD73VV5mmNupwgnjaz
         umHOEIVM+mJJZf4miaJy/vZrwl/Bvxn9zY4ICi13vyXSE2yVgvF2CHDT4kQAGaJb7Jh1
         bhmCTnaQ1ba/WRQBlE+Pu5wvBn7ybrZN8UaPPwip0FoECaA51JRKmZNxAqb3OMGYaaVG
         7CSN/eR86xlbmNVipLqrfWGYUJwzD6jLHKnz+JFXS5Ciufr+6B8tmXTymj8W8fJedx9A
         LLVA==
X-Forwarded-Encrypted: i=1; AJvYcCXW4K3o/5+ht9dy0YVnr5DnOlOSqMArKaG/s9WTsIw8eKjZdBOPr7LbC9GhVy9GCYxbJF7NcqzfcHP0abQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzW56LJIorY+U2yHyG0BD/yRs+rh4NSRXKuy7+mGMXSlu6hX5s
	LfnkyX0FoWzfmgF1sJXNoQ+SIxEzRS+rFfkMFGR19wcEAB0YkCBVICzbnz9uQ9RxwjV7vBQxkoT
	UACEBm092E9FM9uO/SjfVU6F2Ihmh0Qa9wyKmsrwDAj+jj4TD0AJHWLzHtzICh2SycXY=
X-Gm-Gg: ASbGnctCGFwh0hD2xSIL9BdWkSNxOCy0K1KNrxMxGRJ+GNaKxiF4seVQoDYBj3PvEHA
	38euzdQvdnKlqYsPZKgEw0Mc14PLPDIDpVb97fGmXKR6ZTHB/cA/oEqGDsYJ4NqAB9vZESZKA0Q
	wgOCDhZ4S5BeZbZ2gIR/6Hvb+QlHzlOITakrkdVNnbHlv7JYOAzBD/4subrUCL923GGAO7JopmE
	UA+YVnUbIET98g5y+ibjaneuDuiKbYqR8Eg1c789yZWuVAxU3/XIiEVfhfP/OF32wDf7yPcLxq2
	8no+OXJogyoH/YeIugsyGH/Pjit3EWoNIKoSyRHTO0cGRO69w0/C8cidX8q20kJZgD1sKNFU7gW
	MooMXp6FxEqdJPSCsfNaNi04O7io=
X-Received: by 2002:a05:6a20:3ca7:b0:344:97a7:8c60 with SMTP id adf61e73a8af0-34651b39327mr2433033637.17.1761724229266;
        Wed, 29 Oct 2025 00:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrtX2riqRKQJAZwIzKrPyRlcgkmBoKxT4ObGka+kUyMH1rsu0UzCrQL9V1E6sN1ckaqk1v/g==
X-Received: by 2002:a05:6a20:3ca7:b0:344:97a7:8c60 with SMTP id adf61e73a8af0-34651b39327mr2432990637.17.1761724228717;
        Wed, 29 Oct 2025 00:50:28 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127a09a8csm13143456a12.11.2025.10.29.00.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 00:50:28 -0700 (PDT)
Message-ID: <39b962a4-f890-4b59-a2ec-f1f749ed212f@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 13:20:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251024-sdcc_rcg2_shared_ops-v2-1-8fd5daca9cd2@oss.qualcomm.com>
 <5e8397c3-5bb6-41e6-ac35-4090b7a9fe98@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <5e8397c3-5bb6-41e6-ac35-4090b7a9fe98@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA1NiBTYWx0ZWRfX1Gnzil0mPTxb
 0JTpw6qRgHO9IpXW/4/fu/rh+jBzV9j03eBz9zBdEVB/J9tgOXfi+VEfInIwcGooWp/Zd+Edgd0
 fLLK0ONPpbM3wLvPMMGmQUKUm5Tl4+T5UFhJNlicZQeRz0dgtltyBOOKMkXiErZ12VxDSrJLR7+
 S3qV5BhovIQ8j+EQSmi+XHj6HjjQGhoYqWO4LvFhZmrootP2cC5sZPPE4+2wx0xVfTp5MYMqau3
 02uHZcOCWxwELhuSBz7CUe40JTPyNfTDkiJ4p2evBW4ICmv3WeBeQciKXPo9upP1Tv1nsUU8jci
 3Dxwo1gvRwM5Kvn3yWmT1UGWl41982gHlSLG2u7tLqGwdRhQOKa2Bdc8TcJa/+zOFbIDRpaw+AJ
 4CH8iXTE5Bk7abPlyQyr5WlWk60Zaw==
X-Authority-Analysis: v=2.4 cv=V5ZwEOni c=1 sm=1 tr=0 ts=6901c746 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=41bDykYUuDK7XwA9TSwA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: LaNfodL4kF0Piswz8jNcY-1Kxv4SjfGz
X-Proofpoint-ORIG-GUID: LaNfodL4kF0Piswz8jNcY-1Kxv4SjfGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290056



On 10/24/2025 1:08 PM, Konrad Dybcio wrote:
> On 10/24/25 7:18 AM, Taniya Das wrote:
>> Fix "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>> boot. This happens due to the floor_ops tries to update the rcg
>> configuration even if the clock is not enabled.
>> The shared_floor_ops ensures that the RCG is safely parked and the new
>> parent configuration is cached in the parked_cfg when the clock is off.
>>
>> Ensure to use the ops for the other SDCC clock instances as well.
>>
>> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - EDITME: describe what is new in this series revision.
>> - EDITME: use bulletpoints and terse descriptions.
> 
> :(
> 
> The subject also needs to be 'gcc': -> 'gcc-qcs615:'
> 

:( my bad. Sure, I will update the subject as well.


-- 
Thanks,
Taniya Das


