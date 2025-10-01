Return-Path: <linux-kernel+bounces-838526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175FBAF64E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59BA3B48B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8742264CD;
	Wed,  1 Oct 2025 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="oD4z0TYC"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4373A8F7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303467; cv=none; b=FQQs5NS0QLw/ud94kysv/9auj3qABiRNyI8zHuVMJldkYNXZ3mk2WxwMLB3n3UjRs77XJpgzTP0cos579lxgrPIPktCxsi9hdkXHt/J2mQeT+FA8I1qO5DibO5m5171gMOXnxXjbxD4kKhG0YsTrl5Ve5uC9mMaxykV0gC4jMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303467; c=relaxed/simple;
	bh=jJXddCZFI/cpqttthVvXwpHOOfpO6qOgBeHJyNLw3sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlFUii8K1u3KQQwPGrQSTJWIN9Mpd7gfRNo4/ocm4vZqCAHSg6rwnWeR/iJb0Gl6qhDBkzdNHAuMTBBSTY6CIlESFDli425Pris+pF4paKi0ovTaCLl91cbDAEHgNbNeS1q09qbV78H2w4KXwAqu5lQXUbHx3H2Q1/tZWkujKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=oD4z0TYC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5506b28c98so4751369a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1759303465; x=1759908265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vl/CNeoWhBjYRjRzmZ70zdlmyrUzioNb3cPONrlMgXE=;
        b=oD4z0TYC25JdT1fOZr52zMRqbg1wmIWtoykVLa6wq3J85cbPXsm4jpCFEBb3eM0zCG
         vGfG2vVsRQW0+gyaU821IEdfy58IFD14PeS5ZUiN9Dbb0pvYjkE4q2GqecG2RT2E7yFq
         0ZytH262/PC8TDg6Fv8deqspOQGDeA0uuqGF3jVO9hTKwD2ei3xfaAJD1+bt2JyvAhBY
         c1BBTOJz4kyTnNFIX6ZqjWN3xWZu6bUrQyl0JLsBuJrhlQjFchrogd9Q6nHwG8rmx6QX
         FQFhRDqKJb1QO5tsV7HakN9/qowm0CUIRjuNs7KOSaSawgkb7kxPi9Itmvkcady63Kii
         sVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303465; x=1759908265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl/CNeoWhBjYRjRzmZ70zdlmyrUzioNb3cPONrlMgXE=;
        b=O4t/dzRMWaFzf1cVd2/SIPGCMEzWrGQfemyBD8Ip0HyEtJz7cShnn0Bu355OfRiIGZ
         BkV/4NFHG27ba+/JJMiFHpLtPOQxlqx1EKnD+d5GzDgO/AdTFcehvP7IKNU2lt/gUqD/
         rNHQmS6SiW6ppanhL1uqvo/4FRfdQrE4uUCdVa+6i7eJ5htz18FA8xo4vKJy+gqLIiZK
         pURGA8JFLum6D34fFLRY0qy4Eo4oh/en2CMnClkoUlLC3ryx1H0D/zGacgAIj52PLZ2K
         9w8rxQBAkuC9i3YleMxFh0qrvdJSEC2aOzAYLo0uWYTTtPHcY2bPox8nhxc9b2qUd6Xp
         AAOg==
X-Forwarded-Encrypted: i=1; AJvYcCWwzHz2WjrNozLsXVKThZhZAeSfNQlgOK/AkiAUyfYBiS/wdYDSU3RF1lHE1sBp8bai8QHZyfgvmuq11mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MOg2QUm810XvVeXyCH+WaHRq/5Li4rGZnHkl6XYC2FQrS3OA
	4CYrP05mefH0XDYuZZP3mnW6PD0wjzPO1Mvmsx3/BjF4f1/grRNr4IZqAfsICQQjkJTf
X-Gm-Gg: ASbGnctIOGOtoDHvcroTeeCxpeE7vDUXny97c7vpL0KUMcdtd83C1fARZPEdru7X8Nd
	Va1lgPBHI4bKLzza8STPPfTnErrH7SIUKa76O/qe3tlS2wz+1iDXcqfay6tzPtQ5UvIoUJei5hz
	WFB5GVR3Dk3g1fjCREgpfQsOeIvCwzg4g4erc4EtPXuciEqwvIfze7BZ2G5QfK4NXtewRFkZAMy
	/ZdfXQqi07FanMgOFM/afrF/PnKdGZaDjfQPgqQY1OExLgZaxn2gkrFJxWCMjo6AA0kdE8xpdvF
	VAjTqQMk61CsOJcEECkfNcLTfzwaXNaKlZx38wzu2o/L8k1vx8r6p1c5rzNfvJ/kMScnEk0mwEY
	vqd3DkZk7/Awkns/QRH+3ynMeupOswnvvW4naf5iXpIF4yvSI
X-Google-Smtp-Source: AGHT+IEcRWXeLVrb+pvtX4jq8PyYOWVzLibEP7mgL2Y7VQ8f57O8WepoVnphTXII4DvapquColdOgw==
X-Received: by 2002:a17:903:40ca:b0:265:57dc:977b with SMTP id d9443c01a7336-28e7f440616mr29394075ad.61.1759303465055;
        Wed, 01 Oct 2025 00:24:25 -0700 (PDT)
Received: from sultan-box ([79.127.217.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6881fcasm178452755ad.93.2025.10.01.00.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:24:24 -0700 (PDT)
Date: Wed, 1 Oct 2025 00:24:21 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com,
	Alexey Zagorodnikov <xglooom@gmail.com>
Subject: Re: [PATCH v4 4/7] media: platform: amd: isp4 subdev and firmware
 loading handling added
Message-ID: <aNzXJaH_yGu1UrV2@sultan-box>
References: <20250911100847.277408-1-Bin.Du@amd.com>
 <20250911100847.277408-5-Bin.Du@amd.com>
 <aNJK_tZe99_jWNdR@sultan-box>
 <c63a56cb-23d0-4c5a-8e1a-0dfe17ff1786@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c63a56cb-23d0-4c5a-8e1a-0dfe17ff1786@amd.com>

On Tue, Sep 30, 2025 at 03:30:49PM +0800, Du, Bin wrote:
> On 9/23/2025 3:23 PM, Sultan Alsawaf wrote:
> > On Thu, Sep 11, 2025 at 06:08:44PM +0800, Bin Du wrote:
> > > Isp4 sub-device is implementing v4l2 sub-device interface. It has one
> > > capture video node, and supports only preview stream. It manages firmware
> > > states, stream configuration. Add interrupt handling and notification for
> > > isp firmware to isp-subdevice.
> > > 
> > > Co-developed-by: Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>
> > > Signed-off-by: Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>
> > > Signed-off-by: Bin Du <Bin.Du@amd.com>
> > > Tested-by: Alexey Zagorodnikov <xglooom@gmail.com>
> > 
> > [snip]
> > 
> > > +++ b/drivers/media/platform/amd/isp4/isp4.c
> > > @@ -5,13 +5,19 @@
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/vmalloc.h>
> > > +
> > > +#include <media/v4l2-fwnode.h>
> > >   #include <media/v4l2-ioctl.h>
> > >   #include "isp4.h"
> > > -
> > > -#define VIDEO_BUF_NUM 5
> > > +#include "isp4_hw_reg.h"
> > >   #define ISP4_DRV_NAME "amd_isp_capture"
> > > +#define ISP4_FW_RESP_RB_IRQ_STATUS_MASK \
> > > +	(ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT9_INT_MASK  | \
> > > +	 ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT10_INT_MASK | \
> > > +	 ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT11_INT_MASK | \
> > > +	 ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT12_INT_MASK)
> > >   /* interrupt num */
> > >   static const u32 isp4_ringbuf_interrupt_num[] = {
> > > @@ -21,19 +27,95 @@ static const u32 isp4_ringbuf_interrupt_num[] = {
> > >   	4, /* ISP_4_1__SRCID__ISP_RINGBUFFER_WPT12 */
> > >   };
> > > -#define to_isp4_device(dev) \
> > > -	((struct isp4_device *)container_of(dev, struct isp4_device, v4l2_dev))
> > > +#define to_isp4_device(dev) container_of(dev, struct isp4_device, v4l2_dev)
> > > +
> > > +static void isp4_wake_up_resp_thread(struct isp4_subdev *isp, u32 index)
> > > +{
> > > +	if (isp && index < ISP4SD_MAX_FW_RESP_STREAM_NUM) {
> > > +		struct isp4sd_thread_handler *thread_ctx =
> > > +				&isp->fw_resp_thread[index];
> > > +
> > > +		thread_ctx->wq_cond = 1;
> > > +		wake_up_interruptible(&thread_ctx->waitq);
> > > +	}
> > > +}
> > > +
> > > +static void isp4_resp_interrupt_notify(struct isp4_subdev *isp, u32 intr_status)
> > > +{
> > > +	bool wake = (isp->ispif.status == ISP4IF_STATUS_FW_RUNNING);
> > > +
> > > +	u32 intr_ack = 0;
> > > +
> > > +	/* global response */
> > > +	if (intr_status &
> > > +	    ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT12_INT_MASK) {
> > > +		if (wake)
> > > +			isp4_wake_up_resp_thread(isp, 0);
> > > +
> > > +		intr_ack |= ISP_SYS_INT0_ACK__SYS_INT_RINGBUFFER_WPT12_ACK_MASK;
> > 
> > The INT_MASKs and ACK_MASKs are the same; perhaps the ACK_MASKs can just be
> > removed so you can just write intr_status to ISP_SYS_INT0_ACK instead?
> > 
> 
> These macro definitions are automatically generated from the IP design by
> the hardware team. INT_MASK and ACK_MASK represent specific bits in
> different registers—the status and acknowledgment registers, respectively.
> While their values are currently the same, they could differ depending on
> the IP design. I prefer to keep both definitions to maintain clarity.

Sure, no problem.

> > > +
> > > +	/* clear ISP_SYS interrupts */
> > > +	isp4hw_wreg(ISP4_GET_ISP_REG_BASE(isp), ISP_SYS_INT0_ACK, intr_ack);
> > > +}
> > >   static irqreturn_t isp4_irq_handler(int irq, void *arg)
> > >   {
> > > +	struct isp4_device *isp_dev = dev_get_drvdata(arg);
> > 
> > This is technically a data race because setting drvdata and reading drvdata do
> > not use WRITE_ONCE() and READ_ONCE(), respectively. And enabling the IRQ before
> > the handler is allowed to do anything is why that `if (!isp_dev)` check exists,
> > because that is another race.
> > 
> > Instead, pass the isp_dev pointer through the private pointer of
> > devm_request_irq() and add IRQ_NOAUTOEN so the IRQ is enabled by default. Then,
> > when it is safe for the IRQ to run, enable it with enable_irq().
> > 
> > That way you can delete the `if (!isp_dev)` check and resolve the two races.
> > 
> 
> Good deep insight, suppose you mean use IRQ_NOAUTOEN to make irq default
> disabled. Sure, will add support to dynamically enable/disable IRQ during
> camera open/close and remove unnecessary check.

Sorry for the typo, meant to say default disabled indeed. :)

> > > +	u32 r1;
> > > +
> > > +	if (!isp_dev)
> > > +		goto error_drv_data;
> > > +
> > > +	isp = &isp_dev->isp_sdev;
> > > +	/* check ISP_SYS interrupts status */
> > > +	r1 = isp4hw_rreg(ISP4_GET_ISP_REG_BASE(isp), ISP_SYS_INT0_STATUS);
> > > +
> > > +	isp_sys_irq_status = r1 & ISP4_FW_RESP_RB_IRQ_STATUS_MASK;
> > 
> > There are four IRQs (one for each stream) but any one of the IRQs can result in
> > a notification for _all_ streams. Each IRQ should only do the work of its own
> > stream.
> > 
> > You can do this by passing devm_request_irq() a private pointer to indicate the
> > mapping between a stream and its IRQ, so that isp4_irq_handler() can know which
> > stream it should look at.
> > 
> 
> Will do optimization to remove unused IRQs and keep only necessary ones
> (reduce from 4 to 2), actually an IRQ won't result in notification to all
> streams, please check the implementation of isp4_resp_interrupt_notify, it
> will only wake up IRQ corresponding stream processing thread.

What I mean is that the IRQ for one stream can wake a different stream if it is
also ready at the same time according to the interrupt status register.

Assume we have ISP_IRQ 0 and 1 for streams 1 (WPT9) and 2 (WPT10), respectively.
Consider the following sequence of events:

    ISP_IRQ0 (WPT9)			ISP_IRQ1 (WPT10)
    ---------------			----------------
    <interrupt fires>			<interrupt fires>
    isp4_irq_handler()			isp4_irq_handler()
    isp_sys_irq_status = WPT9|WPT10	isp_sys_irq_status = WPT9|WPT10

    isp4_wake_up_resp_thread(isp, 1)	isp4_wake_up_resp_thread(isp, 1)
					// ^ woke up WPT9 from WPT10 IRQ!

    isp4_wake_up_resp_thread(isp, 2)	isp4_wake_up_resp_thread(isp, 2)
    // ^ woke up WPT10 from WPT9 IRQ!

The problem is that isp4_irq_handler() doesn't know which IRQ triggered the call
into isp4_irq_handler().

> > > +static int isp4sd_init_meta_buf(struct isp4_subdev *isp_subdev)
> > > +{
> > > +	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
> > > +	struct isp4_interface *ispif = &isp_subdev->ispif;
> > > +	struct device *dev = isp_subdev->dev;
> > > +	u32 i;
> > > +
> > > +	for (i = 0; i < ISP4IF_MAX_STREAM_BUF_COUNT; i++) {
> > > +		if (!sensor_info->meta_info_buf[i]) {
> > > +			sensor_info->meta_info_buf[i] = ispif->metainfo_buf_pool[i];
> > > +			if (!sensor_info->meta_info_buf[i]) {
> > > +				dev_err(dev, "invalid %u meta_info_buf fail\n", i);
> > > +				return -ENOMEM;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > What is the point of metainfo_buf_pool? Especially since metainfo_buf_pool[i] is
> > not set to NULL after this "allocation" occurs.
> > 
> > I think isp4sd_init_meta_buf() and metainfo_buf_pool are unnecessary and can be
> > factored out.
> > 
> 
> I suppose you mean meta_info_buf, will remove it together with
> isp4sd_init_meta_buf() and use metainfo_buf_pool from ispif directly which
> is vital for ISP FW to carry response info.

I was thinking that metainfo_buf_pool could be renamed to meta_info_buf and then
the old meta_info_buf could be deleted. Same result either way. :)

> > > +	init_waitqueue_head(&thread_ctx->waitq);
> > > +	timeout = msecs_to_jiffies(ISP4SD_WAIT_RESP_IRQ_TIMEOUT);
> > > +
> > > +	dev_dbg(dev, "[%u] started\n", para->idx);
> > > +
> > > +	while (true) {
> > > +		wait_event_interruptible_timeout(thread_ctx->waitq,
> > > +						 thread_ctx->wq_cond != 0,
> > > +						 timeout);
> > 
> > Why is there a timeout? What does the timeout even do since the return value of
> > wait_event_interruptible_timeout() is not checked? Doesn't that mean that once
> > the timeout is hit, isp4sd_fw_resp_func() will be called for nothing?
> > 
> > I observe that most of the time spent by these kthreads is due to the constant
> > wake-ups from the very short 5 ms timeout. This is bad for energy efficiency and
> > creates needless overhead.
> > 
> 
> Good catch, previouly before IRQ is really enabled, this is to make sure ISP
> can work normally even for 120fps sensor, since now IRQ is enabled, we can
> increase the timeout value to like 200ms to avoid the unwanted timeout
> caused wake-ups.

What should the kthread do when there is a timeout though? Is the timeout
necessary to detect when FW is no longer responding? If so, shouldn't there be
error handling?

If the timeout isn't used to check for error then I think it should be removed.

> > > +		thread_ctx->wq_cond = 0;
> > > +
> > > +		if (kthread_should_stop()) {
> > > +			dev_dbg(dev, "[%u] quit\n", para->idx);
> > > +			break;
> > > +		}
> > > +
> > > +		guard(mutex)(&thread_ctx->mutex);
> > > +		isp4sd_fw_resp_func(isp_subdev, stream_id);
> > > +	}
> > > +
> > > +	mutex_destroy(&thread_ctx->mutex);
> > > +
> > > +	return 0;
> > > +}

[snip]

> > > +
> > > +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> > > +{
> > > +	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
> > > +	unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> > > +	struct isp4_interface *ispif = &isp_subdev->ispif;
> > > +
> > > +	struct device *dev = isp_subdev->dev;
> > > +	u32 cnt;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&isp_subdev->ops_mutex);
> > > +
> > > +	if (sensor_info->status == ISP4SD_START_STATUS_STARTED) {
> > > +		dev_err(dev, "fail for stream still running\n");
> > > +		mutex_unlock(&isp_subdev->ops_mutex);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	sensor_info->status = ISP4SD_START_STATUS_NOT_START;
> > > +	cnt = isp4sd_get_started_stream_count(isp_subdev);
> > > +	if (cnt > 0) {
> > > +		dev_dbg(dev, "no need power off isp_subdev\n");
> > > +		mutex_unlock(&isp_subdev->ops_mutex);
> > > +		return 0;
> > > +	}
> > > +
> > > +	isp4if_stop(ispif);
> > > +
> > > +	ret = dev_pm_genpd_set_performance_state(dev, perf_state);
> > > +	if (ret)
> > > +		dev_err(dev,
> > > +			"fail to set isp_subdev performance state %u,ret %d\n",
> > > +			perf_state, ret);
> > > +	isp4sd_stop_resp_proc_threads(isp_subdev);
> > > +	dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> > > +	/* hold ccpu reset */
> > > +	isp4hw_wreg(isp_subdev->mmio, ISP_SOFT_RESET, 0x0);
> > > +	isp4hw_wreg(isp_subdev->mmio, ISP_POWER_STATUS, 0);
> > > +	ret = pm_runtime_put_sync(dev);
> > > +	if (ret)
> > > +		dev_err(dev, "power off isp_subdev fail %d\n", ret);
> > > +	else
> > > +		dev_dbg(dev, "power off isp_subdev suc\n");
> > > +
> > > +	ispif->status = ISP4IF_STATUS_PWR_OFF;
> > > +	isp4if_clear_cmdq(ispif);
> > > +	isp4sd_module_enable(isp_subdev, false);
> > > +
> > > +	msleep(20);
> > 
> > What is this msleep for?
> > 
> 
> This is the HW requirement, at least 20ms is needed for the possible quickly
> open followed.

Add a comment explaining the HW requirement for this msleep.

Sultan

