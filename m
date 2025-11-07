Return-Path: <linux-kernel+bounces-890115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F3C3F3F5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A920B188BBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9389E2EA75E;
	Fri,  7 Nov 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gkO8w+7A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IfvuGPKr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586CF2701C4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509001; cv=none; b=GT+m4rYtpr/T1p1JRkg6qImq3F0pu42+sgMQt2vC7TaiZNAkHkyu41IcTNcP928FfAJ/U4FMbhNFGyfVSpv4JpzVNwigsU5HIaV2xCn2TQkTbFiqu6Z+9lEVpY/oQ/XLhZwDuOpxhzYcHG4CLNyRJVS9tV2RPjpHcowAMUnnzZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509001; c=relaxed/simple;
	bh=/ZxHNm19lQ8PeTQeuHqgdpQBpLwi+8y4QRpRtkDWgr8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dQ/FLC/AxQHvLE4eXGlmbC5MCV4IilVJSAZ/56RB0QL+gu9PJyfC8aM8yWUavAisMZS5VklZYGbpdwTv/7FEfVlZDkNoKd1lDlnk7HRwhfITDtoWP4NjqRhD22GDIuykt8SLeQqgrxwm8uhjG6bnEJEpSxs+my2RDN01OpuF1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gkO8w+7A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IfvuGPKr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A78Hn6X4131423
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 09:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dTHRFYJ1WMv+O+OJg71Qlu
	i13WEvTb6Ij7B/xGqHvAU=; b=gkO8w+7AiEK/i4pYbK3AXq6OCHuNMjcD3JlyHr
	Fiw3qOBbCK5hi+28hVoiPBTIy7xDUr3C10cAO0/TIPqRi49J+FlF69fwWI/XeXTg
	MXIP5VfnLke77tSFF4j/dR3n4y6t0fe5l5tCPE0mYpvfArWritQ3ZO1Of813mif4
	IXAUoGpvQIhMX+/BrdEwFcXXzV9R9b3jJWijS5dCg1DT357tNZJePxKNygE+uH2B
	WBE8F+LnQzwR8wXhAJn38pvVci6BHjRkAa7QS38fQGVXJ4QpowxxaUeaUUxZI1+X
	v0Yj0u+ddiajqJjzGxfBkvKNopJKoEL13H6gUQWPBSTNJLzQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u3x3k4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:49:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958a134514so7578045ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762508998; x=1763113798; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTHRFYJ1WMv+O+OJg71Qlui13WEvTb6Ij7B/xGqHvAU=;
        b=IfvuGPKrE/7PcUDtbc6zVbq6J0RwQfyfr6OT7pApOVUT3sZBTUlzcjwiZeW5KA0OA6
         nIBHcasNrpG4JeSYDABKJdinQKh+YKuqTLZkq2hdZec80NgzA3Mt25NRv1hsSGt8dMV4
         +EgrOZH+3uinz4YRUNyZPK7Uvr+IQP6J+NcLd05t9wjdpo2zjoN64hetpZ4kMjekx/I0
         Z9WWoiC2VdNNHmSsE8SLYMGb/g0YgJrSRqAKNYUGJwZrWgzVu+1sxHmS1whGYys7ELCr
         RKCUsPgEp98GuswQAM1ekN1sToyZYojG3lNGD2j6p69IxpNGMRw2kCHItAxG8IUGb4Nc
         13Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508998; x=1763113798;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTHRFYJ1WMv+O+OJg71Qlui13WEvTb6Ij7B/xGqHvAU=;
        b=OdsCrCf7vUGJyyDPcg0AWaxqW9tOI3bQl7yf6QttfOB7de4brqjqAukzqy0wA+6aJs
         ZXyLh2mfQ4fU/TonTm+FEiDubnweu3vOvb566mdrBSzY+F8IFj++O2GDSoPeWuhQrFye
         iEkVEqarJp0rmREEAl8NbRf7wFPIJ2kxdB430LJSTdRrcauBn80RYA4XiMGGrAcZ2ZWu
         9epQYucTxFEY2zp/0OSuxgkNiTq5hmfnxhbRTBAHS0RZa4xjQ+XQTAjqukS7xFP/02x9
         fjluMQkEoAFUA9kNotNA6U0QoYmNJaeJbXwy7uFdbYD9+8LL1MFkDPtUNai3/UrPBi9Q
         STyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwuO6ATUZ4uNO6IKZ9Jr01/DeHnqID4kFoqOtOpjRknYUDD9XYHb1FKZRnAoy2Lc3Yf73s19XJiOMaYGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1pRoWWFxRrZK3NGjYQOu4Is6OT6V2VKr8LZAjcxXODmw8/YjW
	v21EEHvAB2SGlEOWfBem/Zlst5yuQccGCjpsuCU8NyLKZTlwQNtSy8W6Ba7eYHDyzLurb1AKxoC
	RDKjb50zNhmXExqMXp2drLaPI610FouzQu8yDa1SvjgybYFAyNij6zjrvtmDR37yEUXs=
X-Gm-Gg: ASbGncuyRYUV0N+2psv+xXf1qFt8JWRHyqxKbVic2lyYoQIyUYvW+Xxf/uRGrq8ESc9
	AQCvg1yTxsMFBpLaICodNP1tFWiX29crjc899JLl+0k9179/oxhGNsG5+bJcMPKVLfqNcXwThDI
	9DapNs4/U9aI/YI212MGS0GCiArAc0wo5xMpoJzn9niCly29vyGCKhbUCdQN0vQXGU2VJ1gw7cT
	D6P1U7G5OfDlgtkaJiD37FRZhyvsIlKdYpVkbUl4Upg9EvovOinXeJy2F8vEF7OBfo3HhhqvKmW
	9bEjlviojv//zwAvf3WQXmJNqCK5RzWXzBEquLldhzcJf1psmbGs/yWtWUEKcrm6Hsyv7Os6Np8
	JkH/ct75xspYta60iQoTaXXFc2xKJes/cyA==
X-Received: by 2002:a17:903:384f:b0:270:e595:a440 with SMTP id d9443c01a7336-297c040a72bmr32762585ad.25.1762508996949;
        Fri, 07 Nov 2025 01:49:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhtY2SGWxq9iLgeSlohLfIqxjeiYdldOOqQcQaZGnCNL1D1PFMqODFJt6ggJmNFtJ8YpOjhA==
X-Received: by 2002:a17:903:384f:b0:270:e595:a440 with SMTP id d9443c01a7336-297c040a72bmr32761925ad.25.1762508995922;
        Fri, 07 Nov 2025 01:49:55 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5f011sm54975895ad.25.2025.11.07.01.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:49:55 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v3 0/6] media: iris: prepare support for video codecs on
 Qcom vpu4 platform
Date: Fri, 07 Nov 2025 15:19:35 +0530
Message-Id: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK/ADWkC/23MzQrCMAzA8VeRnu3o15x68j1EpOsyF3TrbLUoY
 +9uNlB28JDAP4TfwCIEhMj2q4EFSBjRdxR6vWKusd0FOFbUTAmVi50y/Nr154QVeG5tbZwRJRS
 mYPTfB6jxNVvHE3WD8eHDe6aTnK5fJV8oSXLBQSvtREnjqoOPMbs/7c35ts1osQlL6gdIIYslo
 Aio883WgbSmBP0HGMfxAxzKB83qAAAA
X-Change-ID: 20250924-knp_video-aaf4c40be747
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762508991; l=15943;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=/ZxHNm19lQ8PeTQeuHqgdpQBpLwi+8y4QRpRtkDWgr8=;
 b=Xb/4LpcrKabaKUldN0vUqvDKozmM8AYursAXKLJmCLn1Mk8BEbYKQ2BQ6fix8kPkjUx3+bIQu
 bb1YW9eM+51BU9DtcIIHTbQr43IMprXrAnKk5uvGWZxgscswSR7ym52
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3OCBTYWx0ZWRfX5WSbaUvCtqUw
 2/E1f9fmVje6H4uOdSV/xfT6TVJq1gX1pjm+PuskVWMotDaeP2/aJQK7KSqrDerL0HAwGTe9uES
 luo1TMRNuPyaEq5ty+Jt1Wa6MS0Qrw5uW1AqStL/s7Mgs+t+uGHjFm3Yh7Ha0Vm33F1TNhqE9/Y
 UigEGQ4bWuME2JtrT9QD3BZSZR+X40uWCNWbOgQGehSdjsQcw6sxeS0C/ZupuNUjk4g0YV1Ty+w
 uDltH/zhMVZo2FCyIkXlsonDarL0FPr90/7kE/y1RRJcd3GuNGBNi+A0ylSfgRV3e5EmfXkk3GI
 fgVmIcukuwUFsU+aQASrUEAvwcNRMl/IzCOueo91adGUODxBlXOZJfRvs1KmF4IWGK6YLTA+QFG
 JVVR4BsIY3zvBbciruqLHc+1WovcVQ==
X-Proofpoint-ORIG-GUID: gQhWSj3bWsvHhf-Qma6QDzJtKbVrXgV6
X-Proofpoint-GUID: gQhWSj3bWsvHhf-Qma6QDzJtKbVrXgV6
X-Authority-Analysis: v=2.4 cv=BrKQAIX5 c=1 sm=1 tr=0 ts=690dc0c6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=j8pLvHWEjehsjOGDu-oA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070078

Upcoming Qualcomm kaanapali platform have a newer generation of video 
IP, iris4 or vpu4. The hardware have evolved mostly w.r.t higher number 
of power domains as well as multiple clock sources. It has support for 
new codec(apv), when compared to prior generation.

From previous version of this series, the kaanapali binding patch(#1/8) 
and the compatible patch(#8/8) have been dropped. The discussion for 
this is captured here [1].
The series introducs buffer calculation and power sequence for vpu4. It 
prepares for vpu4 when kaanapali is enabled after the binding discussion 
is concluded.

[1] 
https://lore.kernel.org/linux-media/fdf4c469-d276-4f64-b13d-5266cca7235c@oss.qualcomm.com/

Please review and share your comments.

Following are the compliance and functional validation reports executed 
on kaanapali(vpu4). For the series to be functional on vpu4, patch #8 
from version of the series need to be explicitly included.

v4l2-compliance report, for decoder followed by encoder, including 
streaming tests:

v4l2-compliance 1.31.0-5396, 64 bits, 64-bit time_t
v4l2-compliance SHA: 3f22c6fcee75 2025-09-18 09:49:23

Compliance test for iris_driver device /dev/video0:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Decoder
        Bus info         : platform:2000000.video-codec
        Driver version   : 6.17.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Decoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 10 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_REMOVE_BUFS: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)
[  328.905995] qcom-iris 2000000.video-codec: invalid plane
[  332.917543] qcom-iris 2000000.video-codec: invalid plane
        test blocking wait: OK

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
        Video Capture Multiplanar: Captured 21481 buffers
[  350.438406] qcom-iris 2000000.video-codec: invalid plane
[  350.447079] qcom-iris 2000000.video-codec: invalid plane
[  350.458821] qcom-iris 2000000.video-codec: invalid plane
[  350.465860] qcom-iris 2000000.video-codec: invalid plane
        test MMAP (select, REQBUFS): OK
        Video Capture Multiplanar: Captured 21481 buffers
[  363.878157] qcom-iris 2000000.video-codec: invalid plane
[  363.886546] qcom-iris 2000000.video-codec: invalid plane
[  363.898475] qcom-iris 2000000.video-codec: invalid plane
[  363.905527] qcom-iris 2000000.video-codec: invalid plane
        test MMAP (epoll, REQBUFS): OK
        Video Capture Multiplanar: Captured 21481 buffers
[  377.209312] qcom-iris 2000000.video-codec: invalid plane
[  377.218027] qcom-iris 2000000.video-codec: invalid plane
[  377.233635] qcom-iris 2000000.video-codec: invalid plane
[  377.241360] qcom-iris 2000000.video-codec: invalid plane
        test MMAP (select, CREATE_BUFS): OK
        Video Capture Multiplanar: Captured 21481 buffers
[  390.624700] qcom-iris 2000000.video-codec: invalid plane
[  390.633590] qcom-iris 2000000.video-codec: invalid plane
[  390.645629] qcom-iris 2000000.video-codec: invalid plane
[  390.652618] qcom-iris 2000000.video-codec: invalid plane
        test MMAP (epoll, CREATE_BUFS): OK
        test USERPTR (select): OK (Not Supported)
        test DMABUF: Cannot test, specify --expbuf-device

Total for iris_driver device /dev/video0: 54, Succeeded: 54, Failed: 0, 
Warnings: 0

Compliance test for iris_driver device /dev/video1:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Encoder
        Bus info         : platform:2000000.video-codec
        Driver version   : 6.17.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Encoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video1 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 38 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_REMOVE_BUFS: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)
        test blocking wait: OK

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (select, REQBUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (epoll, REQBUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (select, CREATE_BUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (epoll, CREATE_BUFS): OK
        test USERPTR (select): OK (Not Supported)
        test DMABUF: Cannot test, specify --expbuf-device

Total for iris_driver device /dev/video1: 54, Succeeded: 54, Failed: 0, 
Warnings: 0

gstreamer test:
Decoders validated with below commands, codec specific:
gst-launch-1.0 multifilesrc location=<input_file.h264> stop-index=0 ! 
parsebin ! v4l2h264dec ! video/x-raw ! videoconvert dither=none ! 
video/x-raw,format=I420 ! filesink location=<output_file.yuv>

gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 ! 
parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none ! 
video/x-raw,format=I420 ! filesink location=<output_file.yuv>

gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 ! 
parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none ! 
video/x-raw,format=I420 ! filesink location=<output_file.yuv>

Encoders validated with below commands:
gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse 
format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc 
capture-io-mode=4 output-io-mode=4 ! filesink sync=true 
location=<output_file.h264>

gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse 
format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h265enc 
capture-io-mode=4 output-io-mode=4 ! filesink sync=true 
location=<output_file.hevc>

ffmpeg test:
Decoders validated with below commands:
ffmpeg -vcodec h264_v4l2m2m -i <input_file.h264> -pix_fmt nv12 -vsync 0 
output_file.yuv -y
ffmpeg -vcodec hevc_v4l2m2m -i <input_file.hevc> -pix_fmt nv12 -vsync 0 
output_file.yuv -y
ffmpeg -vcodec vp9_v4l2m2m -i <input_file.webm> -pix_fmt nv12 -vsync 0 
output_file.yuv -y

v4l2-ctl test
Decoders validated with below commands:
v4l2-ctl --verbose --set-fmt-video-out=pixelformat=H264 
--set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
--stream-from=<input_file.h264> --stream-to=<output_file.yuv>

v4l2-ctl --verbose --set-fmt-video-out=pixelformat=HEVC 
--set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
--stream-from=input_file.bit --stream-to=<output_file.yuv>

v4l2-ctl --verbose --set-fmt-video-out=pixelformat=VP90 
--set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
--stream-from-hdr=input_file.hdr  --stream-mmap 
--stream-to=<output_file.yuv>

Encoders validated with below commands:
v4l2-ctl --verbose 
--set-fmt-video-out=width=<width>,height=<height>,pixelformat=NV12 
--set-selection-output 
target=crop,top=0,left=0,width=<width>,height=<height> 
--set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap 
--stream-from=<input_file.yuv> --stream-to=<output_file.h264> -d 
/dev/video1
v4l2-ctl --verbose 
--set-fmt-video-out=width=<width>,height=<height>,pixelformat=NV12 
--set-selection-output 
target=crop,top=0,left=0,width=<width>,height=<height> 
--set-fmt-video=pixelformat=HEVC --stream-mmap --stream-out-mmap 
--stream-from=<input_file.yuv> --stream-to=<output_file.hevc> -d 
/dev/video1

Note: there is a crash observed while performing below sequence
rmmod qcom-iris
modprobe qcom-iris
The crash is not seen if ".skip_retention_level = true" is added to 
mmcx and mmcx_ao power domains in rpmhpd.c. This is under debug with 
rpmh module owner to conclude if it to be fixed differently.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v3:
- Drop the binding and compat patch.
- Address comments related to variable handlings (Bryan)
- Pick the updates from Dmitry related to sort register #defines and 
  connecting register and their corresponding bits operation (Dmitry)
- Link to v2: https://lore.kernel.org/r/20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com

Changes in v2:
- Dropped dependencies from binding (Dmitry).
- Dropped optional items from binding (Dmitry, Krzysztof, Konrad).
- Updated binding in sorted order and proper alignment (Krzysztof).
- Fixed order of newly introduced kaanapali struct (Dmitry, Bryan)
- Improved readability of buffer size calculation (Bryan)
- Optimized fuse register read (Konrad).
- Fixed order of vpu register defines (Dmitry).
- Addressed few other log and commit related comments (Bryan)
- Link to v1: https://lore.kernel.org/r/20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com

---
Vikash Garodia (6):
      media: iris: Add support for multiple clock sources
      media: iris: Add support for multiple TZ content protection(CP) configs
      media: iris: Introduce buffer size calculations for vpu4
      media: iris: Move vpu register defines to common header file
      media: iris: Move vpu35 specific api to common to use for vpu4
      media: iris: Introduce vpu ops for vpu4 with necessary hooks

 drivers/media/platform/qcom/iris/Makefile          |   1 +
 drivers/media/platform/qcom/iris/iris_firmware.c   |  23 +-
 .../platform/qcom/iris/iris_platform_common.h      |  11 +-
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  33 +-
 .../platform/qcom/iris/iris_platform_sm8250.c      |  21 +-
 drivers/media/platform/qcom/iris/iris_power.c      |   2 +-
 drivers/media/platform/qcom/iris/iris_probe.c      |  20 +-
 drivers/media/platform/qcom/iris/iris_resources.c  |  16 +-
 drivers/media/platform/qcom/iris/iris_resources.h  |   1 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 199 +-----------
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 358 +++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 342 ++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h |  24 ++
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 188 ++++++++---
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   5 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |  61 ++++
 16 files changed, 1026 insertions(+), 279 deletions(-)
---
base-commit: f215d17ddbe8502804ae65d8f855100daf347061
change-id: 20250924-knp_video-aaf4c40be747

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>


