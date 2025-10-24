Return-Path: <linux-kernel+bounces-869615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00201C0853D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A09534E313
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA130C62D;
	Fri, 24 Oct 2025 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iy9nBdiW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577830DD30
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349029; cv=none; b=Zek2RjHtLs91lmJFrCvaUf24nYTCtKQzhJKwUUei5WpssmjV+Xjc//z3WhXJIlgdf75/AWneE7u1LsNw6RLwR6A+tHhvSigmVXSdgDn6XH04r72WCvYmhsyX3MFMrFolGWfzZeLQGBP9jiZvZBSzyVlfQwWPAhMPo6unwZrXb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349029; c=relaxed/simple;
	bh=ejv28ey2tIsFthuSJL2U+UTwWlXVb/k3pPfpgY5U+7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ozi9mrVTqzZMu4TeCrVjSyvt8qDVPspMQQepwtoz6i6QYLm6zuwjlcBFLrYkPW8IptzplVO+mHHKsssUvPGX+t/0UrO3bn2TdZP6RoBQozP0mlUr2TI9LpPYclcv4nTYIzW1ty7ao8lS3JVxXdUQHcVLzxTF4cdT5IYBs0Ng7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iy9nBdiW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9LZX019412
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EZFysYVyYBWltYrC0SedwHBc4KXxbxS34afltiLtTwQ=; b=Iy9nBdiW8XRRmxcg
	lbXk52zwASTTi/7LnATf1ZS7YVdB16SC6qjLoCXxzoH1FkEnn7IOtrtOaiKd6FQY
	XDd3QPYTChX05Rm37Kd01q5M9BQFJrqmUGkd63xyy1qGHPgrkx1JiFsXK7XlGBGq
	pOODHc1rp3JRsibrjMdKVR1bHIsVug6MZGSvoRrwAbhcUyKSgfVDIAqItDohTHEE
	aJfopVF1AdYXqgoH+TMsFl+gLf8ERPuDyG7j+F53H0jReldUycnr6UbkiQSKTMVQ
	DLg0sncKh9a3yU0LkwwakuTTqTC3AaK5EqTSInDIE4FjNUYEr1ZPvd8NRH+hnRuf
	ACfewQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49yp6k4r3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:37:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a73256easo130612121cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761349022; x=1761953822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZFysYVyYBWltYrC0SedwHBc4KXxbxS34afltiLtTwQ=;
        b=lNZANSMzoTTkj+ia6EKKePIANe5SkKwnr34GjLvwO6SO/ef70neIh2Ge0cKrzczT6Z
         bekd5WYgvz/e/I8vBHnwmvf9q8WPh+qpFkopQ/NK/koRVf6dsAaNfCx1mjoSSspdUrvD
         NazjunghLlaEo2Ke/wDqCUoO8x8/hzZ5NEQK0MVGgaYFycAHQxYmDl3oTYg4LuDnXT/R
         AHOJfgJV8dGDcTpXHtN7DA1St75lZ3+asA/vFSwlJHARu13unDmiKAeTGJXb4sea8Pfd
         +orIdQG+55k/RZVd6l3Z5OpJi/Mz1h2TZBfyROUrJ9iipUTZ3ndlhmfYjJpu8CCWPi9E
         zelQ==
X-Forwarded-Encrypted: i=1; AJvYcCUofdnLt8TJtuywm3WudgJoLCi8xPJWazynB9QaEFwEegFfW1ClSyv7vQR0iXOjwl3YtBI76EPhEsQTaeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQOLwRcaH6KcOkeeCTE9MOqBX+BMqPRL7bqds0YJzCIADhU7b
	seg3XgSBSrPBGcWemWvu7t+RRyV9Jjr+F7QZtJr2jF6o+AkzkDZfXzjSoxGOizqpE4EsvPLYFSf
	HIrL51gKC3lws56QaxnxUS6g9lgJv27JKmdWpdFm13fqZUnKVhsQfo2Po5CdJyswr/x0=
X-Gm-Gg: ASbGncv+tPjWmGK8WgP2BqpbBvQYlOWOHaG0iGl52LUOqq6YcoE25kizjAqIlreUwG7
	qhDHCjx4TncAvWjZg/evDgH2cxVgIqGGGjTPrfHMDbXCE2mmCLpKGJMjEIZlTcf5cx0XHjs9G8A
	0X7wXWodzihQLg0AbX+MvBqV0FkC6hXnME/+yfjs25uejr7YcviqvKAsYZ+vbkPohiFo3halcr+
	jBn5mVUr7c4EZoxXYwKG6Fb2u7/hFS9qSXJz/fL4OUkQtxU0IYFWKvHZ8uAZ/yKFN4a5/8grsc7
	Z5UbENHhhYOdpB7VRCYGGnLkYAClrDT3s+5bfrw/pbd/LZUTsn9ouSNjy5N5rUqUYVHMCpujn+F
	vQRO/opVuttdBKMnpO4QuzCWFmj6AKdRZmjYwReGyRDItEOsxI6piS3cJpef1pI0xwYBdl94gHJ
	Y7MMfQz4mytZjVHQjtbcg7EmYEezTSPlYH
X-Received: by 2002:a05:622a:1a09:b0:4e8:a9f6:352 with SMTP id d75a77b69052e-4eb92c1a9a3mr55799071cf.20.1761349021774;
        Fri, 24 Oct 2025 16:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYkPMH/1amLDMteKXiUxzbbwspSGbdq6LXiAVzk+48gbt7k63sGZ7x/Epi+FyyMrfa33UFxQ==
X-Received: by 2002:a05:622a:1a09:b0:4e8:a9f6:352 with SMTP id d75a77b69052e-4eb92c1a9a3mr55798821cf.20.1761349021214;
        Fri, 24 Oct 2025 16:37:01 -0700 (PDT)
Received: from ?IPV6:2001:999:78a:6bdb:4a04:8470:a7e2:a09b? (n858d08qopcovr0eljv-1.v6.elisa-mobile.fi. [2001:999:78a:6bdb:4a04:8470:a7e2:a09b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09d2e5sm1610011fa.17.2025.10.24.16.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 16:37:00 -0700 (PDT)
Message-ID: <417075cb-73e8-47fa-9685-a0441dab7250@oss.qualcomm.com>
Date: Sat, 25 Oct 2025 02:37:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com>
 <20251024181832.2744502-3-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251024181832.2744502-3-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMSBTYWx0ZWRfX+rlTb0rUfpvP
 hGj6egVeED/wf13W3UXZCrOwQ2dnFRdrr2NWWoMGuRSCmn5Qwvf60SsFRWwnfU0Sco5Wp/RlgV8
 eo13cHrRoPppF62It96Ef40+Y3vaOZtp4JCmgYgDUAlRE7HDHupWIcq73O8yH8+pK3B41fmaJtI
 OZqClzYRIvtGeyj1zzRHW/rrGOrbudZB/RUoudjctIo6WVbM62SxxoYRcJwLbkN4OvDB1NZ+snX
 noM1TUxWtD5slyfn8MSjhFPS5M3kl1vCRauFqrcy2E4NgjdJ4GwUgl9S/QMdb5Ja/a+mtMRUNnW
 JvHEg4bTvZ86dDQntChAy7GhwfB/AtkP21LkHAfzBg+8H4O4I5djdZ9D8fG3WMbp0LnVTU7Vo8x
 LCpuNoMhTvnK+5/HZlP7b5QTWYQN0A==
X-Proofpoint-GUID: fS4y9TpiPn4ajbZdB0NVASNtrqNy6F_f
X-Authority-Analysis: v=2.4 cv=bL8b4f+Z c=1 sm=1 tr=0 ts=68fc0da2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=HzzVZquQTjcG95wWTlcA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: fS4y9TpiPn4ajbZdB0NVASNtrqNy6F_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230131

On 24/10/2025 21:18, Krishna Kurapati wrote:
> There is a ID pin present on HD3SS3220 controller that can be routed
> to SoC. As per the datasheet:
> 
> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
> not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
> low. This is done to enforce Type-C requirement that VBUS must be at
> VSafe0V before re-enabling VBUS"
> 
> Add support to read the ID pin state and enable VBUS accordingly.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>   drivers/usb/typec/hd3ss3220.c | 101 ++++++++++++++++++++++++++++++++++
>   1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 3ecc688dda82..089c4168c7b5 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -15,6 +15,9 @@
>   #include <linux/usb/typec.h>
>   #include <linux/delay.h>
>   #include <linux/workqueue.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of_graph.h>
>   
>   #define HD3SS3220_REG_CN_STAT		0x08
>   #define HD3SS3220_REG_CN_STAT_CTRL	0x09
> @@ -54,6 +57,11 @@ struct hd3ss3220 {
>   	struct delayed_work output_poll_work;
>   	enum usb_role role_state;
>   	bool poll;
> +
> +	struct gpio_desc *id_gpiod;
> +	int id_irq;
> +
> +	struct regulator *vbus;
>   };
>   
>   static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
> @@ -319,6 +327,71 @@ static const struct regmap_config config = {
>   	.max_register = 0x0A,
>   };
>   
> +static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
> +{
> +	struct hd3ss3220 *hd3ss3220 = dev_id;
> +	int ret;
> +	int id;
> +
> +	if (IS_ERR_OR_NULL(hd3ss3220->vbus))
> +		return IRQ_HANDLED;
> +
> +	id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
> +
> +	if (!id) {
> +		ret = regulator_enable(hd3ss3220->vbus);
> +		if (ret)
> +			dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
> +	} else {
> +		regulator_disable(hd3ss3220->vbus);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
> +{
> +	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
> +	const char *compat_string;
> +	struct device_node *np;
> +	int num_ports = 0;
> +	int ret = 0;
> +	int i = 0;
> +
> +	num_ports = of_graph_get_port_count(hd3ss3220_node);
> +
> +	for (i = 0; i < num_ports; i++) {
> +		np = of_graph_get_remote_node(hd3ss3220_node, i, 0);
> +		if (!np) {
> +			dev_err(hd3ss3220->dev, "failed to get device node");
> +			ret = -ENODEV;
> +			goto done;
> +		}
> +
> +		ret = of_property_read_string(np, "compatible", &compat_string);
> +		if (ret) {
> +			of_node_put(np);
> +			dev_err(hd3ss3220->dev, "failed to get compatible string");
> +			ret = -ENODEV;
> +			goto done;
> +		}
> +
> +		if (strcmp(compat_string, "usb-c-connector") == 0) {
> +			hd3ss3220->vbus = of_regulator_get(hd3ss3220->dev, np, "vbus");
> +			if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
> +				hd3ss3220->vbus = NULL;
> +
> +			if (IS_ERR(hd3ss3220->vbus))
> +				ret = -ENODEV;
> +		}

This whole loop is an overkill. You know that only port@0 can be 
connected to the usb-c-connector. There is no need to check other ports. 
there is no need to check for the compatible, etc.

> +
> +		of_node_put(np);
> +	}
> +
> +done:
> +	return ret;
> +}
> +
>   static int hd3ss3220_probe(struct i2c_client *client)
>   {
>   	struct typec_capability typec_cap = { };
> @@ -354,6 +427,34 @@ static int hd3ss3220_probe(struct i2c_client *client)
>   		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
>   	}
>   
> +	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
> +	if (IS_ERR(hd3ss3220->id_gpiod))
> +		return PTR_ERR(hd3ss3220->id_gpiod);
> +
> +	if (hd3ss3220->id_gpiod) {
> +		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
> +		if (hd3ss3220->id_irq < 0) {
> +			dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
> +			return hd3ss3220->id_irq;
> +		}
> +
> +		ret = devm_request_threaded_irq(hd3ss3220->dev,
> +						hd3ss3220->id_irq, NULL,
> +						hd3ss3220_id_isr,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						dev_name(hd3ss3220->dev), hd3ss3220);
> +		if (ret < 0) {
> +			dev_err(hd3ss3220->dev, "failed to get id irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = hd3ss3220_get_vbus_supply(hd3ss3220);
> +	if (ret)
> +		return dev_err_probe(hd3ss3220->dev,
> +				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
> +
>   	if (IS_ERR(hd3ss3220->role_sw)) {
>   		ret = PTR_ERR(hd3ss3220->role_sw);
>   		goto err_put_fwnode;


-- 
With best wishes
Dmitry

