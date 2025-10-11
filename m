Return-Path: <linux-kernel+bounces-848942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D8BCEDCB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FC954E6E13
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725F88635D;
	Sat, 11 Oct 2025 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZE0LXkr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E029A1
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145738; cv=none; b=Ay9VVGRjaGjg9t5mZbNCm8eKU44QIcwMbgMhhvrjPNmYFchGpWIkh3PMsMijkXjUrMhaS9UoJrABKySURf5XvXLpcSkn/G996n5ZN5W7pvSvLW6E3UcN4j5MQYvaoVQQoo/KlHlOwHJ/ye6lHzE9cG5bcsvWMBxRVxx93bdYAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145738; c=relaxed/simple;
	bh=HZ3mLjNRQjX1qGnxm6rWXMlL5/igOX43KyrCJbe1r+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlVhv/uTuMd+CvkR20nlpd/OHf9GyAbEG+v7mZ+TieUvUY1Pc+7XhFXMShylSIQZW2zFmkLoGvn9ND2Lrsl+7xQJotp6FKmVddvBzpTNmlIhqULqRe6y4lcH9XZVIGH6zDpS0ZitFv0crWvhUA5/eaJlyguJMe3Y7eDVH7twies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BZE0LXkr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59B0K2fT021553
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=22PmJgUhzxiKx5+IpAAPxMYL
	VMT8ngl0DAw3wm/5cAk=; b=BZE0LXkr2+Qiv1IMekwSOgPjTUpC1lb1SjEom9fc
	07GEcDS+ZRu2LU2hxJ3hlipjApN4uGMcfq6B3J5Bc/6UMnJMKjAhdOK0VkACZB7w
	1ZPmeFgfvWKS3c3HsN4MOIaj7kCM3OnLPbNFhHabjArOyi9b3o7SGEjyRlZA/IZO
	FUD4dZH9X/D59PlZ/rdhwyp8v0H2eFUQsh/xyv+haNGlcdn0lNFdjNB3b89RVfQi
	Y7g4Xjrxr4qGe16DUek1OzrAQzltzoDadaOtnIwllqZvBMimmB7+FF6E2KJVcdRa
	JkZuEMk8avV/jjDVk59CXu8aJd8jdaLPtDxCZ+XRTZG6rg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qckkr2sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:22:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87a0e9be970so174482086d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760145735; x=1760750535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22PmJgUhzxiKx5+IpAAPxMYLVMT8ngl0DAw3wm/5cAk=;
        b=FMbQeOTm15FQC26v3ZrYy6OjI4BkBbWbibed6eKR860CM6QkorXhC4+N19uB/eduiI
         CaatNhWOdWKUKiTwqEmTFf36kyf7eLXGLEzvIEnEFP4faAkimLpCtOwMwiUUhnVysJNQ
         3dNiw6bSOJPoRnYRlFM6IoGcQuKNbe3LymMfluCAD0dusRjMRVGtHSLNXlPfXGR2Q6jO
         k1zC9MFWhjeq2x36SSOI87GcGsoqRq0aAXHWLtTaYd0md5XEhJ/YLkeFX7XAMZjVK9rT
         b0Z4NgsUaH5U/utOU9JudqV56h2CFDLAe1t7vgc+4Qcx4TDHXLUHbrOEBiLxY/910Gia
         Zw0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2iRqG/d73tb/D8lMWXHPS1zdk3lX+LmK3Ap1VYtw1h3xwDpHFxUHi4E3CukWlCzLolB9q3Pj7XX2naZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJ38FN0tAnM6b83QaEYqsH0FPSy15bkMBTR7cm7yOMxyRG+Il
	s0iply5f+2TQ6kecrnBmkSBQWdhc1hDwEb4J/NNV8wcJBYl8w1jhnUnO0uFSNjd3a7jaLaUgdRW
	Rge4tsnlG53Nxy7SRDqnu9Jtd2BFVL5fqn1Pnw+VIC8dX3Dukpi7lAKtW5RTZYYmziF0=
X-Gm-Gg: ASbGnct2dA4uzFhFoaG2K4M/zkzafHMIS22nPMsEyEjREvGUJydA9C3NTDLcCvQFRBH
	8LHvI2FmTt+XJc7Ewz+7h364IAvyrxALFGWUKkXZZ5Mat76Vtsu6wn59hu8YIqtPO/OjwYW9kf7
	sbapVo4nr2T2Fi9HVDfCcY3z90VUT4DjS98VTXCkzd2xNgKv15G/Jc4p80+6iCOj+Cqtct6ZH10
	gwPtkHM/cNe5Ss4E+OKJwDMCG3j+wuUHnA3zhnGDr5OsnY9oYkZzKAUwzpnEVJL89NDy4tNiocj
	9DLx9gP5z1BP5SqnOoE4BrAMU74QIRPDbfcPzfMCM9xfvFsRxkOTyyrCjm6CBNTYEGmD/cvVxg7
	Xn+eJE4IuSpq6i4BCOx9KyxXIa9GIR+cve2XNybBlJF/ABAk6Rkmb
X-Received: by 2002:a05:622a:18a6:b0:4de:d9eb:8af2 with SMTP id d75a77b69052e-4e6ead630cemr203562421cf.63.1760145735236;
        Fri, 10 Oct 2025 18:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSxP09VxzL4AdeG+j26+0ZPwef4cSR7s1fRwMPH24RBHSJt8XgyukwJ9XzcJRRP6KVrlxyuQ==
X-Received: by 2002:a05:622a:18a6:b0:4de:d9eb:8af2 with SMTP id d75a77b69052e-4e6ead630cemr203562171cf.63.1760145734783;
        Fri, 10 Oct 2025 18:22:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856382dsm1377018e87.68.2025.10.10.18.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 18:22:12 -0700 (PDT)
Date: Sat, 11 Oct 2025 04:22:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org,
        robh@kernel.org, bleung@chromium.org, heikki.krogerus@linux.intel.com,
        ukaszb@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: typec: cros_ec_ucsi: Load driver from OF and
 ACPI definitions
Message-ID: <fciyxaedvyqeppldl26rsy7hogoi2zks6tq6m2yu5xerfjxo3g@u6vzsiicv5ke>
References: <20251009010312.2203812-1-jthies@google.com>
 <20251009010312.2203812-3-jthies@google.com>
 <alnlmxbcv3ivhh7iolfqsurhknnm2o6i6waxq7kuhmzcbeljr5@a4wy3prshu3c>
 <CAMFSARdzoZrv4oXxVAYRcZJgxdLcrTMVAVGa=D8H=9c1vZ0zKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMFSARdzoZrv4oXxVAYRcZJgxdLcrTMVAVGa=D8H=9c1vZ0zKQ@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=RLy+3oi+ c=1 sm=1 tr=0 ts=68e9b148 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=iAm5ckqHF2LNUxrvEqEA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: va2MZDymC0j6m8654rMg1u1ePHz_Lkb8
X-Proofpoint-GUID: va2MZDymC0j6m8654rMg1u1ePHz_Lkb8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX5JRgoi8aGFVS
 UGnhOmwBY+8MyvHv/z1JdxUlMbZI8lO2PlEK6FbjYa9+jj18KA6OrVXyJRaJQ1cPWUm5Clo2pTO
 gwZw0RYkz6v+SzyFXd3qQwxwnNJbr3QPrsp4ZKEBvjoYqLEx/bsdFI6b0PWM6liYqtZetUB5cr3
 zpTCBKqyH/a1nkkcaQHc0/d9pRzv9aJsXFakIBKgsk53tm2cn3xJ8xz7COvtp30bkfMFe2J521L
 9ryc8CHAIOGN7eq36g/PNh2MhKFRBEcAJgbFGlLmAkUr/df+nlzoQHZo6mry0a6RRGKjKy9clx9
 E3Fp5DNc+ZlvHKNMc4qROCs+zrkt7OmnYaJegQsUkCsdQkcm4owAkNa+gdpmaHjs1R1fbewEe66
 +HxaBlRaTNE6z4GxHtEyWJcgfpSQcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510100140

On Fri, Oct 10, 2025 at 05:10:13PM -0700, Jameson Thies wrote:
> Hi Dmitry,
> on early ChromeOS devices using this driver it gets added as a
> subdevice of the cros_ec_dev mfd. But, we want to change this to load
> the device from OF/ACPI nodes. The issue here is that older devices
> which don't define the OF/ACPI nodes to load cros_ec_ucsi will still
> need to add the device through cros_ec_dev.

IIRC, MFD devices support binding subdevices to the OF nodes. Do you
plan to use it? Could you possibly point out the example DTs?

> 
> So cros_ec_ucsi needs to support multiple methods of being
> instantiated, and going through cros_ec_dev creates an intermediary
> device in the path which doesn't exist when the driver is loaded
> through OF/ACPI. I'll add a comment explaining this in the v4 series.

-- 
With best wishes
Dmitry

