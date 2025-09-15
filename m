Return-Path: <linux-kernel+bounces-817350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E1B580DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB2C7A4F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B5B1F1538;
	Mon, 15 Sep 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaoJU7gO"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890B57C9F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950625; cv=none; b=QoEUECQKvXSKx7iQ9yXs+5FpsTKJ8GRkZl6FVTUiqHVd5bRezuPdQoP05TgSajZbb1ECbF0saJRWREEnMx7yp5Q916McZww3Q4Hj53E6bALmc436QeaUkRqbRYrJkLgOMW9kuBrbriwjH3ScFE40lzJkQ5jsIRIgys/Ex4xelEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950625; c=relaxed/simple;
	bh=SNQX9jVuudWNKsVENtOK6ohBfS9ZpG3Y9l8Z5BV1MXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqL+8ocRqjVj6GtnKGa7Atqfxt/PL/wW9vpQh8HiOGCZXjeO51tx4jFAaUpGtgPEj0wsTrWSWxOodHxb2XgtArGkzf9GKPXMlU2Ei7RUNjqlfv2qiwJl2hhneNMCuE7MCPficD8YmoZdGrElWMbEWXq5HtLsTL+8ZI6t4CUCl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xaoJU7gO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f28da25b9so2135655a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757950621; x=1758555421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mHjWPU/zmI6VFe0ygBMZ/McjnLYznpUmAATZGQRdx4=;
        b=xaoJU7gOkMw+8vMGjBvbzG+BoslneTupIiUTZg9mSd3UkOfxlU/82UDfAncrwm9rpy
         cUge8A0PNdYlbyV8Ya01Es4n9lRPGgY537i9cRNuTUxS2v7O1mr8Y7PxIpPaXt2iqBPY
         apLuaAIx3j6Zyp0o6Hv9J+XqC5ZJNy8kQpY1lETtxyPMu+mkVIkiYahkuG755qMheFMx
         59w9JR4Y3VGrRWcNQruTh1uwU4yjIdf5Aop4T67jaZFEtyhogsVlAE9Oj0PqBK5LiF/R
         NvQWRNH1YekBmk+QkM6A6rQHKgnOB3Ltv8sX1g43URIw2cIJoB+C/OhsIgZLBn0bXbRe
         DARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950621; x=1758555421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mHjWPU/zmI6VFe0ygBMZ/McjnLYznpUmAATZGQRdx4=;
        b=amJqpoDVl5aZRC6lE2XVRGr9FZxUITrFAKcUnaa8TKOM480ULipiqljh6uuT7q4FCq
         07kIcZbsxF7zwA5KZTiRrQf8qLHO/qksqAE8fTbetpBdG2oEqtmfUI+XXQkAA0H4raYg
         ogrA6oGtl/FbIbj514jB5evEvn02E4SXj0/S88PhEFb4wb1uiNvoacRMLIAwnWTo69H7
         LBqsSgHaGNWkyd5FvReLEZIe+xTHId5qUcMvDNEehDM6FdTN2ygBheTKXI44Lw73ozkd
         WULy57x0cLPVsYNlyR3rXVM5UPmVEmo1MrzPQ2OWKYitCiF3/H7CmiHGNAzSsnklHfEZ
         zpJA==
X-Forwarded-Encrypted: i=1; AJvYcCVP4X60vautZddwKSIBbC1+cu3Ni59jemxibwBLb+GjnQbRfgC71kMgqXCcw7Xr21DqyTvjXVr/iOizbRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5wFkls+O17vDFzKlgRr4rVbtBBWzqsoeiUk2yFPGwAD5T6sr
	wS5QoGp6QTR56GUFoAYvIh2lP9LM6lZ2KIWGLEodJDNHpWZPvWggbbNH/BFC6jVvlpvTdcnpmSb
	MGX8z+83M6Pqtj5mkzMI/51ABZ6pTmdyYXK1bg47vlZxJrG3jl473aVM=
X-Gm-Gg: ASbGncstulBWA5YhERcmI/SArye+2a3fA6hShCWR/ffv29WUDFYvxjIZDdCm3AFYMPa
	LRTrA0XwhytztjuXuM1TEiagGZL1SjlqvX22N76rRnNdSbqqn4YeOrWyCZFddRd299RhXPlJA3n
	eV8af+Elc1IP4EMSY+fknB+86L+KE9njm2RmlffiPC9NFlFpmy+L1k2gLaP3y8seh8gkNY0z35E
	Tqt6eZjOsX6ua0NnwRIIUISqOwG/ND8Z0acfy3o4H13erOEPS0IFdG+izFZdcRVWJSwhgz6UjmL
	lNFYQFqvNvrssAEPyaMTs+tHEqsUvSJCHNH9q17r74xmOTC8qA==
X-Google-Smtp-Source: AGHT+IHaCGR4bJP0zk6dQyNjvAMqOj83vg1/N6S59DAb5aM9KrE92htEXPWeBR2BYJio9XOPDSBuQKHMC8DpDsz6s6c=
X-Received: by 2002:a05:6402:21d1:b0:61e:c42e:825f with SMTP id
 4fb4d7f45d1cf-62ed825a71cmr11238844a12.2.1757950621239; Mon, 15 Sep 2025
 08:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609151531.22621-1-dawei.li@linux.dev>
In-Reply-To: <20250609151531.22621-1-dawei.li@linux.dev>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 15 Sep 2025 09:36:48 -0600
X-Gm-Features: AS18NWCAJ6Emz8XYDyjxhwrpmsWu02aESGwF6JloSGyRuZtGrxXg5HjO3xltCzU
Message-ID: <CANLsYkxLXxj9=+TvsLNmO7c41_hzay2oe-4njkVU=4kmJrmccQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] rpmsg: Introduce RPMSG_CREATE_EPT_FD_IOCTL uAPI
To: Dawei Li <dawei.li@linux.dev>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Jun 2025 at 09:15, Dawei Li <dawei.li@linux.dev> wrote:
>
> Hi,
>
> This is V4 of series which introduce new uAPI(RPMSG_CREATE_EPT_FD_IOCTL)
> for rpmsg subsystem.
>
> Current uAPI implementation for rpmsg ctrl & char device manipulation is
> abstracted in procedures below:
> - fd = open("/dev/rpmsg_ctrlX")
> - ioctl(fd, RPMSG_CREATE_EPT_IOCTL, &info); /dev/rpmsgY devnode is
>   generated.
> - fd_ep = open("/dev/rpmsgY", O_RDWR)
> - operations on fd_ep(write, read, poll ioctl)
> - ioctl(fd_ep, RPMSG_DESTROY_EPT_IOCTL)
> - close(fd_ep)
> - close(fd)
>
> This /dev/rpmsgY abstraction is less favorable for:
> - Performance issue: It's time consuming for some operations are
> invovled:
>   - Device node creation.
>     Depends on specific config, especially CONFIG_DEVTMPFS, the overall
>     overhead is based on coordination between DEVTMPFS and userspace
>     tools such as udev and mdev.
>
>   - Extra kernel-space switch cost.
>
>   - Other major costs brought by heavy-weight logic like device_add().
>
> - /dev/rpmsgY node can be opened only once. It doesn't make much sense
>     that a dynamically created device node can be opened only once.
>
> - For some container application such as docker, a client can't access
>   host's dev unless specified explicitly. But in case of /dev/rpmsgY, which
>   is generated dynamically and whose existence is unknown for clients in
>   advance, this uAPI based on device node doesn't fit well.
>
> An anonymous inode based approach is introduced to address the issues above.
> Rather than generating device node and opening it, rpmsg code just creates
> an anonymous inode representing eptdev and return the fd to userspace.
>
> # Performance demo
>
> An simple C application is tested to verify performance of new uAPI.
>
> $ cat test.c
>
> #include <linux/rpmsg.h>
>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/ioctl.h>
> #include <fcntl.h>
> #include <string.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <sys/time.h>
>
> #define N (1 << 20)
>
> int main(int argc, char *argv[])
> {
>         int ret, fd, ep_fd, loop;
>         struct rpmsg_endpoint_info info;
>         struct rpmsg_endpoint_fd_info fd_info;
>         struct timeval start, end;
>         int i = 0;
>         double t1, t2;
>
>         fd = -1;
>         ep_fd = -1;
>         loop = N;
>
>         if (argc == 1) {
>                 loop = N;
>         } else if (argc > 1) {
>                 loop = atoi(argv[1]);
>         }
>
>         printf("loop[%d]\n", loop);
>
>         strcpy(info.name, "epx");
>         info.src = -1;
>         info.dst = -1;
>
>         strcpy(fd_info.name, "epx");
>         fd_info.src = -1;
>         fd_info.dst = -1;
>         fd_info.fd = -1;
>
>         while (fd < 0) {
>                 fd = open("/dev/rpmsg_ctrl0", O_RDWR);
>                 if (fd < 0) {
>                         printf("open rpmsg_ctrl0 failed, fd[%d]\n", fd);
>                 }
>         }
>
>         gettimeofday(&start, NULL);
>
>         while (loop--) {
>                 ret = ioctl(fd, RPMSG_CREATE_EPT_IOCTL, &info);
>                 if (ret < 0) {
>                         printf("ioctl[RPMSG_CREATE_EPT_IOCTL] failed, ret[%d]\n", ret);
>                 }
>
>                 ep_fd = -1;
>                 i = 0;
>
>                 while (ep_fd < 0) {
>                         ep_fd = open("/dev/rpmsg0", O_RDWR);
>                         if (ep_fd < 0) {
>                                 i++;
>                                 printf("open rpmsg0 failed, epfd[%d]\n", ep_fd);
>                         }
>                 }
>
>                 //printf("Number of open failed[%d]\n", i);
>
>                 ret = ioctl(ep_fd, RPMSG_DESTROY_EPT_IOCTL, &info);
>                 if (ret < 0) {
>                         printf("old ioctl[RPMSG_DESTROY_EPT_IOCTL] failed, ret[%d], errno[%d]\n", ret, errno);
>                 }
>
>                 close(ep_fd);
>         }
>
>         gettimeofday(&end, NULL);
>
>         printf("time for old way: [%ld] us\n", 1000000 * (end.tv_sec - start.tv_sec) + end.tv_usec - start.tv_usec);
>         t1 = 1000000 * (end.tv_sec - start.tv_sec) + end.tv_usec - start.tv_usec;
>
>         if (argc == 1) {
>                 loop = N;
>         } else if (argc > 1) {
>                 loop = atoi(argv[1]);
>         }
>
>         printf("loop[%d]\n", loop);
>
>         gettimeofday(&start, NULL);
>
>         while (loop--) {
>                 fd_info.fd = -1;
>                 fd_info.flags = O_RDWR | O_CLOEXEC | O_NONBLOCK;
>                 ret = ioctl(fd, RPMSG_CREATE_EPT_FD_IOCTL, &fd_info);
>                 if (ret < 0 || fd_info.fd < 0) {
>                         printf("ioctl[RPMSG_CREATE_EPT_FD_IOCTL] failed, ret[%d]\n", ret);
>                 }
>
>                 ret = ioctl(fd_info.fd, RPMSG_DESTROY_EPT_IOCTL, &info);
>                 if (ret < 0) {
>                         printf("new ioctl[RPMSG_DESTROY_EPT_IOCTL] failed, ret[%d]\n", ret);
>                 }
>
>                 close(fd_info.fd);
>         }
>
>         gettimeofday(&end, NULL);
>
>         printf("time for new way: [%ld] us\n", 1000000 * (end.tv_sec - start.tv_sec) + end.tv_usec - start.tv_usec);
>         t2 = 1000000 * (end.tv_sec - start.tv_sec) + end.tv_usec - start.tv_usec;
>
>         printf("t1(old) / t2(new) = %f\n", t1 / t2);
>
>         close(fd);
> }
>
> # Performance benchmark
>
> - Legacy means benchmark based on old uAPI
> - New means benchmark based on new uAPI(the one this series introduce)
> - Time are in units of us(10^-6 s)
>
> Test    loops   Total time(legacy)      Total time(new) legacy/new
> 1       1000    218472                  2445            89.354601
> 2       1000    223435                  2419            92.366680
> 3       1000    224263                  2487            90.174105
> 4       1000    218982                  2465            88.836511
> 5       1000    209640                  2574            81.445221
> 6       1000    203816                  2509            81.233958
> 7       1000    203266                  2458            82.695688
> 8       1000    222842                  2835            78.603880
> 9       1000    209590                  2719            77.083487
> 10      1000    194558                  2621            74.230446
>
> 11      10000   2129021                 31239           68.152662
> 12      10000   2081722                 27997           74.355181
> 13      10000   2077086                 31724           65.473648
> 14      10000   2073547                 28290           73.296112
> 15      10000   2055153                 26957           76.238194
> 16      10000   2022767                 29809           67.857593
> 17      10000   2054562                 25884           79.375753
> 18      10000   2036320                 28511           71.422258
> 19      10000   2062547                 28725           71.803203
> 20      10000   2110498                 26740           78.926627
>
> 21      100000  20802565                260392          79.889417
> 22      100000  20373178                259836          78.407834
> 23      100000  20361077                256404          79.410138
> 24      100000  20207000                256759          78.700260
> 25      100000  20220358                268118          75.415892
> 26      100000  20711593                259130          79.927423
> 27      100000  20301064                258545          78.520428
> 28      100000  20393203                256070          79.639173
> 29      100000  20162830                259942          77.566649
> 30      100000  20471632                259291          78.952343
>
> # Changelog:
>
> Changes in v4:
> - Build warning of copy_to_user (Dan).
> - ioctl() branches reorder (Beleswar).
> - Remove local variable fd and pass &ept_fd_info.fd to rpmsg_anonymous_eptdev_create().
> - Link to v3: https://lore.kernel.org/all/20250519150823.62350-1-dawei.li@linux.dev/
>
> Changes in v3:
> - s/anon/anonymous (Mathieu)
>
> - API naming adjustment (Mathieu)
>   - __rpmsg_chrdev_eptdev_alloc ->  rpmsg_eptdev_alloc
>   - __rpmsg_chrdev_eptdev_add ->  rpmsg_eptdev_add
>
> - Add parameter 'flags' to uAPI so user can specify file flags
>   explicitly on creating anonymous inode.
> - Link to v2: https://lore.kernel.org/all/20250509155927.109258-1-dawei.li@linux.dev/
>
> Changes in v2:
> - Fix compilation error for !CONFIG_RPMSG_CHAR config(Test robot).
> - Link to v1: https://lore.kernel.org/all/20250507141712.4276-1-dawei.li@linux.dev/
>
> Dawei Li (3):
>   rpmsg: char: Reuse eptdev logic for anonymous device
>   rpmsg: char: Implement eptdev based on anonymous inode
>   rpmsg: ctrl: Introduce RPMSG_CREATE_EPT_FD_IOCTL uAPI
>
>  drivers/rpmsg/rpmsg_char.c | 129 ++++++++++++++++++++++++++++++-------
>  drivers/rpmsg/rpmsg_char.h |  23 +++++++
>  drivers/rpmsg/rpmsg_ctrl.c |  35 ++++++++--
>  include/uapi/linux/rpmsg.h |  27 +++++++-
>  4 files changed, 182 insertions(+), 32 deletions(-)
>

I intend to merge this when 6.18-rc1 is released in 3 or 4 weeks.

Thanks,
Mathieu

> ---
> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
>
> Thanks,
>
>         Dawei
> --
> 2.25.1
>

