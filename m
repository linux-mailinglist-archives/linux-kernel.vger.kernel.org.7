Return-Path: <linux-kernel+bounces-865593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5765EBFD8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C383A3B5EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E2272813;
	Wed, 22 Oct 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dcfC7PHn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A24279DCF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153278; cv=none; b=PAcJsc6NE6Z8rZ9QM2Twk+vdw89MiUoUmsTmBj/DWd+r3Rwmof60FWBZAPsfBgjYH3WWZWkyTUHfG+21he0kySXMxcm68Fig3weNNesaXm6Col7k3ANc/CMREIoqJM5uI26pz5HqXea23oaawxwHHDAt58oVM98f57/gKwT7G1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153278; c=relaxed/simple;
	bh=W0hYyw+FFxFPIcjLI6cLC2huES89KHfpD4J6D4BemPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6aOfIl5izmLQFvLg3DhVEgaTKMpnX+3hhS6htHjoEMGaju3FOI/z33aGxpoCf/TOJ9NmNPTOLAwKZBjShqgSgHaI4820p5APx9DgbECfx+3JJq78drsEG97YSIcQKWoQQ4GrdGUOUjZ1Um/4GPrCOFpHL8OQo0OYM2qQWem9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dcfC7PHn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAsl5q024237
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3n7GuKanrjFBNn+S6EEEj55UDKDMqVUCfv5KZTHI70M=; b=dcfC7PHnQ57SVoYy
	5d1E8fYZT5HTzt8RzOBJJnKF8vDcrQ7Az7FqhBpcmiN9++w6o6jpWN202ZEPKQvX
	px/aEbaUC2xuV+9jl25QCCp1xq3+/xN1GxA5TkiUwsYtjadptpbvu09aLxJai31Q
	ZQJK0ijKHwRvgtrfPByQvk1ypRK/nGw7/OgUKU8Hv24IdZiRO8HCfUdG+96tgS1w
	1YGptPzr5X/OWZz7iejg0kiLzIJky5sx2KV5XC1iEPybkjJhJn6Nq5iy0z2Z7X8x
	3wHfMo7DU6VicCs8kndTmKr9Daanju4X+P20sD47KoszzHnP3wTKDP6tOaT/7R43
	KwJ+gA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w85hja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:14:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e892b1c102so5008681cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153275; x=1761758075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3n7GuKanrjFBNn+S6EEEj55UDKDMqVUCfv5KZTHI70M=;
        b=eU39pGt+2KGuxN6WiM2n1Q6Mybbqj1dIYZg3gMB7gtWhxJz0RysuIJgIMrrMCabPBP
         x0jbg9SmjNYsw+kCkft7AIyqOUVxlHx8EaMD4oDBCCazrvlg64lKW1RKAqSFhC4/yosp
         7ZeGyIhLDHWch2ejvIh5OKV7oT9w542ycYl4xvd6/Wt1hFHKEAn62YIrXyVI3DqCaU5S
         H7OCYFGH7t6K6PudYP6aEhc7ejn12NWcw2dF43qM/oon39duVUCRMnhhyCz+VaXpjKIy
         ljv3EpiPYUhCAWqbnO77iGmrHL/zXREFojMyZkogdDKxPDKaUCRm1TQSx0Xoivx/zuD3
         GoNg==
X-Forwarded-Encrypted: i=1; AJvYcCWqMcqEeO/XyZR2UvlW0gsUn1gdVidgz0XYNRB96r9Ndh/1JVLdzJMhG0SwXpbZbpgeUKGFbDHB7If9xnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxmb1wLOscp7FrI3N4SxIiUuH4UH4mWr8ikQ3UAvUyxXtTthab
	kopLsTmgjGgC1L3KrYcYhyuu+ZR5nS9iVUk8FciyBEeqquzvIcs1iU0sTaccMeF4/ManU8sCuSw
	ME9CKvrIBAwcul9mTq4ZCF1CcvK5bZPwaT1rjL2mioUMPzZyCiguzn2TkWsi/IQQx1FY=
X-Gm-Gg: ASbGncsTKYLwURsuBgGwRAnwj+sid/0yUNSzo4FaSSVD8SNjp/jOPapLOSRHk/sVZBT
	NB3XFnwCTi0NeHJ+FGspvp9AyrUtT1eURvKYW/GwgEMy3oPDR7uQUF00L70d2mSyYKPb+inuqOu
	y2DjPAzUp4DKUgKeLP4eQxnezSviTsN3DRlYtaCtFfMRbNDzhPVn3ojz0giMJKxZUHb/Te/zyQ2
	9fiGkl3GT3LW9x898/VcZ1ciPGrZTr6kRb9umkk7sF9I0OOpQPv0Jp54X0My9jn/hMmaVfbgG8g
	GCFaTjDGggIJoZg5lLRI6RXyN4y5PAM+9f7qKlEhMkRRyg4a5VDaXnDXahhXUGB4eqcEd8V0gGy
	4qzRhT1zslf6vOIRNyofRLMNdle1hQCn1aw//4iyJzXKn/3ldx1JYTWYA
X-Received: by 2002:a05:622a:1492:b0:4b7:94af:2998 with SMTP id d75a77b69052e-4e89d2cb636mr181110591cf.6.1761153275297;
        Wed, 22 Oct 2025 10:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElUs2ccLws+09dJCicur/nb+FwFaszJn1D/TePDNT/7C+eYSqLSDOVvQDTj/XCFdnCKCnLTw==
X-Received: by 2002:a05:622a:1492:b0:4b7:94af:2998 with SMTP id d75a77b69052e-4e89d2cb636mr181110211cf.6.1761153274818;
        Wed, 22 Oct 2025 10:14:34 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb0365e1sm1394344166b.48.2025.10.22.10.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:14:34 -0700 (PDT)
Message-ID: <280f1e92-36a1-450b-b6df-b36c3aed3c1c@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 19:14:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] backlight: qcom-wled: fix unbalanced ovp irq enable
To: foss@joelselvaraj.com, Lee Jones <lee@kernel.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021-qcom-wled-fix-unbalanced-ovp-irq-enable-v2-1-7ff115b4ffe7@joelselvaraj.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021-qcom-wled-fix-unbalanced-ovp-irq-enable-v2-1-7ff115b4ffe7@joelselvaraj.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX4zcJK0M7jxuN
 4Z1bLVus1WMLvjV4KjCDYXBktoav/w1xZtRQC4j+irssry24lMgcGr/K/szVsusjmZkB82wESlo
 Rhr3aMWhDkmUqpMSIVYILj957eYThnRKP+bPqvnMnUPojIqzBURPdbhFkpCTwbsg3dmJKCdBMpg
 5bqoq735os/7hDMsicK4ZnAGszF4tmZmnBKrsA0sGODH2mI+n0jR2IckKG8VAey8mmooyTZ0YcC
 8xhgl4XawBknaiajI+Ixc5WG3M1G6GZWqSBP/Sd34I+1fFFnvPq7952OogC5FQEV90WallZI+d3
 d8P8kvr2s7U7PHGaHogYuW9e2Z9VZKvgNW8CDG+Gi4BVrXgnyh8GZx3FDO9+duWIsfKPfdlWLVg
 QKTzLlUz62n9OdxORm+qC3dYMm3Juw==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f910fc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WFa1dZBpAAAA:8 a=pW9aVPEJbd2O5lHr0_EA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=MZguhEFr_PtxzKXayD1K:22
X-Proofpoint-GUID: 6GYRHJfgEIQ0hyCOYGfShj-X-QcGJP4O
X-Proofpoint-ORIG-GUID: 6GYRHJfgEIQ0hyCOYGfShj-X-QcGJP4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/21/25 8:53 PM, Joel Selvaraj via B4 Relay wrote:
> From: Joel Selvaraj <foss@joelselvaraj.com>
> 
> In Xiaomi Poco F1 and at least few other devices, the qcom wled driver
> triggers unbalanced ovp irq enable warning like the following during
> boot up.
> 
> [    1.151677] ------------[ cut here ]------------
> [    1.151680] Unbalanced enable for IRQ 176
> [    1.151693] WARNING: CPU: 0 PID: 160 at kernel/irq/manage.c:774 __enable_irq+0x50/0x80
> [    1.151710] Modules linked in:
> [    1.151717] CPU: 0 PID: 160 Comm: kworker/0:11 Not tainted 5.17.0-sdm845 #4
> [    1.151724] Hardware name: Xiaomi Pocophone F1 (DT)
> [    1.151728] Workqueue: events wled_ovp_work
> ...<snip>...
> [    1.151833] Call trace:
> [    1.151836]  __enable_irq+0x50/0x80
> [    1.151841]  enable_irq+0x48/0xa0
> [    1.151846]  wled_ovp_work+0x18/0x24
> [    1.151850]  process_one_work+0x1d0/0x350
> [    1.151858]  worker_thread+0x13c/0x460
> [    1.151862]  kthread+0x110/0x114
> [    1.151868]  ret_from_fork+0x10/0x20
> [    1.151876] ---[ end trace 0000000000000000 ]---
> 
> Fix it by storing and checking the state of ovp irq before enabling and
> disabling it.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---
> I was able to debug the issue a little further. This happens mainly because
> devm_request_threaded_irq already enables the ovp irq during probe. Then ovp
> work gets scheduled when update_status happens and in turn enables the irq again.
> Tracking the status makes it easy to avoid the double irq enable. But I am
> open to try a different approach if there is any suggestion.

Would reverting this change and adding (| IRQF_NO_AUTOEN) to that call
fix it?

Konrad

