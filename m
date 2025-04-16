Return-Path: <linux-kernel+bounces-604942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A32A89AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF543AA409
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624C02949F6;
	Tue, 15 Apr 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbhKyXHF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DC294A07
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713919; cv=none; b=n9z4V9fB+DCClfZCntAAWZJQWs/Lo243cOmvlXa3gu+mhflvp+U5HOHxhIrhG45w9dtmGz1DeC+87udBlXeVztbxSSK+VQib/6cduBin8k4NztIYQ/99J3uEwpDU1zMSXb0sYxpdkmrH1HqcF92xYjZyJnVawLxDuU+6ZnrkC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713919; c=relaxed/simple;
	bh=PqtFIuf2PaqgdiInwLbpBw6+hS8F+gVD8HwKtn8pZqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+kpv+zuVPZR5OcCDoSiTg/6xqtU/O16cdHfQrQjft9rCpn5Tx7C40qr2doX4eQMDQ/hPs/4hC4GBHRmfcAI21Dvo6wa4aC8XX4qn/SYm4NhMQwpmifC/PUrg31aoMlTitiUyd/TWZLGdPvdoDq8FQKrjUbBK4SknfnB6V7AAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GbhKyXHF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tSHS006072
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 10:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i+0K8i6mH8nJR7NC8EwJps6/hl4dOeR4gugtJgCdwYo=; b=GbhKyXHFtJPUNo2F
	r8lgxHB/xGMiPGs/xFw7MESJlNA/1FGzekziAesCWmz3twq4WH+96JvDKYJFCM1A
	zrFfwvuwI/GEwWkKzsneFjqWCB9zFxHeTI8mh1+ITGNfUVzUWAt4DpBCt17ZmF2d
	ZegQFJTCMwfKOX6mC2YZ18SeoQMOCOjtkvAa7p/7jMtRufbCKldlS2UK1wyU1sYx
	/UtRVsqfoe5eKrT3bkeHpZRffuL1FVEY4dYngYsm2BE7cUa0TUOTKLvibiro5JvT
	I8BCALixKxR/ubtRMzo3vK9FNwp0pO97ACRAlElyx9DyvFDNmjgd6+jowkVf9QZj
	lXaEGg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvj7wvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 10:45:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5560e0893so45720485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 03:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744713916; x=1745318716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+0K8i6mH8nJR7NC8EwJps6/hl4dOeR4gugtJgCdwYo=;
        b=j3UEHR6gXfZSQWOZNwXSn2kTbLH03ldBWi7JUali3I2VuwzlWXdrEbXXPOL8Kec2kd
         cRmgm3MoWS6CTCjSpK2uG4PpkHly0WQ6TeVSHz1GOusq4PZWU5GlBx2PZ0roDIX7oKdd
         ViOX13R+MG2vTD9NqNW8whr/65cBuQpAC8V0tyiWUqCswD4MeezhZMuyo2Uzt3/1H2i4
         BC9bg1WA2us5K+tQhj222ZZIRgu8ZcQojJnCVI7YQJovnRBk7GpOKSZJy3DSSrbFjbjb
         /Old66FnQ5xlendeAwpreTNTkRJsODJx9lbznm+j9EVYi97bD7CnixYSOQBLuskwLKdx
         Q5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCW5+J6DiQlIQrlLSnkOehOPZyymepY9cciEypyuRnL/tDzZQX/HSyQumYgjE98Jl85vTMxZ2yDlsv6d4Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFhzO2XiLlyE0oT7QRo9ktbBId7bn0L3FFPDslc2v4m4f2ZMV
	QJ4wTJl3wx0qxZNUAPYqM4zH7uOl62/mZqauihVlmwTqt9RPUtPZpc7+kVbkW4BLlGYnV4B54xF
	v/Wx4och11epAKFS5jZqUOcAK1ypSIDtRAq4xIBsIEPTmRz9b7xQXSmD8KbNrypI=
X-Gm-Gg: ASbGncstOzEo/U1Z3kF/wpi9vTmeTTbhU6WkYTNmWwMtD+10/5rkyP+DtRQX5hkMFxD
	4utrc1j6VwDzwSA40PT9UWjNw3gimrRjccHG/BIT2wCwK6/XNseaey0olGSKl+pJqN1hz/8CtHR
	V/MlmYfacVtnhPJEcm6PcA9HFVJL+Z/LZSH2EiFl+g/j8A4fP222+i7TX9sa+LgxVJ5LiYLimGy
	QZGHoif/11Uhi/ZpdC9hFbc6GyHk2k7wQBsk+aIhnyaZYvBnoy1IMMrsmfFrdKlqHQ66TpybMyK
	pl12HSHZH264QD+OQU2JSNPzYa9ztHWlJ7jp5mqi5jYMEw3XVRqoip6salGfJWP4vqI=
X-Received: by 2002:a05:620a:2805:b0:7c3:d266:3342 with SMTP id af79cd13be357-7c7af0d6f78mr895574185a.5.1744713915975;
        Tue, 15 Apr 2025 03:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyEhEvT1Gs9u/aXKE281kr5sy1k/I78whPJRn+eNoQLoEHL0zwBuWWggzm+pOs6b25mbTA2g==
X-Received: by 2002:a05:620a:2805:b0:7c3:d266:3342 with SMTP id af79cd13be357-7c7af0d6f78mr895572485a.5.1744713915606;
        Tue, 15 Apr 2025 03:45:15 -0700 (PDT)
Received: from [192.168.65.246] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f5054dbsm6781505a12.49.2025.04.15.03.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 03:45:15 -0700 (PDT)
Message-ID: <5e5e0827-633c-4175-a93d-22f841858cc5@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 12:45:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] arm64: dts: qcom: sm6115: use correct size for VBIF
 regions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250415-drm-msm-dts-fixes-v1-0-90cd91bdd138@oss.qualcomm.com>
 <20250415-drm-msm-dts-fixes-v1-12-90cd91bdd138@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250415-drm-msm-dts-fixes-v1-12-90cd91bdd138@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=67fe38bd cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=da4WsfccAxvekxWPt1gA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ptWQIPyInV5_USNR9k3dzVl52pJI2JwI
X-Proofpoint-ORIG-GUID: ptWQIPyInV5_USNR9k3dzVl52pJI2JwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=671
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150075

On 4/15/25 12:26 PM, Dmitry Baryshkov wrote:
> Use allocated region size for VBIF regions as defined by the docs
> (0x3000) instead of just using the last register address.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

