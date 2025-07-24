Return-Path: <linux-kernel+bounces-743403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED02BB0FE44
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5F41CC716A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC136BB5B;
	Thu, 24 Jul 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cU3dguX1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1FA48
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753318117; cv=none; b=pB/EB3ukhc4eTrfHpN72gvpBpG7tG+MzjFKV//xriuXil7ap0HsISQKjXmOpK2gaKHWK4bRLZJikdgbGPXzcA9LtuBm1EUDnbtp40B/WlOOgJvCbLn+04nIjZAhFt9YG/Uc3szsklDe3/Uy4VF4nFYv5agL7edn2C8ZuHN2Yuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753318117; c=relaxed/simple;
	bh=5Y4+1OYJZAeHUPLBYQx8kSVooxsv7DlVmjvdbv3x1uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGhJFaUBjcUAH7QVPei64x4knb2yZnw10P8RL8yOjeNGsHBsRpAYAdNxn6b9+Fl8SMJVFgPHBv4v49HmyEnrbHbb4Ys2rPXC9vMQ/ypNNKyASDZdQB3YIIkBs3bZNW19OfhP9adYRC5kssmbdlYrsck+b+AIIhhb8vsOIrZ4v6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cU3dguX1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXH97023402
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iv9yjSoPymrEhpWFY2OCTVKnjOfTrTpo4a9m/IVzyY0=; b=cU3dguX11UZN5kLs
	bWHz3I1Ole9ar5grt/PZITtZqkyNZMKLSKB8/Ktf01mfoonsq8ctGXLwt+xiI8aR
	ZRX+hdJxrbgU/sRfw7BWwEGwAe3vsqIUOhVLLP5OXjzx5D6xN/b2gpfx+iWP9r7F
	15rTgqEYBQnyfgbef1BjBB28px+z3pMxut1rC9X8fybYVhZ5v8DRHfVrMoMxrDEX
	Bm0k8yrz6W6P524TT/Oe4OxVtJ1z0ocn0O+17+au23QRNr03SIETwAjvKtaq+Bm8
	T5kSM8/mvIvnsizDcSZLeJHoTfqezxf2mQ27xPkYV1CSv2UbSwybLhL90oVcNBmn
	i0fD8g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na5d1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:48:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23507382e64so3885495ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753318113; x=1753922913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iv9yjSoPymrEhpWFY2OCTVKnjOfTrTpo4a9m/IVzyY0=;
        b=PHnVBbZ2+UDx4lVSreo0JyoYc3jmPxZCHhuHKGBLCWmG52ZNteCHkVH9bWRqSjNAId
         xZdmzrPtukCUVRZ1P0McvztT05SPcTg0/MD+rQcXpKXAGqZEi85ub/Me3Jmxdw0wwRam
         jq8QH00nFRo4hgiWIamPXr6nwy7MzGWmLz3TLELFeHAZv9I4KtSTdNh7y8VnrZvwe15X
         TeY9u5gg/Pzp5ypjw7JqIFXvW8UPp/Fx9npFyOVTxpFO9qdl0oeWlyG2pHD9/ZPH5UyC
         zju1WKv0TFFqarb3wQZ7hG0WNLfEUDb4fCjsaFZ17yFX95ud9RB3PHl3h8MGxfzDxikC
         qmLg==
X-Forwarded-Encrypted: i=1; AJvYcCWmNCtk0XKwTEi51whZem1EKeiF16bWUFsMTzWoL3L2jlCdJ4UpijdqK0j0P1BVyPgWpsqfx3jofGXIz+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTo1PjgvLjKXex3Mg1tHEEBdYRKzRyanJJMTUjdO4w0fi5azRF
	weOhOLScAlvjshJBVA6t/Cx7DEBmN/89OVv/oQyZDSc9WGs8q3yFOHJzYfUR+3DNwvBXctj8A1X
	j9uLFI8RRGExN8HgNMD2LULluN1v18F71gKpvehftes8SJOkpDRTfZtO0zyq8k2a7uyw=
X-Gm-Gg: ASbGnctF3uL91gfXIe/p8/YsULlHp0e+wIC8WttS6+Aw9UFF1E6RFQmOQ+MZyJ93/eC
	IJyaOf+4d+bd5HcOz/Bja5KvsB8KeDz4rs+TxTH3KeSwWxr/Fcywk//3B95bIRnP41rNqfV5K6L
	CxGp1nexdNfFiF6EgL0BVinGRXAK1ghz5pDOm7VUdvvLqiLnsYjzxf2aLL45ZHj0cm3uUfOz+Lo
	TKf63a48COtZDZYb6UxTpJM7R8IKql/hJ9y69sjzetQutrq4rIzie+j1uqeB/FKYgKBPND6qyYN
	kn0c1EADdEhIYfTAKetnq4vN0ec3WZTgXuVUggAN9nJarpbMgv21GTJAo3hVO+x1Ee2RwKdiWdX
	w3Zvihht+dgaatNStwkKSxv3GXII=
X-Received: by 2002:a17:902:e80f:b0:236:748f:541a with SMTP id d9443c01a7336-23f9808e0a0mr65325965ad.0.1753318112926;
        Wed, 23 Jul 2025 17:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtgVjVnQZl9R1khr6bvXoxGlsAxZOVo2vw1YbZ3PlcB22TMJrQHHVvMIcFioMt5XbHmkOknw==
X-Received: by 2002:a17:902:e80f:b0:236:748f:541a with SMTP id d9443c01a7336-23f9808e0a0mr65325605ad.0.1753318112460;
        Wed, 23 Jul 2025 17:48:32 -0700 (PDT)
Received: from [10.133.33.58] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66270ee5sm17485a91.11.2025.07.23.17.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 17:48:32 -0700 (PDT)
Message-ID: <83173ae4-4e5a-4bc9-b02b-6cef26489148@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 08:48:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
 <0f9eebfe-21f8-48b8-9b49-a35126aa6dd1@kernel.org>
 <67ca3b6f-3cd3-430e-886a-0443f6d630dc@oss.qualcomm.com>
 <miiod6ft7iavg64q4f3uwcnztamgvt46gcguean5atsqi5d5us@xrwlzznsgx2z>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <miiod6ft7iavg64q4f3uwcnztamgvt46gcguean5atsqi5d5us@xrwlzznsgx2z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vOuk640nyXJCJKlgoeKlF747EPuAqGMU
X-Proofpoint-ORIG-GUID: vOuk640nyXJCJKlgoeKlF747EPuAqGMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAwNCBTYWx0ZWRfX+b2VswAmAwRz
 Sy5qrSFb46gQVH2nBu8QZ0UuVFsSYq3A/EdFqN+G8CeUFFDteoAvjVncA3WYDfSdiDyaUcRuHeD
 6S2SWkItw/5kO3N60mkHvCiFjCTgqSWzAMuwYh/jRHOYzeyJ/mpN6xa17tuuvA84iagVesWm64u
 xnmhiiF6vfLxcS0x6AKiY03BtwjPPm5WwFUvi7yApu/RvVLl/RcNZfk6nxPKaI82iMPeuce905L
 l9UalwNaWqQESQxLwKXgcyqlWBzw7HJDOAzcZNHtF5LpN8sgaTBkolf8xBqadezPko8uwav9Q3D
 g5MoR727D5NgPSChAwPNKjVj8pXOYDX8OVfLjd8luyi1r3RbrGJ/BXpic09Gc3AyvjjKlsy3LIS
 oMjMR88yG/nLwgludzb9KZ9SKAMSA5UIDsHXqKp6aQcPCOjr+9lLaaRKFZUjd8QC2zWeIlNx
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=688182e1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=6jahUQGBau2IMRXzWEoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240004



On 2025-07-23 19:26, Dmitry Baryshkov wrote:
> On Wed, Jul 23, 2025 at 02:44:14PM +0800, Yijie Yang wrote:
>>
>>
>> On 2025-07-23 14:28, Krzysztof Kozlowski wrote:
>>> On 16/07/2025 11:08, Yijie Yang wrote:
>>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>>> components optimized for IoT applications. It is designed to be mounted on
>>>> carrier boards, enabling the development of complete embedded systems.
>>>>
>>>> This change enables and overlays the following components:
>>>> - Regulators on the SOM
>>>> - Reserved memory regions
>>>> - PCIe6a and its PHY
>>>> - PCIe4 and its PHY
>>>> - USB0 through USB6 and their PHYs
>>>> - ADSP, CDSP
>>>> - WLAN, Bluetooth (M.2 interface)
>>>>
>>>> Written with contributions from Yingying Tang (added PCIe4 and its PHY to
>>>> enable WLAN).
>>>>
>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>> ---
>>>
>>> As pointed out by "arm64: dts: qcom: hamoa-iot-evk: Enable display
>>> support" this is incomplete. Adding new SoM or board is one commit. Not
>>> two. Don't split board DTS, which is already prepared/ready, into
>>> multiple fake commits. This is not a release early approach. This is
>>> opposite!
>>
>> The inclusion of display support was not intended in the initial patch, and
>> it was not ready at the time this series was submitted. Since the display
>> patch set was not submitted by me, its timing could not be controlled. If
>> preferred, the display-related changes can be merged into this patch in the
>> next revision to maintain consistency.
> 
> This is neither merged nor accepted. Please squash display (and any
> other possible forthcoming changes) into this patchset before reposting

Sure, I will.

> 

-- 
Best Regards,
Yijie


