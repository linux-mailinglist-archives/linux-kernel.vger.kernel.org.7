Return-Path: <linux-kernel+bounces-845384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12CBC4A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0170C3C60F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353002F7AB0;
	Wed,  8 Oct 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CtLQqwSQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A92F616F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924592; cv=none; b=QwXzVoG+BeRBAW3vcKmRqOlZ1QAKPsym3Wr47eFt64qjWrnHvN4JxdMSdMgr1CusqWPt/Qf8UqP0Z3yyxYDwXyE8LSyl8eXlmTX4YLTj26JfnKSN8OrMMu3p8HcKzIPIvHStRRbGcqAVD/RdxvN71U/VTWd1m8OS4NoBhLAvudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924592; c=relaxed/simple;
	bh=lTDgga8MBX26FDIM9uxD9CEVoactIApmKXI7vkta5zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK90TUZW+Ue49DaXcjXrV/LD6mvSetXhQyjh8MtbXpIgYpn+Igs1tkzJ7Gb+xN6Zs6mL7ZvQJfDtMlRfAOpUftXm1kVSFSLMtdsvgYogZGJlCeX6H+sWglynYM2pCZMMYHfxDXxcuOfjCBVAxwcGQG6x0SA9J2bCPwPOExzeIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CtLQqwSQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Oms021162
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f1knxwE895h//Uk+NLRtt7Bk
	s2juXaTkC3N0JijxtuU=; b=CtLQqwSQO639oW91NwkqOA2tgo457a0R3ad7To39
	dZ1GYvsm8ttIJZXIosAI+25Lzum1CCZAx+SSytWAUr0k+pm/kHz8GUs5m5lRrAIh
	W7/ZRcyU0viA9a6UIrW8qMXltd+50Kee3bx0deJ6KgU9jhUUIffLEwWz6b6aG+L2
	w3/9TyBui7yvgmrHVAF6RZHGnafTaB11G4V9qY+W1JrTtoAo2KUj7IUIbroefhPf
	6NvB6CWMMx7EhUoA7akbS+UT8MqJHjynroTOFmiNlOQGXufU1nN1KA8RTgYPVjwu
	pxtZ/7vZhdHHzIh7ew/Npi2VQsnPOODquwfkfUM0OCB71w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1t8d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:56:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630753cc38so6011567a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924589; x=1760529389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1knxwE895h//Uk+NLRtt7Bks2juXaTkC3N0JijxtuU=;
        b=vPAPTIXPmECUPXZC/e094gbmpSjXD7Avrgs5WLxaSJUrwRgWafBoSCmbUxjTsZeTYW
         qZlknfxgLBAC2j2ij2sc0Si74YKkl58VASmQZzM+6Z93Q9OkuUyq6pouiUMNvBHTcOt6
         iAfqrg6haYeLnwQYX1MqZdvNtVS/lUI9oHFXazviCG3Sp/yDEaGUyOFmcWUFNm/ajQU4
         Ew+IFdIcuXPvAVqlMPC/Ul8sAsTVip9d++PM0GK7IbLGQhZnK7GFaF3xxACJO5z3dgYv
         QqHhAuZSf3Z3PtfBVjyw85MpqUFRP2mzYS2B9Lq02JO+0vzKuLyk1lrAZlXacB7v0Rcd
         rWFA==
X-Forwarded-Encrypted: i=1; AJvYcCVOVBxhhv/Dl4pjcD3ZIJ9L8YRqcPXOiY64mvmj7kiNHT9RKChCI+wE9OSwlXusl81ciCehU49OxTp2nSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLBdI5SzrXuWUAf3nIEaxe9/os1deixMMS3UwwAUD00T3MO+6
	ryX2mcGUQg9SYL5r6dh00F6GkoRDrRtnKrC8gsPE/CS41QR9WZPHwG6HnzARoyLMKNnsqGnuBfK
	EMtpP5UYi5M1VyWRpUqKS1E1EQhuG///wpd2ZbKTLPa/wKtvqJcyN2kel29WDWuAdPaM=
X-Gm-Gg: ASbGnctEQZSX8xV5B2vnh2FoFqF8je0E4WAqUvy9/vve4GRslpfZmZbGErLJxjonz8B
	cv6ZKxd7Z5PVAN3A0Nl1FElQpqA9PEwBwmvqtYbKbtU+WLWtEIvGGii8384mZV3X6Aj7lkSvdhx
	UlxSmg8uxX2sdskBsfWN79B4R86M2pudlX8JoHNXbW52arz/pTqonxJNvZG6LAqG97zmQr5t19b
	Xeb2jLABTlgCFRo+8ZbhJbMnEMO2NILa3AtWaoYSosQ4/IdxTs6pdMyGZIhy/6ed1WPNYlazZE9
	3A4Z9YDAF/QBqUycCV1/PabQQOGFIT/lEfHMRGKrhDsdHLrzCLkWP1udDgbwshL372umyiCh
X-Received: by 2002:a17:90b:33d1:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-33b51149673mr3944052a91.1.1759924588774;
        Wed, 08 Oct 2025 04:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4vjV+Vlhpo1bxX4HVDR2AOqNRI4QSe2mg82Psqm/L0rIOyNsw4ssPAJ9H8Pf7ehrhuUjFjg==
X-Received: by 2002:a17:90b:33d1:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-33b51149673mr3943999a91.1.1759924588104;
        Wed, 08 Oct 2025 04:56:28 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6311462b24sm7363069a12.37.2025.10.08.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 04:56:27 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:26:21 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] arm64: dts: qcom: Add EL2 overlay for Lemans
Message-ID: <20251008115621.xogashum3s4auqah@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-12-de841623af3c@oss.qualcomm.com>
 <yef5jtmcfuks2w2sngxr4a4htihxx4xidsgwpro6wckbfvmvvn@jfr3dlsdf5vm>
 <20251008073214.kcanrljguox2vtzq@hu-mojha-hyd.qualcomm.com>
 <5408daec-127a-4fdd-88f1-855c90694f6a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5408daec-127a-4fdd-88f1-855c90694f6a@oss.qualcomm.com>
X-Proofpoint-GUID: hGNIyddg_lA5IS0TlNnd9Qs5MKmeoCPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfXzq/tB4ju1wch
 aaU1CNfSUrK7WpOTWqORf96V1Uy5arLFDNG+K+EA8tZ4/CVndv84KS6YCVCkYwhwceDQXPS/fuM
 h6w2MIF1SpAeRoRwAafN+7ji489BHb8KAMFKBNQJ2UbJo4fDpfPndwWlhsi0xUW54Sk78OapAtx
 jeILpiCiLm2XFdzaVA0wQ0gphWgn3KAQilAizX+UG7IOvWUkmufPC/dYDO8IZJwaInIFR6Ih9nd
 a35dF9WtDiJSEhcwf7WKm1fMQnQ0k6x125wEt8C2omPD7dBOvG6Te/p/9tjmw7zNAwYRWBcw0Ru
 5VUzw490ggmL2b0oJUWDSJVt0t5tA7VV4AA3+oJuIHSVDU+yj1f3OlVMrBKZtSB9VJA7UHja8Zb
 4CagSJS3XXBvhUNrXYTC1jpH1bSknA==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e6516e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=mJOJxhs_1O9UuuOt1LYA:9 a=CjuIK1q_8ugA:10
 a=eSe6kog-UzkA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: hGNIyddg_lA5IS0TlNnd9Qs5MKmeoCPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On Wed, Oct 08, 2025 at 12:13:03PM +0200, Konrad Dybcio wrote:
> On 10/8/25 9:32 AM, Mukesh Ojha wrote:
> > On Tue, Oct 07, 2025 at 02:55:04PM -0700, Manivannan Sadhasivam wrote:
> >> On Tue, Oct 07, 2025 at 10:18:57PM +0530, Mukesh Ojha wrote:
> >>> All the Lemans IOT variants boards are using Gunyah hypervisor which
> >>> means that, so far, Linux-based OS could only boot in EL1 on those
> >>> devices.  However, it is possible for us to boot Linux at EL2 on these
> >>> devices [1].
> >>>
> >>> When running under Gunyah, remote processor firmware IOMMU streams is
> >>> controlled by the Gunyah however when Linux take ownership of it in EL2,
> >>> It need to configure it properly to use remote processor.
> >>>
> >>> Add a EL2-specific DT overlay and apply it to Lemans IOT variant
> >>> devices to create -el2.dtb for each of them alongside "normal" dtb.
> >>>
> >>> [1]
> >>> https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> >>>
> >>> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> >>> ---
> 
> [...]
> 
> >>> +&iris {
> >>> +	/* TODO: Add video-firmware iommus to start IRIS from EL2 */
> >>
> >> So the missing 'iommus' property is the only blocker to enable IRIS?
> > 
> > Yes, but this would require some changes in the driver as well to create
> > a platform device for the firmware and IOMMU domain, and to attach the
> > firmware device to the domain.
> 
> "yes, but actually no"
> 
> > 
> > There was some discussion around this in v2[1], where I added support
> > for video. However, the change involved hooking into the video-firmware
> > property, which was used for Venus.  There were concerns[2] about following
> > the same approach for Iris, and due to that, we have dropped video
> > support for now.  However, an RFC has been posted from our side to
> > handle such scenarios[3], as of now unclear about the direction for
> > Iris.
> > 
> > 
> > [1] https://lore.kernel.org/lkml/aKooCFoV3ZYwOMRx@linaro.org/
> > 
> > [2] https://lore.kernel.org/lkml/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> > 
> > [3] https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/
> > 
> > [4] https://lore.kernel.org/lkml/4a32bbec-2baf-4210-a7c1-1ddcd45d30c8@oss.qualcomm.com/
> 
> Reword the comment to "/* More driver work is needed */" since there
> is nothing more you can do at the moment and you most likely don't
> want to block your series on resolving the above entanglement

Sure.

> 
> Konrad

-- 
-Mukesh Ojha

