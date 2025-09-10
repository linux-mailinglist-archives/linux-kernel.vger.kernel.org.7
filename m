Return-Path: <linux-kernel+bounces-810173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CECB516E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66591175A29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25D3176E4;
	Wed, 10 Sep 2025 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5GE7C3d"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B731A067
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507311; cv=none; b=HaSHgudjdzMIJGGZM0coIjAX/KVL1q+EpbutWlC0BYh123Q6biXNBmHlG1WMWykvhGfePcQv6qWf3fL7S/gqsbpw94v/BLPVWJI6fQi4YGq2srGpoK3Tz/lsqsxA/M6akezwchGYyb+Tbgp0NdMGkpRXWkJQODz/jVVEMS7O64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507311; c=relaxed/simple;
	bh=xr+pHWDpFhG101gZJW36qscUm47fFzwtzUnoWeWDmLY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ib1wKAEvdnPc3EVXOFmF3pwPUfu6sR1vyAdh6fl7PNxVQGoZ8qz6SE34tK98vkQ1/t8ZuRfzhPxNNebepeE6HG9fDMyQCLQXqRZRU5NI83y5pwXe70AciXLLAphUMZCxyOQK0gXJaw+PPcwY8wCx7e11S6MFgy1yhhhmh2WGbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l5GE7C3d; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77250e45d36so5881607b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757507309; x=1758112109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uKKz38rJoChd6hasvypIOinRdsvj7L3C/cH5A2UhAis=;
        b=l5GE7C3dJ/JUFsuAQJ4aaeKurtCtKAnlEFMprKqNZJ+/ZLB9IlR0GSmxOeuxvdSB2L
         8fSb7iU+9/+tf/O14nKK92dojn/fKfeSIIV6a1sy+d9oQxWDfAdqYxn3oa4admdir6u4
         ZqhqStWxuMfK2NuA0IAbloU3TXh+Fs2RsCdY1db+JiPNBekQmwf5WhutRkuj1hs4/BZ6
         D93QLuXm8xT1NdiXREHvHMgK1B4ubx1Swnva5ckMnUoXHqRgvvS+GvdUGvWGw9eBr18x
         tDc8u+3hQeOR5EXKC9JVfF/f4Y+brypIATG5Jlj8L/S7/VoABBKbeGXUgaDMTet0364q
         KNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757507309; x=1758112109;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKKz38rJoChd6hasvypIOinRdsvj7L3C/cH5A2UhAis=;
        b=ASsrFXN2K0dzQbVD4XWaKlOodHohLiFqBNX1aU4VvSv487+In35haQPCVk7xmxNDOg
         OMz07ku1G9hyQ5sujwCKJrQM3Aod1douiJaSN7yRIky635Z7cRq7zjkOpaINDq2/v3FB
         MjWeCHf3q0YLzwhqFcLbuBojVn8nNhMeBBiFinC6kErM2jasw9rKd8lmeyZLaMpEfiK7
         oLtgnpYRihHU1CN/226KNmAzGLw0vmz6RN+KOKdKdsVC4bcR/99226csfkOQdPIZpoy6
         sCH168fGVJAhcENJTxK3zMu1UAPvfsZGN/LhyyP9Cpa7VJalnkDdj9ZwA31KESlbGwcV
         +Mxw==
X-Gm-Message-State: AOJu0YzqNvDC7ZBbBxrxOr7tblNkgrwNpluuknuONR4goCFZ/N7U7Z+t
	sqyhemrurO9kAsLwaJ0dAR0D2eLL3lwdDoEaqOsx/vTKkg7I2T1uYYzRwvv4TXR290E5gSgbRNH
	ba/o7uU14SysyubyXqBQx+HyvOgyYw3/Ji4iAPxZgclEJm//DUhFr08M=
X-Gm-Gg: ASbGnctSAaajUS9H5u0sc2LrVDRv0M28rPnTgEjF4CvlLBVLNNJaqgxM2OMXRTVZ0hP
	b24xDgT6Hq2LUmmkxDbmeaN7l5ZZXO8snS5DDtfjevOjOgT0EIjsXDjtEVNP56Y1o1CUNJmg0Dd
	22Uz2hM9CX0T5Qq8a3JDEZ/9c1n5rvgghZyrF9ufd6U1UlNgUbCGhjJorDm07u2qErbDcKiVzxb
	fPSlvfkwnIRdfceOIsgXG762mzSN/LuJB6RbN0Tf2vTXa1qKY11k6N1AP8YU8Usoi+N9SAMqcmy
	DdzVYrtDu5Y6DODUrg==
X-Google-Smtp-Source: AGHT+IG4qzDgYzLw61c20CouFv01sBXpB434aIve9D/nBM4iCZ8x3Y3u0nVvalLiKmVp0DIuV/6ujgGhDDoSGv7mFtM=
X-Received: by 2002:a05:6a20:734a:b0:243:b38b:eba3 with SMTP id
 adf61e73a8af0-2533d225e5amr22112020637.20.1757507308800; Wed, 10 Sep 2025
 05:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Sep 2025 17:58:17 +0530
X-Gm-Features: AS18NWC_Ip5gUfztIBhg-V1fX8vYtT8uTSYaRWdst2tMKb6IDGdmP3wp0PVgMdM
Message-ID: <CA+G9fYuW3VZHpAzoL5pRXu6_K9LMHynNzMO9ULrdsC4UKY-ELA@mail.gmail.com>
Subject: next-20250910: ERROR: modpost: "typec_switch_set" [drivers/extcon/extcon-ptn5150.ko]
 undefined!
To: open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors are noticed with arm64 defconfig+
with gcc-12 and gcc-13 toolchains on the Linux next-20250910 tag.

Regression Analysis:
- New regression? Yes
- Reproducibility? yes

Build regression: next-20250910: arm64: "typec_switch_set"
[drivers/extcon/extcon-ptn5150.ko] undefined!
Build regression: next-20250910: arm64: "fwnode_typec_switch_get"
[drivers/extcon/extcon-ptn5150.ko] undefined!

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The suspected patch, (The git bisection is in progress)
  0d6a9aca15c987b4774f7fdb34114ab0d483766a
  extcon: ptn5150: Add Type-C orientation switch support

## Build log
ERROR: modpost: "typec_switch_set" [drivers/extcon/extcon-ptn5150.ko] undefined!
ERROR: modpost: "fwnode_typec_switch_get"
[drivers/extcon/extcon-ptn5150.ko] undefined!

## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250910
* Git commit: 5f540c4aade9f1d58fb7b9490b4b7d5214ec9746
* Architectures: arm64
* Toolchains: gcc-12 and gcc-13
* Kconfigs: defconfig+lkftconfigs

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29839409/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250910/build/gcc-12-lkftconfig-graviton4/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32V3KFrDCJV0h7Mw72c5hdncTEL
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32V3KFrDCJV0h7Mw72c5hdncTEL/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32V3KFrDCJV0h7Mw72c5hdncTEL/config

--
Linaro LKFT

