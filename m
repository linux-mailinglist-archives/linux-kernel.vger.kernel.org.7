Return-Path: <linux-kernel+bounces-818644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985FEB5948F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C013483A43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4512C0F83;
	Tue, 16 Sep 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxxFqk+s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278321578D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020430; cv=none; b=oBi/ZVyLgBcg3YmFte1s6VzsbkHu2gmDUHG8eifs15Skx6R1mis2kVeUOKMXHHYMLYUeKKC38uepbt6gntfRhJXj+xvpF6Ti6U/ZLzlMkz2JC9v7ltMXQ/ZXEZCPRofI+nakM6SoUNoA74M0hcJrKXUOallK2VbTScOMBGBfTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020430; c=relaxed/simple;
	bh=M6Zqo8Ymcxu6eRx/7fcnIg/xojiXutzI75zXFiJxqNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sanxoo/aXgPq8PmRGQPus5xETOygGUfmV0odf8H13B85AgmoZ4GJW1w/3a0ogOI/qCvKfZQjtb49HPSl9MBUhZDphuUepWGZdxdxRn6OctW8gUsROjttXxzMD0QfLrUO2DJpbImlU6AcD+jXNoPoVmvzGUpVDuoHRPajz4DBQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxxFqk+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAdiEY018564
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vH/Rjq1TuanzbCVidX6mw4sX
	aElF2T/40jPPuQxAJJ8=; b=cxxFqk+s3TclutWcPBPpzYKxUvMqL8f+BX1NlLvw
	ABaC7fj13xTysRPsNiqHutQuPgUXUfajjvhnPcgnpF3yFjWIDJC8tU0AofVVaW8q
	b+A2/WlC8ytZpKXSJSWwCR9IUSv56vUbt5zYFwbxV8qRkdMEIqNaNVnek+qeUd3R
	aOyLlZ0T9sbcnTkZsSV126/F7ICaKJFIN8DwiTUrfEiT+ksKZDUAgIKXUmLOzCSG
	tpiEucz+MK2winOlvCc7US0oDuiJqYqr+hC81zk5kAIZkcezCUHAzvC4kZqAtD9j
	aW/LUY5E9540RHna9YvXk3SxcXqqWJMQtGOJL3t1alw8/w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da9cytp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:00:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b78fb75a97so33390171cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020427; x=1758625227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH/Rjq1TuanzbCVidX6mw4sXaElF2T/40jPPuQxAJJ8=;
        b=iZ+jH35LQ3l/PveUHM4juHU8RVIfnwkAdmFmmjSADPJjPYcXPB6bWoIalSZABJsl49
         SSRccBYRRuAr4mXnpLX8wTF7yjJOHcHu1XGWge18YYlYI11VYj7Ma+fQILYm93G2qVAp
         yPYX/gjT/R+uPw8el7Ag/J2z9y/vp2Nz1rRspip6ooOWlOHmb0aCY08XEvM7Gc8Mm/IL
         BjdTjZcEbnSF22MtD5minYPZF8ZT3gx76hBizu7cYe2XyebtrAW/8KR/CW6XhCucADvi
         TqEkYNIOvRrBo+6COlvLttT1U6kC8gOZKXGALd12lFWqOXPk8GjieJCbNF6Rpfi19yoB
         gn5g==
X-Forwarded-Encrypted: i=1; AJvYcCUtZiKk7q2hNBYPus8nzB200AorhQGJgJdNVR1YFDbwoK+uf7f95voRX3dk2CZUuLUclpbg8Xwy4UMtDUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dcXQBvMXZ/efRTF5eZ41g4F+9hcRLECu3/woUHo8TmjqocSf
	lAM82unTyhFTdIk23NveoBIwEy3H0VxBs+45FO9mL8ncyUJ5XhPaAVfo98zVyfneJx8ruItbdif
	NFX2eCwtV5Q22oRIl6cBg4SrK6GlHX6szpTAomWDoXvEmwx8ZhCtHtRiJ0CnAmyrLQNU=
X-Gm-Gg: ASbGncv+cxm5edmlq3P/Wlq4CXh3/YJ72y06k41+SS80AsyOE8EDzq7hrpK/8a9t2xK
	NGatJSLcyb5dO2NkDUV125NbZzw0c2YgC2GD+VmmLUjM3KP7wGtGSqEWR5gR79EKywTEkVLzIIL
	JiXa51FrsSWMkT65qXITuAL/FtczSSVKSpIV9V8+jQE67xDp4wndv8g/ygAlw0TkqnhYTnL/SOv
	xI+r1I6CfPlnbwOScqxT0LGs1IeHZLdDwFDg1AB3CcGIsg3Q8pi4bqdmWsbRQMwImMsFZImCy3u
	JXTmNx6AJaCvtlVlP3o6Wnel6Le4iUKqrwzMiSDzpQ6rCLjDCUuXqEUmxt46QC8viIUnLNbec4b
	iu60wv5gOLf3w/12LjCLvidZ6dvNRglM4mFEzNgipUyJqn4oZZph+
X-Received: by 2002:ac8:5d04:0:b0:4b5:e12b:9e1 with SMTP id d75a77b69052e-4b77d0aff86mr159715141cf.60.1758020426810;
        Tue, 16 Sep 2025 04:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEqyqBzvf06O0P8M/2FvHMvziCp9UQog00iNc315yVML3/M3tQIwWCuaULaNoan+pHArDzpA==
X-Received: by 2002:ac8:5d04:0:b0:4b5:e12b:9e1 with SMTP id d75a77b69052e-4b77d0aff86mr159712941cf.60.1758020424897;
        Tue, 16 Sep 2025 04:00:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63d9esm4235593e87.70.2025.09.16.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:00:24 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:00:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v5 06/10] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Message-ID: <kq7dqqjaw5rgdx7nubycj3wuwqor63e37vploqw3efo6qa4oir@faorattts2vs>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-6-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-6-53d7d206669d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c9434b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=woMd_khH0HIeFH28_EQA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: q4FXF81APViPqydF85MNDl4ckq_grdm1
X-Proofpoint-ORIG-GUID: q4FXF81APViPqydF85MNDl4ckq_grdm1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX5Y8VZlWc01Ea
 h4F5fwzBhJkyadGZMU5ktslfUiidJ91HJKAe3PxXGJLy9SM9MpeTyK7Iw3pqHG9YdCm1AGGG2Lj
 ZmdKIuBjhhdsZ0+Uc2VDr0+cCM/55Lm8XI6uGiDF8mjthbebw8ylOB2nv2zaADzQ3ngBbohopBP
 4bV/93MtHl0h1RQnao3Dhj9J+1FRThuSizj9XLI1oL40WbQTucZ722K4qX+hSmsC2ZQii+649Yj
 kyCnIUyAbwXMUjzRAnCLUNR+6+IFzfgmpnOiUpaeNby4QVNeZ+/qOBXdYs4XD1Dga1wFpKNcZ5Z
 82fla895eNqGLWs5sT+ECFx8bIv4+ZXREyJooOyNCF3H7jF868I5oZkYmX8aMcCMVA5cfXYk8C4
 axkEWv0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

On Tue, Sep 16, 2025 at 04:16:54PM +0530, Wasim Nazir wrote:
> Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> firmware.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

