Return-Path: <linux-kernel+bounces-803258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E25B45CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A06B4E14EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7D12F7ADC;
	Fri,  5 Sep 2025 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Adxer/jb"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180B2EE608
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086629; cv=none; b=egIzXwhsM/UQBSHur5NxYur0pb/8kBZsfJr7UEDuRq0PW56TFnLy3L81fxC+tUOcdGhdaO94oJNcR5joXyMEli7Ns3ULgkSznBbjK1NLQMQ12SjxF2OXV1Ay5gKY8VquLO8J6s30e8BV63j1/t6U6Ou+l7VIkTgRXPKfNhCMszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086629; c=relaxed/simple;
	bh=Kg1vnljwk728S3xcpj5uPtZq0cPx87y/XAxf6Mbkg0w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=QbsfUplvvX9vBbdMSWBO1hT8VuB1v8j9Rdv87yJGxva4Gh0n57kJxIS6uwx+5IH50lvKGGAHYIehbIKZqIxNu7M42UPqDqJlFiEJ8i9DgS6QhztfWSv2z5s+kw5bjMJE4F7l5q7V3N47DVWGwiXTyoLk9jA6QSQUeBtKd7gvFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Adxer/jb; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109c58e29so17598551cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757086626; x=1757691426; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8H2BgOZaIRqj4/CcuEuveM9YTYIhVsemNvoFOFsf3o=;
        b=Adxer/jbSeczynoeFKEXClu7cZMZCpAF3YLWX+s0HTBWs6TBpLyV2vLRrfiKsaIL+D
         ZhqpWBTavn9Db2BIGlnBvqmcOzF+JUsAekaEgCeJUNaUOhJSFPDZvzVMOHvs1SgKpkc+
         AqHd2pYm09ShlOUEubo9sDUSMc4cOwing3C7JUwsdbz9IWkiKFgSsczRcOMLXwytPuxi
         KuenPdohzMQWfiTAL9YTg/4MvUnlnFc0fLVwKC4ejK9wCe8q+XtUUpJyJojGjuaO+QO/
         807AVC+9b2a8UsjoH8Ki4j2CCxzj1IJMBp5zP1w9YFfVis/G07DkxoN6TNdR/fngx0cu
         tqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757086626; x=1757691426;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8H2BgOZaIRqj4/CcuEuveM9YTYIhVsemNvoFOFsf3o=;
        b=HlQt6zfZV5Msot3dfjABIDs/pAfq0TYJairEHp7Cumn5rgyIiXP6tbe4zEJZjCNgSc
         tvaWTkgd7Ufrimpq4I++fAOMD6RKhy++LUdAYKlmws0jb/m+djFAtFJhLZmKZzoju13K
         P91/gmCF+yjuONvIvM3baF9r1DBF+6ibbeci3LgENKtqGCFuO7th6bZrzOqZEiveKfXr
         yykoxRA62eccf3bd0OeeXmdzuGzgGpR41jYwQanqR1Wy4BL7J2n5+7TELcKLET5jPdzj
         8c3/Ro7xT1no5ARATuZ63oaBK5/TKgZ4EPWK9rkNBQn9oirpLCWlU3y1i51vAZ4AjBFI
         A10A==
X-Forwarded-Encrypted: i=1; AJvYcCUzcIVjtmlbIN+UDD5dBFUHA1g+gPDad9UKgBJ2bEhozJPaxfmtnqItIdRsBAMAYjrwc1rCp6dhXiNLABk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eYPVIDhNi++x5GmWuvUia8U8kTUaY6Rswrcge+aWpOWEMf8S
	FePWsUkXKlyDkJph2v901x3MvMGigZUCOwuuGkGh0r8qfZV5SMt67Z6R93uIJUpqYw==
X-Gm-Gg: ASbGncsTVWbo5C90ihSVLsx6veDBRxKIga/zsFr+OPZ5Ww/6kNs2s4Wit9AJiPbdXeC
	7ElDzfjC7t9nu28sAlGuD2kTpVdMC680vFHHYGPO+4msgX/xvQmlHhEiQosark/p7/9OUMZF3wM
	8TY9Ca3MDb6HgaIXM1k6ZwKPnFCypj+GY0oyll2uvsm9P4vpAVVo2XAeDG36PoZv6RtbAupk+eH
	7n5w796y3I0hKMxV3FnjeP0VDLmzP6qVEgYJ2G3N0r6s3UJjhcjkd8e9HKmvFGKmtFrrJicP1p2
	aM0FWb12nTs5RxEoUbY6500qhtlou0+dgCWlIPk8dMsQ2SrzP+Qeh7/xcLnYP1JNGWB+Y0IkNQS
	6x4PJZnqBFg5c51+m1yYCOIakI7MrzYAwsHxNy9169CeF7eFBKEv2PiSv8SY848F+GGlFTTocEu
	ip75U=
X-Google-Smtp-Source: AGHT+IHso3j+0e//Z9vqXwH7srvuoY144d5Q5A5/ORbPudxl8GItsfJbG1VzD6dz0JwkeY/cN1Uv6A==
X-Received: by 2002:a05:622a:5e1b:b0:4b4:56a6:42b1 with SMTP id d75a77b69052e-4b456a6498cmr110458451cf.47.1757086625566;
        Fri, 05 Sep 2025 08:37:05 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b5d57c6e0asm33881781cf.51.2025.09.05.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:37:04 -0700 (PDT)
Date: Fri, 05 Sep 2025 11:37:03 -0400
Message-ID: <6af833b45f68db4612ca52dd839d5662@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250905
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

A single small audit patch to fix a potential out-of-bounds read caused
by a negative array index when comparing paths.  Please merge for v6.17.

Paul

--
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250905

for you to fetch changes up to 4540f1d23e7f387880ce46d11b5cd3f27248bf8d:

  audit: fix out-of-bounds read in audit_compare_dname_path()
    (2025-09-03 16:46:23 -0400)

----------------------------------------------------------------
audit/stable-6.17 PR 20250905
----------------------------------------------------------------

Stanislav Fort (1):
      audit: fix out-of-bounds read in audit_compare_dname_path()

 kernel/auditfilter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com

