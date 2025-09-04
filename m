Return-Path: <linux-kernel+bounces-801578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CCEB44710
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3647C1C86D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678927E05B;
	Thu,  4 Sep 2025 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ccUHMCob"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58480264A8E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016957; cv=none; b=P+yKXYfW02ZEd49aWkNYr+qK/P08NxxETouGHBtpSlzIuwptZXTbxiv4ROBzzC7Rh/sW4uHZA7On7BzQqADL2L8chyOBIOoQwTboldbxEbQYEbVkAd5ZFSD8L5NpGiQj7Qb3SLP45Fo8mbi2ZBEsC90KhtKB06Dq5F/pFPJPbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016957; c=relaxed/simple;
	bh=qVNT0CbMSIOU8qDaxlLhQHgz+L25Hqq/GpRSW9zCIdY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=f/efcsLLez18qoTEgH7N+rcy2ye1OMCMkYz+9VZFYFzG1hva0q/Ii4jiQySbwmAa/3B+4VI0QG0verhjT1QRYtDRg7T9Jd1hr4OWJFfety7Qn9vtVJ+lOLX8qlfyr86vbUq4l8fSI6eZFQLwISpPFA/aMPk0qLnpN83NtjfhBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ccUHMCob; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7fe9eea0d21so145348785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757016954; x=1757621754; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+680EUIEPlbLOYfx6FNfIkN7nwv+fre8jP7yiSa4FY=;
        b=ccUHMCobupeqH2+VzoztjCjZ3AJELJhhDjD8Q+4NCV0hS871UpEGc97gES6tUXbbqj
         gkkCVtT6YvSo4TkSYgDJIeQRxsmkT76wAMf+mphll2aLxjhE/AnEFBtky7IO6KnuHS1U
         xahz65rDKJ/MeZwlgWQl0eqcd1M5RC9Qops6OqAP7wULdWU9js27mVnHjMvZzZSCYz/J
         AOAQQvXwi1LUbGoLwV/4DRjW4KdgaygcfF4ew7RobT3WMKmI7iwsqh7Br3eOEMVA3Tkr
         j+gJ0OzuhdjzsXRNJ4l1otjaFibTA3bDqrkYwzcaHBOCBNtaEShkuFctOpi14gVwYnmI
         GQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757016954; x=1757621754;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/+680EUIEPlbLOYfx6FNfIkN7nwv+fre8jP7yiSa4FY=;
        b=snplmMIjmM/F+f3ZNEGr2TH0rWXBqyoIuRDmROKFbJnD76SZf2ntBGlcjC36MXIz8h
         FDh7tOxcI2Ic7+w7r3brNuCQpAqegUe9NrFOBjjuMXMV7Jf++7BoasCYN6JKaGTqzqkG
         roHOSEuMABGXsV2H89/5XqhDR9O4HACHwFgqi7hICk42C4pIXilyeVjgup3PI97X2aLg
         o0PqVk11o2KqLbeb3qEdtibd/DiWfqkt4lsVjrsnjf401MecupZMkcIGrkjicej8bAdC
         W4LPDRo0sIT8Nm2QZapBD26eEhVrkVtzpCemedg6BfH0BKBZeTSGTkShxNsGxy8lcOiy
         a+4w==
X-Forwarded-Encrypted: i=1; AJvYcCXipw+odoxALj0fZD3Ls07FsmakOBUR12mqr7I5Vr8eVqAhxVO4e3vTKvssOYEmDJG0hWq60EstjHEn068=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJzXbNdpz2WZ2qGmpODA02pr2cpRetVHI2nCB/qnivFasl5oG
	X4FzmA8l3K+QDczVhEdCGJopoC+t4kcCALNe8dd5/2iQRErcZxShyLOB/g6O203T7g==
X-Gm-Gg: ASbGnctCrWvRjhKfPDRfMz3P4WU5l87SGnSXFu79nXZ+KjcbiMl0whd6IVtblIfyZFC
	BJlWErcCKFZbeyo7YLkYJz/oOTJMIpjmNz+6tsFO/4YrW9Vq+3JBeez4Lx6hRb4oiLvvXyRiMw5
	tKpVQoE6F0vPSa9lMbXCS67cbJ+HGohVui+S89hle3tsiGXUQwmztGhJd8oMvGrJlO9mmli074L
	OMAHuGmh/Dk2q1gBkiv1U/rHh9lrGKQTePcL85BLohsPtDp+wbevcthj4yzX3sjhtF183VfQQ17
	EX/MEh4LSNIP99B6+P8vQTViXhUA4P4CudIqdWi7lrIMesPSZHrFx8DIeeyxw0+k4lN9ay4tkjD
	/fTHXj5izJiag1zGF188lHqkRU67wQlotCtPe8qsK2+psNSs5kD1/hgkx+Go65WDvXX+ac1mhMh
	IsV+8FORmYA45Zcw==
X-Google-Smtp-Source: AGHT+IGcpdOqg5H1mkv4XguVPsHn1zuGxeD7ZQ/j0Cwgoh/FoGRTVROAIGg/0Ow4seoYOufr8Iy2Wg==
X-Received: by 2002:a05:620a:28c2:b0:7ea:44c:d4a8 with SMTP id af79cd13be357-7ff26eaafa5mr2625182285a.14.1757016953965;
        Thu, 04 Sep 2025 13:15:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aaacfeb4bsm342220885a.41.2025.09.04.13.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:15:53 -0700 (PDT)
Date: Thu, 04 Sep 2025 16:15:52 -0400
Message-ID: <e2c4c055ff356b4fe5d49bc9df3fd2ab@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250903_1645/pstg-lib:20250904_1609/pstg-pwork:20250903_1645
From: Paul Moore <paul@paul-moore.com>
To: Neill Kapron <nkapron@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: Neill Kapron <nkapron@google.com>, kernel-team@android.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: enable per-file labeling for functionfs
References: <20250828170317.2322582-1-nkapron@google.com>
In-Reply-To: <20250828170317.2322582-1-nkapron@google.com>

On Aug 28, 2025 Neill Kapron <nkapron@google.com> wrote:
> 
> This patch adds support for genfscon per-file labeling of functionfs
> files as well as support for userspace to apply labels after new
> functionfs endpoints are created.
> 
> This allows for separate labels and therefore access control on a
> per-endpoint basis. An example use case would be for the default
> endpoint EP0 used as a restricted control endpoint, and additional
> usb endpoints to be used by other more permissive domains.
> 
> It should be noted that if there are multiple functionfs mounts on a
> system, genfs file labels will apply to all mounts, and therefore will not
> likely be as useful as the userspace relabeling portion of this patch -
> the addition to selinux_is_genfs_special_handling().
> 
> This patch introduces the functionfs_seclabel policycap to maintain
> existing functionfs genfscon behavior unless explicitly enabled.
> 
> Signed-off-by: Neill Kapron <nkapron@google.com>
> 
> Changes since v1:
> - Add functionfs_seclabel policycap
> - Move new functionality to the end of existing lists
> 
> Changes since v2:
> - Sending as separate patches
> 
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c                   | 8 ++++++--
>  security/selinux/include/policycap.h       | 1 +
>  security/selinux/include/policycap_names.h | 1 +
>  security/selinux/include/security.h        | 6 ++++++
>  4 files changed, 14 insertions(+), 2 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com

