Return-Path: <linux-kernel+bounces-779800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC9B2F90E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1511E1CE5EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4F3176EB;
	Thu, 21 Aug 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igTA85yF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757522D320D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780766; cv=none; b=uUgRvBf+Dxq/P3GXVEG6hXtu/1LQjcHgWVea4pIriNqgeFasitSD4L6NFXjnIqaQJKdryYbVXeDyXxqHMxv3hIO3fM4k6eykuHh2cTmq9AoM+C26ZpqRh2VnfooP/5iF+RnQTQAT31ufR/ku13iEWJKsCp3XCq+pXWgyEFLeC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780766; c=relaxed/simple;
	bh=7tofv9IHJynFoIS4ob9uheWq03zdnIpwJ8zDq59EoIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udMGbQ5P3nNIHSNjTwkTUkMlIUbK6FXFSsmg1ZUFeZIwLyfhic0aWBSCvK+Q9PS6MEKSHqdbpkI1DNxZ3agV8sTS24YZOOWDVUzAGvJaDwHgQRbj9psULdS0FKvUMt+aIN44OJdEa97bMYhiq0NZeSb8ASJTp0jKV4loHS+Kjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igTA85yF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244580692f3so1522725ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780765; x=1756385565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5NFJHJToPY5c0jfPG6MrwrcNdfj7hp17HoGeXCaC+Y=;
        b=igTA85yF73Vwx3ARIqRrexSB+AxgL9RHh9PY7rdmoLyJerHgffR7L5yWR87k6Lr0T3
         izfCTQRbmjRb42YdrlXHOsd6qGEbrQiIAaiASugkPjw2nJvIy61Qo0JWyQY2YAZD9DlU
         9ygL6B4hTwBDgNHIdGvZHK2hBY/FnJ0YWMkSPco9qUx33+bqei7NxPbdSkrROiJMYnZ9
         Az6+cPhiG8hn1Dqg2oK08gxB1W4HdpkHQmOUUG+5pdPgKNxe6KmegnudxTsMTerh08jO
         +kiC1KQdekryN0gSecJb3sxy847lgiOv3kADzWVHOtIJQ9mVjz+RETpPb+Lfcv/0ZlmX
         /t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780765; x=1756385565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5NFJHJToPY5c0jfPG6MrwrcNdfj7hp17HoGeXCaC+Y=;
        b=TakljmJug4Fr2NdwzL3iX5qRZy+tBn76Z9QuKMafqsg8vPb/nC4FgTOF4a44N4MtsH
         VOaYqAdEDOM4k8sqyByBMjWphGfCr1Y9I6+JLo/JMMzOm4EFIAZjNDj3n+JRgf6JezJh
         YFlQRCqmRNM9DqvBhVIXqyVXYYCJqjbjySj/F8/7jB0qevqRDE/TQrB8YLONGvd6AsN9
         G4Tepg9ZHwMzsvtoQHqxd6y+OGaTtzRgrcngplkbDHYanwrupud4q8PCIx6AEHpLdukd
         lY6kQJEbGTTuiC/3qHFP3vByZV5k+yfaZDU7RtlitSucQaVWr0RQI+bbL2KZqXmycg28
         jWXg==
X-Forwarded-Encrypted: i=1; AJvYcCXXblbTb1iyKbE4JGLMwDKeK1MOETrQVRGKvniwKjL53ywP4p85z2SdkTXAzM/MMXTPNxraPbxYLHFFgFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpDPjiO6x6U5YhpcBRzmTry+Q4i5XfXw2LtPMDCFG6+FhuWKp
	Zhuoe4TQMVwoZ2KqYCMS+R0khJw3DLZ4nRBKPXtvAXoaEYP2Aaa30eWdXwZJqiSFi6ID1M5BuHq
	mmrN1nQwxHB3EoSvCOoL987l/y8hcmqo=
X-Gm-Gg: ASbGncuy6QAPjvMu0sOgr+0DlC/eM71Pw3lBnD1SmU9vxB6zGOXySYG49+7HuNb0zsI
	JjenGBM7ohH84FB7fdcITFbC/2FmHvDUNNwHFPPo8dA0DX/YLmtP2Lox8J4+VaOWO66Z1rlPIJj
	jtdDhxhPzTbj+8wasxes9/2Etnl0MHu6YTbGRabuGuzQ92f5sUydZCIy4n9CthEfbBBh16MYGGn
	owNlZ4=
X-Google-Smtp-Source: AGHT+IE1R9pueAdp5VMLQpWl5CC+yKc4/2DL/OI76SVE9etO8cB6WdqmjzEBP8sVRhoWzSGG4UVBbmPvRTfJRCqssdY=
X-Received: by 2002:a17:903:610:b0:240:764e:afab with SMTP id
 d9443c01a7336-245ff89cafdmr13185205ad.6.1755780764612; Thu, 21 Aug 2025
 05:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820233817.4050006-1-lizhi.hou@amd.com>
In-Reply-To: <20250820233817.4050006-1-lizhi.hou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Aug 2025 08:52:32 -0400
X-Gm-Features: Ac12FXwhzdJf225YIiSFvoai9KNyKZln0etB11o5p81pX9w3DGHzvfztlQg-ZAE
Message-ID: <CADnq5_NjpN79sWt9t9Zw2u=OkzpGOfMqjhUxSyyLNaFesdjObw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: accel: amdxdna: Update compiler information
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: ogabbay@kernel.org, quic_jhugo@quicinc.com, 
	jacek.lawrynowicz@linux.intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com, 
	mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 8:03=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
> The compiler information is outdated. Update it to the latest.
>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/accel/amdxdna/amdnpu.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel=
/amdxdna/amdnpu.rst
> index fbe0a7585345..42e54904f9a8 100644
> --- a/Documentation/accel/amdxdna/amdnpu.rst
> +++ b/Documentation/accel/amdxdna/amdnpu.rst
> @@ -223,13 +223,13 @@ Userspace components
>  Compiler
>  --------
>
> -Peano is an LLVM based open-source compiler for AMD XDNA Array compute t=
ile
> -available at:
> +Peano is an LLVM based open-source single core compiler for AMD XDNA Arr=
ay
> +compute tile. Peano is available at:
>  https://github.com/Xilinx/llvm-aie
>
> -The open-source IREE compiler supports graph compilation of ML models fo=
r AMD
> -NPU and uses Peano underneath. It is available at:
> -https://github.com/nod-ai/iree-amd-aie
> +IRON is an open-source array compiler for AMD XDNA Array based NPU which=
 uses
> +Peano underneath. IRON is available at:
> +https://github.com/Xilinx/mlir-aie
>
>  Usermode Driver (UMD)
>  ---------------------
> --
> 2.34.1
>

