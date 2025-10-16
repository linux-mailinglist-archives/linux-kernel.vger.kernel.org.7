Return-Path: <linux-kernel+bounces-855732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67387BE2237
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF5D0352A87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A643054DB;
	Thu, 16 Oct 2025 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="giqMW1bc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCB304BA4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603051; cv=none; b=Tk+dOe8ZMmbVCXuM+tcZeZomJNxD4fl9m3Rh8/FF7zZygaWaIGb0JPdKZMu9fvMZgOF1S+rxsXdwR0GZBDFqb33d9hmngYooLKe9I+o5id5nv7zVFo+ukHTflH5L6+6vyNGcJppAbKvdf/Obqkt4YmVbHuqfKQNbW35FH5uJMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603051; c=relaxed/simple;
	bh=ZZroxsNAEgSwczAGeTWehfgDT0FVPWSIbqAPl4PD9GY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=PT2bBbZzGdcmZK9XHojgOZ04PuGwyife7FdDh07HTBDTPinkxo4RG5z8ir6dEuTtvargSoCC1m9PxY47C4tCS8sp8I342lpHVuzhkipeZQjJZui07pEFbjMvvIOj64kITIJvO9eVaLZV2GWOiD5YsSIxxHgVO2deLlxuvGqOXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=giqMW1bc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G71uYF003414
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tLspn+sXAuQv7dxVXLpLQqXZ
	KlloivCUx0//CGsa3B4=; b=giqMW1bcRzMOu9TH+Sq88pPEsWnFQ6NJhjvf2pJ0
	X2mLlpwPMdBWivUVhJw+YK7cdrSXaYCHfjhAt2ahbz6kDDYEwn1dHoHsj9TL10aL
	0K7jogV51Iin5/Fy8v5ZamXZEy296dD6fCb5xBjMxiPgLrstHZ9GvILFJgBPhEnK
	kHbCEsE0E5AP5AHutUXI24HUS5goxpHiFiLh8numBVwJcb7dab496EPUNXBu0Eii
	W6234TltdFgdu/2Lbjc111RA8PGQaVSkCMsm5EbVDzDfLpkoOdXQwqwdNi+/AMvE
	b862rUw3pidlVnDkotm/nJF+IEq67NzVHPgCgH1bZ9dEjg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8p6ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:24:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88f3a065311so16707285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603046; x=1761207846;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tLspn+sXAuQv7dxVXLpLQqXZKlloivCUx0//CGsa3B4=;
        b=s5qD/w8CDAutPKQves1LpqkYWwL5IVgUtZ2TwRdvZLGiAn9ZkFkhIh86VHhbMXW9PJ
         lEdVKB7ftRiwLiOneRkCS+JG0oB2hEOKp+DTdFqq/92dA2PxxsOlxnQEj5l6uAumNXS1
         71fOVHiJY0NgUTep/UBQ+j4NBpOonZvRV786UyWTMzD+a3QpO5a9Y2KI+ZcC1D8NDfTy
         i/bFeJzTyPREppy1UktGhIGXxhi+1hHzwQ4dOo36hNMenDsApOrnORBb77voIM4xcyLp
         UdkUJwlUZTJto4G/6OMAk77Rf0KB6CeLzxZH8aHKDULrQ2kYzYjsJ9pRgkYsLDdNdaAA
         3sWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQICkGu9Zv1VlaHJ7o6B15KkIAfaoChSs918wLtoNneVNT3RYJynKZdLnyeVKwS/dRoeq6+3iz9nxv0uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIeo/BYx8/GPjre2yvpWFB3QkrDZ9Etm/WQYsgb18dw+/1d0pL
	CsBOlefdDAN8GXZ91AKFwTXyaVC0Op1C2AFXVtyok7FzAiLpT/L/23yRxWXbLfNxY7921P3OJpJ
	h8OsN61Wbpj2llxkQvTv6wTRUa3riZKQ/wLd/nwKLrVDCWbuHla5gZJKL0n7r2IWS228=
X-Gm-Gg: ASbGnctpkZwcUJ1aDUKimv4rqysskUBaP2zeZAw9cLt7tlNtm8F2PUDjUWcV3Jmk03F
	yh7dtTPARUXqcdR3iq1z2NSDSOQQ1a3MztL1av1tIJm4/Q+n1iZKyyR14/BkUCpYQZUHBbAtg71
	l9bTcQ+hWy18d2J3ANpF7rt77ZoPsxlaqeUFfeVs9vpi5gFj5XjK2mKlAfUQbVNYHOtkVUgv/+l
	WhsEtL6bAPJNWw6KZahnyF3M24tYnywMbsdjaiDQKKizOPz932V78WnjDEn+/Z8JrQfOCJD6gPA
	qCfQThyDKtYhNRo1jrstBHdbBpVlg5yzKzZ7pW79GxbB0gnFTl8T/yc9RCRjlDKF1VyVdnNYbWf
	PEriiyDnPPRDp3+KF3IwhKrCYVQhj0feKKVWe5DmLA5D1Uaj4GIOzgG7Q
X-Received: by 2002:a05:620a:3d14:b0:88e:83c4:99de with SMTP id af79cd13be357-88e83c49f2dmr249002085a.10.1760603046484;
        Thu, 16 Oct 2025 01:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNjoX35Hf5/4TDUn5cuAOimH21PjME+9WdGGAYgQevO8GHJj6ZB0+GFvGFoNQY7mK6HUwXxw==
X-Received: by 2002:a05:620a:3d14:b0:88e:83c4:99de with SMTP id af79cd13be357-88e83c49f2dmr249001185a.10.1760603045790;
        Thu, 16 Oct 2025 01:24:05 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd6b457esm447870166b.76.2025.10.16.01.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:24:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------sSk5JAkndINXoX824lhv1Ic5"
Message-ID: <5a0a0255-3c29-4e31-ab15-d286dea1ccb4@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 10:24:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] arm64: dts: qcom: sm8750: Add USB support to
 SM8750 SoCs
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Eric Biggers <ebiggers@kernel.org>, nfraprado@collabora.com,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com>
 <20251015105231.2819727-2-krishna.kurapati@oss.qualcomm.com>
 <80c71cfd-e12a-4707-ad03-e03b0ac48838@oss.qualcomm.com>
 <fac1a1a1-43a9-4bec-a6be-812e7d97e807@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <fac1a1a1-43a9-4bec-a6be-812e7d97e807@oss.qualcomm.com>
X-Proofpoint-GUID: r1gnOsfbGRQyhPYuWtwxRRLIrKuF7zc3
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f0aba7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=V6SiT3HrjUhaa_fPiuUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=KofzomiH3cK2qzB-QwAA:9
 a=B2y7HmGcmWMA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfXwaSUNmhcM7wG
 lKMMgVpPrXlMIk/6XQ4IA9V8v8aOYmw779Md6b80jc9/4eRj9PpUktVKW0qztLkHel2ublGEDjd
 258gpapc7EIvp48Zf7EkFlf0i6JWZApLzOMS4G0+DrC+xDfBblr3G0jQ9gzLuC6CQ+OVCNUAoEr
 zxWTWcaXpXnpdXrU57LrIb3JB0nVoflOJU2e8ibAaJ57oa9hFOZeRccYZbTIcNbfF4ARFGEet4B
 BGkWMLxFAgDdPa0JPUqa8BC/1Z6OAJeN/sd17Cm/KhqXOCeLT3OGPgjnbJnB2IQHAe5mzjqDXcf
 UI5vUgXy8qIqcoPgCxmABUIsOYvsMgf1RxI+ynF7U9iIzfunHEoC0YAuwGsCQygmd3YPX/CTYLR
 BPAx+tozeUQwj79xhKppNJPI4q0cLg==
X-Proofpoint-ORIG-GUID: r1gnOsfbGRQyhPYuWtwxRRLIrKuF7zc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

This is a multi-part message in MIME format.
--------------sSk5JAkndINXoX824lhv1Ic5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/25 9:51 AM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/16/2025 12:59 PM, Konrad Dybcio wrote:
>> On 10/15/25 12:52 PM, Krishna Kurapati wrote:
>>> From: Wesley Cheng <quic_wcheng@quicinc.com>
>>>
>>> Add the base USB devicetree definitions for SM8750 platforms.  The overall
>>> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
>>> (rev. v8) and M31 eUSB2 PHY.  The major difference for SM8750 is the
>>> transition to using the M31 eUSB2 PHY compared to previous SoCs.
>>>
>>> Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
>>> PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> Signed-off-by: Melody Olvera <melody.olvera@oss.qualcomm.com>
>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +        usb_1: usb@a6f8800 {
>>> +            compatible = "qcom,sm8750-dwc3", "qcom,dwc3";
>>> +            reg = <0x0 0x0a6f8800 0x0 0x400>;
>>
>> Please resend this using the flattened model
>>
> 
> Hi Konrad,
> 
>  I didn't want to disturb an ACKed series and hence I just tested and resent the patches as it. I will flatten it out once this is merged. Hope that would be fine.

This series generates dt-bindings warnings as-is, so that's a reason
in itself..

Moreover, you're introducing a user for a known-limited ("broken")
dt-binding with the intention to fix it up soon(tm).. the changes are
not really groundbreaking so I think none of the reviewers will mind if
you just apply the below diff (attached, compile-tested only)

Konrad
--------------sSk5JAkndINXoX824lhv1Ic5
Content-Type: text/x-patch; charset=UTF-8; name="0001-x.patch"
Content-Disposition: attachment; filename="0001-x.patch"
Content-Transfer-Encoding: base64

RnJvbSAxODU1MGVhM2YyODVjMWMwYmYzNmUyYTlhYmQwMjc4MGRkMGYwYWYyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLb25yYWQgRHliY2lvIDxrb25yYWQuZHliY2lvQG9z
cy5xdWFsY29tbS5jb20+CkRhdGU6IFRodSwgMTYgT2N0IDIwMjUgMTA6MjI6NDggKzAyMDAK
U3ViamVjdDogW1BBVENIXSB4CgotLS0KIC4uLi9iaW5kaW5ncy91c2IvcWNvbSxzbnBzLWR3
YzMueWFtbCAgICAgICAgICB8ICAzICsKIGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zbTg3
NTAtbXRwLmR0cyAgICAgICB8ICA2ICstCiBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc204
NzUwLmR0c2kgICAgICAgICAgfCA4NiArKysrKysrKystLS0tLS0tLS0tCiAzIGZpbGVzIGNo
YW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDUwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvcWNvbSxzbnBzLWR3YzMu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvcWNvbSxzbnBz
LWR3YzMueWFtbAppbmRleCBkZmQwODRlZDkwMjQuLjE0Mzg2NWZkZTNhNCAxMDA2NDQKLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9xY29tLHNucHMtZHdj
My55YW1sCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvcWNv
bSxzbnBzLWR3YzMueWFtbApAQCAtNjcsNiArNjcsNyBAQCBwcm9wZXJ0aWVzOgogICAgICAg
ICAgIC0gcWNvbSxzbTg0NTAtZHdjMwogICAgICAgICAgIC0gcWNvbSxzbTg1NTAtZHdjMwog
ICAgICAgICAgIC0gcWNvbSxzbTg2NTAtZHdjMworICAgICAgICAgIC0gcWNvbSxzbTg3NTAt
ZHdjMwogICAgICAgICAgIC0gcWNvbSx4MWU4MDEwMC1kd2MzCiAgICAgICAtIGNvbnN0OiBx
Y29tLHNucHMtZHdjMwogCkBAIC0zNzEsNiArMzcyLDcgQEAgYWxsT2Y6CiAgICAgICAgICAg
Y29udGFpbnM6CiAgICAgICAgICAgICBlbnVtOgogICAgICAgICAgICAgICAtIHFjb20sc204
MzUwLWR3YzMKKyAgICAgICAgICAgICAgLSBxY29tLHNtODc1MC1kd2MzCiAgICAgdGhlbjoK
ICAgICAgIHByb3BlcnRpZXM6CiAgICAgICAgIGNsb2NrczoKQEAgLTQ5OCw2ICs1MDAsNyBA
QCBhbGxPZjoKICAgICAgICAgICAgICAgLSBxY29tLHNtODQ1MC1kd2MzCiAgICAgICAgICAg
ICAgIC0gcWNvbSxzbTg1NTAtZHdjMwogICAgICAgICAgICAgICAtIHFjb20sc204NjUwLWR3
YzMKKyAgICAgICAgICAgICAgLSBxY29tLHNtODc1MC1kd2MzCiAgICAgdGhlbjoKICAgICAg
IHByb3BlcnRpZXM6CiAgICAgICAgIGludGVycnVwdHM6CmRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3Fjb20vc204NzUwLW10cC5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L3Fjb20vc204NzUwLW10cC5kdHMKaW5kZXggODE1NjUxZjY1MjE0Li5jMjgyZjEyYzRkODMg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zbTg3NTAtbXRwLmR0cwor
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc204NzUwLW10cC5kdHMKQEAgLTExMjIs
MTEgKzExMjIsOSBAQCAmdWFydDcgewogfTsKIAogJnVzYl8xIHsKLQlzdGF0dXMgPSAib2th
eSI7Ci19OwotCi0mdXNiXzFfZHdjMyB7CiAJZHJfbW9kZSA9ICJwZXJpcGhlcmFsIjsKKwor
CXN0YXR1cyA9ICJva2F5IjsKIH07CiAKICZ1c2JfMV9oc3BoeSB7CmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc204NzUwLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL3Fjb20vc204NzUwLmR0c2kKaW5kZXggNDUwZmU1YjdmMDNlLi5kOTMzYzM3OGJkOGQg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zbTg3NTAuZHRzaQorKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc204NzUwLmR0c2kKQEAgLTI2NTEsOSArMjY1
MSw5IEBAIHVzYl9kcF9xbXBwaHlfZHBfaW46IGVuZHBvaW50IHsKIAkJCX07CiAJCX07CiAK
LQkJdXNiXzE6IHVzYkBhNmY4ODAwIHsKLQkJCWNvbXBhdGlibGUgPSAicWNvbSxzbTg3NTAt
ZHdjMyIsICJxY29tLGR3YzMiOwotCQkJcmVnID0gPDB4MCAweDBhNmY4ODAwIDB4MCAweDQw
MD47CisJCXVzYl8xOiB1c2JAYTYwMDAwMCB7CisJCQljb21wYXRpYmxlID0gInFjb20sc204
NzUwLWR3YzMiLCAicWNvbSxzbnBzLWR3YzMiOworCQkJcmVnID0gPDB4MCAweDBhNjAwMDAw
IDB4MCAweGZjMTAwPjsKIAogCQkJY2xvY2tzID0gPCZnY2MgR0NDX0NGR19OT0NfVVNCM19Q
UklNX0FYSV9DTEs+LAogCQkJCSA8JmdjYyBHQ0NfVVNCMzBfUFJJTV9NQVNURVJfQ0xLPiwK
QEAgLTI2NjgsMTQgKzI2NjgsMTcgQEAgdXNiXzE6IHVzYkBhNmY4ODAwIHsKIAogCQkJYXNz
aWduZWQtY2xvY2tzID0gPCZnY2MgR0NDX1VTQjMwX1BSSU1fTU9DS19VVE1JX0NMSz4sCiAJ
CQkJCSAgPCZnY2MgR0NDX1VTQjMwX1BSSU1fTUFTVEVSX0NMSz47Ci0JCQlhc3NpZ25lZC1j
bG9jay1yYXRlcyA9IDwxOTIwMDAwMD4sIDwyMDAwMDAwMDA+OworCQkJYXNzaWduZWQtY2xv
Y2stcmF0ZXMgPSA8MTkyMDAwMDA+LAorCQkJCQkgICAgICAgPDIwMDAwMDAwMD47CiAKLQkJ
CWludGVycnVwdHMtZXh0ZW5kZWQgPSA8JmludGMgR0lDX1NQSSAxMzAgSVJRX1RZUEVfTEVW
RUxfSElHSD4sCisJCQlpbnRlcnJ1cHRzLWV4dGVuZGVkID0gPCZpbnRjIEdJQ19TUEkgMTMz
IElSUV9UWVBFX0xFVkVMX0hJR0g+LAorCQkJCQkgICAgICA8JmludGMgR0lDX1NQSSAxMzAg
SVJRX1RZUEVfTEVWRUxfSElHSD4sCiAJCQkJCSAgICAgIDwmaW50YyBHSUNfU1BJIDEzMSBJ
UlFfVFlQRV9MRVZFTF9ISUdIPiwKIAkJCQkJICAgICAgPCZwZGMgMTQgSVJRX1RZUEVfRURH
RV9CT1RIPiwKIAkJCQkJICAgICAgPCZwZGMgMTUgSVJRX1RZUEVfRURHRV9CT1RIPiwKIAkJ
CQkJICAgICAgPCZwZGMgMTcgSVJRX1RZUEVfTEVWRUxfSElHSD47Ci0JCQlpbnRlcnJ1cHQt
bmFtZXMgPSAicHdyX2V2ZW50IiwKKwkJCWludGVycnVwdC1uYW1lcyA9ICJkd2NfdXNiMyIs
CisJCQkJCSAgInB3cl9ldmVudCIsCiAJCQkJCSAgImhzX3BoeV9pcnEiLAogCQkJCQkgICJk
cF9oc19waHlfaXJxIiwKIAkJCQkJICAiZG1faHNfcGh5X2lycSIsCkBAIC0yNjkyLDU0ICsy
Njk1LDQ1IEBAICZtY192aXJ0IFNMQVZFX0VCSTEgUUNPTV9JQ0NfVEFHX0FMV0FZUz4sCiAJ
CQkJCSAmY29uZmlnX25vYyBTTEFWRV9VU0IzXzAgUUNPTV9JQ0NfVEFHX0FDVElWRV9PTkxZ
PjsKIAkJCWludGVyY29ubmVjdC1uYW1lcyA9ICJ1c2ItZGRyIiwgImFwcHMtdXNiIjsKIAot
CQkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47Ci0JCQkjc2l6ZS1jZWxscyA9IDwyPjsKLQkJCXJh
bmdlczsKKwkJCWlvbW11cyA9IDwmYXBwc19zbW11IDB4NDAgMHgwPjsKKworCQkJcGh5cyA9
IDwmdXNiXzFfaHNwaHk+LAorCQkJICAgICAgIDwmdXNiX2RwX3FtcHBoeSBRTVBfVVNCNDNE
UF9VU0IzX1BIWT47CisJCQlwaHktbmFtZXMgPSAidXNiMi1waHkiLAorCQkJCSAgICAidXNi
My1waHkiOworCisJCQlzbnBzLGhpcmQtdGhyZXNob2xkID0gL2JpdHMvIDggPDB4MD47CisJ
CQlzbnBzLHVzYjItZ2FkZ2V0LWxwbS1kaXNhYmxlOworCQkJc25wcyxkaXNfdTJfc3VzcGh5
X3F1aXJrOworCQkJc25wcyxkaXNfZW5ibHNscG1fcXVpcms7CisJCQlzbnBzLGRpcy11MS1l
bnRyeS1xdWlyazsKKwkJCXNucHMsZGlzLXUyLWVudHJ5LXF1aXJrOworCQkJc25wcyxpcy11
dG1pLWwxLXN1c3BlbmQ7CisJCQlzbnBzLHVzYjNfbHBtX2NhcGFibGU7CisJCQlzbnBzLHVz
YjItbHBtLWRpc2FibGU7CisJCQlzbnBzLGhhcy1scG0tZXJyYXR1bTsKKwkJCXR4LWZpZm8t
cmVzaXplOworCisJCQlkbWEtY29oZXJlbnQ7CiAKIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
CiAKLQkJCXVzYl8xX2R3YzM6IHVzYkBhNjAwMDAwIHsKLQkJCQljb21wYXRpYmxlID0gInNu
cHMsZHdjMyI7Ci0JCQkJcmVnID0gPDB4MCAweDBhNjAwMDAwIDB4MCAweGUwMDA+OworCQkJ
cG9ydHMgeworCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OworCQkJCSNzaXplLWNlbGxzID0g
PDA+OwogCi0JCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEzMyBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsKKwkJCQlwb3J0QDAgeworCQkJCQlyZWcgPSA8MD47CiAKLQkJCQlpb21tdXMgPSA8
JmFwcHNfc21tdSAweDQwIDB4MD47Ci0KLQkJCQlwaHlzID0gPCZ1c2JfMV9oc3BoeT4sIDwm
dXNiX2RwX3FtcHBoeSBRTVBfVVNCNDNEUF9VU0IzX1BIWT47Ci0JCQkJcGh5LW5hbWVzID0g
InVzYjItcGh5IiwgInVzYjMtcGh5IjsKLQotCQkJCXNucHMsaGlyZC10aHJlc2hvbGQgPSAv
Yml0cy8gOCA8MHgwPjsKLQkJCQlzbnBzLHVzYjItZ2FkZ2V0LWxwbS1kaXNhYmxlOwotCQkJ
CXNucHMsZGlzX3UyX3N1c3BoeV9xdWlyazsKLQkJCQlzbnBzLGRpc19lbmJsc2xwbV9xdWly
azsKLQkJCQlzbnBzLGRpcy11MS1lbnRyeS1xdWlyazsKLQkJCQlzbnBzLGRpcy11Mi1lbnRy
eS1xdWlyazsKLQkJCQlzbnBzLGlzLXV0bWktbDEtc3VzcGVuZDsKLQkJCQlzbnBzLHVzYjNf
bHBtX2NhcGFibGU7Ci0JCQkJc25wcyx1c2IyLWxwbS1kaXNhYmxlOwotCQkJCXNucHMsaGFz
LWxwbS1lcnJhdHVtOwotCQkJCXR4LWZpZm8tcmVzaXplOwotCi0JCQkJZG1hLWNvaGVyZW50
OwotCi0JCQkJcG9ydHMgewotCQkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKLQkJCQkJI3Np
emUtY2VsbHMgPSA8MD47Ci0KLQkJCQkJcG9ydEAwIHsKLQkJCQkJCXJlZyA9IDwwPjsKLQot
CQkJCQkJdXNiXzFfZHdjM19oczogZW5kcG9pbnQgewotCQkJCQkJfTsKKwkJCQkJdXNiXzFf
ZHdjM19oczogZW5kcG9pbnQgewogCQkJCQl9OworCQkJCX07CiAKLQkJCQkJcG9ydEAxIHsK
LQkJCQkJCXJlZyA9IDwxPjsKKwkJCQlwb3J0QDEgeworCQkJCQlyZWcgPSA8MT47CiAKLQkJ
CQkJCXVzYl8xX2R3YzNfc3M6IGVuZHBvaW50IHsKLQkJCQkJCQlyZW1vdGUtZW5kcG9pbnQg
PSA8JnVzYl9kcF9xbXBwaHlfdXNiX3NzX2luPjsKLQkJCQkJCX07CisJCQkJCXVzYl8xX2R3
YzNfc3M6IGVuZHBvaW50IHsKKwkJCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwmdXNiX2RwX3Ft
cHBoeV91c2Jfc3NfaW4+OwogCQkJCQl9OwogCQkJCX07CiAJCQl9OwotLSAKMi41MS4wCgo=


--------------sSk5JAkndINXoX824lhv1Ic5--

