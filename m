Return-Path: <linux-kernel+bounces-838981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A7BB0900
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB5C4A05B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E682FC028;
	Wed,  1 Oct 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n+WQA5md"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D872FBE14
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326504; cv=none; b=uKBdT2cmhL4Tw5x05IABjONw3vRqnWHNGHKqYRjsVC8n9w8QX9uMOCwli7Gq/69c2SOVjYLi8s3CADmwDmcsgt9ms3K40ycecv0J6y8dkEa0M5rN6koWqGMIfAKtNesV/yQ6UbWFYX1NN3BncVLq8rlryNpw75ZNkkxZTSIkxAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326504; c=relaxed/simple;
	bh=fp3v57qBuLEjj+J/x49VyV5FvxQeWmOVI+OPPyz4H7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJvfxq26y+joOBFurVQDl76tZH6NtfYKTcrnEnAz/m/KxePvq//vC4K3ALSWcqET3cuoCo0PeK4nE+N1KeFwkixtDrgj+BayU7TegCmwF9Z4bdesKDvv43RdQKHvsRw+DbLeJUoQuski5tGAfH+DtzBKaqLK8P719Q4l6THJ0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+WQA5md; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918wM6N024443
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 13:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fp3v57qBuLEjj+J/x49VyV5FvxQeWmOVI+OPPyz4H7U=; b=n+WQA5md74ejqI22
	weutqrqOSh8bHER/YgP7ORqarjnx1x7Q6u2QU+m0t3Lgnn8Hr547sOFtCtOpdVdo
	VmzJNle/CIt6lSESTN5+mnCqR9WmQ6qEVGXOSctw7w9fDABsyH5X5YlBy/qWGQ1Q
	wFFvroYetQDlqWXwFB7GeRHuK8p9JNqCZkvr0znuzjODxrwLfd5D735ii9598kQe
	bChngM/JygPhnrKHpyQZUoSHS2Q8TeJQfkVvVvVcRn5i4g7NhtRgXbf/XQTBTQBo
	WUxTXtxv1872zW77Fjh3QFjVsXR+UInS1z7367YDXPEF0hlFF5wmi41WBwq7m0e9
	QD+cbw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n5462-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 13:48:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b550fab38e9so5055900a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326500; x=1759931300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp3v57qBuLEjj+J/x49VyV5FvxQeWmOVI+OPPyz4H7U=;
        b=LIbdto1EiCQt4KiorFR8LymxrMxrVrTp1tQNbMgKdIg4LJWr8LKhVPaLWnw1gaP2Q8
         ZrpgsiJ8v0PSqnaAOE6gOI53aoVtO9jMr0wzF+WwyHBJ46gQeIdTkRgChkkvSUBRAsHq
         iW8p2HaU/tqzL4FgSO/LRC/oG4oa1DxOtaQW+ORLELS4oCPaetp/xrmIPju/IyKNaDgL
         b6HTSzYBK98jljGvkFMNLUAwHOzWFBvJBelY07BtjLXbJ/UbQi6jC8/O684+XkYKsYc3
         30gXJU0+Gu1flE8cgO5LvKYhq26AhAQ24dfdsW4ZUORNGEERbaarJlr8JcYuyGtZLbR0
         DBHw==
X-Forwarded-Encrypted: i=1; AJvYcCVBBOm+9+d79UzVbHW2F1KHU+Pa+7FZ5jQV4x3+/8mAFFTnxX7fyvzX0w0UUm6Dzj3ywyb5iC7tdUXLdAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4dY3fXdteHPs9MkkQqRVrE1WydS3H4Xx7ehs6WvWoQhvNV+X
	laJjRecAnCzwc1BvM7QW7C90nK/vmPF/UlhPnPOLC/nV/aU/4G11Rob5n+cymJ35/Ay5RHLa5OD
	j5ui90irFZPj1qjhPm2S5oroiGw8EfDKpaqJuJyC64X3cIv3RqcyANl0mto9SjU91QPyhqM/DEh
	WNUotC0TrhSzcqR6K/Z2zZ7MjRFRnhJAFxj2U262a/YQ==
X-Gm-Gg: ASbGnctW8++NyE+OTVwysIxTbOPCbfxUEFgcXye3AoaU4YpMvG0kHUsnJVagZRlPZeW
	AXPgK9geYdAkStkBhe/yrgSJNzJMlWZNvHiUVUj+c7agDkp1ygZosi5QeYzKTto1znbaZUFjoS9
	kx3j62lfOjgjSjocQYIVvWhjC/fZkIBvmKQA7lJ8bWMiuW0jhcTyxXHL9k3v0=
X-Received: by 2002:a17:90b:17cf:b0:32b:d183:facf with SMTP id 98e67ed59e1d1-339a6f66d48mr3342752a91.28.1759326500230;
        Wed, 01 Oct 2025 06:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGEoqW8Gg2lgK86qxAwu+nfXe3G5OJ2NfYflPendMDk34x4Ydw1dWzOJ1aSl3n8ThNvGAbpRjrnFNtVgBSIzw=
X-Received: by 2002:a17:90b:17cf:b0:32b:d183:facf with SMTP id
 98e67ed59e1d1-339a6f66d48mr3342716a91.28.1759326499769; Wed, 01 Oct 2025
 06:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-16-24b601bbecc0@oss.qualcomm.com> <cd91e7f2-72bf-48f2-891e-4e6cd36b1e24@oss.qualcomm.com>
In-Reply-To: <cd91e7f2-72bf-48f2-891e-4e6cd36b1e24@oss.qualcomm.com>
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 19:18:07 +0530
X-Gm-Features: AS18NWBhYwOecFTI7PUFOxMVtEHAFfH7cHQ1cCOcmiaMyYqMB14HKhsIE_TTwpI
Message-ID: <CADhhZXau4EPEvf6Ngo+p4Jv=NPF6TYxcWtt2tV+MyrmOxp7OOQ@mail.gmail.com>
Subject: Re: [PATCH 16/24] arm64: boot: dts: glymur-crd: Add Volume down/up
 keys support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Wt63puCEERcDTitr7Fb69Qou6rw2C9T-
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68dd3125 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=EUspDBNiAAAA:8 a=QrdbydHfbqU_mCGI0rsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Wt63puCEERcDTitr7Fb69Qou6rw2C9T-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX/0+cImCUvgxY
 tvreNB4YcweJOinAE7eeZcqK2gNPhl3/sT2I53yRk6MbhLAgsbuUYkvn4c25xwPTAKEmFB00CgP
 1IQODAveiuAp6EbpFJpqOtReNAWRQ7ZN8KxZ8EPpVF95LQFC8B50l3VXQKqOdmn4H4Fk1uGSKhq
 uXad88sB7rRSnJX7yys9D6HvRu54kVebaZVvgb5qKaJ8t6JOsCUNxldRgf02trZOGMk0n83TkJP
 bQHTK/4rl/S1JXjRCa/XlW2gX8bDu3/E/J94C6cBu9DyjHnNumKCpyACuIHm8VGQX0J0XmOr/RC
 F452UqIF4yhkUjpe78wcOulADSUBGVfMkk4mBNQd89z7BPInm9GO7ORDX8Vdp+by9YlpBUVxnoW
 w44mfOI4ODKIYmb/sFpJl0pB9Alo7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

Hi Konrad,

On Thu, Sep 25, 2025 at 4:46=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/25/25 8:32 AM, Pankaj Patil wrote:
> > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> >
> > Add Volume Down/Up keys for Glymur CRD.
>
> Does the CRD have these physical keys, or are they routed to the
> debug board?

Yes, it seems to be routed only over the debug board.
The keyboard too has the vol+ key, but seems no direct key having
vol+/gpio6 on CRD.
(sorry should this patch be dropped then for this reason i guess?)

>
> Konrad

Regards,
Kamal

