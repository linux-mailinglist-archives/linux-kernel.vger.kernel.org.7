Return-Path: <linux-kernel+bounces-882989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB41C2C218
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACCD3A7D25
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A330AABF;
	Mon,  3 Nov 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2fp99AM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IUOSXaV9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A62FBE08
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176773; cv=none; b=qPbi5YbI5Qqp7hiAUz+8EXvybYL92gSLis8zcTtz0IWUn0TyaA20HMhAkQy3H/wRZkDy4klJMgAkyhSFzeNJIM3tU/n4aNl4wB1XBhLRujb+0U78j/2BCurKPS0CGZAmIt4ThbP824mshNWgVlv6PBvx59aLudgRtEI/CZ9Wrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176773; c=relaxed/simple;
	bh=mg7SByJm97xZE/wXkQ1rmnqhs3PTduSImrl8NpJB8ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6Gj/Ms5oZy74HuFoFmHVVLmn+bmXs1kzg9+PHaq9neC9DQsZIzBkY+z0bl6UNNYVUQ0Um26Z2wKed+4Do0lWnqzVEBP+0/XSLsVhmp4FtglF8b9e6q6h+JlP8hXy8a4tDN+g38Tag/2ar3ZOLHq7VfVKyX+dUypXLGzn+2bDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2fp99AM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IUOSXaV9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3B7RTi2983878
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 13:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BIyw5i9qviVdqzlYyIMTMo7lUxL9keKbptlFRLiNMjc=; b=i2fp99AM+6Tv0AMj
	9kTFkiC49jvRKpQLndVLSSTAItiAxHYIBtFc1OyyKD77BlccMOsOZwMgtw+IfVik
	j1KVqdOfMCyyEmu7/YT8WMSm/qnPOre+EDJSBXvfFeiugAHF07MiLAVpiWLzqlOI
	DwuDvaUHP8qKv+ozrlt9TFKkuJSBCMZMBIMpqnn9kzrBWX3cUHTthtI7iaMBAwpW
	Uke5LKlZQ0EwYtVNUCzbFuHk/QKjRRE/G5nTyPUBUiJmwFm+J1Qzxs+Mh8IOJ7un
	Bc+nPJxjFActRowTFdjY7EC4ahzVDBJ4EqPv9WqrW2R/U7++WEHMZmri+BRdaOxk
	XlyYUw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b0ayw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:32:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eb86039d9aso13072851cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762176771; x=1762781571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIyw5i9qviVdqzlYyIMTMo7lUxL9keKbptlFRLiNMjc=;
        b=IUOSXaV9RktVFULlBOZaJ6UrvbnQd+C/1skda0vEKrYg85tdibGPrOwTM+CH9woEn+
         uaZLPqSWx5CKkyZ5DhvJXVdjx5udDlxXs4Kf43FzT+g/rO7dOwQqwS8JUV6mcfFQDn/D
         Fgo/h0mtV/3FPkUM0Ds5uHCyDM831uTJ46Z3ZkPffLdbcctPrSXobICbQCEsYz+Xgi/a
         ic6RN31o4UJBlzHz05J50iz1hHPzTT1GxW1dbDt1OS8fruiNPpWhlI/TlyVYPWPrVguz
         39BybMOW+34y5W6Z9a5OT+xmBjnhcouElHVFQCv/OBNyjlA5H3pV24WZABkn6BRDpFZq
         9tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176771; x=1762781571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIyw5i9qviVdqzlYyIMTMo7lUxL9keKbptlFRLiNMjc=;
        b=PhD1GJyqIWjCJGdiwAqmWh7fedFSQ2dC0yksO7CffdnNJgTNHHEZ/jZLVcPJYh9nEm
         f3kUej4XMxyMIBSSBf3zbFeefkRIVnZLFZm9VMd1CskE1+Dlt3COaWK0umwhcyS9A0yD
         jWqLyjFH129Bujbqfp9Y147rviyDT2ER19Vn42NaR8zKtu99ihKo63GVKYJskR58s/FB
         WvCj2vhfOWK/oH0Nevl+z06Tln/HGF99Ltu3K2oRCFrD2UCTYk8WtKgHj2ouKO/UpFHz
         FubtfDWTkX4arkz7r+bCPbtY5x6jad00B3LQ1kP8ELGaADmElX+iOyAPZanzzwKbu6r0
         eHow==
X-Forwarded-Encrypted: i=1; AJvYcCUz9AYxyYQ6gIon6dLxsL/cJZ0/Q72wiLY0YD6ubE0cekYdz+LeEnibBG7d/laePPlc6lG+nyO+vBdz078=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfc+4EUsR5ERQXkVhALMtiIz4KBU7ASo6a3uHxiKe3z8CVciub
	AqEP3p04Pm9vmczDxYrEJ2+sPhIxEjgepbymYfxWdWKbL4EDouv4KkIUdouNfmKCHMMX+NzJSIi
	KH82oCv49zkmiP7qkkx7/lPkQec+m96D4icBm4i+5V0MUoxjeVD8GT0GiwX1y+lII2LQ=
X-Gm-Gg: ASbGncsHCRhiPzCh46ihXS1TvAFNVXn8DLRSsrWbKi8kd9YaCLeSAhjXhzWdIbv4BkJ
	DUstqRs/28Flw88FpWomXfiXWQviczPvhH+quOr7lgv7S6eTucfaEWugOtt+I/ct/ZrNEUc4gxm
	fNwb74IVeny924zNWKuqZLe3RBwIj6R9LEoHwtqkUzwKbE1fSMaqP2KNVEb8es6UPJ+cZrm2lZE
	wnkvD51XKSVX3a2iIg9FiHJirLgeC4xjdgpmm0B082I0C9IlEGPvFey5rANwHGDUC6UKNwwV5nv
	B8PeD6Y0ewwvYvK0breiHb7UxC5UFe0lSYYcCPOdQsaqN9erObXn0tFq6t3IWquIaJmzcw6cfqJ
	KsstQzzKTDeZ9Mu1LuCcN48c6FaG8xg9R7LwKBD6HL6q6PJ/SuFn33siN
X-Received: by 2002:a05:622a:1649:b0:4ec:f9c2:c1ec with SMTP id d75a77b69052e-4ed30f7af4cmr106303461cf.9.1762176770199;
        Mon, 03 Nov 2025 05:32:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEARl4356Q+2Zi/1x+agQ2KP3My3PdqzDEFeuGS3FcOWXSR2Dn/DSniysgJ/5j+YoE1zUxc+A==
X-Received: by 2002:a05:622a:1649:b0:4ec:f9c2:c1ec with SMTP id d75a77b69052e-4ed30f7af4cmr106302941cf.9.1762176769506;
        Mon, 03 Nov 2025 05:32:49 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70abbb6106sm537864066b.67.2025.11.03.05.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:32:48 -0800 (PST)
Message-ID: <0c409660-dd67-48e3-961f-6eeeec11074f@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 14:32:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] clk: qcom: Add support for Global clock controller
 on Kaanapali
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com
Cc: aiqun.yu@oss.qualcomm.com, Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
 <20251030-gcc_kaanapali-v2-v2-6-a774a587af6f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251030-gcc_kaanapali-v2-v2-6-a774a587af6f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEyMyBTYWx0ZWRfXwNjaWYaAAY9x
 FdCRZvWrJuJ4g0cI50vHtXMbE/0vQZ61HTuTAKjJ8acLJnCvY+dBAffX1GqRtOJ9VAV2gO2JZc9
 48KpYcVPk6kZbruP1e0xuV/MnCfiNbLZw5UU3P+bLV3qXete5pIlAa0kJ/Mrw8P0O5uO0ek6UkX
 34nk8UDcI+8kJ4qioPu20SCbeZ63rDl2wIPQNA4rg3ugcmTpxP7XFONA+eG1s6FHYr0OW785ZlP
 HXTc6jNUKkyQ81I8X2xSHhyATCXdtGsDzDO/ioRTGWlfGKz4BcOnkkVBA2VmGUEnsG8Qhwn4pfC
 F0RGybkjtenAtLg4o5Pqu+XXaVMl80yErd6i04vc08ORzfXriHKnBEMew3/heZpWwvEdswIx6ME
 EhUngHpwTX6dRmeKwDBSZfg3BKiPWA==
X-Proofpoint-GUID: 2mTYzL3bPyehjyqgNSodaCt7c8bVPwli
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6908af03 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JX4wz1K3SFr7njo99sgA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 2mTYzL3bPyehjyqgNSodaCt7c8bVPwli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030123

On 10/30/25 12:09 PM, Taniya Das wrote:
> Add support for Global clock controller for Kaanapali Qualcomm SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

