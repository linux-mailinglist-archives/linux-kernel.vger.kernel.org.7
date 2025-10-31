Return-Path: <linux-kernel+bounces-880130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BFFC24F16
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9BA3B651D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7B347BBE;
	Fri, 31 Oct 2025 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pxuhDPyn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HxctMC8S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D521420B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912727; cv=none; b=FS0LoMZH7njqGbXCv14lzHsreQ2RiTsQfXMq0bkG6bMbb2t6+1pzPJcDvtOiOk5ARAWwkUj9m6tlW/P4QYqBg2AL0CipD7P/8+6DnJn0DM988xlCNRPNEzERF3fQqJoT+lBHh8OHXLeQtWtBmRNZo0QqFCzuagdHe46hGNnYEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912727; c=relaxed/simple;
	bh=histqgWYWRJzF/fRVEEH99JEM6BEShvYwzywG0nFBU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPs/3LsvsgPzkU0vJSbbwUSyJYXDNuaOICqCB90CJGqMOAbU4s8Hq8s3pflxsFGmy0T4sla4ZVs8yr7jBqYDHjW6pfzdKZtkC2DcXiFFdithsGxj8P9cg8CaIpLy8Q2vhX0HbreVS8JlS+h1XT2hFYRlvpJepHHZFl6NgqNrtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pxuhDPyn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HxctMC8S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VA8V0A1512264
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t0ntCCJGokp8wjeBNRQ5jO4E
	1nDyS9ibjhGJgiXXXCc=; b=pxuhDPynTe4oatb/be/N1kufH8tqBh8BbQmUFBc+
	Umae1vEejTxvazmw5bvc+rHDy6X0tdczjJq/396cXHR2D1eZbWcpYCcNjHhmdSNF
	LC1jiUmQa3FR7DHngMBz09YZ+OR+le24Hkt4/7DA7RUAOqaAy1rGZmE8d3nBAr36
	VRX1BOc6HJdEUORYGDWcGtja+amIz9ACOq3Sn9yRgGfCpQXAzMi14saO8+P1xJhT
	w2JZ8V676+YMrKc/jV3fkQGy5P0EfXnrPbB/AO/dekXxSWOZ0p1wPP++V0z0R+cs
	vi1X49No2SxHc9HfuRR2Fq0cDjcQp0Eslg/3yj26SrmlDg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69hkxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:12:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29526a0d1afso7707055ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761912724; x=1762517524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0ntCCJGokp8wjeBNRQ5jO4E1nDyS9ibjhGJgiXXXCc=;
        b=HxctMC8SnZOJ9PZ1n8ODxwYZMkQgUnenrWXRZ9vrltF1VnwgJeQwu6VsOFlkcOA/el
         bimyCac1jBG1PGT4n12L+hWfGneqWUurFqxLEzO9o4ZeSR6Fxn4GYqQg9w6M7a+Wjg0A
         VRFmY1vDaRqtJnYi7GazA3nTev6fIPz3v+a+oZyZyhMZZqkyzVDAyZ4ctk+lUA8vuO1c
         lbvFF3WI8DRGBsoKqRWpHsecCf5ke0ozpp5Kgd+j+DOVBk8xl84oj+l0dqEKsN9Hp+Fb
         dFt4F95BO7sdpc0OdvWpeO9NalhZd9JHkQ/5uX4CKzbJHo3hwwzzSk+mWAACXap3LaxU
         /WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912724; x=1762517524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0ntCCJGokp8wjeBNRQ5jO4E1nDyS9ibjhGJgiXXXCc=;
        b=WT2xje2A31cdLv+UKKBU7RzJeTuKPNGHsCLI7x6YxanZ+EE1XjE+5Nz3XMdNKA41AO
         VLrIGU+Dmn/c1tnHagWM1eC61Jjf+JPeP8houLl7z4n9jJDxy+9SGvpJTCSBa3/H4uWa
         vbJfBWIO12K9fTjdmKxfbX8mpkqDc6/1nh6QBNzmvZo7dap4dwbYd7DIb5uv1Hy55wUP
         NpFxlgm5sIJ8dAPasOAKY3D/Dbywtfs5iMDxBEyFkcuNBk3LI8wj1+YMGCuZmr2CYKpn
         AFJ7LaM9jk+OoBAWau5O0y8dY5G3BNVfpFL4a45Olu4Epd/S+bXR2fyfVO8nFeTIXKyd
         3XtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQdOe5FHc6WB/yMapSdaL+U7+7V+WQ6/5yIz7lL+Nffndz3mOGJTcUmWrCz8RgmWy7wr6zd3aRCBe+Aek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+JgK4kTwSFHyeD9n1cBlckakIV8vcgYHxe5ZWiFNd8Z2QKEi
	flp9VyMjOgQKTVnR8loQs0hWOOlBZISPWCDzqvjwJtzZOIs4HD71eVAs64QY5dIFmZQpU3aVx1d
	vjKPcHPGQclojcuQgNzwLcE2yriZqhc+tlZqCcLHfIVYlvzZiklOIczqfryENqEiSuMA=
X-Gm-Gg: ASbGncsCZljtGJsMYDxAF6+q4nKTlts+SKPJxJKSibGgbiQ87nBUE/kpr5TZfaNZabE
	27S/KOx+XdnvWNd69Xnk9zcEcxKRzUs9WZ6eF5S8kx+Prkab6iLs8wrQaSNQcnCd7GWlzNG3Hhn
	oZolRplRLRYiATHEmj+VcbFPSzjsCqi4aQcjQbTtkL4nqHuVLkSiFWLfnKSxzhp8z742ZC0AKFd
	3QBJBdJ7PUMBT0oew1F0/YLmWk9EkO5SjPimm6uDwQa2mjsTYGaSSUm8K4cyX3hTd9SiryUicxb
	CLG6Py9wasFALl01QUE0BiOoakn5yhx8pxujezhNobmQu0JxwGMH6p2hb4dCDnvYHwxvpsvYGOy
	0of28E3WUiXUKZuRE+OueGi0lCp2k84gT
X-Received: by 2002:a17:902:dad1:b0:27e:f03e:c6b7 with SMTP id d9443c01a7336-294ed0982fbmr89140565ad.10.1761912723487;
        Fri, 31 Oct 2025 05:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFkkeZRsiuTlC1EpCac6wkygqEXe2Ou1I4f8XHFqwZycCb3yybQhK+4zAvwptAWwbxS1hO5w==
X-Received: by 2002:a17:902:dad1:b0:27e:f03e:c6b7 with SMTP id d9443c01a7336-294ed0982fbmr89140035ad.10.1761912722819;
        Fri, 31 Oct 2025 05:12:02 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268b553bsm21984775ad.39.2025.10.31.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:12:02 -0700 (PDT)
Date: Fri, 31 Oct 2025 17:41:56 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: hrishabh.rajput@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/2] watchdog: Add driver for Gunyah Watchdog
Message-ID: <09e8485f-f512-4069-be9f-3e94fb142aa3@quicinc.com>
References: <20251031-gunyah_watchdog-v4-0-7abb1ee11315@oss.qualcomm.com>
 <20251031-gunyah_watchdog-v4-2-7abb1ee11315@oss.qualcomm.com>
 <13d2963d-e931-4e51-b875-a1650b899bb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d2963d-e931-4e51-b875-a1650b899bb7@kernel.org>
X-Proofpoint-ORIG-GUID: KhcKWbKA6I6gRyQOuhnBaJXW9Vi0oqEX
X-Proofpoint-GUID: KhcKWbKA6I6gRyQOuhnBaJXW9Vi0oqEX
X-Authority-Analysis: v=2.4 cv=OYaVzxTY c=1 sm=1 tr=0 ts=6904a795 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=SWRU6URpa7t1zXFJtNkA:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExMCBTYWx0ZWRfX6GOXVfkLpxOG
 IjHL1Z78VpkX6qaiLxmU/H4LoJhynsk8LroEyJ7oOeN6NR9RKz6bNXx1E81+9VmemASYREQWX1/
 IxJslG3IOzPhem2sPbZuS0eSuy9aXhSjJKuULOGizRqDZdJoeBq/4fUxgSNDEoXcyYBMHWFaJ7D
 E8NwDkjFmvymwN5PuqV3A0O4F7avaTj811fCLx04P3hjAugTKj3bJFMLrf5+4GYyUtM01qq7vA7
 LZ+dfZJC97z7rc3IODURk0g8/98vmPqZPnVi0cpwPoAzjsf6HwkLrYIg+k1PZfYJGJc9FFLEOjj
 zHQJtLnkqhvPjUN23RRbHZPbCp7rRP+tPl9APHn1u+surKQvbs7xdH5CqKRq6Bzj1wIaKIAUI9Y
 jlHcoO8SOqOsay//SHdkjEoB2C6vVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310110

On Fri, Oct 31, 2025 at 12:48:18PM +0100, Krzysztof Kozlowski wrote:
> On 31/10/2025 11:18, Hrishabh Rajput via B4 Relay wrote:
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(gunyah_wdt_pm_ops, gunyah_wdt_suspend, gunyah_wdt_resume);
> > +
> > +static struct platform_driver gunyah_wdt_driver = {
> > +	.probe = gunyah_wdt_probe,
> > +	.driver = {
> > +		.name = "gunyah-wdt",
> > +		.pm = pm_sleep_ptr(&gunyah_wdt_pm_ops),
> > +	},
> > +};
> > +
> > +static int __init gunyah_wdt_init(void)
> > +{
> > +	return platform_driver_register(&gunyah_wdt_driver);
> > +}
> > +
> > +module_init(gunyah_wdt_init);
> 
> 
> Heh, what was my last message? If I see module_init() I will NAK it.
> 
> At v3 you really ignored entire feedback and this one here continues the
> pattern.
> 
> NAK, please read how Linux driver model is works.

You mentioned in your previous reply that

```
If you call any module_init other than module_foo_driver I will keep
NAKing your patch because it is wrong. I explained why wrong already
multiple times in previous threads and other discussions.
```

If you are referring to why module_platform_driver() is not called here,
Hrishabh answered that already previously. Please see
https://lore.kernel.org/all/ndwwddd7vzjpgvzg55whdno4ondfxvyg25p2jbdsvy4lmzsfyy@jnn3wywc7xtp/

If this is not what you are referring, please let us know. Thanks for
your constant support/feedback on this series.

Thanks,
Pavan

