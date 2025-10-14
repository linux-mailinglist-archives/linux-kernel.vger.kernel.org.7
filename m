Return-Path: <linux-kernel+bounces-852523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0205BBD9361
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9A9F4F94AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72F310779;
	Tue, 14 Oct 2025 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L480XCLC"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE130FC0E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443466; cv=none; b=MTdo8rR3XhGsyWv4LjAE8bEw6CnZrLW8kMecOCpOxpTHllNOG5BvyiHlMGsa20k2jotqCBzFHKHSgZnPWhML8FmDX1Wno+ljTJEy8tbWh9YBIHUbBIKmCnB7Qp4TC70IjH074zxAXWisuLbUfXgh4UibThbRYlar0lx84drK7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443466; c=relaxed/simple;
	bh=2ZZScwbmkYA6J1yeM8HzNg5etplUf9/M0NH1N9A6LTI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hu3/nD2mHA3WtmJdK+50utMcV0Wc9XceVNsTrlmqHyyU4LJYo8A1AK9qLYgSzn6pHrp014qEfFjbFV9+h5/9Uo7n/ijVTfSHeOIP6Yyo8/Ge8Gl0GO6WWXxAv3StT5145jTteuseKqMhOpOuqpQ9onOWog3Q2q8gtj4cufJR+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L480XCLC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso6156740e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760443463; x=1761048263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wdGlYc6E3hJbaF1YEB8DLPuktLI6fILuO+1oFLSvZkM=;
        b=L480XCLC33Hia8FLbvhZJoVAAG5ak6CrrWMccvp8ou0iWNfxmYrOXH0QHTiDSIR+6c
         ZBWJzZCQQKWJhC/WiUTIPbs4sh+MCydudau15l7BISB+foaEwdxi5RtxL60H4tpzened
         NnvSODOqnmcW/2UGFd9A+M410rbVz8KiGmtc+f1Nb92uhcY30FKfVRs/62rRm1DKvYpo
         PdI4m7vH3UiXQiOaZ3oTfZ2yLsrALlgzZGps4kcTrWLZZFwMqquQnyny+YAmCo4kOVPE
         ouk2pTlzcx5ue0Pd1T7+uDGtb/7/gX/8m7PXE5ZhK+pwOqEObKhhGheHVDdCMOR01rZJ
         bH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443463; x=1761048263;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdGlYc6E3hJbaF1YEB8DLPuktLI6fILuO+1oFLSvZkM=;
        b=rJ8rS6FmWBgTaHUJophFH98mvq7kLEkVjc01nd5aBhxqKT8Q11OvnrhShC06v1eEV2
         QBMsqpWwdZkUg4JG9EIfRFd+x+UsYcswtLUYAYyx+uK1aYaH8ZVMpFaUfYWgpxa2NGuh
         2VqF0KeeeB9qbQCmYTQFUuX46J4DodKvakf+spI48nsH1eFdQAbM6dLgeRYyaDh8pakI
         1OQMTMk4+7zlAeqMj1Gi9NSqA19gB2fDGUzJXlzSb3PzyAib78PdPkJDok5XQsr0tdL9
         SueZguHSHCDJmCyp/oAUQRjrJ32SlYyC+xLUHL9IhoGZyTj/7wG6LZ0RDD0rjUa4AAXy
         74CQ==
X-Gm-Message-State: AOJu0YzDySJUIcn/EkoAc82ir20SbZr6m5Bmox1w5B5jlymtBxyavdYh
	bFAt9bZ8aSdoUsGK+xM8NZSK+1xbdeFhgclI3n+8zZODbVUHLmtfcdsG
X-Gm-Gg: ASbGnct7O+/JW2q1xsMmJV1Eb3WFL7EXIS9kdQRTK9knM3a2FPJOIxSnw7o4ok3EUfY
	d4mgbMa/ozxl6JZplsoNf4987fPvfj8tpjmCFK7XHTvMedCd86V/3lyuJG5pdwkt2P+5e/nN0Ia
	q8zWf9BJh+F/CSrA2Kq2XuqiP7+pfZCEj9L1UTppQvK8k/VbSSj8cQ8nWM/lvjCU5K87DOjvO7x
	fNpMORbd1kXcbLZ7kvzADrnQhNd3sGsKBoxsoCfnRzCT2e/28v15Ag0jf/1Y72xPufXUAeEJ/Y5
	eXw3K3uJZ0y1R1jvwxcxrQCmA0hdrQCMivIMpieN8YGjnVQUc7LWBD0L14c15ZwEb50Qg5WCdg+
	Q7cHibVhMLrB9tNJ4Wi0p4ftCu2ZbDaoazNUr9Z1a1NH3
X-Google-Smtp-Source: AGHT+IF//DVuxiAyoFaLBp/zSWTHwvjjwrFInr62GmJ6IuyiwBJ0xs6dpvVys5j66394cJtJiy8Yug==
X-Received: by 2002:a05:6512:33c9:b0:588:d2d5:8cfc with SMTP id 2adb3069b0e04-5906d9e8fbcmr7447930e87.47.1760443462958;
        Tue, 14 Oct 2025 05:04:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088579e01sm5215324e87.114.2025.10.14.05.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:04:22 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Ulf Hansson <ulf.hansson@linaro.org>,  Shawn Guo <shawnguo@kernel.org>,
  "Rob Herring (Arm)" <robh@kernel.org>,  Angelo Dureghello
 <angelo@kernel-space.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
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
Date: Tue, 14 Oct 2025 15:04:21 +0300
In-Reply-To: <CAOMZO5DmzokFbmucbcDg73CKzaz0vVdMgnfLdBapHFLWVzEqpA@mail.gmail.com>
	(Fabio Estevam's message of "Mon, 13 Oct 2025 21:45:26 -0300")
Message-ID: <871pn5pu4a.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Hi Sergey,
>
> On Sat, Oct 11, 2025 at 5:57 PM Sergey Organov <sorganov@gmail.com> wrote:
>
>> I'm not familiar with the code and can't figure what exactly I'm
>> expected to check. Could you please prepare a patch, and I'll be happy
>> to apply and check it.
>
> Here is a patch you can try.
>
> It's not a formal patch yet, as it needs to be split.

No, this patch doesn't help. Still doesn't even after I added the
following (maybe overlooked) change from the original patch:

modified   arch/arm/mach-imx/mach-imx6sx.c                                                         
@@ -32,10 +32,10 @@ static void __init imx6sx_init_irq(void)                                       
                                                                                                   
 static void __init imx6sx_init_late(void)                                                         
 {                                                                                                 
-        imx6sx_cpuidle_init();                                                                    
-                                                                                                  
         if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))                                                 
                 platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);                    
+                                                                                                  
+        imx6sx_cpuidle_init();                                                                    
 }                                                                                                 


-- Sergey Organov

