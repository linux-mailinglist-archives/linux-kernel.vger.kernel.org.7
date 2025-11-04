Return-Path: <linux-kernel+bounces-885147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD729C321E2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E2614F0AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110A4335086;
	Tue,  4 Nov 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z8RqijMF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cbhlwGCu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E6334C1D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274592; cv=none; b=TzDmJhX4UqIMEUyYO3UW6GKjYaFsZWp/9NcMssYQWYgCGJ2c1BlnIVZN3S6RFaM3c9rnEJ6bh603HRhckaQZpDjZcaU0gzlMfpDxogyQf+3+fp454eym6kB393lhMIjYY93vC2elxJB6owXi4zZC6HPb3XclXplTH77OC2+acMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274592; c=relaxed/simple;
	bh=3iGgYxxtQuWZvtgGO61gZgATALoWKUJ2moq6radNC84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0MnS64XpP1Nq9HKSwsGfsI+k3oBw3Y0zjnhQWZrkZuMs7WLG0TWDKBYsXq60Q/RmDlnYIhNF2p77ZKKGCs+vNomr5hoX9Apzq9pEpjVaDnYZ+XPF4TGQ7RS1lUETImGfSiQ8f4zjenUWuG+a14YLG9FUJCoiYZckaEpAatCoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z8RqijMF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cbhlwGCu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Gg3gk2547232
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 16:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9s3RA8l3BgP/9QCFsxhXosXbQQbRQ0RF30CvjuNoA4M=; b=Z8RqijMFzjObmRqX
	jPOdlGjZkZirxxVwDHYXEkJ+QK5br+4EiF/J/u3xeSjRyicdv/cOAoMj/KSvzipX
	/Vd5oPHlzC2WYdFq0NmmV/k1gbz4vO1petxYrGIpE7mYvxq12zAq9l1pC3a51PWV
	zjnU36b4cal+3BZB9y0no9aIxvA9V8eNnNwYjTQy05h0kW/2lJ+3vDuNBsqKgJ7R
	E+o1H2s6wIfbvt1zM7tdTAbHKhRar8U7ahKt4iYh38saDvw14YQ8lbQgmcnoyRzK
	KgZzSGy1OUvEBDX2JQGA60p4LPDrWDUwkDLMsCU4O4P8sGbgCe41SqxoBZijYnrg
	3i5LCA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7fgrh2w9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:43:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8b86d977fso24391751cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762274588; x=1762879388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9s3RA8l3BgP/9QCFsxhXosXbQQbRQ0RF30CvjuNoA4M=;
        b=cbhlwGCu6d/cZjVMeCLaJkFwbc17LyeF+4+xfDvfylnwi+V9htXU+vCnzmXeFH8YVP
         DIzwrTap2764BGJOBkUZvDh9h/Lk5/AmcHhGv5qIXd2Euc7645dsWPVQlFQPosuvkOtD
         tbSeNDA7Na0glIPfi2+WLM9jajb6Z2A2VuE5M1mfm6jKdMVjJZP2PriuhI/t2HinQXb5
         QAMLx/zOrd2OhowvRYR8blSFzpUJ5vCCH+mmPQveQ9jZsr9d8PG2pfGTPuTTe3MmBzCh
         xp26nWMbuVuq0fyMSTSd4rJURJW46Ci0kif3FfgFyJ1gXP5buFOW+H9fmxYa92by90wW
         16Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274588; x=1762879388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9s3RA8l3BgP/9QCFsxhXosXbQQbRQ0RF30CvjuNoA4M=;
        b=VOhDgRxz2cpSDJxl7OVjZfPoeYGr09PWPSl1SM4bE5l7T9EubdtUlwqJUoHSv71b5/
         HEs08ojAxfx8l38bpzv8jrbrhbV79zNqtXkxUNlpDr9ScUwryCpCm7aSRLfBy6J0ENV0
         qzFfsC5ZDcvXUoQzl1oPi6gTeai1J2gNbQ+iuSTsIWPmsdG0rqb0nyIb+WNBuoJWf0HL
         DU+b2TCcmqHTOoMSyIMoVhGGiwk91pcoV9ISHrkNcAJxwMXpFTARp7C8IuVLCW1YUj4u
         gi17D9eS+7Tptw6Ko1RwBRcyTkuAbEAP74GFIp4DQy+GKzfnOqWv3myqhBlNRKy5rwbO
         wyWA==
X-Forwarded-Encrypted: i=1; AJvYcCXzvX+jSfSo+JC6vOiHRfQ1oIOb4fOjom+6pOeNGcjwSN4IWhAJ0wga+4Z5Kc0OEuuH6wUmDneMndCfTXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJks9NI4OG4nRMrL3QoeQL5feb3OUYOJDoyD2TnyF7T1o7o6x9
	mj55y1UfNRnKa8F1pupwMr3+2HiYBYmZic+nTGzYGq9vuTixpY/l/kWD9rv1Z2f+kD+6xVOBHvr
	Bxeo2jv4S5ns3SMkmuCdcsIcHl22Lz4kUDaHavsqxVpEwXufsRlnW1QgBcOlV9TWf4wA=
X-Gm-Gg: ASbGnctNJkEBGWxh320emtb+BbaqLNYkkjKVmQaxKlOhbV1DoelkWFmghjDr/wr9+Ff
	bbAdzJ0ZfIc0Bt8Z8LvA8TyQUCwZPw6CqIGgqFJPbd//PSYUtdRGdmrQK9eaIwX1352zmiPmCsY
	oJXjag13DC0gIUJVYCyBP/7R5JfGRqpDc9bjpX1J9yliNr2TGVSqYsOgezelm4VbTjC8dTJ0Edm
	btB0e9AnEs4FOr/0xXCA4qdJmbJfYYzLaAS6m1vgeJYobxUF0YKxtz0M4HvV/p/3rYCJY6kpw2Z
	NkqlFLO1aBAWonBU4FaWn3g/toHk8sJj7DGEWdqkfbNK5dpilWVGjteyj2C6M2qljyhf/QxHL+l
	MF+coyH2MxNlmcHwMNVASb/1y1CxZayswn5cQ21YRiRwELgWlyyDlv81Y
X-Received: by 2002:ac8:5d4d:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4ed7213b57dmr1946561cf.2.1762274588114;
        Tue, 04 Nov 2025 08:43:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ4JvkGlhZ/hqhR3Z/n//oLvvoGHPq6LtH+dnI3wwGK6XeQZauNqIGX2cfHu0XV9feBYEMZg==
X-Received: by 2002:ac8:5d4d:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4ed7213b57dmr1946211cf.2.1762274587554;
        Tue, 04 Nov 2025 08:43:07 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26d1sm248514466b.35.2025.11.04.08.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:43:07 -0800 (PST)
Message-ID: <571d5733-be1b-449c-ba5a-414e0f950463@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 17:43:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com>
 <29b32098-39ca-440d-9b51-915157b752b5@oss.qualcomm.com>
 <2d4a192f-45b2-4aee-bcc9-dbe0dce0aa93@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2d4a192f-45b2-4aee-bcc9-dbe0dce0aa93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: D0gWKAnIdzobn9gWAm7TDxMZdqRL0Zh_
X-Proofpoint-GUID: D0gWKAnIdzobn9gWAm7TDxMZdqRL0Zh_
X-Authority-Analysis: v=2.4 cv=b7O/I9Gx c=1 sm=1 tr=0 ts=690a2d1c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gdQQi2AoJGqifGrzje8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0MCBTYWx0ZWRfX7Wp7QJHJY7bV
 k9PFBiu4IhR2MiFHs/yN4zrd40muJqVR8P2oWpynhMEjOBncrYlUrJz5BpKzAlJEeuvCRcM/aXY
 5rwWfS66fni/0ZdrYeHz7gLtm0T6azgRufACgczUom0Lmp+JwmxpJX28t3qLl14M7JI41Bde1JG
 4jgEwqVmLCRojTgSV78q+FGoY6a9HLR6qz4FqtDwqsEjiy3V91wJGnM1dZwwuAGXwMuGa2wBVyv
 MQ+9VtReOJEbJ4WM5ydPIUglESB6Am76MlXiElesLP5msHnOfXzeLk8eCGpHunSpOy1a9AS2XXA
 E0gtYWS1+50IsyhTLc6VyXOzhJ1xIVpxAJWhers/epGf68d+HSNq4A+phnVQ0o+JWCQuErXA7lW
 m+qkpfkDkVOQ8u75CanZr9V0SaWbiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040140

On 11/4/25 5:38 PM, Krishna Chaitanya Chundru wrote:
> 
> On 11/4/2025 5:59 PM, Konrad Dybcio wrote:
>> On 11/4/25 1:12 PM, Krishna Chaitanya Chundru wrote:
>>> The T_POWER_ON indicates the time (in μs) that a Port requires the port
>>> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
>>> asserted before actively driving the interface. This value is used by
>>> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
>>>
>>> Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
>>> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
>>> This can result in improper L1.2 exit behavior and can trigger AER's.
>>>
>>> To address this, program the T_POWER_ON value to 80us (scale = 1,
>>> value = 8) in the PCI_L1SS_CAP register during host initialization. This
>>> ensures that ASPM can take the root port's T_POWER_ON value into account
>>> while calculating the LTR_L1.2_THRESHOLD value.
>> Is 80us a meaningful value, or "just happens to work"?
> 
> This value is given by hardware team.

Sorry I asked the wrong question

Is it something that comes from the spec (PCI or DWC), or is it qc
specific?

Konrad

