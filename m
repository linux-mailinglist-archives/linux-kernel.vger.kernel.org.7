Return-Path: <linux-kernel+bounces-737668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4ECB0AF1C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470727ABD91
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0F239E7B;
	Sat, 19 Jul 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aYNd9kCJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4021ABB0
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752917742; cv=none; b=MIicwp5pdIdd/czQe8etjdNYA+Ie7EpLlnbAnXwMVUk6Mx7ELHvOQeKxfiS+xRg7bnWvWZPWECFVBfNJFACkEL0kv84ZBG08+5vCQu2Ijh8lVpiLDLf+GDUUtQCjrBF+YT76SFFoMPWZLDhm0X64DNzYT9odPXmb2G9wWPaHSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752917742; c=relaxed/simple;
	bh=hoSWN+5jhLJI9d8DpMrlNxb5YX+YAZkHose3puHowik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7DCjtJ9qzQaVmX+9OjAzUsqYX6V+H2dgBTmKMfEdv7S1Olh1BZCeebPaJOzhhiWuNHFeXnYf13KBghhq0dE3AWXcX3ab+zRhwGCb36Tmsvc1L14EgxZ7rvdDiccjtQX95Lx0Pbr4lYPWNRyxMG/aRYqZWxMbjPdV/LORCDBLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aYNd9kCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J6Bgiw013017
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wSbh+xGKxOsPi/4J27pwmx2I
	Cc9rg1Dj97VeqIVuWg8=; b=aYNd9kCJBpJD8plQqeqjz/IuZ6xQz243UkfZsZl2
	xfMrkrgp61/ad0lwFhnxvzBZfBwaJwIXkXf+e4secVC/5Zb66PlHfH2bQ/AkEQ+S
	UEJ/TE/6lu9GEH+F7mTu33dlaEhdBI/Yb4E672HHDkvbeePuQWNPnt5Ugt8xLvpW
	2NOJV3h/UJxDWgd4VAhTCZnyDQVyPnZtJ518PNR2jrsKVTXIl0E2AXtcYmM4tdVC
	mFYYA1Km/E9LwiHwpq3c/Kv9KhFnaLRe8lpUSbJevx37qrINemTr/FNDDjGvOUuO
	6ZFE3SL0a8tE+FSiXq7eCzkMG4OfC1IjMDr/8usJHWdQ+A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044f8ec8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:35:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e338e627f1so780476485a.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 02:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752917733; x=1753522533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSbh+xGKxOsPi/4J27pwmx2ICc9rg1Dj97VeqIVuWg8=;
        b=jyRS9oBYt3XgZLSt6vCE5J4FdO930RjyQfBMiowtM78PyrlGO/rD9Td3r7uZnDYc/S
         k/gYwGrc0vnLjSRI7aoh1/U9MTn75mdTz/HJSv+iYsg3778FuPT/wKv+XZ/793hbeC4/
         pa4WAmKJiIaouYXSke97G8/XB6jOsn1SdDhIoHnukS3dLUZq/K8Lwvb/9a7dnVmxS1CZ
         6QJELUNXHvJmhIl80e5MyQ20nrvppg9HwHLen1JLTv7uO1elEvO6hnzSnHLES0c9xE3F
         a16ju63Ifqb/agOBi1XPXSj7HZius39hRND+wLpMvPKdKYjxjzjM/wHoR6eOvY6lGgvV
         qOWg==
X-Forwarded-Encrypted: i=1; AJvYcCVXy1fmCtUluXl6ufJLRQYcQX7lDhYK/ao35TkF140xPqtYgqh+2pczMo30sokIStavEG7IA1AdZV0e0b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx242l/6qUMB1ZgzBEaf1XSROsQqIyKInosYpfaYFi+iM+XOb/n
	QvfjvMIVai9l7o/jA66p5CAWQETEJBi33xZ9hZ7E2PEr/np2QbO8gVkgleBHK5jePH7zUJmUTmM
	UmkITcm5qlrtOKt/ojGvWm389o3tP89pEZUdTABSuMQIf0Pu56RHb2qWfJ2lhkpygoAc=
X-Gm-Gg: ASbGncsen+2grjUVCy4W3KT3jyrDB4a65Kg4r/6GCAzcFvBu5F5XxK7ototRrN1UxGr
	/kDo5FXax/dydA146LeUQF83raHYc7HCweD1BXFaxD2lr7dG3kHwWPeghqrYBw9V0wzoI2FLK/7
	S2Cb5nszYKRAUBWUvdeE+JsRl5u6rag4F3OLAExwIEhOihtrTalPoTKVOpASZh+5Z+HkwpIw4M7
	e/yG9rNwzap5t3yRptM2jUxCUto8fHKwv9vqMKY9vMbVAcfqbIAPuG7p/JtOIFvY82hhST9gk1n
	RfbykWSFJo6WRiQVSINBs1hUuRkq5LeBgR3+jp/MxmWHb1nM1YuA8jbDGZA27rQ8YG4caTg0XYl
	m9Jvg1Rt60awOcoXWtXjckuDVlXR5kZe4dfhOk41RckjKzlA187nQ
X-Received: by 2002:a05:620a:2699:b0:7d4:28d9:efbe with SMTP id af79cd13be357-7e356ae17fcmr791787885a.32.1752917733018;
        Sat, 19 Jul 2025 02:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5wbUvtWyq03MOIlSlrD0IZhIz8P5EDs5+tTPDfigb89vA+4wYsZvArhwqxS6KlWMIpuEvg==
X-Received: by 2002:a05:620a:2699:b0:7d4:28d9:efbe with SMTP id af79cd13be357-7e356ae17fcmr791785185a.32.1752917732539;
        Sat, 19 Jul 2025 02:35:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aba0f7sm648128e87.83.2025.07.19.02.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:35:30 -0700 (PDT)
Date: Sat, 19 Jul 2025 12:35:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2] usb: dwc3: qcom: Don't leave BCR asserted
Message-ID: <iyvjr6fx3ec327mcbtemxdke32wzm6xy2zuwbdimy7ticsuvmq@rlbqiwdwi4x2>
References: <20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: c6jvHK9lqNu5WxY1oVMMSdm7Pm1d8Klb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA5NCBTYWx0ZWRfX4ud3ke6fAScc
 kMjhMz/u9yFuknemtX0Wa018FxMiVoUsfonE3Bq2tfJOToPa6Awn0/95nPIZLtWMXZA8u2fSDrg
 tSyd97yAMggqls53UPkg+Hk6dC8gg4RrqX+mb0ZA0reWsCxRY/6ma0C5HsCYL+uNTksOkQbLNw6
 +HFe/me5kCQroC0nCfB/CZ/5klMixxGbm46hI+CbUfcAevRJUwHF9SmX00rOqE8kPmezRX7uRZJ
 1e32DVD084EicJYmMBzsrWGZFf804D7w8lK4/RZwgsGZUSuQZHNcnd0+xRjjVF/Sh/vl7E7QbBj
 HJc6strEG5ctgPEpo6TnJBmqBxVlfaUq7diu/3DASXuoZvUefPpk3G3mPKHwHgTV1g9tnD1rZli
 MdLdc2etoj62G5fntfv5dFXLLf9oXcT5iqtje9CGMB7XhgX8NOaPuycahIWLc32phdJ+744a
X-Proofpoint-GUID: c6jvHK9lqNu5WxY1oVMMSdm7Pm1d8Klb
X-Authority-Analysis: v=2.4 cv=YtcPR5YX c=1 sm=1 tr=0 ts=687b66e6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8
 a=eOX_9S80fVGYM9ega84A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=597 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190094

On Wed, Jul 09, 2025 at 06:59:00PM +0530, Krishna Kurapati wrote:
> Leaving the USB BCR asserted prevents the associated GDSC to turn on. This
> blocks any subsequent attempts of probing the device, e.g. after a probe
> deferral, with the following showing in the log:
> 
> [    1.332226] usb30_prim_gdsc status stuck at 'off'
> 
> Leave the BCR deasserted when exiting the driver to avoid this issue.
> 
> Cc: stable@vger.kernel.org
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Changes in v2:
> Added Fixes tag and CC'd stable.
> 
> Link to v1:
> https://lore.kernel.org/all/20250604060019.2174029-1-krishna.kurapati@oss.qualcomm.com/
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

