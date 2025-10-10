Return-Path: <linux-kernel+bounces-848581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E0BCE156
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB0A189EF81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07454221F1C;
	Fri, 10 Oct 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKOEdXUq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D221D3CD
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117316; cv=none; b=O4LzNmG0NMP4i9L4Mu38XRR9cq9xnsKQjz9QZ19/6+x0ijlqL8IjpjwP/7kU4vuFH73pEA9zcqsmpKEaQOOp3WXlzoxcZZQ0k/S41Pyx7dHQkysSjRmppGoa+8sZFB+pqXab8eoAbGmKVwldWq8Jin8ktK58BInRXgxVaO4AAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117316; c=relaxed/simple;
	bh=/adNrdiBXGreU5Zv1TBVSGHzTcP/X2qnzXFeQoZyAeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lotRwblV4Q1JBYuO+U41qPFT0Vw49ZceD5Tp2qJWZwGtMb1Is26AYkjhATRbRAONdE5NuX5mIRl4y50IX2O/hxMSqDW2WobHRSxkxhX0YAl4EXUW1xjI27E942bYbk3RkMfqGYk2l8DwruRAzuIP+u6WrIv/Tl6pX87+AGsvr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKOEdXUq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ABRbCo024175
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5RtO9UgOqlSPMcNOTbaUjDba3fAyZ6bvIxzoBS2IW8c=; b=KKOEdXUq6dzVIpSr
	LuJS0xo+4fVpQm9ipytJjhUyIbbZcPvktUogcCD0y3+eJLP8s1aJR8wvmfndCjno
	kUTsWwQnWkASOVtEWbTyeetS2luFQF+r5qQy8uWhjboF7y+oXDRfMwxmjdIUm6zh
	Xucp23vVwHYDaO1dFREHLpY6jQIm0J6Q4lZ2nSt5HX+nHmgSoHO+NZmHxjDcTv4v
	GzKYKwalDfMEJr6CHNYseyZo8a8BXahcS/PwdYG8/Hwq7NyFQzSBlTPkvmHO0NM5
	lqwKsGSiqsGerVXwef/LdLWeyXVc+dOGWsHlNn3SCjrA3fT1wn6pgBa8boEAw6X1
	mSBAoQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49q18y90uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:28:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-883618130f5so102197985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117312; x=1760722112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RtO9UgOqlSPMcNOTbaUjDba3fAyZ6bvIxzoBS2IW8c=;
        b=XvBANZnrEZF+/vOqt8UyMxG64zwYvxpkZh5tWAnlLJ292F1wAwJbuL72hhSZCsJvKq
         Iz8BQgIQ3wRQwv1ha/aDqHcQin3jQmezvEWpKshETjelz/4mMBNbkQLlJFSuteajcCZh
         Z+gl1kZhjwPp1yOOVIDHXPOLdruJBkv71C+mvTzedrhqttrh18uK0CBcg0yakH+hM3WK
         3+13mGtLfPVn5bMxfu/kVGufuJx6/Kl0vAIMYuryViWwSSGYzhV7udp4abuHZ8tFNXNF
         fZsB5LFqKfI+Nto7TfqwNvVgQGo1S8+nA6/foKTeo5LpFeJ58AKCtFmmfH23MhV5GzUB
         yz9A==
X-Forwarded-Encrypted: i=1; AJvYcCULX7hQ3f+At5BI9gNHPblTShi2RxMd5zLeg3l7IXznAZE2kpawgpo/4/xkohUZOL4B7ZFwoHehZzkErEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeeg9MqjG3ZLp62nOnEmncqBhtuhkCpVSFsf9oplk9wWZSoXb
	aW/VuEPv5HaqL1+AE1gToRp94FaRiPv6kNjT01sIt+VwvB46t0mAFi5p7RM5mAn3Z+MS8xcj47H
	6zAOX0Itk7jzaVxN63d8hQrKrUpKXmUmqOgB4tNz7Evz1PeqMX3FU2/W2WsfRrJrZ28M=
X-Gm-Gg: ASbGncsL1h5OgxHjgXNRVhbLxH2PbmVswB2/pxNsuilQI3mW8OK/NcCPDNul7AIdIUD
	Ww/KebVq6Hi6xkso7FbORuibD0pInGWVhZg2A5+ZxBmWsBwWOuu0+TIpIBLu2BiiigzRrPMNryS
	Rtb2DRwjPQr4aW9lAWUa7s3ft//VTmOu4n4Bfkln9k/y9rl2Da3qMRdaTr5MVf9mEJ76ikyZi9+
	BZ+8DWYMGZouo4rT4uf1YLcGNNhqbLHHphXjdJPWVUAnnegMhWKiBoo2rlPa8jStzXwFaltqbiQ
	+pF50QmdZMpmnlLvyYTPZu7awJDGCCj1l6BZ10EqRn7BjenzG0Bgfbxwp/FE7u+BjfS+Onlo811
	NHq7YViN8ua9OlrS50AU55A==
X-Received: by 2002:a05:620a:28c2:b0:856:6bcd:4adc with SMTP id af79cd13be357-883544f4e27mr1154163385a.9.1760117312490;
        Fri, 10 Oct 2025 10:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDtsBobK85gPBifHNNJEiQy1NEmBXZH06eJMg5hBaBeDWosJuw8Hx8ajikWbGG7O41+fj2DQ==
X-Received: by 2002:a05:620a:28c2:b0:856:6bcd:4adc with SMTP id af79cd13be357-883544f4e27mr1154159685a.9.1760117311864;
        Fri, 10 Oct 2025 10:28:31 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d951deb6sm281479666b.76.2025.10.10.10.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:28:31 -0700 (PDT)
Message-ID: <61f77b51-af6e-4625-8d58-fee8f93e1d5e@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 19:28:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: Add support for Huawei MateBook
 E 2019
To: Jingzhou Zhu <newwheatzjz@zohomail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251008130052.11427-1-newwheatzjz@zohomail.com>
 <6199698.lOV4Wx5bFT@debian-vmware>
 <c6880fe5-029a-4f8d-a08e-81a066a79450@oss.qualcomm.com>
 <2386127.ElGaqSPkdT@debian-vmware>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2386127.ElGaqSPkdT@debian-vmware>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qryQZtFg04yA1bnK0DoZ0a4HX-rWjTEY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA2NSBTYWx0ZWRfX4+AHsXJTNh0I
 qsxPskMjWbUcqR7c2bZugmQMYqffCvbCBcafq0so0ddQAoKMVdCALL7MgGqDEerP/FGhR3d7qrX
 6jxtbQGWtuUHoDo44Jw6g48t45p6dj78dqnCskZmcRYodif0jGBEogD6msSZfh5XU+JaHtVEXQJ
 E5qp2M9ZrillzrdMSFj58oIy8CMnSKmHLIJRCibG5/eYqKkczftSh/et/Guh/x+81nWqYzzHLYD
 98vJbvL3N9V53oAMqkci5j2ZxZAPN+quAFFCuHe+QvOgB8+SIamZqrUyfStxa8vRZv3W6lXy36o
 z9vgyteUdaMHOKoPcYUM+jEBT+ZiLAR6dyz5GMQroHxIe0ZOs0QuGIrNlTQDHmH62iwpU9uo7xt
 S+amjfiYKCveJqyrUCPp3Om4fVjLNQ==
X-Proofpoint-ORIG-GUID: qryQZtFg04yA1bnK0DoZ0a4HX-rWjTEY
X-Authority-Analysis: v=2.4 cv=LJZrgZW9 c=1 sm=1 tr=0 ts=68e94241 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=wbXqjQ4oNPLq0UupdngA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510100065

On 10/10/25 4:52 PM, Jingzhou Zhu wrote:
> On Thursday, 9 October 2025 21:58:29 CST, Konrad Dybcio wrote:
>> Please refrain from resending if it's just to apply tags, maintainer
>> tools do it for you
>>
>> Konrad
> 
> Understood. This is my first time to send patches, so I'm not very familiar
> with the tools. Should I wait for the maintainer to pick it up, or is there
> anything else I should do?

Because the current version is v6.17 (not -rc), we're in what's
deceptively called a "merge window". This is when Linus Torvalds merges
pull requests from maintainers downstream of him.

Your patches go through the trees of these maintainers, in this case:
qcom-arm64-dts via Bjorn Andersson
	-> soc-arm64-dts via Arnd Bergmann
		-> torvalds/master via Linus Torvalds

Maintainers generally refrain from accepting non-urgent changes until
Torvalds tags the next -rc1 release (v6.18-rc1 in this case), after
which they start picking up changes again.

After your patches are picked up, they show up in linux-next, which
is notably a release ahead of torvalds/master (i.e. it previews the
'next' release), so if your patch gets merged when 6.18-rc1 is the
newest, it will show up in v6.19.

Another note is that -rcs are tagged weekly, and maintainers are
reluctant to accept big changes at about -rc5, since they need
time for CIs, build bots and users to test.

A cycle normally includes 7-8 release candidate revisions.

Konrad

