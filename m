Return-Path: <linux-kernel+bounces-875590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E0C19637
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A7A64FF28F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5961327798;
	Wed, 29 Oct 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PinC6bNn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZ1ypKjs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC92F5A09
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730430; cv=none; b=BoQD6UAIvSNRz0QvcNflj2bDLI2xmDxk/p6nnz4Bxa3D5MhpC44EFENzpdSAy3MXpwrg1qWkFerfmWBidHvOe9kXiazZvRnPjD9hMMfVGnzTityVLrbTzlR5xVVDfg2KIMk7FItWL9kjighXw+Cpx6i+O520bJ+2IweYb83LDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730430; c=relaxed/simple;
	bh=rqXupnqpPNubcslAJqHJlXhLlIWio5DVNHXOUdm+UbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP5lFrD2Flz3CWFrkDde6GP98O/ANhZwivCfNSR2OSl4SRmfJ0MLfQyLmOH+YHIChUsz7DxdJ94tPyloEaFmrRYX9NhEYY0HN5tzx36dvTW/FWFs1w83TFoqllS9mgux4Jj3LxKScq4TD8ByuVsNtsaxztvx/DYFvgoFfbG/QDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PinC6bNn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZ1ypKjs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v3VX3643088
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rqXupnqpPNubcslAJqHJlXhLlIWio5DVNHXOUdm+UbE=; b=PinC6bNn37EUuD2p
	S//9W4YLzXTry7snCkLcRnxkY+YC7H2ivdlp3twtdEBTsOdzomijrYOBTWcrX87g
	iSrGIcUYzdkmyV0N4v36GXGMDBbv5wq7EDX87Sr23ivdZxgSbU/WHuvWDTWP9w7A
	jcSC2OEqWeN7fbggrLV/wKxnMWBkVGVSQKaBHjSb1DGRM+XVKnhjvkkK7/By5Kwk
	BftrQs2y+ns9oq3ibom6qpQqyGb2yWbZ+L3tgYjsAiritaZ27kr5D72WyBtle0NJ
	FoSPxaXC/cBl7WjN7p/QX0Yw7lGdHj/DTzmZbye9oGB/g0ztNjYACvk9wtWOeX7v
	1Auaaw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1j19k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e890deecf6so10797221cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761730427; x=1762335227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqXupnqpPNubcslAJqHJlXhLlIWio5DVNHXOUdm+UbE=;
        b=eZ1ypKjs13O1GG2VPg8aT68jZCxW0W55419Dm+ZLo6SKPTUsn5bbz938QxI0YxFrUB
         CQQ9xh3xPFkms2VHs3DhtzapSG8cNJTJVCP+zJEjtdbxKSjgSERxKG3iUHbB1ulwrwMZ
         uRI8wnXtOisAH5oly6fLYD5qkDvWmKYRJlyqKvbd5zHDTlGU5g08VZfXLzoIU8x3/4st
         AosPLjaqgiG0AaMIHjfzHo2DjfCv4eHTZyM2/wcVAPHFR7ueLciUB+IgD5jXELYhrX4w
         1e6LC2myfO4KbTLmhLUKjEkSuaLVI06zI75VNq4gfWRGpD8T4rwQfZXmY9RME9Duc6uk
         BMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730427; x=1762335227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqXupnqpPNubcslAJqHJlXhLlIWio5DVNHXOUdm+UbE=;
        b=k5dw2i+mUQgfz0CEl32KHFhxS9E8UzirMRSkr6AD9HjK6ph0mnrrRFjFdW6MLfWggH
         0hTDWG4788d1jRkbrAI0tSxL19c5deq4NwUtjDNJ104y6CXZzGpxZxr0u391Cr+xPzyc
         XaQUMx8t9cDkayebTXJIUuKyeGO/yQd699GewoOZcedoEEZgHLSPtdtLmAkknthv/r74
         P0DBWj5DNSLiI1HCYHzvZRejJ5R3HlXcQPNAPWxOcm5910tc1x2AhIV5vQRcmETcagxW
         LFEwHSw7bP8B7cby5JUhs0yd9qW+G2DsTPbPzanXt50ta2s8LVgMCVAUwAcsl4r+IZwg
         mlyw==
X-Forwarded-Encrypted: i=1; AJvYcCW8TgobbahmsyHjv99BZ1vsGz4z0bJYjQIUO6EJJqMvGRcHVSFg7xnXtU8JNOHRYdXm84rcPUue9hyeag8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KWrYLwjHr7bODysRDtjTDMACfH6kYfF2uxhvSDD5/2+r8H/d
	PNQbkug3dhBRxfW509anCV7yKHWSjXALiisxDld05Ap16agX9GTi8mBqsDDnCSqK1IQZbI/sWxL
	CuVngUtTrhYpBv/nbyZA45Frhu9u2PrKJxNFddON0EciFpxbL2SqIcga7ms2ABKFfkoI=
X-Gm-Gg: ASbGncvtR5CZoINPCg+JXQF8BTNLLs7OIS7rzH6AxaZ35gTAHe4VX23OGy4ZFbzBt9Y
	c+a3KXJ+t8g/L0rmdCzyCbmPfS767P5k8hXEYcwM67FqgpFVhN8PyWENtvPeroc4dvvhW4NMK53
	emswvRWzqdSYKI8+QwFcMD6/CeLQr1baGRjCi9fKUBnHYeqx33oTdk/3ZlAfCZh3nsKjPh4UoCM
	2BmVxVBGmsOiWUYTMWkux17LAHsjne5v2PsJ8xwivBa3lc9iOVbflp3HVHZ5Sa6VWmxy9S7G5ve
	jwwnm6/JA0r8RRTyGb/Pk2GC4VopwkY+L/hAgX6MSmRADVoL6LYwNbDOihOpKOtVWG5ilH3Pn65
	KhsigVA3qZaqWF+3k/gVjRCIIooGs5PZai80a1XPpMXm9tQ7t60SuQyOF
X-Received: by 2002:a05:622a:19a3:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ed15b933ecmr18549841cf.4.1761730426533;
        Wed, 29 Oct 2025 02:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjF9pxhXH4RVBPpZWHVrJvDG4x6sCWKd/Yfxw34hVbqnGHssbUIThuvcIHqmaZakQ2H9J9+A==
X-Received: by 2002:a05:622a:19a3:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ed15b933ecmr18549691cf.4.1761730426118;
        Wed, 29 Oct 2025 02:33:46 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548ed8fsm1380815366b.73.2025.10.29.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:33:45 -0700 (PDT)
Message-ID: <c83079bd-ebd2-49fc-ab62-1fba08276cc4@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] arm64: dts: qcom: cleanup GPU's zap-shader node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=6901df7b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kI9A-tbFYqiMmyZ8wAIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Luh1uxBc2Mt_XaPiA8xhcAb74-T4b3ab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MSBTYWx0ZWRfX44w4PoHc8WLd
 w5r+YAWlJFedVJnb+lU8x9OVMjHWs2OtsBtNuH6JaEatVfZktLsoh/gT26Z7lHnVHvNHHuzpLZ5
 vdT/xW30J+GfcwFoQqoSpp5aiNTAoXl8g3OhAxkxA4xiRty+aSfGoXNPLWaQiI2fgujvVqPxVYo
 Vk9kjispbjmSuTJxSrzOaxJi4g5ot9vdb3jklIgzQuv//4LptP/nZVfRiHQjvddE82aH2aj2rFy
 7TOawm/4+ynJdbcoog7u7cYH7wW6A60Jp8/j1GnJhZuvODSQcssXHkIqQHDnQ90lORQCVf6c/cz
 Pj+q2ymB4iVD3ZhBh9SYA/3MZJ/RgFW4G7ZFf2J77YipiS8TeQgFbuAJNTs8xi+eBLYI+yeYrpn
 sRBSAWyabqV3ukbsBXvcwR4g5M+dTg==
X-Proofpoint-GUID: Luh1uxBc2Mt_XaPiA8xhcAb74-T4b3ab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290071

On 10/28/25 9:59 PM, Dmitry Baryshkov wrote:
> Historically all devices manually defined GPU zap-shader node in their
> board DT files. This practice is frowned upon. Add the zap-shader node
> on all platforms, define a label for it and use the label in order to
> patch the node with the firmware name.

I'm not sure this is much of an improvement, since at the end of the
series, boards still have a &gpu { zap-shader {} } section, with the
inner one not being referred to through a label, which reduces
duplication in the single LoC used to assign memory-region, but
doesn't e.g. prevent typos in the zap-shader node name

Konrad

