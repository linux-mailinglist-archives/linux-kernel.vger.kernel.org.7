Return-Path: <linux-kernel+bounces-896305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3871C50129
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237CC3B0AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9C2F39A4;
	Tue, 11 Nov 2025 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="I3kxVN81"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7235CBC6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904031; cv=none; b=Lc0zlXkT2IjC1Or/M/hEyR2MXoUBkkndui3lfYn5YLHfL3hgQZmACir3+a8UUz2RbyJgd5sMw6WyUt8rdWY4gbrRYE3KS8935j28jq8I/fK39J7Pp+kqr1b1vC1bSQWHfKrSBrxUhu/C9+EK8XOl3bmyBIGOBPJVnc/wvU4MuP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904031; c=relaxed/simple;
	bh=K+YwAaQgBHNTGlsWqsDyDMVJC7SMDCTsUaCI08C1ncA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQeeMJaiuZdFIZqMaTcVOSU9IO1Q3Ux4C1xRnE1oUsw/ytF66lokOM33/TRvJ01/+/Z03+WI8gDJ0ZQ7TAkCRlScGEudvEM0lQ/4qM75MpWusgBtyBm1E4Fy8H1Tf3fAMZfvPpz+iohSehdnnBH/rpt2ItPwMgRJx1A6fq1JNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=I3kxVN81; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29586626fbeso2239655ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762904027; x=1763508827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjo2gwUi9bR6UkvLLEiGtPGxExrUE5bT0hwf9+P8s6w=;
        b=I3kxVN81EwOMR2AIVMbt9oYpCAMCYcOpNjJBFHkcecl2nNL7htg1elbPuGymH8QjES
         UmcxdgIk0BySKpveHsH9SRUEpD0iAKOdrU6E1XKYzIbMrNTjC5cxlS06PYlW6ctBU/DD
         5iHgnDRDNvVxXO4fyvpaETiDvDf+BuNFbO8ief8Y9C1dl+BJ51TCpFlRZDBivASAZwSr
         5z6oD5lbUEn1u17MGaYKNpjdRvXTPb5Jd9zK1NTlaUDOHINn0kA/O3DOwEYaJQQkY/Kq
         YJAMYZbYV3iKg5zba6S+buJeDQgZo6Ylj1ARpSCjRnFE2L5QsB/a1WvMMlqiyMgcOvLt
         ZhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904027; x=1763508827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjo2gwUi9bR6UkvLLEiGtPGxExrUE5bT0hwf9+P8s6w=;
        b=O4ueVEteUzY3bFBSl8+cQTAhNpKPKbuXS9QIzft5TYBur4t5fbUBCCJ+7bWyg/jK3f
         Z6sTzFOBoq1QUKtUPK+I/PQxSZSHzBEpyMOGptkHMtGt3uXXb5jksyioYD00CSQh8wTA
         kWxBqeSTIVaMd5h3zuatz+3yqYx2Gl6Ok4FxCeYa85hXfqcdofe0HBSYN3iNO0I7Njib
         Y9CZQTg9IXsvn+KZIQqsL2HNFRCgg4Uoi31xovSAOHuLraF5bkMVka6D+HIr/O5pKsoD
         G9uf5GZaF3aU1RMm35jNHYU+T6SDx7jj6gvLMiaFeYw6k+1qUoONC/uYGkf7cHdLbuX/
         zj/A==
X-Forwarded-Encrypted: i=1; AJvYcCWZOcHfddWT+KZZSQ+JyGnPb6k/8C2bLakQM8vKXAnC+GevjnSaDtaFHsb+X7LXI3bsaMG4GAQtmVzkBVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznLkLQZHbATUtdeCRGo8LWwP1VjUnIUMBhU/b3ZAKBtnzZwRF5
	DnBEXZR5prbm+lZCcknRB6bamvXp/r7z2MU7Gt8mlQUUbLC1UpxHYCyBy7ouvOUHwAy3
X-Gm-Gg: ASbGncvGYN1W7p7hrpEkdKsF/02ynY6SZl0lYlciBg7WYdhFNhLqSi9uhIpPWNKNYOu
	hy2d5wsI0odX/Y0kpeoBUriiPlRh42cw1IQv1LyLww/GuG7mER5u3fIq7u63e2iUqmu6TdTxNDl
	Cxv8yucTohrLkB9xYkIPW0cwJSS+LLbmPr56M2MHYyw0vR+suFAKGeLZ7KqiFVbmr0lg1O94eJG
	aAuTb1bkxae6qfGisqHeqKIIqTmIzIIwOP8zeSF1OncgvkKUfZkjrMwQci13tInDgBGEGdZ9RK2
	6gaX6M879L5HL1Pmr9R1SwSLFPbjUEBF5ProY8CsaHR4/e07YYU3FcTRh5PqMx0wF8xhWKeOVBX
	7ROIZyxRQq+ON/iNbRq/RswlihJhOAPHiWHeHDQs776jIZHTvvXeR2zcpBn52WNZ9zTx3VteoY5
	DMj4j27oTI3CrkpQ==
X-Google-Smtp-Source: AGHT+IHOj8YNWi+mk68xhriHCfF+Pfmcf6xGe5863lzhdwZWXW52qU39peEkD3G2tO50yNhqOYu2dg==
X-Received: by 2002:a17:902:ce90:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-2984edcb530mr11866685ad.40.1762904026766;
        Tue, 11 Nov 2025 15:33:46 -0800 (PST)
Received: from sultan-box ([142.147.89.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9f8f1sm8649795ad.54.2025.11.11.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:33:46 -0800 (PST)
Date: Tue, 11 Nov 2025 15:33:42 -0800
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
	richard.gong@amd.com, anson.tsao@amd.com
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
Message-ID: <aRPH1hV7bEfagPtE@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box>
 <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>
 <aRL8ZPwXSeKD4Qmn@sultan-box>
 <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com>

On Tue, Nov 11, 2025 at 05:58:10PM +0800, Du, Bin wrote:
> 
> On 11/11/2025 5:05 PM, Sultan Alsawaf wrote:
> 
> > On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
> > > Thank you, Sultan, for your time, big effort, and constant support.
> > > Apologies for my delayed reply for being occupied a little with other
> > > matters.
> > > 
> > > On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
> > > > Hi Bin,
> > > > 
> > > > On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
> > > > > Hi Bin,
> > > > > 
> > > > > To expedite review, I've attached a patch containing a bunch of fixes I've made
> > > > > on top of v5. Most of my changes should be self-explanatory; feel free to ask
> > > > > further about specific changes if you have any questions.
> > > > > 
> > > > > I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
> > > > > I should send what I've got so far.
> > > > > 
> > > > > FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
> > > > > protecting the list_del() anymore. I also checked the compiler output when using
> > > > > guard() versus scoped_guard() in that function and there is no difference:
> > > > > 
> > > > >     sha1sum:
> > > > >     5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
> > > > >     5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
> > > > > 
> > > > > So guard() should be used there again, which I've done in my patch.
> > > > > 
> > > > > I also have a few questions:
> > > > > 
> > > > > 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
> > > > >      faster to use that than using disable_irq_nosync() to disable the IRQ from
> > > > >      the CPU's side.
> > > > > 
> > > > > 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
> > > > >      beforehand to mask all pending interrupts from the ISP so that there isn't a
> > > > >      bunch of stale interrupts firing as soon the IRQ is re-enabled?
> > > > > 
> > > > > 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
> > > > >      when the ISP posts a new response _after_ the kthread determines there are no
> > > > >      more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
> > > > > 
> > > > > 4. Why are some lines much longer than before? It seems inconsistent that now
> > > > >      there is a mix of several lines wrapped to 80 cols and many lines going
> > > > >      beyond 80 cols. And there are multiple places where code is wrapped before
> > > > >      reaching 80 cols even with lots of room left, specifically for cases where it
> > > > >      wouldn't hurt readability to put more characters onto each line.
> > > > 
> > > > I've attached a new, complete patch of changes to apply on top of v5. You may
> > > > ignore the incomplete patch from my previous email and use the new one instead.
> > > > 
> > > > I made many changes and also answered questions 1-3 myself.
> > > > 
> > > > Please apply this on top of v5 and let me know if you have any questions.
> > > > 
> > > 
> > > Sure, will review, apply and test your patch accordingly. Your contribution
> > > is greatly appreciated, will let you know if there is any question or
> > > problem.
> > > 
> > > > BTW, I noticed a strange regression in v5 even without any of my changes: every
> > > > time you use cheese after using it one time, the video will freeze after 30-60
> > > > seconds with this message printed to dmesg:
> > > >     [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
> > > > 
> > > > And the video never unfreezes. I haven't found the cause for the regression yet;
> > > > can you try to reproduce it?
> > > > 
> > > 
> > > Really weird, we don't see this issue either in dev or QA test. Is it 100%
> > > reproducible and any other fail or err in the log?
> > 
> > Yes, it's 100% reproducible. There's no other message in dmesg, only that one.
> > 
> > Sometimes there is a stop stream error when I close cheese after it froze:
> > 
> >    [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
> >    [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
> >    [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
> > 
> > When I revert to v4 I cannot reproduce it at all. It seems to be something in
> > v4 -> v5 that is not fixed by any of my changes.
> > 
> 
> Hi Sultan, could you please try following modifications on top of v5 to see
> if it helps?
> 
> diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> index 39c2265121f9..d571b3873edb 100644
> --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> @@ -97,7 +97,7 @@
> 
> #define ADDR_SPACE_TYPE_GPU_VA          4
> 
> -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
> +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
> 
> /*
>   * standard ISP mipicsi=>isp
> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c
> b/drivers/media/platform/amd/isp4/isp4_subdev.c
> index 248d10076ae8..acbc80aa709e 100644
> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> @@ -697,7 +697,7 @@ static int isp4sd_stop_resp_proc_threads(struct
> isp4_subdev *isp_subdev)
>         return 0;
> }
> 
> -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool
> irq_enabled)
> {
>         struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>         unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> @@ -716,8 +716,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev
> *isp_subdev)
>                 return 0;
>         }
> 
> -       for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> -               disable_irq(isp_subdev->irq[i]);
> +       if (irq_enabled)
> +               for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> +                       disable_irq(isp_subdev->irq[i]);
> 
>         isp4sd_stop_resp_proc_threads(isp_subdev);
>         dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> @@ -813,7 +814,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev
> *isp_subdev)
> 
>         return 0;
> err_unlock_and_close:
> -       isp4sd_pwroff_and_deinit(isp_subdev);
> +       isp4sd_pwroff_and_deinit(isp_subdev, false);
>         return -EINVAL;
> }
> 
> @@ -985,7 +986,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int
> on)
>         if (on)
>                 return isp4sd_pwron_and_init(isp_subdev);
>         else
> -               return isp4sd_pwroff_and_deinit(isp_subdev);
> +               return isp4sd_pwroff_and_deinit(isp_subdev, true);
> }
> 
> static const struct v4l2_subdev_core_ops isp4sd_core_ops = {

No difference sadly; same symptoms as before. FYI, your email client broke the
patch formatting so I couldn't apply it; it hard wrapped some lines to 80 cols,
replaced tabs with spaces, and removed leading spaces on each context line, so I
had to apply it manually. To confirm I applied it correctly, here is my diff:

diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
index 39c2265121f9..d571b3873edb 100644
--- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
+++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
@@ -97,7 +97,7 @@
 
 #define ADDR_SPACE_TYPE_GPU_VA          4
 
-#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
+#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
 
 /*
  * standard ISP mipicsi=>isp
diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
index 4bd2ebf0f694..500ef0af8a41 100644
--- a/drivers/media/platform/amd/isp4/isp4_subdev.c
+++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
@@ -669,7 +669,7 @@ static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
 	return 0;
 }
 
-static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
+static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool irq_enabled)
 {
 	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
 	unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
@@ -688,8 +688,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
 		return 0;
 	}
 
-	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
-		disable_irq(isp_subdev->irq[i]);
+	if (irq_enabled)
+		for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
+			disable_irq(isp_subdev->irq[i]);
 
 	isp4sd_stop_resp_proc_threads(isp_subdev);
 	dev_dbg(dev, "isp_subdev stop resp proc streads suc");
@@ -785,7 +786,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
 
 	return 0;
 err_unlock_and_close:
-	isp4sd_pwroff_and_deinit(isp_subdev);
+	isp4sd_pwroff_and_deinit(isp_subdev, false);
 	return -EINVAL;
 }
 
@@ -957,7 +958,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int on)
 	if (on)
 		return isp4sd_pwron_and_init(isp_subdev);
 	else
-		return isp4sd_pwroff_and_deinit(isp_subdev);
+		return isp4sd_pwroff_and_deinit(isp_subdev, true);
 }
 
 static const struct v4l2_subdev_core_ops isp4sd_core_ops = {

> On the other hand, please also add the patch in amdgpu which sets *bo to
> NULL in isp_kernel_buffer_alloc() which you mentioned in another thread.

Yep, I have been doing all v5 testing with that patch applied. 

BTW, I have verified the IRQ changes are not the cause for the regression; I
tested with IRQs kept enabled all the time and the issue still occurs.

I did observe that ISP stops sending interrupts when the video stream freezes.
And, if I replicate the bug enough times, it seems to permanently break FW until
a full machine reboot. Reloading amd_capture with the v4 driver doesn't recover
the ISP when this happens.

As an improvement to the driver, can we do a hard reset of ISP on driver probe?
I am assuming hardware doesn't need too long to settle after hard reset, maybe
a few hundred milliseconds? This would ensure ISP FW is always in a working
state when the driver is loaded.

Thanks,
Sultan

