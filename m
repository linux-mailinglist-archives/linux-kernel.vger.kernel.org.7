Return-Path: <linux-kernel+bounces-811669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE8B52C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AF91B27DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866E22E6CB9;
	Thu, 11 Sep 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qi/qP6X2"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAC2E6CD6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580936; cv=none; b=tTxT8bOd+dTxKwnFekL2bpekmZH2+z/ORgYUIh0FEPjY7v+UAad7YL/fLBSdVO1b7+S5H0mfhopLBO7hh1iZ8yfX3GDeNUVpuA5uXHv/ynW5ue2shHpzn+eCcJLFDF+WTWPzCo+/N29cLvH6/V70ZUBea5jbIpjUDrugDbVNqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580936; c=relaxed/simple;
	bh=M47QY/NfD1t8+b59LoSOFGOa9gmx5lXv7/Ws+sM/WKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MT6/4XbMtc8A6hiqdbTynha03BxhnLgWuK1HzeCmIkpvXaInLbGJDn1NWtKrsRh7Bhv/vANxMUPWjrFXkUYHANxDcFsgiRvP/3fuBksvMlnLLtUFjQhphoKPY8EPqPkraqq8j2DaHZin5UrB+RDfjvHD0YCDD5Mr88LzMiuMJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qi/qP6X2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b046fc9f359so77833866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757580933; x=1758185733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M47QY/NfD1t8+b59LoSOFGOa9gmx5lXv7/Ws+sM/WKQ=;
        b=Qi/qP6X2PlCdGI54tl9rGybKZr/ms9cVB5GS+sxFQz7jG+UJJtUxKxOaiT+iE+jz8Q
         A41qzx/8+HTsnKeTnNolQgz34A6v2TFynwc2QHs1aEHoGEiS6uYgiOcrcl2ZqbF/vtOj
         b8e/XnPzrHrWdCOijX/wzxjbegHsNLHWewLzQnOMjbsliVTB9LnEuo4a88/6C8hSip8+
         y50bwKHQAE4VGWu300ukZ1/xHlzeenSLjvCnvsEXY896yNeG0ISCNa/aCwLEIHzZN/py
         cuh7rcVEmKLrQXdRrmB0vqIKAX22dkvGCBn1A5Tsh1mKF6IswDhoG4CFGDM9TJ+pi3h7
         5UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757580933; x=1758185733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M47QY/NfD1t8+b59LoSOFGOa9gmx5lXv7/Ws+sM/WKQ=;
        b=LS94+Avrpmcklf+1Zq8o0HoB5oJY4GAwmKZs+de1Wcr5QTILPBzOHM/kBvqnfWa6+v
         H8gV/JIe6vI5rpYKJexX0RW27x7urOq6VlmW7cnoWiH5d+U7AfUTnY3dCqRFBCAC5B3t
         Y4/S65z9PLwTdaCp3ZoY92uGKqukJDjwZ1MYZeLGH3UGPdHxA0e2unCnkxhTs3tpEyzI
         11gzPZu4DN2InXlMcx/oHf/Kz7XW2cqiVWA41Oq99iNqgVNK+2oBLjymEuyUx3hvJqya
         V7SCtjejzZPf/mbCIk4fWQGpGvACEwT2Mh1MTh322wB/S3IxxE6B1Tm3pZDVPNebVbJh
         MMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxHpSiqAhP4CV4oAuav6mcKr/hbntqUkp0EHRIc1yuV+O9NqVQwOkZ4RGAx7oU7fJ0TlMQhH1Vj+cuV7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYbf6jwbY7S03yzLWq/OwDAzuOG779ZsUchlO9+hdoj0zEMuZ
	yFxdcwVq8xS6Hu816cxXLOWYeNaTJcembqzl+/ZYEzdu2rpEnbd58x8RiLjw/tGHEKE+iydCphA
	VQP8OsRthgcbzKVj9DM1VE/dYTAa6Xq15eL2+5q2uPQ==
X-Gm-Gg: ASbGnctJ4e8pNwWuQbsS2Iy/eruNM0csAbyMS7gxryJgGgLsP8X9eo+WKfI5vZPN+xQ
	0UCrgQhirkXRQqMUgSlLeQsCaGNGqbyVDx195ePUBiOTxsMrQ6OMB3OTxRQW69fF4hcbJA2R2Jc
	gxChRGx3LWEnxcTVmJHYAOqKbuhpgU14HiyMIeWJkY6AjCOEPWzoi/W0hWevBjBLO4L66mUVBrD
	divYX1KAmy5QVIsC3hCllAXYG6iTXgtkwElYKr5yETQWaA=
X-Google-Smtp-Source: AGHT+IEcucGnPEP1XUJA4OYRlZfyQvXxfLLy3+O0ca3G4KP0AmdyrjngQ0kDvLX5T4++ajGH6Xf9tedXcjS5da8adSs=
X-Received: by 2002:a17:906:eece:b0:b07:88ee:f23d with SMTP id
 a640c23a62f3a-b0788eef6d2mr556748766b.43.1757580933322; Thu, 11 Sep 2025
 01:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com>
 <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <1db2d6df-16ff-4521-ada5-da585b87b06f@os.amperecomputing.com>
 <xhsmhfrdblnp3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <916176fe-ad43-9dd2-ed1c-6f05f838d491@gentwo.org> <xhsmh4itjlnnt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAKfTPtCtR7Q6PxRRXGxfKnhyPTODBGs5cFRVL6A0nHx_GnpA9w@mail.gmail.com> <cc41029e-ca82-bf3c-0cb9-c7bd907a4680@gentwo.org>
In-Reply-To: <cc41029e-ca82-bf3c-0cb9-c7bd907a4680@gentwo.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Sep 2025 10:55:21 +0200
X-Gm-Features: Ac12FXwtszdWLBX6Dh8VqI_apYSKu2ndy_qlHXw7xU6Z9psC3oqRS0-HEGqrwwQ
Message-ID: <CAKfTPtB3cyaYDPdCWjdPAsWcKTZCxw5rbWsS+AZ2sD8_FhgDhg@mail.gmail.com>
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for ILB CPU
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Valentin Schneider <vschneid@redhat.com>, Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 22:44, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
>
> On Wed, 3 Sep 2025, Vincent Guittot wrote:
>
> > > AFAICT we have (at least) two options:
> > > 1) Trigger NOHZ balancing on a busy housekeeping CPU (what this patch does)
>
>
> Isnt there a third option?
>
> 3) Trigger load balancing if on a NOHZ_FULL cpu and multiple processes are
> running on it.

If there are several threads on the NOHZ_FULL CPu then the CPU has its
tick firing which will trigger the busy load balance for this CPU

>
>

