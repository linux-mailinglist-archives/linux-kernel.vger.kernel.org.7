Return-Path: <linux-kernel+bounces-848207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8358CBCCE34
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17ACC1881AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A628A1F1;
	Fri, 10 Oct 2025 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b="qP1CYr32"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBF2882AF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099211; cv=none; b=fOlbuySShlBh02Mpha1gBt9oiIbWOK3x3ga2NrmFaBU+WgUKxzDDtvRaoXP9nE04YgHAWyncbz7P8fXHkB5WYPulwmN2LC8wOBz3ir3bn3RPZAn4BryqO/NaTnztzYskxyGszm6oyF4MfkfBk4WJSlQ37fJDjtrVEIlyAsAVuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099211; c=relaxed/simple;
	bh=PX9B8k66g5YeGpw1A1Ig4K6GqsxMcbr2aBy03ro+orU=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XIbkvvw72SBCAS7hr+N+cd2EpQteEJKpFp+WfH91AAQNvNirH7DvrtiDAP9GjJknRYNnqSxQeOJf5jDTiJdqxtvukZ1A4ZwAjLbcquay0vTy2690wOAVj5E2lBKQgnK5Et4kusLdIHNcwGIKOI2io0oPjecablvPWnxio+/8RJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us; spf=none smtp.mailfrom=kudzu.us; dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b=qP1CYr32; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e3117ea7a2so27504771cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1760099207; x=1760704007; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrf5ZmorMGG0BuXOb/ZsEyv1LRNCievVRv+1nSG0+KY=;
        b=qP1CYr32zl2/rU1B3mKxqgQPyjO3PNFO+e/55W3aKIC2ikmS4dSY3+Rje6LaWy+0/n
         0HhEPChR4KydRJiRw7f3lfvhqmx06QwETgAYzmBkhXj3vbJTde8+DFmJq9x8hfQcEH8R
         QecxCRVdG+bFeCS/E8H47g/a3dkIJ2gJHr/B2GdKTCLlHemZzw6z8QkiCi0m+bAPAgFI
         V5cPvKxtvrZCWp8Yj6DA5GB5fOZ4nRFgluCjIsLJlCr6PCMeFxYUVmP+17VFg8vaAsol
         2JzK35nJL7pdcyj9+a6eQU7FPjBDk7TjT/orzrICQ3USJvo0y9ZDR6umggBmpqpL1Bat
         LtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099207; x=1760704007;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrf5ZmorMGG0BuXOb/ZsEyv1LRNCievVRv+1nSG0+KY=;
        b=IOB/n0VAg7JSOvnqx7q+8uBEVSgSZJc26HmiklW3b/ylrt4ZSp91nSrBUPYR0Y3FQF
         k5SLiGAj5UXfOnNBsGLnKFgRNaWp4I44G8Z4L8iN3hOYUyMQzlw3hkdLukXApKGhai3F
         vIPc8/PdCcEe0v7JLId4+R5eGim8/eLdSbl6lYZ2RFEEju3c+CifJ4nAOpPJfEtkhMjD
         36q8fe8FNDBaDme1tbpf+PRWu6/cFAmxRbGwRV2PDFMQjU8yRHp0RWV1bspW8oulhGca
         tvZm7kgJ276s+hTPlcN+icWqMaa5nZgoMxCgoGx8e19C7FJjCzagyHjEqq1NE9jBt6hG
         vnPg==
X-Gm-Message-State: AOJu0YwjO+Tk/T21kiyu1LkscLopPW7164y1M23lij8zBd1eYq1ZNr/t
	uz32xJVRI9jIozlRi905ObwUn+EphJJsQkUlzENF0ehOO/apz+e/dtswI1gcfYz/Dg==
X-Gm-Gg: ASbGncuDVm3Gpt8xMKD9+ra2gHsrqllmlLRglCR6fan6N4Mf/lkm8at8lHZt6GhNPNe
	Owmc032nvvtkTKYQS3hmLDlOwbIncitRRjVc0Vq+ESNoYS4ak2JWMo4zIm70NGdudZ7yVrA2Hz0
	G7A9QHYngl5/tmwBt+4OSVXy5zbyxXDW3Se7B8hRsBTPIKw1ixTtoA+OA8KrrW0lbdfbVHdClTR
	xFjMLfM5QKqZzMDTQ2AWaZmJqmDGOBm5FdVYAJqqqZf9kb4NCE/85Zk443SikOvRQ9SK7KJU2uy
	B+cUMEXXopL8J7TWxGRjdY9G0HcCAi4j+iZP7D3oxa8KUvbxNdoYnZ+1sdmUGuQJcG/2C2PlWP5
	fG6LODMye1/h3J4R6pOYVAqqC80FAB6nG
X-Google-Smtp-Source: AGHT+IFWlqSZfOgtooYr5mvAawvwnK23V9obB0l1oEdeoDOyt34Lx4eI1XsTuexHYBHwo7UfWP+Avg==
X-Received: by 2002:a05:622a:40c4:b0:4b3:26c:bc44 with SMTP id d75a77b69052e-4e6eace79c2mr159296531cf.20.1760099207163;
        Fri, 10 Oct 2025 05:26:47 -0700 (PDT)
Received: from localhost ([136.56.27.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35713afsm15183926d6.30.2025.10.10.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:26:46 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Fri, 10 Oct 2025 08:26:42 -0400
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for 6.18
Message-ID: <aOj7glAc85SXWodE@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,
Here are a few NTB bug fixes and minor updates for 6.18.  The patches
have been in my tree for some time, but the tag is new.
Please consider pulling them.

Thanks,
Jon



The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.18

for you to fetch changes up to 006824a1cb3bd4001745a2b1cc83c43fad522851:

  NTB: epf: Add Renesas rcar support (2025-09-22 09:35:21 -0400)

----------------------------------------------------------------
Add support for Renesas R-Car and allow arbitrary BAR mapping in EPF. Update
ntb_hw_amd to support the latest generation secondary topology and add a
new maintainer. Fix a bug by adding a mutex to ensure `link_event_callback`
executes sequentially.

----------------------------------------------------------------
Basavaraj Natikar (2):
      ntb_hw_amd: Update amd_ntb_get_link_status to support latest generation secondary topology
      MAINTAINERS: Update for the NTB AMD driver maintainer

Jerome Brunet (2):
      NTB: epf: Allow arbitrary BAR mapping
      NTB: epf: Add Renesas rcar support

fuyuanli (1):
      ntb: Add mutex to make link_event_callback executed linearly.

 MAINTAINERS                     |   1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c |  18 +++++-
 drivers/ntb/hw/amd/ntb_hw_amd.h |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c | 118 +++++++++++++++++++++++-----------------
 drivers/ntb/ntb_transport.c     |   7 +++
 5 files changed, 94 insertions(+), 51 deletions(-)

