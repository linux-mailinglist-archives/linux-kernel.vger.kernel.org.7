Return-Path: <linux-kernel+bounces-761766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9EB1FE36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F337AB4B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1750A2550DD;
	Mon, 11 Aug 2025 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WC/qE3sm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E3157A72
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754883547; cv=none; b=Mln9qrlJ6pWBClQAHxr6utjVdLNWiJh2N7mbE7vUlwQ7JNB9UtXsbyXB8do7LSjcxGOuX8yNZLC7Y3M0iBMQSohjkuaEE/hlI4uKLTdtOhb8Rn9sc3Rq4dGvljA1i98Zg2tVdpdXhtImn3dcSrUVxI5WYOzFfgY8or2BwuvPDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754883547; c=relaxed/simple;
	bh=UKXIMrT2Im5is+rCn4dnrZDMosC6fGU2BCT6Wq0lgPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2k8mmSpRu8WnF4jFPBy6/aCAbWi1YgbpOAqvC5e4mfr9T081BNkxOUfXy1NO5kFzjb53+eGXaUUCj8fiBKcyl8/AJH9tjQmBA5Wsb02puz1EdzT+Jqax6W9a/r+1V+od3qVAqWZS9GAgo59BaEkI0Ljirjk9Z2WBmr0YzWSnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WC/qE3sm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ANpG3P001291
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDApZTk2nZE28clF+a8J2J6VpLUbqhxAq5BNgHbqkVQ=; b=WC/qE3sm/sFHSjfM
	Eq1frOQdIz3EYmhZ/Rt+FViEcfWEgdAeMTwPSnPbL/VqwNyR5jhuunseF/GN9Huq
	GPy79k0grjX9xI1Cdz7+J2tDjgmVxiPasq5QMmkrKOyrF4XwjKaAterf4BUe9fVF
	VJltC44rz6NCghASUn0WxQHi+uYetcrzDOWwOK0TkVBdfr+dWRy3xy+naMiK67Rd
	XMWPuPS63gAqfTKpagrsDZNt6fCossLsL0I+uZpgYMoNYI9a+NWT7P3522VB3Ljf
	qu5gSVAeVzJmZFQHt01QfkbfzCp9HZzehFQ4+qV57AhlKi1q8SvSy0yruPqnSSMP
	I/LuOA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fk7dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:39:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so8720731a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 20:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754883544; x=1755488344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDApZTk2nZE28clF+a8J2J6VpLUbqhxAq5BNgHbqkVQ=;
        b=EZq5o/frN4u0Mak2QO95tpV/hyq0You5cqc0MaLeW70DlzZH55FzQvwDWww29LVyHC
         xFBIi3Hu+0ra+pMXQNe+s5DYgSnFQVFk43b06tB6Ov1DHxviHp4qk54eQhei9/IRCK6r
         a+oWyVGTJwNk95d00K7P8LtkG4BB4QNKk6SW1cFSJgBy4shXhGGb+Rdfxx3ksVf+ce0N
         NsV/8VqKudcQMyqinTMlBlZxHT7/TeA+by+/OOOzifIuif35NpwFfRzEikcYuq5yMZfh
         SPzJ5II6H5WdRze3EC7JjsbDgbOUxI5J54ZaRiYXR20/iwRyHJ2DYxw/B94fzGP1ej1p
         q3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUsObU9ft10epqZLfvrNIp3rh2bUtbW75ZshDgaJBaM9EO6kBYmrX8d66J/JPOacaXtReF4fzBMSxqpJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfP4nKXPuTHpxYjS3gfnHeOVh/dmz9D2b1EvLchaZ0yNN5cAwO
	VuHOLLFQ12MWW/CSJpT9ntNy+2FTj9A42xXv9UedCamcZM6WrhzwA/7BEskiiVJZdhDbajaz5Lv
	msTxkzZJR8zi0wVXA79aFhaDdZLcxYoGE0Yeb3B0ZN6oA1tn8Grvk6kJOiNr6ZBRwyxs=
X-Gm-Gg: ASbGncvIbxrdCN7fsfozPYNV4G96KvODIlyjFlpI28AS+Ri38VvZ7qomUNIs16vrY1Q
	iIokB5DmEDqUxU4jiR9imqcQgGYT1y3dh/ITtKjIgB3Yd+3H8evJf4qiBqzXg5rLemCsuKBYuWV
	8gIyuZ3xyT4T7ET+fISF/JB0n3/sbjqmBQoegzOwpyMH6ZE/xk3HgTwH9edpJQbhuIV66gWGkQG
	10J09SjtbqXYRn35fRRXT7AZTFhGL2LbyzkVkS0XxHUniY2oYVN1iko42qQUqHylNhmJyLdlHZg
	gX+r58YuwTiusc2yCFsjUSHCo9e3n2cfzPHhZjvM7K3Od9hwEyVmJd+rTFSbp5nD9QhYvee3WD8
	L71gwaQ6Dd1VcCs2s4zD78aQmTWt7FaI=
X-Received: by 2002:a17:90b:3846:b0:321:a2cf:9da9 with SMTP id 98e67ed59e1d1-321a2cf9f2emr7030251a91.15.1754883544150;
        Sun, 10 Aug 2025 20:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzovdnuZMOGoG7rJstD57pdUxuFXM7ZTxP1dKosD3H+FktIX9xerVzG52tcd1z3eHsTxfakA==
X-Received: by 2002:a17:90b:3846:b0:321:a2cf:9da9 with SMTP id 98e67ed59e1d1-321a2cf9f2emr7030228a91.15.1754883543728;
        Sun, 10 Aug 2025 20:39:03 -0700 (PDT)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b43c54fbce4sm3786625a12.55.2025.08.10.20.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 20:39:03 -0700 (PDT)
Message-ID: <d52c8078-7416-45c9-8b5e-e3a80ef6ed1d@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 11:38:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
 <81440d36-9729-4eb5-aa30-d94d0f85b7a1@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <81440d36-9729-4eb5-aa30-d94d0f85b7a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yn_S3AMQhqA977tyXEboD8l2CpKb6j4r
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=689965d9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=4rEXVySGOu1P5TZAaAMA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX8x5tyZ7m8TSF
 1K39vJOHzdgwc4bkIRlpQLDmrrNOrpJ0ZrOZDC4QX6vA5fs8yVwvgjLjx+60dZu5nkatGZUUEl4
 Hn0wg7BA6O12R1TNtunzVthVUf0chYO7sVf0SmZE53BWyDqCeryWd1wRikwxuvcepjIxfwS3Q+i
 PdwGQrYjRwDYDvERFawv1mohLthPTgZbzDMuck6SoVVFGbsdX6D0d99r2pAADM/Btg8WX5aYe+n
 GD7cZJDzYqjUw0hhXT1Sz2meH7PnDmAVfT1RZmDf9E1QjLetBgx3pylmv8tgwof8PgaTDLR2CuE
 im6Px8nY9WjKgNIjPfLPR9uOJvdWdzs35W9j47jI/Xz/1BBOduDIXPDfqVR8EdxJvqN/x1M0oqn
 VwmgSucQ
X-Proofpoint-ORIG-GUID: yn_S3AMQhqA977tyXEboD8l2CpKb6j4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003



On 8/6/2025 10:10 PM, Jeff Johnson wrote:
> On 8/3/2025 8:03 PM, Baochen Qiang wrote:
>> Fix below two Smatch warnings:
>>
>> 1#
>> drivers/net/wireless/ath/ath12k/mac.c:10069
>> ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
>>
>> 2#
>> drivers/net/wireless/ath/ath12k/mac.c:9812
>> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
>> drivers/net/wireless/ath/ath12k/mac.c:9812
>> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15
>>
>> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>> ---
>> Baochen Qiang (2):
>>       wifi: ath12k: initialize eirp_power before use
>>       wifi: ath12k: fix overflow warning on num_pwr_levels
>>
>>  drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> Since this is fixing smatch issues I plan on taking this through ath-current
> instead of ath-next.

Sure, fine with me.

> 
> /jeff


