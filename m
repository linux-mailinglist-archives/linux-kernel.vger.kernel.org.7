Return-Path: <linux-kernel+bounces-868455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE1C0546C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FE1401650
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDBD3081D9;
	Fri, 24 Oct 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIPDBXJu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B652307AEA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296659; cv=none; b=bbNd+nVqwAqPivc+IGebAB+eoxGQxg0NKdx4wBYDw5UEH91nkugZNJMnY3hje4CoDNATvw5wPbXSNKrF86RzJR98iSGFVQIZz8SRwM/1E2Vq+J+A6rsldfpBTHapwSD2VBIY//SvIF9o1Cs8t0qmR548DHsenmHAviumy21SW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296659; c=relaxed/simple;
	bh=g0gHpOAw3zIMj/1wPF3opcMcNJQ2q+c7c2Rj1F54Z2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9htbb95P7t35UpVbYhLckLxsZS6u3BK6xIDu8yVkSWbQCJoWJZfKvvhMQ1r+ZU7OU+KDS0fCEuchg9YxvI9JAHCY4AICu5oqUVLZMyIuWxE/+X9EQMSgI45CWCi9oQX0QLWsBkuWr2Jd+ePO5xr6J/knCYmTiQdoS9mwNNwpf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IIPDBXJu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FLJb020355
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0gHpOAw3zIMj/1wPF3opcMcNJQ2q+c7c2Rj1F54Z2o=; b=IIPDBXJuu4Wv4fTO
	BP0/CSW3yBaanAXa1ednNtDx193YunyIBOTP20xwJDrvYpfEVnRs8KRkyOsddfS6
	iPjv5ZgBFQKhxDAYe/knDFL4S2vx5eMxfpU3lLYEolUl9WIjTvgcey4iBHYz6Cqr
	PL6NXQdHKX9Tpcy4thmetomie/ra7ok2ckj9hS4g6stKsLilRJ8Unzpeoj7B9K1c
	V9YNoeNvO65iEcsRnZTq90Jas7nIZBHA+AyhJ5r+1ruDywoCvvmTfJhJBnsTcxIt
	yICX+/CC6H5gjaLlsI1zBVlmH//qMi73kUmhQNxDg3CVwR284C4ps9GJ6bd455s7
	+WOH1w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0segf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:04:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88d842aa73aso634886185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761296654; x=1761901454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0gHpOAw3zIMj/1wPF3opcMcNJQ2q+c7c2Rj1F54Z2o=;
        b=QzyMy42fw5yXwuj+ku2XIJlCM48y0AS5mwPkGdKUq47CPOKRvWDWbP0qNiaQBhNkUh
         ErOme6sYDKMKNJN0EUQBut4RZ8cujLzyofxgF0uwZzkLJ2d2xIvlQcpsicIMwwcG2Zel
         zkgwt52awUshgDkhrMOgjcIlfDOQl7DN7mD6q3Odvw2wVDLEXHlytxgKrWy1JCntmf9+
         6oHRaXPNbDuFRGvkKkY1/qrYqr+LgCTyaPTkrvrtjHeQid7CUWt6wiS18Kyxf7sOM8Me
         vRhEJIpUiaAPvoenAkyXZDPsf0o21scbK65xRbE1+FiKBKyHiADdDvOfVrft2vX8iGMZ
         DMiw==
X-Forwarded-Encrypted: i=1; AJvYcCV5Q0jvSnQ9rS+MuLdWyJMKvyynJTxXg36hckD3ryXerPHgByrL+m+JhWa+lM5YNSLUmVGn6f1K5Fwk6jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2x6loVwNxTTk8DDW7T8yTd+OZUJ95Q5amgnU6qdyxNBYtOAM
	SKmS5sqQbOpnovEaXdxV96pc/uU2HqLvgtGuVyA6ozIg9z0XcUPAIO40AoyDVC9WRaUeeamqe+I
	qSJCunGKh65FCBs5Zsh32TF8v98r1kVAf8ppBpbS3fwqQ+qTdBWSX9XpzcI4pRadbcRL8cBXaLY
	NGY3dPx3g8Y8gqMOkxvnL3ccKL+7vyk0T+TBTRTHxYvA==
X-Gm-Gg: ASbGnctZ9/3aC0ZmDJKX46OggRjQsKRHDTppbIFuKO6Cb0az4rJ6dUTBG6DwwgQh1g1
	VsPtJ8NHBV78JPpoes8T6NwGgh3MAMYPE+jmlm1c58uImjRNk7we7IEg9SWsbD0xS3EUazR6q6w
	J3lWt+4mYNye3m0yARocLHy/xny4AZzk+XyyaafRfTlCHgBbo5wGD2LckolTu0QKal522XjHjdg
	dDJMfAqm/7VzZ4H1iAvlLk/Ym3q6lSUzB/YD08T1H67Cg==
X-Received: by 2002:a05:620a:701b:b0:85d:3c32:c404 with SMTP id af79cd13be357-89070cd842cmr3029015485a.85.1761296653944;
        Fri, 24 Oct 2025 02:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcH7X9I3oq3A8xpwU4zFj0woURu/t1UEGWZ4WrgfA2Vy8Iz3Rekx75D5h0egBppJT6eu7llttNgC/cYYRxzYQ=
X-Received: by 2002:a05:620a:701b:b0:85d:3c32:c404 with SMTP id
 af79cd13be357-89070cd842cmr3029010485a.85.1761296653367; Fri, 24 Oct 2025
 02:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com>
 <20251023-add-support-for-camss-on-kaanapali-v3-1-02abc9a107bf@oss.qualcomm.com>
In-Reply-To: <20251023-add-support-for-camss-on-kaanapali-v3-1-02abc9a107bf@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 11:04:02 +0200
X-Gm-Features: AS18NWBkyZO4ADCwbuPSpZ8_0D23U3UYy4lbimK41M10tmzNwaNW7w3WqyAgoBI
Message-ID: <CAFEp6-06bubGxeNqf0rK7Oe3+YDS7f0_wHPCDTBnXmT7taw7Fw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali compatible
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX287BFUb0bcJY
 Vv+UHyBPDCX4lD1s6CRx9m6DjfGZ8jDSBNeP+uU9At0tMc6bw6p1Ah1GPe7dxaaFKcbxCiKXVy7
 cPUzISqfUNd+zlkdiGYSRqMnz4yYMfEc9pIAx3JeRD1cZ6dvTWWkb/keTI8eOnvJqFvIP3yjrhy
 B+MBy6LCKOYm4kePAcrInneXC2z2XoPT7HRIFMx10f2g1T7+DGf7zkaWBIDzyWvaNRXppYA/Lqp
 iy+W0cxnJ/J7W2Ra3/G+1JYDPI8NG08X1bGNf8owiB5CCWzz7ldPb2ijYoHDv0l2LG7TLT1JA09
 CWDI6IiIcs9zqNyBkI7pVQ6aGNIgWWE23MbCsQQL6GmChnfjwhIvmh9d+V2bUfKVcyxT4rc4TgK
 CpLSK0WPPIHmVCrF1LhZzWDxF0WxLA==
X-Proofpoint-ORIG-GUID: WmRju3-1TKiFtnxZrZqO3VASON3cVcfh
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fb410e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XIB30I8Fq4NfyXnsoAUA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: WmRju3-1TKiFtnxZrZqO3VASON3cVcfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On Thu, Oct 23, 2025 at 11:14=E2=80=AFAM Hangxiang Ma
<hangxiang.ma@oss.qualcomm.com> wrote:
>
> Add Kaanapali compatible consistent with CAMSS CCI interfaces.
>
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

