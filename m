Return-Path: <linux-kernel+bounces-821990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83118B82C92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F423B3223
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711A242D9B;
	Thu, 18 Sep 2025 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYy3YCEW"
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83F213236
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167073; cv=none; b=CVV7ydoLrWyIpx0UyqjZ6GPEZbiHCZSmZY1VIcEsFN0ET0Hx6kCGgH8FUeFXjBAPPJuZ0V6wuFsRMOLNB4g4GE03lsbw9ygAQMulexFE4hhSdE9vvauqz/GWghAgrhPpNZ4G52tfK8E0inH79ASeHoMh50LcI/63aCI3xZhX7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167073; c=relaxed/simple;
	bh=nxorRt81XsoejgZZPF3UzrM0i94qwCD06NgAc8rgm9w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NRiMUYnsvvKWSDEYmFS3l6rBWqxUKXw1V5fU/rPymx9WN6pbLenX/P2jr1/khbnN2vGvIkg/4agQjoVkTBFhpm2sqwGjNOtt9QD/8wnFCp4BegJ1n5L8iT7hiDK3HjBn+yYnBmDMFWIDlv2f48w1GfkCb/diUzZX+wrTfu2Xajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYy3YCEW; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-ea5d7191a64so50341276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758167070; x=1758771870; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0qxhuQsPdBmCPabTs5MbnSs7DgbCrs8k2BIPvl1mJFc=;
        b=YYy3YCEW3xXiIvbv5WSyXyKD1xhYvZkIqXoCiUbQ1Lk5momomqKOHURj7lrrolzQlw
         o0qqXvPkoBiiU6qZCYMdyNGsSeTnsCfL8Z7/REnwd7IV++9KN3DAuVSphkhTVihWCKic
         4aPBH49yjZVvIMx6Upcb2bBX7xZv6PTWVoaCcEYIaWercBadKYU4OwEgLArhlG9tqCYS
         Tn6JiD8gUe3sWEERO5vW2UhCfOKRwMILZmGvyfV2CXhAcD5JUkJiES5h5krXXmT4gIH4
         wS5K3MSkngWjhMe2d+iB3Tv/yVyKRhWJDOGqhkMCnxuWXA7CVAC+LgdcIq61XU1QZiUY
         ANow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758167070; x=1758771870;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qxhuQsPdBmCPabTs5MbnSs7DgbCrs8k2BIPvl1mJFc=;
        b=L84g0qrUJbhWVO/UJLyndC4YV5SDfOuuK6783XqcDwTxfNqeR6eQrdc+trNwCQXzri
         r2/zpngAPBJ8Km0xcWO1AH96FKXUrsex/iEQaUyenChbLxyZng2S+VDpoZad627jwTmm
         1RDb8z38W1nG5IVyCIBWVX1PwuxyUiZV+lFZFoG+VEIR3Cwik2TyANL6nqGiPzWS4PY6
         hM1h2kNhxeMRgMLAOp4BiWSKEc3SJnPOdnwzskhm2JxvbCrNc/ZaHLJsjFNMy037LiEN
         AkPwgWxOxxbGVzXu6WWzwep8allI5//CRzO3hAbA/dN2CcvVo3NIdtVuM956IZorOnzt
         fdGQ==
X-Gm-Message-State: AOJu0YwMkDGa50KttOXKmmJOUp1hIOI4CDXdpFMUKE0s4wmMMbSgdsjg
	CW0/7BDpGxRE9iQzPBmgY6xofKGlFHq9CdBwerK1YNIZbTTGV6gAW7M0eE1xwhBHu91atLCkTXw
	yqDrmI7WMmIobHmEuQ0UKQ1QRR5upUf1c/MOBy6w=
X-Gm-Gg: ASbGncsfymJVRckecah2n59yXLCIki08L3Dd2spPSy4eXYXArV/mJZ21qT2vvUq423X
	3Pv5YW3EVLVEvDY9dAmh+nQ7YIV158FLjU3IhF0HfEcP0KMUCwZUvTy12yPBu+OtBBq1NUvysWw
	yGF/qDSOPp3u7PtxocM/JQ8GJd7VJcOydvS6JyPe4eRIxVAdQPdxpZYQmja0FtbrpauNX+tBkKi
	gsXIeK5jVVQjkReWbPTru2nsUTujnXoQKuvsSGjo8xg//D/3mlzTJTj7eT5
X-Google-Smtp-Source: AGHT+IHE7C16PvOyyqxeBS6Nl/wLef/Giqq+DrsqLDI8P1JakbI1y3Yd2bvbjY+8VaLbQekmW7N0HKotiB2zY6kz8HI=
X-Received: by 2002:a05:6902:6b07:b0:e97:398:42d with SMTP id
 3f1490d57ef6-ea5c0380cf5mr3348198276.7.1758167070538; Wed, 17 Sep 2025
 20:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Thu, 18 Sep 2025 09:14:19 +0530
X-Gm-Features: AS18NWDdodwm1peXMMdaQaCRBEXc9cPPo0MSIx9eukoOIzIQauO99ANPheY3thk
Message-ID: <CAFf+5zi6ZwVdY_ZQ98vH_m00xPzb9-VLf8MUE_jD1BZ6j+vJZA@mail.gmail.com>
Subject: mmap example (Three files: mmap_example.c, compile_mmap_example.sh,
 and ReadMe.txt).
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mmap example (Three files: mmap_example.c, compile_mmap_example.sh, and
ReadMe.txt).

---------------
mmap_example.c
---------------

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
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/mman.h>

// Function prototype(s) for gcc flag -Werror-implicit-function-declaration.
long get_file_size(char *file_path);
void mmap_file_and_print_contents(char *file_path);

long get_file_size(char *file_path)
{

    struct stat st = {0};
    int retval = -1;

    if (!file_path) {
        fprintf(stderr, "\nError: %s(): Argument 'file_path' is NULL.\n\n",
               __FUNCTION__);
        return -1;
    }

    retval = stat(file_path, &st);

    if (retval < 0) {
        fprintf(stderr, "\nError: %s(): stat() call failed for file \"%s\": %s."
               "\n\n", __FUNCTION__, file_path, strerror(errno));
        return -1;
    }

    return st.st_size;

} // end of function get_file_size()

void mmap_file_and_print_contents(char *file_path)
{

    int fd = -1;
    long file_size = -1;
    long page_size = -1;
    char *addr = NULL;
    long num_bytes_read = -1;
    long offset = 0;
    long i = 0;
    char *retval_ptr = NULL;

    if (!file_path) {
        printf("\nError: %s(): Argument 'file_path' is NULL. Exiting..\n\n",
               __FUNCTION__);
        exit(EXIT_FAILURE);
    }

    fd = open(file_path, O_RDONLY);

    if (fd < 0) {
        printf("\nError: %s(): Could not open file \"%s\" for reading: %s."
               " Exiting..\n\n", __FUNCTION__, file_path, strerror(errno));
        exit(EXIT_FAILURE);
    }

    file_size = get_file_size(file_path);

    if (file_size < 0) {
        close(fd);
        printf("\nError: %s(): Could not get the size of the file \"%s\"."
               " Exiting..\n\n", __FUNCTION__, file_path);
        exit(EXIT_FAILURE);
    }

    if (file_size == 0) {
        close(fd);
        printf("\nThe size of file \"%s\" is 0. There is nothing to print.\n\n",
               file_path);
        return;
    }

    errno = 0;
    page_size = sysconf(_SC_PAGE_SIZE);
    if (page_size < 0) {
        close(fd);
        printf("\nError: %s(): sysconf() returned error: Could not get page"
               " size%s%s Exiting..\n\n", __FUNCTION__,
               (errno ? ": " : ""), (errno ? strerror(errno) : ""));
        exit(EXIT_FAILURE);
    }
    if (page_size == 0) {
        close(fd);
        printf("\nError: %s(): Page size returned by sysconf() is 0. Because of"
               " this, this program will not work. Exiting..\n\n",
               __FUNCTION__);
        exit(EXIT_FAILURE);
    }

    while (1) {

        retval_ptr = mmap(addr, (size_t)(page_size), PROT_READ,
                          (addr ? (MAP_PRIVATE | MAP_FIXED) : MAP_PRIVATE),
                          fd, offset);

        if (retval_ptr == (char *)(-1)) {
            close(fd);
            if (addr) {
                munmap(addr, (size_t)(page_size));
            }
            printf("\nError: %s(): mmap() call failed: %s. Exiting..\n\n",
                    __FUNCTION__, strerror(errno));
            exit(EXIT_FAILURE);
        }

        addr = retval_ptr;

        num_bytes_read = (file_size < page_size) ? file_size : page_size;

        for (i = 0; i < num_bytes_read; i++) {
            printf("%c", addr[i]);
        }

        file_size = file_size - page_size;

        if (file_size <= 0) {
            close(fd);
            munmap(addr, (size_t)(page_size));
            return;
        }

        offset = offset + page_size;

    } // end of while (1) loop

    return;

} // end of function mmap_file_and_print_contents()

int main(int argc, char *argv[])
{

    if (argc != 2) {
        printf("\nError: This program expects only one argument which is the"
               " path of the file whose contents have to be printed on the"
               " output screen by mapping the file into memory.\n");
        printf("\nUsage: %s file_name\n\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    mmap_file_and_print_contents(argv[1]);

    exit(EXIT_SUCCESS);

} // end of function main

------------------------
compile_mmap_example.sh
------------------------

#!/bin/bash

set -x

rm -f mmap_example.out

gcc -Wall -Werror -Wextra -Wundef -Wunreachable-code -Winit-self
-Wparentheses -Wconversion -Wsign-conversion -Wsign-compare
-Werror-implicit-function-declaration -Wmissing-prototypes
-Wmissing-declarations -Wformat-security mmap_example.c -o
mmap_example.out

-----------
ReadMe.txt
-----------

File "mmap_example.c" calls mmap() system call to map a file into memory and
then it prints the contents of the file on the output screen.

This program doesn't map the whole file in a single mmap() call, it maps one
page at a time (page size was 4K bytes on the system on which this program was
tested). So, this program maps only 4K bytes at a time. So, if a file's size is
more than 4K bytes then this program will make multiple mmap() calls to read the
whole file.

---- End of ReadMe.txt ----

