Return-Path: <linux-kernel+bounces-822367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E1AB83A31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6454A2822
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E82FE592;
	Thu, 18 Sep 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mmz+ItoE"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CC2D77ED
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185959; cv=none; b=o9Q9Q0pgtt5bvX0CozvpmixrWA76s8sg8tBj3J/H4o5Bm018u2BQ+OjeXBZYZorzUeV6hkZdOjiV7MWZkvtzVNmaEbVGV+5E8Qserbm7cbutvmMGfItg0kxC5/BWhvfkn9fb/UEUFkNOhEcvK1y09OYI6mHxV6JJphxFKZUXfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185959; c=relaxed/simple;
	bh=unL9Ce+kEywQKcq5iWYa3vbSFUfdn9EBm190tWDHYvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjVm9WVR9BR/q4aRVYj6wCoKURLTW8wol696H/RkfNCDj4ViG4I8I9iIf5R/CuRBL5rC8tKETWqkk6Lhf7mtdEp8H3XdlOx2r5vh94bvtJRviqAxgAWW9Zt7uZY2eo+sSyB0YTVbpdlNDFyvxk4l+IBM2jqB69B8lK84sDiOpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mmz+ItoE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-33c9efd65eeso6237821fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758185954; x=1758790754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZmPfoqG0iiG2NY0syO47mgLNSYwy8f5A2cvO3evi8k=;
        b=Mmz+ItoEJ8Z5FZjMt2jY/aSr7oj7aThqxij0DZGgtkpV51YMDfs+oOc9pN7riJusai
         008GZweo55Nm685yDy89CgCNv9YeDOKh+QxA5J18FyL18fVpVMpf0hr84bY9bkv0QdXe
         jjk4S4w4u6AfRVBW7q3oYYHG1kTCA1RWpnXQBY/i+Gj3LC/M4fQ8I5eA0o6zDg9qOyya
         q88vhmkHR/nb5sXWLjHy35L4KKFutVNJuW1f48ojOQByMKnT/6ArYiu2YP+fF/KGIaYL
         MyGPQYCycEFTZ1m7wzspDMSqLBtc90IJsbX8WtVlT/2JJrqCFRa5Oxw925bubOrqktIW
         /tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185954; x=1758790754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZmPfoqG0iiG2NY0syO47mgLNSYwy8f5A2cvO3evi8k=;
        b=SKlLGcYSSCQPbCAEqlfZ/9iCElIKu7Gk/m9h6VTWCCgrJeEi/HWvgkbWx7n+ISP/QF
         22sMW3XEhamMSbOqQXvmrcRVQrbOsIy4BANg9ox7dw1O2YM81ah2otuW2Z0s4ufYq8Tq
         Ebtw3tnfM6hArJIYVOCMHtMbMy9rhI2EIhUP+8IQFlm4dA38/7yPxkdXmHkIgSaQA3mh
         4Dr5uPb5XZ3XaNtyzzyjJXO7kBG/2tcypaNekpCDCiE43xt0TllDktPhrxA2ru/hw2PL
         wAigQ0rdDNP0X0jFlEtXunjr4C0XZnZc76ysNC+tN731q4PJPNRQWfcoWg6VqXd0kUvt
         Wnww==
X-Gm-Message-State: AOJu0YycXpTTnuzFrjUC5veOfb1SuhenNQc42hnbfvwJCzy7KiZa4N8Z
	IT3rbfiL6hDYkGfSLpyX1V0OeOO0n3CcT1kVimHZKKxjymEN0M24nTsy0W974wI61IjEupU0dtg
	9URaZr6XGGn1RRBMacX9iISgywmQu2YYUaWN1/AqXKA==
X-Gm-Gg: ASbGncv6pO9WRR8+q6rKXfZ5Xh/xsRD8rtIC6b9VB0AqpL1oZ8E73Ijj3p2sfdqcA95
	d6svpEpZeCRfswGleq/zWZzHn1xBOZW4bxzXy1vqjyEhGCXBraHDmX//TPIa4KHI/uVI6ePB4Xu
	bpocNLxz7EH7WUqHAiiUs5k3CS34RAXBx0mheOqX9loTqShWJdHb0w/qBKq0kcwxzR35sgN9ez6
	puyWdqNLfLqQGL1Dse389uncyIZ/Wwoss9eT/f+mL8VXlZiCllosfiQJBA=
X-Google-Smtp-Source: AGHT+IE82AqZgCsTk+PY/JWZbreeNfzQ9NGfzRX+YkofNIG1aunevV+FhkpoCPJrFrn6mDCYgSk9k8Ijxcn1IEQSyeI=
X-Received: by 2002:a05:651c:19a9:b0:362:75fc:4681 with SMTP id
 38308e7fff4ca-36275fc4983mr4139801fa.29.1758185953688; Thu, 18 Sep 2025
 01:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905085141.93357-1-marco.crivellari@suse.com> <175743072839.109608.9014903338772554601.b4-ty@kernel.dk>
In-Reply-To: <175743072839.109608.9014903338772554601.b4-ty@kernel.dk>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 18 Sep 2025 10:59:02 +0200
X-Gm-Features: AS18NWDpfZjLQbuUq82kSpsqAhb5CTGCYTAr0k0mPYelJg4h9GAlfvANjno1wMM
Message-ID: <CAAofZF4ysVOA05j3NeieeyPgXjJ_43SEKD=mHPrCz6eF4qXhTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] block: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:12=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> Applied, thanks!
>
> [1/3] drivers/block: replace use of system_wq with system_percpu_wq
>       commit: 51723bf92679427bba09a76fc13e1b0a93b680bc
> [2/3] drivers/block: replace use of system_unbound_wq with system_dfl_wq
>       commit: 456cefcb312d90d12dbcf7eaf6b3f7cfae6f622b
> [3/3] drivers/block: WQ_PERCPU added to alloc_workqueue users
>       commit: d7b1cdc9108f46f47a0899597d6fa270f64dd98c

Many thanks, Jens!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

