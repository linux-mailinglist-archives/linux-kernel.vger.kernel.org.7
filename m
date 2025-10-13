Return-Path: <linux-kernel+bounces-851301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF9BD6109
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ABA401DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACE3081B8;
	Mon, 13 Oct 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VS+s4O94"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92D2E36F3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386906; cv=none; b=LiUn3mP5pMy8Yi0P7z7rNvNfvsFeBtZJCDHnfdABE8swH0Mb56/XOF7BKtbBopQAJapTaiYFBz9I9Zz2UrQMNbBSUSafJCd1rK7ASZ14WWpYT6jZLRjfBBZ0wc64ukidXkPKkXEft50Wt9E/avwMuNb8vsVrj+TJnqnwWM9gHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386906; c=relaxed/simple;
	bh=OPlABqwzLaPodfRRLAnhDx6XJmnrg5s/0t49tmLODaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0e2vE1OoTiWEmlvmhgN508nysoYN7aNqNkhyUNgGPQcSYiKcGzjmKAIavHMYUyVPzawIcS/rD6R9zz5PF1RclsrdONv1GIJWDruYqM0hDycojb9Sbb3PT3jp1BZL6VTdqk1MZeAdTkT2GvoXDsLdZxEFatOY0SqF4XhKpf43ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VS+s4O94; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDoW1021731
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mJ4RcD6MPZiKYcvMSEcaW4l9YhL0RV3NoM0vOj+TUVE=; b=VS+s4O94kq/XbEsf
	pizSfxkl7OYxoZidEhgcwOIpSn6IMDdSA2DRlZkNTSYdl+l2qRd4wD2cHZsuWfbO
	bJYWHXExERqrXm7wXCMbCwA54zlWnS+BcGpz6MFw1WXMOVCX6hyGM4nsa9DxWT3u
	u3I97KSTRHDUaD9tlkRRx7TnEYeIc76JaNSODiGGuzRfcvVVdPEL7mT/7J3T89xr
	fDIarCSDaXNSZbZu3qL9x3+1UePFY/ThEjNMLkhtQSLAOdOQSwywI+78FXtX4AgA
	50lgEDipk3oGCw80uAUokyPlBxvg1c3cWYRdbkzm8E599XcmSfUXfcMqoJT56XuW
	tbXV3g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0bx0sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:21:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88375756116so465216485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760386901; x=1760991701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ4RcD6MPZiKYcvMSEcaW4l9YhL0RV3NoM0vOj+TUVE=;
        b=HO3QvcPsqROI6QDqsCz8pp+Pkk2U0+bAWV0C12HbbrHYNCxFvqYJhkPu8Dh7MXoBox
         pgkf4ti2zwjvGW7hLYMwhCe0OQBDYR87xRjBnn1+JClrWzZT9yMsLMY6VT2iyELHl/En
         SNMWmJ08/E51pdJoM9Bbj4TDtgzLHjzbTJLizq3HJeKlNm2ypcVvROUhLR0stmjFoJVU
         ZY3W2wqnRzJScv4faGW4Rlw2zXiqrn3i1ooA5VhGGMozAo+ZpU03gRMPODPjvYycjyI1
         y5BuyNK+YfP2T6Aj0Nbx2Rhz2IXD7w46f/MNEg2hwYt1COATC+SJ6UXMRmV0hbkrPHh5
         suGg==
X-Forwarded-Encrypted: i=1; AJvYcCV8dKLLSNrWfh6ekbz3szXJDihP+RZLoo6hz0zehRshLisImytju5qfUnRyT9xh6jQ42QT4KcKXQJU321U=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOS/GU/8qa/Ws0iqzZtdfLOlaOrCjiahKUQAOswv8an3NLQDt
	mmQZ3zceegxmCrB5idzBNh7+14iWWAzZd3mn3qxYkIo47Ecjw46dwIvhfpXjfbG1SDbuF4HTVx5
	gwftQuhGU/pJrOiYHrdHLhoUyWrDaxzTM2ktsqb9CHBDm00tlTEMcbS6HhBzxnBe7EpY=
X-Gm-Gg: ASbGnctP5nn/8oylEGQhjEns0yRgH2KTZVttm/GVVBcYo0TGrlkm6OygeyFuQMjstJD
	XQf09nmobaiG5m4vT8qCgOsgvZIARKAg6NJLtbuoCRNV3n/Piv4gCRdr3rgriDu4iX3xpiNFHcm
	KAhDheWL8ScfK0+V/f97dExQvxtbjbIQqeOVufvWt0KAorwPrS2dlfdC/Fno3nG9HU11fgBQ/7T
	RajChliFvRlohRHFJVjsgaeEweJJijbUdkystpyU4oiNXhP7AK5i3UicCi3DJYNAqWwVrOG6TlE
	FNKDOv23bbFJc5oOYMiqynMVrFHY4XhSe3xbUVUdAxeordn2bp6WgbLXQHY7hjLr4aay8vribqK
	Asy2Yw77xSz2ybj63aMRG7GbNIMmEOKZXM4bpTr925knbCYBqYBTySITuJTlRC0Ewp+KZntuu9M
	EmCCCth9qy8LgHdA==
X-Received: by 2002:a05:620a:199b:b0:80f:2813:59dc with SMTP id af79cd13be357-88351de7416mr3153448985a.3.1760386901047;
        Mon, 13 Oct 2025 13:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/z/7lOJkqWBEOhjCXS+YrAq8drXSpYYmNd19CD2+9J0KPLEiTcxk0vcY8yHb76CEcLaTfmg==
X-Received: by 2002:a05:620a:199b:b0:80f:2813:59dc with SMTP id af79cd13be357-88351de7416mr3153446885a.3.1760386900632;
        Mon, 13 Oct 2025 13:21:40 -0700 (PDT)
Received: from ?IPV6:2001:14bb:a3:45ca:256e:fa61:5020:8e5? (2001-14bb-a3-45ca-256e-fa61-5020-8e5.rev.dnainternet.fi. [2001:14bb:a3:45ca:256e:fa61:5020:8e5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59092ed98d9sm3637387e87.24.2025.10.13.13.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 13:21:39 -0700 (PDT)
Message-ID: <c4e1cb13-1bb1-452b-8214-aaf52ae57a3f@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 23:21:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] usb: typec: cros_ec_ucsi: Load driver from OF and
 ACPI definitions
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org,
        robh@kernel.org, bleung@chromium.org, heikki.krogerus@linux.intel.com,
        ukaszb@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251009010312.2203812-1-jthies@google.com>
 <20251009010312.2203812-3-jthies@google.com>
 <alnlmxbcv3ivhh7iolfqsurhknnm2o6i6waxq7kuhmzcbeljr5@a4wy3prshu3c>
 <CAMFSARdzoZrv4oXxVAYRcZJgxdLcrTMVAVGa=D8H=9c1vZ0zKQ@mail.gmail.com>
 <fciyxaedvyqeppldl26rsy7hogoi2zks6tq6m2yu5xerfjxo3g@u6vzsiicv5ke>
 <CAMFSARc7ySH4VhGbwd+CXXC9845NUkf-RE4gKeTW8D_9zNY--g@mail.gmail.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <CAMFSARc7ySH4VhGbwd+CXXC9845NUkf-RE4gKeTW8D_9zNY--g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JONe3Fmgb8fTGUXw5B_2FvBG9oV_25AI
X-Proofpoint-ORIG-GUID: JONe3Fmgb8fTGUXw5B_2FvBG9oV_25AI
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ed5f56 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=oOrn3VzuZvLnv9Y8q_0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXy0W8fscpe/HQ
 lyUfq5q+ZSrLtgd6vWpTKgfu97jWxn47EY0XpL9l6RjFIUA2q2LUrsLieZq18SmpapBZDm+5boN
 xSmnKSatwjCyaDCXtwoDqeeiU43pExT7WuYZL3hIz9LsIdlIOGuVkO8BgFUFaPXvVNX/iEdblGz
 GRFOb0RrWbfRjZcS7+86GwLtUig+VYwxYHan+iy3yBtssiMavnoJqs4e8inuIvg7Rlu1Pithpxj
 A9ITC9u/cmIwaiC8lfDS+psJJiA1iZj2OkM2acCqBxOupik14f0jCLQZBroisZoSiFUgHO1M3YJ
 UahH4p1uNi+f4dBhzHyPp9TYOI8aU6L8xIFh3aYGK7PIkzskaogyNKqGPMmxxZ2octx15M+Kicu
 D99uibRD2d8NbKuACb60lRzaYEUg0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On 13/10/2025 22:49, Jameson Thies wrote:
>> IIRC, MFD devices support binding subdevices to the OF nodes. Do you
>> plan to use it? Could you possibly point out the example DTs?
> 
> I'm not planning to add this, we want to move away from using the
> cros_ec_dev mfd to load cros_ec_ucsi. On upcoming devices using
> cros_ec_ucsi will just be loaded based on ACPI/DT. Regarding example
> DTs, I'll point this out in the comment.


Ack, thanks for the explanation. It might be a good idea to add 
something similar to the commit message.


-- 
With best wishes
Dmitry

