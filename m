Return-Path: <linux-kernel+bounces-891738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F25C435AC
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231F13B2B5C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52322252292;
	Sat,  8 Nov 2025 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcFAVxGm"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B919F137
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762641894; cv=none; b=jw3ANdtG/7sQXInpMGD2IUEZ2cdX7DdZs7V8/raLek2iDW+olVO321CFT0eeF8qRChfklVVP9tE61aqTxkqtQRFfMboLdH0vYA0vrcgpUVMNrN0zz80/oqFT1mWUiB0Yk9vdZ7oODV+efeBP5euEDATVnhj3p3BQIfKhStY5csY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762641894; c=relaxed/simple;
	bh=GAt9wY74jqgORlvfle35FezhBg4krktfQp5WkkOptjM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DPxDyWekwxEgFytBXgE04ioFIF1N+O387w0fPAgaTbq3gKu9g1x+ylS3nXlokxIc04m7+RwDBDFVTUiLpK3ZmNYSpPCloemh72gYelGUgTOTd/+J/YvvKubcyi4iHGmFAFqs+HjvFZ1U9ivyWnXEm+sZauwSN3hoKzAd5tL4F6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcFAVxGm; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88054872394so29386326d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762641892; x=1763246692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GV/WAzTybILabaHuaT+4GIBGUdc55tmfITVCk5miAsM=;
        b=DcFAVxGm2VSEaASAg/3CsSugMNSoKEJCWlTF994Vq8IPXf2Sc3Tz42Fc5IZV9nh/Ie
         +BlNnaP0hxWkGygwA7J9pu4wd1mgJROVQu8kwmE5mgXZAm9ipLreCYdc8A44wua50E3W
         cyE7RDm0/uj2WJjAzNkJzyKYT9rmjxN9CGMzo7k/N42zPYm8Z7e3DEnr9tRfKAZwB1Sn
         THfT3qsCi9bXOC5onlRKRVCWLe0xqyaRlyxI3MzGLcJn0oHmVLlzozgPEV93CvqE9xcI
         PMzyv9sE1cqdGqf0MFdBABNUQ27Qk8OIxQY+zzZV85hRbFf1fQsyju4sJOeelIedDo1q
         racA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762641892; x=1763246692;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GV/WAzTybILabaHuaT+4GIBGUdc55tmfITVCk5miAsM=;
        b=R0+9zuH03p/9bulgdridD+l40V+juwUUme/iUWAc1K6LtWU+nctGb/6WzugA96tYGo
         e228nW12Qu7MhA4/iDWKmAfGLbeQeC/jl44ZRI85dnbnDjWzkKjrVIlOIk9MIbsRlLB3
         jdLSyY0P6cTr3OE90U1d2iaBnjdkcvEoYnK7oP6Hdl2ySGp7Lh7ildfZxjui0JP5oVKb
         +1lg9fuLtx401p86go8Lc/frW/YlgZAH3PCWIla9xT4gsUYjZD45XKPxusIGVivX3pr2
         CsgCOmZnk0OauPNnQMvtqypOmIV0zWTO1LKTRPnPm9JhJueZYopElLDThuDCYlSx2QhP
         fe4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeLpdfTh4beXM4JSAgysVO7wYgDix1Omqu9D5CZ6po8zlBPA5NSQYDIXWd9yafvmtucMTQryv67MfFJqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQPYDpGhJLCenMaLpoR6Xq/zI4uqu3Va6u7WJOMWEm5Pk832e
	5hDoPiN4cxfWnbe2JNnanrj8/AR9mumrB/vfp+G+Twbp+lryEQfAKaHQSd+hbI0XCfAKK17L/vh
	XnMAL6f+Pr4XcBGTCm8mfv/5u3EtgVGw9lXjB
X-Gm-Gg: ASbGncvHzp5CVyt9VGpGeJ0qt/d4uL0j6otb973h6Rl+pXm+8FdKAvj1/62disPs5N7
	9d+mvMwi+fiM0OOt7ehbsoujgA2774AWhBsPuKqgacbQY7M/PCZilNTBukvRr0BKqicC+YbqVPt
	BRwJDIGUCw+uUmV/7ODqgEFHI4OhamFJlRddq+IDpimHIxyJcnjRbCgakZnSh36zGdPKzNsK0Gs
	W0zx6bPRHrgCmHKcUgKwUxwPAAn3R57sHe2QA1plGJmJVcoYZMx33H2iZ4MFRtaaZKF1L0CBNs5
	meZRwXuPsFLcJYDlvw==
X-Google-Smtp-Source: AGHT+IGPsvmDTNCHsgzpvFyVnNsDJSgqb5Rk5vl4nogKFc7EwQjtyzkLdkEtPVMlSxZLE1CKog/LJBj/gYxbLA/Y0ms=
X-Received: by 2002:a05:6214:238e:b0:7a1:781d:8557 with SMTP id
 6a1803df08f44-882386335b5mr46603256d6.24.1762641892141; Sat, 08 Nov 2025
 14:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sun, 9 Nov 2025 08:44:40 +1000
X-Gm-Features: AWmQ_bk86ixqj5JkTDnu0HKph_AOhWOY4hwf0cv-MhJ8e1G1cXHmRZeDwl0HmTk
Message-ID: <CAPM=9twWJuOWLGVoMNdQhpu_5-diyLuHw+QhENenW_wGxu6GOQ@mail.gmail.com>
Subject: [git pull] drm fixes urgent for 6.18-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, 
	Timur Tabi <ttabi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Brown paper bag, the dma mask fix which I applied and actually looked
through for bad things, actually broke newer GPUs, there might be some
latent part in the boot path that is assuming 32-bit still, but we
will figure that out elsewhere.

Dave.

drm-fixes-2025-11-09:
drm urgent fixes for 6.18-rc5

nouveau:
- revert DMA mask change
The following changes since commit d439acbbfb9a982f152c5f806b4592431a80c4fd:

  Merge tag 'drm-xe-fixes-2025-11-07' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-11-08 07:39:54 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-11-09

for you to fetch changes up to 411336159064c5e89e8b89d30c6855db4bb92814:

  Revert "drm/nouveau: set DMA mask before creating the flush page"
(2025-11-08 19:41:09 +1000)

----------------------------------------------------------------
drm urgent fixes for 6.18-rc5

nouveau:
- revert DMA mask change

----------------------------------------------------------------
Dave Airlie (1):
      Revert "drm/nouveau: set DMA mask before creating the flush page"

 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

