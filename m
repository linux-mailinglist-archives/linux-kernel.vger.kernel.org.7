Return-Path: <linux-kernel+bounces-814061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE1B54EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8756D581163
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82EA30AAC5;
	Fri, 12 Sep 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbeVSEJG"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DB305077
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682443; cv=none; b=Bwh/iL7XEi3NDqmFkqLotn6iitzJMjUH+YdoIBS3qCbSFUZ6O3YeEvsSJD2nU790hQYKMNYdY3qE04DtHQaAETPEfh7IqPZ0vQe9NA2/1X36oB+PDuJRjTVf2zhg5XZryoxXoCdQAajtgDH+y0ad0ITBR1SAPht+aP4HuIiRnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682443; c=relaxed/simple;
	bh=m4qhwnsry/SWycpMdOHNFZlNWW6x4f1W26dSGmgsJ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJpUuQFInO6CnsauecrYbHF3oRF/7dtv7MHqsroR8tELz4rcK4m6u2gM+qvxKbValH853clDCjLVRfD7vpljsCpaXz3EgYzbI80kXuOP9R+m636UGixpP7wlAo2V23MU8i1YY5Z4XZ7OK05Q//FfaCiyVgRn1aAEbX2yuIO8+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbeVSEJG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c784130e6so21359505ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757682441; x=1758287241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x544GYJay0OImzEkLS/doW76Om1NP9OFkc47rJ1bRQg=;
        b=UbeVSEJGsx5L4+X2GjmpwNQPMul4dTVwnTmQ9wwb/c8Ze/lyLFFnVliJe+1bWmc67j
         V+0qNq7p/6dYc2leTqyChjY6ioO/DG64skca74puTFWVC4XH5fOaMNAF9nhLMKEXIJHc
         VIBzv6e2qC4L9XmtUpLXy8ykiTdpuB7+AFFTzgS3dJBNPqGI0WUHAiIWKQR/Qk7+NPbW
         bTzjLG6fTGFuVrctSISX75jDKQleeN509HKRI0T4qv0tMB7tbKoYQh4ZOnST/hjHzPxe
         0NsfYJoOP++issdfFw5HtiuUk14TFyWgrsUTLth6MPfGat5FBd3VOp3Mv3viLLVLtpcy
         C9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757682441; x=1758287241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x544GYJay0OImzEkLS/doW76Om1NP9OFkc47rJ1bRQg=;
        b=ggXU5Nc3wwerp+ALAAmLE4JFO2eyfPp/7cC9hrZ3t8JIj5nl2YUN6gEaeR+RP6K9a3
         6Wlg49BlaY2iyNXPnve/+moL3jWBMbbJUgvauaCBR3SrlrUsUOZTIyfbqozZ1NU1yDj6
         slqh23rxsbRK6cfUtlHASNntZZzMmsMry2qdJGPckY2numMVLp63D9/P2W5ebh+OinUI
         +RgNG3xjfiEfW1c2G0b0y/pqmC7bFAzPDNGbMOL4d2dwaHR4qJT+6t7AbqimPYNVzCHs
         clf/KJrlw2j0UBTBEgmXhxfPS9etHu+sGbGGpvfh1rmpDdI1Sw1EFyFE08GvsfFafAce
         oP+A==
X-Gm-Message-State: AOJu0Yw1KWmPBiFg241u5753qElIszXg0NmrB+4pwv9sgYM9C/AYfNB6
	0FYVFdJv+BlnzqxIBGJjuV9IB1vey1TLEErHf8Y24WwTXAaXNEqOJVu/
X-Gm-Gg: ASbGnctnXUcDewK83y38ny3cxYtFcGewreRHxvPO/2SfW5A8h2q90J0r0Ka1ulsUMw6
	+5Ue6Jb1Z9CET8E8GX0Thw2OsZCzjKyuMULHQm1dUlJ8/DcOX08mupk7MbnJO+WFOtx+qLvr8M3
	eC0/9nJAY/xHJgWiA8CFz6YZVcqbYO8ECa0arClFZpCystR0dpJNG9IOw+v15hiL5/Yvv/iAAhk
	Lqn86zcLgRhlTt2iNis3FXHS4orvNCHaCMdunQqN6TyavxbN8zRCdX8cnW/vwKXhlXRME2f10sq
	0Kvt9rkVfJkP1JB0O+jYb4FTry8/o/z4nc4gCikzYJ8dV/Y2hCaRXkinxZco2ArX+MarIcT7LeV
	EyzXK8x+9wYd/5b+Kj1PsUwG7u3HSFWB4jUXh
X-Google-Smtp-Source: AGHT+IFNtOF9483lJqZ0eCDuywtMNSA4/x1QrNPIz5w6iEwUoJ0MCDnna++VYIfN2AunXMyW/zkq8A==
X-Received: by 2002:a17:903:144f:b0:251:19e0:2805 with SMTP id d9443c01a7336-25d27922652mr33876225ad.55.1757682440563;
        Fri, 12 Sep 2025 06:07:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b307225sm49207635ad.145.2025.09.12.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 06:07:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AA34441FA3A0; Fri, 12 Sep 2025 20:07:16 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Javier Garcia <rampxxxx@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Antonino Maniscalco <antomani103@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Revert "drm: Add directive to format code in comment"
Date: Fri, 12 Sep 2025 20:06:50 +0700
Message-ID: <20250912130649.27623-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=bagasdotme@gmail.com; h=from:subject; bh=m4qhwnsry/SWycpMdOHNFZlNWW6x4f1W26dSGmgsJ6o=; b=kA0DAAoW9rmJSVVRTqMByyZiAGjEGlKhXlw/mPScHOQuMTJJKb9msLDKVjN5d75gGJeg1FAW4 Ih1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmjEGlIACgkQ9rmJSVVRTqNraQD9G99e 9SXsT9d6z3iT9FNmQBBdwBmkS2WzrDYbjm1fbCgBANgvs+XgMdf6dSl9lCQ5vHWWgIoppY6NPRZ zWj/mPL4M
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 6cc44e9618f03f ("drm: Add directive to format code in comment")
fixes original Sphinx indentation warning as introduced in
471920ce25d50b ("drm/gpuvm: Add locking helpers"), by means of using
code-block:: directive. It semantically conflicts with earlier
bb324f85f72284 ("drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
usage in literal code block") that did the same using double colon
syntax instead. These duplicated literal code block directives causes
the original warnings not being fixed.

Revert 6cc44e9618f03f to keep things rolling without these warnings.

Fixes: 6cc44e9618f0 ("drm: Add directive to format code in comment")
Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index db9b089ef62c85..86853535fb7bd7 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2432,8 +2432,6 @@ static const struct drm_gpuvm_ops lock_ops = {
  *
  * The expected usage is::
  *
- * .. code-block:: c
- *
  *    vm_bind {
  *        struct drm_exec exec;
  *

base-commit: 9a3f210737e958c3f45a4ce0d7f1ff330af3965f
-- 
An old man doll... just what I always wanted! - Clara


