Return-Path: <linux-kernel+bounces-778819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF0BB2EB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75783B54D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F842D4B61;
	Thu, 21 Aug 2025 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaSDnzkH"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4328466E;
	Thu, 21 Aug 2025 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745263; cv=none; b=L97nFO3U3a9rXq18TEpP7TnWlBxi8Zm1EPm2JNs/uks5RhG6/+Qd235aMH4utsCXN9b8POHx2l67xOmQjIAWsc0Cz7k5kIRJ+M4iRs55Y0N37/FGr2Z+2b2wbFlG8a2xMlfD0IcWKgnPmegWw2J6O5M+hP5N3dDMINCf7PLTurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745263; c=relaxed/simple;
	bh=Wnj4zpvupDfJwbDnmrVHBhHb2H+f2JtBrQtLkPCOY9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imWcuum4dREZog3aErTxOAhLHn6cqcJQRdvvAfeU0IDqVFfT/4KXxoHEifPHTdOu11GW+cPvbRlUBh36IaZQpR1KRiVaF7Xe6llg9D68qP/t2yw0VZ8sBmnlqtb8XVXo6GoMtLoJVO7vYoVgCF95v6iOp86L5IP/GDzOJV5WOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaSDnzkH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b472fd93b4aso406032a12.0;
        Wed, 20 Aug 2025 20:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755745261; x=1756350061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLIq0IXj0ljbI/uh1YhQvF3IAqw8jhRLNek2lIEpThg=;
        b=gaSDnzkHkLJiIiV7nkTEjsmaY4FbUGUKggA0GctCAN5coQG8j/RNgGS4W0iFz1mD+D
         SAnUEj1JhN9O0YZjHynAEeq0Kz3kr/aWjiTTuaj2A2rUEExiy81ahNCW8Q+c0YkWnuxB
         icC9mAy1Vc5IZMjhRSoLtBumUVH1+a+5E1ROzUtCzVmKHiVcbhQOEUC+PMVC98f7mZcc
         0zrsDKHmwmwiO5LKe1vojFne9o4QkyElQooV6o+w2UYvaJ8K03Ica0NiJU6m7AYpVOP5
         AcGDkQF+ancKnSWpqe4M1oZbF1yMWeuZI8rh/RUjB83lBSz/fdrOlnlEBWiAYFSRcN4Q
         0dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745261; x=1756350061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLIq0IXj0ljbI/uh1YhQvF3IAqw8jhRLNek2lIEpThg=;
        b=SPGzo+OA3Y8ghgqWEvhiV176JPBY+O/rbqOOtfUrSrqjLG9Gt0R9s7glUNUNl/EolI
         ZEib+X3KI++2WIqMCnDsaYM00sGPHiWZUrt6zZWOd2Sbw/zwyx7SZvJi0XcY76XzSp3u
         szFeCZjPr2tFnzPMFLyMT+CmhTOW4ei3HBWTXrQVgY+u1Tff+2hIKOHL3tlMXBFoBG8U
         QBBg6NfnGmc+S3Ls+O4nsVQhM3t7/JWi5ClXFxF62twswKHcXymLNKb/99Q5r++Azy5F
         JszmIU0cZjjyqRoVP2alUWu6eXvIJCprhA2mS+dqs/k7eUauotGKm9v4H6a9q/Op9APB
         F8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9K2+NzpkK47T5Z93tzsIBldNxSaQpIWy34JkE1Arh6gsPIXHL86rLWSHxMSnrF8uhcha+Z6Wv2RNG+gM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvp1nB7wGnAnWv4oS/2iDk1oHUSry9Osysem4Nag93LU7D4AMF
	lLdzu3Qp7xjIGvYLJCpyEBEyijgS1oug3Ql7uY5eRC3IZgzxlOc8ARd8kXXRqQtImkw=
X-Gm-Gg: ASbGncsabaH89b3IpTmHCN7LbvX62SwKe9C6buIdXb3828fSabejgLKZAk55Zt73Ufs
	S4nM1i3pOfvof/ZFZ2HWFkQZ0drFlKc+wD67TY0w66YsL/vR966lG8ZqIpJntk+wAkWH7AzVuT7
	7vZodpSCRSmdwquCWHqzTvFulcUnMWPvPW5R7NxXC2rs7M91DP6Dl48fCqhjLUdjgK6FJWN8Anw
	fKM0HPyyzpVoODCY+DhnOqGI2S/E4HMVQOojV6uZVT5oLxLnOqBcaF0hD3LK6Rn3xWuS/P/WHib
	Fa0AgskMizHWt0J/wMskqtpYUlqg+xPt49BNcsHCHUTyrNmE8pGIlhge6QaQ8hiDfEcvCu/TgI0
	sjE5s3G7lPFyrl6hkarbGHWnm+jWAOgkJtn7CFg==
X-Google-Smtp-Source: AGHT+IFvneYPfHw10OoTjF7DG4R4kNeVCtXde9LOb10gF9Bf3fn+/lBg5GgGDr671XjIvWiL9/bblQ==
X-Received: by 2002:a17:902:f706:b0:240:1953:f9a with SMTP id d9443c01a7336-245febe9311mr14910865ad.2.1755745260921;
        Wed, 20 Aug 2025 20:01:00 -0700 (PDT)
Received: from lkmp.. ([49.37.161.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c73f2sm40160695ad.94.2025.08.20.20.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:01:00 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-doc@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	corbet@lwn.net
Cc: tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	harry.wentland@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	rakuram.e96@gmail.com
Subject: [PATCH v2 0/2] docs: gpu: fix typo
Date: Thu, 21 Aug 2025 08:29:54 +0530
Message-ID: <20250821025957.22546-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed multiple typos in GPU documentation reported by Codespell.

This series touches both amdgpu- and drm-related files.

Changelog:

Changes since v1:
- Dropped fix for drm-mm.rst (was included in v1)
- Split into a patch series targeting both amdgpu and drm

Rakuram Eswaran (2):
  docs: gpu: amdgpu: Fix spelling in amdgpu documentation
  docs: gpu: Fix spelling in gpu documentation

 Documentation/gpu/amdgpu/debugfs.rst                       | 4 ++--
 Documentation/gpu/amdgpu/display/programming-model-dcn.rst | 2 +-
 Documentation/gpu/amdgpu/process-isolation.rst             | 2 +-
 Documentation/gpu/drm-uapi.rst                             | 2 +-
 Documentation/gpu/todo.rst                                 | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.43.0


