Return-Path: <linux-kernel+bounces-824749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA0B8A139
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653077B8947
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB8314D39;
	Fri, 19 Sep 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5xoZ9vd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E044273F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293292; cv=none; b=kps4BxuDUuP7k9Z3yzOSYTR21rWJsuoiivStshnWR/vM7JM2CvctiJa7sgqAbuc6wiNcR98MRRu8/QZi0vzPnyL/rGeJoZm7/ZvIoFmbIfuRzQPJNojvxoe81VfXAJ5xq8Xpw28rQYagoQX0Q7soS7VLiBkewEhrtR0bfi8fISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293292; c=relaxed/simple;
	bh=jUlfAR0tdpp8HDtYqsipgTL3rzZBFeOBUhKRi598qIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV/o0g1/vUI7ETJzkTiU4eejPywQR2xPBGBERHf4rScKT++tGtA5w1slVfeWoC+leID8qwhFzoIdHc9xNDkL+9lFHW7C7+Hu4aV7dsljMjiUYslMHVGuuiFX5v2P0N848KFKi5/FPFyE1Wm0lkI+rMdCywxaHoQUJfO9T6JyC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5xoZ9vd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JA7Mf3007486
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1hBxr10k9WetqjQXVdcuaPdH6EVIKEvwTGacGtWwfg=; b=R5xoZ9vdANiuhtxs
	rpj1XNptEtkeYRjQULuIydXmYYpHKbzwyWCdDgw3haDuLHd95G21eHwHq+ls2P7O
	KkweAdyc86caV/oBKm/nKJ50+l7R+kpLNd/0gQTmMqVgihuF6AoMtdZoXGfNjZr3
	o51bMzhESOhfApz0asHkzTFtt2e8wT+kav57xW7IZFGpP5n2IeNKDiJO4VWnrgkj
	6JbV5frkOULgwmC0Oc+9FCI9s31vQ9L+RWl3FRSadU1zopc5CPKpfty1OJRy8+h3
	+tZLBu1X4bYSWUajMxn5cHOFyUE/Y1HYMO9m3KEiOdqw0KhAqN0Pe/+rFYjZdfqw
	LDyrHQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebew8sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:48:10 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77e7808cf4bso782792b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293289; x=1758898089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1hBxr10k9WetqjQXVdcuaPdH6EVIKEvwTGacGtWwfg=;
        b=hAytEjjHFsI3Shvk9T36gcw4ZO+vkc5cmGVzYhZ69rQtB8l1PpRDdgxF0Knl7Csbui
         JJZY8HDPc/g07tw4Hzpuy9F5S+a1E3qaU+yF2i+96exkO0XJuuepgdIFRbV7EiFc2qsa
         13bxbeZEEXBTAsho9SWmK0ORlF0kmh9ajhCwl3VgybnFzCnukkB8n6HibUP4NXH1/ZY1
         atd1t6CKJnP9EbQRvAvV+rWaqYawHZXnNkmlKwGOykQqGtS2hhg32GNPf2piix1P/D/v
         BhEQRhe/gSBtVclLbBnzCYeHoww+4643K/+bgfWGojFScNrVpsYZSLp3Sfk5I9UJI7uL
         FgOw==
X-Forwarded-Encrypted: i=1; AJvYcCVxS0H+8xCiH206mh2J5kPZA0YCuAOiPNFtGrBwY2OBdwCIwWt3pynNhoh9dYbZcjjQh8zQ0qhjyP6wtMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg3u8X1egVMXfaXicVlVM3Ie66BPBJcXwDjSnRx1lsHGut9XhG
	MrcnUWyRmvqnsv1h+1a71ImyBwaMHGnBB9Ud2OKpHCdlqYc4yWOtWdLxA4jSU8JQB5WV8dzg+iA
	gyFCzaYWbmtdvv7kbSSlRelmlhZn+vpDmGlowfis/9A1OP+esxadtaAJ74rMZb2VlcOk=
X-Gm-Gg: ASbGncubNsJdiRDhNrdjvd3hp/ZMB7iqRRcR3lOUXn3ZMD0b2TLdHnlwYtgROQ7xWyq
	y30KodZoRfmClI3cjKQVTo+J8T0fC6FKfLwcJn1KNe+0FvJRk/sGlqN/8Dwoq7V/pono7XBs34H
	1YXad7u5vwpG4fKS3wpiggHEagCiafXccVeLn+KCuKFX5yS91KgGqWZWeuV/TBfkL9xGD1sc0wd
	5Iev3NJO8jZNzQsoL+AzvHqxUWVCOy7zPJ81ruhUNgpJSNV6cJXJ2VurEzAue54YZGQHz48Wxs1
	gxnrg8vJlWJFxZw7Zbdp+afdoid2p30nc6P8wEfmltCJCFIJRmex9snsmsvQbKBTT3rB0nHO
X-Received: by 2002:a05:6a00:88e:b0:776:1f45:904b with SMTP id d2e1a72fcca58-77e4d31b6bbmr3745921b3a.5.1758293289130;
        Fri, 19 Sep 2025 07:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJsuBB0/g57z7HxFan+98g/vSUtfv6DVQ0XiqInQCE6K7qz39QbfM9aRFKgl/UspMyXS4yTQ==
X-Received: by 2002:a05:6a00:88e:b0:776:1f45:904b with SMTP id d2e1a72fcca58-77e4d31b6bbmr3745861b3a.5.1758293288585;
        Fri, 19 Sep 2025 07:48:08 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f097b60e7sm1386902b3a.1.2025.09.19.07.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:48:08 -0700 (PDT)
Message-ID: <1b6d6312-46fe-48a9-addf-b7e362852964@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 20:17:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
To: Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, jic23@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, lumag@kernel.org, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250829-demonic-soft-guppy-512c13@kuoka>
 <zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
 <8fdc99b6-4ad2-4a08-9dca-6289c8fdddd6@linaro.org>
 <nsyhau4pnn2nbxdf35npwq4gvjiphocrftrwi4seirxqzurww6@6jgyzzmjyg7q>
 <20250829173117.000029e6@huawei.com>
 <uvgeuxf7cpnlypif35lvzatdkwrnxynhvf43qw2nc2bvt3zcf3@75kkwp3raqfm>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <uvgeuxf7cpnlypif35lvzatdkwrnxynhvf43qw2nc2bvt3zcf3@75kkwp3raqfm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oXrh_6W7oWKMkgStlRFpC6nT1LiT4Tsf
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cd6d2a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=65c71GXFN9IxV2B_TcYA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: oXrh_6W7oWKMkgStlRFpC6nT1LiT4Tsf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfXwPrIldqfJQ1J
 aHjuGxBPW2J555hQ1YPl7y9kWDp3dGcwZ3adUMieGFwQlu5xnwXbxWiAG5Zp/+ulNBM84FWQ0t+
 OIF/AHIEwFqrDP6+12MHcFlb/V15nlYN+NckaAiKTKaePqCtRIPVwHmm2FdCEZnIyB0EGe7Jqsh
 q2Xiizr2tcf+6hfVW5zQ29RZduXsYlEBo/Jj/PMtkB5ZTfYGAxQ0gUROhvOFIfcVy9etgDTYD5z
 /GEKDQkyzqShGSiX87jsoSWXwLF2jIlkK//v8Y4U9fmePjZlQfAkbYIgOlCsbbkHR9zUuRZHLfH
 GBZ9bYvHpv31n+AeB7eiTV0F5bfONJ1H9+fawRFjjtq7CvDdmSKwD92wv7YJAeXcIh24WJV3iNp
 ZTHQJjz+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

Hi Bjorn,

On 9/18/2025 1:13 AM, Bjorn Andersson wrote:
> On Fri, Aug 29, 2025 at 05:31:17PM +0100, Jonathan Cameron wrote:
>> On Fri, 29 Aug 2025 12:20:45 +0300
>> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>>> On Fri, Aug 29, 2025 at 11:11:48AM +0200, Krzysztof Kozlowski wrote:
>>>> On 29/08/2025 10:09, Dmitry Baryshkov wrote:  
>>>>> On Fri, Aug 29, 2025 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:  
>>>>>> On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:  
>>>>>>>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>>>>>>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>>>>>>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
>>>>>>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
>>>>>>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
>>>>>>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
>>>>>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
>>>>>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>>>>>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>>>>>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>>>>>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>>>>>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
>>>>>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
>>>>>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
>>>>>>>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
>>>>>>>
>>>>>>>
>>>>>>> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf  
>>>>>>
>>>>>> What's the base commit?
>>>>>>
>>>>>> git show 0f4c93f7eb861acab537dbe94441817a270537bf
>>>>>> fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf  
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250822&id=0f4c93f7eb861acab537dbe94441817a270537bf  
>>>>
>>>> I see:
>>>> "Notice: this object is not reachable from any branch."
>>>>
>>>> I guess you think this is 20250822?  
>>>
>>> Well, it kinda is. It's a commit by Stephen, it has proper contents,
>>> etc.  next-20250822 is not a branch, but a tag, that's why you observe
>>> the warning from gitweb. You can verify it yourself by manually pulling
>>> the tag from the repo.
>>>
>>
>> Kind of immaterial.  Typically subsystem maintainers want a base of
>> *-rc1 unless there is a dependency in their tree.
>>
> 
> Basing the work on -rc1 is nice, but unless I'm missing something, patch
> 1 depend on changes that only exists in your -next branch and changes
> that only exists in my (the qcom/dts) -next branch.
> 
> So, it seems that this can only be merged into next-20250822, not into
> any actual maintainer's branch.
> 
> 
> In the current form, the only sensible way I see to merge this is to get
> a version freshly rebased on v6.18-rc1 (before we pile up any other
> conflicts), we merge patch 1 into a immutable branch and then you take
> the rest of the patches on top of this in your tree. Does this sound
> reasonable? I'm open for suggestions...
> 

Thanks for checking this and giving your suggestion. In case there is no
other way and we have to wait till v6.18-rc1 release before patch 1 can be
merged into some branch, can I still push another patch series before it,
to finish addressing all comments? 

If yes, can I base it on some 6.17-rc* tag and should I add the RFC prefix
in that case?

Thanks,
Jishnu

> Regards,
> Bjorn


