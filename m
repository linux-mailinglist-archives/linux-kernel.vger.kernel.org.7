Return-Path: <linux-kernel+bounces-826729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D7B8F342
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26522176477
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D282ED164;
	Mon, 22 Sep 2025 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hihU5vLu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141DA70823
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524310; cv=none; b=XZkDlSQEuz+DPEbub5Ah4iwS6oofPlYfpw/QS2wQg7glgeCV0kfAEkLCv7+6/oPg8ZS9qSbodW6Mne6vS95LqyC4Z8wI9sHaFqnUgDzPhBzI1BAZGZ7GPu5oOoSdYPjU8WoIelvzSFqcwasCDu0H/dhb+O0Hpd6c6dys2aIERYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524310; c=relaxed/simple;
	bh=uGHHGBCfFNOptPjxI3jLNItj2P2GHE5IwiAelETYCAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxD/bpMbhc+uooVgJ65iWDZW9fLoTAbUltqOqIhnepVLqMTHld88WU1SIyR3f4dnvrOQO2XFl69uBQFAeDUtNzMbOuCbiB2AwoVH6v/j+oegqrA3JkZxzmN/uMVVsixliFx+0SWjgV5fwoEHlDWSXc2HmYUEfGj6+GqIHZezaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hihU5vLu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LIx22S012169
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Y6J0JvZHZTyvNJ+YjUFLmgs0dQUdIkfQWhpixwMQlQ=; b=hihU5vLujTq8+L80
	Icsn6E7T6N+IaKbEkE4Wcozq/6of7Tg29DDnlCkpObJjZ6uhOhlgf6q9M7xjsJ+o
	eXMT/Fa4AM8pvf8sIEutFQ9UBw4yKbEl+UVJECznaYOxqd/BldofcAwj8h2UZvuQ
	TONAwpwmX3/TLT2H3aySHyxlPnJLhGThbxP0X0acwezvkyZIXwxuv1i+VMDAzZsZ
	Bvf6bUX46PMoBANDm3nbbKIpAXANZlSdvCrHUbQtDZJ6enK7XW/jG/b3qIdGuPu3
	+Vfp/2TJIwv8hPd63wue22DMQnNjT3MJ0N03Lb6h4zJaLkVxen2mcIvMZc98PYlW
	2XGrDQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98bqa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:58:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2696ab1bc16so11699025ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758524306; x=1759129106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Y6J0JvZHZTyvNJ+YjUFLmgs0dQUdIkfQWhpixwMQlQ=;
        b=OcXJTLEBRCAPmW6zSoEzMvnt8muNjgKMFzF+VLa4opl+u81oFf+kn2AfUBvtCZL9gV
         wI5Jykw6o0yYDjD/MSt8pbagP8z9za79YZik6iJOFDHH5ZJmzGzgfkCaq5ax+w+iS3Iw
         NWMAM7b2L7wKNnUrd6MRiT6X8IBxz3Z6v+4IRZX2KKYrwxb/qdWw7Ut8ADP9riFQAHz3
         63+QEIq8DjHpWbZqTPGNtCE6znmLoOBHaer1F8Rt7qxWYim1VLoEUraIpAnqD+OU9NaY
         OMDyZQYD8CW4hEC1DK2+9BX/OJyNEEbL/mEXnGi91n1xebClaHXj3tJ1HrECuFWIrqso
         g+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw8OeCV6QDWKAvCCn7ML9pEb0glbl5kKcS/wAzeATEgU8kIMgqkCDqCESJjb+PgpD887+WwB8rd6UEIpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZR6eaEZES4KEk9+uaWoPa9wT0wLUOk5yPWLo8XVAynevRkTu
	0AwbzzQ11RMAqksH28dnYPYEgMT0q7bTg/e3USh1jKkDLJIRcGBgnVCIUrN2T1QgmrYaMh+ytgu
	CYqSCMfh70sdNwTvzyxWoaIWrvsnm++mstnAPxRhJk3+iptbMvEXhGC2vF3JniU5Ra3I=
X-Gm-Gg: ASbGncsSX7H3kb7wnpOjBETLMqgCaEieMdB1i5GDrzpctOgTJcYxWnvaVrcm3oRly1g
	1iWifpDXMmHTj3+By2KxWJhb8B38MF+8Zxl6DzKQAcHthLkttHEzyDvAsQ9ZQEEKF+N/Nkp6eVJ
	7te7YqNCTra2tJQL8SLLpkhSMfHN6bKg57KL9G9dybPe21UBKQvfhz8sArORfWYM6JO53i56mH3
	ELth1PEFdaTzQ8qPCKqD2vvidxJhJrlGIKb7nhwkDlLBk4qvMPp269gSZDmvPx5hRTQvXvDajyr
	ObUi13FpG7IsXIRJPhFZm8iVbjLcVae+7pvjR+mU6k+5ZMr+W+yz5SkercYPdblAL0wKPjLhYqV
	q0Ke8rxHzczLInxB9j74zNKAguXPKlKMExg==
X-Received: by 2002:a05:6a21:32a5:b0:266:1f27:a035 with SMTP id adf61e73a8af0-292762e34e1mr8296821637.6.1758524306378;
        Sun, 21 Sep 2025 23:58:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOnFw/Aim0P+Z+Av0f4nHGRdPopw7vSUWV5zLElAHa1cdJ6EyoyUbPMlHQZWh/gnjmhtMsIw==
X-Received: by 2002:a05:6a21:32a5:b0:266:1f27:a035 with SMTP id adf61e73a8af0-292762e34e1mr8296796637.6.1758524305726;
        Sun, 21 Sep 2025 23:58:25 -0700 (PDT)
Received: from [10.133.33.87] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm8998663a12.26.2025.09.21.23.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 23:58:25 -0700 (PDT)
Message-ID: <14cdf3a4-714c-4136-8c1d-99392e7911f5@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 14:58:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] phy: qcom: qmp-usbc: Add QCS615 USB/DP PHY
 config and DP mode support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-12-eae6681f4002@oss.qualcomm.com>
 <bfpgktxgo2hb6dpzy3i7jdr6w4de5boorx4n6qeapct2vre4sn@4z2mnppridn5>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <bfpgktxgo2hb6dpzy3i7jdr6w4de5boorx4n6qeapct2vre4sn@4z2mnppridn5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 65KxqQt4Zx4JplAYFuxyDbVDYMG-qaXc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXyH+uGBOm+2x/
 0vgCpT3hzDW4w5v40TDiNzpcVcF56Tk2fbe7jWiC0qtl5dv33FKt4ddi+SaFYWQV0TFjSirahEe
 8UCTOkmeMKbxdlm9NyBUCeCNLpSFOYnbxMRYGUTBGOAYn2kYXLFR+aQFVrEha3Y0TYGauoaeHOZ
 +b/cszB1KYD6CeihnwMJgVm+AZjRDjkCerqpLTsoFnI0mpFRFl+HFcSv46IIjXASfIaeJlsvW6v
 YoKSBni5tMbzPwP1agFtTWGxObLk+xEnaYjG7Re3UffQf5YS5VOJYQi3fcKwUGGn/nypyJPuLNT
 JHPkfdDmjU0EBw4OzFRYd+AFSAVlJeO1wlQgIRD0hde3u7tfszlJAdbiVntn5K79OK1lD8oi9LD
 HGIWCAzD
X-Proofpoint-ORIG-GUID: 65KxqQt4Zx4JplAYFuxyDbVDYMG-qaXc
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d0f393 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JsSO4BFUhKJy4KAi8vwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018


On 9/20/2025 2:41 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 19, 2025 at 10:24:29PM +0800, Xiangxu Yin wrote:
>> Add QCS615-specific configuration for USB/DP PHY, including DP init
>> routines, voltage swing tables, and platform data. Add compatible
>> "qcs615-qmp-usb3-dp-phy".
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 395 +++++++++++++++++++++++++++++++
>>  1 file changed, 395 insertions(+)
>>
>> +
>> +	writel(0x3f, qmp->dp_tx + QSERDES_V2_TX_TRANSCEIVER_BIAS_EN);
>> +	writel(0x10, qmp->dp_tx + QSERDES_V2_TX_HIGHZ_DRVR_EN);
>> +	writel(0x0a, qmp->dp_tx + QSERDES_V2_TX_TX_POL_INV);
>> +	writel(0x3f, qmp->dp_tx2 + QSERDES_V2_TX_TRANSCEIVER_BIAS_EN);
>> +	writel(0x10, qmp->dp_tx2 + QSERDES_V2_TX_HIGHZ_DRVR_EN);
>> +	writel(0x0a, qmp->dp_tx2 + QSERDES_V2_TX_TX_POL_INV);
> Are you sure that these don't need to be adjusted based on
> qmp->orientation or selected lanes count?
>
> In fact... I don't see orientation handling for DP at all. Don't we need
> it?


Thanks for the review.

I agree with your reasoning and compared talos 14nm HPG with hana/kona
7nm PHY HPG; the 7nm COMBO PHY series has orientation/lane-count dependent
configs, but the 14nm PHY series does not. On QCS615 (talos), the TX_*
registers you pointed to are programmed with constant values regardless
of orientation or lane count. This has been confirmed from both the HPG
and the downstream reference driver.

For orientation, from reference the only difference is DP_PHY_MODE, which
is set by qmp_usbc_configure_dp_mode(). The DP PHY does have an
SW_PORTSELECT-related register, but due to talos lane mapping from the
DP controller to the PHY not being the standard <0 1 2 3> sequence, it
cannot reliably handle orientation flip. Also, QCS615 is a fixed-
orientation platform (not DP-over-TypeC), so there is no validated hardware
path for orientation flip on this platform.


>
>> +
>> +	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +
>> +	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
>> +			       status,
>> +			       ((status & BIT(1)) > 0),
>> +			       500,
>> +			       10000)){
>> +		dev_err(qmp->dev, "PHY_READY not ready\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +

