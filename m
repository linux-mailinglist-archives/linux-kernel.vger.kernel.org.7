Return-Path: <linux-kernel+bounces-834789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C53BA5862
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EF42A57BE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232021FF23;
	Sat, 27 Sep 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XB7lOwWV"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0717A2E8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758942452; cv=none; b=Ew7LFbeckh5wzUtUtEy0oS5+LZ5hzEWhcJJStZmQ5yPx3+gHfp6NoGHyUUbvfc2WioLzBRDTf2JhAkF7dwq/4hRs0RThqsdZPc1KAHc1+ZUfwta39DtsX68Gdj/i+LSyCpEoTHWpipb8Td7vqVuwumdqyZ3HX4ZJeckMaV5EHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758942452; c=relaxed/simple;
	bh=KIWllFg56if3TbC6uvy6hmJ9HqcpA05vzmey5qzXPvc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=BqfgTp2anFSy08KOZKrODAaOKKmGhPYze0O0UbxuqK496pl+HV2n9qE9Xt0rTUZI+aLvGTYpDgb52YCjdxQOtnFW5aOHI7fnSDzjoqzaoGmcWPqV7IqBMxvmpSoCGd3MG/8tycphd5+jI6KCVrxnQhNqUXBBwWqekdYh6oU7ZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XB7lOwWV; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-795773ac2a2so23679996d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758942449; x=1759547249; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSAgZfMkE5F9jENlrny3LvdLwkaNKorgXutltGU+x+0=;
        b=XB7lOwWVBawLFA2yKand2UwL2+v/I3rFVXMysduEPrlZ3MBX09NPq8tQApRKmAUusi
         SyY0yE/GghdcwTrVvibaUzBH4Nq9a1dIYEuR4yQYwDraUMiqLvSdo84nXJoVEUDmCzER
         Z68ZwVEoDR7md99XHvtvJWvksja/0VB00PeYCHpK9qgncBq+lupRcTLuuad2PPJCTSEF
         l+M72j+3gsn+KXQ8f/jrtselF7AZadLdsueTKIF2R7xTjYjRVYYvos3nuTrZ7SmvlXhh
         dAFMCra7qYkqCxvpJZ93tlE2qJc0W9j189yJL0hB+LUK5WQPO0ZC75uVuteKXbm7hcBd
         ZRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758942449; x=1759547249;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSAgZfMkE5F9jENlrny3LvdLwkaNKorgXutltGU+x+0=;
        b=cHhwDXH2FppxVnkqYPrrOjL0+RKcDDPbJSRCw1my99nSTMbphAPnLBd6PyCGLLWTTX
         s0een+kxIPr8bttXW+dPIJSpp9+9SoHkNOXUjEcZiF03HFl1zjRGvHzQRDqaTGeKtSWL
         J7F3+YgTNaY1tEBuuSBpX+SBLc4kvcVhsakOej2wtetCbqeJ51BAb2Xu9dRzi7HbgCfe
         LhG3HzSrxQJ/gdy4gsDc1KFM6cztdhWcX1WUq/FbAZW7SwZZOR5ZEG/EATXV7E+oM5St
         4qPSsautMyJHhAQBcZ+9Qc2K/P04vuoZqorRvDCPR20lmU14wiRUk4IYYpMIxou8XQin
         XQgw==
X-Forwarded-Encrypted: i=1; AJvYcCUroij5E0VBrBZDgaP+LHmeBAvCwqCtEp9h5pmOMbRC8CkwHcuJNvqy4RaCGuRIUO7X6M2RmlSBZjZB0KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/B+XsnYJZ+RXlSi9y62ARQ99DaltOErhNvOFh6wjiL8CRK1Ao
	/MZBucNRaoEVKx1/XEL0bs6txKZ0Acy0D2W54NP1KG7jvG60IxpDIzuVGA4K3sIqr6GbRt1lkYW
	HpV8=
X-Gm-Gg: ASbGncvqUU+QqUsaY/igt8ge+/9mbfakF7ylp/6sFiwfs5McBmKEyJhzuPmWgRxWUUd
	cgV+zPbRzJm7wtYXuEL0mb5dcAPI11BkhZ+34brz/fAUwPdHCQOPiO5MLbN2JajcuCxH2PtHrDH
	5Ua+lvsyPMdoJFwaIpAeOzsGh+7voAYCU/zZELogbYSCj8M5NzByDQu7MTHj+Xg4MEjjX5mBO1/
	IB1/jSzDtpNzvVpXs4HDLf8IarIAlZisxLiR49FURyWutEDspXVlJMLcQN2U6oOzef8Jok7FJft
	VrYC0wYW/vUMV2yF8op4v3uOZ2X7ytT/5ncUfOCkaPPZEvedFuBkWXxtWfG5MDgYEqQxSDLQxuc
	U91tNFwOnGLdolS1eeFuqbceTPHSzL7hU88zHQYHcHD+z/dXe8D8dMMCxF/aP4a0vzuIe
X-Google-Smtp-Source: AGHT+IFoAiAET4/RXIIfogT0oBdVsHUQY8o6xwNhVDRzeLKHFonA8GbaIF5LImVO4PtEuu8oqTAuUA==
X-Received: by 2002:a05:6214:43c3:b0:801:7267:3cd8 with SMTP id 6a1803df08f44-80172673d7fmr139528036d6.39.1758942448929;
        Fri, 26 Sep 2025 20:07:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8016ce9a34bsm35543566d6.57.2025.09.26.20.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:07:28 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:07:27 -0400
Message-ID: <3161e6addb7d3e6c8297ff058ad8236d@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250926
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

Here are the audit patches for the upcoming Linux v6.18 merge window:

- Proper audit support for multiple LSMs

  As the audit subsystem predated the work to enable multiple LSMs,
  some additional work was needed to support logging the different LSM
  labels for the subjects/tasks and objects on the system.  Casey's
  patches add new auxillary records for subjects and objects that convey
  the additional labels.

- Ensure fanotify audit events are always generated  

  Generally speaking security relevant subsystems always generate audit
  events, unless explicitly ignored.  However, up to this point fanotify
  events had been ignored by default, but starting with this pull request
  fanotify follows convention and generates audit events by default.

- Replace an instance of strcpy() with strscpy()  

- Minor indentation, style, and comment fixes

Paul

--
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250926

for you to fetch changes up to d2c773159327f4d2f6438acf1ae2ae9ac0ca46a9:

  audit: fix skb leak when audit rate limit is exceeded
    (2025-09-10 19:55:00 -0400)

----------------------------------------------------------------
audit/stable-6.18 PR 20250926
----------------------------------------------------------------

Casey Schaufler (5):
      audit: fix indentation in audit_log_exit()
      audit: create audit_stamp structure
      lsm: security_lsmblob_to_secctx module selection
      audit: add record for multiple task security contexts
      audit: add record for multiple object contexts

Dan Carpenter (1):
      audit: add a missing tab

Eric Dumazet (1):
      audit: init ab->skb_list earlier in audit_buffer_alloc()

Gerald Yang (1):
      audit: fix skb leak when audit rate limit is exceeded

Kieran Moy (1):
      audit: fix typo in auditfilter.c comment

Richard Guy Briggs (1):
      audit: record fanotify event regardless of presence of rules

Thorsten Blum (1):
      audit: Replace deprecated strcpy() with strscpy()

 include/linux/audit.h        |   25 +++
 include/linux/security.h     |    6 
 include/uapi/linux/audit.h   |    2 
 kernel/audit.c               |  280 ++++++++++++++++++++++++++++++-----
 kernel/audit.h               |   13 +
 kernel/audit_tree.c          |    6 
 kernel/auditfilter.c         |    2 
 kernel/auditsc.c             |   63 ++-----
 net/netlabel/netlabel_user.c |    8 -
 security/apparmor/lsm.c      |    3 
 security/security.c          |   18 ++
 security/selinux/hooks.c     |    5 
 security/smack/smack_lsm.c   |    5 
 13 files changed, 334 insertions(+), 102 deletions(-)

--
paul-moore.com

