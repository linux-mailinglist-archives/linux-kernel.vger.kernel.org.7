Return-Path: <linux-kernel+bounces-818503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB8B59298
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551501BC64EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBF72882B8;
	Tue, 16 Sep 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM7JYwCk"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508329B783
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015894; cv=none; b=Q9EJ0GERPKN2NmpqsamDFxokwCcwdhVnP1MA9ac+kvmaMKRisbDRJ/qnZnFmyoXo4pQvZVe97mDs5iohsUwNrHd73WSmaLS/Z24Yl/eMrr7F7mQjXhmgQsnyCJEM0thJG5PZ4cHv82Cql0DELCl3CRs6XJYSoPCY3HkCQwaAYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015894; c=relaxed/simple;
	bh=rWMg8VEWcM85DWEptIhmba6a8tD6L2NbTPWw8hkbPKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4q5AFBN0aBzoxIw+xFERoCNdN7QIy2FSiV8xmdD+zhu+lvCJ59JL7Bp/kGERPftklcb34jNbXsNWN/h8OR2aB0Y1kXqwtDu5Fdg+njManqCIJeyhOtrvvDjhKwcCNSD695d8k5+i+7YZfbTM4wYwmh3vjcADzJyO6PT5g/u40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM7JYwCk; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-55f74c6d316so5217559e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015891; x=1758620691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWMg8VEWcM85DWEptIhmba6a8tD6L2NbTPWw8hkbPKA=;
        b=JM7JYwCk8MI20X5jTQ0ZrciRaZEpJTXcf8BFab5R1zxpcdLwLZrrep4u3hODMOqXDE
         HZqHZpbxsO3JZvNHbgUYIvCd7tnMxHmjq8PHlO4HefWCIz0u3z4WTN65I72BAaNwTlUI
         wimB237tzUKZ4USuO3slQTBPARdFJnlpuiQwXjeKbH+Fc2DRm6w2j4oOBrvMBCyguyud
         BUGCBb3LeYKspcP5Ig5or7i8TSUTlwVovHEX1vMGY5ufpvkW6Q/MrCRM9KtaqMuklsjF
         +Y3ktfOj5HGpkQ3mGcj/DeG1vNeX/pez7GCXmqI7ejcHrBBos8EpTsRt05Pip2suT/WB
         +m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015891; x=1758620691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWMg8VEWcM85DWEptIhmba6a8tD6L2NbTPWw8hkbPKA=;
        b=HlLu8xEqadpii9oKBj7wnX+DJBjoSOCV7rc1ffsQMQnet/KW8ngOXV8XT7x8d2pKX8
         d5aHBpXyqSiEzxgIPWwsoGYOpjQIThXgaAmQZnZn+e1nBFMRE3pklBwrqEhtOV//b6wZ
         1MfDBZwcwTKcQHoUf5/kOqi8z9v0JcK4emM2wsgLuVCyKifcsqnXK7HK6Fr9l+o/eCqJ
         TbFACiO+aacQwq8IEO6cge8lCzignZMsO0mLLzMQ+M7Fb6ZII5LL9nx5Yxf1rjlYsQet
         KZCyyJ7esvsYkBF7w+qK5DXqQqaAN8/DJo7602dOCCSyUwP/ro6pgpzhc68CdzTzkcuu
         Zgcg==
X-Gm-Message-State: AOJu0YzD5WM4RDYZYNWsuJ+3z3oRbEBWPExRNfAGLxzQoWyPUVoYRZCK
	kRhYYvZ7Y2QlvEFHrICJn8INpS4pJVeX3JZPLXAz+3A8axhlb6WISeVshf1OkS78JyaUgL1FLub
	QjVBIkqZ0FujyF9FrjLN5iT7aGv1UjozrzM6cVpEMxg==
X-Gm-Gg: ASbGncs0Fld+h6dVxHVYzFzJ/5INsgX2agIHOCKyM9TpU/0gzhFTH0tzxUsfHS9sdZE
	0/Pd+3vPz+xORLbTIepA7TItU4l7ufRG1s8OPe1QpEMtLinwLJoIyo+0qyWK6049vx8JLoo6CT4
	LbIwc7gASxNUejW5Xpx4Ri/VrWsXx5N2Vlz/bkDaYE3LXsJSlG8jZ//f4RYzS3gYjyRfISLuE9D
	PD/X5W7
X-Google-Smtp-Source: AGHT+IGDCwUlrtu3acFFVeHclp5eLMQBTi6rJETQdQl3emkFAKwWznktwde2gmw/aQImyjRbz7vTIm24Y3Zc4B1eWIE=
X-Received: by 2002:a05:6512:681b:b0:55f:453a:59ea with SMTP id
 2adb3069b0e04-5704d006f5bmr3754239e87.36.1758015890444; Tue, 16 Sep 2025
 02:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <CAKfTPtCyL=ofg4yLtfG7zsoBMDnP48KCeUELT_Hddd3gnWeYEw@mail.gmail.com>
 <CADHxFxTkexicChcg3To4=AsX8c+s2RNWZ5NfA9UBLMfYRZtmKg@mail.gmail.com>
In-Reply-To: <CADHxFxTkexicChcg3To4=AsX8c+s2RNWZ5NfA9UBLMfYRZtmKg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 16 Sep 2025 17:44:38 +0800
X-Gm-Features: AS18NWCHWXFE3jwEt9fKuUrSbN-s8UqX3OeitUNkpU1acXi2EnNQiggM1CfpmQQ
Message-ID: <CADHxFxTp3sMAwsJvwJfPQ+aD2p2Jk34wAvJGSzQjK+EypO43tQ@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, bsegall@google.com, 
	rostedt@goodmis.org, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Just resending this patch for review.
Any feedback would be appreciated.

Thanks,
hupu

