Return-Path: <linux-kernel+bounces-744509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B37B10DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF81896D05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15B2E3AFB;
	Thu, 24 Jul 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xhbmu1O9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D12DE710
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367849; cv=none; b=ScWb8rhSq3CitG7t5Q/a2fhM/o7MxFuGtYWHzRzW3nfCJu+oO7HEg7Xwm5b46tRQuOWwMbTwEmZyx5Z4YiHPUOp1DZfe/Sprfw+nsceWwftz+ZXqBSQY5VZiPzUhBTYdxqXhRLXYiXJ8yZwwrkeh2n8NJiSlHfkch+UDZnQuoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367849; c=relaxed/simple;
	bh=iKpdDrV3kOuTOMc9bKV37vH2GuPaHLNQYpIK298DPUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HE31/bZW43yORF3G6rmolTAUgvLeHQ9oNi9V2Zl9PN366/r8LMc/Q4b5u1FiCWnwgDY7zYV5jbV3f/TX/FawwNeXUvZKZF5oENBRygXubgwWyxK+eAeBBfvNNJ9mNepDZbZAVtAvXWtwADALclzfdzuvj9qJtB/UIgqufnEr/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xhbmu1O9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OA7kWF017683
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XR+fnHt/cqBwBuufCMHCP6JVhgYBVarZl6G
	D88IpMe0=; b=Xhbmu1O9XrQSBkuApyIbBeOUQ5dV+hozQWqvPq1eHl0bWT//51a
	Uq0SGquOrhR8V/lelPmCfREeZQ8AQHts3oGiEHgCuajusctPIaGG875wtO02+esi
	HOtULLor6lThCHfGhZTfNayT8UbUIuH1MHIcDzuDV+HhYWhwQDZ9dkrkTCocUSUl
	ViEEOo+qqmODjqXdYBwRjrhUmoH0XrifcIRxqzrm/gmkJaD1KYPPdDedaCoUMV3k
	Rf0VUwiloug3NktoSTHYnuJxyggp5+tD0mcVjGtfXDh/ktkDVgwSWkuklgr2urRU
	8fjzBAkjplcfyodESlyLo/xCjC5+yHXRjNg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3euvy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:37:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb3487d422so16772736d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367846; x=1753972646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR+fnHt/cqBwBuufCMHCP6JVhgYBVarZl6GD88IpMe0=;
        b=DKBdqh+hfKywiFZ7HcTr/DxqlBN+Y8SzmoJsQQdATnHVichJzsSYAnttFvrxDvq6oR
         R0oTBiRt0iXTSLeVHcNA4RI2TOxoMzMHeIXLp84tj3Oor0o1MeH+UWI92dVN02DsuBit
         7T2D75iSgPLCrVXsARLn76qaSrQTVl/G+mL0ElpbPqmTKEahUd3Tph1nxnVZvkgaC9lS
         61kADtMj3StzssYvFDJ48o1AxaRNu9Ta9bmH/URg1Gw+82DbNAyvMr8afqVgwVtcksKI
         5JPjwJZ0fBqMGk/9nXLI0DZjEI9D9/p/AAlrzXAvg4U77u6ej2cRRAeMHuR8u/nAMfFw
         wVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Nu1qXniKtsOqwpiAnckpjV+vFgOHp0WnIm39BaWO9vF5n/1XKDXSyUgZO7wg8f94I2+mdKoRPLlbCNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2MTQYIHDqLVLlVFXq8SPdTnD+FxhpDnVM6Xw/jZtkKztbjAI
	sIChQJCpgFwuiwxT+tqS48sLadVeXzFZUn1rv2wcbHfbjYFCG/tibetYVMC+O8HcJ3Qrenx8QHg
	a0PJT+gRGHIF7Q1cjK6JpSX9msUHzBQsFMlRzWAOssZwp1DDOP/cWCb+yEujNUV1IhRI=
X-Gm-Gg: ASbGncuY+iLRF/WP+ZPM7pE7Ap2c41Rj3gfoUh14wSyXnH9ib8AiUT5u99DOc8m1a09
	bclVWmjn/j2rulmjsqwJiHSWa65siH2thUpOY09p51qeZy0RCxa5fwUqi6HBfQeGp0JSki+QpTE
	CxTbRSW9Ri+Q45p8Qgu1pXXDJIpNN7GoCRNFqtr6pe8+OQ5HiGqeelb4u4DlpiHpeqwHsg/JmX7
	0RZuJNzssxDjna3tfLIqPjpWv9XZXzvMstMZxEIcWUo+o+uwe+9qV0fcrSpFA/pnnS0iLsXRJGB
	Yvc34LjbC137hzROCEwN1r21umKVJtxEFNKG6YEKHtI0RbTh3kfF1DifRVjs/7RdZg==
X-Received: by 2002:a05:6214:1e3:b0:707:826:1ab5 with SMTP id 6a1803df08f44-70708261c32mr74163186d6.40.1753367845537;
        Thu, 24 Jul 2025 07:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc5FI+9v6XLNucNriGBwsIEQ9dZNlTaDhhPu74MX9L6L2A3ovmGB0HEuxN22mlYUvA2rHdHA==
X-Received: by 2002:a05:6214:1e3:b0:707:826:1ab5 with SMTP id 6a1803df08f44-70708261c32mr74162576d6.40.1753367844954;
        Thu, 24 Jul 2025 07:37:24 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c495f02sm122856266b.2.2025.07.24.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:37:24 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] gpio: virtio: Fix config space reading.
Date: Thu, 24 Jul 2025 16:36:52 +0200
Message-ID: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rGYWB_BUO7EQ5gu-uwBPy0P7E_yzBUe2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfX+Y8FlwOTzLkk
 4LCwjrQi06ym863YMZNYnTUgMYRHzHxTBDtIZzI3v/W1AleFaMKxRnshw0uYxaIcYUAjEXP+8Ik
 uQDrq3opRsS0FxADA4UT1C57bEKE0dPnyUdL5z+rqQQIKMJN6tlIgP90F3hRxnoNjm/jq0CX8Dv
 hR5oeWSsGqhaJ9IiA9GZYQd17HHnLpZ1oc/1i9UzRB6ExdRg3V0jzUsrJ1o/Bmh2YZ5/S+GsPVa
 KdqvW8Bc3aEEAP/xO1AFUPXHfFZQBcjNTL2sSGzBSzN8ES5X2jo9qekgowi2/zgvVn4NT6YL/1s
 zrCVbUcDXgEI4jL1pv0lryDKIv4ROLxSoRjZgrsqcrmMe1eTwSVOtm86J0OMR3wlpskIOyXhEag
 zEvakHw073oupphday78b1eiAcw4YcdEvuhqAPnhORo966wrMMjWRhkRHkRk9zmggzCV6lgA
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=68824527 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=OcK3cvsEmbn26l3-tBAA:9 a=ZXulRonScM0A:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: rGYWB_BUO7EQ5gu-uwBPy0P7E_yzBUe2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=905 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240111

Fix for Virtio GPIO Linux driver

The Virtio GPIO Linux driver reads the configuration space in a way not
conformant with the virtio specification. The hypervisor we are using is
strict in what it accepts so the current behavior causes a problem.

Builds on top of gpio/for-next, tested on Linux v6.5.7.

- Add CC: to stable as requested
- Add Fixes: in commit message as requested.
  (Problem is present from the beginning and was not introcuced later)
- Add Acked-by: from Viresh Kumar to the commit message
- No further changes to the patch itself

