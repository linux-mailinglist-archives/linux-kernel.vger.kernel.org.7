Return-Path: <linux-kernel+bounces-871400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A2C0D24B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F06724F14EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9FD2F99BC;
	Mon, 27 Oct 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="myHeg4nG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34B25F984
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564280; cv=none; b=lXVQnrNKGeOvfEEm/S+CyGP+atEZJRH5wmXon1mJ8acPLIQUmoCqGnsjYjUO2ahgXoUJlZjfkENVDIKMQuQgV3JyFgXPYatIwrXT4vdvA9pnC7IRv4bq3e4uDruyxrezfY0C4WKjITjntz/HSKl21Pb19YS+bB1H8zd1T8y8BPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564280; c=relaxed/simple;
	bh=Tjn2XSdF4NEJWEm2F6LvPMPISBSVL+ChX6Q+leBvxl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVwomSkeKms25cMoe0kOp9CYsVoD5ytGDk2kxjTJbBnjtVv7JOIqIXZYUo8iObmAV5zPX3JzjQGuCwP/aBSpUsSetVUR2EkuMM0h0uLsWb/cBg6P4dDAqnkzGVJb1Z9sJznVrfsDeOz5vAwMkiuXvX9ci2d1cRmLuqloFHrdLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=myHeg4nG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8G6B2820257
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gg+oaNrvUF9ILfhrptxODjwkkTizmc6ksl2GN2fI8Sw=; b=myHeg4nG95IXEage
	6WBFiaU261eLIJwivXFdqCUgGI87MV6Fm6N5FxeFLMb6pq76mUmaoKWRV+nI3EyA
	3SJJoXPWzZU9EE+iA1YzEO1OnaIIXTZzKDcI1zRvq1NLxfIZ300EXZ2b33bPLyxD
	ZT63QOlIlqXeSW893uNRZoGEfhmlUk/oJ5fEHdJC8LQSsO9t17gFwZ4Ay4KpxzEt
	2lo6S+gQw9jNTbS+TvR5sawEYEgU7dNGUcAesgNoyHLEbjnAAarTn9+IJVT68Jyk
	N2CvGXXIFila1yAiaSOzTF2CdBRI4vX34wv5PyFJeBoQMDEpwI3UFVeGJu3ibXgP
	ISo2EA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0ps14aah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:24:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2982699a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564277; x=1762169077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg+oaNrvUF9ILfhrptxODjwkkTizmc6ksl2GN2fI8Sw=;
        b=n1OXZV9piyOXcsB6NU4fB5vgSar35vqyVPy8oVH9zUyCVOsk2DcIlYObp4FcbrpPUc
         wFZ8iylu/45RTJYIR46MYNXBbJZI0ezXLGIuIxPne5+Z2GywkTIUiYDNRmlZ7Yi9SWiL
         jHLy9X70sCsARqaVZnsqpUZrKd/akpsytLKWjxAfMKrBYMCM/+A+z2rIjtQZZNfCg37c
         A3/C9BDvipgUEC/sYRc6oUpyJPBBxI3EUIUxhf/dGTjHjYe3KvizEF7AgAzMtdlH23Rc
         3uDGvfUAYtZG06YGINd8E8l7zwv3Guh4q1u5M/qc3J4Y5DokS63OPyDGjoN+XKd0q8gM
         knmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhALjrendyCGp/N+QqJFaCnseaPU9/bQIjk2pqTwzkOxndDGrMrHYa5udv6R6Usc31ztuvbmE1ATKFq+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDydeldHgeOTZSy3C9vH5DiPyOFCh8VuQvNiCcLFq8DnlDsA77
	W0hPBgmCnRDtqodg7TK7pMjnalcAM/1GXhjqc+1NX+4OWNYR5xrWL9A9uvINC4AgcJrBZlFDva6
	B7ye4DstH+m43T8qDxT3cX/4C6DqIWLvjuPM6UKDFUbsJ5HGym4JzUQXBUC+tuOuCHfI=
X-Gm-Gg: ASbGnctN62R+QEaf4Qo3H4Wc48kl8+VPxY65oQ99BACZ3c/cQsw3pSqCfRXBz2tZGvh
	Us7DYhbwPjwFVdzsKttk4aBETov4QBm98+oedp/TYMAxlZ11Zifg4dszFHy4TswMX//6H//hiEg
	Odzv5D7I5H9yCY39WUg+vT144PWr9sVJv540IZ8KKHsI9Ht2hsdTmougp5fNtZujJTOczaCIz4P
	MJwCFKLF8zBndQceoG1OwOzrWT2bvLIasA1aZjygddt5V+gICqio6hFWRk2AJheNLrbTrwUEg1H
	i+R1xcKxHV0T0HUjtFtRiqeztcPZvcCM3Ggk2rExnqfgsKc8lv3pCyv3Qe1bQ0CtnYkgVKeV7hG
	L/B60LeGURsAQ2nWnBADSqrNXKu/sKAic0Wg=
X-Received: by 2002:a05:6a20:72a3:b0:334:79cd:fb13 with SMTP id adf61e73a8af0-334a85047abmr47340872637.4.1761564277352;
        Mon, 27 Oct 2025 04:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsjhBOZkZx9w9MCvltT4iIAvo+2a9fFa7BitzsuZT9Yb4/U1sE4CsXunT2tHtCEoQe/u6iag==
X-Received: by 2002:a05:6a20:72a3:b0:334:79cd:fb13 with SMTP id adf61e73a8af0-334a85047abmr47340843637.4.1761564276899;
        Mon, 27 Oct 2025 04:24:36 -0700 (PDT)
Received: from [192.168.1.3] ([122.169.146.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41402e48esm7827559b3a.16.2025.10.27.04.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:24:36 -0700 (PDT)
Message-ID: <231e19ab-0ab7-4eb3-b472-258428a79cf1@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 16:54:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-3-krishna.kurapati@oss.qualcomm.com>
 <aP8_oZlJ4466BEf0@kuha.fi.intel.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <aP8_oZlJ4466BEf0@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ju78bc4C c=1 sm=1 tr=0 ts=68ff5676 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=os7cmxGP5G+7zi0Bb7vKnA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=afDafrLgsQjIVlkna1UA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: khR--mcI7JqzmQb_nazIjVn4gtJPRkqE
X-Proofpoint-GUID: khR--mcI7JqzmQb_nazIjVn4gtJPRkqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwNiBTYWx0ZWRfX5E0P0hpvje4M
 1HNoOVeF3nrrdsmE/21qASlKQ86oWYVjomxsL8cUC4zOPlqloX1lKdVeidVAOdSLahivgYqA1Xs
 9EwKUhZ7C+QgPzxlf1LnmNx0rgbNBjfiYle7saLvMiNiWocUiloM6yVNypMbffgy491juNmxRey
 +63KYGslAnPcCmwuXJH/CGowM7Ctug4lcPpsciWPAO2hJxHaMg00yLgAckZPf+UlUulzKli2MwY
 7jnxz0Xq1+V9ccd7PHhKogaduWKkUfxhbBSeJryCP3v6kZ+scwbf/y9h2sSWY9YEJR44kSVxFKe
 0LODZc0MS18Zk38DaGf6HlEVPlFv1kyAmcYx8xTBN3uFLzLcuIpPLY5Reoh2q986g+4rTSULlqm
 6ffgGSwYSDuAn9YjE2SsERwfgF59LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270106



On 10/27/2025 3:17 PM, Heikki Krogerus wrote:
> Hi Krishna,
> 
>> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
>> +{
>> +	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
>> +	struct device_node *np;
>> +
>> +	np = of_graph_get_remote_node(hd3ss3220_node, 0, 0);
>> +	if (!np) {
>> +		dev_err(hd3ss3220->dev, "failed to get device node");
>> +		return -ENODEV;
>> +	}
> 
> So I guess that's the connector node. Why can't you just place the
> regulator reference to the hd3ss3220 controller node instead of the
> connector like the port controllers do?
> 
> That would allow us to do a simple devm_regulator_get_optional() call
> that's not tied to DT only.
> 

I did that in v1:
https://lore.kernel.org/all/20251002172539.586538-3-krishna.kurapati@oss.qualcomm.com/

But Dmitry mentioned that vbus supply must be in connector node:
https://lore.kernel.org/all/cbpne2d7yr2vpxmrrveqajlp3irzsglxroxyyjmviuci2ewted@6ewwp6yyybk5/

So keeping it in connector node.

>> +	hd3ss3220->vbus = of_regulator_get_optional(hd3ss3220->dev, np, "vbus");
>> +	if (IS_ERR(hd3ss3220->vbus))
>> +		hd3ss3220->vbus = NULL;
>> +
>> +	of_node_put(np);
>> +
>> +	return 0;
>> +}
>> +
>>   static int hd3ss3220_probe(struct i2c_client *client)
>>   {
>>   	struct typec_capability typec_cap = { };
> 
> <snip>
> 
>> +	ret = hd3ss3220_get_vbus_supply(hd3ss3220);
>> +	if (ret)
>> +		return dev_err_probe(hd3ss3220->dev, ret, "failed to get vbus\n");
> 
> I think you have resource leaks here. I'm pretty sure you need to do
> regulator_put() somewhere. You are also leaking the connector fwnode
> that was acquired just before this point..
> 

ACK. Will do regulator_put in cleanup path.
For device node of connector, i am doing of_node_put above.

>>   	if (IS_ERR(hd3ss3220->role_sw)) {
>>   		ret = PTR_ERR(hd3ss3220->role_sw);
>>   		goto err_put_fwnode;
> 
> Get the regulator here after the above condition. Then add a label for
> the regulator_put(). And you already have the handle to the connector
> fwnode so use that one instead of getting it again:
> 
>          hd3ss3220->vbus = of_regulator_get_optional(hd3ss3220->dev, to_of_node(connector), "vbus");
> 
> But do it like that only if you really can't place the vbus regulator
> reference to the controller node. I would really prefer that we could
> do a simple:
> 
>          hd3ss3220->vbus = devm_regulator_get_optional(hd3ss3220->dev, "vbus");

ACK.

Thanks for the review.

Regards,
Krishna,

