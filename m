Return-Path: <linux-kernel+bounces-731822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C0CB05A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E9C3B02A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF62E03EF;
	Tue, 15 Jul 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DwxDrtjT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2761EDA09
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582653; cv=none; b=dN3iz4wSozAuNbHqFxr3hWKw7WGAw/xsomORx/BzmSC7c+E2N4YLhFw+8PY+RGMYxVb9ZXUoof8JVXPOdroDiLh8L1CBt+ipFmrdVto7UtyEDIRR/fIuYi4lhjc/TBd4gGQSMbcqUl6grEfY0DdlQwjN/pFfBtxJoaop/UnhzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582653; c=relaxed/simple;
	bh=WWk+Zz38J+A0lk1NwBDagUK+UNQd7WE179Tt+YtBOkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvB+j5As+k8KsJmViRotcxzE99K8A7/CRQOdp+CcJma3I33h+X9KSijgIx3dAGr845KZxhykLMFO+fIA2/o8+CkRZu0rocKon5xLdKrEvZDb70s2gNJQ58Wd7n+b3Sb/QQup6BMtCnFptg8iw8RV8HNxHaddSJfUuwxKeh8YSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DwxDrtjT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FBceU8004454
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vll9rDGne1AoSKyOm+L2Rpgh
	eag73S1w5wXI4BU9WhU=; b=DwxDrtjTDCkY5VX8gp/sJ39WjfO+PJz5zmZ3sdhs
	bqPA1uVnPIfEGLII9VqnUxlDXxM+khrFIunyiqghfsq28KBM9j/Za8BjUDIxul8G
	y3kalwZbIxpwc78o8OVFaws9iUfb5e++dQRBgIeCCvWlZM/PyLPVs1PuBVz0oFfS
	UKT9cR+v00aMD4SH6pyc0oB64Pc4uwGWDwv3jUYuUtQ4ZHu8LhckZP1s8FfY3cjL
	F0KndfTafhNhO5ZjJ2ysX5ZaS0BXwu46dIuxUno9cYp3TwKAtZBfASCMMjvCHUAg
	0G1CpBW1m3EW0pcWn7XujoNnP8ws5GH0VgALSm0X8IOn5w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca1ehq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:30:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso5771579a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752582650; x=1753187450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vll9rDGne1AoSKyOm+L2Rpgheag73S1w5wXI4BU9WhU=;
        b=f+lX4951ZEJ4Zb/imPwPdkpC2E+idKvUeOLZitRmkAAXgSdbGKbjG2tYPrXJIEWwMV
         fI1tMJ+bpEtsmCtn51weseHBKuvCWMB/A/NjBv0oE+f2Jx96AVKxur/hTvsb5LhM7Xk6
         uGmI6NpyMJx+TREFVuSamCCTe6cIoqjfBnxySLEGM3Urx1OKI4L34hZzhQjyJRlQFjbp
         +vHbkszPrAcM5uy2rKodCxzjSdhQSVMrzR/KARtbsVapwlOAM1zWCAhNb23EQGXDqMyt
         UGN9mHY0r3CiVD/llxu1oEVIvEYwrlRQJYjmq6ckyfIr+v5LkMqprGg1/YU6AP8Ojg/j
         mhOw==
X-Forwarded-Encrypted: i=1; AJvYcCUzTvj/4IAX1kWsJfCOq2Ir1dVHu0b4Zsr7k5NYETuDryd7T5v8hUaN/PmrkYiHgp56ZFkVSOz50PZPUJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZLtUvAztaDOYPcEkKUABnNv5XwFtDoW426kIE7Bd94Hujwpv
	Bu3JpToHO0xv9UHwaWwjOcN+IkPGHxxv6jFGYGq+I5UQ0TkRMAOu174eOIYvCOkP94Tnujdi5M+
	G29aQaixZTmlvfolaflFsBXqC6H0a1wrkWStnS4cvEf9ChzGhzkynuSjWE5esgK+UnB4jm21wpc
	8iGj3eUfevKutNJMFRxsWc/tmfVdbvjDkWOOv0cu4/aA==
X-Gm-Gg: ASbGncstlW3h7XXQKhTNZH+fDxIF92XY/5NhBpXMWBMyM9rzD/nAUmFQWTvIq9eOT9a
	1jN4kygTapbwHb3gbFjyYXPk7a5WIlLHT92hTQEg3wRBriaIv01f4KXO2BDja7u50XrHCjXn5N2
	43W694Gkm5qDZW/6BrRA==
X-Received: by 2002:a17:90b:57ee:b0:311:ef19:824d with SMTP id 98e67ed59e1d1-31c4f48b04fmr24534271a91.2.1752582649353;
        Tue, 15 Jul 2025 05:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+QKgmUT1LtI1tPLIsEldlE+Xv3jc/Myv45x2YTeyCk85wFHdk/rhiwhDMhBYh15+FloJ3fZb+aHNfPlztF/k=
X-Received: by 2002:a17:90b:57ee:b0:311:ef19:824d with SMTP id
 98e67ed59e1d1-31c4f48b04fmr24534218a91.2.1752582648728; Tue, 15 Jul 2025
 05:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606172114.6618-1-quic_ptalari@quicinc.com>
 <20250606172114.6618-8-quic_ptalari@quicinc.com> <d6cr4elhrbh27lmlcv5xzuel75uvsgi7klxjkevm7vg4jcbawe@5ojgetrxkag5>
 <f87807c9-5249-4d97-ab89-898b7d8d260d@quicinc.com> <tt2crsexdnhlotlo3z5uxyta6jrnnvom7aqwsjvopwueazbuih@2l4h6xjpwlar>
 <1c73b530-4f1a-4c45-91aa-b44efb8a8c1e@quicinc.com>
In-Reply-To: <1c73b530-4f1a-4c45-91aa-b44efb8a8c1e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 15:30:37 +0300
X-Gm-Features: Ac12FXx7o0vm61CvNFB6-j5iSJHx1nZh9qdvCU2mn-91NnumjNpXsNKHazRHWZE
Message-ID: <CAO9ioeVLPnqxL6Vz+GOFuqkiT8NcxW3buCP6Q81-rR72MwRxhQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] serial: qcom-geni: Enable PM runtime for serial driver
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
        quic_shazhuss@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExNCBTYWx0ZWRfX4lWj+0RbJc1Z
 q4OLAqpxjQtn/5VDpB0Ea+gTbZEyh6A7QsncYbCDAApabXUYp3Dy+9pRTtIeHP4LuiqtH6BbZzD
 pfGTLX4jP0yoUvq5hyQ58DL76mC20LwNGEHGf0XLSYgHhM3GQL8E/pvKOhzOL66+npMl44JUFh8
 8XwYUQWm8TCF+TXjmjmmdnBkCdai4gv39LRuwan6YNEUTCg1ojb0ayt+08MaigKHEhjFLZYVDV3
 pB0UIkUL1Jqi7sv83u66iOT3JVJB41+HzZoCFYE60Vbmvn0pOrS4CutVfl34R4jcVjqQTT6CNYv
 c7RTvtIhFV0qsU1zrhmDdkQRBzfGMdz+f2iig2+Uamrh3HsTS/3IvpKgSJ5ocMAWTSUKWo7EV46
 aSIL2ThC7QFXTZrH92yeB06BdHylfVSaluu12z0r0zjteR/+oyaaLHsIuWYNqZgD3oQDHbVY
X-Proofpoint-GUID: RJYGvTL6ICkEietbWdDmjG5NscLVOc09
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=687649fa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=U3XR-vgVohVsxwl5X4IA:9
 a=QEXdDO2ut3YA:10 a=-_B0kFfA75AA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: RJYGvTL6ICkEietbWdDmjG5NscLVOc09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150114

On Mon, 14 Jul 2025 at 19:21, Praveen Talari <quic_ptalari@quicinc.com> wrote:
>
> Hi Dmitry/Bjorn/Krzysztof,
>
> Thank you for review.
>
> On 7/1/2025 4:42 PM, Dmitry Baryshkov wrote:
> > On Mon, Jun 30, 2025 at 10:40:25AM +0530, Praveen Talari wrote:
> >> Hi Bjorn,
> >>
> >> Thank you for review.
> >>
> >> On 6/17/2025 9:23 PM, Bjorn Andersson wrote:
> >>> On Fri, Jun 06, 2025 at 10:51:13PM +0530, Praveen Talari wrote:
> >>>> Add Power Management (PM) runtime support to Qualcomm GENI
> >>>> serial driver.
> >>>>
> >>>
> >>> Doesn't this have impact on the behavior outside of your
> >>> project? Or is the transition from qcom_geni_serial_pm() to explicit
> >>> RPM merely moving code around?
> >>>
> >>> Seems like this deserves to not be hidden in a middle of a patch series.
> >>>
> >>>> Introduce necessary callbacks and updates to ensure seamless
> >>>> transitions between power states, enhancing overall power
> >>>> efficiency.
> >>>>
> >>>
> >>> This commit message fails to state why we need runtime PM support in the
> >>> driver.
> >>
> >> Introduce PM runtime support to the Qualcomm GENI serial driver to enable
> >> better power efficiency and modularity across diverse resource control
> >> mechanisms, including Linux and firmware-managed systems.
> >>
> >> As part of this enhancement, the existing qcom_geni_serial_pm() logic to
> >> use standard PM runtime APIs such as pm_runtime_resume_and_get() and
> >> pm_runtime_put_sync(). Power state transitions are now handled through
> >> the geni_serial_resources_on() and geni_serial_resources_off() functions.
> >>
> >> Is it fine?
> >> Please guide me/correct me if needed
> >
> > Please start by stating out the problem that you are trying to solve.
> > There is no actual issue description in your patch.
>
> I hope this commit describes the actual problem.
>
> The GENI serial driver currently handles power resource management
> through calls to the statically defined geni_serial_resources_on() and
> geni_serial_resources_off() functions. This approach reduces modularity
> and limits support for platforms with diverse power management
> mechanisms, including resource managed by firmware.
>
> Improve modularity and enable better integration with platform-specific
> power management, introduce support for runtime PM. Use
> pm_runtime_resume_and_get() and pm_runtime_put_sync() within the
> qcom_geni_serial_pm() callback to control resource power state
> transitions based on UART power state changes.

LGTM

>
> Thanks,
> Praveen Talari
> >
> >>
> >> Thanks,
> >> Praveen Talari
> >>>
> >>> Also, start your commit message with a problem description, per
> >>> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> >>>
> >>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >>>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> >>>> ---
> >>>> v5 -> v6
> >>>> - added reviewed-by tag in commit
> >>>> - added __maybe_unused to PM callback functions to avoid
> >>>>     warnings of defined but not used
> >>>> ---
> >>>>    drivers/tty/serial/qcom_geni_serial.c | 33 +++++++++++++++++++++++----
> >>>>    1 file changed, 29 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> >>>> index b6fa7dc9b1fb..3691340ce7e8 100644
> >>>> --- a/drivers/tty/serial/qcom_geni_serial.c
> >>>> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >>>> @@ -1686,10 +1686,10 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
> >>>>                    old_state = UART_PM_STATE_OFF;
> >>>>            if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
> >>>> -          geni_serial_resources_on(uport);
> >>>> +          pm_runtime_resume_and_get(uport->dev);
> >>>>            else if (new_state == UART_PM_STATE_OFF &&
> >>>>                     old_state == UART_PM_STATE_ON)
> >>>> -          geni_serial_resources_off(uport);
> >>>> +          pm_runtime_put_sync(uport->dev);
> >>>>    }
> >>>> @@ -1827,9 +1827,11 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
> >>>>                    return ret;
> >>>>            }
> >>>> +  pm_runtime_enable(port->se.dev);
> >>>
> >>> Any reason not to use devm_pm_runtime_enable() and avoid the
> >>> two pm_runtime_disable() below?
> >>>
> >>> Regards,
> >>> Bjorn
> >>>
> >>>> +
> >>>>            ret = uart_add_one_port(drv, uport);
> >>>>            if (ret)
> >>>> -          return ret;
> >>>> +          goto error;
> >>>>            if (port->wakeup_irq > 0) {
> >>>>                    device_init_wakeup(&pdev->dev, true);
> >>>> @@ -1839,11 +1841,15 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
> >>>>                            device_init_wakeup(&pdev->dev, false);
> >>>>                            ida_free(&port_ida, uport->line);
> >>>>                            uart_remove_one_port(drv, uport);
> >>>> -                  return ret;
> >>>> +                  goto error;
> >>>>                    }
> >>>>            }
> >>>>            return 0;
> >>>> +
> >>>> +error:
> >>>> +  pm_runtime_disable(port->se.dev);
> >>>> +  return ret;
> >>>>    }
> >>>>    static void qcom_geni_serial_remove(struct platform_device *pdev)
> >>>> @@ -1855,9 +1861,26 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
> >>>>            dev_pm_clear_wake_irq(&pdev->dev);
> >>>>            device_init_wakeup(&pdev->dev, false);
> >>>>            ida_free(&port_ida, uport->line);
> >>>> +  pm_runtime_disable(port->se.dev);
> >>>>            uart_remove_one_port(drv, &port->uport);
> >>>>    }
> >>>> +static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
> >>>> +{
> >>>> +  struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
> >>>> +  struct uart_port *uport = &port->uport;
> >>>> +
> >>>> +  return geni_serial_resources_off(uport);
> >>>> +}
> >>>> +
> >>>> +static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
> >>>> +{
> >>>> +  struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
> >>>> +  struct uart_port *uport = &port->uport;
> >>>> +
> >>>> +  return geni_serial_resources_on(uport);
> >>>> +}
> >>>> +
> >>>>    static int qcom_geni_serial_suspend(struct device *dev)
> >>>>    {
> >>>>            struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
> >>>> @@ -1901,6 +1924,8 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
> >>>>    };
> >>>>    static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> >>>> +  SET_RUNTIME_PM_OPS(qcom_geni_serial_runtime_suspend,
> >>>> +                     qcom_geni_serial_runtime_resume, NULL)
> >>>>            SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_suspend, qcom_geni_serial_resume)
> >>>>    };
> >>>> --
> >>>> 2.17.1
> >>>>
> >



-- 
With best wishes
Dmitry

