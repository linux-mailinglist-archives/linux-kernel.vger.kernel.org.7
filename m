Return-Path: <linux-kernel+bounces-883277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC069C2CE87
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A521887164
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1D30CDA8;
	Mon,  3 Nov 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="znpocFcy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D51A9F8D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184819; cv=none; b=b9xWd9LfU5j/unbRDGlA8jv380u7dW2UPMwToIhLmUi5ek8DzSy2z9U+qT/X4bB9d8SJRJdJ43Jb6cMcMmmaNiiuY7vl9o58vW/6LdyHNbBk0nnSDPTpMFDo2ymZqbzlhWMt4r8D+G9uB/+VFOPzVV7uXUFcJCxW6hTlcwJMdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184819; c=relaxed/simple;
	bh=I9fyilSv+BBiKKVMx658AqQIHyDJsv4UF1qfFI6oBJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoO0sJ1KlWVN2qy68c8tf6ZFvFwP1GmFFiX0HWar9XkU9Hok0VF78gK7kiqxrjh4hWsKwInaU/ZeyWHaDedWHqlKQIjQ++TLPv17QAang7DpuUArebwqHLRBEA3fTRp+8l35OpJi53YVUPRrNem1/Sw7EWhI8kaSx6tezZRfZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=znpocFcy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29599f08202so17137715ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762184816; x=1762789616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2MHtJbnKG4Y1cKxUevHeLcjufmG2/9m4jUTZ+Gv760=;
        b=znpocFcyuowtWU5meTT53VwJTADcNH++p5MYoE88IQGQo9Ck5+1zDLy42Fbiy0gvvF
         ouc85ffFWJo24ZLbW8ay56gUelO5xXyaWlhB4c+7srydPI1Bp6UuMr8YM9+XMF+Sf1vu
         WXcSJpVtiWTufWCgcbbzOX6PgCSLRw4ube7RmD2Ao9VMd0pDk9FsM7JVZUqGoYnPSLVj
         SHNcvl3+RO5X60f+0tft6zny+y8Uvg1tHk/AcqpVqc3TAPWWuMErl7MipX4EsYM5jRUQ
         8Y+bSgNjAibFxnRnrBjvEwl/O3BKzxAUZyJ+Ki2hPWaqD6xtvOstn96o33KeYN6DqE4M
         8s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184816; x=1762789616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2MHtJbnKG4Y1cKxUevHeLcjufmG2/9m4jUTZ+Gv760=;
        b=rAp5QuIECNeU5hTTppZakQ9KffDwDSE+Px5kxPKov2BM5XwfkT4gvP2deN61gkdSOW
         bXyyB8DehGVHvtSwxp6uaPiyYPgKcFxDxUvBEYMNdYw7CW9w6T3Q2eRoFjprqQvprFfj
         crQCXJqpWOqozJCR2a3cvOuuqbzxnWvhznpkF3qNp4DqyRYKjvuZYVlE9LNecGqrQ3G+
         U2e16yCJp0+eK7uzSroaP+qKL8J0NMaNDPrm/UJS7+zn+x1xa2pX4s5KODZdBW33JmMt
         gL269fsTbF7zRNYndhtr3bTU/DkCTKLxfUXHcwmZUqYFX9xCC+gWkgJ6RMheGGSKGGPW
         Hi0A==
X-Forwarded-Encrypted: i=1; AJvYcCW6qHhEsibhm192b1VDkXJCg+PMr7bS4KnNMWObslEo38wUnKEg/ZwItN/FCyNXBylTgiWes1zhQODaE/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08bI600WtVkaoXc0JI9ZD32QHbYMOSFO9FSZhkIPpphqt8xJi
	nRSyYahyDjTHbmE/DIhfATObeG7O1/P02o12/+7QslvFO6g86IRVASP0gwx+ZZ8/pouBY5EqqHo
	ip5XBKhqMu3ft14e6W2UQzClD2yGj/i8BQLlCh0Vyv6f+qNGsbki0Quq4mA==
X-Gm-Gg: ASbGnctnKrkAccCCesDB4y8UL0iKgUqoTIupgOFh9IbfKTXdSI72ze2fr59CiFpyd2j
	rB45W8BWVa5ApCNgf7S/rm4SicG2RiFyzFMU5bdcyYH9l5Ch+cY8u1cEcHtaBzKSNXjsSjcbLbj
	iPCup29OWeC9ipAMqVJuUrJiJKH0h9xV1L0WDQRJTea2QidVnjBlvJt/74fiBwQjUOIDVyqB+Iz
	+DAzti1l00S256L/Uo2ka4tGGugZwqt91Jj77opHTBqLSD9kxz5DOIE2NykACznvpQ3f99bN4Iy
	Ha6rEMBFH9OyhGAYUYdU6C4lglU=
X-Google-Smtp-Source: AGHT+IEHcT4nMnHsVZpNXomSXuk/lGBQbjdeGw2Btvhh4nv0D+IGAkb7LgX6xKGUUqvDu575VUA7gnGnoCi4VeA8JuI=
X-Received: by 2002:a17:902:c40a:b0:295:54cd:d2dc with SMTP id
 d9443c01a7336-29554cdd5eamr138128095ad.16.1762184816049; Mon, 03 Nov 2025
 07:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102-multi_waitq_scm-v8-0-d71ee7b93b62@oss.qualcomm.com> <20251102-multi_waitq_scm-v8-2-d71ee7b93b62@oss.qualcomm.com>
In-Reply-To: <20251102-multi_waitq_scm-v8-2-d71ee7b93b62@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 16:46:37 +0100
X-Gm-Features: AWmQ_bmCR2WVQhkJBwAO950LpEMAQOHLxipl-BASrBXeNuZam9uVHcWhKApvvOA
Message-ID: <CAMRc=Mfh+WQx-vasZed6jWi5nUjg=K+ScVRBMCiFgK397=JbVg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] firmware: qcom_scm: Support multiple waitq contexts
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 9:19=E2=80=AFAM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> From: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
>
> Currently, only a single waitqueue context exists in the driver.
> Multi-waitqueue mechanism is added in firmware to support the case,
> when multiple VMs make SMC calls or single VM making multiple calls on
> same CPU. Enhance the driver to support multiple waitqueue when
> support is present in the firmware.
>
> When VMs make a SMC call, firmware allocates a waitqueue context,
> assuming the SMC call to be a blocking call. The SMC calls that cannot
> acquire resources, while execution in firmware, are returned to sleep
> in the calling VM. When the resource becomes available in the
> firmware, the VM gets notified to wake the sleeping thread and resume
> SMC call. The current qcom_scm driver supports single waitqueue as the
> old firmwares support only single waitqueue with waitqueue id zero.
> Multi-waitqueue mechanism is added in firmware starting SM8650 to
> support the case when multiple VMs make SMC calls or single VM making
> multiple calls on same CPU. To enable this support in qcom_scm driver,
> add support for handling multiple waitqueues. For instance, SM8650
> firmware can allocate two such waitq contexts, so the driver needs to
> implement two waitqueue contexts. For a generalized approach, the
> number of supported waitqueues can be queried from the firmware using
> a SMC call.
>
> Introduce qcom_scm_query_waitq_count to get the number of waitqueue
> contexts supported by the firmware and allocate =E2=80=9CN=E2=80=9D uniqu=
e waitqueue
> contexts with a dynamic sized array where each unique wq_ctx is
> associated with a struct completion variable for easy lookup. Older
> targets which support only a single waitqueue, may return an error for
> qcom_scm_query_waitq_count, set the wq_cnt to one for such failures.
>
> Signed-off-by: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.=
com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 75 ++++++++++++++++++++++++++++------=
------
>  1 file changed, 53 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 28979f95e51fbee94b84c1570a4d88a76f72db4e..0b6efa7c2bdc25a3ba152c25d=
5451d1154779ddd 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -47,7 +47,7 @@ struct qcom_scm {
>         struct clk *iface_clk;
>         struct clk *bus_clk;
>         struct icc_path *path;
> -       struct completion waitq_comp;
> +       struct completion *waitq;

Why this change? This makes the name less descriptive if not misleading.

Bartosz

