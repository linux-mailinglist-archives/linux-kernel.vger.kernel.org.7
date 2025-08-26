Return-Path: <linux-kernel+bounces-787244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B899B37374
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E36F3A2B21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98A31A554;
	Tue, 26 Aug 2025 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVo2jcyH"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7730CD91
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238084; cv=none; b=k5Yw7snFfJY5Ss5LOgaIPF336I7yHFHDTp4452wMOq19Oi3+gPm19ZOgKQz1rlYK+IIA4uJl1ypGeqJCGgkKpkXt16T49Vx76ybcKtIijBptxYoCk253vtRDYBkLNZbSYF1F6iNk/HEh1LNEGf/SMKjYf6ivTx3CFeyg7FqecZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238084; c=relaxed/simple;
	bh=nHV+MoADmuu9Flb/SEZp6v3PcnQ8ZAvPvJ2YlUDEGqg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WWLIWyoDP+Dih4vUgD3Qej1gksg3s1T9vZCJwpc3cS/QylkLMm6IhZlyIkTJCo2zerAC7FBJOYPpirEvL/1qBDZOFUPb1Tox5sjTIrXqHn6r8Zv964p+3Qw3XfJM3ksP4xEyWXMTzGy9Gyo48o5pwzd+eGerBKCSUOabeZg2OBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kVo2jcyH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4d892175so30479995e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756238080; x=1756842880; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5ZZNfqznY43NdEJ8oweClpq/lUKtG6cvHvhI0eKnkw=;
        b=kVo2jcyHjhJQIYTuA3M/9+RzN7Ft3MDQgkVwqOJKJKQiv03+ApkeCbQKaYGAYs7A6V
         qhth2u8o2bj53Y48lTwskvQc38tQS/kYI5BMMu5Wh+CluwBu8QhVnT8sTES9/m30ng5k
         vp7vsTJM+kKboSPZzqQB3WP5ljXCGedd0e6KWNPzC7hYvW5JhTnncYxhOxLVMr+CcCEx
         DuwfBW3jaCMjtDPYf7uS3VfkuHnUynMGg28QvTNXBTbNeYBrNce1sp1MwfsR0IrBBVKC
         BiOjFNHDF4IpM62a56M9gGoUa2AVgSM6YiV8OcG4CvKGl9/PS4X4zyeFMfZi9QH0jAbO
         F8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756238080; x=1756842880;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p5ZZNfqznY43NdEJ8oweClpq/lUKtG6cvHvhI0eKnkw=;
        b=Iph+4bbE+I7g3t1xOZoAy49K95/r/GZDJnQ4319wi305/UUMBpoG6GvahCOTBltY+f
         IZWuUEinTZjPrJkxePuHv2IWPsN5E7i+RDrIm71tWxYV0gGNa/Nj7++fvqnKoCqCZyVC
         qncgXdzPl/E4jSCrxI3RNZhw4O8/27U21mCQ3zRq619HywNBVf2mH/t1X36+5xdf+bLJ
         7ZD9TrOzQAHxuTMcAmSN0cpi8mbUJkltBep1nYUno+W6y/d8Ys7Z0h5bhOBEjHtqrVJ5
         8BcOP6UU7blCQas9ZiF+1LCMGAg/kfhTl5mf7oIXB0H9nKPFGy5RHQ1t91dLHZtFGmC1
         htAw==
X-Forwarded-Encrypted: i=1; AJvYcCU3D8K/fk74PzSWJ0XOKRMJNnXg8Jq+Y3kL60RCV4v4z8ZLIpLN2wuojdTjZUi5SJWpx8VIFXcq7wIicUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yych/jOtFxUoB/Cgd44MN0eWSXvHvWF5IIiEfCpH0RIlK5sXtms
	ZLJmsUA8AGZYJ9A/ptbZkuf2dQDFa0pmkeEEXJiHb64UpLE/MFD9HgATiE3qLJfrTaI=
X-Gm-Gg: ASbGncvXLiBfWiIUB7LqBxLtj1hTeCBzZGVCN5wjsOLuqJP3UuSzlNSJz4dtMaKDQJb
	RFcPpKqNfGXqkWJ0QWYgkBpGyjEmkdTIQq/3R81AoCamldPo96KZkUZkIR+AZafB2bsaBcQdv6a
	qBGM7GP55vI3EdxPC//lMPr06BYyThGbjJimgGk90E7+IraC/pG7+5IR36y4r1y/1qdabUjzpll
	z4GmMYyuBP/G+KgiHx27wD8UcweMv2dMFtTCxVatj0VenndqNFLKvPk5pbiSlYzL5cklxHj8t2t
	nWr6A7ziWYBC2BYfKmAibEAw9xoWkRFFsqD6Ns5Db4lquubbB4Ahq9mhkvJFnJ8YCbPKsjm6zOu
	b1TKJS3ITBYW0m7t6V9w90YswwGQ=
X-Google-Smtp-Source: AGHT+IGHAaQcE5nk8+2l2gN+bgEDgLzg5nPrVxn2sZgSHR1KIyMJyR1EB3qvooivM+uG4c5VtH8DHw==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr135380295e9.26.1756238080215;
        Tue, 26 Aug 2025 12:54:40 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:e633:2c7e:2d3c:f5ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0f320esm23865e9.16.2025.08.26.12.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 20:54:38 +0100
Message-Id: <DCCMFVC0DW1I.GXZVG2BQEFX7@linaro.org>
Subject: Re: [PATCH v7 7/8] serial: qcom-geni: Enable PM runtime for serial
 driver
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Praveen Talari" <quic_ptalari@quicinc.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <dmitry.baryshkov@oss.qualcomm.com>, <psodagud@quicinc.com>,
 <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
 <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
 <quic_cchiluve@quicinc.com>, <quic_shazhuss@quicinc.com>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <bryan.odonoghue@linaro.org>,
 <neil.armstrong@linaro.org>, <srini@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250721174532.14022-1-quic_ptalari@quicinc.com>
 <20250721174532.14022-8-quic_ptalari@quicinc.com>
 <DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org>
 <577d05d4-789b-4556-a2d2-d0ad15b2c213@quicinc.com>
 <dcad137d-8ac9-4a0b-9b64-de799536fd32@kernel.org>
 <DCC8WLEKNS8W.9GAJHQGYPZIY@linaro.org>
 <8689a8b4-75cb-4f01-ad6c-0a8367851257@kernel.org>
 <DCC9B5C7SSU2.GRI1UY0VUDHF@linaro.org>
 <890ede8a-c049-4332-8f62-5dce2fa0f77b@kernel.org>
 <5ae730f4-5337-49f8-8bec-8605a2495f37@quicinc.com>
In-Reply-To: <5ae730f4-5337-49f8-8bec-8605a2495f37@quicinc.com>

On Tue Aug 26, 2025 at 11:29 AM BST, Praveen Talari wrote:
> Hi Alexey/Krzysztof,
>
>
> On 8/26/2025 3:36 PM, Krzysztof Kozlowski wrote:
>> On 26/08/2025 11:37, Alexey Klimov wrote:
>>> On Tue Aug 26, 2025 at 10:21 AM BST, Krzysztof Kozlowski wrote:
>>>> On 26/08/2025 11:18, Alexey Klimov wrote:
>>>>>>> May i know what is testcase which you are running on target?
>>>>>>
>>>>>> Boot the board?
>>>>>>
>>>>>>> what is target?
>>>>>>
>>>>>> It is written in original report. Did you even read it?
>>>>>>
>>>>>>> Which usecase is this issue occurring in?
>>>>>>
>>>>>> Boot?
>>>>>
>>>>> FWIW, what said above by Krzysztof is correct, there is no usecase, j=
ust booting the board.
>>>>>
>>>> 12 days and nothing improved, right? if this was not dropped now,
>>>> Alexey, can you send a revert? Author clearly approches stability with=
 a
>>>> very relaxed way and is just happy that patch was thrown over the wall
>>>> and job is done.
>>>>
>>>>
>>>> If you do not want to send revert, let me know, I will do it.
>>>
>>> I am okay with sending revert, just trying to see if there is any inter=
est
>>> in fixing this.
>>=20
>> Any interest should have happened after 1 day of reporting linux-next
>> breakage. It has been like what? 12 days?
>>=20
>> That's typical throw the patch over the wall. Revert.
>
> Really sorry for the delay.
>
> I forgot to mention earlier that I=E2=80=99ve been actively investigating=
 this
> issue across different platform SoCs. I was able to reproduce the
> problem on the SC7280.
>
> Here=E2=80=99s a summary of the observed behavior:
>
> The issue appears to originate from the qcom_geni_serial driver during
> device runtime resume. It results in a blocked IRQ thread, which in turn
> causes system instability.
>
> The call trace suggests a deadlock scenario where the IRQ
> thread=E2=80=94responsible for handling wake-up events=E2=80=94becomes un=
responsive
> while interacting with the pinctrl subsystem.
>
> Specifically, the msm_pinmux_set_mux function attempts to invoke
> disable_irq, which is problematic when called from an IRQ thread context.
> Since the IRQ itself is a wake-up source, this leads to contention or a
> self-deadlock situation.
>
> I have verified below diff and about to post it

Was the original patch, that introduced the regression, also created by AI =
tools?
Just trying to understand how we ended up with untested commit in -master.

Did you test the change below on real hardware?


> diff --git a/drivers/tty/serial/qcom_geni_serial.c=20
> b/drivers/tty/serial/qcom_geni_serial.c
> index c9c52c52a98d..cb3b4febd8c2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1848,16 +1848,36 @@ static int __maybe_unused=20
> qcom_geni_serial_runtime_suspend(struct device *dev)
>   {
>          struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
>          struct uart_port *uport =3D &port->uport;
> +       int ret;
> +
> +       ret =3D geni_serial_resources_off(uport);
> +       if(ret) {
> +               if (device_may_wakeup(dev))
> +                       disable_irq_wake(port->wakeup_irq);
> +       }
>
> -       return geni_serial_resources_off(uport);
> +       if (device_may_wakeup(dev))
> +               enable_irq_wake(port->wakeup_irq);
> +
> +       return ret;
>   }
>
>   static int __maybe_unused qcom_geni_serial_runtime_resume(struct=20
> device *dev)
>   {
>          struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
>          struct uart_port *uport =3D &port->uport;
> +       int ret;
> +
> +       if (device_may_wakeup(dev))
> +               disable_irq_wake(port->wakeup_irq);
>
> -       return geni_serial_resources_on(uport);
> +       ret =3D geni_serial_resources_on(uport);
> +       if(ret) {
> +               if (device_may_wakeup(dev))
> +                       enable_irq_wake(port->wakeup_irq);
> +       }
> +
> +       return ret;
>   }

Best regards,
Alexey


