Return-Path: <linux-kernel+bounces-850131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B9BD1F91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E88F34E9D82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1CD2ECE89;
	Mon, 13 Oct 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lxtkn/Gj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410F2ECEAB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343327; cv=none; b=oYR4LHqXy/HNZ9WdZtbtEUxsNwWeQMWUncewe2onmNWmkiyCTZHcVYP9/Z75AAnAocJxSMmbosmyxtG3gUIa75wLau5P5LwD12mSZov9RUjXnNeopzpBLk+SwERchqxE3pT+HeE56PXkdgWvyw3glcYIScDarVUTGkAKN39JqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343327; c=relaxed/simple;
	bh=UDNiuRHciTHENXoW3H+Y4cG7ha6QFPCjrMA11qh+a7g=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=PPl96hlxwHTIKB/AJNZSVzsv7/qMHA+iGfpWp+AvMKSeoCo5C+q/+W8tCHJDMbQNGJrUWcVB0ZmMBKcew8VKEfuvrk7ahSrmwgSWp3DU5QkAzwUTWDJAz6X8JNJLhOJ0whCmcV3hERIqGVvDpRXY/724Wl5xc5gXTmrgVOjWIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lxtkn/Gj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n7PI024088
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OmjY9D9cVuil1Jp7xNrdQS+H
	TpGdggwgMksMl4rh6Dg=; b=Lxtkn/Gj/YxXyTGYl/9yBR/u3E1b6YRb+e6NY8zu
	szFPQ6pX3Txu9V2j08fiXqyHMeWMJwnVVgYsN6t5S9CRzYSNSYW8UspMJZQOQrcx
	gQyKbKp9djnm8ReNT9RBCkL9QfayYDoTzFoR2p8x42ILXyg5vs36fMZWR9qqjZVA
	LlE24z/XlXpXwAA0z6mK+sGNLMto9SpBb6LqjnksvQf5cGWwfs32RNBP5zjzKgYn
	/6xowmZEP4vVyI1kOg7e+sHJ7234fkgPBdclu3PnRhNUhJalWfKfAwpadgW0bkuO
	KTv/VyoLE0QGXkUn0khIr9+t5ypvwatsB4BgoOf8/zDfVA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa83rpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:15:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8247c6738edso22427646d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343312; x=1760948112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmjY9D9cVuil1Jp7xNrdQS+HTpGdggwgMksMl4rh6Dg=;
        b=eUnjsMPRQYZ5bnj/aSrhoryNJgVaOBADa3XQbW2xs0hgDtlhUduR6A7xomPQqw0/95
         byRrEJCkz77116Jy3JoZ/TJtT5N2wsTB+7gy3l/+CDTnn2U8vsscXZjb64Da85te4zLx
         av23/1vKLe2mjxCvBaWEtZIiIWL8rILLUtTyyor8h2faEFpmTgtqX1+r/fGn6x/p9L9G
         R14OC6SN3jgWBEzvZbYkjTkaRTqR5c4iy2PUw4DlzbDTYr9D9okxJVOn8jUH2FrNncKO
         4sgEprK7561Ch6R7ynVqkKGUwDo8rPU4Gv0Zz21HPPSMV46nG6grGR0x1+NwtYQ3xVBb
         YvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4Hh4RHI+JcU1bperDVj/F5zY3s24DN0uGApB20ZQHulRe+wJN23k3yGijA3dn0Y3gu1tAIGjLsU9TTvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVV7I8r5vFyMqE0AyonQiyahEBgI8Fr1+fDcatdvtslCanp/jv
	QoN77DFgZVYwO6xUk4xKtkHm76GC3PTVA5eZURQ1Z98neJQT51mVFjDXecW9Oo49cESbknpXHDp
	gYXsjny0FAeYc13zA3qI2AhXZ0vjtK0M/z3sLHfqLxaqHx7deQhXUj6UUKS6s0ID3w9g=
X-Gm-Gg: ASbGncv1NOXA0NdM/WFPMeymCy7zotea9xUnovHMigDKLdHC+sIsGumXZ+SqvnHSVm/
	UrNgdyozO4ccdITZZujDkG1og/CdrbRhgplT9qJcSVHdr1gmVoQfMjya+tbgGtX6jjZb+7Ui8fR
	VtS31DLu2rplt+bajZT4AAWK7d+yWZK2YbHuApVBapwjZeZLrZjGdAYOb1gbWzd+mvPe6pzlq1o
	a/cog5JybT3LZyNDoZJ0xXCaQCISN5GiTxWZGrNP2B3vJWFw1PASJRkeRQjk4PN07LpPTdFmica
	Hbrt7yTfeWFRk6K6ZLw/qaqDw6H/jV3+2URANvUOYzwuTvAcGyTc9cBN4SOvwRmAD11emn7JZSo
	2Q+2epmRej7He6YkOpShnPQ==
X-Received: by 2002:a05:6214:5293:b0:830:4f29:a648 with SMTP id 6a1803df08f44-87b2ef56426mr190156866d6.6.1760343312439;
        Mon, 13 Oct 2025 01:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWN9TUiP9L1PngcZDktR1FONmHpUuUUh8sPFbC1MEyINUVTLX70UosEp/64j95AzjwijPaMA==
X-Received: by 2002:a05:6214:5293:b0:830:4f29:a648 with SMTP id 6a1803df08f44-87b2ef56426mr190156666d6.6.1760343311929;
        Mon, 13 Oct 2025 01:15:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f358sm8333942a12.10.2025.10.13.01.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:15:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------pxY94ReoyjunEHqT0j6EGWe1"
Message-ID: <0c8735f9-eac0-449c-aa95-b82cec0e6cb2@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 10:15:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: add system power domain SS3
 state
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012225950.15475-1-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251012225950.15475-1-val@packett.cool>
X-Proofpoint-GUID: RDIlNONZZGb0yMYbJPDW0K_Gjx4pFU4o
X-Proofpoint-ORIG-GUID: RDIlNONZZGb0yMYbJPDW0K_Gjx4pFU4o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXyCHCzb2iXokH
 d1HYfXPn0VYt3mi9AMTE9gWevkZPXn8BDUQOkCUAYusMHh/04zZkL+WMxMUIGqB8xDZmegqZlyG
 tzTp5Y2efYFxrCy3Rks+z5MICSr9IQQGnYF/3x2fVsUMHVpYu+p7iTEVxSZrWbDh11Gj0PnObMY
 z2mFr8oQc38IHf1GIGYCdMxhlq0ub95Q3t3wkMvO8o7LDWdN9pjPWDZr2ie6oCAT5F2VrvTdfCI
 +RWTo/cf0TijIvj93U7ZyGt3+DbRqs3DwKPoMBm/LQwWAPOPM0q0QF/CoVCtmA7CI3wFJJVFEp/
 if9ZVejOjhm2K3b/z+lAPZSRfoYzqaK74Yf7+E+3De6lo0oqr2fMdBgy4Tz8UtaiM+lcBS4/KYx
 HlZjnzPUHFRlFrno3jwgFvVqpz1goA==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ecb51c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=x6icFKpwvdMA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=S649r15P7wmwVG3cJHoA:9
 a=QEXdDO2ut3YA:10 a=8ls2GUBa6XCicvKWzpAA:9 a=B2y7HmGcmWMA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

This is a multi-part message in MIME format.
--------------pxY94ReoyjunEHqT0j6EGWe1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 12:54 AM, Val Packett wrote:
> Add the same PSCI state as seen on other Oryon-based SoCs like SM8750
> and Glymur, seems to work fine on Hamoa as well.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
> Tested on a Dell Latitude 7455:
> 
> /sys/kernel/debug/pm_genpd/power-domain-system/idle_states:
> State          Time Spent(ms) Usage      Rejected   Above      Below
> S0             69476          23006      195        21562      0
> 
> Seems to mostly be used in system suspend, though I've occasionally seen
> the counter increment a little bit during runtime as well.
> ---

FWIW the exact same state is hardcoded to be present if you use
PSCI_SYSTEM_SUSPEND (which is mapped to `deep` in /sys/power/mem_sleep)

>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 3cf2568def3f..fab8104147bd 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -303,6 +303,14 @@ cluster_cl5: cluster-sleep-1 {
>  				exit-latency-us = <4000>;
>  				min-residency-us = <7000>;
>  			};
> +
> +			domain_ss3: domain-sleep-0 {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x0200c354>;
> +				entry-latency-us = <2800>;
> +				exit-latency-us = <4400>;
> +				min-residency-us = <10150>;

You seem to have copied these time numbers from 8750 as well, but
it's not a great idea, since they're tuned for getting a good perf/pwr
profile for a mobile phone

I attached an old patch I had laying around that described all three
states exposed in the windows DSDT (although I'm not sure if that's
exactly beneficial without additional tuning too)

+Mukesh please take a look

Konrad
--------------pxY94ReoyjunEHqT0j6EGWe1
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-arm64-dts-qcom-x1e80100-Add-system-sleep-states.patch"
Content-Disposition: attachment;
 filename*0="0001-arm64-dts-qcom-x1e80100-Add-system-sleep-states.patch"
Content-Transfer-Encoding: base64

RnJvbSBkZjc0ZTBlNWY2NjliMTM2YTA4Zjc1ODY1MTc3MTQyM2I4YmU5YzYxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLb25yYWQgRHliY2lvIDxrb25yYWQuZHliY2lvQGxp
bmFyby5vcmc+CkRhdGU6IE1vbiwgMTUgSnVsIDIwMjQgMTY6MTY6NDEgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBhcm02NDogZHRzOiBxY29tOiB4MWU4MDEwMDogQWRkIHN5c3RlbSBzbGVl
cCBzdGF0ZXMKCkFkZCB0aGUgbWlzc2luZyBzeXN0ZW0td2lkZSBzbGVlcCBzdGF0ZXMgYmFz
ZWQgb24gdGhlIGluZm9ybWF0aW9uCmZvdW5kIGluIHRoZSBEU0RULgoKRFJJUFMgaXMgYSBu
b24tb2J2aW91cyBuYW1lLCBidXQgaXQncyB0aGUgc3RhdGUgdGhhdCB0aGUgZGV2aWNlIGVu
dGVycwpmb3IgTW9kZXJuIFN0YW5kYnkgb24gV2luZG93cyAoc2VlIFsxXSwgWzJdKS4KClRo
ZSBlbnRyeSBsYXRlbmN5IG51bWJlcnMgKHdoaWNoIHdlcmUgbm90IHByb3ZpZGVkIGFueXdo
ZXJlKSBjb3VsZCB1c2UKc29tZSB0dW5pbmcsIGZvciBzdGFydGVycyBJIHNldCB0aGVtIGVx
dWFsIHRvIGV4aXQgbGF0ZW5jeSwgd2hpY2ggaXMKbm90IGFuIGVudGlyZWx5IHVucmVhc29u
YWJsZSBlc3RpbWF0ZS4uCgpbMV0gaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29tL2VuLXVz
L3dpbmRvd3MtaGFyZHdhcmUvZGVzaWduL2RldmljZS1leHBlcmllbmNlcy9wcmVwYXJlLWhh
cmR3YXJlLWZvci1tb2Rlcm4tc3RhbmRieQpbMl0gaHR0cHM6Ly9kbC5kZWxsLmNvbS9tYW51
YWxzL2FsbC1wcm9kdWN0cy9lc3VwcnRfc29sdXRpb25zX2ludC9lc3VwcnRfc29sdXRpb25z
X2ludF9zb2x1dGlvbnNfcmVzb3VyY2VzL2NsaWVudC1tb2JpbGUtc29sdXRpb24tcmVzb3Vy
Y2VzX3doaXRlLXBhcGVyczQ1X2VuLXVzLnBkZgpTaWduZWQtb2ZmLWJ5OiBLb25yYWQgRHli
Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+Ci0tLQogYXJjaC9hcm02NC9ib290L2R0
cy9xY29tL3gxZTgwMTAwLmR0c2kgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20veDFlODAxMDAuZHRzaSBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvcWNvbS94MWU4MDEwMC5kdHNpCmluZGV4IGU4MGE0NTRmYjhkZi4u
YTM1YWI0ZjdjZGM5IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20veDFl
ODAxMDAuZHRzaQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20veDFlODAxMDAuZHRz
aQpAQCAtMzAyLDYgKzMwMiwzMyBAQCBDTFVTVEVSX0NMNTogY2x1c3Rlci1zbGVlcC0xIHsK
IAkJCQlleGl0LWxhdGVuY3ktdXMgPSA8MjUwMD47CiAJCQkJbWluLXJlc2lkZW5jeS11cyA9
IDw3MDAwPjsKIAkJCX07CisKKwkJCVNZU1RFTV9TTEVFUDA6IHN5c3RlbS1zbGVlcC0wIHsK
KwkJCQljb21wYXRpYmxlID0gImRvbWFpbi1pZGxlLXN0YXRlIjsKKwkJCQlpZGxlLXN0YXRl
LW5hbWUgPSAic3lzdGVtLXNsZWVwMCI7CisJCQkJYXJtLHBzY2ktc3VzcGVuZC1wYXJhbSA9
IDwweDAyMDAwMTU0PjsKKwkJCQllbnRyeS1sYXRlbmN5LXVzID0gPDUwMD47CisJCQkJZXhp
dC1sYXRlbmN5LXVzID0gPDUwMD47CisJCQkJbWluLXJlc2lkZW5jeS11cyA9IDw3NTAwPjsK
KwkJCX07CisKKwkJCVNZU1RFTV9TTEVFUDE6IHN5c3RlbS1zbGVlcC0xIHsKKwkJCQljb21w
YXRpYmxlID0gImRvbWFpbi1pZGxlLXN0YXRlIjsKKwkJCQlpZGxlLXN0YXRlLW5hbWUgPSAi
c3lzdGVtLXNsZWVwMSI7CisJCQkJYXJtLHBzY2ktc3VzcGVuZC1wYXJhbSA9IDwweDAyMDAw
MjU0PjsKKwkJCQllbnRyeS1sYXRlbmN5LXVzID0gPDMwMDA+OworCQkJCWV4aXQtbGF0ZW5j
eS11cyA9IDwzMDAwPjsKKwkJCQltaW4tcmVzaWRlbmN5LXVzID0gPDgwMDA+OworCQkJfTsK
KworCQkJU1lTVEVNX0RSSVBTOiBzeXN0ZW0tc2xlZXAtMiB7CisJCQkJY29tcGF0aWJsZSA9
ICJkb21haW4taWRsZS1zdGF0ZSI7CisJCQkJaWRsZS1zdGF0ZS1uYW1lID0gImRyaXBzIjsK
KwkJCQlhcm0scHNjaS1zdXNwZW5kLXBhcmFtID0gPDB4MDIwMGMzNTQ+OworCQkJCWVudHJ5
LWxhdGVuY3ktdXMgPSA8NTAwMD47CisJCQkJZXhpdC1sYXRlbmN5LXVzID0gPDUwMDA+Owor
CQkJCW1pbi1yZXNpZGVuY3ktdXMgPSA8OTAwMD47CisJCQl9OwogCQl9OwogCX07CiAKQEAg
LTQzNSw3ICs0NjIsOSBAQCBDTFVTVEVSX1BEMjogcG93ZXItZG9tYWluLWNwdS1jbHVzdGVy
MiB7CiAKIAkJU1lTVEVNX1BEOiBwb3dlci1kb21haW4tc3lzdGVtIHsKIAkJCSNwb3dlci1k
b21haW4tY2VsbHMgPSA8MD47Ci0JCQkvKiBUT0RPOiBzeXN0ZW0td2lkZSBpZGxlIHN0YXRl
cyAqLworCQkJZG9tYWluLWlkbGUtc3RhdGVzID0gPCZTWVNURU1fU0xFRVAwPiwKKwkJCQkJ
ICAgICA8JlNZU1RFTV9TTEVFUDE+LAorCQkJCQkgICAgIDwmU1lTVEVNX0RSSVBTPjsKIAkJ
fTsKIAl9OwogCi0tIAoyLjUxLjAKCg==

--------------pxY94ReoyjunEHqT0j6EGWe1--

