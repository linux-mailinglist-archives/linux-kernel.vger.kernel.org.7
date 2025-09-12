Return-Path: <linux-kernel+bounces-813330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C86B543A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75061C272DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0C2BE64A;
	Fri, 12 Sep 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeEbjFVy"
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9C215198
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661504; cv=none; b=lsvig2uJunJvXWkaTyX8KhNL9ZBeo6+9lsrc8yy3QzIhEyU4Iq5CGJxNpxN1KEltGYW5HxzfOELcAWLeS9tQrxYXVaU7JVqI3BILXv98T8OYFvAqwZ5a0W4x/yJjvN7pX+d025MAl+kIkah436+BmYnjuNGKWQnVwmaUOKU2C2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661504; c=relaxed/simple;
	bh=JQDWxLpHWVHgp9kMN9Ik0pZRLEk1IRX+E+X0m4nr8nM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rJ4p+D+9uc2Ie+MIzwx1y9A0zIInOQU5nUz1lvq1XKGIwUGnIpC4cga1zj7X7QM6zbOlj3DJksRqsEM+PuI0T1dEZEv+S7b+Iq36mnLzzni4TREM9aF+BA4o2oeStpM+p9fzaKQja94xTDvH6kbcAjz6eq8UNIawdsGqE6ItR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeEbjFVy; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-61381743635so1045649d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757661501; x=1758266301; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TEKN93EeN4xaGzNtqc/pE4ekZwBIufys1kX3W9ZqEO4=;
        b=BeEbjFVyOU7KgxKppeenzBjr6K2LyN1flYJMmM3JWM1dWCWQ36hGupqJ1ZS//Ao51a
         ys6ZuWz5C2Iy1us8y2DeFHYNXM1OR2JcAlMWiW9L67125pMBsW/rbOe7DnaLh4QGwO+s
         eK+bNPhZ4NUnqkrNop+oaFMpyk35nw6D1eYuQEttLAhi5mVGWPbvEo3sx3hbGace/0O4
         kwJYqj9+sBCA82QCLsPfr6FLE79/3osULT6OEDR7zMbdW+UlSAHO1XS156k4kZd7rhaI
         qpOwlUF/ZlK6gpskDXIBuYPBisxOe+OjPPq8ZaUR2bgh2e/YS74me85/+uQlYZenRXHn
         kuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757661501; x=1758266301;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEKN93EeN4xaGzNtqc/pE4ekZwBIufys1kX3W9ZqEO4=;
        b=Xctf/ERsjn5xZydnsFMPFcdpc3B8XBlmuBkO8Yy4u/Lqb3UjrInspO+4X4YSzpZJ6b
         UV/nBE5miWFr7fzKuPWHMzVtZUQ6SNl2w/OhRwow6yRGuRim/aJ4vrNcbg3P5lGlOKjQ
         BH8RMyMihfk52a4+cRcv/jZyfibwRbrO5jYZbtIawloDh8e7xt0LO45VA3urdJNsE325
         6phgQGuKjgPCWDUiwcFk2i4S1GJv+rbmC7MpJKZRF9CQpHlun5eo6mlwjjgCTVuPThj5
         ab9cSgHKL78VXSx/dvGzuejBM5wumMr/UHS7CKtNnqZPHhJfWSFvwbTaN+kxZP/JMNTq
         mwqg==
X-Gm-Message-State: AOJu0YyujEk1wRu3rIkLqMkGFjqvtL6g5I2bLQacjW+F3/5wT2kFFpZN
	yaTHq+B0Y5Ufg6j63oLrB9PTIKiPj1qoQivM+/Wp8PhoFkhVDPexhmzoSbk+2DxoD7ULwKjBWum
	9FRQsUMBLlquxGn0gbavTwoUbxdkg6SkAuQyMoX0=
X-Gm-Gg: ASbGncvQqbQDm4T4hUODOhtU9n+NggkeHmgpskEL1rDbm/xVtvc5Dxh0FSe/6DplnG5
	e8KIDmzSuVtsrWEskpwIg9kBmRq9BfIrbczN6FqpKPqVNtEtHyj7HOYw5P9uiu6nsLkAU7ttMz1
	Hw7gZDL/FZhj2A3I6Aob1DpCvyzrG7deGlx+Iq8nGr2D+40gEmB8n9l2fvvnZwfLU7X/YNamdB/
	ywYFURsn3f/uUjN6tzty+8WaRMQhk7ZW757dqW6xCTnLnrtGs1T
X-Google-Smtp-Source: AGHT+IGnuGfaBmOZ13LPQ+BIfprgwdL42c8szidhhSr29HoqfMNRZLoraGkIzDIs/zE8hMSRvyxuM8I6D+sMxCUpvms=
X-Received: by 2002:a05:690e:158e:10b0:5fc:9cd0:3ce0 with SMTP id
 956f58d0204a3-6271c107b48mr1637244d50.15.1757661501319; Fri, 12 Sep 2025
 00:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Fri, 12 Sep 2025 12:48:10 +0530
X-Gm-Features: Ac12FXzCzuEcr7rfh_hZTnWane76xXKFYPD5XgYxVQtcaoD7ohe2_1RYwKloCcE
Message-ID: <CAFf+5zgHTkern=oZznsn3S6HKWYuC3vW086AXe+Gy5GKtzr=Ow@mail.gmail.com>
Subject: List of more C programs.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

------------------------
List of more C programs.
------------------------

* Shared condition variable across processes on the same machine example - make
  condition variable shareable across processes by setting condition variable's
  attribute to PTHREAD_PROCESS_SHARED -
            pthread_condattr_setpshared(&condAttr, PTHREAD_PROCESS_SHARED);
* Shared condition variable (library?) across remote processes on different
  machines.
* Generic dynamic key-value store library (in memory).
* Generic dynamic key-value store library (on disk).
* Generic dynamic key-value store library (on disk + cache in memory).
* Parse command line options (library?) and store as key-value pairs.
* Program to dump function names in a C program.
* Multi-line grep (call it mgrep) (search pattern will be interpreted as a regex
  by default, unless -F option is given).
* Only one function to get a list of IP addresses for a host name and only one
  function for getting the host name for an IP address (these functions can call
  other library functions / other functions).
* Program to discover all devices on LAN (IP addresses and host names) (see
  source code of nmap).
* Create a 1-50 GB empty file and create a (self developed) file system in that
  file.

* Give linux command line programs as functions (implement them as functions)?

* String library (more) functions: convert_num_to_words() (USA format),
  get_random_alphabetical_string(int length) - the returned string can be used
  as a file/directory name for a temporary file/directory,
  get_random_alphanumeric_string(int length) - the returned string can be used
  as a file/directory name for a temporary file/directory,
  get_file_name_from_path(), get_directory_name_from_path().

* File library? - get_file_size(), get_number_of_lines_in_file(),
                  get_file_permissions(), get_file_checksum(), copy_file(),
                  move_file(), rename_all_files_in_folder(),
                  replace_string_in_file(int create_backup, int case),
                  replace_regex_match_in_file(int create_backup, int case),
                  find_string_in_file(int case), find_regex_in_file(int case),
                  does_file_exist(), is_file_empty(),
                  create_temp_dir_and_get_name(),
                  create_temp_file_and_get_name(),
                  replace_line_in_file(long line_num),
                  replace_first_matching_line_in_file(),
                  replace_last_matching_line_in_file(),
                  replace_all_matching_lines_in_file(),
                  replace_regex_first_matching_line_in_file(),
                  replace_regex_last_matching_line_in_file(),
                  replace_regex_all_matching_lines_in_file(), is_regular_file(),
                  is_directory(), is_symlink().
                  copy_all_lines_from_first_match_to_last_match_to_new_file(
                        char *intput_file_path, char *output_file_path,
                        int regex_1, char *str_or_regex_1, int regex_2,
                        char *str_or_regex_2, int case-sensitive).

* Linux kernel - Character device driver example (See LDD examples on
  github.com).
* Linux kernel - /proc fs example.
* Linux kernel - PCI/PCIe device driver example (See LDD examples on
  github.com).

* Graphical apps using SDL:

        ** Personal expenses management.
        ** Flatmates expenses management.
        ** Task management (with reminders).
        ** Notes.
        ** Project management.
        ** Stock portfolio.
        ** Shared folder between linux machines.
        ** File transfer on LAN.
        ** Chat on LAN (send files also).

