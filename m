Return-Path: <linux-kernel+bounces-766167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498D0B24323
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157A97B4254
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31082D9EC5;
	Wed, 13 Aug 2025 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLyuCYqE"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433252E11BF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071382; cv=none; b=tsySEdrzKrNie1jOEs/WsYJjOIGDUJZjeNGHIHbtHz+WezoHqOuAiDKxbaTcJ5oTh8qY0qIRygw2WDjlnZ0SboGND6eQa1FfCxkyabOAjAdAiQmKv3TfKcIMzY9lrVDtgi9M26AUUfsZDfON5riXH7+jEd9oG0zIDoIafZ0PMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071382; c=relaxed/simple;
	bh=wfeJn6OXLOSd2GklhvEK2KXBF/te/QhNlLJRLLpT6NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B//oHzYqSM5srjwjZpujAjKunhpnjip3eZct6xHg+MMvhHhYsiNxe/fZ98IrJ77yT9McAqHB6nCWgXQPJzIuDO18/ALo8QZ8Jula42XsBGvfREHeV+EQjm9cknuzJ4gDmzW734FT1wFMe+eXvoo/hJK2P0gcjK26+DSqZj6hzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLyuCYqE; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61bca43dbeaso97761eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755071379; x=1755676179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfeJn6OXLOSd2GklhvEK2KXBF/te/QhNlLJRLLpT6NU=;
        b=XLyuCYqEnk9yF8JdXGunyN+ujw1Fymw1txYThuFHVO2alhysN1K4UCef6XGGbyw5it
         2w0IztDtFaXf65o16a9X5/C6QcWHc/D94mgHCUwA34dngIcBBdYYDnV54lk3yrY6Si7x
         gIewLX3Vp/4GbAGHr/ZjpbHAauw2rtEsgLo7/PNdYPphtnLTjL1YCQiJFlIzHn6ofNsW
         nD76UpLQUHYCKuBeJiR8PSOAuOchc/t5lZ7/SIK75NQw5Fir5TTIkgblpdxglIh/dcZm
         i19+M2atTq0+VCm9ibcrVebj29D6Bute5K5CHRYwwqLlty+2MyY5WNCJ0vWDrPpSnkAv
         mkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071379; x=1755676179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfeJn6OXLOSd2GklhvEK2KXBF/te/QhNlLJRLLpT6NU=;
        b=KJCqGb6EQqUvKGPEhx4ReldmZbL9Z8gJ/RV9IZ5v7hakvSsVG4ogMTg/DAnHQah16a
         kTn9JMZzLjXUCn0X4f8q2MeL7fUptV1GDDKo/BERgWFtgYK8BuSNPV7RYcb00qadPBjS
         lXMpWT/aV98BFOc57U0XlTqYoJjdR4dMKzQNYc/3eE4P8al2mOIh5zBYl4z8knt23ufg
         J79UiGbtOUwLY4J9JYm0VGvaeI9sbJoVzCO7XdK53p8RVf5stHDnleYgKXHNJVAg6xJw
         Zv1ajGSMTXJe96llVFPaGIGy0PqXrSUA+8St6zvZ5XUavw6L2rTMMAeviQK9qpEl2mvr
         1/1g==
X-Forwarded-Encrypted: i=1; AJvYcCVh8naCdqqNg3xZfMvy7vGViESeGIDB6h8F76j0U9jQXEHI9IpBwpt4hDBubZYc6PPUaVMnuETApWKtl7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVa21ysdHqr/c7LEBO02TNEPV+sY3qQM0LFip+wpN1fcKOv+gJ
	9d5G4BJKzMzNujFtwBs/2uPdKom0o4VAgNYZ1TA5qPjrtcgMEr7dw6F9T13Ck5jBM7Td5URw5w2
	WGip+pTwWSkpj9Bmb4/k+iBP7JhJUVx7T7oa1MSiWB4sC+gkCGgx503A=
X-Gm-Gg: ASbGncuBh4gELB9MsGltL0o3lKAR8F9OVSHgatD4gTJRbTMQ70wnYsUo0AN6gkglBUF
	keSDZNFgp0Pu4v6nDNRJpppsOmWQoyRgmWZ0PntksqqZL0WAzShv5I5bv09VwLyFsNCMxuV0KIn
	9Bp9OUCsNCFGbCVHPmJ79B+dwOVG0+kS2XI7yYNiJ6lNEfezWtR8TAMW+dQlbVw/hbvvx0YOJ6d
	6XsZaM7CrQtNYsCHrU=
X-Google-Smtp-Source: AGHT+IFAfPPXVnV/fIsv8KnI8b8Bl+IOsf+U5t0pmvRJM0gZ8xG3AukFt3DXdXVb9aF/gWZVqDSUuTyRuSP2uDtgU3s=
X-Received: by 2002:a05:6820:1ac1:b0:619:a6c0:b4b with SMTP id
 006d021491bc7-61bc758538amr1013523eaf.5.1755071379266; Wed, 13 Aug 2025
 00:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 13 Aug 2025 09:49:27 +0200
X-Gm-Features: Ac12FXyfvHrDtrackOzZC99WcBb71C_WC3_DT2d5Ppi_3YWKQtwtthH808vWulI
Message-ID: <CAHUa44FJ9iRMyDHffRBwgxxX27vTwsAwNiCCEGQ8fMQPZS_D+g@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amir,

On Wed, Aug 13, 2025 at 2:37=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> This patch series introduces a Trusted Execution Environment (TEE)
> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> and services to run securely. It uses an object-based interface, where
> each service is an object with sets of operations. Clients can invoke
> these operations on objects, which can generate results, including other
> objects. For example, an object can load a TA and return another object
> that represents the loaded TA, allowing access to its services.
>

There are some build errors/warnings for arm and x86_64, see
https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/jens/plans/31DmCOn1pF=
2JGVDk3otBOXOL6kV

Thanks,
Jens

