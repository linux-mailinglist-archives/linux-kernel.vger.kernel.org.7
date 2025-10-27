Return-Path: <linux-kernel+bounces-872550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBAC116DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883DF560B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547FC320CCE;
	Mon, 27 Oct 2025 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDC4r4pu"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E331E0E0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597792; cv=none; b=YOP5Wstz2G9yAo/YDWFbLxBx7ygGMBgGfCJBFJRkMhNavrmqjuIksYq1JK62qjNLOGY+65ricj2xGUJ3LFxTfYE8lpYgYCjA14k8QdFRCuuWDfJw/XbMtBFiK92pUvzEMGzwNJfRwBdRFMrpeSzBFN9M6P4ZKovQw6pa7+4nvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597792; c=relaxed/simple;
	bh=k5b39RXPDJ5BYh+OwHPJH4XO8iHKjeIZIHo/utsQOxs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:Message-ID:
	 MIME-Version:Content-Type; b=jg1WhqPW+Mx1M5xx2qxVQXt/ifqysUC6KPgzktVkg4HUfe0vz1wdP7KgdN3BqDLk+cjP/XaOe8x0wqMqyz9JcCh677qOitiLg49AJ4wJsFdOt/k/ALHJgmhVAEQCEFnZztrqQWs+ZvNkIaAo05Tv3hs9lbhll2GeilVH7Aq4jIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDC4r4pu; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5930e30857bso778298e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761597789; x=1762202589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :references:lines:date:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okRlCKEh1MfjlJlesALJbMijX4uc5792JeQL3RZlLvs=;
        b=nDC4r4puvbBUV/Yz8ea4qXa5kKHlANtntJ5U6aAq3jQG5clEo9Z0wF2CGiYwUXMdzh
         3pneDV6IV1TDY+CqKVv+qUp838L8O9pxH4f8F8SYKF1PXSWcNt8b0PPGa9HNgd14Y5Ys
         RZ7ZmScOeIlU/WoubPoyQgBv7da9bLMGHgyIkYEXx9ClejMXSe26bpkhUO44QDDLkDMb
         0S5/n94ueuQ6eo6ZqmmxKyxzjZd/iLywTr7LixpiKiE4fmfoIDRKYfl3v8dL5KEn1r3f
         dkMJGyq374ceSVTPuNxbuecIAeDtRTb2rmPT7Bbcy2nZe0ZXOx9zKvfEpvxEHeXLBtVl
         Rssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761597789; x=1762202589;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :references:lines:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okRlCKEh1MfjlJlesALJbMijX4uc5792JeQL3RZlLvs=;
        b=TxiGRkkoIfYMH7w6vHuDXz0wWnlIHVMRRNYrXlAAL49iNVFqnkY9Dar1qGtG9LHyEq
         Vg+MI4pqMatfk2pIYj4EviQJa6Es6s/+EpMrvb4wpYTrxBs18F2uX51nN4r1+5Yj3HzQ
         KyVUI6zBz+34LVXn6N8hxLUUTHPJ3tTlEsoPgU5gbUeGJGVXK+e0vc59AIsWJ+WcGXlm
         J5Ne8/iCnvl+U8JozmL2qlZbJpqRN6Ye6GtATgjwtVfYPIe68pGJmXmUL8OjQfucxg9V
         lg2whL4rPQb3JaWLfi6SfF/rnBOsrSkb2fv19/jU5bfHzMBQwAK8TeW/G+CfI0omrzsN
         4/6w==
X-Gm-Message-State: AOJu0Yxnai4aYhsLdxkXG1023RHgloGkRhvFvcy3EdLxoJi9goBPH62a
	vTpg8+aOlgmH5a8KCVpwtLIS8RnIIpo+D0R5Kf8NhT2pK3/KKmt+cWUY
X-Gm-Gg: ASbGncuhh8qAIIrTEU0HUnFgDQYXyYGjLN1IKFU/W1ytrb877tG6/UroY8PNomWtvoG
	iTnhGYpdN/EDXYuKz7Viac5Bw5G2ZJFqiA4jk75am02o2G/JRydPpMRaWokq7d3Eonc+nD/RF+j
	LKJ+tNCRvB0pLDt7NaHqZOww7XloGQvfQMv2QB5CCNLs4JQV43gZlpVMeJmlBXBWkQUxNCkgq0i
	3H+NMFHta41HNx7kNYv9pt0N9BQNS/8Ww1L6m0BMgTWJVXQg05aPdASzXkkiJ7XWYo3S2zmHg13
	uVh/8oRTUfkYVIZHNVGS9txCbxlrRWG+VqURvmNPSipju8bshpLuBS2matSOhYWw6SoMO88o9Fg
	L8eXv9wGateOx4AESt9qp3iDP5bXEtIAxEbEwYETlIEA9yS62d7ev362NyhnMHcHTfoX6SH6KhK
	WrsAM=
X-Google-Smtp-Source: AGHT+IHXe5SBWETJCg8YDUS867FHiEdEeYaCkEONCJx3VfogsjoGbYsdrV5XHjWSmQ1gE6q7JR0A8w==
X-Received: by 2002:a05:6512:ea3:b0:591:ec59:2d71 with SMTP id 2adb3069b0e04-5930e9d4b19mr436143e87.30.1761597788223;
        Mon, 27 Oct 2025 13:43:08 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f50661sm2509701e87.33.2025.10.27.13.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 13:43:07 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Ulf Hansson <ulf.hansson@linaro.org>,  Shawn Guo <shawnguo@kernel.org>,
  "Rob Herring (Arm)" <robh@kernel.org>,  Angelo Dureghello
 <angelo@kernel-space.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
In-Reply-To: <87ms5lqn1e.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
 21 Oct 2025 00:30:05 +0300")
Date: Mon, 27 Oct 2025 17:39:59 +0300
Lines: 80
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<87zfa016bd.fsf@osv.gnss.ru>
	<CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
	<87v7ko11iw.fsf@osv.gnss.ru>
	<CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
	<87plav2186.fsf@osv.gnss.ru>
	<CAOMZO5CsY-zRPE4hm=1kdTVquY24Y4T3evQrn9E792xZ434vBA@mail.gmail.com>
	<87y0piiz04.fsf@osv.gnss.ru>
	<CAOMZO5A2YMQQV8J6jg2o0C3qeFif0fSc5j6-98xhqNz=Lk4T+Q@mail.gmail.com>
	<87ecr9upfd.fsf@osv.gnss.ru>
	<CAOMZO5DmzokFbmucbcDg73CKzaz0vVdMgnfLdBapHFLWVzEqpA@mail.gmail.com>
	<87ms5lqn1e.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Message-ID: <87v7k06ppg.fsf@osv.gnss.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Sergey Organov <sorganov@gmail.com> writes:

> Hi Fabio,
>
> Fabio Estevam <festevam@gmail.com> writes:
>
>> Hi Sergey,
>>
>> On Sat, Oct 11, 2025 at 5:57 PM Sergey Organov <sorganov@gmail.com>
>> wrote:
>>
>>> I'm not familiar with the code and can't figure what exactly I'm
>>> expected to check. Could you please prepare a patch, and I'll be
>>> happy to apply and check it.
>>
>> Here is a patch you can try.
>>
>> It's not a formal patch yet, as it needs to be split.
>
> No, this patch doesn't help.

[...]

> I'm going to dig into imx_4.9.11_1.0.0_ga branch again more carefully to
> try to figure what's going on, and what actually either fixes or
> work-arounds the problem at hand.

Well, that activity ended up being almost useless. Even though I've
found yet another patch that "fixes" the build for my board in
imx_4.9.11_1.0.0_ga branch, it happens to cure neither latest mainstream
kernel nor NXP lf-6.12.y branch.

For reference, the patch is:

https://github.com/nxp-imx/linux-imx/commit/fe3aca041b0b8042d59bcf1d9169109c9220e783

I figure the only sensible option that is left is to try to actually
debug the issue on my board using either the latest mainstream kernel,
or lf-6.12.y by NXP (which one is more promising BTW?), but right
now I have no idea where to start. Any hints?

Also, could you please comment on the issues I've raised earlier, to help
me better understand the state of iMX6SX support:

1. Documentation/usage-model.rst suggests "interrupt-parent = <&intc>;"
to be root node property, not of /soc as in imx6sx.dtsi. Is this
essential? Anyway, shouldn't either documentation or implementation be
fixed to agree on this?

2. intc: in imx6sx.dtsi is interrupt-parent of itself? Is it a mistake?
If not, this asks for an explanation in a comment?

                intc: interrupt-controller@a01000 {                                                          
                        compatible = "arm,cortex-a9-gic";                                                    
                        #interrupt-cells = <3>;                                                              
                        interrupt-controller;                                                                
                        reg = <0x00a01000 0x1000>,                                                           
                              <0x00a00100 0x100>;                                                            
                        interrupt-parent = <&intc>;                                                          
                };                                                                                           

3. Some nodes have <&intc>, and some <&gpc> as interrupt-parent. Could
somebody please re-check if it makes sense? Besides, "gpc" is not true
interrupt controller, right, so what's the matter of having it as
interrupt-parent for some nodes?

4. Suspect cycles in DTS:

/soc/bus@2000000/clock-controller@20c4000: Fixed dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000
/soc/bus@2000000/clock-controller@20c4000: Fixed dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000

Are they to better be manually fixed?

Thanks,
-- Sergey Organov

