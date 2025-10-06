Return-Path: <linux-kernel+bounces-842786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834CBBD991
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E8D4EBFC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291122DFA3;
	Mon,  6 Oct 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drXkFUCo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869C22C355
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745050; cv=none; b=W+kKbatkfznpc+1l3UljfVPVAgFxU0rm1qEQnIr1MJoFF2X+LlRD9YwWwyOcaKB3s/tZviLsU0dbl7gRN/WBNlA3y7yK0qZ7gnWEmZ3wJtRc4HgeuuU0t/wopOvcI3c3Pb5baBZY8VSItc+575h7I73L+bzXqXRIGwxYMoFQ+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745050; c=relaxed/simple;
	bh=yA3VOCeWJpMeFPPSvsnSB7GRPYFUREqE/fSTw/m8jVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM1LVVOvWJiqlXL9NgwEfxdWJ9wWU5SfRLpUVIu3lAo6tjg/R3Ssa+0ORmGtQKaXZypnVGB027GIhIrJQ/UFhjpKMbWn+jXNN6dik9AH+8252cVTwpVgZijjJ+y3nHkDpkmrulmsToExNlyXkrX9MQpFVIWV1bYSy7PFXJOcUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drXkFUCo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5961Os1Z001364
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ue1wSy69VigC+Md65Qg2LywO
	1m5qENAP2gsLG1UwtMM=; b=drXkFUCow2VacKOQ4WAGbx/LxgoMHcroSNSFsk9y
	v30uTWmoQjVE4w8Mj8et6SGkM9ozwO8jOlErLGhczGwaHwK8jBg2LU84Kwj4tmCt
	ZpOCvmUObqaZU6UwxneMf91ZUYLG31ts3+IOlUjt36IWeLDK0FmF+R27f66xJku5
	Pdq05yU/roFJcNbFhej6dnMitj10BLHaclknHrurzlHP/TwSLsTNJBuBFijSJJ0X
	gPFMURuMCxjnDHp7eFmOpi+HY5HfkNEFE1n2txJ/6Gy//Ooqni8m7F6T+AIFdB57
	CWL1RTf8x2Tx8JpCSiiwN1tLuNNrx5Xv1y1XZcvBVPS9Tg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy6ufbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:04:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eed7bdff0so54139165ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745046; x=1760349846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue1wSy69VigC+Md65Qg2LywO1m5qENAP2gsLG1UwtMM=;
        b=mm4S1ImkaX/vdtX5UMAR66/LvRYMFfVN0GuCXKm/krQRrxHRlpmqIaalzaSceTvYUI
         5RmuNeA7KxlJ8ZjIWoVd7lQvnTegkfAAWtJO8k4RRLow0kyxGQJXNy+fJPDDMCg0BqJj
         AiHHsuZAdVGy638H6Xw3+wDXRstHhsuEHKbarEPX6D5J/ziRmWCvB6D2wR+/yY+4ceLi
         imCqqOTmSvctpdfNtOctToh//MqxeeWuYOY/Fn1Ayewyy9wYqW3A44F5It7NpgZ8cXhg
         H1vKMqAdgbS/gxVBNWVgBAeKjxOyePHqJodwmT8jmNizoYwxLlwYCZbuq/RkG61Isj+b
         ftcw==
X-Forwarded-Encrypted: i=1; AJvYcCUMajcyCW0J92daG7u4bcfOWZzuNiE2FD32OKElUl/r8w5QGt3cp13JXQ0O9NZmFOcxocu2upEbhdopmtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4dIJfzeo5ZNZ8afcemfOsHcsIzQIEo1SZlmv/LaSkutmLV7CG
	DjXttrSIT6iUc5nN+EeK2N5f495C10HEXpwtBsG5Qd+Y6ZoTUcbdhdEo6MdKufUueBMu5ZtreMn
	u7Xdkp/cHRdjg9UXIlTZ/Mftz3woaLG7Tr6mS2fVf/DKji1QW/bhbDt0kv3a6jY9+De0=
X-Gm-Gg: ASbGncszidcv2ek3chxahVnROW77a98zCYF5XPwQPdiFa1bmQpQc/PprMP5EkirB7Js
	OrJ1iH1Vx+R3odKKRg6b+tCkR+j6vqBs/A6xPkb4T9BoIJ2Nbizo4oKrsbPoVILxZ13BSHGFBNj
	Sf3tuL4+Yb50nNmVK60mr0Bhm6y6Cme13l2GLfBhIeME6m+D8KyfZeUuw+6cBu4MEfK/ZMPcjWR
	E/VnK4iQV9P05qc52nzJUyWlq+vIblzwuTmNilLUnIikuUEIInlshxjm1t/DCbLP29G+633FjEt
	pm6YADwhcTFHht47Ab35fyo3oWCd/JuXnGZ9Hv0IARbRQwE2NcsMXJIAbutEVTglMt//IL+81lw
	jxFA=
X-Received: by 2002:a17:903:2c0e:b0:27e:f03e:c6b7 with SMTP id d9443c01a7336-28e8d038b9cmr202072305ad.10.1759745046073;
        Mon, 06 Oct 2025 03:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXGuzsXDqH+HypDtrXeh1/naCIbPt2MMoelAPp09TjufTVxo08OD/KS48Pkf9lpBlURXi7ww==
X-Received: by 2002:a17:903:2c0e:b0:27e:f03e:c6b7 with SMTP id d9443c01a7336-28e8d038b9cmr202071845ad.10.1759745045504;
        Mon, 06 Oct 2025 03:04:05 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111931sm127803415ad.17.2025.10.06.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:04:05 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:33:59 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: hrishabh.rajput@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] watchdog: Add driver for Gunyah Watchdog
Message-ID: <a7633abf-0005-423b-b152-e8c70aa5c27a@quicinc.com>
References: <20251006-gunyah_watchdog-v2-1-b99d41d45450@oss.qualcomm.com>
 <3b901f9d-dbfa-4f93-a8d2-3e89bd9783c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b901f9d-dbfa-4f93-a8d2-3e89bd9783c9@kernel.org>
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e39417 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=kM1oLTEIhtBy5IrTauIA:9 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kv4MdwGD-E6F47UJqJY_rvqk8ZTnGqKP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX0LDYY1oOA7Es
 1QbYDtTQwact9NYR/k9f5jqFKHqrhBWs56Oblwj9CYi1HiptXXa2UYVJ0VqiA0b2NkwcA4sBamV
 QMC38eGiPoUdY3U1G3tHdZWWFQkSG7+xTd90pVp2rvul71sAZjI73sPf7pLUWKEC+VeGs60ri2Q
 aMAp8Aq2cF+spEoBbMmiYFUkyoe7YzfGAJ1sUbqBKjbGrmXkcrAKL3XEBUnCrWtJbx0X+y97Sxw
 8mpVor+zzW+Uot0b4y6vdceB51H7wWjP6PkAkp6I7vg7cQnhk29K3EVn2GFK4KvSXJbQqJsBoLh
 VwWSWb+tRgNC9vLC+ODKZGkuzHibJIPiZj4gz4NlPmt8YK7lSkwDPccssiQ5zHM7r51EJ7RWy4n
 RHDAZPDMjFlF7THUTPDaEQRMurc+rw==
X-Proofpoint-ORIG-GUID: kv4MdwGD-E6F47UJqJY_rvqk8ZTnGqKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On Mon, Oct 06, 2025 at 05:56:42PM +0900, Krzysztof Kozlowski wrote:
> On 06/10/2025 16:37, Hrishabh Rajput via B4 Relay wrote:
> > +
> > +static int __init gunyah_wdt_init(void)
> > +{
> > +	struct arm_smccc_res res;
> > +	struct watchdog_device *wdd;
> > +	struct device_node *np;
> > +	int ret;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "qcom,kpss-wdt");
> > +	if (np) {
> > +		of_node_put(np);
> > +		return -ENODEV;
> > +	}
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "arm,sbsa-gwdt");
> > +	if (np) {
> > +		of_node_put(np);
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = gunyah_wdt_call(GUNYAH_WDT_STATUS, 0, 0, &res);
> > +	if (ret)
> > +		return -ENODEV;
> 
> No, your hypervisor driver (which you have) should start the module via
> adding platform/aux/something devices. Now you are running this on every
> machine, which is clearly wrong...
> 

This is a good point. Thanks for bringing it up. We don't have a
hypervisor glue driver (yet!) that can add an aux device. Based on v1
feedback, we would like to be a standalone module that can self discover
gunyah hypercall interface.

Currently this driver depends on ARCH_QCOM || COMPILE_TEST. So,
technically this can be built and loaded on all non-Qualcomm machines.

We can make the STATUS SMCC before looking for the other watchdog
devices and fail early.

Our Gunyah glue driver [1] do make SMCC call to establish that we
are actually a guest under Gunyah. Since our intention here is to
support watchdog on as many as platform as possible, it is better not to
tie this with glue driver and make it a stand alone and self discovery
module.

If this is not an acceptable solution (Please let us know), we can find other 
ways to limit it to only work on Qualcomm machines. For ex: Socinfo
platform device is added from SMEM driver which make it only probed on 
Qualcomm machines. We can look into this. 

Thanks,
Pavan


[1]
https://lore.kernel.org/all/20240222-gunyah-v17-4-1e9da6763d38@quicinc.com/ 

