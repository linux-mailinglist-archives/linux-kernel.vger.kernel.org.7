Return-Path: <linux-kernel+bounces-740980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E92C1B0DDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828E5189053C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D262ECEB8;
	Tue, 22 Jul 2025 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7QRbGpK"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2D1D7E37
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193384; cv=none; b=oRR3cUEoD9A81jopyes+iqdrwKq5lapjx5OCnxRIvUn479eUiYNjrxjXsKXCTnPDhU2FdPjWKXBEl5dDo6mAo6By7m49yfBzKBeUxqrHfdroiKHzptGJZQ4dIcavhQ18y1CKcqtYrC96AXRa803JkBhXu6/Q5eYjKfH6h/A39pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193384; c=relaxed/simple;
	bh=4XRWNH6L4gNhJL4fjOK/VGXKWPQRjU+iw51yGIRXI7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb9zSxIniP8t5SP4QRI0EGlXz4d0U+t9hSzwca7Z9wQupkyfaj1Lo/iiDE2IY71R4MaZcU0iDmJBgliH3f11HEg9H8QqsWALyx3uWnKb4se9joJulCULb3YrZJO6Tg4apNmgOVbjVrGsSGmCgUT/BRsdVh6R/D3KSb/tgqkXFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7QRbGpK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-75ab31c426dso2964732b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753193382; x=1753798182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nYA6BM6RuT7QlZka2P+M+8292j7neabTFGbKg/RuP8A=;
        b=u7QRbGpK/56BVZ8DwvD/zK2Pt6Zht3D56J5V4wgDVnT3X7nosZ9ODdV63CPWA6ephc
         MrZNKNnCrGy12PU3v7DCbtkmSoOVlSzKRuHYqjUHGXBeYAq71KWlmckAXvMXnHZF5MQ9
         gQSRL5vq8NaeVMq2/btL1NMajziBD6LdCYIx1vNIbpElRzrcXxn9JHMa42aijsgtdK7t
         ls6PqnQM4Tn7cUSnMsG3TbPXUjfg0NzxKgDX8GxyWJny2BaTsNwcOgpxN4iNVagbar+X
         8VhOLb0Uh4KHuj4QMHAULhIlmN2lpJdR+2xEwrgeBx8DxF6JISbXAq7zbFxobpKtbLre
         cUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193382; x=1753798182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYA6BM6RuT7QlZka2P+M+8292j7neabTFGbKg/RuP8A=;
        b=VC37cUrRelg/WSbnnD9PZHPtZGehqh+SsupIaQ2M37kJuZnSHz2ne5LiW9MSqJaTMY
         7+NVRLHUyqwt4LK5n1lAwJvgvgoq1RGMXqhsWX821IcWFCuC8AsWuXGbg9hYLPECN4NE
         JEhxOMH3i8v8Ch4jdf0/r+u8Rw3+xr1Z77M49i7Ng+jcBDytjmNFKmYqhrjFZHXGcXvY
         X/h3vI463NftVNfNZedHc8xUA8dtX53W2zR03GHsFYqSU/RJpDoxKUFrXACR7QmwwEky
         8CTIhWgJ4Q1Ra1oKipexM/8yaVlHOH1TrFQsa2J0WFSNpVLH6jKIo0aS52GBZ55sM2Vp
         q6FA==
X-Forwarded-Encrypted: i=1; AJvYcCXYCD/wG/jw4QDQSCVkiR9hpZoFgxurh+kS8MJCctrcolR5VXXTsm5yY/gDdgeHXWUi34FO7vBUSTbYLSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xqXd1qtEMdNUEn2qczXtgtgV7wHlLihjMDoDY4MFtLLb+h9x
	jlgmdsYt/U07yt+8LP3yqd0ZNo8qjTfJIffDMidJfHw4X+WwV0pnKUywAPKszttZ8P8wSmiFQ8i
	KKDdAYNM9S/r0Y0lgsAuRWdLlwTZ8o8IO0fvaUhG23g==
X-Gm-Gg: ASbGnctehF5WCplYbXq7GEbV1DDl93KSgxuTDfNMTK+ZRV/fE+w0y/sUZ3vFxy8BSoN
	c2nEIlxd4q8a6MQJEPpW9XjKFl9vVl0FwVKpa4fIDKl+dqFOu1E3O4+MDLTHpHGPJdDDeZMYNre
	P/Kkb4y4r82MMnAWQkI9No7HKF+He0RFfwoa0PmF5wfK1pff+XdpcP/8vYqnlGiX96akcuBTVVE
	wZ2waxL8gBrEueI5I0=
X-Google-Smtp-Source: AGHT+IGFU4VWxlYJEYbLdchAtv1j2H85pNZPMbrhLD3/A1/ePknqXU8Y1b1MkhV+cBTSRgsa7pHyElQVUGu1ZTiaT3M=
X-Received: by 2002:a05:6a00:3d53:b0:748:3385:a4a with SMTP id
 d2e1a72fcca58-75724e89802mr35964790b3a.23.1753193381756; Tue, 22 Jul 2025
 07:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com> <20250714063109.591-9-jie.gan@oss.qualcomm.com>
In-Reply-To: <20250714063109.591-9-jie.gan@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 22 Jul 2025 15:09:30 +0100
X-Gm-Features: Ac12FXwqHXk4-Uo6jXL4Zzw0JmKbOZ72WWBz7IbZfbByNQJn0Pkpcd6_VysI01c
Message-ID: <CAJ9a7VhLXrdP_CPQPgAYTAGWJfsVUa9SG9Bzv9dLtFzR4nFROg@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 08/10] coresight: tmc: add a switch buffer
 function for byte-cntr
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Mao Jinlong <quic_jinlmao@quicinc.com>, Jie Gan <quic_jiegan@quicinc.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This buffer swap code looks OK in principle. The ETR is stopped,
memory synced and set to be read.
See other comments inline.

On Mon, 14 Jul 2025 at 07:31, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>
> Switching the sysfs_buf when current buffer is full or the timeout is
> triggered and resets rrp and rwp registers after switched the buffer.
> Disable the ETR device if it cannot find an available buffer to switch.
>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 2b73bd8074bb..3e3e1b5e78ca 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1287,6 +1287,58 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>         return ret ? ERR_PTR(ret) : drvdata->sysfs_buf;
>  }
>
> +static bool tmc_byte_cntr_switch_buffer(struct tmc_drvdata *drvdata,
> +                                       struct ctcu_byte_cntr *byte_cntr_data)
> +{

This entire function should be in one of the byte_cntr source files,
not in the main etr files. Please keep byte cntr code separate as far
as possible

> +       struct etr_buf_node *nd, *next, *curr_node, *picked_node;
> +       struct etr_buf *curr_buf = drvdata->sysfs_buf;
> +       bool found_free_buf = false;
> +
> +       if (WARN_ON(!drvdata || !byte_cntr_data))
> +               return found_free_buf;
> +
> +       /* Stop the ETR before we start the switching process */
> +       if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)

Can this function be called if the mode is not CS_MODE_SYSFS?

> +               __tmc_etr_disable_hw(drvdata);
> +
> +       list_for_each_entry_safe(nd, next, &drvdata->etr_buf_list, node) {
> +               /* curr_buf is free for next round */
> +               if (nd->sysfs_buf == curr_buf) {
> +                       nd->is_free = true;
> +                       curr_node = nd;
> +               }
> +
> +               if (!found_free_buf && nd->is_free && nd->sysfs_buf != curr_buf) {
> +                       if (nd->reading)
> +                               continue;
> +
> +                       picked_node = nd;
> +                       found_free_buf = true;
> +               }
> +       }
> +
> +       if (found_free_buf) {
> +               curr_node->reading = true;
> +               curr_node->pos = 0;
> +               drvdata->reading_node = curr_node;
> +               drvdata->sysfs_buf = picked_node->sysfs_buf;
> +               drvdata->etr_buf = picked_node->sysfs_buf;
> +               picked_node->is_free = false;
> +               /* Reset irq_cnt for next etr_buf */
> +               atomic_set(&byte_cntr_data->irq_cnt, 0);
> +               /* Reset rrp and rwp when the system has switched the buffer*/
> +               CS_UNLOCK(drvdata->base);
> +               tmc_write_rrp(drvdata, 0);
> +               tmc_write_rwp(drvdata, 0);

This cannot possibly be correct. RWP / RRP are pointers into the
system memory where the ETR stores data.

> +               CS_LOCK(drvdata->base);
> +               /* Restart the ETR when we find a free buffer */
> +               if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
> +                       __tmc_etr_enable_hw(drvdata);

What happens if the ETR is not restarted? Using __tmc_etr_disable_hw()
is correct for this use case, but if you do not restart then the extra
shutdown that would ordinarily happen in tmc_etr_disable_hw() does not
occur. How is this handled in the rest of the update?

> +       }
> +
> +       return found_free_buf;
> +}
> +
>  static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  {
>         int ret = 0;
> --
> 2.34.1
>

Regards

Mike

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

