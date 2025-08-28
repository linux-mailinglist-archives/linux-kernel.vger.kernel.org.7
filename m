Return-Path: <linux-kernel+bounces-789524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E502B396CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77C6464E20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5592D97A6;
	Thu, 28 Aug 2025 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2aGbqeP"
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE22D6E7C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369362; cv=none; b=fjhP2YfJJ44SYcq3WS5wcDSU9LhTObxHpV6MfuKrME0zInY7GzENW0IFrG/Yfqol2Wizdc1boXKAAHJeJ+emI46CeMZu29CLP2z653cwp10lEO37IEoB+6IWTVdN4q0NCzqpSHxC2BJ7TeeedzqmO6IzGXd+xAoWyrcatcrVr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369362; c=relaxed/simple;
	bh=OguTCqAGhd0jJkn6Ix2Fvo1ieQFOhvRQl9Ap5adHE4g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tQTehMDgwFEBCUHSyOg49G07f/6MYdVhuLjzZUEzaybCWl3jkyg/wtmKUZ4SkRAyjWv34Z2TQbJJob+Kg4C5iJc2vvx6F7WsozuYxxnvoqvRHJFh98B+kSeSrDTW0q9kQ/E50tWrrs9IUMy1ZNKpP0VaXitI0A9njj7tz6+gbig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2aGbqeP; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e970b511046so93006276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756369360; x=1756974160; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qiGPM+suLwP4dkp89SR/0dFOvLXVoBhrGyxfdVbyG80=;
        b=A2aGbqePx+ZcYxbrQ2p2IlLotsmi6i5pNz5SrfJkMKYIKiuf+7etasEz+0dOtVPWLQ
         aIjzspFdBJGt5gsywhruOOLWNgfOxQjO8HQVwlOHZDPlMjwczK+dEUB7kpxFL3bK1AqB
         d4FiSg3R9kno1TgaInXgigb3xBqOd2uNI1wESXAuJeowD6p2S+CN4QxFq2CNQeulr/2y
         eqsq9MWCiwusuUHkFoSOc58ICGCBa+iIUp71Oa5Vba4r7bAoz/7Wtf0Cgvjq0QRZvhp8
         rU87wGo6bUEGqQiA92bclsOqEuJJpeyDvA0WwzvabtsAAvsq8HD5/8UPph4Sd5X0/fAs
         beNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369360; x=1756974160;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiGPM+suLwP4dkp89SR/0dFOvLXVoBhrGyxfdVbyG80=;
        b=vMnch5DGShrUtZ0mvnbgJ/jLQGYzdVZfNIfcR33t1YjMu9AAiOHora9Gln5umr8/eF
         HKUKi5JEAF1ZwEuhmKORmLk4lX7ufJCj1LN852g0UKjej0xBv9d14P3VrFmowAUHwyRl
         v/s9Q4sAi8JoUwPTDMaZQHcCRQEbzOfir8yzrv7X9fYmQO3SME533fyuiFqk7KzXyMiT
         gSEfUT/rWczJuhrjDZGnbqnNYyhpP4g34zpO4Cyvt+IcReSaOmwfMwVR67aSl1GgxwCr
         qYa/fl+BW//WvJ34z7B6SAvneTAJnuQ7bZk4ITvZwO+s8I6prb/gxojndJfby58bQN+r
         7M0w==
X-Gm-Message-State: AOJu0YxZvKr7CjfH9Hl/q5SfcXcR2saU9bLoYmVrmVC7XSLDe95RK+TS
	j9jD0ekchTNYYh+T2BQTau+6QTmcxNO8PRAap2tYmTr0Wj2oKMcZ4WTJ5sQmgpKwhZlv4mDQwed
	lGYKzVTuS63f1j9CjFmEsOPaYyzMn1fL/5XPbkcjOzA==
X-Gm-Gg: ASbGncvn5bQPpIeAvd/13D9uI92+Kcz+mrf5rYGXCNYNQeLHyUr5ZlbdH0QrPDvdMH2
	vczh9EJFSVzh4GNMq+BVDYb11KXEy8U8U1kXChgQXgDQ52ORo7bcgt13SmB53wIbMrofTnorNoC
	z8Zk4JAzPVebCRc+SEQvs7fRA35Zz8kx6I1lpaM3ibNnNnV4L4onxOeG37/522orLGjKKcfKn1q
	DWL04cFOB/ZvE714nhV1AhZfvvtLZx7WYjEkR02lP9zlGKO5z31
X-Google-Smtp-Source: AGHT+IGpO98Ar+rSy2BeS0gKApO+vSumveBXzeFdbqlz3iXCfvH7VbmHDNB00pMDHAFnn1M4eaGFm7TMsDNEGDq7Lkg=
X-Received: by 2002:a05:6902:2b91:b0:e95:d920:208d with SMTP id
 3f1490d57ef6-e95d9202f4bmr17648328276.43.1756369359492; Thu, 28 Aug 2025
 01:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Thu, 28 Aug 2025 13:52:27 +0530
X-Gm-Features: Ac12FXzj8IIOVSZPHdnIQpTe2yXDtApCd7zPHtKdwlT19chkee11nCnrw8xE-JU
Message-ID: <CAFf+5zg91=Ei-L-XxroiTQKqVwpG+hVSU5ahOkEuWB0_A1WqbA@mail.gmail.com>
Subject: Signal handler example (Three files: signal_handler_example.c,
 compile_signal_handler_example.sh, and ReadMe.txt).
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Signal handler example (Three files: signal_handler_example.c,
compile_signal_handler_example.sh, and ReadMe.txt).

------------------------------------
signal_handler_example.c
------------------------------------

/*
 * License:
 *
 * This file has been released under "unlicense" license
 * (https://unlicense.org).
 *
 * This is free and unencumbered software released into the public domain.
 *
 * Anyone is free to copy, modify, publish, use, compile, sell, or distribute
 * this software, either in source code form or as a compiled binary, for any
 * purpose, commercial or non-commercial, and by any means.
 *
 * For more information about this license, please visit - https://unlicense.org
 */

/*
 * Author: Amit Choudhary
 * Email: amitchoudhary0523 AT gmail DOT com
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>

// Function prototype for gcc flag -Werror-implicit-function-declaration.
void signal_handler_function(int signum);

void signal_handler_function(int signum)
{

    static long count = 0;

    count = count + 1;

    printf("\n");
    printf("--------------------------------------------------------------\n");
    printf("%s(): \"\"SIGNAL HANDLER FUNCTION CALLED\"\".\n", __FUNCTION__);
    printf("This process has woken up because the signal \"SIGUSR1\" (signal"
           " number %d) was received.\n", signum);
    printf("Now, this process will again go back to sleep.\n");
    printf("This signal handler has been called \"%ld\" %s till now.\n",
           count, (count > 1) ? "times" : "time");
    printf("--------------------------------------------------------------\n");

    return;

} // end of function signal_handler_function()

int main(void)
{

    struct sigaction sa;
    pid_t mypid = -1;
    int retval = -1;

    memset(&sa, 0, sizeof(sa));

    sa.sa_handler = signal_handler_function;

    retval = sigaction(SIGUSR1, &sa, NULL);

    if (retval < 0) {
        printf("\n%s(): Error: sigaction() returned error. Signal handler was"
               " not installed. Exiting...\n", __FUNCTION__);
        exit(EXIT_FAILURE);
    }

    printf("\n%s(): Signal handler installed successfully.\n", __FUNCTION__);

    mypid = getpid();

    while(1) {
        printf("\n%s(): The pid of this process is %d.\n", __FUNCTION__, mypid);
        printf("\n%s(): This process is going to sleep. This process will wake"
               " up when the signal \"SIGUSR1\" (signal number 10) will be"
               " received. If any other signal is received then the results are"
               " undefined.\n", __FUNCTION__);
        pause();
    }

    return 0;

} // end of function main()

-------------------------------------------------
compile_signal_handler_example.sh
-------------------------------------------------

#!/bin/bash

set -x

rm -f signal_handler_example.out

gcc -Wall -Werror -Wextra -Wundef -Wunreachable-code -Winit-self
-Wparentheses -Wconversion -Wsign-conversion -Wsign-compare
-Werror-implicit-function-declaration -Wmissing-prototypes
-Wmissing-declarations -Wformat-security signal_handler_example.c -o
signal_handler_example.out

----------------
ReadMe.txt
----------------

File "signal_handler_example.c" gives an example of how to install a user
defined signal handler that will override the signal handler provided by the
system for that signal.

In this file, we install a signal handler for the signal "SIGUSR1" (signal
number 10).

This program, on startup, goes to sleep waiting for the signal "SIGUSR1". When
the signal "SIGUSR1" is sent to this program, this program wakes up and the
user's signal handler function is called. After the signal handler function
returns, this program again goes back to sleep waiting for the signal "SIGUSR1".
This goes on in an endless loop until the user terminates the program.

If any other signal is sent to this program then the results are undefined.

You can send the signal "SIGUSR1" to this program by running the following
command in a terminal shell (bash, etc.):

            kill -10 pid_of_this_program

So, if the pid of this program is 14753, then you can send "SIGUSR1" signal to
this program as follows:

            kill -10 14753

This program prints its pid on the output screen, so you can use that pid
directly, instead of grepping the output of "ps -aef".

---- End of ReadMe ----

