Return-Path: <linux-kernel+bounces-808934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3108BB506B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6F4168A40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8FE305976;
	Tue,  9 Sep 2025 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdEIQrg2"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE52FF65B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448332; cv=none; b=Bm3f+ozU/nPsiRpJb4oC6O+TJwkkYZBmsTyfimqvSsQaM6mLY1QbMoPtuUQ6JS/aLp5PzwQLhQN0Fh+aUeY5hLYfDYwj2wrPa1citkGxOXxlxn3yiA3D+8i/36ZzbDH9vHaGmxt0ymglWN3BwQs/AlLVY6RqNSLZg0fXxJs2gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448332; c=relaxed/simple;
	bh=851RnKnUgoqCjW/TgSpbd+twylQSsUsEKp/7O2LqGsk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h9vDApAMOmoV0UYfAkDRk7r11OjMhUUCKoM8QVjX/nqzle3BPtXqVWyLKOFk+DJFsE0K50yn6VBO7NtP4tmRUei3pA+fMio8Mk8hUFwOZPpqyFvSLgONDQbWxBMPvCQb6apGlMTv+EhIurbjMVU/IZ4pKVKX8FXKtEerZXSKKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xdEIQrg2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso37041125e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757448329; x=1758053129; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CTE49M6okCvsTNKqUwvsKK7hhTjey+iFIEw73+ORxs=;
        b=xdEIQrg29NLmHHjm054CHFB33F8sm7lwvGEGj/0x++49Iw94OjSAX+6ixe6xILVrvW
         WGuyiS7TB8abJaFsRvgrRJXplQyabp6MjVmrzLkrQDncRarUfdUYsLFH6QOgssPba4hb
         TfVCh5y3xq0bKjy6S2Te868o91IpvvWnDvNUFkQqNRFJI8kAloRmn68dbDOr05fobt0K
         6+QmMi3UuVtsFB/xZfyRtEIjtJ3JwAFTt/679d18I/sBakwulVFt3k2q+ERheuxvrns+
         QeBcqzM1jA+7HnJhS75UJkAkNtw8+FcrIfjpkL7JXckE6NMv70fbKm77FlFQbOksFwTf
         2QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448329; x=1758053129;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CTE49M6okCvsTNKqUwvsKK7hhTjey+iFIEw73+ORxs=;
        b=YU98VncbdraoG0jQnV+CU5s0MBHLSWC42dtVri6l0uYCXh4cZG06gOW/AcZjaWM4xd
         aB2ZkPucF0luozmASuiRDx64KFSdoWiKYuxezmhmLBGnaoVTEmf7KWNy/zLWj+VkjNaS
         AeDFsOADoYRWmzpLwmbh5sVxnpDBuWsv35RTv7Y3uobp00i5pFBMH3VxX7Cd5DHjb8/+
         Au9alMp1bXJFAWVa3/ZuAZevWZCj66qTEdMFvQceSFRKyz5TbLihPbSZyNvAWhZl3Gx3
         77XAqMUYnTPlhWeWcPMf54Q3oimwUUkXjmqtxAPuW0JJSP/dPannhknIE6EfNk5Z2z2Y
         7jiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy1O2gzJH7zhJliYGi5NKbYDstaiK1ZICgURu0ha7OQLahnq2Z7y6S+dI9UwbqOMAhoatTPkNIQ9o3wdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDwsOMmUpsJVBt0ym1SstcjgHUk7rUn00YNF5uy0od1W5xvdt
	opDsnQb80pPodenUHoA1z2wRfqOX1cVe2F0cDjd9XGbWH69vl1yPfkc728Hnamsdyy8=
X-Gm-Gg: ASbGnctHU2PqeB1mJSTnxK5jX2XpgIYXwQpBcgT22TaS0P2o2eNp5fgXPBatS+mTUF0
	NUkzzihJMF4N9uEcxq90E23n/1UDuU/SzrIw+6bpvnICA1YvcrDYVKFXDPCosM0LZWWuafbWLz0
	RgJdM/03CmkJmvOuMNUphd+usQ4l4pEF+rTOtLcFO6OmgyB946eBsLzcNho4Th9wELNtHA0+1rp
	6c4+6YZWu3HHgE9qh8g+Y4Ekb05xgP1OeN3WIzCULfh5tlewKyrdOc13hlzr4HtFyMStpKboLIx
	wu61Om0+/E/0gNOGZW+UWuwhZYio74WJxhT1vwc3ZBjmESEzIO7zFdWD9eG3SyMIhueT+Ok8y4v
	5qu/ZaXWeupESc8X8Tgslo2xzwoMhM8/Qphb23aMYZFjtawqX
X-Google-Smtp-Source: AGHT+IH8x182Nog1gF6IWrm9r/3M9KRxKnOYGemSMatGXEL+NOzXgP2ldkxgpa6cuYWAaUu4B41rdg==
X-Received: by 2002:a05:600c:46d0:b0:45d:d96e:6176 with SMTP id 5b1f17b1804b1-45ddded62d8mr111122655e9.25.1757448328554;
        Tue, 09 Sep 2025 13:05:28 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:c21d:84a2:1410:7b31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df7dc0a16sm1373635e9.13.2025.09.09.13.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 13:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 21:05:27 +0100
Message-Id: <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
Cc: <psodagud@quicinc.com>, <djaggi@quicinc.com>,
 <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
 <quic_arandive@quicinc.com>, <quic_mnaresh@quicinc.com>,
 <quic_shazhuss@quicinc.com>, <krzk@kernel.org>
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Bryan
 O'Donoghue" <bryan.odonoghue@linaro.org>, "Praveen Talari"
 <quic_ptalari@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
In-Reply-To: <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>


(adding Krzysztof to c/c)

On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
>> A deadlock is observed in the qcom_geni_serial driver during runtime
>> resume. This occurs when the pinctrl subsystem reconfigures device pins
>> via msm_pinmux_set_mux() while the serial device's interrupt is an
>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
>> __synchronize_irq(), conflicting with the active wakeup state and
>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
>> leading to system instability.
>>
>> The critical call trace leading to the deadlock is:
>>
>>     Call trace:
>>     __switch_to+0xe0/0x120
>>     __schedule+0x39c/0x978
>>     schedule+0x5c/0xf8
>>     __synchronize_irq+0x88/0xb4
>>     disable_irq+0x3c/0x4c
>>     msm_pinmux_set_mux+0x508/0x644
>>     pinmux_enable_setting+0x190/0x2dc
>>     pinctrl_commit_state+0x13c/0x208
>>     pinctrl_pm_select_default_state+0x4c/0xa4
>>     geni_se_resources_on+0xe8/0x154
>>     qcom_geni_serial_runtime_resume+0x4c/0x88
>>     pm_generic_runtime_resume+0x2c/0x44
>>     __genpd_runtime_resume+0x30/0x80
>>     genpd_runtime_resume+0x114/0x29c
>>     __rpm_callback+0x48/0x1d8
>>     rpm_callback+0x6c/0x78
>>     rpm_resume+0x530/0x750
>>     __pm_runtime_resume+0x50/0x94
>>     handle_threaded_wake_irq+0x30/0x94
>>     irq_thread_fn+0x2c/xa8
>>     irq_thread+0x160/x248
>>     kthread+0x110/x114
>>     ret_from_fork+0x10/x20
>>
>> To resolve this, explicitly manage the wakeup IRQ state within the
>> runtime suspend/resume callbacks. In the runtime resume callback, call
>> disable_irq_wake() before enabling resources. This preemptively
>> removes the "wakeup" capability from the IRQ, allowing subsequent
>> interrupt management calls to proceed without conflict. An error path
>> re-enables the wakeup IRQ if resource enablement fails.
>>
>> Conversely, in runtime suspend, call enable_irq_wake() after resources
>> are disabled. This ensures the interrupt is configured as a wakeup
>> source only once the device has fully entered its low-power state. An
>> error path handles disabling the wakeup IRQ if the suspend operation
>> fails.
>>
>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial dr=
iver")
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>
> You forgot:
>
> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>
> Also, not sure where this change will go, via Greg or Jiri, but ideally
> this should be picked for current -rc cycle since regression is
> introduced during latest merge window.
>
> I also would like to test it on qrb2210 rb1 where this regression is
> reproduciable.

It doesn't seem that it fixes the regression on RB1 board:

 INFO: task kworker/u16:3:50 blocked for more than 120 seconds.
       Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u16:3   state:D stack:0     pid:50    tgid:50    ppid:2      =
task_flags:0x4208060 flags:0x00000010
 Workqueue: async async_run_entry_fn
 Call trace:
  __switch_to+0xf0/0x1c0 (T)
  __schedule+0x358/0x99c
  schedule+0x34/0x11c
  rpm_resume+0x17c/0x6a0
  rpm_resume+0x2c4/0x6a0
  rpm_resume+0x2c4/0x6a0
  rpm_resume+0x2c4/0x6a0
  __pm_runtime_resume+0x50/0x9c
  __driver_probe_device+0x58/0x120
  driver_probe_device+0x3c/0x154
  __driver_attach_async_helper+0x4c/0xc0
  async_run_entry_fn+0x34/0xe0
  process_one_work+0x148/0x284
  worker_thread+0x2c4/0x3e0
  kthread+0x12c/0x210
  ret_from_fork+0x10/0x20
 INFO: task irq/92-4a8c000.:79 blocked for more than 120 seconds.
       Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:irq/92-4a8c000. state:D stack:0     pid:79    tgid:79    ppid:2      =
task_flags:0x208040 flags:0x00000010
 Call trace:
  __switch_to+0xf0/0x1c0 (T)
  __schedule+0x358/0x99c
  schedule+0x34/0x11c
  __synchronize_irq+0x90/0xcc
  disable_irq+0x3c/0x4c
  msm_pinmux_set_mux+0x3b4/0x45c
  pinmux_enable_setting+0x1fc/0x2d8
  pinctrl_commit_state+0xa0/0x260
  pinctrl_pm_select_default_state+0x4c/0xa0
  geni_se_resources_on+0xe8/0x154
  geni_serial_resource_state+0x8c/0xbc
  qcom_geni_serial_runtime_resume+0x3c/0x88
  pm_generic_runtime_resume+0x2c/0x44
  __rpm_callback+0x48/0x1e0
  rpm_callback+0x74/0x80
  rpm_resume+0x3bc/0x6a0
  __pm_runtime_resume+0x50/0x9c
  handle_threaded_wake_irq+0x30/0x80
  irq_thread_fn+0x2c/0xb0
  irq_thread+0x170/0x334
  kthread+0x12c/0x210
  ret_from_fork+0x10/0x20

I see exactly the same behaviour with this changes applied.

root@rb1:~# uname -a
Linux rb1 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13 SMP PREEMPT Tue Sep  9 2=
0:14:22 BST 2025 aarch64 GNU/Linux

I see the same behaviour with linux-next but my local tree is a bit old,
maybe there are some dependencies.

Best regards,
Alexey

