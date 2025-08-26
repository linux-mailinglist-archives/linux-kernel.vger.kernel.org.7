Return-Path: <linux-kernel+bounces-787037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66EFB370A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CD117FBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDE2C2343;
	Tue, 26 Aug 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rl3mZZCB"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F528A3FA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226381; cv=none; b=ebldnxEZO2T1z9rTC44CFmc22pDVcVzPGRZfPvM8GLMFh48wbqjWUgEJAP1R9XF0iGB0CGPNxnDcwZlA8F8qPoju1rCCn7QMKYseRjQUk60uFaDlRPjoR0AZFl8vfTLtfkStdyjU+6GB71lrMwt1ATfVPVB7x9aNQ0Qp6M4+PSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226381; c=relaxed/simple;
	bh=n6+7p1fdJVuXTAshZJvAA2wH82a0EPrQuroIWx1J500=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhEJY1BE8F3m2NjRGsGFMRQT3RoV/0aAOid5lv/IQo9RwiG73LIYaZn9Sig6+K4kqS22kP1jTIx2qGk4rvNV+TQ6eayTnVZa9CE709WTHX/IO2BQsAfDWaU04MnSL7jevcAZCWoARREvaONt5jh7VmZ2tDWCZo/siqj8Di8QIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rl3mZZCB; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b12b123e48so3931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756226378; x=1756831178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6+7p1fdJVuXTAshZJvAA2wH82a0EPrQuroIWx1J500=;
        b=rl3mZZCBvYpKIZC+pviyYf/UtQXQu/M0DRqH/+k6SD+5O6viuBZ+AHY/F99z89sE2b
         j+0YytKsL1/KAcJ92Qj5xUrHowUUFb4qe1CsQVgGXVmefgwh/fXAFQFHLYjLnXAoZQsj
         WkqVSvT7NGMlN+/xzL/Y4VapvBeqm9ypNFOcqtbqomcKvUwu/y0Mq5MlPO+oFBn/9E1A
         gc5uPiteLQ4soUeFLdIQ5pq46EUTvUk3dvTMf+zvCUeRAc4jvoNr7hhpH0ITMRwK6MLj
         a1n/AtC95yDXpbHjQToD5Hqrx/zEEXbEcTA4LJtPYqqVq51h3G04qcK04J1TyPHbyTCj
         Vydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226378; x=1756831178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6+7p1fdJVuXTAshZJvAA2wH82a0EPrQuroIWx1J500=;
        b=Q3iWsfuNMBpeyDChCXlUdmJTRrEgLOwELqvo7yi/Ah4OK7InqNltHLQ++Hx/ivoT0p
         NYtW76mQUxjKw6J5wLkYtgkgR2OZUPN69QqpuFfH7HHn+O+FNbH+dhEqyjtGIo6ZPLB9
         mAarRIRoQp9yro39o3OrFp6YhyQhP/Avk4oGUWYNmbIdjyFLjtMFKdnXv9oXZI6Rk72V
         cSrIKcf8t6U5dLMQJ1ci5SDYV/KGkwF7V8irLA7/YW8L9dYJAiJuonNyamr3FiHw3gLa
         y36Kxwc/FY0Cn/1KnNLcqcYJDHPHbem3SGNwhhdyKNxo8kxp6iMTLU7WiuxPgBi0dGkI
         xUJg==
X-Forwarded-Encrypted: i=1; AJvYcCWNQvAM0aBBBcGESMsGBM5BNIj9E475UiRAV7DeAyijCZS/67R6M8q5F5pAYo+C2Ohte99axUR7r1CpU/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CaochRO47Asr1gFfmsIXt1V+UQb/3fArNeZRJIvUvWzpp0Co
	I0TrdKmTYcCZ12dr53TYub2qNI/oOJHgi51T6MzYWwo1YVwBhduWLhUOxOoWpmXMgRsr1f0Vm1R
	3AFbcluupkrYMzR374ImZH5mxlJkrJn6/rIuMujT+
X-Gm-Gg: ASbGncsi2iopqHCiRTifr3iKykKWGL999xxq81c7F8eQjdaNs5GlnOeEIPXmC7kSu73
	l8MC28aOijqd214K32FVm4/N/FlgVw4HjfZoW6tUhCpvdWLBK3ceEpt38z9+2hfpOR5CaepRduq
	XW7VKG1Yhp9QWAYVjbx2YsC31Xit7dKdGBCI/Udog4emnj8Ct/BZEOMlf72vd2DVpJzqmQ97vYO
	de9qRB2MQE=
X-Google-Smtp-Source: AGHT+IF9sFSkQJt4rZArtsNZy1iqLIVeCHcZ45BnpLXmrF76YrOG7Z45Enc/2KRYnJiWYQPQ41/HruRPhQB+b8/iQLc=
X-Received: by 2002:ac8:5a49:0:b0:4ae:d2cc:ad51 with SMTP id
 d75a77b69052e-4b2e2b6d63dmr6262141cf.1.1756226377856; Tue, 26 Aug 2025
 09:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821094717.573232-1-zhao.xichao@vivo.com>
In-Reply-To: <20250821094717.573232-1-zhao.xichao@vivo.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 26 Aug 2025 09:39:26 -0700
X-Gm-Features: Ac12FXwtorRfZ_FzjnLB-SquF7kNHgSDOAoCJgOtfd17FUtw_9L-I2qwTVXlIms
Message-ID: <CAE2F3rBg+m_iVpJN+raoto2YV-0g1WFC-JNtuZV=OjarHgL3RQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Remove dev_err_probe() if error is -ENOMEM
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:48=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.

You could mention the following commit which I believe changed the
-ENOMEM behavior.

2f3cfd2f4b7c ("driver core: Make dev_err_probe() silent for -ENOMEM")

