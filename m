Return-Path: <linux-kernel+bounces-742290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12875B0EF90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33EC27B1A46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05728C5A5;
	Wed, 23 Jul 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEfu7Q8R"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE228B7E5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265727; cv=none; b=rpodzkwMiF6iQIIGwR5tQ6m1AJAd9nB5YFwFXJmO3otDoKAwt+uWxLZfTKb6ETn833lal9uBg05ZqmipN3tn8zC//bl3ZjdOFq6KHlcMUsqhwTBa9F+sF5m6JXOfEjb8eqMLD2IN7wZ/+o0lLn7h/QGKr/8KKfo0Vjm2C+DYhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265727; c=relaxed/simple;
	bh=bVmnYXcNpbvjM55bFzMCxtV2rB1OTba8n+Ra95I9D4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feg87OV1k8BD3e2HtZl3ond37wAkYDt5yxpTj8IMZ3hrkBmIAfY4VYxKwXjb+hT7rHRCksHRz/ghIexwm/8Ap7H7uztGgQ49l4W0Zp56yu/oCnEZ1TqqgF8/EZ920ED7BpK/DiIW0LyLXsv1ITTSvg6rX6dWnQFcpt/KququUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TEfu7Q8R; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-710fd2d0372so6377887b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753265725; x=1753870525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=keXN2baWTCHNPA/RphADFpl2yUS3e/Xrt6QyChUGi2o=;
        b=TEfu7Q8RvH0zoibNQleHT+ygvWvBbCNx1xUDEkeSzF68IvehmMfFa28zAX7LIqrx9k
         YebcXIKlkvbjEtvZhOiaEAl8IM35d+5ZBMvkksUwKWjR6KGWeMmsi3v6kAFREU7ZOW1v
         qKGy6d5iaBX9aW1pCPKV3NGdesIrS1lhduuv9INHJgtZ5R/WFIdvuOvxtFaez5Twhzpn
         21YzpQ0lebX828JVevt/kYGmM2vEwFELD25Lez+otiA2lCVcAMCKFwu1iAU4z+jMllm5
         JPV2wxw1/K1YjqFh+aJS1R1Ra4ytxCfYpR6ixAg5yjKNyjLqa6QPBiGSA/u9IB63NcjS
         ekpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265725; x=1753870525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keXN2baWTCHNPA/RphADFpl2yUS3e/Xrt6QyChUGi2o=;
        b=M8PGk9eo3y/piTPCPZfG2INEv5ywmIaNTFGVNYMOfezkRWv6TuZkZDngA8Bm7vWTi4
         kJlpsGxGO/Cm1eGstjDc1Ehxab/mdsT20pZcqxMjRsPgJK8HsCuatLBziEWR+f5DKXBR
         lEjPHyPVJvaXxfleu3SJe+9FZeDiSM4ZT4/EKBZpnKLi6pw4BOnsVi0r3JzsJvL2JWo/
         RJq5MevoF87k00g3Xiez2sm96/QFPUVt2HWtlvFOMl7MsXDMYlPVl+/dDGd7wJcjz4lE
         eAkQmLyj8QtgBB/f+5uQm3MBEpPmTZ/rquPLrJHEkdAdA4pgn8aSTIF/YQ29jWsHJFUV
         8n1g==
X-Forwarded-Encrypted: i=1; AJvYcCUA9yhKxHdRCJPPN7wx/lpWa6GP+DyWJALYWkRiuWGPjJgCOelaoF4bhVCo/uoM344ThCnJ+LJn5zwEOuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2WDpztv1KmOF8EbQdVIE69Lt9Es5H5IwOBSjTlAHIFN5Yhh7
	k5+gAcGceDormgBteBx2EoLadjeMbjFlO7Y/5H4DdbSabHCZveZZz4klSL6j7qpNbDhhQTX0csc
	cWC0BMlXCDx+MJ/DKSImvxFAa/E7Zoi25Jj59uEZ9dg==
X-Gm-Gg: ASbGncvNCFXlid0QJSPIROh1l5OjZztFxRqhiVibAvridWjiL8uzlq2upwrosOAPBpv
	g0/Q3yCUf62sWbLgSSBkdjeTS8AETdTayPETvgq+E33s7xxo/S5HY0BauCcnb8Gi113WpKuSJtg
	i1AqxJMpB8NTrST3n3oS3uKUjJ8eRguYP7dPbdBSaxjuPQRR0QzL08yyVZ1dJZv0IyHy+yaNd+8
	Eb2kM+gbSDZjje43vG8nS4P7mss5jvrewygVd0Oiw==
X-Google-Smtp-Source: AGHT+IHLwbDU+l6YFqXq+ZhOTIt3EsG2LfI9gk0yhItHuQJhFHjnzjhqd5q6F+kb9kyqNAhw6q+3Ha0RnPN1bk1gZLw=
X-Received: by 2002:a05:690c:3704:b0:70e:61b:afed with SMTP id
 00721157ae682-719b4b61bdfmr28060077b3.7.1753265724935; Wed, 23 Jul 2025
 03:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Jul 2025 12:14:49 +0200
X-Gm-Features: Ac12FXwdNShN-_Kv2LQC7hceFT9DkPQKcUCw0HK3tS9vOljvQ7MzDNxnuXt3sRs
Message-ID: <CAPDyKFovVuZgQNvRUomxd+P=poy_7xSWuCCwyTzhy88mJtcyqA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add support for RPMHPD on Glymur SoC
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	konrad.dybcio@oss.qualcomm.com, quic_tingguoc@quicinc.com, 
	quic_rjendra@quicinc.com, kamal.wadhwa@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 17:28, Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:
>
> Add support for RPMHPD bindings and driver for the Qualcomm Glymur SoC
>
> Kamal Wadhwa (2):
>   dt-bindings: power: rpmpd: Add Glymur power domains
>   pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                | 26 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe

