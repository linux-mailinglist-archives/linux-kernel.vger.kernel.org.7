Return-Path: <linux-kernel+bounces-810538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4DB51C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617D04801F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F4320A29;
	Wed, 10 Sep 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gzxcu9mF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2930FF30
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518837; cv=none; b=UTYpwopL3iR5szyXkKWCPg2D5EbhWPrmOhYspZuEl6k9qcJleiSUif98cH3irKiz9Ha9eA8pmH93rLq25Y/Ez7uJCkde8v0Ubi7Kn21fLfXfBsgjJYNG+JWwOVI2pFMDK/Ssw757GqY6OehblFFC7IyD1Mmgi+xuGpF3Yn5HF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518837; c=relaxed/simple;
	bh=hVO2+M1CjyDTcr6hYEq2/ZhVHSxpZyBpTsRag2acXao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ill0qwhFYBlvdReRPnYGlOf7N4sn7zlW1KvZhdGoeTdvNOTsvQ7UOpHpiG552K9ht+/BjO0r3Pj9w5WYITDBOtBmQA8pw8U/W0CiXIbOuPpfIWfTI9OvlhjgdWndpXYdPLtcYZz1qZLIaS6IGKb1qMzwORBUtE6Qn1+frCmOoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gzxcu9mF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgEt7029764
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pN4pFZtmgQrocgR3Dr7GVghq
	e/kLxGp7oEbuGlqoA2w=; b=Gzxcu9mFU7vszs5KdS1iPcesfAQcSQBrPkJQ+gzz
	ViLrnjgDYlrurs2dljz5lIRdfPMicFAjxliLXy4Lapb5gx8RASb0GbWEFuUuZgiY
	8bApGWGn9TiD+vhYiGIYYSWgupctEyhaN5qZrqVk6KYgNpnS2/Wnn8taaVNDYiJA
	DZWdlM6i3Pak8KMA/GJWsFh2MkWjpClUFOQecmyShkRp8Dv2ih6HuR+gO9rDkVh4
	hqc3AzmVwbOsB72drkgd0VtzQtmUe/7tHf89bUHyWJrYVJihfPhMD0hT7sXKCaUh
	W9r59ToeVT5YuxUXWw1znLKuWhZGzbnjP1BEUHbPA9426A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapmksc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:40:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-72108a28f05so280276256d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518834; x=1758123634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN4pFZtmgQrocgR3Dr7GVghqe/kLxGp7oEbuGlqoA2w=;
        b=raeopp9UtCVxARNFbqR9YbfDlOMTJs6cHQiOP06eur/EgTqdCVADOsBieaMVs6unwE
         0lw4wdOkNy5ic/OLBcBQ/rvoiT054h6HI3kGCNATNGYipNmTxP020403rPCLJda7t1ub
         tne8yT15cMAO/I8m0Sp3SlTUDquVsb1RjH8JZd3UUo16KWR+ZjgxcHJZ+fhnzLfI0uaF
         z8PBJ8najT/J3jwRqVxMKUR1zYOtQC7Ew1YyfEhIr4KMTreB2ieGppLQKEsRuaPiO+5h
         ugX/vuOS9mvttuuGqWqhXd5/zc6KeJrhzuEU4asb9duneODSI7SlUNBQAJqAvDDBQDn+
         MTmw==
X-Forwarded-Encrypted: i=1; AJvYcCW5SzBNOPky13LlSgaN0BIBbthMflJ8uRAfUJ6XrqGJg7M6wDIlN1PM7mqmt+YLOsZ3RtrPIjZrIu634L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyClY0GUBGkhGU9a1tuOv7ka7jS9rKH9foK8PauMxR/8dKs4FUx
	QnL/wDxgF3zhSfxJmxZheD5l4Nvo1Bp6cNpSw4Ki9U0/HiXwK1kxtghw6DecmNgsrilEtbf7gcN
	VuDsjPaLpLKMcS5AqF6Bp9/ue8Q94NBc+RzK0Khl8jNlsvBTgTYYoALubgOtOUwrvb9s=
X-Gm-Gg: ASbGncv3QHMaTl7quE+trdA5foxxZLq4APMCXf0gz7sjXXRB0w6S5tVCL7zV963+pwh
	5xnWv8VtMdo1P+6qJ2WKC31eycU1FJgbTsjVZ0wlLfWMllAwjemIj/HBKrXb/Ml0jDVq/TIgEok
	sJV/yMGJAGq1ISWipXz/2vHXvXLpVFTdg8r7NSG8N/cbkimZ+XACSDFn1OLBoIzN/nyP+bRQZBs
	pAOs4sGv7CiPzyWEngz8bG1AP9Y/5NWQqUlg8ZAHW5ItXMwiHGB+brGndGJVZPm0wYNvbBslLe0
	/K7ySarZRA8ZXopusgIqpbTcHZXNkHoKBVSextZNuwOXBTsa1I/RX/L7fF8RbLi7ARXbwMAR0vY
	2SrGkXn/95IAPp2FWeZ8SXOHiXq+i3lrUZ/AS9wJIiribEzRrrrjJ
X-Received: by 2002:a05:6214:f28:b0:75c:3592:8c9f with SMTP id 6a1803df08f44-75c35deda13mr49159556d6.2.1757518833919;
        Wed, 10 Sep 2025 08:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF905L8VrU+MKuXIRfhtvAkXP6gqp4CpnfFHzrpoC1as4rJ6TJsh3mY1ibNxJn0xDJi+fHWeg==
X-Received: by 2002:a05:6214:f28:b0:75c:3592:8c9f with SMTP id 6a1803df08f44-75c35deda13mr49158976d6.2.1757518833265;
        Wed, 10 Sep 2025 08:40:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56818445507sm1319770e87.109.2025.09.10.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:40:32 -0700 (PDT)
Date: Wed, 10 Sep 2025 18:40:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
        jessica.zhang@oss.qualcomm.com, Yi Zhang <zhanyi@qti.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: bridge: lt9211c: Add bindings
Message-ID: <5ngac5vcgo6duvfalnplagh5f6eqsxbittntmltzer3kj2vkrl@o2fxfiudcj3h>
References: <20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com>
 <df3067e4-5597-4557-b61f-26afb7d731d2@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3067e4-5597-4557-b61f-26afb7d731d2@mailbox.org>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c19bf3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Keg3OKSH5Pxz4YLYaiEA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: cr1XQi90LSV1KrLinvHfmK3NzFmU0RK4
X-Proofpoint-ORIG-GUID: cr1XQi90LSV1KrLinvHfmK3NzFmU0RK4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX0NTosijrR54y
 reR7VA0oqug13eKOggwOoIo5q0WwTrdo5aeH+ZN+IKNgEolSWL0ApaUCkMdIxFiwi06slG+Yjt3
 vi5GlZPf36ZthqzSE8ez7vG91m+cBHKQqD0HpiIrHZU3r8CRAT2eVZKpK4D3qK+7xgdrAsdlvfc
 elxjHH/1Wx19hPxkhPjgc4y11HRWhT86exc6XKW9CMApKNaN8Sph+Xd/MgQn3APg7IbKCNuB+oS
 1oh3bgsYzfKju3x335xy85qlkmNZZ0LtLBXxDzVKldbfKp+C41L2Lt0VK39rJIMNckiIts8i/rH
 AimTnseLAmzzGqKUy0ay1TW2gJeMlzMb3piqeTuGaDY9Uw201eW37cRYAp7bwe6DBTHMXoL04/V
 sZJFKlP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On Wed, Sep 10, 2025 at 12:18:41PM +0200, Marek Vasut wrote:
> On 9/10/25 9:37 AM, Nilesh Laad wrote:
> > From: Yi Zhang <zhanyi@qti.qualcomm.com>
> > 
> > Add bindings for lt9211c.
> > 
> > Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> > Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> > ---
> >   .../bindings/display/bridge/lontium,lt9211c.yaml   | 113 +++++++++++++++++++++
> >   1 file changed, 113 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211c.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211c.yaml
> Can you extend
> Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml instead
> ?
> 
> How does this chip differ from lt9211 ?

And more importantly, do we need a separate driver for the chip or can
it be handled by the existing one?


-- 
With best wishes
Dmitry

