Return-Path: <linux-kernel+bounces-866846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE670C00C89
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DB274E8D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1400304BBC;
	Thu, 23 Oct 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U2VRmxRx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E11C3F36
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219433; cv=none; b=KZbzhaGOEb6CjaHhC3H3pHp/uYyTfgiPbK+0xT/wG4vRb3fQ+iPTzrNuby4DookFynvENJWZmE4HWPw7PhRTzF3BAOuXtHaPbX53gKFumyrsPJxUg/b0YFYs8lMqavYrHADRivVluQg/HBbownquT4ac//RY/FKCAOunh6qbNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219433; c=relaxed/simple;
	bh=qDtwuwDedPsvaz//bcxpTqdEz/KYt6VyEOhloT8Loo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McU3NTXhlh2TlGEeHqvChn0DT1uANnuSsLbByVhYLSKmU1l1Xq6ojK/6C7Aqzwh9YhidVzL8wMDmd8AchBYuanm/urQMHCHXE0iuTCsXiAXYGcK/41Kuui/KuxppQBfKyal9J+LzPKuPn14IX28J2pj9DVTGVdFgNur/fFrgwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U2VRmxRx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7765S014615
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lpF72Vh5DJvcNErexz3Itv14zwMQYuNIxke7nDoWxqM=; b=U2VRmxRxHoWmogO5
	uKlPU+uYZh4dC4zN5bNFx49Z3ypv8OHlTx8tXGVLRacaPTghwNKzwvteMq5q31jU
	GwlXYiioKfyCkOaJXX9+rr+wOOVXVFJU6ddUUBevmqoZq3+VlfAS8PUX1mO4K5zF
	G8sPZG+Cv29VTcDCtFpVvS6SZsIb+g4s8LQS6C5qKOC8c9z8t5n5WSuUwdENKDB9
	XMNHyDrngUVd5eCZfq2UK2xwEa6qgVKr6hEyOHyM3xyzUwGmxO25ADQKWgxxJmhU
	HXX3FtanLcCVl/6RaPg04qSRWj0eXCwixqrbscSq/8FmpqVJBurkXyYErHLWyKvi
	AMCqvQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0p544-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:37:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a4c63182so19124961cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219430; x=1761824230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpF72Vh5DJvcNErexz3Itv14zwMQYuNIxke7nDoWxqM=;
        b=MKiZeIreA9MGdLUs9s2QuKz8qwWkT4rHucefkSXfgVROqvFXLgUvLfjNUoP742GhzS
         E3GQp740Ys/nwB4k+KkHoOtnWSO8V8BoqDmkk6++i5oJbTA4lm97ZP2lUjXho+WqRX+Z
         h+qts3+/MW0A7nRxnPsrSqhYGCtgLcOjJO684F7qK0jcfNa+doWiuvZwQZ8S7VQPlean
         4IxKe2lGie+SOomozMvByENQ3+lq4pFEFO/gdnEZ3n0qDFCVJJ0TNGvj2gi/OQHGSnvr
         0kCz/EHbH2SaMad6rUOJUCIx4zrWUQ/qMkR3uc5ZatOhRi/pK3g09ZfsBtkoy2gzyLLj
         H/CA==
X-Forwarded-Encrypted: i=1; AJvYcCWqf9CbuXMg4GNAH2ep5GqN44Fy+Tmhil2QfvQScMojlbvZdq11B63JsmBADGVZD/STb0FHE06lFjFg4PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvE9444/eZekaHG7dNUMpioxk857gobBqChnOayATOzDnC3LZi
	mcXpFLA3U9GYEm/18dNRlt6+BUnrPDT6jr+qAUyzrVqamCOHRhx4nwxBSxUYd8DWmE3F1ru9PHo
	+0YsP0Z1vGr188U9gsoViNioBG7vcRCvM9Uo3Svii9WPwpJkko5GLNgEQQWuH6Dd0m7c=
X-Gm-Gg: ASbGncv4oKDB4GLI4QrkG0q+f7yum1uX3qwOCf75/zo+BHgAa9BAL2nuZPsmffGX0Dn
	LIEeHa9/VutpoNithhQ+FLtND89wT5EAG9QW0XoDysHOQ/X4PZlr5AADFm+7uPTSHDlmaVbAhbj
	7vRQJsgOoh8vx8JpTJ25UNwk0cHF0BipJb9LqnhTk91kuTnAtAB2LB+9DSw9hz57/4JfW2qrc/y
	O+J80BdZtEiKKcAgVtMHWWjABnBFv4eUffv3Ja4CTvT6GaU/b9mkWn17F3bTvnemLNB29aWeDT8
	+pQeC1HqgQ/4XA1oRJdElfWAMsMmiZo7XceO0C8nQ/GDixv6KKwVhAVAh4O8OKYIk1NXFCgyPVF
	zXrs4dPmLGMpgNpS5EqbU+yezATZwPwNd+Ow2rPYQ5iaQCmCk0I8xd+t+8YSnw8IX0vODPMUjlb
	poRgzVswngUZ1F
X-Received: by 2002:ac8:58c4:0:b0:4e3:26d5:337 with SMTP id d75a77b69052e-4eb8105a06amr24449681cf.27.1761219429754;
        Thu, 23 Oct 2025 04:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8h+ScPIXeeaneNYBJbVKY4cjpNVlzXhby+SUeoUQk5LUg7A3rs6orbgD1leAJ71qyoDAtsg==
X-Received: by 2002:ac8:58c4:0:b0:4e3:26d5:337 with SMTP id d75a77b69052e-4eb8105a06amr24449311cf.27.1761219429305;
        Thu, 23 Oct 2025 04:37:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d1f539sm668877e87.87.2025.10.23.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:37:08 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:37:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
Message-ID: <7wiionjbjot5psapobmwcflecyu7pz3pzc44c3horsvjfj6yfp@f2iig6hyb5a6>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
 <on4zcfs5qdaekc7teo2iq6vpw7o2mp6yiqjkbznxo7wcxgutj3@nb35f55fkugv>
 <61c299af-c4f8-47a0-8803-306c08792b17@oss.qualcomm.com>
 <xlki5jwurnixdxaph5mtxg7sfks2cww3xbswgtf6dbn2z72o2r@smx5hxo6obxj>
 <c3fac2a3-dc89-440a-9958-f2e904c42f5a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3fac2a3-dc89-440a-9958-f2e904c42f5a@sirena.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX/I75N/YKiMkU
 s9yTfYCfKDkZ0WkUv3vrhnBTtzci7w+ZTShqrztktZZ+PyDMzzj9rQ/qR42aascXLqO2CMveJKr
 E4M5YMqZXEX0xt+H33LDI2ewhsBju1dEIv80C5LEjhucZY8MpxdVnk5aIZc+ee1x1qqEpB83UE9
 Nh3NjM02EULGJbJ0iAM1D34PwRJ31f6r0DsYi1KCne08myB/iuWyW8YIPbZfKGIP1yycnvtrpgP
 HbGsdEMhnluc0Lkvbmt7tqSJLULm5+Z2V5LBVFR6AthIMm6ousw1/+4bh8CBDRRsy3V0hHmUk60
 Q8Z265+snkYj1YwF8/wQaDlfIsQilLWTsAhxXCawzerPWr96XFUJClCuAjKvvG32hwAOtwbH69l
 HATatjz6ZmrXXdYWXNYlP9BNC1JMSw==
X-Proofpoint-ORIG-GUID: ucuHYsCuSOi_kcCtnxBTtG_HFsmDl_VC
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fa1366 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=hcSG1VC2X7GSabmSgqsA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ucuHYsCuSOi_kcCtnxBTtG_HFsmDl_VC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On Wed, Oct 22, 2025 at 04:15:51PM +0100, Mark Brown wrote:
> On Wed, Oct 22, 2025 at 06:11:46PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Oct 22, 2025 at 04:58:15PM +0200, Konrad Dybcio wrote:
> > > On 10/22/25 12:23 AM, Dmitry Baryshkov wrote:
> > > > On Wed, Oct 22, 2025 at 02:38:53AM +0530, Kamal Wadhwa wrote:
> 
> > > >> Currently, when `rpmh_regulator_set_mode_bypass()` helper function
> > > >> is called to set bypass mode, it sends PMIC4's BOB bypass mode
> > > >> value for even if its a PMIC5 BOB.
> 
> > > > The universe will end, the Sun will explode and Ragnarök will be upon
> > > > us. Please describe the issue, why sending bypass value is bad.
> 
> > > I think you misread, it sends the magic value which corresponds
> > > to BYPASS, but one that worked for the previous generation
> 
> > I just wanted to point out that the commit message makes a statement
> > that it sends some value. It should document, why the sent value is bad.
> 
> It seems fairly clear to me from the above that the driver is sending
> the value for the wrong device type which is something so obviously
> wrong I'm not sure it requires further explanation.

Okay. I'm sorry if I'm overreacting.

The bypass_supported field still needs to go away in my opinion.

-- 
With best wishes
Dmitry

