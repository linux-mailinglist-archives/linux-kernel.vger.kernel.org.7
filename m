Return-Path: <linux-kernel+bounces-775698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF95B2C386
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE88D7AFAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289A2C11E2;
	Tue, 19 Aug 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jq0XH1Fb"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA5305057
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606563; cv=none; b=fbx/g0cKYguQTcYRWpLSidmsFRnhaugW6PolGdyj/WLkC5WasfSmdbAhBFYIvDxKWimplYy8BkSetl/g3YuyujeZv15PUZ1IYSaTngqMCdMymOTyvRI3sVUkC0yb7tdH7epUK9vTx/BdEOBBb8zM32IRBLrZQXkzphHeD21DgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606563; c=relaxed/simple;
	bh=VzpI30UkeawZmaVqAnif/Xf8jsvVOdlincz/DMcQfeA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bDZVoqorI+6wswZypeWkHHYULQ241WigLrhZHIKCsWWmXmci8s+gBnE4hrC/oGfkunIE7V+S9maYVk49a1J4yMKAAPx4gu9QhGSIY+bWbTeXl1N4eQgphSsu3Jxs2Nc6/8IPU81dh85So57ZsvrWoQdMIjJupSttGw9M+5gRtBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jq0XH1Fb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55ce521f77bso5290596e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606560; x=1756211360; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UipPaNtmeiclDOI6M9CPZuTeZBFQiA+rXuvCoDGD8Ek=;
        b=jq0XH1FbPLEsUHwurmzFfKMikle7CFbN2cioPXH5UREf1HxHFjHSoWVucLQXATo+NT
         I307De9IW1KbOUL/tmA3qkSxKAyK+T2RNce4gmjxkeUX98iJ10yYYDHNNTEIzXV9f/OY
         aITkgb8V+YuqYN1cMQT08O0ZaAOHMGwOp1NB8Oc6LtmVKO4iB2ycAlod1cJveSBdzpwS
         ADRE/PTP4s7trSg2Gw64wc3DWoY4XWOkeYy3JenVW+wy04jm1zb6MBmryH/5ttOHJweK
         0tMeLXJMoYzGXDtD2a9DabOmx8r94kQevX1vGKb6pwUeAsyC1mVi4AykW3G9HCcFKPFi
         zg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606560; x=1756211360;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UipPaNtmeiclDOI6M9CPZuTeZBFQiA+rXuvCoDGD8Ek=;
        b=AY/+ck7bAYFdt+z/0Q9OiPZ4Ox99sdAf59YXYQX3HgPnISP6FNg21pIKzdRUgr0/0F
         L7Yp42MUQSRQFHa1YmU7rtNYyRIcigm+miVD5X+AOA4KgKFLeWrmeL5YntM5Jj5GJ62G
         KDoJ1b4e3zzeMD4+uiM1ylAFWXiJH3ryzTDsNjKBtZYHL2RXKQFhEAbebhxImJn8BjB7
         eH6oUhpM5SlJZRMObUBC2NeYX+7egAncw35dP1OgCDkLDTcviDN2V7kxx1leaj700AU8
         PDkvwlBkKvmH57ay/UEUoPQZJwrfVbhbdfwvICLZeajtSWNnhrrl36IkfSgg1VssT+4B
         vkBw==
X-Gm-Message-State: AOJu0YyfS1Jb1EF1hnh7fe/3a4l9GO1oBEie5DmKm6Tuxk1b+4Qay6Wj
	cElUoCEKfjIL6M4ofYt0+DsE5y6vhJxmN0ipHNH/j46GjPlTIM9b/Ss+y/ikFfLH4Go=
X-Gm-Gg: ASbGncts60n4XBII4Ds7RORIG8aklA9vwHX0a0WsGBGoCDA/eZ6LRRhALxp3ubIchB1
	f4C9UUA2cRggUOaIpO2fefqOfs2LOrtCrS1z4OabvUrYp0+BTe8/Z/7X5vBwFLIG+j2sdXVOwUJ
	aLDhvxkwRogiYfLUPynKVOl95YAQuJ/Kcme/QzQwahlWXThVEd8ZmejqGMBS5S+gFmtbxnpjsS5
	Bd+0AnPSIjYaUx3o0TzFIxRmq70ufub7tArsno/bgpFdsGVd35gblOLC+b6mP9t7GS60WO1INR4
	hcFddkUCoA9tC06qlN3vwhlejRzNUmNqKoDhfpDvq4f6if6HVfuT1MMw6V64fVMPvm91M1Q1dVw
	lEE2/p3k/Zw2VdFqvZSbbTw==
X-Google-Smtp-Source: AGHT+IFha8J313pxWbqhKQOw7U03tO4cI6VgHA9135xIQnSuHavKRTIlRfvQUn8KhNwo4cxLJh4h8A==
X-Received: by 2002:a05:6512:6318:b0:55c:c98b:39d3 with SMTP id 2adb3069b0e04-55e0086a835mr622415e87.52.1755606559962;
        Tue, 19 Aug 2025 05:29:19 -0700 (PDT)
Received: from rayden ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35145csm2136867e87.26.2025.08.19.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:29:19 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:29:17 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE typo fix for v6.17
Message-ID: <20250819122917.GB3486750@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull this small patch fixing a recently introduced typo in the
OP-TEE driver.

Thanks,
Jens

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-typo-fix-for-v6.17

for you to fetch changes up to 75dbd4304afe574fcfc4118a5b78776a9f48fdc4:

  tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible" (2025-08-18 15:05:49 +0200)

----------------------------------------------------------------
OP-TEE driver fix for v6.17

Fixing a typo in a function name.

----------------------------------------------------------------
Sungbae Yoo (1):
      tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"

 drivers/tee/optee/ffa_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

