Return-Path: <linux-kernel+bounces-790434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88EEB3A71F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA831BA77D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428253314A0;
	Thu, 28 Aug 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jqsx+q2z"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BE32C31B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400273; cv=none; b=ZNt4tvY4wAeRyNyRPrpDYvqi1tpR4+P9hFp22Gln3sJ8q9jkPczCpcdWm4ZY7+a543mlXLhflq1VDIJdQLSgV1e7ErSC3VKEW5zXGvzY8WQi++gS0yxx9nI+Hi0Zkax9Prc3t/C0fXN2D8G8+UwbIBIK3t8pzsZKgK/glkLTm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400273; c=relaxed/simple;
	bh=nCg2nwi14+lPzAfgGbrrAYpMMC6kupWYt2gn0gu1knw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvDWKJR9dovDKf+HnghjPAvqxAF6rRofYFRB1jl4MoYEPHsTF2bGHof+lWf3XwoB3OWEnQ1MfCw0eHPYuwQDIfQ5k8M2ON/HXnjwdWueInp5rKmTVGids1DMblLT7R9kYPfQ2wAbs8U3L3G6nIjnhTwFdd5pK2JKJF3EIaMN8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jqsx+q2z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f4468326aso182e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756400270; x=1757005070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUlxTvNnxWvVbwi4g/Jm8/uE0pr83dkev1JUOpqywAU=;
        b=Jqsx+q2z1/wIo0bt8Hi4q8xHj4xjEYWVOF2t+wyeqz7ErYYHJg19vNwwpy6kAJjelr
         aE4QUfYK3E69mZ1AbBxrvvfVQdHidgMz2wHN8eLerkmksqPXm0FSDhSkTGH70Mp+widb
         CAerc56TozjwD3M/DRaD5V3ZUW+m/ftaTK8/qjGb/m0Dbe6YYmJci9tD3AjXTIgElU+0
         7yKTxFzhcPCh/7Is4k0Gg65yuWSsL25gvVceU4zQNeZq4Zm0QIev2LULfxyAOqWfPJ19
         6JDo0dE70Yd6f51nGO7sfuWTsgzie7uwh+7htqHB2WDXwObBd+i1br8/AsVjnjkm+bzr
         /wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400270; x=1757005070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUlxTvNnxWvVbwi4g/Jm8/uE0pr83dkev1JUOpqywAU=;
        b=T5dLvtAO5ahUJAXtGPS7M1HjLd2IyRSXZHFTMZnQH8fvSIpzV0AqMKI7F9JSR5v5DG
         M+7zN78W1a7KOfE70mBnFRUsyobU85wOJFOS4J5gZIqanknQCPUGk9JznOIXwkJ3Q6Nr
         KMD+Kl+LknD85tCdZjQH9na0u48ve2NYe5KFNHYueCZ4uiCiCAGb0mcgHXbStgOU3acj
         pt8Of44li2qR/LfUXoGNGBrWZ6vdOIEz434jxP4MbYw57LmUzwVPJw4y8SDF6i6AbptW
         +MffZyiw+uNJB5xFwvJlHds5wcxt/Wc30lVKkLkHYxK1k4dwaUQ0ZGIsFZn4bztrNKQA
         2Uqg==
X-Forwarded-Encrypted: i=1; AJvYcCVlfsis3DMtjq0Qh1Nam/cpJTYRDXex1z/g1iX5DjE9xY4cqjeHeWANFApQ61uZXzxFwUzWgKESN6ijMCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVF9OhUsynnKfnlckdT++Z1iJ2PgJaTHuKlLWb5bp2ZIdkdcfq
	VAGTSZx98dpvxO/ggUztSVYLsTgP15z/Of2lAUo/YdjJzcAqSRs/XtYAJ4xOT+B1GtI5alQGPLN
	/gRpTzNL5/Hk1FNBXYXAzXpkjMvIljK3jZk77g4K9
X-Gm-Gg: ASbGncsRfD4PX0nuHcEk7usgwAuRNxZTpSIH7jVeC6umsTFmTi8/bsteL3G/KTlUF1J
	u+7TA+WPMs8jWA27L1rGuDFjoKF/Ppfgfc6EKaYRP24Y6xRrQQpVluGQLL068a4aEjhZLBie0/3
	llzi0jP70PoA01pMgLx/p7txBUUIpEjIT/wTbkdFddEye2gEbaj21nrt9cvIS0jddsc4UMn3cSa
	6ykV45EjhYxAzasdr3Y9cjnrw==
X-Google-Smtp-Source: AGHT+IEA+x+JHJGxAKqi3gf39h+cXrxl4F1cPaRjmHzOLyzmMNWf5vB8Aw2K6CCK2muVk+ohncKOBj10rKhlESV29Zs=
X-Received: by 2002:a05:6512:609b:b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55f4d3263a2mr1010554e87.2.1756400269844; Thu, 28 Aug 2025
 09:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 28 Aug 2025 09:57:37 -0700
X-Gm-Features: Ac12FXyD8odEoc9_-KKAReVcf86GdG5H51-cMjxY6Bgpf4RvXSnT7vL1DpsIvFs
Message-ID: <CAHS8izPU7beTCQ+nKAU=P=i1nF--DcYMcH0wM1OygpvAYi5MiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection framework
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	asml.silence@gmail.com, leitao@debian.org, kuniyu@google.com, 
	jiri@resnulli.us, aleksandr.loktionov@intel.com, ivecera@redhat.com, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:50=E2=80=AFAM Arkadiusz Kubalewski
<arkadiusz.kubalewski@intel.com> wrote:
> ---
>  Documentation/netlink/specs/netdev.yaml     |  61 +++++
>  drivers/net/ethernet/intel/ice/Makefile     |   1 +
>  drivers/net/ethernet/intel/ice/ice.h        |   5 +
>  drivers/net/ethernet/intel/ice/ice_lib.c    |   6 +
>  drivers/net/ethernet/intel/ice/ice_main.c   |   6 +
>  drivers/net/ethernet/intel/ice/ice_tx_clk.c | 100 +++++++
>  drivers/net/ethernet/intel/ice/ice_tx_clk.h |  17 ++
>  include/linux/netdev_tx_clk.h               |  92 +++++++
>  include/linux/netdevice.h                   |   4 +
>  include/uapi/linux/netdev.h                 |  18 ++
>  net/Kconfig                                 |  21 ++
>  net/core/Makefile                           |   1 +
>  net/core/netdev-genl-gen.c                  |  37 +++
>  net/core/netdev-genl-gen.h                  |   4 +
>  net/core/netdev-genl.c                      | 287 ++++++++++++++++++++
>  net/core/tx_clk.c                           | 218 +++++++++++++++
>  net/core/tx_clk.h                           |  36 +++
>  tools/include/uapi/linux/netdev.h           |  18 ++
>  18 files changed, 932 insertions(+)

Consider breaking up a change of this size in a patch series to make
it a bit easier for reviewers, if it makes sense to you.

--=20
Thanks,
Mina

