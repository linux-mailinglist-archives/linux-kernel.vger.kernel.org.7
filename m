Return-Path: <linux-kernel+bounces-889945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7C9C3EE57
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689143B2E68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4332E3148C8;
	Fri,  7 Nov 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C58NAE8b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GoeUXU8b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8233313E0D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502896; cv=none; b=lu7QG1Ale3Y/nPSsq6PY4RkwlZVl+rHmjTpTRQ3Pa4RxKPPXsR1zLjCuCImF3gtb+eML54wiNqb+mCbC3fzerdFFRQT00p/RQN+5hE4wQaQ1Kl8hKwfGPmiGHTn2Z6lrCJGfOpIpNKUQHSZl1asPynqQlkAfsSzXx/kfD/pq4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502896; c=relaxed/simple;
	bh=ZxySiNKOJ7Uo6dLCp72RFEbCgvn+qak+fhlT0zBaY/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rd58pOgpTgfTwiUkELljsKO0YEFxv3Pgo9ZXq4ENe3+P8rDmNxMzYzzxOCIP2zgtXJRjYVEWJKICaTj9eUoDgSwf5o+sN3Tg6WQ7974InOSdDNHufFpNuTyHZZLZHWgMa2t1SQCfGCMESeVL4pRGd+YRIx3PWporZbo9MBtafSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C58NAE8b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GoeUXU8b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A74E4aP584163
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 08:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yVnCGM8cdwol4pZjBWecGHgQ48zUJyNe3I+X4UXo7pA=; b=C58NAE8b9p525Gky
	G2vFjZSFtFQr3c+PAxlCUvzMVaYoP/PefDeocRMcpiHbs5HD54E7lHnSOvwiVifa
	K75kEGN+gTBqZTKBJJ41RldeBRpy0E2Jc4BIZz3jslomGfj9kqy5DD+mY4U4CW3W
	Kyt+rPtSc2GTDYJ2Zg5z+yYVysVU0PG5iePyjsHFssLedj6auI4TurEv6dFT7cQM
	CqeRe07SU2fG6LXxlMo+sfZBsqnwOSKr6ysAr67GSze/qo86hW/rqOzRPdDpls/+
	+zqD3GPPt/0gVrWpDXixUbBwPLklm6UP9vJVzEVO8Uc7eCoRZs9nw96xZJ5JmU/e
	jZy4Pw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8yktj9fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:08:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34029b3dbfeso765954a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762502893; x=1763107693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVnCGM8cdwol4pZjBWecGHgQ48zUJyNe3I+X4UXo7pA=;
        b=GoeUXU8bgRdGQqU1ENxSI+7jyvWoKR79vRApM5MsedxNyHL/tAQaOvEE2Bb4VHI9Tf
         ht74fuSWN28Q/nKQfu0mSNT/G9YOWMr/QHtksekWmwPHTttQY7ANgIn5xCeJkmp8cHqu
         PY7vrNDXPcwYIjLs5G1uGHRwBw0a2ymqDZ9c04RwszO7dpFiDxk32uPJTEnQkB7a0vui
         V1B/pdFnWql4WhVnOMBPSo0Y3sYO8ko4MU9Dv8XMYvFk768JHqUxouhX3K0mhm6ccDwa
         +R7MHVVFz/xllTCRTteN0F/THa5a2b0CFG8jtPmvqBzTL558JYPN8uPxuB+5cf1EDtra
         GHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502893; x=1763107693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVnCGM8cdwol4pZjBWecGHgQ48zUJyNe3I+X4UXo7pA=;
        b=hnRJv2a40rof1scrMfdn96WRYMRl98sLaafz/7d9etbTZZEhaqwcq2IFR3SAxamIuv
         818EoeKFM89rQGfJoUDMvTvwBsM58Jz7Pi2rY+W6VDXgIylXBiMtxI6UtrHGdHRgxBhf
         KlMxOqgdXLlwOn1S8W4VlApQ/ioIQpfpYNm20DrcDp9IlM4fBdu+EzTbiy+JD0Q5NKpo
         zQ2LTZPVI/Xz/c+4HyTaO2AqkMAMxMyY7AIE1vOK7Lh9n6mjoqe9vI7KPOsu5w4ok/fO
         2TTwJwXHu0pFah2AWZ0domnlSsNPif4D9UD2BQaqDxd+NKPnBNOaa9TJ4HSEI5g3mQG9
         /ovA==
X-Forwarded-Encrypted: i=1; AJvYcCXcnzUk06b7t7epSNJ/ye4osrL2oPYagS7WXezuxRgRidW7ZY8HxkeugNQdoR8XgX2m+KP4/diuJtSgumY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytwzkMU3DG5OC4gbIOZ+9DU0SFE4x1Xn4VfeuJ8izSLR0xjWEu
	RzF5TuNpcgLKRhYrgYiP+973ssL9JLAJ4qZQrIwHV99f/oWhiplKEzdOGfQg47jpBfI21PbdZKr
	lWtXaIha76jNcUm/8kOBR8vUHUZW1sEBkmeA7kbWHdzynmSKKjuExo2Ztf6qU172M3TM=
X-Gm-Gg: ASbGncussj8KCNHVEwbf8gB0ii/e8ZaYueCnTbLQMzsP8+5sYJ+nwEfY69Ug0livOVm
	GChIGaU7/RpqO0NvItfoprur/OgrR6nz/vuWiyLB8hwz3c3zjH/ewqmf4kxUMsE55TiXB07Dp59
	hcUIiVe2bVyJFOggnYxv9Yi9pBnDbCYPCRbm5iHZMEqOljQMYAd+szHrRScAcMYuykK4njtP2gO
	UXWxTeUBo8fO7WZC3sD8tx/JrbL9z5U2v4DcwJbWeYhOI+zB6h0Yxpb51Ta0W8ll+4P51/SvdTW
	njG0JSyClUELydCSvozISZASGbk+s2AfZvGV9pJQpMncPy3PH83fDhulqPYO3+DX75c07DbXpoG
	FUCXISMK2iTuVPug9
X-Received: by 2002:a17:90b:2f50:b0:341:88c9:aefb with SMTP id 98e67ed59e1d1-3434c4ea126mr2240854a91.5.1762502893230;
        Fri, 07 Nov 2025 00:08:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1FwVg6yQU1EcNZvCXM3C9fT1xMu8vEORqyrlogZ+caF7N9+pZ1qv8BXFFp26cya3NewfKAw==
X-Received: by 2002:a17:90b:2f50:b0:341:88c9:aefb with SMTP id 98e67ed59e1d1-3434c4ea126mr2240800a91.5.1762502892681;
        Fri, 07 Nov 2025 00:08:12 -0800 (PST)
Received: from [10.64.68.86] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c3357bbsm1837440a91.12.2025.11.07.00.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:08:12 -0800 (PST)
Message-ID: <ee2ddf1f-0403-414e-a77b-9c20431c50fb@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 16:08:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 14/14] arm64: dts: qcom: qcs615-ride: Add PSCI
 SYSTEM_RESET2 types
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Song Xue <quic_songxue@quicinc.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-14-b98aedaa23ee@oss.qualcomm.com>
From: Xin Liu <xin.liu@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-14-b98aedaa23ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bOgb4f+Z c=1 sm=1 tr=0 ts=690da8ee cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=n3IlsZjKbDuTWdq3ZzcA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: IfPIQRUwQIEmFL4TZnxgEKWWf-BxXTAN
X-Proofpoint-GUID: IfPIQRUwQIEmFL4TZnxgEKWWf-BxXTAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2NCBTYWx0ZWRfX+qLBwP6zfAIQ
 gp1Iek95fzjqtAI6tqiHnpFtus00fToI6OXZ0gfp3NDzvXT2nmMs6X3EPme8AJEyShq70FyiuwM
 5YOhZQZYYrejD8uFufdf0Qpr3lYUtnVjtR/53bA9vEaMv7kbJwFTlFAatghU2smax74QAQvkavk
 0Lowxq5unS4Pc/p9OQEpKQGIil2HNXsE6VKNOmbAKKMzaOAwx+p/XQdeefFzpHNmYdWadVTzCAO
 6DJyWbC1KXwnZdP1Mq8ukb5/5VirVzvx0pOFPMntcN0Vvqi5YvxEWmAx/7I0SNOtJ74J70BwoNb
 PjgdCYQipB2eIN3qcczmlSiE2guB08wSvJAS9UwpLPr83AZ7V8yFXx9rwhmQ8DTtEkvqlab4Xcv
 zhqwaUYZeW6jTabFbLzxmlDh7DQKJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070064



On 10/15/2025 12:38 PM, Shivendra Pratap wrote:
> From: Song Xue <quic_songxue@quicinc.com>
> 
> Add support for SYSTEM_RESET2 vendor-specific resets in
> qcs615-ride as reboot-modes.  Describe the resets:
> "bootloader" will cause device to reboot and stop in the
> bootloader's fastboot mode.  "edl" will cause device to reboot
> into "emergency download mode", which permits loading images via
> the Firehose protocol.
> 
> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Tested-by: Xin Liu <xin.liu@oss.qualcomm.com> # On qcs615-ride

> ---
>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 7 +++++++
>   arch/arm64/boot/dts/qcom/sm6150.dtsi     | 2 +-
<...>


