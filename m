Return-Path: <linux-kernel+bounces-731801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03251B059B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECC91A6851E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846482D979F;
	Tue, 15 Jul 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h9qVqk3l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006571CD1F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581757; cv=none; b=m3MIjJi2Bq3HceFhM4e+RhB4O45rymo8pxjl7J4UeRxyHHGGUJjA0zlZAdQhz2NHlhhdb7qwKlBvQhirsVFco1ZPwyePgK1WRKLljt+dO5M5gbGwGX9Vb2iZDIAywEOhho/nrS7rtEPA+yfaS1zQj73KhDXuZKhpyvxUMKNzsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581757; c=relaxed/simple;
	bh=RPMIJ06lYpZki9x4OGNT38hsLl9ZRqJRngOVBfL0TkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJvEB7S08RqIipm0dTLwVrEDARuXsBMjTLdvAa0Aub2hiG33OGrAG+O+3LrYpzOK9BHM43c1Ap/d/wrru9cJTPQi5RcWsFU52pIXabIydcRk34f0Pxia0Jr4X7QTapQRFc+Rpn9ug0lQmX8JO7DSGqK8s8wB390Y6NkVWgMudb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h9qVqk3l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCCa6k005751
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gkoL4vyOl+pm49lYyaV0Bkhtxl6H70tCk4Yr8IITAC0=; b=h9qVqk3lN/9/R4G/
	xDSWD+gcL/0teQzBvkGmlmpNLb1kGet1GQ9gmDdVTyDUxVTIZwf5GcpX+nqBp71k
	XdXNUHXjdUlNv/8NJ2D87SkibXiAs6D3NY5q8m4qAViswwF+AhxL9Z03eFQqUj9h
	CU/pWDB6AyodpnOoOZBakz3QdEQ9kVlaGHEM5tyOz10cMtzczMkEiPiiT+5CJIy/
	avwCwSvDPn2ScB51myfnMWqs25hmkRfjJlfwIXQnmP2drsyYCHqeF+u7at2RUI+P
	6AN1ZAhRLcS3f2mThwQ9pEcOnk9WumLIuW5TZKdaJN1SKZ9jtsn0AucOGIZZyNUg
	hiSw1w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58yk03k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:15:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e33e133f42so7691985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752581754; x=1753186554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkoL4vyOl+pm49lYyaV0Bkhtxl6H70tCk4Yr8IITAC0=;
        b=auIdVgYk+gwTH1GlScgTaF6QGblFz38Ql/ktDa0u4X2IZkCn4jVT2YZGia6wFqC/aP
         C7gGy5WqqEj/z46aVnj4FQ+X2B/G5h+3odH6raoh1v/83ERwwUbfh0ZgQNZMTEJlYISc
         p6752hh/vMf9cB+6KGx2H3RqXUCQJcPj+CeCZG7PybGqMx4wYZoSwdOC5neWN0OaVGhR
         v12HUs0oTWoXi9Rhb2LbXEEPiDmWNYnwpSfPRtL88c2yUW0Q6vnXuGRkMjM9laXQ++dl
         nUt6sNFrUuhW4QqgYUhzo7ekOrHYK7NvCV0U1oAIt1W8eQ31964CgsNNJ3HO8L3kxaII
         wu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0Z88KQ4SpLtpyCOlp41IhVBgzc8VwJjz0Watgd2UlqVIa7hKL9XrUsUA7awTi213Xbp432bfVZT08w1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVlUmmDaJGxMy7D8aN2H7pthfV1BORiWmh0Ts6ew23ByLtHJhR
	ycDYQYdF8wOgHxhqu2DJ29JqfTqqKH55/6c2pTUp9Qwuq/E6r9lawFnNDS7JmuM3Q2+hNrMxt08
	eW1ysg4gPYIS/HCkS2D4sbaCyp6mQncfqp+v4l6XpfV0egJuJu88lLWVpvbyTqxAGJro=
X-Gm-Gg: ASbGncvtO2i35eqwZwBr8jOR87m0nUJpNQ4A5Z+aNj6RUqDxxsQEQu6/MZBxUkVNUUo
	FKdzVS83K7VUpB4vkg84jdE3A1TYen/2p4fhN9G7bj+eN7mQKVxzku1FUmePhYovB4kkoybu5UH
	xaSd/gR/4yAe+PBe+qolPiN2Xi2H6OPFQUw+AYsygsqi5gINNAckRXc7kSA0zsHKVCwJqfctrH6
	iztDZqNGQbWyDAhE99ZGdLJJjyrsPp7zY+4x2mmzb0MwqTBQOwjnb9j6hDf55596zA9YNzwuFMG
	ev3HHUNZOCjg1NUHNozR54XZIsnY0UodMKxE5EBiRE7gvBwSGdp7CYJbecuF14/9bKjhJt7XrTg
	Z1uV4ev4u9N3HVHodcPqa
X-Received: by 2002:a05:620a:63c8:b0:7e3:3029:44c with SMTP id af79cd13be357-7e33c738190mr61809585a.7.1752581753385;
        Tue, 15 Jul 2025 05:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNC0tHGCHaMZe1NNLu7kUu5qixnVltKqW5yasSjlLUM9Lwlg4TzACxjlKTv9RGFtYvhko0XQ==
X-Received: by 2002:a05:620a:63c8:b0:7e3:3029:44c with SMTP id af79cd13be357-7e33c738190mr61807285a.7.1752581752766;
        Tue, 15 Jul 2025 05:15:52 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91cc0sm976035566b.26.2025.07.15.05.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 05:15:52 -0700 (PDT)
Message-ID: <bffc8478-4de9-4a9b-9248-96a936f20096@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 14:15:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Introduce "non-pixel" sub node within iris video
 node
To: Prakash Gupta <quic_guptap@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <7b6db4fa-2f73-376d-4eb3-64c1c7e6cda3@quicinc.com>
 <f5ebf0d6-2f0b-45cc-b99a-b786e5df9edc@linaro.org>
 <5qsgbqml367yq6g5vb4lotrzulojqhi5zlwwribze373a63qrn@rxi4kwyt66m2>
 <4f38058d-a2f1-4ac5-b234-228cfb2e85ff@kernel.org>
 <1ad2ca1e-1d57-4ad8-a057-ab0d804f1d49@oss.qualcomm.com>
 <7da769b4-88e9-401f-bb21-0ff123818b9c@kernel.org>
 <6840d462-8269-4359-a6e5-d154842b62db@oss.qualcomm.com>
 <af0da28c-3ca0-41dc-aaa4-572723ea74bf@linaro.org>
 <klhvgzizub33f46buqsog54wqksqp24a5tijwyv355l2ao2imo@wdkojfebc6s2>
 <e1a6e75a-2a5d-44a2-8bbc-140eb86d1806@linaro.org>
 <2hh3zkdwgqbdurpr4tibr3gjat6arwl3dd3gxakdaagafwjdrm@aj5em4tbsjen>
 <6c6f6bc9-7c34-4961-8b5e-e6d02c4b2f6d@linaro.org>
 <25c64712-960a-50b4-e7fa-398e4bf809ef@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <25c64712-960a-50b4-e7fa-398e4bf809ef@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExMSBTYWx0ZWRfX4NimhTCJ4SK8
 RWUByhqysVjoL7E+TYHURQK96wevdwdUsi3oScBd2M4L5j2K9ps0ECm8RbCwkG/NZVJp1eAUEVB
 KvraO4yFItcVuXHTdf3mlRXSo0xz9E0hgB6LbDXaB8uxvMds1HIGRbHOnYdczOAnZ25tJiNr6WV
 Ul+wRoBgup91glwcmNN6YlK2LLfHxguz0Sb/2Gb2NbPw2kL2CAfYJdAt+AomxRAzK0iMmQpMwa/
 RDLdDDOslJW3ihO2J8uhWnUrTqiM9OK3SRJwwROdwBkegFv5FmALMz8OhJncNSGwXNd07CS63sh
 hzRaSbYExlrbc9Gl0tgOUyKzjCw8m5WKAKRd/o/BLxrVaKummJ0/JQ01LB393m1N9sCC1P8uNR8
 3CylID8IvTS1T9jJPtfxfJDZhncde10RHY7kXOCGIWgwFqIUVcrqwOqaAuPhy1BvqXfOv2Or
X-Proofpoint-GUID: zxOi-4dFaS_jgNn5oCu5rGCsSicu7Wvu
X-Proofpoint-ORIG-GUID: zxOi-4dFaS_jgNn5oCu5rGCsSicu7Wvu
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=6876467a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=j_YMfRGaDDqHtg2ur-kA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150111

On 7/10/25 8:18 PM, Prakash Gupta wrote:
> 
> 
> On 7/5/2025 4:14 AM, Bryan O'Donoghue wrote:
>> On 04/07/2025 17:45, Dmitry Baryshkov wrote:
>>> What about instead:
>>>
>>> - keep IOMMU entries as is
>> ack
>>
>>> - Add iommu-maps, mapping the non-pixel SID
>>> - In future expand iommu-maps, describing the secure contexts?
>>
>> Interesting, we are _adding_ so that's not an ABI break and if I'm
>> reading the documentation right, there's no hard rule on what iommu-map
>> defines i.e. nothing to preclude us from encoding the information we
>> want here.
>>
>> This might work.
>>
>> drivers/pci/controller/dwc/pcie-qcom.c::qcom_pcie_config_sid_1_9_0()
>>
>> You can register your platform device to the SID map you parse.
> 
> I see few limitations with using iommu-map here, some of these are
> listed in [1]
> 
> 1. We can't specify SMR mask with iommu-map.
> 2. We can't specify different iommu-addresses range for specific contexts.
> 3. The secure CB support [2] would require vmid information associated
> with per context. I think this can't be provided with iommu-map.

FWIW iommu-map should probably be evolved to support passing more
than one cell of iommu_spec in general.. For us specifically, it's
only a matter of time before some platform's PCIe controller
requires* we pass a non-zero SMR mask (unless we should be doing
that already somewhere..)

(* we can obviously do the masking manually and put the effective
values in dt, but "eeh")

Perhaps that can even be done without messing up backwards
compatiblity (treat it as pseudocode, def incomplete):

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7043acd971a0..bca54035f90e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2068,9 +2068,12 @@ int of_map_id(const struct device_node *np, u32 id,
               const char *map_name, const char *map_mask_name,
               struct device_node **target, u32 *id_out)
 {
+       const char *cells_prop_name __free(kfree);
        u32 map_mask, masked_id;
+       u32 cell_count;
        int map_len;
        const __be32 *map = NULL;
+       int ret;
 
        if (!np || !map_name || (!target && !id_out))
                return -EINVAL;
@@ -2084,7 +2087,15 @@ int of_map_id(const struct device_node *np, u32 id,
                return 0;
        }
 
-       if (!map_len || map_len % (4 * sizeof(*map))) {
+       cells_prop_name = kasprintf(GFP_KERNEL, "#%s-cells", map_name);
+       if (!cells_prop_name)
+               return -EINVAL;
+
+       ret = of_property_read_u32(np, cells_prop_name, &cell_count);
+       if (ret)
+               return ret;
+
+       if (!map_len || map_len % ((2 + cell_count + 1) * sizeof(*map))) {
                pr_err("%pOF: Error: Bad %s length: %d\n", np,
                        map_name, map_len);
                return -EINVAL;
@@ -2106,7 +2117,7 @@ int of_map_id(const struct device_node *np, u32 id,
                u32 id_base = be32_to_cpup(map + 0);
                u32 phandle = be32_to_cpup(map + 1);
                u32 out_base = be32_to_cpup(map + 2);
-               u32 id_len = be32_to_cpup(map + 3);
+               u32 id_len = be32_to_cpup(map + cell_count - 1);
 
                if (id_base & ~map_mask) {
                        pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",

Konrad

