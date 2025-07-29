Return-Path: <linux-kernel+bounces-749278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD1CB14C46
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1289545785
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D624F289E36;
	Tue, 29 Jul 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gClfGBMC"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3992882CF;
	Tue, 29 Jul 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785362; cv=none; b=r+hRMEqRVeGnjOJF28yjf8RbL4HSYkVbElYuZKgAXcaroIKBeEIhDV+BfAv2QCNqlNEfz7pXkeV5AM1G0Wc8iS0V0YxQ1h2PnYvIQltsr/Dsrtaee8yaUZXqmvLrZ3RocBiYtetMnqzzCpQGJjUBgaYGfg21MXbhSpj1XkFqTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785362; c=relaxed/simple;
	bh=Z9HumShDiufliIB4ciIlQDeCgYnIAnXWWEVH3x23bQQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qUeCosjMHFnIRdYl0jlY6/gdmEkc7mb+qkZByyF7T1tILZcsgSmO3RK2IZuAWDxdCazVUL8UnFQDFIfQr1jcVa3tr7/dSOc7rVizkm9EIYV156Zj1G8zV5YLI3KIjAbRAlZ7wZcoaIwrka66INTzKhuLaSDeMpO7jxSWH3c7ar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gClfGBMC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3220c39cffso5542381a12.0;
        Tue, 29 Jul 2025 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753785360; x=1754390160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8087Ww2Ief01KPpqD9WgawznOlI5BWfEluXJ5Qfhq24=;
        b=gClfGBMCIp0vzpKyr+JCDNCCwCdzRHDFUA0hFjoV/aZ2/NR4cyYRBacp797wLVDlQ7
         nuywfU4lAkqpv1jG9mLsC73lNqJESol/tjHxbCA5GqA62ZaCll7uu1JENKy63rCtB80A
         v1sYZSQPz7yq4gUrk/C9IDKxZUdMoJN2VnJV1o+lEsK9SclE7PauPXd9KQw80YZCzX9l
         5OxXCiI9K5aKf5dx3iVhATftmn4jkEhzTQZ++5Jj4g77mLUVxbE8/vAZBYiJ42RC69hA
         tJlUTrjy24SAa8LB0/7Kd7pSo1wPhxbYZNoLUBZ8fDH7TyNrSZlGUfMP5nEduouYTXQK
         XnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785360; x=1754390160;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8087Ww2Ief01KPpqD9WgawznOlI5BWfEluXJ5Qfhq24=;
        b=EkTyhjtfrZypwy6lEIfFtDwkOWP8ybT5V8bbZUR0PQ5fj/UH2hD/9+QFucOsZ4le3i
         F8063KQwLOtx4zIQKOq0AkiRdH7fFbfSllStiHF4BBwcXxJMkK5MEPhnwj06ecg+N/Wy
         Q7H6eNkqVWGSJd12qCL+vcpdUaBX2RinKUosQiDbFk7gTduiSzXzutol/Qiust0fdKD0
         sY+M7lcvXH9aHBjeCRQ6eZXjkXjCdyeLKVkNsvHuMkMUnvjrbTyX6llnzYks19Fp1aWq
         GmlpUX0DXhKiK0O1H+xIEmEr1n0vWBk7L0vTwCNJwL74tvY6fRSezfb53H2yETu3719O
         uJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUSgLrBykEZtvbMLG+ssdBhWo11RttYcZQbn+f4zdeERbbKJx713H8xZTqCNgyT4dwSucq6zJ9waSqI@vger.kernel.org, AJvYcCUUBc/ZH/63dIrVAwdHCYcI3AnOW5q12oWZAG+SNZy1aNJiYlYXzlYaMZnZaBX1EQcsp3pHhUCzmhw=@vger.kernel.org, AJvYcCWao1XFC4JCsA1Y+049iC3wRiSdQflG+BKHKqgCcxbmCylZXA/ygbE86dggMdxduL3O3fZ9aw2YcyXjiIU9@vger.kernel.org
X-Gm-Message-State: AOJu0YyWIuMEIsnEp7XXHk2Fy45RgrD4pzR9X0DDimgfjDYh2IK1rqv9
	hkAIjxIr79K//X65KBBWmsxoXngHZculbssEtp3p1/UyQqEfSUxYffoL
X-Gm-Gg: ASbGncv9/ANztohCESrtnmsRW6qzEUYbDUJR/zfrMcGtov6Dl0fn4sBYnw4aEvCXORN
	Emd3MmjPO0noNA310XWlwXif4yTXCsbKKefJPbgTvva/trfXETFBsroEG1i9gQ3Fh9gPCbTluc3
	XH+rPzuoU3A6DlH0pIfFQct/TR/QoxIczOpKLvMFqrXCRKm6ml4FkMkzBm2NevgPNVxjOzrpyBW
	JHFIySMDBlAHVhRCChs2PvgN6Sz8S5H/rB3jOU1T/4DdDEtBqwge/bEX+LuPlwRy2evrItBS9Wx
	nsZ0E+/41Mxu7joIgx+8a6sYoANkn49KKV+IsUadBD0/UCrjcPMqZ6zN2m3KJKjf52rBtw8mHH1
	wCT4CTTPtB5CSnDj6u6YtkJOnHnPSit4LUOzOCJCUFM+S/vXrnunR74vr0MUerc61Oxepbv+FXh
	2ngtQ=
X-Google-Smtp-Source: AGHT+IEPkdK0ONC3SbVXWmFef8tZYCI8+3/GregdA3OnPSHja3+EYzzHnGB9qcHUGjypRrp1HWca6Q==
X-Received: by 2002:a17:903:8cd:b0:240:3f4d:b9b1 with SMTP id d9443c01a7336-2403f4dbbdcmr94228405ad.29.1753785360151;
        Tue, 29 Jul 2025 03:36:00 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f328cda53sm1301448a91.19.2025.07.29.03.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 03:35:59 -0700 (PDT)
Message-ID: <3170902c-4a3a-4f85-8703-0e2cfc04201b@gmail.com>
Date: Tue, 29 Jul 2025 19:35:57 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jani Nikula <jani.nikula@intel.com>, Akira Yokosawa <akiyks@gmail.com>
References: <adb2d431b60228a772ec4423457a08e9af4b1d2d.1753713955.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 2/2] docs: changes: better document Python needs
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <adb2d431b60228a772ec4423457a08e9af4b1d2d.1753713955.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[+CC Laurent and Jani]

Hi,

On Mon, 28 Jul 2025 16:54:29 +0200, Mauro Carvalho Chehab wrote:
> Python is listed as an optional dependency, but this is not
> true, as:
> 
> 1) CONFIG_LTO_CLANG runs a python script at scripts/Makefile.vmlinux_o;
> 
> 2) kernel-doc is called during compilation when some DRM options
>    like CONFIG_DRM_I915_WERROR are enabled;
> 
> 3) allyesconfig/allmodconfig will enable both.

Well, these conditions still sound to me optional.

> 
> So, better document that.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/process/changes.rst | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index bccfa19b45df..f6abecf6da86 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -61,7 +61,7 @@ Sphinx\ [#f1]_         3.4.3            sphinx-build --version
>  GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
>  mkimage (optional)     2017.01          mkimage --version
> -Python (optional)      3.9.x            python3 --version
> +Python                 3.9.x            python3 --version
>  GNU AWK (optional)     5.1.0            gawk --version
>  ====================== ===============  ========================================
>  
> @@ -154,6 +154,17 @@ Perl
>  You will need perl 5 and the following modules: ``Getopt::Long``,
>  ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
>  
> +Python
> +------
> +
> +CONFIG_LTO_CLANG requires python 2.7 or 3.0+; some DRM config options like
> +CONFIG_DRM_I915_WERROR require at least Python 2.7 or 3.4+.
> +
> +The kernel-doc tool and docs build require at least 3.6, but they depend on
> +dict changes that happened on 3.7 to produce valid results.
> +
> +Other tools within the Kernel tree require newer versions.
> +

These details look confusing in changes.rst.  The table above says
python >=3.9.x.  All you need to say here would just something lile:

+Python
+------
+
+Required with CONFIG_LTO_CLANG, some DRM config options like
+CONFIG_DRM_I915_WERROR, the kernel-doc tool, and docs build (Sphinx),
+among others.

Other details can go to comments in each script or other docs if
necessary.

        Thanks, Akira


