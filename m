Return-Path: <linux-kernel+bounces-813513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E9B54686
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61587A62F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552227602A;
	Fri, 12 Sep 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3uATJim"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32562749F1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668206; cv=none; b=iarJMY57OLK2yqYDbhTVPVsLaIbKsRqNvHEUE4R+9kVCOARqGELGhyxtfWiuqKYz0eziT9e+n6tjcHsonjysrLdb4CUqGCYdKhKg/oftrVq4EQ2TY3DqrbxoBcPd5Nd9cp/2upmSOPpM2U/yHwUitb+YRfARF5noT0jW69w6L3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668206; c=relaxed/simple;
	bh=8DqyAWrPHCSlw0Pa6kOyFtqUOYpuExdLnT0akgB7Nrk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N2x1YLXpUczJ8nzoFR8JgxuX8FUS0uPytV1Xe6npHHTSXfNSGEODhm9cK2FsyUK4ga3l0TR6qL0AHcZEQtBkr0F/7H2/ENTYrUmts9Lnt+ETQCxJyukM8ZcWPHnw/i5VGBsJ6jrxn1ESE1COER4vRkIacpW/hf/Hr0k16AUdO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w3uATJim; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b04ba3de760so219599266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757668203; x=1758273003; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdfBB7kobN4wJK8/RorJexdvYFnM7nbQB2ZHPDHvDh8=;
        b=w3uATJimS1Gd7FEoNV2zjKqAbexUTcYYa5+JE7/jxr9gpRdjZ9wDMO5PgDxKwOdb7A
         zQDusXwDss0Ly+i7HSIwv+g56eqkYL8kAkpBD2MORnbS/DLF9C6/F9cDsRuMOojLMg5s
         xVmHKxUBKsMPpFwDFTIP9rQCcV2b66/SmMiR3Ki1HgkAnrh+nT3DrlLokNRgFRBbTcvS
         a5150XVGvw2GjaDefgcmMYI23915pkzDdKoqEyLw9wh5AiPjeXNrCtWJdX5NtpagpwZE
         6c5j06jiMWYMSzhRmsNUi/nt804zTLfretpWrd0iyQxb4drAIvIfkkNzcsg6UkC/OlpU
         lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668203; x=1758273003;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdfBB7kobN4wJK8/RorJexdvYFnM7nbQB2ZHPDHvDh8=;
        b=ilwScVF1PUt57IztlHwDeQrx0Mx4B94x+UY6gR0SPwbTqz4AOpUjEk+JcO3DrAWwT5
         lIwtK5eIYLAbeQzmi7l/yVMWm2ig541rXioO/5DpYi7dEaJaA86UTwjJXlhqsyJYT3Xr
         /XO84reGSv10i1BZQqdBBUs5Hf2048sKllNtTYgnwhtbNZgs0DxwKvxmWpsbjAVYk963
         qdYqzUz66SxE4WFG19y77gzLmpopwweBNfDHu797G8Y1bdn9HB8XJ6Jqws0rqr5Jrx9f
         Mqhp5lSDuHoQKTMye8kUwdn3sXNZeFI8DTHLE71zao7vPd8FGZUjtseF1H3NjG5hGOhM
         C8xw==
X-Gm-Message-State: AOJu0YyFsVc/Sc3NLt0PPX7BSjELi17Pnq8e5El/RFJujuJluER9F9zY
	LFxJAynFH+JqZVTLdOZVepDTHOxCxz07luyTDyzHdf48yajuWo2wGif2lZHm9QoIFa0HP8s9fJ8
	RNgXfWrQ=
X-Gm-Gg: ASbGnct06e+60KGv7BKuXsofZHpoqRIKnLyhazJCbnlWSEswMjSH4peeajDkqrLWaAJ
	PWBkky1wDpJwgPSxosnDTNNau17mUW4B/EDWU8AwZfzBOrYMvFTvv5iIx050YL/DPzRosVkQtAD
	M6YjFCsPq5NppjVDid3WeGkQQyKo+wB/p+fSKQCbDiYUA2YX8IU46TRifQRGJ23aaxQvarbssLR
	jZOTMhKAoEQeO2ky3pOTKY2V5tIzBMHSLKhaa+CyhuAIWOCbf0VuAg+R68zcNNCe7AnifgkEwFJ
	xE0EhyeovJ527fbnevNKsxyB+AThtkmMa/ee90Ak2LYAlrYhEExf0t+sSdAmb5Lr4RPg7EfIHDw
	qAwiTcuy6I3p2q1g/bas27n/dmxfG91FlkBCwk2182r+CD4QyJRryNFvISCWF02sYTwcoRRm5to
	4=
X-Google-Smtp-Source: AGHT+IFuuHFceMoZ2ipUeSDV0l2sTDEKnIKxUvMqoFX9PBY3aeszRH7ix8zGbjWkfgqomp+Bhqsb2A==
X-Received: by 2002:a17:907:e885:b0:b07:c909:ceb0 with SMTP id a640c23a62f3a-b07c909d374mr116578966b.32.1757668203078;
        Fri, 12 Sep 2025 02:10:03 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c6110c27sm125678266b.66.2025.09.12.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:10:02 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:10:00 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE improve sysfs for 6.18
Message-ID: <20250912091000.GA1441709@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull this small patch for the TEE sysbsystem. It updates to use
sysfs_emit() instead of scnprintf() for buffers passed to userspace.

Thanks,
Jens

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-improve-sysfs-for-v6.18

for you to fetch changes up to 1faa0d62a19bb8a4b9022b603472e7127974cb55:

  drivers: tee: improve sysfs interface by using sysfs_emit() (2025-08-04 11:05:23 +0200)

----------------------------------------------------------------
Use sysfs_emit() for sysfs buffers to userspace

----------------------------------------------------------------
Akhilesh Patil (1):
      drivers: tee: improve sysfs interface by using sysfs_emit()

 drivers/tee/optee/core.c | 2 +-
 drivers/tee/tee_core.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

