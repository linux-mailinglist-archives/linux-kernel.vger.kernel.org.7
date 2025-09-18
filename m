Return-Path: <linux-kernel+bounces-812738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A53B53C04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F053B1F37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C42257820;
	Thu, 11 Sep 2025 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a4CJlwA6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E223F40D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617213; cv=none; b=ZVL3E2GyWrQ4I28jwcFGNOXoG7jDOi8thm0J4trWkDG3MQXIkl4wyqZkK7Cg/A2bura5XV/Pwome3N2hO1V6ec6AqMbA2kPwkQ63K05uIXx1CS/rOKEM4/xmpKlfLPrBpmyf3QYugoMgTw0YGkyx1+2/x1wZx/Xy9PkvrTvuwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617213; c=relaxed/simple;
	bh=jEuIH5ZZU/EeovpVRYUTQgyVitJw0q9Q0W9biAJS/lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIerG9V9KaTCPqaIFH9lNTt+CNwVgwMlxGSHKslkgd6Pri+mhjLt78MKmwt2sRi0D6yIE3YpRTOWXCAWgulTh6jo4tPJULX20FTvM+GixsEuJZmnJTeYimHI5oebndXxGutlgQi0U3aM8YN9Ph2IF/2QJ1FLPnLSP5Z8nhQXG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a4CJlwA6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77264a94031so830669b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757617211; x=1758222011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03MaJ+6ytyPItqY2qyW/Ajcv1dYvzwe/SXOVragEWgY=;
        b=a4CJlwA6VVy3uyYy7GblD9FTXrIHb3du8k7MPiIQOeNw7U7Du8t/SxkfXUsQal8lOQ
         MMB5JeEk+CO+6xCxtVm/wtcQuyoyUWnF1TvGrcMcT5gHd25nitXVwmOMbdl1jhIoXYMl
         tnwu3idsErMW9kh4uGukwd94ZIVr6mpIjvm9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617211; x=1758222011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03MaJ+6ytyPItqY2qyW/Ajcv1dYvzwe/SXOVragEWgY=;
        b=UcUUOzI0AQL2M+nnjMSonzd4czjubN5lbTMA1IIhjbelQKDXtQlIjicjHNBTrlXpKt
         V4oqX1vpTgufCj+8OOnejhDJB4LhmGNp5B4RIvsUp9hL/tY2jmU0887MIzvZg1bEONvO
         0UOlm5ZdlFlaupC/dCFYKFX2mW1v97cL76OkTqeuf8SuqEPOrZuJEt2Xv2ix/CVdkLZR
         m/oihkLGMp7oyZwqS+QZpFSpiiNjkkNVrqYFY1nm7xFWypCzQL5OYlpXjTY/23nJEPcX
         7PKu0TboPXDF32Fz4qY4ujhpR+l2EcbJTvv2UxWPvJ87HwfRVUK45WOKfSZHmuUBW1m5
         5aaw==
X-Forwarded-Encrypted: i=1; AJvYcCVGCvlagK3yQPxYIe9ZoI9IIIzvldzayDCgwfQoejQnPS+5Vtqz88Esh/UcG9JREAMCXPDNrJcHMjNVG9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjngJ7mq/QGsgCEF2mUU3qSykuemXabU3jBlIADjJxajfMZpV
	abfESqzAiEt0pqAkuOPCZPFlHbhoU/2+UiFXhjTQKozUF1O+YsIWmqJJGF4l3RCznw==
X-Gm-Gg: ASbGncvgQsWd2M94KjWAYVQysCHyei6QG1MvunYJ+Eu3mDNGVkAayMyemO2eC+Xm7sE
	5YIxMmHQiRTyNv21Mzt022msvHCDsZ3C2l//jEIK7NFGIV1erOfV6yxJddD8PiSxhqbjSm56FJS
	JAsgrmO2Y4yz53Ko+1XKZjS511NCUor8K8CLzrsJV+c/ONIG+JUapXoX5z/HIssgToj0VwWj7FE
	8CUOMFtHjKwMNC5Ul3hk3x5eh0lIofiRuP/dl4j9VjsG8XLhVmza05bJUHllUI3jEPiLF2tDYlB
	lW8nGhVeixFWCkyLLWoESNAarL9NlaExphwLjdQUqdR9qCbpq++AWG1Gz0466TJolmqw0uq/CDe
	oGfJaIs4hYpWWElaeHyz8m7vUopufOEi4Ip2oKux8l9ilf11X+MQOkhR6UVJzDTVO4EkYMxBSdV
	PSPzVC
X-Google-Smtp-Source: AGHT+IF+E6MG4K4ru1HMLDWmmyjU/+acTljGFHni8hj8gJV4DBQdRTFv1WxeplPA7OnCTPEFvHrPHQ==
X-Received: by 2002:a17:902:d592:b0:246:441f:f144 with SMTP id d9443c01a7336-25d27c2236fmr3853315ad.56.1757617209513;
        Thu, 11 Sep 2025 12:00:09 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:6690:568:13de:b368])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25c3b305427sm25200305ad.138.2025.09.11.12.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:00:08 -0700 (PDT)
Date: Thu, 11 Sep 2025 12:00:06 -0700
From: Brian Norris <briannorris@chromium.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	cros-qcom-dts-watchers@chromium.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Drop aggre{1,2}_noc QOS
 clocks on Herobrine
Message-ID: <aMMcNn82AmSavJYf@google.com>
References: <20250825155557.v2.1.I018984907c1e6322cf4710bd1ce805580ed33261@changeid>
 <20250825155557.v2.2.Idebf1d8bd8ff507462fef9dc1ff47e84c01e9b60@changeid>
 <90b13660-1844-4701-8e63-7fde2f093db0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b13660-1844-4701-8e63-7fde2f093db0@oss.qualcomm.com>

Hi Konrad,

On Tue, Sep 02, 2025 at 02:02:15PM +0200, Konrad Dybcio wrote:
> On 8/26/25 12:55 AM, Brian Norris wrote:
> > Ever since these two commits
> > 
> >   fbd908bb8bc0 ("interconnect: qcom: sc7280: enable QoS configuration")
> >   2b5004956aff ("arm64: dts: qcom: sc7280: Add clocks for QOS configuration")
> > 
> > Herobrine systems fail to boot due to crashes like the following:
> > 
> > [    0.243171] Kernel panic - not syncing: Asynchronous SError Interrupt
> > [    0.243173] CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0 #1 c5464041cff584ced692726af2c4400fa2bde1db
> > [    0.243178] Hardware name: Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+) (DT)
> > [    0.243180] Call trace:
> > [    0.243182]  dump_backtrace+0x104/0x128
> > [    0.243194]  show_stack+0x24/0x38
> > [    0.243202]  __dump_stack+0x28/0x38
> > [    0.243208]  dump_stack_lvl+0x28/0xb8
> > [    0.243211]  dump_stack+0x18/0x30
> > [    0.243215]  panic+0x134/0x340
> > [    0.243219]  nmi_panic+0x48/0x98
> > [    0.243227]  arm64_serror_panic+0x6c/0x80
> > [    0.243245]  arm64_is_fatal_ras_serror+0xd8/0xe0
> > [    0.243261]  do_serror+0x5c/0xa8
> > [    0.243265]  el1h_64_error_handler+0x34/0x48
> > [    0.243272]  el1h_64_error+0x7c/0x80
> > [    0.243285]  regmap_mmio_read+0x5c/0xc0
> > [    0.243289]  _regmap_bus_reg_read+0x78/0xf8
> > [    0.243296]  regmap_update_bits_base+0xec/0x3a8
> > [    0.243300]  qcom_icc_rpmh_probe+0x2d4/0x490
> > [    0.243308]  platform_probe+0xb4/0xe0
> > [...]
> > 
> > Specifically, they fail in qcom_icc_set_qos() when trying to write the
> > QoS settings for qhm_qup1. Several of the previous nodes (qhm_qspi,
> > qhm_qup0, ...) seem to configure without crashing.
> > 
> > We suspect that the TZ firmware on these devices does not expose QoS
> > regions to Linux. The right solution here might involve deleting both
> > 'clocks' and 'reg', but 'reg' would cause more problems. Linux is
> > already OK with a missing 'clocks', since pre-2b5004956aff DTBs need to
> > be supported, so we go with an easier solution.
> 
> Just to make sure I'm reading this right - the clocks enable just fine,
> but it's the writes to the QoS settings that trigger the hang?

Yes.

> Any chance skipping qhm_qup1 specifically makes things better?

Yes, it seems so. Or specifically, this diff:

--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -52,12 +52,6 @@ static struct qcom_icc_node qhm_qup1 = {
 	.id = SC7280_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x8000 },
-		.prio = 2,
-		.urg_fwd = 0,
-	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };

> Could you please share your exact software version (which I assume is really
> just the version of TF-A in this case) so I can try and reproduce it?

I'm not much of an expert on the makeup of QCOM firmware, but reading my
firmware logs, that'd be:

  coreboot-v1.9308_26_0.0.22-32067-g641732a20a

and

  BL31: v2.8(debug):v2.8-776-g0223d1576

IIUC, the latter points to TF-A hash:

  0223d15764ed Merge "feat(docs): allow verbose build" into integration

Brian

