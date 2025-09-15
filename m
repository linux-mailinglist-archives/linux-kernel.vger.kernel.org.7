Return-Path: <linux-kernel+bounces-816150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0EEB57033
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1380168299
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEB3280308;
	Mon, 15 Sep 2025 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSQ7m4bJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1327FD49
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917586; cv=none; b=LcKYuNJTfduwnq9Yig4C29jTmw4hYsDSzVOhKUPxnaA1kqZ81h5w2sAnWLYRb22SrDsUhEiqUK2e9pDkIeEptX/lesEmMgjhKfgc9KAkvT5bTC4iClXRKSLjoHYL3Hv2FIlgHBaLYjt+rOEy2DZWX+qIOJUIlXBZH/Pu63p7nUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917586; c=relaxed/simple;
	bh=p3cqF/An1AZjw8JVOz9xUECjqoR0vI9WU1IXWZyL7Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDai6AqWTeWgPTYRGoMBkp7g3biWPi3XXZ31hR+uFmh2vGKKoPNcE6+cit8RQ8JWrRxHQsRfCHcYJrhv9pGYfcsXRgelRbIpdmdDwGoRgZHnUpO1Dn8OPSmWi84ZFjZ4NuSfG14Vu1kJaq5Zt72BbJHstK/kdMlVybDJ4WnKgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSQ7m4bJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EN0dNU026970
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p3cqF/An1AZjw8JVOz9xUECjqoR0vI9WU1IXWZyL7Ro=; b=aSQ7m4bJjFzNFsE9
	VSYPcz4xcmtaJlDYhC2EqGRUm5ndV0GtZ5ZBeFj1LG8f21dM4HFUVcP/Qazs4L45
	XQxVIPundh+0tP7/APebYUPMFWTcQxN9OVcP1byjVF1P5Uh8pRvGWO7EUqQxkE0N
	pT/lfc/eZPD91lpJhu5PqogW9Ekn8y2aszHjn8LEVB1C4Xf8eGX1j4d6LCX9fDty
	NFDaIUaSlsixlxtqVNaCN/c0k4rS9pH6tcKJgMdDT/49vF7p/a+BvSarI08jOi/O
	2mww+i6wAEfLN9bvaRDrLHZG/EhSq/ICZPPgbGmCXUhw/pgg1rA35kABR+uRmVN3
	M75Hjw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yjv3s6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:26:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5204317445so932135a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757917583; x=1758522383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3cqF/An1AZjw8JVOz9xUECjqoR0vI9WU1IXWZyL7Ro=;
        b=rzohMkrkpfqzWWnP/vzF3CkwJGOwdQVFQNRLAU72eu0VIDkJdw5nHJ5eoiRsh4fLm/
         8uTeF4+t9zmIttIj7BqcN2joCaXRqICgDhjAQ6PS3sJnJxMUj5hqC08kLh4p433ajGh6
         QAfhv63kUG5UvehqII3IbsMfROMADFq8HFOevbGBrIj+uOpGkbpRidlPDfxz+8RWhdPC
         EQ7yKmEvfCnsKEp0YDsIcGUMdi7e5ntiZns7wxCtvxbeD9OljOhJ5B/NkooAgQdmHzOg
         XUShRn0vrZMSEAcrZzmyCBBby6/L8lj7CjWDKHtCWNO4aBlH85xUKqF7KhrRkAs+PUWX
         CLBg==
X-Forwarded-Encrypted: i=1; AJvYcCVdy/8Wh+eOlYrRvtQVMR99C6/Q1hfzAbpKHDc/zfc9gVY6Jfu/fyDkvzb9qlRzdExD3YyPPoblCCV0X6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwHbiWFJn9L+jeiNMLYPRnVkdVpN0nsYirs6TsTRHG9nSGA7T
	ljcqVsK3CrYha85Wp2UmbjcvV6pTkoGFuUFGD+hG+sqXyPVPjQPzRwA/gE+6joIXDC9M1YVAl//
	/wjEIvhMoSG3PT+T5oZWql0xUuX2HNh2th04ZC4VK00XDZQ1RFqsKnoZ6+MzUa9FOCdU=
X-Gm-Gg: ASbGncsjK8O/IxFyy6E/veKqupIXQ2lWA9kPfHUqDLyYTFFbFaw3DiTE4LVwyV+AdNe
	L3bfyLaV+SHePNAs+MwaCsxegh1d7wlkHWD7SxAFO/Ep4+RUgZIWMJEiuA9ZW53rYba0t3a7ffh
	sskQ5C6Nl/iXA/xmaij3IM3az4EcwwAct/42FhTREfMA65zQkSeumBoN/Jgqz45PcZZal7oID8Q
	ZMf3Tz81WAnC3mrohQi2fD/EnqtDJ4dubvV2632Pronws8acoiiH9Exm5OUIaG+uBKs3N1GY/IB
	909IbgXO56LJniRi2zQpF1dSSwQcBlnrYsO1rIT44foy2u8E8333WnCiR+3JwxJRNt5E1KgyYDs
	V3vtnyuSLZ/Gg7g1ZfT612pqYgqNGe9WAwUA=
X-Received: by 2002:a05:6a00:a96:b0:774:2286:361 with SMTP id d2e1a72fcca58-77612060f79mr6738247b3a.1.1757917583129;
        Sun, 14 Sep 2025 23:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnsuQAVbn2atzfG9WWx0sSeaLKGnzB1+E9spf7myo63WZ+ZUpm7ftykU++CRXawOnpXfnInw==
X-Received: by 2002:a05:6a00:a96:b0:774:2286:361 with SMTP id d2e1a72fcca58-77612060f79mr6738214b3a.1.1757917582644;
        Sun, 14 Sep 2025 23:26:22 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b347f8sm12075678b3a.82.2025.09.14.23.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 23:26:22 -0700 (PDT)
Message-ID: <6bb0cbd0-d3b2-4359-a2d0-6b757f66d0e0@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 14:26:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: dp-controller: Add SM6150
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com>
 <20250912-add-dp-controller-support-for-sm6150-v1-1-02b34b7b719d@oss.qualcomm.com>
 <sx64y6vfov4yag46erckpbl7avwmqlsqt3siebckn76m6jqxjh@f5lueyih6n3q>
 <d3743c52-4e84-4729-9f64-af856419d504@oss.qualcomm.com>
 <droyp5atpjauyttqkwqzk64kkghg6jkkubvfz3zlbrodyzlvoe@fbns762o6vcq>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <droyp5atpjauyttqkwqzk64kkghg6jkkubvfz3zlbrodyzlvoe@fbns762o6vcq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=68c7b190 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=olEU9l-643s81VMgE3sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: qnpqigTnCZFpi73S20-8DKHbGz038mgt
X-Proofpoint-GUID: qnpqigTnCZFpi73S20-8DKHbGz038mgt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNyBTYWx0ZWRfXyUb3lTAqj9pd
 KoTwnvdkgM0kDtJ4+UdujvXNeqg/hlU89XNTxo2qJ9vonJJHq2IkdHKLKiu8R4unv/jlTrZvcrG
 Wj29lE/yYlh+Jaz9FYfCssmBpikbbYb++40kN2Sm52W3mrtKDL4dzrjdJ4o48Desdi0mae1nXg4
 D/F6LdYnY69iNjyomEwSdS9ZfgqXboUvi0jORe93zC/Luht6drUT9cMg5CK8DJiUp6MwDgfP3Ef
 Dx2HeeG+Tz63pQCv4AQPtkjgKSipC7Tn1QkJ5hR6yXpMbPdqDVBJZ1p3okSwUqP6yag9rF7b/72
 h4NnQljEHdQS9EOUjF5FVUJJS1lk0NBnIbtqbU84llUN3jdhf/i26rY8PCJtOH9Bx4p9HKrmIVp
 pqVHOikw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130017


On 9/12/2025 8:10 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 12, 2025 at 07:54:31PM +0800, Xiangxu Yin wrote:
>> On 9/12/2025 7:46 PM, Dmitry Baryshkov wrote:
>>> On Fri, Sep 12, 2025 at 07:39:16PM +0800, Xiangxu Yin wrote:
>>>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>>>> SM6150 shares the same configuration as SM8350, its hardware capabilities
>>>> differ about HBR3. Explicitly listing it ensures clarity and avoids
>>>> potential issues if SM8350 support evolves in the future.
>>> The controller is exactly the same as the one present on SM8150. HBR3 is
>>> a property of the PHY.
>>
>> Ok, will update commit msg.
> Please red my response again. What does it says to you wrt bindings?
>

Yes, SM6150 uses the same DisplayPort controller IP as SM8150. I wasn’t
previously familiar with how fallback compatibility is defined in the
bindings. Since SM6150 will be declared as a fallback to sm8350-dp, is it
fine to drop the driver patch ([2/2])?

Here’s the updated commit message for [1/2], does it match your expectation?
'SM6150 uses the same controller IP as SM8150. Declare SM6150 as a fallback
compatible to sm8350-dp for consistency with existing bindings and to ensure
correct matching and future clarity.'

Thanks again for your guidance.


