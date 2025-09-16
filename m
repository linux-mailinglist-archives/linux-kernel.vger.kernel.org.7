Return-Path: <linux-kernel+bounces-818032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CFB58BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1862A81FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09733126C02;
	Tue, 16 Sep 2025 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mm+qlQXJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E74C81
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989917; cv=none; b=uhf7bxVA1JWaDcMrE1OHB5LirPr0jiJesV+fjDOK5exOEHrGXCjpj6F02wrCSWCys7qF4Gdywmwi2trnZdB22G31gxlavS6XHrTix9U41xr9LGVIlOv5R1/2it5kIRA4y9+DcJC5pd3s4EfOBK7aAXARoRqavfVtjDwnp/+lMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989917; c=relaxed/simple;
	bh=4++fnWEvY6eDmK6WVvP64PvrKxXbk3rdz0KqSZeY+4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKLQbk9bC0bqyYih8NhMrSiAk4Ju2EEgcOLGCAXoiJfhlv5zDKZv6UepLYVaRB4Fk0I0R2BDH/zIbaueMRoKOfwp6EoOMlsqncJ7QSAYR8XgE2TxeJ2iphSx4gWLZrcTYo4SE642MEebhXc7gYjipk+hD5DpH2gA+hhALKtWtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mm+qlQXJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FG1uqv022205
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mj+4DIC4FtIPwgZ5/qVKO3t6wbGyHNH2P4AZrpJL7T0=; b=Mm+qlQXJl1VaizLr
	wSM0NdoKUrX6uPom3OBAi5adxVMBKqwqOqWW6ejrrRgoBdHLE5qlPMrvT6e+VKnE
	ZVkdzOQkdbZ5nvPpPJmDi4PUiv101evyY3XIgp7oA396dY6qViMTG38F38VWGI6g
	d62E0DFa+jvvbKEFo7FD68eUVRhUjI9r26dp5bfCL+H7ebgsmuoN0aWZk65L50kk
	LrewTHg7dWq2+2QzcbJWXSErOgD0uo6HnTm93GK4kGvZYtXO0d5QXbX+neylzeSc
	bZ3P+I6xwpR7nuJ16ZrbK0PQPtTSPb/PaS8JErGkYaGg0h1e7esJgbPL8IPqYdld
	nuynBQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n2pxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:31:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7724877cd7cso4993292b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757989914; x=1758594714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj+4DIC4FtIPwgZ5/qVKO3t6wbGyHNH2P4AZrpJL7T0=;
        b=HdcR2dnHm6p3eLTu1wVT/xLcefQqlXEsBwE1dn3KOqGP0A1pxRrT0K4Ao2EwVQGB96
         Big/qlbDFdBjg9UJ92j+T1omEwa7l82Miz/YBFiA8zy4Qvkaw9sLsIEv47TF+6K8mMka
         vwFPHfybZIXG6YihGTG1++VWWtPBDJHcO14ywUlTNsv88KJ7sfhbRIyc8gUxmPqcTQqA
         aKVHR9YLMOpSFimJIfW/QFeC9kxPYyJXR1YaecpWs0TbObtH4+rWCxWoK2M7lI9nqftT
         LYvu+l/g5BRFck0bHMhgLbmg5lGJc0RbHJaITmrv7y4YkMC0fgnRsBvUlNlTSIn82UeQ
         IT3A==
X-Forwarded-Encrypted: i=1; AJvYcCWn9nRmS7loQuGjffM4kkw3IpjXlK70nMzzAL26Egg9aBQVlg/ChKuxtXcIyXB7hiO6KYZaEvWxZ+BBzCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsG3IXvNB6ZXKAp92jZSRcfHQn9W4pfwiWAwZ1TMupwuPquW9W
	Ota41/9xg+FYeXi2wm6GgK74V6r7oYiURgxnGb63eAAowCR+kafDu8tbnqlAWVqgZtH3hdWa+Yg
	R8TYb4ECr9BUyQmxxKhJVgaxnIr2HHYoTv/FDv68AygXJeQPapZmc9X409KiUuyeaXs0=
X-Gm-Gg: ASbGncsrbsD12jKunaZO3OHNasugRLJaJfBHSBrty/5Jw/J9BHH4Otz/YK0qjDFLeus
	tYyYulqgj9Qkg4tfzMVB4Kf+3c2HyxmtO0Ex1lInwrta4KplFK5UazjJsBrLCxNxQfisxmRKSWZ
	yv6PFy3HeEPHupEgouQR2ePboNgHpXTR/Wi2xObty6iZDcEKtACbPA1Q21Pm5QGs0FCpDKaCZyN
	dUQpNUML14tb80SkLW1vOqqlgxcWL8MYPCVjxBkOQdzIiutO1q7RNr1KyRQ5vianXtNIDrCAwaj
	2hp/CzZfshq9AekBhvSLq+yOmXDs4xFy+lBTlB7XlhCj3QAUGRZnCCFtY/vrZawPd9x/s7YDNvb
	BLabyrlrxCF7xPSTJjREtV+2YIdknpKPA7g==
X-Received: by 2002:a05:6a21:6d98:b0:24d:301a:79b1 with SMTP id adf61e73a8af0-2602aa89c92mr19480577637.15.1757989914138;
        Mon, 15 Sep 2025 19:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGobrdOnAQJkdYAoa+zOeKuaa8r9jXR9CcquiRwbwPK5Q7sG5dUgcn7ckySyY/fCdIk4y0zFw==
X-Received: by 2002:a05:6a21:6d98:b0:24d:301a:79b1 with SMTP id adf61e73a8af0-2602aa89c92mr19480549637.15.1757989913655;
        Mon, 15 Sep 2025 19:31:53 -0700 (PDT)
Received: from [10.133.33.240] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b877bsm13162406a12.3.2025.09.15.19.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 19:31:53 -0700 (PDT)
Message-ID: <0cf4b0fd-e468-4aab-9ec2-38da93435557@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 10:31:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-3-6f6464a41afe@oss.qualcomm.com>
 <gk2ho7ugp35kb4x65meqsm3aufnry6srr4p7jspf6xyn7ywzkh@vd5ca7txjdk6>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <gk2ho7ugp35kb4x65meqsm3aufnry6srr4p7jspf6xyn7ywzkh@vd5ca7txjdk6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AE6_op-W-nCLewZfEU60sjc8CLBORZoI
X-Proofpoint-ORIG-GUID: AE6_op-W-nCLewZfEU60sjc8CLBORZoI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX4D8w996i+Wrz
 i5CC1Zq8KMUCAYl15Yzyq7HwTrSDxQKystMX6h1tReYXC1c7D2gMg6HPVNtzPN70i3/AoCoOt5x
 EjkHDbvhwNPIa54dN83wyr5fCwIF9yws9qpgZKwcDLWJfWMwKPyRwOF49mmm4t2+l4jtEvnvh5B
 F+YghfyFCzU/d4JhA9n/2UkcoE/DLYBYUfjtoefeZekvGP02+bmj3MMCCkAwDHS+vmvT78CczsG
 cQj+nGfVLuCFXqixEQvVdOiJLTE6mfQHgWy4njf6CgT6UCezcOJ7AOJt9YZxNCx8thtrcNnIzPU
 tjZuXDzDVsO2K2r1NRmg/eu6bCrwiwpmW//Fd3moJW9+h/iAHiqCRsrqIZX12arh0OdNvPjVi36
 1KqQpCc8
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c8cc1b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Hj7Mza36WnbFS9u3f7kA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087


On 9/15/2025 6:18 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 15, 2025 at 04:49:55PM +0800, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> Add power supply property to get battery internal resistance from
>> the battery management firmware.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> T14S is X1E80100, which uses SC8280XP-specific sets of properties. This
> patch changes only SM8350-related data. How was it tested?

I assumed that Neil has picked the series of the changes and tested the 
charge control limit functionality on his T14S device.

When I run "b4 trailers -u", the tag was added on all patches. I will 
remove the "Tested-by" trailer for the patches with functionality not 
applicable for X1E80100 platform.


