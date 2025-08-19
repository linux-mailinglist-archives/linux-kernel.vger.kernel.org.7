Return-Path: <linux-kernel+bounces-775687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871EB2C3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC47A035F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A40305054;
	Tue, 19 Aug 2025 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOjNCNrl"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7C305048
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606407; cv=none; b=fzSG3OKAyci91Ki2OaoL3cOwcQzqWNHR42sw+rpvKp9J/RI78FgwbkFd8/6oOhVspDGz/JbFdNS+2WrXLyp3PtBUm+GVNXD4GS2z7XRJZtYO6eqL6BGG0E69QC2JPvPvVDqlboVkecCkuvByBtLVQhv9V2JIiyMZdpy1WT1P9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606407; c=relaxed/simple;
	bh=Vlqa1gfi8PbIVJ0ZFQ+7x7C5YgAYhufkg+Cs5+SorG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JxMl8WDustbdQbRLRCFJu5mkLf7Er4HIaPTIqDWzUbTEetUnxF0A5LDHQbKbEhsCVW5RjzW6g4SXwf2vZTHS7G6qP2iSx0QcKWg0gTeFGJnrWSumF39U2i/NFqpw9w605YlvlamftQ9atH8fTwDznBeufSlD0rMdFRK+Tb+i5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOjNCNrl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-333e7517adcso55786981fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606404; x=1756211204; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RH/C3wXmNI2h8jF1q3m0CdjAwRtlpdk2fFUGk3Jm2jU=;
        b=rOjNCNrl3JTYutgguN8zMX8ACVE3KY2eNDp3Mujv6EuUgwYxJ0KbdRbHJLeYNIGyI+
         +InBKEDcrI5mIzvV9fFLWWb9Lz2u2FSoQjvh1J1k0AJ9Aslmjr4qxSdyJObWzcomPJDv
         T32+b55sJKOdsfa7vosEj+tpD7E2mqVmcywCCBALiBZf4mfpW1REH0vP9jrARsxYF51j
         NYDsPUachiSYiS6FQvu4UMlwTlDIBfrBnEgPgY2f9ckQ7okw4igd6Bg1d+wVQvPMmuJ/
         lYRoLlD1F0biDDlFaHlf/HDAJKpoZXy3GYKNfjWfjG7bSCHpRINb7KhCRXq3W+te/0gc
         PPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606404; x=1756211204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RH/C3wXmNI2h8jF1q3m0CdjAwRtlpdk2fFUGk3Jm2jU=;
        b=IHww9iatNbLGhmRbOGbnNHfa2SK3Zah2hHtaTYa/nWsp6peNciG0uXi1V2VO7/q9jZ
         mfZ6lbn3BSzsw7FgHYk8GhyJTri/7+1a+MbbaSSn5rHmOXbGgPRq+oQQOHtBS3STVCDf
         XSHT9ZgQP45Va4Ce3KEvkN7MSZdFsk2DheulRrd9jq+wQlx2ysKJBdy6QQrV4YyOvX26
         oL/mGoOFdlCluaV+svCbuua6TF5CSuSdVqrOjXwJr6n8nUbVN4Om+kA2N0cyimXMCI0O
         Vb7V50qT02E8H2cD+BG5OtqJ5eJJQcsLDcg0VTwe3MiROTUkTM+jsYElezLInaZr+VxQ
         0TSw==
X-Gm-Message-State: AOJu0YzNl34sK5Hc/SJH/ou4kgY3xK1D2L/qwH1Bq5Kk5ZVWRaSjyLx9
	0o5B1ApcTG/6Em8CiNYT5xMzIEds7DEq/HAn6P4/O2UEGZ4yoOK95c/ycRR8716PZIuLhdAkbaG
	SPSUe
X-Gm-Gg: ASbGncvk8V81AhqjkeMjFgXwwKdXcC8AVk4S5GLsfpjI4r+Qw7dFeOtva+XrAYVW0mL
	Af0VllheedmXDlIYehLyCMrBUfJPHCTMnh7cC9NPZp279PQEPcesELsGaWJ1QIjFhlmOiwmbEKM
	g08NeP67+lGK/ctPBWiXWv0cXTJu9ItAuDde9c3CPBLT4XF7DYRz100CPGusq5SXFCPc4xf0uHS
	ouQXvxKl3xqDjIEvh/zVudsCOvHIYYekYBom4fFzJpsf55zbmOw+4NGoIc+pt62sGCTTo6iwMAY
	/3Z/Yy/jJv3HJwOi/BsOcP0aixKLhNGOcmuHZ2BvLAMdt2WgK9hRBH4bGIneUjvSzGGz6IkxSbX
	pZ4ZSpkmOm9OoBt4lYHgk5g==
X-Google-Smtp-Source: AGHT+IEopm7tKy//PR6tAZKXugwig1BvugMkJB89GGGoq3IMTwHV3jdUe5FZw58ERsomp4iOogHlRA==
X-Received: by 2002:a05:651c:54d:b0:333:ad65:c512 with SMTP id 38308e7fff4ca-335317ae048mr6645961fa.13.1755606403774;
        Tue, 19 Aug 2025 05:26:43 -0700 (PDT)
Received: from rayden ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a43a051sm22503801fa.18.2025.08.19.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:26:43 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:26:41 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE fixes for v6.17
Message-ID: <20250819122641.GA3486750@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers

Please pull these two small patches fixing a NULL pointer dereference and
memory leak in the TEE subsystem.

Thanks,
Jens

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-fixes-for-v6.17

for you to fetch changes up to 50a74d0095cd23d2012133e208df45a298868870:

  tee: fix memory leak in tee_dyn_shm_alloc_helper (2025-08-04 14:28:04 +0200)

----------------------------------------------------------------
TEE fixes for v6.17

- Fixing a memory leak in the error path for tee_dyn_shm_alloc_helper()
- Fixing a NULL pointer dereference in tee_shm_put()

----------------------------------------------------------------
Pei Xiao (2):
      tee: fix NULL pointer dereference in tee_shm_put
      tee: fix memory leak in tee_dyn_shm_alloc_helper

 drivers/tee/tee_shm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

