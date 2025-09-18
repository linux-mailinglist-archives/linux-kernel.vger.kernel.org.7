Return-Path: <linux-kernel+bounces-764783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08AB2274C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A949188C98E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD742367C9;
	Tue, 12 Aug 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYP+ggHA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834B7E792
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002731; cv=none; b=mvDY6oFjR0xc2Fc90wzKox+xJr9HUW9PNkLKwpzskv4FXwy27Zj2E/B8Y4tQKxLgwV3ZesPcBgL8EC7tOznZj1owvlFYRGk6hDc8YKBmyN8zxo7U/bfwrQZ+j9G4uwmzlcOGFJdiSvHZYDUm+VYunsXbzSDylmqaSK0jOfLpNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002731; c=relaxed/simple;
	bh=zcTdq5q8Z0HgLcrEhlJL9bnsni7joJdNuLHKEU05grQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2ODWLRcbEcefszNjme2z6xYTcJpj7tElMwMAX3sF+broQKUK+ATMGqLEY3AY2s1hjt1AJZ2HRERlvYG6iuRNrzKupNWJAt4v3FBEY7Q9O9eoffuriJ3NPFQBpgqo+rQ3UZP2NUhFga/rN4SEKYQy8MgC8E/3CSInBWEKQlKZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYP+ggHA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvrZt017899
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/Lt9jlssY621f3SXqy2FZpkF
	L8zX0+/kNs4yc3M8rA0=; b=OYP+ggHATi20Z8ifosPyLezT723nD5OYFjjyxmxg
	3GXPxRdBSsI/fifuAxCQPl/BZsUlf8pW4ub7DRGVkSFKbG4oZGPEzAZ6srBQvjBz
	9LkP5igwUi9DddTRKn9sk0PIFwggsC4xQ6uX/v1Dk8nZPnZTnAvnlInC/rzqtb5t
	CU8bCNnyO47qhqOFnHfhSBDn4w7+P8+14SH6KUHXNhJl3udhVoRxSVYEy4pj+502
	7tkRWfPZtaWjEmEDkXTIBveqwihtbQgBg8Tqe9dfjo0WWrimBpuDc+5EdKywDqo1
	GIQh9fV0Ikxlzh93pyx3NNqiAuNkRe7GR4ZbNFLzF7EhSw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4c5cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:45:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4af210c5cf3so216360201cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755002727; x=1755607527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Lt9jlssY621f3SXqy2FZpkFL8zX0+/kNs4yc3M8rA0=;
        b=CQgrEJ92dbab3SfX7ZgtgwWlu6/tJ5sFhBGQAhaNckH0sp6vHohb7e4DtwoHSwtJGR
         Ipzpec8wpm8N66EPPDKiogk1PyCpDmZ1rQ+33hPlpCqAS9s1Ago+EHes7BaP5jBfGufo
         Z3Nh8YHjEQyPBfL/qSodueD8tPUiGPItQr5aqZgakMoIpQMhZ6ZAd32TAsWjS8DHv4WY
         4YTFfLpvHKgJfsjSB/AwUVKv47E3UECc+M6DgRyyxFj9MwL20U6jStvmFiXf1LKoUtda
         Zd6FrWG7iBFntak530AXbwszubC9oTJJeYknZgFVImKTpvhu2tQyLCcIPa38Uf5wDstP
         rOPg==
X-Forwarded-Encrypted: i=1; AJvYcCXVY0bRKAl0gpiQX0NktEpMXneIIuo2krbxRCg1MTUo7HakAuFiV77cu4pYvZF0eokSOtSK+x8T9jwQ1Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0emDFoWzQGEsN1ke/F07xmjgeKnNLAsOo98TVrtJ48YGgM2a
	YPRtPJdqJueNxTf7MiwBVr84E6OY5LnGRAmX7AP2ZwVKowrkf4w+Va1Iff6TUCf+0ZZDwPwq0Zq
	EpZKQZdsNsugq+f1vqUbNx8teNesw7XqlMJajfU273y1uXi1WiiMOnH1Xa5C7RYvfDCbX3wAg1F
	s=
X-Gm-Gg: ASbGncsjTD/+CxSWCwGogbotoS6xKl0M9MZd9qDeHdqbuqje+lO2mhuU1Ef0hC8h9kE
	9nJJyzV9AHFlCtksXjwcThMBW/+ddjXkmmzw9CAXQaFjPLSvzZC1vpxgsloVdFfCXEEmdee3SKW
	mbNEPxgnT4SPcppmskyrJTw2aAgSzK+B+HG5p5LSJ0mbvr2IwtaexpLqob3NeiYHgagCfHgayas
	B2lyW0GkmidR/tC7hLly4ts9GEkttVjIbvIboonfFlWOZP1YdHQL51rQpZZ7VbyLIqjCvZMvfVO
	iblaA+aXub5JwC0SkpxVvmKtBAnVxv11sV+MBkvWkZpOiTCY+R5M3Jtd8czFMEQaA+j7enrCXBJ
	0JqgtGOmkY9keQbz+v2xgrugnnAKNyy7I9k2o/E4qLGt8uuwj7Rde
X-Received: by 2002:a05:622a:1355:b0:4b0:6e11:c38d with SMTP id d75a77b69052e-4b0ecbe7076mr34822101cf.26.1755002727443;
        Tue, 12 Aug 2025 05:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9SQT32jrdPl+DSEzH8DNObTnQWwpDoeVxwaSctGqgT5hIPV+OPyFg5u8UtRHgDjNZLLAlzg==
X-Received: by 2002:a05:622a:1355:b0:4b0:6e11:c38d with SMTP id d75a77b69052e-4b0ecbe7076mr34821641cf.26.1755002726934;
        Tue, 12 Aug 2025 05:45:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98ad9sm4807530e87.78.2025.08.12.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:45:26 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:45:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] arm64: dts: qcom: sm8750-mtp: Add WiFi and
 Bluetooth
Message-ID: <3jrs5gkxzjgrjmfbd65qr3uzblzzz5ae4apo5qwpxb63jm4i23@jzpaxp3dxais>
References: <20250811131055.154233-2-krzysztof.kozlowski@linaro.org>
 <l6u4y3suv3dpylexbiiznhcuyanlc4ouizhzj2cchblaf6o4wg@fe4laxrioaj5>
 <481985cb-fa84-4b09-9b95-948ee70b557a@linaro.org>
 <k7mw7rj7cno3con2t57nps23y7evd3da6gahyl5gnrxss7e3s4@qncnuekxr7lb>
 <f7704cc1-95b4-4860-86ea-96ec18f61c8a@linaro.org>
 <ibitgekdjsktpvr6zmouuhgzcbfjfeuv4l4zsl6vszv4hauug5@one6zo6gdykb>
 <3239685a-97af-4d56-a0cc-984f26db5f76@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3239685a-97af-4d56-a0cc-984f26db5f76@linaro.org>
X-Proofpoint-GUID: 5ijrYL7xl6YNmQO97obTRALVBRU9-QkB
X-Proofpoint-ORIG-GUID: 5ijrYL7xl6YNmQO97obTRALVBRU9-QkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXyzr3zXHriAc5
 AFhoQf44wQE9SHLgjXPygDHQ0x3CmZ2KUnJgz0TzkR0PjDCdVWgdfVDUrsMS0g+SfLlLEjfKtoV
 qLjKBYY8mo16UYiGAY2bW8kkUA1P9Ynr6Ee1y5xFyO4tOCxrpgJ1sBJOBGpSE1NuZXO0iT6ogW3
 9+rjymrGzW0tYK0SYUdDrxgYGTwdVEwAKUd54aTMjGvR15S0RCLV5XP6YlmcqloEGEZJ86axZBt
 fFVpNHkFAd3d0hnvi6UZh7SRuzLRwoVwZekhTuDC8OonKvcRYgrxiaeXaROI0JvyF9YY/l4gmBN
 S5pM0dpUFnpJctCPDkLfnIEs4tmfM71VJ4c3JHCsV0C37YWaKgBssKP/nKgrLhiXBf1RnGZ5YRe
 KZv3TkeI
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689b3768 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=H-yCtxcVDpURQovV7lcA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On Tue, Aug 12, 2025 at 01:07:20PM +0200, Krzysztof Kozlowski wrote:
> On 12/08/2025 13:00, Dmitry Baryshkov wrote:
> > On Mon, Aug 11, 2025 at 04:40:09PM +0200, Krzysztof Kozlowski wrote:
> >> On 11/08/2025 16:33, Dmitry Baryshkov wrote:
> >>> On Mon, Aug 11, 2025 at 04:25:47PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 11/08/2025 16:22, Dmitry Baryshkov wrote:
> >>>>> On Mon, Aug 11, 2025 at 03:10:56PM +0200, Krzysztof Kozlowski wrote:
> >>>>>> MTP8750 rev 2.0 (power grid v8) boards come as two different variants
> >>>>>> with different WiFi chips: WCN7850 and WCN786x.  WCN7850 is already
> >>>>>> supported by the kernel, but WCN786x is not.  Both of the board variants
> >>>>>> are considered newest revisions and the difference is only in MCN
> >>>>>> numbers and internal codenames.
> >>>>>
> >>>>> Are they soldered on board, installed via add-on cards or installed via
> >>>>> M.2 slot?
> >>>>
> >>>> This is MTP, so same answer as other MTPs - these are replaceable parts,
> >>>> just like you can replace display or modem.
> >>>>
> >>>>>
> >>>>> Are they going to be somewhat compatible (e.g. on the BT side?)
> >>>>
> >>>> No clue, you need to ask Qualcomm people - it's their hardware.
> >>>
> >>> And you (hopefully) have access to the docs.
> >>
> >>
> >> No, fought with that for 1 year, got some basic docs only. It is very
> >> difficult to get any access to these docs. I assume you mean the MTP board.
> >>
> >> If you mean Bluetooth or WiFi - I have 0 access there.
> > 
> > I mean WiFi / BT. Then you can ask Jeff or a corresponding BT maintainer
> > to provide necessary details. You make it sound as if you are not a part
> > of the system. You are. You can talk to necessary people within
> > Qualcomm.
> 
> 
> This feels like creating obstacles and some new sort of requests that
> contributor for hardware A has to come with answers about completely
> different new hardware B, so please provide rationale for such request.
> 
> I see no reason why compatibility between bluetooth of WCN7850 and
> WCN786x is relevant here. Even if I knew the compatibility or
> differences between WCN7850 and new WCN786x, I cannot publicly speak
> about them.

It was you, who mentioned WCN786x and you didn't mention that it's a
not-yet-available hardware. So, how would I guess that?

> Devices will be different, they will have different compatibles, thus
> you CANNOT have one DTS for both. What else - not my task, not my
> expertise, not relevant to this submission.

Them having different compatibles is exactly my question. It's not
obvious if they are compatible or not.

We've discussed this offline and I hope that the next iteration will
cover all these details.

-- 
With best wishes
Dmitry

