Return-Path: <linux-kernel+bounces-762516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA3EB207E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B2E2A3EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBCF2D3727;
	Mon, 11 Aug 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7u9EUKJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51572D3724
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911644; cv=none; b=F+bB34xLnKPNTqKdpL6J2YsTUUc79h3pNwnUMRDPHbKbF+48azpJ+7ziC+32Ae6JUsbYBMEzwbH14D5qGuKJX3VgycH+jq9C3K+Ejo1AXH+Y2nxfyVk8GmLfdVYDUnLON8B8VX6nKM3i21fKf2yG8ZxCrMQw8gQ1G1tNfQ2Emcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911644; c=relaxed/simple;
	bh=sNmlSmfYdwXOQBv0vavVqJDC1VXG+HeHq0jxT4H3q1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9JFVO08hEJ6yfMH3zPAKgqDRcnKDztYqSQMJryjpj49fZzgZPXMhdeYCMUNJGe1K/QWTGd5ndYzvuIL4EHJQEO+EvAMBiQUsBlkMN5Ior6lKZWhMCgdkjws/PmhhsGxxoUxtPINGTm4yMkgekDA01VNZ/j5kl0M6XWIdicZTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7u9EUKJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dppf021817
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MXqAgcvzQUdwo9xEC5/EH2pfW8vHuMbHVvogbxJ9Lj4=; b=H7u9EUKJwtYhg/sN
	aChKtQBcmW1gHZ8YY7jeKtOsVpXIZOeENSn32QgfNjnOsV+nj8R2Jm6uleJcYt5K
	/jXQxIxszap0mQZObpyO0bn09Vxon9SZjyl5swci6+9NycbM6RhepiJSBztuXMVY
	zQmeAgmw2yu9MraVMg8aVynIQ9AdDFRmcQbEfkIpiY1EesOlIe2k4Npc+4o+Cf8F
	tP4xUS0reB0VQfo+r9dsPCTUL6vnSHBZdXActXtoijk5kmOtnsDEXoOm3r4j/MWk
	yGMNGye6M5+UK3T3jyI4jy9ImEn6z/ekIIC8KqO4lpY30ME4QbwY+/NsItU/sA1D
	I8mxHA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g45f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0938f0dabso11615041cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911641; x=1755516441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXqAgcvzQUdwo9xEC5/EH2pfW8vHuMbHVvogbxJ9Lj4=;
        b=lRKXHIi+w6NeWb0GrFCpMjgf4aOXosmvVBLSx6MrliOmTrOgNsK9OcbAx+Q53C2l7W
         xlA1PBMt9eEgL2MjyoV09yjbcbcfhrvOiCcDfgn4sl9xhqrLZgaKUXh4OeUZV4jMJA+t
         3lD8Lx8IMWQuorlcZ7b+zwj2WuALxOCsQc/2mcV0tushQ3rhhFLKoac/PVhYSLownju5
         xxLC2X1rhOZLWYbUWfK5zthZbsk7f1Dh3ybbfEIM/HD4htkTP0rbjdV7S6TPHzU/APer
         58RjpV2nIdTD+QBIq3163va4Xdlr4zi9UdBAHPOES/YL55V+G26R8dXQkn0ZooxmROlC
         fiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcq3Mm7eJmLCbwoG2dpf0+Pps7Keq4pCXrlnSqg/Pmovvp75V/KDXj0A3+nBnH8hTk/x8hVNjxuRTP6sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY60Iqsots2+HyZQucVJRHZC41Zx50yedJjsNdk5/Yum/J1sig
	nXWSwvkJa1bVCQSk+/Dx6WaRqVUe6lXhSH1FNRdtaUmyD2n+m2SKOPbTrbcOTEsHy1yAZJhbDkH
	KuOyNdp88XtfH2CjDA7tZrRHIkgeSMp/9oVg/68tjdvuOP2kE0RO2d4aIRaPXDgyob4o=
X-Gm-Gg: ASbGncuLI25P1j9oEH7Dhi23XxuHOIxw5URyiZmJz93tkWGV2lE2suBJ+HFfJHtVyDr
	jiFUIJs2riXaRbl6iC7bVJYaRasIO54+PFveZPuVliV/+b2rFubyLGhMsVgPjTlMj7pViXrmIfE
	uGY11Fol5jgXYimFz1NwVNwN38jvTCTX0JAmB175pZl7ORcnGn/7Edv9AqOtzYxWHau2t9TgDjh
	xQedSHulji6hCHSFj+psZStzsu+E7FmYKKRuS10wctUEDHh0zFjyVk0TnwIi++YKYQjJUNvR5BZ
	h2Z0o+bykSS6JHCspkcawtZKX0F61wyCeA1vtbZxqZDkNeBgmWyCfR0LBd8ILFtvaC+ETvBM8a6
	T69J0qTn3nZ6x15jmXA==
X-Received: by 2002:ac8:7f83:0:b0:4b0:af21:80b2 with SMTP id d75a77b69052e-4b0c16c4306mr56044991cf.0.1754911640516;
        Mon, 11 Aug 2025 04:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB82t9+WSwhTTLvNNNhL8Jg4BkUYV42aaK9LLPylVt42U1QY8YH8fULVeSO7VZVHjKz4kfTQ==
X-Received: by 2002:ac8:7f83:0:b0:4b0:af21:80b2 with SMTP id d75a77b69052e-4b0c16c4306mr56044781cf.0.1754911640094;
        Mon, 11 Aug 2025 04:27:20 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af919e96050sm1997444166b.0.2025.08.11.04.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:27:19 -0700 (PDT)
Message-ID: <c7be65ca-58ed-4a57-9294-8022927a15ca@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 13:27:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sdm632-fairphone-fp3: Add camera
 fixed regulators
To: Luca Weiss <luca@lucaweiss.eu>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-msm8953-cci-v1-0-e83f104cabfc@lucaweiss.eu>
 <20250810-msm8953-cci-v1-6-e83f104cabfc@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-msm8953-cci-v1-6-e83f104cabfc@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6899d39a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=dlmhaOwlAAAA:8 a=EUspDBNiAAAA:8
 a=M0Bv5317UiM6gxb-jmQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=y4cfut4LVr_MrANMpYTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX7DF1e7N80Cij
 1r+Tm+vPkjZmYF3pcQAZurvwQjPgj/yo5cVtC/ILcwDIFponTMQh3TOgOLKFWhXrT8tgFMdEDl6
 JJ1YX+NOwBo7LV92DtgPFybuGjRntfi4MYm7SBb5GKUzYQ/PAf8qrzdpN4MHEjxEj9lIwvQm8t5
 85FNnUQm8UTLHX9ozXwFu/epW5tzxhgBV6WV4cWVSQpSx791nK6JIH+l43h2aZC6TN2HwDsyJUK
 BcGcqTHibaM9KyoUnrBhL+UJN8Hn3t0W7ekUye9Prh5QHZt7cUezpErK2EGf7KwaDuUfDBwSg1e
 d5s3zeobmeEQkoC9GV29Xzc7Cyd7iGMt+TWpj3fqft0f427p2w5+GAFez2QNF2j9guVHkL6O//L
 uhT3/LHF
X-Proofpoint-GUID: 4DtFQsl76qdHRdmaB5Di3hZOWlNdHgsr
X-Proofpoint-ORIG-GUID: 4DtFQsl76qdHRdmaB5Di3hZOWlNdHgsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 8/10/25 5:37 PM, Luca Weiss wrote:
> Add the definitions for a few fixed regulators found on the Fairphone 3.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

