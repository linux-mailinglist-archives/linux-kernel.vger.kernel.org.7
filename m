Return-Path: <linux-kernel+bounces-892794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B96C45D34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2A2188DEF1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CF5301711;
	Mon, 10 Nov 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gV1/bSjj"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC2288C20
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769429; cv=none; b=MnV0e5YoVadkgkr4ifze1mUBeCfK3TJqdAsQi4vuuf7n1+Grw8Vm6OPL90WCRcGEbdUjyL9lfjVOem49rHcStXn7HZ4VdSG8BvoOsDnFNeFeMSvbzFZkhlwRsEgstezYW/4niYV0PTcg3gauCJTBuIaw2Bo/tXixON6l/Ykghwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769429; c=relaxed/simple;
	bh=TVNJZZr3jfoE3UaQeU9vIu/zRILJt+76GfhotihG2as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNrWqzkLqiNFOI54Oy7ZxDaLkoII6xgdJOwu394W8dkWUk+rD4wPLqEnHNKvswEB8vIazOsFcEuiyV2QbqD71/4PiMFKLz0UP7sCFhWQ4GNPQum+UcE5/TnoiHZ4U6Kqj3yb2yn7bWwZax57yBBvFzE99QDtYXrCcrvrlJA7DPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gV1/bSjj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so4775907a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762769426; x=1763374226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVNJZZr3jfoE3UaQeU9vIu/zRILJt+76GfhotihG2as=;
        b=gV1/bSjjQDmhqfKzDZna1AmdciSFeMUB2Dmu8RC/BLFZXhgu4mFYvYqAS54oVVdoF7
         9svHwWS2ysGZzDrlB9FrHQVWSKjZfFaYxyCCwim402EJjIbYERmkKg2fwgGNL3qIZUEE
         UlnZ5Nn0sJSJnavi0vfeYE/6cGNbMtuwxiyr1XDB1R13PIYTCVJbxb7xE5Szwl0yWUuW
         StadOyWt/B5kyE+eP1H5pQW/wY2BE3cm6vkAbaL6Va0xx+q6ktGfkI6K6y/RkN9DVnY8
         lER67QAduNzdc78KHTDSfijSjedl9GPeNJ/n1vnh4zo/zfc3Hf5Iv1hOU7tWqh1JyZ6u
         bXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769426; x=1763374226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TVNJZZr3jfoE3UaQeU9vIu/zRILJt+76GfhotihG2as=;
        b=nGw69W0clSAmiJ/DIQLoiWwYrGMPkJ46SCyBMiYFug9qqcGEprDI8ouvHpKXeFirC3
         zEOiY7JjS510QpNp4GgI5g4TS7PeW91Uk7nW/TBLMRnNxkA2mzgq9NzBHGUh/nkvvAex
         UkIz8AQnsGEgOFcbFgkwN+u6cHWArSPNK6/Wlzfg7xZoje0pjivH0hf2TmBRMkY2AjeE
         on8DsGh57tPsb41+YiulDJu8j7f6bcQorH/+ViuwSRxMqHZkkDQIJJLc5tPtmpg8V5Vq
         vQKJTerotX9sbdpG8Hrb4VJ6UYZKKjd6CBzviEHBmHEsir78TrOc2ijGiQeC2oVm21QW
         U+5w==
X-Gm-Message-State: AOJu0Yz32WJDENGpFSdoEhxZsz3EtUAW6aPu03UUAXssuaW9vC79mBO8
	/rLtfGR3AOHzMiaGEWhlu5fmczNvA6xl4/OrVak0xA6n6Tksu+HTWYjcnSPCpNP7opHEgkQDRIJ
	o2UF2ETTbW2H80FPUMnW2sNKlT+5BdINkozChKE+bKpzOw6r5KntPjmM=
X-Gm-Gg: ASbGncsoA8lpN4Bu5CbMqJygmNKd2bmyvdjqmgk0rieJgbb9LDKz89oQR022JLXYgJg
	0tBRKiVEQPIgvYwoMIcghZGnXslctA5MWEqtmX91NXfDvJIr1W2uRSRLZrk3NxOZG2YDw43UvdG
	8UYWNE5zh0mmTP1cL1+qiWhFmjYOUXK6Eopz+s0RvWLbVi5kRmds1qnKCo11/ZL113pZjbe51K+
	Jv7b7/O6K/h0ifcGELg3HAnBZU8MZmj5q8xLbEOb8JilDGutopIBl4yb/YgO5J06MILP661cpXQ
	Cngh1e8CcHYvluQO8A==
X-Google-Smtp-Source: AGHT+IGLwnDKdWKGCP0miJmikH8pE3adQ+9Q79EIKvxvM7XnoZfAmJ9m9kW2+rixfd9R6Gmcxrv/ZQn64iRasSw5Kj8=
X-Received: by 2002:a17:907:80b:b0:b72:b495:828c with SMTP id
 a640c23a62f3a-b72e04e34e4mr902549866b.30.1762769425768; Mon, 10 Nov 2025
 02:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107132712.182499-1-marco.crivellari@suse.com> <20251107181156.GA4041739@liuwe-devbox-debian-v2.local>
In-Reply-To: <20251107181156.GA4041739@liuwe-devbox-debian-v2.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 11:10:14 +0100
X-Gm-Features: AWmQ_bm2G6CFuK2AUoQ3TkVXCY83KDhDqqtXzP_vMgpx2r6nNOQHc5dY63iflb4
Message-ID: <CAAofZF508p_6Jy4idPkbFu0r6bvf3x2SUQrH=nro+a125fBmkg@mail.gmail.com>
Subject: Re: [PATCH] mshv_eventfd: add WQ_PERCPU to alloc_workqueue users
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:11=E2=80=AFPM Wei Liu <wei.liu@kernel.org> wrote:
> [...]
>
> Applied to hyperv-next. Thanks.
>
> I modified the subject prefix to "mshv" and added a new line in the
> commit message body to separate the first two paragraphs while at it.

Many thanks, Wei!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

