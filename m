Return-Path: <linux-kernel+bounces-725563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D51B000CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB107188B13A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79B248F7D;
	Thu, 10 Jul 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZu7XHvf"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6242246795
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148145; cv=none; b=PXAf2Ym7iZoDG8jZzJ9ZGkzZq3tzLLJP4F1fnwU867ZPVeNiASaEctLdZlXDfajzwCIyUxUJ2PnFg0ex3jdOJW120VUp0QNuodUg3zMiJwRngW7f1kH1692z2N4laAEUU0tRBaijGUVPqPHoCaxbdWed+epTe5XQ5MGGfn8S2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148145; c=relaxed/simple;
	bh=hfp5GggT5BPTmOuuvHJ26+GWfAFu72C8T56RKYZBYwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t73htIch0on56FiCzgljN6tpCZqXDfjKEvfo0jpw7yRSXlGPI07+VNvsK2OKPxkIIaGef2vhOstRtAbAw8WGetoq3x1O/YCvIDneKEWsvewz/ith4h4+P0GDJHykE6IEug2ROVWqJroQPA6X9Ne2w4qYMq1vY2lDPAx1bHVeF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DZu7XHvf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-716ee8947cdso9740857b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752148142; x=1752752942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yKJfbdSDFe4F+/reoZSBEur/cDIBDtFpYRqgYL7IyLY=;
        b=DZu7XHvf5S2kmJxMZ00zfvNHiSF6C93m2Vrfn6uwmljtUhMKzM8O1CilCyHZZRl0xK
         riylNfhN7J9mPgRjssNfFIiyUx4dXkZPPBsH+jarXMtQjdgx45OrtDGP+P0bRbYvJCj1
         GLFdwniuaCCGIWcSFbjjdW2SS0z1aJcqT7abttgKJYjxstgGbHCnGyCz/guqVzGTkAyc
         wuSRL4CMxjjvGMdKUW4t7wNMWmMH1BPMIdgQiw0PrWgmDqkMHNTJADiQgFN8SnwDDP7U
         AKr2faoZe3IRiGmotVSSqrriBZ5YpKVe3zGBEcTKT89GFp09U5O7RaGpZhheSYJV+ItQ
         mlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148142; x=1752752942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKJfbdSDFe4F+/reoZSBEur/cDIBDtFpYRqgYL7IyLY=;
        b=tAPWqYCPtTBycupN6u9RU4dSakK/8x5KLkw2QKtNNiCIlHAiMDamT/VHgFwPPYWHiL
         Q/2AtZHQxFwdVQz3k8EN9rXyV5TrX+lDGGN5mP8A969/DDcfjoepF3WOR9rp0w1/n8pQ
         3eR2IhVErN5HQl5qY0jhVmloSsIgKBdHWC81vTLTjdSWrpmZDKflabJqfauoGBIr7pgq
         oLpEHo0aWaAqoJSidVo9u6TaM+BpXqXWAJEEbMhe+DB4JFJzzlxmqv3nbxVjJ2CbEU8l
         tUniOGAhPPBDR9UgrsLk42uwI/SfpWGme2fOh9bljqXN124yPsv7WTLMrQRIT4l9CRhX
         3AFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJE9N5fhyqRDMCm2oZE78XS35+b6uIzsAp8azd/B9AZjmrMNgxOQpQ3KnolKmRfl8aDEXkn2kxNE05kQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOBAa1WBSwye6sD7bIRiRAmCouqVmEltUOcZXSLCltMO37t6Y
	i9XQf4aAdf5t1elRfuT3XuWPtMf6OD6CX2S07IB3Pno4MUHydLQizH87+FNj2s+DZs3cQws+tSA
	1Cyziktu3eODQzyTCcmZhlhL02TbZt7Eh/CUEaIJU+w==
X-Gm-Gg: ASbGncuHYGt9pnym15qe8BeSqeBiuG3r57VefN2vDWhEZ2ABwl+PpRVHUOohsq9ol7w
	DkcRyW+7zhqAltD+YesCbii/LOQ7TTzuzyZMx8XerzQoSsNy0G0r4OJkHT0eQvdq/R90kvPAE2b
	S2uJhiPB62KBpG2Op2UOhQlJzy0FVVEnqatzJfOIKimZo=
X-Google-Smtp-Source: AGHT+IGojfjYSOURWlT9qTivvtfMoWhd8EvRMaTwv4VSn3V2NOCpZS4Pq5H6mAkfSTzN2UR8Joi/8xx9zrgl+n0WjtY=
X-Received: by 2002:a05:690c:c9e:b0:716:33dc:7ca8 with SMTP id
 00721157ae682-717c17728aamr46943927b3.18.1752148142380; Thu, 10 Jul 2025
 04:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709205332.2235072-1-k-willis@ti.com>
In-Reply-To: <20250709205332.2235072-1-k-willis@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Jul 2025 13:48:26 +0200
X-Gm-Features: Ac12FXzxFDPRY07ei6vBiy4jZBOAM5cE6ro6_L5OCtHHZgQWHrFPa5nFr0up2fM
Message-ID: <CAPDyKFpk639BP+xa5Hy1Ji8JsVOsmx3bomQWZ1+hG3jAy2juVA@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: ti_sci: Enable abort handling of entry to LPM
To: Kendall Willis <k-willis@ti.com>
Cc: nm@ti.com, kristo@kernel.org, ssantosh@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	d-gole@ti.com, vishalm@ti.com, sebin.francis@ti.com, msp@baylibre.com, 
	khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 22:54, Kendall Willis <k-willis@ti.com> wrote:
>
> The PM co-processor (device manager or DM) adds the ability to abort
> entry to a low power mode by clearing the mode selection in the
> latest version of its firmware (11.x). The following power management
> operation defined in the TISCI Low Power Mode API [1] is implemented to
> enable aborting entry to LPM:
>
> TISCI_MSG_LPM_ABORT
> Abort the current low power mode entry by clearing the current mode
> selection.
>
> Introduce LPM abort call that enables the ti_sci driver to support abort
> by clearing the low power mode selection of the DM. This fixes behavior
> from the DM where if system suspend failed, the next time system suspend
> is entered, it will fail because DM did not have the low power mode
> selection cleared. Instead of this behavior, the low power mode selection
> will be cleared after Linux resume which will allow subsequent system
> suspends to work correctly.
>
> When Linux suspends, the TI SCI ->suspend() call will send a prepare_sleep
> message to the DM. The DM will choose what low power mode to enter once
> Linux is suspended based on constraints given by devices in the TI SCI PM
> domain. After system suspend completes, regardless of if system suspend
> succeeds or fails, the ->complete() hook in TI SCI will be called. In the
> ->complete() hook, a message will be sent to the DM to clear the current
> low power mode selection. This is necessary because if suspend fails, the
> low power mode selection in the DM is not cleared and the next system
> suspend will fail due to the low power mode not having been cleared from
> the previous failed system suspend.
>
> Clearing the mode selection unconditionally acts as a cleanup from sending
> the prepare_sleep message in ->suspend(). The DM already clears the low
> power selection automatically when resuming from system suspend. If
> suspend/resume executed without failure, clearing the low power mode
> selection will not cause an error in the DM.
>
> The flow for the abort sequence is the following:
>    1. User sends a command to enter sleep
>    2. Linux starts to suspend drivers
>    3. TI SCI suspends and sends prepare_sleep message to DM
>    4. A driver fails to suspend
>    5. Linux resumes the drivers that have already suspended
>    6. Linux sends DM to clear the current low power mode selection from
>       TI SCI ->complete() hook
>    7. DM aborts LPM entry by clearing the current mode selection
>    8. Linux works as normal
>
> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> Series has been tested on an SK-AM62B-P1 board. Normal suspend/resume
> has been verified. Abort was tested by adding an error into the TI SCI
> suspend hook.
> ---
>  drivers/firmware/ti_sci.c | 61 +++++++++++++++++++++++++++++++++++++++
>  drivers/firmware/ti_sci.h |  3 +-
>  2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index ae5fd1936ad32..63c405f7037f0 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2015,6 +2015,58 @@ static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
>         return ret;
>  }
>
> +/**
> + * ti_sci_cmd_lpm_abort() - Abort entry to LPM by clearing selection of LPM to enter
> + * @handle:     pointer to TI SCI handle
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_lpm_abort(const struct ti_sci_handle *handle)
> +{
> +       struct ti_sci_info *info;
> +       struct ti_sci_msg_hdr *req;
> +       struct ti_sci_msg_hdr *resp;
> +       struct ti_sci_xfer *xfer;
> +       struct device *dev;
> +       int ret = 0;
> +
> +       if (IS_ERR(handle))
> +               return PTR_ERR(handle);
> +       if (!handle)
> +               return -EINVAL;
> +
> +       info = handle_to_ti_sci_info(handle);
> +       dev = info->dev;
> +
> +       xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_ABORT,
> +                                  TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +                                  sizeof(*req), sizeof(*resp));
> +       if (IS_ERR(xfer)) {
> +               ret = PTR_ERR(xfer);
> +               dev_err(dev, "Message alloc failed(%d)\n", ret);
> +               return ret;
> +       }
> +       req = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
> +
> +       ret = ti_sci_do_xfer(info, xfer);
> +       if (ret) {
> +               dev_err(dev, "Mbox send fail %d\n", ret);
> +               goto fail;
> +       }
> +
> +       resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
> +
> +       if (!ti_sci_is_response_ack(resp))
> +               ret = -ENODEV;
> +       else
> +               ret = 0;
> +
> +fail:
> +       ti_sci_put_one_xfer(&info->minfo, xfer);
> +
> +       return ret;
> +}
> +
>  static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
>  {
>         struct ti_sci_info *info;
> @@ -3739,11 +3791,20 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
>         return 0;
>  }
>
> +static void __maybe_unused ti_sci_complete(struct device *dev)
> +{
> +       struct ti_sci_info *info = dev_get_drvdata(dev);
> +
> +       if (ti_sci_cmd_lpm_abort(&info->handle))
> +               dev_err(dev, "LPM clear selection failed.\n");
> +}
> +
>  static const struct dev_pm_ops ti_sci_pm_ops = {
>  #ifdef CONFIG_PM_SLEEP
>         .suspend = ti_sci_suspend,
>         .suspend_noirq = ti_sci_suspend_noirq,
>         .resume_noirq = ti_sci_resume_noirq,
> +       .complete = ti_sci_complete,
>  #endif
>  };
>
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index 053387d7baa06..51d77f90a32cc 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -6,7 +6,7 @@
>   * The system works in a message response protocol
>   * See: https://software-dl.ti.com/tisci/esd/latest/index.html for details
>   *
> - * Copyright (C)  2015-2024 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C)  2015-2025 Texas Instruments Incorporated - https://www.ti.com/
>   */
>
>  #ifndef __TI_SCI_H
> @@ -42,6 +42,7 @@
>  #define TI_SCI_MSG_SET_IO_ISOLATION    0x0307
>  #define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT   0x0309
>  #define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT  0x030A
> +#define TI_SCI_MSG_LPM_ABORT   0x0311
>
>  /* Resource Management Requests */
>  #define TI_SCI_MSG_GET_RESOURCE_RANGE  0x1500
> --
> 2.34.1
>

